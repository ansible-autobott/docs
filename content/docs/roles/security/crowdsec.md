---
weight: 30
bookCollapseSection: true
title: "Crowdsec"
---

# Crowdsec

Install Crowdsec and make a minimal configuration using firewall bouncer, the basic role will listen 
for ssh login attempts + central API decisions and apply them to the firewall bouncer.

This setup will cover you from:
1. brute force ssh login attempts (if you still use passwords)
2. general community identified ips doing brute force attacks


## Enable the role
``` yaml
run_role_crowdsec: True

```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

### Configure sources
```yaml
crowdsec:
  # automatically run hub upgrade daily, this should be fine if you stay with the default config  
  automatic_hub_upgrade: False
```

{{% hint warning %}}
**NOTE about automatic_hub_upgrade:**  
This is disabled as default as we consider it an Experimental feature.

The default debian packager decided to not add a cron job to pull new collections (parsers + decisions) on a schedule.
We assume it was done on purpose to delegate this to the sysadmin to be performed manually.
We are currently evaluating what are the consequences of automatics vs manual update.
{{% /hint %}}

