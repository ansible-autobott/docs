---
weight: 10
bookCollapseSection: true
title: "Transmission"
---

# Transmission
Install and configure Transmission

## Enable the role
``` yaml
run_role_transmission: true

```

## Mandatory configuration: 
```yaml
transmission:
  remote_user:     "torrent"
  remote_password: "torrent"
  # Download paths
  download:
    path: "/var/download"


```

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
transmission:
  # start the service with different umask value
  # needs to be set in decimal notation: 18=022 (644), 2=002 (664), 7=007 (660)
  umask: ""

```

---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:9091` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://transmission.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:9091"
```
### Delegating auth to Authelia

Out of the box, the remote admin of transmission relies on basicauth to authenticate, but if you
only are going to use the web interface, you can delegate the authentication to Authelia and
inject the basicauth authorization header using caddy.

In your vhost configuration add the following lines:
```yaml

# enable authelia
authelia: true
# inject the Authorization header with the user +`password
proxy_lines:
  - header_up Authorization "Basic {{ ( 'torrent:' ~ secrets.services.transmission.password ) | b64encode }}"
```
please adjust accordingly to your username + secret location 

