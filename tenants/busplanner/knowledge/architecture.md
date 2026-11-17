# Architecture

> Status: BusPlanner Unified filled 2026-11-10 from the repo at commit `0137276` (static reading) and the Azure DevOps API. Old World and the mobile apps were mapped from code on 2026-11-17 (`repos/BusPlanner.md`, `repos/Apps.md`). Detail lives in `repos/BusPlannerUnified/*.md`.

## Systems

| System | Purpose | Where | Tech |
|---|---|---|---|
| Unified API | REST writes, GraphQL reads, auth, tenancy | `BusPlannerAPI` + Application/Domain/Infrastructure | .NET, EF Core |
| Time & Attendance | shifts, punches, pay periods, approvals, payroll export | `Modules/TimeAndAttendance` | .NET |
| Chatbot | read-only assistant with 17 fixed tools | `Modules/Chatbot` | .NET, Anthropic model |
| Web client | single-page app | `client` | React 19, Vite 7, TypeScript |
| ETL | BP Pro → object storage → Unified database | `BusPlanner.ETL` | .NET, Helm cron + worker |
| GPS reader | ingests vendor GPS events | `BPGPSReaderService` | .NET |
| GPS substitution import | imports vehicle substitutions | `BPGPSSubstitutionImportService` | .NET |
| Stop classification | classifies GPS events against planned stops | `BPStopClassificationService` | .NET |
| Client registry | catalog of clients, databases and feature flags | `BPClientRegistry`, `Client_Registry` database | SQL Server |
| Migration tool | applies schema migrations (75 so far) | `BusPlanner.MigrationTool` | .NET CLI |
| Turns, Chipmunk | driver tablet, parent app | `Managed/Apps`: `MauiTurns`, `MauiChipmunk` | .NET MAUI 10, Android and iOS; SQLite (SQLCipher) offline store; Sentry; `repos/Apps.md` |
| Old World | BP Pro, BP Web, BP Quick, Fleet, Trips, trackers, BPInfo REST | `Unmanaged/BusPlanner` monorepo: `Managed/` (.NET Framework 4.8 web, services, BPInfo REST) and `Unmanaged/` (C++ BP Pro) | `repos/BusPlanner.md`, `domain.md` |

## How a request flows

Browser → SPA (object storage behind a CDN) → API ingress → JWT validated → `client_code` claim resolves the client's database through `Client_Registry` (401 if missing or unknown) → EF global filters scope rows by `customer_access` / `department_access` → exact-match `permission` claims authorize REST endpoints → SQL Server. Reads mostly go through GraphQL, which requires only a valid token. Writes to Old World data go out through BPInfo REST.

## Data

- One SQL Server database per client, plus the `Client_Registry` catalog.
- The plan is stored as daily snapshots: a rolling window of 10 weekdays, each activated only after its load completes.
- Time: T&A shift times are local wall-clock (actual, edited, payable tiers); punches and GPS events are UTC; plan times are customer-local.
- ETL: Extract writes JSON to object storage and posts a Redis message; Load runs 8 phases with no customer-wide transaction. Students and addresses load incrementally.

## Integrations

| External | Used for | In test environments |
|---|---|---|
| BP Pro database | ETL source | restored copies on the dev SQL server |
| BPInfo REST | read/write Old World data | **dev and staging reference production BP Info URLs** |
| GPS vendors (Geotab, Samsara, Synovia, Zonar and others) | GPS events | UNVERIFIED |
| Anthropic API | chatbot | live and billable; faked only in chatbot endpoint tests |
| Datadog | logs and metrics (`config.json` carries the env name) | per environment |

## Source control and CI/CD

- Azure DevOps org `busplanner`, project `BusPlanner Unified`, one repo `BusPlannerUnified`. Branches `dev` → `staging` → `main`. No Azure Test Plans.
- 15 pipelines, defined in `pipelines/`: PR validation for backend and front end, deploys to dev (automatic on merge), staging and production (manual), service deploys (ETL, GPS reader, substitution import, stop classification), `Chatbot-Eval` (manual), `Claude-Code-Review` (AI review plus branch guard).
- Read pipelines, builds and PRs with `harness/ado.ps1 <api path>` (GET only).
- Deployment mechanism for staging and production: **kubectl** (`backend-deploy-staging.yml`, `backend-deploy-prod.yml`); the ArgoCD template and overlays exist but no pipeline uses them (read 2026-11-12).
- Each environment **rebuilds from its own branch** (`imageTag = Build.SourceVersion`); prod is manual on `main`. Images and the FE bundle are env-agnostic (config injected at deploy).
- FE staging/prod region default is `us`, BE default is `canada`. Service pipelines (GPS reader, substitution import, stop classification) deploy any branch to the chosen env on a manual run.
- Cadence (ADO, 2026-11-12): ~20 PRs/week into `dev`; prod deployed Sep 17, Oct 9, Oct 21; 70 dev merges unreleased since Oct 22. One feature PR merged straight into `main` on 2026-11-03 (ENG-2963). Unified `dev` has no QA required-reviewer policy.
- Branching proposal for the GitHub move: `reports/2026-11-12-branching-strategy.md`.

## Infrastructure

IBM Cloud Kubernetes in two separate accounts (CA in Toronto, US in us-east), object storage for the SPA and ETL files, IBM Secrets Manager, Terraform in `infra/`. AWS provides DNS, CDN and certificates. CA staging runs in the CA dev cluster. Environment table: `environments.md`.

## Observability

Datadog. Health endpoints `/health` and `/health/ready` on the API; `/config.json` on the SPA shows environment and deployed commit. How QA gets log access: TODO.
