# ETL code review against the mapping sheet (2026-11-24)

Read-only review of `BusPlannerUnified` at **origin/dev 4fd03d48 (2026-11-24)**; for ETL paths dev = main = staging (last ETL change 2026-11-17). Old World read at `BusPlanner` f0f6e712 (2026-11-13). Nothing was built or run. Oracle: `etl-mapping-sheet-full.md`. Paths: `ETL/` = `BusPlannerUnified/BusPlanner.ETL/`, `E/` = `ETL/BpPro.Etl.Extract/Extractors/`, `L/` = `ETL/BpPro.Etl.Load/`, `Orch` = `L/Orchestration/LoadOrchestrator.cs`, `Snap` = `L/Snapshots/SnapshotManager.cs`.

Verdict: the sheet is right for most column mappings. It is **not** yet a safe oracle for lifecycle, delete, snapshot and failure behaviour. Items below marked INFERENCE need a run or the owner to confirm.

## 1. Sheet corrections (use these, not the sheet)

| Rule | Sheet | Code |
|---|---|---|
| `pln_route.vehicle_guid` future-dated AVL | never picked | true only in default mode (`E/RouteExtractor.cs:116-118`); AVL mode (`use_avl_vehicles: true`) filters retire only (`:74-78`). All client configs use `false` today, so latent. Tie-break EffectiveDate DESC, CreateDate DESC (`:113-114,126`) |
| `pln_student_stop.stop_guid` | GEO composite join | joins 3 of 4 GEO parts (no GEOSeqNum) and no `bs.Active` filter (`E/BusStopStudentExtractor.cs:53-55`) |
| All INT times | secs -> HH:mm:ss | decode first (strip BASE_TIME, mask 24 bits, `Common/Utilities/CDayTimeDecoder.cs:29-37`); `<= 0` -> NULL for every time (`E/BaseEntityExtractor.cs:219-226`); >= 24h wraps (`IntToTimeConverter.cs:21-22`) |
| Student watermark | applied at extract | extract always full; filter at load (`L/EntityLoaders/StudentEntityLoader.cs:75-77`); missing ModifiedDate kept; lifecycle-boundary rows re-processed (`WatermarkFilter.cs:46-79`); only students and addresses use it |
| `pln_student_snapshot` | one row per active student, latest active enrollment grade | every non-deleted student incl. retired (`StudentSnapshotEntityLoader.cs:78`); any enrollment type, retire vs `GETDATE()`, effective not checked (`:72-77`); insert-only, never updates or removes (`:79-85`) |
| `pln_enrollment` audit | 'ETL' | INSERT omits created_by/modified_by/is_deleted, DB defaults apply (`EnrollmentEntityLoader.cs:79-87`); returning soft-deleted GUID inserts a new row (`:62`) |
| Revive | contact and contact type only | also student, student_address, school_program; most other tables match on `is_deleted = 0`, so a returning row inserts a duplicate or hits the unique index (INFERENCE) |
| Lifecycle clock | window | `LifecycleMapper` uses `DateTime.UtcNow.Date` (`Common/Utilities/LifecycleMapper.cs:41-68`); snapshot validity uses customer-local date (`SchoolDayCalculator.cs:53`) |
| Operator bridges | yesterday / today | vehicle uses SQL `GETDATE()` (`VehicleOperatorBridgeLoader.cs:145,167`); staff uses `DateTime.UtcNow.Date` (`StaffEntityLoader.cs:300`). Vehicle whose operator is removed: old link **not** retired (`:77-78`); deactivated staff: link never retired (`StaffEntityLoader.cs:133`) |
| `pln_employee_vehicle` | 1 vehicle per employee | GUID-order tie-break; update only, removed assignments stay; inactive employees not excluded (`EmployeeVehicleEntityLoader.cs:45`). Unmerged branch `dispatch/eng-1628/1629` adds a `substitution_source IS NULL` filter; on dev a re-run can overwrite Dispatch/GPS-import rows |
| `pln_stop.stop_planned_time` | always NULL | confirmed: loader reads `dto.PlannedTime` but no extractor sets it |
| `pln_school_zone` | DB-to-DB loader | post-phase-4 bridge; also retires links of soft-deleted zones (`'ETL-RETIRE'`, `SchoolZoneBridgeLoader.cs:64-75`) |
| Not in sheet | - | Default "Default Busplanner Operator/Depot" (is_system = 1) seeded every load and assigned to vehicles with no depot/operator (`DefaultDepotOperatorLoader.cs:64-106`); `runs.Distance` extracted not loaded |

## 2. Run mechanics a tester needs

- **Extract** (`Orchestration/ExtractionOrchestrator.cs`): entities one after another per customer; a failed entity is logged and left out of the manifest; manifest SUCCESS / PARTIAL / FAILED (`ManifestGenerator.cs:64-78`). No projection or unknown time zone aborts the customer. Watermark advance = extract start time. Retry only for COS upload. Queue-publish failure is a warning only. 19 `*_guids.json` delete lists; none for staff, routes, runs, stops, student-stops, components, seat/vehicle types; a failed upload skips delete detection silently.
- **Load order**: phases 1-5 once -> delete detection -> bridges (school_program, school_zone, vehicle_operator, default depot/operator) -> phase 6 snapshots -> per day: phases 7, 8, stop-school links, activate -> deactivate outside window -> watermarks (`Orch:256-438`). Phase membership in `L/Orchestration/LoadPhaseDefinition.cs:23-92`.
- **Only SUCCESS manifests load**; PARTIAL and FAILED are skipped (`L/Polling/ManifestPoller.cs:94`). A manifest older than `_manifest_loaded` is skipped as success.
- **No customer-wide transaction.** A phase stops at its first failed entity and the customer aborts; earlier commits stay; watermarks not advanced; current day snapshot stays inactive.
- **Snapshot window**: next 10 Mon-Fri days from customer-local today, today included, no holiday calendar, computed at load time. `OverwriteExistingSnapshots` default false (Helm `values.yaml:64`); local configs set true with fixed `snapshot_dates`.
- **Day filters**: runs/stops by Frequency bitmask, student-stops by Schedule bitmask; NULL or 0 = every day.
- **Delete detection** targets: operators, vehicles, districts, depots, schools, bell time tables, zone types, zones, grades, programs, enrollment types, enrollments, contact types, contacts, vehicle-staff, students (global, not customer-scoped; also operators and vehicles). None for addresses, routes, runs, stops, student-stops, components, staff.
- **Skip logging**: run/stop FK skips Warning; student-stop skips only in a summary count; route/component date skips Debug; zone SQL errors logged, not counted.
- **Deploy**: Helm `deploy/helm/etl`; dev only in repo: SDCC (`values-sdcc.yaml`, source `SDCC_Summer_26_2026_07_17`, nightly on) and STSBHN (manual). Extract CronJob `0 6 * * *` UTC; Load = Deployment on Redis `etl:load-queue:<client>`. Manual extract: `kubectl -n busplanner-dev create job --from=cronjob/etl-<client>-extract ...`. Customer installs run Extract from Windows Task Scheduler (`ETL/docs/ETL-Extract-Installation-Rulebook.md`).
- **Tests and CI**: `ETL/BpPro.Etl.Tests`, about 450 xUnit unit tests, no SQL Server. CI runs them only on push to dev (`pipelines/backend-deploy-etl-dev.yml`), not on PRs (`backend-pr.yml` excludes ETL). 17 of 36 tables have no test; no runtime MERGE, FK-skip, geometry, delete-detection or re-run test exists.
- **Audit**: `ETL/docs/ETL-Data-Correctness-Audit-2026-07-07.md` is the source of the IDs in the sheet (`RUNS-014`, `EMPLOY-006` ...; scheme `<ENTITY6>-NNN`, `D1`-`D13`, `T1`-`T10`; severity S1-S4). Section 8 (line 5352) holds 320 runtime verification SQL queries.
- `ETL/scripts/setup-checklist.md` is stale (7 phases, staff skipped). `ETL/scripts/seed/manual-tables.md` explains seed GUIDs. `ETL/schema/cleanup-for-retesting.sql` resets a target DB.

## 3. Probable product bugs (to confirm, then report)

| # | Issue | Evidence | Confidence |
|---|---|---|---|
| 1 | Removed routes/runs/stops/student-stops stay live in reused snapshot days 2-10 (upsert only, no delete detection, overwrite off by default) | `Orch:379`; `RouteEntityLoader.cs:124`; `BusStopStudentEntityLoader.cs:342`; Helm `values.yaml:64` | High, needs a run |
| 2 | ENG-2903 mechanism still present: `EnsureSnapshots` deactivates all window snapshots before loading; a failure on day k leaves k..10 inactive | `Snap:187-190`; catch `Orch:449-456` | High, check fix status |
| 3 | Student addresses deleted in Pro never removed | no address delete target (`Orch:664-693`) | High |
| 4 | Vehicle operator removed in Pro keeps old link; deactivated staff keep operator link | `VehicleOperatorBridgeLoader.cs:77-78`; `StaffEntityLoader.cs:133` | Medium |
| 5 | Lifecycle day (UTC) vs snapshot day (customer-local) can differ by one day; bridges use two clocks | `LifecycleMapper.cs:41-68`; section 1 | Medium |
| 6 | AVL-mode future-dated route vehicle (ENG-3177 fix incomplete) | `RouteExtractor.cs:74-78` | Medium, latent |
| 7 | Student-stop stop join: the 3-part GEO join is **needed** (a 4-part join matches almost nothing in data), but it is ambiguous for transfer stop pairs that share a GEOObjID (859 in STSBHN) and the sheet's "first instance" rule can pick the wrong stop; also no stop Active filter | `BusStopStudentExtractor.cs:53-55`; SQL profile section 6 | Medium, needs data check on STSBHN |
| 8 | Enrollment program `TOP 1` without ORDER BY; can differ from student-stop program | `EnrollmentExtractor.cs:42-47` | Low-medium |
| 9 | Component with several versions repeats ComponentGUID in JSON | `ComponentExtractor.cs:40` | INFERENCE |
| 10 | Times at 00:00 become NULL; >= 24:00 wrap | `BaseEntityExtractor.cs:224`; `IntToTimeConverter.cs:21-22` | Medium |
| 11 | Polygon parser assumes 3 doubles per vertex (Z only) | `Common/Utilities/CoordinateConverter.cs:109-110` | INFERENCE |
| 12 | Returning soft-deleted rows insert duplicates on tables that match `is_deleted = 0` | section 1 | INFERENCE |
| 13 | Errors swallowed: delete-detection failure, zone SQL error, queue publish | `Orch:738`; `ZoneEntityLoader.cs:275-283`; `ExtractionOrchestrator.cs:361-369` | Low |
| 14 | `pln_student_snapshot` includes retired students and never refreshes grade/address | section 1 | Medium |

## 4. Old World (BP Pro) facts for test design

- Schema is C++ (`Unmanaged/libs/GEDI/Schema_Current.cpp`), upgrades in `GEDI/UpgradeDatabase.cpp`; current DB version 13.1.10. Columns differ by client DB version: `BPX_Contact.Email2AllowPortalAccess` from 11.6.4; `BP_RunV.LockFlag` and `Frequency` from 11.6.0.
- **No database triggers.** `ModifyDate`/`CreateDate` are stamped by the BP Pro client (`GEDI/BPUpdateBuilder.cpp:72-81`), some bulk paths use the PC clock. Direct SQL edits do not move `ModifyDate`, so they do **not** trigger the student watermark: change data through the BP Pro UI, or set `ModifyDate` explicitly.
- `BPL_VehicleStaff` has no Active/Effective/Retire columns: an assignment ends by delete or re-point.
- `BPL_AVLVehicleRoute` has Effective/Retire (NULL = open) and optional RunGUID.
- `IsRHS` and `DistToStart` change on run recalculation, not on user edit (`GEDI/BPRunV.cpp:3340-3469`).
- No ETL copy job (Landmark, ENG-3058) is in the Old World repo.
- UI sources for changes: runs/stops `GEDI/BPRunV.cpp`, `GBPUI/RouteManager.cpp`; vehicle-route assignment `GEDI/DispatchGPSVehicleAssignment.cpp`; contacts `GEDI/StudentUpdate.cpp`, `GBPUI/ContactInfo.cpp`; substitutions `Managed/Georef.BusPlanner/SubstitutionWriter.cs`.
- Not found: UTM zone storage, Frequency semantics, enrollment types, `BPL_RecordProgram.Exclude` rules, delete builder soft/hard behaviour.

## 6. Source and target data on the QA SQL servers (profiled 2026-11-24, counts only)

Queries: `C:\Users\skhan\Repos\qa-runs\busplanner\etl-profile-2026-11-24\` (run through `harness/sql.ps1`).

- **Sheet text errors found in the schema**: run Effective/Retire are on `BPX_Run` only (not `BP_RunV`); `Frequency` and `RunVGUID` are on `BP_RunV` (not `BPX_Run`); `BP_Student` has no `GradeCode` column; `BPX_Route` has no `Active` flag (lifecycle by dates only). AVL join is `BPL_AVLVehicleRoute.AVLVehicleGUID -> BPX_AVLVehicle.AVLVehicleID = BPX_Vehicle.VehicleID`.
- **Version difference**: `BPX_VehicleType.MaxCumulativeEquipment` is missing in `SDCC_SY2526_PLAN_JHREZONE_2026_03_17` and `STSBHN_20252026_LIVE_2026_03_26`, present in later restores. Check the vehicle-type extractor handles it (negative test). All contact columns exist in every restore, so the contact COL_LENGTH fallback cannot be tested with them.
- **No exact source/target pair exists.** Every Unified DB is loaded daily (extract 06:00 UTC, snapshots about 08:10) from a BP Pro source these servers do not hold. GUID match rates: staging `STSBHN_20262027_LIVE_2026_10_22` -> `BP_Unified_STSBHN` 98-99% (best; only pair with contacts); dev `STSBHN_20252026_LIVE_2026_03_26` -> `BusPlanner_Unified_7_21_STSBHN` 95-98%; SDCC pairs 73-82% (Summer_26 has new student GUIDs: unusable). Staging STSBHN names are scrambled daily after load (Slack 2026-10-23), so compare keys and non-personal values only.
- **Cross-database queries work** on one server (`-Database master`, three-part names); dev-to-staging does not. 60 s timeout: one entity per query, filter to one snapshot, join with `TRY_CAST(external_id AS uniqueidentifier)`.
- **Dev Unified DBs have no contacts or contact types** (staging has them): contact load not running on dev.
- **T&A data**: STSBHN has 2 staff and 0 vehicle-staff rows; use SDCC for `ta_employee`, `veh_employee_vehicle`, `pln_employee_vehicle`.
- **Natural test data**: future-dated AVL rows (staging STSBHN only, 431 rows on 2 routes); vehicle operator differs from depot operator (1 in STSBHN); students with no address (288 STSBHN); staff with no operator (2 per restore); blank StaffID (12 SDCC); inactive runs (2 staging); whitespace-only contact fields (many); duplicate contact priority (many); runs with several RunV (6-8) or several primary components (5-11); stops with several pass numbers (1).
- **Must be seeded (no restore has them)**: MAIN + special program at one stop, enrollment with several programs, `Exclude = 1`, bell-time program link, `LockFlag = 3`, run type OTHER, zone without polygon, StaffID > 50, over-length fields, future-dated stop/route/student.

## 7. Jira and Confluence (read 2026-11-25)

No ticket exists for an ETL test approach, ETL QA or a data-validation utility. Confluence has no ETL page (no diagram, test plan or mapping page). Nearest: ENG-3373 (Shikhar, In Progress: the mapping sheet; validated by counts + 5 random rows per table on STSBHN; "no mapping errors found" means the sheet matches the code, not that the code is right), ENG-2815 (Resolved, Drew's ad-hoc ETL pass; findings in ENG-2850 comments), ENG-3015 (asks for ETL integration tests in MERGE and purge modes).

Code findings already ticketed:

| Finding (section 3) | Ticket | Status |
|---|---|---|
| 1 removed rows stay in reused snapshot days | ENG-2752 | Open, unassigned |
| 2 one failed load deactivates all days | ENG-2903 (ENG-2918 reader workaround approved; ENG-2920 chatbot) | In Progress, no PR |
| 3 address delete detection; all addresses HOME; second addresses dropped | ENG-3373 findings; ENG-2686 | In Progress |
| 6 AVL-mode future-dated vehicle | ENG-3177 / ENG-3099 say AVL mode unchanged; ENG-883 older AVL bug | Not ticketed |
| ETL overwrites Dispatch / GPS+ substitution rows | ENG-2620 (Vlad: park), ENG-2169, ENG-3015, unmerged dispatch/eng-1628 | Open |

Other open ETL defects: ENG-2749 (one staff per bus; blank phone `''` breaks fallback), ENG-2748 (capacity = size class, not seats; wheelchair never set), ENG-2750 (school address never loaded), ENG-2751 (depot times dropped), ENG-2807 (HRCE school missing), ENG-3056 (Reopened: student-stop MERGE full scans; snapshots never pruned; OSTA newest 6 snapshots have 0 student-stops; has acceptance criteria), ENG-2112 (manifest poller misses newest extract above 1,000 COS objects), ENG-1408 (new StaffGUID with same number fails whole load), ENG-2412 (`pln_stop_zone` never loaded), ENG-967 (zone audit dates), ENG-2534 (per-client COS keys), ENG-3058 (Landmark refresh excludes staff/vehicle; Open, past target 2026-11-20; 3 LBL tasks disabled). ENG-3181 is not an ETL defect (custom client view).

Ready for QA (ETL): ENG-3177, ENG-3099, ENG-2747, ENG-2109, ENG-884, ENG-883, ENG-882, ENG-881, ENG-880, ENG-878, ENG-801, ENG-795. The July items (ENG-795 to ENG-884) have one-line descriptions and no expected behaviour: get it from the July audit (`ETL-Data-Correctness-Audit-2026-07-07.md`) before testing.

Unconfirmed: the deployed `OverwriteExistingSnapshots` value per client (ENG-2620, ENG-3056); whether Load runs as a Deployment (Helm in repo) or a CronJob per client (ENG-2534, ENG-3056 pod names).

Confluence pages worth reading: "BusPlanner Unified: Developer Overview & Setup" (PE 286359568: pick plan by date, dev HRCE/NSTS read customer prod BP Info, so test bus writes only on STSBHN or QA1); "New World Branching & Release Workflow" (PE 277381141: ETL branch testing needs old-world access or a listed exception, no decision yet); "New client stand-up runbook" (PE 251756545: ETL setup steps C2/C3, E12).

## 5. Team context (Slack, mail, 2026-10 to 2026-11)

- ENG-2903 fix plan (Slack 2026-10-29, Shikhar and Vlad): load-completed marker; continue to next day on failure and mark failed; load into a new inactive snapshot and swap in one transaction. Readers must not use `is_active` (ENG-2918, merged).
- ENG-3177 is an Extract change deployed directly on the customer server (HRCE), 2026-11-17.
- NPSSTS: load failed on 335 staff sharing 4 placeholder StaffIDs (2026-10-20, ENG-2418); fixed in BP Pro data.
- Staging STSBHN is scrambled daily by a script 30 minutes after the ETL load (2026-10-23): do not reconcile staging STSBHN against its BP Pro restore.
- Shikhar's ETL architecture diagram (promised 2026-11-16) is not published yet.
