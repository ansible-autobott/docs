---
weight: 70
bookCollapseSection: true
title: "Borgmatic"
---

# Borgmatic

Install and configure Borgmatic

## Enable the role
``` yaml
run_role_borgmatic: true

```

## Optional configuration: 
{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


Setup automatic backup configurations
```yaml
borgmatic:
  - name: test_php
    enabled: true
    # needs to be an existing borg repo
    # destination can be a single target or a list
    destination: 
      - /vhosts/php/backups
      - ssh://abd@def.repo.borgbase.com/./repo

    ## ssh private key used if the destination is ssh
    ssh_key: |
      -----BEGIN OPENSSH PRIVATE KEY-----
      b3BlbnNzaC1rZXktdjEAAAAABG5vbmUA ...    
      
    # select what directories to back up      
    dirs:
      - root: /vhosts/php/home_dir/public_html
    # select a list of databases to include in the backup
    mariadb:
      - php
      - test

    # select the retention policy
    # "minimal", "medium", "aggressive"
    retention: "minimal" 
```


These are the retention policies detailed:

{{% columns  %}}
**_Minimal_**

    keep_hourly: 1 
    keep_daily: 1 
    keep_weekly: 1 
    keep_monthly: 1 
    keep_yearly: 0

<---> 

**_Medium_**

    keep_hourly: 6
    keep_daily: 2
    keep_weekly: 2
    keep_monthly: 2
    keep_yearly: 1

<---> 

**_Aggressive_**

    keep_hourly: 24
    keep_daily: 7
    keep_weekly: 4
    keep_monthly: 6
    keep_yearly: 1

{{% /columns %}}






