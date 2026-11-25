# ETL source-to-target mapping sheet (Shikhar Patel, 2026-11-23)

Source: `BusPlanner-ETL-Source-to-Target-Mapping.xlsx` in Shikhar Patel's OneDrive, shared 2026-11-23 with Andy Tompkins, Yusra Abbasi and Sharaiz Khan. Link: https://busplanner-my.sharepoint.com/:x:/p/shikhar_patel/IQAYow1kzLZhSIfF6rCZNFZuAWvWW9syLvUVbFPX9wL9nZQ
Read 2026-11-24 in the browser (one sheet, "ETL Mapping", 405 rows). The M365 connector cannot read it (Graph `FileCorruptTryRepair`); Excel for the web opens it.

The sheet says green rows are "mapped & verified from code". It is the **current** oracle for ETL tests and supersedes the 2026-02-23 ETL spec (`schema-and-etl-spec.md` section 6) where they differ. It does not supersede code; a mismatch between sheet and code is a finding.

Columns: Target Table, Target Column, Type, Null, Source Table(s), Source Column, Join / Filter, Transformation, Notes / Test.

## Tables (36)

| Group | Tables | Scope |
|---|---|---|
| Snapshot plan | `pln_route`, `pln_component`, `pln_run`, `pln_stop`, `pln_student_stop`, `pln_student_snapshot`, `pln_snapshot`, `pln_employee_vehicle` | snapshot-scoped; MERGE on `external_id` (or `external_guid`) + `snapshot_guid` |
| Student | `pln_student`, `pln_student_address`, `pln_student_contact`, `pln_enrollment` | outside snapshots; student and address incremental by watermark - 120 min; contacts full every run |
| Org / geography | `pln_district`, `pln_school`, `pln_school_program`, `pln_school_zone`, `pln_zone`, `pln_zone_type`, `pln_depot` | outside snapshots |
| Vehicle reference | `pln_vehicle_type`, `pln_vehicle_seat_type`, `pln_seat_type` | outside snapshots |
| Lookups | `pln_grade`, `pln_program`, `pln_bell_time`, `pln_bell_time_program`, `pln_bell_time_type`, `pln_contact_type`, `pln_address_type`, `pln_enrollment_type` | outside snapshots |
| Vehicles | `veh_vehicle`, `veh_vehicle_operator`, `veh_employee_vehicle` | outside snapshots |
| Operator | `opr_operator` | outside snapshots |
| Staff | `ta_employee`, `ta_employee_operator` | outside snapshots |

Internal DB-to-DB loaders (no extractor, no JSON): `pln_student_snapshot`, `pln_snapshot`, `pln_school_zone`, `pln_employee_vehicle`, `pln_address_type`.
Not in the sheet: `pln_customer`, `pln_school_year` (pre-seeded), `pln_stop_school`, `pln_student_school`, all `dev_`, `gps_`, `usr_`, `chat_` tables.

## Cross-cutting rules (testable)

- Source filter: most entities extract `Active = 1` only. `BP_Student` and `BP_Address` have no Active flag: `is_active` = `[EffectiveDate, RetireDate)` window (retire **exclusive**), reconciled on every full load.
- `LifecycleMapper(Active, [Effective, Retire))`: retired-but-Active source row -> `is_active = 0` (district, school, zone, depot).
- Text: truncate to target length; NOT NULL text gets a fallback (`'Unknown'`, `'Unknown School'`, `'UNKNOWN'` and so on). Exception: `ta_employee.employee_number` is **never truncated**; StaffID > 50 chars or blank -> staff row skipped.
- Unresolved required FK -> row **skipped**, not failed (run, component, stop, student_stop, school, zone, address, contact, enrollment, bell time, links). Unresolved optional FK -> NULL.
- Times: BP Pro INT seconds -> `HH:mm:ss` at extract -> snapshot date + time as **local** `DATETIME2`, no UTC shift (run start/end, stop scheduled time). Bell times: packed int -> local `TIME`; 0 -> NULL.
- Geometry: UTM WKB -> WGS84 at extract (stops, schools, addresses, depots, zone polygons and bounding boxes, run paths). Load uses `STGeomFromText/STPolyFromText(..., 4326).MakeValid()`; unloadable path -> NULL; stop without lat/long -> skipped; zone without geometry -> skipped.
- Soft delete: DeleteDetector via `*_guids.json` lists sets `is_deleted = 1`, `is_active = 0`, `modified_by = 'ETL-DELETE'`. Contacts and contact types revive on reappear. Student delete detection is "global, not customer-scoped".
- Audit: `created_by` / `modified_by` = `'ETL'`, `modified_date` = `SYSUTCDATETIME()`; some tables keep source provenance (district, school, program, depot, vehicle, operator, staff, vehicle-staff).

## Table-specific rules worth a test

| Table | Rule |
|---|---|
| `pln_route.vehicle_guid` | AVL row **active at extract time** (EffectiveDate <= now, not retired); future-dated AVL row must not be picked (ENG-3177) |
| `pln_run` | run type 0-3 -> PICKUP, DROPOFF, NOON_PICKUP, NOON_DROPOFF, else OTHER; `lock_flag` clamp 0-3 else 0; several RunV per RunGUID = day variations, last wins after Frequency filter |
| `pln_stop.external_id` | `{BusStopGUID}:{RunGUID}:{PassNumber}`; a stop on N runs = N rows; `stop_type` 0-7 map, missing key fails the load |
| `pln_stop.stop_planned_time` | **always NULL**: extractor never fills it (flagged for QA) |
| `pln_student_stop` | synthetic `external_guid` = GEO composite + StudentGUID + ProgramGUID, so MAIN + special program at one stop = 2 rows; `program_guid` NULL kept, never guessed from school (ENG-2747); `is_primary_program` = MAIN enrollment type; `walk_distance` metres |
| `pln_student` | grade removed (now `pln_enrollment.grade_guid`, ENG-2279); watermark = MAX(student ModifyDate, enrollment ModifyDate) |
| `pln_student_address.address_type_guid` | **always HOME**; BP Pro address type never mapped (flagged for QA) |
| `pln_student_contact` | dynamic SELECT by `COL_LENGTH` probe; missing column on older BP Pro -> typed default, never fails; change test uses BIN2 collation (case change counts) |
| `pln_enrollment` | full master list, not snapshot-scoped; `retire_date` is not a soft delete; `school_year_guid` always NULL today |
| `pln_student_snapshot` | one row per active student per snapshot; address = MIN non-deleted; grade = latest active enrollment |
| `pln_snapshot.is_active` | created 0, activated only after phases 7/8; **never pick a day's plan by `is_active`**: use the snapshot dated that day, most recent created first (ENG-2918) |
| `pln_school_program` | real school-program affinity, not every school x every program; no `school_programs.json` -> bridge unchanged |
| `pln_school_zone` | School-type zones matched by `zone_code = school_code`; relationship `SCHOOL_BOUNDARY` |
| `pln_zone` | change = soft-delete old + insert new `zone_guid`, never update in place; identical = no-op (geometry by `STEquals`) |
| `pln_grade` | recreated grade with same code: stale same-code row soft-deleted first |
| `pln_depot` | `depot_name` = DepotID (no name in BP Pro); `Position` is address text, coordinates come from Geo_Node |
| `veh_vehicle.depot_guid` | linked only when vehicle operator = depot operator or either is NULL |
| `veh_vehicle_operator` | one current link per vehicle; operator change: old `retire_date` = **yesterday**, new starts today |
| `ta_employee_operator` | one current link per employee; operator change: old `retire_date` = **today** |
| `veh_employee_vehicle` | one current vehicle per employee and employee per vehicle; conflicts most-recent-wins; admin-authored rows (`external_guid` NULL) never evicted |
| `pln_employee_vehicle` | copies active master rows into each snapshot; 1 vehicle per employee by `ROW_NUMBER() ORDER BY vehicle_guid` |
| `ta_employee` | MERGE on `external_guid` or adopt payroll-CSV row by `employee_number`; adopted rows keep payroll fields; inactive staff only update, never insert |

## Items the sheet flags for QA ("Confirm with QA")

1. Extracted but not loaded: route (Regular, SpecialEd, TrackedByGPS ...), component depot times, school (Capacity, SpecialEd ...), student (MedicalDetail, MetAtBus, LoadTime ...), staff (Position, License ...).
2. `pln_stop.stop_planned_time` always NULL.
3. Every student address is HOME.
4. Cell I205 (`pln_zone.zone_code` note) shows `#NAME?`: a broken cell in the sheet.

## Differences from `schema-and-etl-spec.md`

| Topic | ETL spec / earlier knowledge | Sheet |
|---|---|---|
| Active snapshot | One `is_active = 1` snapshot per date (DK 595-599, integrity check 3) | Do not select by `is_active` (ENG-2918) |
| `ta_employee_operator` | UNVERIFIED whether written | Written by StaffEntityLoader |
| `vin_number` | truncate 17 | truncate 25 |
| `vehicle_capacity` | NULL | `BPX_VehicleType.Size` |
| `pln_school_program` | every school offers every program (SC 1570) | real affinity only |
| Address types | Primary/Secondary/Daycare or HOME/DAYCARE/... | always HOME |
| Retire date | inclusive per DK | exclusive `[Effective, Retire)` (matches code) |
| Operator-change retire date | not stated | vehicle: yesterday; employee: today (inconsistent, ask) |
