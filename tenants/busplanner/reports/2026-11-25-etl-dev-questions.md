# ETL (BP Pro → BusPlanner Unified): questions and findings for the dev team

**From:** QA (Sharaiz Khan) · **Date:** 2026-11-25 · **Status:** open, waiting for dev answers

**Published:** Confluence PE > QA Documentation > ETL Testing: BP Pro to BusPlanner Unified > [ETL: Questions and Findings for the Dev Team (QA POC)](https://busplanner.atlassian.net/wiki/spaces/PE/pages/293502993). The Confluence page is where devs answer; this file is the source copy.

## Why this document

QA ran a proof of concept (POC) to prepare ETL testing. We read the mapping sheet (ENG-3373), the Extract and Load code, the ETL tests and CI, the BP Pro and Unified databases on dev and staging, the Old World code, Jira, Confluence and Slack. This document lists every question, probable bug, gap and point of confusion that we found. We need your answers before we can write test cases with a trusted "expected result".

**Scope and evidence**
- Code: `BusPlannerUnified` at `origin/dev` 4fd03d48 (2026-11-24). For the ETL folders, `dev`, `staging` and `main` are the same. Old World: `BusPlanner` at f0f6e712 (2026-11-13).
- Nothing was built or run. All findings come from reading code and running read-only SQL counts. Items marked **(inference)** need a run or your confirmation.
- Path prefixes: `ETL/` = `BusPlannerUnified/BusPlanner.ETL/`, `E/` = `ETL/BpPro.Etl.Extract/Extractors/`, `L/` = `ETL/BpPro.Etl.Load/`, `Orch` = `L/Orchestration/LoadOrchestrator.cs`, `Snap` = `L/Snapshots/SnapshotManager.cs`.
- No student, parent or staff data is in this document. Data findings are counts only.

**How to answer:** write your answer under each item. Say one of: *intended* (and why), *bug* (ticket key), or *don't know* (who knows). If an item is already fixed, give the PR.

**Suggested owners:** Shikhar Patel (Extract, Load, sheet), Vladislav Derbenev (snapshots, GPS+ readers, Dispatch), Michel Walther (deployment, COS, ENG-2903), Mitchell Bland (Landmark refresh, chatbot reads), Michelle Prichard (open ETL audit tickets).

## Summary

| Section | Items |
|---|---|
| A. Probable product bugs | 16 |
| B. Mapping sheet corrections | 13 |
| C. Behaviour we need confirmed | 15 |
| D. Environments, data and deployment | 10 |
| E. Tests, CI and process | 8 |
| F. Tickets that need dev input | 10 |
| G. Old World (BP Pro) questions | 6 |

The five items QA needs first: **A1, A2, C1, D1, D2**.

---

## A. Probable product bugs

Please confirm each one: bug or intended. If it is a bug and has no ticket, QA will raise one after your answer.

### A1. Removed routes, runs, stops and student-stops stay live in later plan days
- **What we see:** a snapshot day that already exists is only upserted on the next run (`Orch:379`). There is no `NOT MATCHED BY SOURCE` branch and no delete detection for routes, runs, stops, student-stops or components. `OverwriteExistingSnapshots` defaults to `false` (`deploy/helm/etl/values.yaml:64`; `Common/Models/Config/LoadSettings.cs:33`). So a row removed in BP Pro can stay live in days 2–10.
- **Ticket:** ENG-2752 (Open, unassigned).
- **Questions:** Which value does each client run with today (dev, staging, prod)? Who owns ENG-2752? How will the fix avoid removing rows that GPS+ or Dispatch wrote (ENG-2620, ENG-3015)?

### A2. One failed load still deactivates every plan day (ENG-2903)
- **What we see:** `EnsureSnapshots` deactivates every snapshot in the window before loading (`Snap:187-190`). If day k fails, days k to 10 stay inactive, and nothing in the catch block reactivates them (`Orch:449-456`). ENG-2918 changed only the GPS+ readers to pick a plan by date.
- **Ticket:** ENG-2903 (In Progress, no PR).
- **Questions:** Which of the fixes agreed on Slack (2026-10-29) is being built: a load-completed marker, continue-on-day-failure, or build-then-swap? Is the chatbot fixed too (ENG-2920)? Does any other reader still select by `is_active`?

### A3. Student addresses deleted in BP Pro are never removed
- **What we see:** `Orch:664-693` has no delete target for addresses, and there is no `student_address_guids.json`. Shikhar's ENG-3373 findings say the same.
- **Questions:** Intended? Is it part of ENG-2686?

### A4. Every address is HOME, and second addresses are dropped
- **What we see:** the loader always uses the default HOME type (`EnsureAddressType`). The source has 6 (SDCC) and 15 (STSBHN) distinct address types. Student-stop rows whose address did not load are skipped.
- **Ticket:** ENG-2686 (In Progress).
- **Question:** What is the target design and the date?

### A5. ENG-3177 fix does not cover AVL mode
- **What we see:** the default path filters on EffectiveDate (`E/RouteExtractor.cs:116-118`). The AVL-mode path (`use_avl_vehicles: true`) filters only on `RetireDate` (`:74-78`), so a future-dated row can still win. All configs use `false` today, so the gap is latent. Staging STSBHN has 431 future-dated AVL rows on 2 routes.
- **Ticket:** none (ENG-3177 and ENG-3099 say AVL mode is out of scope; ENG-883 is an older AVL-mode bug).
- **Questions:** Will any client use AVL mode? Should we raise a ticket?

### A6. Student-stop to stop join is ambiguous for transfer stops
- **What we see:** the join uses 3 of the 4 GEO key parts (no `GEOSeqNum`) and has no stop `Active` filter (`E/BusStopStudentExtractor.cs:53-55`). Data supports the 3-part join: a 4-part join matches almost nothing. But in STSBHN, 859 stops share a `GEOObjID` (the transfer pick-up and drop-off pairs), and the sheet says "first instance" wins.
- **Questions:** For a transfer pair, which stop should the student get? Is "first instance" deterministic? Should inactive stops be joinable?

### A7. Times of exactly 00:00 become NULL, and times of 24:00 or later wrap
- **What we see:** `<= 0` becomes NULL for every time field (`E/BaseEntityExtractor.cs:219-226`), and `hh` formatting wraps at 24h (`Common/Utilities/IntToTimeConverter.cs:21-22`).
- **Question:** Can BP Pro hold after-midnight or overnight runs? If yes, what should Unified store?

### A8. UTC day and customer-local day can differ
- **What we see:** `LifecycleMapper` sets `is_active` from `DateTime.UtcNow.Date` and parses dates as UTC (`Common/Utilities/LifecycleMapper.cs:41-68`). Snapshot validity uses the customer-local date (`L/Utilities/SchoolDayCalculator.cs:53`). Near midnight, a student can be active in one rule and not the other. The vehicle-operator bridge uses SQL `GETDATE()` (server local time) and the staff-operator bridge uses `DateTime.UtcNow.Date`.
- **Questions:** Which clock is the rule? Is this related to ENG-882?

### A9. Operator links are not retired in two cases
- **What we see:** a vehicle whose operator is removed in BP Pro keeps its old link (`L/EntityLoaders/VehicleOperatorBridgeLoader.cs:77-78`). Staff who become inactive keep their operator link (`L/EntityLoaders/StaffEntityLoader.cs:133`). The staff bridge does retire on an operator change (`:255-263`).
- **Question:** Intended?

### A10. `pln_student_snapshot` includes retired students and never refreshes
- **What we see:** it takes every non-deleted student, including retired ones (`StudentSnapshotEntityLoader.cs:78`). Grade can come from any enrollment type (Main or Home). The retire test uses `GETDATE()`, not the snapshot date, and the effective date is not checked (`:72-77`). It only inserts, so address and grade never update on a re-run (`:79-85`).
- **Question:** Which of these are intended?

### A11. Rows that come back after a soft delete
- **What we see:** revive exists for student, student_address, contact, contact_type and school_program. Most other tables match on `is_deleted = 0`, so a GUID that comes back inserts a new row. That can duplicate the row or fail on the unique index **(inference)**. Example: `EnrollmentEntityLoader.cs:62`.
- **Question:** Which tables should revive?

### A12. A returning soft-deleted student can stay deleted
- **What we see:** the watermark filter passes the student only if `ModifyDate` is recent, and the reconcile pass excludes `is_deleted = 1` rows (`StudentEntityLoader.cs:391`) **(inference)**.
- **Question:** Intended?

### A13. Enrollment program is not deterministic
- **What we see:** `TOP 1` without `ORDER BY` (`E/EnrollmentExtractor.cs:42-47`). The student-stop version orders by Name (`E/BusStopStudentExtractor.cs:62`). The two programs can disagree. No current restore has an enrollment with more than one program.
- **Question:** Add `ORDER BY Name` to match?

### A14. Components with several versions, and runs with several primary components
- **What we see:** `INNER JOIN BPX_ComponentV` returns one row per version (`E/ComponentExtractor.cs:40`), so `components.json` can repeat a ComponentGUID **(inference)**. Runs give one row per RunV and primary component, and the last row wins (`E/RunExtractor.cs:68-75`). Data: 5–11 RunVs in STSBHN have more than one Type=0 component.
- **Question:** Which component and route should such a run get?

### A15. Polygons are parsed as 3D only
- **What we see:** the polygon parser assumes 3 doubles per vertex (`Common/Utilities/CoordinateConverter.cs:109-110`). Run lines handle 2D and 3D (`:170-175`) **(inference)**.
- **Question:** Can BP Pro store 2D polygons?

### A16. Errors that never fail the run
- **What we see:**
  - A failed delete-list upload or download only logs a warning, so delete detection is skipped silently (`ExtractionOrchestrator.cs:325-330`; `Orch:705-742`).
  - A zone SQL error is logged and skipped but not counted (`ZoneEntityLoader.cs:275-283`).
  - A queue-publish failure is a warning only (`ExtractionOrchestrator.cs:361-369`).
  - Student-stop FK skips appear only in a summary count.
- **Question:** Should any of these fail or alert?

---

## B. Mapping sheet corrections (ENG-3373)

The sheet matches the code for most columns. Please confirm these corrections, and update the sheet.

| # | Sheet row | Sheet says | What we found |
|---|---|---|---|
| B1 | `pln_route.vehicle_guid` | future-dated AVL row never picked | true in default mode only (see A5). Tie-break (EffectiveDate DESC, CreateDate DESC) is not in the sheet |
| B2 | `pln_student_stop.stop_guid` | GEO composite join | 3-part join, no stop Active filter (see A6) |
| B3 | All int times | seconds → HH:mm:ss | value is decoded first (strip BASE_TIME, mask 24 bits, `CDayTimeDecoder.cs:29-37`); 0 → NULL for every time, not just bell times |
| B4 | `pln_student` watermark | applied at extract | extract always writes the full list; the filter is at load (`StudentEntityLoader.cs:75-77`); missing ModifyDate is kept; boundary rows re-processed |
| B5 | `pln_student_snapshot` | one row per active student; latest active enrollment | see A10 |
| B6 | `pln_enrollment` audit columns | 'ETL' | INSERT omits created_by, modified_by, is_deleted; DB defaults apply (`EnrollmentEntityLoader.cs:79-87`) |
| B7 | Revive | contact and contact type only | also student, address, school_program (see A11) |
| B8 | `pln_run` filter columns | Eff/Retire on "BPX_Run / BP_RunV" | only `BPX_Run` has EffectiveDate/RetireDate; `Frequency` and `RunVGUID` are on `BP_RunV`, not `BPX_Run` |
| B9 | `pln_student` not loaded | "GradeCode still extracted" | `BP_Student` has no `GradeCode` column in any restore |
| B10 | `pln_school_zone` | DB-to-DB loader | bridge after phase 4; also retires links of deleted zones (`'ETL-RETIRE'`, `SchoolZoneBridgeLoader.cs:64-75`) |
| B11 | Missing rows | — | default "Default Busplanner Operator/Depot" (is_system = 1), seeded every load (`DefaultDepotOperatorLoader.cs:64-106`); `runs.Distance` and route `AVLVehicleID` extracted, not loaded |
| B12 | `pln_zone.zone_code` notes | cell I205 shows `#NAME?` | broken cell; what is the note? |
| B13 | `pln_stop.stop_planned_time` | always NULL | confirmed: Load reads `dto.PlannedTime`, but no extractor sets it. Intended? |

---

## C. Behaviour we need confirmed

These are not bugs yet. We need the intended rule to write an expected result.

| # | Question | Context |
|---|---|---|
| C1 | What is the deployed value of `OverwriteExistingSnapshots` and `SnapshotDates` per client and environment? | Helm default `false`; local configs `true` with fixed dates. Decides A1. ENG-2620 and ENG-3056 also ask. |
| C2 | Is the 10-day window "next 10 Mon–Fri days from customer-local today, today included, no holiday calendar"? | `SchoolDayCalculator.cs:14-27`. Meeting 2026-11-16 said "today plus nine/10 days". No holidays: is a snapshot on a school holiday expected? |
| C3 | Operator change: vehicle link retires **yesterday**, staff link retires **today**. Which is right? | `VehicleOperatorBridgeLoader.cs:145,167`; `StaffEntityLoader.cs:300` |
| C4 | Student delete detection is global, not customer-scoped (also operators and vehicles). Safe only with one database per client? | `StudentEntityLoader.cs:424-430` |
| C5 | `pln_employee_vehicle` picks a vehicle by `ORDER BY vehicle_guid`, never removes old assignments, and keeps inactive employees. Intended? | `EmployeeVehicleEntityLoader.cs:45`. Unmerged `dispatch/eng-1628/1629` changes this loader |
| C6 | Only SUCCESS manifests load; PARTIAL is skipped. Is that intended, given that Extract still publishes PARTIAL? | `ManifestPoller.cs:94`; `ExtractionOrchestrator.cs:225-231` |
| C7 | What does a failed customer leave behind, and is that acceptable? Committed phase 1–5 rows stay; watermarks do not advance; today's snapshot stays inactive. | No customer-wide transaction |
| C8 | Which UTM projection and zone does each client use, and where is it stored? | Extract aborts with no projection (`ExtractionOrchestrator.cs:152-157`) |
| C9 | What coordinate tolerance should QA accept after the UTM → WGS84 conversion? | Needed for reconciliation checks |
| C10 | Should a reused snapshot be rebuilt, or only patched? | Root question behind A1, A2 and ENG-2620 |
| C11 | Which BP Pro columns that are extracted but not loaded does Unified need? Route (Regular, SpecialEd, TrackedByGPS), component depot times (ENG-2751), school (Capacity), student (MedicalDetail, MetAtBus, LoadTime), staff (Position, License) | Sheet "Confirm with QA" rows. Product decides; dev confirms the cost |
| C12 | Should `BPX_VehicleType.MaxCumulativeEquipment` be probed like the contact columns? | Missing in older restores (SDCC 2026-03-17, STSBHN 2026-03-26) |
| C13 | Phase layout: phases 1–5 once, delete detection, bridges, then phases 6–8 per day. Is this order final? | `LoadPhaseDefinition.cs:23-92`; `scripts/setup-checklist.md` still says 7 phases |
| C14 | Does `pln_school.modified_by` really take `CreateUser`? | `SchoolEntityLoader.cs:188-189` |
| C15 | Extract names the COS folder and queue `SnapshotDate` by the UTC date, but Load ignores it and uses customer-local today. Can the two differ for a client far from UTC, and does it matter? | `ExtractionOrchestrator.cs:102,350` |

---

## D. Environments, data and deployment

| # | Question | Context |
|---|---|---|
| D1 | Which BP Pro database does each Unified database load from each night? | No pair on the QA servers is an exact match. Best: staging `STSBHN_20262027_LIVE_2026_10_22` → `BP_Unified_STSBHN` (98–99% GUID match). Dev SDCC pairs: 73–82%. |
| D2 | Can QA get an exact pair: a frozen BP Pro copy plus the Unified database loaded from it, with a way to trigger Extract and Load on demand? | Needed for reconciliation and for change scenarios |
| D3 | Can QA get a writable BP Pro copy on dev, used by QA only? | To make controlled changes (`QA-AUTO-` data) and re-run the ETL |
| D4 | Does Load run as a long-running Deployment on the Redis queue, or as a CronJob per client? | Helm says Deployment; ENG-2534 and ENG-3056 pod names suggest CronJob |
| D5 | Dev Unified databases have no contacts and no contact types (staging has them). Is the contact load off on dev? | `U_7_21_STSBHN` at migration 93 still has 0 rows |
| D6 | Staging STSBHN is scrambled every day after the load (Slack 2026-10-23). Is that still true, and which columns change? | Decides what QA can compare there |
| D7 | Every local extract/load config names the COS bucket `bp-etl-production`. Is it production? | QA has blocked the name in its tooling. If it is prod, local configs should not point at it |
| D8 | May QA run aggregate queries on client data on dev and staging? | Open from the 2026-11-20 meeting (data scrubbing) |
| D9 | Landmark weekly refresh (ENG-3058): when will the script change, and when do the 3 LBL tasks restart? What should happen when a route points to an excluded vehicle or staff member? | Past target date 2026-11-20 |
| D10 | Where do Extract and Load logs and manifests live for staging and prod, and can QA read them? | Needed to check skips and failures |

---

## E. Tests, CI and process

| # | Question | Context |
|---|---|---|
| E1 | Can ETL tests run on PRs? | `backend-pr.yml` excludes `BusPlanner.ETL`; ETL tests run only on push to dev (`pipelines/backend-deploy-etl-dev.yml`). The Developer Overview page suggests PR tests cover the backend |
| E2 | Is there a plan for ETL integration tests against SQL Server? | About 450 unit tests, none against SQL. No test for MERGE, FK skips, geometry, delete detection or re-runs. ENG-3015 asks for MERGE and purge tests |
| E3 | 17 of 36 tables have no test. Which should get tests first? | Includes component, enrollment, student_address, student_snapshot, school_program, grade, ta_employee_operator |
| E4 | How should QA test ETL feature branches before merge? | Branching page: ETL needs Old World access or a listed exception; no decision recorded |
| E5 | Can the 320 runtime SQL checks in the July audit (`ETL/docs/ETL-Data-Correctness-Audit-2026-07-07.md`, section 8) be the base of QA's checks? Are they current? | Audit IDs (RUNS-014, EMPLOY-006 ...) appear in the sheet and code |
| E6 | Can QA own an ETL test-approach ticket and a data-validation utility ticket? | None exists. ENG-3373 is a one-time check. Meeting 2026-11-16 planned a session on this |
| E7 | When is the ETL architecture diagram coming? | Promised 2026-11-16 |
| E8 | Who answers ETL questions while Shikhar is away in December? | |

---

## F. Tickets that need dev input

| Ticket | Status | What QA needs |
|---|---|---|
| ENG-795, 801, 878, 880, 881, 882, 883, 884 | Ready for QA since July | Expected behaviour and acceptance criteria. Descriptions are one or two lines. Are they still valid after later changes? |
| ENG-3177, ENG-3099 | Ready for QA | Acceptance criteria; confirm the AVL-mode scope (A5); which client and data to test on |
| ENG-2747 | Ready for QA | Fix PR; is the "JAR" case a different cause? |
| ENG-2109 | Ready for QA | Is it superseded by later bridge changes (A9)? |
| ENG-2850 | In Progress, no children | Split Drew's 2026-10-26 list into tickets? (contacts, 3-part address join, stale snapshot rows, transfer stops, stops not on a run) |
| ENG-3056 | Reopened | Why do OSTA's newest snapshots have 0 student-stops? Is pruning old snapshots planned? |
| ENG-1408 | Open | Does BP Pro reissue StaffGUID each year? A new GUID with the same employee number fails the whole load |
| ENG-2112 | Open, unassigned | The manifest poller reads only the first 1,000 COS objects. Is it fixed or planned? Does any client bucket exceed 1,000 objects today? |
| ENG-2748, 2749, 2750, 2751, 2807, 2412, 967 | Open, several unassigned | Owner and target date for each. Is any of them blocked on a schema decision? |
| ENG-2620, ENG-2169, ENG-3015 | Open | Is the nightly reload overwriting GPS+ and Dispatch rows accepted (Vlad: "park"), or will ENG-3015 fix it? When does `dispatch/eng-1628/1629` merge? |

---

## G. Old World (BP Pro) questions

| # | Question | Context |
|---|---|---|
| G1 | BP Pro has no database triggers. `ModifyDate` is set by the client (PC clock). Do all edit paths set it? Do imports and bulk tools? | The student watermark depends on it (`GEDI/BPUpdateBuilder.cpp:72-81`) |
| G2 | Is a BP Pro delete a hard delete for all source tables? | Delete detection depends on GUIDs disappearing |
| G3 | `BPL_VehicleStaff` has no Active, Effective or Retire columns. How does an assignment end: delete or re-point? | Affects `veh_employee_vehicle` history |
| G4 | What do `Frequency` (BP_RunV) and `Schedule` (BPL_BusStopStudent) bitmasks mean? Is NULL or 0 really "every day"? | `FrequencyFilter.cs:9-15`, `ScheduleFilter.cs:16-24` |
| G5 | `IsRHS` and `DistToStart` change on run recalculation, not on a user edit. Does a recalculation set `ModifyDate`? | `GEDI/BPRunV.cpp:3340-3469` |
| G6 | Which BP Pro versions do clients run? `Email2AllowPortalAccess` exists from 11.6.4; `LockFlag` and `Frequency` on RunV from 11.6.0; current 13.1.10 | Decides which version cases QA must cover |

---

## Data facts for reference (counts only)

| Fact | Where |
|---|---|
| STSBHN has 2 staff and 0 vehicle-staff rows; SDCC has 537 staff and 243 vehicle-staff rows | dev restores |
| 288 STSBHN students have no address | STSBHN 2026-03-26 |
| 12 SDCC staff have a blank StaffID (skipped by the loader) | SDCC 2026-03-17 |
| 1 STSBHN vehicle has an operator that differs from its depot's operator | STSBHN |
| No restore has: MAIN plus special program at one stop, an enrollment with several programs, `Exclude = 1`, a bell-time program link, `LockFlag = 3`, run type OTHER, a zone with no polygon, StaffID over 50 characters | all 5 restores |

QA's working notes: `tenants/busplanner/knowledge/repos/BusPlannerUnified/etl-code-review.md` and `etl-mapping-sheet.md` in the QA hub.
