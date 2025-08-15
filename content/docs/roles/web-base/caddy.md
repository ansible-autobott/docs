---
weight: 10
bookCollapseSection: true
title: "Caddy"
---

# Caddy

Simple Caddy role that installs and configures the Caddy web server and reverse proxy.

## Enable the role
``` yaml
run_role_caddy: true
```

### Tags:

`caddy` => run only this role

## Mandatory configuration


```yaml
caddy:
  # email used for ACME account registration
  email: "email@example.com"
```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
caddy:
  # enable Prometheus metrics
  metrics: true
  
  # the git tag used to build caddy, can be a tag or a commit
  caddy_version: "v2.10.0" 
  go_version: 1.25.0

  # specify a list of plugins to build with xcaddy
  # see https://caddyserver.com/docs/build#xcaddy
  caddy_plugins: 
    - github.com/caddy-dns/cloudflare


```
