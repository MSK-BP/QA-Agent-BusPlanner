# Meeting knowledge base

What people said, decided, worried about and planned in recorded meetings. Written by `/meeting-harvest`; not approved knowledge. Consult it with `knowledge/` before a decision (see CLAUDE.md, "Two knowledge bases").

Last harvest: 2026-11-25T13:10:00Z (`state.json` `last_run`), 46 meetings in total (36 qa-core, 10 qa-context).

## Differs from knowledge base

Items where a meeting contradicts, updates or answers `knowledge/`. A decision on one of these areas must name the difference.

| Date | Area | Meeting says | Knowledge base says (file) | Note |
|---|---|---|---|---|
| 2026-11-24 | GPS+ Path & Stop Compare | GPS gap drawn dashed when over **3 minutes** (value from the PRD); straight line | No threshold; a break is a "GPS gap" only when the tracker went quiet (`confluence.md`) | [updates](notes/2026/2026-11-24-engineering-deep-dive-206344783.md); supersedes the 2026-11-19 row (1 minute) |
| 2026-11-24 | Time & Attendance | Overlapping shifts must never be allowed (Yusra Abbasi, Tommy Zwirblia); code reading says allowed only after an admin edit (Shikhar Patel); US dev accepts them, CA dev blocks | "V1 performs no time-overlap validation between punches of one shift" (TA-11, `repos/BusPlannerUnified/ta-requirements.md`); ENG-1589 (`jira/eng-1201-1600.md`) | [contradicts](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Environments and access | US dev: Audit Log missing (permission added without admin-role migration); pre-API time-outs with no logs in US and CA dev; US/CA dev behave differently on the same code | Absent (`environments.md`, `test-strategy.md`) | [absent](notes/2026/2026-11-24-engineering-deep-dive-206344783.md), [stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) |
| 2026-11-24 | Environments and access | Canadian prod near capacity: onboard five more clients (to 2026-12-07), then pause until scaling; API auto-scaling; SQL scale-up vs out; GPS Reader redesign for several pods; CA dev+stage share a cluster, US one cluster per environment | Absent (`architecture.md`); single-pod GPS services and lease proposal confirmed (`confluence.md`) | [absent](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md), [GPS+ sync](notes/2026/2026-11-24-gps-plus-leadership-sync-206584659.md) (says about 5 more clients) |
| 2026-11-24 | Time & Attendance | Production Nash T&A database to be restored to dev/stage for export testing; export must match a known-good PDF exactly | No Nash database listed (`environments.md`); hard rule 5 applies | [absent](notes/2026/2026-11-24-qa-onboarding-206383252.md) |
| 2026-11-24 | Mobile apps | QA takes over mobile testing; iOS via TestFlight, Android APK by QR; Quick Codes to QA1/QA2; built-in Turns location spoofer and drive replay; regression plan outdated | `access.md` A2 (APK, QA quick code, tablet needed); "no regression checklist" (`INDEX.md` Known holes); spoofer absent (`repos/Apps.md`) | [updates](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md), [stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) |
| 2026-11-24 | Release and branching | 13.5.1 released 2026-11-24; 13.5.2: Dev Complete end of next week, code freeze 2026-12-04, QA complete + staging 2026-12-09, release 2026-12-15 | Weekly train, no freeze (`process.md`); "A calendar freeze was rejected" (`confluence.md`) | [updates](notes/2026/2026-11-24-product-backlog-grooming-206471711.md), [stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) |
| 2026-11-24 | Old World defects | SPT-937 is a hotfix candidate (three clients); SPT-1013 time shift (likely client IT); Toronto backup and alert-email failures | SPT-937 in Backlog (`jira/other-projects.md`); others absent | [updates](notes/2026/2026-11-24-support-engineering-huddle-206434224.md) |
| 2026-11-24 | Mobile apps | Undo of manual scans (hard/soft delete/30 s window) and NFC card sign-in for drivers under study; Turns users live in BP Service Administration (no API) | Absent (`repos/Apps.md`, `architecture.md`) | [absent](notes/2026/2026-11-24-turns-undo-scans-card-login-206431675.md) |
| 2026-11-24 | Auth | PROD-997 New World user management: customer admin role phase proposed | Users and Access PRD final 2026-10-26 (`domain.md`) | [absent](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) |
| 2026-11-24 | Notifications and two-way sync | Two-way sync splits the Substitution Service; notifications reuse its queue design; Michel Walther reviews | Absent (`architecture.md`) | [absent](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | GPS+ Route Management | US clients must migrate new GPS+ and new Dispatch together; Chipmunk compatibility with new GPS+ untested | Absent (`domain.md`) | [absent](notes/2026/2026-11-24-gps-plus-leadership-sync-206584659.md), [grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) |
| 2026-11-24 | Release and branching | BusPlanner GitHub organisation to be created | "`MSK-BP` belongs to no organisation" (`access.md`) | [updates](notes/2026/2026-11-24-qa-onboarding-206383252.md) |
| 2026-11-23 | Release and branching | One main release in December: 13.5.2 on 2026-12-15 (promote 12-09); 12-22 cancelled; Fleet 12.4.16 last of 2026 (12.4.17 cancel pending) | Weekly train, no dates (`process.md`) | [updates](notes/2026/2026-11-23-sprint-refinement-206045688.md), [huddle](notes/2026/2026-11-23-support-engineering-huddle-205950536.md); supersedes the 2026-11-20 row (13.5.3 on 12-22) |
| 2026-11-23 | Release and branching | Hotfix only for a code change, after normal escalation; P0 called by Amanda McInnis / Tommy Zwirblia / Umar (tentative); Control Center meeting and RCA for every P0; non-code fixes skip the process | Hotfixes go out same or next day with targeted regression (`process.md`); "severity/priority definitions" not documented (`INDEX.md` Known holes) | [updates](notes/2026/2026-11-23-release-process-working-session-206104652.md) |
| 2026-11-23 | Release and branching | New World: feature branch, then QA in its own environment, then merge to `dev`; `dev` = integration, `stage` = regression; GitHub Actions; SQL migrations applied by hand today | Old World flow: whole `dev` promoted to `stage`, functional QA on QA1 (`process.md`); no GitHub Actions or migration step (`architecture.md`) | [updates](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) (confirms the 2026-11-19 decision) |
| 2026-11-23 | QA process and priorities | 50-60% of Old World QA time is setup; QA averages 3-4 h per ticket | Absent (`test-strategy.md`) | [absent](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) |
| 2026-11-23 | QA process and priorities | QA pivots to T&A this week for a US-only release (3-4 days); chatbot QA on CA reduced to a regression check (no client live) | No QA-order line in `test-strategy.md` | [updates](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Environments and access | US dev/stage/prod reported far out of sync with Git; payroll export deployed only in Canada; planned restore of a production T&A client database to US staging, with login cleanup | Absent (`environments.md`: US staging clients NCPS, YSD; their SQL server not identified) | [absent](notes/2026/2026-11-23-bp-eng-standup-205847641.md) (summary only), [deep dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Release and branching | Sprint kickoff on Fridays, retrospective on Thursdays | "two weeks, Monday kickoff/planning to Friday retrospective" (`process.md`) | [contradicts](notes/2026/2026-11-23-bp-eng-standup-205847641.md) (summary only) |
| 2026-11-23 | Ride Support (Discipline) | Turns sign-in for Ride Support: real login, not PIN (PII); REST-to-Unified automatic sign-in under study; drivers need individual accounts | No sign-in rule for Ride Support (`domain.md`); T&A uses PIN (`domain.md`) | [absent](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Offline mode: referrals can be written and submitted with no signal | Open item "P1 Turns offline rider data" (`domain.md`) | [answers](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | A driver can refer any student in the system (student search), not only riders on their run | Absent (`domain.md`) | [absent](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Suspended-rider alerts not in V1 (pending sales check with New Caney) | V1 "Not in V1" list omits suspended-rider alerts (`domain.md`) | [absent](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Discipline "done mid-December", then about a month of polish and QA | "Core flows must be built and pass QA by 2026-12-18" (`domain.md`); "No hard Ride Support deadline yet." (`test-strategy.md`) | [contradicts](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | ETL | Landmark weekly copy script ENG-3058 paused; change for Staff and Vehicles due for the 2026-11-27 run | No file names ENG-3058 | [absent](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Old World defects | SPT-1006 (Toronto report sharing, workaround), ticket 963 (district admin sees other districts' routes in a report by operator; prefix unclear), SPT-997 (intermittent, Chipmunk area) | None of them in `jira/other-projects.md` | [absent](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) |
| 2026-11-23 | Notifications and two-way sync | Notification Engine on hold after a staffing change | `domain.md` V1: "email by hand until a notification service exists" | [updates](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | GPS+ Route Management | Substitution Service runs about every 5 min, no UI; QA checks tables against Old World; Dispatch dashboard to replace it | Period not recorded (`process.md`, PE/156794883) | [absent](notes/2026/2026-11-23-product-suite-knowledge-transfer-206034723.md) (summary only) |
| 2026-11-23 | Environments and access | Server changes logged in Jira (SOC); one-notch resizes without approval; 40% buffer; a resize reboots the server | Absent (`environments.md`, `architecture.md`) | [absent](notes/2026/2026-11-23-server-procurement-process-206084465.md) (summary only) |
| 2026-11-20 | GPS+ Path & Stop Compare | Pass shown for a stop picked by rank, then **time**, then distance; "Visited" is a rank, not an outcome | "GPS+ stop visit pick rule stays higher rank then shorter distance … (ENG-2849)" (`jira/eng-2801-latest.md`) | [updates](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Environments and access | No scrub process for dev; whether developers and agents may use a client's data depends on the client (data residency, explicit permission) | "Dev also holds real customer data … Hard rule 5 applies" (`environments.md`); no per-client permission | [absent](notes/2026/2026-11-20-engineering-deep-dive-205362569.md): matters for agentic QA on dev |
| 2026-11-20 | Database migrations | Feature-branch migrations on the shared dev database can break other developers; no dev refresh from staging | Absent (`environments.md`, `test-strategy.md`) | [absent](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | GPS+ Route Management | Front-end-only loading works for HRCE (~6,000 rows), fails for large clients (NSTS); redesign decision 2026-11-23 | Absent | [absent](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Forms engine | Package committed to `docs/forms-engine` on branch `forms/ENG-3249-…` (not in `dev`); Claude found the draft SQL incompatible with `dev` (5 breaking issues, 7 Jira tickets to fix, summary only) | "It will go into `BusPlannerUnified` at `docs/forms-engine/`"; install order on schema v7.21 (`domain.md`) | [updates](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Ride Support (Discipline) | Module lives in `BusPlanner Unified/modules` with Application/Domain/Infrastructure projects | Absent | [absent](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Release and branching | 13.5.2 on 2026-12-15, 13.5.3 on 2026-12-22 (bug-focused); ENG-246 and ENG-588 must ship by year end | Weekly train, no dates (`process.md`); ENG-246, ENG-588 "Open" (`jira/eng-0001-0400.md`, `jira/eng-0401-0800.md`) | [updates](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | Old World defects | SPT-999 finance billing report fails for one district after SaaS migration: Highest | Absent | [absent](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | Ontario Ministry reports | Courtesy split into CTY, TFN, TIN extended-property types; missing values make students "Other" | One courtesy extended property (ENG-2536, `jira/eng-2401-2800.md`) | [updates](notes/2026/2026-11-20-ontario-ministry-reports-205530038.md) (summary only) |
| 2026-11-20 | GPS readers | CalAmp substitutions pulled on an interval (~10 min); temporary in CalAmp only, permanent in both; Francobus vehicle history missing | Absent (`architecture.md` vendors UNVERIFIED) | [absent](notes/2026/2026-11-20-calamp-substitutions-customer-call-205497664.md) (summary only) |
| 2026-11-20 | Chatbot | Reviewed for prompt injection; answers BusPlanner data only | Declines cover out-of-scope BusPlanner questions only (`repos/BusPlannerUnified/chatbot-spec.md`) | [updates](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) (summary only) |
| 2026-11-19 | Ride Support (Discipline) | V1 release (with Dispatch) moved to early January | "Core flows must be built and pass QA by **2026-12-18**" (`domain.md`) | [updates](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Ride Support (Discipline) | V1: no family letters or messages, no Chipmunk change; family contact is a manual checkbox and date | Users include "families (letters only)" (`domain.md`); Ride Support V1 spec (`confluence-prd.md`) | [updates](notes/2026/2026-11-19-discipline-planning-205027556.md), [walkthrough](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Ride Support (Discipline) | Prototype: district-configured routing chain; unopened for one school day it moves on | "unopened for Conduct_ReviewDays school days (default 2) escalates"; V1 is "one path from two settings and starter roles instead of routing chains" (`confluence-prd.md`) | [contradicts](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) (prototype demo, not a spec change) |
| 2026-11-19 | Ride Support (Discipline) | Requirements and QA steps live as repo markdown (`docs/form-engine`, summary only), one-way to Jira PROD-847/848; Claude-built epics, one epic at a time | Spec is the Confluence folder PE/238616600, "Ride Support V1" v0.7 (`domain.md`) | [updates](notes/2026/2026-11-19-discipline-handoff-205163106.md), [planning](notes/2026/2026-11-19-discipline-planning-205027556.md) |
| 2026-11-19 | QA process and priorities | Sharaiz Khan and Ibrahim Usman to set up Playwright E2E for the New World Discipline work now | Playwright/Appium/xUnit framework is Track 2, later; Track 1 is agentic via this hub (`test-strategy.md`) | [differs in part](notes/2026/2026-11-19-discipline-handoff-205163106.md) (summary only) |
| 2026-11-19 | Forms engine | One set of form tables for Discipline, Inspection and Workflow; a submission is saved to the database, then queued per module | Ride Support tables `cnd_` / `sc_`; SY-16 forms engine "TO-BE the one inspection engine" (`confluence-prd.md`) | [updates](notes/2026/2026-11-19-engineering-deep-dive-204907852.md), [walkthrough](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Release and branching | A feature branch passes QA in its own environment before merge to `dev`; skip lane only by group decision; epic branches for dependent tickets | `dev` gate is the PR-APPROVERS group, "typically QA" (`confluence.md`); functional QA on `dev` (`process.md`) | [updates](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) (decided in principle; needs feature-branch environments first; replaces the 2026-11-16 statement) |
| 2026-11-19 | Release and branching | No release branch per version; keep `dev` → `stage` → `main` with tags | "Branching proposal for the GitHub move: `reports/2026-11-12-branching-strategy.md`" (`architecture.md`) | [updates](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md): check that proposal |
| 2026-11-19 | Release and branching | 13.5.1 promoted to Stage on Thursday 2026-11-19; untested items reverted by a deadline | "Weekly promote to Stage every Wednesday" (`confluence.md`) | [differs](notes/2026/2026-11-19-bp-eng-standup-204885304.md) (one-off timing) |
| 2026-11-19 | GPS+ Live Viewer | End phase: last stop reached after one serviced stop; next run shown if within 30 min; "Run ended" label (tickets 3212, 3214); mid-run substitution overlap is a known gap (3213) | Absent | [absent](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | GPS+ Path & Stop Compare | (superseded by 2026-11-24: 3 minutes) GPS gaps of more than 1 minute drawn as dashed lines; PRD does not join points over 5 minutes apart | A break is a "GPS gap" only when the tracker went quiet; no 1-minute rule (`confluence.md`) | [absent](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) (planned) |
| 2026-11-19 | GPS readers | A Geotab naming change broke stop events (string match, not an ID); clients correct their own Geotab config | Geotab vehicle match by serial number; no name dependency (`repos/BusPlannerUnified/data-services.md`) | [absent](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) (summary only) |
| 2026-11-19 | Old World defects | VRO work order delete removes its paid PO: now a High bug to fix | ENG-2928 "current behaviour; product decision pending" (`jira/eng-2801-latest.md`) | [updates](notes/2026/2026-11-19-qa-bug-triage-205099052.md) (likely the same issue) |
| 2026-11-19 | Old World defects | New: cancellation/delay report misses all-day alerts posted for the next day (Highest); BP Quick multi-run incident report merges AM and PM (High); Fleet PO receive has no quantity limit (High) | Absent | [absent](notes/2026/2026-11-19-qa-bug-triage-205099052.md) |
| 2026-11-19 | QA process and priorities | QA bug triage weekly, with QA pre-triage of its own bugs | Only the daily SPT triage call with support (`process.md`) | [absent](notes/2026/2026-11-19-qa-bug-triage-205099052.md) |
| 2026-11-19 | Environments and access | Forms schema in a dev sandbox copy of the HRCE database; changes to existing tables reviewed before leaving it | No such database (`environments.md`) | [absent](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | ETL | ETL QA design paused until an ETL workflow diagram arrives; migration "Skill 2" validates loads and fails on staff ID | Absent (`test-strategy.md`) | [absent](notes/2026/2026-11-19-engineering-onboarding-204968938.md), [sync](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) (summary only) |
| 2026-11-18 | Environments and access | A customer production URL (STSYR) was named in a meeting; it is not written here. Add it to `blocked-patterns.txt` in the next interactive session | `blocked-patterns.txt` | [production host named](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) |
| 2026-11-18 | GPS+ Path & Stop Compare | Compare gets 30 s auto-refresh of path and vehicle, refresh and pause buttons; opens from Live Viewer in a new tab | Compare opens for "last 7 days ending today"; GPS+ history pages have no auto-refresh (`confluence.md` 5.3) | [updates](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) (planned) |
| 2026-11-18 | Database migrations | GPS event table needs a new index for late-arriving events; applied by a separate script and the create-database script, not the migration tool; stop classification fails without it | ENG-1193 "No index leading on gps_event_history.event_timestamp." (`jira/eng-0801-1200.md`) | [updates](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Chatbot | Model hosted in Canada; prompts must not leave Canada | No hosting region recorded (`repos/BusPlannerUnified/chatbot.md`) | [absent](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Chatbot | Usage tracked per customer and per user; no customer spend limits, usage display or client keys | "Token-cost ceiling and per-user rate limits are **deferred**" (`repos/BusPlannerUnified/chatbot-spec.md`) | [updates](notes/2026/2026-11-18-engineering-deep-dive-204431295.md): dropped, not deferred |
| 2026-11-18 | Chatbot | Chatbot must refuse general, non-BusPlanner questions | Declines cover out-of-scope BusPlanner questions only (`repos/BusPlannerUnified/chatbot-spec.md`) | [absent](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Release and branching | Container registry (one per region, shared by all environments) filled up and failed a deploy; retention plan agreed | No registry or retention rule (`architecture.md`) | [absent](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | GPS+ Path & Stop Compare | Old World has no historical plan: a BP Pro past-date path compare uses today's plan | Snapshot glossary only (`domain.md`) | [absent](notes/2026/2026-11-18-engineering-deep-dive-204431295.md); partly answers the 2026-11-13 window question |
| 2026-11-18 | Environments and access | Tri-County database created in production only, not dev or staging | "Tri-County CA-NS-TCRCE (In Progress, P2 net new)" (`jira/eng-2401-2800.md`) | [updates](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Old World SaaS migration | STSYR plans a move from on-premise to SaaS, likely summer | ENG-1997: STSYR on its own Hyper-V / SQL 2022 server (`jira/eng-1601-2000.md`) | [updates](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) (tentative) |
| 2026-11-18 | BP Pro routing | A run must be inserted into a route in Route Manager; manual Location IDs need an access street | No such rule (`domain.md`, `confluence-prd.md`) | [absent](notes/2026/2026-11-18-bp-pro-run-creation-training-204532051.md) (summary only) |
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

One customer production URL was named (2026-11-18, STSYR); it is not written in this base. See the first row of the table.

## Decision register

Newest first. Superseded decisions stay, marked.

| Date | Area | Decision | Owner | Status | Note |
|---|---|---|---|---|---|
| 2026-11-24 | Release and branching | 13.5.2 last 2026 release 2026-12-15; code freeze 12-04; QA complete + staging 12-09; tickets Dev Complete by end of next week | Murtaza Khalil | decided | [note](notes/2026/2026-11-24-product-backlog-grooming-206471711.md), [stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) |
| 2026-11-24 | Release and branching | 13.5.1 released 2026-11-24 | Shikhar Patel | decided | [note](notes/2026/2026-11-24-bp-eng-standup-206319910.md) |
| 2026-11-24 | Environments and access | Canadian prod: five more clients (to 2026-12-07), then pause until scaling; API auto-scaling; SQL recommendation; GPS Reader scaling design | Andy Tompkins, Shikhar Patel, Daniel Sukhram | decided | [note](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) |
| 2026-11-24 | Environments and access | US and CA environments keep the same architecture; CA namespace alignment done with the QA environments work | Andy Tompkins | decided | [note](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) |
| 2026-11-24 | GPS+ Path & Stop Compare | GPS gaps over 3 minutes drawn dashed (PRD value), straight line | Vladislav Derbenev, Tommy Zwirblia | decided | [note](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Notifications and two-way sync | Michel Walther reviews two-way sync after Vehicle Manager; notifications reuse the same queue design | Tommy Zwirblia | decided | [note](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Ride Support (Discipline) | MD changes peer-reviewed, Tommy Zwirblia and Andy Tompkins optional reviewers; Stephen Hu starts the Unified-Turns API | Tommy Zwirblia | decided | [note](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Mobile apps | Mobile app testing moves from developers to QA | Nikki Tilano | decided | [note](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md) |
| 2026-11-24 | Time & Attendance | Restore Nash T&A to dev/stage; document and shadow the restore before 2026-12-07 | Nikki Tilano | decided | [note](notes/2026/2026-11-24-qa-onboarding-206383252.md) |
| 2026-11-24 | Release and branching | Create the BusPlanner GitHub organisation | Tommy Zwirblia | decided | [note](notes/2026/2026-11-24-qa-onboarding-206383252.md) |
| 2026-11-24 | Old World defects | SPT-937 hotfix candidate; developer assigned with a time-box | Murtaza Khalil | decided (summary only) | [note](notes/2026/2026-11-24-support-engineering-huddle-206434224.md) |
| 2026-11-24 | Environments and access | Old servers: image template exported to Object Storage; one restore test; decommission by month end | Andy Tompkins | decided | [note](notes/2026/2026-11-24-image-backup-old-servers-206573694.md) |
| 2026-11-23 | Release and branching | One main release in December, 2026-12-15; 2026-12-22 cancelled; no release until January | Murtaza Khalil, Nikki Tilano | decided | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md), [huddle](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) |
| 2026-11-23 | Release and branching | Fleet 12.4.16 last release of 2026; cancel 12.4.17 (pending Matt) | Nikki Tilano | tentative | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | Release and branching | Hotfix process only for code changes; normal escalation first; Control Center and RCA per P0 | Nikki Tilano, Amanda McInnis | decided | [note](notes/2026/2026-11-23-release-process-working-session-206104652.md) |
| 2026-11-23 | Release and branching | New World: keep `main`/`stage`/`dev`; QA on the feature branch before merge to `dev`; no release branches; GitHub Actions | Andy Tompkins, Shikhar Patel | decided | [note](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) |
| 2026-11-23 | Release and branching | Several people learn New World deployment in one recorded session before Shikhar Patel's leave | Andy Tompkins | decided | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | Release and branching | Sprint kickoff Fridays, retrospective Thursdays | Nikki Tilano | stated (summary only) | [note](notes/2026/2026-11-23-bp-eng-standup-205847641.md) |
| 2026-11-23 | QA process and priorities | QA pivots to T&A this week for a US-only release; chatbot QA on CA reduced to regression | Tommy Zwirblia, Nikki Tilano | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | QA process and priorities | QA speed gets its own discussion, separate from branching | Nikki Tilano, Andy Tompkins | decided | [note](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) |
| 2026-11-23 | Ride Support (Discipline) | Real sign-in on Turns for Ride Support, not PIN | Tommy Zwirblia | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Offline mode; finish a referral on the form version it started on; submit on an older version allowed | Tommy Zwirblia | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | New World keys for riders and runs; feature detection as today in Turns | Tommy Zwirblia | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Referral for any student in the system | Tommy Zwirblia | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Suspended-rider alerts not in V1 (sales check pending) | Tommy Zwirblia, Stephen Hu | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Stories one epic ahead; repo is source of truth; estimate the rest from Wave 1 effort | Tommy Zwirblia | stated | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Discipline done mid-December, then about a month of QA and fixes; Stephen Hu does the Turns work | Andy Tompkins | stated | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | ETL | ENG-3058 Landmark script changed for Staff and Vehicles by 2026-11-27 | Matthew Hayes (assigned by Murtaza Khalil) | decided | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Chatbot | Keep all V1/V1.5 bugs assigned, low included; 14 enhancements go through product first | Tommy Zwirblia | decided | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | Mobile apps | Document app-store submission; Imran owns it | Andy Tompkins, Nikki Tilano | decided | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | Old World defects | SPT-1006 fix deferred to a later release (workaround accepted) | Andy Tompkins | decided | [note](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) |
| 2026-11-23 | Environments and access | Server changes logged in Jira; one-notch resizes need no approval; new servers and decommissions do | Ahnaf Rahman, Andy Tompkins | decided (summary only) | [note](notes/2026/2026-11-23-server-procurement-process-206084465.md) |
| 2026-11-20 | GPS+ Path & Stop Compare | Compare pass pick rule: rank → time → distance | Vladislav Derbenev | decided | [note](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Ride Support (Discipline) | Module goes in `BusPlanner Unified/modules` | Jon Borromeo, Drew Weeks, Stephen Hu | decided | [note](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Release and branching | Keep the current branch convention (`forms/ENG-3249-…`); `feature/<key>` only when the whole team agrees | Andy Tompkins | decided | [note](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Forms engine | Package markdown is the source of truth; Jira synced from it; Claude plans go to Confluence | Tommy Zwirblia, Jon Borromeo | stated | [note](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Release and branching | 13.5.2 on 2026-12-15, 13.5.3 on 2026-12-22 bug-focused; ENG-246, ENG-588 by year end; no large features at year end | Nikki Tilano | stated; superseded by 2026-11-23 (12-22 cancelled) | [note](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | Old World defects | SPT-999 raised to Highest | Chris MacLeod | decided | [note](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | QA process and priorities | Support may use Claude on the source code; people stay responsible for answers | Andy Tompkins | decided | [note](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | Release and branching | Next release Tuesday 2026-11-24 (fallback 2026-11-25); regression first, then Fleet items | Nikki Tilano | stated (summary only) | [note](notes/2026/2026-11-20-bp-eng-standup-205348805.md) |
| 2026-11-19 | Release and branching | A client-facing feature branch must pass QA in its own environment before merge to `dev` | Andy Tompkins | decided (in principle) | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Release and branching | Keep `dev` → `stage` → `main` with tags; no release branch per version | Andy Tompkins, Shikhar Patel | decided | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Release and branching | Skip lane stays; each use decided by a group, never one developer | Andy Tompkins | decided | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Release and branching | Dependent tickets: test each branch, then an epic branch for integration, then `dev` | Andy Tompkins | decided | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Release and branching | 13.5.1: items not QA-done by 2–3 p.m. are reverted before the Stage promote | Nikki Tilano | decided | [note](notes/2026/2026-11-19-bp-eng-standup-204885304.md) |
| 2026-11-19 | Ride Support (Discipline) | V1 (with Dispatch) target early January | Tommy Zwirblia | stated | [note](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Ride Support (Discipline) | V1 excludes family letters, Chipmunk, SIS push-back, emergency incident reports; manual contact checkbox only | Tommy Zwirblia | decided | [note](notes/2026/2026-11-19-discipline-planning-205027556.md) |
| 2026-11-19 | Ride Support (Discipline) | First build: Turns Referrals button (username/password sign-in), referral page, JSON forms in the database | Tommy Zwirblia | decided | [note](notes/2026/2026-11-19-discipline-planning-205027556.md) |
| 2026-11-19 | Ride Support (Discipline) | Repo markdown is the source of truth, one-way to Jira; one epic at a time | Tommy Zwirblia | stated | [note](notes/2026/2026-11-19-discipline-handoff-205163106.md) |
| 2026-11-19 | QA process and priorities | Sharaiz Khan and Ibrahim Usman own agentic New World QA, including Playwright E2E | Tommy Zwirblia | stated (summary only) | [note](notes/2026/2026-11-19-discipline-handoff-205163106.md) |
| 2026-11-19 | Forms engine | One set of form tables for all modules; submission saved, then queued per module | Tommy Zwirblia | decided | [note](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | GPS+ Live Viewer | "Run ended" label now, "Ended" status later; show overlapping runs; 20-bus end-phase gap accepted | Tommy Zwirblia, Andy Tompkins | decided | [note](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | GPS+ Path & Stop Compare | GPS gaps over 1 minute drawn dashed | Tommy Zwirblia | superseded by 2026-11-24 | [note](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | QA process and priorities | QA bug triage weekly until the backlog is small; QA pre-triages | Andy Tompkins, Nikki Tilano | decided | [note](notes/2026/2026-11-19-qa-bug-triage-205099052.md) |
| 2026-11-19 | Old World defects | Cancellation/delay all-day alert bug Highest; VRO PO deletion and PO quantity bugs High | Andy Tompkins, Nikki Tilano | decided | [note](notes/2026/2026-11-19-qa-bug-triage-205099052.md) |
| 2026-11-19 | GPS readers | Clients correct their own Geotab configuration after the Geotab change | not named | stated (summary only) | [note](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) |
| 2026-11-18 | Chatbot | Go-live: current features working right; net-new feedback items are not blockers | Tommy Zwirblia | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Chatbot | Use the AWS-hosted model in Canada; prompts stay in Canada | Tommy Zwirblia | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Chatbot | BusPlanner provides all keys; no client keys, no client spend limits or usage screens; track usage per customer and user internally | Tommy Zwirblia, Andy Tompkins | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | GPS+ Path & Stop Compare | Add 30 s auto-refresh, refresh and pause; Live Viewer and Compare replace the three old views | Tommy Zwirblia | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Database migrations | GPS event index goes in the create-database script and a separate script, not the migration tool; HRCE staging and prod first | Shikhar Patel | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Release and branching | Container registry: keep latest 25–30 images now; later a scheduled job keeps in-use and rollback images | Shikhar Patel, Andy Tompkins | decided | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
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
| 2026-11-24 | Time & Attendance | Are overlapping shifts ever allowed (after an admin edit)? Why do US dev and CA dev differ? | open | [note](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Notifications and two-way sync | Who builds two-way sync in depth; library or own queue service? | open | [note](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) |
| 2026-11-24 | Environments and access | GPS Reader: auto-scaling now or manual pods first; client-provider vs time-boxed unit of work? SQL scale up or out? | open | [note](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) |
| 2026-11-24 | GPS+ Route Management | Can the new GPS+ run with the old Chipmunk parent app (test 2026-11-25)? | open | [note](notes/2026/2026-11-24-gps-plus-leadership-sync-206584659.md), [grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) |
| 2026-11-24 | Mobile apps | Undo manual scans: hard delete acceptable? NFC cards with existing readers? | open | [note](notes/2026/2026-11-24-turns-undo-scans-card-login-206431675.md) |
| 2026-11-24 | Auth | Is PROD-997 phase 1 (customer admin role) prioritised now? | open | [note](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) |
| 2026-11-24 | Old World defects | Which ticket is "Engineering 3.1.1.9" (Tri-County)? | open | [note](notes/2026/2026-11-24-support-engineering-huddle-206434224.md) |
| 2026-11-23 | Ride Support (Discipline) | How does a driver signed in to BPInfo REST get signed in to Unified, and how are users matched after an email change? | open (Stephen Hu researching) | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Ride Support (Discipline) | Can New Caney accept V1 without suspended-rider alerts and seating charts? | open | [note](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) |
| 2026-11-23 | Release and branching | New World versioning strategy (needed before tags)? | open | [note](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) |
| 2026-11-23 | Release and branching | Which module outages are P0 vs P1; will engineering commit to fix-time SLAs? | open | [note](notes/2026/2026-11-23-release-process-working-session-206104652.md) |
| 2026-11-23 | Environments and access | How far are US environments behind Canada and Git, and how are they brought in line? | open | [note](notes/2026/2026-11-23-bp-eng-standup-205847641.md) |
| 2026-11-23 | QA process and priorities | Chatbot V2 or Chipmunk stability first? | open | [note](notes/2026/2026-11-23-sprint-refinement-206045688.md) |
| 2026-11-23 | Old World defects | Is ticket 963 in SPT or another project? | open | [note](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) |
| 2026-11-20 | GPS+ Route Management | Which large-client loading redesign, and before Dispatch? | open (decision planned 2026-11-23) | [note](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Environments and access | May developers and agents read a given client's data on dev, and where is that recorded per client? | open | [note](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Database migrations | How are migrations on the shared dev database coordinated? | open | [note](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | QA process and priorities | Will Playwright run in the Unified CI pipelines? | open | [note](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) |
| 2026-11-20 | Release and branching | Which branch convention will the team adopt, and when? | open | [note](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) |
| 2026-11-20 | Old World defects | Who fixes SPT-999, and does it take time from Discipline? | open | [note](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) |
| 2026-11-20 | GPS readers | Is the Francobus vehicle-history gap on the vendor side or in the reader? | open | [note](notes/2026/2026-11-20-calamp-substitutions-customer-call-205497664.md) |
| 2026-11-19 | Release and branching | How many feature-branch QA environments, where (IBM Cloud or local Docker), and who deploys a branch? | open | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Release and branching | Who approves PRs into `dev`, and who decides a skip-lane use? | open | [note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) |
| 2026-11-19 | Ride Support (Discipline) | Final name of the praise/discipline/concern function? | open | [note](notes/2026/2026-11-19-discipline-planning-205027556.md) |
| 2026-11-19 | Ride Support (Discipline) | Suspension start date: required with no default, or a time-of-day default? | open | [note](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Ride Support (Discipline) | Is the routing chain configurable in V1, and is the timer one or two school days? | open | [note](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | Ride Support (Discipline) | Is the customer form builder in V1? | open | [note](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) |
| 2026-11-19 | QA process and priorities | How do the hub's `tests/` cases relate to QA steps in repo markdown and Jira? | open | [note](notes/2026/2026-11-19-discipline-handoff-205163106.md) |
| 2026-11-19 | GPS+ Live Viewer | Which filters and reports change when "On time" becomes "Ended"? | open | [note](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) |
| 2026-11-19 | Old World defects | Does the 00:00 alert timestamp also break the bus stop campaign report and other date-filtered reports? | open | [note](notes/2026/2026-11-19-qa-bug-triage-205099052.md) |
| 2026-11-19 | GPS readers | Which Geotab field changed, and will the string match be replaced by an ID? | open | [note](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) |
| 2026-11-18 | GPS+ Path & Stop Compare | Does the 30 s refresh apply to past dates, or only to today? | open | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Chatbot | Is the "BusPlanner data only" rule built and covered by a decline eval? | partly answered 2026-11-20: stated as built and reviewed; eval not named ([note](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md), summary only) | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Database migrations | Who checks, about a week later, that every database has the GPS event index? | open | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Ridership | Where do ridership and rider scans live in the New World: module, GPS+ or both? | open | [note](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) |
| 2026-11-18 | Mobile apps | Does the Samsara integration cover the driver apps, and which tablet specs will be published? | open | [note](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) |
| 2026-11-17 | Stop boundaries | Which product gets the boundary feature: BP Pro, BP Web or BP Unified? | open | [note](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) |
| 2026-11-17 | Stop boundaries | What happens to a student inside a boundary whose stop is retired or moved? | open | [note](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) |
| 2026-11-16 | ETL | Snapshot window: "today plus nine/10 days" or 10 weekdays? | open | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-16 | Release and branching | Will the GitHub move change how QA gates merges into `dev`? | answered 2026-11-19: yes, a feature branch passes QA before merge to `dev` ([note](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md)) | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-16 | Release and branching | Which flag model (none, product, per-client) will the new branching strategy use? | open | [note](notes/2026/2026-11-16-etl-workflows-203613040.md) |
| 2026-11-13 | Ride Support (Discipline) | Is 2026-12-18 a dev-complete target or a "passed QA" deadline? | partly answered 2026-11-19: V1 release moved to early January ([note](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md)) | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | Mobile apps | Which physical mobile devices exist for testing? | open | [note](notes/2026/2026-11-13-qa-onboarding-202993371.md) |
| 2026-11-13 | ETL | Does the ETL Extract fix need a regression test for a run with three or four split mappings? | open | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
| 2026-11-13 | GPS+ Path & Stop Compare | What time window does the New World Path Compare use compared with BP Pro? | partly answered 2026-11-18 (BP Pro uses today's plan for past dates) | [note](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) |
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

- 2026-11-24 · [Product backlog grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) · New GPS+ viewer for Chipmunk clients lacks vehicle management
- 2026-11-19 · [Engineering Deep Dive](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) · End phase results, "Run ended" label, overlapping substitution runs
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · Live Viewer refresh moves into Path & Stop Compare
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · HRCE blockers: stop descriptions (ENG-2789), status sort (ENG-2880), hidden waypoints

### GPS+ Path & Stop Compare

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · GPS gaps over 3 minutes dashed (PRD), replaces 1 minute
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Pass pick rule rank → time → distance; "+1" extra passes
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · Old GPS Path Compare fix ENG-2065; GPS+ date handling
- 2026-11-19 · [Engineering Deep Dive](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) · GPS gaps over 1 minute dashed; time slider later
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · 30 s auto-refresh and pause; BP Pro has no historical plan
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · ENG-3136 Landmark: inverted door signals, path not driven in BP Pro
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · ENG-2788 hide waypoints; SPT-924, SPT-841 raised to Highest

### GPS+ Route Management

- 2026-11-24 · [GPS+ leadership sync](notes/2026/2026-11-24-gps-plus-leadership-sync-206584659.md) · Client rollout status; US needs GPS+ and Dispatch together; Chipmunk compatibility test
- 2026-11-23 · [Product suite knowledge transfer](notes/2026/2026-11-23-product-suite-knowledge-transfer-206034723.md) · Substitution Service every ~5 min; Dispatch dashboard to replace it
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Front-end-only loading fails for large clients; redesign decision 2026-11-23
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · Old World substitutions flow to the New World without Dispatch
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · HRCE GPS+ release planned for the next week, without the vehicle manager
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Three new BP Info APIs for the vehicle assignment page; split dated mappings
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Vehicle assignment page design; run-level rule; overlap with Dispatch left open

### BP Info

- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · ENG-3152 APIs for Unified vehicle assignments
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · New APIs; operator-provider pairing not exposed today
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Assignment writes to the Old World through BP Info

### GPS readers

- 2026-11-24 · [Canadian prod scaling](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) · Reader cannot split work; lease design; unit-of-work debate
- 2026-11-24 · [GPS+ leadership sync](notes/2026/2026-11-24-gps-plus-leadership-sync-206584659.md) · About 5 more clients; reader credentials pending
- 2026-11-20 · [CalAmp substitutions call](notes/2026/2026-11-20-calamp-substitutions-customer-call-205497664.md) · CalAmp pulled on an interval; temporary vs permanent substitutions; Francobus history gap
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · ENG-2971 Geotab time zone; ENG-2410 mapping bleed
- 2026-11-19 · [GPS+ leadership sync](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) · Geotab naming change broke stop events; scaling to 10 clients
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Unified reader replaces Old World readers; single pod, no multi-pod logic
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Geotab AUX ports and signal inversion; settings not synced

### ETL

- 2026-11-24 · [On-boarding](notes/2026/2026-11-24-qa-onboarding-206383252.md) · Mapping sheet delivered; ETL testing vision doc next
- 2026-11-24 · [Canadian prod scaling](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) · ETL load is the SQL peak; Extract runs on Old World SaaS
- 2026-11-23 · [Engineering Deep Dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) · Landmark weekly copy script ENG-3058 paused; fix for 11-27
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Nightly ETL feeds Discipline; no dev refresh from staging
- 2026-11-19 · [GPS+ leadership sync](notes/2026/2026-11-19-gps-plus-leadership-sync-205156943.md) · Migration Skill 2 validates ETL loads, blocked on staff ID
- 2026-11-19 · [On-boarding](notes/2026/2026-11-19-engineering-onboarding-204968938.md) · ETL QA design waits for a workflow diagram
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Extract and Load flow, snapshots, no written table mapping, unit tests exist
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · ETL as the QA fill-in track (chatbot QA pipeline)
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Extract mapping defect with future-dated assignments
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · ETL knowledge transfer; ETL runs against a restored BP Pro copy

### Ride Support (Discipline)

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · MD peer review; Unified-Turns API starts; January = ~20% of Smart Tag
- 2026-11-24 · [Mobile app knowledge transfer](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md) · Ride Support in Turns connects to BPU in 1-2 months
- 2026-11-23 · [Engineering Deep Dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) · Real sign-in, offline mode, form versions, any-student referral, alerts out of V1
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · Done mid-December, then QA; Stephen Hu on Turns
- 2026-11-20 · [Discipline V1 kickoff](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) · Module in `modules/`; package on branch; docs are source of truth
- 2026-11-20 · [Support huddle](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) · SPT-999 competes for the finance expert; Discipline not pushed
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Follow-up with QA scheduled; local setup over VPN
- 2026-11-19 · [Unified walkthrough](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) · Prototype end to end; V1 early January; nothing to families in V1
- 2026-11-19 · [Discipline planning](notes/2026/2026-11-19-discipline-planning-205027556.md) · V1 scope; Turns Referrals button first; JSON forms
- 2026-11-19 · [Discipline handoff](notes/2026/2026-11-19-discipline-handoff-205163106.md) · Repo markdown source of truth, one epic at a time, Playwright E2E with QA
- 2026-11-19 · [Engineering Deep Dive](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) · Forms schema in a dev sandbox; build assignments
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · Schema walkthrough planned with QA; epic list coming
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Spans web, driver tablet and Chipmunk; very early stage
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Dev-complete target 2026-12-18; agentic QA; meaning of the date left open
- 2026-11-13 · [Engineering Deep Dive](notes/2026/2026-11-13-engineering-deep-dive-202961200.md) · Requested by New Caney; walkthrough moved

### Auth

- 2026-11-24 · [Product backlog grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) · PROD-997 user management phases
- 2026-11-24 · [Turns undo scans and card login](notes/2026/2026-11-24-turns-undo-scans-card-login-206431675.md) · NFC card sign-in needs long alphanumeric values
- 2026-11-23 · [Engineering Deep Dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) · Turns-to-Unified sign-in for Ride Support
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Session 1 h → 12 h interim, refresh tokens later

### Environments and access

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · US dev audit-log permission, overlapping shifts, pre-API time-outs
- 2026-11-24 · [Canadian prod scaling](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) · Pause onboarding after five; auto-scaling; namespace vs cluster drift
- 2026-11-24 · [BP ENG stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) · US vs CA dev differences block testing
- 2026-11-24 · [On-boarding](notes/2026/2026-11-24-qa-onboarding-206383252.md) · Nash production T&A database to dev/stage
- 2026-11-24 · [Mobile app knowledge transfer](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md) · Quick Codes to QA1/QA2
- 2026-11-24 · [Image backup of old servers](notes/2026/2026-11-24-image-backup-old-servers-206573694.md) · Image template to Object Storage; decommission by month end
- 2026-11-23 · [BP ENG stand-up](notes/2026/2026-11-23-bp-eng-standup-205847641.md) · US environments out of sync with Git; prod T&A database to US staging
- 2026-11-23 · [Server procurement](notes/2026/2026-11-23-server-procurement-process-206084465.md) · Jira logging, resize rules, 40% buffer
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · No scrub; client data use client-dependent; local API to remote DB over VPN
- 2026-11-20 · [Discipline V1 kickoff](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) · Local run steps; VPN and ENG create rights pending
- 2026-11-19 · [Engineering Deep Dive](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) · Forms schema sandbox copy of HRCE on dev
- 2026-11-19 · [New World branching](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) · Feature-branch QA environments needed, not built
- 2026-11-19 · [BP ENG stand-up](notes/2026/2026-11-19-bp-eng-standup-204885304.md) · New Caney server resources raised
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · About four client databases each on staging and prod; Tri-County prod only
- 2026-11-18 · [STSYR SaaS migration](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) · Parallel build, customer QA, short cutover; production URL not recorded
- 2026-11-16 · [STEO SaaS implementation](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) · Parallel SaaS environment with rollback
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Dev app accounts for QA; QA1/QA2 by RDP or VPN; customer databases on QA1
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Paired Old World + New World QA environment planned

### Release and branching

- 2026-11-24 · [Product backlog grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) · Code freeze 12-04, staging 12-09, release 12-15
- 2026-11-24 · [BP ENG stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) · 13.5.1 released 11-24; 13.5.2 Dev Complete end of next week
- 2026-11-24 · [On-boarding](notes/2026/2026-11-24-qa-onboarding-206383252.md) · BusPlanner GitHub organisation
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · One December release 12-15; 12-22 cancelled; deployment cover
- 2026-11-23 · [Support huddle](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) · 13.5.2 on 12-15 is the last 2026 release
- 2026-11-23 · [Release process session](notes/2026/2026-11-23-release-process-working-session-206104652.md) · Hotfix only for code changes; P0 gate, Control Center, RCA
- 2026-11-23 · [New World branching](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) · QA on feature branch before `dev`; GitHub Actions; migration conflicts accepted
- 2026-11-23 · [BP ENG stand-up](notes/2026/2026-11-23-bp-eng-standup-205847641.md) · 13.5.1 on 11-24; sprint kickoff Friday, retro Thursday
- 2026-11-20 · [Support huddle](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) · 13.5.2 Dec 15, 13.5.3 Dec 22 bug-focused; ENG-246, ENG-588 by year end
- 2026-11-20 · [BP ENG stand-up](notes/2026/2026-11-20-bp-eng-standup-205348805.md) · Release 2026-11-24, fallback 2026-11-25
- 2026-11-20 · [Discipline V1 kickoff](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) · Current branch convention kept; `feature/` later
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · Five releases reviewed, one due 2026-11-24
- 2026-11-19 · [New World branching](notes/2026/2026-11-19-new-world-branching-strategy-205123949.md) · QA before merge to `dev`, no release branches, skip lane by group, epic branches
- 2026-11-19 · [BP ENG stand-up](notes/2026/2026-11-19-bp-eng-standup-204885304.md) · 13.5.1 to Stage; untested items reverted
- 2026-11-19 · [On-boarding](notes/2026/2026-11-19-engineering-onboarding-204968938.md) · BusPlanner GitHub organisation planned
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · Registry full broke a deploy; retention plan
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · All QA on `dev`; revert vs cherry-pick bottleneck; feature-flag debate; GitHub move
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · HRCE GPS+ release, items waiting on a dev deployment
- 2026-11-11 · [Engineering Deep Dive](notes/2026/2026-11-11-engineering-deep-dive-202033054.md) · Several promotes for HRCE; 12-hour change via normal release

### QA process and priorities

- 2026-11-24 · [Mobile app knowledge transfer](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md) · QA takes over mobile testing; devices pending
- 2026-11-24 · [On-boarding](notes/2026/2026-11-24-qa-onboarding-206383252.md) · Restore knowledge transfer before 12-07
- 2026-11-24 · [Support huddle](notes/2026/2026-11-24-support-engineering-huddle-206434224.md) · CSM workflow deck with RACI
- 2026-11-23 · [Engineering Deep Dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) · QA pivots to T&A for a US release; chatbot QA reduced
- 2026-11-23 · [New World branching](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) · QA time 50-60% setup; QA speed gets its own discussion
- 2026-11-23 · [Product suite knowledge transfer](notes/2026/2026-11-23-product-suite-knowledge-transfer-206034723.md) · New World basics and Substitution Service for new QA
- 2026-11-20 · [BP ENG stand-up](notes/2026/2026-11-20-bp-eng-standup-205348805.md) · Regression first, then Fleet release items
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Playwright vs Chrome MCP debate; API tests preferred by GPS+ dev
- 2026-11-20 · [Support huddle](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) · Support uses Claude on source code; people stay responsible
- 2026-11-19 · [QA bug triage](notes/2026/2026-11-19-qa-bug-triage-205099052.md) · Weekly triage; priorities for Fleet, Quick, T&A, Trips bugs
- 2026-11-19 · [Discipline handoff](notes/2026/2026-11-19-discipline-handoff-205163106.md) · QA owns agentic New World QA and Playwright E2E
- 2026-11-19 · [On-boarding](notes/2026/2026-11-19-engineering-onboarding-204968938.md) · Fathom only note-taker; QA docs to the QA Confluence space
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · QA cannot keep up with merges; test ETL ticket by ticket
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Discipline + ETL in parallel; Old World only as needed; estimate QA at PRD time
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Agentic "switch"; earlier priority order (superseded)

### Mobile apps

- 2026-11-24 · [Mobile app knowledge transfer](notes/2026/2026-11-24-mobile-app-knowledge-transfer-206555480.md) · Apps overview, TestFlight/APK, spoofer, outdated regression plan
- 2026-11-24 · [Turns undo scans and card login](notes/2026/2026-11-24-turns-undo-scans-card-login-206431675.md) · Undo options, NFC sign-in, BP Quick user sync is big
- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · Store release proven before Turns Discipline work
- 2026-11-24 · [BP ENG stand-up](notes/2026/2026-11-24-bp-eng-standup-206319910.md) · Submission with dev-only testing so far
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · Store submission documented; Imran owns it
- 2026-11-19 · [Discipline planning](notes/2026/2026-11-19-discipline-planning-205027556.md) · Turns Referrals button with username/password sign-in
- 2026-11-18 · [STSYR SaaS migration](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) · Operator-owned driver tablets, about 800 routes; Samsara scope open
- 2026-11-13 · [QA on-boarding sync](notes/2026/2026-11-13-qa-onboarding-202993371.md) · Developers test apps on emulators; physical devices unknown

### Notifications and two-way sync

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · Substitution Service split; shared queue design; Michel Walther reviews
- 2026-11-24 · [Canadian prod scaling](notes/2026/2026-11-24-unified-ca-prod-scaling-206398929.md) · Substitution Service scaling moves into two-way sync
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · Notification Engine on hold; Dispatch two-way sync decision blocks back end
- 2026-11-16 · [ETL Workflows](notes/2026/2026-11-16-etl-workflows-203613040.md) · Two-way sync engine planned
- 2026-11-12 · [QA on-boarding sync](notes/2026/2026-11-12-qa-onboarding-202544284.md) · Notification engine is the first agentic build and starts two-way sync

### Ontario Ministry reports

- 2026-11-20 · [Ontario Ministry reports issues](notes/2026/2026-11-20-ontario-ministry-reports-205530038.md) · Monitor placeholders; CTY/TFN/TIN courtesy types; grade codes
- 2026-11-20 · [Support huddle](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) · Missing extended properties make students "Other"
- 2026-11-12 · [Ontario Ministry reports training](notes/2026/2026-11-12-ontario-ministry-reports-training-202654264.md) · Importers, extended properties, BIN location, common report errors

### Eligibility

- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · ENG-2967, ENG-3043, ENG-2724 eligibility fixes
- 2026-11-13 · [CCSD eligibility path forward](notes/2026/2026-11-13-ccsd-eligibility-path-forward-203086298.md) · Full-student run is the main suspect for slow calculation

### Stop boundaries

- 2026-11-24 · [Product backlog grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) · PGCPS Aerial Map top priority, tight for 12-15
- 2026-11-17 · [PGCPS support check-in](notes/2026/2026-11-17-pgcps-support-check-in-203924420.md) · Boundary polygon requirements; Comprehensive Stops layer first

### Old World SaaS migration

- 2026-11-24 · [Image backup of old servers](notes/2026/2026-11-24-image-backup-old-servers-206573694.md) · Old servers backed up and decommissioned
- 2026-11-18 · [STSYR SaaS migration](notes/2026/2026-11-18-stsyr-saas-migration-204600731.md) · STSYR exploring SaaS, likely summer
- 2026-11-16 · [STEO SaaS implementation](notes/2026/2026-11-16-steo-saas-implementation-203613006.md) · Cutover moved to the week of 2026-12-07; File Checker migrated as-is

### Chatbot

- 2026-11-24 · [Product backlog grooming](notes/2026/2026-11-24-product-backlog-grooming-206471711.md) · Chatbot filter reprioritised; PROD-997 may delay it
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · All bugs stay assigned; enhancements to product first
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · Scorecards, eval harness, prompt-injection review
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · Canada-hosted model, BusPlanner-only answers, no client spend limits

### Database migrations

- 2026-11-23 · [New World branching](notes/2026/2026-11-23-new-world-branching-strategy-206125528.md) · QA-before-merge makes migration-number clashes worse; accepted
- 2026-11-20 · [Engineering Deep Dive](notes/2026/2026-11-20-engineering-deep-dive-205362569.md) · Shared dev database migration conflicts; per-ticket fixture databases
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · GPS event index outside the migration tool; about 1 h per database

### Ridership

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · Simplified seating chart; limited ridership integration first
- 2026-11-24 · [Turns undo scans and card login](notes/2026/2026-11-24-turns-undo-scans-card-login-206431675.md) · Undo of manual scans vs audit trail
- 2026-11-18 · [Engineering Deep Dive](notes/2026/2026-11-18-engineering-deep-dive-204431295.md) · Not decided: module plus rider scans in Compare; Chipmunk bridge

### BP Pro routing

- 2026-11-18 · [BP Pro run creation training](notes/2026/2026-11-18-bp-pro-run-creation-training-204532051.md) · Run-to-route insertion, manual Location IDs, access streets

### Forms engine

- 2026-11-23 · [Support huddle](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) · Workflow-forms enablement for CX
- 2026-11-20 · [Discipline V1 kickoff](notes/2026/2026-11-20-discipline-v1-kickoff-205490343.md) · Package in `docs/forms-engine`; draft SQL breaks against `dev` (summary only)
- 2026-11-19 · [Engineering Deep Dive](notes/2026/2026-11-19-engineering-deep-dive-204907852.md) · One table set, save then queue; form versions by GUID + version
- 2026-11-19 · [Unified walkthrough](notes/2026/2026-11-19-unified-walkthrough-ride-support-204952466.md) · One form builder under Discipline, Inspection, Workflow

### Old World defects

- 2026-11-24 · [Support huddle](notes/2026/2026-11-24-support-engineering-huddle-206434224.md) · SPT-937 hotfix candidate; SPT-1013; Toronto backups and alert emails
- 2026-11-23 · [Support huddle](notes/2026/2026-11-23-support-engineering-huddle-205950536.md) · SPT-1006, 963, SPT-997
- 2026-11-20 · [Support huddle](notes/2026/2026-11-20-support-engineering-huddle-205470421.md) · SPT-999 Highest; two BP Web user-sync feature requests stay unscheduled
- 2026-11-20 · [Engineering show and tell](notes/2026/2026-11-20-engineering-show-and-tell-205429665.md) · Fleet PO, workflow form, report and trip fixes
- 2026-11-19 · [QA bug triage](notes/2026/2026-11-19-qa-bug-triage-205099052.md) · Cancellation/delay alerts, Fleet POs, Quick reports, Trips French

### Time & Attendance

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · Overlapping shifts debate
- 2026-11-24 · [On-boarding](notes/2026/2026-11-24-qa-onboarding-206383252.md) · Nash restore; exact PDF match oracle
- 2026-11-23 · [Engineering Deep Dive](notes/2026/2026-11-23-engineering-deep-dive-205871282.md) · US-only T&A release; known-good export to validate after stage restore
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · T&A client blocked since August; 3-4 days QA; prod-to-stage database copy
- 2026-11-23 · [BP ENG stand-up](notes/2026/2026-11-23-bp-eng-standup-205847641.md) · No T&A data in US stage; payroll export only in Canada

### Dispatch

- 2026-11-24 · [Engineering Deep Dive](notes/2026/2026-11-24-engineering-deep-dive-206344783.md) · Front end near done; street graph and queue design block back end
- 2026-11-23 · [Sprint refinement](notes/2026/2026-11-23-sprint-refinement-206045688.md) · Front end done, back end not started; two-way sync blocks
- 2026-11-23 · [Product suite knowledge transfer](notes/2026/2026-11-23-product-suite-knowledge-transfer-206034723.md) · Reassigned Dashboard prototype; Chipmunk parent notices
