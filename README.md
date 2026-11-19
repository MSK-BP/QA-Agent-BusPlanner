# QA Agent

A Claude Code workspace that works as a QA automation engineer for any software project. Open this folder in Claude (desktop Code tab or the `claude` CLI), ask for a QA job, and it does it.

The core is generic. Everything about a particular product (its knowledge, environments, production blocklist, helper scripts and reports) lives in a **tenant** under `tenants/<name>/`, which is a separate git repository. Clone the core, add a tenant, and the same agent works on a different project.

## How it is built

```
QA Agent/                          core repository
├─ CLAUDE.md                       role, routing, rules (loaded every session)
├─ .claude/
│  ├─ skills/                      the jobs (slash commands)
│  ├─ agents/                      the specialists the jobs delegate to
│  ├─ hooks/                       guardrails enforced by the harness, not the model
│  │  ├─ tenant-context.ps1        session start: names the active tenant, loads its TENANT.md
│  │  ├─ env-guard.ps1             blocks production and destructive commands
│  │  ├─ blocked-patterns.txt      generic patterns; each tenant adds its own
│  │  └─ audit-log.ps1             logs every command to the tenant's run folder
│  └─ settings.json                permissions and hook wiring
├─ .mcp.json                       Playwright browser server
├─ harness/
│  ├─ setup-machine.ps1            installs Git, Node, Playwright; runs the tenant's setup
│  ├─ new-tenant.ps1               creates a tenant from the template
│  ├─ use-tenant.ps1               switches tenant, rebuilds the browser config
│  ├─ tenant.ps1                   resolves the active tenant (used by hooks and scripts)
│  ├─ run-qa.ps1                   runs any job headlessly, for CI or a schedule
│  ├─ docx2txt.ps1                 extracts text from Word specs
│  └─ evals/                       tests of the agent itself
├─ templates/tenant/               blank tenant
└─ tenants/                        one git repository per project (ignored by the core)
   └─ <name>/
      ├─ TENANT.md                 identity and rules loaded every session
      ├─ knowledge/                domain, process, architecture, environments, strategy, repo maps
      ├─ blocked-patterns.txt      this project's production hosts, IPs, databases
      ├─ playwright.json           origins the browser must never request
      ├─ harness/                  project-specific helpers and setup
      └─ reports/                  everything the agent produces for this project
```

| Layer | Mechanism |
|---|---|
| Knowledge | Markdown in the tenant, read on demand and updated as the agent learns; live access to repos, tracker, wiki |
| Skills | One `SKILL.md` per job: a written procedure the agent follows |
| Sub-agents | Specialists with their own context; reviewers that do not see the author's reasoning |
| Harness | Hooks that block production and log commands; tenant switching; headless runner; evals |

## Tenants

```powershell
.\harness\new-tenant.ps1 acme                         # new project from the template
git clone <url> tenants\acme; .\harness\use-tenant.ps1 acme   # existing project
.\harness\use-tenant.ps1 acme                         # switch, then restart the session
```

The active tenant comes from `QA_TENANT`, else `.qa-tenant` (local, not committed), else the only folder in `tenants/`. The guard loads **every** tenant's `blocked-patterns.txt`, so switching tenant never lifts another project's production block. The agent never copies one tenant's data into another or into the core.

## Skills

| Command | Does |
|---|---|
| `/onboard-repo <path>` | Reads a repo and writes its map, suites and conventions into the tenant's `knowledge/` |
| `/learn-domain [area]` | Builds domain knowledge from the wiki and tracker, with sources |
| `/test-plan <KEY>` | Risk-based plan and cases for a ticket or feature |
| `/write-tests <plan or KEY>` | Implements the automated tests in the owning repo, then has them independently reviewed |
| `/run-suite <suite> [env]` | Runs a suite and summarises it |
| `/triage <run or test>` | Classifies each failure: product, test, environment, data, flaky |
| `/bug-report <finding>` | Reproduces, minimises, drafts, and files the ticket after approval |
| `/pr-qa <PR>` | Risk, coverage of the change, what to test before merge |
| `/explore <feature>` | Charter-based exploratory session in the running app |
| `/release-signoff <version>` | Evidence table and a go/no-go recommendation |
| `/write-cases <plan, KEY or feature>` | Writes markdown test case files in the tenant's `tests/`, reviewed by `test-reviewer`, left for a person to approve |
| `/review-cases [approve] <selector>` | Independent review of cases, or records a person's approval |
| `/run-cases <suite or selector> [env] [rehearsal]` | Runs approved cases with `case-runner`, has `result-verifier` judge each from evidence, triages failures, writes the run report and coverage matrix |
| `/test-module <module or KEY>` | The whole loop, stopping at each human gate (approval, bug filing) |
| `/meeting-harvest [since <date>]` | Pulls recorded meetings into the tenant's separate meeting knowledge base (`meetings/`: one sanitised note per meeting, plus a topic index, decision register and conflict list); runs daily from a schedule. Decisions consult it through the `meeting-researcher` agent |

## Sub-agents

| Agent | Role | Can edit |
|---|---|---|
| `code-mapper` | Traces features through code, finds untested branches | no |
| `test-designer` | Turns requirements into cases | no |
| `test-automator` | Writes tests in the repo's own framework | yes |
| `exploratory-tester` | Drives the real app by browser or API | no product code |
| `failure-triager` | Finds why a test failed | no product code |
| `test-reviewer` | Checks that tests would actually catch the bug | no |
| `case-runner` | Runs one markdown case through browser, API, SQL or device; records observations, never verdicts | result and evidence files only |
| `result-verifier` | Judges each expected line from the evidence alone: Pass, Fail, Blocked, Inconclusive | no |

## Examples

Plain requests route to the same skills as the slash commands.

```
> /onboard-repo C:\src\<product-repo>
> What should we test for PROJ-1234?
> /write-tests PROJ-1234
> Run the smoke suite on staging and tell me what broke
> Last night's pipeline is red, why?
> Explore checkout with boundary values on staging
> Are we good to ship 3.4?
```

## Browser

`.mcp.json` runs the Playwright MCP server (`@playwright/mcp`, pinned in `harness\setup-machine.ps1`) with `node.exe` directly from `%LOCALAPPDATA%\qa-agent\playwright-mcp`. It doesn't depend on `PATH` or `npx`, and `node_modules` stays out of the hub. Settings come from `.local\playwright.json`, which `use-tenant.ps1` builds: installed Chrome, headed, 1440x900, the tenant's blocked origins, and the tenant's run folder as the output folder.

Each Claude session gets its own **isolated** browser, kept in memory. Sessions never lock each other out of a shared profile, so several sessions (and several testers) can run browser cases at the same time.

Sign-ins are saved per environment and role, never typed by the agent:

```powershell
.\harness\save-signin.ps1 -Env staging -Role admin -Url https://app.example-staging.com/
```

A Chrome window opens; a person signs in; the sign-in (cookies, local storage, IndexedDB) is saved to `<run folder>\auth\<env>-<role>.json` and the window closes. A session loads it with the `browser_set_storage_state` tool, so one session can switch roles between steps. The file holds session tokens: it stays in the run folder (outside synced folders), is git-ignored, and the agent is denied reading it. Save it again when the app's session expires.

## Headless and scheduled use

```powershell
.\harness\run-qa.ps1 -Tenant acme -Job "/pr-qa 482" -Repo C:\src\<product-repo> -ReadOnly
```

Call it from a CI step on pull requests, or from Task Scheduler for a nightly regression and triage. Output lands in the tenant's run folder (`headless/`).

## Run folder

Output that is never committed (run results, headless output, screenshots, `audit.log`) goes to the tenant's run folder. By default that is `tenants/<name>/reports/`. If the hub sits in OneDrive or another synced folder, move it out: `.\harness\use-tenant.ps1 <name> -RunRoot <folder>` saves the folder in `.local\run-root` for this machine, and each tenant gets a subfolder. The `QA_RUN_ROOT` environment variable overrides it, for CI. Screenshots and logs can show real data, so keep them out of synced folders.

## Guardrails

- `env-guard.ps1` runs before every shell command and browser action. It blocks anything that matches the core patterns or any tenant's `blocked-patterns.txt`, and blocks everything if the core list is missing.
- `audit-log.ps1` records every command in `audit.log` in the tenant's run folder.
- `settings.json` denies reading credential, key and `.env` files anywhere in the hub, and denies `git push`.
- `CLAUDE.md` requires approval before filing tickets, posting messages, pushing or opening PRs.

## First-time setup

1. `powershell -ExecutionPolicy Bypass -File .\harness\setup-machine.ps1`
2. `.\harness\new-tenant.ps1 <project>`, or clone an existing tenant into `tenants\`.
3. In Claude: fill `TENANT.md`, `knowledge/environments.md` and `blocked-patterns.txt`; run `/onboard-repo` on each product repo; run `/learn-domain`.
4. Build a few eval cases (`harness/evals/README.md`) before trusting it unattended.

## Extending

- New job: add `.claude/skills/<name>/SKILL.md` and a row in the `CLAUDE.md` routing table.
- New specialist: add `.claude/agents/<name>.md`.
- New tool (database, CI, logs, test management): add an MCP server to `.mcp.json`. Project-specific settings belong in the tenant.
