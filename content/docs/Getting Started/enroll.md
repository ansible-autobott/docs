---
weight: 20
title: "Enroll a host"
---

# Enroll

To run Autobott you will need to have a user on the target system that allows for ssh in and sudo.

The recommendation is to use a dedicated management user (default is "ans") for this use-case.

The expectation is that this system user can be accessed with an ssh key only (defined in `autobott_enroll_ssh_keys`)
and once accessed it needs an second password (defined in `autobott_enroll_passwd` ) to obtain root on the system.

## Enrolling a host

{{% hint warning %}}
**Important**  
Autobott is intended and only tested with Debian stable versions.

It might take some time for the Autobott code to update after the release of a new stable version, 
make sure you are running a supported Debian version.
{{% /hint %}}

### Inventory setup

Regardless of manual or automatic enrollment, first you need to set the minimum basic variables for this
host in your inventory.

```yaml
# This are ansible specific variables that need to be present
ansible_become_pass:  "{{ secrets.ans_sudo_pw }}"
ansible_user: "{{ autobott_enroll.user }}"

# setup enroll role
autobott_enroll:
  # Ansible login user
  user: ans
  # used by ansible to escalate to root once logged in this 
  # is defined when we enroll the system
  passwd:  "{{ secrets.ans_sudo_pw }}"
  # User keys allowed to login as ansible admin, thus run ansible playbook
  ssh_keys:
    - "ssh-ed25519 AAAA...tVs3ZzC ans@autobott"
```


### Automatic enrolling

There is a convenient make target specified to enroll remote machines

```bash
export ANSIBLE_USER="debian"
export ANSIBLE_PASS="secret"
make enroll INV=../autobott2-inventory/inventory.yaml HOST=dev.ika.re

```
This will try to use existing users/credentials to perform the necessary setup on the target Host

### Manually enrolling a Host

If the automatic enrollment does not work, you can allways enroll the Host manually:

1. make sure sudo is installed 
```bash
apt update && sudo apt install -y sudo 
```

2. Create an admin user `ans` on the system
```bash
#Create the group with GID 900
sudo groupadd -g 900 ans
# Create admin user with a specific UID
sudo useradd -m -s /bin/bash -u 900  -g 900 ans
```
3. put your public ssh key in `.ssh/authorized_keys`

```bash
# prepare folders
sudo mkdir -p /home/ans/.ssh
sudo chmod 700 /home/ans/.ssh
# put the key
sudo echo "<THE PUBLIC KEY>" | sudo tee /home/ans/.ssh/authorized_keys > /dev/null
# fix permissions
sudo chmod 600 /home/ans/.ssh/authorized_keys
sudo chown -R ans:ans /home/ans/.ssh
```
4. Make sure to add the user to the sudo group so that he can execute `sudo su`
```bash
sudo usermod -aG sudo ans
```
5. Set a password for the user, this needs to match what you define in `ansible_become_pass`
```bash
sudo passwd ans
```
6. verify everything works

From the host machine
```bash
ssh ans@MACHINE # use ssh key, no password promt expected
sudo su # expected password prompt
```
---

## Running locally
if you don't want to have the ssh user exposes, you can as well clone the repository to the target machine
and run it locally with a user that also has sudo permissions.

{{% hint danger %}}
**Roadmap**  
Running locally has been done in the past, but is not properly tested nor documented for now.
{{% /hint %}}

