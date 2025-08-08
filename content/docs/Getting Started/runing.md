---
weight: 30
title: "Running Autobott"
---

# Running Autobott 

The autobott repository contains some convenient make targets to run the ansible playbook,
here is a breakdown of the relevant targets to run Autobott.


## Commands


{{% hint info %}}
All make parameters can be set as environment variables as well
{{% /hint %}}

### Prepare
```bash
make prepare
```

Prepare will setup a local python Venv with all the needed dependencies, this way you don't relly on external
python installations.

### enroll
```bash
make enroll INV="../inventory" HOST="host.URL" ANSIBLE_PASS="AA" ANSIBLE_USER="debian"
```
Role used to automatically enroll Autobott, see [enroll](/docs/docs/getting-started/enroll/) for details.


### run
```bash
make run INV="../inventory" INV=inventory_path HOST="host.URL" TAG="a_tag"
```
The main role to run Auttobott, it will run the playbook.

---

## Parameters


### INV

`INV` points to the inventory path/file your inventory is defined

### HOST

`HOST` optional parameter that allows you to limit the execution to a subset of your hosts, it accepts comma separated values.

E.g. If you have host `a`,`b` and `c` in defined in your inventory but you only want to run a specific task
on host a and c you can do `HOST="a,c"`

{{% hint info %}}
NOTE: this is a per execution limitation, the next time you run without the HOST set all hosts will be picked up.
{{% /hint %}}

### TAG

`TAG` optional parameter that allows you to limit the execution to a subset of the actions by targeting a specific tag

Most of the tags in Autobott correspond to a single role, effectively allowing you to target specific roles, but 
there are exceptions, tags are documented for each role.
