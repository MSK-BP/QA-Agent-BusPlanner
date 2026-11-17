# Meeting knowledge base

What people said, decided, worried about and planned in recorded meetings. Written by `/meeting-harvest`; not approved knowledge. Consult it with `knowledge/` before a decision (see CLAUDE.md, "Two knowledge bases").

Last harvest: 2026-11-17T20:28:38Z (`state.json` `last_run`), 9 meetings in total (5 qa-core, 4 qa-context).

## Differs from knowledge base

Items where a meeting contradicts, updates or answers `knowledge/`. A decision on one of these areas must name the difference.

| Date | Area | Meeting says | Knowledge base says (file) | Note |
|---|---|---|---|---|
| 2026-11-17 | Stop boundaries | PGCPS boundary polygons override walk rules, must not overlap, start as a 0.5-mile hazard-constrained area, editable; a Comprehensive Stops layer comes first | "Custom stop boundaries with lasso-to-assign students on the map" (To Do) (`jira/other-projects.md`) | [updates](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) |
| 2026-11-16 | Old World SaaS migration | STEO cutover moved from 2026-11-21 to the week of 2026-12-07 | IN-203 "server downsized, must be resized for SaaS move", no date (`jira/other-projects.md`) | [updates](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) |
| 2026-11-16 | Release and branching | Unified flow: feature → `dev` (all functional QA) → whole `dev` promoted to stage for regression → `main`, same as the Old World | "The Unified promote/release schedule is not documented in these sources." (`process.md`) | [answers](notes/2026/2026-11-16-etl-workflows-203613040.md) (flow only, no weekly schedule) |
| 2026-11-16 | Release and branching | No testing in production after a release; the deploying developer does basic checks only | "Run the health check in prod, where the customer will look." (`process.md`) | [contradicts in part](notes/2026/2026-11-16-etl-workflows-203613040.md) (process.md rule is for new-customer stand-up) |
| 2026-11-16 | Release and branching | Move from Azure DevOps to GitHub in about a month; branching first, then pipelines deploying to several QA environments | "Branching proposal for the GitHub move" with no date (`architecture.md`) | [updates](notes/2026/2026-11-16-etl-workflows-203613040.md) (tentative) |
| 2026-11-16 | Environments and access | Unified dev app accounts (US dev, CA dev) were created for QA; credential shared out of band | "Dev accounts: none provided yet." (`environments.md`) | [contradicts](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-16 | Environments and access | Large client Old World databases are restored onto QA1 for tests, then deleted | QA1 hosts TODO; no mention of customer data on QA1 (`environments.md`) | [updates](notes/2026/2026-11-16-etl-workflows-203613040.md): QA1 can hold real customer data |
| 2026-11-16 | Environments and access | QA1/QA2 reached by RDP through the office machine, or directly over VPN | "Old World QA1/QA2 URLs were NOT FOUND in any source." (`environments.md`) | [updates](notes/2026/2026-11-16-etl-workflows-203613040.md) (route only, no hosts) |
| 2026-11-16 | ETL | Snapshots for "today plus nine/10 days" | "a rolling window of 10 weekdays" (`architecture.md`, `domain.md`, code) | [contradicts](notes/2026/2026-11-16-etl-workflows-203613040.md); code wins until the ETL owner confirms |
| 2026-11-16 | GPS readers | GPS readers and substitution import run as one pod each in the cluster | Runbook says the GPS Reader is Windows-only on a VM; where it runs "is not determinable from the repo" (`repos/BusPlannerUnified/data-services.md`) | [answers](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-13 | ETL | ETL Extract picks the latest-effective vehicle mapping, which is wrong with future-dated assignments; fix owner Shikhar Patel, no ticket key | Absent from known gaps and defects (`test-strategy.md`) | [new defect](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS+ Path & Stop Compare | ENG-3136 (Landmark): inverted door signals on about half the buses; New World path differs from BP Pro | No file names ENG-3136 | [updates](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS readers | Geotab AUX settings were copied once from the Old World server and are not synced | Absent | [updates](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | Ride Support (Discipline) | 2026-12-18 is a happy-path **dev-complete** target; client delivery early January | "Core flows must be built and pass QA by **2026-12-18**" (`domain.md`, Discipline row) | [contradicts](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | Ride Support (Discipline) | Same firm 2026-12-18 target, with delivery risk if missed | "No hard Ride Support deadline yet." (`test-strategy.md`) | [contradicts](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-11 | Auth | Session lifetime: interim 1 h → 12 h ticket, then a refresh-token ticket; via the normal release | "Auth as built": "60 minutes plus 5 minutes clock skew … Refresh tokens are a proposal." (`domain.md`) | [updates](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) (planned, not built) |
| 2026-11-11 | GPS+ Path & Stop Compare | ENG-2788: hide waypoints and turnarounds in Compare **and Live Viewer**; configurable later | "Stop Compare must exclude stop types Turnaround Point and Way Point entirely" (`jira/eng-2401-2800.md`) | [updates](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |

No production host, IP or database was named in a harvested meeting.

## Decision register

Newest first. Superseded decisions stay, marked.

| Date | Area | Decision | Owner | Status | Note |
|---|---|---|---|---|---|
| 2026-11-16 | Old World SaaS migration | STEO "File Checker" script migrated as-is, not rewritten; runs on its existing server and feeds SaaS | BusPlanner implementation | decided | [note](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) |
| 2026-11-16 | Old World SaaS migration | STEO SaaS built in parallel; customer planners validate before cutover; old server kept as rollback | BusPlanner implementation | decided | [note](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) |
| 2026-11-13 | QA process and priorities | QA focus: Discipline and ETL in parallel; ETL gives way if Discipline is at risk | Tommy Zwirblia | decided | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | QA process and priorities | Old World tested only as needed for ETL and New World correctness; no broad coverage now | Tommy Zwirblia, Andy Tompkins | decided | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | QA process and priorities | Agentic QA (not a conventional framework) for the Discipline module; progress reported daily | Sharaiz Khan, Tommy Zwirblia | decided | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | GPS+ Route Management | Three new BP Info APIs: affected records on save, routes without a GPS vehicle, operator-provider mapping; to QA1 | Mitchell Bland | decided | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS+ Route Management | Client-side diff of affected routes rejected (concurrency, large unpaged data) | Mitchell Bland, Michel Walther | decided | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS+ Route Management | Vehicles filtered by operator, not by platform or depot | Mitchell Bland | decided | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | Eligibility | CCSD: finish the current full run, analyse the process against the change-only model, then agree a new process | BusPlanner engineering | decided | [note](notes/2026/2026-11-13-ccsd-eligibility-path-forward-203086298.md) |
| 2026-11-12 | QA process and priorities | QA order: ETL, syncs, chatbot, products | Tommy Zwirblia | stated; superseded by 2026-11-13 | [note](notes/2026/2026-11-12-qa-onboarding-202544284.md) |
| 2026-11-12 | QA process and priorities | Agentic development: the new developer builds the notification engine end to end first; developers "switch", not transition | Tommy Zwirblia | decided | [note](notes/2026/2026-11-12-qa-onboarding-202544284.md) |
| 2026-11-11 | GPS+ Route Management | All HRCE tickets set to Highest priority | Nikki Tilano | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | Auth | Session timeout 1 h → 12 h now (normal release), refresh tokens in a second ticket later | Andy Tompkins | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | GPS+ Path & Stop Compare | ENG-2788: hide waypoints and turnarounds now | Tommy Zwirblia | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | GPS+ Route Management | Vehicle assignment page mimics the old GPS+ page; writes go to the Old World through BP Info, return through the substitution import | Andy Tompkins | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | GPS+ Route Management | A vehicle-to-run assignment moves the run onto the destination vehicle's route (new route if it has none) | Andy Tompkins | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | Release and branching | HRCE fixes ship in several promotes; customer date only after design and QA scope are known | Andy Tompkins | decided | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |

## Open questions

| Raised | Area | Question | Status | Note |
|---|---|---|---|---|
| 2026-11-17 | Stop boundaries | Which product gets the boundary feature: BP Pro, BP Web or BP Unified? | open | [note](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) |
| 2026-11-17 | Stop boundaries | What happens to a student inside a boundary whose stop is retired or moved? | open | [note](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) |
| 2026-11-16 | ETL | Snapshot window: "today plus nine/10 days" or 10 weekdays? | open | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-16 | Release and branching | Will the GitHub move change how QA gates merges into `dev`? | open | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-16 | Release and branching | Which flag model (none, product, per-client) will the new branching strategy use? | open | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-13 | Ride Support (Discipline) | Is 2026-12-18 a dev-complete target or a "passed QA" deadline? | open | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | Mobile apps | Which physical mobile devices exist for testing? | open | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | ETL | Does the ETL Extract fix need a regression test for a run with three or four split mappings? | open | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS+ Path & Stop Compare | What time window does the New World Path Compare use compared with BP Pro? | open | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS readers | ENG-3136 door inversion: wiring fault or a Geotab setting read wrong? | open | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | Eligibility | Is a full-student eligibility run a supported scenario QA must load-test? | open | [note](notes/2026/2026-11-13-ccsd-eligibility-path-forward-203086298.md) |
| 2026-11-12 | Environments and access | Which hosts and data will the paired QA environment use; does it replace QA1/QA2 or dev? | open | [note](notes/2026/2026-11-12-qa-onboarding-202544284.md) |
| 2026-11-12 | QA process and priorities | When can developers other than the builder use the agentic development process? | open | [note](notes/2026/2026-11-12-qa-onboarding-202544284.md) |
| 2026-11-11 | GPS+ Route Management | Does moving a run to the vehicle's route change what reports and other pages show as the run's route? | open | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | Auth | Does the 12-hour change cover the Unified JWT only, or also BP Info tokens? | open | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | GPS+ Route Management | Which assignment functions belong to GPS+ and which to Dispatch? | open | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | GPS+ Route Management | Which BP Quick functions (vehicles, drivers) must move to the New World, and when? | open | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |
| 2026-11-11 | BP Info | Does BP Info support run-level assignment changes? | open (2026-11-13 added three APIs; run-level not confirmed) | [note](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) |

## Topics

### GPS+ Live Viewer

- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · HRCE blockers: stop descriptions (ENG-2789), status sort (ENG-2880), hidden waypoints

### GPS+ Path & Stop Compare

- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · ENG-3136 Landmark: inverted door signals, path not driven in BP Pro
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · ENG-2788 hide waypoints; SPT-924, SPT-841 raised to Highest

### GPS+ Route Management

- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · HRCE GPS+ release planned for the next week, without the vehicle manager
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Three new BP Info APIs for the vehicle assignment page; split dated mappings
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Vehicle assignment page design; run-level rule; overlap with Dispatch left open

### BP Info

- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · New APIs; operator-provider pairing not exposed today
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Assignment writes to the Old World through BP Info

### GPS readers

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Unified reader replaces Old World readers; single pod, no multi-pod logic
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Geotab AUX ports and signal inversion; settings not synced

### ETL

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Extract and Load flow, snapshots, no written table mapping, unit tests exist
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · ETL as the QA fill-in track (chatbot QA pipeline)
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Extract mapping defect with future-dated assignments
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · ETL knowledge transfer; ETL runs against a restored BP Pro copy

### Ride Support (Discipline)

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Spans web, driver tablet and Chipmunk; very early stage
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Dev-complete target 2026-12-18; agentic QA; meaning of the date left open
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Requested by New Caney; walkthrough moved

### Auth

- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Session 1 h → 12 h interim, refresh tokens later

### Environments and access

- 2026-11-16 · [STEO SaaS implementation](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) · Parallel SaaS environment with rollback
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Dev app accounts for QA; QA1/QA2 by RDP or VPN; customer databases on QA1
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Paired Old World + New World QA environment planned

### Release and branching

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · All QA on `dev`; revert vs cherry-pick bottleneck; feature-flag debate; GitHub move
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · HRCE GPS+ release, items waiting on a dev deployment
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Several promotes for HRCE; 12-hour change via normal release

### QA process and priorities

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · QA cannot keep up with merges; test ETL ticket by ticket
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Discipline + ETL in parallel; Old World only as needed; estimate QA at PRD time
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Agentic "switch"; earlier priority order (superseded)

### Mobile apps

- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Developers test apps on emulators; physical devices unknown

### Notifications and two-way sync

- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Two-way sync engine planned
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Notification engine is the first agentic build and starts two-way sync

### Ontario Ministry reports

- 2026-11-12 · [Ontario Ministry reports training](notes/2026/2026-11-12-ontario-ministry-reports-training-202654264.md) · Importers, extended properties, BIN location, common report errors

### Eligibility

- 2026-11-13 · [CCSD eligibility path forward](notes/2026/2026-11-13-ccsd-eligibility-path-forward-203086298.md) · Full-student run is the main suspect for slow calculation

### Stop boundaries

- 2026-11-17 · [PGCPS support check-in](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) · Boundary polygon requirements; Comprehensive Stops layer first

### Old World SaaS migration

- 2026-11-16 · [STEO SaaS implementation](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) · Cutover moved to the week of 2026-12-07; File Checker migrated as-is
