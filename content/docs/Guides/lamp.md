---
weight: 60
bookToc: true
title: "LAMP (kind of)"
---

# LAMP

Originally Autobott was stared as a private project to setup shared LAMP instances.

A lot has changed in the last ~ 10 years from when this project started but this core functionality is still present.

Either to run multiple self-hosted php applications our if you want to give some "users" access to a limited LAMP, 
this setup described below was made with the intent to isolate as much as possible every PHP instance without using
VMs or docker instances.


{{% hint info %}}
This setup assumes that you have already enabled the mariaDB and php-fpm roles
{{% /hint %}}

##  Vhost setup

The vhosts role allows you to define multiple virtual hosts, with one assigned to each service.

Under the hood, the vhosts role creates a dedicated user for each virtual host. This user is then used to run the PHP 
process, effectively isolating PHP execution per service.

The per-user PHP configuration is highly customizable, allowing fine-grained control over many PHP runtime parameters.

Similarly, if a database is required, the vhosts role can create a separate database for each user.

The vhosts convention is to create a folder structure like `/vhosts/<name>/home_dir/public_html`.
Here, the home_dir directory acts as the user’s home and defines the boundary of the SFTP jail (see below).

Below is a sample Vhost configuration for a PHP service. For complete details, please refer to the [Vhosts page](/todo).

```yaml
  - name: demo_lamp
    enabled: true
    comment: "lamp example"
    sample_content: "php"
    password: "user-password"
    groups:
      - sftp
    servers:
      - enabled: true
        domains:
          - "https://php.mydomain.com"
        type: "php"
    php:
      enabled: yes
    mariadb:
      enabled: true
      password: "db-password"

```
## sftp Jail
Now if you want to give sftp access to your users, e.g. FileZilla, in a aftp jail, you can configure a jail like below:

This will allow only the users in the group "sftp" to login with password but they will have limited access and only
using the sftp protocol.
```yaml 
linux_basic:
  ssh:
    sftp_jails:
      - group_name: sftp
        jail_dir: "/vhosts"
        start_dir: "/home_dir" 
        umask: "0037"          
        allow_password: true
        remove: false 
```

## user backup with Goback

Additionally, if you want to allow your users to download regular automated backups, you can setup the Goback role
to generate backups files in their respective jail with a config similar to this: 

```yaml
goback_profiles:
  - name: demo_lamp
    enabled: yes
    destination: /vhosts/demo_lamp/home_dir/backups
    delete_destination: false  # delete destination on disable
    dirs:
      - root: /vhosts/demo_lamp/home_dir/public_html
    mysql:
      - dbname: "demo_lamp"
    keep: 1
    file_owner: demo_lamp
    corn_monthly: True
    corn_weekly: false



```