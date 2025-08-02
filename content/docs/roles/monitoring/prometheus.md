---
weight: 20
bookCollapseSection: true
title: "Prometheus"
---

# Prometheus

This role installs a single prometheus instance and allows to configure it


## Enable the role
``` yaml
run_role_prometheus: false

```

## Optional configuration: 

{{% hint warning %}}
**Important:**  
This documentation page is incomplete and only shows the default role configuration.
improvements are pending.
{{% /hint %}}

### Configuration
```yaml
prometheus: 
  version: 3.4.2
  # User and group configuration
  user:
    name: prometheus
    uid: # Let system assign UID
    group: prometheus
    gid: # Let system assign GID

  # Installation paths
  paths:
    base_dir: /opt/prometheus
    data_dir: /opt/prometheus/data
    config_dir: /opt/prometheus/config

  # Service configuration
  service:
    bind_ip: 127.0.0.1
    port: 9090
    loglevel: info
    scrape_interval: 1m
    evaluation_interval: 1m
    retention: 15d

  # list of alertmanager targets
  alertmanagers: []
  # define a list of scrape targets
  # e.g.
  # - name: prometheus        # name of the target
  #   target: localhost:9090  # host for checking the /metrics endpoint
  #   labels:                 # extra set of labels to add to the metric
  #     server: vagrant
  scrape_targets: []
  # set of rule files to load in the prometheus configuration,
  # search path is <role path>/files/prometheus_rules and <inventory>/files/prometheus_rules
  # the role already provides some build in rules files:
  # - deadManSwitch.yaml => constantly send an alert, used to verify alerting works
  # - AlertsSystemStatus.yaml => contains basic system alerts
  # - instanceDown.yaml => alerts if a scrape target is down
  rules_files: []
```


