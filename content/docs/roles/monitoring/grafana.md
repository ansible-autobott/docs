---
weight: 40
bookCollapseSection: true
title: "Grafana"
---

# Grafana

This role takes care of configuring your apt sources.


## Enable the role
``` yaml
run_role_grafana: True
```

## Optional configuration:

{{% hint warning %}}
**Important:**  
This documentation page is incomplete and only shows the default role configuration.
improvements are pending.
{{% /hint %}}

### Configuration
```yaml
grafana: 
  version: 12.0.2
  # User and group configuration
  user:
    name: grafana
    uid: # Let system assign UID
    group: grafana
    gid: # Let system assign GID

  # Installation paths
  paths:
    base_dir: /opt/grafana
    data_dir: /opt/grafana/data

  # Service configuration
  service:
    bind_ip: 127.0.0.1
    port: 3000
    loglevel: info

  # url of the prometheus instance
  datasource_url: "http://localhost:9090"

  # a list of dashboards to provision on the instance
  # files to search in <role>/files/dashboards 
  # and <inventory>/files/grafana_dashboards
  #  - node-exporter-full.json
  dashboards: []
```



```


