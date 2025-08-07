---
weight: 51
bookCollapseSection: true
title: "Goback"
---

# Goback

Goback is a simple and minimalistic backup program intended to manage files at ease in zip files

## Enable the role
``` yaml
run_role_goback: true

```

## Optional configuration: 
{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


Once goback is installed you can define profiles that will be executed weekly/monthly 

```yaml
goback_profiles:

  # very minimal profile config, this will place the backups in the default location
    # set to false to keep the profile but disabled
  - enabled: True
    # run monthly backup
    corn_monthly: True
    # run weekly backup
    corn_weekly: True
    # set the mode of the target directory when creating
    dir_mode: "0700"
    # content of the goback profile configuration,
    # check the goback documentation for details: https://github.com/andresbott/goback
    content:
      version: 1
      # IMPORTANT the role needs the name to be present
      name: "demo_php_global"
      type: "local"
      dirs:
        # the path defines the source to backup / sync
        - path: "/vhosts/demo_php/home_dir/public_html"
      dbs:
        name: demo
        type: mysql
      destination:
        path:   "/vhosts/demo_php/backups"
        keep: 3
```

## Goback destination in a SFTP Jail 

check out the guides where it is described how to set up Goback in combination of sftp jails
to allow users and admins to download backups over sfpt.


