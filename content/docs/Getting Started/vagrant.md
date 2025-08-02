---
weight: 1
bookToc: false
title: "Try it on vagrant"
---
# Try it yourself

This ansible playbook has a convenien vagrant/virtualbox integration for testing and development.

prerequisites:


*  Install virtual box from https://www.virtualbox.org/
* install vagrant https://developer.hashicorp.com/vagrant

## Bake the base image

Create the base vagrant image (this needs to be only once), this will bake a base debian image that autobott will use to clone other instances

``` bash
make vagrant-base
```

## Install

IMPORTANT: make sour you don't have other VMs running and/or listening on localhost ports: 2200,8080,8443

Start and Enroll your VM (add the minimal setup to your new image)

``` bash
make vagrant-up
```

Run all roles to provision all the services
``` bash
make vagrant-run
```
You can also run specific roles,targets using the Vars TAG=<tag> and HOST=<host>
``` bash
make vagrant-run TAG=authelia
```

{{% hint warning %}}
**known_hosts error**  
If you get error "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED", you need to trust the new host in known_hosts.

You can run `make vagrant-ssh-renew` to delete and trigger a new ssh login

{{% /hint %}}


## Next steps

After completing the installation (can take a while) you can access the instance on
[https://localhost:8443](https://localhost:8443) or access the instance over ssh with 

``` bash
cd vagrant
vagrant ssh
```




## Cleanup

Lastly if you want to delete the image ( or start all over again)

Note: this will delete all data on the image
``` bash
make vagrant-destroy
```
