---
weight: 30
bookCollapseSection: true
title: "Radicale"
---

# Radicale

CalDav and CardDav server that stored data as plain files.



## Enable the role
``` yaml
run_role_radicale: true
```

### Tags:

`radicale` => run only this role

    
---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:5232` (if you did not change the port)

Radicale expects the header X-Remote-User to be populated, e.g. use this vhost config:

{{% hint warning %}}
**NOTE:**  
Note: radicale does NOT have authentication enabled by default,
you will need to protect the files with a proxy, see [vhosts](Vhosts.md) for details
{{% /hint %}}


Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://dav.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:5232"
      authentication: true
      htpasswd_file_users:
        - user: user1
          pass: "1234"
          enabled: true      

```