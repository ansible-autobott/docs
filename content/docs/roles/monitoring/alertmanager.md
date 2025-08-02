---
weight: 50
bookCollapseSection: true
title: "Alertmanager"
---

# Monit

This role installs a single alertmanager instance and allows to configure it



## Enable the role
``` yaml
run_role_alertmanager: true

```

## Optional configuration:

{{% hint warning %}}
**Important:**  
This documentation page is incomplete and only shows the default role configuration.
improvements are pending.
{{% /hint %}}

### Configuration
```yaml
alertmanager: 
  version: 0.28.1
  # User and group configuration
  user:
    name: alertmanager
    uid: # Let system assign UID
    group: alertmanager
    gid: # Let system assign GID

  # Installation paths
  paths:
    base_dir: /opt/alertmanager
    data_dir: /opt/alertmanager/data
    config_dir: /opt/alertmanager/config

  # Service configuration
  service:
    bind_ip: 127.0.0.1
    port: 9093
    loglevel: info

  receivers: [] # a list of receivers that will be put "as is" in the alertmanager configuration,
  # see https://prometheus.io/docs/alerting/latest/configuration/#receiver for details
  #- name: sample-email
  #  webhook_configs:
  #    - url: https://my-hook.com

  routes: [] # a list of alert routes that will be put "as is" in the alertmanager configuration,
  # see https://prometheus.io/docs/alerting/latest/configuration/#route for details
  #- receiver: 'sample-email'
  #  group_wait: 30s
  #  group_by: [cluster, alertname]
  #  routes:
  # All alerts with service=mysql or service=cassandra
  # are dispatched to the database pager.
  #    - receiver: 'sink'
  #      group_wait: 10s
  #      matchers:
  #        - service=~"mysql|cassandra"
  inhibit_rules: [] # a list of inhibit_rules that will be put "as is" in the alertmanager configuration,
  # see https://prometheus.io/docs/alerting/latest/configuration/#inhibit_rule for details
  #- source_match:
  #    severity: 'critical'
  #  target_match:
  #    severity: 'warning'
  #  equal: ['alertname', 'dev', 'instance']
```


