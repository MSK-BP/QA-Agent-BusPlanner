# Confluence: full read of space PE (non-PRD slice) and personal spaces

> Read 2026-11-10 on `busplanner.atlassian.net`. Read-only. Every fact carries a page id: `PE/<id>` = `https://busplanner.atlassian.net/wiki/spaces/PE/pages/<id>`.
>
> Scope of this file: every item in space PE (Product / Engineering) whose title does NOT start with "PRD", plus the personal spaces. The "PRD ..." family (106 items) was read by a separate pass and is not covered here.
>
> Privacy: internal IP addresses, secret-manager URLs and ids, account ids, key names' values, hashes and certificate thumbprints that appear on some pages were deliberately not copied. Pages that hold such material are flagged "sensitive".
>
> Words used: SHIPPED = the page describes current behaviour. PROPOSED = design or request, not built. UNVERIFIED = my inference.

## 1. Page inventory

Space PE holds 212 content items (pages, live docs, folders, 1 database). 106 have a title starting "PRD" (other pass). **This slice: 106 items = 76 pages (5 of them are live docs: 4 with content, 1 empty) + 1 database + 29 folders.** All 76 pages and the database were read in full (76 of 76). Folders have no body and are inventory only.

Tree source: descendants of the space home page (PE/9535653), depth 10. Dates are "last modified" from search.

### 1.1 Process, QA and team pages

| Page id | Title | Parent / section | Type | Summary | Updated |
|---|---|---|---|---|---|
| 9535653 | Product / Engineering Home | space root | page | "Engineering Hub" placeholder; quick links are WIP with no real targets. No onboarding content | 2026-09-23 |
| 235175938 | Build, Deployment and QA Testing Process | Knowledge Transfers > QA Training Documents | page | The pipeline: QA gate on `dev`, QA1, weekly promote, QA2 regression, release; statuses; Slack channels | 2026-10-27 |
| 235470851 | How to Write a Proper Bug | Knowledge Transfers > QA Training Documents | page | 7-point bug checklist, examples | 2026-10-26 |
| 50429953 | Release Train and Merge Queue Process | Process Improvements | page | The proposal that introduced the QA gate; problem, solution, constraints | 2026-07-17 |
| 174850052 | ENG Board - Jira Issue Type Guide | Process Improvements | page | Issue types, origin of each, SPT/PROD flow | 2026-09-30 |
| 59310084 | Dev Sprint Process | Engineering Sprint Schedule | page | Stub ("In progress"): 2-week sprints, Monday kickoff, Friday retro | 2026-07-24 |
| 59998210 | Important Dates - Engineering - 2026 | Engineering Sprint Schedule | database | 51 rows: sprint starts/ends, stage promotions, releases, Jul 3 to Oct 2 2026. Read as CSV. Stale after Oct 2 | 2026-10-06 |
| 9699329 | Daily Standup Agenda | Notes and Agenda | page | Running agenda table (owner, item); mostly undated one-liners | 2026-11-09 |
| 87031810 | Deep Dive Agenda | Notes and Agenda | page | Running agenda of design deep dives | 2026-11-06 |
| 158662658 | School Opening 2026: Retrospective | Team Retrospectives | page | Retro of the Aug-Sep 2026 peak; 15 calls to action | 2026-10-15 |
| 256081921 | RCA: Alberta Geotab GPS times 60 min behind (IN-221) - Nov 3-4, 2026 | RCA's | page | Incident write-up: timeline, root cause, 15 actions | 2026-11-09 |
| 79757313 | Tracker - Diagnosing and Fixing Set Up Issues | Knowledge Transfers | page | Old World tracker troubleshooting notes from a knowledge-transfer meeting. Sensitive (cert thumbprint, a customer host) | 2026-08-11 |
| 177668097 | Finance Contracts Setup/Training | Knowledge Transfers | page | How developers edit and test per-client finance contracts (XML + Lua) in BP Pro | 2026-10-06 |

### 1.2 New World (BusPlanner Unified) pages

| Page id | Title | Parent / section | Type | Summary | Updated |
|---|---|---|---|---|---|
| 137920519 | Module Overview | New World PRD's and Documentation > GPS+ | page | Index: GPS+ V1 = Live Viewer, Event Viewer, Path & Stop Compare | 2026-09-14 |
| 138215425 | Live Viewer | GPS+ | page | Stub, "DEV COMPLETE - V1"; Jira links | 2026-09-14 |
| 138313730 | GPS+ Live Viewer — QA & Product Handoff | GPS+ > Live Viewer | page | 14 use cases, scenarios, 18 business rules, 11 limitations, roles, Q&A | 2026-09-29 |
| 138346501 | Event Viewer | GPS+ | page | Stub, "DEV COMPLETE - V1"; Jira links | 2026-09-14 |
| 137822221 | GPS+ Event Viewer — QA & Product Handoff | GPS+ > Event Viewer | page | 10 use cases, 17 business rules, 6 limitations | 2026-09-14 |
| 138510338 | Path & Stop Compare | GPS+ | page | Stub, "DEV COMPLETE - V1"; Jira links | 2026-09-14 |
| 139231233 | GPS+ Path & Stop Compare — QA & Product Handoff | GPS+ > Path & Stop Compare | page | 17 use cases, 32 business rules, 12 limitations | 2026-09-18 |
| 174227457 | GPS services scalability | GPS+ | live doc | Draft: how the 3 GPS background services run today and a lease-based scaling proposal | 2026-09-30 |
| 137232386 | AI Assistant — Question Scope (V1) | AI Assistant (Chatbot) | page | The 42 questions the chatbot is scoped to answer, with flags and release labels | 2026-09-12 |
| 156794883 | GPS Substitution Service Setup | New Client Standup | page | BP Info REST user and app settings for the substitution import | 2026-09-23 |
| 157450256 | GPS+ New Customer Stand-Up Checklist | New Client Standup | page | 7-step stand-up template with a QA health check (Q.1-Q.6) and handoff | 2026-10-07 |
| 193462274 | GPS+ Stand-Up Checklist – Landmark (NPSSTS) | New Client Standup | page | Filled copy for one customer; two blockers; QA checks not started | 2026-10-22 |
| 251756545 | New client stand-up runbook (BusPlanner Unified) | New Client Standup | page | Full step-by-step runbook P1, C1-C3, E1-E17, reference, troubleshooting, known issues. Work in progress. Sensitive | 2026-11-05 |
| 251789313 | New client stand-up: PowerShell commands | under 251756545 | page | PowerShell 7 twins of the runbook's shell commands. Sensitive | 2026-11-05 |
| 162430977 | JWT renewal (refresh tokens) | Proposal for reviews | page | Auth as built (60-min JWT) and a refresh-token design | 2026-09-25 |
| 195297284 | IBM Cloud Server Backups - Quick Start Guide | Infrastructure & Operations | page | SQL Server VM backups for both cloud accounts; names the dev/staging/prod servers. Sensitive (account and policy ids) | 2026-10-08 |
| 226918402 | Multi-day Vehicle Assignments - Phase 1 Design | New World PRD's and Documentation | page | Draft design: intent table, importer, resolver; 11 acceptance criteria | 2026-10-21 |
| 68255745 | Reassign Dashboard — Phasing (V1 / After ETA / V2 / V3) | space root | page | Feature list for New World Dispatch; phases undecided | 2026-07-30 |
| 220561412 | Reassign Dashboard — Developer Feedback (Vlad): Status Tracker | under 68255745 | page | Developer questions against the Reassign Dashboard PRD with status | 2026-10-20 |
| 225050641 | BusPlanner GPS Plus User Manual | CX Documentation | live doc | End-user manual of the New World GPS+ module, incl. Route Management and the assistant | 2026-10-30 |
| 225673218 | Untitled live doc 2026-10-21 | CX Documentation | live doc | Empty | 2026-10-21 |

### 1.3 Old World, customer and escalation pages

| Page id | Title | Parent / section | Type | Summary | Updated |
|---|---|---|---|---|---|
| 136249345 | Suffolk API Requirements — DOR Enablement | Old World Documentation & PRD > BP Pro | page | Parent page: API needs of one large operator | 2026-09-14 |
| 136347650 | BP Pro — API Requirements (Suffolk DOR) | under 136249345 | page | Proposed write endpoints; as-is facts about the BP Pro API | 2026-10-08 |
| 136118274 | BusPlanner Trips — API Requirements (Suffolk DOR) | under 136249345 | page | Proposed read-only Trips API; as-is Trips data facts | 2026-10-08 |
| 167837697 | PGCPS Router Feature Requests: Delivery Plan | BP Pro | live doc | 10 routing feature requests in two phases | 2026-10-05 |
| 170721285 | Maryland (MSDE) Ridership & Accident Reports: Product Analysis | BP Pro | page | Field-by-field analysis of two state reports | 2026-10-09 |
| 163545089 | Thunderbay - Zones in BP Web/Parent Portal | Old World Documentation & PRD > BP Web | live doc | Weather-zone alert and report changes, 5 items | 2026-10-05 |
| 185204738 | Old-World Dispatch Escalations: Indian River, St. Johns and Clay | Escalations Meeting Notes > Old World Dispatch Escalations | page | Defect list and "bridge" design for three districts | 2026-10-05 |
| 210960386 | Miami Fleet Weekly Sync | Escalations Meeting Notes > Old World Fleet Escalations > Miami Fleet | page | Notes of the first weekly Fleet sync; fixes shipped and open asks | 2026-10-15 |
| 211517442 | Miami/Clay Fleet Jira Tasks | Miami Fleet | page | Jira-macro tracker; tables not returned by the API | 2026-10-19 |
| 212041732 | TSTG Jira Tasks | Escalations Meeting Notes | page | Jira-macro tracker; tables not returned by the API | 2026-10-19 |
| 214695940 | Miami-Dade BP Trips – Requirements Feasibility (Dev Review) | space root | page | Requirement-by-requirement feasibility against Trips SE code | 2026-10-16 |

### 1.4 Release notes

"Dev notes" pages are auto-titled "Release Notes - Development - <version> - <train> - <timestamp>". Parent is the folder "Release Notes > Release notes for 2026" unless noted. Issue counts are rows in each page's issue table.

| Page id | Version | Train | Issues | Headline | Created |
|---|---|---|---|---|---|
| 242876418 | Client Facing Release Notes | (Release Notes folder) | - | Client wording for 13.3.0.235 to 13.4.1.231, newest first | 2026-11-04 |
| 47841281 | 12.4.7 | Miami Fleet | 9 | VRO close rules, PO list performance | 2026-07-15 |
| 65667073 | 12.4.8 | Miami Fleet (child of 47841281) | 7 | Inventory Listing report, WO location | 2026-07-29 |
| 83492865 | 12.4.9 | Miami Fleet | 14 | User List features, account-period lock | 2026-08-14 |
| 106004482 | 12.4.10 | Miami Fleet | 16 | Non-stock returns, payment history | 2026-08-27 |
| 138706945 | 12.4.11 | Miami Fleet | 6 | Purchase Requisition dropping parts, PO totals | 2026-09-14 |
| 157253645 | 12.4.12 | Miami Fleet | 2 | Reminder count mismatch, create WO from reminders | 2026-09-23 |
| 205389841 | 12.4.13 | Miami Fleet | 2 | Transfer Receive Cutoff Date; lists QA task ENG-2441 | 2026-10-14 |
| 261160962 | 12.4.14 | Miami Fleet (space root) | 7 | Deadlocks, reminders, closed WO re-sent to ERP | 2026-11-06 |
| 57573378 | 13.1.9 | Main | 13 | Issue table only, no notes | 2026-07-23 |
| 57606145 | 13.1.10 | Main Hotfix | 11 | One customer's bugs and report features | 2026-07-23 |
| 66027522 | 13.1.11 | Main Hotfix | 1 | BP Info settings for Turns (T&A on Unified) | 2026-07-29 |
| 73990145 | 13.1.12 | Main | 19 | Trips SE budget codes, BP Web, Workflow | 2026-08-06 |
| 83951617 | 13.1.13 | Main Hotfix | 4 | Chipmunk wrong bus / login failures | 2026-08-14 |
| 88571905 | 13.1.14 | Main | 17 | Workflow rules, custom reports crash after upgrade | 2026-08-19 |
| 92864513 | 13.1.15 | Main Hotfix | 3 | Dispatch changes not reaching tracker / parents | 2026-08-20 |
| 109838342 | 13.2.0 | Main Hotfix | 4 | Performance indexes for one customer | 2026-08-28 |
| 121667588 | 13.2.1 | Main | 13 | First page grouped by product | 2026-09-02 |
| 130547713 | 13.2.2 | Main Hotfix (child of 123142145) | 2 | Route Changes PDF, duplicate Delays pushes | 2026-09-08 |
| 130711553 | 13.2.3 | Main Hotfix | 2 | Student Report omissions, tracker cache | 2026-09-08 |
| 138543106 | 13.2.4 | Main Hotfix | 3 | Wrong families notified on Modify Runs | 2026-09-14 |
| 151126018 | 13.2.5 | Main | 10 | Trips, Quick run merge, Workflow | 2026-09-21 |
| 152109057 | 13.2.6 | Main Hotfix | 1 | Dispatch notifications held until sent (ENG-1616) | 2026-09-22 |
| 169639937 | 13.2.7 | Main Hotfix | 4 | Buses on time when 25+ min late (fix in tracker) | 2026-09-29 |
| 178683906 | 13.3.0 | Main | 32 | Largest release; Verify DB Schema destroyed foreign keys | 2026-10-02 |
| 218759169 | 13.3.1 | Main | 23 | Notification fixes, GeoIMS losing workers | 2026-10-19 |
| 232685569 | 13.3.2 | Main Hotfix | 10 | Path Server / GeoIMS memory, condensed directions | 2026-10-23 |
| 246415361 | 13.4.0 | Main (space root) | 28 | Router features, ridership report suite | 2026-10-30 |
| 256868354 | 13.4.1 | Main Hotfix (space root) | 7 | Ontario Ministry report hotfix | 2026-11-04 |
| 262406145 | 13.4.2 | Main Hotfix (space root) | 2 | Path Server memory, Alberta GPS time | 2026-11-06 |
| 123142145 | 2.12.1 | Chipmunk | 1 | Show/hide password toggle | 2026-09-02 |
| 122683395 | 2.4.9 | Delays | 1 | Notification badge count | 2026-09-02 |

Totals across the 31 dev-notes pages: 274 issue rows. Main 8 releases / 155 issues; Main Hotfix 13 / 54; Miami Fleet 8 / 63; Chipmunk 1; Delays 1.

### 1.5 Folders (no body; inventory only)

| Folder id | Title | Parent | Children in this slice |
|---|---|---|---|
| 9666561 | Notes and Agenda | home | 9699329, 87031810 |
| 43122689 | Team Retrospectives | home | 158662658 |
| 43515905 | Release Notes | home | 242876418, folder 232357890 |
| 232357890 | Release notes for 2026 | Release Notes | 27 dev-notes pages (4 newer ones sit at space root) |
| 50397185 | Process Improvements | home | 50429953, 174850052 |
| 59441156 | Engineering Sprint Schedule | home | 59310084, database 59998210 |
| 79724545 | Knowledge Transfers | home | 79757313, 177668097, folder 203554817 |
| 203554817 | QA Training Documents | Knowledge Transfers | 235175938, 235470851 (only two pages) |
| 138018818 | New World PRD's and Documentation | home | Combined PRD, GPS+, AI Assistant, Unified Login, New Client Standup, Proposal for reviews, Infrastructure & Operations, 226918402 |
| 238682113 | Combined PRD | New World PRD's and Documentation | all "PRD · ..." pages (other pass) |
| 137887755 | GPS+ | New World PRD's and Documentation | 137920519, 138215425, 138510338, 138346501, 174227457 (+ "PRD: Vehicle ↔ Route Mapping (GPS+)" 238518274, other pass) |
| 140148737 | AI Assistant (Chatbot) | New World PRD's and Documentation | 137232386 |
| 58687491 | Unified Login | New World PRD's and Documentation | only PRD-titled pages (other pass) |
| 156139533 | New Client Standup | New World PRD's and Documentation | 156794883, 157450256, 193462274, 251756545 |
| 162398209 | Proposal for reviews | New World PRD's and Documentation | 162430977 |
| 195297282 | Infrastructure & Operations | New World PRD's and Documentation | 195297284 |
| 159744002 | Old World Documentation & PRD | home | Quick, BP Pro, Trips SE, Trips CE, Fleet, BP Web |
| 160366593 | Quick | Old World Documentation & PRD | only a PRD-titled page |
| 160399361 | BP Pro | Old World Documentation & PRD | 136249345, 167837697, 170721285 |
| 160432129 | Trips SE | Old World Documentation & PRD | empty |
| 160268290 | Trips CE | Old World Documentation & PRD | empty |
| 160333827 | Fleet | Old World Documentation & PRD | empty |
| 160333825 | BP Web | Old World Documentation & PRD | 163545089 (+ one PRD-titled page) |
| 211353602 | Escalations Meeting Notes | home | 2 folders, 212041732 |
| 211484673 | Old World Fleet Escalations | Escalations Meeting Notes | folder Miami Fleet |
| 211582977 | Miami Fleet | Old World Fleet Escalations | 211517442, 210960386 |
| 211451905 | Old World Dispatch Escalations | Escalations Meeting Notes | 185204738 |
| 226197507 | CX Documentation | home | 225673218, 225050641 |
| 256049153 | RCA's | home | 256081921 |

PRD-titled pages that live OUTSIDE the "Combined PRD" folder and look hand-written (excluded from this slice by the title rule; make sure the other pass covered them): 237043713 "PRD – Users and Access", 58851500 "PRD — Unified Login Flow", 250740737 "PRD — Turns: end-of-run check for students not scanned off" (all in folder Unified Login), 233144322 "PRD — Default Operator" (folder Quick), 247824423 "PRD · BP Info – Bulk Upload REST Users" (folder BP Web), 238518274 "PRD: Vehicle ↔ Route Mapping (GPS+)" (folder GPS+).

### 1.6 Personal spaces reviewed

55 spaces exist: PE plus 54 personal spaces. The personal spaces hold 111 content items in total. Every one is the auto-created "Overview" page except four: three copies of Atlassian's "Getting started in Confluence" template (80642149, 55607392, 9601119) and one untitled live doc (120356866), which is empty. **Nothing about engineering, QA, testing, releases or environments exists in any personal space.**

Spaces (owner names as shown): Abiya Shah, Ahnaf Rahman, Ali Janjua, Amanda McInnis, andy.tompkins, Aqib Usman, Awais Akram, barry.elliott, Binford Sloan, BusPlanner Integrations, Caroline Van Winden, chris.macleod, Cynthia Mendez, Daniel Sukhram, Deanna Maddux, Dong-Ik Lee, Drew Weeks, Emran Moradian, Farzan Hussain, Haley.Ace, Hamad Zeb, ibrahim ali asgher, Janice Fritz, Jason Ta, Jeff Langdon, Jennifer Murphy, Josh Rice, Lauri-Ann Turnbull, Lee.Medina, Logan Gillett, Maricar Benedictos, Marty Miller, Matthew Hayes, mbraun, Michel Walther, Michelle.Prichard, Mitchell.Bland, Muhammad Ali, Murtaza Khalil, Neil Campbell, Nikki Tilano, Pam Clapp, Peter Xiao, Sharaiz Khan, Shikhar Patel, Stephen.Hu, Swati Dash, Tommy Zwirbia, Umar Mir, vladislav.derbenev, Wajeeha Batool, Yash JJ, Yusra Abbasi, zach.robichaud.

## 2. QA and release process, complete

This section supersedes the summary in `process.md`. Every rule below is on a page; nothing is added.

### 2.1 The Old World pipeline (BusPlanner Main 13.x and Miami Fleet 12.4.x) — PE/235175938

The schedule is "the usual cadence, not a guarantee". Always confirm the current week's promote and release dates.

1. A developer opens a PR into `dev`. Nothing merges without one approval from the QA Reviewers group (currently Nikki, Murtaza, Andy, Yusra, Hamad). This is the QA gate.
2. `dev` is built nightly. A midday build can be requested in `#qa-env-updates` if QA runs out of work. The build deploys to **QA1**.
3. QA first pass happens on QA1 against what newly merged. "First pass" and "QA gate approval" are the same testing.
4. Weekly promote to Stage every Wednesday. The whole `dev` branch promotes as a batch; nothing is cherry-picked. It deploys to **QA2**.
5. Regression runs on QA2 for about 3 working days: Thursday, Friday, Monday.
6. Release on Tuesday. Main and Fleet releases alternate weekly.
7. If regression finds something, the fix goes back through `dev` and the same gate. PRs are not reverted to unblock a release.

Rules that follow from the page:
- A ticket in **Ready for QA** is tested on QA1.
- A status change to Ready for QA only counts once the next `dev` build has deployed to QA1. Testing before that tests old code. Compare the build/deploy time in `#qa-env-updates` with the time the ticket changed status.
- There is no merge notification. The signals are: Jira status (Code Review -> Ready for QA), the build, and the **QA Reviewer** field with the **My QA Items** quick filter on the Dev board.
- Functional testing (QA1) tests one ticket against its acceptance criteria. Regression (QA2) tests the combined batch for side effects and does not re-test each ticket. A ticket must pass functional testing before it is eligible for regression.
- **Approved for Release** is the signal for what survives the Wednesday promote.
- Main, Fleet and hotfixes share one Stage slot. Only one can occupy Stage at a time, so a hotfix can delay a promote. "My item didn't make it to QA2" can mean it was queued, not rejected.

Status workflow and where to write notes (PE/235175938):

| Status | Meaning | What QA writes |
|---|---|---|
| Ready for QA | Merged into `dev`, waiting for the next QA1 build | Nothing yet |
| QA Review | QA is testing on QA1 | Running notes in ticket comments |
| Approved for Release | First pass passed | Before the move: what was tested and why it passes, in the ticket's **QA Notes tab** (example on the page: "Tested X scenario on QA1, matches acceptance criteria, no issues found") |

### 2.2 Why the gate exists and its constraints — PE/50429953 (a proposal page, July 2026)

- Before the gate, developers merged into `dev` freely and the only control was telling them to stop. QA had a large untested backlog at promote time, and promotion was unblocked by reverting PRs so that only Approved for Release / Resolved work stayed in.
- The gate is a required-reviewer group on the `dev` branch policy in Azure DevOps. The group is called **PR-APPROVERS**. One approval is enough. It is "typically QA but Eng leads can Approve items that must make it in".
- A calendar freeze was rejected because the alternating Main/Fleet weeks leave no free multi-day window.
- QA gets about 3 working days for regression. The page calls that "a tight window for a full regression pass, especially on a large or risky batch".
- If QA lacks work, midday builds pull more items in (labelled a temporary solution).
- The page states: "BusPlanner does not have a dedicated QA or RC environment or machine, only the existing Stage environment." The October page (PE/235175938) describes QA1 and QA2, so this sentence reflects July. UNVERIFIED which is current for hardware.
- A cherry-pick release model was considered and judged risky (dependent PRs conflict).

### 2.3 What the release calendar shows actually happened — database PE/59998210

Event types: Sprint Start, Sprint End, Stage Promotion, Release, Fleet Stage Promotion, Fleet Release, Main-Hotfix-Stage Promotion, Main-Hotfix-Release. The last row is 2026-10-02, so the calendar is not maintained after that.

| Version | Promoted to Stage | Released | Note on the row |
|---|---|---|---|
| 12.4.7 Fleet | Jul 8 | Jul 16 | "QA Regression Testing starts after promotion is complete" |
| 13.1.10 Main Hotfix | Jul 23 | Jul 23 | "QA Targeted Regression Testing starts after promotion is complete" |
| 12.4.8 Fleet | Jul 23 | Jul 28 | regression after promotion |
| 13.1.11 Main Hotfix | Jul 29 | Jul 29 | "regression testing deemed not needed" (settings for New World on BPInfo) |
| 13.1.12 Main | Jul 30 | Aug 5 | moved one day because of PTO |
| 12.4.9 Fleet | Aug 6 | Aug 12 | |
| 13.1.13 Main Hotfix | Aug 12 | Aug 12 | |
| 13.1.14 Main | Aug 13 | Aug 18 | |
| 12.4.10 Fleet | Aug 19 | Aug 25 | |
| 13.1.15 Main Hotfix | Aug 20 | Aug 20 | |
| 13.2.1 Main | Aug 26 | Sep 1 | |
| 12.4.11 Fleet | Sep 2 | Sep 9 | |
| 13.2.4 Main Hotfix | Sep 10 | Sep 11 | |
| 13.2.5 Main | Sep 15 | Sep 16 | one day on Stage |
| 13.2.6 Main Hotfix | Sep 18 | Sep 21 | |
| 12.4.12 Fleet | Sep 21 | Sep 22 | one day on Stage |
| 13.2.7 Main Hotfix | Sep 25 | Sep 28 | |
| 13.3.0 Main | Sep 29 | Oct 1 | two days on Stage for the largest release (32 issues) |
| 12.4.13 Fleet | Oct 2 | (not recorded) | |

What this means for QA:
- Hotfixes are promoted and released the same or next day, with "targeted regression" or none.
- From mid-September the regression window was often 1-2 days, not the 3 working days the process page describes.
- Sprints (same database): 82 ended Jul 10; 83 Jul 13-24; 84 Jul 27-Aug 7; 85 Aug 10-21; 86 Aug 24-Sep 4; 87 Sep 7-18; 88 started Sep 21.
- Each release row links to its release-notes page. That link is the only "release recorded" artefact in Confluence.

### 2.4 BusPlanner Unified (New World) process

- Separate repo and pipeline, branches `dev` / `staging` / `main`, "currently deploying to its own environment rather than following this QA1/QA2 flow" (PE/235175938).
- Each environment runs its own branch's migrations (PE/157450256 step 3.2; PE/251756545 E4: staging = `staging`, prod = `main`).
- The ETL Load container image is built as `dev-latest`; staging and prod use a retagged copy (PE/157450256 step 4.2). Tags in use: `staging-latest`, `prod-latest` (PE/251756545).
- The only written QA rule for New World: "Run the health check in prod, where the customer will look. If a check fails, fix in dev, run a full regression in stage, then promote to prod. The full QA sequence is to be written up by Shikhar." (PE/157450256). That write-up was not found.
- The customer stand-up health check (PE/157450256, PE/193462274):

| # | Check |
|---|---|
| Q.1 | Vehicle count matches old-world GPS+ |
| Q.2 | GPS data arriving for every vehicle |
| Q.3 | Routes and mappings match old-world GPS+ |
| Q.4 | Substitutions and substituted vehicles flow through |
| Q.5 | Stop classification working as expected |
| Q.6 | Product flags show and hide the right menus |

  Handoff: H.1 confirm every QA check passed; H.2 hand the customer to Customer Success; H.3 close the Jira stand-up item with the checklist attached. Stand-up stories sit under ENG-2417. "No stand-up work happens without a ticket."
- Standup agenda items show the release path is still being settled: "NW Release Plan", "New world to Stage and Prod", "GPS+ NW Client Standup. Skip dev. Skip stage??", "Mid day deploy to ca-dev unified?", "chatbot to dev env today?" (PE/9699329). No documented Unified cadence exists.
- A separate same-day Live Viewer fix was described as targeting prod first (PE/226918402).

### 2.5 Jira issue types and where work comes from — PE/174850052

```
Feature Request (PROD board)
  └── Epic (ENG board)
        └── Story / Task / Bug / Bug - Eng
              └── Sub-task
```

| Type | Rule | Example on the page |
|---|---|---|
| Epic | Always a child of a PROD Feature Request; never created on ENG without one. Owned by engineering lead or delivery manager | `[GPS+] Live Viewer - V1` |
| Story | Client-facing functionality: changes what a client sees, does or gets | `BP Unified: GPS+ - Live Viewer map panel` |
| Task | Internal work: infrastructure, refactoring, spikes, migrations, documentation, tooling | `[Monitoring] Spike - Geotab reader instrumentation and Datadog integration` |
| Bug | Reported by a client or CX. Must originate on the SPT board, Zendesk ticket where possible | `[CA-ON-FBUS] GPS tracking stopped for all units` |
| Bug - Eng | Found internally by a developer or QA before a client reports it. No SPT or Zendesk ticket | `[GPS+] Path compare returns incorrect results for routes with shared stops` |
| Sub-task | Split of a parent; aim for no more than 5-6 | - |

How a client bug reaches ENG: client reports -> CX/support creates an SPT ticket with the Zendesk link -> daily triage call with support reviews and prioritises -> the SPT ticket is **moved** to ENG (no duplicate; the SPT number and Zendesk reference travel with it). A Bug on ENG without an SPT origin "may have been created incorrectly".

When to use Bug - Eng: a developer finds a regression during development; QA catches a defect during a sprint; an internal review surfaces a code issue; a bug is found while investigating another ticket. When not: the issue came from a client, CX or Zendesk.

Feature requests: never created directly on ENG. Informal request -> raise with the product team or delivery manager -> Feature Request on PROD -> once scoped and approved, an Epic on ENG -> stories and tasks.

Related one-liners from the standup agenda (PE/9699329): "Jira question type"; "10-15 min is roughly when move a question to a bug" (this refers to the Jira "Dev Question" issue type that the guide does not document; UNVERIFIED reading); "New issue type/reminder for release notes".

### 2.6 Bug checklist — PE/235470851

1. Issue type **Bug - ENG**, not Bug, Task or Story.
2. **Affected Version**: the release the bug was found on (tells whether it is a regression). May be left blank if unknown, but finding out is good practice.
3. **Client** field: "BusPlanner" when QA finds it internally; the specific client when reported from the client side.
4. **Priority** reflects urgency, not only severity. Ask: how many clients or users are affected; is there a workaround; does it block a release, a client deadline or other work.
5. **Repro steps**: exact, ordered, from a known starting point; include client/environment if client-specific and the specific data (student, route, run). Someone who never saw the bug must be able to reproduce it.
6. **Expected** and **Actual**, stated separately.
7. Screenshot or short recording when it clarifies faster than text (UI, layout, visual).
8. If found while testing a Story, link the bug to that Story with the **relates to** link type (helps decide whether it blocks the Story's release).

Examples named: ENG-2853, ENG-2851, ENG-2357. The page has no severity scale and no priority-level definitions.

### 2.7 Sprints and meetings

- Two-week sprints. Kickoff/planning on Monday, retrospective on Friday. Unfinished tasks roll over or go back to the backlog (PE/59310084, a stub).
- Daily stand-up has a shared agenda page (PE/9699329); its format changed on 2026-09-14. A recurring ask: "communicate all at-risk items in the current sprint to Nikki and [Murtaza]".
- Deep dives have a shared agenda (PE/87031810). Items that matter to QA: "Dev -> QA Handoff Documentation" (Michel; the origin of the three GPS+ handoff pages), "QA / Code Review", "Code Review process", "What is bug, terminology, consequences", load testing ("Tommy/Andy to own initial steps of load testing. Nikki/Murtaza to create an epic in Jira for tech debt items").
- Engineers log hours ("Log your hours please", PE/9699329).
- The team creates and edits Jira tickets through Claude and the Rovo MCP connector (blocker noted in PE/9699329).

### 2.8 How releases are announced and recorded

- One dev-notes page per fix version, created by Nikki Tilano from Jira's release-notes template: a property table (Release link, Version, Description, Contributors), an issue table, then written notes. From 2026-09-02 notes are grouped by product; from 13.3.0 most items carry a "Setup:" line (new settings, defaults, upgrade order, scripts) (release pages; digest in section 4.9).
- "Client Facing Release Notes" (PE/242876418): one page, newest first, started October 2026, last edited by Murtaza Khalil. One sentence per change, no ENG keys, no client names. It is a subset of the dev notes. Older client notes are in a Word document on SharePoint. It uses 4-part build numbers (13.4.1.231).
- The calendar database row for each release links the dev-notes page (PE/59998210).
- Stand-up items "External Release Note Timing" and "New issue type/reminder for release notes" show timing is discussed there (PE/9699329).
- QA1 build/deploy times go to `#qa-env-updates`; team-wide announcements go to `#dev-general` (PE/235175938).
- No page says where a release is announced to the company or to customers beyond the above.
- Only one dev-notes page lists a QA task: ENG-2441 "[QA] 12.4.13 Miami Fleet - Regression Testing" (PE/205389841). No page records a sign-off, test results or the environment tested.

### 2.9 Slack channels named in Confluence — PE/235175938

`#qa-env-updates` (QA1 build times, midday build requests); bug-posting channels where QA posts the Jira link and tags the developer: `#qa-bppro`, `#qa-bpweb`, `#qa-bptrips`, `#qa-quick`, `#qa-fleet`, `#qa-subscription-service`, `#qa-unified-gpsplus`; `#dev-general` (environment status, piloting notes, support-question reminders).

### 2.10 Incident and retro practice

- RCA page per incident under the "RCA's" folder. Structure used (PE/256081921): summary, field table (incident ticket in project IN, related tickets, severity, status, detected, mitigated, fix version, incident lead, fix owner, customer validation, escalation/comms), impact, timeline, 5-whys root cause, contributing factors, resolution, action items table, lessons learned, references. A client-facing RCA is derived from it.
- Lessons that bind QA (PE/256081921): treat time-zone rule changes as a code and integration risk; agree who verifies in the GUI before an overnight rollout; the BP Web pages `~/Subscriptions/WheresMyBus` and `~/School/VehicleLocator` were "not yet validated or QA'd" after the fix (action 5, open).
- School Opening retro (PE/158662658), items that touch testing and releases:
  - About 4 QA staff were a bottleneck all sprint; hotfixes consumed QA cycles meant for planned work.
  - Work built for "start of school" in June/July is not reviewed or tested by clients until school starts.
  - Some top-priority tickets could only be validated at production scale once school started.
  - One-off client configuration makes the system fragile and hard to verify ("100 different settings and nobody knows half of them").
  - Actions: a Jira label applied at intake for school-opening tickets (done); a clearer bar for support ticket detail before engineering; resolved tickets must carry a root-cause/fix summary; migrate remaining Azure DevOps tickets and tech debt into Jira; no hard product deadlines in the Aug-Sep window; all client communication through support channels.
- "Resolved" in Jira means waiting for the reporter to confirm the fix (PE/185204738).

## 3. Environments and access

No page gives a URL for QA1, QA2 or the Unified dev/staging application. What exists:

### 3.1 Old World (Main, Fleet)

| Environment | Built from | Purpose | URL / host | Source |
|---|---|---|---|---|
| QA1 (Main) | `dev`, nightly + on-request midday build | Functional first pass | NOT FOUND | PE/235175938 |
| QA2 (Main) | `stage`, weekly promote | Regression | NOT FOUND | PE/235175938 |
| QA1 / QA2 (Fleet) | `fleet-dev` / `fleet-stage` | Same pattern, separate instances | NOT FOUND | PE/235175938 |
| Production | `main`, `fleet-main` | What clients use | Per customer | PE/235175938 |

- Source control and PR policy: Azure DevOps (PE/50429953).
- Production hosting: older per-client Windows servers named `ca-*` in the Canada cloud account (PE/195297284); servers referred to as `wwwNN` and per-client codes like `CA-AB-<code>`, reached by per-client RDP files (PE/256081921). "SaaS host" for hosted clients, otherwise the client's own server (PE/157450256).
- Internal monitoring sites, Old World trackers (PRODUCTION data; internal network only): `trackermonitoring.sweden.georef.local`, `dispatchmonitoring.sweden.georef.local` (refresh every 5-10 minutes; click a client name for detail), `trackerhealth.sweden.georef.local` (more live) (PE/79757313).
- The Dispatch database is rebuilt from the Live database every night at 2 AM; changes made in Dispatch are wiped. The Quick database and Live are not touched (PE/185204738). One customer's dispatch copy refreshes weekly, overwritten every Friday (PE/226918402).
- Components that must be upgraded together (dev notes): GeoIMS protocol 13000007 with BP Web (PE/178683906); 13000011 GeoIMS + BP Web (PE/232685569); 13000013 GeoIMS + BP Web + BP Quick (PE/256868354); Path Server with BP Pro and BPServer, a mismatched client "silently calculates locally" (PE/232685569); tracker fixes need the tracker updated separately (PE/169639937, PE/178683906).

### 3.2 BusPlanner Unified (New World)

Three environments exist per country: **dev, staging, prod** ("the `logos` bucket in all three COS instances (dev / staging / prod)", PE/157450256; SQL servers below, PE/195297284). The cloud is IBM Cloud, Kubernetes, SQL Server on Ubuntu VMs.

| Item | dev (CA) | staging (CA) | prod (CA) | Source |
|---|---|---|---|---|
| Called | "ca-dev", "CA-Dev" | staging / "stage" | prod | PE/9699329, PE/87031810 |
| Kubernetes cluster | not stated | `k8-dev-ca-tor` (the dev cluster) | `k8-prod` | PE/251756545 |
| Namespace | not stated | `busplanner-staging` | `busplanner-prod` | PE/251756545 |
| SQL Server VM | `k8-mssql` | `k8-staging-mssql` | `k8-prod-mssql` | PE/195297284 |
| Git branch | `dev` | `staging` | `main` | PE/235175938, PE/251756545 |
| ETL image tag | `dev-latest` | `staging-latest` | `prod-latest` | PE/157450256, PE/251756545 |
| DB access | shared master SQL user | shared master SQL user; stand-up uses your own account; ETL Load logs in as `apiUser` | per-client login `bp_<code>_app` scoped to one DB, stored in the secrets manager (SOC 2) | PE/157450256, PE/251756545 |
| BP Info writes | not stated | always disabled (`WritesEnabled=false`) | enabled only after the client's BP Info is upgraded (ENG-2583) | PE/251756545 |
| ETL CronJob on creation | not stated | armed | suspended until a clean test run | PE/251756545 |
| Backups kept | 14 days | 14 days | 90 days daily + 365 days monthly | PE/195297284 |
| App URL | NOT FOUND | NOT FOUND | `https://app.busplanner.ca` (**PRODUCTION**) | PE/251756545 E10.2 |

- US: a separate IBM Cloud account in region us-east with its own `k8-prod-mssql`, `k8-staging-mssql`, `k8-dev-mssql`; prod app URL `https://app.busplanner.com` (**PRODUCTION**) (PE/195297284, PE/251756545).
- Login routes: a **central URL** and a **client-slug URL**; both must be tested for each new user (PE/251756545 E16, PE/157450256 7.3). The end-user manual gives only the pattern `https://<your-site>.busplannerweb.com/gps-plus` with no concrete host and no test/production label (PE/225050641).
- Staging holds real customer data: every environment's ETL Load reads the same per-client bucket in the production object-storage instance; extracts hold student and staff personal data and are deleted after 14 days (PE/251756545). The GPS+ user manual was written against "HRCE staging data" (PE/225050641).
- "CA-Dev is already overloaded, Devs use it as local, 4 clients fully live for GPS+" (PE/87031810, Sep 28). So the dev environment doubles as developers' local database.
- "Retire stale devices ... to align mapping numbers across dev/stage/prod envs" was approved Oct 2 (PE/87031810).
- VPN is required for the prod secrets manager; a VPN was set up for a new developer (PE/251756545, PE/9699329).
- Infrastructure repo: `iks-gitops` (SOP.md section 12 is the backup source of truth) (PE/195297284).
- Monitoring: Datadog is named for planned metrics and a reader instrumentation spike (PE/226918402, PE/174850052).

### 3.3 Accounts

- Every Unified client database contains a shared developer account ("devteam"). On the staging host its password is kept identical across clients ("one devteam password works everywhere"). Known issue 6 flags that it uses the dev seed password in production. Do not use it for testing; no credential is recorded here (PE/251756545).
- QA users: "Create the QA users the same way [admin UI]. Deliver credentials outside chat and tickets." (PE/251756545 E16); "Deliver credentials to users; create QA users." (PE/157450256 7.2). A new client DB has only the `Admin` role; client roles must be created first.
- "Prod: never test writes against prod BP Info." (PE/251756545 E10.2).
- "Never in notes, guides or tickets: passwords, HMAC keys, peppers, full connection strings with passwords, extract files." (PE/251756545).
- Accounts each handoff page says a tester needs: section 5.

### 3.4 Branch strategy summary

| Product | Branches | Promotion | Source |
|---|---|---|---|
| Main (13.x) | `dev` -> `stage` -> `main` | Whole-branch promote weekly; fix forward | PE/235175938 |
| Miami Fleet (12.4.x) | `fleet-dev` -> `fleet-stage` -> `fleet-main` | Same, alternating weeks with Main | PE/235175938 |
| BP Unified | `dev` -> `staging` -> `main` | Not documented; image retag per environment | PE/235175938, PE/157450256 |

Known branch defect: creating a new Unified client database from `main` fails; use `staging` for both environments until ENG-2963 is fixed (PE/251756545).

## 4. Engineering runbooks and how-tos relevant to testing

### 4.1 New client stand-up runbook (BusPlanner Unified) — PE/251756545 (+ PowerShell twin PE/251789313)

Status on the page: work in progress, not tested end to end. Author Michel Walther. The PowerShell page is "translated, not verified end to end" and requires PowerShell 7.3+ (5.1 mangles JSON passed to the CLIs).

Structure: Part 0 (P1 tools and access, once per person); Part 1 (C1-C3, once per client); Part 2 (E1-E17, per environment: prod always, staging optional and usually skipped, staging before prod when used).

Step tags and the page's rules for an agent following it:

| Tag | Meaning | Rule for an agent |
|---|---|---|
| `[READ]` | Read-only | Run and report against the step's Expect |
| `[WRITE]` | Creates or changes something | Show the exact command, wait for an explicit "go" |
| `[WRITE][PROD]` | Production write | Same, every single time, no batching |
| `[HUMAN]` | Browser SSO, a person, the client's server, a password | Never attempt |

Also: never guess a value; never print or store a secret; stop at the first failed Expect and do not improvise a fix on prod.

Tools: IBM Cloud CLI with four plugins, `kubectl`, `jq`, `zip`, .NET SDK 8+, the repo cloned, SQL access to each environment's SQL host and its Client_Registry database, VPN. Repo working directory: `BusPlannerUnified/BusPlannerUnified`. A bundle zip attached to the page holds the SQL scripts (`sql/e01`..`e17`), the CronJob template and reference guides.

Steps, as testable facts:

| Step | What it does | Facts a tester can rely on |
|---|---|---|
| C1 | Collect inputs | Client code: upper case, letters and digits, max 11 chars. `CUSTOMER_GUID` and `SCHOOL_YEAR_GUID` are minted once per client and reused in every environment. A second person checks them: wrong GUIDs file one client's students under another client. School year comes from BP Pro table `BPX_SchoolYear` |
| C2 | Object-storage bucket | One bucket per client, in the production storage instance; every environment's Load reads it. Extracts expire after 14 days |
| C3 | ETL Extract on the client's Windows server | Self-contained `BpPro.Etl.Extract.exe` in `D:\Busplanner\ETL\<CODE>\`; read-only account (`db_datareader` + `db_denydatawriter`); daily scheduled task, usual slot 02:00 local, staggered per client. Output: JSON extracts + `manifest.json` under `<CODE>/<yyyy-MM-dd>/`. Success = manifest `status` is `SUCCESS` with the right customer code and GUIDs. "The task reports success even when the extract failed: the manifest is what counts." A local-mode dry run logs `SUCCESS — 20 entities`; leaving `UseLocalStorage` on makes later runs "succeed" with nothing uploaded |
| E2 | Look-ups in Client_Registry | Tables `BPCustomers` (ClientCode, Server, DatabaseName, DbCredentialSecret), `BPUsers` (email hash -> customer), `BPFeatureFlag` |
| E3 | Create DB `BP_Unified_<CODE>` | `dotnet run --project BusPlanner.MigrationTool.Cli -- create-database`. Does not roll back; a half-built DB must be dropped. Must be run from branch `staging` (ENG-2963) |
| E4 | Migrate | `bpmigrate status` / `up`. Fresh DB shows "Current version 0 / N" with v17-v19 listed as orphans (expected). After: N / N, nothing pending, no orphans |
| E5 | Seed customer + school year | Without these rows the Load fails |
| E6-E7 | Secrets `client-db-<CODE>`, `bpinfo-<CODE>` | Secret names are case-sensitive; a case mismatch gives a 404 at login |
| E8 | Logo `<code>.png` | Per-environment logos bucket |
| E9 | Client_Registry row | Expect `GLOBAL_LOGIN=1, GPS=0, CHATBOT=0`, at least 1 user. Never run `docs/database/Client_Registry.seed.sql` outside dev: it overwrites other clients |
| E10 | Login test `[HUMAN]` | Log in, choose the client: logo shows, a page loads |
| E11.1 | BP Info settings | Keys `BaseUrl`, `CredentialSecret`, `DatabaseGuid` (blank = Live Viewer driver changes refused), `Enabled`, `WritesEnabled` |
| E11.2 | GPS+ thresholds | A new client has none until this runs. Defaults: `LateThresholdMinutes` 5 (Late, amber), `SevereLateThresholdMinutes` 15 (Late, red; must be greater than Late), `StaleThresholdMinutes` 120 (No GPS Events), `EarlyThresholdMinutes` 5 (on-time performance only) |
| E12 | ETL Load CronJob per client | Objects `etl-<code>-config`, `etl-<code>-load`, `etl-<code>-secrets`. Memory 4Gi, big clients 12Gi. Must run after the client's extract finished and not overlap another Load on the same SQL host. "Completed is not success: the job always ends as Completed." Success log lines: `Selected latest manifest for <CODE>`, `Using manifest GUIDs`, `1/1 manifests loaded, 0 failed`, `completed successfully`. DB proof: `etl_watermark` row `_manifest_loaded`. Re-running is safe |
| E13 | GPS | Feature flag `GPS` starts three services. The reader picks the client up within 15 minutes; stop classification and substitution import only after a restart. Providers the Unified reader supports: Geotab, Zonar, Synovia, GTS, Samsara ("anything else is never read"). Default poll: vehicles 600 s, events 20 s. Verify: devices > 0 per connection after 15-30 minutes. `CHATBOT` flag follows the same pattern |
| E14 | Link devices to vehicles (`dev_vehicle_device`) | By name with a dry run first, or the "AVL round-trip" from the old-world DB. Only buses on an active old-world route get linked; spares, parked and unassigned buses stay unlinked. One reference guide's STEP 0 deletes all links: never re-run it |
| E15 | Restart stop-classification and substitution-import | Only after E14: "GPS events processed before the links exist are never matched later." Restart briefly affects all clients. Health check: 1 active `pln_snapshot` for local today, the link count, latest `gps_event_history.event_timestamp` (UTC) within about 15 minutes |
| E16 | Users (prod) | Admin UI; create QA users the same way; test each user through the central URL and the client-slug URL |
| E17 | Status check | Read-only script, safe any time |

Troubleshooting rows worth knowing as a tester (PE/251756545):

| Symptom | Cause |
|---|---|
| Load: `No SUCCESS manifest found under prefix` | Extract not running, or prefix differs from the client code |
| Load: `Skipping … already fully loaded` | Expected: that extract is already loaded |
| Load: `duplicate key … IX_ta_employee_number`, `Phase 2 (Reference Data) failed` | Same StaffID on several BP Pro staff |
| Load: GUID / FK mismatch | Customer seeded with other GUIDs |
| Pod `OOMKilled` | Memory limit too low |
| Extract "succeeds", nothing uploaded | `UseLocalStorage` still true |
| CronJob `spec.timeZone: Invalid value` | Windows time-zone id used where the IANA name is needed (and the reverse in the extract config) |
| devteam / user login fails with the right password | Registry secret name mismatch (case) |
| New user can't log in via the central URL | The user's login routing wasn't saved: re-save the user in the admin UI |
| Stop classification / substitution import show no lines for the client | Not restarted since GPS was switched on |
| Substitution import: `BP Info import disabled for <CODE>` | `Enabled = false` |
| Substitution import: `No active pln_snapshot dated today` | No successful Load yet |
| GPS: no devices | GPS flag off, bad provider credentials, wrong location / fleet name |
| Device links: 0 linked, "no unique match" | GPS and BP Pro name buses differently |

Known issues listed on the page: (1) the Load job always ends `Completed`; (2) one shared storage key for all extracts and loads (per-client keys: ENG-2534); (3) duplicate StaffIDs in BP Pro stop the Load; (4) device names often don't match (common with Geotab); (5) create the DB from `staging` (ENG-2963); (6) security concern: the shared developer account uses the dev seed password in prod, seeded by migration 27.

A live example of (3) and (4): the Landmark/NPSSTS stand-up is blocked because 335 staff share 4 placeholder StaffIDs, breaking the unique `ta_employee.employee_number` index, and device mapping gives 0 links (PE/193462274).

### 4.2 GPS+ New Customer Stand-Up Checklist — PE/157450256

Older, higher-level template than the runbook. Extra facts:
- The ETL Load is not multi-tenant: one CronJob per client per environment, deployed by hand.
- Default operator and depot are seeded automatically by the ETL Load.
- The reader reconciles every 15 minutes; the stop-classification and substitution services load their customer list only at start-up.
- The reader needs about 6 hours to populate `dev_device`; one successful Load populates `veh_vehicle`. Zero mappings after seeding is a client data-quality problem (GPS units mapped to placeholder vehicles).
- Users can be created by a bulk SQL script that writes `AspNetUsers`, GPS+ roles/permissions and the `BPUsers` routing rows.
- Login verification: client-slug URL and central URL; confirm GPS+ loads and shows live data.
- A step moves from engineering to the Implementation team once it has run cleanly from the checklist three times.

### 4.3 GPS Substitution Service setup — PE/156794883

- Each client's BP Info endpoint gets a REST user named `BusPlanner` with operation permissions `GPSRouteVehicleGet`, `GetGPSVehicles`, `Override`.
- Unified `app_settings`, category `BPInfo`: `BaseUrl` (required), `CredentialSecret` (a secret name, required), `Enabled` (per-client kill switch; seeded false; parsed as true/1/yes; **defaults to true if the key is absent**).
- Poll interval `PollIntervalSeconds` defaults to 300 s.
- One customer has a single BP Info endpoint whose default database comes from web.config; short-term fix is three endpoints on that server.

### 4.4 GPS background services, as built — PE/174227457 (draft)

| Service | What it does | State |
|---|---|---|
| GPS Reader | Polls each customer's provider about every 20 s, writes events | Per-customer checkpoint in the DB (`LatestEventWrittenDateTime`) |
| Stop-Classification | Matches GPS events to planned stops | In-memory watermark + in-memory stop cache (invalidation signal in a SQL table) |
| GPS-Substitution-Import | About every 5 min pulls substitutions from BP Info | Stateless per cycle; writes idempotent |

Each runs as a single pod for all customers with no leader election, lock or sharding. Deployments use the Recreate strategy, so every deploy has a short gap; the services catch up from checkpoints. Proposed (not built): per-customer lease table in Client_Registry with about 30 s expiry, a unique index on the events table, persisted watermark, upsert for classifications.

Test implications (UNVERIFIED, derived): after a deploy or restart expect a short gap then catch-up; the stop-classification watermark is lost on restart.

### 4.5 Authentication as built — PE/162430977 section 1

- `POST api/auth/login` returns one HS256 JWT. `Jwt:ExpiryMinutes` is 60; default clock skew adds 5 minutes, so the effective life is about 65 minutes.
- All claims are baked into the token: permissions, six `*_access` scopes and `client_code`, read from the tenant database. Permission or scope changes only take effect on re-login.
- No revocation and no server-side session.
- The client stores the token in `localStorage` (`bp_token`, `bp_expiresAt`, claim arrays). Three places attach it: the axios client, the GraphQL client and the chatbot streaming fetch.
- Any 401 wipes storage and hard-redirects to `/login?expired=1&redirect=…`. Unsaved form state is lost.
- Timesheet and Overtime polling stops once the token is expired. The GPS Live Viewer poll is **not** gated.
- Existing bug noted: session-expiry cleanup leaves `bp_clientCode` and four scope arrays in storage (one code path clears 7 keys, the other 15).
- PROPOSED design: 15-minute access token + 12-hour refresh token per session stored hashed in `usr_refresh_token`; `POST api/auth/refresh`, `POST api/auth/logout`; proactive refresh about 60 s before expiry; one retry on 401; sessions revoked on admin password reset; a "session ends in 15 min" notice. Not included: rotation, cross-device revocation, wall-display support.

### 4.6 Old World tracker troubleshooting — PE/79757313

- Where to look: the three monitoring sites (section 3.1); for old-world GPS+ the F12 network tab in Quick.
- Logs. Tracker: `C:\ProgramData\Georef\Logs` — `BPTracker_yyyy_mm_dd.txt` (usually the Chipmunk tracker), `BPTracker_<SERVICENAME>_yyyy_mm_dd.txt` (usually Dispatch), `BPService_REST_yyyy_mm_dd.txt` (REST API). BPInfo: `...\BusPlannerWeb\Rest\Logging` — `Logyyyymmdd.txt` (every request, source IP, HTTP code), `Chipmunkyyyymmdd.txt` (login, student details). GeoIMS: `D:\Client\LogFiles` (`GeoIMS_Tracker`, `GeoIMS_DispatchTracker`).
- Clean start-up check: search the tracker log for "ProgramController Program Startup". Line 227017 = starting; 227021 must be present, error-free and match the URL in Quick's settings; 227024/025 must finish; 227026+ is the BPInfo import (the Dispatch tracker can sit on RunVPath for 20+ minutes for big clients).
- Set-up checks: tracker app.config (`RestApiBaseUrl`, connection string, GeoIMS settings); tracker settings DB (`RESTAPI%` keys, `DispatchDatabaseGuid`, `DispatchOnlyShowBusPlannerRoutes`); Quick DB settings (tracker URLs and login); GPS readers; the dispatch copy script; for Turns `Turns_UseDispatchDatabase` true in BP Web; ports 9001 and 9002 open.
- Common issues: complete tracker outage (`/ServiceInformation/Get` errors); tracker error in GPS+ (always the Dispatch tracker) or on the Dispatch page (Chipmunk or Dispatch tracker); GPS+ showing only vehicles without GPS mapping (the `DispatchOnlyShowBusPlannerRoutes` setting, or readers differ between the Live Pro DB and the Tracker Pro DB — they must be identical); login issues (turn on `ChipmunkVerboseLogging`); "Fail to Cache DistrictOfRecord setting" (GeoIMS not restarted after the dispatch DB copy; restart GeoIMS, GeoIMS_Live, GeoIMS_Quick).
- Diagnostic endpoints: `/rest/api/monitoring/getunmappedlivegpsvehicles`, `getunmappedtrackerdbgpsvehicles`, `getgpsvehiclepairs`, `getalltrackerdbgpsvehicles`, `getallgpsvehicles`.

### 4.7 Finance contracts: local test method — PE/177668097

- A finance contract is an XML file with Lua logic, uploaded into the BP Pro database. `get_values_per_date` is the entry point in every contract. Almost all are version 5.
- Repo: `BPFinanceContracts` in Azure DevOps ("managed" section); one folder per client, then per work date.
- Test tool: BP Pro > geotools menu > Other > "Route Cost Breakdown Analyzer - Developer Mode". Reload the tool after each contract change.
- The page's checklist: the contract returns values; outputs are as expected for the routes; total cost is as expected. Test on a copy of that client's database. A logic change usually means testing all of a client's contracts.
- If a contract errors for a route, the analyzer blanks that route's rows and shows the error in a tooltip.

### 4.8 Backups — PE/195297284

Owner Daniel Sukhram (DevOps), ticket IN-45. Prod SQL VMs: daily snapshots kept 90 days, monthly kept 365 days. Non-prod (staging, dev): daily, kept 14 days. Snapshots are crash-consistent, not a replacement for native SQL backups. Canada backups silently stopped for 37 days in Aug-Oct 2026. Open items: the coverage check is not scheduled; a test restore has never been performed. Relevance to QA: dev/staging data can be restored only within 14 days.

### 4.9 What the release notes teach a tester (digest of 31 pages)

- Hotfix rate: 13 Main hotfixes against 8 regular Main releases between Jul 23 and Nov 6.
- Four hotfixes concern wrong or duplicate parent notifications from Dispatch (PE/92864513, PE/138543106, PE/152109057, PE/130547713).
- "Silent failure" is the most common defect pattern named: ENG-969, ENG-1038, ENG-1372, ENG-1375, ENG-547, ENG-684, ENG-2222, ENG-565, ENG-2700, ENG-2699.
- Upgrade and packaging defects: ENG-2232 (Verify DB Schema removed all foreign keys on databases upgraded through 12.1.0, PE/178683906); ENG-1038 (a stale DLL left after upgrade crashed every custom report, PE/88571905); ENG-1968 (a partial view not packaged, two Fleet screens returned HTTP 500, PE/138706945); ENG-2280 (BP Pro could not open the latest DB version; never released publicly, PE/178683906).
- Recurrences: ENG-1008 "recurrence after the June 25 fix" (PE/88571905); ENG-2967 "recurrence of IN-111" (PE/262406145).
- Settings that change behaviour on upgrade: `StudentRouteChange_ShowWhatChanged` is ON by default after upgrade (ENG-404); several features ship default-off behind settings (equipment labels, dispatch notification hold ENG-1616, cluster stop, Vehicle Performance/Occupancy reports, Transfer Receive Cutoff Date) (PE/178683906, PE/246415361, PE/205389841).
- Data fixed forward only: ENG-2971 and ENG-2110 do not correct data recorded before the fix (PE/262406145, PE/246415361).
- Dev notes and client notes can disagree: the ridership report suite is under 13.4.0 in the dev notes and 13.4.1 in the client notes; ENG-2908 is described on the 13.4.0 page but listed in 13.4.1 (PE/246415361, PE/256868354, PE/242876418).
- Found-in-QA examples: ENG-969 "Found during ENG-885 QA" (PE/57606145); ENG-2729 "QA fixes" shipped with its feature (PE/232685569).
- Fleet constraint from the customer sync: upgrades must finish before the customer's 8:15 pm cost export (PE/210960386).

## 5. Feature and handoff documents: business rules as testable sentences

### 5.1 GPS+ Live Viewer — PE/138313730 (handoff, last content update 2026-09-14; Q&A added by QA 2026-09-29)

Status and counting
1. Status is decided in a fixed order: No Route, then No GPS Events, then Late, then On Time. A bus that is late and not reporting is counted once, under No GPS Events.
2. On Time is the default. It includes early buses and buses with no lateness information, if they have a route and fresh GPS.
3. A bus with no route today is No Route regardless of GPS. A bus with a route but not on a run (before its window, between runs, done for the day) is On Time with Run shown as "No run".
4. A bus appears only if it is an active vehicle with a tracker linked. Otherwise it is absent: no row, no error, no count.

Delay and ETA
5. ETA is one time: the next stop's scheduled time shifted by the current delay. It is cleared once that time has passed. It is blank when the bus is not on a run, has not reached a stop, or has no further stop with a scheduled time.
6. Only one run drives status, delay and ETA: an in-progress run beats an overrunning one, which beats one not yet started.
7. Status, delay and ETA are based on the officially scheduled run, never adjusted by other signals.
8. A run that crosses midnight is never the active run.
- A delay of more than a day is treated as a data error and hidden; Delta and ETA go blank (limitation 11).
- Active-run window: run start minus 30 minutes to run end plus up to 90 minutes overrun grace. The grace is hardcoded and the same for all clients. Times are local wall-clock converted to UTC (Q&A).

Pins
9. A pin follows the vehicle, not its route or run. Maximum 20.
- A 21st pin is refused: the pin control on unpinned rows is disabled with a message; unpinning stays available.
- A pinned bus that drops off the list is kept and shown as "missing" with an unpin option.
- Pins survive a page reload in the same tab and are cleared on logout or closing the tab.
- The pinned strip has its own sort, independent of the main table, and can be collapsed; pinned buses keep refreshing while collapsed.

Filters, sorting, paging
10. Depot and operator are page-scope filters: they narrow the list and the summary cards. Search, minutes-late, the status card filter and pins narrow only the list. "Showing X of Y" and the card counts may legitimately differ.
- Clicking a status card filters the table; the cards keep their full counts, including the clicked one. A card with count 0 gives an empty table.
- Search matches bus, driver, route or run and is not limited to one field.
15. Sorting by status orders On Time, Late, No GPS Events, No Route; within Late the order is alphabetical, not by lateness. Sort by delay to find the worst.
16. "Later than N minutes" matches only Late buses strictly more than N minutes late; exactly N does not match.
17. "Clear" resets depot, operator and minutes-late only. It does not clear the search box or an active status card.
- Sorting applies to the whole list, not the visible page. Every page change is a fresh server load.
- The "Unassigned" filter value is offered only to a user unrestricted on both grants.

Refresh
11. Refresh interval and pause state last for the session; they reset to the default of 15 seconds at next login.
13. Resume after a pause refreshes immediately. Returning from a background tab refreshes immediately only if the data went stale.
- Changing a filter while paused does nothing until resume.

Configuration and data
12. Late, Severe-Late and Stale thresholds are per customer, not per dispatcher. There is no admin screen for them.
14. STALE (see below): "The system has no concept of a route or run substitution."
18. A driver can show on a bus with no route. The page says this is observed, not confirmed as intended.
- A bus that never reported a GPS position never appears on the map.
- Multi-route warning icon shows only when the bus is idle (Route cell blank) and has more than one assigned route (`!route && assignedRouteCount > 1`). It also shows once the 90-minute overrun window has passed (Q&A).
- "Very Late" is a colour within Late, not a separate status, card, filter or sort (limitation 8).
- A cancelled run cannot be recorded anywhere; it looks like a tracker that stopped reporting (limitation 1).

Access (section 7)
- The page needs its own permission. Each user has an operator grant and a depot grant, each restricted to a list or unrestricted. Visible buses = the overlap of both.
- A bus with no depot or operator on record is invisible to anyone restricted on that grant.
- A filter can never reveal a bus outside the grant; list and cards always agree on which buses are in scope.
- Test accounts needed: four (unrestricted on both; depot-restricted only; operator-restricted only; restricted on both) plus at least one bus with no depot or operator.

Unknowns the page asks QA to confirm: the empty-fleet state; loading and server-unreachable states; whether search is case-sensitive.

**What has changed since this page (PE/225050641, 2026-10-30; SHIPPED per the user manual):** the Live Viewer is no longer read-only.
- A row action "Change this route's bus or driver" appears only for users with route-management permission and only for buses with a route.
- The Route Management dialog has Vehicle and Driver tabs. Confirm buttons read "Change bus to [bus]" / "Change driver to [name]". Cancel changes nothing.
- After a bus change the message says the new bus shows "after the next substitution import". After a driver change the new driver shows on the next refresh. A driver change applies to the bus today, on all its routes.
- Failure messages: "The change could not be sent. Try again."; "BusPlanner Info couldn't be reached. Nothing was changed - try again."; "You don't have permission to change routes." Nothing is changed in those cases.
- A Compare row action opens Path & Stop Compare for the bus's route, last 7 days ending today, current run selected. It is greyed out with a reason when there is no route today, the plan assigns several routes, or the user lacks access. (The handoff page said Compare was disabled.)
- Refresh interval options: 5, 10, 15, 30, 45, 60 s. Countdown text "next refresh in Xs", "Refreshing now", "next retry in Xs".
- Pause banner: "Auto-refresh paused - last updated at [time]. Resume to keep the list live." Failure banners: "Couldn't load the live fleet. Retrying every Ns." / "Couldn't refresh - showing data from [time]. Retrying every Ns." (old data kept).
- Status tiles can be combined; clicking Total Buses clears the status filter. (The handoff page describes single-card toggling.)
- On Time = less than the Late threshold behind plan; Late = at or above it. The badge "Late (n min)" is yellow from the Late threshold and red from the Very Late threshold.
- A user with no operator or depot access sees: "No buses fall within your access. Ask an administrator to grant your account an operating company and depot."
- Pin limit text: "Pin limit reached (20) - unpin a bus to add another". "Unpin all" shows "Unpinned N buses" with Undo.
- Empty states: "No buses match the current search and filters." / "No buses are out right now." / "Loading the live fleet...".
- Default sort is by Bus. Sortable: Status, Bus, Route, Delta, ETA, Last Update. Rows per page 25, 50, 100.
- Map "Show" options: Grid, Pinned, All. Grid and Pinned are on by default; choosing All turns both off and the reverse.
- Zoom action is greyed with "No GPS position to zoom to" when there is no location.
- All times are in the district's local time; distances in km, speeds in km/h.

### 5.2 GPS+ Event Viewer — PE/137822221 (handoff, 2026-09-14)

Purpose: the raw signal timeline (Ignition, Door, Stop Arm, Amber Lights) for one route's runs over up to 14 days, as an exportable grid plus a one-day map. Read-only. Historical; no auto-refresh.

1. The picker allows exactly one route. Runs within it are multi-select. Picking another route clears the selected runs.
2. The date range is capped at 14 days. A wider range shows "The event log covers up to 14 days at a time — this range is {N}. Narrow it to run the report." and loads nothing. It is never silently shortened. End before start shows "The end date is before the start date."
3. If the route was not in the plan on some days in range, a note names those days.
4. If a day has no plan imported (commonly a weekend), a separate note names those days.
5. Only changing the date range or the route/run selection calls the server. Event-type filter, grouping, sorting and export work on loaded data.
6. No paging: everything in the selection loads at once.
7. An event claimed by more than one run shows once when grouped by Date (naming every run) and once per run when grouped by Run.
8. The CSV export always has exactly one row per event, whatever the grouping.
9. The CSV export contains only what the event-type filter currently shows. Export is disabled when nothing shows.
10. Duration shows one of: an exact time, an upper bound marked "<", "unknown", or "Ongoing" (signal still active at the end of the report). The wording "Ongoing" is unsettled; the user manual shows "Open at end" (PE/225050641).
11. The map shows only the planned path, the actual GPS path and event markers. Never stop information.
12. The map shows one day; the grid shows the whole range.
13. Event-type toggles change the map markers, never the path lines.
14. A break in the actual-path line is labelled "GPS gap" only when the tracker stopped reporting, not when it is caused by run selection.
15. The first map open in a session is slower; later hide/show is instant and does not reload.
16. A substituted route, or a substituted run on a normal route, is not offered in the picker, with no indication that anything was left out.
17. Rarely, a run has a data problem unrelated to substitution; then the whole date range is rejected with a message naming the run(s).

Scenarios worth testing: nothing picked shows "Choose a route and its runs to build the event log."; loading shows "Deriving the event log…"; all event types off gives zero rows and disables Export; toggling a filter keeps the map's pan and zoom; switching grouping clears the selected row.

Limitations: no location/address column; no speed; no stop-visit or on-time information; events not tied to a selected run never appear (for example idling at the depot).

Access: one permission, `gpsplus:events:read` (group "gpsplus"). With it a user sees and can export every route the customer has. **No depot or operator scoping** — the page calls this "simply how the page is built today, not a confirmed, deliberate decision". Test accounts: two (with and without the permission).

Added by the user manual (PE/225050641): default range is the last 7 days; counter "N run-days - M events"; dates, selection and grouping are remembered for the browser session; columns Route, Run, Event, Start, End, Duration.

### 5.3 GPS+ Path & Stop Compare — PE/139231233 (handoff, 2026-09-18)

Purpose: one route's planned stops over up to two weeks beside what GPS recorded, one row per planned stop, with a one-day map and an export. Read-only. Guiding principle: a missing measurement is never shown as a missed stop.

Outcomes
1. Every planned stop that can be judged gets exactly one of: Serviced, Probable, Skipped, Not Seen.
2. A stop that cannot be judged shows no outcome, never a guess.
6. "Not due yet" is shown for a short while after the scheduled time. Once any matching record exists it is never "Not due yet". A stop with no scheduled time stays "Not due yet" while its date is today.
7. "Unconfirmed" is shown when nothing was recorded near the stop and the tracker went quiet around its scheduled time.
8. Skipped = recorded passing without stopping. Not Seen = nothing recorded near the stop although the day and tracker were otherwise working.
9. Serviced and Probable both mean covered; Serviced has stronger evidence. User manual wording (PE/225050641): Serviced = stopped and door-open recorded; Probable = speed about 0, no door signal.
- A fleet without a given sensor never gets Serviced; every stop tops out at Probable (limitation 9).
- If the whole day could not be assessed, every row for that day shows a dash.

Notices
3. "Whole date not measured" overrides every other reason. Within a measured date, "no bus assigned to this route" outranks tracker or feed reasons.
4. A day with no school and a day where this route was not running get two differently worded notices.
5. A public holiday reads the same as a weekday nobody imported a plan for (no holiday calendar).
23. A route with no bus assigned is still offered in the picker; the page explains that none of its stops can be assessed.
- Banner texts in the manual: "Some stops could not be confirmed"; "This route is not in the plan for this date"; "This date was never measured"; "No bus assigned to this route"; "The bus has no usable tracker"; "No tracking data received for this date".

Summary cards
10. Stops Serviced counts only measured days and leaves out stops that are Not due yet, Unconfirmed or Not Seen.
11. Average Deviation can only read later than the true average, never earlier (it uses the strongest-evidence time, not arrival).
12. The Average Deviation card is amber when late and green otherwise. No data shows a dash in the same green as a good average.
15. On-path compliance is measured over the bus's whole day, including depot time, deadheads and other routes. A perfectly driven route will not read 100%.
16. On-path compliance shows a percentage, "No route path" or "No tracking". A bare 0% means a genuine measured zero.

Grid, map, export
13. No row is coloured to suggest lateness. Only the Delta figure is coloured. A whole row is tinted only for a Skipped stop on an assessable day.
14. Nothing is shown by colour alone: every pill, dot and legend swatch has a text label.
17. A run with no stored planned path is normal: it still shows the driven track and stop pins.
18. A map pin sits at the stop's planned location, never where the bus was recorded.
19. "Not due yet" and "couldn't be assessed" pins are both grey; they differ only on hover and in the legend.
20. A track break is called a "GPS gap" only when the tracker went quiet.
21. Choosing another route clears the selected runs.
22. The date range is at most two weeks; a wider one is refused before anything loads and the message states the limit. Default range is the last 7 days.
27. A run renamed mid-period stays one run, shown under its latest name.
28. Column visibility and widths are remembered only while logged in.
29. The export always includes Date, Route, Run for every line and adds a Reason column not on screen, including a line for a date with nothing to report.
30. On screen early/late uses a plus/minus sign and colour; in the export it is words (for example "3 min late") to avoid spreadsheet formula parsing.
31. When a selection hits a size limit, the screen shows an alert and the export's last line states the limit.
32. Grouping by Run always adds a Date column.
- The Group By toggle is shown only when there is more than one day or run. Grouping re-orders loaded rows without a server call.
- The day stepper offers only days that produced rows.
- Every column resize handle works from the keyboard.
- The export covers the whole selection, not just what is on screen.

Substitution and data problems
24. A route affected by GPS+ substitution does not appear in the picker in this release.
25. A single substituted run is silently excluded from its route's run list.
26. If any run anywhere in the selected range has a specific unresolved data problem, the entire range is refused with an error, even for unrelated routes. Narrowing the range to exclude that day resolves it.

Access: one permission, `gpsplus:compare:read`, shown as that raw string on the Role Management screen. **No depot or operator narrowing** (limitation 1): anyone who can open the page sees stop-by-stop tracking evidence for every route the customer has. Test accounts: one with and one without the permission; plus two accounts that both hold the permission but have different depots/operators, to confirm both see the same complete set of routes.

Other limitations: no unplanned ("courtesy") stops; no precise arrival/departure time; one route at a time; no paging.

### 5.4 GPS Plus User Manual — PE/225050641 (SHIPPED behaviour, 2026-10-30)

Sign-in and navigation
- Flow: work email > Continue > "Choose your organization" if the email belongs to several > password > "Sign in with Password".
- After sign-in the first GPS Plus page the user has access to opens. Signing in at the base address lands in the first product the user can use (Time & Attendance users may land there).
- Product bar: GPS Plus, Ask AI, Dispatch (greyed, "SOON", cannot be opened), Log out.
- Main menu: GPS Live Viewer, GPS Path & Stop Compare, GPS Event Viewer, GPS Device Mapping (placeholder "coming soon" page), Smart Mappings (greyed, cannot be opened).
- Mail and Notifications icons in the top bar are not active.
- An "Ask BusPlanner" button on every page opens the assistant panel. The assistant has New conversation, Conversations (reopen/delete), Open full page; Enter sends, Shift+Enter adds a line; the page states the AI can make mistakes.

Test-data caveats stated by the author: in HRCE staging only Door events appeared; Stop Arm showed a red dot or "No reading"; Amber Lights "No reading". Signal-dependent checks need tracker-specific data. Thresholds for that district: Late 5 min, Very Late 15 min, stale 120 min.

Live Viewer, Event Viewer and Compare details from the manual are merged into 5.1-5.3.

### 5.5 AI Assistant — Question Scope (V1) — PE/137232386 (scope; epic ENG-296)

42 questions. Release labels: v1.0 = 26, v1.5 = 6, v2.0 = 10. Feature flags: `GPS`, `GPSPLUS`, `ADMIN`; Planning questions have no flag.

| # | Area / flag | Release | Questions | Work item |
|---|---|---|---|---|
| 1-3 | Planning / none | v1.0 | Totals of students, routes, runs, stops, vehicles; averages; largest/smallest school or route by riders | ENG-1895 |
| 4-7 | Planning / none | v1.0 | Runs missing scheduled stop times; routes with no vehicle; students missing address or coordinates; when plan data last loaded and whether it succeeded | ENG-1896 |
| 8-9 | Planning / none | v1.0 | Routes over/under a capacity threshold; fleet utilization and unassigned vehicles | ENG-1897 |
| 10 | Planning / none | v1.0 | Who is assigned to drive a run on a date | ENG-1899 |
| 11-12 | Planning / none | v1.0 | Students with walk distance over a threshold; students needing specific equipment and their routes | ENG-1884, ENG-1885 |
| 13-15 | Planning / none | v2.0 | Unassigned students inside a zone; stops closer than a distance; stops within a radius of an address | ENG-1898 |
| 16-21 | GPS / `GPS` | v1.0 | Student pickup/drop-off time; average ride time; did a run complete and which stops were skipped; vehicles/routes with no GPS data or sensor problems; actual vs planned stop sequence; runs serviced by another vehicle | ENG-1904 |
| 22 | GPS / `GPS` | v1.0 | Runs over/under planned time | ENG-1905 |
| 23-24 | GPS / `GPS` | v1.0 | Fleet-wide ranked path deviation; one route's deviation by day | ENG-1906 |
| 25-26 | GPS / `GPS` | v1.0 | Is GPS data current (last event, ingest latency per provider); vehicles lagging or not reporting | ENG-1907 |
| 27 | GPS / `GPS` | v1.0 | Period-over-period comparison of ride time or coverage | ENG-1908 |
| 28-30 | GPS+ / `GPSPLUS` | v2.0 | Where is a bus now; which buses are late or stale; substitution history | ENG-1909 |
| 31 | GPS+ / `GPSPLUS` | v1.0 | On-time performance by route, school, run or stop | ENG-1910 |
| 32 | GPS+ / `GPSPLUS` | v1.0 | GPS route summary per stop per day, max 14 days | ENG-1911 |
| 33 | GPS+ / `GPSPLUS` | v2.0 | Deep link to a filtered GPS+ dashboard | ENG-1912 |
| 34-36 | Admin / `ADMIN` | v2.0 | Users not logged in recently; who holds a permission; audit events | ENG-1913 |
| 37-42 | Planning / none | v1.5 | Students on a route/run/stop/school; routes serving a school; bell time; zero-load stops that are not waypoints; runs with no students; students retiring by grade | ENG-1894 |

Presentation rules: a table is the default for every answer, sortable, with an explicit "showing N of M" note when truncated (ENG-1900); charts are v1.5 (ENG-1901); maps (ENG-1902) and report cards with CSV export (ENG-1903) are v1.0.

Qualifiers that must appear in the answer:
- Driver attribution is the planned assignment; substitutions are not visible.
- GPS stop times are arrival-only, one visit per stop per day.
- Runs missing scheduled stop times are excluded from ride-time answers and listed with the reason.
- Capacity and utilization use the planning definition, stated in the answer.
- Days with no GPS data are excluded from on-time performance with an explicit exclusion count, never counted as late.

Out of scope: Time & Attendance questions (ENG-1505) and anything not listed.

### 5.6 Multi-day Vehicle Assignments, Phase 1 — PE/226918402 (DRAFT design)

As built today:
- New World stores the vehicle mapping per snapshot day only (`pln_route.vehicle_guid`).
- The substitution import pulls only today's active old-world device-to-route rows and writes them into the snapshot. It polls about every 3 minutes; dialogs tell users updates arrive within about 5 minutes.
- The ETL and the import both write the same snapshot columns.
- The pre-projection window is 10 days per client.

Acceptance criteria on the page (PROPOSED; each is directly testable once built):
1. A multi-day assignment made in the new page is one old-world record, lists/edits/deletes as one record, and shows on every affected snapshot within one poll.
2. The same change made in Quick produces the same intent row and the same snapshots.
3. A future assignment inside the 20-day window appears on its days; one beyond the window appears when that day is projected.
4. Shortening or deleting an assignment re-resolves the dropped days to the next applicable rule.
5. A run-level row overrides its route for that run only.
6. After the nightly ETL a newer change still wins over an older one.
7. A New World driver reassign applies today only, is not written to the old world, and is gone from the next day's snapshot.
8. An unresolvable mapping never silently reverts a route; it is visible in monitoring and resolves after the device link is backfilled, without re-import.
9. Re-running the resolver with no changes writes nothing.
10. Operator users can see and change only their own operator's routes and vehicles.
11. Only the resolver writes vehicle and driver mappings into snapshots.

Validation rules (UI-5): a change is refused with an explanation when retire is not after effective, when it overlaps another record at the same level for the same route or run, or when the vehicle has no device for the window. Resolution order per run per day: active run-level row, else active route-level row, else planned bus, else unassigned.

Known defects: ENG-2650 (driver reassign moves the planned bus but the old-world row stays; after ETL the route moves back); ENG-2738 (an unresolvable mapping is dropped and the planned, possibly retired, bus is silently restored) — open; ENG-2632 works as designed. Stated test approach: build the new importer alongside the current service, writing no snapshots, and compare outputs.

### 5.7 Reassign Dashboard (New World Dispatch) — PE/220561412, PE/68255745 (PROPOSED)

Decided or direction-set items that will become test rules:
- An absence written by Dispatch has status PENDING (C11).
- Dispatch and T&A share one absence table: hours 0.01-24, one absence per employee per day, payroll counts anything not REJECTED.
- The absence form offers AM / PM / All Day. Clients without T&A do not see the hours field (C9). AM maps to AM-component runs, PM to PM-component runs; noon runs undecided (C12).
- A run whose driver is absent with no cover must count as uncovered (D15; the PRD formula had this wrong).
- Spare driver = a driver with no runs. Spare bus = a bus on no route (D16).
- Double Back moves the run to the covering driver's vehicle/route. A plain reassign keeps the run on its bus and changes only the driver (D17, D23).
- An absence applies on each date in its range; state is derived from dates (D20).
- Uniqueness becomes one driver per (vehicle, run) (D22b).
- No undo: History is read-only; a mistake is corrected by a new change (E24).
- Conflict detection is advisory: it warns, never blocks (PE/68255745).
- Open: concurrency when two dispatchers save the same day (E25); Double Up and Split cannot be saved yet (B5); the "serviced" rule depends on a tracker service that has not landed (B6).
- Drive-time and lateness numbers in the prototype are synthetic until the ETA algorithm exists; do not assert real values.

### 5.8 Old World Dispatch escalations — PE/185204738 (2026-10-05)

As-is rules:
- The Dispatch database is rebuilt from Live every night at 2 AM. Substitutions, splits and time changes made in Dispatch are wiped, cannot be entered the day before, and leave no readable record.
- The Send Run Changes ledger keeps 30 days but only shows today.
- Quick already supports dated substitutions.

Highest-value regression area named: merge or split of runs in Dispatch breaks parent notifications, Turns rosters and scanning, and tracker sync. Open or recent defects: ENG-2448 / SPT-545 (Send Run Changes fails with a tracker error, parents not told); ENG-2326 (tracker refuses Send Run Changes after a merge, HTTP 406); SPT-697 (merge or split sends nothing); ENG-2290, ENG-2325 (substitute bus does not stick); ENG-2294 (saving a driver stores the aide's name); ENG-2453 (alert email says 15 minutes instead of 30, goes to every run on the route, repeats); ENG-1352 (student scanning does not work; blocked since August); ENG-2096, ENG-2043 (wrong stop times in parent emails after a merge); ENG-2082, SPT-678 (merged-in students "Unplanned" in Turns / merged runs missing on tablets); ENG-2302 (early-release day sets school time to 11:50 PM); ENG-2319 (Chipmunk showed route complete mid-run on a spare bus); ENG-2335 (GeoIMS losing workers took services down on 9/28).

PROPOSED "bridge": a change-history row per run per save with CSV export; substitutions with a date range up to 7 days out for AM, PM or both; three Quick settings — "Dispatch - Send Run Changes" (default on), "Dispatch - Timed Parent Notices" (default off), "Dispatch - Parent Notice Lead Time" (default 60 minutes); defaults change nothing on upgrade.

### 5.9 Thunder Bay weather zones — PE/163545089

As-is:
- Zone alerts work off stops. "Only Bus Stops within Zone" notifies only subscribers at cancelled stops. "All Bus Stops Affected by Zone Closure" cancels the whole run if it passes through the zone.
- On Post a Transportation Alert, once a zone is selected the Component Type field disappears, so a zone cancellation applies all day.
- No zone is stored on a stop; it is calculated from the zone boundary containing the stop.

PROPOSED (PROD-632..636):
- Component Type stays visible when a zone is selected; zone + component cancels only that component's runs (Rural + AM leaves PM untouched).
- Leaving Component Type unset keeps today's all-day behaviour.
- Push notifications go only to subscribers at affected stops on the selected component's runs.
- Parent Portal and Student Summary show a Zone column between Stop and Route; a stop outside every zone shows nothing.
- Route Directions show "Zone: [name]" in the stop bar.
- New "Weather Zone Student List" report grouped by zone; a student with stops in two zones appears in both groups; schools see only their own students.

Risks called out on the page: the Component Type change touches a core alerting flow many clients use; the student list report and bulk printing may time out on a cancellation morning.

### 5.10 Other requirement pages (short)

- **BP Pro API (PE/136347650), as-is:** the BP Pro API is effectively read-only; its only real write is the GPS route-to-vehicle mapping. Login issues 1-hour bearer tokens; there are no API keys. The driver API returns only staff who are drivers. Setting a route's driver changes the driver on every route that vehicle serves (staff reach a route via the vehicle). No field-level lock exists; Staff, Route and Vehicle carry a record-level "Protected" flag. The student update engine is about 30k lines of native code (regression risk).
- **Trips API (PE/136118274), as-is:** Trips has no API today. A trip returns to its start location; it can have several driver/vehicle assignments; odometer is recorded once per trip; no depot or deadhead data; each Trips database appears to serve one district.
- **Trips SE feasibility (PE/214695940), as-is:** visibility is list/calendar filtering by school only; **opening a trip by ID has no access check**. The blackout-hours check only tests whether the start or return time falls inside the blackout, so a trip spanning it is not caught. Settings start-up code deletes unknown setting rows. Trips uses its own logins (no SSO). "Rotation" sorts by fewest assignments ever.
- **Maryland reports (PE/170721285), PROPOSED:** ridership report = 9 rows x 5 provider columns = 45 counts; each transported student counted in exactly one cell; enrollment as of Sept 30, eligible as of the last Friday in October. Known defect to avoid copying: the existing Transportation Statistics "transported students" query has a count-distinct bug. A report run after the count date reflects data as of the run day.
- **PGCPS router requests (PE/167837697):** equipment icons (client setting, off by default), colour-coordinated runs, cluster stops (checkbox on stop properties; behaves like a regular stop), Student ID column in Student Listing, Run Directions Condensed (deadheads included; a deadhead must never start a new page or leave a blank page), alternate address on the map, parent notification letter. Most shipped in 13.4.0 (PE/246415361).
- **Miami Fleet sync (PE/210960386), SHIPPED:** "Transfer Receive Cutoff Date" blocks receiving or reopening transfers created before the date; empty by default. Known defect ENG-2340: once set it cannot be cleared (workaround: 1900-01-01). Saving a PO totals all pages of lines (ENG-1930).
- **Finance contracts (PE/177668097):** see 4.7.

## 6. People and ownership

Roles are as stated on a page where one is stated; otherwise the evidence is given. No page lists the QA team or an org chart.

| Name | Role / evidence | Area | Source |
|---|---|---|---|
| Nikki Tilano | Author of the QA/build process, bug guide, issue-type guide, sprint page, calendar, RCA, retro and all 31 dev release-notes pages; member of PR-APPROVERS; runs stand-up items; owns Jira process actions | Delivery / release process, Jira hygiene | PE/235175938, PE/50429953, PE/256081921, PE/158662658 |
| Murtaza Khalil | PR-APPROVERS; asks for at-risk sprint items with Nikki; last editor of the client-facing release notes; owns Azure DevOps-to-Jira migration with Nikki | Sprint/delivery management, client release notes | PE/9699329, PE/242876418, PE/158662658 |
| Tommy Zwirblia ("Tommy Z", "TZ") | Created the space home, stand-up and deep-dive pages; engineering decision owner; escalation/comms on the RCA; author of the chatbot question scope | Engineering lead, New World | PE/9535653, PE/226918402, PE/256081921, PE/137232386 |
| Andy Tompkins | PR-APPROVERS; RCA fix owner (Geotab reader hotfix); author of the multi-day assignment design; owns load-testing first steps with Tommy | GPS readers, Old World/New World bridge, infrastructure decisions | PE/256081921, PE/226918402, PE/87031810 |
| Yusra Abbasi | PR-APPROVERS; QA on the multi-day design ("Yusra is on chatbot and ETL testing"); added the QA Q&A to the Live Viewer handoff | QA: BP Unified GPS+, Chatbot, ETL | PE/226918402, PE/138313730 |
| Hamad Zeb | PR-APPROVERS (QA Reviewers group) | QA: Old World (per process.md Jira evidence) | PE/235175938 |
| Maricar Benedictos | Author of the GPS Plus User Manual; "QA - help from Wejeeha and Maricar" | QA / documentation: GPS+ | PE/225050641, PE/9699329 |
| Wajeeha Batool | "QA - help from Wejeeha and Maricar" | QA (T&A per process.md Jira evidence) | PE/9699329 |
| Michel Walther ("Michel W.") | Author of the three GPS+ handoff pages, the stand-up runbook, the Landmark checklist; owner of health check Q.1; builds the resolver; raised "Dev -> QA Handoff Documentation" | BP Unified developer: GPS+, stand-up, ETL | PE/138313730, PE/251756545, PE/226918402 |
| "Mike" | Completed stand-up steps 1-6 for Landmark; raises storage security and SQL Server items | BP Unified stand-up. Whether "Mike" is Michel Walther is UNVERIFIED | PE/193462274, PE/87031810 |
| Shikhar Patel | Author of the stand-up checklist and scalability draft; original stand-up guides; device links; "full QA sequence to be written up by Shikhar" | GPS services, client stand-up | PE/157450256, PE/174227457 |
| Vladislav Derbenev ("Vlad") | Author of the JWT page; developer feedback on the Reassign Dashboard; BP Info writes and the new assignments page | BP Unified: auth, Dispatch, GPS+ | PE/162430977, PE/220561412 |
| Drew Weeks | Author of the substitution service setup; supplies BP Info URLs and credentials; builds the intent table and importer | BP Info, substitution import, Fleet/Main contributor | PE/156794883, PE/251756545, PE/226918402 |
| Janice Fritz | Engineering code-review corrections on the API pages; dev reviewer for Trips; contributor on most Main releases | BP Pro, Trips, reports | PE/136347650, PE/214695940 |
| Mitchell Bland | Tracker/dispatch and infrastructure expert; old-world / BP Info expert; chatbot onboarding | Tracker, Dispatch, Chipmunk | PE/158662658, PE/226918402 |
| Michelle Prichard | Tracker/dispatch expert (two-person bus factor with Mitchell); chatbot | Tracker, Chatbot | PE/158662658, PE/87031810 |
| Dong-Ik Lee ("Lee") | Contributor on Miami Fleet releases and Clay dispatch hotfixes | Fleet | release pages |
| Logan Gillett, Stephen Hu, Ibrahim Ali Asgher, Tian Yi, Javier Duarte | Release contributors (Javier: Chipmunk, Turns settings) | Developers | release pages |
| Daniel ("Dan") Sukhram | DevOps; owner of backups; incident lead for infrastructure | Infrastructure, environments, servers | PE/195297284, PE/256081921 |
| Awais Akram | Author of API requirements, Maryland analysis, PGCPS plan, Reassign Dashboard pages, Trips feasibility | Product (requirements) | PE/136249345, PE/220561412 |
| Ahnaf Rahman | Product: scoping, PRDs, admin page, mobile UI, substitution readiness | Product | PE/163545089, PE/87031810 |
| Matthew Hayes ("Matt") | Author of the old-world Dispatch escalations page; holds a customer PRD; Dispatch prototype | Product: Dispatch | PE/185204738, PE/87031810 |
| Amanda McInnis | Escalation and communications on the RCA; start-of-school change requests | CX / escalations | PE/256081921, PE/158662658 |
| Haley Ace | Customer validation during the incident (checks in Quick) | Support | PE/256081921 |
| Chris MacLeod | Support ticket quality bar | Support | PE/158662658 |
| Josh (Rice, UNVERIFIED surname) | Ran a client's scheduled tasks manually | Support / client services | PE/256081921 |
| Lauri-Ann Turnbull, Caroline Van Winden | Support double-check / advice during the incident | Support / CX | PE/256081921 |
| Binford Sloan | CSM for a large Maryland district; Maryland report stakeholder | Customer success | PE/167837697, PE/170721285 |
| Deanna Maddux | Wrote a customer's depot structure spec | Implementation / CX | PE/214695940 |
| Brian | Demos to a customer; on a customer call | UNVERIFIED role | PE/226918402, PE/163545089 |

Teams named: Implementation (owns stand-up steps and user creation), Customer Success (receives a stood-up customer), Client Services (pulls finance contracts), Support/CX (daily triage call with engineering), DevOps.

QA headcount: "about 4 QA staff" (PE/158662658).

## 7. Answers to the hunt list

| # | Item | Result | Answer |
|---|---|---|---|
| 1 | URLs of Old World QA1 and QA2 | **NOT FOUND** | PE/235175938 is the only page (outside the PRD family) that mentions QA1/QA2 and it gives no host. Build/deploy times are posted in `#qa-env-updates`; ask there. Fleet has separate QA1/QA2 instances, also without URLs |
| 2 | URLs of Unified staging / dev | **NOT FOUND** (names FOUND) | Three environments per country: dev ("ca-dev"), staging, prod. Cluster, namespace and SQL server names are in section 3.2 (PE/251756545, PE/195297284, PE/157450256). Only PRODUCTION app URLs are written down: `https://app.busplanner.ca` (CA) and `https://app.busplanner.com` (US). Login also works through a client-slug URL; the manual shows only the pattern `https://<your-site>.busplannerweb.com/gps-plus` (PE/225050641) |
| 3 | Test accounts policy | **PARTLY FOUND** | No policy page. What is written: QA users are created per client in the admin UI like customer users, and credentials are delivered outside chat and tickets (PE/251756545 E16; PE/157450256 7.2). A shared developer account exists in every client DB and is flagged as a security concern; do not test with it (PE/251756545). Never test writes against prod BP Info (PE/251756545 E10.2). Dev and staging use a shared master SQL user (PE/157450256). Accounts needed per feature: Live Viewer 4 + a bus with no depot/operator; Event Viewer 2; Path & Stop Compare 2, plus 2 with different depot/operator (section 5). Staging data is real customer data |
| 4 | Definition of done | **NOT FOUND** | Nearest thing: the status rules in PE/235175938 (QA Notes written before Approved for Release) and the stand-up hand-off checklist (PE/251756545). CQL text search for "definition of done" hits only PRD-family pages (not read here) |
| 5 | Test strategy or regression checklist | **NOT FOUND** | The process page defines what regression is, not what it contains. Per release a Jira task "[QA] <version> - Regression Testing" exists (ENG-2441, PE/205389841); its content is in Jira. The only checklist-like items are the 6 stand-up health checks Q.1-Q.6 (PE/157450256); "the full QA sequence is to be written up by Shikhar" was not found |
| 6 | Onboarding pages | **NOT FOUND** | The space home is a placeholder (PE/9535653). "QA Training Documents" holds only PE/235175938 and PE/235470851. Personal spaces are empty. Useful substitutes: PE/79757313 (tracker), PE/251756545 (Unified stand-up), PE/177668097 (finance contracts), PE/225050641 (GPS+ user manual) |
| 7 | How releases are announced | **PARTLY FOUND** | A dev release-notes page per version (author Nikki Tilano), the Client Facing Release Notes page (PE/242876418, edited by Murtaza Khalil), and a calendar row linking the notes (PE/59998210, stale after Oct 2). Timing is a stand-up topic. No page names an announcement channel or mailing |
| 8 | Bug template | **FOUND** | PE/235470851, section 2.6 |
| 8b | Severity / priority definitions | **NOT FOUND** | Priority "should reflect urgency, not just severity" with three questions (PE/235470851). No scale is defined. The RCA template has a "Severity" field left "To confirm" (PE/256081921). Release notes occasionally tag "(Critical)" or "(High)" (PE/65667073, PE/57606145) |
| 9 | Which repos hold the Old World products | **PARTLY FOUND** | No repo list. Fragments: Azure DevOps holds the code and the `dev` branch policy (PE/50429953). A "managed" section and an "unmanaged" (native C++ BP Pro) solution exist (PE/177668097). Named repos: `BPFinanceContracts` (PE/177668097), `iks-gitops` (infrastructure, PE/195297284), `BusPlannerUnified` (New World, PE/251756545). Code units named: `BPInfo.Rest.Service` (PE/136347650), `TripsStandardEdition`, `Georef.Web.Trips.StandardEdition`, `Georef.Web.Users` (PE/214695940), `libs\GEDI` (PE/170721285), `BPGPSReaderService` inside BusPlannerUnified (PE/251756545). Search excerpts of two PRD pages (not read here) show paths `Managed/BPInfo.Rest.Service at main` (PE/239403051) and `Managed/BusPlannerFleet on fleet-main` (PE/239403009) — the PRD pass should have the full map |
| 10 | QA team members and coverage | **PARTLY FOUND** | No roster. Evidence: QA Reviewers group = Nikki, Murtaza, Andy, Yusra, Hamad, "typically QA but Eng leads can approve" (PE/235175938, PE/50429953). Yusra: chatbot and ETL testing, GPS+ (PE/226918402, PE/138313730). Maricar: GPS+ (wrote the user manual) and Wajeeha: named as QA help (PE/9699329, PE/225050641). "About 4 QA staff" (PE/158662658). Who covers which Old World product is not on any page |

## 8. Corrections needed in domain.md / process.md

Applied on 2026-11-10 in both files; listed here for the record.

domain.md
1. Live Viewer BR14 ("no concept of substitution") and "entirely read-only" are confirmed stale: the user manual of 2026-10-30 documents the Route Management dialog on the Live Viewer and a working Compare action (PE/225050641). The note was UNVERIFIED; it is now sourced.
2. Added Event Viewer and Path & Stop Compare rules; they were listed as "not read in full".
3. Added the privacy gap: Event Viewer and Path & Stop Compare apply no depot/operator scoping (PE/137822221, PE/139231233), unlike the Live Viewer.
4. Status boundary: Late = at or above the Late threshold; defaults 5 / 15 / 120 / 5 minutes (PE/225050641, PE/251756545).
5. Unified GPS reader supports five providers (Geotab, Zonar, Synovia, GTS, Samsara), not the nine Old World readers (PE/251756545).
6. Chatbot scope is defined: 42 questions, flags, mandatory qualifiers (PE/137232386).
7. Auth: effective token life is about 65 minutes; the Live Viewer poll is not gated on expiry (PE/162430977).
8. Open question 2 ("where is BP Unified tested") is partly answered: dev, staging and prod exist; URLs for dev and staging are still missing.
9. Open question 9 is confirmed: outside the PRD family there is no definition of done, test strategy or onboarding page.
10. Old World Dispatch: the dispatch database is rebuilt nightly at 2 AM (PE/185204738).
11. New glossary terms: Serviced / Probable / Skipped / Not Seen / Unconfirmed / Not due yet, On-path compliance, GPS gap, run-day, cluster stop origin, Client_Registry, intent table / importer / resolver, Double Back / Double Up.

process.md
1. Test-environment table: Unified has three environments (dev, staging, prod) in each country; staging runs in the namespace `busplanner-staging` on the **dev** cluster; SQL server names added; the tracker monitoring list gains `trackerhealth`.
2. The release cadence is looser than "Wednesday to Tuesday": the calendar shows hotfixes released the day they are promoted and regular releases after 1-2 days on Stage in September (PE/59998210). The calendar is stale after Oct 2.
3. Hotfix testing is "targeted regression" or none (PE/59998210).
4. PE/50429953 is a proposal from July; its statement that there is no dedicated QA environment predates the QA1/QA2 description.
5. New World QA rule and health checks Q.1-Q.6 added (PE/157450256).
6. People directory extended (Tommy Zwirblia, Awais Akram, Maricar Benedictos as QA, Shikhar Patel, Drew Weeks, Vladislav Derbenev, support and CX names) and Andy Tompkins / Michel Walther entries sharpened.
7. Confluence directory: personal spaces were reviewed and hold nothing; pages previously marked "not read in full" are now read.
8. Issue-type guide spells the type "Bug - Eng"; the bug guide spells it "Bug - ENG". Same type.
9. "Resolved" means waiting for the reporter to confirm (PE/185204738) — answers part of the status-name question.
10. Components that must be upgraded together are now listed (release notes).

## 9. Pages that could not be read, or only partly

| Page | What was missed | Why |
|---|---|---|
| 211517442 Miami/Clay Fleet Jira Tasks | All ticket tables | Live Jira macros are not returned by the API; only headings and intro text. Use Jira |
| 212041732 TSTG Jira Tasks | All ticket tables | Same |
| 163545089 Thunderbay zones | The "ENG stories" tracker table | Jira macro |
| 157450256 Stand-Up Checklist | The stand-up tracker lists under ENG-2417 and three "details" links | Jira macros / stripped links |
| 235175938 Build, Deployment and QA Testing Process | The images under "Build Process" and "Release Cadence" | Images and macros are dropped by the markdown conversion. They may show environment names or a calendar; worth opening in a browser |
| 50429953 Release Train and Merge Queue Process | The "Branch and environment flow" diagram | Image dropped |
| 158662658 School Opening retro | The retro deck | Attachment link stripped |
| 177668097, 225050641, 79757313, 195297284 | Screenshots and figures | Images dropped |
| 31 dev release-notes pages | The in-page "Date" field | Date macro dropped; dates taken from titles |
| 225673218 (PE) and 120356866 (personal) | - | Readable but empty |
| 29 folders | - | Folders have no body |
| Attachments (for example the stand-up bundle zip on 251756545) | SQL scripts, CronJob template, reference guides | Attachments were not downloaded |
| Inline and footer comments on pages | - | Not requested from the API |
| The 106 "PRD"-titled items | - | Out of this slice by instruction |

Slack remains unread (see process.md).
