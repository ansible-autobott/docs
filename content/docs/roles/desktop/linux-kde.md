---
weight: 10
bookCollapseSection: true
title: "Linux KDE"
---



# Linux KDE

This role installs the KDE Plasma desktop and applies an opinionated set of
defaults — theme, keyboard shortcuts, window behaviour and tweaks for Dolphin,
Konsole and Yakuake. It supports Debian (bookworm ships Plasma 5, trixie ships
Plasma 6) and Ubuntu; the matching tooling is selected automatically from the
distribution release.

## Enable the role
``` yaml
run_role_linux_kde: true
```

## Mandatory configuration:

This role has no mandatory configuration.

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items; for the complete set of
options refer to the defaults/main.yaml file in the role directory.
{{% /hint %}}

All options below live under the `linux_kde` dictionary, which is merged with the
role defaults — you only need to set the keys you want to change.

### Apply the desktop style (theme + customizations)
```yaml
linux_kde:
  # install the elementary-breeze theme and apply the KDE customizations
  # (shortcuts, window-decoration buttons, Dolphin / Konsole / Yakuake tweaks,
  # wobbly windows, ...) for the primary desktop user.
  # This implies add_kde_elementary_breeze.
  add_kde_style: true
```

{{% hint info %}}
**NOTE:**  
The customizations are applied by running a `kwriteconfig` script as the desktop
user — `kwriteconfig.sh` on Plasma 5, `kwriteconfig6.sh` on Plasma 6, chosen
automatically for the target release. Because they write to the user's
`~/.config`, some settings only take effect after the user logs out and back in.
{{% /hint %}}
--- 

### Install the elementary-breeze theme only
```yaml
linux_kde:
  # install the elementary-breeze theme package without the customizations.
  # (add_kde_style already pulls this in.)
  add_kde_elementary_breeze: true

# optional: override the theme package that gets installed
linux_kde_elementary_breeze_url: "https://github.com/andresbott/elementary-breeze/releases/download/v0.1.4/elementary-breeze_0.1.4_all.deb"
```
--- 

### Image context-menu actions
```yaml
linux_kde:
  # add Dolphin service-menu actions to convert, rotate and flip images
  # (installs qdbus + imagemagick and the kim_* helper scripts).
  add_kde_menu_actions: true
```
--- 

### Global menu (appmenu) — Debian 13 (trixie) only
```yaml
linux_kde:
  # install the GTK appmenu modules and export GTK_MODULES so GTK apps publish
  # their menus over D-Bus for the Plasma "Global Menu" widget. You still add
  # the Global Menu widget to a panel yourself (a per-user Plasma setting).
  add_kde_global_menu: true
```

{{% hint info %}}
**NOTE:**  
On some older NVIDIA/X11 setups the GTK appmenu module can crash GTK apps, which
is why this is opt-in.
{{% /hint %}}
