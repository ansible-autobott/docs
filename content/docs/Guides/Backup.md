---
weight: 60
bookToc: true
title: "Backup"
---

# Running backups

This guide describes an opinionated backup strategy, take inspiration on this for you own needs.

## Goback

Goback is a simple tool that generates backups as zip files on a specific location.

The idea here ist to use Goback mostly for LAMP applications or where backup sizes are not huge,
and we still want easy to manage files; these files will eventually end in a secondary Borg backup Archive.

This will be mostly used to back up data on remote machines (VPS) and be able to pull to the local machine.

### Backups for other users

With goback you can define a profile that generates backups into a location where other users (non-admins)
can ssh/sftp into and grab/work on them.

E.g. following the [LAMP](/docs/docs/guides/lamp/) example you can configure a profile to put the backup into
the users home:

```yaml
goback_profiles:
  - name: demo
    enabled: True
    dirs:
      - root: /vhosts/demo/home_dir/public_html
    mysql:
      - dbname:  demo
    keep: 2
    corn_weekly: True
    # this is where we define the target    
    destination: /vhosts/demo/home_dir/backups
    file_owner: demo
    file_mode: "0600"
    dir_mode: "0700"
```


### Goback SFTP jail

This is how to configure Goback to put its archives into an SFTP jail so that we can then pull them 
from a remote machine.

Let's start by configuring our jail, using the linux_base role we create a limited user with ssh key only access.



{{% hint warning %}}
Just make sure to not name the user `goback` as it will conflict with the system created user.
{{% /hint %}}

```yaml
users:
  - username: backup
    enabled: true
    delete_home: false
    name: "backup"
    primary_group: "nogroup"
    shell: /bin/false # optional
    home: "/backup/home"
    ssh_key:
      - "ssh-ed25519 AAAAC...rfRRV0J5l my-key"
```

and create the corresponding jail for that user:

```yaml
ssh:
  - user_name: backup
    allow_password: false
    jail_dir: "/backup"
    # this is a relative path to the jail root
    # in this case the real path would be: /backup/output
    start_dir: "/output"
```
{{% hint danger %}}
**Important**
When defining your folder structure, take in account that the jail root will be owned by root and will have
permission 755, this is a requirement for the jail to work.
{{% /hint %}}

Now le's configure our profile to put the backups in `/backup/output`

```yaml
  - name: mediawiki
    enabled: yes
    keep: 2
    corn_weekly: True
    dirs:
      - root: /vhosts/mediawiki/home_dir/data
    mysql:
      - dbname: "mediawiki"
    
    # this is where we define the target
    destination: /backup/output/mediawiki
    file_owner: backup
    file_mode: "0600"
    dir_mode: "0700"

```
{{% hint info %}}
Since we intend to store multiple profiles we create a sub folder for every profile
{{% /hint %}}

now you can test the sftp jail:
```bash
$~ sftp backup@my-host
```
---

### Automatic pull of remote backup files 

{{% hint warning %}}
This is a placeholder for now, not yet implemented.
{{% /hint %}}


## Borg

Borg backup and it's companion app Borgmatic offer more advanced backup features like encryption and deduplication,
for this reason they are more suited for final archival, but they make it a bit more cumbersome to work with.

In this guide we will show different scenarios to use backup with borg/borgmatic

---
### Local Borg repo

This scenario your data and repo live on the same machine, this basically gives you a Time-machine backup where 
you can see the different snapshots of your data.

To setup a Local repo, simply define a local path in your profile

```yaml
encryption_passphrase: "demo"
destination:
  - path: /backups/docmost
    label: local
    encryption: repokey-blake2
```
Ford details check [borgmatic](http://localhost:1313/docs/docs/roles/base-services/borgmatic/)

---
### Remote Borg repo

In this scenario you have borg connecting over ssh to a remote repository and storing the backup there.

You can use a service like [borgbase](https://www.borgbase.com/) to host your remote repository, 
or you can set up your own with borg server.

First, you will need a pair of ssh keys, you can create them with:
```bash 
ssh-keygen -t ed25519 -C "your-application-name" -f ./id_ed25519_appname
```

{{% hint warning %}}
make sure to not provide any passphrase to the ssh key, otherwise remote backup will not work
{{% /hint %}}

To setup the remote repo, add the relevant config to your profile

```yaml
    ssh_key: |
      -----BEGIN OPENSSH PRIVATE KEY-----
      b3BlbnNzaC1rZ....Rpb24tbmFtZQ==
      -----END OPENSSH PRIVATE KEY-----
    encryption_passphrase: "demo"
    destination:
      - path: ssh://bra0oig1@bra0oig1.repo.borgbase.com/./repo
        label: borgbase
        encryption: repokey-blake2
```
{{% hint info %}}
**Note**: The borgbase role will initialize the repository for you, so no action needed.
{{% /hint %}}



---
### Setup a remote borg server

We will explain how to configure Borg so that it can be used as a remote repo.

Start by adding the repo into the borg configuration

{{% hint danger %}}
For now the borg role only supports setting up a server with version 2.0.0b19
{{% /hint %}}

```yaml
borg:
  # use borg version 2
  version: "2.0.0b19"
  server:
    enabled: true
    repos:
      - name: test
        public_key: "ssh-ed25519 AAAA... test-remote"
        permissions: "all"
```

This will create a repository that can be accessed via ssh on `ssh://borg@my-host/test`

{{% hint info %}}
**NOTE:** the configured ssh key will **only** be able to run borg actions, and only in the scop of the configured permissions
{{% /hint %}}

You can create multiple entries for the same repo e.g.

```yaml

repos:
  - name: test
    public_key: "ssh-ed25519 AAAA... key1"
    permissions: "write-only"
  - name: test
    public_key: "ssh-ed25519 AAAA... key2"
    permissions: "read-only"
```

---
### borgmatic 101

These are some basic commands when working with borg/borgmatic

create a new archive
```bash 
sudo borgmatic --config /etc/borgmatic.d/<profile>.yaml --verbosity 1
```

list archives
```bash 
sudo borgmatic --config /etc/borgmatic.d/<profile>.yaml list
```

mount an archive
```bash 
borgmatic  --config /etc/borgmatic.d/<profile>.yaml mount \
--repository <repo name> --archive <archive-name>  --mount-point <moiunt point>

# unmount later with 
umount <moiunt point>
```

