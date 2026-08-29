---
weight: 50
bookToc: true
title: "Secret management"
---

# Secret Management

Autobott manages inventory secrets with [SOPS](https://github.com/getsops/sops)
using [age](https://github.com/FiloSottile/age) keys. Secret **values** are
encrypted inside `*.sops.yaml` files that live next to the rest of your
inventory, and they are decrypted **transparently at runtime** — you never run a
manual decrypt step before a play.

Why SOPS (vs. whole-file encryption):

- Only the **values** are ciphertext; the keys and structure stay in plaintext,
  so `git diff` still shows *what* changed (just not the secret itself).
- Encrypted `*.sops.yaml` files are **safe to commit** to your inventory repo.
- Multiple operators can each hold their own key — no shared password file.

## How it works

- `ansible.cfg` enables the SOPS vars plugin:

  ```ini
  [defaults]
  vars_plugins_enabled = host_group_vars, community.sops.sops
  ```

  Any `host_vars/<host>/*.sops.yaml` (also `.sops.yml` / `.sops.json`) is
  decrypted and merged automatically when the play runs.

- Decryption happens on the **control node** (where you run `make`), using your
  age **private key**. The managed hosts never see the key.

- The private key lives **next to the inventory** at `<inventory-dir>/sops_key`.
  Autobott's make targets export it as `SOPS_AGE_KEY_FILE`, derived from `INV`.

- A `.sops.yaml` at the inventory root lists the age **public keys**
  (recipients) allowed to decrypt each file.

> ⚠️ The private key (`sops_key`) is **secret** — gitignore it, never commit it.
> The encrypted `*.sops.yaml` files, and `.sops.yaml` itself, *are* committed.

## Setup

### 1. Install the tooling

`make prepare` installs the `community.sops` Ansible collection and verifies the
`sops` and `age` binaries are present (offering to install them if not).

```bash
make prepare
```

### 2. Create your age key

Run this once per operator, pointing `INV` at **your** inventory. It writes
`sops_key` next to the inventory and prints your **public** key:

```bash
make age-key INV=/path/to/your-inventory/
```

output:

```text
Creating age key at /path/to/your-inventory/sops_key ...
Done. Add this public key to your .sops.yaml recipients:
# public key: age1jv59tpdyjs99kmrykr9jeqwvsxfdu999rxdk98m2emsjue4l2e8spms3vh
```

`age-key` refuses to overwrite an existing key, and refuses the playbook repo's
bundled sample inventory (that one ships a committed example key). If you prefer,
generate it by hand instead:

```bash
age-keygen -o /path/to/your-inventory/sops_key
```

Make sure `sops_key` is gitignored in your inventory repo:

```gitignore
# secrets/…/.gitignore
/sops_key
```

### 3. Declare the recipients — `.sops.yaml`

Create a `.sops.yaml` at your inventory root. `path_regex` selects which files a
rule applies to; `age` lists the public keys that may decrypt them (a YAML list,
one `- age1...` per line, or a comma-separated string):

```yaml
# /path/to/your-inventory/.sops.yaml
creation_rules:
  - path_regex: (^|/)(host_vars|group_vars)/.*\.sops\.ya?ml$
    age:
      - age1jv59tpdyjs99kmrykr9jeqwvsxfdu999rxdk98m2emsjue4l2e8spms3vh
      # - age1<teammate-public-key>
```

`sops` finds this file by walking **up** from the secret being encrypted, so it
must live in the inventory repo it governs.

## Managing secrets

### The secrets file

Keep each host's secrets in one `secrets.sops.yaml` and reference them from the
other host_vars. You write it as normal YAML; only the values become ciphertext
once sealed.

```yaml
# host_vars/my_host/secrets.sops.yaml
secrets:
  ans_sudo_pw: "MySecret"
  users:
    my_user:
      other_pw: "AnotherSecret"

# host_vars/my_host/base.yaml
ansible_become_pass: "{{ secrets.ans_sudo_pw }}"
```

### Create & seal a new secrets file

Write `host_vars/<host>/secrets.sops.yaml` in plaintext, then encrypt it in
place:

```bash
make seal-secrets INV=/path/to/your-inventory/ HOST=my_host
```

`sops` encrypts every value to the recipients from `.sops.yaml`. The keys and
structure stay readable; the file is now safe to commit.

### Edit an existing secret

Decrypts to a temp file, opens your `$EDITOR`, and re-encrypts on save:

```bash
make edit-secrets INV=/path/to/your-inventory/ HOST=my_host
```

`edit-secrets` fails fast if the file is missing or not yet encrypted (it tells
you to `seal-secrets` first).

**GUI editors** must *block* until the window is closed, or SOPS re-encrypts an
empty file. Terminal editors (vim, nano) block by default. For Kate there is a
ready-made target:

```bash
make edit-secrets-kate INV=/path/to/your-inventory/ HOST=my_host
```

For other GUI editors set the wait flag yourself, e.g.
`export EDITOR='code --wait'` or `export EDITOR='subl -w'`.

### View a secret

Decrypt to stdout without opening an editor:

```bash
make view-secrets INV=/path/to/your-inventory/ HOST=my_host
```

### Multi-line values (e.g. SSH keys)

SOPS encrypts whole values, so multi-line strings work as-is — paste them into
`secrets.sops.yaml` and `seal-secrets`. If a consumer needs the raw bytes and you
stored a base64 string, decode it with the `b64decode` filter:

```yaml
ssh_key: "{{ secrets.private_key_base64 | b64decode }}"
```

## Adding or rotating an operator

1. The new operator runs `make age-key INV=/path/to/your-inventory/` and shares
   their **public** key.
2. Append that public key to the `age:` recipients in `.sops.yaml`.
3. Re-encrypt existing files so the new key can read them (run by someone who can
   already decrypt):

   ```bash
   make rekey INV=/path/to/your-inventory/
   ```

   `rekey` runs `sops updatekeys` over every `secrets.sops.yaml` in the
   inventory, syncing their recipients to `.sops.yaml`.

To **revoke** an operator, remove their public key from `.sops.yaml` and
`make rekey`.

## Reference: make targets

| Target | Purpose |
|--------|---------|
| `make age-key INV=…` | Create the inventory's age key (`<inv-dir>/sops_key`) and print the public key |
| `make seal-secrets INV=… HOST=…` | First-time encrypt a plaintext `secrets.sops.yaml` in place |
| `make edit-secrets INV=… HOST=…` | Decrypt → `$EDITOR` → re-encrypt |
| `make edit-secrets-kate INV=… HOST=…` | Same, but in Kate (blocking GUI) |
| `make view-secrets INV=… HOST=…` | Decrypt a host's secrets to stdout |
| `make rekey INV=…` | Re-encrypt all `secrets.sops.yaml` to match `.sops.yaml` recipients |

All targets take `INV` (the inventory file or directory); the age key path and
the `.sops.yaml` are resolved relative to it. Set `SOPS_AGE_KEY_FILE=<path>` to
override the key location for a single command.
