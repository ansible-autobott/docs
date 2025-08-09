---
weight: 50
bookCollapseSection: true
title: "Docmost"
---

# Docmost

Collaborative wiki

## Enable the role
``` yaml
run_role_docmost: true
```

**Tags**:
* `docmost` => run only this role


#### Mandatory configuration:

```yaml
docmost:
  # change, only the characters `A-Za-z0-9`, without special characters or spaces
  db_pass: "changeMe"
  # needs to be at least 32 chars
  app_secret: "REPLACE_WITH_LONG_SECRET_REPLACE_WITH_LONG_SECRET"
```
---

#### Optional configuration:

```yaml
docmost:
  # configure the email delivery
  # https://docmost.com/docs/self-hosting/configuration/
  # https://docmost.com/docs/self-hosting/environment-variables/#using-smtp
  email:
    # smtp or postmark, set to "" to disable
    driver: "" 
    # smtp host and port 
    host: "" 
    port: ""
    # initiate directly tls connection, normally used for port 465
    smtp_secure: "true"
    username: ""
    password: ""
    # define the from address
    from: ""
    # define the from name
    from_name: "Docmost"
    # postmark token if using postmark
    postmark_token: ""
```


---

## Proxy Configuration

Once enabled you can point a reverse proxy to: `127.0.0.1:3030` (if you did not change the port)

Sample vhost configuration.
```yaml
- name: myserver
  enabled: true
  servers:
    - enabled: true
      domains:
        - "https://docmost.my-domain.com"
      type: "proxy"
      proxy_url: "http://127.0.0.1:3030"

```

--- 

## Backup / Restore

### Backup

docmost can be backed up using goback with a config like this:

```yaml
  - enabled: True
    corn_weekly: True
    dir_mode: "0700"
    content:
      version: 1
      name: docmost
      type: "local"
      dirs:
        # data path for images etc
        - path: /opt/docmost/data
      dbs:
        # docker postgress config
        - name: docmost
          user: docmost
          password: "{{ secrets.services.docmost.db_pass }}"
          type: dockerPostgres
          containerName: docmost_postgres
      # sftp jail
      destination:
        path:   "/var/goback_backups/output/docmost"
        keep: 5
        owner: backup
        mode:  "0600"




```

---

### Restore

1. delete any data of docmost and start a new clean instance
```bash
docker compose down -v # this deletes the data in the volumes
docker compise up -d # start a new docmost in the backround
```


2. Copy the data folder from the backup to the location where docker compose will serve the data.
Important: make sure that the permissions are set correctly 
    
3. restore the DB with:
``` bash
export PG_PASSWORD="YOUR_POSTGRESQL_PASSWORD"
export DB_CONTAINER_NAME=docmost_postgres

docker exec -it $DB_CONTAINER_NAME psql -U docmost -d docmost -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
cat <docmost.dump.sql> | docker exec -i $DB_CONTAINER_NAME psql -U docmost -d docmost
```

> postgres commands based on: https://github.com/docmost/docmost/discussions/192#discussioncomment-13002803

