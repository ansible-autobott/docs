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


Setup borgmatic backup configurations
```yaml
borgmatic_backups:
  - name: test_php
    enabled: true
    # list of borg repositories
    destination:
      - path: /backup/test_php
        label: local
        encryption: none
        
      - path: ssh://qwerty.repo.borgbase.com/./repo
        label: remote
        encryption: repokey-blake2

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
    # run this profile on a schedule: daily, weekly or monthly
    # set to "none" to disable
    schedule: "weekly" 
```
#### Retention policies

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

### Encryption/Hashing

You can set encryption in your borgmatic profile, if you choose so just be aware that:
* your passphrase will be stored in clear text on the host (only root accessible)
* Autobott will copy back the Borg key to your host machine, make sure to keep it in a 
secure place otherwise you will lose access to your backup.

The type of encryption that you use will depend on the Borg version you have installed.

{{% hint warning %}}
The performance of the encryption will highly depend on your hardware, please check the borg manual for details
{{% /hint %}}

For **Borg 1** use one of the following options

| encryption           | Details                                                                          |
|----------------------|----------------------------------------------------------------------------------|
| keyfile              | Encrypted with key locally, protected by passphrase                              |
| repokey              | Encrypted with key in repository, protected by passphrase                        |
| keyfile-blake2       | Encrypted with key locally, protected by passphrase, uses blake2                 |
| repokey-blake2       | Encrypted with key in repository, protected by passphrase, uses blake2           |
| authenticated        | Content not encrypted but,protected from tampering                               |
| authenticated-blake2 | Same as authenticated but uses the blake2 hash                                   |
| none                 | No encryption at all ; **not recommended** due to risk of tampering and exposure |       


{{% hint info %}}
run `borg init --help` for details
{{% /hint %}}


For **Borg 2** use one of the following options

| encryption                       | Details                                                                                        |
|----------------------------------|------------------------------------------------------------------------------------------------|
| keyfile-blake2-chacha20-poly1305 | Uses CHACHA20 encryption, POLY1305 authentication, BLAKE2b ID hash; key stored locally         |
| repokey-blake2-chacha20-poly1305 | Same as above, but key stored in the repository                                                |
| keyfile-chacha20-poly1305        | Uses CHACHA20 encryption, POLY1305 authentication, HMAC-SHA-256 ID hash; key stored locally    |
| repokey-chacha20-poly1305        | Same as above, but key stored in the repository                                                |
| keyfile-blake2-aes-ocb           | Uses AES256-OCB for encryption and authentication, BLAKE2b ID hash; key stored locally         |
| repokey-blake2-aes-ocb           | Same as above, but key stored in the repository                                                |
| keyfile-aes-ocb                  | Uses AES256-OCB for encryption and authentication, HMAC-SHA-256 ID hash; key stored locally    |
| repokey-aes-ocb                  | Same as above, but key stored in the repository                                                |
| authenticated-blake2             | No encryption; data authenticated using BLAKE2b; useful for integrity-only protection          |
| authenticated                    | No encryption; data authenticated using HMAC-SHA-256; provides tamper protection only          |
| none                             | No encryption and no authentication; **not recommended** due to risk of tampering and exposure |


{{% hint info %}}
run `borg repo-create --help` (or `borg rcreate --help` on older build) for details,
{{% /hint %}}



