---
weight: 50
bookCollapseSection: true
title: "Arrs"
---

# Arrs

Most of the servarr applications share configuration, for this reason we are grouping them into one page.

This page covers the following applications

* Lidarr => for music
* Radarr => for movies
* Sonarr => for Shows and tv series
* Whisparr => for adult content



## Enable the role
``` yaml
run_role_lidarr: true
run_role_radarr: true
run_role_sonarr: true
run_role_whisparr: true
```

### Tags:

* `lidarr` => run only this role
* `radarr` => run only this role
* `sonarr` => run only this role
* `whisparr` => run only this role

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


The following configuration applies to any of the services
```yaml
lidarr | radarr | sonarr |  whisparr:
  # start the service with different umask value
  # set to something like 0022 (755) or 0007 (770), will be ommited if empty
  umask: ""
  # use External to delegate auth to the proxy
  auth_method: "External" # Basic | Forms | External | None

```
---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:<port>`

* Lidarr => 8686
* Radarr => 7878
* Sonarr => 8989
* Whisparr => 6969




Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://service.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:<port>"

```

--- 
## stash and xbvr

For more details check the defaults.yaml file in the role directory.

### Enable the role
``` yaml
run_role_stash: true
run_role_xbvr: true

```
Once enabled you can point a reverse proxy to: `127.0.0.1:<port>`

* stash => 9999
* xbvr => 9997

