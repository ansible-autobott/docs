---
weight: 20
bookCollapseSection: true
title: "Linux apt"
---

# Linux Apt

This role takes care of configuring your apt sources, apt preferences and
(optionally) unattended security upgrades.


## Enable the role
``` yaml
run_role_linux_apt: true

```

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

### Distribution release
```yaml
linux_apt:
  # Target Debian release. Leave empty (the default) to keep the currently
  # running release and only manage its sources. Set it to the name of a newer
  # release (e.g. "trixie") to perform a distribution upgrade.
  # The upgrade only runs when this differs from the running release AND the
  # play is executed with the `linux-upgrade` tag.
  release: ""
```

### Configure sources
```yaml
linux_apt:
  # Country code for mirror selection
  mirror_country: "ch"

  # Repository components configuration,
  # if set to false some other roles might fail to install, e.g. zfs
  use_contrib: true   # Enable 'contrib' component
  use_nonfree: true   # Enable 'non-free' component
  use_backports: true # Enable backports repository
```

### Pin packages from backports

Optionally install and pin selected packages from the `<release>-backports`
suite. Once a package is pinned it will automatically track newer backport
versions. This requires `use_backports: true`.

```yaml
linux_apt:
  pin_backported_pkg:
    # Install and pin the amd64 kernel (linux-image-amd64 + linux-headers-amd64)
    # from backports. When an AMD GPU is auto-detected, firmware-amd-graphics is
    # pinned and installed as well.
    kernel: false

    # Install and pin general firmware (firmware-linux + firmware-linux-nonfree)
    # from backports.
    firmware: false
```

### Configure additional apt sources

Additional repositories are written to `/etc/apt/sources.list.d/<name>.sources`
using the modern **deb822** (`.sources`) format.

```yaml
linux_apt:
  # sources_d allows to configure additional apt sources
  sources_d:
      # Repository identifier -> /etc/apt/sources.list.d/<name>.sources
    - name: "docker"
      # Base repository URL(s)
      uris: "https://download.docker.com/linux/debian"
      # Optional; defaults to the running release
      suites: "{{ ansible_distribution_release }}"
      # Optional; defaults to "main"
      components: "stable"
      # Optional
      architectures: "amd64"
      # Signing key: a URL, a keyring path, or an armored key block
      signed_by: "https://download.docker.com/linux/debian/gpg"
      # Optional; defaults to "deb"
      types: "deb"
      # Repository state
      enabled: true
```
