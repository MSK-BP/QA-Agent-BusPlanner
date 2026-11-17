# Access register

> Checked 2026-11-16 with the agent's own tokens and connectors. Updated 2026-11-17: code access to all three Azure DevOps projects was granted to the user (QA tester) and two team members. There is no QA lead: the QA team is two testers plus the engineering manager. Read-only checks only: no invite accepted, no account created, no access requested. Secret values were not read or printed.

## Verdict

Since 2026-11-17 the agent can read all product code: BusPlanner Unified, Old World (`Unmanaged/BusPlanner`) and the mobile apps (`Managed/Apps`), plus their pipelines. It still cannot get a Turns test build on a device, test accounts, Datadog or the team chat channels (list at the end).

## What the agent can reach now

| System | Access | How | What it gives |
|---|---|---|---|
| Azure DevOps org `busplanner` | Read, **three projects** (2026-11-17) | PAT via `harness/ado.ps1 -Project <name>` (GET only) | `BusPlanner Unified`: repo `BusPlannerUnified`, 15 pipelines, 9 variable groups. `Unmanaged`: repo `BusPlanner` (Old World, 1.8 GB), active pipelines `BusPlanner-Build`, `BusPlanner-Release`, `PR-Review`, `dev-branch-tracker`, `fleet-dev-branch-tracker`, one test plan `Fleet Test Plan`. `Managed`: repos `Apps`, `QA_Automation`, `BPFinanceContracts`, active pipelines `Turns-Android`, `Apps_Test`, `QA_Automation`. The org-level profile and account list return 401 |
| Git clones (read-only) | `C:\src\BusPlannerUnified`, `C:\src\BusPlanner` (shallow, `--depth 1`, `main`; a blobless clone stalled on Azure DevOps), `C:\src\Apps` (`dev`), `C:\src\QA_Automation` | `harness/git-ado.ps1` (passes the token per process; refuses `push`) | Clones are outside OneDrive on purpose. Refresh with `harness/git-ado.ps1 -C C:\src\<repo> fetch --prune`. `repos/BusPlannerUnified` here is the old 2026-11-10 snapshot that the knowledge files cite; `main` is still at that commit, `dev` is 94 commits ahead |
| GitHub | No BusPlanner product repos | `gh` CLI: accounts `MSK100` (personal) and `MSK-BP` (work), scopes `repo`, `read:org`, `workflow` | `MSK-BP` belongs to no organisation and owns only `QA-Agent-BusPlanner`. No BusPlanner org exists for this account yet (see the GitHub move in `architecture.md`) |
| Jira | Read | Atlassian connector | ENG, PROD, IN, SPT, SOC, MDP (see `jira.md`) |
| Confluence | Read | Atlassian connector | Space PE and others (see `confluence.md`, `confluence-prd.md`) |
| Slack | 2 channels joined (`#all-busplanner`, `#social`); public-channel search works | Slack connector | A search for repo locations found nothing |
| Microsoft 365 | Mail, calendar, OneDrive/SharePoint read, Teams chats and channel messages | M365 connector (scopes include `Mail.Read`, `Files.Read.All`, `Sites.Read.All`, `ChannelMessage.Read.All`) | Member of **no Teams team**. SharePoint holds no product source code |
| BP Unified SQL, dev and staging (CA) | Read-only queries | `harness/sql.ps1` over the CA VPN; the user sets the passwords | See `environments.md`. The login is sysadmin on both servers, so read-only depends on the helper. US staging databases are not on these servers |
| BP Unified dev and staging (CA, US) | Browser and API | `harness/unified.ps1`, Playwright profile | See `environments.md` |
| Local tools | Installed | — | git 2.56, .NET SDK 10.0.404, Node, Python 3.15, GitHub CLI, Chrome. No Java, no Android SDK or `adb`, so no Android build or emulator |

## Facts learned during the check

- The Azure DevOps token can read the **production** variable groups (`busplanner-prod-infra`, `busplanner-prod-us-infra`). Secret values are masked; host and bucket names are not. All production names found already match the guard (the core `prod-` pattern or `blocked-patterns.txt`). Raise with the team: a QA read token does not need production group access.
- Variable groups: `{dev,staging,prod}-infra` (CA), `{dev,staging,prod}-us-infra`, `dev-secrets`, `dev-us-secrets`, `chatbot-eval-secrets`. No `staging-secrets` or `prod-secrets` group is visible, so those secrets live somewhere else (UNVERIFIED: IBM Secrets Manager).
- Pending invites in the mailbox: Azure DevOps (2026-11-09, org `BusPlanner`) and Atlassian (2026-11-09, 2026-11-10). The tokens already work, so these look accepted. Nothing else is waiting.

## Security findings from the code (2026-11-17)

Raise these with the owners. Never copy the values.

- `Managed/QA_Automation`: a test login (user name and password) for the Old World QA2 site is committed in `data/testData.json`, in 30 commits of history.
- `Managed/Apps`: test credentials in `AppTests/Constants.cs` and `BPInfoServiceClientDemoFixture.cs`; some test names carry a password, so it shows in the `Apps_Test` results. The Android keystore and its password are in the repo (`Turns/Turns.csproj`).
- `Apps_Test` calls customer production trackers (`tracker*.mybusplanner.*`) from CI. These hosts are now in `blocked-patterns.txt`.

## What needs a team member

| # | Need | Why | Ask |
|---|---|---|---|
| ~~A1~~ | Read access to the Apps repo | Done 2026-11-17 | Map: `repos/Apps.md` |
| A2 | A Turns test build (APK), a QA quick code that maps to a dev or staging client, and a test tablet or emulator; Sentry read access (App Center is retired) | Device tests for F3 and F4b. The `Turns-Android` pipeline shows no artifacts, and it builds the wrong framework (`repos/Apps.md`) | Apps owner |
| ~~A3~~ | Old World code | Done 2026-11-17: one repo, `Unmanaged/BusPlanner` | Map: `repos/BusPlanner.md` |
| A4 | QA1 and QA2 hosts for Old World, and approval to test there | QA2 for client 1230 is `1230webqa2.busplannerweb.com` (from `QA_Automation`). QA1 and the other clients are not known. Not yet approved in `environments.md` | Engineering lead, then the user |
| A5 | Test accounts for dev and staging, one per Ride Support role | Role tests in F1 and F2 | Product or DevOps |
| A6 | Datadog read access | Logs for triage | DevOps |
| A7 | Slack channels for engineering, QA and releases; a Teams team if one is used | The agent sees only 2 general channels | Any member can add the user |
