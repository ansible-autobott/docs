---
weight: 30
bookCollapseSection: true
title: "Authelia"
---

# Authelia

Simple Authelia role that installs and configures the Authelia authentication server with 
support for 2FA, user management, and access control policies.

## Enable the role
``` yaml
run_role_authelia: true
```

### Tags:

`authelia` => run only this role

## Mandatory configuration: 

{{% hint warning %}}
**NOTE:**  
The authelia configuration is quite extensible, please take your time to understand how authelia works
{{% /hint %}}

```yaml
authelia:  
  secrets:
    # needs to be more than 20 chars, cannot change between installations
    storage_encryption_key: ""

    # define a session secret so that cookies are valid cross ansible runs-
    # as default autobott will generate a new random string on every run, invalidating any active session
    # you can generate it with:  openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | head -c 75
    session: ""
    
    
  # protected site configurations
  sites:
    - name: demo
      # domain can be a single one or a list of domains / regex of domains, e.g. *.my-domain.com
      domain: 
        - "demo.localhost.lan"
        - "jellyfin.localhost.lan"
        - "wiki.localhost.lan"
      policy: "two_factor" # one_factor | two_factor
      groups:
        - team1

  # defines the cookies that Authelia handles,
  # make sure that the domain overlaps the sites you configure.
  cookies:
    - name: "authelia_session"
      domain: "localhost.lan"
      authelia_url: "https://auth.localhost.lan"        

  # user definitions
  users:
    - username: alice
      displayname: "Alice Example"
      password: "changeme"
      salt: "BuMcDk78nYRxSvUXLIKeHZ" # exactly 22 chars
      email: "alice@example.com"
      groups:
        - team1
        - tema2
      disabled: false
      
  # smtp config used for notifications, e.g. when enabling 2fa or password reset
  # if address is empty, the default fallback
  smtp:
    # address normally is smtp, submission, or submissions, check the dock for details
    # https://www.authelia.com/configuration/notifications/smtp/
    address: "" #
    timeout: '5s'
    username: ''
    password: ''
    # make sure that your smtp server allows for this sender
    sender: "Authelia <admin@example.com>"
    identifier: 'localhost'



```
## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
authelia:
  # Enable Authelia metrics
  service:
    metrics: false
  # issuer for TOTP tokens
  totp_issuer: "Authelia"

```

---
## Protecting a vhost

Configuring a site above only defines the access policy. To actually enforce it, the vhost
serving that domain has to forward its requests to Authelia. The types `static`, `spa`,
`php` and `proxy` support this with `authelia: true`:

```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://demo.localhost.lan"
      type: "proxy"
      proxy_url: "http://127.0.0.1:8080"
      authelia: true
      authelia_port: 9031 # optional, only if authelia does not run on the default port
```

The upstream service receives the authenticated identity in the `Remote-User`,
`Remote-Groups`, `Remote-Email` and `Remote-Name` headers.

### Excluding paths

Some services expose an API that authenticates itself with tokens or api keys. Sending
those requests through Authelia breaks them, because the client receives an HTML login
page it cannot handle. Use `authelia_except_paths` to let them through, everything not
listed stays protected:

```yaml
    - enabled: true
      domains:
        - "https://aether.localhost.lan"
      type: "proxy"
      proxy_url: "http://127.0.0.1:8075"
      authelia: true
      authelia_except_paths:
        - "/rest"
        - "/rest/*"
```

{{% hint warning %}}
**NOTE:**
Caddy matches paths exactly, so to exclude a whole subtree you need both the path itself
and the wildcard (`/rest` **and** `/rest/*`). Note that `/rest` does not match
`/restricted`, so unrelated paths stay protected.
{{% /hint %}}
