---
weight: 40
bookCollapseSection: true
title: "Docker"
---
# Docker

Install the docker daemon


## Enable the role
``` yaml
run_role_docker: true

```

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

```yaml
docker:
  # add a metrics endpoint on "127.0.0.1:9323"
  expose_metrics: true
  
  # Enable experimental features
  experimental: false
  
  # Enable live restore, https://docs.docker.com/engine/daemon/live-restore/
  live_restore: true
  
  # users added to the docker group
  users: 
    - jsmith
```