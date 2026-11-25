# ETL mapping sheet - full text copy

Verbatim row text of `BusPlanner-ETL-Source-to-Target-Mapping.xlsx` (Shikhar Patel, shared 2026-11-23), sheet "ETL Mapping", 405 rows, copied 2026-11-24. The SharePoint file is the master; re-copy it when it changes. Summary and QA flags: `etl-mapping-sheet.md`.

Format per column row: `column | type | null | source table(s) | source column | join/filter | transformation | notes`.

## PLANNING - pln_ (30 tables)

### 1a. Route / trip core

#### pln_route
- external_id | NVARCHAR (uniqueidentifier) | N | BPX_Route | RouteGUID | — | direct (dto.SourceGuid) | Natural key; MERGE match on external_id + snapshot_guid
- route_name | NVARCHAR(100) | N | BPX_Route | Description (→ RouteID fallback) | — | first non-blank(Description, RouteID) ?? 'Unknown'; trunc 100 | NOT NULL in new world
- route_number | NVARCHAR(50) | Y | BPX_Route | RouteID | — | trunc 50 |
- route_description | NVARCHAR(500) | Y | BPX_Route | Description | — | trunc 500 |
- vehicle_guid | uniqueidentifier | Y | BPX_Route → BPL_AVLVehicleRoute → BPX_AVLVehicle → BPX_Vehicle → veh_vehicle | BPX_Vehicle.VehicleGUID → veh_vehicle.external_guid | AVL row ACTIVE at extract run (ENG-3177): EffectiveDate<=now, not retired; VehicleID=AVLVehicleID trim/ci, Active=1; then FK lookup | NULL if unresolved | Test: future-dated AVL row must NOT be picked
- operator_guid | uniqueidentifier | Y | BPX_Route → opr_operator | OperatorGUID → opr_operator.external_guid | FK lookup by external_guid | NULL if unresolved |
- snapshot_guid | uniqueidentifier | N | (ETL-generated) | — | — | current extraction snapshot | Scopes route to the snapshot; not from source
- is_active | bit | N | (constant) | — | — | 1 |
- is_deleted | bit | N | (constant) | — | — | 0 | Soft-delete handled by DeleteDetector
- created_by | NVARCHAR | Y | BPX_Route | CreateUser | — | direct |
- modified_by / modified_date | NVARCHAR / datetime2 | N | (ETL) | — | — | ETL user / SYSUTCDATETIME() | Audit stamp
- (extracted, NOT loaded) | BPX_Route | SifGUID, Instruction, AnnualEstimatedCost, ContractGUID, DeadheadMethodGUID, Regular, SpecialEd, Protected, TrackedByGPS, EffectiveDate, RetireDate | Effective/Retire used only for snapshot-validity filter (SchoolDayCalculator); rest not persisted | Confirm with QA whether any are needed

#### pln_run
- external_id | NVARCHAR(100) | N | BPX_Run | RunGUID | — | direct (dto.SourceGuid) | Natural key; MERGE on external_id + snapshot_guid
- route_guid | uniqueidentifier | N | BPX_Run → BP_RunV → BPL_RunVComponentV → BPX_ComponentV → BPX_Component → pln_route | BPX_Component.RouteGUID → pln_route.external_id → route_guid | 5-table chain; rvc.Type=0 = primary component; FK lookup in snapshot | NOT NULL FK; run SKIPPED if unresolved |
- component_guid | uniqueidentifier | N | … BPX_Component → pln_component | BPX_Component.ComponentGUID → pln_component.external_id → component_guid | same chain; FK lookup in snapshot | NOT NULL FK; run SKIPPED if unresolved |
- run_name | NVARCHAR(100) | N | BPX_Run | RunID (→ Description fallback) | — | first non-blank(RunID, Description) ?? 'Unknown'; trunc 100 | NOT NULL
- run_description | NVARCHAR(500) | Y | BPX_Run | Description | — | trunc 500 |
- run_sequence | int | N | BPL_RunVComponentV | [Order] | — | default 0 | Audit RUNS-014 (was selected, never mapped)
- run_type | NVARCHAR(20) | N | BPX_Run | Type (smallint) | — | 0=PICKUP,1=DROPOFF,2=NOON_PICKUP,3=NOON_DROPOFF, else OTHER; trunc 20 |
- run_start_time | datetime2 | Y | BP_RunV | StartTime (int secs) | — | INT secs → HH:mm:ss at extract; + snapshot date → local DATETIME2 (no UTC shift, RUNS-015) |
- run_end_time | datetime2 | Y | BP_RunV | EndTime (int secs) | — | same as run_start_time |
- path | geography | Y | GEO_Run | Line (UTM WKB) | LEFT JOIN GEO_Run ON rv.GEOObjID=gr.ObjID | UTM WKB → WGS84 WKT at extract; STGeomFromText(…,4326).MakeValid() at load; unloadable → NULL (NEWSK-01) |
- lock_flag | smallint | N | BP_RunV | LockFlag | — | bitmask 1=START_LOCKED, 2=END_LOCKED; clamp 0..3 else 0 (RUNS-026) | Substitution feature
- is_active | bit | N | BPX_Run | Active | WHERE r.Active = 1 | direct |
- is_deleted | bit | N | (constant) | — | — | 0 |
- created_by / modified_by / modified_date | (ETL) | 'ETL' / 'ETL' / SYSUTCDATETIME() |
- (filter only, NOT loaded) | BPX_Run / BP_RunV | EffectiveDate, RetireDate, Frequency, Regular, SpecialEd, Protected | Eff/Retire → snapshot-validity (SchoolDayCalculator); Frequency → day-of-week (FrequencyFilter); multiple RunV per RunGUID = day variations, last wins after filter
- (extracted, NOT loaded) | BPX_Run | SifGUID, Instruction, RunVGUID | join / identity only; not persisted

#### pln_component
- external_id | NVARCHAR | N | BPX_Component | ComponentGUID | — | direct (dto.SourceGuid) | Natural key; MERGE on external_id + snapshot_guid
- route_guid | uniqueidentifier | N | BPX_Component → pln_route | RouteGUID → pln_route.external_id → route_guid | FK lookup in snapshot | NOT NULL FK; component SKIPPED if unresolved |
- component_name | NVARCHAR(100) | N | BPX_Component | ComponentID (→ Description fallback) | — | first non-blank(ComponentID, Description) ?? 'Unknown'; trunc 100 | NOT NULL; no *_number col so legacy ID lives here
- component_type | NVARCHAR(50) | Y | BPX_ComponentType | Name | LEFT JOIN ct ON c.ComponentTypeGUID | trunc 50 (widened 20→50, COMPON-015) |
- component_sequence | int | N | BPX_Component | SortOrder | — | default 0 |
- is_active 1 / is_deleted 0 (constants); created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME()
- (extracted, NOT loaded) | BPX_ComponentV | ComponentVGUID, PreDepotGUID, DepotDriverCheckInTime, DepotDepartTime, DepotDriverCheckOutTime, Frequency | INNER JOIN cv ON c.ComponentGUID | extracted into components.json but pln_component (v7.18) has no columns for depot times / predepot / frequency | Confirm with QA

#### pln_stop
- external_id | NVARCHAR(150) | N | BP_BusStop (+ BPX_Run) | {BusStopGUID}:{RunGUID}:{PassNumber} | — | composite key (StopKey) preserves legacy 1:N stop→run; uses source RunGUID | Natural key; MERGE on external_id + snapshot_guid
- run_guid | uniqueidentifier | N | BP_BusStop → BPL_BusStopRunV → BP_RunV → BPX_Run → pln_run | BPX_Run.RunGUID → pln_run.external_id → run_guid | LEFT JOINs; FK lookup in snapshot | NOT NULL FK; stop with no run assignment SKIPPED |
- stop_name | NVARCHAR(200) | N | BP_BusStop | BusStopID (→ Description fallback) | — | BusStopID ?? Description ?? 'Unknown'; trunc 200 | NOT NULL; legacy ID preserved here
- stop_description | NVARCHAR(500) | Y | BP_BusStop | Description | — | trunc 500 |
- stop_type | NVARCHAR(20) | N | BPX_BusStopType (via BP_BusStop.Type) | Type | — | 0=Pickup,1=DropOff,2=SchoolPU,3=SchoolDO,4=TransferPU,5=TransferDO,6=WayPoint,7=TurnAround → string | [JsonRequired]: missing key fails load loudly
- latitude / longitude | DECIMAL(9,6) | — | Geo_Node | Point (UTM WKB) | LEFT JOIN gn ON bs.GEOObjID=gn.ObjID | UTM WKB → WGS84 lat/lon at extract | Stop SKIPPED if lat/long NULL
- stop_sequence | int | N | BPL_BusStopRunV | [Order] | — | default 0 |
- pass_number | smallint | N | BPL_BusStopRunV | PassNumber | — | default 0; part of composite external_id |
- stop_scheduled_time | datetime2 | Y | BPL_BusStopRunV | [Time] (int secs) | — | INT secs → HH:mm:ss at extract; + snapshot date → local DATETIME2 (STOPS-015) |
- stop_planned_time | datetime2 | Y | (none) | — | — | DTO field exists but extractor never populates it | FLAG for QA: currently always NULL — confirm intended
- is_right_side | bit | N | BPL_BusStopRunV | IsRHS | — | NULL→false | Substitution feature
- is_manual | bit | N | BPL_BusStopRunV | IsManual | — | NULL→false | Substitution feature
- is_active | bit | N | BP_BusStop | Active | WHERE bs.Active = 1 | direct |
- is_deleted 0; created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME() | source CreateUser extracted but not carried
- (filter only, NOT loaded) | BP_BusStop / BP_RunV | EffectiveDate, RetireDate, RunV.Frequency | Eff/Retire → snapshot-validity; RunVFrequency → day-of-week (FrequencyFilter)

#### pln_student_stop
- external_guid | uniqueidentifier | N | BPL_BusStopStudent (+ Program) | synthetic: GEO composite + StudentGUID + ProgramGUID | — | ComposeExternalGuid — program included so MAIN + special-program at one stop = 2 rows (BUSSTO-018/029) | Identity; row SKIPPED if GEO ObjID null
- snapshot_guid | uniqueidentifier | N | (ETL) | current snapshot
- stop_guid | uniqueidentifier | N | BPL_BusStopStudent → BP_BusStop → pln_stop | BusStopGUID (via GEO composite JOIN) → pln_stop (BusStopGUID prefix, first instance) → stop_guid | FK lookup | NOT NULL FK; SKIPPED if unresolved
- student_guid | uniqueidentifier | N | BPL_BusStopStudent → BP_Student → pln_student | StudentID → BP_Student.StudentGUID → pln_student.external_guid → student_guid | LEFT JOIN on StudentID; FK lookup | NOT NULL FK; SKIPPED if unresolved
- program_guid | uniqueidentifier | Y | BPL_RecordProgram → BPX_Program → pln_program | (enrollment's own) ProgramGUID → pln_program.external_guid → program_guid | OUTER APPLY TOP 1 WHERE rp.RecordGUID = EnrollmentGUID ORDER BY Name | NULL kept (ENG-2747); never guessed from school
- is_primary_program | bit | N | BPX_Enrollment | EnrollmentTypeGUID | — | true when legacy MAIN enrollment type (StudentStopProgramResolver) | distinguishes MAIN vs special-program row
- school_guid | uniqueidentifier | N | BPL_BusStopStudent → BPX_Enrollment → pln_school | EnrollmentGUID → BPX_Enrollment.SchoolGUID → pln_school.external_guid → school_guid | LEFT JOIN on EnrollmentGUID; FK lookup | NOT NULL FK; SKIPPED if unresolved
- student_address_guid | uniqueidentifier | N | BPL_BusStopStudent → pln_student_address | AddressGUID → pln_student_address.external_id → student_address_guid | FK lookup | NOT NULL FK; SKIPPED if unresolved
- student_code | NVARCHAR(50) | Y | BPL_BusStopStudent | StudentID | — | trunc 50
- walk_distance | DECIMAL(9,2) | Y | BPL_BusStopStudent | DistToStop (float, metres) | — | SQL float → decimal; metres (ENG-1884) | NULL when Pro had no value
- customer_guid | uniqueidentifier | N | (ETL) | load-param customerGuid
- is_active 1 / is_deleted 0; created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME()
- (filter / join, NOT loaded) | BPL_BusStopStudent | EnrollmentGUID, Schedule, EffectiveDate, RetireDate, GEO composite | EnrollmentGUID = source join key (not persisted; identity is synthetic); Schedule → day-of-week (ScheduleFilter); Eff/Retire → snapshot-validity; GEO composite → stop resolution + identity

### 1b. Student

#### pln_student
- external_guid | uniqueidentifier | N | BP_Student | StudentGUID | direct | Natural key; MERGE on external_guid alone (not snapshot-scoped)
- student_id | NVARCHAR(50) | N | BP_Student | StudentID | trunc 50; NULL/blank → 'UNKNOWN' | NOT NULL
- first_name / last_name | NVARCHAR(100) | N | BP_Student | FirstName / LastName | trunc 100; NULL → 'Unknown' | NOT NULL
- date_of_birth | NVARCHAR(20) | Y | BP_Student | BirthDate | DATE → 'yyyy-MM-dd' string at extract (no TZ shift)
- gender | NVARCHAR(10) | Y | BP_Student | Gender | trunc 10
- special_needs | NVARCHAR(500) | Y | BP_Student | SpecialNeeds | trunc 500 (ENG-1885) | Backfilled by full-snapshot reconcile pass
- is_special_ed | bit | N | BP_Student | SpecialEd | direct (ENG-1885)
- seat_type_external_guid | uniqueidentifier | Y | BP_Student | SeatTypeGUID | direct GUID passthrough (ENG-1885); NOT resolved to pln_seat_type PK | external_guid, not FK
- phone | NVARCHAR(30) | Y | BP_Student | Phone | ContactText.Clean (trim, blank→NULL), trunc 30 (ENG-2816) | Kept if students.json lacks phone key (older extract, ENG-2816 guard)
- is_active | bit | N | BP_Student | EffectiveDate, RetireDate → (computed) | BP_Student has NO Active flag; is_active = LifecycleMapper[EffectiveDate, RetireDate) window | Retired / not-yet-effective → 0; reconciled every full load
- is_deleted | bit | N | (constant) 0 | DeleteDetector via student_guids.json (global, not customer-scoped)
- created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME()
- (incremental watermark) | BP_Student + BPX_Enrollment | ModifyDate (student) vs MAX enrollment ModifyDate | ModifiedDate = MAX(student.ModifyDate, max enrollment ModifyDate) so an enrollment-driven grade change advances the watermark (STUDEN-014/051); only rows modified after (watermark-120min) upserted
- (extracted, NOT loaded) | BP_Student | GradeCode, GEOObj*, AlternateID, Instruction, Alert, MedicalNum, MedicalDetail, MetAtBus, BusPatroller, Confidential, Protected, Online, ScheduleTypeGUID, DayTypeGUID, SiblingGUID, LoadTime, StudentWeight, DistrictOfRecord | grade REMOVED from pln_student (ENG-2279) → now pln_enrollment.grade_guid; GradeCode still extracted but not written; rest never persisted | Confirm with QA whether any are needed

#### pln_student_address
- external_id | NVARCHAR(100) | N | BP_Address | AddressGUID | direct | MERGE on external_id + student_guid (not snapshot-scoped)
- student_guid | uniqueidentifier | N | BP_Address → BP_Student → pln_student | BP_Student.StudentGUID (via 4-part GEO composite join) → pln_student.external_guid | INNER JOIN on GEOObjID+GEOObjType+GEOClassID+GEOSeqNum (STUDEN-066); FK lookup | NOT NULL FK; address SKIPPED if student unresolved
- address_type_guid | uniqueidentifier | N | (constant 'HOME') | always the default 'HOME' pln_address_type (EnsureAddressType); source AddressTypeGUID NOT used | FLAG for QA: every address lands as HOME
- address_line1 | NVARCHAR(200) | N | BP_Address | StreetNum + StreetName (→ Import* fallback) | '{StreetNum} {StreetName}'.Trim() ?? Import* ?? 'Unknown Address'; trunc 200 | NOT NULL
- address_line2 | NVARCHAR(200) | Y | BP_Address | Apt (→ ImportApt fallback) | trunc 200
- city | NVARCHAR(100) | Y | BP_Address | Municipality (→ ImportMunicipality) | trunc 100
- state_province | NVARCHAR(50) | Y | BP_Address | Province (→ ImportProvince) | trunc 50
- postal_code | NVARCHAR(20) | Y | BP_Address | PostalCode (→ ImportPostalCode) | trunc 20
- latitude / longitude | DECIMAL(9,6) | Y | Geo_Node | Point (UTM WKB) | LEFT JOIN gn ON a.GEOObjID=gn.ObjID | UTM WKB → WGS84 lat/lon at extract (CoordinateConverter) | NULL when no Geo_Node point
- is_active | bit | N | BP_Address | EffectiveDate, RetireDate → (computed) | no Active flag; LifecycleMapper[EffectiveDate, RetireDate) window; reconciled every full load
- is_deleted 0; created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME()
- (incremental / NOT loaded) | BP_Address | ModifyDate (watermark), GEOObj*, source AddressTypeGUID | watermark filter (modified after watermark-120min); AddressTypeGUID extracted but overridden by HOME

#### pln_student_contact
- external_guid | uniqueidentifier | N | BPX_Contact | ContactGUID | direct | MERGE on external_guid alone; delete via student_contact_guids.json (ENG-2816)
- student_guid | uniqueidentifier | N | BPX_Contact → BP_Student → pln_student | RecordGUID (= StudentGUID) → pln_student.external_guid | INNER JOIN BP_Student on polymorphic RecordGUID (student-owned rows only); FK lookup (live row preferred) | NOT NULL FK; contact SKIPPED if student not in pln_student
- contact_type_guid | uniqueidentifier | Y | BPX_Contact → pln_contact_type | ContactTypeGUID → pln_contact_type.external_guid | FK lookup | NULL kept when type unknown (row not dropped)
- sif_guid | uniqueidentifier | Y | BPX_Contact | SIFGUID | GUID passthrough
- first_name / last_name | NVARCHAR(50) | Y | BPX_Contact | FirstName, LastName | ContactText.Clean, trunc 50
- home_phone / work_phone / cell_phone | NVARCHAR(30) | Y | BPX_Contact | HomePhone, WorkPhone, CellPhone | Clean, trunc 30
- preferred_phone_type | NVARCHAR(10) | N | BPX_Contact | PreferredPhoneTypeGUID | 3 fixed GUIDs → 'HOME' / 'WORK' / 'CELL'; anything else → 'HOME' (BP Pro fallback) | NOT NULL
- fax | NVARCHAR(30) | Y | BPX_Contact | Fax | Clean, trunc 30
- email1 / email2 | NVARCHAR(255) | Y | BPX_Contact | Email1, Email2 | Clean, trunc 255
- place_of_work | NVARCHAR(255) | Y | BPX_Contact | PlaceOfWork | Clean, trunc 255
- mailing_address1 / mailing_address2 | NVARCHAR(255) | Y | BPX_Contact | MailingAddress1, MailingAddress2 | Clean, trunc 255
- notes | NVARCHAR(MAX) | Y | BPX_Contact | Notes | Clean (no trunc)
- priority | int | N | BPX_Contact | Priority | default 0 | BP Pro call order (0=first; dups possible)
- met_at_bus | bit | N | BPX_Contact | MetAtBus | direct
- address_external_guid | uniqueidentifier | Y | BPX_Contact | AddressGUID | GUID passthrough (not FK-resolved)
- address_type_external_guid | uniqueidentifier | Y | BPX_Contact | AddressTypeGUID | GUID passthrough (not FK-resolved)
- email1_allow_portal_access / email2_allow_portal_access | bit | N | BPX_Contact | Email1AllowPortalAccess, Email2AllowPortalAccess | direct (default 0 on older BP Pro)
- is_deleted | bit | N | (constant) 0 | revived on re-add; delete via guid list
- created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME() | Full load every run (no watermark); MERGE rewrites only changed rows
- (extract mechanics) | BPX_Contact | (version-dependent columns) | dynamic SELECT via COL_LENGTH probe — older BP Pro lacks Email2AllowPortalAccess etc; missing col → typed default (NULL/0/'HOME'), never fails entity; change-test uses BIN2 collation (case edit counts)

#### pln_enrollment
- external_guid | uniqueidentifier | N | BPX_Enrollment | EnrollmentGUID | direct | MERGE on external_guid (is_deleted=0); full master list, NOT snapshot-scoped (ENG-2279)
- student_guid | uniqueidentifier | N | BPX_Enrollment → pln_student | StudentGUID → pln_student.external_guid | FK resolve (external_guid, is_deleted=0) | REQUIRED; row SKIPPED if student not loaded yet (resolves on later run)
- enrollment_type_guid | uniqueidentifier | Y | BPX_Enrollment → pln_enrollment_type | EnrollmentTypeGUID → pln_enrollment_type.external_guid | FK resolve | NULL if unresolved
- school_guid | uniqueidentifier | Y | BPX_Enrollment → pln_school | SchoolGUID → pln_school.external_guid | FK resolve | NULL if unresolved
- grade_guid | uniqueidentifier | Y | BPX_Enrollment → pln_grade | GradeGUID → pln_grade.external_guid | FK resolve | grade lives here now (ENG-2279), not on pln_student
- program_guid | uniqueidentifier | Y | BPL_RecordProgram → BPX_Program → pln_program | ProgramGUID (Exclude=0, 0-or-1) → pln_program.external_guid | OUTER APPLY TOP 1; FK resolve | the enrollment's single program; NULL if none
- customer_guid | uniqueidentifier | N | (ETL) | load-param customerGuid | stamped, required
- school_year_guid | uniqueidentifier | Y | BPX_Enrollment | SchoolYearGUID | RAW GUID passthrough (NOT resolved; pln_school_year has no external_guid) | always NULL today; kept for future
- import_grade / import_school_id / home_room / school_travel_mode | NVARCHAR(50) | Y | BPX_Enrollment | ImportGrade, ImportSchoolID, HomeRoom, SchoolTravelMode | trunc 50
- effective_date | date | Y | BPX_Enrollment | EffectiveDate | 'yyyy-MM-dd' business date (no TZ shift)
- retire_date | date | Y | BPX_Enrollment | RetireDate | 'yyyy-MM-dd' business retire | NOT a soft delete — a transfer leaves the old row retired; is_deleted set only by delete detection
- is_deleted | bit | N | (constant) 0 | set by delete detection when GUID disappears
- created_by / modified_by / modified_date = 'ETL' / 'ETL' / SYSUTCDATETIME()

#### pln_student_snapshot
- (internal DB→DB loader — no extractor / no JSON; builds the snapshot xref from NEW-world tables) | Idempotent via NOT EXISTS; one row per active student per snapshot
- snapshot_guid | uniqueidentifier | N | (ETL) | the snapshot being built | scoping key
- student_guid | uniqueidentifier | N | pln_student | student_guid | WHERE pln_student.is_deleted = 0 | one row per active student | NOT NULL
- student_address_guid | uniqueidentifier | Y | pln_student_address | student_address_guid | LEFT JOIN: MIN(student_address_guid) per student WHERE is_deleted=0 | first non-deleted address per student | NULL if student has no address
- grade_guid | uniqueidentifier | Y | pln_enrollment → grade_guid | grade_guid | LEFT JOIN latest active enrollment: ROW_NUMBER() OVER (PARTITION BY student ORDER BY effective_date DESC), rn=1, retire_date NULL or future | grade from latest active enrollment (ENG-2279) | NULL if no active enrollment
- created_by 'ETL'; is_deleted 0

#### pln_snapshot
- (ETL-generated — no source table / no JSON; SnapshotManager creates one per customer + school_year + date) | Idempotent: FindExisting reuses; scopes ALL snapshot-scoped tables (route/run/stop/student_stop/student_snapshot)
- snapshot_guid | uniqueidentifier | N | (ETL) | Guid.NewGuid() (PK, NEWSEQUENTIALID default) | scoping key
- customer_guid | uniqueidentifier | N | (ETL) | load-param customerGuid | NOT NULL
- school_year_guid | uniqueidentifier | N | (ETL) | current school-year guid | NOT NULL
- snapshot_date | date | N | (ETL) | the plan date this snapshot represents
- is_active | bit | N | (ETL) | created = 0; activated ONLY after Phase 7/8 data lands; deactivated outside 10-day window / during purge+reload | ENG-2918: NEVER pick a day's plan by is_active — use snapshot dated that day, most-recent created first
- created_date / created_by | SYSUTCDATETIME() / 'ETL'

### 1c. Org / geography

#### pln_district
- external_guid | uniqueidentifier | N | BP_District | DistrictGUID | direct | MERGE on external_guid (is_deleted=0); OUTSIDE snapshots
- district_code | NVARCHAR(50) | Y | BP_District | DistrictID | trunc 50
- district_name | NVARCHAR(200) | N | BP_District | Name | trunc 200; NULL → 'Unknown District' | NOT NULL
- customer_guid | uniqueidentifier | N | (ETL) | load-param customerGuid | NOT NULL FK to pln_customer; required
- is_active | bit | N | BP_District | Active, EffectiveDate, RetireDate → (computed) | LifecycleMapper(Active, [Effective,Retire)) — retired-but-Active → 0 (DISTRI-011)
- is_deleted 0
- created_date | datetime2 | N | BP_District | CreateDate | parsed UTC; NULL → now
- created_by / modified_by | NVARCHAR(100) | N | BP_District | CreateUser | trunc 100; NULL → 'ETL'; modified_date = SYSUTCDATETIME()
- (extracted, NOT loaded) | BP_District | Director, Phone | not persisted

#### pln_school
- external_guid | uniqueidentifier | N | BP_School | SchoolGUID | direct | MERGE on external_guid; OUTSIDE snapshots; WHERE Active=1 (active schools only extracted)
- school_code | NVARCHAR(50) | Y | BP_School | SchoolID | trunc 50
- school_name | NVARCHAR(200) | N | BP_School | Name | trunc 200; NULL → 'Unknown School' | NOT NULL
- district_guid | uniqueidentifier | N | BP_School → pln_district | DistrictID → pln_district.district_code (+ customer) → district_guid | FK lookup | NOT NULL FK; school SKIPPED if district not loaded yet
- latitude / longitude | DECIMAL(9,6) | Y | Geo_Node | Point (UTM WKB) | LEFT JOIN gn ON s.GEOObjID=gn.ObjID | UTM WKB → WGS84 at extract | NULL if no Geo_Node point
- is_active | bit | N | BP_School | Active, EffectiveDate, RetireDate → (computed) | LifecycleMapper(Active, [Effective,Retire)) (SCHOOL-003)
- is_deleted 0
- created_date | datetime2 | N | BP_School | CreateDate | parsed UTC; NULL → now
- created_by / modified_by | NVARCHAR(100) | N | BP_School | CreateUser | trunc 100; NULL → 'ETL'
- (extracted, NOT loaded) | BP_School | SIFGUID, AlternateID, GradeSchoolTypeGUID, Capacity, WebPage, Regular, SpecialEd, Public, Protected, GEOObj* | not persisted; Eff/Retire used only for is_active | Confirm with QA

#### pln_school_program
- (bridge — real school↔program affinity; replaced the old cartesian every-school×every-program, PROGRA-001/007) | Key (school_guid, program_guid); NOT snapshot-scoped
- school_guid | uniqueidentifier | N | school_programs.json ← BP_School → BPL_ObjectGrade → BPL_RecordProgram(Exclude=0) → BPX_Program | SchoolGUID → pln_school.external_guid | DISTINCT real affinity (per-grade collapsed); FK resolve (customer-scoped via district) | pair SKIPPED if school/program unresolved
- program_guid | uniqueidentifier | N | … BPX_Program → pln_program | ProgramGUID → pln_program.external_guid | FK resolve (customer-scoped)
- created_by 'ETL'
- is_deleted | bit | N | (MERGE) | insert new / reactivate returning / soft-delete a pair no-longer-real (for schools in the set) | no school_programs.json → bridge left UNCHANGED (no cartesian fallback)

#### pln_school_zone
- (bridge — internal DB→DB, no extractor; built after zones + schools load; matches School-type zones to schools) | Key (school_guid, zone_guid); NOT snapshot-scoped
- school_zone_guid | uniqueidentifier | N | (ETL) | NEWID() | PK
- school_guid | uniqueidentifier | N | pln_zone → pln_school | sch.school_guid | INNER JOIN pln_school ON z.zone_code = sch.school_code (is_deleted=0) | match key = zone_code ↔ school_code
- zone_guid | uniqueidentifier | N | pln_zone | z.zone_guid | WHERE pln_zone_type.type_name = 'School' AND customer scoped
- external_guid | uniqueidentifier | Y | pln_zone | z.external_guid | carried from the zone
- relationship_type | NVARCHAR | N | (constant) | 'SCHOOL_BOUNDARY'
- effective_date | date | N | (ETL) | CAST(SYSUTCDATETIME() AS DATE)
- is_deleted | bit | N | (constant / retire) | NOT EXISTS guards on both unique indexes
- created_by / modified_by 'ETL'

#### pln_zone
- external_guid | uniqueidentifier | N | BP_Zone | ZoneGUID | direct | Match on (customer_guid, external_guid); OUTSIDE snapshots; WHERE Active=1
- zone_name | NVARCHAR(100) | N | BP_Zone | Description (→ ZoneID fallback) | first non-blank(Description, ZoneId) ?? 'Unknown'; trunc 100 | NOT NULL
- zone_code | NVARCHAR(50) | Y | BP_Zone | ZoneID | trunc 50 | (notes cell shows #NAME? in the sheet)
- zone_description | NVARCHAR(500) | Y | BP_Zone | Description | trunc 500
- zone_type_guid | uniqueidentifier | N | BP_Zone → pln_zone_type | ZoneTypeGUID → pln_zone_type.external_guid (+ customer) | FK lookup | NOT NULL; zone SKIPPED if unresolved
- customer_guid | uniqueidentifier | N | (ETL) | load-param | NOT NULL
- zone_geometry | geography | N | GEO_Polygon | Polygon (UTM WKB) | LEFT JOIN gp ON z.GEOObjID=gp.ObjID | UTM WKB → WGS84 WKT at extract; STPolyFromText(4326).MakeValid() at load | NOT NULL; zone SKIPPED if geometry/bbox missing
- bounding_box_min/max_lat/long | DECIMAL(9,6) | N | GEO_Polygon | MinX/MinY/MaxX/MaxY (UTM) | UTM corners → WGS84 at extract | NOT NULL
- is_active | bit | N | BP_Zone | Active, Effective, Retire → (computed) | LifecycleMapper(Active, [Effective,Retire)) (ZONES-002/014)
- is_deleted | bit | N | (constant / supersede) | change = soft-delete old row (is_deleted=1/is_active=0/'ETL-DELETE') + insert NEW zone_guid; never UPDATE in place; identical row = no-op; geometry compared via STEquals
- created_by / modified_by 'ETL'
- (extracted, NOT loaded) | BP_Zone | GEOObj*, Protected | not persisted

#### pln_zone_type
- external_guid | uniqueidentifier | N | BPX_ZoneType | ZoneTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots
- type_name | NVARCHAR(100) | N | BPX_ZoneType | Name | trunc 100; NULL → 'Unknown Zone Type' | NOT NULL (e.g. 'School')
- type_code | NVARCHAR(50) | N | BPX_ZoneType | Name | trunc 50 of Name; NULL → 'UNKNOWN' | BP Pro has no separate code — Name reused
- customer_guid load-param; is_active 1; is_deleted 0; created_by / modified_by 'ETL'
- (extracted, NOT loaded) | BPX_ZoneType | Public, IsSystem | not persisted

#### pln_depot
- external_guid | uniqueidentifier | N | BP_Depot | DepotGUID | direct | MERGE on (customer_guid, external_guid); OUTSIDE snapshots; WHERE Active=1
- external_id | NVARCHAR(100) | Y | BP_Depot | DepotID | trunc 100
- depot_code | NVARCHAR(50) | N | BP_Depot | DepotID | trunc 50; NULL → 'UNKNOWN' | unique per customer
- depot_name | NVARCHAR(200) | N | BP_Depot | DepotID | trunc 200 of DepotID; NULL → 'Unknown Depot' | BP Pro has NO separate depot name — DepotID reused
- depot_description | NVARCHAR(500) | Y | BP_Depot | Description | trunc 500
- depot_type | NVARCHAR(100) | Y | BPX_DepotType | Name | LEFT JOIN dt ON d.DepotTypeGUID | trunc 100
- operator_guid | uniqueidentifier | Y | BP_Depot → opr_operator | OperatorGUID → opr_operator.external_guid | FK lookup (optional) | NULL if unresolved
- latitude / longitude | DECIMAL(9,6) | Y | Geo_Node | Point (UTM WKB) | LEFT JOIN gn ON d.GEOObjID=gn.ObjID | UTM WKB → WGS84 (BP_Depot.Position is address TEXT, not a coord)
- capacity | int | Y | BP_Depot | Capacity | direct
- has_maintenance / is_home_depot / has_locked_gate / has_lighting / has_fuel / has_wash | bit | N | BP_Depot | Maintenance, Home, LockedGate, Lighting, Fuel, Wash | direct bits
- is_active | bit | N | BP_Depot | Active, Effective, Retire → (computed) | LifecycleMapper
- is_deleted 0
- created_date / created_by / modified_date / modified_by | BP_Depot | CreateDate, CreateUser, ModifyDate, ModifyUser | provenance preserved; NULL user → 'ETL'
- (extracted, NOT loaded) | BP_Depot | Protected | not persisted

### 1d. Vehicle reference

#### pln_vehicle_type
- external_guid | uniqueidentifier | N | BPX_VehicleType | VehicleTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots; loads BEFORE vehicles (Phase 2)
- type_name | NVARCHAR(100) | N | BPX_VehicleType | VehicleType | trunc 100; NULL → 'Unknown Vehicle Type' | NOT NULL (e.g. 'INTER - Type C')
- description | NVARCHAR(255) | Y | BPX_VehicleType | Description | trunc 255
- size | int | Y | BPX_VehicleType | Size | direct
- max_cumulative_equipment | int | Y | BPX_VehicleType | MaxCumulativeEquipment | direct
- customer_guid load-param; is_active 1; is_deleted 0; created_by / modified_by 'ETL'
- (extracted, NOT loaded) | BPX_VehicleType | FuelTypeGUID, VehicleClassificationGUID | out of scope — not carried by extractor

#### pln_vehicle_seat_type
- external_guid | uniqueidentifier | N | BPL_VehicleSeatType | VehicleSeatTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots; loads AFTER vehicle_types + seat_types
- vehicle_type_external_guid | uniqueidentifier | N | BPL_VehicleSeatType | VehicleTypeGUID | raw external_guid (NOT resolved to pln_vehicle_type PK; no hard FK) | required; row skipped if invalid
- seat_type_external_guid | uniqueidentifier | N | BPL_VehicleSeatType | SeatTypeGUID | raw external_guid (NOT resolved to pln_seat_type PK; no hard FK) | required; orphan link stored, not failed
- num_of_seats | int | Y | BPL_VehicleSeatType | NumOfSeats | direct | seat composition per vehicle type (e.g. Type C = 64 Regular + 1 Wheelchair)
- customer_guid load-param; is_active 1; is_deleted 0; created_by / modified_by 'ETL'

#### pln_seat_type
- external_guid | uniqueidentifier | N | BPX_SeatType | SeatTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots; loads BEFORE students (Phase 3)
- type_name | NVARCHAR(100) | N | BPX_SeatType | SeatType | trunc 100; NULL → 'Unknown Seat Type' | NOT NULL (e.g. 'Wheelchair', 'Safety Vest')
- is_special_ed | bit | N | BPX_SeatType | SpecialEd | direct
- is_system | bit | N | BPX_SeatType | IsSystem | direct
- customer_guid load-param; is_active 1; is_deleted 0; created_by / modified_by 'ETL' | referenced by pln_student.seat_type_external_guid

#### pln_employee_vehicle
- (snapshot-scoped; internal DB→DB — no extractor; copies ACTIVE assignments from master veh_employee_vehicle) | MERGE by (employee_guid, snapshot_guid); dedup 1 vehicle/employee (EMPLOY-002)
- snapshot_guid | uniqueidentifier | N | (ETL) | the snapshot being built | scoping key
- employee_guid | uniqueidentifier | N | veh_employee_vehicle | employee_guid | WHERE retire_date IS NULL AND is_deleted=0; customer-scoped via ta_employee.customer_guid (EMPLOY-003) | admin-UI maintained master
- vehicle_guid | uniqueidentifier | N | veh_employee_vehicle | vehicle_guid | ROW_NUMBER() 1 per employee (ORDER BY vehicle_guid) | updated on re-run if assignment changed
- is_deleted 0; created_by / modified_by 'ETL'

### 1e. Reference / lookups

#### pln_grade
- external_guid | uniqueidentifier | N | BPX_Grade | GradeGUID | direct | MERGE on external_guid; OUTSIDE snapshots
- grade_code | NVARCHAR(50) | N | BPX_Grade | Grade | trunc 50; NULL → 'Unknown' | NOT NULL (e.g. 'K','01','12'); unique per customer
- grade_description | NVARCHAR(200) | Y | BPX_Grade | Description | trunc 200
- sort_order | int | N | BPX_Grade | SortOrder | default 0 | display ordering
- met_at_bus | bit | N | BPX_Grade | MetAtBus | direct | student must be met at the stop
- customer_guid load-param; is_active 1
- is_deleted | bit | N | (constant / supersede) | 0 | deleted+recreated grade keeps grade_code, new GUID → stale same-code row soft-deleted first (GRADES-001)
- created_by / modified_by 'ETL'
- (extracted, NOT loaded) | BPX_Grade | GradeSchoolTypeGUID, NextGradeGUID, ScheduleTypeGUID, DayTypeGUID | not persisted

#### pln_program
- external_guid | uniqueidentifier | N | BPX_Program | ProgramGUID | direct | MERGE on external_guid; OUTSIDE snapshots; universal per customer (not per-school)
- program_name | NVARCHAR(100) | N | BPX_Program | Name | trunc 100; NULL → 'Unknown Program' | NOT NULL
- program_code | NVARCHAR(50) | Y | BPX_Program | Code | trunc 50
- program_description | NVARCHAR(500) | Y | BPX_Program | Description | trunc 500
- customer_guid | load-param | NOT NULL FK to pln_customer
- is_active 1; is_deleted 0
- created_date | datetime2 | N | BPX_Program | CreateDate | parsed UTC; NULL → now (PROGRA-008 provenance)
- created_by / modified_by | NVARCHAR(100) | N | BPX_Program | CreateUser | trunc 100; NULL → 'ETL'
- (extracted, NOT loaded) | BPX_Program | SpecialEd, IsSystem | not persisted

#### pln_bell_time
- external_guid | uniqueidentifier | N | BPX_BellTime | BellTimeGUID | direct | MERGE on external_guid; OUTSIDE snapshots (ENG-2279)
- school_guid | uniqueidentifier | N | BPX_BellTime → pln_school | SchoolGUID → pln_school.external_guid | FK resolve | bell time SKIPPED if school not loaded yet (resolves later run)
- bell_time_type_guid | uniqueidentifier | Y | BPX_BellTime → pln_bell_time_type | BellTimeTypeGUID → pln_bell_time_type.external_guid | FK resolve | NULL if unresolved
- is_regular | bit | N | BPX_BellTime | Regular | direct
- is_special_ed | bit | N | BPX_BellTime | SpecialEd | direct | regular / special-ed tier
- early_in / late_in / bell_in / arrival_out / early_out / late_out / bell_out | time | Y | BPX_BellTime | EarlyIn, LateIn, BellIn, ArrivalOut, EarlyOut, LateOut, BellOut | BP Pro packed day-time int → local 'HH:mm:ss' at extract → TIME; 0 ('not set') → NULL | local by nature — no per-client TZ
- is_deleted / created / modified | INSERT omits them — column defaults apply; modified stamped 'ETL' on update
- (extracted, NOT loaded) | BPX_BellTime | CreateDate, CreateUser, ModifyDate, ModifyUser; program assoc (BPL_RecordProgram, separate) | audit cols not persisted; program links go to pln_bell_time_program

#### pln_bell_time_program
- (bridge — bell-time↔program links; carries the Exclude bit, both include AND exclude) | NOT snapshot-scoped; delete detection via LoadOrchestrator (ENG-2279)
- external_guid | uniqueidentifier | N | BPL_RecordProgram | RecordProgramGUID | direct | MERGE on external_guid
- bell_time_guid | uniqueidentifier | N | BPL_RecordProgram → BPX_BellTime → pln_bell_time | RecordGUID (= BellTimeGUID) → pln_bell_time.external_guid | INNER JOIN BPX_BellTime on RecordGUID; FK resolve | link SKIPPED if bell time not loaded
- program_guid | uniqueidentifier | N | BPL_RecordProgram → BPX_Program → pln_program | ProgramGUID → pln_program.external_guid | FK resolve | SKIPPED if program not loaded
- exclude | bit | N | BPL_RecordProgram | Exclude | direct (include/exclude bit kept, unlike school_program) | no rows for a bell time = applies to ALL programs
- modified_date / modified_by | SYSUTCDATETIME() / 'ETL' on update

#### pln_bell_time_type
- external_guid | uniqueidentifier | N | BPX_BellTimeType | BellTimeTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots; small lookup (ENG-2279)
- name | NVARCHAR(50) | N | BPX_BellTimeType | Name | trunc 50; NULL → 'Unknown' | e.g. AM / PM / Noon
- modified_date / modified_by | SYSUTCDATETIME() / 'ETL' on update | NOTE: this lookup has NO customer_guid / is_active / is_deleted columns written

#### pln_contact_type
- external_guid | uniqueidentifier | N | BPX_ContactType | ContactTypeGUID | direct | MERGE on external_guid ALONE; revives on reappear; precedes student_contacts (ENG-2816)
- name | NVARCHAR(50) | N | BPX_ContactType | Name | trimmed, trunc 50; NULL → '' | NOT NULL (e.g. Mother / Father / Guardian; customers rename BP Pro's 'Contact 1/2/3')
- filter_type | NVARCHAR(20) | Y | BPX_ContactType | FilterType | ContactText.Clean, trunc 20 | owner kind: 'Student'/'School'/'Depot'/'Operator'; NULL/empty = any
- is_deleted | bit | N | (MERGE) | revive (=0) on reappear; change-test BIN2 collation | no snapshot; delete detection sets stale ones
- modified_date / modified_by | only rewritten when a value changed (case counts); unchanged keeps modified_date

#### pln_address_type
- (NO BP Pro source / no extractor — ETL-created default ONLY, via StudentAddressLoader.EnsureAddressType) | one 'HOME' row per client; pln_student_address.address_type_guid always points here
- address_type_guid | uniqueidentifier | N | (ETL) | Guid.NewGuid() | PK
- type_name | NVARCHAR | N | (constant)
- type_code | NVARCHAR | N | (constant) | unique; the EnsureAddressType lookup key
- is_active 1; is_deleted 0; created_by / modified_by 'ETL'
- (FLAG for QA) | BP Pro AddressType/AddressTypeGUID is NEVER mapped here | every student address forced to HOME; multi-type addresses not represented

#### pln_enrollment_type
- external_guid | uniqueidentifier | N | BPX_EnrollmentType | EnrollmentTypeGUID | direct | MERGE on external_guid; OUTSIDE snapshots; small lookup (ENG-2279)
- name | NVARCHAR(100) | N | BPX_EnrollmentType | Name | trunc 100; NULL → 'Unknown' | 'Main' = real school enrollment, 'Home' = residence/eligibility (+ Other 1-3); resolution matches active 'Main' by Name
- is_system | bit | N | BPX_EnrollmentType | IsSystem | direct
- modified_date / modified_by | SYSUTCDATETIME() / 'ETL' on update

## VEHICLES - veh_ (3 tables)

#### veh_vehicle
- external_guid | uniqueidentifier | N | BPX_Vehicle | VehicleGUID | direct | MERGE on external_guid; OUTSIDE snapshots; WHERE Active=1 (AVL mode = BPX_AVLVehicle, id only)
- vehicle_name | NVARCHAR(100) | N | BPX_Vehicle | VehicleID | trunc 100; NULL → 'Unknown Vehicle' | BP Pro has no separate name — VehicleID reused
- vehicle_number | NVARCHAR(50) | N | BPX_Vehicle | VehicleID | trunc 50; NULL → 'UNKNOWN'
- license_plate | NVARCHAR(20) | Y | BPX_Vehicle | License | trunc 20
- vin_number | NVARCHAR(25) | Y | BPX_Vehicle | VIN | trunc 25
- year | int | Y | BPX_Vehicle | ModelYear | direct
- make / model | NVARCHAR(50) | Y | BPX_Vehicle | Make, Model | trunc 50
- vehicle_capacity | int | Y | BPX_Vehicle → BPX_VehicleType | VehicleType.Size | LEFT JOIN vt ON v.VehicleTypeGUID | direct
- depot_guid | uniqueidentifier | Y | BPX_Vehicle → pln_depot | DepotGUID → pln_depot (+ customer) | FK lookup; only links if vehicle operator == depot operator (or either NULL) | NULL if unresolved / operator mismatch
- vehicle_type_external_guid | uniqueidentifier | Y | BPX_Vehicle | VehicleTypeGUID | raw external_guid (not resolved to PK), ENG-1885
- is_active | bit | N | BPX_Vehicle | Active | direct
- is_deleted 0
- created_date / created_by / modified_date / modified_by | BPX_Vehicle | CreateDate, CreateUser, ModifyDate, ModifyUser | provenance (VEHICL-012); NULL user → 'ETL'
- (extracted, NOT loaded) | BPX_Vehicle | OperatorGUID (→ veh_vehicle_operator bridge), DeprCycle, PurchaseCost, Protected | operator goes to the bridge; rest not persisted

#### veh_vehicle_operator
- (bridge — a vehicle's operating company; from vehicles.json OperatorGUID; VehicleLoader drops the operator so this fills it, else GPS+ shows 'Unassigned') | NOT snapshot-scoped; ONE current link per vehicle (UX ..._current: retire_date NULL + is_deleted 0)
- vehicle_guid | uniqueidentifier | N | BPX_Vehicle → veh_vehicle | VehicleGUID → veh_vehicle.external_guid | FK resolve | link dropped if vehicle/operator unresolved
- operator_guid | uniqueidentifier | N | BPX_Vehicle.OperatorGUID → opr_operator | OperatorGUID → opr_operator.external_guid | FK resolve | vehicle with no operator = no link
- effective_date | date | N | BPX_Vehicle | CreateDate (first link) / today (re-assign) | first link = vehicle BP Pro create date; re-assignment = today
- retire_date | date | Y | (ETL) | NULL = current; on operator change old row retire_date = YESTERDAY (ETL runs ~2AM next day), new starts today (no overlap) | history kept (is_deleted stays 0)
- is_deleted 0; created_by / modified_by 'ETL'

#### veh_employee_vehicle
- external_guid | uniqueidentifier | N | BPL_VehicleStaff | VehicleStaffGUID | direct | MERGE on external_guid; master driver↔vehicle table (admin-UI + ETL co-owned)
- employee_guid | uniqueidentifier | N | BPL_VehicleStaff → ta_employee | StaffGUID → ta_employee.external_guid | FK resolve (StaffEntityLoader runs first) | SKIPPED if staff not in ta_employee
- vehicle_guid | uniqueidentifier | N | BPL_VehicleStaff → veh_vehicle | VehicleGUID → veh_vehicle.external_guid | FK resolve; extract INNER JOINs active Staff + active Vehicle | SKIPPED if vehicle unresolved
- effective_date | date | N | BPL_VehicleStaff | CreateDate | Pro has no effective date → CreateDate
- is_deleted 0
- created_date / modified_date / created_by / modified_by | BPL_VehicleStaff | CreateDate, ModifyDate, CreateUser, ModifyUser | provenance
- (constraint) | 1 CURRENT vehicle/employee + 1 current employee/vehicle (filtered unique) | conflicts: most-recent-wins (ModifyDate/CreateDate); admin-authored (external_guid NULL) NEVER evicted (EMPLOY-006)

## OPERATORS - opr_ (1 table)

#### opr_operator
- external_guid | uniqueidentifier | N | BPX_Operator | OperatorGUID | direct | MERGE on external_guid; OUTSIDE snapshots
- operator_name | NVARCHAR(100) | N | BPX_Operator | Name | trunc 100; NULL → 'Unknown Operator' | NOT NULL
- operator_code | NVARCHAR(50) | N | BPX_Operator | OperatorID | trunc 50; NULL → 'UNKNOWN'
- operator_description | NVARCHAR(500) | Y | BPX_Operator | DisplayName | trunc 500
- mailing_address1 / mailing_address2 | NVARCHAR(200) | Y | BPX_Operator | MailingAddress1, MailingAddress2 | trunc 200
- phone | NVARCHAR(50) | Y | BPX_Operator | Phone | trunc 50
- email / finance_email | NVARCHAR(200) | Y | BPX_Operator | Email, FinanceEmail | trunc 200
- is_protected | bit | N | BPX_Operator | Protected | direct
- is_active 1; is_deleted 0
- created_date / created_by / modified_date / modified_by | BPX_Operator | CreateDate, CreateUser, ModifyDate, ModifyUser | provenance (OPERAT-001); NULL user → 'ETL'

## STAFF / T&A - ta_ (2 tables)

#### ta_employee
- external_guid | uniqueidentifier | N | BPX_Staff | StaffGUID | direct | MERGE on external_guid OR adopt payroll-CSV row (external_guid NULL, same employee_number)
- customer_guid | uniqueidentifier | N | (ETL) | load-param | NOT NULL
- employee_number | NVARCHAR(50) | N | BPX_Staff | StaffID | trimmed; NEVER truncated — StaffID > 50 chars or blank = staff SKIPPED (a cut number could collide) | ADOPTION key with payroll CSV
- first_name / last_name | NVARCHAR(100) | N | BPX_Staff | FirstName, LastName | trunc 100; NULL → ''
- email | NVARCHAR(255) | Y | BPX_Staff | Email1 | trunc 255
- phone | NVARCHAR(20) | Y | BPX_Staff | CellPhone (→ HomePhone → WorkPhone) | first non-null; trunc 20
- hire_date | date | Y | BPX_Staff | HireDate | parsed date
- is_active | bit | N | BPX_Staff | Active | direct; ALL staff extracted but only ACTIVE INSERT a row; inactive only UPDATE existing (propagate deactivation)
- is_deleted 0
- created_date / modified_date / modified_by | BPX_Staff | CreateDate, ModifyDate, ModifyUser | provenance
- created_by | NVARCHAR | N | (ETL) | payroll-adopted rows (created_by != 'ETL') keep payroll-owned fields; only ETL-created rows get full refresh (EMPLOY-006)
- (extracted, NOT loaded) | BPX_Staff | OperatorGUID (→ ta_employee_operator), GovernmentID, BirthDate, Fax, Email2, MailingAddress1/2, Notes, License, Position, LanguagesSpoken, PreferredLanguage, Protected, Eff/Retire | operator → bridge; rest not persisted | Confirm with QA (T&A may need position/license)

#### ta_employee_operator
- (bridge — maintained by StaffEntityLoader from BPX_Staff.OperatorGUID; ACTIVE staff only; one CURRENT link per employee) | filtered unique: 1 row per employee WHERE retire_date NULL + is_deleted 0
- employee_guid | uniqueidentifier | N | BPX_Staff → ta_employee | StaffGUID → ta_employee.external_guid | FK resolve
- operator_guid | uniqueidentifier | N | BPX_Staff.OperatorGUID → opr_operator | OperatorGUID → opr_operator.external_guid | FK resolve
- effective_date | date | N | BPX_Staff | EffectiveDate | parsed; NULL → today
- retire_date | date | Y | (ETL) | NULL = current; set = today when operator cleared or changed | operator changed = retire old + insert new
- is_deleted 0
- created_by / modified_by 'ETL' | operator present but not loaded → SKIP (never retire on transient FK miss)
