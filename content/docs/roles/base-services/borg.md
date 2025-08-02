---
weight: 60
bookCollapseSection: true
title: "Borg"
---

# Borg

Install Borg backup

## Enable the role
``` yaml
run_role_borg: true

```

## Optional configuration: 
{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


You can specify what borg version to install
```yaml
borg:
  version: "1.4.1" 

# select one of the following versions, or overwrite the checksum as well 
borg_checksums:
  "1.4.1": "b3ee1ce7454aacc0312c814e470df38132b1f6a71ae4164bea2b7d5033cb2480"
  "2.0.0b14": "4c7222e5324f907f53331dee6783c5c4cd99cee1dfdff4893c839f798d2f3e2b"
  "2.0.0b13": "35b50867cef2049b44970824da731e29894a493049c1441451bbf318741d5bbb"
  "2.0.0b12": "35b50867cef2049b44970824da731e29894a493049c1441451bbf318741d5bbb"
  "2.0.0b11": "9f72afb2f5fadfd4c15c4200e6078fe6361aa9e05f9a28cf6500d3b06c5caacc"
```



### Setup a borg remote server
```yaml

borg:

  # The server settings configures the machine so that other borg instances
  # can backup to this server using ssh. This will only setup the SSH configuration
  # you still need to use borg on the client to initialize the repo.
  server:
    enabled: true

    # where the backups will be stored
    data_directory: /var/borg_backups

    # Create symlink to ease the access and not expose internal storage structure
    # Set to empty string to disable symlink creation
    # this allows to setup your repos as borg@machine/backup/repo
    data_symlink: /backup

    # list of repositories, 
    repos:
      - name: test
        public_key: "ssh-rsa AAAAB..."
        append_only: true        
```


