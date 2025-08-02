---
weight: 10
bookCollapseSection: true
title: "Linux Basic"
---



# Linux Basic

This role sets up essential base configurations for the Linux host including packages,
hostname, SSH, timezone, locale, users, and more.

## Enable the role
``` yaml
run_role_linux_basic: true

```

## Mandatory configuration:

This role has not mandatory configuration

{{% hint info %}}
**NOTE:**  
if you don't configure the default values, this role will perform the following changes on the system:

* Installing default packages
* allow only ssh key login
{{% /hint %}}



## Optional configuration: 



{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}



### Install additional packages
```yaml
# configure the role
linux_basic:
  packages:
    # list of apps that can be defined in a host inventory
    host_defined: []
    # list of apps that can be defined at group inventory
    group_defined: []
    # list of packages not to be present, defined in host inventory
    absent_host_defined: []
    # list of packages not to be present, defined in group inventory
    absent_group_defined: []
```
--- 

### Hostname related configuration

```yaml
linux_basic:
  # define the host's hostname
  hostname: ""
  
  # define the host's Fully qualified domain name
  fqdn: "{{ ansible_fqdn }}"
  
  # add extra entries to /etc/hosts
  etc_host_entries: 
    - 127.0.0.1 wiki.localhost
```
--- 

### sshd related configuration
```yaml
linux_basic:
  ssh:
    # enable X11 forwarding, this should not be needed on a normal server
    x11_forwarding: false
    
    # create a special group that will allow passwd auth, default only ssh keys are allowed
    pw_auth_group_name: "allowpwauth"
    
    # setup sftp jails for users in a specific group.
    # a jail allows users to sftp into the jail dir, but not navigate out of it 
    sftp_jails: 
      - group_name: sftp
        jail_dir: "/home"      # will be composed as {{ jail_dir }}/%u
        start_dir: "/home_dir" # optional, allows to define the default starting dir when opening a session
        umask: 0077            # change the umask parameter of the jail default is 0077 creates files as 0700
        allow_password: true
        remove: false # set to true to remove the sftp jail config

      - user_name: myuser
        jail_dir: "/home/user"  # the jail dir
        start_dir: "/home_dir" # optional, allows to define the default starting dir when opening a session
        umask: 0077            # change the umask parameter of the jail default is 0077 creates files as 0700
        allow_password: true
        remove: false # set to true to remove the sftp jail config
```

{{% hint info %}}
**NOTE:**  
In order for jails to work properly, they jail dir needs to be owned by root:root, the role will make this changes.

Take this in consideration when setting up your jail directory structure.
{{% /hint %}}


--- 

### Locales
```yaml
linux_basic:
  # set / change the timezone of the machine, e.g. "Europe/Zurich"
  timezone: "Europe/Zurich" # timezone to configure in the machine
  
  # this allows to overwrite the setting of the RTC (real time clock)
  # normally on windows the RTC is set to local time and on linux to UTC, you can force linux to use local
  time_rtc: "UTC" # "local | UTC"

  locale:
    # list of locales to be generated (take care to use value from /usr/share/i18n/SUPPORTED,as locale-gen exit with code 0 even with errors...)
    generate:
      - en_US.UTF-8 UTF-8
    # locale to be configured
    set:
      lang: en_US.UTF-8
      all: en_US.UTF-8  
```
--- 

### Users and groups
```yaml
linux_basic:
  ## create system groups
  groups: 
    - name: sftp
      gid: 402
      
  ## create an system users
  system_users:
    - username: "tardis"
      enabled: true
      name: "that blue box"
      groups: [ 'trenzalore','gallifrey']
      uid: 2001
      gid: 2001
  
  ## create regular users
  users:
    - username: jsmith
      name: "The Doctor"
      enabled: yes
      delete_home: false # if enabled is set to false, determine if the home directory should be deleted
      primary_group: "users" # group needs to exist, default "users"
      groups: ['sudo', 'trenzalore','gallifrey']  # empty string removes user from all secondary groups
      enforce_groups: no
      password: "my-secrets-password" # encrypted
      shell: /bin/bash # optional
      ssh_key:
        - "ssh-rsa AAAAA.... john@laptop"
        - "ssh-rsa AAAAB.... doctor@desktop"
      ssh_key_revoked:
        - "ssh-rsa AAAAB.... doctor@desktop"
      uid: 2001
      gid: 2002
      
  # same as users but allows to define users in two inventory places  
  users_extra: []    
```
--- 

###  Mixed stuff
```yaml
linux_basic:
  # setup an email in cron that will get cron error reports
  cron_email: "" 
  # add a timeout of when sudo will ask a password again.
  # set to "" to disable
  sudo_timeout: "600"
```
