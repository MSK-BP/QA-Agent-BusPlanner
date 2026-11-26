# Test strategy

> Status: BusPlanner Unified filled 2026-11-10 from the repo.
>
> **Verified by execution on 2026-11-10** (commit `0137276`, .NET SDK 8.0.427, Node 22.23.4, run from a copy outside OneDrive):
> - Backend unit: `dotnet test BusPlanner.Tests.Unit` → 3,360 passed, 0 failed, 81 skipped (3,441 total), 2 min 26 s. The skips are the opt-in eval tests and the 4 `GetFlaggedMessagesQueryHandlerTests`.
> - Front end: `npm ci` ok; `npm run lint` 0 errors, 58 warnings; `npx jest --ci` 158/158 suites, 2,161/2,161 tests, about 2 min; `npm run build` ok.
> - Not yet run: integration tests (need a SQL Server the user names), chatbot evals (live, billable).
>
> Run builds from a git clone outside OneDrive (`C:\Users\skhan\Repos\<repo>`; that folder holds everything that must stay out of OneDrive), not from `repos/` here: `node_modules`, `bin` and `obj` add several hundred MB that OneDrive would sync. No written test strategy or definition of done exists in Confluence; what follows describes what is, plus the gaps. Old World suites: NOT FOUND.

## Suites (BusPlanner Unified)

Run backend commands from `repos/BusPlannerUnified/BusPlannerUnified/`, front-end commands from its `client/` folder.

| Suite | Level | Command | Needs | Runs when |
|---|---|---|---|---|
| Backend unit | unit | `dotnet test BusPlanner.Tests.Unit` | .NET SDK | every backend PR |
| Backend integration | api / db | `dotnet test BusPlanner.Tests.Integration` | SQL Server via `BP_TEST_SQL_SERVER` or `BP_TEST_SQL_CONNECTION` | developers, locally only |
| Seeded DB subset | api / db | `dotnet test BusPlanner.Tests.Integration --filter "Category=SeededDb"` | as above | locally only |
| Chatbot eval | model behaviour | manual pipeline `backend-eval.yml`, or `--filter "Category=Eval"` with opt-in | live model key, billable | on request |
| Front end | unit / component / a11y | `npx jest --ci` | Node | every front-end PR |
| Front-end lint and types | static | `npm run lint`, `npm run build` | Node | every front-end PR |
| End-to-end | ui | none exists | | |

One class or test: `--filter "FullyQualifiedName~<Class>[.<Method>]"`. Front end: Jest only discovers files under `__tests__/`. More variants: tests map section 2, front-end map section 4.

## What gates what

- **Backend PR:** API build and unit tests, minus the excluded flaky class.
- **Front-end PR:** lint, Jest, build. No coverage threshold.
- **Branch flow:** `dev` → `staging` → `main`, enforced by a vote reviewers can override.
- **AI code review:** comment-only, dev PRs, at most 2 findings.
- **Not gated anywhere:** integration tests, chatbot evals, coverage, end-to-end, post-deploy smoke, security scanning.
- Whether the PR builds are required by branch policy: UNVERIFIED, check in Azure DevOps.

## Old World release gate (from Confluence, see `process.md`)

PR into `dev` needs one QA Reviewers approval → Ready for QA → test on QA1 → QA Review → Approved for Release with rationale in QA Notes → Wednesday promotion to `stage`/QA2 → regression Thursday to Monday → Tuesday release.

## Coverage gaps

| Area | Risk | Gap |
|---|---|---|
| Whole product | high | no end-to-end or smoke automation |
| Payroll, GPS+ seeded checks | high | integration tests exist but no pipeline runs them |
| T&A timesheet and payroll export UI | high | no render tests; `TimesheetPage` is about 7,400 lines |
| Period freeze, approvals, GraphQL authorization | high | candidate defects listed in `repos/BusPlannerUnified.md` |
| ETL load failure and partial snapshots | high | no customer-wide transaction; recurring bug theme in Jira |
| GPS reader, `BPClientRegistry` | medium | no tests found |
| Time zones (T&A, GPS, stop classification) | high | silent UTC/Eastern fallbacks; recurring bug theme in Jira |
| Users, Roles, Analytics pages | medium | no render tests |

Business rules in `domain.md` are all marked "covered by: UNKNOWN". Matching them to tests is open work.

## Recurring bug themes (Jira ENG, last 180 days, sampled)

Chatbot wrong answers/timeouts/scope leak; GPS+ substitutions and timing; New World ETL data fidelity; Fleet work orders and inventory; Chipmunk, trackers and GPS readers including time-zone errors. Keys are in `domain.md`.

## Flaky, skipped and known-gap tests

| Test | State | Cause |
|---|---|---|
| `GetFlaggedMessagesQueryHandlerTests` (4 tests) | skipped, and excluded by name in CI | seeded feedback intermittently invisible; two competing explanations in the repo |
| `PayrollExportApiSeededTests.Generate_EightParallelRequests_ExactlyOneSucceeds` | trait `KnownGap`, fails intermittently | real race: parallel exports can double-freeze |
| All eval tests (`[SkippableFact]`) | skipped unless opted in | live model |
| GPS+ fixture tests | time-sensitive | seed older than 30 minutes fails verification |

Skipped is not passed: a green PR run includes a block of skipped tests. More patterns (shared database with no rollback, wall-clock use in about 50 files): tests map section 10.

## What belongs at which level here

- Unit: T&A payable and rounding rules, stop classification tiers, formatters (golden files).
- Integration: permissions and tenant scope per endpoint, payroll pipeline, period freeze.
- Component: permission-gated UI, a11y sweeps, date display in district time zone.
- End-to-end (to be built): login with org picker, clock in → approve → close period → export, GPS+ Live Viewer, chatbot ask with a gated tool.
- Eval: chatbot answer quality and decline behaviour.


## New modules before a framework exists (decided 2026-11-16)

Decided 2026-11-17 (testers and engineering manager to confirm): two tracks. Track 1, now: current-sprint work, starting with Ride Support, is tested agentically with this hub. Track 2, later: an agent-maintained Playwright/Appium/xUnit framework for stable N-1/N-2 work, started when Track 1 is stable and fed by its cases. No hard Ride Support deadline yet. Plan: `reports/2026-11-16-agentic-test-approach.md` (the new skills and agents are not built yet).

- Cases: markdown files in this tenant at `tests/<module>/<flow>/<case-id>.md` (rules in `tests/README.md`). Built 2026-11-18: `/write-cases`, `/review-cases` (a person approves), `/run-cases` (`case-runner` observes, `result-verifier` judges), `/test-module`, and `harness\cases.ps1` (validate, matrix, CSV export). First suite: `tests/suites/smoke.md`.
- Channels: browser (Playwright), API (guarded helper, to build), SQL (`harness/sql.ps1`), device (Appium MCP on an Android emulator or tablet, for Turns). All channels are agentic; no manual channel (decided 2026-11-17). Testing runs on dev; no separate test client.
- Every verdict is checked by an independent verifier agent against the evidence.
- Developers keep writing their own unit and component tests in BusPlannerUnified.
- Track 2: when Track 1 is stable, stable cases are converted into code for the BP Unified framework.

## Existing manual regression list (seen 2026-11-26)

`MASTER REGRESSION TESTING LIST.xlsx` (team spreadsheet, from the user's Downloads; owner to confirm) holds the manual regression checks the team runs per release:

| Sheet | Checks | Shape | Use for the QA Agent |
|---|---|---|---|
| Turns | 138 checks, 19 sections (set-up, inspections, T&A clock, navigation, ridership and scans, settings, permissions, device layout, app lifecycle, localization, offline) | Action and expected result per row; no priorities filled | Seed for `device` cases on the emulators; the Ride Support cases add to the ridership and offline sections |
| Chipmunk | 108 checks, 17 sections | Same | Seed for parent-app device cases |
| Delays | 92 checks, 12 sections | Same; some rows note known ENG bugs | Seed for Delays device cases |
| BP Pro, BP Web, BP Quick, BP Fleet | 29, 21, 22, 14 rows | Pass or fail per release version (12.x to 13.3), notes and linked bugs | Old World regression scope and history, for QA1 and QA2 once approved |

Minimum OS versions from the sheet: Turns iOS 13 and Android 8; Chipmunk and Delays iOS 13 and Android 5. The emulators cover Android 11 and 16 only, so add an older image if those minimums must be tested.
