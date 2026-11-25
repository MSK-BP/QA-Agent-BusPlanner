# ETL test approach: BP Pro (Old World) to BusPlanner Unified (New World)

**Date:** 2026-11-24, revised 2026-11-25 · **Status:** draft for team review · **Owner:** Sharaiz Khan (QA)
Nothing in this approach has been run yet.
**Published:** [ETL Test Approach: Data Validation Utility](https://busplanner.atlassian.net/wiki/spaces/PE/pages/294879234) in Confluence, ETL Testing folder. This file is the source copy.

## Verdict

- Build an **ETL Data Validation Utility**. It compares each BP Pro database with the Unified database loaded from it, table by table.
- Use Shikhar's mapping sheet (ENG-3373) as the oracle. One check for each sheet row.
- The utility reads only. It runs after Load, outside the pipeline. It reports counts and GUIDs only.
- Add a small set of change scenarios and bug-regression cases. A one-time comparison cannot find these defects.
- **Gate 0:** get dev answers first. The questions are on the Confluence page "ETL: Questions and Findings for the Dev Team (QA POC)".

## 0. Gate: dev answers before test design

- The POC found 77 items: probable bugs, sheet corrections, rules to confirm, and environment gaps.
- QA cannot write a trusted expected result until the devs answer them.
- Answers needed first:
  - **A1:** removed rows stay in later plan days.
  - **A2:** one failed load turns off all plan days.
  - **C1:** the deployed value of `OverwriteExistingSnapshots`.
  - **D1:** which BP Pro database feeds each Unified database.
  - **D2:** an exact source and target pair for QA.
- Shikhar is away for most of December. Get the answers before then.

## 1. Architecture (as QA understands it)

```
BP Pro SQL Server ──► Extract ──► IBM COS bucket ──► Load ──► Unified SQL Server
  (client DB, or a      (.NET app)    JSON per table,      (Deployment,     pln_ / veh_ /
   weekly copy)                      manifest.json,        Redis queue +     opr_ / ta_ tables
                                     *_guids.json          COS polling)
```

| Stage | What it is | Where it runs | What it changes in the data |
|---|---|---|---|
| Extract | .NET console app `BpPro.Etl.Extract` | Old World SaaS or customer machines (Windows Task Scheduler). Dev clients: Kubernetes CronJob, 06:00 UTC | SQL joins and filters, time decoding, UTM → WGS84 coordinates, enum maps. Writes delete lists (`*_guids.json`) |
| Object storage | IBM COS: one JSON file per table, `manifest.json` (SUCCESS / PARTIAL / FAILED) | IBM Cloud | Nothing. A checkpoint |
| Load | .NET service `BpPro.Etl.Load` | Kubernetes Deployment. Takes jobs from Redis `etl:load-queue:<client>` and polls COS for manifests | MERGE on GUID, lifecycle (`is_active`, `is_deleted`), delete detection, bridges, the 10-weekday snapshot window |

- Only SUCCESS manifests load. PARTIAL and FAILED loads are skipped.
- Some clients (Landmark, ENG-3058) extract from a weekly copy of the client database, not the live database.
- **To confirm (D4):** Helm says Load is a Deployment. Ticket pod names suggest a CronJob.

## 2. The ETL Data Validation Utility

### 2.1 What it checks

| Check family | Question | Example |
|---|---|---|
| Structure | Do the target tables and columns exist with the expected types, lengths and nullability? | `veh_vehicle.vin` length; geometry columns are WGS84 |
| Completeness | Does each in-scope source row have exactly one live target row, or a known skip reason? | Active `BPX_Route` rows for the snapshot date = `pln_route` rows in that snapshot |
| Keys | Is each MERGE key unique, and does it match the source GUID? | `pln_stop.external_id` = `{BusStopGUID}:{RunGUID}:{PassNumber}` |
| Values | Is each transform correct: constant, enum map, truncation, fallback? | `run_type` 0–3 → PICKUP, DROPOFF, NOON_PICKUP, NOON_DROPOFF |
| Time and geometry | Are times correct on the snapshot date, and are coordinates within tolerance? | `StartTime` 25200 → 07:00:00; tolerance from the devs (C9) |
| Referential integrity | Does each FK point to the right parent in the same snapshot and customer? | No orphan `pln_student_stop` rows |
| Lifecycle and obsolete data | Do retired or deleted source rows show as inactive or deleted in the target? | Retired student → `is_active = 0`; removed run is not live in days 2–10 |
| Snapshot health | Is there one active plan for each of the 10 weekdays, and is each one complete? | No day with 0 student-stops (ENG-3056) |
| Run health | Did the last run finish, and are the row counts in line with the previous run? | Manifest SUCCESS; no table changes by more than 50% |

### 2.2 Two checkpoints

- **Primary: source → target.** It checks the full result that users see. Most known bugs are in Load (A1, A2), so a COS-only check would miss them.
- **Diagnostic: COS files.** Use them when a check fails, to tell whether Extract or Load caused it.

### 2.3 How it is built

- One rule for each row of the mapping sheet. When the sheet changes, the matching rule changes.
- Use the 320 SQL checks from the July audit (`ETL/docs/ETL-Data-Correctness-Audit-2026-07-07.md`, section 8) as the starting set. The devs confirm they are current (E5).
- Each rule returns only a count of mismatches and up to N sample GUIDs. It never returns names, addresses, phone numbers or dates of birth.
- The result is one report per run: pass or fail for each table and each rule, with counts.
- **Reuse before building.** The migration "Skill 2" already validates loads for new clients (meeting 2026-11-19). Agree with its owner what to share.

### 2.4 Where it runs: three stages

| Stage | Where | Trigger | Needs |
|---|---|---|---|
| 1. Now | QA hub, read-only SQL (`harness/sql.ps1`) | On demand | Staging STSBHN pair (98–99% match); dev answers |
| 2. Next | Kubernetes job on dev and staging | After each nightly Load | Devs to host it; an alert channel |
| 3. Later | ETL repo, integration test project | CI on each ETL change | A SQL Server in CI (E2); ETL tests on PRs (E1) |

### 2.5 What the utility does not cover

- **Change over time:** updates, deletes, revives, operator changes, re-runs. These need a BP Pro copy that QA can change (D3). See section 3.
- **Downstream use:** GPS+, the chatbot, Discipline and T&A reading the loaded data.
- **BP Pro itself.** The Old World is in scope only as the source of truth.

## 3. Other test layers (small)

| Layer | What | When |
|---|---|---|
| Mapping review | Compare the sheet with the code. Done in the POC: 13 sheet corrections (section B on Confluence) | Done; re-check when the sheet changes |
| Change scenarios | Change a QA-only BP Pro copy (`QA-AUTO-` data), run Extract and Load, run the utility before and after | After D2 and D3 |
| Bug regression | One case for each ETL bug (list below) | After dev answers |
| Downstream smoke | GPS+ Live Viewer shows the right day plan and operator; chatbot answers about students per stop | Light, with each release |

**Change scenarios:**
- Incremental: change a student after the watermark → updated. Direct SQL edits do not move `ModifyDate`, so make changes through the BP Pro UI.
- Delete: remove a route, run, stop, student-stop or address → not live in any plan day (A1, A3).
- Revive: delete a row, then add it back → one row, active (A11).
- History: change a vehicle or staff operator → the old link retires, the new link starts (A9, C3).
- Snapshots: force a failure on one day → the other days stay active (A2, ENG-2903).
- Re-run with no source change → no new rows, no changed values.

**Bug regression set:** ENG-2903, 2918, 2752, 2747, 3177, 2686, 3056, 2112, 1408, 884, 883, 882, 881, 880, 878, 795, 2109, 2620, 3015.

## 4. Scope and priority

- **In scope:** the 36 tables in the sheet (30 `pln_`, 3 `veh_`, `opr_operator`, `ta_employee`, `ta_employee_operator`), the extract files, the load and the snapshot window.
- **Out of scope:** GPS ingest (`dev_`, `gps_`), `usr_` and `chat_` tables, schema migrations, Old World SaaS migrations.

| Priority | Tables | Reason |
|---|---|---|
| P1 | snapshot, route, component, run, stop, student_stop, student, enrollment, vehicle, employee_vehicle (both), ta_employee | Most bugs; feeds GPS+, chatbot, Discipline and T&A |
| P2 | student_address, student_contact, student_snapshot, school, district, zone, school_program, school_zone, depot, vehicle_operator, ta_employee_operator, opr_operator | Reference data with rules |
| P3 | Lookups: grade, program, bell time, contact type, address type, enrollment type, vehicle type, seat type, zone type | Simple direct maps |

## 5. Environment and data

- **Never production.** The COS bucket `bp-etl-production` is blocked in QA tooling until the devs confirm what it is (D7).
- **Best pair today:** staging `STSBHN_20262027_LIVE_2026_10_22` → `BP_Unified_STSBHN`, 98–99% GUID match. Dev SDCC pairs match only 73–82%.
- **No exact pair exists.** QA needs a frozen BP Pro copy plus the Unified database loaded from it (D2).
- Staging data is scrambled daily after the load (D6). Confirm which columns change before comparing them.
- The source databases hold real student and staff data. Use aggregate results only. Data permission is still open (D8).
- Test data QA creates uses the prefix `QA-AUTO-`, and QA removes it afterwards.

## 6. Meeting input

These are statements from meetings, not verified rules.

- **Vision document (2026-11-24):** QA to write an ETL testing vision in the Discipline document format, before the build starts. This document is that vision.
- **Skill 2 (2026-11-19):** a migration skill validates ETL loads and fails today on staff ID. Owner Andy Tompkins. It overlaps the utility, so agree what to share.
- **Workflow diagram (2026-11-19):** ETL QA design waits for a workflow diagram from the devs (E7). Section 1 is QA's version until then.
- **Extract location (2026-11-24):** Extract runs on Old World SaaS machines. This agrees with the code.
- **Snapshot window (conflict):** a meeting on 2026-11-16 said "today plus nine/10 days". The code uses 10 weekdays. The code is the rule until the devs confirm (C2).
- **Capacity:** ETL is the QA fill-in track and gives way to Discipline (2026-11-13). The Stage 1 utility is small enough for that.

## 7. Open questions on the utility

1. Can the utility reuse or extend Skill 2?
2. Who hosts Stage 2, and where do its alerts go?
3. Can QA read the COS files on dev and staging for diagnosis?
4. Can QA trigger Extract and Load on demand on dev?
5. Do the devs want the stable rules in the ETL repo (Stage 3)?

## 8. Next steps

| # | Step | Owner | Needs |
|---|---|---|---|
| 1 | Get answers to the Confluence questions, first A1, A2, C1, D1, D2 | Sharaiz, devs | Page shared |
| 2 | Review this approach with the team | Sharaiz | — |
| 3 | Agree the overlap with Skill 2 | Sharaiz, Andy Tompkins | — |
| 4 | Build Stage 1 rules for the P1 tables | QA agent, QA review | Step 1 answers |
| 5 | Run Stage 1 on the staging STSBHN pair and report | QA agent | VPN, SQL access |
| 6 | Plan the QA-only BP Pro copy and change scenarios with a dev | Sharaiz | D2, D3 |
| 7 | Propose Stage 2 hosting to the devs | Sharaiz | Stage 1 results |

## References

- Mapping sheet summary and full copy: `knowledge/repos/BusPlannerUnified/etl-mapping-sheet.md`, `etl-mapping-sheet-full.md`
- Code review, run mechanics, SQL profile: `knowledge/repos/BusPlannerUnified/etl-code-review.md`
- Dev questions: `reports/2026-11-25-etl-dev-questions.md` (published in Confluence, ETL Testing folder)
- ETL spec and the 20 integrity checks: `knowledge/repos/BusPlannerUnified/schema-and-etl-spec.md`
- Meetings: `meetings/INDEX.md`, ETL topic
