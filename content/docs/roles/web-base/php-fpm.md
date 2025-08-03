---
weight: 20
bookCollapseSection: true
title: "PHP-Fpm"
---

# PHP-Fpm

Simple PHP-FPM role that installs and configures the PHP FastCGI Process Manager.  
Includes defaults for system user/group, runtime settings, and OPcache configuration.

## Enable the role
``` yaml
run_role_php_fpm: true
```

### Tags:

`php-fpm` => run only this role

{{% hint info %}}
**NOTE:**  
Many of the php internals can be tweaked, but the default should work well.
{{% /hint %}}

For details on how to configure php workers, check the vhosts role


