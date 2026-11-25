# ETL test approach: BP Pro (Old World) to BusPlanner Unified (New World)

Date: 2026-11-24. Status: **draft for review**. Nothing in this approach has been run.

## Verdict

Test the ETL at the data level, table by table, with Shikhar's mapping sheet as the oracle. Use read-only SQL that compares a BP Pro database with the Unified database loaded from it. Add a regression layer from past ETL bugs, so the team's ticket-by-ticket view is also covered. Start with the snapshot plan chain and students, because most ETL defects are there.

Get answers to the open questions (section 9) from Shikhar **this week or next**. He is away for most of December.

## 1. Inputs

| Input | What it gives | Where |
|---|---|---|
| Mapping sheet (Shikhar, 2026-11-23) | Source, join, transform and notes for each column of 36 tables | `knowledge/repos/BusPlannerUnified/etl-mapping-sheet.md` (summary and link) |
| ETL spec v2 (draft, 2026-02-23), QA validation doc, load-test doc | Architecture, manifest, error handling, 20 integrity checks, SDCC baseline counts | `knowledge/repos/BusPlannerUnified/schema-and-etl-spec.md` |
| Code map | What Extract and Load actually do; 31 spec-versus-code differences | `knowledge/repos/BusPlannerUnified/data-services.md`, `schema-and-etl-spec.md` section 8 |
| Jira | ETL bugs: ENG-2903, ENG-2747, ENG-2918, ENG-3177, ENG-884, ENG-883, ENG-882, ENG-881, ENG-880, ENG-878, ENG-795, ENG-2109 | `knowledge/jira.md` |
| Meetings | Decisions, owners and open points on ETL (section 8) | `meetings/INDEX.md` |

## 2. Scope

**In scope:** the 36 tables in the sheet. These are 30 `pln_`, 3 `veh_`, `opr_operator`, `ta_employee` and `ta_employee_operator`. The scope also covers the extract (JSON and manifest), the load (phases, MERGE, skips, delete detection) and the snapshot window.

**Out of scope for now:**
- GPS ingest (`dev_`, `gps_`).
- `usr_` and `chat_` tables.
- The MigrationTool (schema migrations).
- Old World SaaS migrations (STEO, STSYR).
- Old World behaviour, except where we need it to set up an ETL case (decision of 2026-11-13).

## 3. Test layers

| # | Layer | Question it answers | How | Who / tool |
|---|---|---|---|---|
| L1 | Mapping review | Do the sheet, the code and the spec agree? | For each table, compare sheet rows with the Extract SQL and Load MERGE. Send each mismatch to Shikhar. | Agent (`code-mapper`), reviewed by QA |
| L2 | Source-to-target reconciliation | Does each source row land once, with the right values? | Read-only SQL per table (see section 4) | Agent through `harness/sql.ps1`; QA reviews |
| L3 | Data-integrity invariants | Is the loaded data internally consistent? | The 20 checks in `schema-and-etl-spec.md` section 9, updated with the sheet (check 3 changes: ENG-2918) | Agent, SQL |
| L4 | Behaviour scenarios | Does the ETL handle change over time? | Change a **dedicated** BP Pro copy, run Extract and Load, and compare before and after (see section 5) | QA with a developer; needs a writable copy |
| L5 | Bug regression | Do the past ETL fixes still hold? | One case per bug (section 6) | Markdown cases, then automated |
| L6 | Downstream smoke | Do consumers show the loaded data correctly? | GPS+ Live Viewer (operator not "Unassigned", correct day plan), chatbot answer on students per stop | Browser, light |
| L7 | Operational | Does a nightly run finish and report correctly? | Manifest status, row counts against the previous run (50% alert), duration against 30/60 min targets, logs | Read logs and manifest |

## 4. L2 reconciliation: checks per table

For each table, run the six check types below. The sheet's columns give the expected values directly.

| Check | Expected | Example |
|---|---|---|
| Coverage | Every in-scope source row has exactly one live target row, or a documented skip reason | Active `BPX_Route` rows valid on the snapshot date = `pln_route` rows in that snapshot |
| Keys | The MERGE key is unique and matches the source GUID | `pln_stop.external_id` = `{BusStopGUID}:{RunGUID}:{PassNumber}` |
| Values | Each transform is correct: truncation, fallback, enum map, constant | `run_type` 0-3 -> PICKUP, DROPOFF, NOON_PICKUP, NOON_DROPOFF |
| Time and geometry | Seconds -> local time on the snapshot date; UTM -> WGS84 within an agreed tolerance | `BP_RunV.StartTime` 25200 -> snapshot date 07:00:00 |
| Foreign keys | Each FK resolves to the right parent in the same snapshot or customer; skipped rows are counted | `pln_student_stop.program_guid` NULL when the enrollment has no program, never guessed |
| Lifecycle | `is_active` and `is_deleted` follow `[Effective, Retire)` and delete detection | Retired student -> `is_active = 0` (ENG-880) |

**Reports show counts and GUIDs only.** They never show names, addresses, phone numbers or dates of birth. The source databases hold real student and staff data.

## 5. L4 behaviour scenarios

| Area | Scenario |
|---|---|
| Incremental | Change a student after the watermark -> updated; change one 3 hours before -> not reprocessed; an enrollment change advances the student watermark |
| Delete detection | Remove a source row -> `is_deleted = 1`, `is_active = 0`, `'ETL-DELETE'`; add it back -> contact revives; other entities: confirm behaviour |
| Supersede | Change a zone polygon -> old row soft-deleted, new `zone_guid`; same polygon -> no-op. Recreate a grade with the same code -> stale row soft-deleted |
| Assignment history | Change a vehicle operator -> old link retired yesterday, new one from today. Change a staff operator -> retired today. Future-dated AVL row -> not picked (ENG-3177) |
| Driver-vehicle | Two BP Pro links for one vehicle -> most recent wins; an admin-UI row is never evicted; the snapshot copy is 1 vehicle per employee |
| Payroll adoption | Payroll-CSV employee with the same StaffID -> adopted, payroll fields kept; StaffID over 50 chars -> skipped, not truncated |
| Snapshots | 10-weekday window; re-run reuses the snapshot; a failed load does not deactivate other days (ENG-2903); select by date, not `is_active` (ENG-2918) |
| Idempotency | Re-run with an unchanged source -> no new rows, no changed `modified_date` on unchanged contacts |
| Older BP Pro | Missing contact columns -> typed defaults, the load does not fail |
| Time zone | Load server in a different zone from the customer -> times unchanged (ENG-882) |
| Multi-customer | Driver-vehicle assignments do not leak between customers (ENG-884) |

## 6. Regression set from past bugs (L5)

ENG-2903 (failed load deactivates snapshots), ENG-2918 (plan picked by `is_active`), ENG-2747 (students missing from stops, wrong program), ENG-3177 and the 2026-11-13 fix (future-dated vehicle mapping), ENG-884 (employee-vehicle leak), ENG-883 (AVL vehicle COALESCE), ENG-882 (load-server time zone), ENG-881 (`BPL_VehicleStaff` not migrated), ENG-880 (retired students active), ENG-878 (zone updated in place), ENG-795 (run and stop types), ENG-2109 (vehicle-operator write).

## 7. Priority

| Priority | Tables | Reason |
|---|---|---|
| P1 | `pln_snapshot`, `pln_route`, `pln_component`, `pln_run`, `pln_stop`, `pln_student_stop`, `pln_student`, `pln_enrollment`, `veh_vehicle`, `veh_employee_vehicle`, `pln_employee_vehicle`, `ta_employee` | Most bugs; feeds GPS+, chatbot and T&A |
| P2 | `pln_student_address`, `pln_student_contact`, `pln_student_snapshot`, `pln_school`, `pln_district`, `pln_zone`, `pln_school_program`, `pln_school_zone`, `pln_depot`, `veh_vehicle_operator`, `ta_employee_operator`, `opr_operator` | Reference data with rules (supersede, history, affinity) |
| P3 | Lookups: grade, program, bell time (3), contact type, address type, enrollment type, vehicle type, seat type (2), zone type | Simple direct maps |

## 8. Environment, data and automation

- **Where:** the dev SQL server (`k8-mssql`). It holds both BP Pro restores (for example `SDCC_*`) and versioned Unified databases. L2 and L3 can compare them on one server. Staging is read-only and only when you ask. Never production (hard rule 1).
- **Data:** the restores are real customer data. Use aggregate results only. Whether we may use a given client's data on dev is still an open question (meeting 2026-11-20).
- **L4 needs a writable BP Pro copy** that only QA uses, plus a way to trigger Extract and Load on demand. We do not have this yet. All changes use the prefix `QA-AUTO-` and get cleaned up afterwards.
- **Automation path:**
  1. Write markdown cases with the SQL channel (`/write-cases`) and run them with `/run-cases`.
  2. Then generate one SQL check per sheet row, so the checks change when the sheet changes.
  3. Then move stable checks into the product repo's ETL test project (location to agree with the team).
- `harness/sql.ps1` is read-only (SELECT/WITH, always rolled back, maximum 200 rows). Reconciliation queries must return counts or mismatches only. Cross-database queries through it are **not yet tried**.

## 9. Meeting input and conflicts

All items below are things people said in meetings, not verified rules.

- **Mapping document.** 2026-11-16: Shikhar said no written mapping existed and he would publish one ([etl-workflows 20:11](https://fathom.video/calls/901422514?timestamp=1211)). The sheet of 2026-11-23 closes this.
- **How to start (open).**
  - 2026-11-16: Shikhar suggested going ticket by ticket. Sharaiz Khan was asked to start on ETL testing as a whole ([54:03](https://fathom.video/calls/901422514?timestamp=3243)).
  - **Recommendation:** go table by table (L2-L4), with the bug list as a separate layer (L5). This covers both views.
- **Stability.**
  - 2026-11-13: Tommy said the ETL is "established and not changing" ([qa-onboarding 12:37](https://fathom.video/calls/899495000?timestamp=757)).
  - The sheet cites recent fixes (ENG-3177, ENG-2918, ENG-2816), and ENG-3058 changed the copy process on 2026-11-23.
  - **Recommendation:** treat the ETL as still changing, so plan for the checks to change with it.
- **Capacity.**
  - 2026-11-13: ETL is the fill-in track and gives way to Discipline.
  - 2026-11-23: QA moves to T&A this week.
  - ETL work therefore starts at low capacity.
- **Source data (conflict).**
  - 2026-11-12: a copy of the client's BP Pro database goes into the QA environment.
  - 2026-11-16: the New World "does not need client Old World databases".
  - 2026-11-23: Extract reads a weekly Landmark copy of three client databases (ENG-3058).
  - **Recommendation:** use the dev restores for L2 and L3. Ask which client databases match a Unified load of the same day.
- **Earlier knowledge versus the sheet.** The sheet changes several things we had recorded. Examples are the active snapshot, the address type, school-program affinity and the VIN length. The full list is in `etl-mapping-sheet.md`.

## 10. Open questions (for Shikhar, and for you)

1. Which BP Pro restore and Unified database on dev were loaded from the same extract? Is SDCC the reference client? **For you:** you mentioned "DCL". Is this SDCC (Clay)?
2. May QA run aggregate queries on that client's data on dev?
3. Can QA get a writable BP Pro copy and a way to trigger Extract and Load on dev?
4. The sheet flags items as "Confirm with QA": columns extracted but not loaded, `stop_planned_time` always NULL, and every address forced to HOME. Are these intended, or are they gaps that need a ticket?
5. A vehicle operator change retires the old link **yesterday**, but a staff operator change retires it **today**. Is this difference intended?
6. Delete detection for students is "global, not customer-scoped". Can this delete students across customers in a shared database?
7. The `pln_employee_vehicle` tie-break picks a vehicle by `ORDER BY vehicle_guid`, which is arbitrary. Is that acceptable?
8. What coordinate tolerance applies after UTM -> WGS84 conversion?
9. Cell I205 in the sheet shows `#NAME?`. What is the note for `pln_zone.zone_code`?
10. Who owns ETL questions while Shikhar is away in December?

## 11. Next steps

| # | Step | Owner | Needs |
|---|---|---|---|
| 1 | Review and approve this approach | Sharaiz | - |
| 2 | Send questions 1-10 to Shikhar (draft first) | Sharaiz / agent | your yes |
| 3 | L1 mapping review for the P1 tables against code | agent | repo access (have) |
| 4 | Write P1 L2/L3 cases (`/write-cases`) | agent, then QA review | answers to Q1-Q2 |
| 5 | Run P1 checks on dev (`/run-cases`) | agent | VPN + SQL password set |
| 6 | Plan L4 environment with a developer | Sharaiz | Q3 |
