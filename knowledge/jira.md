# Jira: structure, work in flight and QA conventions

> Read 2026-11-10 from `busplanner.atlassian.net` (read-only). Complements `process.md` (workflow, people) and `domain.md` (high-risk areas); facts already there are not repeated.
> How to trust this file: counts and tables come from a complete summary-level pull of every ENG issue (2,879). Ticket bodies were read for 80 issues only. See "Read coverage" at the end. Customers appear only as their short codes.

## A. Projects

All six projects have the same lead in Jira: Tommy Zwirblia. Only ENG has components, fix versions and sprints.

| Key | Name | Type / board | Issues | Issue types | Statuses | Purpose |
|---|---|---|---|---|---|---|
| ENG | Development | Software; "Dev board" (scrum, id 68) | 2,879 | Epic, Story, Task, Sub-task, Bug, Bug - ENG, Dev Question, Workflow, Feature, Product | Work items: Open, Reopened, Investigation, In Progress, Blocked, Code Review, Ready for QA, QA Review, Approved for Release, Resolved, RELEASED. Epics: Open, Ready for Development, In Progress, On Hold, In QA, QA Approved, Resolved. Dev Question: Open, Reopened, Investigation, Resolved | All engineering work |
| PROD | Product Management | Software; "PROD board" (kanban, 134) | 842 | Feature Request (616), Feature (66), Epic (28), Capability / Product / Task / Story (133 together) | Backlog, To Do, Gathering Requirements, Scheduled, Ready for Development, In Progress, User Acceptance Testing, Approved for Release, On Hold, Declined, Done | Requirements. ENG epics hang under PROD Features; client asks are Feature Requests |
| SPT | Support Queue | Software; "SPT board" (kanban, 101) | 118 (72 not done) | Bug, Dev Question, Workflow | Backlog, Ready for Development, In Progress, On Hold, Done | Intake from CX/support; tickets are moved into ENG after triage (they then carry the `jira_escalated` label) |
| IN | Infrastructure | Software; "IN board" (kanban, 167) | 234 | Epic, Story, Task, Sub-task, Bug | Backlog, In Progress, On Hold, Done | DevOps and incidents. 6 epics: IN-10 / IN-16 server resizes (stage 1, 2); IN-11 / IN-29 / IN-30 Datadog agent rollout (stages 1-3); IN-136 post-school-opening server updates |
| SOC | BusPlanner SOC2 | Team-managed; "SOC board" (35) | 71 (last update 2026-09-15) | Task, Epic, Subtask | To Do, In Progress, Done | SOC 2 compliance tasks. No epics exist. Content not read |
| MDP | My discovery project | Jira Product Discovery | 6 (last update 2026-06-18) | Idea | Parking lot, Discovery, Impact, Ready for delivery, Delivery, Done | Sandbox; ignore |

ENG was created on 2026-05-13 (first key ENG-3), so "last 180 days" is in practice the whole project. Older history lives in Azure DevOps (many epics cite a "DevOps Ticket" or "DevOps ID").

### ENG components (12; 2,745 of 2,873 issues have none)

| Component | Issues | Note |
|---|---|---|
| MVP - GPS+ Live Viewer | 41 | "Must make the end-of-July deadline for New World GPS+" |
| MVP - Time and Attendance | 13 | |
| BP Unified Dispatch - Wave 1 ... Wave 8 | 6, 14, 14, 7, 6, 8, 6, 4 | Delivery waves of Unified Dispatch |
| Chipmunk-Robustness / Chipmunk-Tracker | 9 / 1 | |

Components are a planning tag for three programmes, not a product taxonomy. To find a ticket's product area use its **parent epic** (see B).

### ENG fix versions (50 in total; all listed)

Unreleased: `13.4.3 - BusPlanner Main - Hotfix`, `13.4.4- BusPlanner Main`, `13.4.5 - BusPlanner Main` (empty), `12.4.15 - Miami Fleet`, `11.2026 - New World`, `2.8.10.2026 - New World` (dated 2026-10-08, still unreleased), `T&A - Yankton` (go-live marker).

| Train | Released versions (release date) |
|---|---|
| BusPlanner Main 13.4 | 13.4.0 (Oct 29), 13.4.1 Hotfix "Ministry Report Hotfix" (Nov 4), 13.4.2 Hotfix (Nov 6) |
| BusPlanner Main 13.3 | 13.3.0 (Oct 1), 13.3.1 (Oct 15), 13.3.2 Hotfix (Oct 23) |
| BusPlanner Main 13.2 | 13.2.0 Hotfix (Aug 28), 13.2.1 (Sep 1), 13.2.2 Hotfix (Sep 2), 13.2.3 Hotfix (Sep 3), 13.2.4 Hotfix (Sep 11), 13.2.5 (Sep 16), 13.2.6 Hotfix (Sep 21), 13.2.7 Hotfix (Sep 28) |
| BusPlanner Main 13.1 | 13.1.5 (Jun 23), 13.1.6 (Jun 25), 13.1.7 Hotfix (Jul 3), 13.1.8 (Jul 9), 13.1.9 (Jul 21), 13.1.10 Hotfix (Jul 23), 13.1.11 Hotfix (Jul 29), 13.1.12 (Aug 5), 13.1.13 Hotfix (Aug 12), 13.1.14 (Aug 18), 13.1.15 Hotfix (Aug 20) |
| Miami Fleet 12.4 | 12.4.4 (Jun 18), 12.4.5 (Jun 29), 12.4.6 Hotfix (Jul 3), 12.4.7 (Jul 16), 12.4.8 (Jul 28), 12.4.9 (Aug 12), 12.4.10 (Aug 25), 12.4.11 (Sep 9), 12.4.12 (Sep 22), 12.4.13 (Oct 6), 12.4.14 (Nov 6) |
| Mobile | Chipmunk 2.11.3 (Jul 13), 2.12.0 (Aug 21), 2.12.1 (Aug 25); Turns 2.9.20 (Jul 13), 2.10.20 (Aug 6); Delays 2.4.8 (Jul 13), 2.4.9 (Sep 2) |

14 of the 25 released Main versions are hotfixes. 2,384 of 2,873 issues have no fix version, so a missing fix version says nothing about whether something shipped.

### Sprints (Dev board, two weeks)

| Sprint | Dates | State |
|---|---|---|
| ENG Sprint 81 - 90 | Jun 13 - Oct 30 (81: Jun 13-27; 82: Jun 27-Jul 11; 83: Jul 13-25; 84: Jul 27-Aug 10; 85: Aug 10-22; 86: Aug 24-Sep 5; 87: Sep 8-18; 88: Sep 21-Oct 3; 89: Oct 3-16; 90: Oct 16-30) | closed |
| **ENG Sprint 91** | Oct 31 - Nov 13 | **active** |
| ENG Sprint 92 - 96 | Nov 13 - Jan 22, 2027 (two weeks each) | future |

Only Sprint 83 has a goal recorded. A "Test Sprint" (May 22-30) also exists.

## B. Epics

### How epics are organised

- Every product has standing **bucket epics**: `<Product>: Production Bugs` (client-reported), `<Product>: QA Bugs` (found internally), `<Product>: General Tasks`, `<Product>: Client Requests`. Most "QA Bugs" buckets are empty or nearly so; in practice QA-found bugs also land in the Production bucket or in a programme bucket (ENG-2917, ENG-2205, ENG-873, ENG-2646).
- Feature epics sit under a PROD Feature (for example the ten Chatbot v1 epics ENG-1868..1877 under PROD-897). Recent client requests get one epic each named `[<customer code>] <product>: <ask>`.
- Epic statuses to watch: **In QA** (9) and **QA Approved** (8). 103 epics are Open, 36 In Progress, 18 Resolved, 8 Ready for Development, 2 On Hold.
- 369 ENG issues have no parent at all (264 of them bugs).

### ENG epics (all 184)

"Children" counts ENG issues whose parent is the epic; "open" excludes Resolved, RELEASED, Approved for Release and QA Approved. Purpose is the first sentence of the epic description where one exists, otherwise derived from the name.

| Key | Name | Status | Children (all / open) | PROD parent | Purpose |
|---|---|---|---|---|---|
| ENG-3 | T&A Core: Employee & Payroll Setup - BP Unified | In QA | 10 / 4 | PROD-858 | T&A core: employee and payroll setup |
| ENG-6 | T&A Core: Cleanup and Finalization - BP Unified | On Hold | 5 / 2 | PROD-858 | T&A core: cleanup and finalisation |
| ENG-12 | Time & Attendance Mobile | Resolved | 6 / 0 | PROD-860 | Mobile app for T&A clock-in/out (design and PRD linked) |
| ENG-46 | GPS / GPS+ Production Bugs | Open | 74 / 31 | PROD-916 | Bucket: client-reported bugs for GPS / GPS+ |
| ENG-47 | GPS / GPS+ QA Bugs | Resolved | 2 / 0 | PROD-916 | Bucket: internally found (QA) bugs for GPS / GPS+ |
| ENG-48 | GPS / GPS+: General Tasks | Open | 7 / 3 | PROD-916 | Bucket: general tasks for GPS / GPS+ |
| ENG-50 | Dispatch: Production Bugs | Open | 41 / 17 | PROD-905 | Bucket: client-reported bugs for Dispatch |
| ENG-51 | Dispatch: QA Bugs | Open | 0 / 0 | PROD-905 | Bucket: internally found (QA) bugs for Dispatch |
| ENG-52 | Dispatch: General Tasks | Open | 1 / 0 | PROD-905 | Bucket: general tasks for Dispatch |
| ENG-56 | Chipmunk - Tracker Production Bugs | Open | 72 / 25 | PROD-894 | Bucket: client-reported bugs for Chipmunk - Tracker |
| ENG-57 | Chipmunk - Tracker QA Bugs | Open | 0 / 0 | PROD-894 | Bucket: internally found (QA) bugs for Chipmunk - Tracker |
| ENG-58 | Chipmunk - Tracker: General Tasks | Resolved | 9 / 0 | PROD-894 | Bucket: general tasks for Chipmunk - Tracker |
| ENG-62 | Delays App: Production Bugs | Open | 9 / 4 | PROD-892 | Bucket: client-reported bugs for Delays App |
| ENG-63 | Delays App: QA Bugs | Open | 0 / 0 | PROD-892 | Bucket: internally found (QA) bugs for Delays App |
| ENG-65 | Delays Apps: General Tasks | Open | 3 / 0 | PROD-892 | Bucket: general tasks for Delays Apps |
| ENG-66 | BusPlanner Turns: Production Bugs | Open | 31 / 21 | PROD-889 | Bucket: client-reported bugs for BusPlanner Turns |
| ENG-67 | BusPlanner Turns: QA Bugs | Open | 0 / 0 | PROD-889 | Bucket: internally found (QA) bugs for BusPlanner Turns |
| ENG-68 | BusPlanner Turns: General Tasks | Open | 4 / 1 | PROD-889 | Bucket: general tasks for BusPlanner Turns |
| ENG-72 | BusPlanner Web: Production Bugs | Open | 116 / 68 | PROD-907 | Bucket: client-reported bugs for BusPlanner Web |
| ENG-73 | BusPlanner Web: QA Bugs | Open | 14 / 12 | PROD-907 | Bucket: internally found (QA) bugs for BusPlanner Web |
| ENG-75 | BusPlanner Web: General Tasks | Open | 1 / 0 | PROD-907 | Bucket: general tasks for BusPlanner Web |
| ENG-76 | BP Pro: Production Bugs | Open | 142 / 83 | PROD-893 | Bucket: client-reported bugs for BP Pro |
| ENG-77 | BP Pro: QA Bugs | Open | 2 / 1 | PROD-893 | Bucket: internally found (QA) bugs for BP Pro |
| ENG-78 | BP Pro: General Tasks | In Progress | 27 / 13 | PROD-893 | Bucket: general tasks for BP Pro |
| ENG-81 | BP Fleet: Production Bugs | Open | 131 / 60 | PROD-898 | Bucket: client-reported bugs for BP Fleet |
| ENG-82 | BP Fleet: QA Bugs | Open | 33 / 8 | PROD-898 | Bucket: internally found (QA) bugs for BP Fleet |
| ENG-83 | BP Fleet: General Tasks | In Progress | 14 / 2 | PROD-898 | Bucket: general tasks for BP Fleet |
| ENG-86 | BP Quick: Production Bugs | Open | 35 / 19 | PROD-890 | Bucket: client-reported bugs for BP Quick |
| ENG-87 | BP Quick: QA Bugs | Open | 4 / 4 | PROD-890 | Bucket: internally found (QA) bugs for BP Quick |
| ENG-88 | BP Quick: General Tasks | Open | 1 / 1 | PROD-890 | Bucket: general tasks for BP Quick |
| ENG-91 | Trips SE: Production Bugs | Open | 20 / 10 | PROD-917 | Bucket: client-reported bugs for Trips SE |
| ENG-92 | Trips SE: QA Bugs | Open | 0 / 0 | PROD-917 | Bucket: internally found (QA) bugs for Trips SE |
| ENG-93 | Trips SE: General Tasks | Open | 2 / 1 | PROD-917 | Bucket: general tasks for Trips SE |
| ENG-96 | Trips CE: Production Bugs | Open | 3 / 2 | PROD-904 | Bucket: client-reported bugs for Trips CE |
| ENG-97 | Trips CE: QA Bugs | Open | 0 / 0 | PROD-904 | Bucket: internally found (QA) bugs for Trips CE |
| ENG-98 | Trips CE: General Tasks | Open | 1 / 0 | PROD-904 | Bucket: general tasks for Trips CE |
| ENG-101 | Workflow Requests | Open | 65 / 20 | PROD-901 | (no description) Workflow Requests |
| ENG-102 | Workflow Bugs | Open | 45 / 19 | PROD-901 | (no description) Workflow Bugs |
| ENG-104 | BP Finance: Bugs | Open | 6 / 1 | PROD-891 | (no description) BP Finance: Bugs |
| ENG-105 | BP Finance: General Tasks | Open | 0 / 0 | PROD-891 | Bucket: general tasks for BP Finance |
| ENG-265 | Client Requirement: BP Workflow - One Active Submission Per Student Per Form | Resolved | 3 / 0 | PROD-901 | Workflow: only one active submission per student per form |
| ENG-266 | OSTA - Enrollment Schedule | Open | 2 / 2 | PROD-888 | OSTA enrollment schedule (client requirement) |
| ENG-267 | STSCO - CloudFlare Workaround | Open | 1 / 0 | PROD-909 | CloudFlare workaround for STSCO |
| ENG-268 | GPS / GPS+: Client Requests | Open | 6 / 4 | PROD-912 | Bucket: client-requested changes for GPS / GPS+ |
| ENG-269 | Chipmunk - Tracker: Client Requests | Open | 4 / 2 | PROD-887 | Bucket: client-requested changes for Chipmunk - Tracker |
| ENG-270 | Delays App: Client Requests | Open | 0 / 0 | PROD-896 | Bucket: client-requested changes for Delays App |
| ENG-271 | BusPlanner Turns: Client Requests | Open | 2 / 2 | PROD-914 | Bucket: client-requested changes for BusPlanner Turns |
| ENG-272 | BusPlanner Web: Client Requests | In Progress | 17 / 3 | PROD-909 | Bucket: client-requested changes for BusPlanner Web |
| ENG-273 | BusPlanner Dispatch: Client Requests | Open | 5 / 2 | PROD-910 | Bucket: client-requested changes for BusPlanner Dispatch |
| ENG-274 | BP Pro: Client Requests | Open | 11 / 3 | PROD-888 | Bucket: client-requested changes for BP Pro |
| ENG-275 | BP Fleet: Client Requests | Open | 29 / 7 | PROD-899 | Bucket: client-requested changes for BP Fleet |
| ENG-276 | BP Quick: Client Requests | Open | 3 / 0 | PROD-895 | Bucket: client-requested changes for BP Quick |
| ENG-277 | Trips SE: Client Requests | Open | 1 / 1 | PROD-913 | Bucket: client-requested changes for Trips SE |
| ENG-278 | Trips CE: Client Requests | Open | 0 / 0 | PROD-906 | Bucket: client-requested changes for Trips CE |
| ENG-280 | BP Unified: Dispatch - Investigation and Analysis | In Progress | 3 / 2 | PROD-908 | Investigation and analysis for Unified Dispatch |
| ENG-281 | Maryland State Department of Education - EOY Operational Report | Resolved | 7 / 0 | PROD-888 | Maryland end-of-year operational report (vehicle counts, route miles) |
| ENG-288 | Maryland State Department of Education - Monthly Report | Open | 4 / 0 | PROD-888 | Maryland monthly active-employees report |
| ENG-293 | Performance Improvement | Open | 20 / 10 | PROD-888 | Bucket for performance improvement work |
| ENG-294 | Communicating Delays as Alerts | Resolved | 0 / 0 | PROD-910 | Communicate delays as alerts |
| ENG-295 | CLASS - Hide all the cancellations by zone from the alerts page | Open | 1 / 1 | PROD-909 | Hide cancellations by zone from the alerts page (CLASS) |
| ENG-298 | BP Unified: GPS Readers | In Progress | 11 / 9 | PROD-856 | GPS reader services for BP Unified |
| ENG-349 | BP Unified Chatbot: Agentic Core | Resolved | 5 / 0 | PROD-897 | Covers the foundational build of the agentic chatbot — scaffolding the new agentic architecture, populating it w... |
| ENG-350 | BP Unified Chatbot: Quality & Feedback | Resolved | 5 / 1 | PROD-897 | Covers chatbot quality assurance and user feedback infrastructure — building the QA setup (saving prompts/respon... |
| ENG-351 | BP Unified PvA: Data Layer | Open | 5 / 5 | PROD-841 | Defines the new data schema for the Plan vs Actual model and handles ingestion of both planned route/stop data a... |
| ENG-352 | BP Unified PvA: Algorithm & Validation | Resolved | 0 / 0 | PROD-855 | Implements the core matching logic that compares GPS actuals against planned stops to detect deviations, and val... |
| ENG-355 | Triboard - Finance Contracts | Resolved | 4 / 0 | PROD-902 | Create 12 finance contracts for Triboard |
| ENG-357 | Chipmunk Message Transportation Functionality Not Working | Open | 4 / 0 | PROD-894 | Chipmunk parent-to-transportation messaging feature is non-functional |
| ENG-360 | BP Finance: Client Contracts | Open | 8 / 5 | PROD-902 | Catch-all epic for finance contract setup and changes across client accounts. |
| ENG-361 | Client Upgrade Tool Phase 1: Discovery Service | Open | 9 / 9 | PROD-893 | Build a C .NET Framework console application (in the Managed Repo) that discovers all installed BusPlanner produ... |
| ENG-362 | Client Upgrade Tool Phase 2: Upgrade Execution Engine | Open | 10 / 10 | PROD-893 | Extend the Discovery Service (Phase 1) to perform actual product upgrades on SaaS client servers, eliminating al... |
| ENG-385 | BP Finance - Wicomico - Finance Workbook | Resolved | 5 / 0 | PROD-902 | The client needs us to replicate their BalancedPayDigitalFile for their finance |
| ENG-622 | Trips SE: WICOMICO requests | Open | 10 / 0 | PROD-913 | WICOMICO Trips work for Go Live. |
| ENG-695 | Delay Alerts — GPS Live Viewer (Frontend) [BP Dispatch/GPS+] | Open | 11 / 11 | PROD-912 | Delay alerts in the Old World GPS Live Viewer for dispatchers |
| ENG-712 | T&A Core: Admin Screens - BP Unified Schema | Resolved | 2 / 1 | PROD-858 | T&A core admin screens on the Unified schema |
| ENG-743 | Test Ticket | In Progress | 2 / 2 | PROD-918 | Test epic (ignore) |
| ENG-760 | BP Unified: T&A - Verify CRUD against PRD & confirm child stories | In Progress | 11 / 4 | PROD-859 | Consolidated verification epic for the Time & Attendance areas confirmed code-complete during the Dev review (6 ... |
| ENG-761 | BP Unified: T&A - Locations & Geofences | On Hold | 2 / 2 | PROD-859 | Remaining build & verification for Locations & Geofences (PROD-280) |
| ENG-762 | BP Unified: T&A - Audit Log | Resolved | 6 / 0 | PROD-859 | Audit Log (PROD-285): the two-view observability surface (Recent activity, By pay period) per PRD §10 and the Au... |
| ENG-763 | BP Unified: T&A - Overtime Monitoring | Resolved | 2 / 0 | PROD-859 | Overtime Monitoring (PROD-286): the OT dashboard microapp and time-card overtime alerts, 40h/week threshold, per... |
| ENG-764 | BP Unified: T&A - Settings: Rounding & Tolerances | In Progress | 3 / 3 | PROD-859 | Settings (PROD-287): customer configuration of rounding rules (taroundingrule) and tolerance thresholds (tasetti... |
| ENG-798 | BP Unified: Setup - Depots & Row Level Security | In Progress | 5 / 4 | PROD-856 | Combined Setup epic covering two related workstreams for BP Unified |
| ENG-808 | BP Unified: Setup - Multitenancy & Master Database | In Progress | 8 / 3 | PROD-856 | Multitenancy and master database for BP Unified |
| ENG-842 | BP Unified: GPS+ Live Viewer | In Progress | 33 / 7 | PROD-825 | The core GPS+ live monitoring dashboard for the new world, and the primary July 31 deliverable |
| ENG-843 | BP Unified: Setup - Product-Level Feature Flagging | Open | 0 / 0 | PROD-856 | Not part of the July deliverable. |
| ENG-844 | BP Unified: GPS+ Path & Stop Compare | In Progress | 17 / 5 | PROD-825 | Planned-vs-actual investigation for one or more runs across a date range — merges the legacy path-compare (map) ... |
| ENG-849 | [Post-V1] BP Unified: GPS+ Smart Mappings | Open | 0 / 0 | PROD-827 | POST-V1 — out of scope for the July V1 release |
| ENG-850 | BP Unified: Setup - Datadog Monitoring | Open | 0 / 0 | PROD-856 | No standalone stories — Datadog monitoring is woven into each GPS+ / T&A work item rather than tracked as a sepa... |
| ENG-860 | BP Pro: Map/Run Editor stop label — equipment summary display (Livingston/Prince George) | Resolved | 4 / 1 | PROD-888 | Stop label on map / Run Editor also lists specialised equipment |
| ENG-873 | BP Unified: T&A - Bugs and General Tasks | In Progress | 30 / 18 | PROD-859 | Bucket for T&A bugs and general tasks |
| ENG-908 | BP Unified: GPS+ Foundations, Shared Services and Global UI Components | In Progress | 28 / 5 | PROD-825 | The shared data, algorithm-integration, and UI plumbing that every GPS+ surface depends on — so the four module ... |
| ENG-909 | BP Unified: GPS+ Event Viewer | In Progress | 14 / 0 | PROD-825 | The full GPS event history for selected runs/dates — raw device signals as a filterable log plus an activity map... |
| ENG-972 | Smoke- Tests for Post-Upgrade Regressions | Open | 12 / 12 | PROD-893 | Build a short, scripted post-upgrade smoke test that Support runs after every upgrade to confirm systems are up,... |
| ENG-1025 | BP Unified: T&A – US Go-Live & Deployment | In Progress | 6 / 0 | PROD-856 | T&A US go-live and deployment tasks |
| ENG-1062 | BP Unified: Login Flow V1 | In Progress | 14 / 11 | PROD-856 | Single unified sign-in across the BusPlanner platform |
| ENG-1117 | BP Unified: Design system foundation - FE | Open | 9 / 8 | PROD-856 | Front-end design system for the Unified SPA (tokens, conventions) |
| ENG-1162 | Chipmunk & Tracker Robustness | Open | 7 / 7 | PROD-894 | Fix Chipmunk login failures seen at school opening |
| ENG-1265 | Dev Questions | Open | 139 / 23 | PROD-918 | Bucket for Dev Question tickets from support/CX |
| ENG-1303 | LESA - Student Name Tag Report Enhancements | Resolved | 3 / 0 | PROD-443 | Student Name Tag report enhancements (client request) |
| ENG-1315 | BusPlanner Unified: Tracker - Investigation and Design | Open | 1 / 1 | PROD-857 | Investigation and design for a Unified tracker |
| ENG-1317 | BP Unified: GPS+ - Features/Tasks Reserved After 1st Go-Live | Open | 23 / 23 | PROD-841 | GPS+ features and tasks deferred until after first go-live |
| ENG-1361 | [CA-ON-TSTG] Ridership Reporting - BP Web report enhancement + 6 new BP Quick dashboards | QA Approved | 11 / 0 | PROD-895 | TSTG ridership pilot: BP Web report enhancement + 6 BP Quick dashboards |
| ENG-1501 | BP Unified: Tech Debt | Open | 10 / 7 | PROD-856 | Central epic for tracking engineering tech debt on the BP Unified platform |
| ENG-1523 | BP Unified: Time & Attendance - Nash - Export and PDF | In Progress | 13 / 5 | PROD-330 | Self-serve payroll export and PDF for the first T&A client (Nash) |
| ENG-1580 | Android API Level & iOS Min Version Compliance - 2026 | In Progress | 8 / 7 | PROD-900 | Google Play requires target API level upgrade (original deadline Aug 30, extended to before Oct 31 per approved ... |
| ENG-1619 | BP Unified: Dispatch — A: Domain model & foundation | In Progress | 24 / 24 | PROD-908 | The driver-resolution model, the shared substitution writer, the day-snapshot read model, the coverage record, a... |
| ENG-1620 | BP Unified: Dispatch — B: Shared chrome & map | Open | 6 / 6 | PROD-908 | Search, filters, stat cards, and the map panel: the elements common to both the Gantt and the Sheet — including ... |
| ENG-1621 | BP Unified: Dispatch — C: Absences | Open | 5 / 5 | PROD-908 | The shared taabsence store (same rows as T&A, no copy) and the Add Absence modal. |
| ENG-1622 | BP Unified: Dispatch — D: Coverage engine | Open | 9 / 9 | PROD-908 | The Coverage Type flow and everything it drives: driver picker, conflict engine, covering route/bus dropdown, pe... |
| ENG-1623 | BP Unified: Dispatch — E: Sheet view | Open | 4 / 4 | PROD-908 | The Sheet surface: shell, Absences section, Available Drivers. |
| ENG-1624 | BP Unified: Dispatch — F: Gantt view | Open | 5 / 5 | PROD-908 | The custom Gantt: timeline canvas, row model, sorting, drag interactions, Route Management modal. |
| ENG-1625 | BP Unified: Dispatch — G: Merge / Split tool | In Progress | 4 / 4 | PROD-908 | The stop-level workspace behind Double Up and Split, wrapping the existing BusPlanner 12.2.1 merge/split/optimiz... |
| ENG-1626 | BP Unified: Dispatch — H: Group-by lenses | Open | 5 / 5 | PROD-908 | Bus and Route lenses, the Unassigned Routes/Vehicles buckets, whole-route bus moves, serviced-run locking. |
| ENG-1627 | BP Unified: Dispatch — J: History | Open | 5 / 5 | PROD-908 | Append-only audit capture, the Log tab, the Absences tab and CSV export. |
| ENG-1868 | BP Unified: Chatbot - Prerequisites | QA Approved | 6 / 0 | PROD-897 | E0 · Prerequisites (9-11d) — blocks everything The security and technical groundwork every other epic depends on |
| ENG-1869 | BP Unified: Chatbot - ETL Additions | QA Approved | 3 / 0 | PROD-897 | E1 · ETL Additions (4d) Lands two student fields that BusPlanner Pro already has but the ETL currently discards:... |
| ENG-1870 | BP Unified: Chatbot - Agentic Core | In QA | 13 / 1 | PROD-897 | E2 · Agentic Core (16-24d) The heart of the product |
| ENG-1871 | BP Unified: Chatbot - PLANNED Feature | In QA | 8 / 3 | PROD-897 | E3 · PLANNED Feature (15-20d) The first customer-visible capability: everyday planning-data questions built on t... |
| ENG-1872 | BP Unified: Chatbot - UI Display Tools | In QA | 8 / 1 | PROD-897 | E4 · UI Display Tools (11-14d) The rendering layer every tool's output flows through, dispatched purely by paylo... |
| ENG-1873 | BP Unified: Chatbot - GPS Feature | In QA | 6 / 2 | PROD-897 | E5 · GPS Feature (13-19d) Brings the historical-GPS question set — the core of the April demo — onto the new arc... |
| ENG-1874 | BP Unified: Chatbot - GPSPLUS Feature | Open | 0 / 0 | PROD-897 | E6 · GPSPLUS Feature (14-21d) — ships dark behind the GPSPLUS flag Lights up the live-fleet and on-time-performa... |
| ENG-1875 | BP Unified: Chatbot - v2.0 - ADMIN Feature | Open | 1 / 1 | PROD-819 | E7 · ADMIN Feature (1-2d) Answers account-health questions for administrators: inactive users by last-login stal... |
| ENG-1876 | BP Unified: Chatbot - Testing & Evals | In QA | 11 / 3 | PROD-897 | E8 · Testing & Evals (7-11d) — runs continuously from E2 onward The project's safety net, not a discrete phase |
| ENG-1877 | BP Unified: Chatbot - QA & Docs | Open | 0 / 0 | PROD-897 | E9 · QA & Docs (8-11d) — outside the development window The final phase before pilot, run after dev is functiona... |
| ENG-2015 | Part 1 - Tracker Service Changes | Open | 8 / 2 | PROD-915 | Server-side fixes inside BPTrackerService itself, aimed at the queue and connection limits that caused the hard ... |
| ENG-2016 | Part 2 - BPInfo Improvements, SQL Relief, and Observability | Open | 6 / 6 | PROD-915 | Relief for the shared SQL tier and BPInfo, plus the visibility and forensics needed to plan capacity and diagnos... |
| ENG-2017 | Part 3 - Chipmunk App | Open | 3 / 3 | PROD-915 | Client-side fixes to the Chipmunk mobile app's error-recovery behavior - the single biggest amplifier identified... |
| ENG-2114 | BP Unified: Chatbot - v1.5 - Prerequisites | Open | 0 / 0 | PROD-911 | Chatbot v1.5 prerequisites |
| ENG-2115 | BP Unified: Chatbot - v1.5 - Agentic Core | Open | 0 / 0 | PROD-911 | Chatbot v1.5 agentic core |
| ENG-2116 | BP Unified: Chatbot - v1.5 - PLANNED Feature | In Progress | 1 / 0 | PROD-911 | Chatbot v1.5 planning-data questions |
| ENG-2117 | BP Unified: Chatbot - v1.5 - UI Display Tools | In Progress | 3 / 2 | PROD-911 | Chatbot v1.5 UI display tools |
| ENG-2118 | BP Unified: Chatbot - v1.5 - QA & Docs | In QA | 4 / 2 | PROD-911 | Chatbot v1.5 QA and documentation |
| ENG-2120 | BP Unified: Chatbot - v2.0 - PLANNED Feature | Open | 1 / 1 | PROD-819 | Chatbot v2.0 planning-data questions |
| ENG-2121 | BP Unified: Chatbot - v2.0 - GPSPLUS Feature | Open | 2 / 2 | PROD-819 | Chatbot v2.0 GPS+ questions |
| ENG-2130 | test epic 1 | Resolved | 2 / 2 | PROD-556 | Test epic (ignore) |
| ENG-2131 | test epic 2 | Resolved | 0 / 0 | PROD-556 | Test epic (ignore) |
| ENG-2133 | BP Unified: Chatbot - v1.5 - GPSPLUS Feature | In QA | 2 / 1 | PROD-911 | Chatbot v1.5 GPS+ (live fleet) questions |
| ENG-2205 | BP Unified: GPS+ - Production & QA Bugs | In Progress | 58 / 38 | PROD-837 | Bucket: production and QA bugs for New World GPS+ |
| ENG-2210 | US-MD-PGCPS - Prince George's Issues | Open | 12 / 4 | PROD-893 | Umbrella for Prince George's County Public Schools work: performance, load testing, upgrade and related client i... |
| ENG-2346 | [Monitoring] Service health monitoring - GPS readers, Tracker, and Subscription Service | Open | 5 / 4 |  | We currently rely on Pulseway to tell us whether a service is running |
| ENG-2417 | GPS+ New World Customer Stand-Up | In Progress | 25 / 21 | PROD-856 | Stand-up of GPS+ new world for customers across Phases 1 to 4. One story per customer |
| ENG-2457 | TDTIMS Reports - NC DPI Requested Modifications for 2026 Reporting Cycle | QA Approved | 2 / 0 | PROD-626 | NC DPI has requested modifications to three TDTIMS reports for the 2026 reporting cycle |
| ENG-2458 | BP Pro - PGCPS - Cluster stops: mark stops as cluster stops and show them with a distinct icon | QA Approved | 1 / 0 | PROD-621 | PGCPS routers need to identify large, high-population stops (typically big apartment complexes with 50 to 150+ s... |
| ENG-2459 | BP Pro - PGCPS - Color-coordinate runs with their stops and students on the map | QA Approved | 1 / 0 | PROD-620 | When several runs are shown on the map, each run gets its own color, and that run's stops and assigned students ... |
| ENG-2466 | BP Web - Alerts - STSTB- Make 'Always' timeframe work with Multi-Day so the alert persists until the To date | Open | 1 / 1 | PROD-435 | Alert with Always timeframe must persist across multi-day range (STSTB) |
| ENG-2468 | BP Pro - PGCPS - Show equipment-based student icons on the map | QA Approved | 2 / 0 | PROD-550 | Show equipment-based student icons (e.g. wheelchair) on the Pro map |
| ENG-2469 | BP Web - CLASS- Extend BP Web Setting to show alert option in School Alerts and General Alerts | Open | 1 / 1 | PROD-228 | Extend BP Web setting so alert option shows in School and General Alerts |
| ENG-2470 | BP Web - PGCPS - New condensed directions reports: Route Directions by Route and by Run (Gen Ed / Spec Ed) | In QA | 8 / 3 | PROD-612 | Two new condensed Route Directions reports, by Route and by Run (PGCPS) |
| ENG-2471 | BP Web - PGCPS - Add option for Student ID in the Student Listing page & Report | In Progress | 1 / 1 | PROD-507 | Include Student ID option on Student Listing page and report |
| ENG-2473 | Trips SE: Add Driver/Contractor Email to Driver Trip Sheet | Ready for Development | 1 / 1 | PROD-690 | Driver Trip Sheet (report type 4 only): add driver/contractor email |
| ENG-2474 | Trips SE: One Driver/Contractor Per Page on Driver Trip Sheet (multi-driver trips) | Ready for Development | 1 / 1 | PROD-690 | Driver Trip Sheet (type 4 only): one driver/contractor per page |
| ENG-2483 | BP Fleet - AVRCE - Add filters to the Parts on work orders and parts received by date reports | Ready for Development | 1 / 1 | PROD-59 | Fleet: date filters on parts-on-work-orders and parts-received reports |
| ENG-2484 | Parent Portal & Student Summary - Show weather zone next to each assigned stop | Ready for Development | 1 / 1 | PROD-565 | Parent Portal / Student Summary: show weather zone per assigned stop (STSTB) |
| ENG-2485 | BP Web - New Weather Zone Student List report (by stop zone) | Ready for Development | 1 / 1 | PROD-566 | New BP Web Weather Zone Student List report by stop zone (STSTB) |
| ENG-2486 | BP Web - Transportation Alerts - Show Component Type (AM/PM) when posting an alert for a zone | In Progress | 1 / 1 | PROD-633 | Transportation Alerts: show AM/PM component type when posting for a zone (STSTB) |
| ENG-2488 | BP Pro - Show weather zone for each stop on the student record and in stop properties | Ready for Development | 1 / 1 | PROD-632 | BP Pro: weather zone per stop on student record and stop properties (STSTB) |
| ENG-2489 | Route Directions by Route/Run reports - Show weather zone for each stop | Ready for Development | 1 / 1 | PROD-564 | Route Directions reports: show weather zone per stop (STSTB) |
| ENG-2506 | BP Web- Highlight/bold safety-critical fields on Route Details by Route & by Run reports | Ready for Development | 0 / 0 | PROD-43 | Bold safety-critical fields on Route Details reports (CBE request) |
| ENG-2581 | BP Unified: GPS+ Live Viewer - Route Management (Substitute Vehicle and Reassign Driver) | In Progress | 28 / 20 | PROD-837 | GOAL Let users change a route's vehicle or a vehicle's driver for today from New World Live Viewer, matching the... |
| ENG-2588 | New Customer Standup | Open | 1 / 1 | PROD-856 | Parent epic for new customer stand-up work on BusPlanner Unified — knowledge transfer, environment and data acce... |
| ENG-2595 | BP Pro - PGCPS - Show students at their alternate address on the map when assigned from it | In Progress | 2 / 1 | PROD-623 | Show students at alternate address on map when assigned from it |
| ENG-2597 | MSDE - Maryland State Reports - Monthly Active Employee Report: setting to generate with or without employee SSN | In Progress | 1 / 1 | PROD-700 | MSDE monthly employee report: setting to include or omit SSN |
| ENG-2598 | MSDE - Maryland State Reports - Accident Report | In Progress | 2 / 2 | PROD-562 | MSDE Maryland state Accident Report |
| ENG-2599 | MSDE - Maryland State Reports - Ridership Report | In Progress | 2 / 2 | PROD-563 | MSDE Maryland state Ridership Report |
| ENG-2646 | Mobile - 2026 Android API Level & iOS Min Version Compliance - Bugs Found in Testing | Open | 17 / 17 | PROD-900 | This epic tracks pre-existing bugs found while doing the work in ENG-1580 for Chipmunk, Turns and Delays |
| ENG-2720 | [US-NY-STSI (Suffolk)] AM/PM Component Report - identify which run was late, with start and end times | In Progress | 2 / 1 | PROD-768 | AM/PM Component Report: identify which run was late with start/end times |
| ENG-2732 | BP Web - PGCPS - Parent Notification Letter: generate and print letters to parents, selectable by school | Open | 1 / 1 | PROD-547 | Requirements, the PGCPS example letter and dev scoping are on PROD-547. |
| ENG-2785 | [71020][CA-ON-STSYR (York)] - Add ministry classifications to Reason Type classification list | QA Approved | 1 / 0 |  | Add ministry classifications to Reason Type classification list (STSYR) |
| ENG-2865 | ZD47208 - US-NC-GASTON - BP Pro: print one school boundary per page, masked, with readable street names | Open | 2 / 2 | PROD-230 | BP Pro: print one masked school boundary per page with readable street names |
| ENG-2917 | BP Unified: Chatbot - Bugs | In Progress | 44 / 38 | PROD-938 | Bugs found in the BP Unified Chatbot, including bugs in the New World ETL that feeds it. |
| ENG-2937 | BP Web - PGCPS - Condensed Route Directions rollout feedback: page breaks, first-page header, line-by-line directions, fold-in-half layout | Open | 1 / 0 | PROD-814 | Condensed Route Directions rollout feedback: page breaks, headers, layout |
| ENG-2939 | BP Pro - PGCPS - Bulk edit stops into cluster stops | Open | 1 / 1 | PROD-816 | Bulk-edit stops into cluster stops |
| ENG-2949 | Tracker Upgrade | Open | 1 / 1 | PROD-822 | Tracker bundles login, push notifications, and ETA calculations into one service, so a failure in any one of the... |
| ENG-2950 | Map Loading | Open | 1 / 1 | PROD-821 | The map reloads in the background on every search update, even when nothing on the map has changed. |
| ENG-2951 | Audit Trail | Open | 1 / 1 | PROD-821 | Database changes are logged only in files, not the front end, so customers can't see who changed what. |
| ENG-2952 | Product Configurator | Open | 1 / 1 | PROD-824 | We have no central view of how Dispatch and Chipmunk are set up on each customer server, so unique setups and ed... |
| ENG-2953 | BP Unified: GPS+ Device Mapping | Open | 5 / 5 | PROD-826 | Admin surface that maps each GPS device (physical tracker) to the vehicle it's installed on, over time, front-en... |
| ENG-2974 | Trips SE: Add Trip Number to Driver Trip Sheet Report | Open | 1 / 1 | PROD-243 | HZSD requested the Trip Number on the Driver Trip Sheet Report. |
| ENG-2976 | BP Web - PGCPS - Automate Route Directions by Run distribution for changed runs each print cycle | Open | 2 / 2 | PROD-770 | PGCPS requested automated generation and email distribution of the Route Directions by Run report for runs chang... |
| ENG-3018 | [CA-AB-PRSD] BP Turns: End-of-run check for students not scanned off | Open | 1 / 1 | PROD-553 | At the final stop of a run, BP Turns shows the driver/monitor a list of students who scanned ON but have not sca... |
| ENG-3020 | [US-FL-SDCC] Chipmunk: Show child's stop time to parents instead of school arrival time | Open | 1 / 1 | PROD-515 | Chipmunk shows parents their child's stop description and time (AM Pickup Stop, PM Dropoff Stop) instead of the ... |
| ENG-3022 | [CA-ON-HSTS] BP Pro: Remove contacts during Student Update when no replacement is provided | Open | 1 / 1 | PROD-340 | Student Update removes a contact from a student when that contact has been removed in the SIS with no replacemen... |
| ENG-3024 | [CA-AB-CBE] BP Pro: Track Met at Bus changes in Student History | Open | 1 / 1 | PROD-795 | Every change to a student's Met at Bus flag is recorded with the old and new value, date and time, user, Manual ... |
| ENG-3036 | CVE-2026-111497 (Brotli) Remediation | In Progress | 3 / 3 |  | Remediation of CVE-2026-111497, an out-of-bounds write in Google's Brotli decoder |
| ENG-3042 | Release Management | In Progress | 3 / 1 | PROD-939 | Release and deployment work: regression testing for releases and hotfixes, managing release and promote cycles, ... |

### PROD epics (all 28)

| Key | Name | Status | PROD children | ENG children | Purpose |
|---|---|---|---|---|---|
| PROD-52 | CA-NS-AVRCE - Custom SQL View Request | Done | 0 | 0 | Custom SQL view for a client (AVRCE) |
| PROD-94 | CA-AB-PRSD - Undo Manual Student Scan in Turns Requester: Peace River | Done | 0 | 0 | Undo a manual student scan in Turns (PRSD) |
| PROD-117 | CA-QC-CSSBE – Request for new report | Done | 0 | 0 | New report request (CSSBE) |
| PROD-214 | Trips SE: WICOMICO - Change Object Code to a Dropdown | Done | 5 | 0 | Trips SE: Object Code becomes a dropdown (WICOMICO) |
| PROD-215 | BP Quick - Yankton - Add ability generate QR code of Student ID | Done | 1 | 0 | BP Quick: generate QR code of Student ID (Yankton) |
| PROD-229 | ZD - #55365 - US-NC-GCS (Guilford) - BUS PASSES ON BP WEB (format change request) | Done | 0 | 1 | BP Web bus pass format change (GCS) |
| PROD-253 | Driver Time Sheet — Dual-View Approval (PRD §3.5) | Done | 20 | 0 | T&A driver time sheet dual-view approval (PRD 3.5) |
| PROD-274 | Employees (T&A) | Done | 4 | 0 | T&A Employees admin |
| PROD-275 | Positions (T&A) | In Progress | 3 | 0 | T&A Positions admin |
| PROD-276 | Job Codes (T&A) | Done | 3 | 0 | T&A Job Codes and pay-code mapping |
| PROD-277 | Absence Types (T&A) | Done | 1 | 0 | T&A Absence Types |
| PROD-278 | Departments (T&A) | In Progress | 2 | 0 | T&A Departments |
| PROD-279 | Holidays (T&A) | In Progress | 3 | 0 | T&A Holidays calendar and credit |
| PROD-280 | Locations / Geofences (T&A) | In Progress | 2 | 0 | T&A Locations and geofences |
| PROD-281 | Employee–Vehicle Assignment (T&A) | In Progress | 3 | 0 | T&A employee-vehicle assignment |
| PROD-282 | Pay Periods (T&A) | Done | 3 | 1 | T&A Pay Periods configuration and lifecycle |
| PROD-283 | Pay Cycle Summary (T&A) | In Progress | 2 | 0 | T&A Pay Cycle Summary (OT/PTO/holiday aggregation) |
| PROD-284 | Payroll Export (T&A) | Done | 4 | 0 | T&A Payroll Export (3-step flow, CSV) |
| PROD-285 | Audit Log (T&A) | In Progress | 6 | 0 | T&A Audit Log (two views) |
| PROD-286 | Overtime Monitoring (T&A) | In Progress | 2 | 0 | T&A Overtime Monitoring (>40h/week) |
| PROD-287 | Settings — rounding & tolerances (T&A) | In Progress | 2 | 0 | T&A Settings: rounding and tolerances |
| PROD-288 | Notifications (T&A, V2) | In Progress | 1 | 0 | T&A Notifications (deferred to V2) |
| PROD-337 | Map/Run Editor stop label: show equipment summary (Livingston/Prince George) | Done | 0 | 0 | Stop label shows equipment summary (Livingston / PGCPS) |
| PROD-397 | Unified Login | Backlog | 21 | 0 | Unified Login: one sign-in for the platform |
| PROD-424 | BP Quick: Live Viewer Role for School Monitoring | Done | 0 | 0 | BP Quick view-only Live Viewer role for school monitoring |
| PROD-459 | Nash County T&A - Export and PDF | Backlog | 0 | 0 | Nash T&A export and PDF |
| PROD-477 | Chipmunk: Add show/hide password toggle (eye icon) on login and account creation | Done | 0 | 0 | Chipmunk show/hide password toggle |
| PROD-777 | [US-NY-STSI (Suffolk)] Planned first and last student times to cover the full run, irrespective of district of record | Backlog | 0 | 0 | Planned first/last student times to cover full run (STSI) |

### PROD Features (66): the parents of ENG epics

Format: key name (status, number of ENG child epics). Not read beyond title and first lines.

- PROD-330 BP Unified: Time & Attendance (On Hold, 1); PROD-802 [72688]-[CA-ON-TSTG] Add "Geocode Errors" location for students with non-geocodable addresses (Backlog, 0); PROD-819 BP Unified: Chatbot - v2.0 (Backlog, 3); PROD-821 BP Pro: Tech Debt (Backlog, 2)
- PROD-822 Chipmunk - Tracker: Tech Debt (Backlog, 1); PROD-824 BusPlanner Core: Tech Debt (Backlog, 1); PROD-825 BP Unified: GPS+ - v1 (Backlog, 4); PROD-826 BP Unified: GPS+ Vehicle Mapping (Backlog, 1)
- PROD-827 BP Unified: GPS+ - Smart Mapping (To Do, 1); PROD-829 BP Unified: GPS+ - ETA Algorithm (To Do, 0); PROD-831 BP Unified: GPS+ - Alerts (Backlog, 0); PROD-832 BP Unified: GPS+ - Path Compare Summary (Backlog, 0)
- PROD-833 BP Unified: GPS+ - On Time Reporting (Backlog, 0); PROD-834 BP Unified: GPS+ - Path Generation (Backlog, 0); PROD-835 BP Unified: GPS+ - Path Playback (Backlog, 0); PROD-836 BP Unified: GPS+ - Staff Manager (Backlog, 0)
- PROD-837 BP Unified: GPS+ - Bugs and General Items (Backlog, 2); PROD-838 BP Unified: GPS+ - Vehicle Manager (Backlog, 0); PROD-840 BP Unified: GPS+ - Customer Asks (Backlog, 0); PROD-841 BP Unified: GPS+: Plan vs Actual - v2 (Backlog, 2)
- PROD-842 BP Unified: Chatbot - Customer Asks (Backlog, 0); PROD-843 BP Unified: Dispatch - Customer Asks (Backlog, 0); PROD-845 BP Unified: Admin Module - Settings (Backlog, 0); PROD-846 BP Unified: Admin Module - UI for Product Setups (Backlog, 0)
- PROD-848 BP Unified: Discipline Module - v1 (Backlog, 0); PROD-849 BP Unified: Discipline Module - Customer Asks (Backlog, 0); PROD-855 BP Unified: Plan vs Actual (Backlog, 1); PROD-856 BP Unified: Foundation, Schema Setup, and Infrastructure Work (In Progress, 11)
- PROD-857 BP Unified: Tracker Algorithm (Backlog, 1); PROD-858 BP Unified: Time and Attendance Core (In Progress, 3); PROD-859 BP Unified: Time and Attendance - v1 (In Progress, 6); PROD-860 BP Unified (Mobile): Time and Attendance (Done, 1)
- PROD-887 Chipmunk - Tracker: New Features (Backlog, 1); PROD-888 BP Pro: New Features (Backlog, 6); PROD-889 BusPlanner Turns: Bugs and General Tasks (Backlog, 3); PROD-890 BP Quick: Bugs and General Tasks (Backlog, 3)
- PROD-891 BusPlanner Finance: Bugs and General Tasks (Backlog, 2); PROD-892 Delays App: Bugs and General Tasks (Backlog, 3); PROD-893 BP Pro: Bugs and General Tasks (Backlog, 7); PROD-894 Chipmunk - Tracker Bugs and General Tasks (Backlog, 5)
- PROD-895 BP Quick: New Features (Backlog, 2); PROD-896 Delays App: New Features (Backlog, 1); PROD-897 BP Unified: Chatbot - v1 (In Progress, 11); PROD-898 BP Fleet: Bugs and General Tasks (Backlog, 3)
- PROD-899 BP Fleet: New Features (Backlog, 1); PROD-900 General Mobile Infrastructure (In Progress, 2); PROD-901 BusPlanner Workflows (Backlog, 3); PROD-902 BusPlanner Finance Contracts (Backlog, 3)
- PROD-903 BP Pro: Add Staff Binding for Finance Contract (Backlog, 0); PROD-904 Trips CE: Bugs and General Tasks (Backlog, 3); PROD-905 BusPlanner Dispatch: Bugs and General Tasks (Backlog, 3); PROD-906 Trips CE: New Features (Backlog, 1)
- PROD-907 BusPlanner Web: Bugs and General Tasks (Backlog, 3); PROD-908 BP Unified: Dispatch - v1 (Backlog, 10); PROD-909 BusPlanner Web: New Features (Backlog, 3); PROD-910 BusPlanner Dispatch: New Features (Backlog, 2)
- PROD-911 BP Unified: Chatbot - v1.5 (In Progress, 6); PROD-912 GPS / GPS+: New Features (Backlog, 2); PROD-913 Trips SE: New Features (Backlog, 2); PROD-914 BusPlanner Turns: New Features (Backlog, 1)
- PROD-915 Tracker Optimizations (Backlog, 3); PROD-916 GPS / GPS+ Bugs and General Tasks (Backlog, 3); PROD-917 Trips SE: Bugs and General Tasks (Backlog, 3); PROD-918 Dev Questions (Backlog, 2)
- PROD-938 BP Unified: Chatbot - Bugs (Backlog, 1); PROD-939 BusPlanner Core: Release Management (Backlog, 1)

Other projects: IN has 6 epics (listed in A). SOC, SPT and MDP have none.

## C. ENG, last 180 days, every issue at summary level

**Totals.** JQL `project = ENG AND created >= -180d` returned **2,872**. The project holds **2,879** issues in total and all 2,879 were pulled (key, summary, type, status, priority, components, labels, fix versions, parent, dates, assignee, reporter, QA Reviewer, Client). The tables below use created >= 2026-05-14, which is **2,873** issues (one more than the JQL figure because of the time-of-day boundary).

| By type | n | By status | n | By priority | n | Created in | n |
|---|---|---|---|---|---|---|---|
| Bug | 1,087 | Open | 1,279 | Highest | 521 | May (from 14th) | 6 |
| Story | 554 | Resolved | 730 | High | 417 | June | 671 |
| Task | 382 | RELEASED | 358 | Medium | 1,764 | July | 350 |
| Sub-task | 355 | Approved for Release | 130 | Low | 153 | August | 770 |
| Epic | 182 | Ready for QA | 125 | Lowest | 18 | September | 433 |
| Dev Question | 159 | Code Review | 77 | | | October | 539 |
| Bug - ENG | 129 | In Progress | 65 | | | November (to 10th) | 104 |
| Workflow | 25 | Blocked | 38 | | | | |
| | | Investigation 17, Reopened 17, QA Review 12 | | | | | |
| | | Epic-only: Ready for Development 8, In QA 8, QA Approved 8, On Hold 1 | | | | | |

- **By component:** none 2,745; MVP - GPS+ Live Viewer 41; Dispatch Waves 1-8 65 in total; MVP - Time and Attendance 12; Chipmunk-Robustness 9; Chipmunk-Tracker 1.
- **By fix version:** none 2,384. Largest: 2.8.10.2026 New World 41, 11.2026 New World 38, 13.1.8 35, 13.3.0 32, 13.4.0 28, 13.4.4 25, 13.3.1 23, 13.1.5 21, 13.1.12 19, 13.1.14 17, Fleet 12.4.10 16, Fleet 12.4.4 14, Fleet 12.4.9 14. All other versions hold 13 or fewer.
- **By parent:** 1,970 issues sit under an epic, 369 have no parent, 229 are children of a Story, 111 of a Task, 179 hang directly under a PROD Feature or Feature Request. Largest epics: ENG-76 BP Pro Production Bugs 142, ENG-1265 Dev Questions 139, ENG-81 BP Fleet Production Bugs 131, ENG-72 BP Web Production Bugs 116, ENG-46 GPS / GPS+ Production Bugs 74, ENG-56 Chipmunk - Tracker Production Bugs 72, ENG-101 Workflow Requests 65, ENG-2205 Unified GPS+ bugs 58.
- **By label:** none 1,649; `jira_escalated` 754; `jira_auto_reopened` 204; `P30_BP_Unified` 189; `pss-stamped` 153; `BP_Unified_Chatbot_v1.0` 66; `Ridership` 54; `TSTG` 51; `BPQuick` 40; `BP_Unified_Chatbot_v1.5` 38; `Reporting` 23; `P22_Tracker` 17; `P28_Time_And_Attendance` 17; `rollover` 16; `BPWeb` 14; `P37_Web_Bug` 14; `spike` 13. About 30 more labels have 10 or fewer uses.
- **QA Reviewer field (set on 515 issues):** Hamad Zeb 182, Yusra Abbasi 91, Ali Janjua 80, Mitchell Bland 36, Janice Fritz 34, Wajeeha Batool 18, Javier Duarte 17, Drew Weeks 13, Michelle Prichard 11, Shikhar Patel 11, Dong-Ik Lee 9, Maricar Benedictos 6, Stephen Hu 6, Muhammad Ali 5, Nikki Tilano 2.
- **Assignee:** 1,162 unassigned. Then Janice Fritz 248, Michelle Prichard 202, Dong-Ik Lee 202, Vladislav Derbenev 149, Ibrahim Ali Asgher 130, Mitchell Bland 123, Drew Weeks 122, Stephen Hu 105, Shikhar Patel 105, Michel Walther 71, Logan Gillett 64, Javier Duarte 58, Tian Yi 53, Peter Xiao 24, Emran Moradian 19, Andy Tompkins 11.

### Bugs: 1,216 (Bug 1,087 + Bug - ENG 129)

| Status | n | Priority | n | Created | n |
|---|---|---|---|---|---|
| Open | 593 | Highest | 309 | June | 385 |
| Resolved | 241 | High | 248 | July | 125 |
| RELEASED | 200 | Medium | 520 | August | 193 |
| Ready for QA | 54 | Low | 127 | September | 245 |
| Code Review | 44 | Lowest | 12 | October | 236 |
| Approved for Release | 33 | | | November (to 10th) | 32 |
| Blocked 23, In Progress 9, Reopened 9, QA Review 7, Investigation 3 | | | | | |

- 529 bugs carry `jira_escalated` (came from SPT), 117 `jira_auto_reopened`, 98 `pss-stamped`.
- Client field on bugs: "BusPlanner" (internal) 404; blank 134; then US-FL-MDCPS 54, US-FL-SDCC 48, US-MD-PGCPS 48, CA-ON-TSTG 42, CA-ON-STSTB 31, CA-NS-HRCE 28, CA-ON-STSCO 24, CA-AB-PRSD 23, US-FL-SDIRC 17, US-NC-NCPS 15, CA-NL-NLESD 14, US-NY-STSI 13, CA-ON-NSTS 13, CA-AB-ECSD 12.
- Top bug reporters: Murtaza Khalil 345 (escalations), Hamad Zeb 130, Yash JJ 82, Joshua Abubo 66, Mitchell Bland 65, Janice Fritz 61, Yusra Abbasi 45, Jason Ta 44.
- 941 of 1,216 bugs have no fix version.
- Resolved bugs (n = 361 with a resolution date): created-to-resolved median 17.9 days, quartiles 3.8 and 39.7 days.

### Bug themes

Method: every one of the 1,216 bug summaries was assigned to exactly one product theme by rule (parent bucket epic first, then summary keywords). The 83 that matched no rule were read one by one; they are mostly unparented BP Web / BP Pro / GPS escalations, plus 5 test tickets. "Open" means not Resolved, RELEASED or Approved for Release. "Hi" is Highest + High.

| Theme | Bugs | Open | Hi | Last 30 days | Example keys | What goes wrong |
|---|---|---|---|---|---|---|
| BP Fleet (Miami train) | 193 | 100 | 71 | 26 | ENG-3034, ENG-3012, ENG-2980, ENG-2979, ENG-2972 | Work order numbering and re-open paths, purchase orders deleted or renumbered, parts/inventory deduction, reminder date maths, silent 500s |
| BP Pro: routing, imports, eligibility, Path Server | 159 | 92 | 76 | 16 | ENG-3053, ENG-3051, ENG-3050, ENG-3043, ENG-2967 | Eligibility runs not completing, Path Server memory/threads/asserts, student update and rollover data, database version upgrades |
| BP Web: portal, alerts, reports | 143 | 93 | 56 | 15 | ENG-2982, ENG-2945, ENG-2908, ENG-2905, ENG-2901 | Report filters and date boundaries, PDF timeouts, alert posting, reCAPTCHA, peak-hour disconnects |
| Chipmunk / Tracker (parent app) | 116 | 57 | 70 | 18 | ENG-3052, ENG-2986, ENG-2971, ENG-2970, ENG-2966 | "Bus not reporting", readers falling behind at morning peak, login/server-down, pushes to tracker failing silently. Highest share of Highest/High in the last 90 days (53) |
| GPS / GPS+ Old World (readers, compare) | 95 | 52 | 56 | 7 | ENG-2968, ENG-2863, ENG-2836, ENG-2825, ENG-2760 | Reader errors, late/serviced status wrong, route names with special characters |
| Other / unparented escalations | 83 | 68 | 36 | 13 | ENG-2919, ENG-2892, ENG-2885, ENG-2839, ENG-2579 | Mixed: ridership reports, scans, culture/unit handling, schema upgrade, one cross-database lookup leak (ENG-1865) |
| GPS+ New World (Live Viewer, Compare, ETL, readers) | 78 | 52 | 31 | 23 | ENG-2963, ENG-2880, ENG-2861, ENG-2855, ENG-2849 | Substitutions not applied or flipping, status/sort wrong, ETL load failures deactivating plan snapshots (ENG-2903) |
| Mobile: Turns / Delays | 64 | 49 | 32 | 14 | ENG-3014, ENG-2883, ENG-2835, ENG-2763, ENG-2718 | Scans, end-of-run behaviour, bugs surfaced by the 2026 platform-compliance work (ENG-2646) |
| T&A (Unified) | 58 | 38 | 29 | 7 | ENG-2913, ENG-2912, ENG-2894, ENG-2879, ENG-2876 | Payable time vs punches, approved timecards not reopening, CSV import, slow GraphQL reads |
| Workflow forms | 58 | 31 | 27 | 4 | ENG-2827, ENG-2822, ENG-2759, ENG-2643, ENG-2558 | Duplicate submissions, dropdowns empty without error, per-client form logic |
| Chatbot (Unified Ask AI) | 47 | 41 | 13 | 46 | ENG-3048, ENG-3047, ENG-3046, ENG-3045, ENG-3011 | Wrong or missing answers, timeouts (single user and concurrent), access scope, UI state. Almost all filed in the last 30 days: the busiest area right now |
| BP Quick | 45 | 30 | 17 | 5 | ENG-2907, ENG-2823, ENG-2761, ENG-2757, ENG-2615 | Dashboards and ridership views, slow loads |
| Trips (SE / CE) | 35 | 23 | 16 | 0 | ENG-2576, ENG-2317, ENG-2315, ENG-2314, ENG-2278 | Trip sheets, costing, client go-live items |
| Dispatch (Old World) | 34 | 14 | 20 | 1 | ENG-2800, ENG-2504, ENG-2496, ENG-2403, ENG-2302 | Driver reassignment, permissions, notifications |
| BP Finance | 8 | 2 | 7 | 0 | ENG-2525, ENG-2098, ENG-2087, ENG-1387, ENG-1273 | Contract calculations |

Cross-cutting symptom tags from the same summaries (a bug can carry several; 465 carry none):

| Symptom | Bugs | Example keys |
|---|---|---|
| Error / failure / "not working" | 207 | ENG-3045, ENG-3034, ENG-3012, ENG-3011 |
| Data wrong, missing, duplicated, not syncing | 201 | ENG-2980, ENG-2979, ENG-2913, ENG-2912 |
| Reports, exports, PDF, print | 159 | ENG-2946, ENG-2945, ENG-2919, ENG-2907 |
| Performance, timeout, memory, crash, disconnect | 144 | ENG-3047, ENG-2971, ENG-2967, ENG-2966 |
| Map, geocode, distance, path | 74 | ENG-3053, ENG-3051, ENG-3050, ENG-2967 |
| Notifications, alerts, email | 73 | ENG-2966, ENG-2945, ENG-2839, ENG-2833 |
| Login, SSO, permissions, access | 59 | ENG-2980, ENG-2927, ENG-2925, ENG-2906 |
| Request or question filed as a bug | about 50 | ENG-3029 (a SQL query request typed Bug / Highest) |
| Time zone, dates, DST | 21 | ENG-2979, ENG-2971, ENG-2885, ENG-2827 |

Symptom counts are keyword matches on summaries and are indicative, not exact.

## D. Tickets read in full (description, custom fields, all comments)

**Cap hit.** The three requested sets are far larger than 80: 385 Highest/High bugs created in the last 90 days (211 Highest, 174 High), 147 issues in a QA status, 145 issues reported by or assigned to QA staff in the last 60 days; 612 distinct issues. The 80 read were: all 12 in QA Review, all 9 epics In QA, then the most recent from each set in turn (Highest/High bugs by created date back to 2026-08-26, Ready for QA by last update, QA-staff issues by created date). Overlap means 32 of the 80 are Highest/High bugs, 47 are in a QA status and 28 involve QA staff. Every comment on all 80 was exported (no truncation).

What each ticket in a QA status needs from the tester (from the read):

| Key | Status | What it is | What QA must do / watch |
|---|---|---|---|
| ENG-3043 | QA Review | CA-AB-CCSD eligibility still not completing after 13.4.2; adds Path Server copies | Needs the PR 1787 build. Validate setting values 1-8, restart, 4-client load. Long runs were not tested by dev |
| ENG-3050 | QA Review | Path Server aborts when a path point has no street vertex | Needs PR 1790 build. 4-process load must not crash. 4 of 81 distances differ and have no ticket |
| ENG-3051 | Ready for QA | Path Server returns loop distance instead of 0 for same-place requests | Needs PR 1791 build. Compare Path Server and local eligibility distances |
| ENG-1997 | QA Review | CA-ON-STSYR BP Web disconnects at morning peak (port exhaustion) | QA notes are on the sub-tasks. Dev diagnosis was revised five times: read to the last comment |
| ENG-391 | QA Review | CA-ON-STSYR Parent Portal SSO (OpenID Connect) sign-in fails | Test new sign-in, placeholder-email self-heal, email collision guard. Live identity-provider round trip was not tested by dev |
| ENG-773 | QA Review | T&A Pay Periods verified against PRD | QA recorded B3/B4 as FAIL and several cases have no verdict, yet the ticket still sits in QA Review |
| ENG-785 | QA Review | T&A rounding rules | Verify hierarchy pay code > position > customer default. QA notes are in the repo docs |
| ENG-1043 | QA Review | GPS+ Live Viewer v1 story | Summary cards must sum to Total. Thresholds 5/15/120 min live in the database only. Story was written after development |
| ENG-2062 | QA Review | Substituted routes in Path & Stop Compare / Event Viewer | Only the route-level case passed. Run-split, chained and spare-vehicle cases untested for lack of data |
| ENG-2801 | QA Review | Adding analytics:read removed the chatbot planned-vs-actual map | 4-user permission matrix, 9 tests; evidence exists for tests 1-4 only. Re-login after permission change |
| ENG-2818 | QA Review | Chatbot planned vs actual fails at run level | 20 prompt cases built by QA with screenshots; no explicit verdicts yet |
| ENG-2922 | QA Review | Ask AI "Thinking" panel loses collapsed state | 7 tests including the floating window. Reset on reload is a known limit |
| ENG-2012 | QA Review | Dispose GeoIMS connections in three CA-ON-TSTG workflow forms | Repeat school changes. Failure shows as empty dropdowns with no error |
| ENG-2726 | Ready for QA | US-FL-MDCPS Fleet: Missing Parts on closed work orders never deducted | 6 scenarios tied to the "Restrict Missing Parts To Open Work Orders" setting. Exported work orders must never change |
| ENG-2065 | Ready for QA | CA-AB-PSD: routes with "+" in the name list no runs in Path Compare | Regression on 10 route/run dropdown screens. Try + [ ] & _ ' " in names. Waiting since 2026-09-09 |
| ENG-1597 | Ready for QA | Revoking delete permission does not hide Add/Edit/Delete controls | Three-role matrix. Sign out and in (token lasts up to 1 hour). Role permissions override direct ones. Waiting since August |
| ENG-2516 | Ready for QA | T&A: punch added to an approved timecard does not reopen it | Pay-integrity risk. Same job code reopens, different job code does not. Check Audit Log |
| ENG-2740 | Ready for QA | T&A: mobile clock-out overwrote supervisor edit | Dev could not reproduce; only regression tests were added. Old client data stays wrong by design |
| ENG-2518 | Ready for QA | T&A: overlapping pay periods with explicit period on export | Sections A-D in order. **Section C performs a real export that cannot be undone** on a shared environment |
| ENG-1534 | Ready for QA | T&A: new scan-pair CSV payroll format + split shift at midnight | Open files in a text editor (CRLF, no header). Overnight shift needs a device punch |
| ENG-2642 | Ready for QA | Chatbot GPS tools must respect school/district/operator/depot access | Large matrix (sections A-G, 7 test users). No leakage of out-of-scope routes. AND vs OR combining rule undecided |
| ENG-2754 | Ready for QA | Chatbot generic "Looking up records" tool | 13 admin tests, School User half, planning flag off. Footer totals must match the answer |
| ENG-2790 | Ready for QA | Chatbot answers student enrollment / address / special-needs questions | School User must get "no student found" for another school's students |
| ENG-2904, ENG-2882 | Ready for QA | Chatbot contradictory coverage figures; route number treated as a bus | Notes carry an explicit "Fail if" list. New chat per test |
| ENG-2924 | Ready for QA | Chatbot trend answer mentions a chart that is not rendered | 13 cases incl. weekend, partial today, dock, reload, screen-reader caption |
| ENG-2925 | Ready for QA | chatbot:read-only user lands on "No modules available" | 4 tests. ENG-2906 was closed as its duplicate |
| ENG-2926 | Ready for QA | Chatbot GPS questions time out for district-scoped users | Cold cache can take about 23 s: ask again before failing |
| ENG-2921, ENG-2946, ENG-2911, ENG-3011 | Ready for QA | Chatbot UI and error-handling bugs | ENG-2946 and ENG-2911 have no QA Testing Notes; ENG-3011 has one line |
| ENG-2795 | Ready for QA | Chatbot opens docked in a resizable right pane | 8 test groups: width 360-760 px, remembered state, keyboard, narrow screens, feature flag |
| ENG-3030 | Ready for QA | Replace Ask AI icon and logo | 8 placement checks; sign-in page, timesheet PDF and rail "B" must stay unchanged |
| ENG-2789 | Ready for QA | GPS+ shows stop description, not only Stop ID | Scope grew in comments (show/hide columns). On dev from 2026-11-10 |
| ENG-2880 | Ready for QA | GPS+ Live Viewer Status sort not by lateness | QA already failed it on 2026-10-30; waiting for a new fix. Needs 2+ late buses during live runs |
| ENG-2963 | Ready for QA | Unified base schema declares columns twice; create-database fails | Create a database from main on an empty server, then run all migrations |
| ENG-3037 | Ready for QA | Rebuild Unified images on patched .NET (CVE) | QA notes "n/a". Verify runtime version per pod, staging first |
| ENG-2470 (epic) | In QA | PGCPS condensed Route Directions reports | 17 Given/Then criteria. Deadheads never cause blank pages. Existing reports unchanged |
| ENG-3, 1870-1873, 1876, 2118, 2133 (epics) | In QA | T&A core and Chatbot v1 / v1.5 epics | Epic descriptions are empty or planning text; the work is in the children |

Other tickets read, not in a QA status, worth knowing:

- **Regression task pattern** (ENG-2909 for 13.4.0, ENG-2973 for 13.4.1, ENG-3035 for 13.4.2, ENG-3013 for Fleet 12.4.14): one `[QA] Regression ...` Task per release, result posted as a sign-off comment. ENG-2909 ended "passed with exceptions" (ENG-2905, ENG-2908).
- **A fix that passed QA but did not solve the customer problem:** ENG-2967 (Path Server thread build-up, RELEASED in 13.4.2) was followed by ENG-3043 as a new ticket, not a reopen, "to keep fix versions clean".
- **A good fail-back example:** ENG-2947 (Fleet reminder date). QA failed the first fix on 11-03 with a step table, dev fixed the same day, QA verified on build 12.4.14.7 on 11-04.
- **Incident fixes:** ENG-2971 (GPS times 60 minutes behind after a time-zone rule change; needs the October 2026 Windows update and an iisreset), ENG-2986 (reader falls behind 6:30-9:30; tracker drops events older than about 65 s; Investigation), ENG-2966 (driver reassignments fail to reach the tracker; logged at Info level so invisible under an Error filter; Open), ENG-2903 (one failed ETL plan load deactivates all snapshots; In Progress).
- **Open, High, unassigned to a release:** ENG-3045 / 3046 / 3047 (chatbot failures and timeouts), ENG-2982 (CA-ON-STSCO reCAPTCHA missing after upgrade), ENG-2928 (Fleet: deleting a work order silently deletes its paid purchase order; awaiting a product decision), ENG-2945 (report date range exclusive at midnight), ENG-2894 (T&A reads 5-9 s against a p95 target under 1 s), ENG-3034 (Fleet demo site error; screenshot only).
- **Not really bugs:** ENG-3029 (query request typed Bug / Highest), ENG-2919 and ENG-2970 (configuration fixes, no code).
- Remaining keys read: ENG-2979, 2980, 2972, 2969, 2968, 2985, 2983, 3012, 2913, 2912, 2906, 2905.

## E. Conventions observed

### Acceptance criteria

- There is no AC field and no single format. Seen in the 80 tickets: a bullet list under "Acceptance criteria" (ENG-773, ENG-785, ENG-2518, ENG-2795, ENG-3050, ENG-2963); "Done when" bullets (ENG-3030, ENG-3043, ENG-2967, ENG-2968); "Given ..., when ..., then ..." bullets plus "Open questions (confirm before development)" in exactly one epic (ENG-2470).
- Many tasks have a one-line description and the real criteria live in the **QA Testing Notes** field (ENG-2754, ENG-2790, ENG-2925). Some have none at all (ENG-2062 says the AC "should be filled in" and it never was).
- Specs drift: ENG-1043 was written after development and edited since. Treat a story as possibly stale and confirm with the developer.

### QA Testing Notes (`customfield_10460`)

- **Written by the developer**, not QA. Good ones contain: What changed; Setup / prerequisites (sometimes SQL to create the state); numbered tests or an ID / Steps / Expected table; regression list with the highest-risk area named; and a section **"Not tested" / "Not covered by development" / "Measured by dev"**. That last section is the tester's real scope.
- Chatbot notes use Do / Expect / Record and an explicit **"Fail if"** list, split into admin and School User halves.
- Quality varies down to "n/a", "See comments" or a pointer to sub-tasks or repo docs. If the field is thin, look for a developer comment headed "What changed / How to access / How to test".
- Developers also fill **Release Notes** as "Note:" plus "Setup:".

### Bug reports

- QA-filed bugs use type **Bug - ENG** with the Client field set to "BusPlanner". Structure by author:
  - Old World (Hamad Zeb): Description, Repro Steps, Expected Result, Actual Result, Environment (site, build, database and its version, school year, user), **Severity and Priority as two separate values**. Screenshots go in the first comment.
  - Unified (Yusra Abbasi): Environment, Module / Feature, Severity with justification, Steps to Reproduce, Expected, Actual, Suspected Cause, Related, Reproducibility, Attachments. Chatbot bugs attach the "Copy debug log" export.
  - T&A (Wajeeha Batool): adds Preconditions / Test data and Impact, and cites test-case IDs.
- State whether the defect is **pre-existing or a regression** and who confirmed it ("confirmed with <dev>, not part of ENG-nnnn").
- If state was set by SQL on a QA database, say so in the report.
- Support-origin bugs (type Bug) carry Zendesk number, Client, Product Area, Version, Observed, Expected, "Questions for Dev"; some are one sentence and a screenshot.
- Priority and type are unreliable as signals: 521 of 2,873 issues are Highest, and requests get filed as bugs.

### Summaries and customer codes

- Customer code format: `CC-PP-CODE` (country, province/state, short code), e.g. `CA-ON-TSTG`, `US-FL-MDCPS`. It appears in 451 of 1,216 bug summaries; 170 start with a Zendesk number.
- Patterns in use: `[84794] [CA-AB-PRSD] - <text>`; `ZD #72519 - CA-ON-FBUS - <text>`; `[US-FL-MDCPS] BP Fleet: <text>`; `[BusPlanner] <text>` for internal; `BP Unified: <Module> - <text>` (111 bugs); `[QA] Regression <version> <train>` for QA tasks. Bracket use is inconsistent; follow the pattern of the product you are filing against.

### Labels

- Automation: `jira_escalated` (754; moved from SPT), `jira_auto_reopened` (204), `pss-stamped` (153; meaning unverified).
- Programme: `P30_BP_Unified` (189), `BP_Unified_Chatbot_v1.0` / `v1.5` / `v2.0`, `P28_Time_And_Attendance`, `P22_Tracker`.
- Product-bug family `Pnn_<Product>_Bug` (`P37_Web_Bug`, `P36_Pro_Bug`, `P44_BP_Unified_Bug`, `P42_Dispatch_Bug`, `P41_GPS_Bug`, `P39_App_Chipmunk_Bug`, `P31_Fleet_Bug`, `P32_Quick_Bug`): 3 to 14 uses each, so not applied consistently.
- Topic: `Ridership`, `TSTG`, `BPQuick`, `Reporting`, `rollover`, `spike`, `distance-units`, `ontario-reports-26`. `OBSOLETE` (9) marks dead tickets.
- 611 of 1,216 bugs have no label. Do not rely on labels to find things.

### How QA records results

- A comment headed **"QA Verification - <KEY> - Passed"** (or "Verified on QA"), then: environment (QA1 or QA2), **build number of every component**, database, browser; scope including what was not done; a table of Test / Expected / Result with tick marks and the actual figures seen; "Side observations (not this ticket)" with keys of any bugs logged; a closing line such as "Fix verified on QA1. Approved for release" (models: ENG-2905, ENG-2947, ENG-2967).
- Unified testers open with the database and environment ("QA STSBHN DB", "Canada-dev env"), copy the developer's test table and mark each case Pass / Fail with screenshots. Build numbers and an overall verdict are often missing there (ENG-773, ENG-2801, ENG-2818): add both.
- Regression sign-off: "PASSED" or "PASSED WITH EXCEPTIONS", sections Passed / Failed - bugs logged / Notes / Release decision, ending "QA signs off on <product> <build> for release".
- **Failing a ticket:** comment that @-mentions the developer, with a step / state / result table naming exactly which path fails (ENG-2947). In practice the status often stays in Ready for QA or QA Review after a fail (ENG-2880, ENG-773), so read the comments, not the status. Jira recorded 56 moves from QA Review back to Open / In Progress / Reopened in 180 days.
- Tickets hold real personal data (student and employee names and IDs), test-account emails and at least one site key. Never copy these into reports or test evidence.

### Cycle time from Ready for QA to done

- Release-bound Old World fixes turn around in 1 to 4 days: ENG-2967 merged 11-05, verified 11-06, released 11-06; ENG-2971 dev notes 11-04, QA 11-06; ENG-2947 fail, fix and verify within 2 days; ENG-2905 created 10-29, passed 11-02. Regression tasks close the same day they are run.
- Unified (New World) work waits far longer: ENG-773 dev notes 2026-07-27, QA results 2026-11-06; ENG-2062 three weeks; ENG-2801 and ENG-2818 about two weeks.
- Of the 126 issues in Ready for QA, 106 have not changed status for more than 7 days, 66 for more than 30 days and 42 for more than 60 days.
- A per-ticket median for Ready for QA to Approved for Release could not be computed: changelogs were not read.

## F. In flight on 2026-11-10

**Sprint:** ENG Sprint 91, Oct 31 - Nov 13, 491 issues (Jira count). Done-category 96; In Progress / Code Review / Investigation / Blocked 146; Open or Reopened 118; Ready for QA or QA Review 133. Sprint 92 starts Nov 13.

**Unreleased fix versions:**

| Version | Issues | Status mix | Notes |
|---|---|---|---|
| 13.4.3 - BusPlanner Main - Hotfix | 3 | QA Review 2, Ready for QA 1 | Path Server / eligibility: ENG-3043, ENG-3050, ENG-3051. **Entirely waiting on QA** |
| 13.4.4- BusPlanner Main | 25 | Approved for Release 12, Code Review 7, QA Review 3, In Progress 2, Ready for QA 1 | Next weekly Main release |
| 13.4.5 - BusPlanner Main | 0 | - | Placeholder |
| 12.4.15 - Miami Fleet | 5 | Code Review 4, Ready for QA 1 | US-FL-MDCPS purchase-order and parts fixes; ENG-2726 is ready |
| 11.2026 - New World | 38 | Ready for QA 26, Code Review 5, QA Review 3, Approved for Release 3, Resolved 1 | **29 of 38 waiting on QA** |
| 2.8.10.2026 - New World | 41 | Approved for Release 33, Ready for QA 5, Resolved 1, QA Review 1, In Progress 1 | Dated Oct 8, not marked released |
| T&A - Yankton | 6 | Resolved 4, RELEASED 2 | Go-live marker for US-SD-YSD |

**Other live threads:** CVE remediation with a Nov 10 deadline (epic ENG-3036; ENG-3037 Ready for QA). Release Management epic ENG-3042 holds the regression tasks. Mobile platform compliance (ENG-1580, 7 of 8 children open; 17 bugs found in testing under ENG-2646, all open). Unified Dispatch epics A-J (ENG-1619..1627) are mostly Open with all children open: not yet a QA concern.

**Waiting on QA today:** 126 Ready for QA, 12 QA Review, 9 epics In QA (147 in total; 138 excluding epics).

- By area (non-epic): Chatbot about 33 (25 under ENG-2917 plus feature epics), Unified GPS+ about 43, Unified T&A about 23, Unified Login Flow 8, Unified setup / tech debt / readers 10, Old World and other about 21 (Path Server hotfix 3, BP Web 2, Chipmunk-Tracker robustness 2, Fleet 1, others).
- By type: Story 40, Bug - ENG 34, Task 29, Bug 27, Sub-task 8. By priority: Highest 35, High 12, Medium 93, Low 7.
- **111 of the 138 have no QA Reviewer.** Assigned: Yusra Abbasi 10, Mitchell Bland 7, Hamad Zeb 3, Stephen Hu 2, one each for Dong-Ik Lee, Wajeeha Batool, Muhammad Ali, Ali Janjua, Nikki Tilano.
- 104 of the 147 have no fix version; 35 are tagged for the two New World versions; 8 for Main / Fleet.
- Suggested order for a new tester: (1) 13.4.3 hotfix trio; (2) 13.4.4 and 12.4.15 items; (3) older Highest-priority items (ENG-1597, ENG-2065, ENG-2516, ENG-2740); (4) the `11.2026 - New World` set; (5) the long tail with no fix version, after asking which are still wanted.

## QA queue snapshot (2026-11-10)

Source: statuses as pulled on 2026-11-10, about 09:00 Eastern. "Area" is the component when one is set, otherwise the parent epic (components are almost never set). Age is given two ways because time-in-status was not read: days since the issue was last updated, and days since it was created. Sorted oldest update first within each status.

### QA Review (12)

| Key | Type / Priority | Summary | Area (component, else parent epic) | Fix version | QA Reviewer | Days since update / since created |
|---|---|---|---|---|---|---|
| ENG-785 | Story / Highest | BP Unified: T&A - Rounding rules configuration | MVP - Time and Attendance | - | Hamad Zeb | 10 / 126 |
| ENG-1043 | Story / High | BP Unified: GPS+ v1 - Live Viewer (MAIN) | MVP - GPS+ Live Viewer | - | Yusra Abbasi | 10 / 106 |
| ENG-2062 | Story / Medium | BP Unified: GPS+ Path & Stop Compare / Event Viewer — display substituted routes correctly | BP Unified: GPS+ Path & Stop Compare | 2.8.10.2026 NW | Yusra Abbasi | 10 / 60 |
| ENG-391 | Bug / Highest | CA-ON-STSYR ZD #33311 SSO Login Failure – BusPlanner Web (OpenID Connect / Azure Entra ID) | BusPlanner Web: Production Bugs | 13.4.4- BusPlanner Main | - | 4 / 151 |
| ENG-2818 | Bug - ENG / High | Chatbot - Planned vs actual doesn't display for runs | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 17 |
| ENG-773 | Story / Highest | BP Unified: T&A - Verify Pay Periods against PRD | MVP - Time and Attendance | - | Wajeeha Batool | 3 / 126 |
| ENG-2922 | Bug / Medium | BP Unified: Chatbot - Ask AI: Collapsed Thinking panel re-expands on its own and doesn’t sta... | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 1 / 11 |
| ENG-1997 | Bug / Highest | [72466] [CA-ON-STSYR] - BP Web consistently getting disconnected | BusPlanner Web: Production Bugs | 13.4.4- BusPlanner Main | Hamad Zeb | 1 / 63 |
| ENG-2801 | Bug - ENG / Medium | Adding permisson leads to map drawing | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 0 / 18 |
| ENG-2012 | Sub-task / Medium | Dispose RemoteDatabase in the TSTG workflow forms that create it without using | [72466] [CA-ON-STSYR] - BP Web consistentl... | 13.4.4- BusPlanner Main | Dong-Ik Lee | 0 / 62 |
| ENG-3043 | Bug / Highest | [CA-AB-CCSD] Eligibility still not calculated for schools after 13.4.2 hotfix (follow-up to ... | - | 13.4.3 Main - Hotfix | Yusra Abbasi | 0 / 1 |
| ENG-3050 | Bug - ENG / Medium | [BusPlanner] Path Server aborts the whole service on a shortest-path request whose start or ... | - | 13.4.3 Main - Hotfix | Hamad Zeb | 0 / 0 |

### In QA (9)

| Key | Type / Priority | Summary | Area (component, else parent epic) | Fix version | QA Reviewer | Days since update / since created |
|---|---|---|---|---|---|---|
| ENG-2470 | Epic / Highest | BP Web - PGCPS - New condensed directions reports: Route Directions by Route and by Run (Gen... | BP Web & Quick - US-MD-PGCPS - New "Run Di... | - | - | 21 / 43 |
| ENG-1872 | Epic / Medium | BP Unified: Chatbot - UI Display Tools | BP Unified: Chatbot - v1 | - | - | 19 / 71 |
| ENG-1873 | Epic / Medium | BP Unified: Chatbot - GPS Feature | BP Unified: Chatbot - v1 | - | - | 17 / 71 |
| ENG-1871 | Epic / Medium | BP Unified: Chatbot - PLANNED Feature | BP Unified: Chatbot - v1 | - | - | 15 / 71 |
| ENG-1870 | Epic / Medium | BP Unified: Chatbot - Agentic Core | BP Unified: Chatbot - v1 | - | - | 15 / 71 |
| ENG-2118 | Epic / Medium | BP Unified: Chatbot - v1.5 - QA & Docs | BP Unified: Chatbot - v1.5 | - | - | 13 / 56 |
| ENG-2133 | Epic / Medium | BP Unified: Chatbot - v1.5 - GPSPLUS Feature | BP Unified: Chatbot - v1.5 | - | - | 13 / 55 |
| ENG-1876 | Epic / Medium | BP Unified: Chatbot - Testing & Evals | BP Unified: Chatbot - v1 | - | - | 13 / 71 |
| ENG-3 | Epic / Medium | T&A Core: Employee & Payroll Setup - BP Unified | BP Unified: Time and Attendance Core | - | - | 5 / 180 |

### Ready for QA (126)

| Key | Type / Priority | Summary | Area (component, else parent epic) | Fix version | QA Reviewer | Days since update / since created |
|---|---|---|---|---|---|---|
| ENG-755 | Story / Medium | Test ticket Blocked | test epic 1 | - | Nikki Tilano | 46 / 130 |
| ENG-2122 | Sub-task / Highest | BP Unified: GPS+ Path & Stop Compare - Show substituted routes | BP Unified: GPS+ Path & Stop Compare / Eve... | - | - | 42 / 56 |
| ENG-2123 | Sub-task / Highest | BP Unified: GPS+ Event Viewer - Show substituted routes | BP Unified: GPS+ Path & Stop Compare / Eve... | - | - | 42 / 56 |
| ENG-2124 | Sub-task / Highest | BP Unified: GPS+ Live Viewer - Show substituted routes | BP Unified: GPS+ Path & Stop Compare / Eve... | - | - | 42 / 56 |
| ENG-2375 | Sub-task / Medium | ST-1 — Deterministic whole-route lookup (resolve to the canonical, non-spare route) | BP Unified: GPS+: route switches between t... | - | - | 22 / 39 |
| ENG-2376 | Sub-task / Medium | ST-2 — Enforce run > route precedence (coverage-aware whole-route substitution) | BP Unified: GPS+: route switches between t... | - | - | 22 / 39 |
| ENG-2377 | Sub-task / Medium | ST-3 — Idempotency guard (write only on a real vehicle difference) | BP Unified: GPS+: route switches between t... | - | - | 22 / 39 |
| ENG-2378 | Sub-task / Medium | ST-4 — Regression test harness (converged-state + idempotency, cases A–D) | BP Unified: GPS+: route switches between t... | - | - | 22 / 39 |
| ENG-2037 | Task / Medium | BP Unified GPS+ - API to stop logging client aborts as 500s | BP Unified: GPS+ - Features/Tasks Reserved... | - | - | 19 / 62 |
| ENG-2806 | Task / Medium | BP Unified: Chatbot UI- Additonal Map Icons | BP Unified: Chatbot - UI Display Tools | - | - | 13 / 18 |
| ENG-2583 | Story / Highest | BP Unified: GPS+ Live Viewer - New World API to apply substitution and driver changes throug... | BP Unified: GPS+ Live Viewer - Route Manag... | - | Yusra Abbasi | 13 / 31 |
| ENG-2390 | Bug - ENG / Medium | BP Unified: GPS+ Event Viewer - Map legend shows actual distance in miles for metric clients | BP Unified: GPS+ - Production & QA Bugs | - | - | 11 / 39 |
| ENG-1080 | Task / Medium | BP Unified: Login Flow - [V1] Apply Unified Login Visual Design & Official Wordmark | BP Unified: Login Flow V1 | - | - | 10 / 104 |
| ENG-2394 | Bug - ENG / Medium | BP Unified: GPS+ Live Viewer - Grid, pinned strip or map stay stale after a change during a ... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2362 | Task / Medium | BP Unified: GPS+ - optimize request for more than 1 status at once | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 40 |
| ENG-884 | Bug / Highest | BP Unified: ETL - Pln_employee_vehicle populated for all customers, leaking assignments acro... | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-1068 | Story / Medium | BP Unified: Login Flow - [V1] Wrong-Password Feedback | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-786 | Story / Highest | BP Unified: T&A - Tolerance thresholds configuration | MVP - Time and Attendance | - | - | 10 / 126 |
| ENG-1196 | Story / Low | BP Unified: GPS+ v1 - Permissions | MVP - GPS+ Live Viewer | - | Yusra Abbasi | 10 / 95 |
| ENG-1193 | Story / Medium | BP Unified: GPS+ - Stop Classification Service System (multi-tenant) | MVP - GPS+ Live Viewer | - | Stephen.Hu | 10 / 95 |
| ENG-1164 | Story / Medium | Chipmunk: Email alert on Tracker status change (good → bad) | Chipmunk-Robustness | - | Mitchell.Bland | 10 / 96 |
| ENG-1069 | Story / Medium | BP Unified: Login Flow - [V1] Change Email from the Password Screen | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-1060 | Story / Medium | BP Unified: T&A - Recalculate payable hours after changing a rounding rule | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 105 |
| ENG-1910 | Story / Medium | BP Unified: Chatbot - On-time performance endpoint | BP Unified: Chatbot - v1.5 - GPSPLUS Feature | - | - | 10 / 71 |
| ENG-2338 | Task / Low | BP Unified: GPS+ - [perfomance] First request after an API start pays a large cold penalty | BP Unified: GPS+ - Production & QA Bugs | 2.8.10.2026 NW | - | 10 / 42 |
| ENG-2322 | Task / Medium | BP Unified: GPS+ - Performance evaluation | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 43 |
| ENG-1908 | Story / Medium | BP Unified: Chatbot - Trend period comparison | BP Unified: Chatbot - GPS Feature | - | - | 10 / 71 |
| ENG-421 | Task / Medium | BP Unified Schema - GPS Readers: Samsara | BP Unified: GPS Readers | - | - | 10 / 151 |
| ENG-1282 | Task / Medium | BP Unified: GPS+ - Switch time zone IDs from IANA to Windows time zone IDs | MVP - GPS+ Live Viewer | - | - | 10 / 89 |
| ENG-883 | Bug / Highest | BP Unified: ETL - AVLVehicle mode uses COALESCE(avr.AVLVehicleGUID, r.VehicleGUID) on unrela... | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-2391 | Bug - ENG / Low | BP Unified: GPS+ Live Viewer - Empty fleet map falls back to Branford, CT instead of the dis... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2389 | Bug - ENG / Medium | BP Unified: GPS+ Live Viewer - Out-of-range page shows "No buses are out right now" while bu... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2387 | Bug - ENG / Medium | BP Unified: GPS+ Path & Stop Compare - Stale or unknown run ids give a silent empty report i... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2395 | Bug - ENG / Low | BP Unified: GPS+ Event Viewer / Path & Stop Compare - Superseded report requests are never c... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2399 | Task / Medium | BP Unified: GPS+ - Controller tests for Path & Stop Compare and Route Selection endpoints | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-2398 | Task / Medium | BP Unified: GPS+ - Route picker lists a substitute spare route under the same label as the r... | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-1351 | Task / Medium | BP Unified: normalize customer time zone to a Windows ID on write (guard for ENG-1282) | BP Unified: GPS+ Live Viewer | - | - | 10 / 84 |
| ENG-2061 | Bug - ENG / Highest | BP Unified: GPS+ Path & Stop Compare / Event Viewer — filter out GPS-substituted routes inst... | BP Unified: GPS+ Path & Stop Compare | - | Muhammad Ali | 10 / 60 |
| ENG-819 | Story / Highest | Verifying the rounding rules and tolerance threshold behaviour on the existing reporting | MVP - Time and Attendance | - | - | 10 / 123 |
| ENG-1917 | Task / Medium | BP Unified: Chatbot - Security and prompt-injection review | BP Unified: Chatbot - v1.5 - QA & Docs | - | - | 10 / 71 |
| ENG-1914 | Task / Medium | BP Unified: Chatbot - Eval harness and seed cases | BP Unified: Chatbot - Testing & Evals | 2.8.10.2026 NW | - | 10 / 71 |
| ENG-2604 | Story / Highest | BP Unified: GPS+ Live Viewer - Reassign driver through BP Info and show it in today's plan [... | BP Unified: GPS+ Live Viewer - Route Manag... | - | Yusra Abbasi | 10 / 27 |
| ENG-2385 | Bug - ENG / High | BP Unified: GPS+ - Blank or over-long run ids return 500 instead of 400 (Event Viewer, Compare) | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-1104 | Story / Medium | BP Unified: Login Flow - Privacy Policy and Terms of Services Should be Linked | BP Unified: Login Flow V1 | - | - | 10 / 102 |
| ENG-1166 | Task / Medium | Chipmunk: Add missing monitoring APIs to real-time Tracker dashboard + live/refresh labeling | Chipmunk-Robustness | - | Mitchell.Bland | 10 / 96 |
| ENG-1194 | Story / Medium | BP Unified: GPS+ - Stop Classification Service System (multi-tenant) - Deployment | MVP - GPS+ Live Viewer | - | Stephen.Hu | 10 / 95 |
| ENG-2321 | Task / High | BP Unified: Stop Classification picks up vehicle substitutions without waiting for the daily... | BP Unified: GPS+ Foundations, Shared Servi... | 2.8.10.2026 NW | - | 10 / 43 |
| ENG-1358 | Bug / Medium | BP Unified: T&A - Grid Job Code and Vehicle dropdowns remain editable in a Closed/Exported (... | BP Unified: T&A - Bugs and General Tasks | 2.8.10.2026 NW | - | 10 / 83 |
| ENG-2582 | Story / Highest | BP Unified: GPS+ Live Viewer - Route management dialog [FE] | BP Unified: GPS+ Live Viewer - Route Manag... | - | Yusra Abbasi | 10 / 31 |
| ENG-2492 | Bug - ENG / Medium | BP Unified: GPS+ Compare - client tests fail on dev after ENG-2393 | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 35 |
| ENG-2401 | Task / Low | BP Unified: GPS+ - jest-axe sweeps for the remaining GPS+ components | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 39 |
| ENG-800 | Story / Medium | BP Unified: Setup - Add RLS objects, user associations & basic testing to Setup (GPS+ etc.) | BP Unified: Setup - Depots & Row Level Sec... | - | - | 10 / 125 |
| ENG-801 | Story / Medium | BP Unified: Setup - Add Depot data to ETL | BP Unified: Setup - Depots & Row Level Sec... | - | - | 10 / 125 |
| ENG-802 | Story / Medium | BP Unified: Setup - Add Depot to T&A Department relationship & UI | BP Unified: Setup - Depots & Row Level Sec... | - | - | 10 / 125 |
| ENG-2157 | Bug - ENG / High | BP Unified: GPS+ Path & Stop Compare - Enforce operator/depot grant filtering | BP Unified: GPS+ Path & Stop Compare | - | - | 10 / 54 |
| ENG-882 | Bug / Highest | BP Unified: ETL - Load service parses times in load server's local timezone instead of custo... | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-795 | Bug / Highest | BP Unified: ETL - icorrect run and busstop types | BP Unified: Tech Debt | - | Yusra Abbasi | 10 / 125 |
| ENG-799 | Story / Medium | BP Unified: Setup - Verify T&A implements RLS correctly | BP Unified: Setup - Depots & Row Level Sec... | - | - | 10 / 125 |
| ENG-1059 | Story / Medium | BP Unified: T&A - Setting for decimal hours vs hh:mm | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 105 |
| ENG-881 | Bug / Highest | BP Unified: ETL - ETL doesn't migrate BPL_VehicleStaff | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-1003 | Task / Highest | BP Unified: GPS Reader Service — convert to cross-platform .NET 8 Worker Service | BP Unified: GPS Readers | - | - | 10 / 110 |
| ENG-1064 | Story / Medium | BP Unified: Login Flow - [V1] Account Not Found on Email Lookup | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-1053 | Task / Medium | BP Unified: T&A Make post-login icon client Agnostic | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-1058 | Story / Medium | BP Unified: T&A - Edit time record: actual hours in AM/PM, edited in 24h | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 105 |
| ENG-1018 | Task / Medium | BP Unified: [API] Add bearer-token auth to Swagger UI with per-endpoint security indicators | BP Unified: Tech Debt | - | - | 10 / 109 |
| ENG-1016 | Bug / Medium | T&A: Sidebar does not match design — icon set, typography, and collapse/expand behavior missing | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 109 |
| ENG-1004 | Task / High | BP Unified: GPS Reader Service — make the pipeline fully asynchronous | BP Unified: GPS Readers | - | - | 10 / 110 |
| ENG-2359 | Bug - ENG / Medium | BP Unified: GPS+: route switches between two buses on every substitution import poll | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 40 |
| ENG-986 | Task / Medium | Improve the MigrationTool | BP Unified: Tech Debt | - | - | 10 / 111 |
| ENG-893 | Bug / Medium | T&A - make delta time N/A if the employee doesn't have a schedule | T&A Core: Employee & Payroll Setup - BP Un... | 2.8.10.2026 NW | - | 10 / 117 |
| ENG-880 | Bug / Highest | BP Unified: ETL - Retired students imported as is_active=1 | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-871 | Bug / Highest | BP Unified: T&A - missing permission checks | T&A Core: Employee & Payroll Setup - BP Un... | - | - | 10 / 119 |
| ENG-878 | Bug / Highest | BP Unified: ETL - Pln_zone updated in-place instead of soft-delete + recreate | BP Unified: T&A - Bugs and General Tasks | - | - | 10 / 118 |
| ENG-1063 | Story / Medium | BP Unified: Login Flow - [V1] Enter Email to Begin Sign-In | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-775 | Story / Medium | BP Unified: T&A - Locations CRUD | BP Unified: T&A - Locations & Geofences | - | - | 10 / 126 |
| ENG-1048 | Story / Medium | T&A - Job Codes table view and add/edit modal need "Requires Vehicle" option | MVP - Time and Attendance | - | - | 10 / 105 |
| ENG-1067 | Story / Medium | BP Unified: Login Flow - [V1] Sign In with Password | BP Unified: Login Flow V1 | - | - | 10 / 105 |
| ENG-1931 | Story / Highest | GPS+ data-quality fixes + CA staging login secret | BP Unified: GPS+ Foundations, Shared Servi... | - | - | 10 / 70 |
| ENG-2226 | Task / Medium | BP Unified: GPS+ - Improve integration test fixture to avoid shared DB collision testing | BP Unified: GPS+ - Production & QA Bugs | - | - | 10 / 47 |
| ENG-2156 | Bug - ENG / Highest | BP Unified: GPS+ Path & Stop Compare - Stop classification returns zero planned stops during... | BP Unified: GPS+ Path & Stop Compare | - | - | 10 / 54 |
| ENG-2109 | Bug / High | BP Unified: GPS+ ETL - fix VehicleOperatorTable write | BP Unified: GPS+ Foundations, Shared Servi... | - | - | 10 / 57 |
| ENG-2688 | Task / Medium | BP Unified: GPS+ Route Management - Remove the route-reassign mass-diff guard | BP Unified: GPS+ Live Viewer - Route Manag... | - | - | 10 / 25 |
| ENG-2619 | Bug - ENG / Medium | BP Unified: GPS+ Live Viewer - Bus change to a Zonar bus with no serial is sent to BP Info b... | BP Unified: GPS+ Live Viewer - Route Manag... | - | - | 10 / 26 |
| ENG-2817 | Story / Medium | BP Unified: Chatbot - On-time performance by operator (monthly scorecard) | BP Unified: Chatbot - GPS Feature | - | - | 10 / 17 |
| ENG-2816 | Story / Medium | BP Unified: Chatbot - Find students by parent phone or email, and pull parent email lists | BP Unified: Chatbot - PLANNED Feature | - | - | 10 / 17 |
| ENG-8 | Story / Medium | BP Unified Schema - Time & Attendance: Finalization | T&A Core: Cleanup and Finalization - BP Un... | - | - | 8 / 180 |
| ENG-627 | Story / Medium | BP Unified Schema - Time & Attendance - Redo UI based on new design | T&A Core: Employee & Payroll Setup - BP Un... | - | Yusra Abbasi | 8 / 146 |
| ENG-2747 | Bug / Highest | New World ETL - Students missing from their bus stops, and stop assignments show the wrong p... | BP Unified: Chatbot - Bugs | - | - | 6 / 20 |
| ENG-2963 | Bug - ENG / High | BP Unified: Base schema on main declares dev_device.device_id and dev_device.vehicle_name twice | GPS+ New World Customer Stand-Up | - | - | 6 / 7 |
| ENG-2860 | Bug - ENG / Medium | BP Unified: Chatbot - Morning capacity lists include routes with no morning run | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 14 |
| ENG-2878 | Bug - ENG / Medium | BP Unified: Chatbot - Ride time says today's unfinished runs have no planned duration | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 13 |
| ENG-2877 | Bug - ENG / Medium | BP Unified: Chatbot - Ride time shows 0 minutes for a run the bus ran early | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 13 |
| ENG-2859 | Bug - ENG / Medium | BP Unified: Chatbot - Capacity questions for a school time out | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 14 |
| ENG-2685 | Bug / Low | Chatbot - resuming conversations don't scroll to the bottom | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 25 |
| ENG-2819 | Bug - ENG / Medium | BP Unified: Chatbot - Missing-address check fails when a grade is named | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 17 |
| ENG-2820 | Bug - ENG / Medium | BP Unified: Chatbot - Plan status shows bus-swap times as the import time | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 17 |
| ENG-2875 | Bug - ENG / Medium | BP Unified: Chatbot - Driver changes made through route management don't show for past plan ... | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 13 |
| ENG-2636 | Bug / Medium | Chatbot - refuses to show charts unless for GPS data | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 26 |
| ENG-2921 | Bug / Medium | BP Unified: Chatbot - Ask AI: “Thinking” indicator from a running conversation briefly appea... | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 11 |
| ENG-2914 | Task / Medium | Chatbot - accurate token counts | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 11 |
| ENG-2946 | Bug / Medium | BP Unified: Chatbot - Ask AI: Invalid PDF upload shows a raw “Network Error” instead of the ... | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 7 |
| ENG-2910 | Bug - ENG / Medium | BP Unified: Chatbot - On-time performance by school times out | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 11 |
| ENG-2755 | Task / Medium | Chatbot - ask the user what they meant when a question is unclear | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 20 |
| ENG-2882 | Bug - ENG / Low | BP Unified: Chatbot - A route number asked about "on route" is reported as not existing | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 13 |
| ENG-2911 | Bug - ENG / Medium | BP Unified: Chatbot - On-time performance question shows no route table | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 3 / 11 |
| ENG-1597 | Bug / Highest | BP Unified: T&A - Revoking a delete permission does not hide/disable the Delete controls (en... | BP Unified: T&A - Bugs and General Tasks | 11.2026 NW | - | 3 / 75 |
| ENG-2516 | Bug - ENG / Highest | BP Unified: T&A - Adding a new record to an approved timecard does not reopen it to Outstanding | T&A Core: Cleanup and Finalization - BP Un... | 11.2026 NW | - | 3 / 33 |
| ENG-2740 | Bug - ENG / Highest | Mobile clock-out overwrites payable from raw punches, silently discarding the supervisor's t... | BP Unified: T&A - Bugs and General Tasks | 11.2026 NW | - | 3 / 21 |
| ENG-1534 | Story / Medium | BP Unified: Time & Attendance - Nash - [Payroll Export] Generate LINQ scan-pair CSV payroll ... | BP Unified: Time & Attendance - Nash - Exp... | 11.2026 NW | - | 3 / 80 |
| ENG-2795 | Story / High | BP Unified: Chatbot - Open chat in a right-side pane instead of a floating window (Rovo-style) | BP Unified: Chatbot - v1.5 - UI Display Tools | - | - | 3 / 18 |
| ENG-2518 | Story / Medium | Allow overlapping pay periods, with explicit period selection on export | Pay Periods (T&A) | 11.2026 NW | - | 3 / 33 |
| ENG-3011 | Bug - ENG / High | BP Unified: Chatbot - Requests frequently fail with "Network Error (ERR_NETWORK)", usually a... | BP Unified: Chatbot - Bugs | - | - | 1 / 4 |
| ENG-2065 | Bug / Highest | [72945] [CA-AB-PSD] - GPS Path Compare - Specific routes cannot pull runs | GPS / GPS+ Production Bugs | 13.4.4- BusPlanner Main | Ali Janjua | 1 / 61 |
| ENG-2926 | Bug - ENG / Medium | Chatbot - GPS questions time out for district users | BP Unified: Chatbot - Bugs | 11.2026 NW | - | 0 / 10 |
| ENG-3037 | Task / Highest | Rebuild and redeploy Unified container images on .NET 8.0.33 | CVE-2026-111497 (Brotli) Remediation | - | - | 0 / 3 |
| ENG-2925 | Bug - ENG / Medium | Chatbot - user currently needs a ta permission to see chatbot page | BP Unified: Chatbot - Bugs | 11.2026 NW | Mitchell.Bland | 0 / 11 |
| ENG-2924 | Bug - ENG / Medium | Chatbot - Daily stop coverage doesn't show chart | BP Unified: Chatbot - Bugs | 11.2026 NW | Mitchell.Bland | 0 / 11 |
| ENG-2790 | Task / Medium | Chatbot - Enrollments and Addresses missing for students | BP Unified: Chatbot - PLANNED Feature | - | Mitchell.Bland | 0 / 19 |
| ENG-2754 | Task / Medium | Chatbot - only using specific tools that exist for querying data | BP Unified: Chatbot - Agentic Core | - | Mitchell.Bland | 0 / 20 |
| ENG-2642 | Task / High | BP Unified: Chatbot - fix GPS tools permissions | BP Unified Chatbot: Quality & Feedback | - | Mitchell.Bland | 0 / 26 |
| ENG-3030 | Story / Highest | BP Unified: Chatbot - Update Ask AI icon and BusPlanner logo to the standardized versions us... | BP Unified: Chatbot - v1.5 - UI Display Tools | - | - | 0 / 4 |
| ENG-2904 | Bug - ENG / Medium | BP Unified: Chatbot - Stop coverage has contradictory figures | BP Unified: Chatbot - Bugs | - | - | 0 / 12 |
| ENG-2880 | Bug / High | GPS+ - Status Sort is Not Based on Lateness | BP Unified: GPS+ - Production & QA Bugs | 11.2026 NW | Yusra Abbasi | 0 / 13 |
| ENG-3051 | Bug / Medium | [BusPlanner] Path Server adds a path request's end point to the graph before its start point... | - | 13.4.3 Main - Hotfix | - | 0 / 0 |
| ENG-2789 | Bug / Highest | New World GPS+ - Only Stop ID is showing | BP Unified: GPS+ - Production & QA Bugs | 11.2026 NW | - | 0 / 21 |
| ENG-2726 | Bug / Highest | [US-FL-MDCPS] BP Fleet: Missing Parts left open on Completed/Closed work orders, so charged ... | BP Fleet: Production Bugs | 12.4.15 Fleet | - | 0 / 24 |

## Read coverage

**Read in full (description, QA Testing Notes, Release Notes, links, every comment): 80 ENG issues.** Listed in section D. The text was exported complete and digested by four reader sub-agents (20 issues each); the main agent worked from their digests, not the raw text.

**Read at description level (first part of the description only):** all 184 ENG epics; all 28 PROD epics and 66 PROD Features (title, status, parent, first lines).

**Read at summary level (title and fields, no body), complete, not sampled:** all 2,879 ENG issues. Of the 1,216 bug summaries, all were classified by rule and 83 were read individually; the rest were not each read by eye.

**Structure read completely:** project list with leads, issue types and counts; statuses per issue type for all six projects; ENG components (12) and fix versions (50); boards (5); sprints on the Dev board (17). Components and versions for PROD, SPT and IN were checked and are empty.

**Counts only (no content):** PROD by issue type; children of PROD epics; SPT open count; sprint 91 by status group; status-change ages for Ready for QA; QA Review fail-backs.

**Not read:**
- Bodies and comments of the other 2,799 ENG issues, including 353 of the 385 Highest/High bugs from the last 90 days, 100 of the 147 issues in a QA status, and 117 of the 145 recent QA-staff issues.
- Any PROD Feature Request (616) or PROD Capability / Product / Task / Story (133) beyond a count.
- Any SPT (118), IN (234), SOC (71) or MDP (6) issue content. IN epics by title only.
- Changelogs (so no exact time-in-status or cycle-time medians), worklogs, attachments, images, linked pull requests, board configuration and quick filters, saved filters, dashboards, workflow transition rules and screens.
- Sprint membership per issue for closed sprints.
- Confluence, Slack and Azure DevOps (out of scope for this file).

**Known weaknesses:** bug themes are keyword- and parent-based, so a bug filed under the wrong bucket is counted there. Symptom tags are approximate. "Days since update" overstates freshness when someone merely commented. The Client field is blank on 134 bugs.
