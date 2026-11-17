# QA Agent: set-up for a team member

This repository is the whole QA Agent for BusPlanner: the agent at the root, and the BusPlanner knowledge, helpers and reports in `tenants/busplanner/`. Everyone uses the same repository. Each person uses **their own** accounts and secrets. Never share a credentials file, a token or a password.

Time: about one hour. Windows only (the hooks and helpers are PowerShell).

## 1. Accounts to have first

| Need | From | Used for |
|---|---|---|
| A Claude seat with Claude Code | Engineering manager | Running the agent |
| A GitHub account, added as a collaborator on this repository | The repository owner | Clone, pull, push |
| Azure DevOps access to `BusPlanner Unified`, `Unmanaged`, `Managed` (org `busplanner`) and a personal access token (read: code, build) | Azure DevOps admin; the token you create yourself | Code, pull requests, pipelines |
| Your own SQL login for the Unified dev and staging servers | DevOps (Dan Sukhram) | Read-only database checks |
| The CA VPN profile (`.ovpn`) | DevOps (Dan Sukhram) | Reaching the SQL servers |
| The staging QA account for BusPlanner Unified | A QA tester, by a private message, never in git | Signing in to staging |
| Jira, Confluence, Slack, Microsoft 365 | Your normal company sign-in | Connectors in Claude |

## 2. Install and clone

1. Install Git and the GitHub CLI. Sign in with **your** GitHub account: `gh auth login --web`.
2. Clone the repository. Any folder works. OneDrive is fine for the repository itself.
   ```
   git clone https://github.com/MSK-BP/QA-Agent-BusPlanner.git "QA Agent"
   cd "QA Agent"
   ```
3. Run the machine set-up. It installs Node, the Playwright browser server, .NET 8, Node 22, SSMS and OpenVPN, and activates the BusPlanner tenant:
   ```
   powershell -ExecutionPolicy Bypass -File .\harness\setup-machine.ps1 -Tenant busplanner
   ```
4. Keep large and sensitive output out of OneDrive. Product clones go to `%USERPROFILE%\Repos\<repo>`. Run output (screenshots, logs) goes to `%USERPROFILE%\Repos\qa-runs`:
   ```
   powershell -ExecutionPolicy Bypass -File .\harness\use-tenant.ps1 busplanner -RunRoot $env:USERPROFILE\Repos\qa-runs
   ```

## 3. Your own secrets (never committed)

1. Create `tenants\busplanner\Infra Creds.txt`. Git ignores it, and the agent cannot read it. The helpers read it without printing anything. Layout:
   ```
   <your Azure DevOps personal access token>

   US staging
   URL: https://...
   Email: ...
   Password: ...
   Clients: CODE1, CODE2

   CA staging
   URL: https://...
   Email: ...
   Password: ...
   Clients: CODE1, CODE2
   ```
2. Store your SQL login and passwords. The script asks for them (the password with hidden input) and keeps them in your Windows user environment:
   ```
   powershell -ExecutionPolicy Bypass -File .\tenants\busplanner\harness\set-sql-password.ps1 -Env dev
   powershell -ExecutionPolicy Bypass -File .\tenants\busplanner\harness\set-sql-password.ps1 -Env staging
   ```
3. Import the `.ovpn` into OpenVPN Connect and connect before any SQL check.

## 4. First session

1. Open Claude, Code tab, and open the `QA Agent` folder. The session start names the active tenant: `busplanner`.
2. In claude.ai settings, connect Atlassian (Jira and Confluence), Slack and Microsoft 365.
3. Ask the agent to check the set-up: "check my set-up: ADO, SQL dev and staging, Jira". It runs `ado.ps1`, `sql.ps1 -Action ping` and a Jira search, all read-only.
4. The first time the agent opens the browser, sign in to staging yourself in the Playwright window. The agent never types a password. The sign-in persists in `%LOCALAPPDATA%\qa-agent\browser-profiles\busplanner`.

## 5. How we work

- **Your data prefix:** `QA-AUTO-<your initials>-`. The agent puts it on every record it creates, so two people never collide on dev.
- **Production is blocked** by a hook for everyone. Read the hard rules in `knowledge/environments.md` before you test on any environment. Staging holds real customer data.
- **The agent asks first** before it files a ticket, posts a message or pushes. Approve each one.
- **Split the work by ticket or flow.** One person and one Claude session for each.
- **Git:** pull before you start. Commit knowledge updates and reports with a clear message. Push only what you have read.
- **Knowledge lives in the repository, not in Claude's memory.** Claude's memory is per person and per machine. If the agent learns something the team needs, it goes in `knowledge/`.

## 6. What to ask the agent

| You want | Ask |
|---|---|
| What to test for a ticket | `/test-plan ENG-1234` |
| A PR checked from a QA angle | `/pr-qa <PR link or number>` |
| Hands-on testing on dev or staging | `/explore <feature> on us-staging` |
| A bug written up | `/bug-report <what you saw>` |
| Why a pipeline failed | `/triage <run link>` |
| Is a release ready | `/release-signoff <version>` |
