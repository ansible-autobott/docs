---
weight: 10
title: "Inventory setup"
---

# Inventory setup

Autobott allows to manage multiple hosts with different configurations.

Generally you would keep your own inventory in a different git repository, one repo that contains multiple hosts
normally is enough.

You can use [ansible-autobott/inventory](https://github.com/ansible-autobott/inventory) as a starting point to setup
your own inventory; you can als use the sample inventory in this repo (used for vagrant) as guidance to set up your own.

the default inventory locaion is `../inventory/main.yaml` but you can specify diferent one with the env var
`INV`

```bash 
export INV="../inventory/servers.yaml"
make run
```
```bash
make run INV=../inventory/servers.yaml
```

## Secrets

For details about how to manage your secrets check [Secret Management](/docs/docs/guides/secrets)

