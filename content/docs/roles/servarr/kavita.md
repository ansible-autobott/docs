---
weight: 40
bookCollapseSection: true
title: "Kavita"
---

# Kavita

Install the book reader Kavita

## Enable the role
``` yaml
run_role_kavita: True
```

### Tags:

`kavita` => run only this role

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


```yaml
kavita:
  # start the service with different umask value
  # set to something like 0022 (755) or 0007 (770), will be ommited if empty
  umask: ""
  # use External to delegate auth to the proxy
  auth_method: "External" # Basic | Forms | External | None

```
---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:5000` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://kavita.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:5000"

```