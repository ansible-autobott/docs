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

**Tags**:
* `homepage` => run only this role
* `homepage-settings` => only apply new homepage settings

#### Mandatory configuration:

```yaml
homepage:
  allowed_host: localhost:8443
```

## Configuration
To configure homepage you need to create the config files: bookmarks.yaml, services.yaml, settings.yaml and widgets.yaml
in any of the following paths, picked up in order of preference
1. `<inventory_root>/files/homepage/<host_name>`
2. `<inventory_root>/files/homepage` 

In Addition, you can add images and icons on the paths:
* `<inventory_root>/files/homepage/images` 
* `<inventory_root>/files/homepage/icons`

There you can put files that will be copied into the target machine.

{{% hint info %}}
For details on homepage configuration check the official documentation: [https://gethomepage.dev/configs/](https://gethomepage.dev/configs/)   
{{% /hint %}}

### About Secrets

You can reference encrypted secrets in these configuration files as well:

```yaml
    - Sonarr:
        ...
        widget:
          type: sonarr
          url: "http://127.0.0.1:8989"
          key: "{{ secrets.sonarr.api_key }}"
```





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