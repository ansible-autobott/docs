---
weight: 30
bookCollapseSection: true
title: "Zfs"
---

# ZFS


This role will install openzfs from the debian contrib repository.


## Enable the role
``` yaml
run_role_zfs: true

```

{{% hint info %}}
**NOTE:**  
The contrib repository  needs to be enabled, otherwise the role will fail
{{% /hint %}}

## Setup ZFS pools

This role does not setup any pool, this is still left for the admin to do manually.