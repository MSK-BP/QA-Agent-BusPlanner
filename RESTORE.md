# Restore after a PC reset

The QA hub is two git repositories:

| Part | Where it lives | Holds |
|---|---|---|
| Core | `MSK100/QA-Agent` (GitHub, private) | `CLAUDE.md`, `.claude/` (skills, agents, hooks), `harness/`, `templates/` |
| This tenant | `MSK-BP/QA-Agent-BusPlanner` (GitHub, private) | `TENANT.md`, `knowledge/`, `blocked-patterns.txt`, `playwright.json`, `harness/` (ado, unified, creds, setup), `reports/` |

Not in git, so keep a copy elsewhere (OneDrive or a password manager):

- `Infra Creds.txt`: plain-text secrets. Better: move them to a password manager.
- `backup/claude/`: Claude's memory and the 2026-11-10 build-out session. The raw session contains secrets.
- `repos/`: the BusPlannerUnified snapshot. Re-clone it from Azure DevOps instead (org `busplanner`, project `BusPlanner Unified`).
- `reports/audit.log`, `reports/browser/`: local run output.

## Steps

1. Install Git, then clone the core and this tenant:
   ```
   git clone https://github.com/MSK100/QA-Agent.git "QA Agent"
   cd "QA Agent"
   git clone https://github.com/MSK-BP/QA-Agent-BusPlanner.git tenants\busplanner
   ```
2. Put `Infra Creds.txt` and `backup\` back into `tenants\busplanner\`.
3. Run the setup. It installs Git, Node and the Playwright browser server, activates the tenant, then runs `tenants\busplanner\harness\setup.ps1` (.NET 8, Node 22, SSMS, OpenVPN, Claude memory restore):
   ```
   powershell -ExecutionPolicy Bypass -File .\harness\setup-machine.ps1 -Tenant busplanner
   ```
4. OpenVPN Connect: import the `.ovpn` from Dan's "VPN Access - New World CA Environment" email.
5. Open Claude, Code tab, the `QA Agent` folder. Connectors (Jira, Confluence, Slack, M365) reconnect from claude.ai.
6. Ask Claude: "read tenants/busplanner/RESTORE.md and check the setup".

Claude keys its memory by the folder path. If the hub ends up at a different path, the memory restore in step 3 still copies it to the right place, because it uses the path you run it from.
