---
weight: 30
bookCollapseSection: true
title: "Immich"
---

# Immich

The personal replacement for google photos

## Enable the role
``` yaml
run_role_immich: true
```

### Tags:

`immich` => run only this role

#### Mandatory configuration:

```yaml
immich:
  # change, only the characters `A-Za-z0-9`, without special characters or spaces
  db_pass: "changeMe"
``` 

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


```yaml
immich:
  paths:
    # where uploaded photos will be placed
    uploads_dir: /opt/immich/uploads
  service:
    # set an identifier from this list: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
    timezone: Etc/UTC
    # Mount local folders into a targe withing the docker container
    # the tarted will be /media/<name> -> the target, e.g.
    #  piratecove: "/media/piratecove"
    mounts: []

```
---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:2283` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://immich.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:2283"

```