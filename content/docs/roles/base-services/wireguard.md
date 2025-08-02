---
weight: 20
bookCollapseSection: true
title: "Wireguard"
---
# Wireguard


Simple wireguard role that will install the module and configure wg0


## Enable the role
``` yaml
run_role_wireguard: true

```

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
wireguard:
  # set false to disable the wg0 interface, but still leave it configured
  enabled: true
  
  # private key can be generated with "wg genkey", 
  # create the public key with: echo <priv_key> | wg pubkey
  # if left empty a key will be created at /etc/wireguard/private.key
  # configure the private key of the interface wg0 
  private_key: ""
  port: "51820"

  # the IP address of the interface 
  address: "192.168.20.1/24" #
  address_ipv6: ""

  # setup firewall rules to use as exit node
  exit_node: false

  # peers to configure
  peers: []
   - name: peer1
     public_key: "" 
     endpoint: ""
     # for VPN client set what ips go the vpn.
     # for VPN servers, limit the ips a client can assign itself
     # defaults to 0.0.0.0/0,::/0 ( all traffic)
     AllowedIPs: "192.168.20.2/32"
```