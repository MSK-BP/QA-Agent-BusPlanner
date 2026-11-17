# Repo map: BusPlannerUnified

> Built 2026-11-10 from `main` at commit `013727603301a83a71434a865ba147a199d795e6` by static reading. Nothing was built or run on this machine (`dotnet`, `node` and `git` are not installed), so every command here is as documented in the repo, UNVERIFIED by execution.
>
> Local snapshot: `repos/BusPlannerUnified/` (a zip download, not a git clone). The .NET solution is in the inner `BusPlannerUnified/` folder.
> Azure DevOps: org `busplanner`, project `BusPlanner Unified`. Read-only API access: `harness/ado.ps1`.

## What it is

BusPlanner Unified ("New World"): a multi-tenant web platform that sits beside the legacy BusPlanner products ("Old World") and reads and writes their data through BP Info. See `knowledge/domain.md` for the product picture.

## Detailed maps (read only the one you need)

| Area | File | Read it for |
|---|---|---|
| API, domain, auth, tenancy, Time & Attendance | `BusPlannerUnified/backend-core.md` | endpoints, permissions, T&A business rules, payable/rounding, freeze rules |
| Chatbot and GPS+ analytics | `BusPlannerUnified/chatbot.md` | tool catalogue, gates, eval harness, QA script template |
| ETL, GPS reader, substitution import, stop classification, database | `BusPlannerUnified/data-services.md` | data flow, snapshots, schema, classification thresholds |
| React client | `BusPlannerUnified/frontend.md` | screens, Jest setup and conventions, coverage gaps, locators |
| Tests, pipelines, environments, infrastructure | `BusPlannerUnified/tests-ci-infra.md` | exact commands, PR gates, environment table, production identifiers, flaky list |

## Stack in one screen

- **Backend:** .NET, layered (`BusPlannerAPI`, `BusPlanner.Application`, `BusPlanner.Domain`, `BusPlanner.Infrastructure`) plus `Modules/TimeAndAttendance` and `Modules/Chatbot`. REST for writes, GraphQL for reads. EF Core on SQL Server.
- **Tenancy:** one SQL Server database per client. The JWT `client_code` claim selects the database through the `Client_Registry` catalog; there is no default database. Inside a database, rows are scoped by `customer_access` / `department_access` claims. Permissions are exact-match strings.
- **Front end:** React 19, Vite 7, TypeScript, Apollo GraphQL for reads, axios for writes. No UI component library.
- **Services:** `BusPlanner.ETL` (Extract from BP Pro to object storage, Load in 8 phases into daily plan snapshots), `BPGPSReaderService`, `BPGPSSubstitutionImportService`, `BPStopClassificationService`, `BPClientRegistry`, `BusPlanner.MigrationTool`.
- **Cloud:** IBM Cloud Kubernetes (separate CA and US accounts) with an AWS edge (Route 53, CloudFront). Deployed by Azure DevOps pipelines.

## Tests that exist

| Suite | Tech | Size | Runs in CI |
|---|---|---|---|
| Backend unit | xUnit, Moq, FluentAssertions | about 246 files | yes, on backend PRs |
| Backend integration | xUnit, WebApplicationFactory, real SQL Server | about 73 files | **no pipeline** |
| Chatbot eval | live model, 3 runs / 2 passes | see chatbot map | manual pipeline only |
| Front-end unit/component | Jest, React Testing Library, jest-axe | about 158 files | yes, on front-end PRs |
| End-to-end / browser | none | 0 | no |
| Manual scripts | Markdown in `docs/qa` and `docs/testing` | about 55 documents | n/a |

## Biggest gaps (where QA automation adds most)

1. No end-to-end or browser automation at all, and no post-deploy smoke test.
2. Integration tests are not run by any pipeline.
3. Front end: `TimesheetPage` (about 7,400 lines), Payroll Export, most T&A admin pages, Users, Roles and Analytics have no render tests.
4. No tests found for the GPS reader or `BPClientRegistry`.
5. No coverage measurement anywhere.
6. Production code has no `data-testid`; accessible roles and labels are weak on T&A and admin pages, which will slow UI automation there.

## Candidate defects found while reading (static, UNVERIFIED)

Each needs reproducing on a test environment before it is reported. Details and `file:line` are in `backend-core.md` section 8.

- GraphQL reads need only a valid token, with almost no per-permission gating; `includeDeleted:true` drops tenant scope on most T&A lists.
- Validators are not run automatically; `CreateShiftCommandValidator` is never invoked.
- Period freeze is enforced unevenly: supervisor `POST api/ta/shifts` has no check; mobile clock paths check only the linked period.
- Bulk approve skips the step-permission check that single approve enforces.
- Filtered payroll exports do not mark the period EXPORTED, contrary to the spec.
- Parallel payroll exports can double-freeze (already documented in the repo as a `KnownGap` test).
- A missing customer time zone silently falls back to UTC (backend) or UTC/Eastern (data services).

## Housekeeping findings to raise with the team

- Credentials are committed in plain text: a SQL connection string in `DEV_SETUP_T&A.txt`, a login password in `docs/qa/Chatbot-FeatureFlags-E2-3-QA-Guide.md`, an AWS access key ID in `docs/infra/deploy-progress.md`, and seeded account passwords in several docs. None are copied into this knowledge base.
- Stale docs: `docs/testing/FrontendTests.md` (before its accessibility section), the ETL spec, `CreateDatabase.md`, `SetupGPSDownload.md`, parts of `README.md`.

## The repo's own agent rules

The repo ships `CLAUDE.md` files and a `.claude` folder. When working inside it, its test-project rule applies: report every change under `BusPlanner.Tests.Integration` with the file list, never set a SQL server value yourself, and never report a suite as passing if it was not run.
