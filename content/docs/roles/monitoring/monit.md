---
weight: 10
bookCollapseSection: true
title: "Monit"
---

# Monit

Monit is a lightweight monitoring service with self-healing capabilities

## Enable the role
``` yaml
run_role_monit: True

```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}


### Configure Email delivery
```yaml
monit:
  # list of pre-made checks
  checks:
    system: True        # main system alerts, cpu/disk/memory
    ssh: True           # monitor and restart sshd
    mariadb: True       # monitor and restart mariadb service
    caddy:              # monitor and restart caddy service
      enabled: True
      port: 80
      
  # ads extra external host checks, using http requests
  external_hosts:
    # name of the service, used for the file
    - name: docmost
      # the url needs to be able to resolve, e.g. for docmost.localhost,
      # you need to add an entry to /etc/hosts
      url: https://docmost.localhost
      # optional, use if non-standard ports are used
      port: 8443
      # allow self signed certs
      selfsigned: true
```

### Configure Email delivery
```yaml
monit:
  # configure a smpt server to use for sending the emails
  # if you have a local smtp, e.g. nullmailer you don't need to specify again.
  smtp:
    host: ""
    port: ""
    user: ""
    pass: ""

  # email addresses that will get notifications
  alert_targets: 
    - user@email.com

```


