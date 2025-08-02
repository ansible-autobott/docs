---
weight: 10
bookCollapseSection: true
title: "Lynis audit"
---

# Lynis audit

Lynis audit (https://cisofy.com/lynis/) will run the audit and generate a report on your host machine.


## Enable the role
``` yaml
run_role_lynis: true

```

## Read the result
Once the role was executed, it will create a file on your host machine in the folder `./reports/lynis_audit`

You can parse it with the included utility 

```bash
cd reports
./lynis_parser.sh ./lynis_audit/my_report.dat

```