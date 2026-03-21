---
weight: 70
bookToc: true
title: "Upgrade to Debian 13 (trixie)"
---

# Upgrade to Debian 13 (trixie)

This guide covers upgrading a host managed by autobott from Debian 12 (bookworm) to Debian 13 (trixie).

{{% hint warning %}}
Take a snapshot or backup before upgrading. The playbook reboots the host as part of the upgrade.
{{% /hint %}}

## 1. Update inventory

In `base.yaml`, set the target release:

```yaml
linux_apt:
  release: "trixie"
```

## 2. Run the upgrade

{{% hint info %}}
The upgrade only runs when the `linux-upgrade` tag is explicitly passed. Running the full playbook without this tag will not trigger the upgrade.
{{% /hint %}}

```bash
make run INV=../inventory/main.yaml HOST=<host> TAG=linux-upgrade
```

The playbook will:

1. Replace `/etc/apt/sources.list` with trixie sources
2. Remove `php` before the upgrade (trixie ships PHP 8.4 vs 8.2 in bookworm)
3. Run `apt dist-upgrade`
4. Remove obsolete packages
5. Reboot
6. Clean the package cache

## 3. Re-apply the full playbook

After the upgrade, run the full playbook to re-apply all role configurations for trixie:

```bash
make run INV=../inventory/main.yaml HOST=<host>
```

This handles role-specific changes including:

- **PHP-FPM**: installs PHP 8.4, removes old 8.2/8.3 configs
- **ZFS**: rebuilds DKMS modules against the new kernel
- **Tailscale**: APT source updates to trixie automatically
- **MariaDB**: no changes needed, trixie is supported

## Notes

- The upgrade only triggers when `linux_apt.release` differs from the running OS release. If the host is already on trixie, `distupgrade.yaml` is skipped.
- If ZFS pools are in use, verify `zpool status` after the reboot before continuing.
