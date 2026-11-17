# Tenant: BusPlanner

BusPlanner makes student transportation software: route planning, GPS+ fleet tracking, Time & Attendance, and a chatbot. The new platform is **BusPlanner Unified**; the older products are called "Old World". Details are in `knowledge/domain.md`.

- **Ticket tracker and wiki:** Jira (ENG, PROD, IN, SPT, SOC, MDP) and Confluence, through the Atlassian connector. Slack and Microsoft 365 are connected too.
- **Code:** Azure DevOps, org `busplanner`. Read-only helper: `harness/ado.ps1`.
- **Environments:** dev and staging only, CA and US (`knowledge/environments.md`). Read its "Hard rules" before acting on any environment: dev and staging are not isolated from real customer systems, and staging holds real customer data.
- **Secrets:** `Infra Creds.txt` in this folder. It is ignored by git and blocked from the Read tool. Use `harness/unified.ps1` and `harness/ado.ps1`, which load it without printing anything.
- **People to protect:** students, parents, drivers, schools and employees. Never copy their details into reports, tickets or chat, and never trigger anything that notifies them (Dispatch notices, parent emails).
- **Machine setup:** `harness/setup.ps1` (.NET 8, Node 22, SSMS, OpenVPN, Claude memory restore). Restore steps are in `RESTORE.md`.
