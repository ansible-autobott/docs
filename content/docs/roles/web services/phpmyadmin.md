---
weight: 100
bookCollapseSection: true
title: "PhpMyaAdmin"
---

# PhpMyaAdmin
PHP interface to manage Mysql/MariaDB Databases.


## Enable the role
```yaml
run_role_mealie: true
```

### Tags:

`phpmyadmin` => run only this role

## Mandatory configuration:

```yaml
run_role_phpmyadmin: true
phpmyadmin:
  # long randoms string
  blowfish_secret: "so1deege7Shoogaewoo4haR2phohghae7sas3luifaex7quahv"
```


to use phpmyadmin you will need to setup a php vhost like this:

```yaml
# in the vhosts: config
servers:
  - name: phpmyadmin
    enabled: true
    comment: "mysql database management in php"
    servers:
      - enabled: true
        domains:
          - "http://pma.localhost:8080"
          - "https://pma.localhost:8443"
        type: "php"
        document_root: "/opt/phpmyadmin/latest"
    php:
      enabled: yes
      open_basedir:
        - "/opt/phpmyadmin/latest"
```
