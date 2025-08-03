---
weight: 40
bookCollapseSection: true
title: "Mealie"
---

# Mealie

Keep track of food recipes and food     planning

## Enable the role
```yaml
run_role_mealie: true
```

### Tags:

`mealie` => run only this role

## Mandatory configuration:

```yaml
run_role_mealie: true
mealie:
  # change, only the characters `A-Za-z0-9`, without special characters or spaces
  db_pass: "changeMe"
  # needs to be at least 32 chars
  app_secret: "REPLACE_WITH_LONG_SECRET_REPLACE_WITH_LONG_SECRET"
```

---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:9925` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://mealie.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:9925"

```