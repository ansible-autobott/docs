---
title: Introduction
type: docs
---

# Ansible Autobott
**Ansible Playbooks for Managing Self-Hosted Services on Debian Hosts**


{{% hint warning %}}
**Work in progress**  
The documentation is still under development and some parts are incomplete
{{% /hint %}}


---

## About

**AutoBott** is a curated set of Ansible playbooks designed to automate the deployment and maintenance of
self-hosted services on Debian-based servers — with limited support for basic desktop setups.

Whether you're running a homelab or managing a lightweight private cloud, AutoBott simplifies system administration, enhances security, and gets your favorite services running in minutes.

---

## Get Started

Check out the [Getting Started Guide](/docs/docs/getting-started/) to set up your first server or simply try
it out on a [vagrant VM](/docs/docs/getting-started/vagrant/).

---
## Features

### 🛠️ System Management & Hardening
- General Debian setup and maintenance
- Security best practices baked in
- [Lynis](https://cisofy.com/lynis/) auditing report
- [CrowdSec](https://www.crowdsec.net/) for real-time threat prevention

### 🔐 Networking & Access
- **ZFS** support for advanced storage
- **WireGuard** and **Tailscale** for secure networking
- **Authelia** for unified authentication and SSO

### 📦 File & Data Services
- **Samba** for Windows-compatible shared folders
- **MariaDB** automated setup and tuning
- **Backups** with Borg and Borgmatic (encrypted, deduplicated)

### 📈 Monitoring & Observability
- **Prometheus + Grafana** stack
- **Monit**

### 🎥 Media & Entertainment
- Install and manage **Jellyfin** and **Kavita**
- Deploy the full **Servarr** suite (Radarr, Sonarr, etc.)

### 🧠 Knowledge & Productivity
- Host internal wikis with **MediaWiki** and **Docmost**
- **Homepage** dashboard as your central control panel
- **Immich** photo manager for secure personal media

---

## Why Use AutoBott?

- ✅ Easy-to-read, modular Ansible roles
- ✅ Designed for reproducibility and minimal intervention
- ✅ Ideal for homelabbers, self-hosting enthusiasts, and small-scale private clouds

