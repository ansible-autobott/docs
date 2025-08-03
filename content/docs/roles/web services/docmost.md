---
weight: 50
bookCollapseSection: true
title: "Docmost"
---

# Docmost

Collaborative wiki

## Enable the role
``` yaml
run_role_docmost: true
```

### Tags:

`docmost` => run only this role


#### Mandatory configuration:

```yaml
docmost:
  # change, only the characters `A-Za-z0-9`, without special characters or spaces
  db_pass: "changeMe"
  # needs to be at least 32 chars
  app_secret: "REPLACE_WITH_LONG_SECRET_REPLACE_WITH_LONG_SECRET"
```


---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:3030` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://docmost.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:3030"

```