# Tenants

Each folder here is one project the QA agent works on, and is its own git repository. The core repository ignores everything in this folder except this file.

- Create: `harness\new-tenant.ps1 <name>` (copies `templates\tenant`).
- Bring an existing one onto a machine: `git clone <tenant repo url> tenants\<name>`.
- Switch: `harness\use-tenant.ps1 <name>`, then restart the Claude session.
