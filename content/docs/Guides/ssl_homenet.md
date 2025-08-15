---
weight: 60
bookToc: true
title: "TLS in home network"
---

# TLS in home network

The best way to get TLS with trusted certificates inside the home network without exposing your server
to the internet is using DNS based challenge.

Int his gide we will explain briefly how to setup this and how to use autobot to configure DNS based
challenge with cloudflare.

## Requirements

1. You will need your own Domain name that you control, (for in this guide we assume you already configured
Cloudflare as your DNS server)
2. You will need to setup your home router/DNS server to resolve your local IPs to the internal ip. 
e.g. local.domain.com should return you 192.168.x.x IP from your home network
   * in openwrt: go to network => DHCP and DNS and in Addresses add an entry 
   like: `/.local.domain.com/local.domain.com/192.168.1.x`

you can test this setup by using a self-signed certificate first in your setup.

{{% hint warning %}}
For now only cloudflare is supported, please open a ticket to add more providers if needed.
{{% /hint %}}

## Setup

### Caddy
Make sure you installed caddy with the cloudflare plugin.

Also use a real email address otherwise certification creation will fail. 

```bash
run_role_caddy: True
email: "me@example.com"
caddy_plugins:
- github.com/caddy-dns/cloudflare
```

### Api KEY

Get an API key for cloudflare: 
1. go to profile => api tokens (https://dash.cloudflare.com/profile/api-tokens)
2. create a token with permissions:
   * Zone.Zone:Read
   * Zone.DNS:Edit
3. Optionally, but recommended, limit the API key to the domain you indent to use
4. get the kay and store it as a secret in your inventory

### Configure your vhost

now in your server configuration you can define tls type to cloudflare

```bash
vhosts:
  - name: internal_net
    enabled: true
    comment: "cloudflare tls protected"
    servers:
      - type: "proxy"
        enabled: true
        domains:
          - "https://local.my-domain.com"
        proxy_url: "http://127.0.0.1:3003"
        tls:
          type: "cloudflare"
          api_key: "{{ secrets.services.caddy.cf_api_token }}"
```

This action will automatically add the secret to the vhost using the protected file `/etc/caddy/env`
