---
weight: 30
bookCollapseSection: true
title: "Tailscale"
---

# Tailscale

Install the tailscale client.


Note: due to the nature of tailscale it's state cannot be provisioned with Ansible.



## Enable the role
``` yaml
run_role_linux_apt: true

```

## Configuration

{{% hint info %}}
**NOTE:**  
Due to the nature of tailscale's configuration it's state cannot be provisioned with Ansible and 
needs to be done manually
{{% /hint %}}



