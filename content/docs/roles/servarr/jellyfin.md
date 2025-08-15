---
weight: 30
bookCollapseSection: true
title: "Jellyfin"
---

# Jellyfin

Install Jellyfin.

## Enable the role
``` yaml
run_role_jellyfin: True
```

### Tags:

`jellyfin` => run only this role

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


```yaml
jellyfin:
  # run jellyfin with additional group permissions 
  extra_groups: []
  # start the service with different umask value
  # set to something like 0022 (755) or 0007 (770), will be ommited if empty
  umask: ""

```
---
## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:8096` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://jellyfin.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:8096"

```


## Backup / Restore

The full backup/restore details are documented here:
https://jellyfin.org/docs/general/administration/backup-and-restore/ 

### Backup

The Debian based installation stored data `/var/lib/jellyfin` and config is in `/etc/jellyfin`


{{% hint danger %}}
Jellyfin requests to stop the service to make safe backups, the current approach does not solve this.
Use at own risk, as an alternative use borgmatic with a shutdown hook.
{{% /hint %}}

```yaml
  - enabled: True
    corn_weekly: True
    dir_mode: "0700"
    content:
      version: 1
      name: jellyfin
      type: "local"
      dirs:
        # change data dir accordingly, e.g. /opt/sonarr/data/Backups
        - path: /var/lib/jellyfin
        - path: /etc/jellyfin
      # sftp jail
      destination:
        path:   "/var/goback_backups/output/jellyfin"
        keep: 5
        owner: backup
        mode:  "0600"

```

---

### Restore

1. make sure you have the same jellyfin version.
2. Stop the Jellyfin service.
3. copy the backup data in place.
4. Start the server again.




