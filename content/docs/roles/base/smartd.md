---
weight: 80
bookCollapseSection: true
title: "Smartd"
---
# Smartd

Smard (S.M.A.R.T) is set of tools and daemon used to monitor disk health


## Enable the role
``` yaml
run_role_smartd: True

```

## Optional configuration:

``` yaml
smartd:
  powermode: idle
  skip_count: 0
  email: root
```

### powermode

configure the power mode on what smart will scan a disk, possible values:
* never: smartd will poll (check) the device regardless of its power mode.
* sleep: check the device unless it is in SLEEP mode.
* standby: check the device unless it is in SLEEP or STANDBY mode.
* idle: check the device unless it is in SLEEP, STANDBY or IDLE mode, 
in idle normally disks are still spinning

see https://www.smartmontools.org/wiki/Powermode for details

### skip_count

Defines the amount of checks before the power mode is skipped and disks are started
to check the disk status, polling is done every 30 min; 1460 is once a month

### email

Define who to notify, the email field can be a coma separated list without spaces.

If you set a local user e.g. root, and have nullmailer configured properly the admin should get the email instead.

Use the special sting `nomailer` to not send anyone an alert.

more details: https://linux.die.net/man/5/smartd.conf


{{% hint info %}}
**NOTE:**  
Autobott changes the default configuration of the debain installation and does **not** use
/usr/share/smartmontools/smartd-runner to send emails, hence everyting you might put in
/etc/smartmontools/run.d/ will be ignored.
{{% /hint %}}

## nanoSmart

https://github.com/ansible-autobott/nanoSmart

is a small cron + a Vue.js SPA to make smart information visible over an HTTP server.
nanosmart cron and SPA is installed and enabled by default; 
to make the content accessible add a Vhost config like:

```yaml

  - name: nanosmart
    enabled: true
    servers:
      - enabled: true
        domains:
          - "https://smart.domain.com"
        type: "static"
        document_root: "/opt/nanoSmart/webui"

```

If you wish to disable nanoSmart the config of nanoSmart.enabled to false

``` yaml
smartd:
  nanoSmart:
    enabled: false
```

{{% hint info %}}
**NOTE:**  
This will also delete all current existing reports stored in the same installation dir.
{{% /hint %}}
