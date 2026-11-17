# Tenants

Each folder here is one project the QA agent works on. A tenant lives in one of two layouts:

| Layout | What it is | Git |
|---|---|---|
| Separate | The core repository plus a tenant that is its own git repository | The core ignores everything in this folder except this file |
| Combined | One repository that holds the whole core and one tenant | The combined repository tracks its tenant folder (its `.gitignore` un-ignores it) |

- Create: `harness\new-tenant.ps1 <name>` (copies `templates\tenant`).
- Bring a separate tenant onto a machine: `git clone <tenant repo url> tenants\<name>`.
- Switch: `harness\use-tenant.ps1 <name>`, then restart the Claude session.
- Combined layout: generic changes (no tenant data) also belong in the core repository, and core changes belong in the combined one. Copy them with `harness\sync-core.ps1 -CoreRepo <core clone>`. It moves patches, not history, and stops if a change carries tenant data (folder name, `blocked-patterns.txt`, optional `core-sync-words.txt`).
