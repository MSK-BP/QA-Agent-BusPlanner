# BusPlannerUnified - schema and ETL as specified (Word documents)

Built from the converted Word documents only (Read/Grep; nothing run). Companion to `data-services.md`, which reflects **code**. Where the two disagree see section 8; as a rule code wins.

Source abbreviations (all under `repos/BusPlannerUnified/_docx_text/`; numbers are `.txt` line numbers):
- **DK** = `specs/bus-planner-design-knowledge-v7.22.txt` (1,479 lines, read in full)
- **SC** = `specs/bus-planner-complete-schema-v7.22.txt` (8,366 lines, read in full)
- **ETL** = `etl/ETL-Technical-Specification_v2.txt` (2,582 lines, read in full). Still headed "Version: 1.0 Date: 2026-02-23 Status: Draft" (ETL 4); the only visibly newer content is the depot mapping (ETL 841-846, 884, 1210-1320).
- **QAV** = `etl/ETL-QA-Validation-v7.22.txt` (209 lines)
- **LT** = `etl/ETL-Load-Test-Setup-v7_18.txt` (593 lines; written for schema v7.18)
- **DS** = `knowledge/repos/BusPlannerUnified/data-services.md` (code-derived map)

Reading caveats (apply to everything below):
1. **SC's "Null" column is not trustworthy.** It mixes conventions: primary keys and `is_deleted` show "No", name columns show "Yes", description columns show "No", `retire_date` shows "Yes", and `etl_watermark` uses "NOT NULL" (SC 60-149, 7905-7928). Do not derive nullability assertions from it; use the DDL (`ETL/docs/bus-planner-schema-v7_21.sql` + migrations, per DS section 3). UNVERIFIED which reading is intended.
2. **SC rarely states foreign keys.** Only a few tables carry explicit `REFERENCES` rows (SC 514-515, 577-585, 698-699, 2529-2535) or "FK to" descriptions. Elsewhere the FK target below is inferred from the convention "FK column has the same name as the referenced PK" (DK 132-135). Inferred FKs are marked `~`; whether a DB constraint exists is UNVERIFIED.
3. SC lists columns but **no indexes or CHECK constraints** (one stray CHECK fragment at SC 929-937). Uniqueness and allowed values come from table descriptions, DK, or QAV.
4. The documents contradict each other on table counts: DK summary says 100 (DK 1019-1028), DK history says 110 (DK 1443), SC header says 122 across 12 domains with `pln_` = 30 (SC 2, 23-25), SC footer says "Total tables: 110 (v7.21)" (SC 8365). SC actually describes 34 `pln_` tables (my count, section 2).

---

## 1. Schema overview

Platform: Microsoft SQL Server; `UNIQUEIDENTIFIER` + `NEWSEQUENTIALID()`, `DATETIME2`, partitioning, filtered indexes, CHECK constraints, `GEOGRAPHY` (DK 99-108).

| Prefix | Area | Purpose | Tables in SC | Source |
|---|---|---|---|---|
| `opr_` | Operator | Transportation service providers (bus companies) sharing one system; global, not nested under customer | 1 | SC 56-59; DK 965-980, 1046-1047 |
| `veh_` | Vehicle | Fleet vehicles, their operator over time, master driver-to-vehicle assignment | 3 | SC 151-376 |
| `dev_` | Device | GPS/telemetry hardware and its dated assignment to vehicles and operators | 4 | SC 377-645 |
| `gps_` | GPS event | Provider connections and settings, latest position per device, partitioned history, GPS-to-stop match results | 5 | SC 646-1040 |
| `pln_` | Program and plan | Customer > district > school > program hierarchy, reference data (zones, bell times, students), and per-day snapshot plan (routes, components, runs, stops, student-stops) | 34 described (summary says 30) | SC 1042-3763 |
| `ins_` | Inspection | Versioned inspection templates, completed inspections, responses, defects, photos, signatures | 11 | SC 3765-4513 |
| `ta_` | Time and attendance | Employees, org structure, schedules, shifts, clock punches, approvals, pay periods, absences, trip credits, custom fields | 40 | SC 4515-7060 |
| `usr_` | User and authorization | Domain users, roles, permissions, entity scope, sessions, layouts, preferences | 14 | SC 7062-7824 |
| `svc_` | Service infrastructure | Dead-letter visibility for queue messages | 1 | SC 7826-7894 |
| `etl_` | ETL infrastructure | Per-customer, per-entity extract watermark | 1 | SC 7896-7928 |
| `AspNet*` | Identity | ASP.NET Core Identity tables (authentication, role/user permission claims); created by migration 01 | 7 | SC 7930-8030 |
| `chat_` | Chatbot | Conversations, messages, feedback, admin corrections, regression test cases; migrations 02-06 | 5 | SC 8031-8336 |

Reference vs snapshot split (DK 340-375): reference data is "outside snapshots" and stable; snapshot data carries `snapshot_guid` and is "imported fresh with each ETL". DK lists `pln_student_address` on **both** sides (DK 349 and 370-371); SC says it is reference data with no `snapshot_guid` (SC 2737); ETL maps a `snapshot_guid` for it (ETL 1766-1770). Trust SC and code (DS section 3).

---

## 2. Table catalogue

Legend: **SD** = has `is_deleted` (soft delete). **A4** = has all four audit columns `created_date/created_by/modified_date/modified_by`. **A2** = `created_*` only. **T** = temporal (`effective_date`, `retire_date`). **Snap** = has `snapshot_guid`. **Cust** = has `customer_guid` (tenant column). `~` = FK inferred by naming. Line = table start in SC.

### opr_, veh_, dev_, gps_

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `opr_operator` (58) | Operator definition | PK `operator_guid`; `external_guid`, `operator_code`, `operator_name`, contact fields, `is_protected`, `is_active` | SD, A4. No `customer_guid` (global). `external_guid` = BP Pro GUID (DK 244) |
| `veh_vehicle` (153) | Vehicle master | PK `vehicle_guid`; `external_guid`, `vehicle_name`, `vehicle_number`, `vehicle_capacity`, `vehicle_wheelchair`, `vehicle_type`, `license_plate`, `vin_number`, `year`, `make`, `model`, `depot_guid` -> `pln_depot`, `is_active` | SD, A4. No `customer_guid`. Depot rule: vehicle's current operator must equal depot operator or either is NULL; enforced in app/ETL, not DB (SC 223) |
| `veh_vehicle_operator` (256) | Vehicle-to-operator over time | `vehicle_guid`~, `operator_guid`~ | SD, A4, T. "Single operator at a time per vehicle" (SC 257) |
| `veh_employee_vehicle` (314) | Master driver-to-vehicle assignment (outside snapshots) | `employee_guid`~ `ta_employee`, `vehicle_guid`~, `external_guid` (BPL_VehicleStaff GUID; NULL for admin-UI rows) | SD, A4, T. One active driver per vehicle and one current vehicle per employee (DK 1209, 1214). Unique filtered index on `external_guid` (SC 8340) |
| `dev_device_type` (379) | Device type lookup | PK `device_type_guid`; `device_type_name` | SD, A4 |
| `dev_device` (427) | Tracker instance | PK `device_guid`; `connection_guid`~ `gps_provider_connection`, `device_type_guid` -> `dev_device_type`, `device_serial_number`, IMEI/phone/SIM, `firmware_version`, `device_id` (provider's id), `vehicle_name`, `is_active` | SD, A4. `device_id` + `vehicle_name` written by GPS reader device sync (QAV 71-75) |
| `dev_vehicle_device` (520) | Device-to-vehicle over time | `vehicle_guid` -> `veh_vehicle`, `device_guid` -> `dev_device` | SD, A4, T. Used to attribute a GPS event to the vehicle at event time (DK 294-298, 1139) |
| `dev_device_operator` (588) | Device-to-operator over time | `device_guid`~, `operator_guid`~ | SD, A4, T. Single operator at a time |
| `gps_provider_connection` (648) | One vendor connection | PK `connection_guid`; `name`, `provider` | **No SD, no audit columns** listed |
| `gps_connection_settings` (671) | Name/value settings per connection | PK `setting_guid`; `connection_guid` -> `gps_provider_connection`; `name`, `value` | No SD, no audit. Holds vendor credentials per DS section 3: never dump values |
| `gps_event_current` (704) | Latest event per device | PK `event_guid`; `device_guid`, `vehicle_guid`, `event_timestamp`, `received_timestamp`, lat/long, `speed_mph`, `heading`, `ignition_on`, `odometer_miles`, `engine_hours`, `raw_payload`, `door_open`, `stop_arm_open`, `amber_lights_on` | No SD; `created_date` only. Exactly one row per device (DK 304-309, 1144-1145) |
| `gps_event_history` (812) | All events, monthly partitions | Composite PK (`event_guid`, `event_timestamp`); same telemetry columns plus `reverse_geocode_address`, `classification_type`, `classified_timestamp` | No SD; `created_date` only. Partition key = `event_timestamp` (device time, UTC), never server time (DK 1134-1136) |
| `gps_stop_visited` (939) | GPS event matched to a planned stop | PK `gps_stop_visited_guid`; `snapshot_guid` -> `pln_snapshot`, `stop_guid` -> `pln_stop`, `event_guid`, `event_timestamp`, `classification_type`, `classification_rank`, actual lat/long/timestamp, `speed_kmh`, `distance_meters`, `door_open`, `stop_arm_open` | SD, A4, Snap. "Unique on stop_guid where not deleted" (SC 940). Replaces removed `pln_stop_event` |

### pln_ reference data

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `pln_customer` (1044) | Tenant; one customer = one BP Pro DB connection | PK `customer_guid`; `customer_name`, `customer_code`, `time_zone`, `is_active` | SD, A4. Multi-tenancy boundary (DK 380-384). No BP Pro source (ETL 2205-2207) |
| `pln_school_year` (1107) | School year per customer; own BP Pro DB | `customer_guid`~; `year_name`, `start_date`, `retire_date`, `bp_pro_database_name`, `is_active` | SD, A4, Cust. Note `start_date`/`retire_date`, not `effective_date` |
| `pln_depot` (1175) | Depot/garage reference | `customer_guid` -> `pln_customer`, `operator_guid` -> `opr_operator` (nullable), `external_guid`, `depot_code`, `depot_name`, `depot_type`, lat/long, `capacity`, six facility flags, `is_active` | SD, A4, Cust. Docs say ETL population not implemented (SC 1176); code loads it (section 8) |
| `pln_district` (1302) | District under a customer | `customer_guid`~; `external_guid`, `external_id`, `district_name`, `district_code`, `is_active` | SD, A4, Cust |
| `pln_school` (1375) | School under a district | `district_guid`~; `external_guid`, `external_id`, `school_name`, `school_code`, `address`, lat/long, `is_active` | SD, A4. **No `customer_guid`**: tenant reached via district |
| `pln_area` (1458) | Customer-defined grouping of schools | `customer_guid`~; `area_name`, `area_code` | SD, A4, Cust |
| `pln_school_area` (1521) | School-to-area many-to-many | `school_guid`~, `area_guid`~ | SD, A4. SC shows **no** effective/retire dates although DK says temporal (DK 753-754) |
| `pln_program` (1569) | Program, universal per customer | `customer_guid`~; `external_guid`, `external_id`, `program_name`, `program_code`, `is_active` | SD, A4, Cust. "Every school offers every program" (SC 1570) |
| `pln_school_program` (1642) | School-to-program bridge | `school_guid` -> `pln_school`, `program_guid` -> `pln_program` | SD, A2. Populated by ETL after programs and schools (SC 1643) |
| `pln_grade` (1680) | Grade definitions from BPX_Grade | `customer_guid` -> `pln_customer`; `external_guid`, `grade_code`, `sort_order`, `met_at_bus`, `is_active` | SD, A4, Cust |
| `pln_on_time_category` (1753) | Customer-defined early/on-time/late labels | `customer_guid`~; `window_type`, `category_name`, `category_code`, `display_color`, `is_favorable`, `sort_order` | SD, A4, Cust |
| `pln_program_bell_time` (1836) | Bell time per program | `program_guid`~; `external_guid`, `bell_type`, `bell_time` (TIME), `applies_monday..friday` | SD, A4, T. No weekend flags in SC |
| `pln_arrival_window` (1929) | Arrival thresholds per bell time | `program_bell_time_guid`~, `on_time_category_guid`~; `minutes_before_bell_min`, `minutes_before_bell_max` | SD, A4. NULL min/max = no limit (SC 1930) |
| `pln_departure_window` (1987) | Departure thresholds per bell time | `program_bell_time_guid`~, `on_time_category_guid`~; `minutes_after_bell_min`, `minutes_after_bell_max` | SD, A4 |
| `pln_address_type` (2045) | Address type lookup | `external_guid`, `type_name`, `type_code`, `is_active` | SD, A4. No `customer_guid` in SC |
| `pln_student` (2648) | Student identity only | PK `student_guid`; `external_guid`, `external_id`, `student_id`, names, `date_of_birth`, `gender`, `grade`, `is_active` | SD, A4. **No `customer_guid`, `school_guid` or `program_guid`** by design (DK 609-610, 631-636). Personal data |
| `pln_student_address` (2736) | Student addresses | `student_guid`~ (listed twice in SC 2748-2757, conversion oddity), `address_type_guid`~; `external_id`, address lines, city, state, postal code, lat/long, `is_active` | SD, A4. No `snapshot_guid` (SC 2737). Personal data |
| `pln_student_card_assignment` (2834) | Rider card to student over time | `student_guid`~; `card_number`, `card_type` | SD, A4, T. One active student per card; a student may hold several cards (SC 2835) |
| `pln_zone_type` (3156) | Customer-defined zone type | `customer_guid`~; `external_guid`, `external_id`, `type_name`, `type_code`, `speed_limit_mph`, `requires_real_time_check`, `alert_on_entry`, `alert_on_exit` | SD, A4, Cust |
| `pln_zone` (3043) | Zone polygon | `zone_type_guid`~, `customer_guid`~; `external_guid`, `external_id`, `zone_name`, `zone_code`, `zone_geometry` (GEOGRAPHY), four `bounding_box_*`, `area_sq_miles` | SD, A4, Cust. Zone change = soft-delete old + insert new (DK 705-710). Expected 400-500 per customer (SC 3044) |
| `pln_school_zone` (3259) | User-managed school-to-zone link | `school_guid`~, `zone_guid`~; `external_guid`, `relationship_type` | SD, A4, T. School point may lie outside the polygon (SC 3260) |
| `pln_stop_zone` (3332) | Pre-computed stop-in-zone | `stop_guid`~, `zone_guid`~ | SD, A4, T. Must be recomputed when zones or stops change (DK 716) |
| `pln_substitution_reason` (3649) | Reason lookup | `reason_code`, `reason_name`, `is_active` | SD, A4. No `customer_guid` in SC although DK calls it customer-defined (DK 813) |
| `pln_user_student` (3478) | Parent/guardian to student | `user_guid`~ `usr_user`, `student_guid`~; `relationship_type` | SD, A4, T |
| `pln_user_student_stop` (3541) | Parent stop-alert configuration | `user_student_guid`~, `user_guid`~, `student_guid`~, `zone_guid`~, `stop_guid`~; seven `applies_*` day flags | SD, A4, T. `user_guid`/`student_guid` are denormalized copies and must equal the parent `pln_user_student` row (DK 944-956) |

### pln_ snapshot data

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `pln_snapshot` (3707) | One plan snapshot | PK `snapshot_guid`; `snapshot_id` INT IDENTITY; `customer_guid`~, `school_year_guid`~; `snapshot_date`, `source_system`, `is_active` | **No `is_deleted`, no `modified_*`.** Cust. At most one active snapshot per date (DK 595-599) |
| `pln_route` (2540) | Route in a snapshot | `snapshot_guid`~; `external_id`, `vehicle_guid`~ (nullable), `operator_guid`~ (nullable), `route_name`, `route_number`, `route_sequence`, substitution columns incl. `original_route_guid`, `is_active` | SD, A4, Snap. Substitution flag 0/1/2 (SC 2541) |
| `pln_component` (2108) | Time-of-day segment of a route | `snapshot_guid`~, `route_guid`~; `external_id`, `component_name`, `component_type`, `component_sequence`, start/end TIME | SD, A4, Snap |
| `pln_run` (2191) | One trip | `snapshot_guid`~, `route_guid`~, `component_guid`~; `external_id`, `run_name`, `run_sequence`, `run_type`, `run_direction`, `run_start_time`/`run_end_time` (TIME in SC), substitution columns incl. `original_run_guid`, `run_description`, `path` (geography), `lock_flag` | SD, A4, Snap. `lock_flag` in {0,1,2,3}, CHECK expected (SC 2321; QAV 46-49) |
| `pln_stop` (2324) | Stop on a run | `snapshot_guid`~, `run_guid`~; `external_id`, `stop_sequence`, `stop_type`, `stop_name`, lat/long, `projection_x/y`, `stop_scheduled_time`/`stop_planned_time` (TIME in SC), `geofence_radius_feet`, substitution columns incl. `original_stop_guid`, `is_right_side`, `is_manual` | SD, A4, Snap |
| `pln_student_stop` (2950) | Central student assignment | `snapshot_guid`~, `stop_guid`~, `student_guid`~, `program_guid`~, `school_guid`~, `student_address_guid`~; `is_primary_program`, `external_guid`, `customer_guid`, `student_code`, `is_active` | SD, A4, Snap, Cust (nullable per SC 3027-3030). `external_guid` unique within a snapshot (QAV 41-44) |
| `pln_student_snapshot` (2897) | Student per snapshot with address, grade, school | `snapshot_guid` -> `pln_snapshot`, `student_guid` -> `pln_student`, `student_address_guid` -> `pln_student_address`, `grade_guid` -> `pln_grade`, `school_guid` -> `pln_school` | SD, A2, Snap. "Each student appears once per snapshot" (SC 2898) |
| `pln_employee_vehicle` (2477) | Driver-to-vehicle for the snapshot day | `snapshot_guid` -> `pln_snapshot`, `employee_guid`~ `ta_employee` (deferred FK, DK 1016-1017), `vehicle_guid` -> `veh_vehicle` | SD, A4, Snap. One employee per vehicle per snapshot day (SC 2478) |
| `pln_ridership_scan` (3390) | Board/exit card scans | `card_number` (not an FK, by design), `snapshot_guid`~, `run_guid`~ (nullable), `stop_guid`~ (nullable), `vehicle_guid`~; `scan_timestamp`, `scan_type`, `scan_type_source`, lat/long | SD, A4, Snap. Unmatched scans keep NULL run/stop (DK 782-783) |

### ins_

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `ins_inspection_type` (3767) | Pre-trip, post-trip, annual | `type_name`, `type_code` | SD, A4 |
| `ins_template` (3820) | Versioned form | `inspection_type_guid`~; `template_name`, `version_number` | SD, A4, T. A past inspection must keep pointing at the version used (DK 840-846) |
| `ins_category` (3888) | Item grouping | `template_guid`~; `category_name`, `category_sequence` | SD, A4 |
| `ins_item` (3941) | Checklist item | `category_guid`~; `item_name`, `item_sequence`, `is_required`, `response_type`, `version_number` | SD, A4 |
| `ins_inspection` (4014) | Completed inspection | `template_guid`~, `vehicle_guid`~, `inspector_user_guid`; date, time, start/end timestamp, start/end lat/long, odometer, `overall_status` | SD, A4. DK says it references employees (DK 1003); SC column is a user GUID |
| `ins_response` (4127) | Answer to an item | `inspection_guid`~, `item_guid`~; `response_value`, `response_status`, `response_timestamp` | SD, A4 |
| `ins_defect` (4195) | Defect from a failed response | `response_guid`~; `defect_description`, `defect_severity`, `reported_timestamp`, `resolved_timestamp`, `resolved_by` | SD, A4 |
| `ins_photo` (4268) | Photo on inspection, response or defect | `inspection_guid`, `response_guid`, `defect_guid` (all optional); filename, path, timestamp, lat/long | SD, A2 |
| `ins_signature` (4336) | Signature | `inspection_guid`~; `signer_name`, `signer_role`, image path, timestamp, lat/long | SD, A2 |
| `ins_template_operator` (4399) | Template-to-operator over time | `template_guid`~, `operator_guid`~ | SD, A4, T. Single operator at a time |
| `ins_vehicle_template` (4457) | Template-to-vehicle over time | `template_guid`~, `vehicle_guid`~ | SD, A4, T |

### ta_

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `ta_timescan_device` (4517) | Time clock | `customer_guid`~, `location_guid`~ (nullable); `device_name`, `device_serial`, `is_active` | SD, A4, Cust |
| `ta_location` (4580) | Work location with geofence | `customer_guid`~; `location_name`, `location_code`, lat/long, `geofence_radius_feet`, `is_active` | SD, A4, Cust |
| `ta_employee` (4658) | Employee | `customer_guid`~; `employee_number`, names, `email`, `phone`, `hire_date`, `termination_date`, `is_active`, `external_guid` (BPX_Staff GUID; NULL for payroll-CSV rows) | SD, A4, Cust. Unique filtered index (`customer_guid`, `external_guid`) (SC 8340). ETL never deletes employees (DK 1215). Personal data |
| `ta_department` (4751) | Department tree | `customer_guid`~, `parent_department_guid` (self); `department_name`, `department_code`, `is_active` | SD, A4, Cust |
| `ta_position` (4814) | Position | `customer_guid`~; `position_name`, `position_code`, `is_active` | SD, A4, Cust |
| `ta_job_code` (4877) | Job code | `customer_guid`~; `job_code`, `job_title`, `hourly_rate`, `external_paycode`, `is_active` | SD, A4, Cust. Identity fields locked once referenced (DK 1418-1423) |
| `ta_shift_template` (4950) | Default shift times | `customer_guid`~; `template_name`, scheduled start/end TIME, break minutes | SD, A4, Cust |
| `ta_schedule` (5013) | Scheduled work for a date | `employee_guid`~, `shift_template_guid`~, `location_guid`~; `schedule_date`, start/end TIME | SD, A4 |
| `ta_shift` (5091) | Worked shift, three time tiers | `employee_guid`~, `pay_period_guid`~, `location_guid`~, `job_code_guid`~; `shift_date`, `actual_*`, `edited_*`, `payable_*` start/end TIME, `approval_status` | SD, A4. Hours and overtime are computed at query time, not stored (SC 5092) |
| `ta_timescan_transaction` (5194) | Raw clock punch | `employee_guid`~, `timescan_device_guid`~, `vehicle_guid`~; `transaction_timestamp`, `transaction_type`, lat/long, `is_manual_entry` | SD, A4 |
| `ta_shift_transaction` (5272) | Shift-to-punch link | `shift_guid`~, `transaction_guid`~ | SD, A2 |
| `ta_timescan_audit` (5310) | Punch change audit | `transaction_guid`~; `field_name`, `old_value`, `new_value`, `change_reason`, `changed_date`, `changed_by` | **No SD**; append-only |
| `ta_time_adjustment` (5358) | Adjustment request on a shift | `shift_guid`~, `new_job_code_guid`; `adjustment_type`, `adjustment_minutes`, `reason`, `status`, `requested_by`, `approved_by`, `approved_date` | SD, A4 |
| `ta_rounding_rule` (5441) | Payable time rule | `customer_guid`~; `rule_name`, `round_to_minutes`, `round_type` | SD, A4, Cust |
| `ta_pay_period` (5499) | Pay period | `customer_guid`~; `start_date`, `end_date`, `status`, `exported_date`, `exported_by` | SD, A4, Cust. No `department_guid` (moved to junction, DK 1232) |
| `ta_settings` (5567) | T&A name/value config | `customer_guid`~; `setting_name`, `setting_value` | SD, A4, Cust |
| `ta_absence_type` (5625) | Absence type | `customer_guid`~; `type_name`, `type_code`, `is_paid` | SD, A4, Cust |
| `ta_absence` (5683) | Absence record | `employee_guid`~, `absence_type_guid`~; `absence_date`, `hours`, `status`, `approved_by`, `approved_date` | SD, A4 |
| `ta_employee_badge` (5761) | Badge over time | `customer_guid`~, `employee_guid`~; `badge_number`, `badge_type` | SD, A4, T, Cust |
| `ta_employee_position` (5829) | Employee-to-position over time | `employee_guid`~, `position_guid`~, `supervisor_employee_guid`; `is_primary` | SD, A4, T. Several concurrent positions allowed, one primary (SC 5830) |
| `ta_employee_department` (5897) | Employee-to-department over time | `employee_guid`~, `department_guid`~ | SD, A4, T. Exactly one active department per employee (DK 1425) |
| `ta_employee_location` (5955) | Valid clock-in locations | `employee_guid`~, `location_guid`~ | SD, A4, T |
| `ta_employee_operator` (6013) | Employee-to-operator over time | `employee_guid`~, `operator_guid`~ | SD, A4, T. Single operator at a time |
| `ta_employee_fte` (6071) | FTE over time | `employee_guid`~; `fte_value` DECIMAL(5,4), `daily_hours` | SD, A4, T. One active FTE per employee; CHECK 0.0001-2.0000 (DK 522-524) |
| `ta_approval_step` (6134) | Configurable approval step | `customer_guid`~; `step_order`, `approver_type`, `permission_name`, `step_name`, `is_active` | SD, A4, Cust |
| `ta_shift_approval` (6202) | Approval of a shift at a step | `shift_guid`~, `approval_step_guid`~; `is_approved`, `approved_by_user_guid`, `approved_date` | **No SD**; `created_date` only |
| `ta_approval_history` (6245) | Approval transition log | `entity_type`, `entity_guid` (polymorphic, no FK); `previous_status`, `new_status`, `action_by`, `action_date` | **No SD**, no audit columns |
| `ta_holiday` (6293) | Holiday | `customer_guid`~; `holiday_name`, `holiday_date`, `is_paid` | SD, A4, Cust |
| `ta_position_holiday` (6351) | Position-to-holiday | `position_guid`~, `holiday_guid`~ | SD, A4 |
| `ta_position_job_code` (6399) | Position-to-job-code | `position_guid`~, `job_code_guid`~ | SD, A4 |
| `ta_timescan_device_operator` (6447), `ta_location_operator` (6505), `ta_position_operator` (6563), `ta_department_operator` (6621), `ta_pay_period_operator` (6679) | Entity-to-operator over time (five tables, same shape) | entity GUID~, `operator_guid`~ | SD, A4, T. Single operator at a time per entity |
| `ta_trip_credit` (6737) | Credited hours without start/end | `employee_guid`~, `job_code_guid`~; `credit_date`, `credited_hours`, `source_type` | SD, A4. No status column and no department FK by design (DK 1224, 1228) |
| `ta_trip_credit_approval` (6805) | Approval of a trip credit at a step | `trip_credit_guid`~, `approval_step_guid`~ (deferred FK, DK 1444); `status`, `approved_by_guid`, `approved_date` | SD, A4 |
| `ta_department_pay_period` (6873) | Department-to-pay-period over time | `department_guid`~, `pay_period_guid`~ | SD, A4, T. One active per department (DK 1236) |
| `ta_employee_field_definition` (6931) | Custom employee field definition | `customer_guid`~; `field_name`, `field_key`, `field_type`, `list_options` (JSON), `is_required`, `display_order`, `is_active` | SD, A4, Cust. Unique (`customer_guid`, `field_key`) where not deleted (DK 1313) |
| `ta_employee_field_value` (7009) | Custom field value | `employee_guid`~, `field_definition_guid`~; `field_value` NVARCHAR(MAX) | SD, A4. Unique (`employee_guid`, `field_definition_guid`) where not deleted; type validated in app only (DK 1315-1316) |

### usr_, svc_, etl_, AspNet, chat_

| Table (SC line) | Purpose | Key columns and FKs | Testing notes |
|---|---|---|---|
| `usr_permission` (7064) | Permission | `permission_name`, `permission_code`, `permission_type`, `entity_type` | SD, A4 |
| `usr_role` (7127) | Role | `role_name`, `is_system_role` | SD, A4. System roles cannot be deleted (SC 7128) |
| `usr_role_group` (7180), `usr_role_group_member` (7228) | Role grouping | `role_group_guid`~, `role_guid`~ | SD; member table A2. Groups do not affect permissions (DK 905-906) |
| `usr_role_permission` (7266) | Role-to-permission | `role_guid`~, `permission_guid`~ | SD, A2 |
| `usr_user` (7304) | Domain user | `username`, `email`, `password_hash`, names, `employee_guid`~ `ta_employee` (nullable), `is_active`, `last_login_date` | SD, A4. Not auto-synced with `AspNetUsers` (DK 1466). Never dump `password_hash` |
| `usr_user_role` (7387) | User-to-role over time | `user_guid`~, `role_guid`~ | SD, A4, T |
| `usr_user_operator` (7445) | User-to-operator over time | `user_guid`~, `operator_guid`~ | SD, A4, T. Single operator at a time |
| `usr_user_program` (7503) | Program-level access over time | `user_guid`~, `program_guid`~ | SD, A4, T |
| `usr_user_entity_scope` (7561) | Data scope over time | `user_guid`~; `entity_type`, `entity_guid` (polymorphic) | SD, A4, T |
| `usr_session` (7624) | Session | `user_guid`~; `session_token`, `created_date`, `expires_date`, `ip_address`, `user_agent`, `is_active` | **No SD**. Never dump tokens |
| `usr_workspace_layout` (7672) | Saved dashboard layout | `user_guid`~; `layout_json` | SD, A4. One non-deleted row per user (DK 1291) |
| `usr_default_layout` (7720) | Default layout per role | `role_name`, `layout_json` | SD, A4 |
| `usr_user_preference` (7768) | Per-user preference | `user_guid`~; `preference_category`, `preference_key`, `preference_json` | SD, A4. Unique (`user_guid`, category, key) where not deleted; CHECK on category (DK 1335, 1377) |
| `svc_queue_dead_letter` (7828) | Failed queue messages | `database_target`, `queue_name`, `message_payload`, `error_message`, `error_timestamp`, `retry_count`, `source_service`, `correlation_id` | SD, A2 |
| `etl_watermark` (7898) | Last successful extract per customer and entity | PK `watermark_id` INT IDENTITY; `customer_guid`, `entity_name`, `last_extract_at`, `updated_date` | No SD. Unique (`customer_guid`, `entity_name`) (SC 7899) |
| `AspNetUsers` (7932) | Login accounts | `Id`; extended with `FirstName`, `LastName`, `CreatedAt`; standard Identity columns | Framework-managed. `PasswordHash` never exposed via GraphQL (SC 7987) |
| `AspNetRoles`, `AspNetUserRoles`, `AspNetRoleClaims`, `AspNetUserClaims`, `AspNetUserLogins`, `AspNetUserTokens` (8029-8030) | Roles, membership, permission claims, external logins, tokens | Standard Identity columns | `AspNetRoleClaims` is "the main permission store" |
| `chat_conversation` (8033) | Conversation | `user_guid`, `customer_guid` (nullable), `title` | SD, A4, Cust |
| `chat_message` (8085) | Message | `conversation_guid` -> `chat_conversation`; `role`, `content`, `generated_sql`, `generated_graphql`, `query_result_json`, `tokens_used`, `duration_ms`, `map_data_json`, `tool_attempts_json` | No SD; `created_date`/`modified_date` only |
| `chat_feedback` (8157) | Rating on a message | `message_guid` -> `chat_message`, `user_guid`; `rating`, `comment` | No SD. Unique per (message, user) (SC 8158) |
| `chat_correction` (8199) | Admin guidance fed into the prompt | `message_guid` -> `chat_message` (optional); `correction_text`, `category`, `is_active`, `created_by_user_guid` | No SD; A4 |
| `chat_test_case` (8256) | Regression case | `name`, `prompt_text`, `expected_keywords`, `forbidden_keywords`, `is_active`, `last_run_status`, `last_run_response`, `last_run_at` | No SD; A4 |

Tables named in DK but **absent from SC** (do not write tests against them without checking the DDL): `dev_hardware_provider` (DK 277, 1078, 1119-1126; replaced in v7.17 per DK 1448), `pln_stop_event` (DK 369, 1084; removed, DK 1469), `usr_notification` (DK 1093, 1167), `ta_time_scan` / `ta_time_scan_audit` / `ta_absence_audit` / `ta_holiday_taken` / `ta_holiday_taken_audit` (DK 532-541), `ta_employee_payroll`, `ta_employee_schedule` (DK 517-518), and a `ta_employee.operator_guid` column (DK 993; SC has the `ta_employee_operator` junction instead, SC 6013).

---

## 3. Entity relationships in the planning chain

Organisation (DK 376-400; SC 1044-1640):
- `pln_customer` 1 - N `pln_district` (via `pln_district.customer_guid`).
- `pln_district` 1 - N `pln_school` (via `pln_school.district_guid`). A school has no direct customer column.
- `pln_customer` 1 - N `pln_program` (via `pln_program.customer_guid`). Programs are not per school; `pln_school_program` links every school to every program of the customer (SC 1570, 1643). DK's older wording "Customer > District > School > Program" (DK 379) and the derivation chain "Program > School > District > Customer" (DK 634) predate this.
- `pln_customer` 1 - N `pln_school_year`; each school year has its own BP Pro database (SC 1108).

Plan for a day (DK 329-339, 577-599):
- `pln_snapshot` belongs to one customer and one school year and one `snapshot_date`.
- `pln_snapshot` 1 - N `pln_route`. A route optionally names one `veh_vehicle` and one `opr_operator` (both nullable, SC 2562-2569).
- `pln_route` 1 - N `pln_component` (`component_sequence`).
- `pln_component` 1 - N `pln_run`; `pln_run` also carries `route_guid` directly (denormalized; must equal its component's route). SC has no "run version" table: BP Pro's `BP_RunV` / `BPX_ComponentV` versions are flattened into `pln_run` / `pln_component` at extract (ETL 441-470, 1988-2013).
- `pln_run` 1 - N `pln_stop` (`stop_sequence`).
- Every one of route, component, run, stop repeats `snapshot_guid`; a child's `snapshot_guid` must equal its parent's.
- Route, run and stop each have a self-reference `original_*_guid` for substitutions (section 4).

Students (DK 600-636; SC 2648-3041):
- `pln_student` 1 - N `pln_student_address` (typed by `pln_address_type`).
- `pln_student_stop` is the central link: one row = (snapshot, stop, student, program, school, student address). `school_guid` is a stored copy "derived from program" (DK 626-627); `is_primary_program` is enforced in the business layer (DK 629-630).
- A student's school, program and customer are **derived** through `pln_student_stop`, never stored on `pln_student` (DK 609-610, 631-636). A student with no assignment has no derivable customer.
- `pln_student_snapshot`: one row per student per snapshot with address, grade and school (SC 2898).
- `pln_student_card_assignment` (dated) links cards to students; `pln_ridership_scan` stores the card number as text and optionally a run and stop.

Vehicles, employees, GPS (DK 265-327, 1195-1215):
- `veh_vehicle` N - 1 `pln_depot` (`depot_guid`); `veh_vehicle` - `opr_operator` through dated `veh_vehicle_operator`.
- `veh_employee_vehicle` (dated master) says which employee normally drives which vehicle; the ETL copies active rows into `pln_employee_vehicle` for each snapshot (LT 17-25, 515-517).
- Report-time chain for labour allocation: Driver -> `veh_employee_vehicle` -> `pln_employee_vehicle` -> component -> runs -> stops -> schools; derived, never stored (DK 1201-1204).
- `dev_device` - `veh_vehicle` through dated `dev_vehicle_device`; `gps_event_history.device_guid` -> device; `vehicle_guid` on the event is resolved at ingest from the mapping valid at event time (DK 1139).
- `gps_stop_visited` joins a GPS event to a `pln_stop` within a `pln_snapshot` (SC 939-965).
- `usr_user.employee_guid` optionally links a login user to a `ta_employee` (DK 410-412).

---

## 4. Design decisions and invariants (testable sentences)

IDs and naming
1. Every domain table's primary key is a `UNIQUEIDENTIFIER` named `{entity}_guid` defaulting to `NEWSEQUENTIALID()` (DK 127-131). Exceptions in SC: `pln_snapshot.snapshot_id` and `etl_watermark.watermark_id` are INT IDENTITY (SC 3719-3720, 7905-7906); `gps_event_history` has composite PK (`event_guid`, `event_timestamp`) (SC 813).
2. A foreign-key column has the same name as the primary key it references (DK 132-135).
3. Boolean columns start with `is_` (also `has_`, `applies_`, `alert_on_` in practice) (DK 136-142).

Soft delete and audit
4. Deleting a record sets `is_deleted = 1`; the row stays (DK 168-176). DK claims "every table" has it; SC shows these without it: `pln_snapshot`, `gps_event_current`, `gps_event_history`, `gps_provider_connection`, `gps_connection_settings`, `ta_timescan_audit`, `ta_shift_approval`, `ta_approval_history`, `usr_session`, `etl_watermark`, `chat_message`, `chat_feedback`, `chat_correction`, `chat_test_case`, and the AspNet tables (section 2).
5. Every application query must filter `is_deleted = 0` (DK 176).
6. `created_date` is set to `SYSUTCDATETIME()` automatically; `created_by` / `modified_by` hold a username or system name (DK 153-166).
7. T&A transaction tables may never be hard-deleted; a delete creates an audit record (DK 544-545).

Time
8. Every `DATETIME2` column holds UTC; `TIME` columns hold local time of day (DK 93-98). Known code exception: plan run/stop times (section 8).
9. `gps_event_history.event_timestamp` is the device time and decides the partition; `received_timestamp` is the adapter receive time (DK 1134-1136).

Effective dating
10. A dated association is active on date D when `effective_date <= D` and (`retire_date` IS NULL or `D <= retire_date`) - retire date **inclusive** in DK (DK 190-196). Code treats retire date as exclusive (section 8).
11. For single-current associations at most one row per entity has `retire_date IS NULL AND is_deleted = 0` (unique filtered index) (DK 202-209). Applies to the `*_operator` tables, `ta_employee_department`, `ta_employee_fte`, `ta_department_pay_period`, `veh_employee_vehicle` (DK 522, 1209, 1236, 1425).
12. Weekday flags default to 1 for Monday-Friday and 0 for Saturday and Sunday (DK 221-231).

Snapshots
13. A snapshot is an immutable point-in-time copy of the plan for one `snapshot_date` (DK 578-581).
14. For a customer and date, `snapshot_date = D AND is_active = 1` returns exactly one snapshot (DK 595-599).
15. Loading a new snapshot for a date deactivates the previous one for that date, then activates the new one (DK 588-593).

Substitutions
16. `substitution_flag` is 0 (original), 1 (substituted out) or 2 (the replacement); the effective plan is rows with flag IN (0, 2); the original plan is flag = 0 (DK 799-825).
17. A replacement row (flag 2) points at the row it replaces through `original_route_guid` / `original_run_guid` / `original_stop_guid` (DK 809).
18. `substitution_source` is 1 (Dispatch) or 2 (API) (DK 807-808).

External identity
19. `external_guid` holds the BP Pro GUID and is the MERGE key; uniqueness is scoped to the parent (for example `customer_guid`, `external_guid`) (DK 235-242).
20. A source row that disappears is soft-deleted by the MERGE (`WHEN NOT MATCHED BY SOURCE THEN UPDATE SET is_deleted = 1`) (DK 260-264).
21. `ta_employee` rows created by payroll CSV and `veh_employee_vehicle` rows created in the admin UI keep `external_guid` NULL and are never evicted or deleted by the ETL (DK 250-251, 1214-1215).
22. BP Pro staff match an existing employee by `StaffID = employee_number` and adopt it without overwriting payroll-owned fields (DK 1213).
23. When BP Pro driver-vehicle links collide with the one-current rules, the most recent (ModifyDate/CreateDate) wins (DK 1214).

GPS
24. `gps_event_current` holds exactly one row per device; every event is also inserted into `gps_event_history` (DK 316-320, 1141-1145).
25. A zone change is a soft delete of the old zone plus a new zone row (DK 705-710).
26. A ridership scan keeps its `card_number` text even if the card is later reassigned (DK 785-789).

Authorization
27. Effective permissions are the union over all assigned roles; there is no deny (DK 892-897).
28. An action is allowed only if the permission exists AND the scope check passes (DK 908-914).
29. Permission strings such as `ta:employee:read` are issued as JWT `permission` claims, merged from role claims and direct user claims, with `customer_access` and `department_access` scope claims (DK 1464).
30. The Admin role is re-seeded at startup with every permission, so a new gate never locks Admin out (DK 1465).
31. `AspNet*` and `usr_*` are separate stores and are not synchronized (DK 1466).

Time and attendance
32. Original clock times are immutable and stored to the second; supervisor edits are minute precision; payable (formerly "rounded") values are always populated (DK 425-433, 1446).
33. Editing with rounding sets payable = round(edited); editing without rounding copies edited to payable; a later batch re-round normalizes it (DK 445-462, 472-479). Worked example: punch 05:32:45 with 5-minute rule -> 05:35:00; edit to 05:28 with rounding -> 05:30:00; without rounding -> 05:28:00; batch re-round -> 05:30:00 (DK 481-511).
34. FTE = daily hours / 8 and must lie in 0.0001-2.0000 (DK 521-524).
35. A job code referenced by time records has `job_code`, `job_title`, `job_description`, `hourly_rate`, `external_paycode` locked; only `is_active` and position links stay editable (DK 1418-1423).
36. A shift is PENDING until the last active approval step is approved, then APPROVED; rejecting voids prior approvals; editing an approved shift's times resets it to PENDING and voids approvals; every transition is written to `ta_approval_history`; nothing changes once the pay period is EXPORTED (DK 1474-1475).
37. Pay period status moves OPEN -> CLOSED -> EXPORTED; export selectors offer only Open and Closed periods; a successful export sets EXPORTED (DK 567-570, 1398, 1402).
38. Payroll export uses `ta_job_code.external_paycode`, falling back to `job_code` when NULL (DK 1404).
39. Semi-monthly auto-generated pay periods start on the 1st and 16th; names are "[CycleType] - [StartDate] to [EndDate]" (DK 1385).
40. Each employee has exactly one active department (DK 1425).

Migrations
41. Schema changes after the v7.21 baseline come only from numbered, idempotent SQL pairs tracked in `BPMigrationHistory`; there are no EF Core migrations (DK 1457-1459).
42. The depot/vehicle operator-match rule is not a DB constraint (DK 1478).

---

## 5. Enumerations and code tables (as documented)

| Column | Documented values | Source | Caveat |
|---|---|---|---|
| `pln_run.run_type` | TO_SCHOOL, FROM_SCHOOL, SHUTTLE, FIELD_TRIP, OTHER | SC 2192; ETL 1961-1980 | Code uses a different vocabulary (section 8) |
| `pln_stop.stop_type` | STANDARD, HOME, SCHOOL, GARAGE, WAYPOINT | SC 2325; DK 1072 | Code uses nine other values (section 8) |
| `pln_run.lock_flag` | 0 unlocked, 1 START_LOCKED, 2 END_LOCKED, 3 both | SC 2321; DK 1471 | |
| `substitution_flag` (route, run, stop) | 0 original, 1 substituted out, 2 substitution | DK 799-803 | |
| `substitution_source` | 1 Dispatch, 2 API | DK 807-808 | |
| `pln_substitution_reason.reason_code` (examples) | DRIVER_ABSENT, VEHICLE_BREAKDOWN, WEATHER, EMERGENCY; extensible | DK 813-818 | |
| `pln_program_bell_time.bell_type` | ARRIVAL, DISMISSAL | DK 645 | Code has moved to `pln_bell_time*` tables (section 8) |
| `pln_on_time_category` (examples) | EARLY, ON_TIME, LATE; `window_type` ARRIVAL / DEPARTURE | DK 651-655; SC 1754 | Customer-defined |
| Address types (examples) | HOME, DAYCARE, GUARDIAN, WORK (DK); Primary, Secondary, Daycare (SC) | DK 613-619; SC 2046 | User-defined; documents differ |
| `pln_ridership_scan.scan_type` | BOARD, EXIT | DK 777 | |
| `pln_ridership_scan.scan_type_source` | DEVICE, INFERRED | DK 778, 1186 | |
| `pln_user_student.relationship_type` | PARENT, GUARDIAN, EMERGENCY_CONTACT | SC 3479 | |
| `gps_stop_visited.classification_type` / rank | DRIVEBY 1, VISITED 2, CHECKPOINT 3, STOP 4 | SC 974-979; QAV 64 | Order matches DS section 6 |
| `gps_event_history.classification_type` | BUS_STOP, SCHOOL_STOP, HOME_STOP, GARAGE_STOP, TRAFFIC_STOP, RAILROAD_STOP, IDLE, IN_TRANSIT | DK 1116; SC 929-930 | Code writes different labels (section 8) |
| Notification `notification_type` | BUS_ARRIVAL, RIDERSHIP_BOARD, RIDERSHIP_EXIT, DEVIATION_ALERT, INSPECTION_CRITICAL; channel push/sms/email; priority normal/urgent | DK 1166 | Queue contract; table not in SC |
| `ins_item.response_type` | PASS_FAIL, YES_NO, NUMERIC, TEXT | SC 3942 | |
| `ins_response.response_status` | PASS, FAIL, NA | SC 4128 | |
| `ins_defect.defect_severity` | MINOR, MAJOR, CRITICAL | SC 4196 | |
| `ins_signature.signer_role` | INSPECTOR, SUPERVISOR, MECHANIC | SC 4337 | |
| Inspection types (examples) | Pre-Trip, Post-Trip, Annual / Maintenance | SC 3768; DK 834-835 | |
| `ta_shift.approval_status` | PENDING, APPROVED, REJECTED (default PENDING) | SC 5191 | |
| `ta_absence.status`, `ta_time_adjustment.status` | PENDING, APPROVED, REJECTED | SC 5359, 5684 | |
| `ta_pay_period.status` | OPEN, CLOSED, EXPORTED | SC 5500 | |
| `ta_timescan_transaction.transaction_type` | CLOCK_IN, CLOCK_OUT (BREAK_START/BREAK_END removed v7.19) | SC 5195; DK 1446 | |
| `ta_time_adjustment.adjustment_type` | ADD_TIME, SUBTRACT_TIME, CHANGE_JOB_CODE | SC 5359 | |
| `ta_rounding_rule.round_type` | NEAREST, UP, DOWN | SC 5442 | |
| `ta_employee_badge.badge_type` | PROXIMITY, BARCODE, QR, RFID | SC 5762 | |
| `ta_approval_step.approver_type` | PERMISSION, EMPLOYEE_SELF | SC 6135 | |
| `ta_trip_credit.source_type` | MANUAL, SCHEDULE | DK 1221 | |
| `ta_employee_field_definition.field_type` | TEXT, DATE, NUMBER, BOOLEAN, LIST | SC 6932 | |
| `usr_user_preference.preference_category` | GRID, FILTER, SORT, THEME, NOTIFICATION | SC 7769; DK 1333 | CHECK constraint per DK 1377 |
| `usr_permission.permission_type` | READ, WRITE, DELETE, ADMIN | SC 7065 | |
| `usr_user_entity_scope.entity_type` | PROGRAM, VEHICLE, LOCATION, DEPARTMENT | SC 7562 | |
| `chat_message.role` | user, assistant | SC 8105 | |
| Manifest `status` | SUCCESS, PARTIAL (FAILED per DS) | ETL 696, 2271 | |
| Pay period cycle (UI input) | Weekly, Biweekly, Semi-Monthly, Monthly | DK 1383 | Not a stored column per SC |

---

## 6. ETL as specified (ETL spec v2)

Architecture (ETL 14-126): two .NET 8 containers. `bp-pro-extract` reads each BP Pro DB (read-only, `Active = 1` rows, ETL 68) and writes one JSON file per entity plus `manifest.json` to object storage at `{bucket}/{customer_code}/{YYYY-MM-DD}/` (ETL 129-162). `bp-unified-load` validates the manifest, creates a snapshot, loads in FK order and activates the snapshot (ETL 94).

JSON envelope: `metadata` {entity, source_database, customer_code, extracted_at, extract_version, row_count, checksum_sha256} + `records` (ETL 200-215). Manifest: per entity file, source (`extracted` / `pre_generated`), row_count, checksum, duration; totals; status (ETL 649-697).

### Source-to-target mapping summary

| Target | BP Pro source | Mapping highlights | ETL lines |
|---|---|---|---|
| `opr_operator` | BPX_Operator | OperatorID -> `operator_code`; Name -> `operator_name`; DisplayName -> `operator_description`; `is_active` = 1 | 701-767 |
| `veh_vehicle` | BPX_Vehicle | VehicleID -> both `vehicle_name` and `vehicle_number`; License truncated to 20; VIN truncated to 17; ModelYear -> `year`; type name by VehicleTypeGUID lookup; capacity NULL; wheelchair 0; Active -> `is_active`; DepotGUID -> `depot_guid` (NULL if unresolved); also one `veh_vehicle_operator` row | 768-884 |
| `pln_district` | BP_District | DistrictID -> `district_code`; Name truncated to 200 | 885-927 |
| `pln_school` | BP_School | SchoolID -> `school_code`; Name truncated to 200; district by DistrictID; address NULL; lat/long from GEO centroid (null + warning if absent, ETL 311) | 928-988 |
| `pln_program` | BPX_Program | Name, Code, Description copied; spec says one row per (program, school) | 989-1038, 2014-2017 |
| `pln_school_year` | BPX_SchoolYear | SchoolYear -> `year_name`; StartDate -> `start_date`; EndDate -> `retire_date`; DB name from config | 1039-1093 |
| `pln_zone_type` | BPX_ZoneType | Name -> `type_name`; `type_code` generated from name | 1094-1148 |
| `pln_zone` | BP_Zone | ZoneID -> `zone_code`; Description (truncated to 100) -> `zone_name`; WKT -> `GEOGRAPHY::STGeomFromText(wkt, 4326)`; bounding box and `area_sq_miles` (sq m / 2,589,988.11) computed | 1149-1209, 2021-2036 |
| `pln_depot` | BP_Depot + BPX_DepotType | DepotID -> `depot_code` and `depot_name`; type name denormalized; lat/long parsed from Position; six flags copied; Security bit not mapped. Marked "not yet implemented" | 1210-1320 |
| `pln_route` | BPX_Route | RouteID -> `route_name` and `route_number`; RouteGUID -> `external_id`; vehicle and operator by GUID lookup; `route_sequence` 0; `substitution_flag` 0 | 1322-1394 |
| `pln_component` | BPX_Component + BPX_ComponentV | ComponentID -> `component_name`; type name lookup; SortOrder -> sequence; DepotDepartTime -> start; DepotDriverCheckOutTime -> end | 1395-1461 |
| `pln_run` | BPX_Run + BP_RunV | RunID -> `run_name`; Type -> `run_type`; RunV.StartTime/EndTime -> TIME; route and component through the chain; `run_sequence` from BPL_RunVComponentV.Order | 1462-1540 |
| `pln_stop` | BP_BusStop | BusStopID -> `stop_name`; lat/long from GEO centroid; Sequence, ScheduledTime, PlannedTime; `stop_type` inferred (STANDARD, SCHOOL at a school, GARAGE at a depot) | 1541-1631 |
| `pln_student` | BP_Student | StudentID -> `student_id`; names truncated to 100; BirthDate -> DATE; grade from enrollment -> grade join; `middle_name` NULL | 1632-1698 |
| `pln_student_address` | BP_Address | `address_line1` = "{StreetNum} {StreetName}"; Apt -> line 2; municipality, province, postal code; student via GEOObjID match | 1699-1783 |
| `pln_student_stop` | BPL_BusStopStudent | stop via bus-stop GEO key; program and school from BPX_Enrollment; address = Home address; `is_primary_program` = 1 when enrollment type is Home | 1784-1844, 2018-2020 |
| `ta_employee` | BPX_Staff | StaffID (truncated to 50) -> `employee_number`; Email1 -> `email`; phone = CellPhone else HomePhone, truncated; HireDate -> DATE; also one `ta_employee_operator` row | 1846-1925 |
| not loaded | enrollments, grades, vehicle_equipment, staff_roles, contracts | Extracted for derivation or future use | 328-329, 565-566, 636-637, 158-162 |
| pre-generated (no BP Pro source) | customer, address_types, substitution_reasons, on_time_categories | Hand-authored JSON listed in `extract-config.json`, copied into the batch | 2198-2220 |

### Transformation rules
- Times: BP Pro INT = **seconds** from midnight -> `hh:mm:ss`; null or negative -> null; examples 25200 -> 07:00:00, 27000 -> 07:30:00, 43200 -> 12:00:00, 57600 -> 16:00:00 (ETL 1929-1942, 2558-2579). `BP_Student.LoadTime` is a duration, not a time of day (ETL 1942).
- `datetime` -> `DATETIME2` lossless; date-only fields formatted `yyyy-MM-dd` (ETL 1943-1952).
- Run type: 0 TO_SCHOOL, 1 FROM_SCHOOL, 2 SHUTTLE, 3 OTHER, anything else OTHER (ETL 1961-1980).
- Composite GEO keys are resolved to GUID references at extract (ETL 1984-1987).
- Run -> route chain: BPX_Run -> BP_RunV -> BPL_RunVComponentV (`Type = 0`, primary component only) -> BPX_ComponentV -> BPX_Component -> BPX_Route, `Active = 1` (ETL 1988-2013).
- Lifecycle: Active 1 -> `is_active` 1, `is_deleted` 0; Active 0 -> `is_active` 0, `is_deleted` 0; RetireDate < today -> `is_active` 0 (ETL 2037-2039).
- GUID mapping via staging table `_etl_guid_map` (customer, entity_type, source_guid -> target_guid) (ETL 2077-2089).

### Ordering (ETL 2040-2076)
P1 `opr_operator`, `pln_customer`, `pln_substitution_reason`, `pln_address_type` -> P2 `pln_school_year`, `pln_district`, `veh_vehicle`, `ta_employee` -> P3 `pln_school`, `pln_zone_type`, `veh_vehicle_operator`, `ta_employee_operator` -> P4 `pln_program`, `pln_zone` -> P5 `pln_snapshot` -> P6 `pln_route`, `pln_component`, `pln_run`, `pln_stop` -> P7 `pln_student`, `pln_student_address`, `pln_student_stop`.

### Validation, reconciliation, error handling
- Manifest validation: expected entities present, checksums match, no partial uploads (ETL 94). Checksum mismatch rejects the whole manifest (ETL 2294-2296).
- Post-load validation report per customer: per entity `extracted`, `loaded`, `new`, `updated`, plus `warnings` and `errors` (ETL 2440-2460). Reconciliation rule implied by the example: `loaded = extracted` for every entity.
- Extract errors: DB connection retry 3x with backoff then skip customer; query timeout retry once with doubled timeout then skip entity and mark manifest PARTIAL; upload retry 3x; unexpected NULL logged and emitted (ETL 2260-2284).
- Load errors: FK violation or timeout rolls back the whole customer transaction; invalid WKT skips that zone and logs; duplicate snapshot = skip (ETL 2285-2317).
- Idempotency: an existing snapshot for (`customer_guid`, `school_year_guid`, `snapshot_date`) means the load is skipped (ETL 2318-2321).
- Atomicity claims: extract per customer is all-or-nothing (ETL 68); load per customer is one transaction (ETL 95, 2438).

### Performance targets and limits (ETL)
| Item | Value | ETL lines |
|---|---|---|
| Extract duration per customer | alert above 30 min | 2401-2403 |
| Load duration per customer | alert above 60 min | 2409-2411 |
| Row count per entity | alert on deviation above 50% from previous run | 2405-2407 |
| Object storage latency | alert above 10 s per file | 2425-2427 |
| GUID map hit rate | alert below 70% | 2417-2419 |
| Failed customers, transaction rollbacks | alert on any | 2413-2423 |
| Nightly timeline (ET) | extract 02:00, done ~03:00, load from ~03:30, all active ~05:00, dashboards 06:00 | 2431-2435 |
| Extract config | 10 parallel customers, 300 s query timeout, batch 5,000, 3 retries / 5 s | 2096-2102 |
| Load config | 30 min transaction timeout, batch 1,000, 3 retries / 10 s, deactivate previous snapshot | 2244-2251 |

Other documented volumes: `gps_event_current` about one row per active device; zones 400-500 per customer; real-time zone checks at thousands of points per second (DK 306, 695, 730). QAV states there are no automated performance or load tests (QAV 201).

---

## 7. ETL QA validation procedure (QAV) and load-test setup (LT)

### QAV checklists (target: schema v7.22 = v7.21 DDL + migrations 01-10, QAV 3-4)

| Area | What is checked | Pass criterion | QAV lines |
|---|---|---|---|
| Extract | Every configured customer extracts; manifest lists every expected entity | No error | 127 |
| Extract | Row counts vs BP Pro | "Approximate" the source after active-only filter (no numeric tolerance given) | 128 |
| Extract | INT seconds -> time | 28800 -> 08:00:00 | 129 |
| Extract | Pre-generated files copied | Present in batch | 130 |
| Load | Snapshot-scoped rows carry the correct `snapshot_guid` | All rows | 132 |
| Load | Orphan FKs | 0 | 133, 158-169 |
| Load | `pln_run.run_description` | Populated where source had one | 134 |
| Load | `pln_run.lock_flag`; `pln_stop.is_right_side` / `is_manual` | In {0,1,2,3}; 0/1 | 135 |
| Load | `pln_student_stop.external_guid`, `customer_guid`, `is_active` | Unique within snapshot; set; default 1 | 136 |
| Load | `dev_device.device_id`, `vehicle_name` | Populated | 137 |
| Geometry | `pln_run.path` | Valid WGS84 LINESTRING; spot-check on a map | 139 |
| Geometry | `pln_stop` lat/long | lat in [-90, 90], long in [-180, 180]; nothing left in UTM | 140-142 |
| Geometry | Zone polygon | Valid WGS84 POLYGON | 141 |
| GPS | Events inserted per poll; `device_guid` resolves | No orphans | 144 |
| GPS | Sensor columns | NULL when provider omits them (not 0) | 145 |
| GPS | `gps_stop_visited` | Type in the four values; rank 1-4; at most one non-deleted row per `stop_guid` | 146-147 |
| Idempotency | Re-run extract + load with unchanged source | No duplicate rows | 150 |
| Idempotency | Re-apply a migration | No-op | 151 |
| Migrations | `BPMigrationHistory` | Versions 1-10 present (stale, section 8) | 153 |
| Migrations | "Verify DB Status" | No PhantomApplied | 154 |
| Schema | `gps_stop_visited` exists, `pln_stop_event` does not | Both true | 155 |

QAV SQL (read-only, QAV 156-196):
- Orphan stops: `pln_stop` not deleted LEFT JOIN `pln_run` where run is NULL -> expect 0.
- Orphan current events: `gps_event_current` LEFT JOIN `dev_device` where device is NULL -> expect 0.
- `lock_flag` distribution -> only 0-3; `is_right_side` x `is_manual` distribution.
- `pln_student_stop` grouped by (`snapshot_guid`, `external_guid`) for non-deleted, non-NULL keys HAVING COUNT > 1 -> expect 0 rows.
- `gps_stop_visited` grouped by type and rank.
- Count of `pln_run` with `path IS NULL` (informational).
- Count of `pln_stop` with out-of-range coordinates -> expect 0.
- Count of `dev_device` with `device_id` or `vehicle_name` NULL.
- `BPMigrationHistory` listing.

QAV known gaps (QAV 197-202): stop matching feature-flagged off; no per-device timezone conversion (UTC stored); sensors "not yet used as classification inputs"; no performance tests; no migration-level unit tests for reprojection and the v7.22 columns.

### Load-test setup (LT, schema v7.18)
- Two passes: (1) create DB from the v7.18 script (drops and recreates), seed `pln_customer` and `pln_school_year`, add `customer_guid` and `school_year_guid` to the manifest, run Load in local mode; (2) seed three `ta_employee` rows and two `veh_employee_vehicle` rows, re-run Load (LT 13-25, 64-232, 344-470).
- Local mode: `UseLocalStorage` true, `UseLocalQueue` true, `UseQueueConsumer` false (manifest poller) (LT 111-120).
- Fixed test GUIDs for customer and school year (LT 49-62). The manifest GUIDs must match the seeded rows exactly or FK errors follow (LT 564-572).
- Expected counts for the SDCC 2026-02-26 extract (LT 216-228, 275-342):

| Table | Rows | Table | Rows |
|---|---|---|---|
| `opr_operator` | 2 | `pln_district` | 1 |
| `veh_vehicle` | 288 | `pln_school` | 43 |
| `pln_zone_type` | 6 | `pln_grade` | 15 |
| `pln_program` | 14 | `pln_zone` | 349 |
| `pln_route` | 184 | `pln_component` | 360 |
| `pln_run` | 892 | `pln_stop` | 9,406 |
| `pln_student` | 36,766 | `pln_student_address` | 36,891 |
| `pln_enrollment` | 67,395 | `pln_student_stop` | 63,445 |
| `pln_employee_vehicle` | 0 after pass 1 | | |

- Pass 2 success criterion: count of `pln_employee_vehicle` (not deleted) equals count of `veh_employee_vehicle` with `retire_date IS NULL AND is_deleted = 0`, each row scoped to the snapshot created by the load (LT 501-517). Log line to look for: "Phase 6: Internal load employee_vehicles -> pln_employee_vehicle: 2 records" (LT 461-468).
- Re-run works because the in-memory manifest tracker resets on restart and all MERGEs are idempotent (LT 456).
- Reset: `cleanup-for-retesting.sql`, clearing `veh_employee_vehicle` before `veh_vehicle` (LT 519-540).
- Troubleshooting tip in the document: blank the `checksum_sha256` in the manifest to bypass a mismatch (LT 560-562). This disables an integrity check; do not use it when the checksum itself is under test.
- The counts are a historical baseline: they predate one-row-per-run stops and weekday filtering (DS section 4, UNVERIFIED against current code). The single-snapshot assumption (LT 258-260, 513) does not hold with the code's 10-day window.

---

## 8. SPEC vs CODE

"Code does" is taken from DS (which cites the source files); it was not re-read here.

| # | Topic | Document says | Code does (DS) | Trust |
|---|---|---|---|---|
| 1 | Run type values | TO_SCHOOL, FROM_SCHOOL, SHUTTLE, FIELD_TRIP, OTHER (SC 2192; ETL 1961-1980) | 0/1/2/3 -> PICKUP, DROPOFF, NOON_PICKUP, NOON_DROPOFF, else OTHER (DS 171) | Code |
| 2 | Stop type values | STANDARD, HOME, SCHOOL, GARAGE, WAYPOINT; inferred from location (SC 2325; ETL 1602-1606) | 0-7 -> PICKUP, DROPOFF, SCHOOL_PICKUP, SCHOOL_DROPOFF, TRANSFER_PICKUP, TRANSFER_DROPOFF, WAYPOINT, TURN_AROUND, else STANDARD; missing `source_stop_type` fails the load (DS 171, 319) | Code |
| 3 | Run and stop time storage | `TIME` columns, local time of day; all `DATETIME2` are UTC (SC 2243-2251, 2396-2403; DK 93-98) | Local `DATETIME2` = snapshot date + local time; source time 0 -> NULL (DS 169, 333) | Code. Biggest trap for time assertions |
| 4 | Snapshot model | One snapshot per ETL import; previous one for the date deactivated (DK 588-593; ETL 94) | Rolling window of the next 10 weekdays from customer-local today; an existing snapshot is reused and reloaded (DS 165-167) | Code |
| 5 | Idempotent re-run | Existing snapshot -> load skipped (ETL 2318-2321) | Skip is by `_manifest_loaded` watermark; snapshots are reloaded by MERGE (DS 175-178) | Code |
| 6 | Load transaction | One transaction per customer; rollback leaves no partial data (ETL 95, 2438; QAV 83) | No customer-wide transaction; committed rows stay; snapshot stays inactive (DS 181-182) | Code |
| 7 | Load phases and order | 7 phases; snapshot before students (ETL 2040-2076; LT 214-228) | 8 phases; students (P5) before snapshots (P6); snapshot data P7; student snapshots P8 (DS 48-67) | Code |
| 8 | GUID resolution | `_etl_guid_map` staging table (ETL 2077-2089) | MERGE on `external_guid` / `external_id`; no map table (DS 8, 177) | Code |
| 9 | Source key column | `external_id` on district, school, program, zone (ETL 892-896, 935-939) | `external_guid` on reference tables, `external_id` on snapshot tables (DS 131) | Code (DK 243-251 agrees) |
| 10 | Stop identity | `external_id` = BusStopGUID; one row per stop (ETL 1548-1552) | `external_id` = `{BusStopGUID}:{RunGUID}:{PassNumber}`; a stop on N runs is N rows (DS 170) | Code |
| 11 | Program scope | One `pln_program` per (program, school) with `school_guid` (ETL 1038, 2014-2017) | Customer-scoped; `pln_school_program` bridge (DS 55, 164; SC 1570 agrees) | Code and SC |
| 12 | Deactivated source rows | Active 0 -> `is_active` 0, `is_deleted` 0 (ETL 2039) | Extract takes `Active = 1` only; rows missing from the guid list -> `is_deleted` 1 and `is_active` 0, `modified_by` 'ETL-DELETE' (DS 154, 163) | Code |
| 13 | Retire date boundary | Inclusive: active when `D <= retire_date` (DK 190-196) | Exclusive: `effective <= day < retire` (DS 168, 293) | Code for ETL and GPS; confirm per feature elsewhere (UNVERIFIED) |
| 14 | Depot ETL | Not implemented; schema only (SC 1176; DK 1478; ETL 1211) | Depots loaded in phase 2; default "Default Busplanner" depot and operator seeded (DS 49-50, 164) | Code |
| 15 | Staff / employees | Staff -> `ta_employee` + `ta_employee_operator` (ETL 1846-1925); LT says employees are not loaded by ETL (LT 350) | Staff loader writes `ta_employee`; employees never deleted (DS 49-51, 151). `ta_employee_operator` not listed among written tables (UNVERIFIED) | Code; DK 1211-1215 is the closest document |
| 16 | Primary program | Enrollment type "Home" (ETL 1835-1838) | "Main" enrollment type (DS 289) | Code |
| 17 | Trigger and transport | Object-storage notification or polling; Azure container instances / Logic Apps; Key Vault (ETL 46-50, 79-80, 2354-2365) | Redis list queue per client or polling; k8s CronJob + Deployment; k8s Secrets (DS 18-19, 109) | Code |
| 18 | Extract atomicity | All entities or nothing per customer (ETL 68) | Each entity uploaded as it finishes; PARTIAL/FAILED status; publish unless FAILED (DS 151-153) | Code |
| 19 | Customer and lookup seeding | Pre-generated JSON for customer, address types, substitution reasons, on-time categories (ETL 2198-2220) | `customer_guid` and `school_year_guid` must be pre-seeded in the target and carried in the manifest (DS 152, 336; LT 180-196 agrees). Whether pre-generated files are still used: UNVERIFIED | Code |
| 20 | Students load | Full load each run (ETL 2073-2076) | Incremental by watermark minus 120 min, fail-open on missing ModifiedDate (DS 162) | Code |
| 21 | Bell times | `pln_program_bell_time` + arrival/departure windows (SC 1836-2043) | `pln_bell_time_type`, `pln_bell_time`, `pln_bell_time_program` loaded (DS 52-55, 122) | Code; status of the older tables UNVERIFIED |
| 22 | Tables missing from the documents | - | `pln_vehicle_type`, `pln_seat_type`, `pln_vehicle_seat_type`, `pln_enrollment`, `pln_enrollment_type`, `pln_stop_school`, `pln_student_school`, `gps_plan_change_history`, `app_settings`, `ta_payroll_export*`, `ta_employee_pin`, `ta_payable_recalculation*`, view `gps_live_fleet_v` (DS 121-129) | Code |
| 23 | Migration level | v7.22 = migrations 01-10 (+28); expect history 1-10 (SC 2; QAV 153) | 75 migrations in the catalog (DS 136) | Code. Test "all catalog migrations applied, no mismatch" |
| 24 | GPS event classification labels | BUS_STOP, SCHOOL_STOP, HOME_STOP, GARAGE_STOP, TRAFFIC_STOP, RAILROAD_STOP, IDLE, IN_TRANSIT (DK 1116) | Live, On, IgOff, Beacon, Stop, UnknownStop, Pullout, plus School / Depot after geofencing (DS 207, 216) | Code |
| 25 | GPS pipeline shape | Seven queue-driven microservices, `database_target` routing, dead-letter table, notification service (DK 1048-1194) | Three long-running services polling vendor APIs and the DB; no queue pipeline described (DS 20-22) | Code. Treat DK section 21 as design intent |
| 26 | GPS vendors | Zonar, Samsara, GPS Trackit, Geotab (DK 1051); Geotab/Zonar/Synovia (QAV 23) | Geotab, Zonar, Synovia, GTS, Samsara (DS 201) | Code |
| 27 | Stop matching inputs | Geofence radius + speed <= 2.0 mph + stop type (DK 1150-1160); sensors not yet used, matching flagged off in the reader (QAV 198-200) | Separate service; distance 50/75/100 m, speed < 5 km/h, door, stop arm or amber, time window (DS 244-251) | Code |
| 28 | `gps_stop_visited` uniqueness | Unique on `stop_guid` where not deleted (SC 940; QAV 147) | MERGE on (`stop_guid`, `snapshot_guid`, not deleted) (DS 257) | Equivalent in practice because a stop row belongs to one snapshot (UNVERIFIED index definition) |
| 29 | Soft delete "everywhere" | Every table has `is_deleted` (DK 173) | `pln_snapshot`, `gps_event_current`, `pln_stop_school`, `pln_student_school` have none (DS 131); SC shows more (section 4, item 4) | Code and SC |
| 30 | Names in QAV | `pln_student_snapshot_xref`, `pln_zone.polygon` (QAV 121, 141) | `pln_student_snapshot`, `zone_geometry` (SC 2897, 3090; DS 65) | SC and code |
| 31 | Tenancy | Operators and customers share one database; "always filter by operator" (DK 965-997) | One database per client, selected from the JWT `client_code`; delete detection for `pln_student`, `veh_vehicle`, `opr_operator` relies on that (DS 102-105) | Code |

---

## 9. Top 20 data-integrity checks to automate

Run per client database and scope snapshot-table checks to one snapshot (QAV 132). Read-only. Expected result is zero rows unless stated.

1. **Parent exists and is live**: every non-deleted `pln_stop` has a non-deleted `pln_run`; every `pln_run` a `pln_component` and `pln_route`; every `pln_component` a `pln_route`; every `pln_route` a `pln_snapshot` (QAV 158-163; DK 332-339).
2. **Snapshot consistency down the chain**: a stop's `snapshot_guid` equals its run's; a run's equals its component's and route's; `pln_run.route_guid` equals its component's `route_guid` (section 3).
3. **One active snapshot per date**: no (`customer_guid`, `school_year_guid`, `snapshot_date`) has more than one `is_active = 1` row (DK 595-599).
4. **Active snapshot is not empty**: every active snapshot has at least one route, run, stop and student-stop (DS rule 6; ETL 94).
5. **Student-stop references resolve inside the same snapshot**: `pln_student_stop.stop_guid` points to a non-deleted stop with the same `snapshot_guid`; `student_guid`, `program_guid`, `school_guid`, `student_address_guid` resolve to non-deleted rows; the address belongs to the same student (DK 620-630; QAV 116-118).
6. **Student-stop upsert key unique**: no duplicate (`snapshot_guid`, `external_guid`) among non-deleted rows with a non-NULL key; `customer_guid` not NULL on ETL rows (QAV 175-179).
7. **One student-snapshot row per student per snapshot** (SC 2898).
8. **Upsert keys unique on reference tables**: no duplicate non-NULL `external_guid` among non-deleted rows of `opr_operator`, `veh_vehicle`, `pln_district`, `pln_school`, `pln_program`, `pln_zone_type`, `pln_zone`, `pln_grade`, `pln_depot`, `pln_student`, `veh_employee_vehicle`, and (`customer_guid`, `external_guid`) on `ta_employee` (DK 235-251; SC 8340). Likewise no duplicate `external_id` within a snapshot on `pln_route`, `pln_component`, `pln_run`, `pln_stop`.
9. **Single current assignment**: at most one row with `retire_date IS NULL AND is_deleted = 0` per `vehicle_guid` in `veh_vehicle_operator`; per `device_guid` in `dev_device_operator`; per `employee_guid` and per `vehicle_guid` in `veh_employee_vehicle`; per `employee_guid` in `ta_employee_department` and `ta_employee_fte`; per `department_guid` in `ta_department_pay_period` (DK 202-209, 1209, 1236, 1425).
10. **No overlapping device mappings**: for one `device_guid`, no two non-deleted `dev_vehicle_device` rows have overlapping date ranges; and `retire_date` is never before `effective_date` on any dated table (DK 294-298; DS risk 25).
11. **Enumerations in domain**: `run_type`, `stop_type` (use the code vocabulary, section 8 rows 1-2), `lock_flag` in 0-3, `substitution_flag` in 0-2, `substitution_source` NULL/1/2, `ta_shift.approval_status`, `ta_pay_period.status`, `gps_stop_visited.classification_type` with the matching rank (QAV 46-49, 64, 79; DK 799-808).
12. **Substitution lineage**: every row with `substitution_flag = 2` has a non-NULL `original_*_guid` pointing to a row in the same snapshot; rows with flag 0 have a NULL original (DK 799-811). How code marks the replaced row (flag 1 vs soft delete, DS 231) should be confirmed first (UNVERIFIED).
13. **Coordinates are WGS84**: `pln_stop`, `pln_school`, `pln_student_address`, `pln_depot` latitude in [-90, 90] and longitude in [-180, 180], neither exactly 0, and inside the client's plausible bounding box; nothing left in UTM (QAV 140-142, 188-190).
14. **Geometry valid**: `pln_zone.zone_geometry` is a valid polygon and its four bounding-box values enclose it; `pln_run.path`, when present, is a valid line (QAV 139-141; ETL 2021-2036).
15. **One current GPS row per device**: `gps_event_current` has no duplicate `device_guid`; every `device_guid` there and in recent `gps_event_history` exists in `dev_device` (QAV 165-169; DK 1144-1145).
16. **Current matches history**: for each device, `gps_event_current.event_timestamp` equals the maximum `event_timestamp` in `gps_event_history`; no event has `event_timestamp` later than `received_timestamp` by more than a small tolerance or in the future (DK 316-320, 1134-1136). Tolerance to be agreed (UNVERIFIED).
17. **Stop-visit integrity**: at most one non-deleted `gps_stop_visited` row per `stop_guid`; its `snapshot_guid` equals the stop's; `distance_meters >= 0`; rank and type agree (QAV 146-147; SC 940).
18. **Soft-delete coherence**: no non-deleted child references a deleted parent on reference chains (`pln_school` -> `pln_district`, `pln_zone` -> `pln_zone_type`, `veh_vehicle.depot_guid` -> `pln_depot`, `pln_school_program` -> school and program); rows soft-deleted by the ETL have `is_active = 0` (DK 168-176; DS rule 11).
19. **Master vs snapshot driver assignment**: for a freshly loaded snapshot, the set of (`employee_guid`, `vehicle_guid`) in `pln_employee_vehicle` equals the active master set in `veh_employee_vehicle` for that date; one employee per vehicle per snapshot (LT 501-517; SC 2478).
20. **Reconciliation against the manifest**: for each loaded entity, target row count for the load equals the manifest `row_count` minus documented filters (per-day effective/retire and weekday filters for snapshot entities); alert on a change above 50% against the previous run (ETL 2405-2407, 2440-2460; QAV 128). Exact per-entity formula needs the code's filters (UNVERIFIED).

Useful extras once the 20 are in place: `ta_shift` APPROVED implies an approved `ta_shift_approval` row for every active step and a matching `ta_approval_history` row (DK 1474-1475); no shift changed after its pay period became EXPORTED; `usr_workspace_layout` one non-deleted row per user; `usr_user_preference` unique (user, category, key); custom field values valid for their `field_type` / `list_options` (DK 1291, 1315, 1335).

---

## Not determined from these documents
- Real nullability, defaults, indexes and CHECK constraints (SC does not list them reliably).
- Whether the older bell-time, area, ridership, parent-alert and inspection tables are populated or used by any current feature.
- Whether `ta_employee_operator` is written by the staff loader.
- Whether pre-generated JSON entities are still part of the extract.
- Exact reconciliation formulas per entity and any agreed numeric tolerance for "row counts approximate the source".
- Which retire-date convention (inclusive per DK, exclusive per code) applies in T&A and authorization features.
