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
  - name: demo_php_global
    # set to false to keep the profile but disabled
    enabled: True
    # include these dirs
    dirs:
      - root: /vhosts/demo_php/home_dir/public_html
    # include make a mysqldump of these DBs
    mysql:
      - dbname:  demo
    # keep the latest 2 backups
    keep: 2
    # run monthly backup
    corn_monthly: True

  # extended profile:  this will place the backups on a custom location
  - name: demo_php
    enabled: True
    # set a specific backup location
    destination: /vhosts/demo_php/backups
    # set the mode of the destination folder
    dir_mode: "0700"
    # change file owner after backup
    file_owner: andresbott_com
    file_mode: "0600"
    # delete backup directory when disabling the role
    delete_destination: no
    dirs:
      - root: /vhosts/demo_php/home_dir/public_html
    mysql:
      - dbname: demo
        user: db_user
        password: db_password        
    keep: 1
    corn_monthly: True
    corn_weekly: false
```

## Goback destination in a SFTP Jail 

check out the guides where it is described how to set up Goback in conmbination of sftp jails
to allow users and admins to download backups over sfpt.


