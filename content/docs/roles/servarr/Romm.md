---
weight: 40
bookCollapseSection: true
title: "RomM"
---

# RomM

Install romM

{{% hint warning %}}
**Unstable:**  
This role is not yet extensively tested and might fail and/or require manual intervention.
{{% /hint %}}


## Enable the role
``` yaml
run_role_romm: true
```

### Tags:

* _romm_ => run only this role

## Mandatory configuration:

```yaml
romm:
  db_pass: "changeMe"
  # needs to be at least 32 chars generate with openssl rand -hex 32
  app_secret: "f787f1489baba67c41ea0187f6590a2742b1b6cd69b8f5fb6fef13e17c96ae5f"
```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


```yaml
romm:
  # check: https://docs.romm.app/latest/Getting-Started/Quick-Start-Guide/
  integration:
    igdb_client_id: ""
    igdb_client_secret: ""

    # https://docs.romm.app/latest/Getting-Started/Generate-API-Keys/#mobygames
    mobygames_api_key: ""
    # https://docs.romm.app/latest/Getting-Started/Generate-API-Keys/#steamgriddb
    steamgridd_api_key: ""

    # Use your ScreenScraper username and password
    # https://docs.romm.app/latest/Getting-Started/Generate-API-Keys/#screenscraper
    screenscraper_user: ""
    screenscraper_pw: ""

    # https://api-docs.retroachievements.org/#api-access
    retroachievements_api_key: ""
```

---

## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:3040` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://romm.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:3040"

```