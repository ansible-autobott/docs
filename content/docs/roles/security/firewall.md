---
weight: 20
bookCollapseSection: true
title: "Firewall"
---

# Firewall

Install and configure ufw firewall.

The default config will block inbound and outbound traffic, the rules are setup on an allowlist basis, so that we only
allow what explicitly is needed.


## Enable the role
``` yaml
run_role_firewall: true

```

{{% hint info %}}
**NOTE:**  
A minimum set of required ports are allways allowed (can be overwritten at own risk):
* Inbound SSH on 22
* Outbound 53 (DNS), HTTP(S) on 80 and 443
{{% /hint %}}

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

### Configure sources
```yaml

firewall:

  # make docker services not publicly available,
  # check https://github.com/chaifeng/ufw-docker# for details
  block_docker_public: True
    
  # allowed inbound tcp ports
  allow_inbound_tcp:
    - 80    # HTTP
    - 443   # HTTPS
  # allowed inbound udp ports
  allow_inbound_udp:
    - 55555 # wireguards
  # allowed outbound tcp ports
  allowed_outbound_tcp: []
  # allowed outbound udp ports
  allowed_outbound_udp:
    - 6100:6200 # e.g. transmission
```

## Troubleshooting 

If you are unsure if something does not work due to firewall blocking traffic you can disable if with:

```bash
sudo ufw disable
```

Remember to enable it again or run the role again.

