---
weight: 50
bookCollapseSection: true
title: "MariaBD"
---

# MariaDB

Install MariaDB (compatible with mysql)

## Enable the role
``` yaml
run_role_mariadb: true

```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

### Configure sources
```yaml

# change the default port
port: 3306

# overwrite the sql_mode values eg,
# "ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
# see: https://mariadb.com/kb/en/sql-mode/
sql_mode: ""
```


