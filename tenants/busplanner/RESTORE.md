# Restore after a PC reset

The QA hub is one git repository: `MSK-BP/QA-Agent-BusPlanner` (GitHub, private). It holds the core at the root (`CLAUDE.md`, `.claude/` with skills, agents and hooks, `harness/`, `templates/`) and this tenant in `tenants/busplanner/` (`TENANT.md`, `knowledge/`, `blocked-patterns.txt`, `playwright.json`, `harness/`, `reports/`).

Not in git, so keep a copy elsewhere (OneDrive or a password manager):

- `Infra Creds.txt`: plain-text secrets. Better: move them to a password manager.
- `backup/claude/`: Claude's memory and the 2026-11-10 build-out session. The raw session contains secrets.
- `repos/`: the BusPlannerUnified snapshot. Re-clone it from Azure DevOps instead (org `busplanner`, project `BusPlanner Unified`).
- Run output (`audit.log`, `browser/`, `runs/`, `headless/`): in `C:\Users\skhan\Repos\qa-runs\busplanner\`, outside OneDrive. After a restore, run `harness\use-tenant.ps1 busplanner -RunRoot C:\Users\skhan\Repos\qa-runs` from the hub, and clone the product repos again into `C:\Users\skhan\Repos\` with `harness\git-ado.ps1`.

## Steps

1. Install Git, then clone the repository:
   ```
   git clone https://github.com/MSK-BP/QA-Agent-BusPlanner.git "QA Agent"
   ```
   Sign in to GitHub with the GitHub CLI (`gh auth login --web`, in the MSK-BP browser profile). Then make the repo always use that account, whichever is active in `gh`, by adding this to `.git\config`:
   ```
   [credential "https://github.com"]
   	helper =
   	helper = "!f() { test \"$1\" = get || exit 0; echo username=MSK-BP; echo password=$('C:/Program Files/GitHub CLI/gh.exe' auth token --user MSK-BP); }; f"
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
