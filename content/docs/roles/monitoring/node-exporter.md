---
weight: 30
bookCollapseSection: true
title: "Node Exporter"
---

# Node Exporter

This role takes care of installing and configuring node exporter


## Enable the role
``` yaml
run_role_node_exporter: True

```

## Optional configuration:

{{% hint warning %}}
**Important:**  
This documentation page is incomplete and only shows the default role configuration.
improvements are pending.
{{% /hint %}}

### Configuration
```yaml
node_exporter:
  version: 1.9.1
  # User and group configuration
  user:
    name: node_exporter
    uid: # Let system assign UID
    group: node_exporter
    gid: # Let system assign GID

  # Installation paths
  paths:
    base_dir: /opt/node_exporter
    data_dir: /opt/node_exporter/data
    config_dir: /opt/node_exporter/config
    textfile_collector: /var/lib/node_exporter/textfile_collector

  # Service configuration
  service:
    bind_ip: 127.0.0.1
    port: 9100
    log_level: info

  default_collectors: true # set to false to disable the default set of collectors
  collectors: # list of extra collectors to be enabled, see: https://github.com/prometheus/node_exporter
    - textfile

  # allows to define scripts that will run with cron that will output monitoring data
  # to a static file that node_exporter picks up
  # Example:
  # - file: disk_usage.sh
  #   enabled: true
  #   cron: "*/5 * * * *"
  textfile_collectors: []
  # allows to create static metrics, useful to show details about the instance in grafana
  #    - name: "metric name"
  #      desc: "metric description"
  #      metric_values: # apparently item.values os a reserved word in jinja
  #        - value: "1"
  #          labels:
  #            - name: "test"
  #              value: "value"
  #            - name: "bla"
  #              value: "ble"
  static_annotations: []
```




