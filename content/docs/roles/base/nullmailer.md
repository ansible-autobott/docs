---
weight: 70
bookCollapseSection: true
title: "Nullmailer"
---
# Nullmailer

Nullmailer is a lightweight SMTP relay agent designed to forward outgoing mail from a host to a configured
smart relay server without handling local mail delivery.

We use it to send email notifications through _sendmail_




## Enable the role
``` yaml
run_role_nullmailer: True

```

## Mandatory configuration:

``` yaml
nullmailer:
  # destination address to send emails to, 
  # accepts multiple emails comma separated
  email_to: ""
  # smtp configuration
  smtp_server: ""
  smtp_user: ""
  smtp_pass: ""
```

## Optional configuration:

{{% hint info %}}
**NOTE:**  
This list highlights only the key configuration items we believe require your attention;
for the complete set of options, refer to the defaults.yaml file in the role directory.
{{% /hint %}}

``` yaml
nullmailer:
  # override_from set the from field in send emails
  # note see: https://github.com/bruceg/nullmailer/issues/72
  override_from: ""
  # set the default domain from where emails are sent from
  email_from: ""
```
