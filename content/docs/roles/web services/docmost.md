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

#### Optional configuration:

```yaml
docmost:
  # configure the email delivery
  # https://docmost.com/docs/self-hosting/configuration/
  # https://docmost.com/docs/self-hosting/environment-variables/#using-smtp
  email:
    # smtp or postmark, set to "" to disable
    driver: "" 
    # smtp host and port 
    host: "" 
    port: ""
    # initiate directly tls connection, normally used for port 465
    smtp_secure: "true"
    username: ""
    password: ""
    # define the from address
    from: ""
    # define the from name
    from_name: "Docmost"
    # postmark token if using postmark
    postmark_token: ""
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