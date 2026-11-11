# BusPlannerUnified - data and background services

Source: read-only snapshot `repos/BusPlannerUnified`, commit 0137276. Mapped with Read/Grep/Glob only; nothing was built or run.
Paths are relative to the repo root. `BU/` = `BusPlannerUnified/` (the inner .NET solution folder). `ETL/` = `BU/BusPlanner.ETL/`.
Anything marked UNVERIFIED is inferred, not read in code. Secrets and connection strings are deliberately not reproduced; section 3 says where config lives.

Doc-trust warning: several docs are older than the code. Where they disagree, code wins (the audit itself rules "schema .sql is authoritative over the spec", `ETL/docs/ETL-Data-Correctness-Audit-2026-07-07.md:54`).
- `docs/etl/ETL-Technical-Specification.md` is still headed "Version 1.0 / 2026-02-23 / Draft" (lines 3-5) and describes run types as TO_SCHOOL/FROM_SCHOOL/SHUTTLE (lines 1058, 1233-1237), a 7-phase load, an `_etl_guid_map` table and a single per-customer transaction. None of that matches the code.
- `docs/database/CreateDatabase.md` says "Apply all -> 19" and "staff ... skipped at load time" (lines 69, 464); the catalog now has 75 migrations and a staff loader.
- `docs/database/SetupGPSDownload.md` describes `BPCustomers.db_connection_string` and `ConnectionStrings:DefaultConnection` (lines 43-47, 211-221) and only Geotab/Zonar; the code uses `ConnectionStrings:ClientRegistry`, `Server`+`DatabaseName`+secret name, and five providers.

---

## 1. Overview

| Component | What it does | Trigger | Reads | Writes |
|---|---|---|---|---|
| `BpPro.Etl.Extract` (`ETL/BpPro.Etl.Extract`) | One-shot console app. Extracts ~30 entity types from one BP Pro (legacy BusPlanner Pro) SQL Server DB to JSON envelopes + `manifest.json` + `*_guids.json` | k8s CronJob `etl-<client>-extract` (default `0 6 * * *` UTC, ships suspended, `concurrencyPolicy: Forbid`) or manual `kubectl create job --from=cronjob/...`; on a client's own Windows server, Windows Task Scheduler | BP Pro DB (SELECT only) | Object storage `{cos_prefix}/{UTC yyyy-MM-dd}/`; one Redis list message per successful extract |
| `BpPro.Etl.Load` (`ETL/BpPro.Etl.Load`) | Transform and load JSON into the Unified DB in 8 FK-ordered phases; maintains a rolling 10-school-day set of plan snapshots | k8s Deployment `etl-<client>-load` consuming Redis list `etl:load-queue:<client>` (`UseQueueConsumer=true`); or single-run polling mode that scans storage for the newest SUCCESS manifest and exits | Object storage JSON, Unified DB | Unified DB `opr_`, `veh_`, `pln_`, `ta_employee`, `etl_watermark` |
| `BPGPSReaderService` (`BU/BPGPSReaderService`) | Polls GPS vendor APIs, normalises to a common event, classifies by sensor transitions, writes telemetry; background reverse-geocoding and geofence reclassification | Long-running BackgroundService (Windows Service or console). One worker per client with feature flag `GPS`; poll every 20 s, vehicle refresh every 600 s, registry reconcile every 15 min | Client_Registry, vendor APIs, client DB `gps_provider_connection` / `gps_connection_settings` | Client DB `dev_device`, `gps_event_history`, `gps_event_current`, `gps_connection_settings.LatestEventWrittenDateTime` |
| `BPStopClassificationService` (`BU/BPStopClassificationService`) | Matches GPS events against the day's planned stops; keeps the best match per stop | Long-running; one worker per `GPS`-flagged client; poll every 30 s; optional historical backfill | Client DB `gps_event_history`, `dev_vehicle_device`, `pln_snapshot/route/run/stop`, `pln_customer.time_zone`, `gps_plan_change_history` | `gps_stop_visited` |
| `BPGPSSubstitutionImportService` (`BU/BPGPSSubstitutionImportService`) | Pulls today's route/run -> vehicle substitutions (and optionally driver reassigns) from the client's BP Info REST service and overlays them on today's plan snapshot | Long-running; one worker per `GPS`-flagged client; poll every 300 s (`SubstitutionImport:PollIntervalSeconds`) | BP Info HTTP (`GPSRouteVehicle/Get`, `LiveData/GetGPSVehicles`, `DriverSchedule/Get`), client DB `app_settings` category `BPInfo` | `pln_route`, `pln_run`, `pln_component`, `pln_employee_vehicle`, `gps_plan_change_history` |
| `BPClientRegistry` (`BU/BPClientRegistry`) | Shared library: reads the `Client_Registry` catalog DB (clients, feature flags, users), resolves per-client DB credentials | Library, called per request / per reconcile; no caching | `dbo.BPCustomers`, `dbo.BPFeatureFlag`, `dbo.BPUsers`; IBM Secrets Manager | nothing |
| `BusPlanner.MigrationTool` (WPF) + `BusPlanner.MigrationTool.Cli` (`bpmigrate`) | Applies numbered, idempotent raw-SQL schema migrations; can create a new DB from the base DDL | Manual desktop tool; CLI `status / up [--to N] / down --to N / create-database` | `Migrations/NN_*.up.sql|.down.sql`, base DDL in `ETL/docs` | Target DB schema, `BPMigrationHistory` |
| `BU/Migrations/*.sql` (3 files) | Dated standalone SQL scripts with the same names as tool migrations 07-09 | UNVERIFIED: legacy/manual copies; the tool reads its own `BusPlanner.MigrationTool/Migrations/` folder | - | - |
| `BU/scripts` | Dev/QA SQL and PowerShell: GPS+ synthetic fixture, payroll seed/verify, `SeedData.sql`, `Deploy-IIS.ps1`, `Migrate-ZonarSettingsToUnified.ps1`, two migration-renumber reconcile scripts | Manual | - | - |

Sources: `ETL/BpPro.Etl.Extract/Orchestration/ExtractionOrchestrator.cs`; `ETL/BpPro.Etl.Load/Services/LoadServiceRunner.cs:34-80`; `deploy/helm/etl/values.yaml:67-87`; `deploy/helm/etl/templates/cronjob-extract.yaml:15`; `ETL/docs/ETL-Extract-Installation-Rulebook.md:18-25`; `BU/BPGPSReaderService/BPGPSReaderService.cs:12-34`; `BU/BPGPSReaderService/ClientWorker.cs:51-52`; `BU/BPStopClassificationService/ClientWorker.cs:104-125,196-197`; `BU/BPGPSSubstitutionImportService/ClientWorker.cs:14-31,110-111`; `BU/BPClientRegistry/ClientDirectory.cs:23-26`; `BU/BusPlanner.MigrationTool.Cli/README.md:12-19`.

Deployment model: ETL and stop classification are deployed **per client** (own Helm release, Secret, values file); one shared Redis and one shared object-storage bucket serve all clients, isolated by queue name and key prefix (`docs/infra/onboard-etl-stopclass-client.txt:22-37`). Client values files present: `deploy/helm/etl/values-sdcc.yaml`, `values-stsbhn.yaml`; local config variants `extract-config_SDCC/STSBHN/STSTB.json`, `load-config_SDCC/STSBHN/STSTB.json`.

Conflict to be aware of: the runbook says the GPS Reader is Windows-only, runs on a VM and is not containerized (`docs/infra/etl-deployment-runbook.md:280-281`), while the project contains a `Dockerfile` and the code comments describe a single k8s replica (`BU/BPGPSReaderService/BPGPSReaderService.cs:23-24`). Where it actually runs per environment is not determinable from the repo.

---

## 2. Data flow (text diagram)

```
PLAN DATA (nightly, per client)
BP Pro SQL Server (legacy BusPlanner Pro; tables BPX_*, BPL_*, BP_*, GEO_*, xGeoSetting)
  | Extract: one SELECT set per entity, UTM -> WGS84 coordinate conversion,
  |          time decode, JSON envelope {metadata, records}, SHA-256 per file
  v
Object storage  {cos_prefix}/{UTC date}/  <entity>.json, <entity>_guids.json, manifest.json
  | + Redis list message {customer_code, customer_guid, school_year_guid, manifest_path, cos_prefix}
  v
Load (per manifest, status SUCCESS only)
  P1 operators                         -> opr_operator
  P2 districts, depots, vehicle_types, vehicles, staff, vehicle_staff
                                       -> pln_district, pln_depot, pln_vehicle_type, veh_vehicle,
                                          ta_employee, veh_employee_vehicle
  P3 schools, bell_time_types, bell_times, zone_types, grades, enrollment_types,
     seat_types, vehicle_seat_types    -> pln_school, pln_bell_time_type, pln_bell_time, pln_zone_type,
                                          pln_grade, pln_enrollment_type, pln_seat_type, pln_vehicle_seat_type
  P4 programs, bell_time_programs, zones -> pln_program, pln_bell_time_program, pln_zone
  P5 students, student_addresses, enrollments -> pln_student, pln_student_address, pln_enrollment
  -- delete detection (soft delete rows missing from *_guids.json)
  -- bridges: pln_school_program, pln_school_zone, veh_vehicle_operator, default depot/operator
  P6 ensure snapshots (next 10 weekdays, or explicit snapshot_dates) -> pln_snapshot (created inactive)
  for each snapshot day:
     [purge if overwrite_existing_snapshots]
     P7 routes, components, runs, stops, bus_stop_students + internal employee_vehicles
                                       -> pln_route, pln_component, pln_run, pln_stop,
                                          pln_student_stop, pln_employee_vehicle
     P8 internal student_snapshots     -> pln_student_snapshot
     rebuild pln_stop_school + pln_student_school ; activate snapshot
  deactivate snapshots outside the window ; advance etl_watermark
  v
Unified DB (one database per client)  --EF Core AppDbContext-->  BusPlannerAPI (GraphQL reads, REST writes)

GPS DATA (continuous, per client)
Vendor APIs: Geotab, Zonar, Synovia, GTS, Samsara
  | BPGPSReaderService: fetch -> common GpsEvent -> active-device filter + 30 s position dedup
  |                     -> sensor-transition classifier -> bulk insert
  v
dev_device, gps_event_history (UTC), gps_event_current (1 row per device)
  | async: Nominatim reverse geocode (Stop/UnknownStop) -> gps_event_history.reverse_geocode_address
  | async: zone containment (UnknownStop) -> classification_type School / Depot
  v
BPStopClassificationService: event -> dev_vehicle_device (dated) -> vehicle -> snapshot for the
  customer-local service date -> pln_route/pln_run chain -> pln_stop -> distance/speed/sensor/time rules
  v
gps_stop_visited (best match per stop per snapshot)  -> GPS+ Live Viewer (view gps_live_fleet_v), analytics, chatbot

SUBSTITUTIONS (every 5 min, per client)
BP Info REST -> BPGPSSubstitutionImportService -> overlays on today's active snapshot
  (pln_route / pln_run clones, substitution_source = 2) + gps_plan_change_history
  -> stop classification evicts cached stops for the changed vehicles
```

Sources: `ETL/BpPro.Etl.Load/Orchestration/LoadPhaseDefinition.cs:13-136`; `ETL/BpPro.Etl.Load/Orchestration/LoadOrchestrator.cs:254-438`; `ETL/BpPro.Etl.Extract/Orchestration/ExtractionOrchestrator.cs:98-103,186-231`; `BU/BPGPSReaderService/ClientWorker.cs:362-370,511-588`; `BU/BPStopClassificationService/Data/StopLookupService.cs:103-205`; `BU/BPStopClassificationService/README.md:134-138`; `BU/CLAUDE.md` (tech stack table).

---

## 3. Database

**Engine.** Microsoft SQL Server (docs require 2019+; `Microsoft.Data.SqlClient`; GEOGRAPHY columns; `AT TIME ZONE`). `gps_event_history` is monthly partitioned (`pf_gps_monthly`) (`docs/database/CreateDatabase.md:27,61`). The dev SQL Server runs on Linux per `BU/scripts/gpsplus-testdata/README.md:538`.

**Client Registry and per-tenant model.**
- One catalog DB `Client_Registry` holds `BPCustomers` (one row per client: `CustomerID`, `CustomerName`, `ClientCode`, `Server`, `DatabaseName`, `DbCredentialSecret`, `ClientLogoObjectKey`, `IsDeleted`), `BPFeatureFlag` (EAV: `CustomerID`, `FeatureCode`, `IsEnabled`; missing row = off) and `BPUsers` (`EmailHash`, `CustomerID`, `IsDeleted`) (`BU/BPClientRegistry/ClientDirectory.cs:41-43,74-76,96-103`).
- Feature codes: `GLOBAL_LOGIN`, `GPS` (gates the reader, stop classification and substitution import together), `CHATBOT` (`BU/BPClientRegistry/FeatureCodes.cs:12,20,30`).
- Each client has its **own Unified database**. The API routes each request to it from the JWT `client_code` claim (`docs/database/MultiTenant-Local-Login-Setup.md:19-28`). Background services open one connection per client built from `Server` + `DatabaseName` + credentials (`BU/BPClientRegistry/DbCredentials.cs:62-74`).
- Credential rule "master if present, else IBM Secrets Manager": if `Db:MasterUser`/`Db:MasterPassword` are configured they are used for every client DB; otherwise the secret named in `BPCustomers.DbCredentialSecret` is fetched (`BU/BPClientRegistry/DbCredentials.cs:12-45`).
- `ClientCode` lookup is trimmed and upper-cased (`ClientDirectory.cs:48-50`).
- Inside one client DB there is still a `pln_customer` row and many tables carry `customer_guid`, but `pln_student`, `veh_vehicle` and `opr_operator` do not; ETL delete detection for those relies on one database per client (`ETL/BpPro.Etl.Load/Utilities/DeleteDetector.cs:17-21`).
- Naming trap: two catalog DBs exist on the dev server; the usable one is `Client_Registry`, not `Client_Registry_Local` (`docs/database/MultiTenant-Local-Login-Setup.md:56-65`).

**Where config lives (no values reproduced).**
- ETL in k8s: Secret `etl-<client>-secrets` with keys `BPPRO_CONNECTION_STRING`, `UNIFIED_CONNECTION_STRING`, `IBM_COS_ACCESS_KEY`, `IBM_COS_SECRET_KEY`, `REDIS_CONNECTION_STRING`; non-secret identity in `deploy/helm/etl/values-<client>.yaml`; ConfigMap renders `extract-config.json` + `load-config.json` with `ENV_VAR:NAME` placeholders (`deploy/helm/etl/templates/configmap.yaml`, `docs/infra/etl-deployment-runbook.md:95-106`).
- ETL local: `ETL/BpPro.Etl.Extract/extract-config.json`, `ETL/BpPro.Etl.Load/load-config.json`, both `appsettings.json` (`UseLocalStorage`, `UseLocalQueue`, `UseQueueConsumer`, `LocalStoragePath`).
- Stop classification: Secret `stop-classification-<client>-secrets`, key `ConnectionStrings__DefaultConnection` per the runbook (`docs/infra/etl-deployment-runbook.md:296-298`); the service README instead lists `ConnectionStrings:ClientRegistry` + `Db:Master*` / `SecretsManager:*` (`BU/BPStopClassificationService/README.md:15-22`). The two documents disagree; the README matches the multi-tenant code.
- GPS reader / substitution import: `ConnectionStrings:ClientRegistry`, `Db:MasterUser/MasterPassword`, `SecretsManager:ServiceUrl/SecretGroup/ApiKey` (`BU/BPGPSReaderService/BPGPSReaderService.cs:80-92`). Vendor credentials live in the client DB table `gps_connection_settings` (name/value rows). BP Info base URL and the secret *name* live in `app_settings` category `BPInfo`.

**Schema areas** (prefix = domain). Base DDL `docs/specs/bus-planner-schema-v7.20.sql` (109 `CREATE TABLE`), newer baseline `ETL/docs/bus-planner-schema-v7_21.sql`.

| Prefix | Area | Key tables |
|---|---|---|
| `opr_` | Operators (bus companies) | `opr_operator` |
| `veh_` | Vehicles | `veh_vehicle`, `veh_vehicle_operator`, `veh_employee_vehicle` (master driver-to-bus assignment) |
| `dev_` | GPS devices | `dev_device`, `dev_vehicle_device` (dated device-to-vehicle mapping), `dev_device_type`, `dev_device_operator` |
| `gps_` | Telemetry | `gps_provider_connection`, `gps_connection_settings`, `gps_event_history`, `gps_event_current`; later `gps_stop_visited` (mig 07), `gps_plan_change_history` (mig 59), view `gps_live_fleet_v` (mig 37+) |
| `pln_` reference | Customer-scoped plan reference | `pln_customer`, `pln_school_year`, `pln_district`, `pln_school`, `pln_program`, `pln_zone_type`, `pln_zone`, `pln_school_zone`, `pln_address_type`, `pln_substitution_reason`, `pln_on_time_category`; later `pln_depot` (12), `pln_grade`, `pln_school_program`, `pln_seat_type` (62), `pln_vehicle_type` / `pln_vehicle_seat_type` (63), `pln_bell_time*` (64-65), `pln_enrollment*` (67) |
| `pln_` snapshot | Per-day plan | `pln_snapshot`, `pln_route`, `pln_component`, `pln_run`, `pln_stop`, `pln_stop_zone`, `pln_student_stop`, `pln_employee_vehicle`, `pln_student_snapshot`, derived `pln_stop_school` / `pln_student_school` |
| `pln_` students | Not snapshot-scoped | `pln_student`, `pln_student_address`, `pln_student_card_assignment`, `pln_ridership_scan` |
| `ins_` | Inspections | `ins_inspection`, `ins_template`, `ins_item`, `ins_response`, `ins_defect` |
| `ta_` | Time and attendance | `ta_employee`, `ta_shift`, `ta_shift_transaction`, `ta_timescan_transaction`, `ta_pay_period`, `ta_absence`, `ta_schedule`, `ta_rounding_rule`, `ta_job_code`, `ta_position`, `ta_settings`, `ta_approval_history`; later `ta_payroll_export*` (26), `ta_employee_pin` (21), `ta_payable_recalculation*` (41) |
| `usr_` + `AspNet*` | Users, roles, permissions | `usr_user`, `usr_role`, `usr_permission`, `usr_user_entity_scope`; Identity tables from mig 01 |
| `chat_` | Chatbot | `chat_conversation`, `chat_message`, `chat_feedback`, `chat_correction`, `chat_test_case` |
| other | Infrastructure | `svc_queue_dead_letter`, `etl_watermark` (created by Load if absent), `app_settings` (mig 34), `BPMigrationHistory` |

Conventions: GUID PKs, `snake_case` columns, soft delete `is_deleted` + `is_active`, audit columns `created_*`/`modified_*`. Exceptions: `pln_snapshot` and `gps_event_current` have no `is_deleted`; `pln_stop_school`/`pln_student_school` have none either and are bulk rebuilt (`BU/CLAUDE.md` Persistence section; `BU/scripts/gpsplus-testdata/README.md:545-550`). Source identity columns: `external_guid` on reference tables, `external_id` on snapshot tables (`ETL/.../RouteEntityLoader.cs:126`, `StudentEntityLoader.cs:234`).

**Schema versioning.**
- Two numbering systems coexist: the **base schema version** "v7.xx" (v7.15 ... v7.22; `docs/database/CreateDatabase.md:544-553`) and the **migration version** = 1-based position in `MigrationCatalog.All`.
- Migrations are raw idempotent SQL pairs `NN_Name.up.sql` / `NN_Reverse.down.sql`, not EF migrations; applied state is stored per database in `BPMigrationHistory`, keyed by MigrationId `YYYYMMDDhhmmss_Name` (`BU/BusPlanner.MigrationTool/README.md:3-25`).
- At this commit the catalog holds **75** migrations; last is `20261016000000_SeedOnTimeEarlyThreshold` (`BU/BusPlanner.MigrationTool/MigrationCatalog.cs:13-212`).
- The tool resolves the SQL file by catalog **index**, so a file whose `NN` does not match its position resolves to no file; ids are never renamed, only positions move (`MigrationCatalog.cs:60-69`; `README.md:100-108`).
- `BaselineDetector` probes one schema element per migration; a history row with no matching probe shows as `PhantomApplied` in Verify DB Status (`README.md:48-59`).
- Docs name three different "required" levels: "v7.22" (`docs/infra/etl-deployment-runbook.md:30-31`), "migrations through v18/v19" (`docs/testing/QA-ETL-ManualTests.md:11,38`), and "migrations 01-10 bring a database to v7.22" (`BU/CLAUDE.md`). Treat "all migrations in the catalog applied, zero mismatches" as the testable state.
- Every client DB tracks its own version; migrations must be applied to each target DB separately (`docs/testing/QA-ETL-ManualTests.md:44`). Load and stop classification do not create schema (`docs/infra/onboard-etl-stopclass-client.txt:185-188`), except Load creates `pln_snapshot` and `etl_watermark` if missing (`ETL/BpPro.Etl.Load/Snapshots/SnapshotManager.cs:21-38`).
- The GPS+ synthetic fixture applies migrations by filename and writes **no** `BPMigrationHistory` (`BU/scripts/gpsplus-testdata/README.md:562-566`).

---

## 4. ETL details

**Extract** (`ETL/BpPro.Etl.Extract/Orchestration/ExtractionOrchestrator.cs`)
- Per enabled extraction, in parallel up to `max_parallel_customers` (Helm default 1) (lines 50-77).
- Output folder is `{CosPrefix}/{UtcNow:yyyy-MM-dd}` (98-103). A second run on the same UTC date writes to the same folder.
- Coordinate projection is read from BP Pro `xGeoSetting` (`Setting='Projection'`), falling back to config; if neither exists the customer's extraction **aborts** rather than emitting data with no coordinates (114-157).
- Each successful entity is uploaded as it finishes (199-204). GUID-list files are written for 18 entities (253-279); `staff` is deliberately excluded so the ETL never deletes employees.
- Manifest carries `customer_guid`, `school_year_guid`, `timezone`, per-entity `row_count` + `checksum_sha256`, `status`, and the extraction **start** timestamp (211-219).
- The Redis message is published unless status is `FAILED`; a publish failure is only a warning (228-231, 357-365).
- Extractors filter on `Active = 1` (comment 257-260). `use_avl_vehicles` switches the vehicle source to `BPX_AVLVehicle` + `BPL_AVLVehicleRoute` (176-184).
- Student `ModifiedDate` emitted = later of `BP_Student.ModifyDate` and the newest `BPX_Enrollment.ModifyDate` (`docs/testing/QA-ETL-ManualTests.md:495`; not re-read in `StudentExtractor.cs`).

**Load** (`ETL/BpPro.Etl.Load/Orchestration/LoadOrchestrator.cs`)
- Manifest selection: queue mode handles one message per poll, ignoring non-SUCCESS manifests (`Queue/RedisQueueConsumer.cs:49-104`); polling mode takes only the newest SUCCESS manifest per prefix, falling back to an older day if the newest is PARTIAL/FAILED (`Polling/ManifestPoller.cs:63-117`).
- Validation: SHA-256 checked per entity when the manifest has a checksum; mismatch throws and fails the customer (463-490). An empty checksum is not checked. An entity absent from the manifest is silently skipped (520-526).
- Customer timezone comes from `manifest.Timezone`; unknown or missing falls back to the UTC calendar day with a warning (187-206). It is reset on every loader for every customer because loaders are DI singletons (208-211).
- Phases 1-5 run once; any failed phase throws (256-268).
- Students and student addresses are **incremental**: only records with `ModifiedDate` newer than (`etl_watermark.last_extract_at` - 120 min) are upserted (`EntityLoaders/StudentEntityLoader.cs:68-69`; `BpPro.Etl.Common/Utilities/WatermarkFilter.cs:41-51`). A missing or unparseable `ModifiedDate` is kept (fail-open). A record whose retire/effective date crossed "today" since the cutoff is also reprocessed (`WatermarkFilter.cs:62-79`). All other entities are full MERGE upserts.
- Delete detection after phase 5: rows whose `external_guid` is not in the live list get `is_deleted=1`, `is_active=0` (where the column exists), `modified_by='ETL-DELETE'`. Empty or missing list = no-op (`LoadOrchestrator.cs:659-739`; `Utilities/DeleteDetector.cs:44-54,71`). Admin-created `veh_employee_vehicle` rows (`external_guid IS NULL`) are never touched (684-688).
- Bridges and defaults after phase 5: `pln_school_program` from `school_programs.json`, `pln_school_zone` by `zone_code = school_code` for School-type zones, `veh_vehicle_operator` from vehicles.json, then a per-client "Default Busplanner" depot/operator for vehicles left without one (278-325).
- Snapshots: explicit `snapshot_dates`, otherwise the next 10 Mon-Fri days starting from the **customer-local** today (330-357; `Utilities/SchoolDayCalculator.cs:14-27`). Holidays are not excluded.
- A snapshot is found by (`customer_guid`, `school_year_guid`, `snapshot_date`) and reused; new ones are created `is_active = 0`; a reused one is deactivated for the reload (`Snapshots/SnapshotManager.cs:55-58,173-206`).
- Per snapshot day: optional purge (only when `overwrite_existing_snapshots`; Helm default **false**, `deploy/helm/etl/values.yaml:64`), phase 7, phase 8, rebuild of school-reach links in one transaction, then activation (377-414).
- A record is included on a snapshot day when `EffectiveDate <= day < RetireDate` (retire exclusive), evaluated on the customer's calendar date (`SchoolDayCalculator.cs:39-58`). Runs are also filtered by weekday frequency and student-stop rows by the `Schedule` weekday bitmask (`Utilities/FrequencyFilter.cs`, `ScheduleFilter.cs`; behaviour described in `docs/testing/QA-ETL-ManualTests.md:403-417`).
- Run/stop times are stored as local `DATETIME2` = snapshot date + local time of day; BP Pro time 0 loads as NULL (`docs/testing/QA-ETL-ManualTests.md:515-522`; `Utilities/SnapshotTimeComposer.cs`).
- `pln_stop.external_id` = `{BusStopGUID}:{RunGUID}:{PassNumber}`; a stop on N runs is N rows (`docs/testing/QA-ETL-ManualTests.md:346`; `Utilities/StopKey.cs`).
- Enum maps: run type 0/1/2/3 -> PICKUP/DROPOFF/NOON_PICKUP/NOON_DROPOFF, else OTHER; stop type 0..7 -> PICKUP, DROPOFF, SCHOOL_PICKUP, SCHOOL_DROPOFF, TRANSFER_PICKUP, TRANSFER_DROPOFF, WAYPOINT, TURN_AROUND, else STANDARD (`BpPro.Etl.Common/Utilities/PlanningEnumMapper.cs:17-44`).
- After all days: snapshots outside the window are deactivated (419-420); watermarks `students`, `student_addresses` and `_manifest_loaded` are set to the extraction start time (429-438).

**Idempotency.**
- Durable skip: a manifest whose extract timestamp is `<=` the `_manifest_loaded` watermark is skipped and reported as success (`LoadOrchestrator.cs:154-173`).
- In-memory `IManifestTracker` also skips manifests already processed in this process (`RedisQueueConsumer.cs:76-81`); it is lost on restart.
- All loaders are MERGE upserts keyed on `external_guid` / `external_id` (+ snapshot) (`EntityLoaders/RouteEntityLoader.cs:124-126`, `RunEntityLoader.cs:284-286`, `StopEntityLoader.cs:290-292`, `BusStopStudentEntityLoader.cs:379-381`).
- The spec's "detect existing snapshot and skip" rule (`docs/etl/ETL-Technical-Specification.md:1584-1586`) is not what the code does: an existing snapshot is reused and reloaded.

**Error handling.**
- Fail-fast per phase: the first failed entity stops the phase, the customer load throws, the day's snapshot stays inactive (`LoadOrchestrator.cs:568-573,395-397`).
- There is **no** customer-wide transaction. Rows committed before a failure stay in place until a later purge (`docs/testing/QA-ETL-ManualTests.md:424,444`).
- Retries (3 attempts, exponential from 10 s) only wrap the purge and the link rebuild, and only for SQL errors -2, 1205, 49920 (744-770).
- Delete-detection failures are logged and do not abort the load (733-737).
- Purge disables FK checks on tables referencing `pln_stop` and re-enables them `WITH CHECK CHECK` (`SnapshotManager.cs:375-392,464-490`). Purge also deletes `gps_stop_visited` rows of that snapshot (350-351).
- Queue mode loops forever with a 5 s pause after an unhandled cycle error; polling mode exits (`Services/LoadServiceRunner.cs:44-91`).
- Load holds all entity JSON in memory and re-deserializes snapshot entities per day; memory limit raised to 4Gi because 1Gi ran out mid-loop (`deploy/helm/etl/values.yaml:93-98`).

**Load-test setup** (`docs/etl/ETL-Load-Test-Setup-v7_18.md`, written for schema v7.18, March 2026)
- Two passes: baseline load from a prepared SDCC extract folder, then seed `ta_employee` + `veh_employee_vehicle` and re-run to prove the internal `employee_vehicles` loader copies active assignments into `pln_employee_vehicle` (lines 17-25, 293-478).
- Local mode flags: `UseLocalStorage=true`, `UseLocalQueue=true`, `UseQueueConsumer=false` (105-122).
- Expected row counts for that dataset are tabulated (276-289), e.g. 184 routes, 892 runs, 9406 stops, 36766 students, 63445 student-stops. These predate the 1:N stop change and frequency filtering, so they are a historical baseline, not current expected values (UNVERIFIED against current code).
- Reset script `ETL/schema/cleanup-for-retesting.sql`; seed scripts `ETL/scripts/seed/01..03-*.sql`, `seed-new-customer.sql`.
- Document still lists 7 phases and file paths under `C:\Repository\Unified\src\...` that do not match this repo layout.

---

## 5. GPS reader and substitution import

### 5a. BPGPSReaderService
- **Vendors**: Geotab, Zonar, Synovia, GTS, Samsara; any other `gps_provider_connection.provider` value is skipped with a warning (`BU/BPGPSReaderService/ClientWorker.cs:304-360`).
- **Inputs**: vendor HTTP APIs. Per connection, settings rows such as `ProviderEndPointAddress` (required; connection skipped without it, line 295-299), `ProviderUsername`, `ProviderDatabase`, `ProviderAccountCode`, `StartDateTime`, `EventPollFrequency`, `VehiclePollFrequency`, `APIRateLimit`, sensor input names `IgnitionOnInput`, `DoorInput`, `StopArmInput`, `AmberFlasherInput`, classifier settings `StopSpeed`, `StopArmAutomaticallyAStop`, `ZeroSpeedDoorOpenAutomaticallyAStop` (`docs/database/SetupGPSDownload.md:114-152`; `Pipeline/EventClassifier.cs:61-71`).
- **Start point**: `LatestEventWrittenDateTime` (saved progress) > `StartDateTime` > 24 h ago (`docs/database/SetupGPSDownload.md:300-306`). Incremental polls for Zonar/Synovia/GTS/Samsara also default to 24 h ago (`ClientWorker.cs:430-431,445-446,460-461,475-476`).
- **Common format** (`Models/GpsEvent.cs`): device id, UTC timestamp, lat/long, speed km/h, ignition, door, stop arm, amber lights, heading, odometer miles, engine hours. Heading comes from Zonar only; odometer and engine hours from Geotab only (`Pipeline/EventWriter.cs:146-148`). Samsara reports no ignition (`EventClassifier.cs:98-103`).
- **Filtering**: events for unknown or inactive devices are dropped; same device + same lat/long (6 decimals) within 30 s is a duplicate (`Pipeline/EventProcessor.cs:51-82`).
- **Sensor classifier** (`Pipeline/EventClassifier.cs`), stateful per device across polls:
  - Types: `Live`, `On`, `IgOff`, `Beacon`, `Stop`, `UnknownStop`, `Pullout` (32-38).
  - Zero speed = speed < `StopSpeed` (default 0.1 km/h) (61, 109).
  - Ignition just on -> `On`; just off -> `IgOff`; off -> `Beacon`; on or unknown -> `Live` (129-146).
  - `Pullout` when a stop was in progress and the bus moves (150-153).
  - A stop candidate (door opened at zero speed; stop arm opened at zero speed with the setting on; or reaching zero speed with door/arm already open) is **deferred**, one per vehicle (159-178).
  - Deferred stop resolves when the bus moves, stop arm or amber is on, door closes, ignition is off, or more than 1 minute passes; it becomes `Stop` if stop arm or amber is on or `ZeroSpeedDoorOpenAutomaticallyAStop` is set, else `UnknownStop` (203-216).
  - Ignition turned off below 0.1 km/h -> `UnknownStop` (183-186).
  - A deferred stop older than 10 minutes is force-released as `UnknownStop` (41, 249-261).
- **Write**: speed stored as mph rounded to 1 decimal; timestamps stored in UTC (`EventWriter.cs:117-131`). History insert skips rows already present with the same (`device_guid`, `event_timestamp`, `speed_mph`, `latitude`, `longitude`) (245-252). `gps_event_current` is a MERGE holding one row per device (336-339).
- **Enrichment**: `Stop`/`UnknownStop` events queue for Nominatim reverse geocoding, one shared queue for all clients, 1 request per 1.1 s (`Pipeline/GeocodingWorker.cs:34-37`); `UnknownStop` events queue for geofence reclassification to `School` (via `pln_school_zone`) or `Depot` (via zone type), constant `Check Point` also defined (`Pipeline/GeofenceWorker.cs:45-74`). Each work item carries its own client connection string (`ClientWorker.cs:535-542`). On start, un-geocoded and un-geofenced events newer than the last processed one are re-queued (599-693).
- **Synovia wildcard rule**: per (ProviderCustomerGuid, ProviderAccountCode), a blank-name connection row means "all fleets" and wins; named siblings and extra blank rows are dropped (`ClientWorker.cs:200-268`).
- **Tenant set**: `BPCustomers JOIN BPFeatureFlag WHERE IsDeleted = 0 AND FeatureCode = 'GPS' AND IsEnabled = 1` (`Pipeline/CustomerLoader.cs:52-54`); re-read every 15 minutes, workers started/stopped without restart (`BPGPSReaderService.cs:34,175-199`).

### 5b. BPGPSSubstitutionImportService
- **Inputs** (bearer token, JSON): `GET {BaseUrl}/api/GPSRouteVehicle/Get?active=true`, `GET .../api/LiveData/GetGPSVehicles`, optionally `GET .../api/DriverSchedule/Get?databaseGuid=...` (`BpInfo/BpInfoClient.cs:49,81,116`).
- **Per-client settings** (`app_settings`, `category='BPInfo'`, `customer_guid IS NULL`): `BaseUrl`, `CredentialSecret` (a Secrets Manager secret name), `Enabled` (default true), `WritesEnabled`, `DatabaseGuid`, `ReadBackDryRun` (`Models/BpInfoSettings.cs`; `Data/AppSettingsReader.cs:37`). Read-back mode = On if `WritesEnabled`, else DryRun if `ReadBackDryRun`, else Off (`BpInfoSettings.cs:41-42`).
- **Target snapshot**: the active `pln_snapshot` whose `snapshot_date` equals the customer-local today (timezone from `pln_customer.time_zone`, Eastern fallback); none -> cycle skipped with a warning (`Matching/SubstitutionMatcher.cs:380-423`; `ClientWorker.cs:197-202`).
- **Matching** (`Matching/SubstitutionMatcher.cs:85-92`):
  - RouteID -> `pln_route.route_number` in that snapshot, `external_id IS NOT NULL` (spare routes never match), not deleted (170-179).
  - RunID (optional) -> `pln_run.run_name` in that snapshot (223-227).
  - Vehicle -> `dev_device` by provider-specific rules, then `dev_vehicle_device` valid on the snapshot date, then `veh_vehicle`; newest mapping wins (288-301).
  - Per-provider rules, preferred then fallback (`Matching/ProviderVehicleMatch.cs:26-34`): Geotab/BusPlanner serial -> `device_serial_number`, else AVLVehicleID -> `vehicle_name`; Zonar serial, else ProviderVehicleID -> `device_id` with connection name = Platform; GTS serial, else AVLVehicleID -> `vehicle_name` with name = Platform; Synovia case-insensitive ProviderVehicleID -> `device_id`, else serial; Samsara ProviderVehicleID -> `device_id`, else AVLVehicleID -> `vehicle_name`. Provider `busplanner` searches under the `Geotab` connection (83-88). Unknown provider -> skipped.
  - Unset BP Info dates (0001-01-01) mean effective "since forever" / retire "open-ended" (139, 157).
- **Precedence** (`Matching/SubstitutionPrecedence.cs:11-18`): per run, an active run mapping wins, else an active route mapping, else the ETL-planned bus. R1 newest effective date wins among duplicates; at equal rank a GPS mapping beats a driver reassign, two GPS mappings tie-break on `RouteVehicleGuid` and log a warning (65-104). R2 a route mapping relabels the whole route only if all remaining runs follow it; if only some runs fall in its window only those runs move (107-170). R3 a run move to where the run already goes is dropped (177-201).
- **Writer** (`Writing/SubstitutionWriter.cs:17-33`): Case 1 (whole route) soft-deletes and recreates `pln_route` with the new vehicle, linking via `original_route_guid`; Case 2 (run) soft-deletes and recreates `pln_run` under the target vehicle's route, creating a spare route (Case 2c, `external_id` NULL) if the target bus has none. Each apply is one transaction and also writes `gps_plan_change_history`. Import-written rows carry `substitution_source = 2` and `substitution_flag = 2` (lines 414, 433-434). Idempotent: already-current target = no-op.
- **Reconcile order**: reverts first, then route moves, then run moves, then sweep of empty spare routes (`SubstitutionReconciler.cs:23-28`).
- **Outage behaviour**: a failure fetching mappings or GPS vehicles aborts the cycle before any revert; an **empty** mapping list is valid and triggers reverts (`ClientWorker.cs:168-184`). A failed `DriverSchedule/Get` keeps existing reassign overlays (186-191, 293-303).
- **Driver reassign read-back** (`Matching/RouteReassignPlanner.cs:32-49`): a route whose feed bus differs from its planned bus becomes a whole-day route claim ranked by first-seen time; routes held by Dispatch (`substitution_source = 1`) are skipped; if more routes differ than max(5, 25% of the feed) none is applied.

---

## 6. Stop classification

**What it classifies.** Each GPS event of a mapped vehicle is compared with every planned stop that vehicle has on the event's customer-local service date. Result per (stop, snapshot): one `gps_stop_visited` row holding the best evidence seen.

**Rules** (`BU/BPStopClassificationService/Classification/StopClassifier.cs:15-53`), first match wins:

| Result (`classification_type`, rank) | Distance | Speed < 5 km/h | Door open | Stop arm or amber | Time from schedule |
|---|---|---|---|---|---|
| STOP, 4 | <= 100 m | yes | yes | yes | <= 120 min |
| CHECKPOINT, 3 | <= 75 m | yes | yes | - | <= 120 min |
| VISITED, 2 | <= 75 m | yes | - | - | <= 60 min |
| DRIVEBY, 1 | <= 50 m | - | - | - | <= 60 min |

Thresholds are constants in `BU/BusPlanner.Application/Classification/ClassificationConstants.cs:6-26` (single source of truth per `BU/BusPlanner.Application/Classification/CLAUDE.md`). Note the drive-by radius (50 m) is smaller than the visited radius (75 m): a fast pass at 60 m is not classified at all.
- Distance is haversine; speed is `speed_mph` converted to km/h; NULL speed counts as 0; NULL door/arm/amber count as false (`StopClassifier.cs:17-27`).
- A stop with no scheduled time passes every time window (25-27, 37-38). A candidate more than 6 h from schedule is rejected outright (34-35).
- Rank 0 = MISSED exists as a constant but is never written by the service; missed is the absence of a row (UNVERIFIED for analytics; `ClassificationConstants.cs:19`, `StopClassifier.cs:52`).
- "Serviced" = rank >= 2. `HardSignalMinRank` = 3 splits SERVICED (door seen) from PROBABLE (`ClassificationConstants.cs:26,78`).

**Upsert rule.** MERGE on (`stop_guid`, `snapshot_guid`, not deleted); an existing row is replaced only by a higher rank, or equal rank with smaller distance (`Data/GpsStopVisitedRepository.cs:10-19`). One row per stop per snapshot, whatever the time of the pass.

**Plumbing.**
- Vehicle for an event: `dev_vehicle_device` with `effective_date <= event date` and (`retire_date` NULL or `> event date`), TOP 1; unmapped events are counted, not classified (`Data/GpsEventReader.cs:82-91`; `ClientWorker.cs:240`).
- Service date: event UTC -> customer local date using `pln_customer.time_zone` (default `America/New_York`) (`Data/StopLookupService.cs:25-27,68-80`).
- Snapshot: exact `snapshot_date = service date` within the school-year term, preferring active then newest (`StopLookupService.cs:104-116`). Stops are reached through the substitution lineage (`original_route_guid` / `original_run_guid`).
- Scheduled time: local `stop_scheduled_time` converted to a full UTC instant with `AT TIME ZONE` (186).
- Stop cache per (vehicle, local date); cleared on UTC day rollover; vehicles in `gps_plan_change_history` are evicted each poll (`ClientWorker.cs:213-219,227`).
- Real time: reads up to 5000 events with `event_timestamp > lastProcessed`, ordered by time (`GpsEventReader.cs:57,90-91`). Starts at now - 5 min on every start (`ClientWorker.cs:110-112`).
- Historical mode (`StopClassification:HistoricalMode=1`, `HistoricalDateFrom`, optional `HistoricalDateTo`): hour by hour per vehicle, then real time if `DateTo` is empty. Settings are global: every client backfills the same range (`ClientWorker.cs:127-192`; `README.md:24`).
- Tenant set is read once at start; there is no reconcile loop, so a newly flagged client needs a restart (`StopClassificationWorker.cs:91`; `ClientWorker.cs:100-102`).
- Missing or unusable configuration stops the host by design (`README.md:35-36`).

---

## 7. Domain glossary (as the code and schema use the terms)

| Term | Meaning here |
|---|---|
| BP Pro / BusPlanner Pro | Legacy planning product; one SQL Server DB per customer and school year; source of plan data |
| Unified DB / "new world" | The per-client target database of this platform |
| Client / tenant / customer | A school transportation customer. `ClientCode` (registry, login slug) vs `customer_code` / `customer_guid` (`pln_customer`, ETL) |
| Client_Registry | Catalog DB mapping client codes to servers/databases and feature flags |
| Operator | Bus company operating vehicles (`opr_operator`) |
| Depot | Vehicle yard (`pln_depot`); "Default Busplanner" is the ETL-seeded fallback depot/operator |
| Snapshot | The plan for one calendar date (`pln_snapshot`); routes, components, runs, stops, student-stops are copied per snapshot |
| Route | A vehicle's work for a day; `route_number` = BP Pro RouteID |
| Component | A part of a route (AM/PM/noon grouping; `component_type`) holding runs |
| Run | One trip; `run_type` PICKUP/DROPOFF/NOON_PICKUP/NOON_DROPOFF/OTHER; `run_name` = BP Pro RunID |
| Stop | A stop instance on one run and pass; `stop_type` from the 9-value vocabulary |
| Pass number | Distinguishes repeat visits of one physical stop on a run (part of the stop key) |
| Student stop | Assignment of a student to a stop with school and program (`pln_student_stop`) |
| Enrollment / MAIN enrollment | Student-school-grade-program link; the Main type decides `is_primary_program` |
| Program | Education program (regular, special ed ...); customer-scoped, linked to schools by `pln_school_program` |
| Zone / zone type | Geographic polygon (school zone, depot zone) used for geofencing |
| Bell time | School start/end window (`pln_bell_time*`) |
| Effective / retire date | Validity window; retire date is exclusive |
| Frequency / Schedule | Weekday bitmasks on runs and student-stop assignments |
| External guid / external id | The BP Pro GUID (or composite) of a row; the upsert key |
| Manifest | Summary JSON of one extract: entities, counts, checksums, status SUCCESS/PARTIAL/FAILED |
| Watermark | Last fully loaded extraction start per customer and entity (`etl_watermark`) |
| Guid list | `<entity>_guids.json`: full set of active source GUIDs used for delete detection |
| GPS provider connection | One vendor account for a client (`gps_provider_connection`) |
| Device / vehicle-device mapping | Tracker (`dev_device`) and its dated assignment to a bus (`dev_vehicle_device`) |
| Event classification | Sensor-based label on a GPS event: Live, On, IgOff, Beacon, Stop, UnknownStop, Pullout, School, Depot |
| Stop visited | Best GPS evidence that a planned stop was reached: DRIVEBY, VISITED, CHECKPOINT, STOP |
| Serviced / Probable | Rank >= 2 is serviced; rank 2 alone is "probable" (no door signal) |
| BP Info | Legacy REST service of a client exposing live GPS mappings and driver schedule |
| Substitution / overlay | A same-day change of bus for a route (Case 1) or run (Case 2) written over the ETL plan |
| Spare route (Case 2c) | Route created for a bus that had none; `external_id` NULL |
| Driver reassign / read-back | A driver change made in the Live Viewer, sent to BP Info and read back as a route move |
| Dispatch | Another writer of substitutions (`substitution_source = 1`); it outranks the import |
| AVL vehicle | BP Pro's GPS-side vehicle record (`BPX_AVLVehicle`); optional vehicle source for the extract |
| GPS+ / Live Viewer | The product area reading `gps_live_fleet_v` |

---

## 8. Business and data rules (testable)

ETL
1. BP Pro run type 0, 1, 2, 3 loads as PICKUP, DROPOFF, NOON_PICKUP, NOON_DROPOFF; any other value loads as OTHER. (`ETL/BpPro.Etl.Common/Utilities/PlanningEnumMapper.cs:17-24`)
2. BP Pro stop type 0-7 loads as the eight named stop types; null or other loads as STANDARD. (`PlanningEnumMapper.cs:33-44`)
3. A `stops.json` without `source_stop_type` fails the load instead of loading STANDARD. (`docs/testing/QA-ETL-ManualTests.md:216-223`; `ETL/BpPro.Etl.Tests/Common/StopDtoJsonRequiredTests.cs`)
4. A record is on a snapshot day only when effective date <= day < retire date, in the customer's calendar. (`ETL/BpPro.Etl.Load/Utilities/SchoolDayCalculator.cs:39-58`)
5. With no explicit dates, Load maintains snapshots for the next 10 weekdays from the customer-local today. (`SchoolDayCalculator.cs:14-27`; `LoadOrchestrator.cs:346-351`)
6. A snapshot is active only after all its phase 7/8 data and link rebuild have completed. (`LoadOrchestrator.cs:410-413`)
7. After a successful load, active snapshots of that customer and school year outside the window are deactivated. (`LoadOrchestrator.cs:419-420`)
8. A manifest with status other than SUCCESS is never loaded. (`RedisQueueConsumer.cs:98-104`; `ManifestPoller.cs:93-100`)
9. A manifest whose extraction time is not newer than the last fully loaded one is skipped. (`LoadOrchestrator.cs:159-173`)
10. An entity file whose SHA-256 differs from the manifest fails the customer load. (`LoadOrchestrator.cs:473-480`)
11. A row deleted or deactivated in BP Pro becomes `is_deleted = 1` and `is_active = 0` in the Unified DB on the next load. (`DeleteDetector.cs:44-54`)
12. An empty or missing guid list never deletes anything. (`DeleteDetector.cs:71`; `LoadOrchestrator.cs:700-720`)
13. The ETL never soft-deletes `ta_employee` rows. (`ExtractionOrchestrator.cs:275-277`; `LoadOrchestrator.cs:684-686`)
14. Students and addresses unchanged since the watermark minus 120 minutes are not rewritten. (`StudentEntityLoader.cs:68-69`)
15. The watermark advances to the extraction start time and only after every phase succeeded. (`LoadOrchestrator.cs:425-438`)
16. A stop served by N runs or passes on a day appears as N `pln_stop` rows in that snapshot. (`docs/testing/QA-ETL-ManualTests.md:326-347`)
17. Run and stop times equal the BP Pro local wall-clock time on the snapshot date; a source time of 0 is NULL. (`docs/testing/QA-ETL-ManualTests.md:515-522`)
18. Extraction aborts for a customer when no coordinate projection can be resolved. (`ExtractionOrchestrator.cs:148-157`)
19. `route_number`, `run_name`, `component_name`, `stop_name` carry the BP Pro IDs and no `*_name` is blank. (`docs/testing/QA-ETL-ManualTests.md:147-181`)
20. `customer_guid` and `school_year_guid` must be pre-seeded and identical in every environment for a client. (`ETL/docs/ETL-Extract-Installation-Rulebook.md:27-33`)

GPS reader
21. Two events of one device at the same 6-decimal position within 30 s produce one row. (`BU/BPGPSReaderService/Pipeline/EventProcessor.cs:61-80`)
22. Events from devices not known as active are not written. (`EventProcessor.cs:51-59`)
23. Re-reading an already loaded time range inserts no duplicate history rows. (`Pipeline/EventWriter.cs:245-252`)
24. `gps_event_history.event_timestamp` is UTC. (`EventWriter.cs:117-127`)
25. A provider that reports no ignition never yields On, IgOff or Beacon. (`Pipeline/EventClassifier.cs:98-146`)
26. A deferred stop with stop arm or amber on resolves to Stop; otherwise UnknownStop unless `ZeroSpeedDoorOpenAutomaticallyAStop` is true. (`EventClassifier.cs:211-216`)
27. A deferred stop unresolved for 10 minutes is released as UnknownStop. (`EventClassifier.cs:41,249-261`)
28. A client is ingested only while its `GPS` feature flag is enabled; a change takes effect within 15 minutes. (`Pipeline/CustomerLoader.cs:52-54`; `BPGPSReaderService.cs:34`)

Stop classification
29. STOP needs <= 100 m, speed < 5 km/h, door open, stop arm or amber, and <= 120 min from schedule. (`StopClassifier.cs:40-41`; `ClassificationConstants.cs:6,12,15`)
30. DRIVEBY needs only <= 50 m and <= 60 min from schedule. (`StopClassifier.cs:49-50`)
31. A fleet without door telemetry can never exceed VISITED. (`ClassificationConstants.cs:71-75`)
32. A better-ranked, or equally ranked but closer, event replaces the stored visit; a worse one never does. (`GpsStopVisitedRepository.cs:15-19`)
33. An event matches only stops of the snapshot dated the event's customer-local date. (`StopLookupService.cs:25-27,110-115`)
34. An event from a device with no dated vehicle mapping is counted as "no vehicle mapping" and not classified. (`ClientWorker.cs:240,258-262`)

Substitution import
35. A run mapping beats a route mapping, which beats the planned bus. (`SubstitutionPrecedence.cs:11-12`)
36. Between two mappings for the same route or run, the later effective date wins. (`SubstitutionPrecedence.cs:60-76`)
37. When BP Info returns no active mappings, existing import overlays are reverted. (`BU/BPGPSSubstitutionImportService/ClientWorker.cs:183-184`)
38. When BP Info cannot be reached, nothing is reverted that cycle. (`ClientWorker.cs:173-177`)
39. A substitution is applied only to the active snapshot dated the customer-local today. (`SubstitutionMatcher.cs:420-421`)
40. If more routes differ from plan than max(5, 25% of the driver feed), no driver reassign is applied. (`RouteReassignPlanner.cs:48-49`)

Migrations
41. Every migration is safe to apply twice. (`BU/BusPlanner.MigrationTool/README.md:61-71`)
42. Each migration's file number equals its 1-based position in `MigrationCatalog.All`. (`MigrationCatalog.cs:60-69`)

---

## 9. Existing tests and manual QA; gaps

**Automated**
- `ETL/BpPro.Etl.Tests` (xUnit): Common (time decoders, checksum, deterministic GUID, enum mapper, lifecycle mapper, truncation, watermark filter, `StopDtoJsonRequired`), Extract (config provider, orchestrator, manifest generator), Load (orchestrator, phase definition, manifest poller, Redis consumer, delete detector, frequency/schedule filters, school-day calculator, snapshot time composer, stop key, student-stop program resolver, 10 entity/bridge loaders), `Integration/QueueIntegrationTests`. Run in CI by `pipelines/backend-deploy-etl-dev.yml:66`. The audit quotes "314 ETL tests green" as of 2026-07-09 (`ETL/docs/ETL-Data-Correctness-Audit-2026-07-07.md:24`); current count not verified.
- `BU/BusPlanner.Tests.Unit/StopClassification/` (`StopClassifierTests`, `StopClassifierBatchTests`, `ClassificationComparerTests`); run by `pipelines/templates/stop-classification-build.yml:27`.
- `BU/BusPlanner.Tests.Unit/SubstitutionImport/` (`SubstitutionPrecedenceTests`, `RouteReassignDiffTests`, `ReassignOutcomeTests`) and `BU/BusPlanner.Tests.Integration/SubstitutionImport/` (`TodaySnapshotTests`, `RouteReassignTests`, `PrecedenceReconcileTests`, `MatcherCoverageTests`).
- `BU/BusPlanner.Tests.Unit/Persistence/MigrationCatalogConsistencyTests.cs` (catalog vs files).
- GPS+ seeded integration tests (`BusPlanner.Tests.Integration/Seeded/GpsPlus*`) build `BusPlanner_Unified_GpsPlusTests` from DDL + migrations and gate on `VerifyGpsPlusLiveViewer.sql` (`BU/scripts/gpsplus-testdata/README.md:94-114`). Integration tests need `BP_TEST_SQL_CONNECTION` or `BP_TEST_SQL_SERVER`; they create and drop databases (`BU/CLAUDE.md`).

**Manual**
- `docs/testing/QA-ETL-ManualTests.md`: Section 0 end-to-end run procedure and smell-test SQL; TC-ETL-001..003 (run type), 010/011 (names), 020/021 (stop type), 030/031 (time display), 040 (run sequence), 050/051 (deletes), 060..065 (cardinality, program, partial week), 070/072 (load isolation), 080/081 (EF alignment), 090..092 (watermark), 110..113 (time, GPS matching, abort hardening, lifecycle). Each section is tagged SHIPPED / PARTIAL / PENDING. Always scope snapshot-table queries to the snapshot under test (line 54).
- `docs/etl/ETL-Load-Test-Setup-v7_18.md`: two-pass load test (section 4 above).
- `BU/BPStopClassificationService/README.md:38-124`: inject one synthetic `gps_event_history` row at a planned stop, run one poll, expect `STOP`, rank 4, distance ~0, then delete both rows.
- `docs/infra/etl-deployment-runbook.md:207-219` and `onboard-etl-stopclass-client.txt:301-331`: deployment verification (log lines, row counts, storage listing).
- `docs/database/SetupGPSDownload.md:270-294`: GPS reader data verification queries.
- `BU/scripts/gpsplus-testdata/`: controlled fixture with named scenarios for the Live Viewer and Event Viewer.

**Gaps**
- No automated tests reference `BPGPSReaderService` classes (`EventClassifier`, `EventProcessor`, `EventWriter`, provider services) or `BPClientRegistry` (`ClientDirectory`, `DbCredentialProvider`): a Grep of all `*Tests*.cs` found none.
- No end-to-end ETL test against real SQL Server in the ETL test project is evident (loader tests' DB usage not inspected; UNVERIFIED). The audit itself says MERGE runtime behaviour cannot be seen statically (`ETL-Data-Correctness-Audit-2026-07-07.md:52`).
- The GPS+ fixture does **not** test the matching algorithm: its `gps_stop_visited` rows are written by the seed, not by the classifier (`BU/scripts/gpsplus-testdata/README.md:450-458`).
- Fixture limits: one vendor (Geotab), one timezone, static positions, untrustworthy on the two DST days, cancelled runs unrepresentable (`README.md:519-532`).
- Atomic rollback of a failed load is PENDING; TC-ETL-070 documents the expected partial state (`QA-ETL-ManualTests.md:422-445`).
- Two known completeness gaps need a periodic full reload: student edits that bump no ModifyDate, and address re-geocoding (`QA-ETL-ManualTests.md:507`).
- No test or doc covers migration down-scripts beyond the README's manual checklist (UNVERIFIED that none exist elsewhere).
- No documented test for Samsara or GTS ingestion; the setup guide covers only Geotab and Zonar.

---

## 10. Risk notes for QA

| # | Risk | Detail | Source |
|---|---|---|---|
| 1 | Partial load left behind | No customer-wide transaction; rows committed before a failure remain in an inactive snapshot until a later purge | `ETL/BpPro.Etl.Load/Orchestration/LoadOrchestrator.cs:568-573`; `docs/testing/QA-ETL-ManualTests.md:444` |
| 2 | Stale rows inside a reloaded snapshot | Purge runs only when `overwrite_existing_snapshots` is true; Helm default is false, so a nightly reload is MERGE-only. Whether rows removed from BP Pro then linger in an existing snapshot depends on each loader (UNVERIFIED) | `deploy/helm/etl/values.yaml:64`; `LoadOrchestrator.cs:379-385` |
| 3 | Purge deletes GPS results | Purging a snapshot also deletes its `gps_stop_visited` rows; they return only via a historical backfill | `ETL/BpPro.Etl.Load/Snapshots/SnapshotManager.cs:350-351` |
| 4 | Queue message loss | The message is popped (RPOP) before the load; a failed load or a pod crash does not re-queue it. Recovery is the next extract (nightly or manual) | `ETL/BpPro.Etl.Common/Services/RedisQueueClient.cs:54`; `Queue/RedisQueueConsumer.cs:117-120` |
| 5 | Silent non-publish | A Redis publish failure after a good extract is only a warning; in queue mode nothing loads that night | `ETL/BpPro.Etl.Extract/Orchestration/ExtractionOrchestrator.cs:357-365` |
| 6 | Duplicate or competing loads | More than one Load replica on a client queue is unsupported; same for stop classification | `docs/infra/etl-deployment-runbook.md:258,355` |
| 7 | Same-day extract overwrite | Output path uses the UTC date, so two extracts on one UTC day share a folder, and a client west of UTC can straddle two folders in one local evening | `ExtractionOrchestrator.cs:98-103` |
| 8 | Stale binaries or stale JSON | Version skew between Extract and Load produced the "all stops STANDARD" incident; `dev-latest` image tag can resolve to a cached image | `docs/testing/QA-ETL-ManualTests.md:225`; `docs/infra/onboard-etl-stopclass-client.txt:177-180` |
| 9 | Tenant mix-up: wrong database | Source and target DBs are chosen only by the client Secret; `source.databaseName` in values is a label and can disagree with the real connection; target GUIDs must exist in that target DB | `docs/infra/etl-deployment-runbook.md:118-132`; `onboard-etl-stopclass-client.txt:413-415` |
| 10 | Tenant mix-up: global tables | `pln_student`, `veh_vehicle`, `opr_operator`, bell-time and enrollment-type delete detection are not customer-scoped; two customers in one DB would delete each other's rows | `ETL/BpPro.Etl.Load/Utilities/DeleteDetector.cs:17-21`; `LoadOrchestrator.cs:664-689` |
| 11 | Tenant mix-up: singleton loader state | Loaders are DI singletons; timezone, watermark and guid-list path are reset per customer precisely because they once leaked | `LoadOrchestrator.cs:208-211,224-228` |
| 12 | Mass soft-delete | Delete detection trusts the guid list; a truncated but non-empty list from a "SUCCESS" extract would soft-delete live rows | `DeleteDetector.cs:59-61` |
| 13 | Timezone: three representations | Plan times are customer-local `DATETIME2`; GPS events are UTC; `pln_customer.time_zone` holds a Windows id after migration 35 (IANA before), and `AT TIME ZONE` rejects IANA ids | `BU/BusPlanner.MigrationTool/MigrationCatalog.cs:251`; `BU/BPStopClassificationService/README.md:79-80`; `BU/scripts/gpsplus-testdata/README.md:538-544` |
| 14 | Timezone fallbacks hide misconfiguration | Unknown manifest timezone -> UTC day; missing `pln_customer.time_zone` -> Eastern in stop classification and substitution import | `LoadOrchestrator.cs:194-206`; `BU/BPStopClassificationService/Data/StopLookupService.cs:68-76`; `BU/BPGPSSubstitutionImportService/Matching/SubstitutionMatcher.cs:385-387` |
| 15 | DST | `AT TIME ZONE` and the C# conversion disagree on the spring-forward gap and fall-back overlap; pre-migration-18 rows may hold 1900-01-01 dates | `BU/scripts/gpsplus-testdata/README.md:530-532`; `ClassificationConstants.cs:255-261` |
| 16 | Snapshots on non-school days | Window is every weekday; holidays get a plan, and analytics must infer "operated" days from GPS volume | `SchoolDayCalculator.cs:14-27`; `ClassificationConstants.cs:92-96` |
| 17 | Classification gap after restart | Real-time classification restarts at now - 5 min; events written while the service was down are never classified without a backfill | `BU/BPStopClassificationService/ClientWorker.cs:110-112` |
| 18 | Late-arriving GPS events | The reader is selected by `event_timestamp > lastProcessed`; an event inserted later with an older timestamp is skipped | `BU/BPStopClassificationService/Data/GpsEventReader.cs:90-91`; `ClientWorker.cs:257` |
| 19 | Classification stall | An exception inside a batch leaves the watermark unadvanced, so the same batch is retried every poll; one bad vehicle can stall a client with only a log line | `StopLookupService.cs:192-203`; `ClientWorker.cs:269-272` |
| 20 | New GPS client not picked up | Stop classification and (UNVERIFIED) substitution import read the tenant list only at start; the reader reconciles every 15 min | `BU/BPStopClassificationService/StopClassificationWorker.cs:91` |
| 21 | "0 classifications" is ambiguous | Live buses are often outside the time window; absence of matches is not proof of a defect and not proof of health | `BU/BPStopClassificationService/README.md:40-43` |
| 22 | GPS classifier state is in memory | Deferred stops and per-vehicle sensor state are lost on restart; ignition is re-seeded for Geotab only | `BU/BPGPSReaderService/Pipeline/EventClassifier.cs:21-23`; `ClientWorker.cs:315-317` |
| 23 | GPS backfill gaps | Incremental polls for four vendors fall back to 24 h ago when no progress timestamp exists; an outage longer than that loses data unless `StartDateTime`/progress is reset | `BU/BPGPSReaderService/ClientWorker.cs:430-431` |
| 24 | Shared geocoding queue | One Nominatim queue at about 1 request per second for all clients; a busy client delays addresses for the others. Coordinates of stop events are sent to a public OpenStreetMap service | `BU/BPGPSReaderService/Pipeline/GeocodingWorker.cs:34-37` |
| 25 | Duplicate device mapping | One tracker mapped to two buses yields two fleet rows on one position; stop classification picks one mapping arbitrarily (TOP 1 without ORDER BY) | `BU/scripts/gpsplus-testdata/README.md:489-493`; `GpsEventReader.cs:82-89` |
| 26 | Substitution on name matches | Routes and runs are matched by `route_number` / `run_name` with TOP 1; duplicate names in a snapshot resolve arbitrarily | `SubstitutionMatcher.cs:170-179,223-227` |
| 27 | Substitution vs nightly ETL | Overlays are written into the same snapshot rows the ETL reloads; interaction when Load reloads today's snapshot mid-day was not traced (UNVERIFIED) | `SubstitutionMatcher.cs:31-36,412-413` |
| 28 | Migration renumbering | A DB that ran a migration under an old number has a stale `Version`; file/position mismatch resolves to no file; migration 50 drops columns and has a merge gate | `BU/BusPlanner.MigrationTool/README.md:88-126`; `MigrationCatalog.cs:104-108` |
| 29 | Destructive scripts | Base DDL drops and recreates the database; `cleanup-for-retesting.sql` deletes all planning data; the GPS+ build script drops its target and writes to the shared Client Registry | `docs/database/CreateDatabase.md:135,527`; `BU/scripts/gpsplus-testdata/README.md:71-78` |
| 30 | Personal data | Extract JSON in object storage contains student data; restored district copies hold real children's records | `docs/infra/onboard-etl-stopclass-client.txt:153-154`; `BU/scripts/gpsplus-testdata/README.md:253-257` |
| 31 | Memory pressure | Load keeps all JSON in memory for the 10-day loop; out-of-memory mid-loop leaves some days loaded and others not | `deploy/helm/etl/values.yaml:93-98` |

---

## Not determined from the repo
- Where `BPGPSReaderService` and `BPGPSSubstitutionImportService` actually run per environment (VM vs cluster) and their deployment config.
- Whether a nightly MERGE-only reload (no purge) removes rows that disappeared from BP Pro inside an existing snapshot.
- `MigratorService` transaction behaviour per migration (docs say "in a transaction", `docs/database/CreateDatabase.md:71`; code not read).
- DDL of `Client_Registry` (the docs link `docs/database/Client_Registry.sql`; file not confirmed present).
- Current number of ETL tests and whether loader tests hit a real database.
- Purpose and status of `BU/Migrations/*.sql` (three dated scripts outside the tool).
- Contents of service `appsettings.json` files were intentionally not read (possible secrets).
