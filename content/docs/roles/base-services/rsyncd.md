---
weight: 45
bookCollapseSection: true
title: "Rsyncd"
---

# Rsyncd

Install and configure an rsync daemon (`rsyncd`), exposing one or more
modules (shares) over the native rsync protocol on TCP port 873.

The daemon runs as an always-on service: the role masks the `rsync.socket`
socket-activation unit and enables the `rsync` service instead. Its
configuration lives in `/etc/rsyncd.conf`, with virtual users stored in
`/etc/rsyncd.secrets`.

## Enable the role
``` yaml
run_role_rsyncd: true

```

{{% hint info %}}
**NOTE:**
Disabling the role again (`run_role_rsyncd: false`) tears the daemon down:
it stops and disables the service and removes the config and secrets files.
The `rsync` package and the module directories (with their data) are left
in place.
{{% /hint %}}

## Optional configuration:

{{% hint info %}}
**NOTE:**
This list highlights only the key configuration items we believe require your
attention; for the complete set of options, refer to the `defaults/main.yaml`
file in the role directory.

Your `rsyncd` block is merged recursively on top of `rsyncd_defaults`, so you
only need to set the values you want to change.
{{% /hint %}}

### Global settings

```yaml
rsyncd:
  global:
    address: ""            # "" = bind all interfaces
    port: "873"
    max_connections: "0"   # 0 = unlimited
    motd_file: ""          # "" = no banner
    timeout: "600"         # I/O timeout in seconds (0 = none)
```

### Users

Virtual rsync users are written to the secrets file. **They are not system
users** — they exist only in `/etc/rsyncd.secrets` and are used for module
authentication.

```yaml
rsyncd:
  users:
    - name: "backup"
      password: "{{ secrets.users.backup.passwd }}"
```

### Modules (shares)

`name` and `path` are mandatory; everything else falls back to
`module_defaults`. Omit `auth_users` (or leave it empty) to make the module
anonymous, similar to a samba guest share.

```yaml
rsyncd:
  modules:
    - name: "backups"
      comment: "Nightly backups"
      path: "/srv/rsync/backups"
      read_only: false
      auth_users: ["backup"]        # omit/empty => anonymous module
      hosts_allow: ["10.0.0.0/24"]
```

The module directory is created automatically with the ownership and mode
taken from `dir_owner` / `dir_group` / `dir_mode` (per-module or from
`module_defaults`).

{{% hint info %}}
**Sharing a directory with other services:**
To let the daemon write into a directory that is also shared by samba and the
servarr apps, use the `incoming_chmod` option together with matching directory
ownership/mode. See
[File permissions across services](/docs/docs/guides/servarr/#file-permissions-across-services)
in the Servarr guide.
{{% /hint %}}
