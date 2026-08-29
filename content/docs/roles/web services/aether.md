---
weight: 60
bookCollapseSection: true
title: "Aether"
---

# Aether

[Aether](https://github.com/andresbott/aether) is a music server: it exposes an OpenSubsonic
API (so any Subsonic client works) plus its own web player, with library scanning,
artwork lookup and a metadata editor.

The role installs the upstream `.deb`, which ships the systemd unit, creates the `aether`
system user and the `/var/lib/aether` data directory. The config at `/etc/aether/config.yaml`
is then overwritten with a template managed by autobott.

## Enable the role
``` yaml
run_role_aether: true
```

**Tags**:
* `aether` => run only this role

## Optional configuration:

{{% hint info %}}
**NOTE:**
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
aether:
  # the upstream release to install, must be listed in aether_checksums
  version: 0.4.0

  # add the aether service user to extra groups, e.g. to read a shared media library.
  # the group must already exist (provision it with the linux_basic role)
  extra_groups:
    - smbmedia
  # start the service with a different umask so files aether creates in a shared
  # media tree stay group writable (0007 -> files 660, dirs 770)
  umask: "0007"

  # the packaged unit runs with ProtectSystem=strict, so the whole filesystem is
  # read-only to the service except /var/lib/aether. to let aether write tags and
  # embedded artwork back into your library, list the library root(s) here
  readwrite_paths:
    - /media/music

  config:
    server:
      port: 8075
      # defaults to 127.0.0.1, so aether is only reachable through a reverse proxy.
      # set to an empty string to listen on all interfaces
      bind_ip: "127.0.0.1"

    # artist image fetching, providers are fanart.tv and TheAudioDB.
    # with both empty the feature stays disabled. the role writes each key to its own
    # file under /etc/aether so the secret never lands in config.yaml
    artist_images:
      fanart_api_key: ""
      theaudiodb_api_key: ""
```

---
## Authentication

{{% hint warning %}}
**NOTE:**
Aether defaults to `none`, which means **no authentication at all**. Anyone who can reach
the port has full access, so either put it behind an authenticating proxy or switch to
`native`.
{{% /hint %}}

Three methods are available:

| Method | Behaviour |
|---|---|
| `none` | No authentication. Trusted networks only. |
| `native` | Users live in the aether database, aether renders its own login form. |
| `proxy-header` | Identity comes from headers injected by an authenticating proxy (Authelia). |

### Native users

`admin_bootstrap` seeds the first admin, and only while the user store is empty. Changing
it later has no effect on an already seeded install. Both values are mandatory, aether
refuses to start without them.

```yaml
aether:
  config:
    auth:
      method: native
      admin_bootstrap:
        user: admin
        # plaintext or a bcrypt hash, generate one with `aether user hash`.
        # the role writes this to a root-only file and references it from the config,
        # so the password is not stored in config.yaml
        password: "changeme"
```

### Behind Authelia

With `proxy-header` aether never shows a login form: it trusts the `Remote-User` and
`Remote-Groups` headers, and creates users automatically on first sight. Roles are read
from the groups header on every request, so group membership in Authelia is authoritative.

```yaml
aether:
  config:
    server:
      # mandatory: aether must only be reachable through the proxy
      bind_ip: "127.0.0.1"
    auth:
      method: proxy-header
      proxy_header:
        # members of this authelia group become aether admins
        admin_group: "aether-admin"
        # only these peers may assert identity headers. list both loopback forms,
        # a proxy dialing "localhost" can arrive as ::1
        trusted_proxies:
          - "127.0.0.1"
          - "::1"
```

{{% hint danger %}}
**Deployment invariants for `proxy-header`:**
* Aether must be unreachable except through the proxy (`bind_ip: "127.0.0.1"`).
  Anyone who can reach it directly can forge the identity headers and become admin.
* The proxy must strip inbound identity headers on every request.
* `/rest` must bypass Authelia, see below.
{{% /hint %}}

---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:8075` (if you did not change the port)

The OpenSubsonic API under `/rest` authenticates itself with per-user api keys. If Authelia
covers it, Subsonic clients get an HTML login page they cannot handle, so exclude it with
`authelia_except_paths`. Everything else, including the web player, stays protected.

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://aether.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:8075"
      authelia: true
      authelia_except_paths:
        - "/rest"
        - "/rest/*"
```

The matching Authelia site, granting admin to members of `aether-admin`:

```yaml
authelia:
  sites:
    - name: aether
      domain: "aether.my-domain.com"
      policy: "one_factor" # one_factor | two_factor
      groups:
        - aether-admin
```

---
## Uninstall

Setting `run_role_aether: false` removes the package but keeps the database. To also drop
`/var/lib/aether` and purge `/etc/aether`:

```yaml
aether:
  delete_data_on_uninstall: true
```

## Dependencies

The role installs `libchromaprint-tools`, which provides `fpcalc` (Chromaprint/AcoustID
audio fingerprinting) used to identify tracks and albums.
