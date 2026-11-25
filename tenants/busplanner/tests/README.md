# BusPlanner test cases

The QA Agent's markdown test cases for BusPlanner. The generic rules (layout, statuses, commands) are in the hub's `templates/tenant/tests/README.md`. This file holds what is BusPlanner-specific.

## Modules and ID prefixes

| Module folder | What | ID prefix | Example |
|---|---|---|---|
| `platform` | Health and smoke checks of an environment | `UNI-SMOKE-` | `UNI-SMOKE-001` |
| `ride-support` | Ride Support V1 (spec tests RS-QA-001..201, plan gap cases RS-GAP-xx) | `RS-QA-`, `RS-GAP-` (same number as the spec) | `RS-QA-012` |
| `<area>` for a current-sprint ticket, e.g. `chatbot`, `gps` | Cases for one ENG ticket | `<KEY>-<nn>` | `ENG-3071-01` |

Flows: Ride Support uses the plan's flows (`F1` to `F7`). Ticket cases use `general` unless the ticket has steps worth splitting.

## Environments and channels

Read `knowledge/environments.md` first, including the hard rules. In short:

| Channel | Tool | Where | Notes |
|---|---|---|---|
| `ui` | Playwright MCP, an isolated browser per session | dev and staging app hosts, CA and US | Loads the role's saved sign-in. **Scripted sign-in helper:** `harness\signin.ps1 -Env <env> -Role <role>` (API sign-in from the credentials file, dev and staging only, about 1 hour) |
| `api` | Reads: `harness/unified.ps1 -Action get`. Writes: `harness/api-write.ps1 -Method POST|PUT|PATCH|DELETE -Path <api path> -Body <json> -Case <case id>` | dev and staging API hosts | Writes: POST bodies carry `QA-AUTO-`; PUT, PATCH and DELETE only on records the helper created; every write goes to `<run root>\writes\ledger.jsonl`. At the end of the run: `api-write.ps1 -Env <env> -Action cleanup`. It refuses route management (BP Info), auth and password paths, and billable chatbot calls |
| `sql` | `harness/sql.ps1`, read-only | Unified dev and staging servers, over the CA VPN | Each tester uses their own SQL login (`BP_QA_SQL_LOGIN`) |
| `device` | Appium (not set up) | Turns on an Android emulator or tablet | Needs a Turns APK and a QA quick code (access A2). Device lines are Blocked until then |

**Build under test:** `GET https://<app-host>/config.json` returns `dd.env` (environment name) and `dd.version` (deployed commit).

**Never** exercise a path that writes through BP Info (GPS+ Route Management: substitute vehicle, reassign driver, bus change) without a named go-ahead for that run. Dev and staging point at production BP Info.

## Roles

| Role in a case | Identity | Status |
|---|---|---|
| `staging-qa` | The staging QA account in each tester's own credentials file | Available on CA and US staging: `harness\signin.ps1 -Env us-staging` or `-Env ca-staging` |
| Ride Support roles (`transportation-1`, `school-reviewer`, ...) | One test account per role | **Not available yet** (access A5). Cases that need them are Blocked |

## Team rules

- **Data prefix:** `QA-AUTO-<tester initials>-`. Clean-up removes it.
- **Approval:** the two testers approve each other's cases (`/review-cases approve`), not their own.
- **Split:** one tester and one Claude session per module or ticket. Pull before you start, push your cases and runs when you finish.
- **Evidence:** screenshots stay in the run folder outside git (`%USERPROFILE%\Repos\qa-runs\busplanner\runs\`). Never capture student, parent, driver or employee details.
