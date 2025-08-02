---
weight: 20
bookCollapseSection: true
title: "Linux apt"
---

# Linux Apt

This role takes care of configuring your apt sources.


## Enable the role
``` yaml
run_role_linux_apt: true

```

## Mandatory configuration:

``` yaml
linux_apt:
  # needs to be set to the debian release, at the moment 
  # it MUST be bookworm ( will be changed in the future)
  release: "bookworm" 
```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

### Configure sources
```yaml

  # Country code for mirror selection
  mirror_country: "ch" 

  # Repository components configuration, 
  # if set to false some other roles might fail to install, e.g. zfs
  use_contrib: true # Enable 'contrib' component
  use_nonfree: true # Enable 'non-free' component
  use_backports: true # Enable backports repository
```


### Configure additional apt sources
```yaml
linux_apt:
  # extra_sources_d allows to configure additional apt sources
  extra_sources_d:
    # Repository identifier
     - name: "docker"
       # Repository definition
       repo: "deb [arch=amd64] https://download.docker.com/linux/debian bookworm stable"
       # Repository signing key URL
       key_url: "https://download.docker.com/linux/debian/gpg"
       # Key fingerprint for verification
       key_id: "9DC858229FC7DD38854AE2D88D81803C0EBFCD88"
       # Repository state
       enabled: true
       # Optional pin priority
       pin_priority: 500                                       
```
