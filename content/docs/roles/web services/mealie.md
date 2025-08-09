---
weight: 40
bookCollapseSection: true
title: "Mealie"
---

# Mealie

Keep track of food recipes and food     planning

## Enable the role
```yaml
run_role_mealie: true
```

**Tags**:

* `mealie` => run only this role

## Mandatory configuration:

```yaml
run_role_mealie: true
mealie:
  # change, only the characters `A-Za-z0-9`, without special characters or spaces
  db_pass: "changeMe"
  # needs to be at least 32 chars
  app_secret: "REPLACE_WITH_LONG_SECRET_REPLACE_WITH_LONG_SECRET"
```

---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:9925` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://mealie.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:9925"

```

## Backup / Restore

### Backup


Mealie does not have (nor want) automatic backups, so we need to log-in, navigate to settings > backups and
manually trigger a new backup; the backup file are placed into: `/opt/mealie/data/backups`

then we can use a goback rule like this to copy the backup into a sftp jail

```yaml
  - enabled: True
    corn_weekly: True
    dir_mode: "0700"
    content:
      version: 1
      name: mealie
      type: "local"
      dirs:
        # data path for images etc
        - path: /opt/mealie/data/backups
      # sftp jail
      destination:
        path:   "/var/goback_backups/output/mealie"
        keep: 1 # since the backups already contain multiple files, we keep it small
        owner: backup
        mode:  "0600"


```
