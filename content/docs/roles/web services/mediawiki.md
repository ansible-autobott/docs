---
weight: 40
bookCollapseSection: true
title: "Mediawiki"
---

# Mediawiki


The Original WIKI

## Enable the role
``` yaml
run_role_mediawiki: true
```

**Tags**:
* `mediawiki` => run only this role

#### Mandatory configuration:

```yaml
run_role_mediawiki: true
mediawiki:
  wiki:
    name: "demo wiki"
    admin_user: "demo"
    admin_pass: "wiki12345678"
    base_url: "https://wiki.localhost:8443"
    secret_key: "changeme"
    site_upgrade_key: "changeme"
```


## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


```yaml
mediawiki:
  wiki:
    emergency_contact_mail: "me@localhost"
    password_sender_mail: "me@localhost"
    secret_key: "changeme"
    site_upgrade_key: "changeme"

    namespace: "main"
    print_exceptions: false

    locale: "en_US.utf8"
    lang: "en"
    # allowed upload extensions
    allowed_extensions:
      - pdf
      - tiff
      - txt
    # whitelist extensions that are normally not allowed
    whitelisted_extensions:
      - txt
```
    
---
## Vhost

To use this you will need to setup a php vhost like this:


```yaml
# in the vhosts: config
servers:
  - name: mediawiki
    enabled: true
    comment: "wiki powered by mediawiki"
    servers:
      - enabled: true
        domains:
          - "https://wiki.localhost:8443"
        type: "php"
        document_root: "/opt/mediawiki/public"
    php:
      enabled: yes
      open_basedir:
        - "/opt/mediawiki/data"
        - "/opt/mediawiki/install"
    mariadb:
      enabled: true
      password: "mediawiki"
```

{{% hint warning %}}
**NOTE:**  
IMPORTANT: ensure that the server name and the database matchers the mediawiki config.
see [vhost](Vhosts.md) for more information.
{{% /hint %}}


