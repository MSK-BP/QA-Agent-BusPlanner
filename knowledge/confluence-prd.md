# Confluence PRD family (space PE): full read

> Status: SOURCED 2026-11-10 from Confluence space PE, site `busplanner.atlassian.net`. Scope: every page whose title starts with "PRD" (the machine-generated "Connected PRD" family titled "PRD · ...", plus six hand-written PRDs). Every other PE page is covered by a separate file.
>
> Source shorthand: a bare page id such as `239173635` means `https://busplanner.atlassian.net/wiki/spaces/PE/pages/239173635`.
>
> How this was produced: the space was enumerated with CQL (212 items; 106 have a title starting with "PRD": 87 pages and 19 folders). The 87 pages were read to the end in 14 batches (pages are 20k to 150k characters; the whole family is about 52,000 source lines) and each fact was written down with its page id. Rows were merged by script; glossary and system rows were de-duplicated, the rest was not, so a rule can appear twice when two pages state it. This file is about 2,850 lines, well over the 900-line guide, because nothing sourced was dropped; use the section headings and search rather than reading top to bottom.

## Read this before using any row

- **Today vs to-be.** Each connection in the PRD has three views: **Today** (company code at the pins below), **Local version** (built on one machine or in a prototype, not in company code) and **To-be** (what the PRD asks for). Section 4 holds only Today. Local version, prototype results and proposals are all in section 5 and are **not shipped**.
- **"Verified" is the PRD author's tag,** meaning checked in code or in a document that cites code. It is not a QA result. Other tags: `lead` (strong inference, confirm first), `open` / `unknown`, `assumed` (assumption or proposed number), `calculated`.
- **Code pins for "today"** (239140866): every product except Fleet at production `main` `e60a6e87` (2026-09-18); Fleet at `fleet-main` `969d0138` (2026-09-22); the mobile apps (Turns, Chipmunk, Subs, Delays) at Apps `dev` `7bfa58ff` (2026-08-25); some facts at `main` `26919bc6` (2026-10-01). Later releases (13.4.x, 12.4.14) may have changed behaviour: re-check a "today" rule on the build under test before treating it as current.
- **Older parts describe April 2026 code.** Parts 8 to 30 (feature requirements, specs, stress test) keep their own dates and ID schemes. Where they disagree with Part 1 (the connected-system PRD), Part 1 is current (239140866). The clearest case: older pages say every Dispatch save emails parents at once; production has held notices until the dispatcher sends them since 2026-09-18.
- **PRD versions.** The family was pushed from PRD v0.100 on 2026-11-05. Ten pages were re-pushed from v0.102 on 2026-11-09 (239173656, 238321683, 239304705, 238845954, 238845975, 237961219, 239337479, 239075331, 239108122, 241500162) and two from v0.101 (237928473, 239337500). Publisher: Matthew Hayes.
- **Hand-written PRDs in this slice** (not generated, own authors and statuses): 237043713 Users and Access, 233144322 Default Operator, 250740737 Turns end-of-run check, 58851500 Unified Login Flow, 247824423 BP Info Bulk Upload REST Users, 238518274 Vehicle to Route Mapping (GPS+).
- **Privacy.** The PRD uses example people and a test district; those names are not copied here. No credentials, tokens or internal addresses are recorded.

## ID schemes used by the PRD (239140866)

| Id | Meaning |
|---|---|
| `SY-n` | System rules and shared services |
| `CX-n` | Connections between products (CX-1 to CX-88) |
| `IC-1` to `IC-11` | The integration contract |
| `IF-<code>-<nn>` | Interfaces a product offers or uses |
| `J1` to `J25` | Journeys |
| `<code>-G/R/A/K<n>` | A product's goals, requirements, acceptance criteria, risks (`<code>` = two-letter product code, e.g. DS, TU, CH, FT) |
| `<code>-QA-nnn` | A section's QA tests |
| `WX-1` to `WX-8` | Worked examples |
| `RK-n`, `Qn` | System risks; questions (answered ones become decisions) |
| `WK-n` | Workflow stress-test findings |
| `W01` to `W18` | Local, unshipped Fleet work packages |
| CM-, DP-, TN-, DF-, WP-, D1 to D7, R1 to R4, TRK-, SHR-, FR-xx | Ids from the older source documents. `FR-` means a district feature request in the Fleet change spec and a "functional requirement" in the Workflow PRD |

## 1. Page inventory

Total in slice: **87 pages** (all read to the end) plus **19 folders** titled "PRD Â· ..." that are containers with no body. "Last updated" is the date of the page's current version.

| Page id | Title | Parent | Content summary | Last updated |
|---|---|---|---|---|
| 239140866 | PRD · Read me first | 239042562 PRD · Start here (folder) | Preface of the compiled PRD: list of the 30 parts, summary page (problem, targets, decisions needed), §0 how to read (code pins, evidence tags, ID schemes), §1 problem table, §2 design rules SY-1 to SY-9; PRD v0.100 | 2026-11-05 |
| 239173635 | PRD · System map | 238387204 PRD · System (folder) | §3 system map diagram and shared services / system rules SY-10 to SY-26, each with Today / Local version / To-be; PRD v0.100 | 2026-11-05 |
| 239271938 | PRD · Glossary and plain language | 239042562 PRD · Start here (folder) | §9 plain-language rules, country and language table, glossary (say / not / means), code names vs screen names; PRD v0.100 | 2026-11-05 |
| 239173656 | PRD · Connection Register | 238387204 PRD · System (folder) | §4 every connection CX-1 to CX-88 with path, today, local version, to-be, says; PRD v0.102 | 2026-11-09 |
| 238321683 | PRD · How to use the product sections | 238387204 PRD · System (folder) | §8.0 pull-out rule, integration contract IC-1 to IC-11, interface catalogue (IF-xx-nn), hand-off payloads, product index (two-letter codes), section template, scale figures, new-platform schema fit (v7.22), feature-switch table, Dispatch permission catalogue; PRD v0.102 | 2026-11-09 |
| 238911490 | PRD · Product × product matrix | 238387204 PRD · System (folder) | §5 count of connections between each pair of products, the CX ids per pair, empty cells worth a look; PRD v0.100 | 2026-11-05 |
| 238026754 | PRD · Event list | 238387204 PRD · System (folder) | §6 named hand-offs (events): sender, receivers, what it carries, built or new, CX; PRD v0.100 | 2026-11-05 |
| 238092292 | PRD · Journeys | 238387204 PRD · System (folder) | §7: 25 end-to-end journeys J1-J25 (morning run, boarding scan, dispatcher change, swap, alerts, sign-up, broken bus, field trip, driver's working life, behaviour referral), each listing the CX rows it uses and its "gaps today"; PRD v0.100 | 2026-11-05 |
| 238518296 | PRD · Order of work | 238387204 PRD · System (folder) | §10: ordering rules, phases A and 0-5 with proposed release dates, requirement ids and exit-criteria ids per phase, dependency graph, team lanes, pilot districts; PRD v0.100 | 2026-11-05 |
| 238452749 | PRD · Out of scope, non-goals and rejected options | 238387204 PRD · System (folder) | §12: out-of-scope list, system non-goals, table of ~30 rejected design options with reason and where decided; PRD v0.100 | 2026-11-05 |
| 238223375 | PRD · Appendices | 238387204 PRD · System (folder) | Appendix A coverage (map arrows / bench ids / source PRDs -> CX rows), B local work, C sources and pinned commits, D the 2026-10-26 retest of Ride Support criteria in the HTML prototype with pass/fail counts and PRD-vs-prototype differences; PRD v0.100 | 2026-11-05 |
| 238419971 | PRD · Worked examples and the demo plan | 238387204 PRD · System (folder) | §11: worked examples WX-1 to WX-8 (to-be timelines with interface / requirement / AC ids, each followed by "the same morning today") and the bench demo plan; PRD v0.100 | 2026-11-05 |
| 239304705 | PRD · Open questions, risks, decisions and change log (1 of 2) | 239108119 PRD · Open questions, risks and decisions (folder) | §13.1 document control, §13.2 open questions Q5-Q290 with recommendation / owner / due / blocks, §13.3 risks RK-1 to RK-26, §13.4 decision log 2026-09-24 to 2026-11-08; PRD v0.102 | 2026-11-09 |
| 238845954 | PRD · Open questions, risks, decisions and change log (2 of 2) | 239108119 PRD · Open questions, risks and decisions (folder) | §13.5 change log v0.102 back to v0.2 (what each PRD version added, with ids, setting names and "verified for the record" facts); PRD v0.102 | 2026-11-09 |
| 238223396 | PRD · Dispatch — build section (DS) (1 of 2) | 239337473 PRD · Dispatch (folder) | PRD §8.6 Quick Dispatch (DS): pull-out card, why (today's gaps), success measures, scope, requirements DS-R1..DS-R56, settings table, interfaces, failure cases, conflict tables; PRD v0.100 | 2026-11-05 |
| 238419992 | PRD · Dispatch — build section (DS) (2 of 2) | 239337473 PRD · Dispatch (folder) | Acceptance criteria DS-A1..DS-A171, QA test table DS-QA-001..DS-QA-302, rollout phases, risks DS-K1..K5; PRD v0.100 | 2026-11-05 |
| 238157830 | PRD · New World Dispatch V1 (1 of 2) | 254476308 PRD · Dispatch V1 (folder) | Part 5: PRD-dispatch-v1.md draft v0.14 (2026-11-04): what engineering settled, words, scope in / out of V1, platform needs, Turns / Chipmunk / Dashboard reads, V1 requirements with AC-n.k, permissions and settings tables, conflict cases CF-01..CF-78, screen rules, test district, how QA tests are written; PRD v0.100 | 2026-11-05 |
| 238911511 | PRD · New World Dispatch V1 (2 of 2) | 254476308 PRD · Dispatch V1 (folder) | V1 QA test tables §8.2-§8.17 (QA-001..QA-304), open question list, change log v0.1..v0.14; PRD v0.100 | 2026-11-05 |
| 238157851 | PRD · Dispatch Module — knowledge transfer | 239337473 PRD · Dispatch (folder) | Part 11: Customer Success knowledge-transfer doc on the "TransportDispatch - Dispatch Run Sheet" v3.6 HTML prototype: features DM-1..17, screens S-1..14, key fields KF-1..14, workflows WF-1..13, rules R1..R14, split / double-up / double-back deep dive, open questions, source map; PRD v0.100 | 2026-11-05 |
| 239108098 | PRD · Feature Requirements — Chipmunk, Dispatch & Turns (1 of 2) | 238387204 PRD · System (folder) | Part 8: requirements draft v0.6 (2026-09-01, code line fleet-main @ 19cb8e5b) for CM-1..CM-7, DP-1..DP-3, TN-1..TN-4; how the three products connect, 4 databases, 3 settings stores, defect register DF-1..DF-17, open questions 1-24, start of implementation guide; PRD v0.100 | 2026-11-05 |
| 237928452 | PRD · Feature Requirements — Chipmunk, Dispatch & Turns (2 of 2) | 238387204 PRD · System (folder) | Part 8 continued: work packages WP-0..WP-12, sequencing, release model (what needs an app-store release), code reference index, Appendix A proposed settings, Appendix B existing settings with defaults, verification provenance; PRD v0.100 | 2026-11-05 |
| 239239170 | PRD · Dispatch Merge Runs — parent notification defects | 239337473 PRD · Dispatch (folder) | Part 9: defect spec D1-D7 for wrong / duplicate parent emails after Dispatch Merge Runs (incidents 2026-08-31 and 2026-09-04), proposed fixes, acceptance criteria, interim mitigation; PRD v0.100 | 2026-11-05 |
| 238616579 | PRD · Add Students to Runs | 239337473 PRD · Dispatch (folder) | Part 10: spec (2026-09-03, draft) for a bulk "Add Students to Runs" flow in Quick; documents today's single-student wizard, GEDI calls, bugs B1-B9, requirements R1-R14, 7 screens, skip rules S1-S11, permissions, Pro stop optimizer, phasing; PRD v0.100 | 2026-11-05 |
| 238518317 | PRD · Chipmunk — build section (CH) | 239337476 PRD · Chipmunk (folder) | Section 8.16 of the Connected PRD: Chipmunk parent app pull-out card, "on the new platform" job map, why/defects today, success measures, goals CH-G1..G5, requirements CH-R1..R31, settings tables, interfaces, failure cases, data tables, acceptance criteria CH-A1..A66, QA tests CH-QA-001..169, rollout, risks CH-K1..K7; PRD v0.100 | 2026-11-05 |
| 238878722 | PRD · Chipmunk — parent app UX changes | 239337476 PRD · Chipmunk (folder) | Part 13: "Chipmunk UX changes" draft v2.0 (2026-09-01) for the mobile team: what the ETA screen does today (from two screenshots + server code), changes CM-1..CM-8, release model, empty states, server work packages WP-n, open questions, tracker API surface; PRD v0.100 | 2026-11-05 |
| 238256131 | PRD · Chipmunk alerts — comments and deep-linked push | 239337476 PRD · Chipmunk (folder) | Part 14: implementation spec (draft for development, 2026-09-18) for alert Comment/Reason reaching the app (R1), generic push body (R2), deep link to Alerts tab (R3), unread state (R4); current code path, patches, version-skew analysis, 13 acceptance criteria; PRD v0.100 | 2026-11-05 |
| 238518338 | PRD · Student boarding pass | 239337476 PRD · Chipmunk (folder) | Part 15: draft spec (2026-08-04) for a scannable Bus Pass screen in Chipmunk: problem, scope, 5 states, data fields, offline rules, 8 acceptance criteria, open questions, risks, "not yet verified" list; prototype only; PRD v0.100 | 2026-11-05 |
| 238845975 | PRD · Turns — build section (TU) (1 of 2) | 238747652 PRD · Turns (folder) | Section 8.14 of the Connected PRD, first half: Turns driver tablet pull-out card, why, success measures, goals TU-G1..G7, requirements TU-R1..R50, settings Turns reads + new settings table, interfaces, failure cases, data tables; PRD v0.102 | 2026-11-09 |
| 237961219 | PRD · Turns — build section (TU) (2 of 2) | 238747652 PRD · Turns (folder) | Section 8.14 second half: acceptance criteria TU-A1..A110, QA tests TU-QA-001..276, rollout phases, risks TU-K1..K5, considered and rejected; PRD v0.102 | 2026-11-09 |
| 239140887 | PRD · Turns — pre/post-trip inspection checklist | 238747652 PRD · Turns (folder) | Part 23: spec (2026-09-02) for an all-open inspection checklist in Turns: root cause in the form-module schema (fm_ tables), interaction rules, optional backend additions, 10 acceptance criteria, Fleet reference implementation; client-only change; PRD v0.100 | 2026-11-05 |
| 250740737 | PRD — Turns: end-of-run check for students not scanned off | 58687491 Unified Login (folder) | HAND-WRITTEN PRD, not part of the generated "PRD · ..." family (no PRD version line). Status banner "Requirements confirmed — pending engineering feasibility"; author Ahnaf Rahman (also last editor, page v3); no owner field given (product = BusPlanner Turns student scanning); Jira PROD-553; requested by one Alberta school division (PRSD) via Zendesk 74359; prototype linked. Contains requirements, behaviour table, reuse assessment of ENG-1394, engineering questions, risks, dependencies | 2026-11-02 |
| 239337479 | PRD · Ride Support — build section (SC) (1 of 2) | 238616600 PRD · Ride Support (folder) | PRD §8.21 Ride Support (SC): pull-out card, why, success measures, goals, requirements SC-R1..SC-R43, settings table with defaults, default reason/action lists, interfaces, failure cases, knock-on effects, data tables; PRD v0.102 | 2026-11-09 |
| 239075331 | PRD · Ride Support — build section (SC) (2 of 2) | 238616600 PRD · Ride Support (folder) | Acceptance criteria SC-A1..SC-A181, QA tests SC-QA-01..SC-QA-312, rollout steps and build phases, risks SC-K1..K7, considered and rejected; PRD v0.102 | 2026-11-09 |
| 237928473 | PRD · Ride Support — build spec (1 of 2) | 238616600 PRD · Ride Support (folder) | Part 4 build spec (TECH-SPEC-student-conduct.md, draft v0.22 of 2026-11-06): why, people, use cases UC-1..UC-13, statuses and valid steps T01..T19 / C01..C09, conflicts at a step, business rules BR-1..BR-66, data model (cnd_ / saf_ tables), door calls, platform API, events, letter job; PRD v0.101 | 2026-11-09 |
| 239337500 | PRD · Ride Support — build spec (2 of 2) | 238616600 PRD · Ride Support (folder) | Build spec continued: letter placeholders, SIS export fields, permissions and scope, settings with ranges, screens TS-1..TS-21 / WS-1..WS-21 / CS-1..CS-3, special situations ST-1..ST-55, NFRs, instrumentation, test layers and acceptance map, traceability, build order, Jira epics CND-E1..E12, engineering questions Q-E1..Q-E17, developer questions DQ-1..DQ-71, contradictions C1..C23, prototype appendix, default lists and letters; PRD v0.101 | 2026-11-09 |
| 239108122 | PRD · Ride Support V1 (1 of 2) | 253689870 PRD · Discipline V1 (folder, under 238616600 PRD · Ride Support) | Part 7 of the Connected PRD: Ride Support V1 draft v0.6 (2026-11-08): scope, statuses and path, requirements SC-R / TU-R with RS-AC criteria, permissions, 39 settings, edge cases RS-EC-01..64, screen rules, test district, QA tests §8.1-8.5; PRD v0.102 | 2026-11-09 |
| 241500162 | PRD · Ride Support V1 (2 of 2) | 253689870 PRD · Discipline V1 (folder, under 238616600 PRD · Ride Support) | Continuation: QA tests §8.6-8.10 (RS-QA-085..176), open-question list, traceability note, change log v0.1-v0.6; PRD v0.102 | 2026-11-09 |
| 238583811 | PRD · Dashboard — build section (DB) | 239370241 PRD · Dashboard (folder) | §8.23 end-state Dashboard: pull-out card, why, DB-R1..R15, IF-DB-01/02, DB-A1..A22, QA tests DB-QA-100..150, rollout, risks DB-K1..K4, rejected options; PRD v0.100 | 2026-11-05 |
| 238551042 | PRD · Dashboard V1 | 239370241 PRD · Dashboard (folder) | Part 6: Dashboard V1 draft v0.5 (2026-11-02): scope, how it counts, DB-R1..R15 V1 parts with DB-AC criteria, DB-EC-01..42, test district with expected numbers, DB-QA-001..099 and 200..213, Appendix A prototype (DB-PQ-01..31, PROD-793 item by item); PRD v0.100 | 2026-11-05 |
| 239403009 | PRD · Fleet — build section (FT) | 238551063 PRD · Fleet (folder) | PRD §8.8 Fleet: why, success measures, goals FT-G1..G7, requirements FT-R1..R30, school-bus seat-layout reference, interfaces, failure cases, data, acceptance FT-A1..A41, QA tests FT-QA-001..111, rollout, risks FT-K1..K7; PRD v0.100 | 2026-11-05 |
| 238288898 | PRD · Fleet — change specification (1 of 6) | 238551063 PRD · Fleet (folder) | Part 16 header, contents, traceability, migration / settings / permission ledgers, house rules, work items W01 (reminder anchors), W02 (one due-ness calculation), W03 (due PM on work-order create), start of W04 (service history tab); all local, uncommitted; PRD v0.100 | 2026-11-05 |
| 238845996 | PRD · Fleet — change specification (2 of 6) | 238551063 PRD · Fleet (folder) | Rest of W04, W05 (vehicle warranty), W06 (inspections core), W07 (criteria builder, two failure levels) with fact-check corrections; all local; PRD v0.100 | 2026-11-05 |
| 238911532 | PRD · Fleet — change specification (3 of 6) | 238551063 PRD · Fleet (folder) | W07 fact-check, W08 (defect intake), W09 (failure notification bell / inbox), W10 (work-order change audit), first part of W11 (inspection messaging); all local; PRD v0.100 | 2026-11-05 |
| 238354434 | PRD · Fleet — change specification (4 of 6) | 238551063 PRD · Fleet (folder) | Build spec for locally built Fleet work (NOT shipped): tail of W11 inspection messaging, W12 permission enforcement + 110000 permission family, W13 criteria publish outbox to Quick forms module, W14 telemetry seam / meter ingestion, start of W15 vehicle map; each with traps, proof steps, not-done list, open decisions, fact-check corrections; PRD v0.100 | 2026-11-05 |
| 238420013 | PRD · Fleet — change specification (5 of 6) | 238551063 PRD · Fleet (folder) | Rest of W15 vehicle map, W16 Vehicle Shop Days report, W17 attachments preview/print/inline, W18 EITAS fixes (labour export, fuel tank, barcode, vendors, part photos, core charge), section 6 verification playbook, 7 decisions owed, 8 do-not-ship list, start of Appendix A exact code; PRD v0.100 | 2026-11-05 |
| 239403030 | PRD · Fleet — change specification (6 of 6) | 238551063 PRD · Fleet (folder) | Appendix A exact code only (A-DUE-3 .. A-WEBCONFIG-1): SQL, migrations 867-878 column lists, due-ness arithmetic, warranty rule, notification / audit / messaging queries, permission attribute, publish payload, telemetry, map, downtime, attachment, fuel, barcode code; PRD v0.100 | 2026-11-05 |
| 239009796 | PRD · Fleet — integrations | 238551063 PRD · Fleet (folder) | Part 17 Fleet Integrations PRD dated 2026-08-03: three phases (Geotab GPS in Fleet, odometer / engine hours from telemetry, parts-vendor APIs) with verified facts about current code, P0/P1/P2 requirements, metrics, open questions; PRD v0.100 | 2026-11-05 |
| 239435777 | PRD · Fleet — local demo build plan | 238551063 PRD · Fleet (folder) | PRD Part 18: waves 0-6 of an uncommitted local Fleet demo (migrations 867-878, Beaverton FR-01..FR-10, inspections builder, defect intake, due-ness consolidation); all local, not shipped; v0.100 | 2026-11-05 |
| 238485507 | PRD · Fleet — digital inspections module | 238551063 PRD · Fleet (folder) | PRD Part 19: design of a Fleet inspections module reverse-engineered from an HTML prototype (60-item state safety form, 4-table schema, MVC wiring, link to work orders); v0.100 | 2026-11-05 |
| 238485528 | PRD · Fleet — competitive gap analysis | 238551063 PRD · Fleet (folder) | PRD Part 20: Fleet (fleet-main 12.4.x) vs competitors; verified-in-code strengths and Tier 1-3 gaps; inspection builder requirements; v0.100 | 2026-11-05 |
| 239009817 | PRD · Fleet — combined fix spec, Clay County and Miami-Dade | 238551063 PRD · Fleet (folder) | PRD Part 21: defects found on fleet-main at two customer sites (C1-C11, M1-M5, S1-S3) with root cause, proposed patch and verify steps; v0.100 | 2026-11-05 |
| 239075352 | PRD · Fleet, Turns and inspections — context | 238551063 PRD · Fleet (folder) | PRD Part 22: prospect asks A-E, what the local Fleet demo contains, how Turns / BPInfo / Quick FormModule / Fleet attach today, fm_* schema, seams to reconcile; v0.100 | 2026-11-05 |
| 237993990 | PRD · GeoIMS / tracker reliability — fix spec | 238420037 PRD · Platform (folder) | PRD Part 24: GeoIMS and Tracker "healthy but wedged" defects (GEO-1..GEO-21, TRK-1..6, SHR-1..4, I-1..8), release plan 0-5, rejected fixes; v0.100 | 2026-11-05 |
| 238125072 | PRD · GeoIMS and GEDI (GI) | 238420037 PRD · Platform (folder) | PRD section 8.2: Pro data layer defects today, requirements GI-R1..R17, acceptance GI-A1..A20, QA tests GI-QA-001..049, data tables, rollout; v0.100 | 2026-11-05 |
| 238551066 | PRD · Live tracking (LT) | 238420037 PRD · Platform (folder) | PRD section 8.3: GPS readers and the two trackers; defects today, requirements LT-R1..R17, settings, acceptance LT-A1..A22, QA tests LT-QA-001..057; v0.100 | 2026-11-05 |
| 238321704 | PRD · Quick — staff, training records, ridership and bulk changes (QS) | 238878743 PRD · Quick (folder) | §8.7 build section: Staff Manager retire / credentials / Expired Certifications report, route scope, ridership API, bulk add students to runs, planned crew roles; QS-R1..R9, QS-A1..A11, QS-QA-001..036; PRD v0.100 | 2026-11-05 |
| 238878746 | PRD · Quick — training tracking module (1 of 2) | 238878743 PRD · Quick (folder) | Part 12 knowledge-transfer doc (Customer Success, 2026-06-19) on the browser-only Training Tracking prototype: context, personas, feature inventory A-I, screen walkthrough, field documentation, workflows 7.1a-c; PRD v0.100 | 2026-11-05 |
| 239501313 | PRD · Quick — training tracking module (2 of 2) | 238878743 PRD · Quick (folder) | Continuation: workflows 7.1d-7.10, business rules R1-R16, data entities, 7 reports, notifications, impact assessment, open questions §13; PRD v0.100 | 2026-11-05 |
| 238747676 | PRD · Training mode (TM) | 239075394 PRD · Other modules (folder) | §8.22 practise-on-real-screens mode: TM-R1..R12, 5 settings, IF-TM-01, IF-BI-49, tm_ tables, TM-A1..A18, TM-QA-001..048, rollout phases; PRD v0.100 | 2026-11-05 |
| 239403072 | PRD · Training module (TG) | 239075394 PRD · Other modules (folder) | §8.12 productising the training prototype: TG-R1..R6 (people from registry, rows to Pro, server storage, T-01, training notices), tg_ tables, TG-A1..A9, TG-QA-001..019; PRD v0.100 | 2026-11-05 |
| 238616603 | PRD · Employee app — build section (EA) | 238420034 PRD · Employee app (folder) | §8.18 contract of the employee app with the rest of the system: consumed interfaces, 3 phases, privacy, data (no tables of its own); PRD v0.100 | 2026-11-05 |
| 238223417 | PRD · Employee app PRD | 238420034 PRD · Employee app (folder) | Part 3 "BusPlanner Staff" employee app PRD draft v0.13 (2026-10-08): design rules EA-1..8, roles and scopes EA-10/11, mechanic EA-20..24, transportation EA-30..36, school EA-40..43, driver EA-90..99, effective bus EA-50, ETAs EA-60, build EA-70, security EA-80, CX-55..65 + CX-75, J17-J20, Q1-Q11; PRD v0.100 | 2026-11-05 |
| 238321725 | PRD · Settings catalogue | 239370244 PRD · Settings (folder) | Part 30: script-built catalogue (2026-09-25) of about 1,996 settings in 36 tables/files across nine store families, what the settings program must handle, and the settings the connected PRD proposes or names; PRD v0.100 | 2026-11-05 |
| 239468548 | PRD · Settings program — build section (SP) | 239370244 PRD · Settings (folder) | §8.20 summary of the settings program: why, Q33 decision, SP-R1..R18 in brief, interfaces, data tables, rollout; PRD v0.100 | 2026-11-05 |
| 239534081 | PRD · Settings program PRD | 239370244 PRD · Settings (folder) | Part 2: full draft v0.1 PRD of the settings program (requirements SP-R1..R18, acceptance SP-A1..A18, failure cases, data model, rollout R0-R3, risks, code locations of every store); PRD v0.100 | 2026-11-05 |
| 239075373 | PRD · Workflow — build section (WF) | 239468545 PRD · Workflow (folder) | §8.10 Workflow: today state (writes into live Pro), WF-R1..R6, WF-A1..A6, WF-QA-001..009, wf_ tables; PRD v0.100 | 2026-11-05 |
| 238911553 | PRD · Workflow PRD | 239468545 PRD · Workflow (folder) | Part 25: PRD v0.2 (2026-07-08) of a proposed no-code Workflow product derived from an interactive prototype (8 modules, FR-* requirements, roles, data model, phasing); all to-be; PRD v0.100 | 2026-11-05 |
| 238682115 | PRD · Workflows — stress test (1 of 2) | 239468545 PRD · Workflow (folder) | Part 29 §0-§9.2: desk-traced stress test of cross-product workflows at production code: weaknesses WK-1..WK-57, known-defect re-check at production main, role tests, journeys J1-J24, scenarios S1-S15, top-10 blockers; PRD v0.100 | 2026-11-05 |
| 238452770 | PRD · Workflows — stress test (2 of 2) | 239468545 PRD · Workflow (folder) | Part 29 §9.3-§10 and appendices: PRD changes applied from Round 3 and the production re-check, open leads, read-only proof, SQL counts from the anonymised copy; PRD v0.100 | 2026-11-05 |
| 238747655 | PRD · Trips — build section (TP) | 237797382 PRD · Trips (folder) | PRD §8.9: Trips today (verified gaps), requirements TP-R1..R26, 16 new settings, ACs TP-A1..A36, 80 QA tests, data tables, rollout, risks; v0.100 | 2026-11-05 |
| 238387207 | PRD · Trips — competitive gap analysis, busHive | 237797382 PRD · Trips (folder) | Part 27: Trips SE/CE at production main vs busHive; verified Trips strengths and Tier 1-3 gaps that motivate TP-R8..R24; v0.100 | 2026-11-05 |
| 239140908 | PRD · Trips SE — implementation simplification | 237797382 PRD · Trips (folder) | Part 26: scrape of the Trips SE demo site (31 pages), 22 setup entities, settings categories, 7-state trip lifecycle, proposed onboarding wizard; v0.100 | 2026-11-05 |
| 238321767 | PRD · School closure, consolidation and enrollment projection (1 of 2) | 239108143 PRD · School closure and enrollment projection (folder) | Part 28 §1-§14: BP Pro School Closure Planner diagnosis, bugs B1-B9, phased fix plan, enrollment projection design (schema, engine, UI wiring); v0.100 | 2026-11-05 |
| 237797385 | PRD · School closure, consolidation and enrollment projection (2 of 2) | 239108143 PRD · School closure and enrollment projection (folder) | Part 28 §15-§17 + appendix: build order, limits, UX wording and screens, process / readiness gate; v0.100 | 2026-11-05 |
| 238682136 | PRD · Subs — substitute drivers (SU) | 239075394 PRD · Other modules (folder) | PRD §8.15: Subs app today, SU-R1..R5, SU-A1..A8, 25 QA tests; v0.100 | 2026-11-05 |
| 238321746 | PRD · Subscription Service (SS) | 238420037 PRD · Platform (folder) | PRD §8.4: parent-channel sender today (defects, tables), SS-R1..R13, SS-A1..A17, 43 QA tests; v0.100 | 2026-11-05 |
| 238026775 | PRD · Delays (DL) | 239075394 PRD · Other modules (folder) | PRD §8.17: Delays app today, DL-R1..R3, DL-A1..A5, 15 QA tests; v0.100 | 2026-11-05 |
| 239534102 | PRD · Assistant (AS) | 238420034 PRD · Employee app (folder) | Generated Connected PRD section 8.19: Assistant is frozen and retires when the employee app reaches parity; 1 AC, 3 QA tests; PRD v0.100 | 2026-11-05 |
| 238485587 | PRD · BP Web (BW) | 238420037 PRD · Platform (folder) | Generated Connected PRD section 8.5: BP Web settings, Parent Portal, notices and accounts; today's defects (driver sync, settings sprawl, rollover child links), BW-R1..R14, BW-A1..A17, 39 QA tests; PRD v0.100 | 2026-11-05 |
| 239403051 | PRD · BPInfo REST (BI) | 238420037 PRD · Platform (folder) | Generated Connected PRD section 8.1: the door; verified security gaps today, BI-R1..R19 (hand-off feed, people, bus registry, effective bus, PIN sign-in, inbox, crew, absences, conduct, handover, emergencies), settings table, BI-A1..A29, 77 QA tests; PRD v0.100 | 2026-11-05 |
| 238387286 | PRD · Performance Management (PF) | 239075394 PRD · Other modules (folder) | Generated Connected PRD section 8.11: contractor defects and grounded buses become PM compliance items; PF-R1..R2, 2 AC, 5 QA tests; PRD v0.100 | 2026-11-05 |
| 238485608 | PRD · Time and attendance (TA) | 239075394 PRD · Other modules (folder) | Generated Connected PRD section 8.13: suggested contract for BP Unified T&A (staffGuid link, one bus, suggested jobs, offline punches, absences shared with Dispatch); TA-R1..R9, TA-A1..A9, 21 QA tests; PRD v0.100 | 2026-11-05 |
| 237043713 | PRD – Users and Access (BusPlanner Unified) | 58687491 Unified Login (folder) | HAND-WRITTEN, NOT part of the generated Connected PRD family. Status Final (V5.1); author and owner Ahnaf Rahman; dated 2026-10-27. Settings area for Users / Roles / Customers / Departments, two admin types, forgot password by emailed code, bulk upload; supersedes sign-in parts of 58851500. Requirements TO-BE; section 1 describes today | 2026-10-27 |
| 233144322 | PRD — Default Operator (BusPlanner Web and Quick) | 160366593 Quick (folder, under Old World Documentation & PRD) | HAND-WRITTEN, NOT part of the generated Connected PRD family. Status Ready for Dev; author Ahnaf Rahman; owner not stated separately; Jira PROD-798; page field says last updated 2026-10-23. Per-user default operator pre-selected in Quick Reassign Dashboard and BP Web reports. TO-BE | 2026-10-24 |
| 58851500 | PRD — Unified Login Flow | 58687491 Unified Login (folder) | HAND-WRITTEN, NOT part of the generated Connected PRD family. Status Ready for Dev; author Awais Akram; owner not stated; page field last updated 2026-07-27. Email-first single sign-in V1 (password only), V2 (forgot password, SSO, MFA, magic link), V3 (dynamic methods). TO-BE as written, but 237043713 describes the V1 screens as live today; sign-in parts superseded by 237043713 | 2026-07-28 |
| 247824423 | PRD · BP Info – Bulk Upload REST Users | 160333825 BP Web (folder, under Old World Documentation & PRD) | HAND-WRITTEN, NOT part of the generated Connected PRD family (despite the "PRD ·" title). Status DRAFT v0.2; author and document owner Awais Akram; Jira PROD-763; release date TBD. Bulk add / update of BP Service Administration REST users from Excel plus REST users page redesign; FR-1..FR-19. TO-BE | 2026-10-30 |
| 238518274 | PRD: Vehicle ↔ Route Mapping (GPS+) | 137887755 GPS+ (folder) | HAND-WRITTEN, NOT part of the generated Connected PRD family. Status DRAFT; author Awais Akram; Product / PM (owner) Ahnaf Rahman; last-updated field blank. New GPS+ page for vehicle to route mapping, single and bulk; FR-1..FR-8, US-1..US-10, OQ-1..OQ-5. TO-BE (prototype only) | 2026-10-30 |

Folders (no content):

| Folder id | Title |
|---|---|
| 239042562 | PRD · Start here |
| 238387204 | PRD · System |
| 239108119 | PRD · Open questions, risks and decisions |
| 239337473 | PRD · Dispatch |
| 254476308 | PRD · Dispatch V1 |
| 239337476 | PRD · Chipmunk |
| 238747652 | PRD · Turns |
| 238616600 | PRD · Ride Support |
| 253689870 | PRD · Discipline V1 |
| 239370241 | PRD · Dashboard |
| 238551063 | PRD · Fleet |
| 237797382 | PRD · Trips |
| 239468545 | PRD · Workflow |
| 238878743 | PRD · Quick |
| 239370244 | PRD · Settings |
| 238420034 | PRD · Employee app |
| 238420037 | PRD · Platform |
| 239075394 | PRD · Other modules |
| 239108143 | PRD · School closure and enrollment projection |

## 2. Product map from the PRD

Rows come from different pages, so a product can appear more than once with a different angle; the page id says which page.

| Product / system / module | Description | Users | Dependencies | Page id |
|---|---|---|---|---|
| BI - BPInfo REST "the door" (§8.1) | Carries every new link between products; code name BPInfo.Rest.Service; 99 controllers today; owner team Web | every app and service | Pro via GeoIMS, _WEB copy, GPS target, Dispatch DB | 238321683 |
| GI - GeoIMS and GEDI (§8.2) | Read and write Pro safely; owner Pro and GeoIMS teams | door, Quick, Fleet, Workflow | Pro live DB | 238321683 |
| LT - Live tracking (§8.3) | 9 GPS readers plus the two trackers (BPTrackerService: one Chipmunk and one Dispatch instance per district): where every bus is and its ETA; owner Tracker | Chipmunk, Dispatch, employee app | GPS vendors, BPInfo imports, Dispatch DB | 238321683 |
| SS - Subscription Service (§8.4) | Sends parent email, text and push (BPSubscriptionService); owner Web | parents | BP Web, Quick ledger, OneSignal | 238321683 |
| BW - BP Web (§8.5) | Settings, Parent Portal, notices, accounts; hosts staff Chipmunk Dashboard, Workflow settings, Subscription Service menus; owner Web | office staff, parents, drivers (driver portal) | _WEB copy (direct SQL), GeoIMS | 238321683 |
| DS - Quick Dispatch (§8.6) | Change today's plan safely and tell everyone; "Dispatch" alone = today's product in Quick; "New World Dispatch" = the new one on BP Unified; owner Quick | dispatchers | GeoIMS, Dispatch DB, trackers | 238321683 |
| QS - Quick staff / training records / ridership / bulk changes (§8.7) | One record per person; who rode; many riders at once; owner Quick | office | GeoIMS | 238321683 |
| FT - Fleet (§8.8) | Keep buses safe and running; runs standalone or reads Pro via GEDI/GeoIMS; new Fleet 12.4.x = fleet-main, older Fleet 13.x = dev/main; owner Fleet | mechanics, fleet managers | optional GeoIMS; fuel export file | 238321683 |
| TP - Trips (§8.9) | Plan field trips (SE = StandardEdition, CE = BidEdition in code); owner Trips | trip requesters, drivers | BPInfo Driver / School / Vehicle (import off by default); Google Directions | 238321683 |
| WF - Workflow (§8.10) | Forms and approvals; the only product that writes into live Pro today; owner Workflow | office, parents | GEDI (391 GetRemoteDatabase calls) | 238321683 |
| PF - Performance Management (§8.11) | Contractor compliance; owner unknown (Q30) | contract managers | BPInfo Operator, IncidentCount | 238321683 |
| TG - Training module (§8.12) | Record and prove driver training; today a browser prototype (localStorage, own roster, no server), NOT Georef.Web.Training; owner unknown (Q30) | trainers | people registry (to-be) | 238321683 |
| TA - Time and attendance, BP Unified (§8.13) | Record a driver's working time; code names bpunified, timescan, /api/ta/; owner BP Unified | drivers | own employees, jobs, buses today | 238321683 |
| TU - Turns (§8.14) | Driver tablet: drive the route, check the bus, scan riders; Android only, package com.GeorefSystems_TRPT, shipped as APK; owner Apps | drivers | BPInfo TurnsAppRole (7 controllers) | 238321683 |
| SU - Subs (§8.15) | Cover a route; iOS and Android; needs a connection only to sign in and submit; owner Apps | substitute drivers | BPInfo SubsAppRole (3 controllers) | 238321683 |
| CH - Chipmunk (§8.16) | Show parents the bus, ETA and alerts; one app for all districts, com.busplanner.parent; owner Apps | parents | Chipmunk tracker, BPInfo, Parent Portal login | 238321683 |
| DL - Delays (§8.17) | Tell parents about delays and closings; owner Apps | parents | BPInfo Notification, OneSignal | 238321683 |
| EA - Employee app (§8.18) | To-be: one phone app for mechanics, transportation staff, school staff and drivers off the bus, built from Chipmunk's code; owner Apps | staff, drivers | door, driver channel, live tracking | 238321683 |
| AS - Assistant (§8.19) | Staff app for browsing the plan (no live bus, no ETA); to be retired when the employee app matches it; no source in the Apps repo | staff | BPInfo AssistantAppRole (11 controllers) | 238321683 |
| SP - Settings program (§8.20) | To-be: every setting of every product in one place, written through each product's own store; owner Web (assumed) | BusPlanner staff | IF-BI-36 and per-product settings APIs | 238321683 |
| SC - Ride Support (§8.21) | To-be: referrals (behavior reports) from the bus, the school decides, bus and family told; placeholder name, code keeps "conduct"; home = the new platform | drivers, school reviewers, transportation, operators | door, Turns, parent channel | 238321683 |
| TM - Training mode (§8.22) | To-be: a person practises on the real screens in a practice layer; nothing sent or saved for real | new staff, trainers | door (training claim on token) | 238321683 |
| DB - Dashboard (§8.23) | To-be: district numbers (on-time performance, substitutions, Dispatch changes, stop completion, path deviation) with a School Viewer version; on the new platform | transportation, schools | Dispatch log, GPS+ arrivals, day snapshot | 238321683 |
| New platform (BP Unified) | Time and attendance, GPS+ and New World Dispatch on one database: unified schema v7.22 (June 2026), 122 tables in 12 domains | staff | Pro via incremental ETL (etl_watermark), one pln_snapshot per day | 238321683 |
| Prototypes and bench | Dispatch prototype (dispatch-proto), Connected prototype (Dispatch + Relay + real Turns and Chipmunk on emulators), the HTML version, bench (bp-bench: 76 proposed requirements and an event bus); none shipped | product team | local only | 239140866 |
| Connected PRD (BUSPLANNER-PRD-COMPLETE.md) | Single source file all "PRD · ..." pages are generated from; ids never renumbered, withdrawn requirements keep their id; product PRDs (PRD-dispatch-v1.md, PRD-ride-support-v1.md, PRD-dashboard-v1.md) narrow its scope per release | Product, engineering, QA | Confluence push | 239304705 |
| Connected prototype (connected-prototype.html, "the HTML version") | One-file prototype: Dispatch prototype screens and server, Training and Ride Support servers, the Relay, Turns and Chipmunk drawn from the real apps, one in-page database and clock; a "proven" tag refers to it or the Dispatch prototype; NOT shipped | Product, developers | none (in-page) | 239304705, 238223375 |
| Bench (bp-bench) | Local air-gapped test bed: replica Turns, Chipmunk, Quick, Pro, Fleet, Trips screens over one fixture district with an event bus; each behaviour has a "current" branch reproducing the shipped defect and a "proposed" branch; 76 requirement ids, 17 named hand-offs; NOT shipped | Product (demo) | localhost only; real Fleet on IIS Express when up | 238419971, 238223375 |
| Ride Support (placeholder name; internal identifiers keep "conduct") | To-be student behaviour module: referrals (problem / praise / concern / incident), reviews, decisions, bus suspensions, letters, seating charts; built on the new platform, web first then Turns and Chipmunk parts | Drivers, monitors, transportation and school reviewers, families | Turns, Chipmunk, alert engine, SIS export, the door | 239304705, 238845954 |
| Dashboard (module, name not final) | To-be KPI module with its own tile on the new platform's rail: on-time performance, bus substitutions, Dispatch changes, splits and merges, changes by person and route, stop completion, path deviation; School Viewer version | District staff, school staff | GPS+, Dispatch, the plan, platform analytics | 239304705, 238845954 |
| Alert engine | To-be shared sender for every product's alerts (one queue record per recipient); Dispatch hands it facts only, never finished words; until it exists districts post from BP Web | All products | Chipmunk, email, text, BP Web | 239304705 |
| Settings program (SP) | To-be BusPlanner-hosted tool that reads and writes every product's settings through the product's own path, keeping only a catalogue and audit log (catalogue: 1,996 settings in 36 tables and files) | BusPlanner staff | the door IF-BI-36, each product's store, Microsoft 365 sign-in | 239304705, 238845954 |
| Training mode (TM) / training module (TG) | TM: per-person practice on real screens in a separate practice layer, nothing sent or written elsewhere; TG: logs driver courses with completed and expiry dates; both to-be | New staff, trainers, training lead | the door IF-BI-49, IF-TM-01, Quick, employee app | 239304705, 238845954 |
| Employee app | To-be one phone app for staff (mechanic, dispatcher, school staff, driver role); replaces the Assistant app (Q5: find Assistant's code and archive it) | Staff | the door, Dispatch, Fleet | 238092292, 239304705 |
| New World Dispatch V1 | First release of Dispatch on BP Unified (proposal, draft v0.14, not shipped): one board (Gantt + Table) for any service day, absences, cover and stop tool, checks, day's plan of record, Needs your decision, crew, history; sends nothing to families, drivers or schools | Dispatchers, supervisors, front desk, viewers, district admin | Pro plan loaded into per-day snapshots (`pln_snapshot`), BP Unified T&A (shared absence), platform roles and settings; readers: trackers, Turns, Chipmunk (Q168), Dashboard | 238157830 |
| TransportDispatch run sheet prototype (v3.6) | Customer Success single-file HTML prototype (`dispatch.html`, Alpine.js + Tailwind, localStorage, single user, simulated clock, mock AI, stubbed Pro / Turns / Chipmunk integration); a requirements artifact, not shipped | Dispatcher (hard-coded operator), PIN admin | None real; assumes Pro is system of record | 238157851 |
| Dashboard (module) | Separate module with its own V1 PRD; counts on-time performance, bus substitutions, changes, splits and merges, stop completion, path deviation from Dispatch's log, plan of record and crew (DB-R2..R9, DB-R14, DB-R15) | Office staff | Dispatch log (DS-R31), day's plan of record (DS-R50), crew (DS-R46) | 238157830 |
| Quick Dispatch (DS, PRD §8.6) | Dispatch module inside the Quick web app (code Managed/Goldilox: DispatchReassignController, DispatchBaseController, Dispatch.js, RouteManagement view); engine is GEDI's Dispatch commands; Send Run Changes ledger lives in Georef.Web.Goldilox (DispatchNotification, migration 57) | Dispatchers and transportation office staff; through them drivers, families, schools | GeoIMS, BPInfo REST (the door), trackers, Subscription Service; depended on by Turns, Chipmunk, employee app, T&A, Trips | 238223396 |
| Send Run Changes | Quick ledger that holds every Dispatch change as a group until the dispatcher sends it to families (in production; at Clay since 2026-09-21) | Dispatchers | Quick's own database, Subscription Service, trackers | 238223396 |
| Reassign Dashboard / unified view | New World Dispatch's rebuild of the Reassign Dashboard (screen reference Reassign_Dashboard_PRD_v7_Unified.md, cited as NWD §n): Gantt, Table with Driver/Bus/Route lenses, day sheet, leave calendar, history | Dispatchers | BusPlanner design system shell; day layer (SY-24) | 238223396 |
| Dispatch prototype / connected prototype / HTML version / "the V1 page" | Local builds used as proof ("proven — Dispatch prototype"); NOT shipped; the prototype stays on its own machine | Product team | Clay copy loaded into BP Unified | 238223396 |
| Alert engine | Planned single engine shared by every product that sends alerts; each product queues one record per recipient; its own project, not in Dispatch V1 | Families, school staff (recipients) | New parent app, Chipmunk, email | 238223396 |
| Chipmunk (parent app) | Mobile app; reads BPTrackerService REST + BPInfo; district settings come from BPWeb `georef_Setting` via BPInfo, cached in tracker; one binary for all districts, per-district endpoint and OneSignal app id from `ClientEndpoint`; app source not in the main repo | Parents (subscribers) | Chipmunk tracker, BPInfo REST, BPWeb DB, OneSignal | 239108098 |
| Dispatch (module of BP Quick / Goldilox) | Goldilox MVC -> GeoIMS socket -> Dispatch DB, plus a direct BPWeb SQL handle; also calls tracker REST from the browser; 24 dispatch actions (Reassign, Merge, Split, Optimize, GPS substitute ...) | Dispatchers | GeoIMS/GEDI, Dispatch DB, BPWeb DB, both trackers | 239108098 |
| Turns (driver tablet) | Reads BPInfo REST only; offline-first; run-centric (driver picks a run, drives it, picks the next); app source not in the main repo | Drivers | BPInfo REST, Live or Dispatch DB | 239108098 |
| BPTrackerService | OWIN self-hosted Windows service with its own DB and `Settings` table; most districts run TWO instances: a Dispatch tracker and a Chipmunk tracker; computes ETAs, radius pushes, dispatch-change pushes | Chipmunk, Dispatch, GPS Live Viewer | Tracker DB, Live or Dispatch DB (per `DispatchDatabaseGuid`), OneSignal, GeoIMS | 239108098 |
| BPSubscriptionService | `ImmediateManager` / `ImmediateWorker` poll `ss_QueueStatus`; `EmailQueue`, `SMSQueue`, `PushQueue`; `MailingWorker` sends SMTP; own settings table `ss_Setting` | Parents (email) | BPWeb DB | 239108098 |
| Route Change Subscription Service (RCSS) | Batch job (`DriverRouteChangeManager` / `Worker`, `StudentRouteChangeWorker`) that emails route changes on a district schedule; not a same-morning alert | Drivers, parents | BPWeb DB | 239108098 |
| GEDI / GeoIMS | Shared C++ data layer; Pro links GEDI in-process, web apps call the same code through the GeoIMS command dispatcher (`GQHandler` commandMap) over a binary socket; no application stored procedures, all dynamic SQL | Pro, Quick, BPInfo | Planning / Dispatch DB | 238616579 |
| Quick Log Viewer | Viewer over log4net flat text files `~/Logs/*.log` filtered by a `Category:` substring; no structured store behind it | Support, district admins | BPQuickLogger | 239108098 |
| Add Student to Run wizard (Quick) | Existing single-student wizard: find stop -> create stop -> find run -> recalculate run, for AM and PM | Routers | GEDI calls, path-worker pool | 238616579 |
| Add Students to Runs (TO-BE) | Proposed bulk version of the wizard (1 to ~2,000 students), 7 steps, ends with runs updated | Routers | Same GEDI calls; later a new `GD_BusStopOptimizer_Suggest` | 238616579 |
| Pro Bus Stop Optimizer / Auto-assign | Pro-only ribbon tools: `CDLG_AutoGenBusStops` creates stops in bulk (K-means cluster mode or one-stop-per-corner address mode); `CStudToStopDLG` auto-assigns students to existing stops; neither adds stops to runs | Pro routers | GEDI, MFC UI library `libs/GBPUI` | 238616579 |
| Path-worker pool (Quick) | Pool of path workers used for run recalculation; 5 per database shared by all users of that database | Quick | Path server | 238616579 |
| Chipmunk (parent app) | One public MAUI app for every district (code `Apps/MauiChipmunk`), district picked by Quick Code; Quick Code `demo` shows sample data; shows ETA, bus and stop on map, alerts, messages; owner team Apps (app), Tracker (server as shipped), new platform (future server side) | Parents / guardians | District Chipmunk tracker (BPTrackerService), Dispatch database copy, BP Web (accounts, settings, alerts), BPInfo REST, OneSignal push, Subscription Service | 238518317 |
| New Chipmunk (Beta) | TO-BE: new parent experience reading BusPlanner Unified instead of the tracker; offered per district / school behind `Chipmunk_BetaEnabled` | Parents who opt in | BusPlanner Unified ETL, GPS reader, stop classification; BP Web settings | 238518317 |
| Chipmunk tracker service (BPTrackerService) | Per-district service that computes ETAs, radius ("bus is near") pushes, alert pushes and serves the app's REST endpoints (ETA, ETA2, UserSettings, ChipmunkSettings, MinimumVersion) | Chipmunk app | BPInfo REST feed (polls notifications), GPS readers, GeoIMS path calculator, OneSignal, tracker DB | 238878722 |
| Chipmunk Dashboard (BP Web) | Staff-facing page `BPWeb/Chipmunk/Dashboard.aspx` behind `ChipmunkDashboard_RouteLateThreshold`; not the parent app | Transportation department | BP Web | 238878722 |
| BP Web Chipmunk Message Manager | Staff screen where parent messages are acknowledged; staff replies do not reach the parent in the app today (CX-24, open) | Transportation office | BP Web, tracker ChipmunkMessage endpoints | 238518317 |
| Student Boarding Pass | TO-BE Chipmunk screen showing the student's bus pass as QR + barcode for the driver to scan; presentation layer over bus pass data Pro already holds; prototype only | Parents, students, drivers / aides scanning | Tracker (new fields), Pro bus pass records, Quick scanning | 238518338 |
| Turns (driver tablet) | Android-only MAUI app (`Apps/MauiTurns`) used by drivers on the bus: route/run selection, directions, student scanning, pre/post-trip checks, T&A clock by PIN | Drivers, crew (monitors / aides) | BPInfo REST ("the door"), BP Unified (IF-TA-01), Quick DB (checks, fm_ tables), GPS target (scans), BP Web settings; depended on by trackers, Chipmunk, Dispatch, Fleet, T&A | 238845975 |
| New Turns (Beta) | TO-BE: Phase 3 read-ahead release offered per bus behind `Turns_BetaEnabled` / `Turns_BetaBuses`; tablets not ready fall back to today's Turns | Drivers on Beta buses | BP Web Beta list, MDM or store install | 238845975 |
| Form module (inspections) | Template-driven pre/post-trip inspection stored in Quick's DB (`fm_Template`, `fm_Item`, `fm_PicklistOption`, `fm_Result`, `fm_ResultItem`, `fm_ResultItemAttachment`; 12 tables); Fleet screen `/Inspection/Form` is the all-open reference implementation | Drivers (Turns), Fleet inspectors | Quick (Goldilox) database, Fleet | 239140887 |
| Student Ridership Report (BP Web) | Report page `StudentScanDataReport.aspx` with flags such as "Left on vehicle" and "Did not ride" computed from paired scans | District staff | Scan events, ENG-1390 scan direction inference | 250740737 |
| BusPlanner Unified parent-side services | `BusPlanner.ETL` (nightly load of Pro plan), `BPGPSReaderService` (GPS), `BPStopClassificationService` (stops reached); no parent ETA, pushes or accounts built yet | New Chipmunk (future), GPS+ Live Viewer | Pro, GPS vendors | 238518317 |
| Bus safety (table prefix saf_) | TO-BE: empty-bus check at end of run (TU-R30) and red Emergency button (TU-R31); specified beside Ride Support but not part of it | drivers; Dispatch; emergency contacts | Turns; the door (IF-BI-51 / IF-BI-52, BI-R19); Dispatch Today page | 237928473 |
| Connected prototype (not shipped) | Built 2026-10-14 on one computer: Dispatch prototype (new platform pages, C# library BusPlanner.Conduct), the Relay (a Node stand-in for the door), real Turns and Chipmunk apps on emulators, plus a separate HTML version; email, push and text simulated; reference only, the spec wins | product, engineering, user tests | anonymised copy of one district | 239337500 |
| Ride Support (code SC; working name Student conduct; permission prefix cnd:; table prefix sc_ / cnd_) | TO-BE module: behaviour referrals from the bus (Problem, Praise, Concern, Incident), review by transportation then school, decisions that reach the bus (seat, keep apart, not riding) and the family (letter), SIS export, trends by run, seating charts, bus layouts, equipment | drivers and monitors; principals and named school staff; transportation supervisors; operators' supervisors; families (letter only) | the door (IF-BI-21/24/26/39/40, new IF-BI-41..44); Quick ridership IF-QS-02; parent channel IF-SS-01; new platform accounts and roles (IC-11) | 239337479 |
| Ride Support V1 (PRD-ride-support-v1.md) | First release doc: one path from two settings and starter roles instead of routing chains; own ACs and QA tests | same | same | 239337479 |
| Pro incident log (BPX_Incident) | TODAY: staff incident log in BP Pro (12 types, e.g. Tardiness / Absenteeism, Behind The Wheel); not about students; stays for staff reports | transportation office | BP Pro yearly database | 239337479 |
| Competitor products (lead only) | SMART tag SMART Conduct, Transfinder Formfinder in Wayfinder, Transportant, Zum, Infinite Campus / PowerSchool referrals; benchmark for the module | n/a | n/a | 239337479 |
| Ride Support (working name; code keeps "conduct" / Conduct_ / cnd:) | TO-BE module on the new platform, integrated with Turns: a bus referral (Problem, Praise, Incident, Concern) goes from the driver tablet to a reviewer, then to the bus, the family and back to the writer; includes bus suspensions and the not-riding list | drivers, monitors, transportation reviewers / supervisors, school reviewers, principals, district admins, counsellors (contacts), guardians (letters only) | Turns release and its offline queue; day's plan (students, SIS ID, enrollment); guardians table (does not exist yet); alert engine (does not exist yet); platform school grants; service-day calendar | 239108122 |
| Dashboard (working name, final name Q188) | TO-BE read-only module, own tile on the BusPlanner Unified rail: seven district numbers (on-time, substitutions, Dispatch changes, splits and merges, changes by person and route, stop completion, path deviation) for today or a range, with rows, breakdowns, CSV and printable page | directors, supervisors, dispatchers, every Dispatch role; school staff via School Viewer | New World Dispatch V1 log and day records (DS-R31, DS-R50); GPS+ on-time, stop-visit and path-deviation engines; the day's plan; platform roles and scope | 238583811 |
| School Viewer | TO-BE reduced Dashboard for school staff: own schools' runs only, only the numbers the district shares, no staff names | school staff | Dashboard; platform school grants; bulk user import (Q184) | 238551042 |
| Platform Analytics page | TODAY: eight tabs (overview, why stops not serviced, fleet map, route map with corridor, trends, problem stops, coverage gaps, vehicle-route mismatch) behind analytics:read; not on the rail in the release build, linked only from the developers' home page | developers today | GPS+ stop classification data | 238583811 |
| GPS+ compare pages (plan versus actual) | TODAY: api/gpsplus/compare grid, map and on-path pages; per stop per day the best sample of what the bus did, per route per day share of positions within 150 m of planned path | GPS+ users with gpsplus:read | GPS feeds, the day's plan | 238583811 |
| Alert engine | TO-BE single engine that sends every product's alerts (decided 2026-10-23); a product puts one record per recipient in its queue; Ride Support letters and staff notices use it | all products | none exists today: the platform has no notification table | 239108122 |
| Connected prototype (HTML page) and Dispatch prototype (local server) | NOT SHIPPED: prototypes carrying the Dashboard on made-up GPS and real prototype Dispatch data; the board-meeting mockup for PROD-793 | product, CS, the district's board | prototype data only | 238551042 |
| Ride Support beta prototype (2026-09) | NOT SHIPPED demo: every hand-off between tablet, office, school and family is simulated and 11 of its 25 settings are never read by its code | product | none | 239108122 |
| Fleet "Miami" line (12.4.x) | The new Fleet, code `Managed/BusPlannerFleet` on branch `fleet-main`; every change lands here; .NET Framework 4.8, MVC 5, C# 7.3, hand-written T-SQL (not Entity Framework) | mechanics, fleet managers, parts staff | Fleet's own SQL database per district; optional GeoIMS for staff | 239403009, 238288898 |
| Fleet older integrated line (13.x) | Older Fleet shipped from `dev` and `main`; a HIGHER version number means the OLDER Fleet; needs its own backport item per client promise (RK-7) | districts still on the old line | — | 239403009 |
| BPFleetService | Windows service that runs the reminders auto-create work-order job (WorkOrderManager) | unattended | Fleet database; `ServiceSetting` rows | 238288898 |
| Fleet local build W01–W18 | Uncommitted work on one machine against `fleet-main`: 52 files modified, about 60 new files, migrations 867–878, permissions 110000–110021; NOT shipped | (none yet) | must be renumbered before merge | 238288898 |
| Fleet Inspections module (local) | Digital vehicle inspection in Fleet: forms, criteria builder, photos, defect intake, notifications, messaging (W06–W09, W11); NOT shipped | inspectors, mechanics, criteria authors | migrations 867, 868, 871–874, 876, 877 | 238845996, 238911532 |
| FleetImporter | Today's history importer; reads one older fleet system's FoxPro tables | CS at move-in | old system export | 239403009 |
| Fleet (BusPlannerFleet web app) | Maintenance system: vehicles, work orders, reminders (PM), parts, vendors, purchase orders, fuel, inspections; ASP.NET MVC 5 / .NET Framework 4.8, raw ADO.NET on SQL Server, schema migrations VersionNNN (shipped baseline 866, local work adds 867-878) | Shop staff, technicians, fleet managers, district admins | Georef.Web.Fleet, Georef.Web.GEDI bridge to the transportation (routing) database, Translations.csv, AspNet identity tables | 239009796 |
| BPGeotabReader | Standalone Windows service (one of the GPS readers) that pulls the Geotab feed and lands telemetry in transportation-database tables BPX_AVLEvent / BPX_AVLEventType; per-district deployment is an ASSUMPTION | none (service) | Georef.Web.Geotab GeotabConnection, Geotab SDK Geotab.Checkmate.ObjectModel 11.43.302 | 239009796 |
| GPS Live Viewer | Live fleet map owned by Goldilox / Dispatch (DispatchGPSLiveViewerController, DispatchGPSLiveMapping, BPQuickService LiveMapWorker); colours buses by movement; Leaflet 1.9.4; default tiles are a district-hosted WMTS service | Dispatchers | Geotab stack, WMTS tile service | 239009796 |
| BP Quick forms module ("the inspections app") | Receives inspection checklist templates via BPInfo REST FormModuleTemplate; data types INFO / TEXT / NUMBER / PICKLIST; renders checklists for drivers | Drivers, Quick users | BPInfo.Rest.Service, Georef.Web.Goldilox | 238354434 |
| Fleet Telemetry Ingestion screen (/Telemetry) | TO-BE local screen: dry-run then commit of odometer / engine-hours readings from a telemetry provider; URL only, no nav entry | Holders of TELEMETRY_VIEW | ITelemetryProvider, settings 82-84, UnitDailyMax (63) | 238354434 |
| Fleet Telemetry tab (/VehicleTelemetry) | TO-BE local screen: one row per non-archived vehicle with latest usable odometer / hours, staleness, rejected count, last position, health state | Holders of TELEMETRY_VIEW | TelemetryProviderFactory, VehicleMileageReading | 238354434 |
| Fleet Vehicle Map (/VehicleMap) | TO-BE local screen: Leaflet map, marker colour = worst maintenance state, side panels for urgent vehicles with no position and unmatched devices | Holders of TELEMETRY_VIEW | ITelemetryPositionProvider, ReminderDueness, settings 89-90 | 238420013 |
| Vehicle Shop Days report (/VehicleDowntime) | TO-BE local report: distinct days with an open work order per vehicle, shop hours, still open, not started; export Copy / CSV / Excel / Print | Fleet managers (VEHICLE_VIEW) | WorkOrderStatus history, UserLocations | 238420013 |
| Criteria publish outbox | TO-BE local: queues an inspection form as JSON for the Quick forms module in table InspectionFormPublish; no sender built | Holders of INSPECTION_CRITERIA_MODIFY | BPInfo REST CreateTemplate contract | 238354434 |
| Parts-vendor integration (Phase 3) | TO-BE proposed: IPartsVendorProvider adapter for price / availability, PO submission, catalogue sync, invoice back-flow | Parts / purchasing staff | Vendor APIs (REST / cXML punchout / EDI 850 / 810), Part / PartVendor / PurchaseOrder tables | 239009796 |
| BusPlanner Fleet (fleet-main, 12.4.x, the "Miami" line) | ASP.NET MVC 5 server-rendered, desktop-first fleet maintenance app: work orders, reminders (PM), parts / inventory, purchasing, fuel, technician time; own database; thin-controller / fat-ViewModel; old-style csproj (no globbing) | Shop staff, mechanics, parts room, fleet managers | Own SQL DB (shipped schema v866); GEDI/GeoIMS for staff reads; BPFleetService for auto-create of work orders | 238485528, 239075352 |
| Fleet 13.x | The OLD Fleet code line (12.4.x fleet-main is the newer one despite the lower number) | Districts not yet cut over | — | 239075352 |
| BPFleetService | Background service that auto-creates work orders from due reminders | none (service) | Fleet DB | 239435777 |
| FormModule (fm_* tables) | Shared forms / inspection backend in Quick's web DB; Turns downloads checklists and submits results through BPInfo.Rest.Service | Drivers (Turns), Quick users | BPInfo.Rest.Service, Quick DB | 239075352 |
| GeoIMS | C++ Windows service (32-bit only) with a pool of geoims.exe worker processes; every web read / write of BP Pro goes through its socket commands (not REST) | Quick, BPInfo, Fleet, BP Web, Workflow, Tracker, Subscription Service, Campaigns, 8 reader services | Pro database, GEDI library, ims_registry / reg.xml | 238125072, 237993990 |
| GEDI | C++ library (Unmanaged/libs/GEDI) holding the Pro schema and business logic; shared by GeoIMS and Pro desktop; managed callers use Georef.Web.GEDI RemoteDatabase | Pro desktop, all web products via GeoIMS | Pro schema | 238125072 |
| BPTrackerService (the tracker) | Per-district service computing ETAs, bus visibility and pushes; 20 controllers; each district runs TWO trackers (Chipmunk's and Dispatch's) | Parents via Chipmunk, dispatchers (GPS+, Reassign Dashboard), employee app | BPInfo imports, GeoIMS, GPS target tables, OneSignal | 238551066 |
| GPS reader services (BP*Reader) | Nine vendor readers writing GPS events into the GPS target (BPX_AVL* tables in the Pro schema) | none (services) | GPS vendors, Pro schema | 238551066 |
| Georef.Web.FleetImporter | One-time FoxPro (FleetPro) to Fleet migration tool; stamps one admin user on every imported adjustment | Implementation staff | Fleet DB | 239009817 |
| Quick Staff Manager | Staff screens in Quick (Managed/Goldilox: StaffPropertyController, StaffVM, StaffTrainingVM, ExpiredCertificatesSearch view) holding people, training rows and the Expired Certifications report | office admins, training coordinators | GeoIMS, Pro staff record, the door (BPInfo) | 238321704 |
| Quick Ridership report | Quick report of student scans per run (RidershipVM, RidershipFilterVM, RidershipController) with date range, scans on/off, time, place, bus, manual flag, unplanned riders | transportation staff; school staff via employee app (to-be) | Dispatch copy of the plan, BPX_AVLScanEvent, BPX_AVLScanCardStudent | 238321704 |
| GPS+ Live Viewer (school) role | View-only Quick role showing the GPS+ live viewer limited to the user's BP Pro school scope (ENG-1159) | school staff | DispatchGPSLiveViewerController, Quick scopes | 238321704 |
| Training Tracking prototype ("BusPlanner Quick Training") | Single-file browser prototype (index.html about 7,781 lines, vanilla JS + Bootstrap, localStorage) for driver training compliance: event log, California T-01 / T-02 forms, requirements, reports, kiosk; demo only, not production | Admin / Transportation Director, instructors, drivers (demo roles) | none (standalone, no backend, no auth, simulated email) | 238878746 |
| Training module (TG) | To-be productised training module: training events, T-01 periods, signatures, kiosk sign-in on a server; people from the registry; rows written to Pro; training notices | trainers, training office, training lead, drivers | the door (IF-BI-22, IF-BI-26, IF-BI-35), Subscription Service scan + email (SS-R8), GeoIMS partial save | 239403072 |
| Training mode (TM) | To-be per-person practice mode on the real screens with a practice layer and outbox; nothing sent or saved for real | new dispatchers, routers, office staff, drivers, trainers, BusPlanner Support | the door (IF-BI-49, training claim), day layer (SY-24, IF-BI-48), BP Web settings and staff accounts | 238747676 |
| Employee app ("BusPlanner Staff", working name) | To-be MAUI phone app built from Chipmunk's code for mechanics, transportation staff, school staff and drivers off the bus; replaces Assistant once at parity | all district employees | the door (SY-10), bus registry (SY-11), people registry (SY-12), driver channel (SY-13), live tracking (SY-15), forms engine (SY-16), Fleet, Quick | 238223417 |
| Assistant | Existing staff phone app showing routes, runs, stops, schools and students as planned only (no live bus, no ETA, nothing for mechanics); source not in the Apps repo | staff | planned data | 238223417 |
| Chipmunk Dashboard | Web dashboard for district staff showing usage numbers, not bus-by-bus answers (tracker DashboardController; roles Override, ChipmunkDashboard) | district staff | tracker | 238223417 |
| BP Web driver portal | Web portal for drivers with about 30 DriverSee… report switches (route details, directions, maps, students, manifests, seating charts, medical report, route changes, bus passes, call lists); plan only, nothing live | drivers | BP Web settings (DriverMenu) | 238223417 |
| Georef.Web.Training | Old library for customer class sign-ups; unrelated to the training module | n/a | n/a | 239403072 |
| Settings program (SP) | Proposed BusPlanner-hosted web app: pick a client, see every product's settings (existing and "coming"), write through to each product's own store via the district's BPInfo door, append-only change and activity logs, templates; keeps only a catalogue and audit, never a copy of values. NOT SHIPPED (draft v0.1) | implementation consultants, Customer Success, support; product/engineering for the catalogue | BPInfo door (IF-BI-01, IF-BI-02, new IF-BI-36), one adapter per store, SETTINGS-CATALOGUE | 239534081 |
| Settings catalogue | Script-generated list (SETTINGS-CATALOGUE.md and .csv, 1,996 rows) of every setting per store with key, default, where it is changed and when a change lands; first input to the settings program and the IC-6 register | product, engineering, CS | code at the production pins plus five local databases read with SELECT only | 238321725 |
| Workflow (shipped) | Forms and approvals product whose settings and 31 wf_ tables live in the BP Web database; the only product that writes into Pro's live database ("Save To BusPlanner") through GeoIMS | parents and staff who submit forms; approvers | BP Web database, GeoIMS (writes), nightly copy to reach the apps | 239075373 |
| BusPlanner Workflow (proposed, prototype) | No-code forms, approvals and communication platform with 8 modules (My Forms, Templates, Form Builder, Submissions, Workflow Rules, Submitter Portal, Letters, Reports) plus Settings; approved requests auto-assign a student to the nearest stop in Pro. Prototype is client-side only (localStorage), integrations simulated | District Admin, Transportation Coordinator, School Admin, Teacher; parents, staff, drivers, public as submitters | Pro Web API, SIS, GIS/geocoding, SMTP (all simulated in the prototype) | 238911553 |
| Trips SE (Standard Edition) | Field-trip request / approve / assign / invoice web site for districts that own their buses; code Managed/TripsStandardEdition, Georef.Web.Trips.StandardEdition, Windows service BPTripsSEService; 37 of 215 CRM clients | trip requesters, approvers, trip office (transportation), drivers (PDF only) | own DB <base>_BPTripsSE; BPInfo imports; Google Directions; SMTP | 238747655, 238387207 |
| Trips CE (Bid / Contractor Edition) | Edition that tenders trips to outside operators (bids, quotes, contracts, operator ratings); code Managed/TripsBidEdition, Georef.Web.Trips.BidEdition, BPTripsService; 9 clients (Ontario, Nova Scotia, Alberta consortia) | consortia, boards, operators | own DB <base>_BPTripsCE; its drivers are not Pro staff | 238747655, 238387207 |
| busHive | Competitor field-trip / charter software (Transit Technologies since 2025-03), sold beside Bytecurve 360, DriveOn driver app and the Field Trip Request requester portal; bought as a bolt-on beside routing vendors | n/a (competitor) | PC Miler, QuickBooks, Sage (per vendor) | 238387207 |
| TripsSE Onboarder (proposed) | Excel workbook (10 sheets) + Flask web wizard + Playwright uploader that loads Trips SE setup in 7 chunks and gives a readiness report; not built | implementation / CS staff, new clients | Trips SE web forms (no API) | 239140908 |
| School Closure Planner | BP Pro desktop dialog (internal CDlg_ProximityPlanner) that lists each affected student's current, closest and second-closest school with walk distances | district transportation analysts | BP Pro walk graph, 32-bit only; ribbon Analysis > School | 238321767 |
| Redistricting module | Separately licensed BP Pro / GeoMap module (key 60627): School Capacity Analyzer, Population Summary / Listing by Boundary, School Boundary Optimizer, Recluster, Merge / Split / Copy Boundary | district planners | Pro DB; permissions 1033 / 1034 | 238321767 |
| Enrollment Projection (proposed) | New Redistricting tool: named plans (scenarios) with feeder rules, base-year headcount capture, multi-year roll-forward, capacity and "students with nowhere to go" lists; not built | transportation director and staff; board gets export | 3 new Pro tables; DB subversion bump 12.4.1 | 238321767, 237797385 |
| Subs app | MauiSubs phone app (iOS, Android) with which a substitute driver takes a route on a bus (writes the bus-to-route mapping) | substitute drivers | BPInfo REST (GPSRouteVehicle, GPSVehicleID, Route); settings shared with Turns | 238682136 |
| Subscription Service | Windows service Managed/BPSubscriptionService (threads DriverRouteChangeManager, Worker, StudentRouteChangeWorker, ImmediateWorker, SMSQueueManager, SMSWorker) plus BP Web EmailQueue / PushQueue and Georef.Web.OneSignal; sends parent email, SMS, Delays push and the drivers' route-change digest | parents, drivers | BP Web DB queues, Twilio, OneSignal, SMTP, Quick | 238321746 |
| Delays app | MauiDelays phone app where parents follow schools and routes for delay and closing notices; works without an account | parents | BPInfo Notification feed, Subscription Service, OneSignal (nine keys) | 238026775 |
| Assistant (AS) | Staff app for browsing the plan: routes, runs, stops, schools, students; frozen, to be retired | office / school staff | BPInfo REST role AssistantAppRole; source not in Apps repo (Q5) | 239534102 |
| BP Web (BW) | District web site: settings home, Parent Portal, notices, driver portal, professional portal, User Manager, reports | district admins, office staff, parents, school staff, drivers | the _WEB copy (rebuilt nightly), GeoIMS, BPInfo REST, the tracker | 238485587 |
| BPInfo REST (BI) "the door" | REST service, 99 controllers, route api/{controller}/{action}/{id}, tokens from /Token | every app, both trackers, Trips SE, Performance Management | GeoIMS, BP Web database and settings, BP Unified PIN check, OneSignal | 239403051 |
| BP Service Administration (BP Info admin site) | Legacy ASP.NET WebForms (.NET 4.8) site managing REST users, their Operations and Schools / Grades / Operators scope; pages Rest/Setup.aspx (list, add) and Rest/Permission.aspx (edit) | district admins (Administrator role), BusPlanner support / CS | ASP.NET Identity tables; GeoIMS for school, grade, operator lists | 247824423 |
| Performance Management (PF / PM) | Contract and operator compliance tracking (contracts, requirements, audits, score ranges, OperatorDeficiency) | contract managers | own database (24 perfMgmt_ tables + ASP.NET Identity); BPInfo Operator/Get and IncidentCount/Get | 238387286 |
| Time and attendance (TA) | BP Unified time clock: PIN clock-in on Turns, jobs, timecards | drivers (on Turns), payroll | BP Unified own database and API; three BPUnified_ settings in BP Web served by BPInfo GetTurnsSettingsV2 | 238485608 |
| BusPlanner Unified sign-in and Settings (project name User Management) | One email-first sign-in at app.busplanner.ca plus a proposed admin-only Settings area (Users, Roles, Customers, Departments) | all Unified users; BusPlanner admins and Customer admins | client_registry.BPUsers (one registry per CAN / US environment); per-organization databases | 237043713 |

## 3. Glossary

291 terms (duplicates across pages removed, first definition kept).

| Term | Meaning | Page id |
|---|---|---|
| [Fact] / [Context] / [Assumption] | Tags used in the training prototype document: verifiable in prototype source / background from Customer Success / analyst inference | 238878746 |
| <Role>See<Feature> switches | BP Web's about 190 per-role visibility settings (district admin 41, school admin 44, operator 46, driver 30, transportation 26) | 238485587 |
| 110000 permission family | Seven new Fleet permissions: INSPECTION_VIEW 110000, INSPECTION_CREATE 110001, INSPECTION_CRITERIA_MODIFY 110002, INSPECTION_FAILURE_NOTIFY 110003, TELEMETRY_VIEW 110010, WORKORDER_CHANGE_AUDIT_VIEW 110020, WORKORDER_CHANGE_AUDIT_REVIEW 110021 | 238354434 |
| A1-A4 | The four dispatcher paths that change a GPS vehicle: Substitute GPS Vehicle tab, GPS Live Viewer, Reassign Route/Driver, GPS Vehicle Assignments admin screen | 239108098 |
| A-AREA-n | Appendix A exact-code block id in the change spec, e.g. A-NOTIFY-1 | 238288898 |
| Accident package | One PDF and one CSV for an Incident: referral facts, GPS point and kept map, frozen seats (sc_SeatSnapshot), scans, Released to, linked emergency alert / empty-bus check | 239337479 |
| AC-n.k / CF-nn / QA-nnn / V1-Gn | V1 ids: AC-n.k = acceptance criterion k of DS-Rn; CF-nn = conflict case (a planned change overtaken); QA-nnn = V1 QA test; V1-G1..G5 = V1 goals | 238157830 |
| AgeLimit (MessageAgeLimit) | Subscription Service setting: how old a queued job may be and still be sent; 10 min when the DB row is absent, capped at 60 | 239108098 |
| alert / hold / send / replaced / expired | alert = typed message the office posts to families; hold = keep a parent notice until sent (not queue); send (not release); replaced = superseded by a later change; expired = held notice nobody sent by midnight | 239271938 |
| Anchor | The last-service value a reminder measures from (LastServiceDate / LastServiceOdometer / LastServiceOperatingHour, else Start*) | 238288898 |
| AS, BW, BI, PF, TA | Two-letter section codes: Assistant, BP Web, BPInfo REST, Performance Management, Time and attendance | 239534102 |
| Asks A-J / B1-B9 | Miami-Dade's ten requests for the closure tool (A name receiving schools ... J presentable output) and the nine independently ticketable defects found in the code | 238321767 |
| AxisState | Ordered due-ness state: NotEnabled 0, NoAnchor 1, NoReading 2, NotDue 3, Approaching 4, Due 5, Overdue 6; IsDue = state >= Due, CanAnswer = state >= NotDue | 238288898 |
| A-xxx-n | Appendix A block ids for byte-exact code (e.g. A-PERM-3, A-DOWNTIME-1, A-TELEM-SQL), each tagged with the W item that uses it | 239403030 |
| Bench / defect ids | CM- Chipmunk, DP- / DF- / D1-D5 Dispatch notice defects, TN- Turns, TI- Turns inspection, TR- Trips, FL- Fleet, PR- Pro, WK- stress-test findings, W01-W18 Fleet local work items | 238223375, 238092292 |
| Beta / switch day | Beta: new Turns and Chipmunk run inside today's apps for chosen buses and opted-in families under a Beta agreement; switch day: the day a district moves from today's Dispatch to New World Dispatch | 239304705 |
| Blackout dates / blackout hours | Trips setup lists: dates on which trips are blocked; hours during which automatic reminder emails are not sent | 239140908, 238387207 |
| Boarding attempt | One row per scan on of a suspended rider (cnd_boarding_attempt); choice ALLOWED, DENIED, ASKED_DISPATCH, NOT_CHOSEN or NO_ATTEMPT; found_by SCAN, LOOKUP or RADIO | 237928473 |
| BTW | Behind-the-wheel training (event type); BTW guide codes SL1-SL6 | 238878746 |
| Build-spec ID schemes | UC-n.m use-case step (also a test); BR-n business rule; ST-n special situation (also a test); NF-n non-functional test; TS-n Turns screen; WS-n web screen; CS-n Chipmunk screen; Q-En engineering question; DQ-n developer question; Cn settled contradiction; CND-En Jira epic | 239337500 |
| bus / GPS unit / tablet | bus = the physical bus by number (not vehicle, unit); GPS unit = tracker installed on the bus (not AVL, device); tablet = the Turns tablet; "GPS" on Turns = home-screen directions to any address | 239271938 |
| Bus body types | A-1, A-2, B, C, D (front / middle / rear engine), activity bus (MFSAB: no stop arm or flashing lights, never home-to-school) | 239403009 |
| Bus instruction | What a decision means on the bus (sc_BusInstruction): seat, keep apart, not riding, note; sent to tablets via IF-BI-43 | 239337479 |
| Bus is near / radius notification | Push sent when the bus crosses inward of the parent's radius around the stop (CX-26) | 238878722 |
| Bus suspension / Lift | Not riding from a first day to a last day for all, AM, PM or chosen runs; states scheduled, in force, ended, lifted; Lift = ending early with a reason | 239108122 |
| BusCrewDay | Proposed crew record: who signed in on which bus, role, times, source (PIN, linked account, yard account, dispatcher) | 239403051 |
| C1-C11 / M1-M5 / S1-S3 | Fleet fix-spec item ids: Clay-only, Miami-only, shared | 239009817 |
| Call-out vs Leave | Call-out = same-day staff absence; Leave = absence entered ahead; both are "staff absence"; a student not riding is a "rider absence" | 238223396 |
| CC-n | Cross-cutting constraints CC-1..CC-6 (two plan DBs, no tolerance, patchy audit, flat log, three settings stores, email is the non-app fallback) | 239108098 |
| CH / TU | Two-letter product codes for Chipmunk and Turns; requirement ids CH-Rn / TU-Rn, goals -Gn, acceptance criteria -An, QA tests -QA-nnn, risks -Kn | 238518317 |
| check / problem / needs repair / do not drive / fixed | check = pre/post-trip inspection (DVIR); problem = defect; needs repair = deferred failure (IsFailure); do not drive = non-operable, grounded (IsNonOperable); fixed = repaired | 239271938 |
| Check levels | Warn / Override with a reason / Block: the three levels of a pre-save check (DS-R4) | 238223396 |
| Clearinghouse | FMCSA Drug & Alcohol Clearinghouse query ledger per driver in the prototype (manual, no integration) | 238878746 |
| Close at Transportation | Closing a referral at a transportation step after a call with the family, with no decision and no letter (Conduct_CloseAfterFamilyCall) | 239337479 |
| CM-n | Change ids in the Chipmunk UX changes document (CM-1..CM-8, sub-items CM-1.1 etc.); "REQ CM-x" refers to them | 238878722 |
| CM-n / DP-n / TN-n | Requirement ids in Part 8: CM = Chipmunk (CM-1..CM-8), DP = Dispatch (DP-1..DP-3), TN = Turns (TN-1..TN-4); sub-items like DP-1.17; DP-1.R1..R7 are integrity constraints | 239108098 |
| cnd_ / saf_ / Conduct | Proposed BP Unified table prefixes for Ride Support (PRD working names use sc_) and bus safety; "Ride Support" is a placeholder name and internal identifiers (Conduct_ settings, cnd: permissions, /api/conduct) keep "conduct" | 237928473 |
| Code 39 | Barcode symbology Fleet prints (ZPL ^B3); cannot encode "#" | 238420013 |
| Code names | Quick = Goldilox (Managed/Goldilox); Send Run Changes = DispatchNotification ledger (ENG-1616); the door = BPInfo.Rest.Service; trackers = BPTrackerService; Subscription Service = BPSubscriptionService; Trips SE / CE = StandardEdition / BidEdition; T&A = BP Unified, bpunified, timescan; driver checks = FormModule fm_* tables in Quick DB; GPS provider "BusPlanner" = Geotab | 239271938 |
| Code pins | "Today" = production main e60a6e87 (2026-09-18, identical to stage b56886f9) for everything except Fleet; fleet-main 969d0138 for Fleet; Apps dev 7bfa58ff for Turns, Chipmunk, Subs, Delays. Evidence read at 969d0138 for a non-Fleet product is "April code". "Local version" = uncommitted local work, not shipped | 238682115 |
| Cohort-survival ratio | Share of a grade's students who return the next year in the next grade; UI name must be "Students returning next year (%)", never "survival ratio" | 238321767, 237797385 |
| Component / ESE / Reg Ed | Component = Pro's run type AM, PM, Noon or Other (`BPX_ComponentType`); ESE = special education (shown as SPED on cards); Reg Ed = regular education | 238157830 |
| conduct identifiers | cnd_ tables, cnd: permission codes, Conduct_* setting keys, SC- ids, URLs and API routes keep "conduct" while screens say Ride Support and "referral" | 239304705 |
| Connected (QA test type) | Test whose Then is checked in another product; other types: Happy, Negative, Edge, Data, Conflict, Permission, Non-functional; P1 blocks the release | 238125072 |
| Connected (test type) | QA test type where the change crosses into another product and the Then is checked there; other types: Happy, Edge, Negative, Permission, Data, Conflict, Concurrency, Non-functional; P1 blocks the release | 238419992 |
| Copy-on-edit / CanEditInPlace | A used inspection form is copied to Version+1 and the old one superseded; editable in place only when UsageCount is 0 and not superseded | 238845996 |
| Core charge | A deposit on a part returned when the old part (core) goes back to the vendor | 239403009 |
| Cost Rule | Fleet setting key 15: 0 = average cost (default), 1 = last cost; drives UnitCost everywhere | 239009817 |
| Country terms | US: license, behavior, miles, district, FERPA; Canada: licence, behaviour, kilometres, school board or consortium, MFIPPA / FOIPOP / PIIDPA; bus checks FMCSA vs NSC Standard 13 | 239271938 |
| Cover / coverage method | How an open run is driven: Substitute (Covering / old Spare Cover), Split, Part split, Bus swap, Cancelled (optional), Double Back, Double Up | 238223396 |
| Cover review states | No longer needed, Uncovered, Check times, Needs review (cover statuses after the plan changes under a planned cover) | 238223396 |
| Coverage piece | Prototype model: one {driver, bus, own run, stops, operation order} contribution to covering a run; run status derives from pieces: cancelled / uncovered / incomplete / assigned / confirmed | 238157851 |
| Crew | Paid adults on the bus besides the driver (monitor, aide, trainer), roles from `Turns_CrewRoles` | 238845975 |
| D1-D7 | Dispatch merge notification defects (Part 9); D1-D3 are prerequisites for DP-1 | 239239170 |
| Dashboard / on-time performance / stop completion / path deviation / School Viewer | Dashboard = §8.23 module of district numbers; OTP = early / on time / late at school; stop completion = share of scheduled stops served; path deviation = left planned line by more than distance for longer than time; School Viewer = school staff role | 239271938 |
| Data classes (IC-7) | Public, Internal, Staff personal, Staff sensitive, Student personal, Student sensitive, Ride Support, Live bus location | 238321683 |
| databaseGuid | District database ID that changes each school year, so door rows must move at rollover (Q31) | 239403051 |
| "Date is the expiry" flag | To-be per-course-type flag (BPX_TrainingType.DateIsExpiry) meaning the training row's date is the expiry date, not the completion date | 238321704 |
| Day layer | Dated store of Dispatch's "just today" changes that ends with its day; on the new platform the day's snapshot is the day layer | 239304705 |
| Day sheet | The dispatcher's board for one service day (AM/PM), replacement for the Excel run sheet; in the unified view its rows are the Table | 238223396 |
| day sheet / leave / call-out / rider absence / absence (staff) / cover / close the year | day sheet = dispatcher's rows for one service day (replaces Excel run sheet, lives in the board's Table); leave = planned staff time off; call-out = out today; rider absence = student not riding; cover = who drives instead; close the year = lock a year's day sheets | 239271938 |
| Day's snapshot | New platform's plan for the day (`pln_snapshot`), loaded from Pro by the ETL plus Dispatch's same-day changes (DS-R50) | 238518317 |
| DaysDown / Shop days | Distinct calendar days in the window on which a vehicle had at least one open (InProgress, not yet terminal) work order; not the same as days out of service | 238420013 |
| Deadhead | A leg with no riders (yard to first stop, between runs, back to yard) | 238845975 |
| DF-n | Defect register DF-1..DF-17 (found in code, not feature requests) | 239108098 |
| Direct Permissions (override) | Today's per-user permission checkboxes in Unified that bypass roles, codes like ta:employee:write | 237043713 |
| Disposition | Telemetry ingestion outcome per reading: Accepted, FlaggedIgnored, FlaggedOverwritten, DuplicateSkipped, MeterTypeMismatch, VehicleNotMatched | 238354434 |
| DM-n / S-n / KF-n / WF-n | Knowledge-transfer ids: prototype feature, screen, key field, workflow | 238157851 |
| DoNotPushToApp | Checkbox on a BP Web alert that keeps it out of the app feed and push | 238256131 |
| Double Back / Double Up | A double = one bus does the open run plus its own run; Double Back = one run after the other; Double Up = the two runs' stops mixed on one trip (D/B, D/U on the sheet) | 238223396 |
| Double Up / Double Back | Double Up: open run's stops merged into a covering driver's same-time run; Double Back: the bus does the two runs in an order (Q75 recommends New World Dispatch's meanings) | 239304705 |
| Double-back | One bus serving the same school twice (two loads) built with Merge Runs; deliberate, not a defect; merged run is named `<run>_Merge<n>` | 239239170 |
| Driver channel | TO-BE push path from server to tablets (inbox, `itinerary.changed`, `plan.changed`, overrides), Phase 3 | 238845975 |
| Driver web portal | BP Web's DriverMenu with about 30 DriverSee… report switches (plan reports only, nothing live); accounts linked through georef_DriverUsers | 238682115 |
| DS | Two-letter product code for Quick Dispatch; ids DS-Rn (requirement), DS-An (acceptance criterion), DS-QA-nnn (QA test), DS-Gn (goal), DS-Kn (risk) | 238223396 |
| Due-ness | Whether a reminder is due / approaching; today computed in about nine different places in Fleet | 239435777 |
| Dueness stamp | Hidden `.dueness-stamp` span (axis, state, due date, percent) used to compare screens attribute by attribute | 238288898 |
| DVIR | Driver vehicle inspection report (the pre/post-trip check) | 239140887 |
| Early / On time / Late / No data / Not there yet | Run's time at school stop vs scheduled: early 5+ min ahead, late 5+ min behind (defaults); No data = no GPS, never counted on time; Not there yet = due but not arrived | 238551042 |
| Effective / Retire | Dates on a mapping; active on D when Effective ≤ D and (no Retire or Retire > D); bulk rows are tagged READY / REASSIGN / ERROR | 238518274 |
| Effective bus | The bus on a run right now: planned bus, then Turns/Subs/Dispatch swap, then dispatcher override (wins until cleared or day ends), including driver self-taken runs | 238223417 |
| Effective mapping / effective bus | The rule choosing which bus is really driving a run from tablet, dispatcher and planned mappings | 238551066 |
| EITAS | Customer whose priority list (sections 2.4 fuel tank, 2.5 barcode, 2.6 downtime, 2.9 vendors, 3.2 labour export, 3.4 attachment print) drives W16-W18 | 238420013 |
| Enrollment types / DBActiveDate | Enrollment types Main, Other1-3 and Home (Home has its own eligibility row and distance and is excluded from capacity counts); DBActiveDate = database-wide persisted "active date" read at about 900 code sites incl. GeoIMS parent and driver endpoints | 238321767 |
| equipment / bus layout / seating chart | equipment = what a rider needs (harness, vest, wheelchair); bus layout = seats, wheelchair stations, doors, exits per bus; seating chart = who sits where on a run | 239271938 |
| ESE | Exceptional Student Education = special education population (Student.SpecialEd flag; Regular / SpecialEd bits on school grades) | 238321767 |
| ETA2 vs ETA (old method / radius method) | Two tracker endpoints; app calls `api/ETA/Get` for districts on the old ETA method and `api/ETA2/Get` on the radius (new) method | 238256131 |
| Evidence markers | VERIFIED = read in source and re-checked; CORRECTED = earlier draft was wrong; UNVERIFIED = inference needing a person or live data | 239108098 |
| Evidence tags | [verified] checked in code or a doc citing code; [lead] strong inference; [open] / [unknown]; [assumed] assumption or proposed number; [calculated] worked from verified figures; "proven" names a prototype | 239140866 |
| Evidence tags (employee app) | [verified] checked in code; [lead] strong inference to confirm; [open] unknown | 238223417 |
| Evidence tags / severity (stress test) | verified = read in code or data; lead = likely but one hop not traced; open = needs something not available (e.g. T&A backend); design = gap in the to-be rules. P1 stops information, P2 makes it wrong or incomplete, P3 confusing. Results: holds / partial / broken / missing / lead / can't test here | 238682115 |
| Exception (suspension) | "May ride on <day>" or "Rides Run X instead" (alternative transportation, with a stop); needs cnd:suspension:lift | 239337479 |
| FailureSeverity | Per-criterion inspection failure level: Ground (bus must not run) or Deferred (work raised, bus may run); NULL reads as Deferred | 239403030 |
| Feeder rule / RuleType / CountType | Proposed rule rows: RuleType 0 Feeder (move students), 1 GradeSpan (change grades offered), 2 Close; CountType 0 Actual, 1 Historical, 2 Intake, 3 Ratio, 4 Projected, 5 CapacityOverride | 238321767 |
| fleet-main | Branch / code line of the newer Fleet (12.4.x, "Miami" line); both Clay and Miami-Dade run it | 239009817 |
| FleetPermissionAttribute | New class-level MVC authorization filter; admits a request holding ANY of the listed permissions | 238354434 |
| FR-01..FR-10 | Beaverton feature-request ids for Fleet | 239435777 |
| FR-01..FR-10 / MIA-01..27 / ENG-987..1002 | Source request id schemes: one district's shop feature requests / Miami production issues / Fleet priority list items | 238288898 |
| FR-02 / FR-04 / FR-07 | Beaverton feature requests: FR-02 work-order Service History pane, FR-04 part images, FR-07 core charge display | 238420013 |
| FT | Two-letter product code for Fleet; ids FT-Gn goals, FT-Rn requirements, FT-An acceptance, FT-QA-nnn tests, FT-Kn risks | 239403009 |
| GEO-n / TRK-n / SHR-n / I-n | Reliability fix-spec ids: GeoIMS native, Tracker, shared socket assemblies, instrumentation | 237993990 |
| GI | Two-letter code for GeoIMS and GEDI (requirements GI-Rn, acceptance GI-An, tests GI-QA-nnn, risks GI-Kn) | 238125072 |
| GPS target | The Pro-schema BPX_AVL* tables the readers write (BPX_AVLEvent has 15 columns; 11 event types: Beacon, IgOff, Live, On, Pullout, School, Off, Stop, Unknown Stop, Check Point, Depot) | 238551066 |
| GPS Unit → Vehicle → Route | New World mapping chain; unit to vehicle is the Device Mapping page, vehicle to route is the proposed GPS Vehicle Mapping page; Old World "GPS Vehicle ID" is actually the device ID | 238518274 |
| Ground / Deferred | The two failure levels on an inspection criterion: Ground takes the bus out of service, Deferred raises work and the bus keeps running; map to Quick forms `IsNonOperable` / `IsFailure` | 238845996 |
| Hand-off | A change event published to the door's feed (api/Handoff), identified by eventId and ordered by seq | 239403051 |
| Hand-off envelope fields | eventId (idempotency key), type, v, databaseGuid, subject {kind,id}, subjectSeq, occurredAt / receivedAt, actor, correlationId, payload (max 16 KB), seq (door's per-district cursor) | 238321683 |
| HealthState | Telemetry tab status per vehicle: Unlinked, No meter configured, No readings, Rejected readings, Stale (more than 14 days), OK | 238354434 |
| Held group / held notice | A parent notice waiting in the Send Run Changes ledger until sent, discarded or expired (ledger state `Expired`) | 238223396 |
| Held notice / Send Run Changes | Parent notice of a Dispatch change kept until a dispatcher sends it; ledger is Quick's DispatchNotification table | 238092292, 238845954 |
| Hold | The reviewer working on a subject (held_by, "Being reviewed by …") | 239337500 |
| ID prefixes | Requirements XX-Rn, acceptance XX-An, QA tests XX-QA-nnn, knock-on XX-Kn, goals XX-Gn; product codes seen: BI door, GI GeoIMS, LT live tracking, SS Subscription Service, BW BP Web, DS Dispatch, QS Quick, TU Turns, SU Subs, CH Chipmunk, DL Delays, FT Fleet, TP Trips, WF Workflow, PF Performance Mgmt, TG training module, TA time and attendance, TM training mode, SP settings program, SC Ride Support, DB Dashboard, EA employee app; CF-nn Dispatch future-change cases; DB-EC Dashboard edge cases | 238518296, 238845954 |
| ID schemes | SY-n system rules and shared services; CX-n connections; J1-J25 journeys; IC-1..11 integration contract; IF-code-nn interfaces; code-Gn / -Rn / -An / -Kn goals / requirements / acceptance / risks; code-QA-nnn QA tests (§8.23 starts at DB-QA-100); WX-1..8 worked examples; RK-n system risks; Qn questions | 239140866 |
| ID schemes (Dashboard) | DB-R requirement, DB-G goal, DB-A (build section) and DB-AC-n.k (V1) acceptance criteria, DB-EC edge case, DB-QA test, DB-PQ prototype check, DB-K risk, IF-DB interface | 238551042 |
| ID schemes (Ride Support) | SC-R = Ride Support requirement, TU-R = Turns requirement, RS-AC-n.k / RS-AC-Tn.k = acceptance criteria, RS-EC-nn = edge case, RS-QA-nnn = QA test, RS-G = goal, CH-R = parents' app requirement, DS-R = Dispatch requirement, Q = open question, IC = integration contract | 239108122 |
| Ignored / Overwritten | Bit flags on VehicleMileageReading marking rejected or superseded odometer readings; "usable" reading = both 0 | 239009796 |
| is near / route scope / retire / cleared to drive / the bus on the run / hand-off | is near = within radius; route scope = which runs a driver may drive; retire = stops working, history stays; cleared to drive = assignable; the bus on the run = effective bus after swaps; hand-off = named event | 239271938 |
| IsNonOperable / IsFailure | Two inspection failure levels on `fm_Item`: grounds the vehicle vs deferred maintenance (bus may still run) | 239140887 |
| IsOperable / HasFailure | Roll-up flags on fm_Result (one submitted form result) | 239075352 |
| IsUrgent | Map flag true for Grounded, FailedInspection, OverduePm only; an open work order is not urgent | 238420013 |
| ITelemetryProvider / ITelemetryPositionProvider | Provider-neutral seam for meter readings and (optional) positions; FakeTelemetryProvider is the only implementation | 238354434 |
| J17-J20 | Employee app journeys: road call, "Where's the bus?", arrival and dismissal, dispatcher swaps a bus from the phone | 238223417 |
| J1-J25 | Journey ids in §7; each journey is built only from CX register rows | 238092292 |
| Just today / From now on | A Dispatch change for one day (day layer / day snapshot) versus a permanent change written to the plan in Pro; "From now on" is a permission | 239304705 |
| Kind / Reason / Severity | Kind = Problem, Praise, Incident, Concern; Reason = district's words for what happened; Severity = three levels the district names (default Minor, Major, Urgent) | 239108122 |
| Kinds | Problem (behaviour against bus rules), Praise, Concern (well-being worry, confidential), Incident (not one rider's behaviour: injury, medical, damage, stranger, rider left on bus) | 239337479 |
| Lead axis / verdict | The axis that decides a reminder (a firing axis first, else the earliest to arrive) and the one plain sentence built from it | 238288898 |
| Left on vehicle | Ridership-report flag: a boarding scan with no matching alighting scan; second in precedence below "Did not ride" | 250740737 |
| Legacy IDs (never renumbered) | CM- Chipmunk, DP- Dispatch, TN- Turns, DF- defects, WP-, D1-D7 merge-notification defects, R1-R4 alert comments, TRK- / SHR- tracker fixes, W01-W18 Fleet local work, WK-n stress-test findings, CC-n cross-cutting (REQ), FR- (two meanings: Beaverton feature request in Fleet spec; functional requirement in Workflow PRD) | 239140866 |
| LidNumber | Vehicle column used (provisionally) as the telemetry device key; no dedicated Geotab device-ID column exists | 238354434 |
| Live DB / Dispatch DB / BPWeb DB / Tracker DB | BP Pro planning DB (authoritative) / `*_DISPATCH` day-of working copy rebuilt nightly / web DB (subscribers, settings, queues, `dispatch_ReassignNotification`) / BPTrackerService DB (cached plan, ETAs, UserSettings, radius settings) | 239108098 |
| LIVE_ bridge / GEDI bridge | Fleet's existing socket connection to the district's live transportation database (RemoteDatabase.GetRemoteDatabaseForFleet, Web.config LIVE_ settings) | 239009796 |
| LT | Two-letter code for Live tracking (LT-Rn, LT-An, LT-QA-nnn, LT-Kn, goals LT-Gn) | 238551066 |
| MapState | Vehicle map state, worst first: Grounded, FailedInspection, OverduePm, OpenWorkOrder, Ok (rank 0-4) | 239403030 |
| MATCHED / NEEDS_RUN / NEEDS_STOP / ATTENTION | Buckets in the bulk flow: stop exists on a run / stop exists on no run / no stop nearby / unclear so not routed ("Needs a look") | 238616579 |
| Mechanism 1-5 (fuel) | Verified causes of fuel tank drift: 1 duplicate-guard test, 2 adjustment sign disagreement, 3 recount screen overwrite / double Quantity input, 5 two tanks of one fuel type at a yard (4 = non-atomic decrement, fixed locally) | 238420013 |
| Message Type template | Per-language text (`MessageTypeTranslation`) shared by every alert of that type; today's push body and in-app alert message | 238256131 |
| Met at bus / hand-off | A rider Pro marks as needing an adult at the stop; the hand-off is the record of who met the child | 238845975 |
| Mirror (migration 877) | Grant each new permission to exactly the roles that already hold the old gating permission, so access is unchanged on install | 238354434 |
| MissingPart | Fleet row recording a part charged to a work order when stock was short; cleared when stock is received | 239009817 |
| MU | Make-up training flag; prints "MU" prefix on the T-01 (CCR Title 13 §1236(b)) | 238878746 |
| needs review / Needs your decision / period / component / ESE, Reg Ed / bell risk | needs review = planned change overtaken by something underneath; Needs your decision = list of those; period = AM, PM or other; component = Pro's run type AM, PM, Noon, Other; ESE / Reg Ed = program (not SPED on cards); bell risk = how close a run is to missing the bell | 239271938 |
| Needs your decision | Dispatch list (DS-R52) of items a dispatcher must resolve: clashes after a reload, planned cover that no longer fits, stop changes on planned runs | 239304705 |
| New World Dispatch / V1 | New World Dispatch = new Dispatch on BP Unified (not "Dispatch v2"); V1 = a module's first release | 239271938 |
| NewMethod | Tracker flag selecting `RunVETAUpdater` (new ETA path) over `RouteETAUpdater`; forced True on every upgraded tracker | 239108098 |
| Nice to have | Written out in full with AC and tests but not committed for V1 (DS-R54 early dismissal, DS-R55 training mode) | 238157830 |
| Not riding / Suspended | A bus suspension, shown to drivers and Dispatch in the district's word (Conduct_DriverWording: "Suspended" default or "Not riding (school)"), never with the reason; states scheduled, in force, ended, lifted | 239337479 |
| Not started | Work orders that never went InProgress; shop time unknown, shown separately, not zero | 238420013 |
| Notice categories | Per-parent message categories: the five in REQ CM-2.1 plus a sixth "About your child" (Student) that a parent cannot turn off (TO-BE) | 238321746 |
| NotifySubscribers | Flag on tracker `UpdatePlannedInfo`; true (Chipmunk tracker) sends change pushes to parents, false (Dispatch tracker) sends none | 239239170 |
| Not-riding list | The day's suspended students for the whole district, held on every tablet as IDs and dates only, never displayed | 239108122 |
| NWD §n | Citation of New World Dispatch's screen PRD (Reassign_Dashboard_PRD_v7_Unified.md) | 238223375 |
| Off elsewhere | TO-BE mark on an off-scan anywhere but the rider's own stop (or school in the morning) | 238845975 |
| Off the path / Run window | Off the path = GPS position beyond the corridor (150 m default) from the planned line; run window = first to last scheduled stop widened by 20 minutes each end | 238551042 |
| Offer ledger / hours guard / trip board / driver sort / trip link | TO-BE Trips concepts: record of every offer and decline (TP-R8); weekly-hours check before an offer (TP-R9); driver sign-up for posted trips (TP-R10); three-level driver ordering (TP-R21); no-sign-in phone page for one trip and one driver (TP-R26) | 238747655 |
| OPEN route | A route with no driver in the plan; listed first on the board and counted | 239304705 |
| OPEN route / open run | A route with no driver in the plan for the day (unassigned route); its runs count in Need a driver | 238223396 |
| open run / substitute / double back, double up / covering driver / spare / run board | open run = driver out, not covered; substitute = another person on the run's own bus; double back / up = one bus does an open run with its own, sequential or mixed (names set by Dispatch_DoubleNames); spare = driver or bus with no route; run board = cards-and-map editor for splits, doubles, stop moves (was "stop tool", Quick's "Merging Runs") | 239271938 |
| Open run vs open route | Open run = a run whose driver is out and not yet covered; open route = a route with no driver in the plan that day | 238157830 |
| Operator = depot = lot | Same thing; the BusPlanner field is Operator, one customer calls its operators depots | 233144322 |
| Opt-out (met at bus) | Family's choice, recorded by the district, that no parent or guardian needs to meet the child at the stop (TU-R50) | 239108122 |
| Organization / client / customer | The tenant an email signs in to; one client_registry.BPUsers record per email and organization, with CustomerID; pln_district is a sub-entity where SSO will be configured | 58851500 |
| Outbox | Durable queue row holding the exact payload to send later; InspectionFormPublish statuses Pending / Sent / Failed / DeadLettered | 238354434 |
| Parent-change job | TO-BE unit of work on IF-SS-01 carrying the change (kind stopTime / busChanged / runChanged / routeChanged / run cancelled, justToday, before / after, bus number, student GUIDs) instead of finished text; other job kind: studentLetter | 238321746 |
| Phase A, 0, 1, 2, 3, 4, 5 | Order-of-work phases: A contract, 0 fix today's paths, 1 the spine's keys, 2 safe moves and Fleet loop, 3 driver channel and live bus, 4 parent channel, 5 the rest | 238518296 |
| Planned crew | Staff assigned to a vehicle in Route & Vehicle Update, shown in Dispatch beside the day's sign-ins | 238321704 |
| PMVI | Ontario mechanical inspection, at least two per year, plus a legally required daily driver inspection | 238485528 |
| Practice layer | To-be per-trainee set of dated practice records kept in separate tables on top of the real plan and day layer | 238747676 |
| Practice outbox | To-be list of everything that would have been sent in training mode, with audience count, channel and wording | 238747676 |
| Preset | Per-state configuration bundle in the prototype (form identity, code dictionaries, requirements, notification defaults): California T-02 and Florida FL-SBDT-1 (sample) | 238878746 |
| Purchase Requisition | Fleet report listing under-stock parts to order, per location / vendor | 239009817 |
| QA test type "Connected" | A QA test whose Then is checked in the product that receives the change; test table columns ID, Covers, Type, P, Given, When, Then | 238321683 |
| QA test types and priority | Types Happy, Negative, Edge, Permission, Data, Non-functional (build section adds Connected); P1 blocks the release, P2 important, P3 can follow; "sent straight to the server" = request made without the UI to prove server-side refusal | 238551042 |
| Qnn / RK-n | Open-question ids (Q5-Q290, never renumbered; answered ones leave the table and become decision rows) / risk ids RK-1 to RK-26 | 239304705 |
| QS / TG / TM / EA | Two-letter PRD section codes: Quick staff-training-ridership-bulk (§8.7), Training module (§8.12), Training mode (§8.22), Employee app (§8.18) | 238321704 |
| Queue | Whose list a sent subject waits in: TRANSPORTATION, OPERATOR, SCHOOL or CONTACTS; the label of the With transportation status follows the queue ("With the operator", "With the well-being contacts") | 237928473 |
| Quick Code | The district code Chipmunk, Turns, Subs and Delays send to appapi.busplannerweb.com (ClientEndpoint) to find the district's own endpoint | 239173656 |
| Radio record | With Turns off, office staff record what happened at the bus: Allowed, Denied (with who was there) or Didn't try to board; logged "Office, from the driver by radio" | 239337479 |
| Read-ahead release | An app release shipped ahead of the server feature it supports; one per app per phase (IC-5) | 238518296 |
| Reason string | Text every GEDI write carries into audit fields and the route-change trail, e.g. "Bus Stop Optimizer" | 238616579 |
| ReassignNotification | Row in BPWeb `dispatch_ReassignNotification` written per dispatch change log; paired with an `ss_QueueStatus` job that sends the parent email | 239108098 |
| Referral | Screen and letter word for a Ride Support report; one referral can name several riders and each rider gets their own review and status | 239337479 |
| referral / praise / concern / bus instruction / Ride Support / suspended | referral = behavior report from driver or staff; praise; concern = well-being worry; bus instruction = seat, keep apart, or not riding with dates; suspended / not riding = school says rider may not ride (word set by Conduct_DriverWording, Chipmunk_SuspendedWording) | 239271938 |
| Referral statuses (9) | Draft, Sent, With transportation, Handled by transportation, Sent to the school, With the school, Decided, Closed, Withdrawn; writer-facing words are Sent at [time], Being reviewed, Done, Withdrawn | 239108122 |
| Relay | Component of the connected prototype that serves the tablets (prototype only) | 238223375 |
| Released to | Per rider on an Incident: adult from the child's list, someone else, back to school, emergency services, or still on the bus | 239337479 |
| Reminder | Fleet PM schedule row with three axes: date, odometer, operating hours; each has interval and threshold | 239435777 |
| Reminder axis | One of three ways a reminder comes due: Date, Odometer, OperatingHours | 238288898 |
| REST user / Operations | A BP Info login in AspNetUsers (e.g. a Turns login or service account) / the REST roles ticked per user (e.g. TurnsApp, StudentBasicGet, RunGetAll), defined in Georef.Web.ServiceAdministration/Roles.cs | 247824423 |
| Retest result words | Pass, Partly, Fail, Not built (PRD proposes it, no prototype has it), Can't test, Not run | 238223375 |
| Retime / Optimize | Retime keeps locked times and spreads planned legs between them; Optimize reorders stops (needs 3 or more stops) and is a preview until Use these times | 238223396 |
| Retire, never delete (SY-23) / route scope (SY-22) | One Retire action closes every sign-in and keeps history / the set of routes a driver or sub may take (e.g. own operator, AllRoutes) | 238092292, 238419971 |
| Reviewer group | sc_ReviewerGroup: a school's reviewers split by grade (K–2) or first letter of last name (A–L) | 239337479 |
| role / starter role / permission / scope / acting role / yard | role = what a person may do, where, and see; starter role = shipped role the district changes; permission = one thing a role may do; scope = yard, operator, school, program, route set or board; acting role ends on a date; yard = Pro's depot | 239271938 |
| route / run / run version / stop / deadhead | route = a bus's whole day; run = one pass (never "trip" for a school run); run version = run variation, RunV: plan for a date range and days; stop; deadhead = driving with no riders | 239271938 |
| Route scope | Which routes/runs a driver may see or claim (e.g. `OwnOperator`), checked by the server (SY-22) | 238845975 |
| Route-level vs run-level GPS mapping | Row in `BPL_AVLVehicleRoute`; null `RunGuid` = whole route, non-null = one run | 239108098 |
| Routing chain | District-defined ordered steps of roles that receive a referral, with a When rule, a Can read it lane, timers and versions (Conduct_Routing) | 239337479 |
| RunV | Run variation; Route -> Component -> RunV -> Run; tracker and dispatch notifications key on RunV GUIDs | 239108098 |
| S1-S11 (Add Students) and S1-S6 (CM-5) | Two different id sets: skip rules of the bulk flow (238616579) vs radius-notification failure scenarios (239108098) | 238616579 |
| School approver chain | Ordered list of approvers per School x Trip Type; the "Default" trip type chain is the fallback when a school has no chain for a trip type | 239140908, 238387207 |
| School stop / Rider stop | School stop = where a run reaches its school (AM) or picks up there (PM); rider stop = any other stop | 238551042 |
| Scope (Quick) | Per-user data limits by district, school, operator and staff (UsersScopeDistrict / School / Operator / Staff); employee app adds shop | 238223417 |
| Seat unit / configuration | One bench on one side of a row (width, 1–3 positions, belts, child seat, mounts) / a named layout variant of a bus chosen per run | 239403009 |
| Send Run Changes | Production feature (ENG-1616, on main since 2026-09-18): every Dispatch change is held in a ledger until the dispatcher sends it; "Replaced" in the list = the ledger's Superseded state | 238682115 |
| Sent straight to the server | QA phrase: the action is tried without the screen to prove the server refuses what the screen hides | 238157830 |
| Served / Probable / Skipped / Not seen | GPS+ stop outcomes: served = door opened with bus stopped close by (stop, checkpoint); probable = close and slow, no door (visited); skipped = drive-by; not seen = no row | 238551042 |
| Service day | A day the buses run, from the district's calendar | 238157830 |
| Service day / Day's plan of record | Service day = a day buses run per district calendar; plan of record = the day's snapshot with Dispatch's changes (DS-R50) | 238551042 |
| service day / just today / from now on / swap | service day = district's local date; just today = temporary substitution, ends tonight (23:59:59 local today); from now on = permanent change; swap = another bus or driver on a run | 239271938 |
| Service day / school day | A day the district runs buses; proposed source is the district's service calendar (Dispatch's in the prototype); still open (Q50) | 237928473 |
| Setting 24 | Fleet setting "New Work Order Reminders On" (`ShowReminderForCreatingWorkOrder`): the switch for the reminders pane on work-order create | 239403009, 238288898 |
| Setting keys 82-90 | 82 TelemetryMileageEnabled, 83 TelemetryProviderName, 84 FuelImporterMileageEnabled, 85 ChargeLabourFromPlannedHours, 89 MapTileUrlTemplate, 90 MapTileAttribution (86-88 other Wave 6 areas); next free key 91 | 238420013 |
| Settings store 1 / 2 / 3 | 1 = BPWeb `georef_Setting` (5 min cache); 2 = Tracker `Settings` (30 min cache); 3 = Dispatch `Setting` in Dispatch DB, int-enum keys named `DisPatch_*` | 239108098 |
| Severity | Each reason is minor, major or urgent; district can rename the three words (Conduct_SeverityWords) but behaviour per level is fixed | 239337479 |
| Shared yard account | One Turns login shared by a yard's drivers; today's only sign-in (0% of sign-ins name a person, WK-1) | 239403051 |
| Shop days | Days a bus is in the shop per work order: first InProgress to first terminal status (Completed / Closed / Inactive), inclusive of both days | 238845996 |
| ShopHours | Clipped work-order span hours summed across work orders (workload; concurrent jobs add up) | 238420013 |
| So far / Final / Corrected | Today's numbers as data arrives / a past day once data is in / a past day after a Dispatch correction | 238551042 |
| Source short names | map = ecosystem map; REQ = REQUIREMENTS-chipmunk-dispatch-turns v0.6; CTX = Fleet-Turns-inspections context; FCS = Fleet change spec; census = code census at the pins; bench = bp-bench engine | 239140866 |
| SPAB | One of the prototype's vehicle categories (school / spab / transit / farm-labor / youth / other) that drive T-01 minimum hours | 238878746 |
| Spare bus | A bus with no route that day | 238223396 |
| Staff notice / Letter / Contact | Staff notice = email to staff via the alert engine naming no student; Letter = what the family gets in the guardian's language; Contact = person told about one event type | 239108122 |
| StaffApp | To-be new BP Web settings Type holding per-role feature switches for the employee app (e.g. SchoolStaffSeeBusMap, MechanicSeeFaultCodes) | 238223417 |
| staffGuid / DriverGuid / busId | Pro person ID (driver accounts match on DriverGuid = staffGuid); busId is the bus registry ID joining Pro vehicleGuid, fleetVehicleId, GPS devices and tripsVehicleId | 239403051 |
| Standard job / work task | A work task with a reminder; Fleet's screens say "work task" | 239403009 |
| Starter role / Work area | Starter role = a role BusPlanner ships with fixed permissions (one per person in V1); Work area = the schools a role applies to, or the whole district for transportation | 239108122 |
| Step codes | T01..T19 = steps on the nine-status path; C01..C09 = steps with a routing chain; named codes TAKE, TAKEOVER, RELEASE, MOVE_ON, CLOSE_CALL, REVERSION, SIGN, CHANGE_STUDENT, LINK, UNLINK | 237928473 |
| Step kinds | One person handles it (default), Split it (by grade or last-name range), Everyone signs off; no voting, no approval steps | 239337479 |
| Step levels | SC-R21: Decide / Review and pass on / Comment only / View only; SC-R27 replaces with Decides / Recommends / Kept informed | 239337479 |
| Stop types vs run types | Separate enums with overlapping values: stops PICKUP=0, DROPOFF=1, SCHOOL_PICKUP=2, SCHOOL_DROPOFF=3, TRANSFER_PICKUP=4, TRANSFER_DROPOFF=5, WAY_POINT=6, TURNAROUND_POINT=7; runs PICKUP=0, DROPOFF=1, NOON_PICKUP=2, NOON_DROPOFF=3; web `iRunType` 0 = AM, 1 = PM | 238616579 |
| Store family / adapter | One of nine families of settings stores (BP Web, Pro, Trackers, Quick, Fleet, Trips, PM, GPS readers, config files); an adapter is the proposed per-store component on the door with list/get/set/clearCache/version | 239534081 |
| sub / merge / split | sub = substitute driver; merge = move one run's stops onto another; split = cut one run into two or three | 239271938 |
| Subject | One rider on a referral, or "A rider I don't know" (UNKNOWN), or the incident itself when it names no rider (NONE); each subject has its own status; an UNKNOWN subject cannot be decided until a student is attached | 237928473 |
| Substitute / Split | Substitute = another person drives the run on the run's own bus (follows the person); Split = the run's stops go onto other runs (stops follow the runs); a double follows the bus | 238157830 |
| Substitution / Change / Split / Merge | Substitution = run on a bus other than its own; Change = one save in Dispatch; Split = a run's stops put on other runs for the day; Merge = a double (Double Back / Double Up) | 238551042 |
| Superseded part | A part number replaced by a newer number, keeping one history chain | 239403009 |
| Suppressed reminder | A reminder not offered because it is Inactive, Ended, or covered by an open work order (reason recorded, not dropped) | 238288898 |
| Switch day | The service day on which a whole district moves from today's Dispatch to New World Dispatch (`Dispatch_SwitchDay`) | 238223396 |
| T-01 | California Training Certificate: 5-year cycle of five birthday-anchored 12-month periods with classroom / in-service / BTW hour grid and signatures | 238878746 |
| T-02 | California Training Record: the form identity of the prototype's California preset (code T-02, California Department of Education) | 238878746 |
| "T-1 renewal" | Prototype's informal label for the annual birth-month renewal cadence; mapping to official CDE/CHP forms is an open question | 238878746 |
| Take it / Take over | Deliberate claim of a referral; opening never takes it; Take over needs a reason and is logged | 239337479 |
| Targeted Notice / Chipmunk Message Manager | BP Web notice to chosen students' parents / BP Web page for parent messages from the Chipmunk app | 238485587 |
| targeted notice / message | targeted notice = district message to chosen families (route, run, stop, school, group, student) by app, email, text; message = person-to-person thread | 239271938 |
| TELEM-0x / PM-* / DT-* | Local-only fixture vehicles and work orders (telemetry, due-ness, downtime); not created by the repository except PM-* via Wave2_DemoFixtures.sql | 238420013 |
| Terminal status | Completed, Closed or Inactive stops the shop-days clock; OnHold does not; Voided not handled | 238420013 |
| Test district | Fixture used by the QA tests: Keystone Heights JR SR High, Elm Middle School, Bus 42 (Run 7, Run 7-2), Bus 12, Run V-12, Bus 1957 (KHHP-E01, type "ESE 10L 2-W/C") | 239075331 |
| Test id schemes | DLC-n / DLC-En = driver life-cycle tests; DRV, MEC, DSP, SCH, PAR, ADM = role tests (driver, mechanic, dispatcher, school staff, parent, admin); J1-J24 = journeys; S1-S15 = whole-day scenarios | 238682115 |
| The board / the stop tool | Board = New World Dispatch's page for a day (Gantt + Table); stop tool = cards-and-map editor for splits, doubles, stop moves and stop times (Quick's Merging Runs with a map) | 238157830 |
| The BusPlanner six | Standard checklist per section: Time, Identity, Data flow, Notices, Settings, Privacy | 238485587 |
| The day's plan of record | The day's snapshot plus Dispatch's changes for that day; what plan vs actual is measured against | 238157830 |
| the door | BPInfo REST; new cross-product endpoints go there (except ETAs, which stay on the tracker) | 239304705 |
| the plan / snapshot / plan of record / plan vs actual / day layer / change feed | plan = Pro's routes, runs, stops, students, crew for a day; snapshot = platform copy per service day with Dispatch's changes, kept; plan of record = snapshot plus changes; day layer = Dispatch's dated changes read over the plan; change feed replaces the nightly copy | 239271938 |
| The Relay | The prototype's stand-in for the door (one Node process); not a product | 239337500 |
| Today / Local version / To-be | Today = company code at the pins; Local version = built on one machine or bench, not in company code; To-be = what the PRD asks for | 239140866 |
| Today page / the feed | Proposed Dispatch page listing everything that happened on the day's runs, newest first (DS-R17); not in V1 | 238223396 |
| TP / SU / SS / DL | Two-letter PRD codes: Trips, Subs, Subscription Service, Delays; ids look like TP-R8 (requirement), TP-A5 (acceptance), TP-QA-018 (test), TP-G4 (goal), TP-K1 / SS-K1 (risk) | 238747655, 238682136, 238321746, 238026775 |
| Training claim | To-be claim carried on every door call made in training mode; the door accepts writes with it only into the practice layer | 238747676 |
| Training lead | To-be person in charge of the training department (plus named designees) who receives the credential digest; set in People_TrainingLead | 239403072 |
| training mode / practice change / practice outbox | practise on real screens, nothing sent or saved; practice change seen only by trainee and trainer; practice outbox = what would have been sent | 239271938 |
| Training-only account | To-be account a trainer marks so every sign-in opens in training mode and cannot switch it off until released | 238747676 |
| Transportation Alert / Bus notification | BP Web post (`BusNotification`, AlertType.Bus) with Message Type template, optional Reason type and per-incident Comment; other types are School notification and General notice | 238256131 |
| Trip states (Trips SE) | Saved > Submitted > Approved > Booked > Complete; Rejected (from Submitted); Cancelled (from Submitted, Approved or Booked) | 239140908 |
| Under Stock | Inventory filter: Quantity < ReorderLevel | 239009817 |
| unified view / Gantt view / table / lens / detail / OPEN route / the board | Dispatch's one-day screens; Gantt = timeline per driver and route; table = quick-entry day sheet; lens = Driver, Bus or Route grouping; detail = how a run is covered (Open, Covering, Bus swap, Split, Double Back, Double Up, Cancelled); OPEN route = no driver in plan; the board = Reassign Dashboard page (never call it "Dashboard") | 239271938 |
| UnitDailyMax | Setting key 63, default 200: max plausible distance per day, shared by fuel entry and telemetry ingestion; unit (miles vs km) ambiguous | 238354434 |
| Unmatched fills | Proposed list where a fuel fill for an unknown vehicle waits for the fleet manager | 239403009 |
| Unplanned Rider / Wrong Run card | Today's Turns labels for a scanned student not on this run (looked up at the door) | 238845975 |
| Unrouted students | Cohort with no rule and no served grade at its school ("Students with nowhere to go"); reasons SourceClosed / AgedOutNoFeeder / DestinationNotServingGrade | 238321767, 237797385 |
| Update Subscriber job | BP Web nightly job, around 12:05 AM, that imports and prunes parent child links | 238485587 |
| Verified / per vendor | Gap-analysis tags: "verified" = checked in code at main e60a6e87, the April 2026 demo scrape, CRM or Slack; "per vendor" = busHive marketing, existence reliable but depth unverified | 238387207 |
| Visibility window | Period in which a child's scans and the bus location may be shown to parents (SY-19) | 238518317 |
| VMRS | Standard vehicle maintenance coding used across Fleet for jobs and parts | 239403009 |
| VRO | Vendor repair order: outside repair work, from which a purchase order can be made | 239403009, 238911532 |
| W01–W18 | Work items of the local Fleet build, in build order; each has an area id (F1-ANCHORS, F2-DUENESS, FR01-DUEPM, FR02-HISTORY, WARRANTY, INSP-CORE, INSP-BUILDER, DEFECT-INTAKE, NOTIFY, AUDIT, MESSAGING, PERMISSIONS, PUBLISH, TELEMETRY, VEHICLE-MAP, DOWNTIME, ATTACHMENTS, EITAS-MISC) | 238288898 |
| W11 .. W18 | Work-item ids in the Fleet change specification: W11 inspection messaging, W12 PERMISSIONS, W13 PUBLISH, W14 TELEMETRY, W15 VEHICLE-MAP, W16 DOWNTIME, W17 ATTACHMENTS, W18 EITAS-MISC (W01-W10 are on earlier pages) | 238354434 |
| Wave 6 | The local build wave that added migrations 867-878 and setting keys 82-90 | 238354434 |
| Waypoint | A point that sends the bus down a chosen road; not a stop, no riders, no time | 238551066 |
| White fleet / outside owner | Vehicles of other district departments (maintenance, IT, safety) / buses the shop keeps for another owner such as a private school | 239403009 |
| Wire keys (IC-1) | databaseGuid, staffGuid, subscriberGuid, studentGuid + SIS studentId, busId (new) + vehicleGuid / fleetVehicleId / gpsVehicleGuid, routeGuid, runGuid, runVGuid, busStopGuid, deviceId, eventId | 238321683 |
| WK-n | Weakness ids used in "Why" (e.g. WK-1 Turns does not know the driver, WK-34 offline check loses data, WK-41 one district at a time) | 238845975 |
| WK-n / DF-n / CM-n / D3 | Ids of known defects referenced from other PRD parts (workflow stress test, data-flow, Chipmunk) | 238125072, 238551066 |
| WMTS | District-hosted map tile service; GPS Live Viewer default tile path /WMTS/<location>/{z}/{x}/{y}.png | 238420013 |
| Workflow statuses (proposed product) | Submission: New, In Review, Approved, Denied (Request Changes returns it to the submitter); form: Draft, Published, Archived; eligibility: Eligible (Bussed), Walker, Out of Boundary; portal tracker: Submitted, Received, Under Review, Decision, Complete | 238911553 |
| WP-n | Work packages WP-0..WP-12 (plus WP-1a) in the implementation guide | 237928452 |
| Writer / Holder / First reviewer | Writer = who wrote the referral (driver, monitor, web staff); Holder = the one person who has taken it; First reviewer = transportation (default) or the student's school | 239108122 |
| WX-1 to WX-8 | Worked examples in §11: WX-1 three drivers out, WX-2 breakdown mid-run, WX-3 a driver's year, WX-4 rollover weekend, WX-5 to WX-8 Ride Support cases | 238419971 |
| XX-Gn / XX-Rn / XX-An / XX-QA-nnn / XX-Kn | Goal / requirement / acceptance criterion / QA test / risk IDs in a generated section; QA types are Happy, Negative, Edge, Data, Permission, Conflict, Non-functional, Connected; P1 blocks the release | 239403051 |
| Yard / Operator | Yard = where buses are kept (district word may be depot or terminal); Operator = company running a route's buses, district or contractor (meaning open, Q181) | 238551042 |
| Yard account | Shared Turns username/password per tablet or yard; names no person | 238845975 |

## 4. TODAY (verified) behaviour

Shipped behaviour as the PRD states it, at the code pins named in the header. 626 rules. The "Evidence" column is the PRD's own tag: erified = checked in code by the PRD author (not by QA), lead = strong inference, calculated = derived. Many rows are known defects; they describe what the product does today, not what it should do.

### System-wide (23)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Code pins for "today": production main e60a6e87 (2026-09-18, identical to stage b56886f9 = Clay's 2026-09-21 build) for all but Fleet; Fleet fleet-main 969d0138; Apps dev 7bfa58ff (2026-08-25); v0.20 facts at main 26919bc6 | verified | 239140866 |
| There are 7 separate sign-in systems (BP Web, Quick, Fleet, Trips, Performance Management, BPInfo REST users, T&A PIN) and 7 places a person is recorded; Chipmunk borrows the Parent Portal login | verified (map, WK-16) | 239140866 |
| 0 of 145 districts run the latest build (13.2.6.189, released 2026-09-21); median district is 28 builds / 163 days behind, furthest 57 builds / 387 days | verified (CRM telemetry 2026-09-25) | 238321683 |
| Design scale for acceptance tests: 1,300 buses, 1,200 routes (3,400 in lists), 70,000 transported students, 70,000 parent accounts in one district | verified (CRM utilization) | 238321683 |
| Scans, checks and clock-ins carry only the tablet's own clock; nothing checks it | verified (WK-46) | 239140866 |
| "Just today" ends at 23:59:59 local; the tracker splits AM / PM at 12:00 local; the tracker's in-memory swap retires after 24 hours; a held Dispatch notice expires at midnight local on the day raised | verified | 238321683 |
| Stop-to-run link (BPL_BusStopRunV) has no dates, so a dated stop change needs a new run variation; student-to-stop link is dated; parent-to-child link is GUID only with no dates | verified (memory) | 238321683 |
| A new database each school year: everything keyed on databaseGuid needs a rollover step (Miami's 26/27 database had to be re-registered in Quick) | verified (memory) | 238321683 |
| The median district is 163 days behind the latest build; Turns and Chipmunk send crash reports to App Center (retirement of App Center is assumed) | verified / assumed | 238518296, 239304705 |
| Scale reference: largest Chipmunk district 67,883 parents, busiest 30 morning minutes about 120 requests a second; largest GPS district 1,180 routes and more than 1,100 Geotab devices | stated (pilots, Q237) | 238518296, 239304705 |
| BP Unified keeps one `pln_snapshot` per day; every route, run, stop, student-stop and crew row carries its snapshot; stop rows carry `stop_planned_time` and `stop_scheduled_time` (schema v7.22) | verified | 238157830 |
| BP Unified's ETL load is incremental by time (`etl_watermark`) and does not see rows deleted in Pro | verified | 238157830 |
| For equipment BP Unified holds only `veh_vehicle.vehicle_wheelchair` (yes / no): no student equipment needs and no seats; `ta_absence` has no AM / PM period; on-time categories live in `pln_on_time_category`; personal view choices in `usr_user_preference` | verified | 238157830 |
| BP Unified's crew link `pln_employee_vehicle` holds one person per bus per day: only 175 of Clay's 260 driver-bus links fit | verified - Clay copy | 238223396 |
| BP Unified's `ta_absence` is one row per day with hours, type and approval status; `veh_employee_vehicle` carries effective and retire dates (unified schema v7.22) | verified | 238223396 |
| The Dispatch DB is rebuilt nightly from the live DB (one-way copy): anything written to Dispatch is destroyed overnight, and anything written to live during the day does not reach Dispatch or Chipmunk until the next copy | verified | 239108098 |
| The connection-string name `ConnectionString` points to a different database in each app (BPWeb -> `*_BPWeb`, BPInfo -> `*_BPWebServiceAdmin`, Dispatch -> `*BPQuick`) | corrected | 239108098 |
| No camera or video integration exists in BPInfo, the trackers or Quick | verified | 239337479 |
| BP Info, BP Web and Quick keep no student behaviour record; Pro's incident log is about staff and no row links to a student | verified — main e60a6e87; Clay copy of Pro 2026-09-29 | 239108122 |
| The new platform has no table for guardians, contacts or notifications (150 migrations checked) | verified — BusPlannerUnified | 239108122 |
| The plan's enrollment rows (pln_enrollment) come from Pro; whether they carry the SIS ID across school years is unknown (Q197) | verified / open | 239108122 |
| A platform module is one entry in the module registry (key, label, landing page, permission-prefix gate such as ta:); the rail, landing page and Access Denied all read it; a tile shows only to people holding a permission with that prefix | verified — client/src/modules/registry.ts | 238583811 |
| CC-1: the nightly copy replaces the web and Dispatch databases, erasing same-day Dispatch writes and GPS mappings; apps see a mid-year Pro change only after the nightly copies; no fault-code reader exists; a "do not drive" never tells Dispatch (CX-39) | known; not re-read | 238682115 |

### BP Pro (26)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Pro requires neither a staff number nor a unique one (13 of 557 staff in one district copy have none); Pro has no staff change log; BPL_StaffTraining has no expiry column; BPX_Incident is a staff log with no student link; layout tables are per vehicle type | verified | 238845954 |
| Pro's bell rows (`BPX_BellTime`) have no date; Pro times each PM run from its school's row picked by school, program and special ed (`CBPRunV::GetTimeFromSchool`); a dated change to a run's stops needs a new run variation | verified | 238157830 |
| Pro cannot record a driver's bus with a future date (`TBL_VEHICLESTAFF` holds vehicle, staff and stamps only) and keeps no version on a route, so the last save wins with no warning | verified - GEDI Schema_Current.cpp | 238223396 |
| Pro can auto-assign students to existing stops and bulk-create stops with the stop optimizer (Pro-only ribbon button), but neither puts the new stops on runs; unplaced students go to auto themes `sysStudentsNotAssignedToBusStops` and `sysStudentsOnNoStopSegment` | verified | 238616579 |
| A pickup stop can only go on a pickup-type run and Pro silently drops mismatches; only Home / Auto transportation types are eligible for auto-assign; AM and PM stops are separate stop records | verified | 238616579 |
| Run stop-ordering (`OneRunAlgorithm`) is one engine shared by Pro and the web (`GD_OptimizedRun_Get`); stop creation clustering exists only inside Pro's dialog code | verified | 238616579 |
| Pro's incident log (BPX_Incident, BPX_IncidentType, BPL_IncidentAttachment, BPL_RouteIncident, BPL_StaffIncident) is about staff: 4,305 rows in 12 types in one district's copy, people are typed names, route is text, none links to a student, newest row March 2021 | verified | 239337479 |
| Seating data: BPX_RunVSeatChartOptions and BPL_StudentRunVSeat (StudentGUID, RunVGUID, Row, Column, Order); options SeatChartSortOrder and SeatChartGroupSiblingsOption | verified | 239337479 |
| Equipment is one label with no size (BPX_Equipment, linked by BPL_StudentEquipment) plus one seat type per student (BPX_SeatType); vehicle types in BPX_VehicleType with seat counts in BPL_VehicleSeatType | verified | 239337479 |
| A suspension today is a free-text student property with no end date; the door (BP Info) serves the property but Turns does not read it, so a suspended rider boarding another bus is not caught | lead (property practice); verified (code) | 239108122 |
| Pro's on-time report finds no arrival unless the district has drawn school zones (COTPReport.cpp) | verified | 238583811 |
| Pro keeps seat layouts per vehicle type only, with no doors, exits, lifts or wheelchair stations | verified — CX-83 | 239403009 |
| Pro database: 321 tables at schema version 13.1 (Clay copy); one database per school year; nightly copies (_WEB for BP Web, Dispatch copy for Quick) rebuild and wipe GEO_* scopes in the Dispatch copy | verified | 238125072 |
| WK-7/WK-8: BPL_StaffTraining.Date is a completion date, but a course such as "CDL Expiration" holds the expiry date in the same field, so date + term reports expiry years late; licence expiry, MD licence, evaluation and physical expiration exist only as extended (user) properties editable in Quick that no check, picker or report reads; first-aid expiry history is missing | verified; WK-8 changed at re-check | 238682115 |
| WK-12: Pro has no "driver of this run"; a route has a bus and the bus has staff (BPL_VehicleStaff, no role or shift), so two drivers on a bus is ambiguous and a bus swap silently changes "the driver"; Fleet keeps a separate DriverVehicles link | verified data | 238682115 |
| WK-13: a person has both an Active tick and a RetireDate which can disagree; BPInfo's staff model sends Active only; Quick's edit form saves Retire Date but its list model has Active only | verified; still true | 238682115 |
| School Closure Planner sits on Analysis > School (not the Redistricting tab), is gated by Permission::AnalysisTools, is absent from GeoMap and shares no code with the Redistricting optimizer; BP Pro builds 32-bit only | verified | 238321767 |
| Closure Planner destinations are never chosen: candidates are all schools in the selected students' DistrictIDs, output has exactly two destination slots (closest, second closest; 8 columns); only control is "Do not consider affected schools" | verified | 238321767 |
| Closure Planner unconditionally skips schools that do not currently offer the student's grade and applies Regular / SpecialEd gates with no UI, so a consolidation into a school not yet configured for the grade returns empty destination columns | verified | 238321767 |
| B1: Closure Planner never selects EnrollmentGUID (comma instead of +), so programGuid is always null and every distance uses a null program, silently, even where segment programs apply | verified | 238321767 |
| B2 / B3: the Exclude flag is uninitialised and with District scope "Do not consider affected schools" erases every candidate (blank grid, no warning); with All Students scope a zero-enrollment school can be reported as a student's closest school | verified | 238321767 |
| Closure Planner silently omits students with no eligibility row, no active transport address or a null grade, and blanks rows with no geocode; no skipped count is shown (School Distance Planner does warn); a run takes about 25 minutes at Miami scale | verified | 238321767 |
| Closure Planner right-click Create Report is wrong: selecting all 8 columns gives a two-column report with student names and grades under "School" and "Distance"; selecting cols 2-7 silently drops closest / second-closest; Export (.mdb / .txt) headings are correct | verified (one path unsettled) | 238321767 |
| B5: Grade Rollover GetSchools resets every saved school rule to identity and writes it back to GradeRollover.ini, so source-to-destination school rules survive only inside the session that set them | verified | 238321767 |
| No enrollment history exists: Grade Rollover overwrites the grade in place, SIS import updates in place or deletes and inserts on a school change, students absent from the import are hard-deleted; there is no enrollment projection or feeder modelling, and school grade spans (BPL_ObjectGrade) have no dates | verified | 238321767 |
| The desktop client refuses to open a database that is not at exactly its current DB version; one upgraded workstation upgrades the live DB and locks out all older clients; protocol version is mirrored by hand in Georef.Web.Sockets | verified | 238321767 |

### BP Web (33)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Where's My Bus and Vehicle Locator ask the GPS vendor directly (GPSLocator_* settings) with their own 30-minute windows (GPSLocator_PreWindow / PostWindow); georef_Drivers copies every staff record with no role or retirement filter; a "delete existing" refresh deletes every driver-account link | verified (WK-32, WK-33) | 239173635 |
| Driver web portal (DriverMenu) has about 30 DriverSee… report switches and shows the plan only; seating chart editor draws every row as two benches of three with one dropdown per seat | verified (WK-3) | 239173656 |
| Where's My Bus and Vehicle Locator ask the GPS vendor directly (CX-54), a path the ecosystem map does not show | verified (appendix A) | 238223375, 238092292 |
| About 190 switches on five fixed role types; Global_TestModeOn is read by nothing; notice reason "Behaviour / Discipline incident" exists; seat editor draws two benches of three per row with a dropdown per seat | today's facts / verified | 238845954 |
| Post Alerts (bus, school, general notices) go to Chipmunk in-app and push, and by email when the email option is ticked; with `Chipmunk_BPWebAlertsEnabled` off the alert is saved "do not push to app" and never reaches the app | verified - Messages.aspx.cs:716 | 238223396 |
| The bus alert page opens GeoIMS before it saves anything; bus alerts reach only subscribed families, and subscriptions go stale while Update Subscribers is suspended (its default) | verified - memory | 238223396 |
| Student Ridership Report has a "Left on vehicle" flag since 13.4.0 (29 Oct, ENG-1394): boarding scan with no alighting scan, suppressed unless anyone alighted on that run that day; scan direction is inferred (ENG-1390) | released per page | 250740737 |
| Known open defect ENG-2884: "Left on vehicle" fires for children still aboard mid-run once the first child scans off (wide exposure on PM runs) | open ticket | 250740737 |
| Bus notice reasons include "Behaviour / Discipline incident" in English, French and Spanish, and nothing stops a delay notice from naming a child | verified | 239337479 |
| A run seating chart editor exists for school admins, operators and drivers (SchoolAdminSeeRunSeatingChartEditor and similar settings); it keeps the bench behind equipment empty via KeepEmptyBehindEquipment | verified | 239337479 |
| BPWeb database table prefixes are caching_, dispatch_, georef_, rcss_, ss_, surveys_, turns_ and wf_; sc_ is unused | verified | 239337479 |
| Seat layouts exist per vehicle type only; BP Web's seating editor draws two benches of three on every row and keeps the bench behind a harness empty (KeepEmptyBehindEquipment) | verified | 238125072 |
| With ParentLogin_UseBPProContacts on, parents link to children via the Pro contact email flagged "Allow portal access" | verified | 238125072 |
| Web.config carries Global_TestModeOn (False) and nothing in BP Web, Quick or the door reads it | verified (Web.config:38) | 238747676 |
| Notices can be marked as tests and hidden from public pages via Alerts_HideTestsFromPublicPages (default true); whether a test notice still sends email or push is unknown | verified (SettingDefaults.cs:237) / unknown | 238747676 |
| Local BPWeb table prefixes in use are caching_, dispatch_, georef_, rcss_, ss_, surveys_, turns_ and wf_ (tm_ unused) | verified 2026-10-08 | 238747676 |
| Role menus use <Role>See<Feature> switches (e.g. SchoolAdminSeeRouteChanges, OperatorSeeGPSVehicleMapping); settings index of 759 with groups SchoolAdminMenu 44, DistrictAdminMenu 39, OperatorMenu 47, DriverMenu 29, TransportationMenu 26, ProfessionalPortal 25, ExternalLogins 18, TwoFactorAuthentication 9 | verified (BP Web settings) | 238223417 |
| School Admins get reports and student search / listing (SchoolAdminSeeStudentSearch, SchoolAdminSeeStudentListing, both on by default) but no live bus map | verified | 238223417 |
| Driver accounts link to the Pro staff record through georef_DriverUsers (DriverGuid = staff GUID); a "delete existing" data refresh unlinks every driver account (WK-32) | verified / stress test | 238223417 |
| Where's My Bus settings: ETAInformation_Timeout default 10 minutes; GPSLocator_PreWindow / PostWindow 30 minutes | verified (BP Web settings) | 238223417 |
| WK-3: there is no driver app; off the bus a driver has only BP Web's driver web portal (about 30 DriverSee… plan reports incl. the student medical report), with no live changes, trips, timecard, training or messages | verified; still true | 238682115 |
| WK-32: "update data from BusPlanner" with "delete existing" deletes every georef_DriverUsers link and georef_Drivers row and re-inserts drivers only, so every driver portal login is empty until an admin re-links it | verified; still true | 238682115 |
| WK-33: the driver sync copies every BPX_Staff row with no role, Active or RetireDate filter, so a retired driver's portal account stays linked and can open route, student and student-medical reports; a link goes only when the staff record is deleted | verified sync; whether the login stays enabled is a lead | 238682115 |
| About 1,996 settings exist in 36 tables and files; BP Web's are in georef_Setting plus seven side tables (795 live definitions in SettingDefaults.cs); no table records who changed a setting or when | verified | 238485587 |
| Six settings districts need are not visible in BP Web: the four bus-window settings (default 120) and the two alert-comment switches (default off) live in the tracker's store; CS changes them by hand | verified | 238485587 |
| Alert comments have been in production since May 2026 but are off and invisible | verified | 238485587 |
| The driver sync (UpdateDataFromBusPlanner.cs) copies every staff member, never drops a retired one, and a "delete existing" refresh unlinks every driver account | verified | 238485587 |
| A retired driver's portal account can still open route and student reports, including the student medical report | verified | 238485587 |
| Where's My Bus asks the GPS vendor directly; taking positions from BusPlanner is the setting GPSLocator_GetLatestGPSEventFromBP, off by default | verified | 238485587 |
| A Targeted Notice goes by email and text only; it does not reach the Chipmunk app | verified | 238485587 |
| Setting ChipmunkAutoAssignParentMessages is dead: the code reads ChipmunkParentMessages instead | verified | 238485587 |
| The run seating chart editor (Operator/RunSeatingChartEditor.aspx) shows each seat as a dropdown of students on a generic layout | verified | 238485587 |
| In reports with an Operator report type, Report Type loads on --Select-- and the Operator dropdown only renders after Report Type changes to Operator; Sort By defaults to Name | stated as current | 233144322 |

### Parent Portal (4)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Since ENG-960 the subscriber import removes a child whose student GUID no longer exists in Pro and logs it; the "allow portal access" contact rule is applied only at account creation or import (lead) | verified / lead | 239173656 |
| Parent linking uses Pro contacts flagged "Allow portal access" (BP_Contact.Email1AllowPortalAccess / Email2AllowPortalAccess) with ParentLogin_UseBPProContacts | verified | 238845954 |
| WK-42: the contact rule ParentLogin_UseBPProContacts (default off) is applied only when parent accounts are created or imported; nothing unlinks a child after the contact is removed; the import prunes and logs a linked child whose student GUID no longer exists in Pro (ENG-960) | lead; prune half verified | 238682115 |
| A parent's child link is a GUID only; the nightly import (about 12:05 AM) prunes a child whose GUID vanished (logged since ENG-960), so a student re-keyed by the SIS import disappears from the parent's app | verified | 238485587 |

### Quick (39)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Quick's staff Delete removes the person from Pro and cascades through 12 foreign keys (training, incidents, attachments, audit trail); retiring closes none of the 5 sign-ins; Active tick and RetireDate can disagree (8 people in Clay) and BPInfo shares Active only | verified (WK-4, WK-13, WK-22) | 239173635 |
| A staff save sends and replaces the whole record, so a stale save deletes rows added elsewhere and can undo a retirement; every web save is stamped "Fleet - Technican Save" (WK-10) | verified (WK-9) | 239173635 |
| Expired Certifications report (PR 615) runs only when opened and ignores the licence / MD licence / evaluation / physical expiry extended properties; nothing checks expiry at assignment | verified (WK-5 to WK-8) | 239173656 |
| A view-only "Live Viewer (school)" role exists (ENG-1159): GPS+ live viewer limited to the user's BP Pro school scope; two Quick features check a role by name (Live_Viewer_View_Role_Name, Operator_Role_Name_For_Sfaff_Manager) | verified | 238321683 |
| Ridership keeps a run's scans only inside its planned window, 5 minutes before to 15 after by default | verified (Goldilox Models/RidershipVM.cs) | 239304705 |
| Quick has 39 permissions and Pro 54, with no yard scope; Quick's scopes live in the Pro database; Quick's Live Viewer setting is tied to a role's name and breaks when the role is renamed | today's facts (v0.32, v0.14) | 238845954, 238452749 |
| The Add Student to Run wizard is launched only from a student's Transportation tab and handles one student; steps: set options -> find AM stops -> create AM stop -> find AM runs -> calculate AM run, then the same for PM | verified | 238616579 |
| Wizard defaults: look for runs within 2.0 (miles for en-US / es-US, otherwise km), suggest 3 runs; the Regular / Special Ed run filters are ignored (hard-coded true, true) | verified | 238616579 |
| Quick has no background jobs and no record-level progress bar (long operations are one request behind a blocking spinner); every multi-select grid selects only the rows on the current page | verified | 238616579 |
| Run recalculation uses a pool of 5 path workers per database shared by all users; a drained pool returns null; monitoring endpoints `/PathWorker/Stats`, `/PeakWorkerUsage`, `/WorkerCountSufficient?threshold=0.8` | verified | 238616579 |
| Known bugs in the wizard: `GetRunStops` has no permission check (B2); an unparseable effective date silently becomes null (B5); saving a new stop does no duplicate or required-field check (B9); stop order is supplied by the browser | verified | 238616579 |
| Student-to-stop assignments are effective-dated and the system may push the requested start date later (business-day delay settings, or later address / enrollment start); stop-to-run links are NOT dated and take effect immediately on the current run variation | verified | 238616579 |
| Latitude / longitude from the new-stop form are parsed with invariant culture so French comma decimals work; session state is StateServer | verified | 238616579 |
| UI strings come from `Translations.csv` (UTF-16 LE with BOM, no header, exactly 4 fields ResourceSet,ResourceId,Language,Value; rows with another field count are silently skipped; an `en` row is the fallback for all languages) | verified | 238616579 |
| Quick log convention: `Category.Student` when student data is viewed or changed (with search criteria), `Category.General` for other changes; errors go separately through `LogErrorVM.Save` | verified | 238616579 |
| Quick's forms module has `fm_Item.IsNonOperable` and `fm_Item.IsFailure` since its migration 55, rolled up to `fm_Result.IsOperable` / `HasFailure` | code-read W07 | 238845996 |
| Forms module item data types are INFO, TEXT, NUMBER, PICKLIST (no boolean); consumers compare case-insensitively and the handler stores data_type without validation | fact-check correction | 238354434 |
| Staff Manager has an Expired Certifications report (PR 615) that reads training rows only; it does not read the licence / MD licence / evaluation / physical expiry extended properties (PR 590, PR 863) | verified at main | 238321704 |
| Nothing warns and nothing blocks when a credential lapses; the report shows lapsed courses only when someone runs it | verified at main | 238321704 |
| Training rows (BPL_StaffTraining) hold Date and Notes only, no expiry column; course term lives in BPX_TrainingType.Term; credential expiry fields are in BPL_StaffUserField | verified (district copy) | 238321704 |
| In one district copy 191 of 235 "CDL Expiration" rows are future-dated because the expiry is typed into the completion date; 155 active drivers have lapsed CPR or First Aid, 86 a lapsed annual medical, 81 no training rows | verified (district copy, WK-6..WK-8) | 238321704 |
| Active and RetireDate can disagree on a staff record (8 staff in one copy); Delete wipes 12 tables of history; retiring a person closes no access (SY-23) | verified per page Why section (status of each sub-claim not separately tagged) | 238321704 |
| Ridership report needs a route and a run, skips Saturdays and Sundays, and finds scans by the route's mapped buses within the run's times plus a 15-minute buffer (WK-30) | verified | 238223417 |
| Ridership judges every past day against today's riders, so history after a split / merge no longer follows the student (WK-44) | verified (stress test) | 238223417 |
| Ridership reads no "scans on/off" setting, so in a district that does not scan every student looks unscanned (WK-40) | verified (stress test) | 238223417 |
| Ridership has a week limit flag (ExceedsWeekLimit) on the date range | verified | 238223417 |
| Since PR 966 (main, 2026-07-10) Ridership uses the GPS mappings in effect on the report date and falls back to the most recently retired one with a warning, so a swapped bus's scans no longer vanish after midnight (WK-31 fixed); ENG-1409 filters were reverted and are not in production | verified | 238223417 |
| The view-only Live Viewer (school) role shows only routes in the user's BP Pro school scope and fails closed (no scope = no routes) (DispatchGPSLiveViewerVM.cs:142-179; ENG-1159); no ETA, no boards, no phone | verified | 238321704 |
| Students are added to runs one at a time (CX-51) | page states as today (tag only on the bulk-add spec) | 238321704 |
| BPL_VehicleStaff has no role column and view BPV_RouteDriver keeps only staff with the Driver role, so a monitor assigned to a vehicle never shows as crew (69 vehicles in one copy carry two or more staff) | verified (district copy) | 238321704 |
| Quick has 51 controllers / tools incl. GPSLiveStatusViewer, GPSHistoryViewer, GPSPathCompare, GPSBusStopCompare, FindRouteChanges, Ridership, DispatchGPSLiveViewer, DispatchReassign, AddressEligibility; computer only | verified (census) | 238223417 |
| Quick checks three permission kinds: module (DISPATCH, GPS, RIDERSHIP, FINDROUTECHANGES, STUDENT, ROUTE, RUN, SCHOOL, BUSSTOP, TRANSFER, VEHICLE, EXCEPTION, STAFFMANAGER, FORMS, ADDRESSELIGIBILITY), action (STUDENT_MODIFY, RUN_MODIFY, SCHOOL_MODIFY, STAFF_MODIFY…) and Pro permissions BPProPermissions (FindObject, RouteManagement, OptimizationTools, GpsManagementTools, AddRunRoute, DeleteStop, AlterRouteChange) | verified (Goldilox Enums.cs) | 238223417 |
| Every Quick list checks scope row by row (IsStudentInScope, IsRouteInScope, IsRunInScope, IsBusStopInScope; IsDistrictInScope, IsOperatorInScope) | verified (census) | 238223417 |
| WK-5: training rows (course, date, note) live on Pro's staff record (BPL_StaffTraining) and are edited in Quick's Certifications tab and Fleet's user page and shown in BP Web; the Training Tracking module is a browser prototype (localStorage) that shares nothing; Trips and T&A keep their own people | verified; still true | 238682115 |
| WK-6 (P1): nothing warns about expiring training or blocks an expired driver in Dispatch, Trips, Subs or Turns; Quick's Staff Manager has an Expired Certifications report (date + course Term) that reads training rows only, not the licence/medical expiry fields | verified; re-check changed (report added) | 238682115 |
| WK-22 (P1): Quick's staff Delete removes the person from Pro and the database cascades away training, accidents, incidents, attachments, comments, contacts, roles, bus links and the staff audit trail (12 cascading tables); GEO_UsersScopeStaff rows are left dangling | verified; still true | 238682115 |
| WK-30/WK-31: Ridership needs a route and a run (no student, bus, school or group start), skips weekends, finds scans by the route's mapped buses within the run's times plus 15 minutes, and says a range over a week is available through Excel export; WK-31 is FIXED (ENG-718): it uses the GPS mappings in effect on the report date, else the most recently retired mapping with a warning | verified; WK-30 still true, WK-31 fixed | 238682115 |
| WK-40/WK-44: Ridership reads no "scans on/off" setting so a non-scanning district shows every student unscanned; it loads the roster once from today's plan and scores every past day against it, so history is lost after a split or merge; Quick can print a QR code for a student's scan card (ENG-720); ENG-1409 shared Ridership filters were reverted and are not in production | verified; still true | 238682115 |
| Depot users normally see only their own depot's routes and runs; with all-operator access nothing is pre-selected on the Reassign Dashboard Operator filter; users are configured separately in Quick (User Access) and BP Web (User Manager) | stated as current | 233144322 |

### Dispatch (Old World) (87)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Since 2026-09-18 every Dispatch save writes held rows (one group per save) to the DispatchNotification ledger; nothing goes to parents until the dispatcher sends the group from Send Run Changes; only the author can send | verified (ENG-1616) | 239173656 |
| A later save on the same stop marks the earlier held row "Replaced"; a group nobody sends expires at midnight, is never sent, and nobody is warned | verified | 239173656 |
| At send the tracker is asked first, then email queued; each channel keeps its last failure and a retry queues only what is missing; a change under the time tolerance or identical to the minute gets no row and no notice | verified (D1, D4, D5 fixed) | 239173656 |
| Run reassigns, Modify Runs time edits, merges and splits raise notices; driver and vehicle substitutions raise none by design, so a bus swap tells no family | verified (DF-1 fixed, WK-48) | 239173656 |
| The parent message is built in the sending dispatcher's language and the default text calls every change "temporary", even a "From now on" change; SMS is not implemented | verified (WK-45) | 239173656 |
| "Dispatch - Disable Parent Emails" turns the district's Dispatch emails off while the app push stays; no pushes are sent on weekends (DF-2); a tracker restart re-sends every active notice (DF-4) | verified (ENG-1406) | 239173656 |
| Open swap defects: a tracker reading the live DB loses the swap at the next mapping poll (within 5 minutes, DF-10); a driver's Turns run-level mapping beats the dispatcher's route-level override (DF-11); a driver-only change sends an empty vehicle, logged as a failure (DF-12); "bus changed" message names the GPS unit, not the bus | verified | 239173656 |
| The Dispatch DB is deleted and rebuilt from live Pro every night, wiping same-day Dispatch writes and set-up (e.g. 80+ Clay GPS mappings); a failed refresh leaves an old plan with no warning; a tracker not restarted after the 12:30 AM refresh refused merges with HTTP 406 (ENG-1994) | verified | 239173635 |
| Dispatch's driver picker lists everyone with the Driver role, retired or not, and never checks training (Clay copy: 126 retired or inactive offered; 155 active drivers with lapsed CPR / First Aid); monitors on the same vehicle never show | verified (WK-6, WK-11) | 239173656 |
| Merge and split check none of: equipment, seats, school boundary, dead ends, operator, timing, version | verified (WK-37, WK-38, WK-47) | 239173635 |
| Production holds every Dispatch parent notice until the dispatcher sends it (Send Run Changes, ENG-1616); a group nobody sends expires at midnight (D1, D4, D5, DF-1, DF-6 fixed) | verified (production re-check) | 238092292, 238845954 |
| Still open in J3: D2, D3, DF-2, DF-3, DF-5; a Dispatch change has no path to the driver at all (drivers hear by phone) | gaps today | 238092292 |
| A dispatcher's bus override silently loses to the tablet (DF-11); DF-10 to DF-12 open (a swap may revert within 5 minutes, DF-10); DF-7 to DF-9 fixed | verified (stress test S2) | 238092292, 238419971 |
| Parents get no message for a bus swap (WK-48); merge notices go only if the dispatcher presses Send, in the sender's language, worded "temporary" | verified (stress test S2, §3.3) | 238092292, 238419971 |
| A merge runs no safety checks (a rider needing a lift can be moved to a bus without one); bus picker still offers a bus that failed its check; driver picker offers retired drivers and ignores training | verified (stress test S2, §3.3) | 238419971 |
| Dispatcher roles / scopes set in the Dispatch copy last one day because the nightly copy rebuilds its security tables; they must be set in the live Pro database | verified (stress test S3; memory) | 238419971 |
| Dispatch names a route's driver from Pro BPL_VehicleStaff via BPV_RouteDriver and GeoIMS GetRouteDriver, Driver role only; no GPS reader passes a driver | verified | 238845954 |
| Today's Dispatch does not log merges, splits or optimizes; Quick's optimizer gets a run's stops without waypoints and removes waypoints without asking | stated as today (rejected options, Q151, decision 2026-10-20) | 238452749, 239304705 |
| Today's Dispatch runs on a copy of Pro rebuilt every night (GEDI `CopyDatabaseSqlToSql`; a 2 AM task at St. Johns, ENG-2403), so the day's work is wiped and nothing can be planned for a later day; no past day can be opened as it ended | verified | 238157830 |
| A failed nightly rebuild left St. Johns on an old plan with no warning from 9/22 to 10/2 | verified - SY-24 | 238157830 |
| After a merge or split, today's Optimize leaves the stop times "Not set"; St. Johns saw push-notice times up to 30 minutes off and stopped sending them from Dispatch | observed | 238157830 |
| Today's Dispatch sends a merge to the tracker for it to import; a tracker refused merges at Clay with a 406 (ENG-1994) | verified | 238157830 |
| Dispatchers work across 2 to 4 screens to cover a call-out (Dispatch plus GPS vendor site, BP Web for alerts, a spreadsheet) | observed | 238157830 |
| Send Run Changes holds every Dispatch change in a ledger until the dispatcher sends it (in production at `main`; Clay since 2026-09-21) | verified - stress test §3.3 | 238223396 |
| A held group nobody sends expires at midnight unsent and nobody is warned; the ledger records state `Expired` | verified | 238223396 |
| Only the dispatcher who made a change can send its held group; a colleague's send is refused | verified | 238223396 |
| The parent message is built at send time in the sender's language and calls every change "temporary" | verified | 238223396 |
| Known defect: splitting a run into two new runs (Clay WESP-02) produces one Send Run Changes row named for one run and carrying the other's route; fix branch ENG-2096 not merged | verified - photos 2026-09-23 | 238223396 |
| Moves check nothing: equipment, seats, boundary, dead ends, operator, stops already served (WK-37); merges are not all-or-nothing (WK-29) | verified | 238223396 |
| Two dispatchers can overwrite each other's run edits (WK-38); their held notices replace each other but the run edits do not | verified | 238223396 |
| A bus swap tells the app (DF-7 to DF-9 fixed since September) but no family gets a message (WK-48); a tracker on the live database loses the swap within 5 minutes (DF-10) | verified | 238223396 |
| The driver picker offers retired and inactive people (126 of 381 in the Clay copy) and never checks training (WK-11) | verified | 238223396 |
| The nightly copy wipes same-day work in the Dispatch database (80+ Clay GPS mappings lost in one day) and rebuilds its security tables, so Dispatch roles set up there last one day | verified - Slack 2026-08-12 / memory | 238223396 |
| Held groups live in Quick's own database and survive the nightly copy; plan changes in the Dispatch database do not | verified - migration 57 notes | 238223396 |
| When the tracker refuses the push at send, the app side stays held with the tracker's reason and the email side can still go | verified | 238223396 |
| A stop-time change smaller than the tolerance (`GetStopTimeChangeToleranceSeconds`) creates no row and no notice; the save notice counts it as "not reported" (`StopChangesNotReported`) | verified | 238223396 |
| Setting "Dispatch - Disable Parent Emails" (`Disable_Parent_Emails`, default off; on = no email) covers email only, not push; a notification-retention-days setting exists (ledger limit described as 30 days) | verified - catalogue | 238223396 |
| The ledger actions exist as Quick page actions `GetHeldNotifications`, `ReleaseNotifications`, `SetGroupMail`, `GetGroupMessages`; access checks use `HasAccessToReassign` and `BPProPermissions` | verified | 238223396 |
| Quick's Optimize returns the new order, each stop's time and the path without saving; the save is the separate Apply (`OptimizeRuns` -> GEDI `Dispatch_OptimizeRuns`) | verified | 238223396 |
| Quick's Optimize removes waypoints and turnarounds (stop types 6 and 7) without asking | verified | 238223396 |
| Run Console time change (`ApplyTimeChange`): a pickup (to-school) run is end-locked, so the changed stop and those before it move; any other run is start-locked, so the stops after move | verified | 238223396 |
| Retime and Optimize on a large run in the live database can take about 45 seconds | status unclear (stated as fact) | 238223396 |
| "May miss the bell" thresholds exist in Quick as `DisPatch_Late_Bus_Threshold_1` and `_2` | verified - catalogue | 238223396 |
| Dispatch cannot post a transportation alert; alerts are posted only in BP Web | verified | 238223396 |
| Families on a run whose planned end has passed hear nothing of a change today, even if the run is late and still on the road (prototype ChangeEngine behaviour, Q243) | verified - prototype only | 238223396 |
| Every dispatch save (Merge / Split / Reassign) notifies parents at once: `SaveLogs` writes one notification row and one queue job per affected bus stop (or one run-level entry if none), so a 25-stop run gives 25 separate emails; there is no draft, hold, de-duplication or collapsing | verified | 239108098 |
| Dispatch change notifications go out by EMAIL only from the Subscription Service; SMS and push queues have no ReassignNotification case and report success without sending | corrected | 239108098 |
| A dispatch change reaches parents over two unrelated channels: email (server side, from the save) and Chipmunk push (browser calls the Chipmunk tracker `UpdatePlannedInfo` with NotifySubscribers=true, push in about 2 s) | verified | 239239170 |
| The browser call that refreshes tracker planned data is fire-and-forget and silently skipped when `TRACKER_API_STATUS` is false, the access token is empty, or the Chipmunk tracker is disabled; the flag is only set true on page load, so logging out and in of Quick is the known workaround (D6) | confirmed in code | 239239170 |
| D1: the 60-second stop-time tolerance is declared but never applied; any stop-time difference at all (even 1 second after a recompute) emails every parent on the run | confirmed in code | 239239170 |
| D2 / CC-3: only 4 of 24 dispatch actions write a Quick log line (Reassign, ReassignRouteSave, ReassignRunSave, AddOrUpdateGPSVehicleAssignment); MergeRunSave and SplitRunSave email parents but leave no Quick log line; OptimizeRuns, CreateNewRun, CreateNewSchoolStop, RemoveAddedSchoolStop log nothing; ReassignRouteSave writes a log line but no notification row | verified | 239108098 |
| D3: in Merge Runs the change logs are matched by BusStopGUID only, so a stop present on more than one merged run gets the "new time" of the last run processed and a parent can be told a time that belongs to another run | confirmed in code; root cause of the incident not proven against live data | 239239170 |
| D4: parent emails are queued before the tracker update is attempted; if the banner "Error trying to update Dispatch Tracker Service" appears, the merge is already saved and parents are already emailed, with no rollback or retry | confirmed in code | 239239170 |
| D5: redoing the same merge re-emails every parent (no idempotency key or supersede); interim advice to districts is not to redo a merge after the tracker error banner | confirmed in code | 239239170 |
| D7: the Dispatch tracker and Chipmunk tracker calls share one error banner and a success clears it, so whichever returns last decides what the dispatcher sees | confirmed in code | 239239170 |
| DF-1: Reassign Run (`ReassignRunSave`) queues notifications with an empty subject and body, so the email job throws "notification subject or body is not set" on every poll for about 10 minutes and no reassign-run email is ever delivered | verified (P1) | 239108098 |
| DF-2: dispatch-change pushes notify nobody on Saturday or Sunday (`Schedule.IncludesDay` returns false for weekends); email has no day filter | verified | 239108098 |
| The parent email body starts "We would like to inform you of a temporary change regarding to your child's bus route." and can contain only three sentences (route, vehicle, stop time, times as `hh:mm tt` e.g. 05:58 AM); there is no run-change or driver-change sentence | verified | 239239170 |
| Email recipients are resolved at send time by a live query, but subject and body are frozen at edit time | verified | 239108098 |
| In `dispatch_ReassignNotification` the Run, Driver and GPS-vehicle columns are never written and Route is blanked when unchanged; `NoEmail` / `NoSMS` / `Test` are never set, so there is no per-action "do not notify parents" switch | corrected | 239108098 |
| There is no cancel or "send now" for pending notifications in the Dispatch UI; a ReSend control exists only in BPWeb `EmailNotificationManager.aspx` and `PushNotificationManager.aspx` | verified | 239108098 |
| The Reassign Dashboard lists drivers only through a route and only runs operating today, so a sub driver with a bus but no route does not appear; depot is never shown (lookup commented out) and user scope is not applied to the list | verified | 239108098 |
| A GPS vehicle substitution from the Substitute GPS Vehicle tab or GPS Live Viewer (A1/A2) writes the Dispatch DB only, retires at 23:59:59 today (hard-coded), does not notify parents and logs no vehicle id; Reassign Route/Driver (A3) does notify parents; the GPS Vehicle Assignments admin screen (A4) is the only path that writes both live and dispatch DBs and logs vehicle ids | verified | 239108098 |
| Today's Dispatch logs 3 of its 20 or so actions; merges, splits and optimizes write nothing (DispatchReassignController.cs, main b35e729c) | verified | 238583811 |
| "Do not drive" never reaches Dispatch, which keeps offering the bus (CX-39) | verified | 239403009 |
| DispatchReassignController has 24 actions and DispatchGPSLiveViewerController 18 (Reassign, ReassignRoute/Run + Save, MergeRunSave, SplitRunSave, OptimizeRuns, CreateNewRun, CreateNewSchoolStop, AddSchoolStopList, RemoveAddedSchoolStop, GPS vehicle assignment, mapping suggestion, ReassignedRoutePrint) | verified | 238223417 |
| SplitRunSave always creates a new run first; MergeRunSave takes each run's new stop list plus stops to remove for up to three runs and deletes a run only if it ends up empty; neither is all-or-nothing (WK-28, WK-29) | verified | 238223417 |
| Change types exist for temporary substitution, permanent change and make temporary (TemporarySubstitution, PermanentChange, MakeTemporary) | verified (Enums.cs) | 238223417 |
| Since 2026-09-18 every change is held in the Send Run Changes ledger until the dispatcher sends it; a send writes log lines, but merge, split and optimize write no audit line of their own (CC-3) | verified at main e60a6e87 | 238223417 |
| The Dispatch engine runs none of the safety checks (lift / equipment, seats, school boundary, dead ends, operator, stops already served, concurrent change) before a move (WK-37, WK-38) | verified (stress test) | 238223417 |
| A dispatcher's swap reaches the Chipmunk tracker (DF-7..DF-9 fixed, substitution tab pushes at save) but the next poll can discard it on a tracker reading the live database, and a driver's mapping silently outranks it (DF-10, DF-11 open; CX-18) | verified at main 2026-09-18 | 238223417 |
| Dispatcher work lives in the Dispatch database which the nightly copy rebuilds, erasing same-day Dispatch work (CC-1) | verified | 238223417 |
| WK-11: the Dispatch driver drop-down lists everyone with the Driver role limited only by operator and scope, ignoring Active, EffectiveDate, RetireDate and training (126 of 381 in the anonymised copy were retired or inactive) | verified; still true | 238682115 |
| WK-28: Split creates the new runs first and then moves the stops with no transaction, so a failed move leaves empty runs behind | verified; still true | 238682115 |
| WK-29 (P1 worst case): Merge updates each run in turn with no transaction, so a mid-way failure can leave a stop on both runs or neither with no change logs; since ENG-745 a merge completes even when the deadhead re-check after deleting the empty run fails | verified in code; still true | 238682115 |
| WK-37 (P1): the merge/split engine has no equipment (lift, wheelchair, car seat, harness), seat-capacity, school-boundary, dead-end, operator or already-served-stop check; the only validation is the web page's "at least two stops" rule | verified absence; still true | 238682115 |
| WK-38: there is no version or modified-date check on a run, so the last save wins silently; held notices no longer double up because a later save on the same stop supersedes the earlier held row | verified absence; changed in part | 238682115 |
| WK-39: dashboard pages check the Reassign permission and redirect, but the Merge/Split/reassign save actions throw before their error handling, so a user without Reassign gets a raw server error | verified in code; changed in part | 238682115 |
| WK-47: a "just today" GPS assignment retires at 23:59:59 whatever time it was made; the tracker's own copy of a substitution lasts 24 hours; the nightly copy erases same-day Dispatch writes (CC-1) | verified; still true | 238682115 |
| WK-45: the parent change message is built at send time with the sending dispatcher's translator, so every parent gets the sender's language; the default body says "a temporary change" even for a permanent change and ends "Thank /you." | verified; re-check changed (built at send, not save) | 238682115 |
| WK-48 (P1): Substitute GPS Vehicle and Reassign Driver write no change log, so no parent email; a reassign's "bus changed" sentence names the GPS vehicle ID, not the bus number; the substitution does now reach the Chipmunk tracker at save (UpdatePlannedInfo, ENG-1371) | verified; changed in part; push for a vehicle-only change is a lead | 238682115 |
| Send Run Changes: each save writes one group (one row per stop worth telling) to the Quick-DB DispatchNotification ledger; nothing is sent until the dispatcher sends it; only the dispatcher who made the change can send; unsent groups expire at midnight and are never sent; at release the tracker is asked first and the email queued only after it accepts; each channel keeps its last error (MailError, PushError) | verified at main | 238682115 |
| D1/D4/D5/DF-6 fixed: a stop change under the StopTimeTolerance setting, or rendering the same to the minute, gets no row and no notification and is counted as "not reported" on save; a retry queues only what is missing; an empty subject or body queues nothing | re-check: fixed | 238682115 |
| "Dispatch - Disable Parent Emails" turns off every Dispatch email for the district while the app push remains; Modify Runs time edits raise a notification (DF-1 fixed); a driver-only change posts an empty vehicle, the tracker answers 400 and it is recorded as "AssignVehicleToRoute failed" (DF-12); reassign saves are no longer blocked by a tracker that is down | verified at main | 238682115 |
| D2/CC-3: a release writes Quick log lines (22 logger calls in the controller, was 4) plus a ledger row per held change, but merge, split, optimize and the school-stop actions still write no audit line of their own; SMS for Dispatch changes is not implemented | re-check: changed | 238682115 |
| A swap notification to the Chipmunk tracker never ran because of a session-key typo in duplicated server code, with nothing logged (DF-7, DF-9); fixed September 2026 | verified | 239403051 |
| On the anonymised Clay copy Dispatch offers 126 retired or inactive people in its pickers | verified (baseline in BI-A5) | 239403051 |

### Dispatch (New World V1) (2)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| New World Dispatch talks to neither the tracker nor Turns, so its changes do not reach tablets or the parents' app; its Save keeps a snapshot that resets overnight and never reaches Pro | stated as today (Q168, decision 2026-10-07) | 239304705 |
| Dispatch sits on the platform rail today as a disabled "coming soon" tile (Sidebar.tsx:194) | verified | 238583811 |

### Chipmunk (61)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Chipmunk stores one Quick Code and one district address, so a parent with children in two districts must set the app up again to switch | verified (WK-41) | 239173656 |
| The bus shows for a window around each run set by four tracker settings (BusPositionWindowAMBefore / AMAfter / PMBefore / PMAfter, minutes, default 120 each); the descriptions of PM-before and AM-after are wrong; ChipmunkShowBusLocation is district-wide on/off | verified (tracker migration 84) | 239173635 |
| Alert comment and reason reach the app and push only when tracker settings ShowAlertReasonType and ShowAlertComment are on (both default off, not shown in BP Web); the push repeats the whole notice and tapping it does not open Alerts | verified (PR 713) | 239173656 |
| "Bus is near" fires even when the bus is not running that run and supports a radius only; ETA can freeze (DF-13 to DF-17); parents cannot choose email categories; no "not riding today"; no contacts screen | verified (REQ) | 239173656 |
| A refresh closes the rows a parent opened on the ETA screen | verified (Apps dev 7bfa58ff) | 238845954 |
| No boarding code in the app (CM-4); the app keeps no read state for alerts (CM-8.7); parents' child links break at rollover; email notices are all or nothing; an email the district has not linked signs in to an empty list with no reason | gaps today | 238092292, 239304705 |
| Morning-run gaps: drivers cannot map their own bus, ETA may be stale, "bus is near" fires for the wrong run; in a breakdown parents watch the dead bus with a frozen ETA | gaps today / verified (stress test S2) | 238092292, 238419971 |
| ETAs are gated by the tracker setting `ShowETAsInApp` (default true), not by BPWeb `Chipmunk_HideETAs` (default false, only app-side hiding and radius push wording); nothing syncs the two | corrected | 239108098 |
| "Too far" is returned when the last GPS event is more than 3220 m (2 mi, hard-coded) from the stop, and also as a stand-in when `ShowETAsInApp` is false; the reason named OneHourUntilRunStart really means within 360 minutes | corrected | 239108098 |
| ETA window per stop is 20 minutes before to 240 minutes after the planned time (`BusStopWindowStartTime` 20, `BusStopWindowEndTime` 4 hours, tracker store) | verified | 239108098 |
| The scheduled stop time and run start time (`PlannedStopTime`, `PlannedRunStartTime`) are already in the ETA2 response; school arrival is only an English string with two different prefixes ("Planned time:" / "Scheduled time:") | verified | 239108098 |
| Flipping `ShowETAsInApp` stops ETA calculation within 30 minutes but `ETA2/Get` keeps its old behaviour until the tracker service restarts (static cache never reset) | verified | 239108098 |
| Defaults: `ChipmunkRefreshRate` 60 s; `ChipmunkDefaultRadius` 1500 m (seed for new subscribers only); `CutOffNotificationsRadius` 200 m is the run-completion detector (bus within 200 m of every stop ends ETAs and notifications), not the "bus is near" trigger | corrected | 237928452 |
| The radius ("bus is near") push fires when the straight-line distance crosses inward through the parent's own radius, with no check that the bus is driving that run; real false triggers: midday bus near an uncompleted AM stop, bus parked near a later run's stop when its window opens (first event forces previous distance to 10000 m and notifies every radius under 10 km), shared corner with two stop records, GPS gap; an AM bus passing a PM stop does NOT trigger | verified | 239108098 |
| The ETA is a shortest-path on BusPlanner's own street graph from the bus to the stop as if driving straight there: it ignores remaining stops and dwell (optimistic), uses base segment speeds (time-of-day speeds and vehicle size are not applied) and no third-party routing | verified | 239108098 |
| DF-13 / DF-14: when routing fails or the bus position cannot be attached to the network the previous ETA stays displayed as current (no timestamp, no age gate); there is no off-path detection on the live ETA path | verified | 239108098 |
| DF-4: a tracker restart (or a failed notice import) re-pushes every still-active notice to every parent; notice import runs 2 minutes after startup | verified | 239108098 |
| A parent's geofence is one integer radius per (subscriber, student, stop-on-run) with no uniqueness constraint; saving settings deletes any stored fence missing from the posted payload | verified | 239108098 |
| Email opt-out today is the single `ReceiveEmail` flag enforced in four separate recipient paths; push preferences (alert, radius, radius unit, ridership, OneSignal subscriptions) live in the tracker; subscribers auto-created at SSO login get ReceiveEmail = false | corrected | 239108098 |
| A boarding scan resolves only through `BPX_AVLScanCardStudent.ScanCardID` (never StudentID) at three independent points; with no match the scan event is still written ("No matching scan cards found"); a retired card resolves on the tablet but produces no parent push | corrected | 239108098 |
| Minimum app build is a compile-time constant (2023103101 for Android and iOS, format yyyyMMdd##); a setting the app already reads can be flipped per district with no app release, a setting the app has never seen needs one | verified | 237928452 |
| Parent messaging is a pull-only inbox (`georef_ChipmunkMessage`) with no push in either direction; its Save endpoints are HTTP GET; the auto-assign setting `ChipmunkAutoAssignParentMessages` is effectively dead | verified | 239108098 |
| `Notifications_AllowCommentsSeenByPublic` defaults to false; the app (release 2.11.2 and later) already renders alert comment and reason fields but the server does not send them | verified | 237928452 |
| No push is ever sent from a Debug build of the tracker (`#if DEBUG` returns before the OneSignal POST) | verified | 237928452 |
| One app binary serves every district; `ClientEndpoint/GetClientEndpoint(clientCode, applicationGuid)` returns the district tracker endpoint and OneSignal app id, gated by a per-district entitlement check | verified | 238878722 |
| With no live ETA and before the run starts the ETA row shows "Bus Route starts at <run start time>", and shows it as an error once that time has passed | verified | 238518317 |
| The ETA card never shows the student's own stop name or its planned time; it shows the school and the school's time, labelled "Planned time:" when stops are within two hours and "Scheduled time:" otherwise, so the same label means arrival (AM) or departure (PM) | verified (screenshots + code) | 238878722 |
| ETA unavailable reasons sent to the app include TooFarFromBusStop (bus more than 3220 m / 2 mi from stop, also used when district hides ETAs), RunHasStartedButNotBusStop, OneHourUntilRunStart (actually fires at 360 minutes), NotScheduledToRun, BusNotReporting, RouteFinished, StopServiced | verified | 238878722 |
| A failed or empty routing call leaves last cycle's ETA marked available; ETA2 carries no timestamp or age gate, so a frozen ETA is served as current (CM-6.1) | verified | 238878722 |
| Parent ETA is bus-to-stop shortest path on BusPlanner's own street graph (no third-party routing); it ignores remaining stops and dwell, does not use time-of-day speeds or vehicle size, and off-path codes 11/12 are never set | verified | 238878722 |
| "Bus is near" is a straight-line inward crossing of one integer radius per subscriber/student/stop, with no check that the bus is driving that stop's run; a parked or other-run bus can trigger it; a 20-minute look-ahead stops a morning bus triggering afternoon stops | verified | 238878722 |
| "Bus is near" keeps firing for a stop the child no longer uses: the app never removes old stops from its saved radius list and the tracker does not check current stop use (SPT-855, ENG-2260, ENG-1547) | verified | 238518317 |
| In route subscription mode (BP Web default) an alert tagged with one run goes to every family on the route (SPT-854) | assumed (read in code) | 238518317 |
| A stop time fixed in Quick's Runs screen after a Dispatch change was sent never reaches the app: no tracker call, no notice queued (PROD-515) | verified | 238518317 |
| When the tracker's day has no linked student the ETA screen says "Student information unavailable" (many parents after a failed nightly copy, a few after a re-key) | verified | 238518317 |
| Dispatch-change pushes are not sent on Saturday or Sunday (schedule check returns false for weekends); email subscribers are still told (DF-2) | verified | 238878722 |
| A tracker restart or one failed poll can re-push every active notice to every parent; no collapse id or idempotency key (DF-4) | verified | 238878722 |
| App text exists in English, French and Spanish only, best-matched per request; server pre-formatted strings are English only | verified | 238518317 |
| Auto-refresh is on by default and runs every `ChipmunkRefreshRate` (default 60 s); each refresh rebuilds the list and closes any row the parent opened | verified | 238518317 |
| A district setting change the app already reads takes effect within about 5 minutes with no restart (BP Web 5-minute settings cache); a setting the app has never seen needs an app release | verified | 238878722 |
| Force-upgrade gate `MinimumVersion/Get` compares against compile-time constants 2023103101 for Android and iOS (build format yyyyMMdd##); raising it needs a tracker release for all districts | verified | 238878722 |
| Server sends latitude/longitude 999 and heading -1 when there is no GPS fix; `DefaultRadius` seeds new subscribers only | verified | 238878722 |
| Per-parent push preferences exist (AlertNotifications, RadiusNotifications, RadiusUnitMetric, RidershipNotifications, RadiusDistance) via `UserSettings/Update`; no per-category email preference exists; subscribers auto-created at SSO login have email off | verified | 238878722 |
| Login supports email/password, OIDC and up to three SSO providers (Microsoft Entra present), all district-configurable; auth is a subscriber-role bearer token | verified | 238878722 |
| A parent whose sign-up email does not match the SIS contact email allowed portal access signs in to an empty student list with no reason shown | verified (support case) | 238518317 |
| A Transportation Alert's Comment is saved and included in subscriber emails only when `Notifications_AllowCommentsSeenByPublic` is on (default false); it never reaches the app push, Alerts list or detail because the tracker wire model and Alert DTO (Id, Title, Message, Posted, Type) do not carry it | verified | 238256131 |
| Alert push heading is RouteId/RunId and body is the Message Type translation (en/fr/es); the push has no data payload, and tapping it only refreshes with no navigation; no read/unread state exists | verified | 238256131 |
| An alert with `DoNotPushToApp` ticked is filtered at the REST feed, so it appears in neither the push nor the app list; the tracker polls the feed every 1 minute by default (10 s floor, `NotificationUpdateFrequency`) | verified | 238256131 |
| App builds on release branches 2.11.2 and later already model and render alert Reason and Comment in the alert detail popup (Apps PR 714, 2026-06-04); whether the published store build has it is unconfirmed | verified (branch), store build unverified | 238256131 |
| School notifications and General notices have no comment field anywhere | verified | 238256131 |
| Scan notifications (push when a student scans) shipped in Chipmunk 2.10.4; only students with a physical scan card can be scanned | stated by staff, not code-verified | 238518338 |
| A scan resolves to a student only by matching `ScanCardID` in `BPX_AVLScanCardStudent`; the stored scan event has no student column; some districts have no scan cards provisioned | verified | 238878722 |
| `ChipmunkMessage/Save` is an HTTP GET with the message body in the query string | verified | 238878722 |
| Settings the app reads today: `ChipmunkShowBusLocation`, `ChipmunkShowStudentScans`, `ChipmunkShowStudentSeat`, `Chipmunk_HideETAs`, `ChipmunkRefreshRate`, `Chipmunk_BPWebAlertsEnabled`, `Notifications_AllowCommentsSeenByPublic`, `Chipmunk_ChatbaseURL` (empty = chatbot off) | verified | 238518317 |
| Mobile clients find production: the app asks a central lookup for the district endpoint, so a locally built app showed live production data | verified | 239075352 |
| Chipmunk has a phone demo mode (demo Quick Code, DemoModeData) with made-up children and ETAs that writes nothing | verified (XamSettings.cs:44, TrackerSettings.cs:259) | 238747676 |
| Home page is chosen from Map, ETA, My Students, Alerts (default ETA); side menu: Settings, Chipmunk Assistant, Help, Message Transportation, Send Feedback, Logout; ETARefresher runs a one-second loop | verified (Apps dev 7bfa58ff) | 238223417 |
| Sign-in stack: Quick Code district lookup (ClientEndpoint), OIDC (IdentityModel.OidcClient), Microsoft sign-in; push via OneSignal; ships Sentry and AppCenter; switches include ShowBus, ShowStudentScans, AllowMessageTransportation, ShowStudentSeat, ChatbotAvailable | verified | 238223417 |
| Chatbase assistant hook exists as Chipmunk_ChatbaseURL in BP Web's store (ENG-1172, main 2026-08-11) | verified | 238223417 |
| WK-41: Chipmunk stores one Quick Code and one district address, so a parent with children in two districts must set the app up again to switch | verified | 238682115 |
| R1-R3: alert reason and comment reach the app and the push body only when tracker settings ShowAlertReasonType and ShowAlertComment are on (both default false, no screen); the old ETAController lacks them; tapping the push has no deep link; one-way parent-to-transportation messages exist and the list is paged; multi-day notices activate at their scheduled time; a Chipmunk_ChatbaseURL setting exists | verified at main | 238682115 |

### Turns (56)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| With Turns_UseDispatchDatabase on, five BPInfo controllers send Turns' reads to the Dispatch DB; Turns runs offline once loaded; Run History lives only on the device | verified | 239173656 |
| The Submit button was removed on 08-12 so drivers cannot map their own bus; Turns_RequireVehicleConfirmation (off by default) confirms the tablet's mapping, not the check's bus; run substitutions (AppSubstitutionsByRun, TurnsSubstitutionsEnabled) are off by default | verified | 239173656 |
| Scans go via SubmitScan with an offline queue; each scan names the tablet's saved GPS unit and has no ID, so a tablet moved to another bus files riders under the old bus and a re-send cannot be told from a new scan; who is on board lives only on the tablet | verified (WK-36, WK-49) | 239173656 |
| A pre/post-trip check saved offline loses its bus and failure flag on sync; the submit email goes to one fixed list (InspectionNotificationEmailAdresses) and if blank nothing is sent though the driver sees "submitted"; no note, photo or odometer is recorded; bus named only if Turns_CaptureVehicle is on (off by default) | verified (WK-24 to WK-27, WK-34, WK-35) | 239173656 |
| Turns sends no position feed: only SubmitScanEvent carries the tablet's lat/long, at scan time; Turns has no notification path, no trip screen, no behavior reporting, no seat editing | verified | 239173635 |
| Student lookup by card or name searches only students with a stop, so an unrouted student shows as "unknown"; tablet shows "Met at bus: YES" and the authorised adults but saves nothing about who met the child | verified | 239173656 |
| Inspection result reaches a fixed email list, if its bus is named at all; stored keys are Turns_CaptureVehicle and InspectionNotificationEmailAdresses (sic) | verified | 238419971, 238845954 |
| A rider can be scanned off only at their own stop (PM) or the school (AM) | stated as today (decision 2026-10-16) | 239304705 |
| Bulk download saves GetAllStudents to the tablet when ShowStudentData is on; the tablet deletes students only on a full download; roster ignores enrolment; unknown-student lookups need a stop | verified (Apps dev 7bfa58ff) | 239304705, 238845954 |
| Turns already reroutes over Pro's road network (RunV/GetTurnsDirections, RunV/Reroute) and can black out the screen while moving (EnableBlackoutWhileMoving); keeps a versioned SQLite database on the tablet | verified | 239304705, 238845954 |
| Nothing warns when a suspended student boards (no path in Turns or BPInfo); Turns and Chipmunk have no behaviour code | verified | 238419971, 238845954 |
| A preferred Work phone returns the cell number (fix planned Phase 0, GI-R14) | verified | 238845954 |
| A driver cannot message the office at all; drivers call by radio or phone (CX-13, CX-14) | verified - REQ TN-4 | 238223396 |
| With `Turns_UseDispatchDatabase` on, Turns reads runs, routes and students from the Dispatch DB, but there is no push or notification to the tablet: the driver sees a dispatch change only after re-fetching | corrected | 239108098 |
| The GPS mapping Submit endpoint still exists (route-level mapping when runID is empty, createType "BPTurnsApp", writes the LIVE DB) but the Submit button was removed from the app (2026-08-12) | verified | 239108098 |
| The API has no driver identity: the token carries a username and roles only, and "who did this" is a free-text string supplied by the app | verified | 239108098 |
| `TurnsSubstitutionsEnabled` is advisory only (not enforced server side); `Turns_UseDispatchDatabase` and `Turns_SubstitutionsRetireAtMidnight` are cached for the process lifetime, so a toggle needs an app-pool recycle | verified | 239108098 |
| Existing setting defaults: all listed Turns bools false; `TurnsStopSpeed` 7 km/h; `Turns_DownloadAllRoutes` -1; `Turns_RequireOfflineLogin` true; the stored key `Turns_EnablePrePostInspections` has a trailing space | verified | 237928452 |
| Drivers sign in with a username and password, often shared per tablet or yard; the token names no person | verified | 238845975 |
| No Dispatch change is pushed to the tablet; the driver must reload or be phoned (CX-13) | verified | 238845975 |
| The bus reaches the server only from Submit; Start Driving reuses the last Submit's bus/route/run, so a driver who skips Submit next day is on a bus the platform does not know | verified | 238845975 |
| A check saved offline loses its bus and failure flag (WK-34); the tablet records no note, photo or odometer and names the bus by GPS unit id or free text | verified | 238845975 |
| Scans carry no id of their own, use the tablet's clock, and on-board state lives only on the device; T&A clock punches made offline are lost (no queue) | verified | 238845975 |
| Scanning happens on a stop's rider screen and is saved against that stop; a rider's scans alternate on/off; the server stores any scan with card, bus, time and GPS and applies no place rule; Scan Off All exists | verified | 238845975 |
| A scan matching no one on the run is looked up via `Student/GetUnknownStudent` and shown as "Unplanned Rider" (offline: an "Offline" student); a rider of another run shows the Wrong Run card; an unrouted student shows only as "unknown" | verified | 238845975 |
| A rider is on a run while their stop assignment is in force (enrolment not checked); riders load only when the run is opened with signal; student rows on the tablet are deleted only by the full download | verified | 238845975 |
| More than 75 m off the planned path the tablet rejoins the plan at the next stop over BusPlanner's road network; `TurnsDisableAutomaticRerouting` turns it off and manual reroute remains | verified | 238845975 |
| Existing settings and defaults: `Turns_RequireVehicleConfirmation` off; `Turns_StopAutoCloseSpeed` 2.75 m/s; `Turns_DownloadAllRoutes` off; `Turns_EnablePrePostInspections` is stored with a trailing space; `TurnsSettingsController.Get` returns an order-dependent list of booleans | verified | 238845975 |
| Seat type and Pro's driver instructions never reach the tablet; authorized contacts show only with `TurnsShowAuthorizedContactInfo`; there is no emergency button and no end-of-run walk-through prompt | verified | 238845975 |
| Tablet storage is SQLite (schema versions 1-3, 17 models) plus secure storage; checks go to Quick's `fm_*` tables, scans to `BPX_AVLScanEvent`, mappings to `BPL_AVLVehicleRoute` | verified | 238845975 |
| Inspection items have data types Text, Picklist or Number only (no pass/fail type); a pass/fail check is a Picklist with option rows and the answer is stored as a string in `fm_ResultItem.Value`; drivers report each item opens as a drop-down (renderer not inspected) | schema verified, UI behaviour from report | 239140887 |
| Manual tap-offs are recorded distinctly from real scans | stated | 250740737 |
| Nothing carries a bus suspension to the bus, a suspended student boarding another bus is never caught, nothing tells the office a child was left on a bus, and the driver has no emergency button (no code in Turns or the door) | verified | 237928473 |
| The rider list shows each rider's name, grade, seat, "met at bus" and scans (StudentsPage.xaml); nothing lets a driver note behaviour | verified | 239337479 |
| The driving-mode overlay covers the rider list above about 5 km/h (StudentsPageViewModel.cs:722) | verified | 239337479 |
| Every scan is marked scanned, manual, unverified or unknown (AVLScanEvent.ScanType, Scan.cs) | verified | 239337479 |
| Turns shows each rider's name, grade, seat, "met at bus" and scans, and has no way for a driver to record behaviour | verified — Apps dev 7bfa58ff | 239108122 |
| Turns queues unsent scans and inspection results when there is no signal and retries every 60 seconds (Services/SyncService.cs) | verified — Apps dev 7bfa58ff | 239108122 |
| Turns' driving-mode overlay covers the rider list above about 5 km/h (StudentsPageViewModel.cs:722) | verified | 239108122 |
| Turns' rider search box has spell check off | stated as today's behaviour, no tag | 239108122 |
| A check names its bus only when `Turns_CaptureVehicle` is on (off by default), and then by GPS unit ID or free text | verified | 239403009 |
| An offline "needs repair" check loses its bus and its failure flag and reaches nobody; the only alert is an email to one fixed list with no note, photo or driver | verified | 239403009 |
| Turns gets checklists from api/FormModule/GetLatest and posts results to api/FormModule/SubmitResults (with background retry); results land in Quick's DB fm_Result / fm_ResultItem and an email notification is sent | verified | 239075352 |
| Turns calls the templates "Questions"; whether pre / post-trip is one of them is unconfirmed; fm_Result has no vehicle column | lead / open | 239075352 |
| fm_Item.DataType has no boolean / pass-fail type, so a pass / fail check is stored as a Picklist (likely why each item must be opened) | lead | 239435777 |
| Turns rider query returns the cell phone even when preferred phone is Work; lists a withdrawn student until the stop is retired; a student with no stop is "unknown" by card or name | verified | 238125072 |
| WK-1 (P1): Turns signs in to BPInfo with a username/password whose token carries username and roles only, never a staff record, so nothing the tablet sends can be tied to a person; many districts share one account per tablet or yard | verified; re-check still true | 238682115 |
| WK-24 (P1): the inspection asks for the bus only when FormModule_Turns_CaptureVehicle is on (default off), and then offers GPS unit IDs or free text; Turns_RequireVehicleConfirmation (default false) confirms the tablet's mapping on the route page, not the check's bus | verified; still true | 238682115 |
| WK-25/WK-26: the inspection failure email lists Operable, Failure, times, "Unit ID" and each answer but no note, photo or driver; recipients are one setting (FormModule_InspectionNotificationEmailAdresses) and a blank list sends nothing with no error while the driver still sees "submitted"; the email is sent only on "not operable" or HasFailure | verified; still true | 238682115 |
| WK-27: fm_Result stores the device and a free-text CreatedById (columns ResultId, TemplateId, TemplateVersionId, DeviceId, CreatedById, CreatedAt, SubmittedAt, IsOperable, HasFailure); no staff record, bus, odometer or position | verified | 238682115 |
| WK-34 (P1): a check saved offline is synced through a mapper that sets the bus to empty and never sets HasFailure, so an offline "needs repair" check triggers no email at all | verified | 238682115 |
| WK-35: both result mappers hard-code Notes and Location to empty; the check has no camera, attachment or odometer handling although the server has an fm_ResultItemAttachment table; a check opens only from the feature menu, not from navigation | verified | 238682115 |
| WK-36: on-board state, queued scans and run history live only in the tablet's database, so a spare tablet starts with nobody on board and "Scan OFF all" (which marks off only IsCurrentlyOn students) marks no one off; a student scanned who is not on the run is kept as "Unplanned" and submitted | verified | 238682115 |
| WK-46: scans use the tablet's local time, checks and clock-ins use the tablet's UTC time, and nothing compares them with the server; the check email shows tablet "Created at" beside server "Submitted at" | verified | 238682115 |
| WK-49: a scan carries card, time, position, type and the tablet's saved GPS vehicle ID (AVLScanEvent) but no scan ID and no bus registry ID, so a moved tablet files riders under the old bus and a re-sent scan cannot be told from a new one | verified model; server duplicate handling not traced | 238682115 |
| BPInfo hands Turns the BP Web settings Turns_RequireVehicleConfirmation (default false), Turns_StopAutoClose* and BPUnified_URL / BPUnified_ClientCode / BPUnified_TimeAttendanceEnabled (default false); Turns drives one run at a time, sees Dispatch changes only after a reload, has run substitutions off by default with no Submit button, and queues offline scans (sync sends checks first, then scans) | verified at main / known | 238682115 |

### Subs (2)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Subs signs in with shared (yard) accounts so a swap names no person; role SubsAppRole opens only GPSRouteVehicle, GPSVehicleID and Route controllers; the phone holds secure storage only; a swap writes BPL_AVLVehicleRoute through the door's GPSRouteVehicle (GEDI method) | verified | 238682136 |
| A swap is "just today" by default (Turns_SubstitutionsRetireAtMidnight); a sub added in Dispatch is not a Pro person (DP-3, CX-20) and one district's driver does not show on the reassign dashboard; subs have no inbox | verified | 238682136 |

### Delays (7)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Delays clears every parent's schools, routes and runs when the district sets DelaysApp_SubscriptionResetDate to a newer date (manual rollover step); multi-day notices activate at their scheduled time (ENG-442); it is the only app reading the notice feed | verified (WK-50) | 239173656 |
| After rollover Delays follows last year's routes; subscriptions are keyed by school or route GUID; Chipmunk and Delays keep separate subscription lists | verified (stress test S3) / data block | 238419971, 238845954, 238092292 |
| One district's late-bus view showed one bus late while more than 50 were | named in a call / meeting 2026-09-25 | 238583811 |
| WK-50: the Delays app clears every parent's schools, routes and runs only when the district sets DelaysApp_SubscriptionResetDate to a newer date; it is a manual rollover step and without it last year's subscriptions stay on changed runs | verified; still true | 238682115 |
| Delays reads BPInfo Notification (anonymous), DelaysUserSettings (no Authorize attribute) and DelaysAppResetDate (anonymous); whether anyone can read or change another device's subscriptions through DelaysUserSettings is an unconfirmed lead | verified / lead | 238026775 |
| Rollover uses the manual setting DelaysApp_SubscriptionResetDate: if set every parent must subscribe again, if forgotten last year's subscriptions stay (WK-50); subscriptions key on school / route GUIDs that change at rollover (georef_DelaysSubscription) | verified | 238026775 |
| Delays keeps its own subscription list separate from Chipmunk's; the phone stores settings only (no SQLite); duplicate delay notices (PR 640) and multi-day notices (ENG-442, start at scheduled time) are fixed in production | verified | 238026775 |

### Fleet (113)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Shipped Fleet reads no FormModule results, so a failed driver check never reaches the mechanic; Fleet checks UseGeoIMS() in 38 places and runs standalone when GeoIMS_IP / LIVE_IP is unset; odometer comes from the fuel export file; Fleet has 146 permissions | verified (WK-23) | 239173656 |
| Fleet has 146 permissions; keeps fuel fills and odometer history; sign-in supports AD FS, OpenID Connect and SAML2 side by side; some screens use red and green for overdue | today's facts / as demoed (FT-R16) | 238845954 |
| Fleet's `/Inspection/Form` renders an all-open checklist with three-segment selection (106x43 px at 375 px wide), "Mark all Pass" / "Mark all N/A", live failure counter; it has no DisplayCondition handling or offline capture | verified (2026-09-02) | 239140887 |
| Shipped Fleet reads no Turns check results at all, so 0% of failed driver checks reach Fleet | verified — stress test WK-23..27, WK-34 | 239403009 |
| Fleet's `Vehicle` has no GPS-device column; a bus has four identifiers and no master | CTX §10 | 239403009 |
| Fleet keeps fuel fills (`VehicleFuel`) and odometer readings (`VehicleMileageReading`, with `Ignored` and `Overwritten` flags) and shows the last odometer; nobody outside Fleet sees them | verified — fleet-main | 239403009 |
| Sign-in page offers single sign-on through AD FS, one OpenID Connect provider and one SAML2 provider, each as a button; this is Fleet's own sign-in | verified — SSOSettings.cs, Startup.Auth.cs | 239403009 |
| Roles are district-named permission sets; completing, closing and reopening a work order are separate permissions and the menu shows only what the role can use | named in a meeting, not code-checked | 239403009 |
| VMRS codes are used across Fleet; 63 or more canned reports are seeded in `SqlReportQuery`, including Parts Used by Vehicle and Parts Expenditure by Vehicle | verified — fleet-main 969d0138 | 239403009 |
| Reminder intervals are by miles, days or business days per vehicle type or vehicle; a reading that jumps about 200 mi is checked; overdue shows red against green today | named in a meeting | 239403009 |
| A reminders pane shows on the work-order create screen only where setting 24 is on; the odometer is typed only after the work order is saved | verified (setting) / named in a meeting (odometer) | 239403009 |
| The baseline reminders pane filtered with hard-coded 93 / 85 / 85 percent gates on page one only (default page size 50), and settings 25–28 had no visible effect | code-read W03, not double-checked | 238288898 |
| Fleet keeps no vehicle warranty; the only warranty data is free text on a part (`Part.Warranty`) and a bit on a work-order part line | verified — FCS W05 | 239403009, 238845996 |
| My Daily Work shows a technician's own tasks; the technician workstation view shows only the work order each one is clocked into now | verified (My Daily Work) / named in a meeting | 239403009 |
| Fuel fills import from a mapped CSV or Excel file or by SFTP; backups run nightly and are kept about 10 days | named in a meeting | 239403009 |
| Parts cost defaults to an averaged stock cost (`Setting` key 15, `CostRule`); a core charge is stored with no flag; a superseded part is only a comment | verified (cost rule) / named in a meeting | 239403009 |
| Standalone mode exists: with `UseGeoIMS()` off Fleet runs without GeoIMS | SY-7 | 239403009 |
| One Fleet database per district with no school-year rollover copy; settings live in `Setting`, `ServiceSetting`, `ExportServiceSetting`, `SSOSetting` | verified — local DB v878 | 239403009 |
| Database migrations run from `Application_Start`, i.e. on the first HTTP request after a deploy, and a migration that throws is swallowed into the error log while the app keeps running | code-read W01 | 238288898 |
| On upgrade `AddDefaultSettings` deletes the `Setting` row of any key no longer in the defaults, destroying a district's configured value | code-read | 238288898 |
| Baseline: a distance- or hours-based reminder measures forever from its start odometer / hours, so after the first interval it is permanently due and servicing it changes nothing | code-read W01 (EITAS no.1 complaint) | 238288898 |
| Baseline: nine screens / jobs each compute "is this reminder due" differently, so the work-order screen can offer a job the Reminder Calendar says is not due | code-read W02 | 238288898 |
| Baseline: a reminder with no anchor measures from zero and fires (one fixture read 960% overdue); a missing hours reading reads as 0 | code-read W02 | 238288898 |
| Baseline: Interval 6 Month with Threshold 14 Day computes a trigger 8 months before the last service (threshold units ignored); threshold >= interval is permanently due | code-read W02 | 238288898 |
| Baseline: `RemindersSkipWeekends` and `RemindersSkipBlackoutDays` default true and a 6-month interval is counted as about 181 working days (about 253 calendar days) on screens while the auto-create job uses 6 calendar months | code-read W02 | 238288898 |
| Baseline at fleet-main 19cb8e5b6: `GetReminderGuidsDueDaysInAdvanceOrOverdue` returns an empty list, so the reminders auto-create job creates no work orders | code-read W02 | 238288898 |
| `WorkOrder.Status` is nullable and often NULL, so the baseline open-work-order test `IN ('Open','InProgress')` suppresses almost nothing and duplicate work orders can be raised | code-read W02 (local DB census) | 238288898 |
| Baseline: the create pane parses a date-only string in the browser as UTC, so in UTC-negative time zones a PM due tomorrow shows overdue from about 19:00 local | code-read W03 | 238288898 |
| Baseline: distance-only and hours-only reminders never appear on the Reminder Calendar; the calendar endpoint is POST-only | code-read W02 | 238288898 |
| Baseline: the vehicle Reminders tab shows next service as current reading + interval, a target that moves and is never reached | code-read W02 | 238288898 |
| Baseline: "Last Odometer" (`GetLatestReading`) ignores the `Ignored` / `Overwritten` flags and can show a rolled-back reading | code-read W05 | 238845996 |
| Hour-meter readings have no `Ignored` / `Overwritten` columns, so a wrong hours reading cannot be excluded | code-read W02 | 238288898 |
| Baseline: `FileUtil.GetMimeType` maps every image to "image/jpg" and has no HEIC entry, so phone photos are served as text | fact-check verified at baseline | 238845996 |
| `WorkOrderLinePart` records no user and no timestamp; Fleet has no change audit (only `LogError` and `UserLoginTracking`) | code-read W10 | 238911532 |
| Work-order `Total*Cost` is written only on Complete, so it is stale after later edits and NULL if never completed | code-read W04 | 238845996 |
| There is no web push for Fleet; OneSignal exists only for native mobile installs (Delays app, parent app) | code-read W09 | 238911532 |
| The Administrator role is re-granted the full permission enum at every app start; there is no global authorize filter; WORKORDER_VIEW = 101000 and no WORKORDER_EDIT exists | fact-check verified | 238911532 |
| Seven schema columns have a trailing space in their name (e.g. `AspNetRolePermissions.[PermissionId ]`, `Reminder.[OperatingHourThreshold ]`) | fact-check verified | 238911532 |
| `MvcBuildViews` is off because two shipped views do not compile (InventoryCount/InventoryPdf, PartLocation/Inventory), so Razor errors appear only at runtime | code-read | 238288898 |
| The test assembly has 2 pre-existing environmental failures (PurchaseOrderVMTests) and `Georef.Web.Test` needs a GeoIMS dev server | code-read | 238911532 |
| 9 Fleet subjects in the recent support-ticket sample, e.g. reminder errors after an upgrade and barcode printing | verified count; indicative | 239403009 |
| Fleet learns a vehicle's odometer only as a side effect of fuel transactions (VehicleFuelVM / VehicleFuelImporterVM) or manual entry; vehicles that do not fuel get no readings | verified | 239009796 |
| The fuel importer is a fixed-width flat-file column map (ColumnName, StartPosition, Width, Active, ColumnOrder) configured by hand; a shifted column silently writes wrong mileage | verified | 239009796 |
| PM reminders consume VehicleMileageReading (and operating hours since migration 818), so odometer errors propagate into PM scheduling | verified | 239009796 |
| Fleet has zero Geotab dependencies (no Geotab project or package reference); the Geotab stack belongs to Quick / Dispatch / BP Web | verified | 239009796 |
| Fleet reads VehicleRoutesDrivers, BPInfo route methods and Staff from the live transportation database over the LIVE_ bridge; if the bridge is unreachable at start-up it logs "No such host is known" and does not crash | verified | 239009796 |
| VehicleMileageReading has Ignored and Overwritten bit columns and a NOT NULL UserId; VehicleOperatingHoursReading has neither flag and uses ModifiedBy | verified | 239009796 |
| Vehicle carries IsOdometerType, IsHourMeterType, OdometerUnit (free text up to 20 chars, values such as km / Miles / MI seen), LidNumber; there is no Geotab device-ID column and no Inactive column (Status 'Archived' is the flag) | verified | 239009796 |
| PartVendor.CostPerUnit is a single money value with no effective date, so there is no price history | verified | 239009796 |
| PurchaseOrderStatus is a lookup table and PurchaseOrder already has InvoiceNumber; Part has ManufacturerPartId, SKU, NonStock, CoreReturnCost | verified | 239009796 |
| Parts procurement is fully manual (price checks, ordering, invoice reconciliation by phone / email / retyping) | verified | 239009796 |
| Database migrations and default settings run from Application_Start (the first HTTP request after deploy); a failing migration is logged, not shown, and the database version stays where it was | stated in spec, not independently re-checked | 238354434 |
| On every app start the Administrator role is re-granted the entire Permissions enum, so a permission revoked from Administrator returns after a restart | stated in spec, not independently re-checked | 238354434 |
| AddDefaultSettings deletes the Setting row of any key missing from the coded defaults, destroying a district's configured value; setting key numbers must never be reused | stated in spec, not independently re-checked | 238354434 |
| Bumping TRANSLATION_VERSION deletes and re-imports all translation resources, wiping any row a district edited directly; the build verifier expects 3 languages (en, es, fr) per key | stated in spec, not independently re-checked | 238354434 |
| The role editor groups permissions by hundreds and uses the permission whose value equals the group number as the bold heading | stated in spec, not independently re-checked | 238354434 |
| A global CSS rule (Custom.css line 1148) makes any Bootstrap panel-default heading in page content white text on white (invisible) | stated in spec, not independently re-checked | 238354434 |
| Work order status text is inconsistent: web app writes 'InProgress' / 'OnHold', the domain enum can write 'In Progress' / 'On Hold', WorkOrder.Status is nullable (NULL on 100 of 105 local rows) and 'Voided' exists in one vocabulary only | stated in spec, not independently re-checked | 238420013 |
| Setting UnitDailyMax (key 63, default 200) drives the implausible-odometer check on manual fuel entry (days x UnitDailyMax), compared in the vehicle's own unit although the description says miles | stated in spec, not independently re-checked | 238354434 |
| Attachment previews (part, purchase order, vehicle, work order) are a 300x300 embed in a 500px dialog fed by a base64 data: URI, so print and open-in-new-tab cannot work in Chrome / Edge / Firefox | stated in spec, not independently re-checked | 238420013 |
| HEIC, HEIF, WEBP and BMP attachments are typed text/plain and the preview is hidden; all other images are served as the unregistered type image/jpg | stated in spec, not independently re-checked | 238420013 |
| AttachmentData Download has no permission check: any signed-in user with an attachment guid can fetch the bytes | stated in spec, not independently re-checked | 238420013 |
| Attachment upload has a file-count limit (GetMaxAttachmentUploadCount) but no size cap; files are loaded whole into memory | stated in spec, not independently re-checked | 238420013 |
| A global DisableCacheAttribute sets no-cache / no-store on every action result, so attachments are never browser-cached | stated in spec, not independently re-checked | 238420013 |
| Fuel import decrements the tank by read-modify-write per row with no concurrency guard, so overlapping imports or a manual adjustment can lose a write | stated in spec, not independently re-checked | 238420013 |
| Fuel import duplicate guard tests whether the matched ImportFuelID is non-empty rather than whether a match was found, so re-importing an overlapping file can insert a second fuel row and decrement the tank again | stated in spec, not independently re-checked | 238420013 |
| Fuel importer writes UsedInFueling adjustments positive while manual entry writes them negative, so SUM(AdjustmentAmount) is wrong by twice the imported volume | stated in spec, not independently re-checked | 238420013 |
| Fuel recount edit form posts two inputs named Quantity (visible box plus hidden as-loaded copy) and two named UnitCost, so the binder receives a combined value | stated in spec, not independently re-checked | 238420013 |
| With two tanks of the same fuel type at one yard every imported row is charged to the FuelLocation that sorts first by name; the mode switch is per-browser localStorage | stated in spec, not independently re-checked | 238420013 |
| Tank balance is stored on Fuel.Quantity (decimal 15,6); FuelLocation holds only Capacity and reorder levels | stated in spec, not independently re-checked | 238420013 |
| Vendor has no unique-name index (47 other lookup tables do), no name check / trim / case-fold on save, and the work-order VRO flow lets a technician create a duplicate vendor in two clicks | stated in spec, not independently re-checked | 238420013 |
| A vendor that was ever used cannot be deleted (six NO ACTION foreign keys); archiving only hides it from pickers while reports keep splitting spend | stated in spec, not independently re-checked | 238420013 |
| Part barcode labels are Code 39 with "#" stripped from the PartID, so scanning a label for a PartID containing "#" never matches in Inventory Count | stated in spec, not independently re-checked | 238420013 |
| Barcode pages load the barcode font from fonts.googleapis.com | stated in spec, not independently re-checked | 238420013 |
| Views are not compiled at build (MvcBuildViews off) because two baseline views are broken: InventoryCount/InventoryPdf and PartLocation/Inventory | stated in spec, not independently re-checked | 238420013 |
| Unit test assembly BusPlannerFleet.Tests has two PurchaseOrderVMTests (DeleteTestSuccess / DeleteTestFailed) that fail for environmental reasons and three controller test classes marked Ignore | fact-check correction | 238354434 |
| Fleet has no map and no position columns in any of its 113 tables | stated in spec, not independently re-checked | 238420013 |
| Shipped Fleet DB schema is v866; migrations 867-878 exist only in an uncommitted local working tree | verified | 239075352 |
| Fleet has no mobile app, no offline mode, no public API (no ApiController) and no webhooks; integration is via direct DB access and the GEDI bridge | verified | 238485528 |
| Fleet has no driver DVIR and no real telematics integration (0 matches for geotab); labour hours are typed by hand | verified | 238485528 |
| UI is bilingual by construction (6,581 translation rows EN/FR; Translations.csv is UTF-16 with BOM and loads only when TRANSLATION_VERSION is bumped) | verified | 238485528, 239435777 |
| A distance- or hours-based reminder measures forever from StartOdometer, so after the first interval it is permanently due and servicing changes nothing; only the date axis rolls forward | verified | 239435777 |
| Work order Create shows a Reminders pane only when setting key 24 "New Work Order Reminders On" is true; window is settings 25/26 (days before/after, default 10) and 27/28 (odometer before/after, 100) | verified | 239435777 |
| Reminders pane ignores the Include Overdue checkbox: server always clamps to +/- 10 days and the client filter is dead code, so reminders overdue by more than 10 days never show | verified | 239009817 |
| Vehicle reminder badge is an unfiltered COUNT while the list is filtered, so a vehicle can show 7 reminders and an empty list | verified | 239009817 |
| "Upcoming" odometer filter uses a modulo test that can never match when OdometerThreshold = 0 and drops reminders once they are badly overdue | verified | 239009817 |
| Reminders list "Create Work Order" silently does nothing when checked reminders have no active time / odometer / hours trigger, and server failures return HTTP 200 success:false that the page discards | verified | 239009817 |
| Reminders list create-work-orders has no server-side duplicate check (two clicks make two work orders); WorkOrder.Status NULL is treated as closed (101 of 109 local work orders had NULL) | verified (local DB) | 239435777 |
| Reminder percent-due gates 93 / 85 / 85 are hard-coded; overdue rows are bold, due-soon rows unstyled, no red | verified | 239009817 |
| A MissingPart on a Completed or Closed work order is never cleared by receiving stock, so a part can show On Hand 2 and Missing together; transfer receipts never reconcile missing parts | verified | 239009817 |
| Fuel import fails every row with a NullReferenceException text when the fuel location has no Fuel (bulk tank) record; the row and its odometer reading roll back; tank quantity can go negative | verified | 239009817 |
| Fuel import: locations must pre-exist; vehicles match on Vehicle.VehicleID; a blank Import Fuel ID is allowed; only a non-blank already-imported id is rejected | verified | 239009817 |
| "Add Work Order" on a vehicle whose Status is not Active (0) renders a disabled button that looks live, with no message; vehicles with other statuses are missing from Active dropdowns | verified | 239009817, 239435777 |
| Work order list Description is clamped to 3rem (about 2 lines) but "+More" only appears above 100 visible characters, so short multi-line descriptions cannot be expanded | verified | 239009817 |
| Work order status row colours: Open none, InProgress green (bg-success), Completed red (bg-danger), Closed grey-400, OnHold / Inactive grey-500; no blue | verified | 239009817 |
| Vehicle.VehicleID has a unique index, so duplicate bus numbers cannot be saved | verified | 239009817 |
| Purchase Requisition silently drops under-stock parts with no PartVendor row (only the TOP 1 primary vendor is compared) or, when "Use Max Quantity For Part Orders" is true, with MaxQuantity - (OnHand + OnOrder) <= 0; at Miami 849 of 933 under-stock rows were hidden | verified | 239009817 |
| ReorderLevel, ReorderQuantity and MaxQuantity accept negative values (no range validation) | verified | 239009817 |
| Inventory "Transfer Sent" adjustment rows from two of three code paths record no Last / New Quantity; one grid shows blank and another shows 0 -> -n for the same row | verified | 239009817 |
| Receiving a transfer twice double-posts adjustments while on-hand moves once (absolute write from a stale value), so the adjustment ledger no longer sums to on-hand | verified mechanism / trigger unknown | 239009817 |
| Editing a quantity on the Part Location screen writes a "Recount" adjustment with note "Manually adjusted" | unverified, flag only | 239009817 |
| With Cost Rule 0, receiving stock blends unit cost as a weighted average (1 at 0.46 + 1 at 6.82 = 3.64), rounded to 2 dp when Round Average Costs (key 17, default true; precision key 57, default 2) is on | verified | 239009817 |
| Settings screen lists every Setting row with an edit pencil; Cost Rule accepts any integer (no 0-1 validation) and a value other than 0 behaves as last cost | verified | 239009817 |
| PartTotalValue renders at a different precision than UnitCost in the same row | verified | 239009817 |
| No warning on a second identical PO within minutes or when a receipt pushes on-hand past MaxQuantity; no "duplicate receipt reversal" reason exists | verified | 239009817 |
| Odometer "latest reading" lookup ignores the Ignored / Overwritten flags, so work order create can display a rejected reading | verified (local) | 239435777 |
| Removing a SettingKey from defaults DELETES that Setting row on upgrade (AddDefaultSettings), destroying the district's value | verified | 239435777 |
| An unauthenticated request returns 302 from the auth filter before the view compiles, so a 302 proves nothing about a page | verified | 239435777 |
| Two views are broken at compile time (InventoryCount/InventoryPdf and PartLocation/Inventory), which is why view pre-compilation is off | verified | 239435777 |
| Part.Warranty is free text and Part.CoreReturnCost holds the core charge (not "CoreCost"); tyre data is one decimal WorkOrder.TotalTireCost | verified | 238485528, 239435777 |
| Adding a report touches six places (SqlReportQuery + 7,810-line SqlReportQueryVM) | verified | 238485528 |
| Fleet is web only ("no mobile app, and no offline"); My Daily Work timer needs permission TECHNICIANDAILYWORK_VIEW (304000); Fleet flags chronic repeat repairs | verified (Fleet gap analysis, Miami fix spec 03) | 238223417 |
| WK-23 (P1): shipped Fleet (fleet-main) has no code that reads Turns inspections (no fm_Result / FormModule / DVIR reference); Fleet's Vehicle has no GPS-device column; a standalone Fleet cannot record technician training without GeoIMS | verified | 238682115 |

### Trips (19)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Trips SE import of drivers / buses / schools from BPInfo is off by default; imported drivers are keyed to Pro only if UseStaffGuidAsEmployeeExternalID is on (off by default); directions come from Google | verified (WK-15) | 239173656 |
| Directions come from Google (CX-43); rotation counts every assignment ever, cancelled included, never hours; estimate starts from a default distance and the booking window, office-only, after submission | verified | 238092292, 238845954 |
| WK-15: Trips SE imports drivers into its own Employee table; UseStaffGuidAsEmployeeExternalID (keying to Pro) defaults to false; Turns has no trip screen | verified; still true | 238682115 |
| Trips SE has 31 pages and none is for a driver: the driver's only artefact is a PDF trip sheet emailed by a template; neither edition's master page has a viewport tag, so no page fits a phone | verified | 238387207, 238747655 |
| Editable sections depend on trip state: Saved = basics, destinations, requirements; Submitted adds accounts and estimates (Cancel / Reject / Approve); Approved adds assignments (Cancel / Assign); Booked adds invoice and driver report (Cancel / Re-assign / Close Trip); Complete is read-only (To PDF) | demo-site scrape | 239140908 |
| A request inside the notice window (NumDaysNoticeRequest) fails on submit with NotEnoughNoticeError; blackout dates block; a rejected trip goes back to the requester only; no exemption path | verified | 238387207, 238747655 |
| A new estimate starts from EstimateDefaultDistance (20 units), uses the whole booking window as hours and derives buses from capacity; Calculate fetches distance from Google Directions but hours stay typed; estimate section shows only in Submitted state to users who can edit it; RequestorCanViewEstimates is off by default | verified | 238387207, 238747655 |
| Driver listing has three modes: alphabetical; first available by seniority; next in rotation = fewest assignments ever (cancelled trips included) then seniority; nothing counts hours | verified | 238387207, 238747655 |
| Driver picker filters by the driver's schools, multi-day flag, employee blackout dates, weekly schedule windows and overlapping trips; vehicle picker filters by type, school and overlapping trips | verified | 238387207 |
| Driver.MaxHoursPerWeek is stored but never read; TripAssignments records only who was assigned, by whom and when (no offers, declines or reasons); seniority is a drag-and-drop list | verified | 238387207, 238747655 |
| Trips SE imports schools, drivers, driver schedules, vehicles and vehicle types from BPInfo (School/Get, Driver/Get, DriverSchedule/Get, Vehicle/Get); UseStaffGuidAsEmployeeExternalID is off by default, so a retirement or training lapse reaches Trips only at the next import | verified | 238747655, 238387207 |
| Approvers are ordered per school and per trip type with the Default chain as fallback; the chain is edited on the School Edit view (not Add) with Move Up / Down / Remove | verified | 238387207, 239140908 |
| Email templates are per trip state and trip type, to six recipient kinds (drivers, requestor, approver, school contact, contractor, reviewer) with per-person overrides; automatic reminders (TripReminderDaysInAdvance) skip blackout hours; any change sends an automatic email with the change details | verified | 238387207 |
| At close-out the office types odometer, sit and overnight times, meals and tolls into the driver report and types actual start / return; invoices leave as PDF plus a cost-summary CSV; the only machine export is Contractor Payments; nothing reaches finance, payroll or Fleet | verified | 238387207, 238747655 |
| Trips CE supports a bid window (BidDaysUntilStart, BidDuration, BidRuleSet), whole-trip or per-leg bids, minimum operators, lowest-cost-only rule, quotes valid QuoteNumDaysValid = 45 days, booking fee, PO numbers, signed contracts, operator ratings, recurring trips with per-date cancellation | verified | 238387207 |
| Rules settings are NumDaysNoticeRequest, NumDaysNoticeCancel, ChangingTripTypeOverwriteRequirements, MaxNumTripsDisplayed; Login settings LockoutMinutes and NonceExpirationMinutes; HideDriverReport hides the driver report; driver trip sheets come in four layouts incl. a manifest; rates are one per rate type and vehicle type with no dates | verified / demo-site scrape | 239140908, 238387207, 238747655 |
| Trips SE setup is 22 entities entered one form at a time with no API and no dependency guidance (e.g. Vehicle Types before Vehicles, Schools before Accounts); "Is default account" is the account auto-charged on a school's new trips; drivers with no Schedule are invisible to auto-assign | demo-site scrape | 239140908 |
| One database per edition per district (SE has 54 tables incl. old aspnet_ membership tables); upgrade steps are VersionNNN.cs files (18, latest 1000); no rollover, drivers and vehicles are re-imported from Pro | verified | 238747655 |
| No duplicate-request check, no bulk approval (one trip at a time; assumed), requester accounts are created by the office, Copy a trip exists; a trip bus does not show as busy in Dispatch; trip hours do not reach time and attendance | verified / assumed | 238387207, 238747655 |

### Workflow (8)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Workflow "Save To BusPlanner" writes into live Pro; gated by Workflow_Enabled and Workflow_SaveToBPVisibleWhenPending (shows the button before approval) | verified | 239173656 |
| wf_ tables live in BP Web's database and Workflow writes to Pro through GeoIMS; FormModule fm_ tables live in Quick's database | data block finding (v0.14) | 238845954 |
| A Workflow submittal has no student key (wf_Submittal: Date, Email, names, SchoolId, OperatorId, Archived); at least one district runs bus discipline forms in Workflow with operators in the loop | verified (CRM ticket subject) | 239075331 |
| At least one district runs bus discipline forms in Workflow | verified — CRM ticket subject 2026-03-31 | 239108122 |
| Workflow is the only product that writes into Pro's live database ("Save To BusPlanner"), through GeoIMS and never with its own SQL; the change reaches Turns and Chipmunk only after the next nightly copy and the form does not say so | verified (CX-46) | 239075373 |
| Workflow_SaveToBPVisibleWhenPending shows Save To BusPlanner before approval; Workflow_Enabled turns the product on; both are BP Web settings | verified | 239075373 |
| Workflow's 31 wf_ tables (wf_Form, wf_FormVersion, wf_Step, wf_Submittal, wf_SubmittalData, wf_SubmittalHistory, wf_Letter, wf_UserSchool …) live in BP Web's database and are upgraded by BP Web's upgrade steps; its "Driver Pre-Trip Inspection" template duplicates Turns' checks; Workflow is the largest support-ticket theme (51 of 1,487 recent subjects) | verified | 239075373 |
| Admin > Forms has a "Submission Uniqueness" setting that was used live to resolve duplicate-submission messaging | meeting note | 237797385 |

### Trackers / GeoIMS / GEDI (13)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Tracker OneSignal batching loop never exits after a send failure (TRK-1); adding a socket timeout as-is would delete parents' subscriptions (SHR-2); GeoIMS and trackers sometimes stop serving while reporting healthy | verified (GeoIMS fix spec) | 239173656 |
| GeoIMS and Tracker intermittently stop serving while reporting healthy; restart is the only remedy (38 incidents in 12 months; 668 DOWN alerts in 144 days) | verified (symptom) | 237993990 |
| No socket connecting to GeoIMS sets a receive timeout (infinite wait) at any of 15 sites; connect timeout falls back to 5.0 s | verified | 237993990 |
| Every GeoIMS request runs a health-check SQL query on the single accept thread under one lock shared by all databases (ADO default 30 s command timeout), so one slow SQL Server stalls every district | verified | 237993990 |
| GeoIMS worker processes are never recycled (no max-request / age / memory limit, 32-bit); a worker is held for the whole client TCP session, idle drop after 300 s | verified | 237993990 |
| Passing a stale worker id to StopWorker / ShutdownWorker crashes the GeoIMS service (null dereference) | verified | 237993990 |
| GeoIMS logs are never pruned; it writes nothing to the Windows event log; the busy-request counter in its UI is always zero | verified | 237993990 |
| A web staff save replaces the whole record and deletes rows it was not sent, so a stale page can delete a course or undo a retirement; every web staff save is audited as "Fleet - Technican Save" | verified | 238125072 |
| Staff list "Driver OR Monitor" filter lacks brackets so drivers skip operator and scope limits; an SQL error returns an empty list | verified | 238125072 |
| Staff delete cascades through 12 tables including the audit; run merge updates runs one by one with no transaction; the move engine checks no equipment, seats, boundary, dead end, operator or timing | verified | 238125072 |
| Expired-certificates report lists lapsed courses only (not licence, MD licence, evaluation, physical); BPL_StaffTraining has no expiry column | verified | 238125072 |
| WK-9/WK-10: a staff save from Quick or Fleet sends the whole record and GeoIMS overwrites every field (incl. Active, RetireDate) and deletes child rows not in the list, so a stale Fleet page can delete a new course or undo a retirement; every web staff save is audited as "Fleet - Technican Save" (or "Fleet - Technican Add") whichever product called it | verified in code; still true | 238682115 |
| WK-14: when a caller asks for drivers and monitors together the staff-list query has no brackets around "Driver OR Monitor", so Driver-role people skip the operator and scope filters; any SQL error returns an empty list with no message | verified in code; which screens ask for both is a lead | 238682115 |

### GPS readers (8)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| 9 readers (Geotab, Samsara, Synovia, Zonar, CTS, GTS, Where's The Bus, TRBOnet, DataRemote) write positions and sensor bits (doors, stop arm, amber lights); none passes odometer, engine hours, fuel or fault codes, and none reads a driver | verified (census) | 239173635 |
| No reader passes odometer or engine hours on, so reminders of buses that do not fuel on-system go stale (CX-34, CX-35) | verified | 239403009 |
| GeotabConnection caps the district account at 60 requests per minute with a 5% buffer and warns that higher rates cause timeout errors | verified | 239009796 |
| BPGeotabReader writes BPX_AVLEvent rows with position, speed, heading, sensors and event time but no odometer or engine-hours column | verified | 239009796 |
| The reader's diagnostic-to-sensor mapping (GetInputValue) is boolean only (0 = off, 1 = on): stop arm, amber lights, door, ignition | verified | 239009796 |
| Geotab SDK is pinned at 11.43.302 and GeotabConnection.CheckVersion logs a warning on version drift | verified | 239009796 |
| No reader passes odometer on (line commented out in three readers); Geotab reader reads no fault data; BPX_AVLEvent has no odometer or engine-hours column | verified | 238551066, 239435777 |
| No reader reads fault codes today; the Geotab reader reads positions (LogRecord) and selected StatusData (GeotabConnection.cs:280), not FaultData | verified | 238223417 |

### Live tracking (20)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| The parent fallback window (how long before / after a run parents see the bus with no driver selection) is four tracker settings: AM and PM, before and after; Georef.Web.TrackerModels is shared by trackers and the door | verified | 238845954, 239304705 |
| DF-7 / DF-10 / DF-11: a dispatcher substitution never reaches the Chipmunk tracker by REST (wrong session key, silent); a tracker without `DispatchDatabaseGuid` polls the live DB and reverts a pushed substitution at the next mapping poll (effective default 10 s); a Turns run-level mapping silently outranks the dispatcher's route-level mapping | verified | 239108098 |
| Two conflicting active GPS mappings for a route make the tracker return no vehicle: the route goes dark for parents and the Live Viewer with only a tracker log warning | verified | 239108098 |
| GPS Live Viewer defaults its base map to a district-hosted WMTS path and treats MapBox / Google / OpenStreetMap as alternates needing a token or licence | stated in spec, not independently re-checked | 238420013 |
| A dispatcher swap is held in tracker memory only until the next GPS Vehicle Mapping poll (every 5 minutes); on a tracker reading the live database the poll replaces it | verified | 238551066 |
| A tablet's run-level mapping outranks a dispatcher's route-level mapping | verified | 238551066 |
| A failed routing call keeps the last ETA with EtaAvailable = true; no off-path check; bus size is not passed to the path search | verified | 238551066 |
| No pushes are sent on weekends (weekday-only schedule shortcut); a tracker restart re-sends every active notice | verified | 238551066 |
| OneSignal batch send loops forever on any failure when a notice has more than 2,000 subscription ids (largest districts); retries are 3 x 10 s, run inside the ETA loop | verified | 237993990 |
| ETA2 requires the Subscriber role, so only parents get ETAs | verified | 238551066 |
| Tracker health check IsTrackerAlive returns true when more than ten routes have ETAs or messages, using data that never expires, so a wedged tracker reports alive | verified | 237993990 |
| Bus position update frequency defaults to 5 s; GPS retry budget is 3 for the whole service lifetime, not per incident; an overrunning cycle re-runs after 1 tick | verified | 237993990 |
| AM and PM split at 12:00 local; BusPositionWindow AMBefore / AMAfter / PMBefore / PMAfter default 120 minutes each; Chipmunk_HideETAs exists; Where's My Bus ETAInformation_Timeout is 10 | verified | 238551066 |
| Tracker ETA2Controller.Get is limited to role Subscriber and returns only the signed-in parent's students; staff have no ETA endpoint | verified | 238223417 |
| Tracker route status reports SecondsDifferentFromPlanned, OnPath, ETAAvailable, ETAUnavailableReason, LastGPSEventTime per route; dashboard tables RouteNoMovement and RouteNoMapping exist (migrations 24, 30) | verified | 238223417 |
| WK-57 / SY-19 today: parents see the bus in a fallback window held as four tracker settings (BusPositionWindow AM/PM Before/After, default 120 minutes each); the descriptions of BusPositionWindowPMBefore ("after the AM runs") and BusPositionWindowAMAfter ("before the PM runs") are wrong | verified at main | 238682115 |
| DF-2: no pushes go out on Saturday or Sunday; DF-4: a tracker restart re-sends every active notice; TRK-1 (OneSignal loop), SHR-2 (timeout deletes subscriptions) and the Subscription Service's dead resume checkpoint and partial-send gap (DF-3, DF-5) are unchanged; ENG-1946: its OneSignal send drops unregistered aliases and resends only when nothing was delivered | re-check: still true | 238682115 |
| DF-10: a Dispatch vehicle substitution is an in-memory mapping replaced at the next GPS-mapping poll (every 5 minutes), so a tracker polling the live database loses it; DF-11: a run-level (tablet) mapping outranks Dispatch's route-level mapping | re-check: still true | 238682115 |
| DF-13..DF-17, CM-1, CM-5 still true: a stale ETA can be served, there is no off-path check, vehicleSize is never set, TooFarFromBusStop is overloaded, and "bus is near" has no run gate; ETA2 is Subscriber-only so there are no staff ETAs | re-check: still true | 238682115 |
| SY-17: tracker settings are cached up to 30 minutes; POST Monitoring/ResetSettingsCache (roles Override and ChipmunkDashboard) clears the cache at once; Chipmunk settings are cached 5 minutes in the tracker; Dispatch imports are scoped to the changed routes and runs | verified at main | 238682115 |

### BPInfo REST (19)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| BPInfo has 99 controllers; TurnsAppRole opens 7 (GPS, GPSRouteVehicle, GPSVehicleID, Route, Run, RunV, Student), SubsAppRole 3, AssistantAppRole 11 | verified (census) | 239173635 |
| Weak spots: no global authorize filter, 6 controllers without [Authorize], 29 actions [AllowAnonymous] (incl. ClientEndpoint, MinimumAppVersion/Get, Notification reads) | verified (REQ §2.3) | 239173635 |
| POST /Token is a password grant with 1-hour tokens; paths follow api/{controller}/{action}/{id}; new shapes get a version suffix (GetTurnsSettingsV2, ETA2); Swagger at swagger/swagger/ui/index | verified | 238321683 |
| BPInfo has the district lookup, tokens, roles and 99 controllers; its Student model carries SpecialEd, Eligibility and TravelCode | stated / verified | 238452749, 238845954 |
| There is no global authorize filter: six controllers have no `[Authorize]` and 29 `[AllowAnonymous]` actions are reachable by anyone (including all of TurnsSettings, `Route/GetId`, `Route/GetIdList`, `Route/GetMinimalList`, `Run/GetIdList`, `Run/GetMinimalList`); the bearer token is accepted in the query string | corrected | 239108098 |
| `RouteItinerary/Get` returns element type only as "Run" or "Deadhead"; `DriverSchedule/Get` takes no filter and returns every driver schedule in the district | corrected | 239108098 |
| The door's Student model already carries alert, instruction, medical, SpecialEd, Eligibility, TravelCode, grade and last name (Models/Student.cs) | verified | 239337479 |
| The door serves student extended properties (StudentComplete) but Turns does not read them; districts use a free-text extended property for driver notes and suspensions with no end date | verified / lead (the workaround) | 239337479 |
| POST api/FormModuleTemplate/CreateTemplate rejects a submission unless version is exactly latest + 1 ("Submitted version must be {n}") and rejects a TemplateId with no version; property names are snake_case | stated in spec (receiver code read) | 238354434 |
| The door has no global authorize filter, 6 controllers lack [Authorize] and 29 actions are [AllowAnonymous] | verified (REQUIREMENTS §2.3) | 238223417 |
| The client list is a JSON file served by ClientEndpoint/GetAllClients on the central door (access codes, door URL, tracker URL, five app flags, EN/FR names, OneSignal IDs); GetAllClients and GetAllClientEndpoints are anonymous; the door has 99 controllers and no screens | verified; anonymous listing is a lead | 239534081 |
| Tokens come from /Token and are valid for 1 hour | verified | 239403051 |
| There is no global authorize filter; 7 controllers have no Authorize (ClientEndpoint, ClientLogo, DelaysAppResetDate, DelaysUserSettings, MinimumAppVersion, SubsSettings, TurnsSettings) and 29 actions are AllowAnonymous | verified 2026-09-25 | 239403051 |
| The token endpoint allows plain HTTP in code (AllowInsecureHttp = true); whether any production edge accepts HTTP is unknown | verified / unknown | 239403051 |
| The anonymous Turns settings (GetTurnsSettingsV2) return BPUnified_URL, BPUnified_ClientCode and BPUnified_TimeAttendanceEnabled (off by default) | verified | 239403051 |
| BPInfo has its own REST database (users, roles, tokens) and also connects to BP Web's database and to three GeoIMS targets: live Pro, the GPS target and the Dispatch copy | verified | 239403051 |
| An EventController with role EventGet already exists; the door has no tables of its own for hand-offs, devices, bus registry or inbox | verified | 239403051 |
| REST users are set up one at a time: add user (username, email, password), then Edit with separate Save buttons for Operations, Schools, Grades and Operators; the Add User form is at the bottom of the page | current QA site and code | 247824423 |
| REST user password rule is 12+ characters with uppercase, lowercase, digit and a non-alphanumeric character; user name allows only letters, digits, @, _ and .; several logins may share one email; no audit trail, translations or row limits | current code | 247824423 |

### Subscription Service (14)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Failures restart from the first address (DF-3) and a crash mid-send abandons the rest (DF-5); OneSignal send drops unregistered aliases and never resends delivered ones (ENG-1946); driver route-change email digest only for drivers with a BP Web account and "Changes" subscription | verified | 239173656 |
| Has no per-recipient delivery record | data block finding (v0.14) | 238845954 |
| DF-3 / DF-5: on a send failure the job restarts from the first address so parents already emailed get duplicates (about once per second until the job ages out); a crash mid fan-out leaves the job abandoned and later parents never get the email | verified | 239108098 |
| A queue job is picked up only while `PostedAt` is between now minus AgeLimit and now; if the service is down longer than that the notification is never sent and there is no catch-up or dead-letter sweep | verified | 239108098 |
| A reassign notification is only sent on the calendar day it was created (`CreateDate.Date == today`); one created 23:50 and processed 00:05 is filtered out | verified | 239108098 |
| AgeLimit has three disagreeing defaults: 60 in the in-memory object, 10 when the DB row is missing, 0-60 clamp applied on write only (a larger value put straight in the table is honoured) | corrected | 239108098 |
| The parent web-account check deletes a subscriber's child subscriptions on any GeoIMS error whose message lacks "server busy"; today the call hangs instead | verified | 237993990 |
| WK-43: a scheduled "driver route change" job emails drivers who have a BP Web account and a "Changes" subscription about Pro route changes since the last run; same-day Dispatch changes are not in it (lead); this is the only way a driver is told of a change | verified; Dispatch-DB scope is a lead | 238682115 |
| Dispatch change notices are written at save in the sending dispatcher's language for every parent; the default text calls every change "temporary" and ends "Thank /you." (WK-45) | verified | 238321746 |
| A failed email send restarts from the first address so parents already emailed get a second copy (DF-3); a crash mid-send abandons everyone after the failure point (DF-5) | verified | 238321746 |
| Dispatch emails are all or nothing per district (setting "Dispatch - Disable Parent Emails", ENG-1406) and parents cannot choose categories; targeted notices already go by SMS via Twilio but Dispatch changes cannot be texted | verified | 238321746 |
| No per-recipient delivery record exists: queue rows (ss_EmailQueue, ss_PushQueue, ss_SMSQueue; ss_QueueStatus per channel) hold only a receiver count and an attempt count; ss_EmailQueue allows up to ten attachments | verified | 238321746 |
| The scheduled student route change job (StudentRouteChangeWorker) sends email only; DriverRouteChangeManager sends the drivers' route-change digest; the push for a Dispatch change is sent by the tracker, not this service | verified | 238321746 |
| Known production harm now stopped by Send Run Changes (Sept 2026): one district got 623 emails whose body was an unchanged stop time ("02:21 PM to 02:21 PM") and another got six contradictory notices in nine minutes | verified | 238321746 |

### Settings (12)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| 8 settings store families, 36 tables and files; Chipmunk / Dispatch / Turns use three: BP Web georef_Setting, tracker Settings, Dispatch Setting; key Turns_EnablePrePostInspections is stored with a trailing space | verified (REQ CC-5) | 239173635 |
| BP Web settings are cached 5 minutes in BPInfo and 30 minutes in the tracker (Chipmunk's 5 minutes in the tracker); POST Monitoring/ResetSettingsCache clears the tracker cache for Override and ChipmunkDashboard roles | verified (ENG-229, ENG-2019) | 239173635 |
| A new setting an app has never read costs an app release; flipping an existing one does not; the tracker's minimum app version is a compile-time constant | verified (REQ §11.5) | 238321683 |
| Defaults today: Turns_EnableRidership off, Turns_EnablePrePostInspections off, TurnsSubstitutionsEnabled off, TurnsEnableBlackoutWhileMoving off, ChipmunkShowBusLocation on, Chipmunk_BPWebAlertsEnabled off, ChipmunkParentMessages off, ChipmunkShowStudentScans off, ChipmunkShowStudentSeat off, Subscriptions_RouteChange off, bus / school / general notice switches on, Subscriptions_TargetedNoticeEnabled on, Disable_Parent_Emails off | Today (settings catalogue 2026-09-25) | 238321683 |
| A BPWeb district setting change takes effect within about 5 minutes (cache invalidated on SettingsChanged); a tracker setting is cached 30 minutes | verified | 239108098 |
| Settings live in 36 tables and files in nine families, about 1,996 catalogued (BP Web 932, Pro 259, Trackers 110, Quick 84, Fleet 128, Trips 113, PM 21, GPS readers 189, config files 160); 145 look like credentials by name | verified (pattern counts, approximate) | 238321725 |
| A BP Web setting change lands on the next read after SettingsChanged in BP Web, within 5 minutes in the apps through BPInfo and within 30 minutes in the tracker copy; tracker settings within 30 minutes or at once after ResetSettingsCache; landing time is unknown for Pro, Quick, Fleet, Trips, PM and readers | verified / unknown | 238321725 |
| BP Web defines 795 keys in code (33 are SSO templates expanded three times per provider) and adds missing rows on demand; the keys Turns_EnablePrePostInspections and Alerts_HideTestsFromPublicPages are defined with a trailing space so default and stored row may never match | verified; trailing-space effect is a lead | 238321725 |
| Pro's xGeoSetting is per database (a new set every school year), has 143 declared keys but 259 rows in the copy, no descriptions, and only some keys in File > Settings; the trackers' 110 keys have no screen anywhere (SQL or an upgrade step) and a district has two trackers, so one key can hold two values | verified | 238321725 |
| Quick has 57 setting keys (int-keyed Setting table plus SSOSetting and service settings); a new key becomes a row only when its screen first loads it (e.g. Disable_Parent_Emails, Dispatch_Notification_Retention_Days, Stop_Time_Change_Tolerance_Seconds); Fleet has 82 keys at fleet-main across Setting, ServiceSetting, ExportServiceSetting, SSOSetting | verified | 238321725 |
| Password rules, three SSO provider slots, website addresses, map tiles and BP Info credentials are set separately in BP Web, Quick and Fleet with no link; no settings table records who changed a value except Fleet's ExportServiceSetting and PM's perfMgmt_Setting | verified | 239534081 |
| A new setting key needs an app release for Turns, Subs, Chipmunk and Delays because each app reads a fixed list (the original Turns settings call returns booleans by position); Turns ClientSettings and Chipmunk XamSettings are device copies of BP Web settings | verified | 238321725 |

### Employee app (1)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| No employee app exists; drivers have no app of their own; the app has no tables of its own | verified (WK-3) | 238223417 |

### Ride Support (1)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| No product records a student's behaviour today: no behaviour code in Turns or Chipmunk (Apps dev 7bfa58ff) and no behaviour record in BPInfo, BP Web or Quick (main e60a6e87) | verified | 239337479 |

### Dashboard (1)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Platform analytics stop at 50 seconds and some whole-fleet reads time out for one day at a large district; Analytics page is linked only from the developers' home; two definitions of a serviced stop exist (Analytics: visited + checkpoint + stop; GPS+ compare: checkpoint + stop); school users get district-wide analytics; GPS+ thresholds default 5 minutes early or late; path corridor 150 m (ENG-1906) | stated as today (Q180-Q191) | 239304705 |

### Training module (1)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Today the training module exists only as a browser prototype storing data in localStorage with its own drivers and buses; nothing on a server; a cleared cache loses the data; a class logged there never reaches Pro | verified — memory | 239403072 |

### Training mode (3)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| No product has a training mode today; new staff practise on the live system | verified | 239173635 |
| No product has a training mode for staff; Chipmunk's demo mode only shows the app | verified read-only (v0.30) | 238845954 |
| No BusPlanner product has a staff training mode (main 26919bc6; Apps dev 7bfa58ff) | verified | 238747676 |

### Time & Attendance (9)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Since July 2026 Turns has Clock In / Change Job / Clock Out against BP Unified, off by default (BPUnified_URL, BPUnified_ClientCode, BPUnified_TimeAttendanceEnabled in BP Web); nothing is queued offline and a geofence can refuse a clock action; PIN auth endpoint is anonymous with header X-Client-Code | verified in the app; backend open | 239173656 |
| ta_absence holds one row per day with hours and carries Pending / Approved / Rejected through approval steps; new platform copies Pro's bell rows per school with type AM/PM or Noon since ENG-2279 | verified (unified schema v7.22; migrations 64-66) | 239304705 |
| WK-16/WK-17: Turns Clock In/Out talks to BP Unified with an employee number and PIN and uses BP Unified's own employees, jobs and bus list, unlinked to Pro; the driver picks the bus separately for Clock In, the Turns GPS mapping and the inspection and nothing checks they agree | verified in the app; backend open | 238682115 |
| WK-18/WK-19: a clock action with no signal returns "can't reach the server" and is not queued (manual redo); a geofence refusal (HTTP 422) leaves the driver clocked in when clocking out away from the yard | verified in the app | 238682115 |
| WK-20/WK-21: job codes are picked by hand and nothing links a job to a run, Dispatch change or trip; PIN sign-in is rate-limited to about 20 requests a minute (scope unknown); T&A on without a client code shows the driver "app not configured" and tells the office nothing; the session token lasts about 5 minutes | verified absence; rate-limit scope is a lead | 238682115 |
| The PIN check is POST {BPUnifiedUrl}/api/ta/timescan/auth/pin with header X-Client-Code and is anonymous; the Turns client is MauiTurns/Turns/Services/TimeAttendance*.cs | verified | 238485608 |
| T&A keeps its own people, jobs and buses, and the driver picks a bus two or three times from different lists (WK-16, WK-17) | verified / lead | 238485608 |
| Clock events need a signal and nothing is queued offline; a geofence can refuse a clock-out after a roadside breakdown (WK-18, WK-19) | verified (WK-18) | 238485608 |
| The PIN check is limited to about 20 requests a minute; if counted per yard, 40 drivers at 6:00 are told to try again (WK-21) | lead | 238485608 |

### Performance Management (2)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| PM reads BPInfo Operator/Get and IncidentCount/Get using its own BP Info credentials held in perfMgmt_Setting; it has 24 perfMgmt_ tables and 13 upgrade steps | verified | 238387286 |
| Contract managers cannot see failed checks or grounded buses on a contractor's buses (0% visible) | assumed | 238387286 |

### Assistant (3)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| AssistantAppRole opens BusStop, District, Eligibility, Equipment, Grade, Notification, Operator, Route, Run, Student, TravelCode; plan data only | verified | 239173656 |
| Assistant shows routes, runs, stops, schools and students as planned only: no live bus, no ETA, nothing for mechanics | verified (Assistant guide 2026-02-17) | 238223417 |
| Assistant has no database of its own and reads through BPInfo with AssistantAppRole, which appears in 25 Authorize declarations on 11 controllers; its source is not in the Apps repository | verified | 239534102 |

### Users & Access (13)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| Unified schema v7.22: usr_user has email and no phone; usr_user_entity_scope scopes by program, vehicle, location, department (not school or route); only veh_vehicle.vehicle_wheelchair exists for equipment; veh_employee_vehicle carries effective and retire dates | verified (schema v7.22) | 239304705 |
| The platform limits a person to their schools by school grants: a grant on the school or its district, and no grant sees nothing (SqlScopeHelper.cs) | verified — BusPlannerUnified 2026-10-22 copy | 239108122 |
| Platform analytics give a school user the whole district's figures by decision (only on-time by school is narrowed); the Live Viewer limits buses by operator and depot grants, so a person with school grants alone sees no buses | verified — IStopClassificationService.cs:275-276, GpsLiveFleetProjection.cs:349-378 | 238583811 |
| The platform's Admin role does not pick up a new permission by itself: each needs its own grant (migration 69); a person's own UI choices live in usr_user_preference | verified | 238551042 |
| WK-2: a Turns or Subs account can be limited only by districts, schools, grades or operators; there is no per-driver route scope, so a sub gets all routes only through an account with no operator limit | verified; still true | 238682115 |
| WK-4: retiring a driver in Pro (Active cleared or RetireDate set) closes none of the Turns/Subs account, T&A PIN, BP Web driver account, Fleet user or Trips employee; offline Turns sign-in accepts any credentials matching the saved ones without asking the server | verified; still true | 238682115 |
| Today Users, Roles and Customers sit under Time & Attendance → System in app.busplanner.ca | reviewed live 2026-10-26 | 237043713 |
| Today there is one Admin role for BusPlanner staff and customers alike with every permission in every product, and BusPlanner staff accounts show in customers' user lists | reviewed live 2026-10-26 | 237043713 |
| Today sign-in is Email → choose organization → password with no "Forgot password?"; clicking your name does nothing and there is no profile or self-service password change | reviewed live 2026-10-26 | 237043713 |
| Today Add user is a right-hand side panel with one long form including Roles, Customer / Department / District / Operator / Depot access, 125 school checkboxes and 75 "Direct Permissions (override)" checkboxes | reviewed live 2026-10-26 | 237043713 |
| Today's password rule is at least 8 characters and 1 digit ("Min 8 chars, 1 digit required") | reviewed live 2026-10-26 | 237043713 |
| Today the Users table shows Email, Name, role code (e.g. GPS-PLUS), Created and a red Delete on every row; Roles lists about 75 raw permission codes; no bulk add; Departments live inside Time & Attendance (ta:department:*) | reviewed live 2026-10-26 | 237043713 |
| Passwords are per organization: client_registry.BPUsers has one record per email and organization and the password is checked against that organization's database | stated as current data model | 237043713 |

### GPS+ (18)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| The ETL loads Pro's plan into the new platform nightly and does not see rows deleted in Pro; GPS+ Live Viewer's ETA covers only the next stop; pln_user_student tables exist with no code (no parent ETAs, pushes or accounts built) | stated as today (Q277, Q278) | 239304705 |
| New platform GPS reader reads Geotab, Zonar, Synovia, GTS and Samsara every 20 s by default; stop classification runs every 30 s into `gps_stop_visited`; ETL loads Pro's plan nightly; no parent ETA, pushes or accounts are built there | verified (BusPlannerUnified copy 2026-10-22) | 238518317 |
| GPS+ keeps per stop per day the best sample (gps_stop_visited: drive-by, visited, checkpoint, stop, with door and stop-arm readings) and per route per day the share of positions within 150 m of the planned path | verified — GpsPlus-Compare-Contract.md | 238583811 |
| GET api/analytics/otp (ENG-1910) counts early / on time / late per stop, run, route or school over a range, leaving out no-GPS days; late = at or past the Live Viewer's Late threshold, early = at or before GPS+'s Early threshold; a stop with no schedule is counted apart, never as on time | verified — OnTimeClassification.cs:11-29 | 238583811 |
| The on-time engine counts every planned stop (rider stops included) and its per-school figure counts every stop whose riders attend that school; it uses each stop's scheduled time, not bell times | verified — IStopClassificationService.cs:253-270 | 238551042 |
| GPS+'s time at a stop is the moment of strongest evidence, later than true arrival by the dwell, so on-time can overstate lateness (arrival times ENG-1322 not built) | verified — GpsPlus-Compare-Contract.md:50 | 238551042 |
| Early and late thresholds default to 5 minutes each (EarlyThresholdMinutes, LateThresholdMinutes), shared with the Live Viewer, and no screen exists to change them (migrations 36 and 75) | verified | 238551042 |
| GET api/analytics/path-deviation (ENG-1906) gives per route per day the share of GPS points outside a corridor around the run's planned path (pln_run.path; default 150 m, allowed 10 to 2,000 m), counting only each run's planned window widened by 20 minutes; a route-day with nothing measured is blank, never 0% | verified — IStopClassificationService.cs:210-242 | 238583811 |
| GPS+ judges stops every 30 seconds by default; StopOutcome treats stop and checkpoint as serviced, visited as probable, drive-by as skipped, no row as not seen | verified — BPStopClassificationService README; StopOutcome.cs | 238583811 |
| Analytics counts "visited" as serviced too (servicedPct), so the platform has two definitions of serviced (Q187) | verified | 238583811 |
| A bus or driver change made in GPS+ goes to BP Info and returns through the GPS substitution import about 5 minutes later; the import names itself not a person and leaves the reason empty; the person is only in the application log | verified — RouteManagementController.cs, GpsVehicleSubstitutionService.cs, SnapshotRowCopier.cs | 238583811 |
| The day's plan carries each substitution with source, reason and time (pln_route, pln_run, pln_stop, pln_substitution_reason), but today only the GPS substitution import writes those columns | verified — unified schema v7.22 | 238583811 |
| Platform analytics filter by route, run, school and GPS provider only; only the Live Viewer's counts take a depot and an operator | verified — IStopClassificationService.cs:464-473, Query.cs:727-737 | 238583811 |
| GPS+ exports its grid in the browser (server-side export ENG-1324 not built); Analytics' stop export runs on the server as CSV or JSON; browser CSV neutralises a value that would start a formula; the platform has no Excel library | verified — StopClassificationController.cs:274-286, gpsplus/shared/csv.ts | 238551042 |
| Not built today: arrival and departure times (ENG-1322), unscheduled stops (ENG-1320, ENG-1321; GPS+ cannot store a stop it cannot match to a planned one), depot and operator filters on past days | verified | 238583811 |
| Platform analytics stop at 50 seconds; some fleet-wide reads already time out for a single day at one large district; fleet-wide path deviation is kept to a few days at a time | verified — Infrastructure/Services/CLAUDE.md:810-817 | 238583811 |
| Today route mapping is done in BP Pro and mirrored in BP Quick as route → GPS device, with three Quick modes (Assignment, Temporary Substitution, Permanent Change); Pro can search by vehicle or route, Quick cannot | stated as current | 238518274 |
| In the New World, PlnRoute carries VehicleGuid inside a read-only ETL-fed plan snapshot from Pro, GPS unit → vehicle is dev_vehicle_device, and the Live Viewer's Route Management action POSTs to BP Info; no editable dated vehicle → route table exists | stated as current | 238518274 |

### Redistricting (3)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| B6: both Boundary Optimizer Optimize() paths crash (back() on empty vector) when a selected school offers no grade held by any selected student and UseMaxDistance is false (the default); B7: Recluster swallows MoveStudent failure in release; B9: Show Boundary Coverage reads its Public radio pair wrongly | verified | 238321767 |
| Capacity Analyzer counts Main + Other1 / 2 / 3 enrollments active at the DB active date against a single whole-school School.Capacity; blank capacity becomes 0 and shows 0% utilised; Boundary Optimizer SetSchools aborts the whole run if any school has no capacity, and capacity 0 divides by zero | verified | 238321767 |
| Boundary Optimizer "Save boundaries as active" defaults off, so proposed boundaries are stored inactive and ignored by eligibility; Population Summary counts current-year grades and the headcount changes with the pivot dimension | verified | 238321767 |

### Other (5)

| Rule (shipped) | Evidence | Page id |
|---|---|---|
| BP Unified v7.22 has no column for the special-education flag or the eligibility / travel codes, no seat table, no language and no phone number on usr_user, and usr_user_entity_scope has no SCHOOL entity type | verified | 237928473 |
| In BP Unified a scan names a card, not a student (pln_ridership_scan with pln_student_card_assignment); pln_student.student_id is the SIS ID and external_guid is Pro's StudentGUID | verified | 237928473 |
| BP Unified table conventions (as dsp_ and trn_ tables follow): <table>_guid key, customer_guid tenant, UTC DATETIME2, is_deleted soft delete, row_version, upper-case enum codes with CHECK, MigrationTool up/down pairs | verified (the prototype's migrations 11 to 26) | 237928473 |
| usr_user_preference category check allows NOTIFICATION, THEME, SORT, FILTER and GRID only (no PROFILE) | lead (stated in Q-E9, not tagged) | 239337500 |
| The platform's home-page cards (client/src/microapps) have one card so far, for overtime; the platform already uses "dashboard" for its dev home page (/dashboard) and for T&A's home (TADashboardPage) | verified | 238551042 |

## 5. TO-BE (proposed) behaviour: NOT SHIPPED

Everything in this section is a proposal, a prototype result or a "local version". Do not test it against a released build and do not report its absence as a bug. 680 rows.

### System-wide (27)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Summary targets: 100% of failed checks reach Fleet within 5 min; 0 held notices expire unwarned; families told of a bus swap once in their language; 0 retired people in pickers; Dispatch changes reach the tablet within 60 s; 5 of 5 sign-ins closed within 15 min of retiring | Summary (assumed targets) | 239140866 |
| Parents see every change within one refresh (ChipmunkRefreshRate, default 60 s) with the same words in email, push and in-app | SY-8 | 239140866 |
| Every device record carries deviceTime, the door stamps serverTime; a gap over 120 s is flagged ("tablet clock wrong") | SY-9 / IC-2 | 238321683 |
| Hand-off feed: at-least-once delivery, order per subject, kept 35 days (older cursor gets HTTP 410), consumers poll at least every 30 s, publish-to-readable 5 s p95, end-to-end under 60 s | IC-3 | 238321683 |
| Errors return HTTP status plus {code, message, retryable, correlationId}, never an empty list; writes take Idempotency-Key (repeat within 24 h returns first result); reads page by cursor (max 500) and return asOf | IC-4 | 238321683 |
| Server supports the current app version and the one before for 180 days; each app ships a read-ahead release before a feature is switched on | IC-5 (Q25) | 238321683 |
| Every new feature has a district switch named Product_FeatureEnabled; a feature that sends to families or drivers starts off; turning off hides and stops sends but never deletes data; a build check fails on unregistered settings or permissions | IC-6 / SP-R16 | 238321683 |
| Offline retries back off from 1 s to 5 min; device makes the IDs; device shows "saved" vs "sent"; late items accepted and flagged late | IC-9 | 238321683 |
| Messages at grade 6 or below, max 12 words per sentence, no codes or GUIDs, colour never the only sign (blue = fine, orange = attention; red only for Turns urgent banner and Emergency), light and dark look per person | SY-6 / §9.1 | 239271938 |
| Open decisions affecting tests: Q6 one tracker or two; Q10 Chipmunk vs Delays subscriptions; Q27 district time zone and evening cutoff; Q31 which GUIDs survive rollover; Q60-Q63 nightly copy removal; Q252 how districts install Turns | Q6, Q10, Q27, Q31, Q60-Q63, Q252 | 239173635 |
| Every product section carries a QA test table code-QA-nnn after its acceptance criteria, with every criterion covered by at least one test | §8.0.6 | 238321683 |
| Phase A (proposed 2026-10-30): IC-1 to IC-11 approved, interface catalogue frozen, stubs and contract tests for IF-BI-21 to IF-BI-24 and IF-LT-20, settings catalogue curated | Phase A | 238518296 |
| Phase 0 (2026-12-11) fixes today's paths: BI-R1, GI-R1-R5, GI-R8, LT-R9-R11, SS-R2-R4, SS-R8, BW-R4, DS-R1, DS-R3, DS-R14, TU-R5, GI-R14 work-phone fix; exit = listed ACs pass at a pilot district | Phase 0 | 238518296 |
| Phase 1 (2027-02-26) hand-off feed, people and bus registries, one effective-bus rule, training mode in Dispatch / Quick / BP Web, feature switches, one role model; Phase 2 (2027-04-30) safe moves and Fleet loop (FT-R1 to FT-R30) | Phase 1, Phase 2 | 238518296 |
| Phase 3 (2027-05-28) driver channel, PIN sign-in, live bus, Ride Support step 1, emergency button and empty-bus check; Phase 4 (2027-06-25) parent channel; Phase 5 (2027-12-10) Trips, T&A, training, Workflow, PM; critical path A -> 1 -> 3 | Phase 3, 4, 5 | 238518296 |
| Every flag starts off for existing districts with an owner and a planned default-change date; a feature that sends to families or drivers starts off | IC-6 | 238518296, 239304705 |
| No parent- or driver-facing feature is switched on at a district in the 3 weeks after its first day of school or during rollover (assumed, confirm with CS); server-only changes ship without a store release | §10.1 | 238518296 |
| Target is 60 seconds from change to screen, not real time; eight settings stores stay; two trackers stay; no product reads another's database (SY-1); no message broker or webhooks, products poll the door | §12.2, §12.3 | 238452749 |
| Every requirement has acceptance criteria and every criterion a QA test (Given / When / Then, with a "Connected" type checked in the receiving product); v0.80 added 1,404 QA tests and 131 ACs | §8.0.6 | 239304705, 238845954 |
| People are matched by ID, never by staff number or name; one owner per setting, copies elsewhere read-only; roles are district-built sets of permissions with scope, no feature checks a role's name | IC-1, IC-6, IC-11 | 239304705 |
| No nightly copy: live Pro is the one plan, changes reach readers through a change feed (plan.changed, polled 30-60 s proposed); an undated Pro change to a run that runs today starts next service day unless "Apply now" | SY-24, GI-R17, Q60 | 239304705, 238845954 |
| Colour never carries meaning alone and never red against green: blue = fine, orange = needs attention, each with a word and mark; no exclamation marks in labels; light and dark look per person; urgent driver banner is the one red exception | §9.1, DS-R40 | 239304705, 238845954 |
| Server supports the current and previous app version for 180 days (Q25); offline sign-in lasts 12 hours by default (Q26); "just today" cutoff 20:00 in a district time-zone setting (Q27); hand-offs kept 35 days in BP Web's database (Q20) | Q20, Q25, Q26, Q27 | 239304705 |
| Q168 (open): until trackers, Turns and the parents' app read the day's snapshot, districts must be told V1 changes do not reach tablets or the app; Q231 (open): bulk add all-or-nothing vs per-rider save; Q237 (open): door rate limits unnumbered; Q209 (open): suspended name offline | Q168, Q209, Q231, Q237 | 239304705 |
| Risks that shape testing: RK-1 districts do not upgrade; RK-6 nightly copy wipes same-day work and permissions; RK-9 app version skew (old app can delete data); RK-16 turns_AllStudentStops cache holds medical and contact data; RK-20 letter names another student; RK-25 practice leaks to families; RK-26 a district needs Ride Support by January 2027 | RK-1, RK-6, RK-9, RK-16, RK-20, RK-25, RK-26 | 239304705 |
| Open: whether Chipmunk planned data updates intra-day without a tracker restart; which districts have `DispatchDatabaseGuid` set; whether the shipped Turns tablet sends runID; production AgeLimit value; driver identity model | Q1, Q11, Q12, Q17, Q18 | 239108098 |
| Phase 0 small fixes on today's paths: the offline check mapper (WK-34), blocking Delete while history exists (WK-22), bracketing the staff-list query (WK-14), warning the dispatcher before a held group expires; the stress test also defines tests DLC-1..11, DLC-E1..E10, role tests and 70 edge tests (4 hold, 14 partial, 36 broken, 8 missing), journeys J1-J24 (none holds end to end) and scenarios S1-S15; open leads: split group, vehicle-only push, re-sent scans | §9.3 item 8, §9.4 item 19, §10 | 238452770 |

### BP Pro (4)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Pro stop optimizer results offer "add these stops to runs" (small change); later the clustering engine is extracted to GEDI and exposed as `GD_BusStopOptimizer_Suggest` | R13, R14, Phases 2-4 | 238616579 |
| Undated plan change to a run running today starts next service day by default (Pro_UndatedChangeStarts: NextServiceDay or Now); Pro warns when Dispatch changed the run today | GI-R17 | 238125072 |
| Closure tool Phase 0: fix B1-B9, initialise Exclude and warn on an empty candidate set, fix Create Report headings (shared CReportableGrid; regression over six other two-heading grids and four selection gestures), add ESE radio (Include all / Regular only / ESE only), show a skipped-student count by cause | Part 28 §7 Phase 0 (0.1-0.8) | 238321767 |
| Closure tool Phase 1-3: destination-school picker shipped together with "ignore grades offered", k-best destinations (default 2, cap about 5), eligibility columns with a "policy defaulted" flag, batched distance search with a mandatory distance-parity test against current output, DB-stored Consolidation Plan, move / rename to School Consolidation Planner | Part 28 §7 Phase 1-3, §9.4 | 238321767 |

### BP Web (8)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Posting a notice with reason "Behaviour / Discipline incident" shows "Don't name a student. Every family on this route will see this." which must be dismissed first | SC-R17 / SC-A20 | 239337479 |
| New settings categories (People, BusRegistry, DriverChannel, StaffApp, Platform) show default, value, who changed it and when (georef_SettingChange); the six tracker settings are shown here; a "features by district" page lists every flag | BW-R1..R3 / BW-A3, A11, A13, A14 | 238485587 |
| Driver sync matches on DriverGuid, never deletes and re-inserts, keeps every link through a "delete existing" refresh, copies only assignable drivers, and disables a retired person's account within 15 minutes | BW-R4 / BW-A1, A2 | 238485587 |
| Bus links page with mismatch flags and one-click fixes (stale page changes nothing); staff accounts linked to staffGuid with optional two-factor; a notice publishes alert.posted, pushed to Chipmunk only when Chipmunk_BPWebAlertsEnabled is on (default off) | BW-R7..R9 / BW-A15..A17 | 238485587 |
| Ride Support menu shows only for roles with its see permission; adults-who-may-meet-the-bus requests page (refuse needs a reason; switch TransportationApproveAdults); seating editor draws the real bus and runs the seat check before save | BW-R10..R12 / BW-A7..A9 | 238485587 |
| Targeted Notices reach Chipmunk when Chipmunk_TargetedNoticesEnabled is on and messages become threads; the five role types become starter roles with no user's pages changing | BW-R13, BW-R14 / BW-A10, A12 | 238485587 |
| 39 QA tests BW-QA-001..039 (settings, driver accounts, positions, re-links, bus links, notices, Ride Support, adults, seats, messages, roles, WCAG 2.1 AA); BW-QA-030 not run and BW-QA-034 not built at the 2026-10-26 retest; risk of a child re-linked to the wrong parent | BW-QA / BW-K1 | 238485587 |
| Default set in User Manager → Edit User → Operators; reports load with Report Type = Operator and the Operator dropdown = the default, rendered on page load; --All-- cannot be a default; Route Directions by Route / by Run (condensed) first; reports without an Operator type unaffected | PROD-798 s6, s7.2, D6 | 233144322 |

### Parent Portal (1)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Where's My Bus uses live tracking by default (within 60 s; "Live location unavailable" if the tracker is down, no silent vendor fallback); a vanished child GUID is re-linked only on exactly one SIS studentId match, otherwise the parent is emailed | BW-R5, BW-R6 / BW-A4, A5 | 238485587 |

### Quick (23)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| New "Add Students to Runs" flow, 7 steps: Pick students -> Choose what to do -> Find stops -> Review -> New stops -> Pick runs -> Finish; "Select all students that match this search" across pages; soft warning above 2,000 students | R1-R6, R12 | 238616579 |
| Each run is recalculated exactly once however many stops are added (assert call count); never more than 2 concurrent recalculations; a busy path worker gives "The system is busy. We will try again." not an error | R7 | 238616579 |
| Uncertain students are not routed and appear in "Needs a look" with one plain sentence per rule S1-S11 (e.g. "A bus cannot turn around here.", "This student lives outside the school's area...", "There is already a stop here.") | R8 | 238616579 |
| Real progress ("142 of 814"), Stop keeps finished work, chunks of 10 students, a failed chunk is retried once then marked "We could not save this one. You can try again."; no rollback, writes ordered stops -> students -> runs | R9 | 238616579 |
| Results CSV accounts for every selected student (ID, name, school, AM/PM stop and run, result, reason, the start date actually applied); every write logged with labelled IDs and reason string "Add Students to Runs" | R10, R11 | 238616579 |
| Phase 1 rules: new stops go on the run immediately (start date only controls when students use the stop); students' existing day schedule is not overwritten; noon runs excluded; candidate runs ranked shortest run first and filtered to user scope; all screens at grade-8 reading level | 8.3, 8.4, G5 | 238616579 |
| Test plan: unit tests for bucketing, each skip rule message, grouping, ranking, run dedupe, bad date, fr-CA coordinates; integration for 1 / 50 / ~800 students and failure paths; load test must not starve other users of path workers; 8 acceptance criteria | 12.1-12.4, 16 | 238616579 |
| Open: whether any district needs the stop-to-run change future-dated (would need run-variation copying; must be answered before Phase 1 ships) | Q6 | 238616579 |
| One Retire button sets RetireDate and clears Active together, publishes person.retired, first shows what will close; Delete only for a record with no history; within 15 minutes the person is gone from every picker | QS-R1 / QS-A1 | 238321704 |
| Retiring a person with runs today shows "Assigned to Route N today. Reassign first, or retire from tomorrow."; a returning driver reactivates the same record and staffGuid; retirement takes effect at end of the chosen day | QS-R1 / QS-QA-004, 006 | 238321704 |
| Every training row has "completed on" and "expires on"; expiry = completion + course term unless the course type is flagged "date is the expiry"; no term shows "No expiry set" and is a warning; with two rows for one course the latest expiry counts | QS-R2 / QS-A2 | 238321704 |
| Expired Certifications report also reads the credential fields and can be emailed to the office weekly | QS-R3 / QS-A3 | 238321704 |
| Staff saves send only what changed; a save on a stale version fails naming who changed it and when | QS-R4 / QS-A8 | 238321704 |
| Staff record holds route scope (OwnRoutes / ChosenRoutes / OwnOperator default / AllRoutes) as a system extended property; People/GetStatus returns it, the PIN sign-in token carries it, and a claim outside scope is refused by the server | QS-R5 / QS-A9, A10 | 238321704 |
| Ridership API (IF-QS-02) by student, group, bus and date range in caller's scope; each day scored against that day's plan; weekends included when scheduled; "Scans are off in this district" state; week limit handled by paging; 30 school days for one student within 3 s | QS-R6 / QS-A4, A5 | 238321704 |
| Live Viewer (school) role stays and its fail-closed school-scope rule is reused by the employee app's school role | QS-R7 / QS-A11 | 238321704 |
| Bulk add students to runs: every placement runs move checks (IF-GI-05), batch saves all-or-nothing per run, one message per family held like a Dispatch change, confirmation says when drivers see riders; 300 riders across 12 runs case | QS-R8 / QS-A6 | 238321704 |
| Route & Vehicle Update records a role (driver, monitor, other) per staff-to-vehicle assignment so Dispatch shows the full planned crew | QS-R9 / QS-A7 | 238321704 |
| 36 QA tests QS-QA-001..036 cover retire, credentials and report, saves and route scope, ridership, school Live Viewer, bulk add, planned crew; retest note 2026-10-26: QS-QA-033 not run | QS-QA-001..036 | 238321704 |
| Rollout: Phase 1 QS-R1..R5, Phase 2 QS-R6, Phase 5 QS-R8; credential scan runs at 02:00 district-local; setting People_TrainingRule (BP Web); risk that existing dates convert wrongly, CS reviews course types per district first | QS-K1 | 238321704 |
| Per-user default operator set in User Access → Edit User Database Access → Scope → Operator tab: single-value picker offering only operators the user can see; ships unset for every user | PROD-798 s5, D3, D4, D7 | 233144322 |
| Reassign Dashboard loads with the Operator filter pre-selected as a dismissable chip; the Depot filter beside it must not change; with no default it loads empty; GPS Live Viewer is nice to have | PROD-798 s7.1 | 233144322 |
| A mid-session operator change lasts until reload; login or refresh returns to the default, overriding Persist Filters for the operator value; access never changes; a default removed from the access list is cleared (or ignored at load, to confirm) | PROD-798 s8, s10, D5 | 233144322 |

### Dispatch (Old World) (46)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Held notices: no default send time, author warned at 14:00 and 20:00 (banner, push, email); a colleague with DispatchSendOthers may send another's group and the log names both | DS-R1, DS-R2, Q22, Q23 | 239304705, 238419971 |
| Merge preview blocks a rider whose equipment the target bus lacks, warns on seats (e.g. 38 of 40) with a reason to accept; save is one transaction with run-version check; equipment check has three levels warn / override with reason / block, dead ends always block, override roles default none | DS-R3, DS-R4, DS-R5, GI-R7 | 238419971, 238845954 |
| A grounded bus shows "Out of service" in every bus picker; driver picker hides drivers with lapsed blocking credentials and says how many are hidden and why; lapsed training warns by default and blocks for licence and medical | DS-R8, DS-R10, Q17 | 238419971, 239304705 |
| Dispatcher wins bus mapping over the tablet until cleared or the day ends (Q4); later decision: the latest wins between a tablet sign-in and a dispatcher's crew correction | Q4, BI-R14, DS-R16 | 239304705 |
| Held group older than 30 min warns its author at `Dispatch_NotificationWarnTimes` (default 14:00 and 20:00) by Quick banner, employee-app push and email; still expires at midnight, with a next-morning summary | DS-R1 / DS-A1 | 238223396 |
| `DispatchSendOthers` lets a colleague send a held group (log names both); groups can be scheduled; with `Dispatch_SendLeadMinutes` set a group sends itself that many minutes before its run (or at once if sooner); only the net change is sent (42 -> 51 -> 42 sends nothing); Discard is logged | DS-R2 / DS-A49, DS-A50 | 238223396 |
| `Dispatch_ShowSendRunChanges` cannot be turned off while `Dispatch_SendLeadMinutes` is empty | DS-R2 / DS-QA-014 | 238223396 |
| A split shows one Send Run Changes row per resulting run, each with its own run and route; a missing engine name reads "(name unknown)" | DS-R3 | 238223396 |
| Preview before save with checks at three levels; defaults: dead ends block, rider equipment needs override with reason (role in `Dispatch_EquipmentOverrideRoles`, default none = block), seats/boundary/operator/timing warn; override is per rider, run and today only and the note is required | DS-R4 / DS-A4, DS-A17, DS-A18 | 238223396 |
| Moves are one transaction and each run carries a version; a stale save fails with "Changed by [dispatcher] at 7:04. Reload?" | DS-R5 | 238223396 |
| Every swap from any screen publishes `vehicle.substituted` once and raises one held parent change per family whose run has not finished today; a run in progress follows the handover rule (After this run default / Now = Handover pending) | DS-R6 / DS-A6, DS-A144 | 238223396 |
| Bus mappings and swaps are written to the live database so they survive the night; after `Dispatch_JustTodayCutoff` (default 20:00) Just today means the next service day | DS-R7 / DS-A9 | 238223396 |
| Driver/monitor pickers use `People/GetAssignable`, never list retired or inactive people, list everyone else with a busy tag ("On Run 7 until 8:10", still selectable) and say how many they hide and why; bus picker lists spares first | DS-R8 / DS-A7, DS-A124 | 238223396 |
| A bus or driver change publishes `itinerary.changed` to both drivers and signed-in crew; "Seen by driver" shows within 10 s of Got it; unseen 3 min before run start alerts Dispatch to call; `work.changed` goes to T&A | DS-R9 / DS-A8 (tablet and Chipmunk within 60 s) | 238223396 |
| A grounded bus (`bus.grounded`) is unavailable in every bus picker within 60 s, with Fleet's reason, until `bus.returned` | DS-R10 / DS-A132, DS-A133 | 238223396 |
| Merge, split, optimize, new run, new/removed school stop each write a Quick log line naming runs and stops by name, never by ID | DS-R11 / DS-A134, DS-A135 | 238223396 |
| Phone API (IF-DS-01, IF-DS-02) runs the same server logic, checks, versions and permissions as Quick | DS-R12 | 238223396 |
| Dispatch hands the Subscription Service the change facts (kind, scope, before/after, names, bus number), never finished text; each parent gets it in their own language with no "temporary" | DS-R13 / DS-A138, DS-A139 | 238223396 |
| A user without the Reassign permission gets "You don't have permission to do this", nothing saves and no server error shows | DS-R14 | 238223396 |
| Dispatcher roles, scopes and the service account are created in the live Pro database; Quick's database page warns when the live database is not registered | DS-R15 | 238223396 |
| Every screen naming a driver shows the day's signed-in crew (`EffectiveBus/Get`) within 60 s of sign-in, planned driver beside it when different; latest of sign-in and dispatcher correction wins; daily "who drove" export | DS-R16 / DS-A12, DS-A126 | 238223396 |
| Today page (feed): all day events newest first, refresh every 60 s, filters, export, rows kept `Dispatch_FeedRetentionDays` (35); urgent rows (emergency, child still on bus, denied suspended scan) pin at top; NOT in V1 | DS-R17, DS-R48 / DS-A13..A15, DS-A92, DS-A95 | 238223396 |
| Hand-offs page searches every met-at-bus hand-off by student, run, stop, date or driver, exports CSV, respects yard scope | DS-R18 / DS-A16 | 238223396 |
| Driver messaging both ways (off as shipped: `DriverMessaging_Enabled`); urgent unanswered after `Dispatch_UrgentMessageMinutes` (2) pushes again; receipts Sent / On the tablet / Seen; limits 300 chars and 10 messages per driver per 10 min; kept 24 months; driver groups; NOT in V1 | DS-R19, DS-R32, DS-R47 / DS-A19, DS-A43..A45, DS-A93, DS-A94 | 238223396 |
| When Pro changes the same thing Dispatch changed today, Pro's change is held and the dispatcher picks Keep mine / Take Pro's / Change it; nobody is told until the pick; a different change applies and checks re-run | DS-R20 / DS-A22, DS-A23 | 238223396 |
| Post alert button on every Dispatch page (templates Double back, Double up, Split, Bus swap, Running late; family count before Send; warns when the alert will not reach the app); saved as a BP Web notice; not in New World V1 (decided 2026-10-23) | DS-R26 / DS-A31..A34, DS-A127 withdrawn | 238223396 |
| Message families from Dispatch as a BP Web Targeted Notice; push says only "You have a new message from Transportation"; off when `Subscriptions_TargetedNoticeEnabled` is off; NOT in V1 | DS-R33 / DS-A46..A48 | 238223396 |
| Success targets: 0 held groups expiring unwarned by 2026-12-11; 0 retired people in picker and 100% of swaps messaging families by 2027-02-26; preview within 3 s; picker within 2 s; Send Run Changes list loads within 2 s with 500 groups; WCAG 2.1 AA | DS-A10, DS-A11 | 238223396 |
| QA table: 302 tests DS-QA-001..DS-QA-302 covering held notices, checks and versions, swaps, pickers and crew, log and phone, hand-offs, Pro conflicts, leave and day sheet, stop tool, history and roles, board, alerts, help, trackers, suspended riders, driver back, messages and groups | DS-QA-001..302 | 238419992 |
| Rollout: Phase 0 = DS-R1, R3, R14 (no flag); Phase 1 = R2, R6, R7, R8, R10, R11, R15; Phase 2 = R4, R5, R12; Phase 3 = R9; Phase 4 = R13; checks start at warn for two weeks per district | Rollout | 238419992 |
| HTML-version retest 2026-10-26 found partial or failing items, e.g. DS-QA-228 and DS-QA-230 fail, DS-A149 / DS-A96 / DS-A129 / DS-A130 not built | Appendix D retest notes | 238223396 |
| A change smaller than the district-configurable stop-time tolerance queues zero notifications; larger queues exactly one per affected stop | D1 | 239239170 |
| MergeRunSave, SplitRunSave and OptimizeRuns each write a Quick log entry (Category General) including the count of notifications queued | D2 | 239239170 |
| Merging two runs that share a stop gives log entries whose previous and current times come from the same run (automated test required) | D3 | 239239170 |
| If the tracker update fails (forced 500), no parent notification reaches a sendable state, or it is held until a retry succeeds | D4 | 239239170 |
| Doing the same merge twice does not email a parent twice; a second notification for the same stop and service day supersedes the first | D5 | 239239170 |
| With the tracker-status flag false at merge time, the tracker still receives the update once the connection check completes; each tracker service gets its own error slot so a Chipmunk success cannot hide a Dispatch tracker failure | D6 / D7 | 239239170 |
| Regression: Reassign notifications unchanged; a Reassign Dashboard change must not send the operator's wall-clock time as the new stop time (Zendesk 65533 fix of 2026-08-20 shipped without a test); a merge that moves a child to another run says so | D-AC | 239239170 |
| WP-0 fixes first, in order DF-9 -> DF-7 + DF-8 together -> DF-10 -> DF-11; verify a ReassignRunSave delivers an email and a substitution reaches both trackers with no "Tracker substitution error" in the Quick log | WP-0 | 237928452 |
| Hold and coalesce: with `DisPatch_Notification_Hold_Minutes` (default 0 = today's behaviour) changes are held in a sliding window (max `DisPatch_Notification_Max_Hold_Minutes`, default 30) and one email per recipient is sent with the net change for all their children; a revert sends nothing; push follows the same window | DP-1.1-1.10 | 239108098 |
| Release modes Manual, AfterLastChange, BeforeRunStart (lead default 60 min), combinable, earliest trigger wins, manual pre-empts; pending batch visible with counts and due time, with Send now and Discard; a change entered after its release time sends immediately | DP-1.11-1.20 | 239108098 |
| DP-1 acceptance: hold = 5, merge plus an edit 2 min later gives one email 5 min after the second change showing original and final time only; a change held across midnight still sends; a 2-hour service outage across a release still sends; Saturday push works | DP-1 AC | 239108098 |
| Every plan-changing action logs Route ID, Run ID, action, user and notification count; a Dispatch Change Report (with CSV export) built from the notification table shows changes with and without notifications | DP-2 | 239108098 |
| Sub drivers with a vehicle and no route appear in the Reassign Dashboard assignable panel, respect user scope, and dashboard load time does not regress | DP-3 | 239108098 |
| A dispatcher GPS vehicle change is written to the live DB too, reaches both trackers within 5 seconds, survives the mapping poll, beats a Turns mapping (test with and without runID), notifies parents, and logs outgoing and incoming vehicle IDs | TN-1.10-1.17 | 239108098 |
| To-be for moves and notices: one transaction for merge/split; a preview that runs equipment, seat, boundary, dead-end, operator and served-stop checks; a version check per run; every swap emits vehicle.substituted and names the bus from the registry; DP-1 builds on the ledger with per-parent language, weekends, a district send time (no silent expiry) and SMS; server clock rule SY-9 | SY-20, CX-18, DP-1, SY-9, EA-36.5 | 238682115 |

### Dispatch (New World V1) (57)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Linked-run change: in-progress run defaults to "After this run" or "Now" with driver handover; driver alert if not seen within 3 min; a dispatcher override beats the tablet mapping (reverses DF-11) | SY-20 (Q4) | 239173635 |
| V1 writes only to the day's snapshot, never to Pro; no "From now on"; no alerts (districts post from BP Web until the alert engine exists); Today feed, driver / family messaging and driver groups left out of V1 | DS-R50, DS-R51, Q173 | 239304705 |
| V1 greys out and locks nothing by the clock: every run of the day can be covered or changed after its start time, change applies to stops not yet serviced; V1 has no undo ("[Name] is back" and Withdraw not in V1), multi-day cover stays | DS-R29, DS-R49, DS-A155 | 239304705 |
| Board Table reads like the Excel run sheet: one line per run, Bus picker on every row, Reassign and Change on every run; OPEN routes listed first and never filtered out while Dispatch_NoDriverRunsMustBeCovered is on (default on); sections collapse with Hide / Show buttons per person, counts stay visible | DS-R29, DS-A164, DS-A167 | 239304705, 238845954 |
| Every stat card opens its rows as a sortable, filterable sheet exporting .xlsx; Needs your decision is the first card; a cover can be picked for that day, 1 week, 2 weeks, through a date, or until the absence ends, each day saved as its own dated cover | DS-R27, DS-R52, DS-R23, DS-A165-A168 | 239304705, 238845954 |
| V1 runs only the checks it has data for and names the ones it cannot ("Equipment not checked: no data"); none passes silently (Q174); PRD-dispatch-v1.md holds cases CF-01 to CF-54 and QA-001 to QA-227 | DS-R4, Q174 | 239304705, 238845954 |
| A district can go back to today's Dispatch until the end of the switch week; today's Dispatch history stays view-only and new History starts on the switch day | DS-R56, Q258, Q259 | 239304705 |
| Day sheet: stat cards, triage strip, call-outs newest first marked NEW for `Dispatch_NewCalloutMinutes` (30), filters, bell risk, printable AM/PM run sheet, week and month views | DS-R21 / DS-A30, DS-A71, DS-A107 | 238223396 |
| Leave is one record (person, date range, period, type, notes, source) up to `Dispatch_LeaveHorizon`; skips weekends and holidays; stores no runs; Requested leave shows grey and is not counted | DS-R22, DS-R30 / DS-A24, DS-A39, DS-A40 | 238223396 |
| Cover can be planned for any leave day as dated day-layer records; duration Just today / 1 week / 2 weeks / Through a date / Until the absence ends, each day previewed and unsavable days named; Copy to other days; `Dispatch_CoverDueDays` (3) feeds the triage | DS-R23 / DS-A27, DS-A119, DS-A168 | 238223396 |
| Stop tool: yellow card = run with no driver, blue = run with driver; Preview waits until every stop is on a bus; orders Own run first / Open run first / Fastest / Optimize / Manual; planner offers earlier start up to `Dispatch_PlannerMaxEarlierMinutes` (30); legs held to 2 to 15 min | DS-R23 / DS-A67, DS-A72, DS-A101 | 238223396 |
| Stop times can be edited before save; a time passing an unmoved stop is refused; Save waits until every stop has a time; preview names runs "not retimed since stops moved"; Optimize asks about waypoints (Keep / Remove / Cancel) | DS-R23 / DS-A102..A106, DS-A122 | 238223396 |
| Only school stops can be taken off a run for the day (x / Put back); riders moved to a run that does not stop at their school are flagged "Missing school stop" and Apply is refused | DS-R23 / DS-A75, DS-A109 | 238223396 |
| Cancelled is a cover choice only when `Dispatch_CoverCancelled` is on (default off), needs a reason and `DispatchCancelRun`, and holds one notice "Today run [run] is cancelled: no bus will come." | DS-R23, DS-R35 / DS-A99, DS-A100 | 238223396 |
| A leave day's runs are re-worked whenever the plan changes; planned cover turns No longer needed / Uncovered / Check times and is marked Needs review; on-leave person signing in on a bus alerts Dispatch | DS-R24 / DS-A25, DS-A26, DS-A120, DS-A121 | 238223396 |
| "[Name] is back" gives a returning driver their runs back in one all-or-nothing step: only that driver's stops leave covering runs, started runs keep their cover, a wait of 10 min or more asks Close the gap? once, families hear only net differences | DS-R49 / DS-A111..A118 | 238223396 |
| Past days open read-only; corrections need `DispatchCorrectPast` and a reason; Close the year (`DispatchCloseYear`) locks every day and builds a CSV/PDF archive; retention `Dispatch_HistoryRetention` default Forever | DS-R25, DS-R31 / DS-A28, DS-A29, DS-A41 | 238223396 |
| Unified view: every screen reads one day state; one Save opens one preview then Just today or From now on; covers and equipment overrides are never From now on; date picker offers only service days; past day Save refused; stat cards open sortable sheets that export .xlsx | DS-R27 / DS-A36, DS-A37, DS-A165 | 238223396 |
| Gantt: 24-hour timeline, rows per driver and route sorted by Driver / Route (default) / Vehicle, attention rows pinned; run blocks blue planned, orange Uncovered, slate Moved in, amber dashed Needs review; drag vertical = reassign, horizontal = retime; a leave takes only its own period's runs | DS-R28 / DS-A35 | 238223396 |
| Table: a bus picked on a row is the whole route's bus for the day (no single-run bus swap); Reassign and Change stay on every run whatever its time; for a run under way changes apply only to stops not yet serviced; Discard drops all pending edits; Run column cannot be hidden | DS-R29 / DS-A150..A163 | 238223396 |
| With `Dispatch_NoDriverRunsMustBeCovered` on (default) OPEN routes sit at the top where no filter hides them and count in Need a driver; section collapse is per person and keeps its count | DS-R29 / DS-A152, DS-A164, DS-A169 | 238223396 |
| From now on needs `DispatchFromNowOn` (starter roles Router, Supervisor); others see Just today and "Ask routing to make it permanent" (Plan requests list) | DS-R34 / DS-A51 | 238223396 |
| District cover and leave rules: `Dispatch_SubOrder`, `Dispatch_CoverHoursLimit` (warns naming hours), `Dispatch_CallInCutoff` (Late call-out), `Dispatch_ConfirmCover`, `Dispatch_MonitorRequiredCodes`; leave type visible only with `DispatchLeaveSeeReason`, others see "Out" on screens, exports and prints | DS-R35, DS-R36 / DS-A52, DS-A53 | 238223396 |
| Help Center with live settings and permissions; a release adding a setting, permission or screen without help fails the release check | DS-R39 / DS-A61..A64 | 238223396 |
| Dark mode follows the computer until the person picks; the choice follows the person; printed sheets stay light | DS-R40 / DS-A83 | 238223396 |
| A reload of the plan (nightly copy, day snapshot reload, From now on save) writes Dispatch's changes back on top in order and re-runs checks; a change that no longer fits waits in Needs your decision | DS-R41 / DS-A84 | 238223396 |
| A From now on save is refused if Pro changed the route, run or stop since the preview; nothing in Dispatch ever blocks a router's save | DS-R42 / DS-A85 | 238223396 |
| Each change for today is also sent to the trackers at save; a tracker refusal (406) shows in Needs your decision with Try again; cancelled runs leave tablets and trackers | DS-R43 / DS-A86, DS-A108, DS-A148 | 238223396 |
| While Quick's ledger and the new platform's both exist, a notice sent or discarded in one is marked so in both (matched by the `dispatch.change` eventId); a family hears once | DS-R44 / DS-A87 | 238223396 |
| Required before go-live: crew row per person, bus, day, role and period so a bus can have AM driver, PM driver and monitor (Q70 decided) | DS-R46 / DS-A89 | 238223396 |
| One kept snapshot per service day is the plan of record; Dispatch writes changes to it, never to Pro; plan vs actual is measured against the dispatcher's times | DS-R50 / DS-A128 | 238223396 |
| Notices go through the alert engine (one record per recipient, facts not words); in V1 no save sends anything to a family, driver or school and the preview says so; Families column reads "Not told" | DS-R51 / DS-A129, DS-QA-170 | 238223396 |
| Needs your decision count is the first stat card every day; every stop added, removed or retimed on a planned run raises an item; a many-day cover has one row | DS-R52 / DS-A130, DS-A166 | 238223396 |
| After V1 or not committed: driver readiness on the board (DS-R53), early dismissal days by school (DS-R54), training mode on Dispatch screens (DS-R55) | DS-R53..R55 | 238223396 |
| Migration: all dispatchers of a district switch on one switch day (not in first 3 weeks of school or rollover); old Dispatch turns view-only; unsent old notices are not sent; way back until end of switch week | DS-R56 | 238223396 |
| Risk: if trackers, Turns and the parents' app do not read the day's snapshot (Q168), V1 changes will not reach tablets or the parents' app, which today's Dispatch changes do | DS-K5 | 238419992 |
| V1 in scope: board, absences, cover and stop tool, checks and saving, day's plan of record, planned changes stay right, crew by role and period, history, permissions and settings, district switch day | §2.1 | 238157830 |
| V1 out of scope: all alerts and notices (DS-R1..R3, R6, R9, R13, R26, R44, R51), hand-offs and suspended scans (R18, R48), crew from tablet sign-ins (R16), From now on (R34, R42), driver readiness (R53), grounded buses and trip bookings (R10), hours guard and sub order, leave requests and approval, emailed summary, help and dark mode (R39, R40), phone API (R12), undo "[Name] is back" and Withdraw (R49, settled 2026-10-27) | §2.2 | 238157830 |
| Every save is for its day only (no From now on) and writes to that day's snapshot, never to Pro; a stop time set for Thu is Thu's time with the planned time beside it and Fri is unchanged; a past day never changes except by correction | DS-R50 / AC-50.1..50.3 | 238157830 |
| No notice, push, email, text or queue record leaves Dispatch on any save; every preview shows "Families and drivers are not told from Dispatch. Tell them as you do today." | DS-R50 / AC-50.4, §6.4, QA-117 | 238157830 |
| A change saved for a day whose snapshot is not loaded yet waits as its own record and is applied with checks when the day loads; if a day's plan fails to load a banner says so and nothing is lost | AC-50.5, CF-39, CF-23 | 238157830 |
| After the evening cutoff (20:00) the board opens on the next service day and "today" saves for that day, named in the preview; weekends and no-service days cannot be picked and the picker says why | AC-27.1, AC-27.5 | 238157830 |
| Nothing is grayed out or locked by the clock: any run can be covered at any time of its day (a late run may not have left); mid-run handover is not in V1; Move Route lists each run with a tick to leave behind | DS-R29 / AC-29.1, AC-29.5, CF-49 | 238157830 |
| Add Absence: Call-out is offered only for today (server refuses a call-out for another day), Leave for any later service day; a leave past `Dispatch_LeaveHorizon` is refused naming the last day; a leave starting on a past day is refused; several people can be added at once | DS-R30, DS-R22 / AC-30.1..30.3, AC-22.1, QA-038, QA-045 | 238157830 |
| End cover on the cover's card reopens the run and removes only that cover's changes (other covers' stops keep order and times; a stop moved again later goes home from where it is); this replaces undo in V1 | DS-R23 / AC-23.13, CF-31, CF-44 | 238157830 |
| A check with no data says so ("Equipment not checked: no data") rather than passing; capacity warns ("Bus 51: 61 riders, 54 seats"); overlap warns with both runs' times; monitor-required runs warn ("Run 12A needs a monitor (ESE)") | DS-R4, DS-R35 / AC-4.3, AC-4.5, AC-35.1 | 238157830 |
| Every run, cover and absence carries a version on any day; a save of several edits is all or nothing and failed edits stay on screen; simultaneous saves let exactly one through | DS-R5 / AC-5.1, AC-5.2, QA-113 | 238157830 |
| Confirmed in V1 is the office-recorded contact loop only: Not called, Left message, No answer, Accepted (tablet "Seen by driver" later); labels "CALL-OUT · 5:42 AM", "Late call-out" | DS-R21 / AC-21.1..21.5 | 238157830 |
| Conflict rules CF-01..CF-78 (A routing changes a run CF-01..25, 76, 77; B people and absences CF-26..35; C Dispatch vs Dispatch CF-36..45, 78; D day and clock CF-46..49; E later products CF-50..54; F early dismissal CF-55..61; G training CF-62..68; H switch CF-69..75): Pro's plan always loads, a touching change is never resolved silently, additions are uncovered until placed, removals leave the cover | §5 | 238157830 |
| Notable conflict rules: a bus planned on two routes at once is refused unless a planned double (CF-38); a covering driver who calls out reopens their runs, nothing is reassigned automatically (CF-30); a no-service day ends covers and offers Put them back (CF-20); a stop left with 0 riders stays (CF-16, Q171) | CF-16, CF-20, CF-30, CF-38 | 238157830 |
| Non-functional targets for the largest district (about 1,100 buses): board opens a day within 3 s, preview within 3 s, picker within 2 s, Retime / Optimize up to about 45 s, Needs your decision items within 60 s of a load; keyboard-only with "Move to..." for each drag; WCAG 2.1 AA; times shown in district time zone | §6.5 / QA-218..227 | 238157830 |
| Test district for all AC and QA: "today" Mon 9 Nov 2026, US Eastern, cutoff 20:00, holiday Wed 11 Nov, early release Fri 13 Nov, yards North and South, 3 schools, 8 buses (2 spares), 12 runs, roles Dispatcher / Supervisor / Front desk / Viewer / District admin; tests that save run on a fresh copy | §7, §8.1 | 238157830 |
| V1 QA tests QA-001..QA-304 (undo tests QA-181..193 and QA-228 withdrawn): board, absences, cover, stop tool, checks and saving, plan of record, planned changes and Needs your decision, crew, history, permissions and scope, settings, non-functional, early dismissal (QA-235..252), training mode (QA-253..272), district switch (QA-273..282) | QA-001..304 | 238911511 |
| Early dismissal (nice to have): entry by date, school and early time moves that day's PM runs by the school's difference; multi-school runs with different shifts, overlaps and planned covers turn Check times; needs `DispatchEarlyDismissal`; past days refused | DS-R54 / AC-54.1..54.13 | 238157830 |
| Before the switch day V1 opens only in training mode; from it old Dispatch refuses saves (also for a session open across midnight); a district running Turns or Chipmunk cannot set a switch day until its tracker reads V1's day; Go back offered only during the switch week | DS-R56 / AC-56.1..56.8, CF-69..75 | 238157830 |
| Open questions that gate testing: Q167 how often Pro's changes reach a day's snapshot (deletions), Q168 how trackers / Turns / parents' app read the day's snapshot, Q65 bell-time source, Q71 / Q174 check data, Q153 / Q154 cancelled and new runs in the day's plan, Q169 where permissions live | Q65, Q167, Q168 | 238157830 |
| Today page gains rows: Emergency, Child left on bus, Bus is empty, Check skipped, Urgent referral (no names), Suspended day, A suspended rider scanned (names the rider, one row per scan on), Contacts told; Dispatch_SuspendedScanRow default "denials pin"; safety rows polled every 3 s while Dispatch decides, else 15 s | §12.3 / DS-A92 / DS-A95 | 239337500 |

### Chipmunk (48)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| ChipmunkBusVisibility = DriverSelection / TimeWindow; ChipmunkBusVisibilityScope = CurrentRun (default) / WholeRoute; an open selection hides the bus 30 min after the run's last stop is served | SY-19 | 239173635 |
| Before the run starts the ETA row shows "Estimated stop time" from today's plan, then "Bus not reporting" once that time passes unstarted; a refresh never closes opened rows; Suspended tag on ETA, My Students, Alerts; pushes carry no name or personal data | CH-R1, CH-R17, CH-R18, IC-7 | 239304705, 238845954 |
| Caregiver sharing only where Chipmunk_ShareEnabled is on (default off), at most 90 days; "No scan on" needs scans on 8 of last 10 school days (Q273); re-link after rollover only on exactly one SIS studentId match (Q21) | CH-R27, CH-R30, BW-R6 | 239304705 |
| When no live ETA is available show the scheduled stop time labelled as scheduled, even when ETAs are hidden; add reason `ETAsHiddenByDistrict`; test all six empty-time paths | CM-1 | 239108098 |
| Per-parent, per-category email preferences for five categories (route changes, bussing, school, general, targeted) enforced in all four recipient paths; `ReceiveEmail = 0` still suppresses everything; upgrade changes nobody's delivery | CM-2 | 239108098 |
| District settings decide which time rows parents see; proposed as server-driven `Chipmunk_ETACardConfig` (JSON) or three booleans `Chipmunk_ShowStopServiceTime` (true), `Chipmunk_ShowRunStartTime` (false), `Chipmunk_ShowSchoolArrivalTime` (false); change effective within 5 minutes, no restart | CM-3 | 237928452 |
| App shows a per-student scannable code (Code128 or QR, default QR) that works offline; scan records ridership visible in Pro, Quick and the parent's scan list; `Chipmunk_ShowStudentScanCode` default false | CM-4 | 239108098 |
| Radius notifications only for a run the bus is currently driving; fix the first-event 10000 m reset; regressions: first stop of a run and a deadheading bus must still notify | CM-5 | 239108098 |
| ETA quality: stale ETA is cleared and never shown as live past a max age (`Chipmunk_ETAMaxAgeSeconds` default 120), vehicle size and time-of-day speeds applied, off-route flag in payload; later run-aware ETA | CM-6 | 239108098 |
| Parent can move or draw the geofence; an old app build must not delete a new-format fence; a bus 100 m away across a river must not notify; decision open between shapes and network-aware distance | CM-7 | 239108098 |
| Alert comment and reason reach the app when `Notifications_AllowCommentsSeenByPublic` is on (absent from the REST body when off), server only, no app release; push tap opens Alerts (backgrounded and cold start); optional generic alert push `UseGenericAlertPush` default false | CM-8 (WP-1 / WP-1a) | 237928452 |
| Make the minimum app build a setting; today raising it needs a tracker release and applies to all districts at once | WP / 11.5 | 237928452 |
| Before the bus reports, the ETA row reads "Estimated stop time: <time>" using the student's own stop time (day's time before plan's), switches to "Bus not reporting" once that time passes with no run started, and reads "Cancelled today: no bus will come" for a cancelled run | CH-R1 / CH-A21, CH-A22 | 238518317 |
| Every ETA shows its age; with GPS 11 minutes stale the row shows the estimated stop time plus "Live tracking isn't available right now"; offline keeps last ETA with age and "No connection" | CH-R2 / CH-A1, CH-A46 | 238518317 |
| "Bus is near" fires once per stop per run, only while the bus drives the run serving that stop today, only for stops the child uses today, and follows a bus swap | CH-R3 / CH-A23, CH-A24, CH-A42 | 238518317 |
| Alert reason and comment show when `ShowAlertReasonType` / `ShowAlertComment` (moved to BP Web, planned default on) allow; push is only "New alert from your school" and opens Alerts | CH-R4 / CH-A2 | 238518317 |
| Notice choices in Settings by type and channel per child (email categories, one push switch per type, text opt-in); each type starts on except "bus at school" | CH-R5 / CH-A4, CH-A43, CH-A44 | 238518317 |
| A parent can add several districts by Quick Code and see each child under their district, with each district's own settings | CH-R6 / CH-A3, CH-A45 | 238518317 |
| A per-student scan code (Code 128 or QR, default QR) one tap from the child's card, offline, brightened, off by default (`Chipmunk_ShowStudentScanCode`) | CH-R7 / CH-A13 | 238518317 |
| After a rollover re-key the app says "We updated <first name>'s record" (single match on SIS studentId) or "Please add <first name> again" (ambiguous match) | CH-R8 / CH-A25, CH-A26 | 238518317 |
| "Not riding today" buttons per run with cutoff `Chipmunk_AbsenceCutoffMinutes` (default 30) before the stop time, confirmation within 60 s, undo until cutoff, skip notice to the parent; off by default (`Chipmunk_AbsenceEnabled`) | CH-R12 / CH-A7, CH-A8 | 238518317 |
| Messages screen with transportation threads and school letters about the child ("I read this" where `Conduct_FamilyAcknowledge` on); reply box only where `ChipmunkParentMessages` on | CH-R11, CH-R13 / CH-A9, CH-A12 | 238518317 |
| Parents allowed portal access can add/remove adults who may meet the child; an added adult is "Waiting for approval" until transportation approves in BP Web or Dispatch (first decision wins); card shows "Met by <name> at <time>" | CH-R14 / CH-A10 | 238518317 |
| A same-day Dispatch change shows in the app within 60 s and the family gets exactly one push and one email once the dispatcher sends it; a change dated later shows on its day | CH-R15 / CH-A11, CH-A31 | 238518317 |
| An opened ETA row stays open through refreshes, tracked by child not list position; needs no server change | CH-R17 / CH-A15 | 238518317 |
| Suspended tag on ETA, My Students and Alerts with district wording/dates settings; ETA hidden by default; push body is only "There's an update about your child's bus ride"; reason never shown | CH-R18 / CH-A16..A20 | 238518317 |
| Child's card lists today's scans within 60 s; off-scan away from own stop says so; denied or undone scans are not shown | CH-R19 / CH-A32 | 238518317 |
| Beta of the new Chipmunk: district switch, optional school list, parent accepts agreement, can leave any time, same account/students, one push per alert, same ETA in and out of Beta | CH-R20..R22 / CH-A33..A41 | 238518317 |
| Sign-up with an unlinked email shows the same "couldn't find a student" words whether or not a student exists; invitation links work once, for their own email, for 14 days | CH-R23 / CH-A48..A50 | 238518317 |
| Running-late push when live ETA is later than stop time by `Chipmunk_LateNoticeMinutes` (default 10), repeat only after another such step, never from a stale ETA; ride exceptions "another bus" and "no scan on" (8 of last 10 days default) | CH-R29, CH-R30 / CH-A59..A63 | 238518317 |
| Other proposed features each behind an off-by-default switch: draw alert area (100-3000 m), bus at school line, delays/closings in Alerts, share with caregiver (max 90 days), requests from the app, more languages, usage measures (on by default, no personal data) | CH-R16, CH-R24..R28, CH-R31 | 238518317 |
| ETA answers at p95 within 500 ms at 120 requests a second for 30 minutes; screen reader reads the ETA card as one sentence; touch targets at least 44 pt / 48 dp; text scales to 200% | CH-A5, CH-A6 | 238518317 |
| 169 QA tests exist, CH-QA-001..169 (Given/When/Then, P1 blocks release, types Happy/Edge/Negative/Data/Permission/Conflict/Connected/Non-functional) covering ETA row, refresh, alerts, districts, not riding, letters, adults, same-day changes, messages, scan code, alert area, suspended tag, re-links, scans, Beta, sign-up, languages, sharing, late notice, measures; prototype retest notes list several as not run or partly passing | CH-QA-001..169 | 238518317 |
| Open questions that affect testing: one canonical door (Q6), where accounts/ETAs/alerts live on the new platform (Q277), same-day Pro changes and failed ETL load (Q278), second linked parent and absences (Q216) | Q6, Q277, Q278, Q216 | 238518317 |
| Risk: an old app binary can delete data a newer one saved (drawn alert areas), needs a minimum version | CH-K2 / RK-9 | 238518317 |
| Show the stop's own service time: header is always a time, live ETA plus scheduled time together, stop then school in travel order, labels flip with direction, unknown enum values handled, new code `ETAsHiddenByDistrict` | CM-1 (CM-1.1..1.7) | 238878722 |
| Server sends an ordered display-config list of rows for the ETA card; app renders unknown fields as nothing; `SchoolStopServicedText` replaced by typed `SchoolStopPlannedTime`; fallback config shipped in the binary | CM-3 | 238878722 |
| Per-category email opt-out (five categories, all default on, push and email independent, locked toggles shown disabled) | CM-2 | 238878722 |
| ETA quality: every ETA carries a computed-at timestamp and the app refuses one older than a configured max age; off-route indicator; route along remaining run; time-of-day speeds; vehicle size; cost-unit guard | CM-6 | 238878722 |
| Parent can move or draw the geofence; wire format additive only (`RadiusFence` beside `RadiusDistance`); old client must not delete new fences via the delete-reconcile in `UserSettings/Update` | CM-7 (CM-7.2, CM-7.3) | 238878722 |
| Minimum app version constants become settings so a floor can be staged per district | CM / WP-1 | 238878722 |
| With `Notifications_AllowCommentsSeenByPublic` on, an alert's comment and reason show in the app's alert detail on both ETA methods; with it off the comment is absent from the REST response body; server-only (WP-1a), no app release if published build is 2.11.2 or later | R1 / CM-8.1..8.3 | 238256131 |
| With tracker setting `UseGenericAlertPush` on (default off) the push body is the configured nudge ("You have an unread alert", fr/es variants); off = today's Message Type text | R2 / CM-8.4 | 238256131 |
| Tapping an alert push lands on the Alerts tab with the new alert present, from background and from terminated state, even when the ETA tab is hidden; radius and scan pushes do not deep-link; unknown type = refresh only | R3 / CM-8.5, CM-8.6 | 238256131 |
| Regression criteria for the alert work: `DoNotPushToApp` still suppresses; School/General alerts render as today with no empty Comment/Reason sections; no district sees a change while the setting stays false | R1 regression AC | 238256131 |
| Bus Pass screen: scannable symbol within 2 s on cold start with no network, brightness up/restore, never scannable outside its effective window, explanatory "no pass" state, existing scan notification fires unchanged, hidden where district has not enabled it, survives rotation/backgrounding | Boarding pass AC 1-8 | 238518338 |
| Boarding pass blocking question: which symbology and payload the district scanners decode is unknown; the prototype's symbol is a placeholder, not a real encoding; status unclear on pass identifier vs scan card id | Boarding pass Q1 | 238518338 |
| Suspended tag defaults: Chipmunk_SuspendedTag on, wording "Suspended", ETA hidden, notices = its last day, a scan denied, a scan allowed; last-day notice says "tomorrow" only when the next service day is tomorrow; letters live under "About your child" with optional "I read this" | BR-55 / CS-1..3 | 239337500 |

### Turns (59)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| "Drive another run": default any run of the driver's own operator with no approval, Dispatch told via run.claimed; route scope values OwnRoutes / ChosenRoutes / OwnOperator (default) / AllRoutes enforced by the server | SY-21, SY-22 (Q14) | 239173635 |
| Sign-in changes to username and password (reset by roles with PeopleResetSignIn); home screen opens on Routes, Seating chart, GPS, Field trips, View Directions, Run history with no Submit; bus asked when a route or trip starts; T&A PIN stays for the clock | TU-R1, TU-R40-R44 | 239304705, 238845954 |
| Tablet sends its position every 10 seconds while a run is selected (Q12); under BusUnitThenTablet the tablet feed takes over after the bus unit is silent 3 minutes | SY-18, LT-R5, CX-66 | 239304705, 238092292, 238419971 |
| Emergency button sits apart; six taps within 5 seconds send at once with no type; cannot be turned on until emergency contacts are named; no referral while the bus moves by default (district may enable Mark or flag) | TU-R31, SC-R2, Q164 | 239304705 |
| Suspended rider's scan on any bus (offline too, from the day's not-riding list of IDs and dates) sounds and offers Allow / Deny; Deny off on runs to school by default; tablet may read a student's alert facts for 15 minutes after the scan; a tap's GPS point counts if no more than 2 minutes older than the tap | TU-R19, TU-R34, BI-R16 | 239304705, 238419971 |
| A rider can be scanned off anywhere, any time; off away from own stop is kept and marked "Off elsewhere"; rider history 30 days across buses (Q125); absence cutoff 30 minutes before the stop, skip offered only for a sole-rider stop (Q49, RK-19) | TU-R33, TU-R17, Q49 | 239304705 |
| Where Conduct_MetAtBusOptOut is on, tablets show "Parent or guardian not required · opted out [date]" in place of "Met at bus" and drop-off asks no "Who met?"; new referral works before a bus is picked (rider found by route / run, name or student ID within route scope) | TU-R50, TU-R36, TU-A107-A110 | 238845954, 239304705 |
| On login Turns asks which bus and which route and submits the GPS mapping automatically; write target `Turns_SubmitMappingTo` (Live/Dispatch/Both, default Dispatch); dispatcher override wins and the driver is told | TN-1.1-1.9 | 239108098 |
| Push to the driver when an assigned run changes (within 30 s of a merge), run refreshes with a banner until acknowledged, acknowledgement visible to dispatcher; setting `Turns_EnableChangeNotifications` | TN-2 | 239108098 |
| Route-level selection with runs as a checkbox list, navigation from the bus's GPS position, inter-run and final deadheads shown; `Turns_RouteLevelSelection` default false leaves today's flow unchanged | TN-3 | 239108098 |
| Two-way dispatcher-driver messaging stored in BPWeb DB with per-recipient receipts, UTC times, retention (`DriverMessaging_RetentionMonths` 24), pushes queued while the bus is moving; needs driver identity first | TN-4 | 239108098 |
| Sign in as a person (username/password; token names the person; T&A PIN stays for the clock); five wrong passwords in 15 minutes lock for 15 minutes; offline sign-in works within `Turns_OfflineSignInHours` (default 12) | TU-R1, TU-R44 / TU-A1, TU-A90 | 238845975 |
| One bus choice per shift sets the mapping, the bus on every check and the clock-in bus; Start Driving re-sends the sign-in when the server has none or another bus | TU-R2, TU-R32 / TU-A2, TU-A32 | 238845975 |
| Dispatch and Pro same-day changes reach the tablet inbox within 60 s online, open only when speed is below 2.75 m/s or at a stop, with "Got it" / "I can't do this run" shown in Dispatch | TU-R3, TU-R13, TU-R28 / TU-A3, TU-A26, TU-A81 | 238845975 |
| Checks sent offline arrive once with bus, failure flag, notes, photos, odometer and driver; a scan sent 3 times counts once (`scanId`); a spare tablet loads who is on board from the server | TU-R5, TU-R6 / TU-A4..A6 | 238845975 |
| Tablet sends positions every 10 s while a route, run or trip is selected, buffered offline and sent newest first; target at most 15% battery and 30 MB over 4 hours | TU-R7 / TU-A7 | 238845975 |
| Starting/ending a route or run publishes the selection so parents see the bus; "Drive another run" within route scope claims a run and tells Dispatch | TU-R8, TU-R9 / TU-A70..A72 | 238845975 |
| Clock events queue offline with device time and are de-duplicated | TU-R12 / TU-A75 | 238845975 |
| Crew: sign-in attaches the person to the bus and Dispatch sees driver and added crew within 60 s | TU-R16 / TU-A10 | 238845975 |
| A parent's "not riding" report pops up when the bus is stopped; "Skip this stop" offered only when the child is the stop's sole rider (`Turns_AbsenceSkipEnabled`) | TU-R17 / TU-A11 | 238845975 |
| Driver referrals from the rider list (stopped only; `Turns_ReferralWhileMoving` Off/Mark/Rider), drafts queue offline, outcome returns as a message to the writer only | TU-R18 / TU-A12, TU-A50..A55 | 238845975 |
| Bus instructions and district not-riding list load at sign-in; a suspended rider's scan-on on any bus opens an alert offline too; list itself is never shown | TU-R19 / TU-A13, TU-A28, TU-A29 | 238845975 |
| Met-at-bus hand-off: `Turns_MetAtBusMode` Off/Ask/Require; "No adult here" keeps the child aboard and notifies contacts and Dispatch within 60 s; ID check and policy settings | TU-R21 / TU-A15, TU-A21, TU-A23 | 238845975 |
| Unrouted student scan says "not routed", keeps the scan with reason `unrouted`; withdrawn students drop off the roster and the tablet deletes non-run students at sign-in and day end | TU-R22, TU-R23 / TU-A16, TU-A17 | 238845975 |
| Driver seat map: tap-then-tap moves with seat checks, `Turns_DriverSeatEdits` Off/Suggest/Save (default Off), saved moves written to Pro's chart; office change wins a conflict | TU-R25, TU-R39 / TU-A19, TU-A22, TU-A64 | 238845975 |
| Empty-bus check at run end (`Turns_EmptyBusCheck` off/prompt/required; required blocks ending the run and sign-out); a rider left aboard raises an urgent Incident | TU-R30 / TU-A30 | 238845975 |
| Emergency button usable while moving: one tap then type with 5 s Undo, or six taps within 5 s sends at once; cannot be enabled until `Dispatch_EmergencyContacts` has a person | TU-R31 / TU-A31 | 238845975 |
| Scan a rider off anywhere at any time; Riders page on the run screen with 30-day history; on/off follows the rider's last scan, not the stop | TU-R33 / TU-A33 | 238845975 |
| Suspended rider at the door: Allow always; Deny only where settings allow (to school off, from school on by default) and needs an adult at a non-school stop; Undo 10 s; Dispatch-decides mode waits 60 s then the student rides; no choice in 3 minutes sends the push anyway; every tap logged | TU-R34 / TU-A34..A45 | 238845975 |
| Home screen after sign-in shows Routes, Seating chart, GPS, Field trips, View Directions, Run history with no Submit form; Messages, My referrals and New referral work with no run started | TU-R36, TU-R40 / TU-A48, TU-A49, TU-A82 | 238845975 |
| Deadhead and any-address directions from the bus's position, reroute within 10 s when more than 75 m off; runs still follow the plan | TU-R41, TU-R42, TU-R24 / TU-A84..A87 | 238845975 |
| Turns Beta per bus: shift keeps one version, not-ready tablet falls back with a message, driver agreement, no MDM required but screen lock needed, office can sign a tablet out remotely | TU-R45..R49 / TU-A94..A106 | 238845975 |
| Family opt-out of being met (`Conduct_MetAtBusOptOut`, off by default): tablet shows "Parent or guardian not required · opted out <date>" within 5 minutes and skips "Who met" | TU-R50 / TU-A108..A110 | 238845975 |
| 276 QA tests exist, TU-QA-001..276, covering sign-in and crew, day follows server, checks/scans/positions/clock, trips, selection and claims, absences, referrals, bus instructions, hand-offs, roster, seats, suspended rider, empty-bus check and emergency, safety labels, scan off anywhere, fan-out, accessibility, office messages, home screen, deadheads, Beta, opt-out; many marked fail / not built / not run in the 2026-10-26 prototype retest | TU-QA-001..276 | 237961219 |
| Rollout: Phase 0 offline check mapper fix (TU-R5); Phase 1 account-based crew record; Phase 3 the rest in one read-ahead release as a Beta; all flags off by default; rollback = flags off | TU rollout | 237961219 |
| Risks: MDM blocks release, battery/data from positions, drivers without a linked PIN, drivers tapping through the hand-off question, seat-move conflicts | TU-K1..K5 | 237961219 |
| All-open inspection checklist: every item's answer control visible without a tap; Picklist with 4 or fewer options is a one-tap segmented control (min 44x44 pt), 5-8 wraps to two rows, more than 8 stays a dropdown; Number uses decimal keypad | Inspection spec 2.1-2.2 / AC 1, 3, 4 | 239140887 |
| Inspection: grounding failure shown before the tap and confirmed once; any failing option auto-expands notes; "Mark all Pass" touches only unanswered items and reports the count; clean 50-item check in 3 taps or fewer; hidden DisplayCondition items not counted; submitted rows byte-identical to today's | Inspection AC 2, 5, 6, 8, 9, 10 | 239140887 |
| Inspection optional backend additions (not required): `fm_Item.RenderHint`, `fm_PicklistOption.IsFailingOption`; root cause must be confirmed against the real Turns renderer | Inspection spec 3, 4 | 239140887 |
| End-of-run check (district setting on/off, no advisory mode): when the driver ends a run, each student who tapped on without tapping off is listed with name and expected stop, and the run cannot end until each is resolved as "Still on bus" (clears only on a real tap-off) or "Manually tap off" | PROD-553 2.1-2.4 | 250740737 |
| End-of-run check applies to all runs; setting off = run ends as today; all tapped off = brief confirmation, not a modal; no routing back to stop/school; no district-facing record needed | PROD-553 2.5-2.7, 3 | 250740737 |
| End-of-run check engineering unknowns: can `FlagLeftOnVehicle` be shared, does Turns know scan direction natively, is full scan history on the device offline, can a run end early (auto / timeout / shift change), must ENG-2884 be fixed first, effect of later run end times | PROD-553 Q1-Q6 | 250740737 |
| Not-riding list (BusInstruction/NotRiding) goes to every signed-in tablet with student GUID, SIS ID, card numbers, periods, first/last/return day — no name, reason or school; loaded at sign-in and on conduct.decided; if it cannot load, header says "Not-riding list not loaded" and it retries every 5 minutes; on-tablet check under 200 ms, list for 1,000 students under 50 KB | BR-26 / ST-21 / NF-1 | 237928473 |
| Suspended-rider alert: Allow on the bus is always offered; Deny the ride only at boarding and per Turns_SuspendedDenyToSchool (off), Turns_SuspendedDenyFromSchool (on), Turns_SuspendedDenyNeedsAdult (on); Deny soft-deletes the scan on; Undo within Turns_SuspendedUndoSeconds (10); a scan off never opens the alert; no choice in 3 minutes = contacts told "no choice was recorded" | BR-51 / TU-A34..43 | 237928473 |
| With Turns_SuspendedDecider = Dispatch (default the driver) the tablet waits Turns_SuspendedDispatchWaitSeconds (60, range 15–300) plus a 10 s backstop; first writer wins; no answer or no signal = the student rides; the question is never queued offline | BR-52 / DS-A97 | 237928473 |
| Emergency button (Turns_EmergencyButton, off): one tap then a type (Medical, Accident, Safety, Security, Other) with a 5 s Undo; six taps within 5 s send at once with no type and no Undo; type page opens 1.3 s after the last tap; works while moving; on Dispatch Today within 60 s with a sound | BR-49 / TU-A31 / UC-6 | 237928473 |
| Empty-bus check (Turns_EmptyBusCheck off / prompt / required): at End run asks "Walk to the back. Is the bus empty?"; required blocks End run and Sign out; each rider left makes an urgent Incident "A rider left on the bus"; Skip when required = 409 | BR-48 / TU-A30 / ST-50 | 237928473 |
| With the bus stopped a driver picks rider(s), Referral, kind and reason (three taps) and a draft is saved on the tablet with bus, run, route, stop, time and writer | TU-R18, RS-AC-T18.1 | 239108122 |
| Turns_ReferralWhileMoving: Off (default, overlay blocks any referral screen) or Mark (one Mark it button saves a draft with bus, run, time, GPS point and no rider; reviewers see "Marked while moving"); nothing is ever typed while moving | TU-R18, RS-AC-T18.2-18.4 | 239108122 |
| With no signal, drafts and sends queue with device time (Saved / Waiting to send / Sent) and each send reaches the platform exactly once however often the queue retries | TU-R18, RS-EC-01/02 | 239108122 |
| An urgent (highest-severity) reason shows "Call Dispatch now" before the form; Concern shows the district's help text first | TU-R18, SC-R6, SC-R12 | 239108122 |
| Home screen gets My referrals (counts Not sent / In progress / Done, "1 referral not sent" at run end and sign-out) and New referral with or without a bus picked, by route and run or by name / student ID; over 50 matches shows first 50; rider on two runs asks "Which run was it?" | TU-R36, RS-AC-T36.1-36.7 | 239108122 |
| The server limits New referral's routes, runs, riders and search to the driver's route scope (SY-22) and refuses a referral carrying a run outside it; student ID shows only on a match by ID | TU-R36, RS-AC-T36.8 | 239108122 |
| Tablets load bus instructions for their runs and the district-wide not-riding list (IDs and dates only) at sign-in and on change; changes reach tablets within 5 minutes with signal; instructions follow the run so a sub sees them | TU-R19 | 239108122 |
| A scan-on, typed card or name lookup of a suspended student opens an alert with sound on any bus, online or offline, showing the district's word, name and last day, never the reason; scan-off never opens it | TU-R34, RS-AC-T34.1, RS-AC-T19.3 | 239108122 |
| Allow is always offered; Deny only where allowed: to school off by default (Turns_SuspendedDenyToSchool), from school on by default; at a non-school stop Deny asks who is with the student and "No adult" removes Deny; Deny takes the scan-on back; Undo lasts 10 s (Turns_SuspendedUndoSeconds) | TU-R34, RS-AC-T34.2-34.4 | 239108122 |
| Every door tap is logged with driver, bus, run, place, GPS, device and server times; taps arriving more than 2 minutes old are marked "late"; an offline Deny made after the bus left the stop is recorded as Allowed and the driver is told | TU-R34, RS-AC-T34.8-34.9 | 239108122 |
| With Conduct_MetAtBusOptOut on (default off) a student page checkbox with a date not later than today makes run tablets show "Parent or guardian not required · opted out [date]" in place of "Met at bus: YES"; only cnd:student:optout holders can change it | TU-R50, RS-AC-T50.1-50.6 | 239108122 |
| Rider query returns work phone when preferred, hides withdrawn students, returns unrouted students as "not routed" (work-phone fix is Phase 0) | GI-R14 | 238125072 |

### Subs (3)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Subs signs in as a person with employee number + T&A PIN when Turns_DriverSignIn is on (default off: shared account still works); a PIN with no staff link is refused "Ask the office to link your PIN"; 5 wrong PINs in 15 min across Subs and Turns lock both for 15 min | SU-R1, SU-A2, SU-A3 | 238682136 |
| A sub's swap publishes vehicle.substituted naming the person and shows in Dispatch within 60 s; a new sub defaults to AllRoutes, narrowed scope refuses other routes ("This run isn't in your routes. Ask Dispatch."); a sub added in Dispatch becomes one Pro staff record (a retired person's old record is reactivated); inbox only when DriverChannel_Enabled and signed in by PIN | SU-R2..R5, SU-A1, SU-A4..A8 | 238682136 |
| 25 proposed QA tests SU-QA-001..025 cover sign-in, route scope, swaps, new subs and the inbox; rollout Phase 3 with Turns' read-ahead release | SU-QA-001..025 | 238682136 |

### Delays (2)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| At rollover each subscription maps to the new year by stable key (SIS school ID / route ID); unmappable ones ask the parent to choose again; DelaysApp_SubscriptionResetDate is removed; DelaysUserSettings requires a device-scoped token (anonymous call refused, device A cannot read device B); list sharing with Chipmunk depends on open question Q10 | DL-R1..R3, DL-A1..A5, Q10, Q31 | 238026775 |
| 15 proposed QA tests DL-QA-001..015 cover rollover, the settings endpoint and one-list-or-two; rollout Phase 4, after every Delays version in the field sends a token | DL-QA-001..015 | 238026775 |

### Fleet (134)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Journey J7: failed "Do not drive" item -> defect.reported -> work order and mechanic notice -> bus.grounded -> Dispatch picks a spare; meter precedence telematics, then fuel, then manual (Q11); wheelchair station starts 30 by 50 in; settings Fleet_DueSoonPercent, Fleet_CheaperVendorMonths, Fleet_InputSilentDays, Fleet_UndoDays | FT-R1-R5, FT-R13, Q11 | 238092292, 239304705, 238845954 |
| Defect intake reads failed Turns checks (`GetFailedResultsSince`): one work order per bus, one line per failed item, idempotent on `resultId`; `IsNonOperable` grounds the bus | FT-R1, FT-A1, FT-A2 | 239403009 |
| A failed check becomes a work-order line within 5 minutes of submit (or reconnect) with note and photos; a check with no bus lands under "Unassigned: needs a bus" | FT-A1, FT-QA-004 | 239403009 |
| Publishing a checklist posts it through the door and publishes `checklist.published`; with the door down it waits in the outbox and is sent once | FT-R2, FT-A14 | 239403009 |
| Completing the repair publishes `repair.done`; the driver's inbox shows it within 60 s | FT-R3, FT-A4 | 239403009 |
| Grounding publishes `bus.grounded` (bus unavailable in Dispatch's picker within 60 s), returning publishes `bus.returned`; a bus on a run is marked "in service now" and nothing is swapped automatically | FT-R4, FT-A3 | 239403009 |
| Telematics meters feed reminders within 15 minutes; a lower reading is kept, flagged and unused; precedence telematics, then fuel, then manual (Q11) | FT-R5, FT-A5 | 239403009 |
| Each Fleet vehicle links to a registry `busId`; non-district vehicles need no link and are not mismatches | FT-R6, FT-A15 | 239403009 |
| Fleet's API is callable only with the door's service role; any other credentials are refused | FT-R7, FT-A16 | 239403009 |
| With `UseGeoIMS()` off Fleet runs and its screens say "Not linked to BusPlanner" | FT-R8, FT-A6 | 239403009 |
| `person.retired` closes the person's Fleet user within 15 minutes; their records stay under their name | FT-R9, FT-A17 | 239403009 |
| Faults of severity "stop" or "service soon" raise one defect line (keyed on source, code, set time); a cleared fault closes the alert, not the work | FT-R11, FT-A8 | 239403009 |
| Bus page shows daily counts and last state of door, stop-arm and light events | FT-R12, FT-A9 | 239403009 |
| Bus page gets a Seats tab with configurations, stations, lift, exits; save checks refuse a layout naming the broken rule; change in Fleet or Pro shows in the other within 5 minutes; saving publishes `bus.layoutChanged` | FT-R13, FT-A10, FT-A11 | 239403009 |
| Seat-layout limits: station clear floor 30 by 50 in to start and never under the district minimum (30 by 48 in default); lift rated load at least 800 lb, never under 600 lb; 30 in from each station to an exit door | FT-R13 | 239403009 |
| Seats retest of the HTML version on 2026-10-26: 1 QA test failed (FT-QA-041, driver tablet must refuse a station in front of the lift door) | FT-R13 retest | 239403009 |
| "Fuel and miles" panel: odometer with time and source, engine hours, 90 days of fills, mpg or L/100 km by month, kWh for electric; shown to mechanics in the employee app; drivers see odometer and next service, never costs | FT-R14, FT-R15, FT-A12, FT-A13 | 239403009 |
| Everything today's Fleet does (sign-in, roles, work orders, reminders, parts, reports, fuel import, backups) must keep working and is regression-checked every release | FT-R16, FT-A19, FT-A20, FT-A41 | 239403009 |
| Opening a work order lists due and deferred work with a tick each; due soon = past `Fleet_DueSoonPercent` (default 85, range 50–100) or inside the job's warning lead; overdue never hidden; "Do not drive" defects cannot be deferred; no second work order is made | FT-R17, FT-A21, FT-A22, FT-A36 | 239403009 |
| Work order gets a History tab (other work orders newest first, next due per job); a figure that cannot be worked out says why, never 0 | FT-R18, FT-A23, FT-A37 | 239403009 |
| Vehicle warranty (in-service date, months, odometer limit) warns on the work order; coverage ends at whichever limit comes first; technician picks Repair here or Hold for warranty | FT-R19, FT-A24, FT-A38 | 239403009 |
| Parts: cheaper-vendor flag within `Fleet_CheaperVendorMonths` (default 12, 0 = off); superseded part chain; Used on / Parts lists; core-charge flag and cores list; part photo thumbnails incl. HEIC | FT-R20..R23, FT-R25 | 239403009 |
| My Daily Work lists every open work order a technician is on; clocking into one stops the other; a technician sees only their own | FT-R24, FT-A29, FT-A39 | 239403009 |
| Fuel sources read in on a schedule; a fill read twice is kept once (source + transaction number); unknown vehicle waits in Unmatched fills | FT-R26, FT-A31 | 239403009 |
| Each vehicle has an owner; a monthly statement per owner; an outside owner sees only its own vehicles; such vehicles never reach Dispatch, Turns or Chipmunk | FT-R27, FT-A32 | 239403009 |
| A bus whose stop arm or door input is silent for `Fleet_InputSilentDays` (default 5) school days it ran goes on the fleet manager's list | FT-R28, FT-A33 | 239403009 |
| Move-in imports a district's history keyed on old numbers; a re-run never copies and never overwrites a record changed in Fleet | FT-R29, FT-A34 | 239403009 |
| A mass change is one batch that a role with "Undo changes" can undo for `Fleet_UndoDays` (default 30); later-edited records are listed and left | FT-R30, FT-A35 | 239403009 |
| Intake must handle 1,300 checks in the 30-minute pre-trip window at the largest district | FT-A7 | 239403009 |
| QA test table: 111 tests FT-QA-001..111 covering intake, checklists, repairs, grounding, meters, identity, API, standalone, faults, seats, fuel, regression of today's Fleet, due / deferred work, history, warranty, parts, technician work, fuel read-in, owners, GPS inputs, move-in, undo; types include "Connected"; P1 blocks release | FT-QA-001..111 | 239403009 |
| Rollout is Phase 2 behind `Fleet_TurnsIntake`, `Fleet_TelemetryMeters`, `Fleet_TelemetryFaults`, `Fleet_TelemetryEvents`, all off by default; rollback = flags off | Rollout | 239403009 |
| Risks: which record says "repaired" (Q8); local migrations 867–878 collide with upstream 867–869; clients on the older line; wrong layout seats a child unsafely; Pro / Fleet layout drift; move-in key reuse; undo restoring relied-on values | FT-K1..K7 | 239403009 |
| Local build totals: migrations 867–878 (next free 879), settings keys up to 90 (next free 91), permissions 110000–110021, 53 unit tests (34 due-ness + 19 publish payload); 12 of 18 sections not fact-checked | W01–W18 | 238288898 |
| Local build does NOT fix the Miami production issues (MIA-01..27), the Fleet priority list (ENG-987..1002) or shop requests FR-05..FR-10, and nothing may be reported as fixed | Change spec §2 | 238288898 |
| Reminders gain last-service odometer and hours anchors (migration 869) so meter reminders roll forward after service; a no-edit save must leave all four anchor values unchanged | W01 | 238288898 |
| Known local defect: editing or creating a reminder from the vehicle screen's Reminders tab still wipes both meter anchors and LastServiceDate | W01 open residual | 238288898 |
| One due-ness calculation (`ReminderDueness`) feeds the Reminders list, vehicle Reminders tab, create pane, Reminder Calendar, dashboard widget and auto-create; no anchor prints blank, never 0% | W02 | 238288898 |
| Due-ness rules: target = anchor + interval; Month / Week intervals counted in calendar time, Day intervals in working days; open work order = status NULL, Open, InProgress / "In Progress", OnHold; Inactive and Voided do not suppress | W02 | 238288898 |
| Projection limits: rate window 180 days, minimum span 14 days, meter older than 30 days = "MeterStale" with no estimate; new settings 86 (hours before, 25), 87 (hours after, 10), 88 (calendar shows meter axes, true) | W02 | 238288898 |
| Behaviour change on upgrade: auto-create starts raising work orders (was creating none) and `ServiceSettingKey.DaysInAdvance` (default 7) becomes inert; creating twice returns "already covered by open work orders" | W02 | 238288898 |
| Not done locally: percent-due sorting still uses the old expression; "upcoming only" on the vehicle tab uses old logic; report queries (`SqlReportQueryVM`) not migrated | W02 | 238288898 |
| Create pane lists due and approaching jobs per axis with a verdict; overdue bold with an Overdue pill; covered jobs counted in a footer with work-order numbers; on error the pane clears and says so | W03 | 238288898 |
| Known local defects in the pane: suppressed count also counts inactive / ended reminders under the "open work order" label; two reminders on the same vehicle and task share one checkbox id; new strings are English only | W03 | 238288898 |
| Service History tab on work-order Edit: Upcoming maintenance + other work orders newest first, capped at 50 with a truncation note, location-scoped, no interactive elements; never-InProgress shows blank shop days | W04 | 238288898, 238845996 |
| Known local gaps in History: badge counts all work orders (unscoped, uncapped) while the table is scoped and capped; Voided work orders accrue shop days forever; location-restricted path never tested | W04 | 238845996 |
| Warranty banner on work-order create only: amber when under warranty, blue when out; time expires the day after the expiry date, odometer expires at >= the limit; no warranty recorded shows nothing | W05 | 238845996 |
| Known local gap: there is no screen to enter warranty data (SQL only), the banner is advisory and saves nothing, text is English only, server date with no time zone | W05 | 238845996 |
| Inspections: seeded 60-item school-bus safety form (sections A–F: 21 / 5 / 8 / 13 / 10 / 3); items Pass / Fail / NA; result derived by server (Fail if any item fails); photos up to 20 MB, images only, served with 7-day private cache | W06 | 238845996 |
| Inspection completion is refused ("Saved, but not completed") when a required photo is missing; out-of-range numeric readings fail the item automatically | W06 | 238845996 |
| Known local defects: a CameraOnly form still shows the photo-library input on a new inspection until saved; performing an inspection is gated on INSPECTION_VIEW, not INSPECTION_CREATE; vehicle picker lists all non-archived vehicles | W06 | 238845996 |
| Criteria builder: forms with jurisdiction, cadence (PerTrip, Days, Months, Miles, EngineHours), photo policy, versions; items typed PassFail, Numeric, Text, Choice, Signature; severity defaults to Deferred and any other value is coerced to Deferred | W07 | 238845996 |
| Known local defect: cloning or versioning a form does not copy `FailureSeverity`, so every Ground criterion silently becomes Deferred in the copy | W07 | 238845996, 238911532 |
| Not built in the builder: per-item edit (delete and re-add), drag reorder, whole-form delete, real jurisdiction templates; an item with recorded results cannot be deleted | W07 | 238845996 |
| Completing a failed Fleet inspection raises one work order per vehicle, one line per failed item, description "N defects from vehicle inspection"; repeat raise returns "This inspection has already raised a work order." | W08 | 238911532 |
| Grounding is per failed criterion ORed with the inspection-level out-of-service flag (can only ground more); the work order is stamped `VehicleOutOfService` | W08 | 238911532 |
| Known local gaps: Turns DVIR source throws NotImplemented; raise is not transactional (a part-way failure can produce a second work order); nothing clears out-of-service or blocks dispatch; a vehicle with no resolvable location is skipped | W08 | 238911532 |
| A failed inspection notifies every non-archived user holding INSPECTION_FAILURE_NOTIFY: bell with unread count on next page load (no polling), up to 8 alerts, inbox at /Notification/Inbox, Acknowledge separate from read and never overwritten | W09 | 238911532 |
| Each notification writes two queue rows (InApp sent, Push unsent, Test = 0 on both); there is no sender, no email, no phone push; with no audience it logs and raises nothing | W09 | 238911532 |
| Work Order Changes report: every part add / change / remove and labour hours change with who, when, cost delta, optional reason; labour flagged when entered hours differ from the clocked span by more than 0.05 h; default window 30 days, cap 500 rows | W10 | 238911532 |
| Audit sign-off needs a ticked confirmation and cannot be overwritten ("that change had already been signed off") | W10 | 238911532 |
| Known local gaps in audit: VRO (purchase-order-backed) parts are not audited; a part removal cannot carry a reason; every save writes a row even with no change; REVIEW permission is not enforced; "needs attention" filter runs after the 500 cap | W10 | 238911532 |
| Inspection messaging: a mechanic asks the inspection's submitter (by name), replies fan out to the shop by permission; body max 2,000 characters (refused, not truncated); states Seen / Queued / Sent, not yet seen; reaching a Turns-only driver is not built | W11 | 238911532 |
| Open decisions that change test expectations: which shop asks come before go-live (Q260), fuel-system APIs (Q262), where the layout lives (Q59), whether Voided is terminal, whether badge should match pane, release note for reduced PM work-order volume | Q59, Q260, Q262 | 239403009, 238288898 |
| P0: Vehicle detail shows last GPS position and reading age for a Geotab-matched vehicle, a clear "not GPS-equipped" state when unmatched, a degraded panel (page still renders) when the LIVE_ bridge is down, and a deep-link to the Live Viewer | Integrations Phase 1 P0 | 239009796 |
| Recommended design: Fleet reads telemetry already landed by BPGeotabReader over the existing bridge, holds no Geotab credentials and makes no second Geotab API consumer; read-only, no write-back | Integrations Phase 1 | 239009796 |
| P0: scheduled odometer ingestion writes one VehicleMileageReading per new reading with DateRead = telemetry time and UserId = service identity; idempotent on vehicle + DateRead | Integrations Phase 2 P0 | 239009796 |
| P0: reading older than latest is flagged Overwritten or skipped; negative delta or jump over threshold is stored with Ignored (visible, not discarded); miles vehicles store miles; hour-meter-only vehicles get no odometer row; manual entry takes precedence | Integrations Phase 2 P0 | 239009796 |
| P1: engine hours ingestion (needs Ignored / Overwritten migration on VehicleOperatingHoursReading), stale / rejected exception report, per-district telemetry-vs-file precedence toggle; P2 retire fuel-importer mileage columns | Integrations Phase 2 P1/P2 | 239009796 |
| P0: IPartsVendorProvider with one adapter; live price / availability with timestamp, fallback to cached CostPerUnit labelled as cached when the vendor API is down; PO submitted on a status transition with no duplicate order on resubmit | Integrations Phase 3 P0 | 239009796 |
| P0: catalogue sync matches on ManufacturerPartId / SKU, keeps prior cost recoverable, queues unmatched vendor parts for review (no auto-create); invoice variances flagged for a human; humans approve every PO | Integrations Phase 3 P0 | 239009796 |
| Targets: 90% or more of Geotab vehicles with a reading in the last 24 h at 30 days; PM reminders on stale odometer down 80%; fuel / odometer tickets down 50% | Integrations metrics | 239009796 |
| Open blocking questions: how a Vehicle is matched to a Geotab device, which service identity writes readings, the plausibility threshold number, which parts vendors / API shapes, PartVendor price history model, districts running Fleet without the transportation product | Integrations open questions | 239009796 |
| Inspection message rules: body over 2000 chars or empty is refused with a banner and nothing written; question is addressed to the inspection's InspectorUserId; reply fans out to INSPECTION_VIEW holders; opening the inspection marks seen only for the addressee; no inspector means compose boxes replaced by an alert | W11 | 238354434 |
| A shop question creates two queue rows: InApp (sent) and Push (unsent, shown as "Queued - not yet delivered to the driver's app"); nothing is sent to Turns; no edit / delete / attachments / inbox deep-link | W11 | 238354434 |
| 20 actions in 5 controllers (Inspection, InspectionForm, Telemetry, VehicleTelemetry, VehicleDowntime) had no permission check and were reachable by URL; now gated by a class-level FleetPermission attribute | W12 | 238354434 |
| Unauthorised behaviour: anonymous goes to login; signed-in page request redirects to the referrer or "/"; AJAX request gets JSON success=false with errorMessage (English only, no translation row) | W12 | 238354434 |
| Migration 877 mirrors WORKORDER_VIEW (101000) to 110000-110003, VEHICLE_VIEW (105000) to 110010, WORKORDER_CLOSE (101006) to 110020-110021; inserts only, runs once; roles created later get none | W12 | 238354434 |
| Sidebar entries follow the same permission as the controller: Telemetry and Vehicle Map (TELEMETRY_VIEW), Vehicle Shop Days (VEHICLE_VIEW), Inspections with Inspection Forms sub-item only for INSPECTION_CRITERIA_MODIFY, Work Order Changes (WORKORDER_CHANGE_AUDIT_VIEW) | W12 | 238354434 |
| Role editor shows all seven new permissions in one group headed "View an Inspection"; "Telemetry" and "InspectionForms" nav labels render as bare resource ids (no translation rows) | W12 | 238354434 |
| Publish button queues the checklist as JSON (one group per section, pass/fail as picklist Pass / Fail / N/A, Ground = is_non_operable, Deferred = is_failure) into InspectionFormPublish as Pending; nothing is transmitted and the panel says so | W13 | 238354434 |
| Publish refusals: form not found, form has no criteria, form unchanged since last publish (SHA-256 payload hash); history panel shows last 10 publishes with status, version, size, attempts | W13 | 238354434 |
| Publish version = last accepted (Status Sent) version + 1, null on first publish; option guids are derived (MD5 of item guid + alias) and must stay stable | W13 | 238354434 |
| Known defect in local build: a Numeric inspection item publishes as Picklist (code tests non-existent type "Measurement"); no test covers Number | W13 fact-check | 238354434 |
| Known gap: an unchanged re-publish after a failed / dead-lettered publish is refused although nothing was delivered, and there is no retry UI; publishing a superseded form is not blocked | W13 | 238354434 |
| Tests: 19 payload unit tests (InspectionFormPublishTest) plus 34 ReminderDueness tests; 55 of 55 executed pass (69 methods, 14 skipped) per fact-check | W13 | 238354434 |
| Settings 82 TelemetryMileageEnabled default false, 83 TelemetryProviderName default "Geotab", 84 FuelImporterMileageEnabled default true; nothing makes the fuel importer honour 84 yet | W14 | 238354434 |
| Odometer ingestion order: meter-type mismatch, convert km to vehicle unit (divide by 1.609344; unknown unit treated as km), duplicate skip, older-than-latest = Overwritten, negative delta or delta/day over UnitDailyMax = Ignored (row kept) | W14 | 238354434 |
| Engine-hours ingestion accepts everything that is not a duplicate (no flag columns), and says so in the reason | W14 | 238354434 |
| Dry run (GET /Telemetry) writes nothing and must report the same dispositions as the commit (POST /Telemetry/Run commit=true); second run after commit reports all 13 fake readings as Duplicate | W14 | 238354434 |
| Expected fake-feed result: Accepted 6, Ignored 2, Overwritten 0, Duplicate 1, Meter mismatch 3, Unmatched 1 (derived, needs TELEM fixtures) | W14 | 238354434 |
| Provider factory messages: empty name = "No telemetry provider is configured..."; Fake / synthetic / local / demo = fake provider with SYNTHETIC banner; Geotab = not reachable reason; other = names the value and supported ones | W14 | 238354434 |
| Known gaps: /Telemetry treats "Geotab" as the fake provider while the tab refuses it; the committing POST has no anti-forgery check; no transaction per run; no production provider; ingestion is manual only | W14 | 238354434 |
| Latest-odometer lookups (work-order create "Last Odometer", mileage reading controller) now exclude Ignored / Overwritten rows; before the fix work-order create showed 9,321 beside a warranty banner using 10,066 | W14 | 238354434 |
| Map marker colour = worst state: Grounded #c9302c, FailedInspection #e8590c, OverduePm #d9a406, OpenWorkOrder #2b6cb0, Ok #7f9a86; popup lists every true condition; approaching PM never colours | W15 | 238420013 |
| Position older than 60 minutes is drawn hollow, worded "Last seen" and speed / ignition get "at that time"; no polling (Refresh button; GET /VehicleMap/Data returns the same JSON incl. providerIsSynthetic) | W15 | 238420013 |
| "Not on the map" panel lists only urgent vehicles without a position plus a count sentence for routine open work orders; unmatched devices listed separately | W15 | 238420013 |
| Map ships with no base map (settings 89 / 90 empty) and shows a banner; the tile-layer path was never exercised; no clustering, geofences, location filter or auto-refresh | W15 | 238420013 |
| Shop Days: default window last 12 months; spans overlapping the window are clipped to it; same-day visit = 1 day; concurrent work orders do not double-count days; Inactive stops the clock, OnHold does not; first terminal transition wins (reopened second stint not counted) | W16 | 238420013 |
| Shop Days is location-scoped for non-admins (EXISTS on UserLocations) but that path was never tested with a non-admin user; no time-zone handling; table has no search box and fixed 50 rows; export title carries the window | W16 | 238420013 |
| Work-order Service History pane Shop Days uses the same rule and must agree with the report (e.g. "41 and counting"); never-started work order shows "-" not 0; badge is 0 for a vehicle-less work order | W16 | 238420013 |
| Shop Days queries match only unspaced 'InProgress' and do not treat 'Voided' as terminal (possible zero / ever-growing days) | W16 | 238420013 |
| Attachment dialogs open at 1000px for Create / Edit (Delete stays 500px); preview served from /AttachmentData/Inline (no Content-Disposition) with Print and "Open in new tab"; unsaved-file preview has neither control | W17 | 238420013 |
| HEIC / HEIF / WEBP / BMP typed as image/*, JPEG as image/jpeg, by file extension; part attachment list gets 48x48 thumbnails; part Basics tab gets a Photos panel (max 6, hidden when none) | W17 | 238420013 |
| Distribution Summary export uses planned hours when setting 85 ChargeLabourFromPlannedHours is on (matching the work order); not exercised end to end; LabourCostOverride still ignored by the export | W18 | 238420013 |
| Fuel import tank decrement becomes one atomic relative UPDATE rounded to 2 dp; never executed locally (no Fuel rows); mechanisms 1, 2, 3, 5 not fixed | W18 | 238420013 |
| Inventory Count scan resolves a "#"-free scan to the stored PartID only on a unique non-archived match; ambiguous or typed "#" input falls through to normal search; not driven through the UI | W18 | 238420013 |
| Selecting a part on a work-order line shows "Core Return Cost" immediately when the part has a core charge above 0, nothing otherwise | W18 | 238420013 |
| Read-only operator scripts: EITAS_DuplicateVendors.sql (groups by normalised name, CanAddUniqueIndexYet verdict) and EITAS_FuelTankDiagnostic.sql (sections A-E per mechanism) | W18 | 238420013 |
| Verification playbook: MSBuild exit 0, aspnet_compiler over all views (two bad views set aside), unit tests, then drive in browser and assert in SQL | Section 6 | 238420013 |
| Do-not-ship list: local Web.config (static machineKey, customErrors Off), Wave2_DemoFixtures.sql, DT fixture script, setting 83 = Fake, fixture severity / verification rows; FakeTelemetryProvider itself does ship | Section 8 | 238420013 |
| Decisions owed: map tile source, shop days vs grounded days on the board report, narrowing INSPECTION_CRITERIA_MODIFY, vendor match key, fuel sign convention, whether the fleet map replaces the Vehicle-detail GPS panel (two Phase 1 P0s unmet) | Section 7 | 238420013 |
| Reminder due-ness windows read settings with defaults: date lookahead 10 days, date overdue grace 10, odometer lookahead 100, odometer grace 100, hours lookahead 10, hours grace 25; states NotDue / Approaching / Due / Overdue; threshold is lead time, never subtracted from interval | A-DUE-2 / A-DUE-6 (status unclear whether settings exist today) | 239403030 |
| An open work order (status NULL, Open, InProgress, In Progress, OnHold, On Hold) for the same vehicle + task suppresses the reminder; Inactive and Voided do not | A-DUE-1 / A-DUE-4 | 238420013 |
| Warranty: under warranty unless today is past start + months or current usable odometer is at or over the limit; missing odometer cannot expire it; lookup failure never blocks raising a work order | A-WARRANTY-3 | 239403030 |
| Inspection data: Result InProgress / Pass / Fail; item status Pass / Fail / NA / Repaired; item types PassFail / Numeric / Text / Choice / Signature; photo requirement None / OptionalAny / RequiredOnFail / RequiredAlways; non-image photo upload refused | A-INSP | 239403030 |
| Copying / versioning an inspection form drops FailureSeverity (copies become Deferred): a grounding criterion can silently stop grounding | A-INSP-BUILDER-5 | 239403030 |
| Notifications: severity 1 = Grounded sorts before 2 = Deferred, unread first; mark-read / acknowledge are scoped to the recipient user; acknowledge also marks read | A-NOTIFY-3 / A-NOTIFY-4 | 239403030 |
| Work-order change audit flags "needs attention" when entered hours differ from clocked time, when entered by someone other than the credited technician, or when removed without a comment; a review cannot be overwritten once set | A-AUDIT-4 / A-AUDIT-5 | 239403030 |
| Local demo (not shipped): migrations 867-878 add inspections, photos, reminder last-service anchors, vehicle warranty, form builder with copy-on-edit versioning, defect intake, failure severity, notifications, work-order change audit, messaging, 110000 permission block, publish outbox | Waves 0-6 | 239435777 |
| One due-ness evaluator (ReminderDueness) feeds service auto-create, WO pane, new WO History tab, reminders list, vehicle tab, dashboard widget and calendar; all must show the same due date and percent | FR-01 / FR-02 / F2 | 239435777 |
| Month and Week intervals count calendar time (landing date shifted off weekend / blackout); Day intervals count working days; WorkOrder.Status NULL and "In Progress" count as open | Decision 7b | 239435777 |
| Numeric inspection item outside min / max auto-fails even if inspector marks Pass; RequiredOnFail photo blocks completion; CameraOnly forms hide the library picker | Wave 3 | 239435777 |
| Completing a failed inspection raises ONE work order per vehicle with one line per failed item, idempotent on re-post, carrying VehicleOutOfService when grounded; Turns DVIR source not built (throws NotImplemented) | Wave 4 / F3 | 239435777 |
| Failed inspection notifies everyone holding a permission (in-app bell + inbox; acknowledge separate from read); no web push exists; queue rows stay unsent | Wave 6.2 | 239435777 |
| Work-order change audit flags labour hours differing from clocked span by more than 0.05 h; sign-off cannot be overwritten | Wave 6.4 | 239435777 |
| Criteria publish outbox serialises a Fleet form for api/FormModuleTemplate/CreateTemplate; receiver requires version = latest accepted + 1; nothing drains the outbox | Wave 6.8 | 239435777, 239075352 |
| Vehicle warranty banner on WO create (date and odometer limits); core-charge prompt when Part.CoreReturnCost > 0; part photo thumbnails incl. HEIC | FR-03 / FR-07 / FR-04 | 239435777 |
| Not built: superseded parts, cheaper-vendor alert, all open WOs in Workstation view, labels on receipt, single vehicle identity across routing / GPS / Fleet, real Geotab provider | FR-05 / FR-06 / FR-08 / asks C-E | 239435777, 239075352 |
| Fix: MissingPart clears regardless of work order status and on transfer receipt (product decision needed; affects every district) | C1 | 239009817 |
| Fix: Include Overdue honoured; odometer filter becomes due-or-overdue; badge agrees with list; create-WO shows server errors and names skipped reminders | C2 / C3 | 239009817 |
| Fix: fuel import gives a clear "no fuel inventory for location" message plus a pre-flight check; never shows raw exception text | C4 | 239009817 |
| Fix: requisition lists omitted parts with a reason (no vendor / no order quantity) and a warning before the PDF; range validation >= 0 on reorder fields | M1 | 239009817 |
| Fix: Transfer Sent rows record Last / New quantity; transfer receipt is idempotent (second post says already received); ledger-vs-on-hand reconciliation report | M2 / M3 | 239009817 |
| Fix: Cost Rule rejects values other than 0 or 1; active cost rule shown on Inventory list and requisition | S1 | 239009817 |

### Trips (15)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Drivers link to Pro staffGuid (UseStaffGuidAsEmployeeExternalID on for new districts; a matcher links exact one-to-one matches, ambiguous ones go to a review list) and vehicles to busId; Trips CE hand-offs carry operatorGuid, no staffGuid, no inbox message | TP-R1, TP-R2, TP-R5, TP-R20, TP-A22..A24 | 238747655 |
| Trips publishes trip.assigned / trip.changed / trip.cancelled / work.planned: an assigned trip reaches the driver's inbox and tablet within 60 s, Dispatch's bus picker shows "On a trip 9:00-13:00", retiring a driver flags future trips within 15 min, a lapsed licence blocks assignment, a grounded bus flags the trip | TP-R3, TP-R4, TP-A1..A4 | 238747655 |
| Offer ledger: every offer records who, when, which rule and outcome (accepted, declined with reason from DeclineReasons, expired, withdrawn); a decline shows within 60 s and the next driver holds the offer; office to-do if nobody accepts within an hour | TP-R8, TP-A5 | 238747655 |
| Hours guard: route hours + booked trips + actual hours vs MaxHoursPerWeek and OvertimeThresholdHours (40); HoursRule warn (default) shows "42 h, over 40" and continues, block refuses; re-runs when trip times change | TP-R9, TP-A6 | 238747655 |
| Trip board: DriverSignUpMode Off (default) / SeniorityWindow (open DriverSignUpWindowHours = 24, best-ranked sign-up wins at close) / FirstCome; all who signed up are told the outcome | TP-R10, TP-A7 | 238747655 |
| Trip on the device: driver sees only own trips; check-in within 200 m of first pickup sets actual start, 5 km away is recorded "away from the pickup"; post-trip form (odometer pre-filled from meter, receipts) closes the trip and hours reach T&A within 5 min; offline entries keep their real time | TP-R11, TP-R12, TP-A8, TP-A9, TP-A16 | 238747655 |
| Invoice lines say their source (meter / typed / estimate; time and attendance / form / estimate); finance export CSV / JSON / journal via service role is idempotent by invoice id and version and logs each pull; reimbursement pack = one PDF + one CSV; rates carry effective-from dates | TP-R13..R15, TP-R19, TP-A10, TP-A11, TP-A14, TP-A27 | 238747655 |
| Requesters: exemptions with reason when AllowRuleExemptions on (off by default; exempted trips cannot be bulk-approved); duplicate flag on same school + date + destination (DuplicateRequestCheck default true); favourites; bulk approval; send-back to any earlier step requires a comment | TP-R16..R18, TP-A12, TP-A13, TP-A28, TP-A29 | 238747655 |
| Driver sort: level 1 available, level 2 DriverSortLevel2 (TripHours default / TripCount / Seniority / None), level 3 DriverSortLevel3 (Name default / Seniority), period DriverSortPeriod (SchoolYear default); cancelled trips count for nothing; existing listing modes map onto it with unchanged order | TP-R21, TP-A17, TP-A18 | 238747655 |
| Automatic itemised quote within 5 s of entering destinations (RoutingProvider BusPlannerThenGoogle default; QuoteAutomatic, QuoteShowToRequester), versioned on each itinerary change; routing down = "distance and time to follow"; Turns gives spoken directions to any typed address within 5 s, address entry only while stopped | TP-R22, TP-R24, TP-A19, TP-A21 | 238747655 |
| A trip is one job: work.planned (kind = trip) becomes a suggested T&A job, Change Job on Turns clocks onto it, work.actual returns hours within 5 min and the invoice line says "time and attendance"; until BP Unified code is available the post-trip form hours stand in | TP-R23, TP-A20, RK-10, TP-K6 | 238747655 |
| Trip texts (DriverTripTexts, off by default, SE only, consent required, STOP ends them, never name a rider) send within 60 s with a trip link; the link needs no app or sign-in, is one driver + one trip, takes miles / times / costs with receipt photos, and dies when the trip is finalized, cancelled, reassigned or a fresh link is sent | TP-R25, TP-R26, TP-A30..A36, Q251 | 238747655 |
| 80 proposed QA tests TP-QA-001..080 (Given / When / Then, P1 blocks release, extra type "Connected") cover registries, hand-offs, pickers, CE, offers, hours guard, trip board, device, money, requesters, driver sort, quotes, one job / directions, texts and trip link | TP-QA-001..080 | 238747655 |
| Rollout: Phase 3 ships the read side of TP-R11, Phase 5 the rest; every new flag starts off; sixteen new settings reach the settings program via IF-TP-01; open questions Q9 (routing provider), Q44-Q47, risks TP-K1..K6 (employee matching, union rules, finance layouts) | TP-K1..K6, Q9, Q45 | 238747655 |
| Proposed onboarding: 7 chunks (Buildings and Places; Fleet; People; Trip Rules; Money; Approval Routing; Communication and Polish) and a readiness report with Hot checks (school without Default approver chain or account, vehicle type without rate, NumDaysNoticeRequest 0 or too high), Warm and Cold checks; status: proposal only | (no id) Part 26 | 239140908 |

### Workflow (6)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Each Save To BusPlanner writes exactly one audit record (who, form, submission, fields, before/after; a partial failure shows what saved); approval publishes form.approved with effectiveDate and reachesAppsAt; the confirmation names when Turns and Chipmunk will have the change (labelled "expected" if the copy does not run) | WF-R1..R3, WF-A1, WF-A2, WF-A4 | 239075373 |
| The pre-trip inspection template is removed or opens the FormModule checklist; the description of Workflow_SaveToBPVisibleWhenPending says it writes before approval; later, writes move through the door with no direct call into Pro (Phase 5; risk WF-K1 districts use the template today; copy time per district unknown, Q32) | WF-R4..R6, WF-A3, WF-A5, WF-A6 | 239075373 |
| 9 proposed QA tests WF-QA-001..009 (Given/When/Then; types Happy, Edge, Data, Connected; P1 blocks release) cover the audit, form.approved, timing confirmation, template removal, setting description and writes through the door | WF-QA-001..009 | 239075373 |
| Proposed product (prototype, status unclear vs shipped Workflow): form builder with about 40 field types, 16 templates, live conditional rules in preview, multi-page forms, undo/redo of at least 50 steps; duplicate creates a Draft with "(Copy)" and 0 submissions; Deny and Request Changes require a reason; every review action appends an audit entry; parallel approval needs both approvers; default 3-step flow with a 48-hour reminder; export "Approved Student IDs Only" in Pro import format | FR-FORMS, FR-TMPL, FR-BLD, FR-SUB, FR-WF-1..5 | 238911553 |
| Proposed Auto-Assignment Pipeline: Parent Submits, Eligibility Check, Review and Approve, Sync to Pro, Auto-Assign Stop; runs must be idempotent, logged and retryable; a Pro sync failure alerts staff and keeps the request for retry; eligibility is delegated to Pro's policy engine | FR-WF-6..9a, FR-INT-2, FR-INT-3 | 238911553 |
| Proposed: self-service "Connect a BusPlanner Pro Database" with staged Test and Connect and a Primary database; public access off forces sign-in; languages EN-US, Spanish, French (Canada), Haitian Creole with a per-form switcher; 6 letter templates and 12 merge fields; WCAG 2.1 AA; UI response under 200 ms; phasing P0-P3 with payments and a native app as fast-follow; 8 open questions (auto-approve guardrails, Pro data ownership, public anti-spam) | FR-SET, FR-L10N, FR-LET, NFR-1..9 | 238911553 |

### Trackers / GeoIMS / GEDI (10)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Release 0 instrumentation, no behaviour change: command duration at Info, saturation counter, per-worker last contact, loop heartbeat registry so IsTrackerAlive fails when any loop is stale | I-1..I-8 | 237993990 |
| Hotfixes: stop orphan-worker infinite loop, add missing returns on stale worker id, 5 s health-check timeout (was 30 s; slow SQL sites will see more worker culls), run-manifest timeout 1200 s | GEO-1..GEO-10 | 237993990 |
| Later releases: supervise the accept thread and interprocess pump, per-database health-check lock with TTL cache, reclaim stuck workers, MaxRequestsPerWorker, handshake off the accept thread (32-64 threads cap) | GEO-11..GEO-19 | 237993990 |
| GeoIMS socket receive timeout must ship only together with the fix that stops subscription deletion on timeout; SendTimeout must not ship | SHR-1 / SHR-2 / GI-R8 | 237993990, 238125072 |
| Staff save changes only marked fields and checks version; stale save fails naming who and when; audit records product and user | GI-R1 / GI-R2 | 238125072 |
| Delete of a person with history is refused ("Retire instead."); new retire command sets RetireDate and clears Active in one transaction | GI-R5 | 238125072 |
| Merge / split / move run all-or-nothing; a move preview returns check, severity (block / warn) and message for equipment, seats, boundary, dead ends, operator, served stops, run version; 60-stop preview within 3 s | GI-R6 / GI-R7 / GI-A7 | 238125072 |
| Per-bus seat layouts, dated seating needs (BPL_StudentSeatNeed) and one seat check (allow / warn / block) shared by Pro, BP Web and the tablet | GI-R12 / GI-R13 / GI-R16 | 238125072 |
| 49 proposed QA tests GI-QA-001..049 covering staff saves / audit / lists, merges and moves, Pro desktop regression and subscriptions, seats / needs / rider query / parent-named adults, same-day changes; 3 marked not built / partly / fail in a 2026-10-26 retest (036, 042, 045) | GI-QA | 238125072 |
| Every GEDI change needs a Pro desktop regression pass (Find Staff, Staff Expiry and Certifications reports, Route & Vehicle Update, merge and split); GeoIMS and all managed callers ship together | GI-K1 / GI-A8 | 238125072 |

### GPS readers (1)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Readers pass meters, status events and fault codes into new BPX_AVLMeter / BPX_AVLFault tables, one row per state change; Geotab odometer visible within 15 min | LT-R4 | 238551066 |

### Live tracking (11)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| BusPositionSource = BusUnit (default) / Tablet / BusUnitThenTablet (tablet takes over after 3 min silence); tablet sends position every 10 s while a route or run is selected; Dispatch told when feeds are more than 500 m apart | SY-18 | 239173635 |
| Tracker restart suppresses pushes for notices posted before service start and rehydrates ETA push flags from NotificationsSentLogs; OneSignal loop bounded | TRK-1 / TRK-2 / LT-R10 / LT-R11 | 237993990, 238551066 |
| One effective-mapping rule for both trackers and the door; dispatcher swaps written to the live mapping table with source = Dispatch and still shown after 3 polls (15 min) | LT-R1 / LT-R2 | 238551066 |
| ETA whose last GPS event is older than ETAStaleMinutes (default 10) returns ETAAvailable = false, reason GPSStale and asOf; off-path buses flagged | LT-R7 | 238551066 |
| Staff ETA endpoints (GetBySchool / GetByRun / GetByStudent) for role StaffApp, scope-checked (403 for another school), p95 within 1 s for 60 buses | LT-R3 | 238551066 |
| BusPositionSource per district (BusUnit default, Tablet, BusUnitThenTablet after 3 min silence; unit takes back after 5 steady min; feeds more than 500 m apart flagged) | LT-R5 | 238551066 |
| Visibility by driver selection with a 30-minute safety cap; "Bus is near" only for the run the bus is really driving; weekend pushes follow student schedules | LT-R6 / LT-R8 / LT-R9 | 238551066 |
| Trackers follow live Pro plus the day layer within 60 s, answer cancelled runs as cancelled, and draw waypoints with their own mark | LT-R14..LT-R17 | 238551066 |
| 57 proposed QA tests LT-QA-001..057 covering effective bus / swaps / source switching / visibility, staff ETAs / vehicle signals / stale ETAs / Bus is near, pushes / restarts / minimum build / settings, hand-off feed / plan / waypoints, and scale (ETA2 p95 500 ms at 120 req/s) | LT-QA | 238551066 |
| Risk: two trackers per district double every rollout; some vendors may not expose odometer / fuel / fault codes | LT-K1 / LT-K3 (Q40) | 238551066 |
| Design gaps fixed in the PRD: a "Now" handover shows parents the new bus only after the confirmed handover or first scan (WK-51); the safety cap counts from the last stop served or scan and pauses during a posted delay (WK-52); WholeRoute closes run by run (WK-53); a tablet-only GPS source is checked against the run's path, next stops and first scans (WK-54); switch back to the unit only when steady, with one "GPS unstable" notice (WK-55); before Dispatch picks between two buses parents see the one carrying the scanned riders (WK-56) | WK-51..WK-56 (SY-18..SY-21) | 238682115 |

### BPInfo REST (19)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Global authorize filter with a reviewed anonymous allow-list (ClientEndpoint lookup, MinimumAppVersion/Get, PIN grant, Delays notice reads); every other action without a token returns 401; /Token refused over HTTP | BI-R1 / BI-A1, A2 | 239403051 |
| Handoff/Publish takes 1-100 hand-offs; same eventId returns the first seq, a changed payload returns 409; Handoff/Read max 1..500 in seq order; kept 35 days, then 410; publish-to-readable p95 ≤ 5 s at 50 per second | BI-R2 / BI-A3, A4 | 239403051 |
| People/GetAssignable returns only active, in-scope people who pass People_TrainingRule (default warn; block for licence and medical) with excluded counts; cached 5 minutes; p95 2 s for 1,500 staff; on GeoIMS failure 503 retryable or last good list up to 10 minutes old, never empty | BI-R3 / BI-A5, A6 | 239403051 |
| Bus registry SaveLinks with a stale version returns 412 naming who saved; EffectiveBus/Get precedence is dispatcher run override, dispatcher route override, driver's claim, tablet login mapping, planned mapping | BI-R4, BI-R5 / BI-A7, A8 | 239403051 |
| /Token grant_type=pin: five wrong PINs for one employee number in 15 minutes lock it for 15 minutes from any device; retired person refused; unlinked PIN refused with "Ask the office to link your PIN"; offline grant lasts Turns_OfflineSignInHours (default 12) | BI-R6 / BI-A9, A10 | 239403051 |
| Inbox push says only "You have a new message", readable within 60 s p95, kept 30 days; GPS/SubmitPositions takes up to 60 points, ignores duplicate (deviceId, deviceTime), sends points older than 10 minutes to the trail only | BI-R7, BI-R8 / BI-A11, A12 | 239403051 |
| A run claim outside the driver's route scope returns 403 and writes no mapping; a failed check appears in GetFailedResultsSince within 60 s; a driver reads BusProblems only for their own bus; existing actions only gain optional fields so old clients keep working | BI-R9..R11 / BI-A13..A15 | 239403051 |
| Staff app endpoints return 403 out of scope; over rate limit returns 429; every answer carries a correlation ID; logs hold no PIN or student name; a device clock more than 120 s off is accepted and flagged "tablet clock wrong" | BI-R12, BI-R13 / BI-A20..A23 | 239403051 |
| Crew record written at each Turns / Subs sign-in (latest of dispatcher correction and tablet sign-in wins; yard account has no staffGuid); Absence/Submit only for a linked child before the run's cutoff, rider.absent within 5 s, no child name in a push | BI-R14, BI-R15 / BI-A16, A17 | 239403051 |
| Conduct hand-offs carry no name or report text and out-of-scope reads return 404; a scan matching a not-riding instruction publishes scan.notRiding; Handover/Submit is idempotent on scanId; SeatChart/Check returns allow / warn / block before Save | BI-R16, BI-R17 / BI-A18, A19 | 239403051 |
| FamilyMessage Send / Threads / Reply; Emergency/Raise published within 5 s, idempotent on alert ID (six quick taps = type "not chosen"); Run/EmptyCheck with a rider left makes one urgent Incident; arrivals more than 2 minutes after device time are marked late | BI-R18, BI-R19 / BI-A24..A29 | 239403051 |
| Proposed setting defaults: Turns_DriverSignIn off; DriverChannel_Enabled off; DriverMessaging_Enabled off; DriverMessaging_DriversCanInitiate on; DriverMessaging_AllowBroadcast off; DriverMessaging_RetentionMonths 24; Handoff_RetentionDays 35; Handover_RetentionYears 5 | BI settings table | 239403051 |
| 77 QA tests BI-QA-001..077 (security, hand-off feed, people, registry, effective bus, sign-in, inbox, positions, claims, Fleet, staff app, limits, crew, absences, conduct, handover, messages, emergencies); risks: GeoIMS overload, yard account as only sign-in, HTTP on /Token; open Q19, Q20, Q26, Q29, Q31 | BI-QA / BI-K1..K3 | 239403051 |
| Bulk upload dialog (Upload file → Review → Results) with a blank template (User Name *, Email, Password, Operations, Schools, Grades, Operators) and a "Current users" download whose Password column is always blank | FR-1..FR-3 | 247824423 |
| Upload accepts .xlsx, .xls, .csv; headers matched by name in any order; rows match on User Name case-insensitively (never Email): existing user updated, else created; users not in the file are never deleted, locked or renamed | FR-4, FR-5, FR-10 | 247824423 |
| Blank cell or missing column keeps the current value; a filled Operations / Schools / Grades / Operators cell replaces the list; values are ALL or semicolon-separated codes, never both; password required for new users and a filled password on an existing user resets it with a warning | FR-6..FR-9 | 247824423 |
| Validation in Review and again on the server: duplicate User Name errors both rows, unknown codes or operations rejected, file-level errors for empty / no User Name column / only User Name column / header only; numeric codes match ignoring leading zeros | FR-11, FR-18, FR-19 | 247824423 |
| Nothing is saved until Import; valid rows import and error rows are skipped; each row is all-or-nothing; Results show Created / Updated / Already up to date / Failed and an error file of failed rows with passwords blank | FR-12..FR-14 | 247824423 |
| Add user becomes a top button, list shows scope as All / n of N / None, Edit page gets one Save; open: how a file clears a value, whether service accounts are protected, whether school GUIDs change at rollover, .xlsx or CSV only | FR-15..FR-17 / OQ 1, 2, 4, 7 | 247824423 |

### Subscription Service (6)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Each recipient's message is rendered at send in that parent's language from one template set shared by email, text and push (fallback district default, then English); "temporary" only for just-today changes; "Thank you." fixed; bus named by number, never GPS unit ID | SS-R1, SS-R2, SS-A1, SS-A2 | 238321746 |
| Delivery is recorded per recipient, job and channel (ss_Job, ss_Delivery): a restart after 500 of 1,000 sends exactly 500 more; a job stuck 5 minutes resumes from the first unsent recipient | SS-R3, SS-R4, SS-A3, SS-A10 | 238321746 |
| Parents choose per category (email on by default); Dispatch texts via Twilio only when Dispatch_TextsEnabled (default off) and the parent opted in, with a consent record in US districts; delivery counts return as email.sent / sms.sent / push.sent so Send Run Changes shows "Sent to 42 families, 3 failed" within 2 minutes | SS-R5..R7, SS-A4, SS-A5, SS-A11, SS-A12, Q28 | 238321746 |
| Scheduled checks: credential scan at 02:00 local publishes training.expiring at People_TrainingNoticeDays (30, 14, 7) and training.expired once, never twice per night; held-notice warning at 14:00 default; drivers' digest stops per district when DriverChannel_Enabled is on | SS-R8, SS-R9, SS-A13..A15 | 238321746 |
| Absence confirmations go in-app + push (no email, no name) within 60 s; letters about a child (studentLetter) and messages to a family cannot be turned off by the parent and never name a student in push body or email subject; a same-day Pro change reaches families once after the dispatcher sends it | SS-R10..R13, SS-A7..A9, SS-A16, SS-A17 | 238321746 |
| 43 proposed QA tests SS-QA-001..043 cover language / channels, no duplicates, texts, scheduled checks and digest, absences / letters / Pro changes / messages, and scale (95% of 70,000 app parents within 2 minutes); rollout Phase 0 (R2-R4, credential scan), Phase 3 (R9), Phase 4 (R1, R5-R7); risk SS-K1 missing French / Spanish templates | SS-QA-001..043, SS-A6, SS-K1 | 238321746 |

### Settings (11)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| New switch defaults (not shipped): Dispatch_PushToFamilies on, Dispatch_ChangesToBPWeb off, Dispatch_TextsEnabled off, Dispatch_SendLeadMinutes empty (= held), DriverChannel_Enabled off, Turns_DriverSignIn off, Turns_MetAtBusMode Off, Turns_DriverSeatEdits Off, Chipmunk_AbsenceEnabled off, Conduct_Enabled off, Training_Enabled off, Dashboard_Enabled off, Turns_EmptyBusCheck off, Turns_EmergencyButton off, Chipmunk_LateNoticeMinutes 10 | §8.0.8 | 238321683 |
| The client picker lists every client from the central client list (kept in sp_Client) and shows one tile per product with version, setting count, count differing from default, "coming" count and whether the store answered | SP-R1, SP-R2, SP-A1 | 239534081 |
| Each setting is read through the door at that moment and never stored beyond the session; an absent row shows "not set: the default applies", an uncatalogued row shows read-only as "unknown key", a key the district's build lacks shows "not in this build" and cannot be written | SP-R3, SP-R4, SP-A2, SP-A9 | 239534081 |
| A change is written to the product's own store, read back, and the cache cleared so the screen says "live"; otherwise it says "lands within N minutes" or "after the app is next released"; a tracker setting must be served by Monitoring/GetSettings within 60 seconds when the reset succeeds | SP-R5, SP-A3, SP-A4 | 239534081 |
| Writes are validated for type, options, range and dependencies; danger settings (e.g. "Dispatch - Disable Parent Emails") need a typed reason; system keys DatabaseVersion and TranslationVersion are read-only; the product's own validation message is shown and nothing is written on rejection | SP-R6 | 239534081 |
| Every change writes one append-only row (user, server time, client, store, key, old, new, reason, result, cache cleared, store version, correlation ID); sign-ins, exports, templates, role changes and refused writes go to an activity log; update or delete of a log row must fail and a nightly hash job reports tampering; revert is a new audited change | SP-R7, SP-R17, SP-R18, SP-A6, SP-A16..A18 | 239534081 |
| Search works across every store by key, alias, name and description (searching FormModule_Turns_CaptureVehicle finds Turns_CaptureVehicle); compare/copy two clients or two databases; templates apply with a per-setting result; CSV export without secrets | SP-R8, SP-R9, SP-R10, SP-R15, SP-A7, SP-A10 | 239534081 |
| No secret value appears in any screen, log, export or API response (shown as set / not set); a viewer cannot write, a consultant cannot change a secret, every refusal is audited; two-factor is on for everyone | SP-R11, SP-A5, SP-A15 | 239534081 |
| Pro shows one column per database (this year / next year), trackers one per tracker, readers one per install; an unreachable store shows "stale" with last read time and refuses writes; a product build adding an uncatalogued setting fails its build check; one product loads in under 10 s and a full client under 60 s; screens meet WCAG 2.1 AA | SP-R12, SP-R13, SP-R14, SP-R16, SP-A8, SP-A11..A14 | 239534081 |
| Rollout: R0 catalogue (2026-10-30), R1 read (2027-02-26), R2 write for BP Web and trackers then Quick, Fleet, Trips, PM (2027-04-30), R3 Pro writes and readers (2027-06-25); no product flags, rollback = switch an adapter off; open: hosting and sign-in (Q34), self-hosted allow list (Q35), how Pro notices a changed row (Q37), reader endpoint (Q38), 7-year audit retention (Q39); risks SP-K1 wrong client, SP-K2 wider attack surface | Q34-Q39, SP-K1..K5 | 239534081 |
| Proposed new settings with defaults: Turns_DriverSignIn off, Turns_OfflineSignInHours 12, People_TrainingRule warn (block for licence and medical), Handoff_RetentionDays 35, ETAStaleMinutes 10, ChipmunkBusVisibility TimeWindow, Chipmunk_AbsenceEnabled off, Chipmunk_AbsenceCutoffMinutes 30, Dispatch_NotificationWarnTimes 14:00 and 20:00, Dispatch_DefaultSendTime empty, Dispatch_JustTodayCutoff 20:00, Dispatch_FeedRetentionDays 35, Dispatch_TextsEnabled off, Trips DriverSignUpMode Off, HoursRule warn, OvertimeThresholdHours 40 | catalogue §3.1 | 238321725 |

### Employee app (10)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Design rules: looks like Chipmunk (BPYellow #FFC001, BPBlue #013668); one app, permissions decide; the server decides role and scope on every call; same powers as on a computer, never more; freshness ("as of") and the effective bus always shown | EA-1..EA-8 | 238223417 |
| Roles and scopes live on the Pro staff record; staff sign in with BP Web professional accounts, drivers with BP Web driver accounts; every student lookup is logged; new StaffApp settings Type; mechanics never see student or parent data | EA-10, EA-11 | 238223417 |
| Mechanic: My buses sorted Do not drive / Needs repair / Warning lights / Due soon / All good; bus page with status, position, driver reports with photos, fault codes, due-ness, meters, history, parts; actions Start / Stop repair, Fixed (repair.done), Do not drive / Back in service (bus.grounded / bus.returned); pushes | EA-20..EA-24 | 238223417 |
| Transportation: Right now home (late, not moving, no GPS, today's changes), one search, Quick tools and edits on the phone gated by Quick's own permissions, tools without permission hidden | EA-30..EA-35 | 238223417 |
| Dispatch on the phone: preview with safety checks, held and merged parent messages, undo while held, logged as from the phone, "Just today / From now on"; prerequisites D2, D3, DF-10, DF-11, CC-3 audit, door security fixes, all-or-nothing merge / split | EA-36 | 238223417 |
| School staff: My school map and morning / afternoon boards for one school scope; swapped bus shown at once (a "Now" change shows "Handover pending" until confirmed); student lookup and scan history for own school only, scans a district setting off by default | EA-40..EA-43, Q10 | 238223417 |
| Driver role: My day, Dispatch changes inbox with acknowledgement (push.acknowledged), trips board / check-in / post-trip form, timecard and clock in/out (offline events keep real time), read-only training and credentials, scans on own runs, problems reported, messages | EA-90..EA-99 | 238223417 |
| Staff ETA endpoint on the tracker by school, run and student, checked by role and scope; fallback = planned time + SecondsDifferentFromPlanned marked as estimate; hide ETA older than ETAInformation_Timeout and show the reason | EA-60 | 238223417 |
| Build: new MAUI app from Chipmunk's code with shared UI library; separate store listing; two-factor for staff; replaces Assistant at parity; demo mode with sample shop, district and school | EA-70, EA-80 | 238223417 |
| Order of work: Phase 1 see the buses; Phase 2 mechanic's bus + Dispatch on the phone; Phase 3 health and messages; Phase 4 drivers; open Q2 (name), Q6 (how "late" is measured), Q7, Q8, Q9 | §14, Q2-Q9 | 238223417 |

### Ride Support (93)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| A behavior report: 3 taps when stopped saves a draft, the school sees it within 5 minutes, nothing waits unseen past 2 school days; pushes and payloads carry no names | CX-78 / IC-7 | 239173656 |
| Transportation reviews first by default (Conduct_FirstReview); a referral is taken on purpose (Take it), never by opening; one suspension at a time per student; special-education check before a bus suspension (Conduct_SpecialEdReview = tick default / reviewer / off); letters never name another student; SIS gets an export, no write-back | SC-R5, SC-R9, SC-R10, SC-R14, SC-R25, SC-R28 | 239304705, 238419971 |
| Built in two phases (web module first, then Turns and Chipmunk parts); Conduct_TurnsEnabled and Conduct_ChipmunkEnabled both off is a complete district; one-way messages only; spell check only, no grammar check in V1; V1 doc has 146 ACs, 56 cases, 176 QA tests | SC-R30, SC-R43 | 239304705, 238845954 |
| 2026-10-26 retest in the HTML prototype: 248 ACs = 104 pass / 73 partly / 38 fail / 31 not built / 1 can't test / 1 not run; 532 QA tests = 263 pass / 83 partly / 73 fail / 63 not built / 2 can't test / 48 not run; covers SC-R1 to SC-R42 plus Turns, Chipmunk, Dispatch and door touchpoints | Appendix D | 238223375 |
| Known prototype-vs-PRD gaps to retest: opening a referral takes it; SIS export refuses another role with HTTP 200 not 403 (SC-A16); Conduct_RideRequiredCodes never triggers; emergencies reach no contact; rider list not covered while moving unless EnableBlackoutWhileMoving; no offline queue in prototype Turns | Appendix D | 238223375 |
| Module ships off per district (Conduct_Enabled off); pages and tables live on the new platform, nothing is written to Pro; Turns reaches it through the door | pull-out card / Data | 239337479 |
| District picks kinds (Conduct_Kinds default Problem, Praise, Incident); each reason has severity minor/major/urgent; default lists ship in EN/FR/ES (e.g. Weapon = urgent, Fighting = major, Out of seat = minor) | SC-R1 | 239337479 |
| With the bus stopped a driver saves a draft for selected riders in 3 taps (riders, Referral, kind + reason); no report screen opens while moving unless Turns_ReferralWhileMoving is Mark or Rider (default Off) | SC-R2 / SC-A1 | 239337479 |
| The door stamps bus, run, route, stop, device and server time and reporter; draft survives app restart, swapped tablet and 8 h offline; sending twice with the same report ID stores one report | SC-R3 / SC-A2 / SC-A3 | 239337479 |
| Draft reminders: writer after Conduct_DraftHours (24), supervisor after Conduct_DraftEscalateHours (48) on "Drafts not sent"; nothing is ever sent unfinished by the system; tablet and web edits merge field by field and a conflict blocks Send until one is picked | SC-R3 / SC-A138 / SC-A139 | 239337479 |
| GPS point older than 2 minutes is marked "last known"; an Incident freezes the seat chart and the map at that moment | SC-R3 / SC-A29 | 239337479 |
| "A rider I don't know": reviewer sees riders scanned on/off that run within 15 minutes of the time and attaches one; after With transportation only a district admin can change the student (logged) | SC-R4 / SC-A38 | 239337479 |
| First reviewer is Conduct_FirstReview (transportation default / school / operator); Conduct_TransportationDecides default "all but bus suspensions"; sent referral reaches the first reviewer's list within 5 minutes, one email each, no email subject or push body names a student | SC-R5 / SC-A5 / SC-A23 | 239337479 |
| Users outside scope (another school's reviewer, another run's driver, another operator) get "not found"; every open, export and print is logged (sc_Access) | SC-R16 / SC-A6 | 239337479 |
| Urgent reason: tablet first shows "Call Dispatch now"; within 60 s of Send the transportation contacts get a push and email and it is at the top of Dispatch's Today page | SC-R6 / SC-A7 / SC-A163 | 239337479 |
| A report unopened for Conduct_ReviewDays school days (default 2) escalates to the transportation contacts; reviewers get a morning digest | SC-R7 / SC-A8 | 239337479 |
| Reviewer records the decision from the district's action list; module never chooses a consequence; flags a third report within 30 days; duplicate line when same student and run within Conduct_DuplicateMinutes (30); comments never reach letters, the reporter or the SIS | SC-R8 / SC-A30 | 239337479 |
| Not riding = bus suspension: shown as "Suspended · Last day: <date>" from next sign-in, a scan opens the alert on any bus (scan.notRiding), counted as an absence with reason school, family gets no absence confirmation | SC-R9 / SC-A9 / SC-A22 / SC-A161 | 239337479 |
| Suspension length from Conduct_SuspensionPresets (1, 3, 5, 10) counted in Conduct_DayBasis days (service default): 3 days from Fri Oct 16 ends Tue Oct 20; scope all runs / morning / afternoon / chosen runs; lift early sends "may ride again" letter | SC-R9 / SC-A26 | 239337479 |
| Special-education gate (Conduct_SpecialEdReview: tick default / reviewer / off): suspension for a SpecialEd student or one with a Conduct_RideRequiredCodes code cannot save without the tick; days-off count flags at Conduct_RemovalDayThreshold (10), e.g. 8 + 3 shows "This makes 11 days off the bus this year" | SC-R9 / SC-A10 / SC-A25 / SC-A48 | 239337479 |
| Family letter: rendered in each parent's language, sent via Chipmunk and email within 5 minutes (Conduct_LetterChannels: app and email default / email only / printed only); push says only "You have a new message from your school"; name check blocks a letter naming another rider on the run or student on the report; no app and no email = printed PDF "given on paper"; per-parent delivery status sent/delivered/failed | SC-R10 / SC-A11 / SC-A12 / SC-A36 / SC-A39 | 239337479 |
| Praise needs no review (Sent → Seen); Conduct_PraiseToFamily school sends (default) / automatic / off | SC-R11 / SC-A13 | 239337479 |
| Concern goes only to Conduct_ConcernContacts and school well-being contacts within 60 s, is confidential ("not found" for others, reporter sees "Sent" only), and the kind cannot be switched on while help text or contacts are empty; an Incident marked "Suspected abuse or neglect" takes the same path | SC-R12 / SC-A14 / SC-A28 / SC-A122 | 239337479 |
| "Ask for video" lists the bus and a window of Conduct_VideoWindowMinutes (10) either side; erase date shown only when Conduct_VideoKeepDays is set; no camera system linked | SC-R13 / SC-A15 | 239337479 |
| SIS export Conduct/GetSince (role ConductExport, other roles 403) returns only reviewed reports, never withdrawn, concern or praise; cursor does not move on failure; no SIS write-back in v1 | SC-R14 / SC-A16 | 239337479 |
| "Behavior by run" report: reports per 100 rides with run load; counts by reporter only for transportation supervisors; loaded-by-hand list after Conduct_ManualLoadDays (3) school days in a row; nothing goes to Performance Management | SC-R15 / SC-A17 / SC-A35 | 239337479 |
| Retention: Conduct_RetentionYears 5 and Conduct_IncidentRetentionYears 7 after the school year unless on hold; two boards on one bus see the other board's students as "another student" | SC-R16 / SC-A18 / SC-A19 | 239337479 |
| Reporter can withdraw until a reviewer opens it; afterwards reviewer marks "withdrawn: mistake"; withdrawn is kept for audit, excluded from counts, letters and SIS, and can never be reopened | SC-R18 / SC-A157..160 | 239337479 |
| Nine statuses per rider: Draft, Sent, With transportation, Handled by transportation, Sent to the school, With the school, Decided, Closed, Withdrawn; invalid: With transportation → Closed (except Close at Transportation), system Draft → Sent, anything from Withdrawn, any → Draft; reopen needs a reason | SC-R19 / SC-A27 | 239337479 |
| With routing chains the statuses become six (Draft, Sent, In review, Decided, Closed, Withdrawn) shown as "In review · step N of M · held by <name>" — this changes the 10/14 decision that nine statuses are fixed | SC-R19 / SC-A47 / Q123 | 239337479 |
| Notes to the driver without a referral (Conduct_StudentNotes, default off): dated or "show once" note pops up on scan | SC-R20 / SC-A34 | 239337479 |
| Routing chains: first chain whose When rule matches is used; cannot save without a deciding role; role permissions are the ceiling; saved chain = new version and in-flight referrals keep their version; Try it previews recipients; student with no grade goes to every holder of the role at the school | SC-R21 / SC-A40..44 / SC-A67 | 239337479 |
| + New referral on the web (needs cnd:referral:create), pre-filled from a student's page, a run, or "Turn into a referral" on a driver's message; "Goes to" shows resolved people before Send | SC-R22 / SC-A45 / SC-A46 | 239337479 |
| District edits reasons, actions and letters (add, reorder, retire, bring back); a reason's kind is fixed once saved; retired items stay on past referrals | SC-R24 / SC-A53 | 239337479 |
| Suspensions: need cnd:suspension:decide; one in force at a time (overlap refused); Conduct_SuspendWithoutReferral (on) from student's page; Conduct_SuspensionNoticeDays (1) service days after the letter; append-only sc_SuspensionLog with "late" over 2 minutes; contact kind "A suspended rider scanned" told once per scan after Undo's window | SC-R25 / SC-A54..64 / SC-A86..89 | 239337479 |
| Driver groups (shared with Dispatch DS-R47): a role can find its people by the driver's group, fallback by the bus's yard | SC-R26 / SC-A58 / SC-A59 | 239337479 |
| Step levels, step rules and custody (proposed, built after the 10/19 demo): writer and the driver written for can never recommend or decide; driver/monitor/bus-company roles can never decide a suspension; timers remind after N and act after M school days, checked every 15 minutes, and never decide; gap check on save and nightly; Ask the writer pauses the clock, a video request does not | SC-R27 / SC-R28 / SC-R29 / SC-R32 / SC-A68..76 / SC-A96..116 | 239337479 |
| Concurrency: first save wins on simultaneous Take it; stale action is refused with a message and the typed note stays; a person beats a timer; offline tablet Withdraw after someone took it is refused | SC-R32 / SC-A96..99 / SC-A114 | 239337479 |
| Works without mobile apps: Conduct_TurnsEnabled and Conduct_ChipmunkEnabled both start off; dependent settings stay visible but greyed "Needs Turns" / "Needs the parents' app"; web referrals, printed suspended-rider list (never the reason), radio records, letters by email and paper; Phase 2 changes no data | SC-R30 / SC-A78..85 | 239337479 |
| Setup: getting-started checklist, six sections, plain labels with "Show technical names", per-person My notifications, change history of every setting | SC-R31 / SC-A90..95 | 239337479 |
| Close at Transportation (Conduct_CloseAfterFamilyCall, off): requires who was spoken with and what was agreed; no letter, no school task; still counts in the student's history | SC-R33 / SC-A117..120 | 239337479 |
| Incident cannot be sent until four questions are answered (what kind, anyone hurt, first aid, emergency services); accident package PDF + CSV only for roles that can see the referral (else 403), each export logged; Released to auto-fills from a Turns hand-over | SC-R34 / SC-R35 / SC-R36 / SC-A121..130 | 239337479 |
| Saved views; bulk Send to the school / Handle only for lowest-severity Problems, blocked with a reason for urgent, Incident, concern, special education or routing-chain referrals; "Praise this month" on dashboards | SC-R37 / SC-A131..133 / SC-A170..171 | 239337479 |
| Seating charts, equipment and bus layouts: moves save "Just today" or "From now on" to Pro's chart through the door (IF-BI-47); wheelchair station default 30 by 50 in, minimum 30 by 48 in; child restraint never at an emergency exit; bench max 3 places; Fill empty seats in Seating_FillOrder (stop order); layout change publishes bus.layoutChanged and messages the day's drivers (Seating_SeatChangeMessage on) | SC-R38..R41 / SC-A134..156 / SC-A168 | 239337479 |
| Message the family from a referral (transportation reviewer, supervisor, district admin only): max 1,000 characters, same name check, push says "You have a new message from Transportation"; does not replace the decision letter | SC-R42 / SC-A172..176 | 239337479 |
| Spell check is the keyboard's (tablet, works offline) or the browser's (web); off in name/ID/search boxes; text is stored exactly as typed and sent to no outside checker | SC-R43 / SC-A177..181 | 239337479 |
| Scale target: with 100,000 reports stored a school's inbox opens under 2 s p95 and Send answers under 2 s p95 at 50 sends a minute (assumed) | SC-A21 | 239075331 |
| 181 acceptance criteria SC-A1..SC-A181 and 312 QA tests SC-QA-01..SC-QA-312 (Given/When/Then; types Happy, Negative, Edge, Permission, Data, Concurrency, Conflict, Connected, Non-functional; P1 blocks release): SC-QA-01..28 seating/equipment/layout; 29..72 report-review-decide-tell; 73..111 suspensions, groups, status path; 112..131 routing and web form; 132..158 lists, suspensions, driver groups; 159..179 step levels and record; 180..191 without mobile apps; 192..199 suspended-rider notices; 200..206 setup; 207..231 collisions; 232..237 close after call; 238..249 incident fields and accident package; 250..267 lists, seating, drafts; 268..273 withdraw; 274..312 cross-product notices, message the family, spell check | SC-QA-01..312 | 239075331 |
| Prototype status only (not shipped): HTML-version retest of 2026-10-26 lists many criteria as partly / fail / not built (e.g. SC-R16 privacy items, SC-R27..R29, SC-R31, SC-R39..R41 not built or failing) | retest notes / Appendix D | 239337479 |
| Rollout: Step 0 web-only by 2027-01-29 for a pilot; Step 1 Phase 3 (tablet + door IF-BI-41..43); Step 2 Phase 4 (parent channel letters); Step 3 Phase 5 (export API IF-BI-44, reports); go-live never in a district's first 3 weeks of school; rollback = Conduct_Enabled off hides the Referral button and ends open bus instructions | Rollout | 239075331 |
| Build phases: Phase 1 = web, API, tables, letters by email/paper, SIS export, Dispatch rows, no mobile developer; Phase 2 = Turns and Chipmunk parts; the employee app's Ride Support inbox is in neither phase | Rollout / Q138..Q140 | 239075331 |
| Key risks: letter or report reaches the wrong person or names another student (SC-K1); drivers using the tablet while moving (SC-K2); special-education and suspension rules differ by state/province, wording needs counsel (SC-K6, Q52); where school days come from is open (Q50) | SC-K1 / SC-K2 / SC-K6 / Q50 / Q52 | 239075331 |
| Every step is one call carrying the status the caller saw and the row version: stale version = HTTP 409 "Someone else changed this referral…", refused step = 422 with the screen message, out of scope = "Not found" (never "forbidden"); error body is { code, message, retryable, correlationId } | BR-39 / §6.4 / ST-11 | 237928473 |
| Referral ID is a UUID made on the tablet; server keeps the highest version; severity of a referral is the highest of its reasons; "No action" cannot be combined with another action | BR-5 / BR-7 / BR-18 / ST-8 | 237928473 |
| Late rules: a referral arriving more than 24 h after its device time is "late"; a tap, emergency or empty-bus check more than 2 min after is late; a device time more than 5 min in the future is replaced by server time and marked "device clock wrong"; a run crossing midnight keeps the run's service date | ST-1 / ST-37 / ST-38 / DQ-15 | 239337500 |
| Name check detail: full names match anywhere, first names as whole capitalised words including a sentence's first word, possessive matches ("Mia's"), substrings do not ("Avalon" vs "Ava"), accents ignored; placeholders' values are not checked; no override | BR-33 / ST-14 | 239337500 |
| Limits (proposed): narrative 4,000 characters; driver note 120 characters; photo max 4 MB (tablet shrinks), clip max 200 MB; suspension length 1 to 180; Conduct_DraftHours 1–168; Conduct_ReviewDays 1–10; Conduct_SuspensionNoticeDays 0–10; at most 30 safety labels of 40 characters; lists 50 rows a page | §11 / ST-41 / ST-42 / WS-2 | 239337500 |
| "3rd referral in 30 days" counts problems and incidents only (not praise, concerns or withdrawn); "Behavior by run" uses scans only when they cover at least 80% of planned rides, else planned rides marked "estimated" | BR-15 / BR-38 | 237928473 |
| A suspension day is an absence the parent cannot undo: no "Riding after all" in the app and the door refuses with "The school decided this. Please call the school." | BR-25 / ST-54 | 237928473 |
| With Conduct_TurnsEnabled off the door's tablet calls answer 403 "Your district doesn't use Turns for Ride Support."; turning Conduct_Enabled off keeps unsent tablet drafts 7 days | BR-58 / ST-30 | 237928473 |
| Other NFRs: tablet queue survives restarts and 8 h offline; Turns keeps driving if Ride Support or the door is down; WCAG 2.1 AA on web, 48 dp tablet targets, status never by colour alone; EN/FR/ES at ship; OWASP ASVS level 2 (proposed); morning digest 07:00 district time (assumed) | NF-1..NF-6 / §6.7 | 239337500 |
| Build spec test inventory: use-case steps UC-1.1..UC-13.4 (13 flows), special situations ST-1..ST-55, NF-1..NF-6, plus PRD SC-A / TU-A / DS-A / CH-A ids; layers unit, contract (conduct.openapi.yaml), integration, end to end, load, user tests | §16 | 239337500 |
| Not built or "spec only" per the spec: employee app's school inbox, real email / push / text, SIS connection, door production endpoints, two boards (SC-A18), retention (SC-A19), load (SC-A21), SC-R30 pages (SC-A78..85), Message the family (SC-A172..176), v0.17 additions | §16.2 / §16.3 / App. A | 239337500 |
| Jira epics CND-E1..CND-E12 (data and step engine, review pages, letters, the door, Turns report, Turns on the bus, bus safety, Dispatch, Chipmunk, reports and SIS, setup, privacy); Phase 1 = E1–E3, E8, E10–E12 (+E4 if Q139); Phase 2 = E5–E7, E9 | §19 | 239337500 |
| Open items that affect tests: which routing levels Phase 1 builds, SC-R21's or SC-R27..29 (Q138); whether the door's calls ship in Phase 1 (Q139); which Dispatch shows the rows (Q140); an offline Deny arriving after a lift (Q141); what a family records request contains (Q142); a failed staff notice (Q144); tablet refresh interval of the not-riding list (Q-E3, proposed 15 minutes) | Q138..Q145 / Q-E3 | 239337500 |
| V1 scope rule: a flow is in V1 only if it works end to end (tablet, decider, bus, family, back to driver); seven outcomes are in; routing chains, custom roles, parents' app, Dispatch screens, driver messages, video, seating charts, SIS API are out | §2.1-2.2 | 239108122 |
| Each rider on a referral has one of nine statuses; the path is set by Conduct_FirstReview (transportation default, or school) and Conduct_TransportationDecides (forward only / everything but a bus suspension default / everything) | SC-R19, SC-R5 | 239108122 |
| Invalid steps are refused by the server even when sent directly: With transportation to Closed without a decision, Withdrawn to anything, any to Draft, Draft auto-sent; a save from a stale page is refused with "This referral changed: open it again" | SC-R19, RS-AC-19.3, RS-AC-19.8 | 239108122 |
| Reopen of a Closed referral is only for a transportation supervisor or district admin with a reason; a changed decision replaces the old one, bus instructions follow and history keeps both | SC-R19, RS-AC-19.6-19.7 | 239108122 |
| Taking a referral is deliberate (Take it, or first moving action); opening or commenting does not take it; others see "Taken by [name], [time]"; Take over needs a reason; Hand to a colleague only to same role and work area | SC-R5, RS-AC-5.2-5.8 | 239108122 |
| A school with several reviewers splits by grade or by first letter of last name; a student in no range goes to all the school's reviewers; no reviewer goes to principal, then district admin, never to everyone; Setup names the gap | SC-R5, SC-R27, RS-EC-14/15 | 239108122 |
| Always-on rules: nobody decides their own referral, a driver or monitor never decides a bus suspension, no other student in a letter, the reason never reaches a tablet, a timer never decides | SC-R27 | 239108122 |
| Drafts are kept on tablet and platform; writer reminded after Conduct_DraftHours (24), supervisor after Conduct_DraftEscalateHours (48); never auto-sent; tablet and web edits merge field by field, a field changed in both blocks Send until the writer picks | SC-R3, RS-AC-3.3-3.7 | 239108122 |
| GPS point older than 2 minutes shows as "last known"; "A rider I don't know" lets the reviewer pick from scans within 15 minutes either side; until a student is attached the referral cannot go to a school or get a letter | SC-R3, SC-R4 | 239108122 |
| An Incident cannot be sent until its four questions are answered; "Suspected abuse or neglect: Yes" (shown only when Concern is on) moves it to the confidential concern path | SC-R34, RS-AC-34.1-34.3 | 239108122 |
| Urgent referrals go to the top of every list in orange with the district's word and notify transportation contacts at once (within about a minute) without waiting for a reviewer | SC-R6, RS-AC-6.1-6.2 | 239108122 |
| Unopened after Conduct_ReviewDays (2) service days: at transportation the contacts get a notice; at the school it returns to transportation as Sent, marked "not opened by the school"; non-service days do not count | SC-R7, RS-AC-7.1-7.3 | 239108122 |
| Decision screen shows history by SIS ID, a flag at the 3rd referral within 30 days, possible duplicates within Conduct_DuplicateMinutes (30) for the same student and run, and reviewer comments that never reach letters, tablets or the CSV | SC-R8 | 239108122 |
| Suspension length from presets 1, 3, 5, 10 or any number, counted in service days (default) or calendar days, last day shown before saving; overlapping suspension refused; first day at least Conduct_SuspensionNoticeDays (1) service days after the letter is sent; ends with the school year | SC-R9, SC-R25, RS-EC-26 | 239108122 |
| For a special-education-flagged student a suspension cannot be saved until "Checked with special education" is ticked (Conduct_SpecialEdReview default tick); days off the bus accumulate and the student is flagged at Conduct_RemovalDayThreshold (10) | SC-R9, RS-AC-9.4-9.5 | 239108122 |
| The suspension log is append-only: one row per tap, office action, letter and delivery; edits and deletes sent to the server are refused | SC-R25, RS-AC-25.6 | 239108122 |
| Letters go per guardian in their language by email or printed PDF ("given on paper"), statuses queued / sent / delivered / failed with Print instead; Send is refused if the text names another rider on the run or referral | SC-R10, RS-AC-10.1-10.7 | 239108122 |
| Praise skips transportation and goes to the school; Conduct_PraiseToFamily = school sends (default), automatic or off; praise never counts as an earlier referral and is never exported | SC-R11 | 239108122 |
| A concern is visible only to its contacts and district admins; transportation and school lists never show it and a direct server request is refused and logged apart; Concern cannot be switched on without help text and contacts | SC-R12, RS-AC-12.1-12.5 | 239108122 |
| SIS export is a CSV of reviewed referrals (SIS student ID, school, date, "School bus", SIS codes, rule); withdrawn referrals, concerns and praise are never exported; nothing is written back to the SIS | SC-R14 | 239108122 |
| Every open, export and print is logged; records kept Conduct_RetentionYears (5) and Incidents Conduct_IncidentRetentionYears (7), both [assumed]; removal logged with no student name | SC-R16 | 239108122 |
| Setup opens on a Getting started checklist (orange "To do" / blue "✓ Done"); every setting change records who, when, old and new; setting keys and permission codes show only with Show technical names | SC-R31 | 239108122 |
| Switches Conduct_Enabled, Conduct_TurnsEnabled, Conduct_ChipmunkEnabled all default off; with tablets off referrals come from the web and staff print the not-riding list; parents' app settings show greyed "Needs the parents' app" | SC-R30, RS-AC-30.1-30.3 | 239108122 |
| Spell check uses the tablet keyboard's and browser's own checker on sentence boxes only; BusPlanner corrects nothing and sends the words to no outside service | SC-R43, RS-AC-43.1-43.5 | 239108122 |
| Non-functional targets: draft saved within 1 s, not-riding check answers a scan within 1 s offline, open-referral list within 2 s at the largest district (about 1,100 buses), referral reaches first reviewer within 2 minutes of signal, lift reaches tablets within 5 minutes, WCAG 2.1 AA, keyboard-only | §6.5 | 239108122 |
| 64 edge cases RS-EC-01..64 each with a recommended rule (tablet / offline, routing, suspensions and the door, letters, record and clock, later items RS-EC-52..56) | RS-EC-01..64 | 239108122 |
| 201 QA tests exist, RS-QA-001..201 (001-084 and 177-201 on page 1; 085-176 on page 2), covering referral path, tablet, bus instructions and door alert, opt-out, form fields, review and decide, families, record and export, setup, speed / access / time; every AC and every §5.2 A-E case has at least one | RS-QA-001..201 | 241500162 |
| Open questions V1 waits on: Q50-Q52, Q54, Q118, Q119, Q123, Q127, Q135, Q137-Q142, Q144, Q146, Q149, Q163, Q165, Q166, Q169, Q193-Q201 (pilot review 2026-10-26), Q288-Q290; key ones: Q193 may transportation suspend, Q197 SIS ID and guardians data, Q198 alert engine | Q193, Q197, Q198 | 241500162 |

### Dashboard (22)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| On time measured at the school stop, each run once, against scheduled time with 5-minute early / late defaults; share is of runs measured (runs with no GPS left out); path deviation = 150 m for 2 minutes, or 5% of a route-day's positions until runs are measured; V1 tests DB-QA-001 to DB-QA-099, edge cases DB-EC-01 to DB-EC-38 | DB-R2, DB-R8, Q180, Q183, Q229 | 239304705, 238845954 |
| Dashboard tile shows only when Dashboard_Enabled (default off) is on and the role holds DashboardView or DashboardSchoolView; otherwise no tile and the server refuses reads | DB-R1, DB-AC-1.1-1.2 | 238551042 |
| Opens on today (or last service day with "No service today: showing ..."); date picker allows only service days; Range = week, month, year to date or two dates and states the count of service days; filters by school, yard, operator can narrow scope but never widen it | DB-R1, DB-R9, DB-AC-1.3-1.6 | 238551042 |
| On-time counts each run once at its school stop against the day's plan-of-record time: early / on time / late by thresholds; no GPS = no data counted apart and excluded from the share; no scheduled time counted apart | DB-R2, DB-AC-2.1-2.5 | 238551042 |
| Today updates at least once a minute and says "so far, as of [time]"; a due run not yet arrived shows "not there yet" and counts late once the late threshold passes; past days say "final", after a Dispatch correction "corrected"; a stale source is named ("GPS: last data 7:40 AM") | DB-R9, DB-AC-9.1-9.7 | 238551042 |
| Substitutions counts runs (once each) on a bus other than their own from Dispatch or GPS+; GPS+ rows say "Not recorded" for who and why; a double is a merge not a substitution; an unrecorded bus on another route shows apart | DB-R3, DB-AC-3.1-3.4 | 238551042 |
| Dispatch changes: one save = one change, counted on the day saved, by kind (absence, cover, split, merge, stop move, stop times, bus, cancelled run, crew, undo, correction); list must match Dispatch History › Log row for row; GPS+ changes are not counted | DB-R4, DB-R6, DB-AC-4.1-4.4, DB-AC-6.3 | 238551042 |
| Splits and merges count saves and also runs split or merged (once per run per day); an undo is its own row and the undone change still counts; changes also count by the staff they were for, with "No staff named" | DB-R5, DB-R6, DB-AC-5.1-5.5, DB-AC-6.4 | 238551042 |
| Stop completion V1 = share of planned rider stops served, with probable, skipped, not seen beside it; school stops excluded; split run's stops count on the carrying runs; card says "Unscheduled stops: not counted yet" | DB-R7, DB-AC-7.1-7.4 | 238551042 |
| Path deviation V1 is by route and day: a route-day counts as off its path when over Dashboard_PathDeviationSharePct (5) of positions in run windows are outside the corridor (Dashboard_PathDeviationMeters 150); no GPS shows blank, never 0%; per-run yes/no using Dashboard_PathDeviationSeconds (120) is after V1 | DB-R8, DB-AC-8.1-8.5 | 238551042 |
| Every number opens rows that add up to it; CSV export carries definition, version, exporter, time and scope; printable page prints light; long ranges export in the background | DB-R10, DB-R14, DB-AC-10.1-10.4 | 238551042 |
| Every number breaks down by school, yard and operator; a run counts in its route's yard and operator whichever bus ran it; rows may add to more than the total and the breakdown says so | DB-R15, DB-AC-15.1-15.6 | 238551042 |
| School Viewer sees only its schools' runs and the numbers in Dashboard_SchoolViewerMetrics (default on-time, substitutions, stop completion), no staff names, no changes by person; server refuses other schools' rows; each user can hide shared numbers for themselves | DB-R11, DB-AC-11.1-11.5 | 238551042 |
| Settings tab needs DashboardSettings; thresholds shown read-only; each change logged with who, when, before and after; the Dashboard writes nothing but its own settings and sends nothing | DB-R12, §6.4, DB-QA-099 | 238551042 |
| Words and colour: every number in words ("2 late of 8 runs measured"), blue = fine, orange = needs attention, never red against green, no exclamation marks; must pass colour-blindness simulation | DB-R13 | 238551042 |
| Speed targets at about 1,100 buses: a day in 3 s, a month in 10 s, year to date in 15 s from kept summaries; WCAG 2.1 AA, keyboard-only | §6.5 | 238551042 |
| 42 edge cases DB-EC-01..42 (GPS and timing, the day's plan, changes and people, scope and privacy, the clock, later items DB-EC-35..38) | DB-EC-01..42 | 238551042 |
| V1 QA tests: 113 tests DB-QA-001..099 and DB-QA-200..213 on a test district with fully worked expected numbers per day (module, counting, on-time, substitutions, Dispatch changes, stop completion, path deviation, exports and breakdowns, School Viewer, settings, colours, clock, speed) | DB-QA-001..099, 200..213 | 238551042 |
| End-state QA tests: 51 tests DB-QA-100..150 incl. a Connected type checked in another product; DB-QA-116, 118, 119, 143 run only once GPS+ counts unscheduled stops and measures runs; end-state criteria DB-A1..A22 | DB-QA-100..150 | 238583811 |
| Risks: DB-K1 numbers disagree with other screens; DB-K2 poor GPS makes numbers look worse; DB-K3 School Viewer sees another school; DB-K4 on-the-fly counting too slow at a large district (mitigation: daily summaries, Q191) | DB-K1..K4 | 238583811 |
| Open questions: Q178-Q192, Q265-Q268 plus Q27, Q50, Q65, Q73, Q169; key ones Q180 on-time unit and thresholds, Q181 meaning of operator, Q187 one definition of serviced, Q189 school scope on analytics, Q190 yard / operator on past days | Q180, Q181, Q187, Q189 | 238551042 |
| Prototype only (not shipped): 31 prototype checks DB-PQ-01..31; ranges limited to 10 service days; no map; no "corrected"; School Viewer hide kept in the browser; path-deviation share must be between 1 and 50 | DB-PQ-01..31 | 238551042 |

### Training module (16)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Prototype (not shipped): event log is the single source of truth; T-01 grid, hours, compliance and reports are derived; T-01 expires issuance + 5 years with exactly 5 birthday-anchored periods; one active T-01 per driver | Prototype R2, R3 [Fact] | 238878746 |
| Prototype: all minimum-hour checks are warn-only and never block saving (e.g. school bus original 20 classroom + 20 BTW; renewal 10 in-service per period) | Prototype R1, R4, R5 [Fact] | 239501313 |
| Prototype: event save blocks only when date blank, hours <= 0, in-service has no code, BTW has no BTW guide code, or external has no hosting organisation; no upper bound on hours; all other fields unvalidated | Prototype §6 [Fact] | 238878746 |
| Prototype: external events never count toward the T-01 grid; events outside all five periods are silently dropped; make-up events still sum hours and print "MU" | Prototype R6, R7 [Fact] | 239501313 |
| Prototype: 3 roles (admin all capabilities; instructor viewReports + modifyHours on assigned drivers; driver view-only own record) switched by a demo role switcher with no authentication; roster, reports and audit view are not actually role-filtered | Prototype R10 [Fact] | 238878746 |
| Prototype known gaps: three different pinned "today" dates (2026-05-12 / -15 / -18); cooldownDays never enforced; 3-strike exam rule and 30-day signature window are text only; period finalized flag never set; convert-from-class and kiosk paths skip T-01 refresh; "Export All" uses one shared filter; hours report red-flagging not implemented | Prototype gaps [Fact] | 239501313 |
| Prototype limits: event attachment cap 2 MB, driver document cap 4 MB, audit log 500 entries (snapshots 500 chars), send history 200 stored / 100 shown, lead times 1-365 days default 90/60/30/7, all email simulated, localStorage key bp_quick_training_v2 | Prototype R11-R15 [Fact] | 239501313 |
| Prototype has 7 reports (Driver Roster, Credentials Expiring Soon, Training Hours Summary, Detailed Training Log, Compliance Matrix, T-01 Renewal Readiness, T-1 Renewals by Birth Month) with Excel (SheetJS) and browser-print PDF export | Prototype §10 [Fact] | 239501313 |
| People come from People/GetAssignable and People/GetStatus; the module keeps no roster of its own (a driver retired yesterday is not on the sign-in list) | TG-R1 / TG-A7 | 239403072 |
| Each finished course writes a training row with completed-on and expires-on via StaffTraining/Save (IF-BI-35) using GeoIMS partial save; a class for 12 drivers adds 12 rows in Pro within 60 s; on failure the class stays pending and retries with "Not yet on the driver's record" | TG-R2 / TG-A1 | 239403072 |
| The module owns only training events, T-01 periods, signatures and kiosk sign-in, stored on a server (closing the browser loses nothing) | TG-R3, TG-R4 / TG-A2, A8 | 239403072 |
| State forms by jurisdiction: California T-01 first; other states are offered no form until added | TG-R5 / TG-A9 | 239403072 |
| Training notices: every training.expiring / training.expired reaches the driver (inbox + email naming course and date; push says only "You have a new message") once per credential per lead time, and the training lead as one digest per scan; lapsed credentials stay in every digest until renewal | TG-R6 / TG-A3..A6 | 239403072 |
| Settings: People_TrainingLead (default empty; digest goes to district admin account), People_TrainingNoticeDays (default 30, 14, 7; "block" courses also warn at 60 days); per-recipient channels email on, module on, app off; the only recipient cannot turn email off | TG-R6 | 239403072 |
| 19 QA tests TG-QA-001..019 cover people and training rows, what the module keeps and state forms, training notices; kiosk unknown driver gets "Ask the office to add you" | TG-QA-001..019 | 239403072 |
| Rollout: module in Phase 5; TG-R6 email leg in Phase 1, inbox / app legs in Phase 3; open: owner team (Q30), storage in BP Web vs Quick database (Q41), training lead per operator (Q43) | Q30, Q41, Q43 | 239403072 |

### Training mode (14)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Per person, not per district; practice kept in separate tables, door and channels refuse training jobs, products without a practice layer open view-only; a release without the check fails (TM-A15) | TM-R1-R5, RK-25 | 239304705, 238845954 |
| Dispatch part (nice to have): band "Training mode: nothing you do here is sent or saved for real", Save (practice), per-person practice layer never in plan of record, log or T&A; non-practice writes refused and logged; prints say "TRAINING: not real"; practice deleted after `Training_KeepDays` (30) | DS-R55 / AC-55.1..55.13 | 238157830 |
| District enables Training_Enabled; a person in Training_UseRoles picks Training mode in the user menu and it stays on in every product until "Back to real work" (which confirms first) | TM-R1 / TM-A1 | 238747676 |
| Training-only accounts open every product in training mode and cannot switch it off until the trainer releases them; marking and releasing are logged | TM-R2 / TM-A2 | 238747676 |
| Every screen shows the band "Training mode: nothing you do here is sent or saved for real."; buttons read Save (practice) / Send (practice); printouts and exports carry "TRAINING: not real" | TM-R3 / TM-A3 | 238747676 |
| Trainee sees the real plan and day in own scope; changes go to a per-trainee practice layer in separate tables; "From now on" writes nothing to Pro; no one else sees the practice; conflicts with real changes show only to the trainee | TM-R4 / TM-A4, A5 | 238747676 |
| Nothing leaves: no email, text, push, in-app message, letter or hand-off; no writes to Pro, GeoIMS, day layer, BP Web notices, Fleet, Trips, Workflow, T&A, trackers, SIS; settings and roles view-only; the door returns 403 "Training mode: not saved for real" and logs it; products without a practice layer open view-only | TM-R5 / TM-A6..A8 | 238747676 |
| Practice outbox records audience count, channel and wording per would-be send ("Not sent: training mode. Would have gone to N families…") | TM-R6 | 238747676 |
| Trainer's pages (IF-TM-01, BP Web, roles in Training_TrainerRoles): who is in training, practice logs, outboxes, Watch, Reset practice, Answer as the office, Release (optionally writes a training row) | TM-R7 / TM-A9 | 238747676 |
| Practice scenarios loaded into one trainee's practice (e.g. "6:40 a.m., three drivers out"); Turns training tablet publishes no selection, position, scan or check; employee app follows the same switch; Chipmunk has no training mode | TM-R8, R9, R10 / TM-A10, A11, A16..A18 | 238747676 |
| Practice is audited, excluded from real log / feed / reports / ridership / pay / T&A, kept Training_KeepDays (default 30) after session end then deleted, also deleted at rollover; Training_HideStudentNames (default off) shows student numbers instead of names | TM-R11, R12 / TM-A12..A14 | 238747676 |
| Release check: before every release an automated check signs in a training account, does each listed action and proves no email, text, push, inbox message, hand-off or write left the practice layer | TM-A15 | 238747676 |
| 48 QA tests TM-QA-001..048 cover switching and band, practice layer, nothing-leaves and outbox, trainer pages and scenarios, tablet, employee app, logging / retention / names, release check; retest note: TM-QA-038 not run | TM-QA-001..048 | 238747676 |
| Rollout: Phase 1 TM-R1..R7, R11, R12 in Dispatch, Quick, BP Web; Phase 3 Turns and employee app; Phase 4 Subscription Service refuses training jobs; Phase 5 scenarios; risks TM-K1..K4; questions Q83-Q85 | TM-K1..K4 | 238747676 |

### Time & Attendance (5)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| One absence per person, service day and period shared by Dispatch, T&A and employee app (`ta_absence`); a T&A rejection turns existing cover Needs review | DS-R45 / DS-A88 | 238223396 |
| Each BP Unified employee carries the Pro staffGuid; the vehicle is the busId from the Turns selection (no second bus list); work.planned and work.changed arrive as suggested jobs | TA-R1..R3 / TA-A6..A8 | 238485608 |
| Clock events queue offline with device time plus server time; off-site clock-out is accepted with a reason and flagged; person.retired disables the PIN within 15 minutes; five wrong PINs in 15 minutes lock that employee number only; 40 drivers in 2 minutes at one yard all succeed | TA-R4..R7 / TA-A1..A3, A9 | 238485608 |
| Trips are suggested jobs and work.actual reaches Trips within 5 minutes of clock-out (8:55 to 13:10 = 4.25 hours); an absence entered in Dispatch, the employee app or T&A is one record with hours marked "to confirm" | TA-R8, TA-R9 / TA-A4, A5 | 238485608 |
| 21 QA tests TA-QA-001..021 (person and bus, suggested jobs, clock events, PINs, trips, absences); TA-QA-018 not run at the 2026-10-26 retest; the whole section is a suggested contract, unverifiable until the BP Unified repository is available | TA-QA / TA-K1, RK-10 | 238485608 |

### Performance Management (1)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| defect.reported and bus.grounded on a contractor's bus become compliance items within 1 hour (none for a district-owned bus); monthly count is distinct buses per operator on the day it happened; 5 QA tests PF-QA-001..005; owner unknown (Q30) | PF-R1, PF-R2 / PF-A1, A2 | 238387286 |

### Assistant (1)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Freeze Assistant, retire it only when every screen has an employee-app equivalent (EA-33 parity list), and keep AssistantAppRole until no district signs in with it; 3 QA tests AS-QA-001..003 | AS-A1 | 239534102 |

### Users & Access (17)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Driver signs in to Turns with T&A employee number and PIN (Q15); on the phone with the BP Web driver account; training rule default warns, lapsed licence or medical blocks (Q17) | SY-12, CX-71 | 239173635 |
| Roles and permissions page in Dispatch writes Quick's `GEO_Roles` / `GEO_RolesPermissions`; a role copied and scoped to a yard sees only that yard and the door answers 403 outside it; acting roles end on their until date | DS-R38 / DS-A57..A60 | 238223396 |
| People hold roles, roles hold permissions; no rule reads a role's name; add a person sends an invitation (no typed password); the last holder of cnd:admin and the last transportation contact cannot be removed | SC-R23 / SC-A49..51 | 239337479 |
| Decided: the T&A PIN becomes the driver's Turns sign-in resolved to StaffGuid (Q15); a driver role in the employee app (Q16); lapsed training warns by default and blocks for licence and medical (Q17); route scope per driver OwnRoutes / ChosenRoutes / OwnOperator (default) / AllRoutes (SY-22); one Retire action emits person.retired, closes access everywhere and Delete is blocked while history exists (SY-23); district sets the fallback window length (Q18) | Q15-Q18, SY-22, SY-23 | 238682115 |
| Users, Roles, Customers and Departments move into a Settings area (gear) hidden from everyone except BusPlanner admins and Customer admins; initials and name open My profile in one click; after sign-in people land on the product used last | R1-R5a | 237043713 |
| Sign-in keeps email → Choose your organization → password and adds Forgot password?; wrong password text "Incorrect password. Try again, or click Forgot password?"; changing a password affects only the signed-in organization; rule stays 8 characters + 1 number as a live checklist | R5b, R6-R9a / A4, A6, A8 | 237043713 |
| Forgot password: 6-digit emailed code, valid 24 hours, only the newest code works, 5 wrong tries stop it, tries left shown, sending throttled; a "password was changed" email follows; passwords are never emailed; an admin-sent reset also carries a link to the code page | 5.1, 5.2 / A1-A3, C1, C3 | 237043713 |
| Users page has Add a user, Add many from a spreadsheet, search, role chips and "Haven't signed in after 7 days (n)"; Status is Active / Hasn't signed in yet / Turned off; no Delete on rows; one automatic 7-day reminder email; Resend welcome does not change the password | R10, R11, R14a-c / B3, B4 | 237043713 |
| Add a user is a four-step pop-up (Name and password → Role → What they can see → Check and add); an email at another organization is allowed, the same email here is an error; "Make one for me" gives a readable password; choose-own-password and welcome email are on by default | R12 / A7, D5, D6 | 237043713 |
| Edit a user has tabs Details and password / Role / What they can see, Email a reset code, a Can sign in toggle (Turned off keeps history) and Remove in the footer with a confirm | R14 | 237043713 |
| Bulk upload: per-organization .xlsx template; .xlsx or .csv up to 2,000 rows; blank scope = All; comma or semicolon separated codes or names; nothing is added until the final button; check screen offers inline fixes; an email already here updates that person | 7.1, 7.2 / D7, D8, Q6 | 237043713 |
| Bulk progress shows added / updated / didn't work / skipped and can run in the background; generated passwords appear only in the downloadable results file | 7.3 / D9 | 237043713 |
| Customer admin edits a customer's name, time zone and notes only; only BusPlanner admin adds customers, switches products or toggles Active; Departments are one list per customer under Settings and cannot be deleted while people are limited to them | R19-R24 / B5 | 237043713 |
| Later phase: Microsoft SSO, MFA, magic link, "Keep me signed in", change history; out of scope: self sign-up, per-database permissions (Quick / Pro), shared role templates, API keys | section 13 | 237043713 |
| Login V1: email → lookup in client_registry.BPUsers → "Choose your organization" only when more than one record → password validated in the chosen client's database; unknown email shows "We couldn't find a BusPlanner account for that email..." | Login V1 s6, Screen 1 | 58851500 |
| Login V1 password screen has read-only email with Change, show / hide and "Sign in with Password" only; rate limiting and bot detection on lookup and login; email and tokens never in URL query strings | Login V1 Screen 3, s9 | 58851500 |
| Login V2 (deferred): district-level SSO with one button per SSO-enabled pln_district, MFA, magic link, Keep me signed in; V3: show only the enforced method; open: wrong-password lockout policy, session TTL, supported IdPs | Login V2 / V3, Q6, Q8 | 58851500 |

### GPS+ (5)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Create a vehicle → route mapping by choosing operator, vehicle and route in one flow, with Effective (default today) and optional Retire date; cannot save without both; runs and components are not in the picker | FR-1, FR-2, FR-8 / US-1, US-2 | 238518274 |
| Reassigning an already-mapped vehicle or route shows a confirmation naming the existing mapping; confirm retires the old mapping today and applies at once; cancel changes nothing; unmapped pairs stage silently until Save | FR-4 / US-4 | 238518274 |
| Search by bus number, plate, depot, operator, route number or name; Unmapped Vehicles and Unmapped Routes queues with counts that always reflect today | FR-3, FR-5 / US-3, US-5 | 238518274 |
| "Effective as of" date shows mappings active that day; History tab is a read-only log; a mapping moves to History when its retire date is reached | FR-6, FR-7 / US-6, US-7 | 238518274 |
| Bulk wizard Upload → Match fields → Review → Done; Next disabled until Vehicle + Route are mapped; auto-match or saved template; rows tagged Ready / Reassign / Error; open: where a mapping persists (new table or write-back to Pro), required fields, .csv support | US-8..US-10 / OQ-1..OQ-4 | 238518274 |

### Redistricting (2)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| Enrollment Projection: tables BPX_EnrollmentScenario (163), BPX_FeederRule (164), BPX_EnrollmentCount (165) at DB 12.4.1; base-year count uses Main enrollment, COUNT DISTINCT student, date-active scope; with no rule students move up one grade in place; feeder Shares must sum to 1.0 +/- 0.001 (never renormalised); capacity shows "Not set" / "Closed", never 0%; reuses permissions 1033 / 1034 | Part 28 §13-§14 | 238321767 |
| Projection UX and readiness: wizard of three questions, plain-language terms, punch list of students with nowhere to go, always-visible "no past counts" banner, capture must run before Grade Rollover (guard on ModifyType 'Automatic - Grade Rollover'), board export built off results not the grid (about 25,000 rows), 13-item readiness gate incl. French copy and CReportableGrid regression pass (Eng / QA) | Part 28 §15-§17 | 237797385 |

### Other (3)

| Proposed behaviour (not shipped) | Requirement / AC id | Page id |
|---|---|---|
| New-platform gaps (unified schema v7.22): no tables yet for equipment / seats (Q71), held notices, driver inbox, Dispatch change log, rider absences, hand-offs, planned cover (Q72); no school or route scope (Q73); ins_ inspection tables conflict with the one-engine decision (Q74); one employee per vehicle per day (Q70 decided: row per person, bus, day, role, period) | Q69-Q74 | 238321683 |
| Bench demo rules: localhost only, today and to-be side by side, every proposed element tagged data-spec with its requirement id, no person names in seed data, nothing committed, product's OK needed before running | §11.9 | 238419971 |
| Prototype rules (not shipped): driver callout creates one entry per assigned run per period per weekday; only Split may leave unassigned stops and allows unlimited covering drivers; D/U and D/B are identical in code (label only); travel proxy clamped 2 to 15 min plus 10 min to school; bell risk late <0, urgent <=20, soon <=45 min; history edits need PIN plus reason | R1..R14 (KT doc) | 238157851 |

## 6. System inventory / integration map

331 items: SY-n system rules and shared services, CX-n connections, IC-n integration contract, IF-xx-nn interfaces, named events and others. Each row says TODAY or TO-BE.

| Id | System / connection | What it does | Talks to | Page id |
|---|---|---|---|---|
| SY-1 | Keep every product; link them | Rule TO-BE: no product reads another product's database | all | 239140866 |
| SY-2 | One door for new links | Rule TO-BE: BPInfo REST; existing links stay until replaced | all | 239140866 |
| SY-3 | Hand-offs are named events | Rule TO-BE: one sender, list of receivers, retry-safe outbox, never sends twice | all | 239140866 |
| SY-4 | One record per thing | Rule TO-BE: bus, person, student, route linked everywhere, one owner per field | all | 239140866 |
| SY-5 | One owner per audience | Rule TO-BE: parents - parent channel; drivers - driver channel; office - BP Web and Quick; mechanics - Fleet | all | 239140866 |
| SY-6 | Plain words | Rule TO-BE: grade 6, no codes or GUIDs, one word per thing | all | 239140866 |
| SY-7 | Pro is the fixed source of truth | Rule TO-BE: every write names its database; standalone modes keep working; no nightly copy reads | Pro | 239140866 |
| SY-8 | Parents always see the latest | Rule TO-BE: within one refresh (60 s default) | Chipmunk, Dispatch, Turns, employee app | 239140866 |
| SY-9 | The server's clock is the clock | TODAY device time only; TO-BE device time plus server time, gap flagged | door, Turns, Dispatch | 239140866 |
| SY-10 | The door: BPInfo REST | TODAY 99 controllers, role-gated; TO-BE all new links and new endpoints | every app; not Fleet / Workflow today | 239173635 |
| SY-11 | Bus registry | TODAY only link is BPL_AVLVehicleRoute (GPS device to bus and route / run; RunGuid null = whole route); TO-BE one link record Pro / Fleet / GPS / Trips plus Bus links page | Pro, Fleet, GPS readers, Trips, Turns, Dispatch | 239173635 |
| SY-12 | People registry | TODAY people in 7-8 places; TO-BE Pro staff record owns the person, one assignable-drivers list | Pro, Quick, BP Web, Fleet, Trips, T&A, Turns, Subs | 239173635 |
| SY-13 | Driver channel | TODAY none; TO-BE one inbox in Turns and the employee app for all driver messages | door, Turns, employee app, Dispatch, Fleet, Trips | 239173635 |
| SY-14 | Parent channel | TODAY two pipelines (email via Subscription Service, push via Chipmunk tracker to OneSignal), held by Send Run Changes for Dispatch; TO-BE one channel, held and merged | Subscription Service, trackers, Chipmunk, Delays, Dispatch | 239173635 |
| SY-15 | Live tracking | TODAY 9 readers and 2 trackers; TO-BE readers pass meters, status events, fault codes | GPS vendors, trackers, Fleet | 239173635 |
| SY-16 | Forms engine: FormModule | TODAY serves Turns checks (GetLatest, SubmitResults; HasFailure, IsOperable, IsFailure, IsNonOperable), nothing reads results but the email; TO-BE the one inspection engine | Turns, Fleet, Quick DB | 239173635 |
| SY-17 | Settings: always say which store | TODAY 8 store families; TO-BE every CX names its setting and store | BP Web, trackers, Dispatch | 239173635 |
| SY-18 | Where the bus position comes from | TODAY installed GPS unit only; TO-BE BusPositionSource setting | Turns, trackers, Dispatch | 239173635 |
| SY-19 | When parents can see the bus | TODAY time windows; TO-BE driver's selection decides | Turns, Chipmunk tracker, Chipmunk | 239173635 |
| SY-20 | Linked runs | TO-BE how Dispatch changes one run inside a route (10 steps and move checks) | Dispatch, Turns, trackers, Chipmunk | 239173635 |
| SY-21 | A driver drives a run that isn't theirs | TO-BE "Drive another run" with limits, audit, auto-expiry | Turns, Dispatch | 239173635 |
| SY-22 | A driver's route scope | TODAY scope per shared account only; TO-BE per-person scope on the Pro staff record | Turns, Subs, door | 239173635 |
| SY-23 | Retire, never delete | TO-BE one Retire action, access closed everywhere, delete blocked while history exists | all | 239173635 |
| SY-24 | One plan, a change feed and a day layer | TO-BE (proposed) no nightly copy; feed polls Pro Change Tracking every 30-60 s and publishes plan.changed | Pro, Dispatch, trackers, Turns, Chipmunk | 239173635 |
| SY-25 | Training mode | TO-BE (proposed) practice layer per person | every product with screens | 239173635 |
| SY-26 | Moving districts to the new Turns, Chipmunk and Dispatch | TO-BE (proposed) Beta inside today's apps, no second app, Dispatch switch day per district with a way back | Turns, Chipmunk, Dispatch | 239173635 |
| IC-1 | Keys | TO-BE contract: wire keys per thing; never key on a name, bus number, route number or staff number | all | 238321683 |
| IC-2 | Time | TO-BE contract: ISO 8601 with offset, UTC storage, deviceTime plus serverTime, service day | all | 238321683 |
| IC-3 | Hand-offs | TO-BE contract: envelope, at-least-once, 35 days, one feed on the door (IF-BI-21) | all | 238321683 |
| IC-4 | REST rules | TO-BE contract: authorize with named roles, errors, idempotency, paging, server-side scope | door, trackers, internal APIs | 238321683 |
| IC-5 | App versions and releases | TO-BE contract: read-ahead release, 180-day support | apps | 238321683 |
| IC-6 | Settings | TO-BE contract: key, store, default, owner, cache; feature switches; levels; one owner per setting | all | 238321683 |
| IC-7 | Data classes and privacy | TO-BE contract: 8 classes; push bodies carry no personal information | all | 238321683 |
| IC-8 | Audit | TO-BE contract: who, product, when, before/after, why; retention 400 days operational, 7 years staff / training / inspection (assumed) | door | 238321683 |
| IC-9 | Offline and retries | TO-BE contract | devices | 238321683 |
| IC-10 | Building against stubs | TO-BE contract: contract test and stub per interface | all | 238321683 |
| IC-11 | Roles, permissions and scopes | TO-BE contract: district-owned roles, catalogue of permissions, scopes, acting roles | all | 238321683 |
| CX-1 | SIS to Pro | TODAY works: SIS file, Student Update task (SFTP), Pro live DB | SIS, Pro | 239173656 |
| CX-2 | GPS vendors to BusPlanner | TODAY works for positions and scans; meters dropped | vendors, readers, GPS target | 239173656 |
| CX-3 | Nightly copies feed the apps | TODAY works but destroys same-day Dispatch writes (_WEB copy and Dispatch DB) | Pro, BP Web, Dispatch | 239173656 |
| CX-4 | BP Web settings and accounts reach every app | TODAY works (TurnsSettings, SubsSettings, ChipmunkSettings, WebSettings) | BP Web, BPInfo, apps | 239173656 |
| CX-5 | Planned data and GPS positions through the door | TODAY works | _WEB copy, GPS target, Dispatch DB, BPInfo | 239173656 |
| CX-6 | The two trackers load planned data | TODAY works with DF-4 restart re-send | BPInfo, trackers | 239173656 |
| CX-7 | Chipmunk served through two doors | TODAY BPInfo and Chipmunk tracker expose the same controllers; TO-BE one (Q6) | Chipmunk | 239173656 |
| CX-8 | Turns gets routes, runs, students, directions | TODAY works, offline once loaded | BPInfo, Turns | 239173656 |
| CX-9 | Turns tells which bus runs which run | TODAY works with gaps (SubmitGPSRouteVehicle to BPL_AVLVehicleRoute) | Turns, trackers, Chipmunk, Dispatch | 239173656 |
| CX-10 | Turns records who gets on and off | TODAY works where scan cards exist | Turns, trackers, Chipmunk | 239173656 |
| CX-11 | Pre/post-trip checks in Turns | TODAY works, results go nowhere but an email; gate Turns_EnablePrePostInspections | Turns, FormModule, Quick DB | 239173656 |
| CX-12 | Bus swap from the tablet | TODAY works; gates TurnsSubstitutionsEnabled, AppSubstitutionsByRun, Turns_SubstitutionsRetireAtMidnight | Turns, Subs, trackers | 239173656 |
| CX-13 | Dispatch tells the driver a route changed | TODAY missing to the tablet (email digest only) | Dispatch, Turns | 239173656 |
| CX-14 | Office and drivers message each other | TODAY missing | Dispatch, Turns | 239173656 |
| CX-15 | Subs app puts subs on buses and runs | TODAY works | Subs, BPInfo, trackers | 239173656 |
| CX-16 | A dispatcher's change emails parents | TODAY held via Send Run Changes | Dispatch, Subscription Service | 239173656 |
| CX-17 | A dispatcher's change pushes to the parent app | TODAY server push at send, about 2 s; none on weekends | Dispatch, Chipmunk tracker, OneSignal | 239173656 |
| CX-18 | A dispatcher swaps a bus or driver | TODAY reaches the app, not the parent; DF-10 to DF-12 open | Dispatch, trackers, Chipmunk | 239173656 |
| CX-19 | Dispatch shows buses live | TODAY works (GPS+, Reassign Dashboard); vehicles vanish if reader settings differ between live and tracker Pro DBs | trackers, Dispatch | 239173656 |
| CX-20 | Dispatch adds drivers and monitors | TODAY uses Pro staff; TO-BE person added becomes Pro record | Dispatch, Pro | 239173656 |
| CX-21 | Parent app finds its district | TODAY works for one district at a time (Quick Code, appapi.busplannerweb.com) | Chipmunk, Turns, Subs, Delays, BPInfo | 239173656 |
| CX-22 | Parent app shows bus and ETA | TODAY works with gaps (ETA, ETA2) | Chipmunk, Chipmunk tracker | 239173656 |
| CX-23 | Parents sign in with Parent Portal account | TODAY works (WebAccount, SSOTokenLogin, OidcTokenLogin; ParentLogin_UseBPProContacts) | Chipmunk, BP Web | 239173656 |
| CX-24 | Parents message the district | TODAY works (Chipmunk Message Manager) | Chipmunk, BP Web | 239173656 |
| CX-25 | District notices reach the parent app | TODAY works; gate Chipmunk_BPWebAlertsEnabled; DoNotPushToApp dropped | BP Web, BPInfo, Chipmunk tracker | 239173656 |
| CX-26 | "Bus is near" alerts | TODAY fires on radius regardless of run | Chipmunk tracker, Chipmunk | 239173656 |
| CX-27 | Parents choose which emails they get | TODAY missing | parent channel | 239173656 |
| CX-28 | Scannable student code | TODAY missing | Chipmunk, Turns | 239173656 |
| CX-29 | Delay and closing alerts reach Delays | TODAY works; nine OneSignal keys; manual reset date | BP Web, Subscription Service, OneSignal, Delays | 239173656 |
| CX-30 | Delays reads notices and routes | TODAY works | Delays, BPInfo | 239173656 |
| CX-31 | Chipmunk tracker hands notices to Subscription Service | TODAY works with TRK-1, SHR-2 | Chipmunk tracker, Subscription Service | 239173656 |
| CX-32 | BP Web reads planned data, hosts parent and admin pages | TODAY works | _WEB copy, GeoIMS, BP Web | 239173656 |
| CX-33 | Fleet reads staff, buses, routes from Pro | TODAY optional | Fleet, GEDI, GeoIMS | 239173656 |
| CX-34 | Fuel transactions give Fleet its odometer | TODAY works (fixed-width file) | fuel system, Fleet | 239173656 |
| CX-35 | GPS vendors give Fleet meters and fault codes | TODAY missing | readers, Fleet | 239173656 |
| CX-36 | Fleet sends checklists to Turns | TODAY missing (W13 outbox local only) | Fleet, FormModule, Turns | 239173656 |
| CX-37 | A failed check becomes shop work | TODAY missing | FormModule, Fleet | 239173656 |
| CX-38 | Driver learns the repair is done | TODAY missing | Fleet, driver channel, Turns | 239173656 |
| CX-39 | "Do not drive" tells the office | TODAY missing | Fleet, Dispatch | 239173656 |
| CX-40 | Fleet shows where its buses are | TODAY missing | live tracking, Fleet | 239173656 |
| CX-41 | Fleet sends costs to finance | TODAY works with defects (BPFleetService ExportManager to SAP / GL); out of scope | Fleet, finance | 239173656 |
| CX-42 | Trips uses BusPlanner drivers, buses, schools | TODAY works, off by default | Trips, BPInfo | 239173656 |
| CX-43 | Trips gets directions from Google | TODAY works, external | Trips, Google | 239173656 |
| CX-44 | The trip shows on the driver's tablet | TODAY missing | Trips, Turns | 239173656 |
| CX-45 | Trip miles reach Fleet | TODAY missing | Trips, Fleet | 239173656 |
| CX-46 | Workflow reads and writes Pro | TODAY works | Workflow, GEDI, Pro | 239173656 |
| CX-47 | Workflow pre-trip template overlaps Turns inspections | TODAY two designs; TO-BE one engine (Q2) | Workflow, FormModule | 239173656 |
| CX-48 | Performance Management reads operators and incident counts | TODAY works | PM, BPInfo | 239173656 |
| CX-49 | Failed inspections count toward a contractor's record | TODAY missing | Fleet, PM | 239173656 |
| CX-50 | Quick reads Pro through GeoIMS | TODAY works | Quick, GeoIMS | 239173656 |
| CX-51 | Adding many students to runs at once | TODAY one at a time | Quick, Pro | 239173656 |
| CX-52 | Driver training records live on the person | TODAY partly (BPL_StaffTraining, BPX_TrainingType) | Pro, Quick, Fleet, BP Web | 239173656 |
| CX-53 | Assistant app reads plan data | TODAY works | Assistant, BPInfo | 239173656 |
| CX-54 | BP Web Where's My Bus / Vehicle Locator ask the GPS vendor directly | TODAY works, second position path | BP Web, Geotab / Synovia / Zonar | 239173656 |
| CX-55 | Employee app shows the plan by scope | TO-BE (app is new; data paths exist) | door, employee app | 239173656 |
| CX-56 | Employee app shows buses live, planned vs actual | TO-BE | live tracking, employee app | 239173656 |
| CX-57 | Employee app shows ETAs by school, run, student | TO-BE new endpoint (today ETA2 requires Subscriber role) | tracker, employee app | 239173656 |
| CX-58 | Employee app shows the bus really on each run | TO-BE | bus registry, employee app | 239173656 |
| CX-59 | Mechanics see the bus's shop story | TO-BE | Fleet, door, employee app | 239173656 |
| CX-60 | Mechanics see warning lights and fault codes | TO-BE | readers, employee app | 239173656 |
| CX-61 | Mechanics see check results and photos | TO-BE | forms engine, employee app | 239173656 |
| CX-62 | Mechanics act from the phone | TO-BE | employee app, Fleet | 239173656 |
| CX-63 | Staff message a driver | TO-BE | employee app, driver channel | 239173656 |
| CX-64 | Staff sign in with roles and scopes | TO-BE | people registry, employee app | 239173656 |
| CX-65 | Quick and Dispatch changes from the phone | TO-BE, gated by BPProPermissions | employee app, Quick, Dispatch DB | 239173656 |
| CX-66 | Turns tablet can be the bus's GPS | TODAY missing; TO-BE SY-18 | Turns, GPS target, trackers | 239173656 |
| CX-67 | Driver's selection decides when parents see the bus | TODAY time window; TO-BE SY-19 | Turns, Chipmunk tracker | 239173656 |
| CX-68 | Dispatch changes one run inside a linked route | TODAY driver not told; TO-BE SY-20 | Dispatch, Turns, trackers | 239173656 |
| CX-69 | A driver takes a run that isn't theirs | TODAY off / Dispatch not told; TO-BE SY-21 | Turns, Dispatch | 239173656 |
| CX-70 | Training module writes to the person's record | TODAY missing | training module, Pro | 239173656 |
| CX-71 | Training status decides who can be assigned | TODAY missing | people registry, Dispatch, Trips, Subs, Turns | 239173656 |
| CX-72 | T&A knows the person, bus and planned work | TODAY partly (clock actions only) | Turns, BP Unified | 239173656 |
| CX-73 | A trip reaches the driver's phone and tablet | TODAY missing | Trips, Turns, employee app | 239173656 |
| CX-74 | Retiring a driver reaches every product | TODAY missing | all | 239173656 |
| CX-75 | Drivers see their day on their phone | TODAY web driver portal only | employee app, BP Web | 239173656 |
| CX-76 | Turns tells Dispatch who is on the bus | TODAY driver from BPL_VehicleStaff only; TO-BE Crew/Submit within a minute | Turns, Dispatch, T&A | 239173656 |
| CX-77 | Parent says the student is not riding today | TODAY missing | Chipmunk, Turns, Dispatch | 239173656 |
| CX-78 | A driver reports what happened on the bus | TODAY missing | Turns, employee app, Ride Support | 239173656 |
| CX-79 | The school's decision reaches the bus | TODAY missing | Ride Support, Turns, Dispatch | 239173656 |
| CX-80 | The family gets the school's letter | TODAY missing | Ride Support, parent channel, Chipmunk | 239173656 |
| CX-81 | The record reaches the SIS; behavior by run | TODAY missing | Ride Support, SIS | 239173656 |
| CX-82 | A rider's seating needs carry dates | TODAY partly (one seat type, undated) | Pro, Turns, BP Web | 239173656 |
| CX-83 | Each bus's real seat layout reaches every chart | TODAY partly (per vehicle type only) | Fleet, BP Web, Pro, Turns | 239173656 |
| CX-84 | Fuel and miles reach the people who need them | TODAY partly (inside Fleet only) | Fleet, employee app, Turns | 239173656 |
| CX-85 | Who met the child at the stop | TODAY partly (display only) | Turns, Dispatch, Chipmunk | 239173656 |
| CX-86 | Parents name adults who may meet their child | TODAY missing (Parent Portal shows them read-only) | Chipmunk, BP Web, Turns | 239173656 |
| CX-87 | A rider who isn't routed reaches Dispatch | TODAY missing | Turns, Dispatch | 239173656 |
| CX-88 | The driver rearranges the seats | TODAY missing on the tablet | Turns, Pro, BP Web | 239173656 |
| IF-BI-01..12 | Door interfaces that exist: Token, ClientEndpoint, plan reads, SubmitScanEvent, GPSRouteVehicle, FormModule, FormModuleTemplate, app settings, tracker imports, Driver / School / Vehicle etc., Delays, MinimumAppVersion | TODAY exist (some to be changed) | apps, trackers, Trips, PM | 238321683 |
| IF-BI-20..52 | New door interfaces: PIN token, Handoff feed, People, BusRegistry, EffectiveBus, DriverDay, Inbox, SubmitPositions, Selection, RunClaim, failed results, BusProblems, VehicleSignal, DriverTrips, Settings, Crew, Absence, Conduct, BusInstruction, Handover, AuthorizedAdult, Bus/Layout and SeatChart, Plan/Changes and DayLayer, Training, FamilyMessage, Emergency, Run/EmptyCheck | TO-BE new | every product | 238321683 |
| IF-GI-01..09 | GeoIMS commands (staff, merge / split, move checks, settings, seats; IF-GI-09 withdrawn) | 01-06 TODAY exist, changed; 07-08 TO-BE | door, Quick, Fleet | 238321683 |
| IF-LT-01..06, 20, 21 | Tracker interfaces: ETA2/Get, Dispatch/UpdatePlannedInfo, AssignVehicleToRoute, GetTrackerGPSLiveRoutes, Monitoring/ResetSettingsCache | 01-05 TODAY exist; 06, 20, 21 TO-BE | Chipmunk, Quick, employee app | 238321683 |
| IF-SS-01..03, IF-BW-01..03 | Parent-change job, parent preferences, scheduled checks host; BP Web settings store, driver accounts, Bus links page | SS TO-BE; BW-01/02 TODAY exist, changed; BW-03 TO-BE | Quick, trackers, apps | 238321683 |
| IF-DS-01..05, IF-QS-01..02 | Dispatch actions, Send Run Changes, Quick settings, Today page, day sheet as APIs; retire action, ridership API | TO-BE (DS-02 exists as Quick page actions) | employee app, T&A | 238321683 |
| IF-FT-01..03, IF-TP-01..02, IF-PF-01, IF-TA-01..03 | Fleet read / actions / settings; Trips settings and finance export; PM settings; T&A PIN auth (IF-TA-01 exists, anonymous), links, work.actual | TO-BE except IF-TA-01 TODAY | door, Turns, Trips | 238321683 |
| IF-SP-01..03, IF-SC-01..02, IF-TM-01, IF-DB-01..02 | Settings program, Ride Support pages and letter jobs, trainer pages, Dashboard and its reads | TO-BE | staff, schools | 238321683 |
| login.mapped / login.failed | Turns to trackers, Dispatch, Chipmunk: which bus runs which run | TO-BE (bench TN-1) | CX-9 | 238026754 |
| vehicle.substituted / vehicle.override | bus or driver swap (Turns, Subs, Dispatch); dispatcher's override | TO-BE (bench) | CX-12, CX-18 | 238026754 |
| dispatch.change / notification.held / notification.discarded / notification.weekendSuppressed | planned change to parent channel; hold or merged steps; weekend suppression | TO-BE (bench DP-1) | CX-16, CX-17 | 238026754 |
| email.sent / push.sent / sms.sent (parent) | parent channel to parents, result back to the Dispatch ledger (sms.sent only in payload table) | TO-BE | Subscription Service, Dispatch | 238321683 |
| alert.posted | BP Web or Dispatch notice with comment and reason to Chipmunk and Delays | TO-BE (bench CM-8) | CX-25, CX-29 | 238026754 |
| eta.frozen / eta.thawed | tracker to Chipmunk: ETA quality | TO-BE (bench CM-6) | CX-22 | 238026754 |
| push.sent / push.suppressed / push.acknowledged (driver) / message.sent | driver channel and Turns: route change, driver's answer (Got it / I can't do this run); office-driver message | TO-BE (bench TN-2, TN-4) | CX-13, CX-14 | 238026754 |
| checklist.published / inspection.submitted / defect.reported / repair.done | Fleet to FormModule to Turns; Turns check to Fleet; problem to mechanics; fix to driver | inspection.submitted exists TODAY as SubmitResults; rest TO-BE (Fleet W08-W13 local) | CX-11, CX-36 to CX-38 | 238026754 |
| bus.grounded / bus.returned / reading.received | Fleet "do not drive" and back; readers' meters, events, faults to Fleet | TO-BE new | CX-39, CX-35 | 238026754 |
| scan.recorded / scan.notRiding / rider.unrouted | rider on or off (exists TODAY as SubmitScan); scan of a rider the school said is not riding; scanned student with no stop | TO-BE except SubmitScan | CX-10, CX-79, CX-87 | 238026754 |
| trip.assigned / trip.changed / trip.cancelled / trip.offered / trip.declined / trip.completed | Trips to driver channel, Dispatch, T&A, Fleet (last three only in payload table) | TO-BE new | CX-44, CX-73 | 238321683 |
| person.added / person.retired / training.expiring / training.expired | people registry events | TO-BE new | CX-20, CX-74, CX-52, CX-71 | 238026754 |
| work.planned / work.changed / work.actual | planned runs, trips, classes to T&A; actual hours back | TO-BE new | CX-72 | 238026754 |
| form.approved | Workflow approved change to Pro and apps | TO-BE new | CX-46 | 238026754 |
| position.reported / source.switched / selection.started / selection.ended | tablet position; GPS source change; which runs are open for parents | TO-BE new | CX-66, CX-67 | 238026754 |
| itinerary.changed / run.claimed / crew.changed | Dispatch run moves to driver; driver took another run; who is on the bus | TO-BE new | CX-68, CX-69, CX-76 | 238026754 |
| rider.absent / rider.riding / stop.skipped | student not riding today or riding after all; driver skipped a stop | TO-BE new | CX-77 | 238026754 |
| equipment.overridden / plan.changed | dispatcher overrode an equipment check; plan change from the change feed with before / after / effective date | TO-BE new | DS-R4, SY-24 | 238026754 |
| leave.recorded / leave.changed / cover.planned / cover.needsReview | staff absence entered ahead; cover planned or no longer fitting | TO-BE new | DS-R22 to DS-R24 | 238026754 |
| conduct.submitted / conduct.decided / conduct.withdrawn | behavior report (no names), the school's bus instructions, report withdrawn | TO-BE new | CX-78, CX-79 | 238026754 |
| suspension.decide / suspension.call / suspension.contacts | Dispatch decides on a suspended rider's scan; office asked to call; contacts told (only in payload table) | TO-BE new | TU-R34, SC-R25 | 238321683 |
| emergency.raised / run.emptyChecked | emergency from a bus (type, bus, position); end-of-run empty-bus check | TO-BE new | TU-R31, TU-R30 | 238026754 |
| seatNeed.changed / bus.layoutChanged / seatChart.changed / seatChart.suggested | dated seating need; bus layout change with riders to reseat; seats moved or suggested | TO-BE new | CX-82, CX-83, CX-88 | 238026754 |
| rider.handedOver / rider.notReleased / handover.noted / adult.proposed / adult.decided / adult.removed | who met a met-at-bus rider or no adult; driver's note; adults a parent names and the decision | TO-BE new | CX-85, CX-86 | 238026754 |
| CX-1, CX-3, CX-5, CX-8, CX-22, CX-51 | Student data path (J14) | SIS -> Pro -> nightly copies -> apps; bulk add from Quick follows the same path; TODAY (to-be adds data-freshness display) | SIS, Pro, Dispatch DB, _WEB copy, Turns, Chipmunk | 238092292 |
| CX-2, CX-6, CX-19, CX-22, CX-26, CX-54 | Morning run (J1) | GPS readers send positions; trackers loaded with the day's plan compute ETA and "bus is near"; Dispatch sees the bus live; Where's My Bus asks the GPS vendor directly; TODAY | GPS readers, trackers, Chipmunk, Dispatch web, BP Web | 238092292, 238223375 |
| CX-9, CX-10, CX-28 | Turns sign-in and scans (J1, J2) | login.mapped at driver sign-in; offline scan -> scan.recorded; boarding code in Chipmunk is TO-BE | Turns, the door, Chipmunk | 238092292 |
| CX-13, CX-16, CX-17, CX-50 | Dispatch change (J3) | Quick writes through GeoIMS -> dispatch.change; parent channel holds and merges, one email (CX-16) and one push (CX-17); driver channel CX-13 is TO-BE | Quick, GeoIMS, Subscription Service, Turns | 238092292 |
| CX-12, CX-15, CX-18, CX-20, CX-39 | Bus / driver swap (J4) | Swap from Turns, Subs, Dispatch or a grounded bus in Fleet all emit vehicle.substituted; trackers follow; partly TODAY, parent message TO-BE | Turns, Subs, Dispatch, Fleet, trackers | 238092292 |
| CX-25, CX-29, CX-30, CX-31 | Alerts and delays (J5) | BP Web notice -> alert.posted -> Chipmunk and Delays; Chipmunk tracker hands it to the Subscription Service; TODAY with gaps R1-R3 | BP Web, Chipmunk, Delays, Subscription Service | 238092292 |
| CX-7, CX-21, CX-23, CX-27, CX-32 | Parent sign-up (J6) | Chipmunk finds the district, talks to its door, signs in with a Parent Portal account hosted in BP Web; TODAY | Chipmunk, BPInfo, BP Web | 238092292 |
| CX-11, CX-36, CX-37, CX-38, CX-47 | Inspection loop (J7) | checklist.published, inspection.submitted, defect.reported, repair.done; one engine FormModule; TO-BE (Fleet side W06-W09, W11, W13 local only) | Fleet, Turns, the door | 238092292, 238223375 |
| CX-34, CX-35, CX-40 | Miles and hours to Fleet (J8) | reading.received from GPS readers drives due dates; fuel import is fallback (TODAY); vehicle map; TO-BE / local | GPS readers, Fleet | 238092292 |
| CX-42, CX-43, CX-44, CX-45, CX-46 | Trips and Workflow (J10, J11) | Trips takes bus and driver from registries, directions from Google today (CX-43); Workflow "Save To BusPlanner" writes to Pro (form.approved); mixed TODAY / TO-BE | Trips, Turns, Fleet, Workflow, Pro | 238092292 |
| CX-55 to CX-65 | Employee app paths (J17-J20) | Search bus or student, bus position and ETA, school board, road call, phone swap; TO-BE | Employee app, the door, Dispatch, Fleet | 238092292 |
| CX-66 to CX-69 | GPS source, visibility, linked runs, taking a run (J21-J23) | Tablet GPS fallback, parents see the bus the run is on, move one run out of a linked route, "Drive another run"; TO-BE | Turns, trackers, Dispatch, Chipmunk | 238092292 |
| CX-70 to CX-75 | Driver's working life (J24) | Training dates, clearance, assignment in route scope, PIN clock-in, driver role on phone, retire; TO-BE | Training module, Quick, T&A, Turns, employee app | 238092292 |
| CX-76 to CX-81 | Crew record and behaviour (J25) | Who is on the bus from Turns sign-in (crew.changed); not riding today; referral from tablet, decision to bus, family letters, SIS export; TO-BE | Turns, the door, Ride Support, Dispatch, Chipmunk, SIS | 238092292, 238845954 |
| CX-41, CX-53 | Finance export / Assistant app | Rows no journey uses: finance out of scope; Assistant to be replaced by the employee app | Fleet, Assistant | 238223375 |
| SY-12, SY-18 to SY-26 | System rules cited | SY-12 one person many products; SY-18 GPS source; SY-19 who sees the bus; SY-20 Dispatch move and handover; SY-21 taking a run; SY-22 route scope; SY-23 retire; SY-24 no nightly copy; SY-25 training mode; SY-26 Beta; all TO-BE | all products | 238092292, 239304705 |
| IC-1 to IC-11 | Integration contract | IC-1 keys and databaseGuid, IC-2 time zone, IC-4 scopes, IC-5 app versions, IC-6 settings and flags, IC-7 privacy classes, IC-8 logging, IC-9 offline, IC-10 contract tests and stubs, IC-11 role model; approval pending; TO-BE | all products | 238518296, 239304705 |
| IF-BI-21 to IF-BI-24, IF-LT-20 | Phase A stubbed interfaces | First interfaces to get stubs and contract tests (IF-BI-22 people assignable, IF-BI-24 school board among them); TO-BE | the door, trackers | 238518296, 238419971 |
| IF-BI-36 to IF-BI-52 | Later door interfaces | IF-BI-36 settings, 38 Directions/Route, 39 crew, 40 absence, 41-44 Ride Support, 45 Handover, 46 adults, 47 seats, 48 change service, 49 training state, 50 parent replies, 51-52 emergency and empty-bus; TO-BE | the door, Turns, Chipmunk, Dispatch | 238518296, 238845954 |
| IF-GI-04, IF-GI-05, IF-SS-01, IF-SS-02, IF-DS-01 to IF-DS-05, IF-FT-01, IF-FT-03, IF-TM-01, IF-DB-01, IF-DB-02 | Other interfaces cited | GeoIMS transactional save and move checks; held-notice raise and one subscription list; Dispatch log / send / settings / feed / day sheet; Fleet reads; trainer API; Dashboard; TO-BE | GeoIMS, Subscription Service, Dispatch, Fleet | 238419971, 238518296, 238845954 |
| events | Hand-off events named | login.mapped, scan.recorded, scan.notRiding, dispatch.change, itinerary.changed, vehicle.substituted, bus.grounded, bus.returned, source.switched, alert.posted, plan.changed, crew.changed, rider.absent, rider.riding, stop.skipped, rider.handedOver, handover.noted, equipment.overridden, emergency.raised, run.childLeft, run.emptyChecked, suspension.decide, suspension.call, conduct.submitted / decided / withdrawn, person.added, training.*, trip.assigned / offered / declined / completed, leave.*, cover.*, work.actual, reading.received; TO-BE unless shipped paths above | the door feed | 238092292, 238419971, 239304705, 238845954 |
| pln_snapshot | Per-day snapshot of the plan on BP Unified | TODAY exists (one per day); TO-BE one for every service day ahead, kept, with Dispatch's changes | ETL from Pro, trackers, Turns, parents' app (Q168), Dashboard | 238157830 |
| ta_absence | Shared absence table | TODAY one row per day with hours, type, status; TO-BE one absence per person, day and period shared by Dispatch and T&A | Time & Attendance, Dispatch | 238157830 |
| DB-R2..R9, R14, R15 | Dashboard numbers read from Dispatch | TO-BE: on-time, substitutions, changes, splits and merges, stop completion, path deviation counted from log and plan of record | Dashboard | 238157830 |
| IF-DS-01 | Dispatch actions API | Preview and save for one change or a batch; TODAY exists only as Quick page actions, TO-BE callable through the door | Employee app (phone), Quick, door | 238223396 |
| IF-DS-02 | Send Run Changes ledger API | List, send, schedule, email switch; TODAY Quick page actions, TO-BE through the door | Scheduled-checks host, employee app | 238223396 |
| IF-DS-04 | Today page API | Read, reply, mark handled; TO-BE (new) | Employee app | 238223396 |
| IF-GI-01..05 | GeoIMS interfaces consumed by Dispatch | IF-GI-04 one-transaction moves, IF-GI-05 preview and checks incl. serviced stops; TO-BE | GeoIMS | 238223396 |
| IF-BI-21..24, 26, 45, 50 | Door interfaces | IF-BI-21 `Handoff/Read` feed, IF-BI-22 `People/GetAssignable`, IF-BI-26 driver channel, IF-BI-45 `Handover/Search`, IF-BI-50 `FamilyMessage/Threads`; `EffectiveBus/Get` for crew; TO-BE | BPInfo REST | 238223396 |
| IF-SS-01 | Parent change hand-off | Dispatch passes change facts to the Subscription Service; TO-BE | Subscription Service | 238223396 |
| IF-LT-02, IF-LT-03 | Tracker interfaces consumed by Dispatch | Named only; TO-BE | Trackers | 238223396 |
| Events published | `itinerary.changed`, `vehicle.substituted`, `vehicle.override`, `dispatch.change`, `notification.held`, `notification.discarded`, `work.changed`, `equipment.overridden` | TO-BE | Turns, Chipmunk, T&A, trackers | 238223396 |
| Events consumed | `bus.grounded`, `bus.returned`, `run.claimed`, `push.acknowledged`, `source.switched`, `training.*`, `trip.assigned`, `message.sent`, `plan.changed` | TO-BE | Fleet, Turns, trackers, Trips, Pro change feed | 238223396 |
| Other events | `alert.posted`, `rider.notReleased`, `scan.notRiding`, `suspension.call`, `suspension.contacts`, `cover.planned`, `cover.needsReview`, `leave.recorded`, `leave.changed` | TO-BE | BP Web, Turns, Ride Support, T&A, employee app | 238223396 |
| UpdatePlannedInfo | Tracker `DispatchController.UpdatePlannedInfo` | TODAY: called from the dispatcher's browser with changed route and RunV GUIDs; refreshes planned data and, if NotifySubscribers=true, pushes changes to parents | Dispatch (browser) -> Dispatch tracker and Chipmunk tracker -> OneSignal | 239239170 |
| ETA2/Get | Tracker ETA endpoint (new method); `api/ETA/Get` is the old-method endpoint still called for districts on the old ETA method | TODAY: returns per-student ETA, planned times and unavailable reason | Chipmunk -> Chipmunk tracker | 239108098 |
| ChipmunkSettings/GetV2 | District settings DTO for the app | TODAY: serves BPWeb store-1 Chipmunk settings | Chipmunk -> BPInfo / tracker -> BPWeb DB | 239108098 |
| ClientEndpoint | `ClientEndpoint/GetClientEndpoint(clientCode, applicationGuid)` | TODAY: returns per-district tracker endpoint and OneSignal app id (Turns currently receives the Delays app id) | Chipmunk, Turns -> BPInfo | 237928452 |
| MinimumVersion | `MinimumVersionController.Get(platform, buildString)` | TODAY: app version gate against compile-time minimum builds | Chipmunk -> tracker | 237928452 |
| GPSRouteVehicle/Submit | Turns route-vehicle mapping endpoint; `ApplyDispatchLiveMapping` is the live-DB write used by the admin screen | TODAY: writes `BPL_AVLVehicleRoute` in the live DB | Turns -> BPInfo -> GeoIMS -> Live DB | 239108098 |
| Mapping poll | Tracker GPS-vehicle mapping poll loop (`MappingUpdateFrequency`, effective 10 s when unset) | TODAY: replaces in-memory mappings from the DB chosen by `DispatchDatabaseGuid` (unset = live DB) | Tracker -> Live or Dispatch DB | 237928452 |
| Email pipeline | `SaveLogs` -> `dispatch_ReassignNotification` + `ss_QueueStatus` -> ImmediateManager -> EmailQueue -> MailingWorker (SMTP) | TODAY: dispatch change emails | Dispatch -> BPWeb DB -> BPSubscriptionService -> parents | 239239170 |
| OneSignal | Push provider; targeting by `include_subscription_ids` (external-id targeting disabled as unreliable) | TODAY for parents; TO-BE for Turns drivers | Trackers -> OneSignal -> apps | 239108098 |
| GD_* commands | GeoIMS commands used by the wizard: `GD_OptimizedRun_Get`, `GD_FindClosestRunToStop_Get`, `GD_BusStops_Save`, `GD_BusStop_Save`, `GD_Student_BusStopAssignment_Add`, `GD_Dispatch_MergeRuns`, `GD_Dispatch_OptimizeRuns` | TODAY; `GD_BusStopOptimizer_Suggest` is TO-BE | Quick (RemoteDatabase) -> GeoIMS -> GEDI | 238616579 |
| PathWorker endpoints | `/PathWorker/Stats`, `/PeakWorkerUsage`, `/WorkerCountSufficient` | TODAY: path-worker pool instrumentation | Quick | 238616579 |
| AddStudentsToRuns endpoints | `CountMatchingStudents`, `FindStopsChunk`, `SuggestStops`, `CreateStopsChunk`, `SuggestRuns`, `PreviewRunOrder`, `AssignStudentsChunk`, `CommitRun`, `LogBatchSummary` | TO-BE: stateless chunked endpoints, only Create / Assign / Commit write | Browser -> Quick -> GeoIMS | 238616579 |
| IF-LT-01 | Tracker ETA2 endpoint (`ETA2/Get?languageCode=`) | TODAY: per-student ETAs, stop and bus positions, alerts for the radius method; TO-BE: adds reason code, typed school time, run/stop type, computed-at timestamp, Comment + ReasonType | Chipmunk app, tracker | 238878722 |
| ETA/Get | Tracker old-method ETA endpoint | TODAY: same data for districts on the old ETA method; must also be patched for alert comments | Chipmunk app, tracker | 238256131 |
| IF-BI-02 | `ClientEndpoint/GetClientEndpoint` | TODAY: resolves district endpoint + OneSignal app id from the Quick Code | Chipmunk, Turns, BPInfo REST | 238518317 |
| Tracker app endpoints | `ChipmunkSettings/GetV2`, `UserSettings/Get`, `UserSettings/Update` (PATCH), `UserSettings/GetStudentStops`, `MinimumVersion/Get`, `ChipmunkMessage/Get` and `/Save` | TODAY: district settings, per-parent push prefs and radii, force-upgrade gate, parent messages | Chipmunk app, tracker | 238878722 |
| NotificationInfo feed | BPInfo REST `Tracker/NotificationInfoController.GetBusNotifications` | TODAY: active BP Web alerts minus DoNotPushToApp, polled by each tracker; TO-BE: carries Comment gated by setting | Tracker, BP Web DB | 238256131 |
| IF-SS-02 | Subscription Service notice preferences | TO-BE: per-category email choices shared between app and Parent Portal | Chipmunk, Subscription Service, BP Web | 238518317 |
| IF-BI-40 / IF-BI-45 / IF-BI-46 | Door calls for rider absence, hand-off record (`Handover/Get`), authorised adults | TO-BE | Chipmunk, Turns, BPInfo REST, Dispatch | 238518317 |
| SY-24 / SY-15 | Dispatch database nightly copy read by the tracker / GPS readers' positions read by the tracker | TODAY | Tracker, Dispatch DB, GPS readers | 238518317 |
| CX-10 / CX-13 / CX-24 / CX-26 / CX-77 | Connections: scan notices to families / Dispatch changes to tablet (none today) / parent messages and staff replies / "bus is near" radius / parent absence to driver | CX-10 and CX-26 TODAY; CX-13 gap TODAY; CX-24 partly TODAY; CX-77 TO-BE | Turns, Chipmunk, Dispatch, tracker | 238518317 |
| IC-5 / IC-6 / IC-7 / IC-9 | Cross-cutting rules: read-ahead releases and 180-day old-app support / switches off by default with owner and date / privacy (push bodies carry no names, own children only) / offline queue with device time, marked late over 2 minutes | TO-BE | All apps | 238845975 |
| IF-BI-25 / IF-BI-26 | `DriverDay/Get` (driver's chain of runs) / inbox and `Inbox/Send` on the driver channel | TO-BE | Turns, BPInfo REST, Dispatch | 238845975 |
| IF-BI-27 / IF-BI-28 / IF-BI-29 | Tablet positions every 10 s / selection started-ended / run claim ("Drive another run") | TO-BE | Turns, BPInfo REST, trackers | 238845975 |
| IF-BI-31 / IF-BI-33 / IF-BI-37 / IF-BI-38 | My bus problems / driver's field trips / trip destination check-in / routing provider and reroute (`RunV/Reroute` exists today) | TO-BE except RunV/Reroute | Turns, Fleet, Trips, BPInfo REST | 238845975 |
| IF-BI-43 | Bus instructions, not-riding list, attempt log (`BusInstruction/NotRiding`, `BusInstruction/Attempt`), safety labels | TO-BE | Turns, Ride Support, BPInfo REST | 238845975 |
| IF-BI-48 / IF-BI-51 / IF-BI-52 / IF-BI-12 / IF-BI-24 | Plan-change feed / `Emergency/Raise` / `Run/EmptyCheck` / minimum app version / employee app bus page | TO-BE (IF-BI-12 status unclear) | Turns, Dispatch, employee app | 238845975 |
| IF-TA-01 | Time & Attendance clock interface on BP Unified | TODAY (PIN clock since July 2026, no offline queue) | Turns, BusPlanner Unified | 238845975 |
| Student/GetUnknownStudent | Door lookup for a scanned card not on the run | TODAY | Turns, BPInfo REST | 238845975 |
| WP-1 / WP-1a / WP-2 / WP-7 / WP-10 / WP-11 / WP-12 | Server work packages behind CM-1/3, CM-8.1-8.4, CM-5, CM-2, CM-4, CM-6, CM-7 | TO-BE | Tracker, BP Web, BPInfo REST | 238878722 |
| ENG-1394 / ENG-1390 / ENG-2884 / PROD-553 | Jira items: Left on vehicle flag (released 13.4.0) / scan direction inference / flag fires mid-run (open) / Turns end-of-run check (gathering requirements) | ENG-1394 and ENG-1390 TODAY; others TO-BE | BP Web reports, Turns | 250740737 |
| IF-BI-41 / IF-BI-43 door calls | Conduct/Lists, Conduct/Submit, Conduct/Mine, Conduct/Withdraw, Conduct/LabelViews, Conduct/Release; BusInstruction/Get, NotRiding, Attempt, Tap, Decision, Seen | TO-BE: Turns calls under the driver's token; every POST is repeatable with the same ID; the door never trusts the tablet for bus, run or reporter | Turns ↔ the door ↔ new platform | 237928473 |
| IF-BI-51 / IF-BI-52 | Emergency/Raise and Run/EmptyCheck (BI-R19) | TO-BE: emergency alert and empty-bus check; 403 when Turns_EmergencyButton is off | Turns → the door → Dispatch | 237928473 |
| IF-BI-44 detail | GET Conduct/GetSince?after={cursor} and POST Conduct/GetSince/Confirm | TO-BE: cursor = highest row_version returned; one row per reviewed subject with Ed-Fi-style fields; Confirm sets "in the SIS" | district SIS | 239337500 |
| /api/conduct | New platform's Ride Support REST API (the same as IF-SC-01's pages) | TO-BE: e.g. GET /boot, /subjects, /referrals/{id}; POST /subjects/{id}/steps, /letter, /subjects/bulk, /suspensions/{id}/radio; GET /suspensions/print; each call checks a cnd: permission and scope | web pages, employee app school role | 237928473 |
| suspension.decide / suspension.call / suspension.drivers | Door and module events for the suspended-rider flow | TO-BE: pinned question to Dispatch; call request ("Ask the office to call" or a refused queued Deny); log row per driver message and Got it | Dispatch Today page and log | 237928473 |
| emergency.raised / emergency.typeAdded | Door events | TO-BE: emergency alert (type NOT_CHOSEN after six quick taps) and the type added later | Dispatch feed, emergency contacts | 237928473 |
| SafetyPulse | Dispatch poll for safety rows (prototype name) | TO-BE: light query read every 3 s while Dispatch decides, else every 15 s | Dispatch Today page | 237928473 |
| IF-SC-01 | Ride Support pages on the new platform | TO-BE: review, letters, video requests, lists, Behavior by run, CSV export, reviewer groups, special-education review, notes to driver | staff browsers | 239337479 |
| IF-SC-02 | Letter jobs for the parent channel | TO-BE: letter job on IF-SS-01, kind studentLetter, category "About your child" that families cannot turn off | Subscription Service / Chipmunk / email | 239337479 |
| IF-BI-41..44 | The door's Ride Support endpoints (BI-R16) | TO-BE: IF-BI-43 bus instructions to tablets; IF-BI-44 Conduct/GetSince SIS export (role ConductExport) | Turns, SIS | 239337479 |
| IF-BI-21 / 24 / 26 / 40 / 45 / 47 | Door interfaces consumed | TO-BE use: 21 hand-offs; 24 the bus on the run and its crew; 26 the driver channel / reporter's inbox; 40 not-riding days; 45 hand-over at the stop (Released to); 47 seats and layouts | Turns, Pro, Fleet | 239337479 |
| IF-QS-02 | Quick ridership | Who scanned on/off and each scan's type; TO-BE consumer for unknown-rider lookup, loaded-by-hand list, accident package | Quick | 239337479 |
| scan.notRiding / run.emptyChecked | Events Ride Support consumes | TO-BE: suspended rider scanned on any bus; empty-bus check done | Turns via the door, Dispatch Today page | 239337479 |
| rider.absent (reason school) / rider.riding | Door events for suspended days | TO-BE: suspension day treated as absence; ETAs drop a sole rider's stop within 60 s; lift publishes rider.riding | trackers, Turns, Chipmunk, Quick | 239075331 |
| bus.layoutChanged | Layout save event | TO-BE: every bus layout save goes to Pro and Fleet through the door | Pro, Fleet | 239337479 |
| suspension.contacts | Dispatch log event | TO-BE: one row per suspended-rider scan with who was told and how | Dispatch log | 239337479 |
| IF-DB-01 | The Dashboard on the new platform | TO-BE: numbers, rows, exports, School Viewer and settings | users' browsers | 238583811 |
| IF-DB-02 | The Dashboard's reads | TO-BE: reads Dispatch's log and day records, GPS+ arrivals, stop visits and tracks, and the day's plan in the platform's one database; writes only its own settings | Dispatch (New World), GPS+, day's plan | 238583811 |
| ENG-1910 | GET api/analytics/otp | TODAY: on-time engine (early / on time / late per stop, run, route, school) | GPS+, Live Viewer thresholds, Assistant | 238583811 |
| ENG-1906 | GET api/analytics/path-deviation | TODAY: share of positions off the planned path per route per day | GPS+, Assistant | 238583811 |
| ENG-1320, ENG-1321, ENG-1322, ENG-1324 | GPS+ backlog | TO-BE (not built): unscheduled stops (1320, 1321), arrival and departure times (1322), server-side export (1324) | GPS+, Dashboard | 238583811 |
| GPS substitution import | Bus / driver change round trip | TODAY: GPS+ change goes to BP Info and returns via import about 5 minutes later with no person and no reason | GPS+, BPInfo REST, day's plan | 238583811 |
| Turns sync queue | Services/SyncService.cs | TODAY: queues scans and inspection results offline, retries every 60 s; TO-BE: also carries referrals, door taps, bus instructions, not-riding list | Turns, platform | 239108122 |
| SIS export | Ride Support CSV | TO-BE: one-way CSV for the district's SIS, permission cnd:export; no write-back, API link after V1 | district SIS | 239108122 |
| PROD-793 | District contract commitment | Jira item: real-time KPI dashboard for Dispatch users, exportable, School Viewer version, mockup before the December 2026 board meeting | Dashboard | 238551042 |
| IF-FT-01 | Fleet read API | TO-BE: bus summary, problems, work orders, what's due, parts, fuel and miles, seat layout; door service role only | the door, employee app | 239403009 |
| IF-FT-02 | Fleet action API | TO-BE: start / stop repair timer, note, photo, needs parts, fixed, do not drive | the door, employee app | 239403009 |
| IF-BI-07 | `FormModuleTemplate/CreateTemplate` | TODAY endpoint exists (verified); TO-BE Fleet posts checklists to it | Fleet, the door, Turns | 239403009 |
| IF-BI-06 | `FormModule/GetLatest` | Tablet fetches the latest checklist version (status on this page unclear) | Turns, the door | 239403009 |
| IF-BI-30 | `GetFailedResultsSince` | TO-BE: Fleet reads failed check results by cursor | Fleet, the door | 239403009 |
| IF-BI-32 | `VehicleSignal/GetSince` | TO-BE: meters, faults and status events for Fleet | Fleet, the door, GPS target | 239403009 |
| IF-BI-23 | Bus registry | TO-BE: `busId` to `fleetVehicleId` links | Fleet, the door, BP Web Bus links | 239403009 |
| IF-BI-47 | `Bus/Layout` | TO-BE: seat layouts exchanged between Pro and Fleet | Fleet, Pro, BP Web | 239403009 |
| IF-BI-34 | Employee app bus page feed | TO-BE: Fuel and miles panel outside Fleet | employee app, the door | 239403009 |
| IF-BI-21 | Door interface consumed by Fleet | TO-BE; purpose not stated on this page | Fleet, the door | 239403009 |
| checklist.published / defect.reported / repair.done | Fleet events | TO-BE: checklist sent; defect raised; repair finished (to driver inbox) | Turns, employee app, Performance Management | 239403009 |
| bus.grounded / bus.returned | Fleet events | TO-BE: bus out of / back in service | Dispatch, Trips | 239403009 |
| person.retired | Event consumed | TO-BE: closes the Fleet user | Quick, Fleet | 239403009 |
| SY-1 / SY-7 / SY-11 / SY-20 / SY-23 | System rules cited | No direct reads of another product's database / standalone mode stays / bus registry / "Now" dispatcher decision / person retirement; TO-BE as applied to Fleet | system-wide | 239403009 |
| CX-33..CX-41 | Fleet connection gaps | TODAY gaps: fuel sources, meters, checklists out, defects in, repairs back, grounding to Dispatch, map tiles, finance export (CX-41 out of scope) | Fleet with Turns, GPS, Dispatch | 239403009 |
| CX-45 / CX-49 / CX-59 / CX-60 / CX-83 / CX-84 | Related connections | Trips miles / Performance Management defects and compliance / status events / faults / seat layouts / fuel and odometer visibility | Trips, Performance Management, Pro | 239403009 |
| IC-6 / IC-7 / IC-8 | Cross-cutting rules | Flags have an owner and a date / photos staff-only / changes logged | system-wide | 239403009 |
| FleetNotificationQueue | Outbound notification queue (local) | TO-BE: stores the push payload per notification; nothing drains it | future sender, Turns | 238911532 |
| GEDI bridge (`RemoteDatabase.GetRemoteDatabaseForFleet`) | Fleet's read path toward Turns data | TO-BE seam named in W08 for DVIR defects; not implemented | Fleet, Turns | 238911532 |
| (no id) | Fleet to transportation DB bridge (GEDI / LIVE_) | TODAY: GeoSocket connection from Fleet to the district live routing database, configured in Web.config LIVE_ settings; carries routes, drivers, staff | Fleet, BP Pro live database | 239009796 |
| IF-GI-01..06 | GeoIMS socket commands: staff reads, staff save, retire and delete, merge / split / move, move preview, expired certificates | TO-BE (changed versions of existing commands; not REST) | Quick, Fleet, BP Web, BPInfo | 238125072 |
| IF-GI-08 | Seats: layouts, needs, charts and the seat check | TO-BE | Pro, BP Web, Turns, door | 238125072 |
| IF-GI-09 | GeoIMS contact commands | Withdrawn | — | 238125072 |
| IF-BI-03 | Turns rider query (BPInfo TurnsStudentInfo methods) | TODAY, changes proposed | Turns, GeoIMS | 238125072 |
| IF-BI-48 | Day layer feed of same-day changes | TO-BE | Pro, trackers | 238125072, 238551066 |
| IF-LT-01..05 | Existing tracker interfaces | TODAY | Chipmunk, Quick | 238551066 |
| IF-LT-06 / IF-LT-20 / IF-LT-21 | Settings write / staff ETAs / vehicle signals (VehicleSignal/GetSince) | TO-BE | BP Web, employee app, Fleet | 238551066 |
| IF-BI-08 / 09 / 21 / 23 / 24 | Door interfaces the tracker consumes: settings, imports, hand-offs, bus registry, effective-bus rule | TODAY for imports; hand-offs and registry TO-BE | BPInfo REST | 238551066 |
| FormModule API | api/FormModule/GetLatest, api/FormModule/SubmitResults, api/FormModuleTemplate/CreateTemplate on BPInfo.Rest.Service | TODAY (first two used by Turns); Fleet publish to CreateTemplate TO-BE | Turns, Quick DB, Fleet | 239075352 |
| GEDI bridge | RemoteDatabase.GetRemoteDatabaseForFleet: Fleet reads staff from the Pro routing DB through GeoIMS | TODAY (lead) | Fleet, GeoIMS, BP Pro | 239075352 |
| SY-12 / SY-15 / SY-18 / SY-19 / SY-20 / SY-23 / SY-24 | Cross-product scenarios referenced: staff save, meters, tablet as GPS, driver-driven visibility, move checks, retire / delete, same-day changes | TO-BE (defined on other pages) | — | 238125072, 238551066 |
| GeoIMS connection prefixes | ConnectInfo prefixes GeoIMS, LIVE, GPS, Dispatch select which GeoIMS target a caller uses | TODAY | all managed callers | 237993990 |
| IF-QS-01 | Retire and credentials interface | Provided by Quick staff section; TO-BE | the door, pickers | 238321704 |
| IF-BI-21, IF-BI-22 | Door people interfaces consumed by QS, TG and the employee app (people and training status) | TO-BE | the door (BPInfo) | 238321704 |
| IF-BI-35 | StaffTraining/Save: writes a training row to Pro through GeoIMS partial save (GI-R1) | TO-BE | training module, GeoIMS, Pro | 239403072 |
| IF-BI-26 | Driver inbox on the door (same inbox as the Turns tablet) used for training notices and messages | TO-BE | employee app, Turns, training module | 239403072 |
| IF-BI-49 | Training state on the door: Training/State, Start, End, Outbox (Write, Read), Log, Reset, Release | TO-BE | every product, BP Web trainer pages | 238747676 |
| IF-TM-01 | Trainer's pages in BP Web | TO-BE | BP Web, the door | 238747676 |
| IF-BI-02, 23, 24, 25, 31, 32, 33, 34, 37, 41, 42, 43 | Door interfaces the employee app consumes (district lookup / sign-in, buses and runs, driver's day, mechanic's bus, trips, behavior reports) | TO-BE | employee app | 238616603 |
| IF-LT-04, IF-LT-20 | Live tracking interfaces: buses / runs and staff ETAs | TO-BE | employee app, tracker | 238616603 |
| IF-DS-01, IF-DS-02, IF-DS-04 | Dispatch interfaces on the phone through the door (after DS-R4, DS-R5); IF-DS-04 feeds the Today page | TO-BE | employee app, Quick Dispatch | 238616603 |
| IF-FT-01, IF-FT-02 | Fleet interfaces for the mechanic's bus | TO-BE | employee app, Fleet | 238616603 |
| person.retired / person.added | Hand-offs published by Quick staff | TO-BE | pickers, BP Web driver sync, Fleet users, T&A, Trips | 238321704 |
| training.expiring / training.expired / training.notified | Credential hand-offs from the 02:00 scheduled scan (SS-R8); training.notified records who was told | TO-BE | Subscription Service, training module, employee app | 239403072 |
| work.planned | Published by the training module for classes | TO-BE | time and attendance | 239403072 |
| repair.done / bus.grounded / bus.returned / push.acknowledged | Events from employee app actions (Fixed, Do not drive, Back in service, driver OK) | TO-BE | driver channel, Dispatch, Fleet (CX-38, CX-39) | 238223417 |
| SY-10..SY-17 | Shared services the employee app plugs into: door (10), bus registry (11), people registry (12), driver channel (13), live tracking (15), forms engine (16), settings (17) | TO-BE as shared services | employee app | 238223417 |
| SY-18, SY-20, SY-21, SY-22, SY-23, SY-24 | GPS source switching (18), linked-route change process and checks before any move (20), Drive another run (21), driver route scope (22), retire closes access (23), day layer (24) | TO-BE | Dispatch, Turns, employee app, Quick | 238223417 |
| CX-55..CX-58 | Staff app reads: planned data by scope (55), live positions and route status (56), staff ETAs new endpoint (57), effective bus from bus registry (58) | TO-BE | door, live tracking, tracker, bus registry | 238223417 |
| CX-59..CX-62 | Staff app and Fleet: status / work orders / due-ness (59), fault codes and meters (60), driver check results and photos (61), repair actions (62) | TO-BE | Fleet, readers, forms engine | 238223417 |
| CX-63, CX-64, CX-65, CX-75 | Message a driver (63), sign-in / roles / scopes (64), Quick edits and Dispatch actions via the door (65), driver's day on the phone (75) | TO-BE | driver channel, people registry, Quick | 238223417 |
| CX-51, CX-52, CX-70, CX-71, CX-76 | Bulk add students (51), credentials (52, 70), credential warnings (71), planned crew roles (76) | TO-BE | Quick, Pro, training module | 238321704 |
| tm_ tables | tm_Session, tm_Account, tm_Outbox, tm_Log, tm_Scenario in BP Web's database; practice tables with SessionId in Quick; trn_ prefix on the new platform | TO-BE | BP Web, Quick | 238747676 |
| tg_ tables | tg_TrainingEvent, tg_Attendance, tg_T01Period, tg_Signature, tg_KioskSignIn, tg_NoticeRecipient, tg_NoticeSent | TO-BE (database undecided, Q41) | BP Web or Quick database | 239403072 |
| Staff / scan tables | BPX_Staff, BPL_StaffRole, BPL_StaffTraining, BPX_TrainingType, BPL_StaffUserField, BPL_VehicleStaff; BPX_AVLScanEvent (3.7 million rows a year in one copy), BPX_AVLScanCardStudent; BPL_BusStopStudent, BPL_StudentRunVSeat | TODAY | Pro database, Dispatch copy | 238321704 |
| IF-BI-36 | Door settings endpoints | TO-BE: Settings/List, Get, Set, ClearCache, Version on BPInfo, parameterised by store, role SettingsAdmin | settings program, store adapters | 239534081 |
| IF-BI-01 / IF-BI-02 | Door tokens / client list | TODAY (existing): token issue and the central client list (GetAllClients); TO-BE: the anonymous client-list calls get a token requirement (BI-R1) | settings program, apps | 239534081 |
| IF-SP-01..03 | Settings program interfaces | TO-BE: IF-SP-01 screens, IF-SP-02 catalogue feed (JSON per product and version, read by BP Web for BW-R1..R3 and the build check), IF-SP-03 audit export | BP Web, build check | 239534081 |
| IF-LT-06, IF-DS-03, IF-FT-03, IF-TP-01, IF-PF-01, IF-GI-07 | Store adapters | TO-BE: tracker settings write endpoint (calls ResetSettingsCache); service-role settings controllers in Quick, Fleet, Trips, PM wrapping existing Get/Set extensions; GeoIMS get/set settings command pair for Pro (read-only at first). IF-BW-01 is the existing BP Web Setting library | BPInfo door | 239534081 |
| form.approved / IF-BI-21 | Workflow hand-off | TO-BE: event published on approval with effectiveDate and reachesAppsAt; Workflow consumes GeoIMS (TODAY) and IF-BI-21 | Workflow, the door, apps | 239075373 |
| DispatchNotification ledger | Send Run Changes store | TODAY: Quick-DB table (migration 57) holding each Dispatch change per stop with states incl. Superseded and expiry at midnight; release calls the tracker (TryChipmunkPush) then queues email | Quick Dispatch, Chipmunk tracker, Subscription Service | 238682115 |
| vehicle.substituted, bus.returned, person.retired, training.expiring, work.planned, source.switched | Proposed events | TO-BE: swap from any screen, grounded bus returned, retire action, expiring training, suggested T&A jobs, GPS source change | parent channel, trackers, Dispatch, every product | 238682115 |
| CX-13, CX-39, CX-37, CX-38 | Missing connections named by the stress test | TODAY missing: Dispatch to tablet (CX-13), "do not drive" to Dispatch (CX-39), inspection to Fleet (CX-37), "fixed" from Fleet to Turns (CX-38) | Dispatch, Turns, Fleet | 238682115 |
| IF-BI-02, IF-BI-05, IF-BI-08, IF-BI-20, IF-BI-26 | BPInfo ("the door") interfaces consumed by Subs | IF-BI-05 = GPSRouteVehicle mapping write (TODAY); IF-BI-20 PIN grant and IF-BI-26 driver inbox are TO-BE | Subs, Dispatch, trackers | 238682136 |
| IF-BI-10, IF-BI-21, IF-BI-22, IF-BI-23, IF-BI-33, IF-BI-37, IF-BI-38 | Door interfaces consumed by Trips | IF-BI-10 Pro imports incl. DriverSchedule (TODAY); hand-offs, people, bus numbers, driver's trips read / sign-up / check-in / post-trip (DriverTrips/SignUp), routing provider (TO-BE) | Trips, Turns, employee app | 238747655 |
| IF-TP-01, IF-TP-02 | Trips settings feed and finance export | TO-BE: sixteen Trips settings to the settings program; invoice / line-item / payroll-hours export under a service role | settings program, district finance system | 238747655 |
| IF-TA-03 | Actual hours from time and attendance | TO-BE: work.actual (start, end, hours) feeds hours guard, driver sort and invoice | Trips, Time & Attendance | 238747655 |
| IF-SS-01, IF-SS-02, IF-SS-03 | Subscription Service provided interfaces | TO-BE: IF-SS-01 jobs (parent change, studentLetter, message); IF-SS-02 subscriptions read (used by Delays if Q10 picks one list); IF-SS-03 scheduled checks | Dispatch, Ride Support, Delays, Chipmunk | 238321746, 238026775 |
| IF-DS-02, IF-BI-11 | Quick's held-list API; notice feed for Delays | TO-BE (IF-DS-02 held-notice warnings); IF-BI-11 notice feed consumed by Delays (status unclear, treat as contract name for today's Notification feed) | Subscription Service, Quick, Delays | 238321746, 238026775 |
| trip.assigned, trip.changed, trip.cancelled, trip.offered, trip.declined, trip.completed, work.planned, work.actual | Trips hand-off events | TO-BE; published from outbox table TripHandoff | Turns, Dispatch, T&A, employee app | 238747655 |
| vehicle.substituted, person.added, person.retired, bus.grounded, push.acknowledged | Staff / bus hand-off events | TO-BE: sub swap naming the person; new sub becomes Pro staff; retired person and grounded bus flag trips; driver "seen" receipt | Subs, Dispatch, Trips, Quick, Fleet | 238682136, 238747655 |
| email.sent, sms.sent, push.sent, training.expiring, training.expired, rider.absent, dispatch.change, alert.posted | Subscription Service events | TO-BE: delivery counts out; credential-scan events out; consumes dispatch.change, alert.posted, person.retired via IF-BI-21 | Dispatch, Ride Support, Training | 238321746 |
| CX-20, CX-29, CX-42..45, CX-72, CX-73, CX-77, CX-80; SY-19, SY-21..24 | Connections / system rules cited by these sections | TO-BE references: CX-44 trips to driver device, CX-45 trip miles to Fleet, CX-72 trip hours to T&A, CX-29 Delays rollover, CX-20 Dispatch-added sub; SY-21 swap conflict alert, SY-22 route scope, SY-23 retire / rehire | Trips, Subs, Delays, Subscription Service | 238747655, 238682136, 238321746, 238026775 |
| Twilio, OneSignal, SMTP, Google Directions | External providers | TODAY: Twilio SMS for targeted notices, OneSignal push (Delays has nine keys), SMTP email, Google Directions distance for Trips estimates (server key) | Subscription Service, Delays, Trips | 238321746, 238026775, 238387207 |
| BPI_AddressEligibility_Get | GeoIMS eligibility method exposed by BPInfo AddressEligibilityController | TODAY: one address per call, district-keyed (no SchoolID), fails when no school in the district offers the grade; a named-school bulk variant is proposed | BPInfo REST, GeoIMS, BP Pro | 238321767 |
| IF-BW-01, IF-BW-02, IF-BW-03 | BP Web interfaces | Settings store and admin pages; driver accounts; Bus links page (uses IF-SP-02 settings catalogue and IF-SP-03 audit note). TO-BE | BPInfo REST, settings program | 238485587 |
| IF-BI-20, IF-BI-21 | Driver sign-in, hand-off feed | /Token PIN grant; Handoff Publish / Read / Health. TO-BE | BP Unified T&A, Turns, every product | 239403051 |
| IF-BI-22, IF-BI-23, IF-BI-24 | People, bus registry, effective bus | GetAssignable / GetStatus; registry and SaveLinks; EffectiveBus/Get. TO-BE | GeoIMS, Dispatch, trackers, BP Web | 239403051 |
| IF-BI-26..IF-BI-34 | Devices and inbox, tablet positions, selections, run claims, Fleet endpoints, staff app | Device/Register, Inbox, GPS/SubmitPositions, Selection/Submit, RunClaim/Submit, failed checks, vehicle signals, bus problems. TO-BE | Turns, employee app, OneSignal, Fleet, Quick | 239403051 |
| IF-BI-39..IF-BI-52 | Crew, absences, conduct, bus instructions, handover, adults, seats, family messages, emergency, empty-bus check | TO-BE; IF-BI-03 (rider read) and IF-BI-10 (Operator / IncidentCount) are existing reads | Turns, Subs, Chipmunk, BP Web, Dispatch, SIS | 239403051 |
| IF-TA-01, IF-TA-02, IF-TA-03 | T&A interfaces | PIN check (TODAY, exists); staffGuid links and suggested jobs (TO-BE); work.actual (TO-BE) | BPInfo REST, Turns, Trips | 238485608 |
| CX-48, CX-49, CX-54 | Connections | PM reads Operator and IncidentCount (TODAY); defects and groundings to PM (TO-BE); Where's My Bus calls the GPS vendor (TODAY) | BPInfo REST, Fleet, GPS vendor | 238387286 |
| client_registry.BPUsers | Email-resolution table | One record per email and client with CustomerID; one registry per CAN / US environment. TODAY per 237043713 | Unified client databases | 58851500 |
| AspNetUsers / AspNetUserRoles / AspNetUserSchools / AspNetUserGrades / AspNetUserOperators | BP Info REST user tables | REST users, Operations and scope lists (checked against RESTSchools, RESTGrades, RESTOperators). TODAY | BP Service Administration, GeoIMS | 247824423 |

## 7. Roles, permissions and access model

| Role | Can see / do; permission names | Today or to-be | Page id |
|---|---|---|---|
| TurnsAppRole / SubsAppRole / AssistantAppRole | BPInfo app roles: 7, 3 and 11 controllers respectively; a Turns or Subs account can be limited by district, school, grade and operator and is often shared by many drivers | TODAY | 239173635 |
| Other BPInfo / tracker roles | Roles.OverrideRole plus named roles (DriverGet, Tracker, FormModuleTemplateAdmin, Subscriber for ETA2); Override and ChipmunkDashboard may reset the tracker settings cache | TODAY | 238321683 |
| Quick roles | Live Viewer (school): read-only GPS+ viewer limited to BP Pro school scope; Quick and Pro permissions via BPProPermissions; Driver role feeds Dispatch's driver list | TODAY | 239173656 |
| Dispatcher sending notices | Only the dispatcher who made a change can send its held group (DispatchSendOthers held by nobody by default) | TODAY | 239173656 |
| BP Web driver account | Driver portal with about 30 DriverSee… switches incl. DriverSeeStudentMedicalReport; linked to staff by georef_DriverUsers | TODAY | 239173656 |
| Parent (subscriber) | Parent Portal account used by Chipmunk; students linked by contact email when ParentLogin_UseBPProContacts is on; Pro "Allow portal access" contact rule | TODAY | 239173656 |
| Starter roles | Dispatcher, Router, Front desk, Supervisor, Director, Area manager, Trainer, Contractor dispatcher, School staff, Mechanic, Driver, Monitor, Read only; no feature may check a role's name; every product has a read-only role | TO-BE | 238321683 |
| Scopes | district, yard (Pro depot), operator, school, program, route set, board, shop, "their own"; enforced by the door on every call | TO-BE | 238321683 |
| Dispatch permission catalogue | 34 permissions incl. DispatchView, DispatchReassign, DispatchFromNowOn, DispatchMergeSplit, DispatchCancelRun, DispatchAcceptWarnings, DispatchOverrideEquipment, DispatchLeaveEnter / Approve / SeeReason, DispatchCoverPlan, DispatchSendNotices / SendOthers / DiscardNotices, DispatchPostAlerts, DispatchMessageDrivers / Families, DispatchFeedView / Reply, DispatchCrewCorrect, DispatchCorrectPast, DispatchCloseYear, DispatchExport, DispatchSeeStudents, DispatchSettings, DispatchManageRoles, DispatchHelpEdit, PeopleResetSignIn, TrainingModeUse / Manage, DashboardView / SchoolView / Settings (nine marked "exists") | TO-BE (status unclear for those marked exists: likely the prototype) | 238321683 |
| New service roles | SettingsAdmin (IF-BI-36), ConductExport (IF-BI-44), Training_TrainerRoles, School Viewer | TO-BE | 238321683 |
| PRD approvers | To be named: engineering leads for Web, Tracker, Quick, Pro and GeoIMS, Apps, Fleet, Trips, Workflow; US and Canada CS leads; Support lead; a privacy reviewer; owner is product | TODAY | 239304705 |
| Dispatcher (Dispatch permissions) | DispatchSendOthers (send another's held group), DispatchSettings, DispatchOverrideEquipment, DispatchFeedView, DispatchFeedReply, DispatchManageDriverGroups, DispatchHelpEdit, DispatchEarlyDismissal, Reassign; Dispatch has 28 permissions in §8.0.9 | TO-BE | 239304705, 238845954 |
| District admin / roles page | Roles belong to the district: fine-grained permissions with scope (district, yard, operator, school, program, route set, board, shop) and data classes; several roles per person; roles page lives in Dispatch for now; BP Web's five role types become starter roles | TO-BE | 239304705, 238845954 |
| Ride Support V1 starter roles | Driver, Monitor, Transportation reviewer, Transportation supervisor, School reviewer, Principal, District admin, Read only; templates also Area manager, Assistant principal, Dean, Special-education reviewer, Bus company (Kept informed only); cnd:student:optout held by transportation reviewer, supervisor, district admin | TO-BE | 239304705 |
| Transportation staff | Approve the adults a parent names (TransportationApproveAdults) in BP Web Requests or Dispatch Today page; only SIS-approved parents ("Allow portal access") can name adults | TO-BE | 239304705, 238845954 |
| Settings program user | Role SettingsAdmin, one credential per client, address allow list, every call audited; BusPlanner staff sign in with Microsoft 365 | TO-BE | 239304705 |
| People page admin | PeopleResetSignIn resets a driver's forgotten username or password | TO-BE | 239304705 |
| School Viewer / Dashboard | DashboardView held by every Dispatch role as shipped; School Viewer sees only its own schools' numbers, limited on the server; district picks which numbers schools see | TO-BE | 239304705, 238845954 |
| Driver / sub | Driver may take any run of own operator without approval, Dispatch told and can undo; sub has route scope (e.g. AllRoutes); driver role in the employee app | TO-BE | 239304705, 238419971 |
| Training lead | District training lead sees everything, optional lead per operator sees that operator's drivers; gets daily digest of expiring credentials | TO-BE | 239304705, 238845954 |
| Dispatcher | Reassign permission (`HasAccessToReassign`, `BPProPermissions`) gates Dispatch changes; only the author can send a held group | TODAY | 238223396 |
| Dispatcher (proposed permissions) | `DispatchSendOthers`, `DispatchAcceptWarnings` (granted to nobody by default), `DispatchOverrideEquipment` (none by default), `DispatchCrewCorrect` (dispatchers), `DispatchPostAlerts`, `DispatchFeedView`, `DispatchFeedReply`, `DispatchMessageDrivers`, `DispatchMessageFamilies`, `DispatchManageDriverGroups`, `DispatchEarlyDismissal` | TO-BE | 238223396 |
| Router / Supervisor | `DispatchFromNowOn` starter roles; Supervisor also `DispatchCancelRun`; Supervisor and Director `DispatchLeaveSeeReason`, expected `DispatchCloseYear`; `DispatchCorrectPast` none until named; `DispatchLeaveApprove` per `Dispatch_LeaveApproval` | TO-BE | 238223396 |
| Front desk / other office roles | Can be added to `Dispatch_FeedViewRoles` to see the Today page without Reply; see "Out" instead of leave type; behavior reports hidden without Ride Support access | TO-BE | 238223396 |
| District admin | `DispatchHelpEdit` (add or hide help articles); settings and roles page | TO-BE | 238223396 |
| V1 Dispatcher | `DispatchView`, `DispatchReassign`, `DispatchMergeSplit`, `DispatchLeaveEnter`, `DispatchCoverPlan`, `DispatchCrewCorrect`, `DispatchSeeStudents` (students' names; others see counts only) | TO-BE | 238157830 |
| V1 Supervisor | Every V1 permission except `DispatchOverrideEquipment` (only when named in `Dispatch_EquipmentOverrideRoles`); incl. `DispatchCancelRun`, `DispatchLeaveSeeReason`, `DispatchExport`, `DispatchCorrectPast`, `DispatchCloseYear`, `DispatchEarlyDismissal` | TO-BE | 238157830 |
| V1 Front desk / Viewer / District admin | Front desk: `DispatchView`, `DispatchLeaveEnter`, `DispatchCoverPlan` (can handle Needs your decision); Viewer: `DispatchView` only (no decision list, every change refused); District admin: `DispatchSettings` | TO-BE | 238157830 |
| V1 scope rule | Roles are scoped to yards (later schools and routes); a control a role cannot use shows disabled with the reason and the server refuses the action anyway | TO-BE | 238157830 |
| Trainer / trainee | `TrainingModeUse` (roles in `Training_UseRoles`), `TrainingModeManage` (roles in `Training_TrainerRoles`: watch, reset, scenarios, release training-only accounts) | TO-BE | 238157830 |
| Prototype operator / PIN admin | Single hard-coded dispatcher; a 4-digit PIN unlocks history edits with a required reason (demo only) | TO-BE (prototype) | 238157851 |
| Subscriber (parent) | Auth role for Chipmunk calls to the tracker; parents see ETAs, alerts, scans, messages for their own children | TODAY | 239108098 |
| TurnsApp (Turns service account) | Role for Turns calls to BPInfo; the account can also hold other per-account roles (e.g. `FormModuleGet` for inspections); cannot read the active GPS mapping (`GPSRouteVehicle.Get` needs `Override` or `GPSRouteVehicleGet`); org-level scoping only (school, grade, operator) | TODAY | 239108098 |
| Turns service account extra roles | Grant `RouteItineraryGet`, `DeadheadGet`, `DeadheadWaypointGet`, `DriverGet` (configuration, no code change) for route-level selection | TO-BE | 239108098 |
| Roles.Tracker / AssistantAppRole | `Roles.Tracker` gates BPInfo Chipmunk message controller; `AssistantAppRole` gates `RouteController.GetPartList` | TODAY | 239108098 |
| Dispatcher (Quick roles) | Uses Reassign Dashboard, Merge / Split Runs, Substitute GPS Vehicle, GPS Live Viewer; user scope is not applied to the Reassign Dashboard driver list today | TODAY | 239108098 |
| Quick router (single wizard) | Needs `TransportationManagement` (1015) and `AlterObject` (1044); can route any student (no per-student authorization); run scope is enforced in GEDI (`IsRunInScope`) | TODAY | 238616579 |
| Quick router (bulk flow) | Needs `TransportationManagement` AND `AlterObject` AND `AlterObjectBulk` (1005); `OptimizationTools` (1024) for suggested stops; `FindObject` (1018) for search; checked in every action | TO-BE | 238616579 |
| SysAdmin / Administrator | `HasBPProPermission` returns true for these regardless of the permission asked; the multi-permission overload is OR | TODAY | 238616579 |
| Parent (subscriber) | Signs in to Chipmunk (email/password, OIDC or district SSO); sees only linked children; identified by subscriberGuid, children by studentGuid | TODAY | 238518317 |
| Parent with "Allow portal access" on the SIS contact | Only this parent's sign-up email links to students; TO-BE only they can add/remove adults or share with caregivers | TODAY (linking) / TO-BE (adults) | 238518317 |
| Caregiver | Sees one shared child's bus, stop and ETA until the share ends (max 90 days); never scans, letters, messages or the Suspended tag | TO-BE | 238518317 |
| District admin | Sets the `Chipmunk_*`, `Turns_*` settings in BP Web (stores ChipmunkApp / TurnsApp); turns Betas on and accepts the Beta agreement | TO-BE (new settings) | 238845975 |
| Transportation staff / dispatcher | Approve or refuse parents' adults (BP Web Requests page or Dispatch Today page; `TransportationApproveAdults`), answer suspended-rider questions, tick the met-at-bus opt-out (`cnd:student:optout`) | TO-BE | 238845975 |
| Driver | Today: signs in to Turns with a (often shared) username/password; TO-BE: named person, sees only own run's riders, instructions and labels, own trips and own referral outcomes, limited by route scope (e.g. `OwnOperator`) | TODAY / TO-BE | 238845975 |
| Crew (monitor, aide, trainer) | Added by the driver or by own PIN; shares the run's rider information with the driver | TO-BE | 238845975 |
| Yard account | Shared Turns account, attached to the bus "as the account, not a person"; stays while the district allows | TODAY | 238845975 |
| Role with `PeopleResetSignIn` | Can show username, set temporary password, unlock a driver's sign-in; starter roles district admin and transportation supervisor; cannot reset someone with more permissions | TO-BE | 238845975 |
| School reviewer | Sees the opt-out tick and date read-only | TO-BE | 237961219 |
| Driver / monitor (reporter) | Writes referrals; sees own drafts and own referrals' status ("Sent", "Being reviewed", "Done"), never the decision unless "Show the writer the outcome"; sees bus instructions and suspension dates, never reasons; can never decide a suspension | TO-BE | 239337479 |
| Transportation reviewer / supervisor | cnd:transportation:review; sees every referral in scope; supervisors alone see counts by reporter and can reopen; can Message the family (also cnd:supervisor) | TO-BE | 239337479 |
| School reviewer / school admin | cnd:school:review (default also gets cnd:suspension:decide); cnd:school:admin edits the school's groups and by default gets cnd:suspension:lift; only own school's students and suspensions | TO-BE | 239337479 |
| District admin | cnd:admin: all permissions, can take any step under own name, change the student late, move a referral to a new chain version, reopen | TO-BE | 239337479 |
| Operator (bus company) | Conduct_OperatorRole none / status (default) / notes; as first reviewer can add notes and forward but not end a referral; bus-company scope stays off until the district confirms its records notice (Q134) | TO-BE | 239337479 |
| Concern contacts / well-being contacts | Only they and district admins see concerns; opens logged separately | TO-BE | 239337479 |
| SIS export client | Door role ConductExport for Conduct/GetSince; any other role gets 403 | TO-BE | 239075331 |
| Family (parent) | Sees only the school's letter and messages about own linked children; optional "I read this" (Conduct_FamilyAcknowledge, off) | TO-BE | 239337479 |
| Other permissions | cnd:conduct:read, cnd:referral:create, cnd:export, cnd:student:optout, special-education review; BP Web's <Role>See… switches are not used for Ride Support except SchoolStaffSeeConduct (BP Web StaffApp, default on) | TO-BE | 239337479 |
| Special-education reviewer | cnd:specialed:review: records the review (Proceed / Proceed with changes / Don't proceed) and sees the special-education page; sees only subjects with a review waiting or done by them | TO-BE | 239337500 |
| Dispatch | Sees urgent referrals, suspended days, suspended-rider scans and the driver's choice, emergencies, empty-bus checks; never the reason for a not-riding day or the report's words | TO-BE | 237928473 |
| More cnd: permissions | cnd:supervisor (reopen, counts by reporter, take over, drafts not sent), cnd:operator, cnd:report:read, cnd:decisions:read, cnd:package:export, cnd:seating:view, cnd:seating:move, cnd:labels:manage, cnd:views:role; concern / well-being contacts are named people in cnd_contact, not a permission | TO-BE | 239337500 |
| Driver / Monitor (Ride Support starter roles) | cnd:referral:create only; own referrals and the runs they sign in to; can never hold a suspension permission | TO-BE | 239108122 |
| Transportation reviewer | cnd:referral:create, cnd:transportation:review, cnd:student:optout; whole district; cannot suspend by default | TO-BE | 239108122 |
| Transportation supervisor | As reviewer plus cnd:supervisor (Drafts not sent, reopen closed referral); cnd:suspension:decide only if Q193 says so | TO-BE | 239108122 |
| School reviewer | cnd:referral:create, cnd:school:review, cnd:suspension:decide for own schools; cannot lift | TO-BE | 239108122 |
| Principal | School reviewer's permissions plus cnd:school:admin (reviewer split) and cnd:suspension:lift | TO-BE | 239108122 |
| District admin (Ride Support) | All cnd: permissions incl. cnd:export and cnd:admin (Setup, any referral except a concern unless named a contact) | TO-BE | 239108122 |
| Read only (Ride Support) | cnd:conduct:read: read referrals in the work area without acting; no + New referral | TO-BE | 239108122 |
| Concern / well-being contacts | No role needed; read only the concerns they are told about | TO-BE | 239108122 |
| Every Dispatch role (Dispatcher, Supervisor, Director, Front desk, Viewer) | DashboardView: full Dashboard, rows and exports within own yard / school scope; Front desk sees absences as "Out" without type | TO-BE | 238551042 |
| Director, district admin (Dashboard) | DashboardSettings: Settings tab (School Viewer metrics, path-deviation values) | TO-BE | 238551042 |
| School Viewer | DashboardSchoolView: own schools, district-shared numbers, no staff names; own My settings to hide numbers | TO-BE | 238551042 |
| Platform permissions existing today | gpsplus:read (compare pages), analytics:read (Analytics page), ta: prefix (T&A module gate); school grants scope a person to schools | TODAY | 238583811 |
| Mechanic / technician | Opens work orders where the role allows, clocks time, defers jobs, sees own work; TO-BE sees only own My Daily Work list | TODAY (roles) / TO-BE | 239403009 |
| Fleet manager | Publishes checklists, grounds buses, assigns unassigned defects, confirms layouts, matches fuel fills, gets silent-input list | TO-BE | 239403009 |
| Parts clerk | Receives purchase orders, marks cores returned; a role without the permission is not offered "open work order" | TODAY / TO-BE | 239403009 |
| Shop supervisor | Fixes time cards; TO-BE sees every technician and every work order they were on | TODAY / TO-BE | 239403009 |
| Driver | TO-BE: gets repair news, sees odometer and next service, never fuel costs or fill amounts | TO-BE | 239403009 |
| Outside owner / department | Receives a monthly statement showing only its own vehicles | TO-BE | 239403009 |
| Door service role | The only credentials Fleet's API accepts | TO-BE | 239403009 |
| "Undo changes" permission | May undo a batch within `Fleet_UndoDays` | TO-BE | 239403009 |
| Administrator role | Holds every permission; re-granted the full enum at each app start; `IsAdmin` / `IsAllowedRoleToAccessAllVehicles` bypass location restriction | TODAY | 238911532, 238845996 |
| INSPECTION_VIEW 110000 / INSPECTION_CREATE 110001 / INSPECTION_CRITERIA_MODIFY 110002 / INSPECTION_FAILURE_NOTIFY 110003 | View inspections and message threads / perform (not enforced separately) / criteria builder / receive failure alerts; seeded to roles holding WORKORDER_VIEW | TO-BE | 238288898, 238845996 |
| TELEMETRY_VIEW 110010 | Telemetry tab and vehicle map | TO-BE | 238288898 |
| WORKORDER_CHANGE_AUDIT_VIEW 110020 / _REVIEW 110021 | Read the change audit / sign off (REVIEW not enforced); seeded to roles holding WORKORDER_CLOSE | TO-BE | 238288898, 238911532 |
| Administrator (Fleet role) | Holds every permission; automatically re-granted all permissions at each app start | TODAY | 238354434 |
| Technician (Fleet role) | Example role with 2 permissions locally; used to prove per-permission mirroring | TODAY (local database) | 238354434 |
| Holder of INSPECTION_VIEW (110000) | Inspection list / form, inspection messages (ask and reply), notification inbox | TO-BE | 238354434 |
| Holder of INSPECTION_CRITERIA_MODIFY (110002) | Inspection form builder and Publish; initially everyone with WORKORDER_VIEW | TO-BE | 238354434 |
| Holder of INSPECTION_FAILURE_NOTIFY (110003) | Receives grounding / deferred failure alerts; inbox access (either this or INSPECTION_VIEW) | TO-BE | 238354434 |
| Holder of TELEMETRY_VIEW (110010) | /Telemetry, /VehicleTelemetry, /VehicleMap; initially everyone with VEHICLE_VIEW; no location scoping by the attribute | TO-BE | 238354434 |
| Holder of WORKORDER_CHANGE_AUDIT_VIEW (110020) | Work Order Changes audit screen; initially everyone with WORKORDER_CLOSE | TO-BE | 238354434 |
| INSPECTION_CREATE (110001) and WORKORDER_CHANGE_AUDIT_REVIEW (110021) | Declared, translated and seeded but enforced nowhere: anyone on the audit screen can sign off | TO-BE | 238354434 |
| Holder of VEHICLE_VIEW (105000) | Vehicle Shop Days report; non-admins without the all-vehicles role see only their UserLocations | TO-BE | 238420013 |
| Any signed-in user | Can fetch any attachment by guid via Download (today) and Inline (to-be); notification bell renders for everyone | TODAY / TO-BE | 238420013 |
| Telemetry service identity | Writes telemetry readings; currently the seeded support account, so indistinguishable from that user's manual entries; dedicated identity undecided | TO-BE | 238354434 |
| Fleet permissions (existing) | WORKORDER_VIEW, WORKORDER_MODIFY, WORKORDER_CLOSE, VEHICLE_VIEW; held via AspNet roles (AspNetRolePermissions); users without WORKORDER_MODIFY see work order descriptions read-only | TODAY | 239009817, 239435777 |
| Fleet permissions (110000 block) | INSPECTION_VIEW, INSPECTION_CREATE, INSPECTION_CRITERIA_MODIFY, INSPECTION_FAILURE_NOTIFY, TELEMETRY_VIEW, WORKORDER_CHANGE_AUDIT_VIEW, WORKORDER_CHANGE_AUDIT_REVIEW; granted on install to roles holding the borrowed permission so access is unchanged | TO-BE (local) | 239435777 |
| Fleet settings admin | Can edit any Setting row (incl. Cost Rule) from the Settings screen | TODAY | 239009817 |
| Subscriber (parent) | Only role allowed to call ETA2 | TODAY | 238551066 |
| StaffApp | Role for staff ETA endpoints, checked against school / run scope | TO-BE | 238551066 |
| Quick users and scopes | GEO_Users, GEO_Roles, GEO_RolesPermissions and GEO_UsersScope (District / Operator / School / Staff) tables live in the Pro database | TODAY | 238125072 |
| Three identity systems | Fleet AspNet roles, BP Pro GEO_* roles and scope, Quick AspNet users are separate | TODAY | 239075352 |
| Office admin (Quick staff permission) | Opens staff records, retires people, edits training and credentials (STAFFMANAGER, STAFF_MODIFY) | TODAY | 238321704 |
| Live Viewer (school) | View-only GPS+ live viewer limited to the user's school scope; no scope = no routes | TODAY | 238321704 |
| BP Web role types | District Admin, School Admin, Operator, Driver, Transportation, each with its own menu of <Role>See<Feature> switches | TODAY | 238223417 |
| Tracker roles | Subscriber (parent ETAs); Override and ChipmunkDashboard (dashboard) | TODAY | 238223417 |
| Prototype roles (admin / instructor / driver) | admin: editAll, editConfig, editRequirements, deleteEvents, viewAllDrivers, viewAudit, viewReports, modifyHours; instructor: viewReports + modifyHours for assigned drivers; driver: view only; kiosk user and state examiner are not roles | TO-BE (prototype, not shipped) | 238878746 |
| Trainee (Training_UseRoles, permission TrainingModeUse) | May switch training mode on; default every role | TO-BE | 238747676 |
| Trainer (Training_TrainerRoles, permission TrainingModeManage) | Sees trainer's pages, Watch, Reset, Answer as the office, Release; default district admin and transportation supervisor | TO-BE | 238747676 |
| Training lead and designees | Receive the credential digest; must hold the staff permission; choose their own channels | TO-BE | 239403072 |
| Mechanic (employee app) | Shop's buses, driver checks, fault codes, work orders, mechanic actions; never student or parent data | TO-BE | 238223417 |
| Transportation staff (employee app) | District / operator scope; Quick tools, edits and Dispatch actions by Quick's own permissions; Today page via Dispatch_FeedViewRoles / Dispatch_FeedReplyRoles; messaging via DispatchMessageDrivers / DispatchMessageFamilies | TO-BE | 238223417 |
| School staff (employee app) | Own school only; look-only; scans and scan history a district setting, off by default | TO-BE | 238223417 |
| Driver (employee app) | Own runs plus routes allowed by route scope; signs in with BP Web driver account on the phone and T&A PIN on the tablet | TO-BE | 238223417 |
| Settings program roles: viewer, consultant, administrator | Viewer reads; consultant changes any non-secret setting on assigned clients; administrator changes secrets (with a reason), templates, the client registry and roles; sign-in with BusPlanner Microsoft 365 accounts, two-factor for all; door role SettingsAdmin | TO-BE | 239534081 |
| Live Viewer (school) | View-only Quick role: the GPS+ live viewer read-only, routes limited to the user's BP Pro school scope, no Smart Mappings; a web map, no ETA and no phone (ENG-1159) | TODAY | 238682115 |
| Dispatcher (Reassign permission) | Reassign permission gates the Dispatch reassign dashboards (redirect without it) and the Merge/Split saves; only the dispatcher who made a change can send its held notification | TODAY | 238682115 |
| Operator-role user (Quick) | Can be given the Staff menu; protected staff fields are restored from the database when an Operator-role user saves | TODAY | 238682115 |
| Workflow roles (proposed product) | District Admin: all incl. Manage Workflow/Settings; Transportation Coordinator: create/edit forms, view submissions, approve/deny; School Admin: view submissions for own building only; Teacher: none; submitters see only the portal and their own submissions | TO-BE | 238911553 |
| Driver / Turns and Subs accounts | A BPInfo user (aspnet_Users, no staff link) scoped by DistrictIDs, SchoolIDs, Grades, OperatorIDs; BP Web driver portal account linked via georef_DriverUsers with DriverSee… report switches | TODAY | 238682115 |
| Trips SE employee roles | Driver, Requestor, Approver, Admin, Transportation, Read-only, Contractor, Reviewer; requester and approver accounts are created by the office; ApproverCanCompleteTrip and CanAssignDriverVehicleWithoutApproval are policy settings; no super-admin view above the admin login | TODAY | 239140908, 238387207 |
| Trips trip office admin / field trip coordinator / finance service role | Trip office admin sets the sixteen new settings; coordinator reviews driver entries and finalizes the trip; finance export needs a service role; requesters must not see decline reasons or driver hours; driver sees only own trips and the board's open trips | TO-BE | 238747655 |
| Substitute driver (SubsAppRole) | Shared yard account limited to GPSRouteVehicle, GPSVehicleID and Route controllers | TODAY | 238682136 |
| Substitute driver (person sign-in) | Employee number + T&A PIN, token names staffGuid, operator and route scope (AllRoutes default); retired staff refused | TO-BE | 238682136 |
| Parent (notices / Delays) | Today: no per-category choice; Delays device reads and writes subscriptions with no token. To-be: per-category choices except "About your child"; text opt-in with consent; Delays device-scoped token | TODAY and TO-BE | 238321746, 238026775 |
| BP Pro redistricting permissions | AnalysisTools gates Closure Planner and Home School Analyzer; RedistrictingAnalysisTools (1033) gates Capacity Analyzer and Population Summary; RedistrictingUpdateTools (1034) gates Boundary Optimizer, Split / Merge (view-only disallowed); upgrade grants reach only built-in roles named readwrite / readonly, custom roles get nothing; administrators get all permissions | TODAY | 238321767, 237797385 |
| BusPlanner admin | BusPlanner staff only, only for @busplanner.com emails; every product and customer; all Settings incl. add customer, switch products on, turn customer off; built in, locked; never visible to customers | TO-BE | 237043713 |
| Customer admin | Customer's own admins; Settings (users, roles, departments; customer name, time zone, notes) plus only purchased products; manages only users of their customer(s); built in, locked | TO-BE | 237043713 |
| Admin (Unified, today) | Single role for staff and customers with every permission in every product; migrates to BusPlanner admin if @busplanner.com, else Customer admin | TODAY | 237043713 |
| Custom roles (Unified) | Blank or copy of a role; one or more roles per user; access = role(s) + what they can see; direct overrides removed (affected users moved into an auto-created role); a role in use cannot be deleted | TO-BE | 237043713 |
| Permission model (Unified) | Sections: Settings users and roles / Settings customers and departments / Time & Attendance / GPS Plus / BusPlanner Family / Transportation data / Reports and help; per item View / Add & change / Delete; Add or Delete ticks View, unticking View clears the rest; any GPS Plus page ticks "Open GPS Plus"; only purchased product sections show | TO-BE | 237043713 |
| Scope "What they can see" (Unified) | Default everything; per dimension All (includes later additions) or Only some: Schools, Bus companies (operators), Depots, Departments, Districts, Customers | TO-BE | 237043713 |
| Example custom roles (Unified) | Payroll supervisor, GPS Plus viewer (operator staff see only their company's buses, no Settings), School office (view only) | TO-BE | 237043713 |
| BP Web user types | District admin, transportation, school admin, operator, driver; pages controlled by <Role>See<Feature> switches; to become starter roles | TODAY / TO-BE | 238485587 |
| AssistantAppRole | BPInfo role used by Assistant | TODAY | 239534102 |
| Administrator (BP Service Administration) | Signs in to the admin site; only role that reaches Rest/ pages; district admins use it | TODAY | 247824423 |
| REST Operations and scope roles | Per REST user: granular Operations (e.g. TurnsApp, StudentBasicGet, RunGetAll, Administrator, Override) plus AllSchools / AllGrades / AllOperators or explicit lists | TODAY | 247824423 |
| New BPInfo roles | HandoffPublish, HandoffRead, BusRegistrySave, DriverSelf (driver token with staff_guid, operator_guid, route_scope), StaffApp, SettingsAdmin, VehicleSignalsGet, FormModuleResultsGet, ConductExport, SeatLayoutSave, SeatChartSave, AdultDecide | TO-BE | 239403051 |
| Routing supervisor / Fleet manager / Transportation director | Vehicle → route mapping (often) / GPS unit → vehicle (rare) / oversight of unmapped routes | TO-BE | 238518274 |

## 8. Contradictions

### 8.1 Against `knowledge/domain.md` (domain.md was not edited; rows 9 to 11 are clarifications rather than direct conflicts)

| # | domain.md says | PRD pages say | Page id |
|---|---|---|---|
| 1 | Dispatch (New World Dispatch) is "in build: waves 1-8 components, merge/split tool" | New World Dispatch V1 is a draft proposal (v0.14, 2026-11-04) under engineering review, with stories not yet written; on the platform today Dispatch is a disabled "coming soon" tile. The Jira components may still be real work, but the PRD does not describe anything shipped | 238157830, 238583811, 239304705 |
| 2 | Chatbot is also called "AI Assistant" | "Assistant (AS)" in the PRD is a different product: an Old World staff mobile app for browsing the plan through BPInfo's AssistantAppRole (11 controllers), to be retired when the employee app matches it. Do not confuse it with the Unified chatbot | 239534102, 238321683 |
| 3 | BPInfo REST "the door" is the API used by apps and BP Unified to read/write Old World data | True as the to-be role (SY-2, SY-10). Today it is not the only door: Chipmunk is served by both BPInfo and the Chipmunk tracker (CX-7), Fleet and Workflow bypass it through GEDI / GeoIMS, and BP Web's Where's My Bus asks the GPS vendor directly | 239173635, 239173656 |
| 4 | 9 GPS vendor reader services | SY-15 and the Live tracking page agree on nine; the tracker reliability fix spec lists eight reader services; the new platform has one reader service covering five providers (Geotab, Zonar, Synovia, GTS, Samsara) | 239173635, 238551066, 237993990, 238518317 |
| 5 | snapshot = the platform's copy of the plan for one service day; "10 snapshots held" (ENG-2903) | Glossary: the copy of the plan for one service day together with Dispatch's changes for that day, one per day, kept. Elsewhere the PRD says a New World Dispatch save keeps a snapshot that resets overnight and never reaches Pro. Retention is not stated consistently | 239271938, 239304705 |
| 6 | Dispatch parent notifications are held until the dispatcher sends them (ENG-1616) | Confirmed, in production since 2026-09-18. New detail: an unsent group expires at midnight and nobody is warned; bus and driver swaps still send families nothing. Older pages in the family (feature requirements, stress-test narrative) still describe the pre-hold behaviour, every save emailing at once | 239140866, 239173656, 239108098, 238682115 |
| 7 | T&A: PIN clock-in from the Turns tablet | The PIN stays for the clock, but the PRD's own decisions conflict on Turns sign-in: 2026-09-24 says drivers sign in to Turns with the T&A PIN, 2026-10-26 says username and password. TA-A6 / TA-QA-001 still test a PIN sign-in on Turns. All of this is to-be | 239304705, 238485608, 238845975 |
| 8 | header caution: PRD pages are v0.100 pushed 2026-11-05 | Twelve pages are now at v0.101 / v0.102, pushed 2026-11-09 (list in the header of this file) | 239173656 and others |
| 9 | Fleet row: "New Fleet" is 12.4.x, older Fleet ships in 13.x | Consistent, with one trap: the higher version number (13.x) is the older Fleet code line. The inspections module, form builder and defect intake (migrations 867-878, W01-W18) are local and unshipped; shipped Fleet schema is v866, although one page calls migration 867 "verified in code" | 239403009, 239075352, 238485528 |
| 10 | Workflow = forms and approvals in BP Web | Consistent for the shipped product (wf_ tables in BP Web, writes to live Pro through GeoIMS). The page "PRD · Workflow PRD" describes an unshipped prototype product with a different architecture; do not read it as shipped behaviour | 239075373, 238911553 |
| 11 | Quick hosts dashboards, staff manager, reports | The "Quick training tracking module" pages describe a browser-only prototype (local storage, no backend), not part of shipped Quick. The PRD's "Dashboard" (DB) is a to-be New World module; the Dispatch "board" must never be called Dashboard | 238878746, 239403072, 239271938 |
| 12 | Unified login: JWT 60 minutes; Users and Access PRD final 2026-10-26 | Users and Access (Final) supersedes the older Unified Login Flow PRD: reset code valid 24 hours and 6 digits, password 8 characters plus one number, landing on the product used last rather than a dashboard. BPInfo REST users have a different rule (12+ characters, four classes) and BPInfo tokens last 1 hour | 237043713, 58851500, 247824423, 239403051 |
| 13 | ESE = special education program of a run | Glossary says cards show ESE, not SPED; the Dispatch V1 page says it is shown as SPED on cards | 239271938, 238157830 |

Naming to keep straight: the module is "Ride Support" in the pages, sits in a folder called "PRD · Discipline V1", and its code names are "conduct" (`Conduct_` settings, `cnd:` permissions) (239108122).

### 8.2 Inside the PRD family (page against page, or a page against itself)

These were found while reading; several are flagged by the PRD itself as open questions. Where a build section and a V1 / spec page differ, check which is newer before writing tests.

- "One door for new links: BPInfo REST" vs today Chipmunk is served by two doors (BPInfo and the Chipmunk tracker), Fleet and Workflow bypass the door via GEDI/GeoIMS, and BP Web's Where's My Bus asks the GPS vendor directly; the background's "BPInfo REST the door" is the to-be role, not today's whole picture (239173635, 239173656)
- Glossary says "Dispatch" alone is today's product in Quick and the new one is "New World Dispatch"; "the board" must never be called "Dashboard" (that is the §8.23 module); the background's "new Dispatch" should use these names (239271938)
- Glossary snapshot = platform copy of the plan for one service day WITH Dispatch's changes for that day, one per day, kept; slightly wider than the background's "platform's copy of the plan for a day" (239271938)
- Read me first lists Part 8 as covering "the three settings stores" while §1 and SY-17 say 8 settings store families (36 tables and files); three is only the subset used by Chipmunk, Dispatch and Turns (239140866, 239173635)
- The Event list (v0.100) omits events present in the v0.102 payload table: sms.sent, trip.offered / declined / completed, suspension.decide / call / contacts; and names different senders for person.added (Dispatch, Subs vs Quick, Subs) and person.retired (people registry vs Quick) (238026754 vs 238321683)
- Pages in this batch are at two PRD versions: 239173656 and 238321683 are v0.102 (2026-11-09); the other five are still v0.100 (2026-11-05) (all)
- District counts differ by source: "0 of 145 districts" (version telemetry) vs "146 of 211 clients" (utilization telemetry) (238321683)
- Background lists Workflow and Subscription Service as Old World products reached via the door; the PRD says Workflow uses GEDI directly and is the only product writing to live Pro (239173656)
- Document control says "Status: draft v0.92" while the same page's header says it was generated from v0.102 (239304705)
- The seven pages are at two PRD versions: Journeys, Order of work, Out of scope, Appendices and Worked examples are v0.100; the two §13 pages are v0.102 (238092292, 239304705)
- Q15 decision (2026-09-24) and J24 / WX-3 say drivers sign in to Turns with their time-and-attendance PIN vs decision of 2026-10-26: drivers sign in with a username and password, the PIN stays for the clock only (238092292, 238419971, 239304705)
- Decision 2026-10-23 puts the Dispatch Feed and Messaging out of scope vs decision 2026-10-26 (v0.81) putting them back in scope in the connected PRD while New World Dispatch V1 still leaves them out (239304705, 238845954)
- Decision 2026-10-14 "the nine statuses are fixed" vs 2026-10-15 / Q122: six statuses with the step as data, the nine as template labels (239304705)
- J25 has the school reviewing a referral first (and v0.19 "each rider's own school reviews") vs decision 2026-10-14 that transportation reviews first by default; WX-5 follows the newer rule (238092292, 238419971, 239304705)
- Order of work places Ride Support in Phases 3-5 on BPInfo / BP Web with tablet first vs decisions 2026-10-14 and 2026-10-19: built on the new platform, web module first, then Turns and Chipmunk (238518296, 239304705)
- Decision 2026-10-19 "a referral is taken on purpose, opening does not take it" vs Appendix D: in both prototypes opening a referral takes it (238223375, 239304705)
- Q4 "the dispatcher wins bus mapping" vs decision 2026-10-21 "the latest wins between a tablet's sign-in and a dispatcher's correction" (239304705)
- Open internal conflicts the PRD itself flags: QS-R8 all-or-nothing batch vs bulk-add spec (Q231); RoutingProvider default vs "stay on Google" (Q232); DB-R2 share of buses vs runs measured (Q229); Subscriptions_RouteChange default off vs parent choice default on (Q222); TU-A28 no name offline vs TU-A34 name offline (Q209) (239304705)
- Phase A release date (2026-10-30) and many question due dates are earlier than the page's last update (2026-11-09) with the items still listed as open / pending; status unclear (238518296, 239304705)
- Background says Old World Dispatch sits in Quick and New World has a new Dispatch: consistent; the pages add that the two must not run on the same day for one district (switch day), and that New World Dispatch V1 today reaches neither tablets nor the parents' app (239304705)
- DS section says V1's conflict list is "CF-01 to CF-54" (Scope, Conflicts) and elsewhere "CF-01 to CF-77" (DS-R52) vs the V1 page, which lists CF-01 to CF-78 (238223396 vs 238157830)
- DS section (2 of 2) says V1's QA tests are "QA-001 to QA-227" vs the V1 pages, which run to QA-304 (238419992 vs 238911511)
- `Dispatch_DefaultView` default is "the day sheet" (choices day sheet, Gantt or table) in the DS settings table vs "the Table" (choices Gantt or Table; no separate day sheet) in V1 §4.10 (238223396 vs 238157830)
- V1 §4.9 lists 17 permissions vs QA-208, which says "each of the 14 permissions in §4.9" (238157830 vs 238911511)
- DS section names the Table's cover choice "Covering" and the filter "open runs only" vs V1, which names them "Spare Cover" and "Uncovered only" (238223396 vs 238157830)
- DS section describes Dispatch publishing `itinerary.changed` to drivers and held notices to families vs V1 (decided 2026-10-23), where Dispatch never talks to Turns or Chipmunk and sends nothing; first-pass background lists "new Dispatch" under BusPlanner Unified as if existing, but these pages treat New World Dispatch V1 as a proposal not yet built (238223396, 238157830)
- DS-R7 / DS-A9 treat "Just today" and "From now on" as the save choices vs V1, where every save is for its day only and From now on is out of scope (238223396 vs 238157830)
- "Only 4 of 24 dispatch actions write a Quick log line" (239108098) vs "roughly twenty dispatch actions, three call BPQuickLogger" (239239170)
- D2 table says ReassignRunSave "emails parents" (239239170 section 5) vs DF-1 "no reassign-run notification is ever delivered by email" (239108098; also noted in 239239170 section 11.3)
- CM-3.1 is written as three boolean settings (239108098) vs Appendix A where `Chipmunk_ETACardConfig` replaces the three booleans (237928452); open question 23 says undecided
- AgeLimit default: "seeded value 60, code fallback 10" (239108098) vs Appendix B "10 min (max 60)" (237928452)
- Reassign Dashboard load baseline at the largest district: "2-12 s" (239108098) vs "8-12 s" (237928452)
- CM-8 is used in work packages WP-1 / WP-1a (237928452) but has no requirement section or scope-table row in 239108098 (points to a separate spec file)
- Background says Turns/Chipmunk just read the plan; page says Turns has a data path to the Dispatch DB only when `Turns_UseDispatchDatabase` is on and no notification path, and Chipmunk planned data may not refresh intra-day (open question 1) (239108098)
- 238518317 says alert "comments and reasons have reached the app since May 2026, but they are off by default" (settings `ShowAlertReasonType`, `ShowAlertComment`) vs 238256131 and 238878722, which show the server never sends Comment/Reason at all and the gate is `Notifications_AllowCommentsSeenByPublic` (app-side fields added 2026-06-04). (238518317, 238256131)
- 238518317 says Chipmunk "shows parents no scans" and treats scans on the card as proposed (CH-R19) vs 238518338, which says scan notifications already shipped in Chipmunk 2.10.4; settings `ChipmunkShowStudentScans` and `RidershipNotifications` already exist. (238518317, 238518338, 238878722)
- 238518317 CH-R7 fixes the scan code as Code 128 or QR (default QR) from the scan card id vs 238518338, where symbology and payload are an unanswered blocking question and the value is a "pass identifier" from Pro bus pass records. (238518317, 238518338)
- First-pass background says 9 GPS readers; 238518317 lists one new-platform GPS reader service covering 5 providers (Geotab, Zonar, Synovia, GTS, Samsara). Likely Old World vs New World, but the count differs. (238518317)
- 238845975 "Why" says the Turns Submit button was removed on 08-12 vs TU-R32 in the same page, which says the bus reaches the server only from Submit and TU-R40 proposes removing the Submit form. (238845975)
- TU-R1 says sign-in is username and password (PIN only for the clock) vs TU-A1, TU-A10 and the Identity row, which speak of "PIN sign-in" and `staffGuid` from the PIN. (238845975, 237961219)
- TU-A63 says Seating chart appears "above View Directions" after bus and route are submitted and is greyed before a run is picked vs TU-R39/TU-R40, which place it above GPS on a home screen with no Submit and have it ask "Which run?". (237961219, 238845975)
- 250740737 specifies a hard-blocking end-of-run check with two per-student options (still on bus / manually tap off) and no notification vs TU-R30 in 238845975, an empty-bus walk-through (off / prompt / required) where picking a rider raises an urgent Incident to contacts and Dispatch. Two different designs for the same moment. (250740737, 238845975)
- 250740737 sits under the "Unified Login" folder although it is a Turns PRD (Old World product). (250740737)
- For Message the family the requirement's push text is "You have a new message from Transportation", but the connected prototype's Relay still pushes "from your school" (239337479)
- Build spec pages are generated from PRD v0.101 and describe themselves as "kept in step with PRD v0.60", while the build-section pages are v0.102; where they differ the PRD section wins (237928473 vs 239337479)
- Build spec ST-2 says an unfinished draft is sent to transportation as "not finished" after Conduct_DraftHours, while its own T17 and PRD SC-R3 / SC-R19 say a draft is never sent by itself (239337500 vs 237928473 / 239337479)
- Build spec T03, UC-1.5 and ST-10 say the first reviewer to open a subject holds it, while PRD SC-R28 and spec §6.9 TAKE say opening takes nothing (spec C12; which is built in Phase 1 is Q138) (237928473 vs 239337479)
- Build spec's success measure says sent reports reach "the student's school reviewer" within 5 minutes; PRD section says "their first reviewer (transportation by default)" (237928473 vs 239337479)
- Build spec lists Message the family (SC-A172..176) and bulk-from-one (SC-A170/171) as "not yet built"; PRD SC-R42 / SC-R37 say proven in the Dispatch prototype and HTML version on 2026-10-26 (239337500 vs 239337479)
- Build spec's Conduct_SuspensionNoticesByEmailOrText list omits "a ride arranged on another run", which the PRD settings table includes (239337500 vs 239337479)- SC-R19 says nine statuses are fixed (decided 10/14) while the same requirement's routing-chain part proposes six statuses with the nine as labels (Q123) (239337479)
- SC-A117 names the button "Close here: we called the family" while SC-R33 and SC-A118 name it "Close at Transportation" (239075331 vs 239337479)
- SC-A120 says "3rd referral in 30 days" while SC-R33 gives the example "7th referral in 30 days"; SC-R8 defines the flag as a third report within 30 days (239075331 vs 239337479)
- The Ride Support V1 pages sit in a folder titled "PRD · Discipline V1" while the pages call the module "Ride Support" (a working name) and the code names stay "conduct" (Conduct_ settings, cnd: permissions, TECH-SPEC-student-conduct.md): three names for one module (239108122)
- SC-R18 and the SC-R19 step table say the writer can withdraw "until someone opens it", but RS-AC-18.2 / RS-QA-114 and the v0.2 change log use "taken, not opened" as the cut-off (239108122 vs 241500162)
- Build section DB-A3 counts on-time by buses ("310 buses ran ... 12 late") while Dashboard V1 counts each run once at its school stop ("of 8 runs measured"); the unit is still open in §5.3 / Q180 (238583811 vs 238551042)
- Build section DB-R7 / DB-A6 count stop completion over all scheduled stops and include unscheduled stops; V1 counts rider stops only (school stop excluded) and does not count unscheduled stops (238583811 vs 238551042)
- Build section DB-A7 / DB-QA-118 treat path deviation per run by metres and seconds (350 m for 4 minutes); V1 measures per route-day by share of positions over 5% (238583811 vs 238551042)
- Build section success measure says "1,000 buses" for the 3-second target; Dashboard V1 and Ride Support V1 say the largest district is about 1,100 buses (238583811 vs 238551042, 239108122)
- Dashboard V1 §4.8 gives DashboardSettings to Director and district admin (Supervisor 1 has none in the test district, DB-QA-081), but Appendix A.4 says the prototype's Supervisor holds DashboardSettings (238551042, prototype vs spec)
- Acceptance-criteria ID schemes differ for the same requirements: DB-A1..A22 in the build section vs DB-AC-n.k in Dashboard V1 (238583811 vs 238551042)
- Background lists "new Dispatch" as part of New World Unified; on the platform today Dispatch is only a disabled "coming soon" tile and the Dashboard's Dispatch numbers depend on a log that does not exist until New World Dispatch V1 ships (238583811)
- Build section pins Fleet code at `fleet-main` `969d0138`; the change specification's baseline is `fleet-main` commit `19cb8e5b6` (239403009 vs 238288898)
- Background treats Fleet as one product; the page says there are two Fleet code lines and the higher version (13.x) is the OLDER one (239403009)
- FT-R16 lists reminders as working today; the change spec says the reminders auto-create job creates nothing at the baseline and reminders are wrong in several ways (239403009 vs 238288898)
- Build section rejects Fleet reading another product's tables directly (SY-1) and takes defects through the door (IF-BI-30); W08 names a direct read across the GEDI bridge as the Turns path (239403009 vs 238911532)
- Rollout names four flags but rollback says "both flags off" (239403009)
- Build section says local migrations 867–878 collide with upstream 867–869; the change spec ledger says "next free: 879" with no collision note (239403009 vs 238288898)
- Change spec header says "53 tests passing"; W09 says the full test assembly reports 34 passed, 2 failed, 14 skipped (238288898 vs 238911532)
- Change spec header lists only setting keys 89 and 90 as added; W02 also adds keys 86, 87, 88 and mentions 82–85 (238288898)
- House rules say three columns have trailing-space names; the W09 fact-check found seven (238288898 vs 238911532)
- FT-R19 says the work order keeps a Repair here / Hold for warranty choice; W05 built only an advisory banner that saves nothing (239403009 vs 238845996)
- One district's request sheet recorded FR-01 (due PM on work-order create) as missing; the pane already ships behind setting 24 (238288898)
- W05 and W06 text quote a rejected reading of 9,321 on fixture TELEM-01; the fact-check says 9,320 on fixture PM-REJECT-3 (238845996)
- W11 and W13 say migrations fire "on the first HTTP request, not at build / site start" vs W12 trap "Migrations run inside Application_Start, not on first request" (same mechanism described two ways) (238354434)
- W13 text says InspectionFormPublish has 16 columns and 53 of 53 tests pass vs its own fact-check: 15 columns and 55 of 55 executed (69 methods, 14 skipped); W15 separately reports "34 passed, 2 failed, 14 skipped" (238354434, 238420013)
- W13 says a measurement item publishes as Number and "the mapping is correct as it stands" vs fact-check: Numeric items publish as Picklist (defect) and the receiver vocabulary is INFO / TEXT / NUMBER / PICKLIST, not Text / Picklist / Number (238354434)
- Integrations PRD Phase 1 P0 requires a GPS panel on the Vehicle record plus a deep-link to the Live Viewer vs change spec W15 which built a fleet-wide map instead; section 7 records the two P0s as unmet (239009796 vs 238420013)
- Integrations PRD says the plausibility threshold and service identity are open blocking questions vs W14 which already uses UnitDailyMax (200) and the seeded support account (239009796 vs 238354434)
- Integrations PRD puts engine hours at P1 behind a flag-column migration vs W14 which ingests engine hours now without any flags (239009796 vs 238354434)
- Integrations PRD says current Fleet migration version is 866 vs change spec migrations 867-878 and "next free 879" (local, unshipped work, not a real conflict but easy to misread) (239009796 vs 238354434)
- Within W14 the two telemetry screens disagree: /Telemetry maps provider "Geotab" to the fake provider while /VehicleTelemetry and the map refuse "Geotab" with a reason (238354434)
- Several code comments named in the spec contradict the code (controllers documented as gated on WORKORDER_VIEW / VEHICLE_VIEW / WORKORDER_CLOSE while the attribute uses the 110000 permissions); the spec says the attribute is the truth (238354434)
- Gap analysis (238485528) says migration 867 inspections tables and one seeded Missouri form are "verified in code" and the design page (238485507) plans them as migrations 868/869, but the context page (239075352) says 867-878 are all uncommitted local work and the shipped DB is v866: the inspections module is NOT shipped (status unclear in 238485528).
- Build plan (239435777) says the Beaverton sheet wrongly lists FR-01 (due PM on the work order screen) as a gap; it already ships behind setting key 24.
- Fix spec (239009817) corrects its own earlier claim: Cost Rule IS editable in the Settings UI (earlier Clay spec said DB update only).
- Context page (239075352) says Fleet demo comments point the Turns DVIR read at the GEDI bridge (Pro DB), but driver inspections live in Quick's DB; the consistent door is BPInfo.Rest.Service.
- Reliability spec (237993990) corrects its earlier analysis: health-check stall is 30 s not infinite; connect timeout is 5 s not 30 s.
- Build plan (239435777) lists the warranty migration as 871 and the builder as 870 in the wave tables but 870 / 871 the other way in the ledger (ledger is stated as final); "Wave 2 no migration, 873 still free" conflicts with 873 being used by Wave 6.
- Background says Fleet is one Old World product; pages 239075352 / 239009817 show two Fleet code lines (13.x old, 12.4.x fleet-main newer).
- Background says "9 GPS readers"; reliability spec (237993990) lists "eight reader services" among consumers of the shared socket assemblies while LT (238551066) says nine.
- Employee app build section lists Phase 3 as "the driver role" vs Employee app PRD §14 where Phase 3 is "Health and messages" and drivers are Phase 4 (238616603 vs 238223417)
- Employee app build section says on the phone "settings and secure storage, no SQLite" like Chipmunk vs Employee app PRD EA-70.2 listing "the SQLite cache" as Chipmunk plumbing (238616603 vs 238223417)
- Training notice lead times default 30, 14, 7 days (TG-R6) vs the prototype's 90, 60, 30, 7 (page calls the older ladder a district choice) (239403072 vs 238878746)
- Prototype doc says Training Setup has seven tabs (Group H, incl. Permissions) vs six tabs (§5.4, no Permissions tab) (238878746)
- Prototype doc gives the driver-document cap as 4 MB (§5.3.2, §8.1 R14) vs 2 MB (§4 G2, §9.9) (238878746 vs 239501313)
- Prototype doc lists alert trigger kinds as six (§4 I3), seven (§5.4.4.3, incl. event-logged) and five implemented plus one unseeded (§11.4); also the birth-month check date is given as 2026-05-15 and 2026-05-18 in different sections (238878746 vs 239501313)
- Training module "today" is a browser prototype outside any product, although the pages sit under the "PRD · Quick" folder and are titled "Quick — training tracking module"; it is not part of shipped Quick (238878746, 239403072)
- Employee app PRD uses "Q4" for two decisions: its own Q4 (replaces Assistant) and "decided Q4" for dispatcher override precedence in EA-50.1 (the latter appears to be a connected-system question) (238223417)
- Settings catalogue says settings live in "36 tables and files in nine families", not the "eight stores" of the ecosystem map (238321725)
- BP Web settings count is given as 932 catalogued / 795 in code in the catalogue table but as "BP Web 894 plus 38 rows in its side tables" in the settings program PRD (238321725 vs 239534081)
- The bus-capture setting is called FormModule_Turns_CaptureVehicle in the stress test, while the settings pages say the stored key is Turns_CaptureVehicle and the FormModule_ form is the C# constant alias; status unclear which is stored (238682115 vs 239534081)
- Stress test Round 1 said drivers are told of changes in "0 ways"; corrected to 1 (the scheduled email digest of Pro route changes) (238682115)
- Stress test narrative (S1, S7, J3, PAR-3) still says every Dispatch save is broadcast/emailed at once; the production re-check on the same page says changes are held until sent since 2026-09-18 (238682115)
- "PRD · Workflow PRD" describes a proposed prototype product with its own Pro Web API key connection and multi-tenant backend, while the WF build section describes the shipped Workflow as wf_ tables inside BP Web writing through GeoIMS; the two are not reconciled on either page (238911553 vs 239075373)
- Trips SE settings count: the simplification page says 68 settings in 9 categories (and elsewhere "Settings has 10 categories") vs the gap analysis citing the settings catalogue: 59 settings in SE, 54 in CE (239140908 vs 238387207)
- Closure Planner grade gate: §3.3 text says the gate "appears at four sites" but its table lists five and the §11 summary says "Unconditional gate at 5 sites" (238321767)
- Simplification page says Trips SE has "No API — form-driven Playwright is the only path" for setup, while the build section shows Trips SE already exchanges data with BPInfo (imports School/Get, Driver/Get, Vehicle/Get) and plans IF-TP-01 / IF-TP-02; the two are about different directions (setup write vs import) but read as conflicting (239140908 vs 238747655)
- Login Flow says users land on a unified Dashboard after sign-in vs Users and Access C2: land on the product used last, "as today" (58851500 vs 237043713)
- Login Flow defers Forgot password to V2 with OTP expiry TBD (10 min placeholder) and password policy undecided vs Users and Access: ships now, 24-hour code, 8 characters + 1 number (58851500 vs 237043713; the later page wins by its own statement)
- Login Flow says the unified sign-in covers Time & Attendance, BP Web, BP Pro and BP Quick vs background (Unified = T&A, GPS+, Chatbot, ETL, new Dispatch) and Users and Access, which puts Quick / Pro per-database permissions out of scope (58851500)
- Password rules differ by system: Unified 8 characters + 1 number (237043713) vs BP Info REST users 12+ characters with four character classes (247824423)
- TA-R1 says the PIN signs in to the time clock and Turns signs in with username and password, but TA-A6 / TA-QA-001 test a PIN sign-in on Turns (238485608; also BI-R6 in 239403051)
- BP Web upgrade folder is given as 314 files (238485587) vs 214 files, latest 1306 (239403051)
- BI page says "Five new settings" but its settings table lists eleven rows; it says the door provides IF-BI-01 to IF-BI-35 but cites IF-BI-39 to IF-BI-52 (239403051)
- Assistant is a BPInfo client not named in the background product list (239534102)

## 9. Pages not read

None. All 87 pages in the slice were read to the end. Limits: the Confluence markdown export reports a lossy conversion (structured macros such as status lozenges and embedded diagrams are dropped), so content held only in macros or images was not read; the 19 folders have no body.
