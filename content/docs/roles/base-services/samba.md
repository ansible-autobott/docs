---
weight: 40
bookCollapseSection: true
title: "Samba"
---

# Samba

Install and configure Samba shares a.k.a Windows shared folders


## Enable the role
``` yaml
run_role_samba: true

```

## Optional configuration: 

{{% hint info %}}
**NOTE:**  
Samba configuration is quite extensive and complex, check the defaults of the role if you miss something.
{{% /hint %}}


Define the samba users
```yaml
samba:
  # define users
  users:
    - name: jsmith
      password: "{{ secrets.users.jsmith.passwd }}"
```

Setup the shared folder

```yaml
samba:
  # setu shared folders
  shares:
    - name: "shared_folder"
      comment: "A shared folder"
      path: "/path/to/shared_folder"
      # list of users that can access the share
      valid_users: 
        - jsmith
      # sepcify users that have write access
      write_list:
        - jsmith
      # force user, group and modes when creating files
      force_user: ""
      force_group: ""
      create_mode: "0664"
      force_create_mode: "0664"
      directory_mode: "0775"
      force_directory_mode: "0775"        

```


