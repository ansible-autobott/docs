---
weight: 10
bookCollapseSection: true
title: "Homepage"
---

# Homepage

Configurable homepage service, the mst used for self-hosted landing pages

## Enable the role
``` yaml
run_role_homepage: true
```

### Tags:

* `homepage` => run only this role
* `homepage-settings` => only apply new homepage settings

#### Mandatory configuration:

```yaml
homepage:
  allowed_host: localhost:8443
```
To configure homepage you need to create the config files: bookmarks.yaml, services.yaml, settings.yaml and widgets.yaml
in any of the following paths: `<inventory_root>/files/homepage` or  `<inventory_root>/files/homepage/<host_name>`

They will be picked up in order of preference, giving priority to the host.

For details on configuration check the official documentation: [https://gethomepage.dev/configs/](https://gethomepage.dev/configs/)

You can add additional images and icons on the paths:
`<inventory_root>/files/homepage/images` and  `<inventory_root>/files/homepage/icons` respectively

   

---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:3003` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:3003"

```