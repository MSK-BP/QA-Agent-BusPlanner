# BusPlannerUnified — backend core map

Snapshot: commit 0137276 (read-only copy under `repos/BusPlannerUnified`). Mapped by static reading only (no build, no tests run).
Scope: `BusPlannerAPI`, `BusPlanner.Application`, `BusPlanner.Domain`, `BusPlanner.Infrastructure`, `Modules/TimeAndAttendance`. Chatbot, ETL, GPS services, client, test projects and CI are mapped elsewhere.

**Path shorthand** (all repo-relative; the .NET solution is in the inner `BusPlannerUnified/` folder):

| Short | Expands to |
|---|---|
| `API/` | `BusPlannerUnified/BusPlannerAPI/` |
| `API-TA/` | `BusPlannerUnified/BusPlannerAPI/Modules/TimeAndAttendance/` |
| `INF/` | `BusPlannerUnified/BusPlanner.Infrastructure/` |
| `DOM/` | `BusPlannerUnified/BusPlanner.Domain/` |
| `APP/` | `BusPlannerUnified/BusPlanner.Application/` |
| `TA-APP/` | `BusPlannerUnified/Modules/TimeAndAttendance/BusPlanner.TimeAndAttendance.Application/` |
| `TA-INF/` | `BusPlannerUnified/Modules/TimeAndAttendance/BusPlanner.TimeAndAttendance.Infrastructure/` |
| `TA-DOM/` | `BusPlannerUnified/Modules/TimeAndAttendance/BusPlanner.TimeAndAttendance.Domain/` |
| `REG/` | `BusPlannerUnified/BPClientRegistry/` |

Anything marked **UNVERIFIED** is inferred, not read directly in code.

---

## 1. Purpose and shape

- Multi-tenant school-transportation platform: one ASP.NET Core API + one React SPA; functional areas are Planning/Transportation, Time & Attendance (T&A), Chatbot, Users & Auth (`BusPlannerUnified/CLAUDE.md:15-31`).
- Framework: **.NET 8** (`net8.0`) everywhere in scope (`API/BusPlannerAPI.csproj:4`, `INF/BusPlanner.Infrastructure.csproj:21`); Hot Chocolate 14.3.0 GraphQL, Swashbuckle 6.6.2 (`API/BusPlannerAPI.csproj:24-31`); EF Core 8 SQL Server (`INF/BusPlanner.Infrastructure.csproj:13`); FluentValidation 12.1.1 (`TA-APP/BusPlanner.TimeAndAttendance.Application.csproj:10`).
- Style: layered "clean-ish" architecture with **CQRS split by transport — GraphQL for reads, REST for writes**, plus a few purpose-built REST GETs (`BusPlannerUnified/CLAUDE.md:121-126`). No MediatR: handlers are plain classes registered one by one and injected into controllers (`TA-APP/DependencyInjection.cs:46-95`, `API-TA/ShiftsController.cs:17-23`).
- Many controllers skip handlers and use `AppDbContext` directly (e.g. `API-TA/PayPeriodsController.cs:18-21`, `API-TA/TimesheetController.cs:33-37`, `API-TA/PayrollExportController.cs:20-27`) — business rules live in BOTH controllers and handlers.
- Project references (who depends on whom):

| Project | References | Source |
|---|---|---|
| `BusPlanner.Domain` | nothing | `DOM/BusPlanner.Domain.csproj` |
| `BusPlanner.Application` | Domain | `APP/BusPlanner.Application.csproj:4` |
| `BusPlanner.Infrastructure` | Application, BPClientRegistry, **TA.Domain, Chatbot.Domain** | `INF/BusPlanner.Infrastructure.csproj:4-7` |
| `TA.Domain` | Domain | `TA-DOM/BusPlanner.TimeAndAttendance.Domain.csproj:4` |
| `TA.Application` | TA.Domain, Domain, **Infrastructure** (uses `AppDbContext` directly) | `TA-APP/BusPlanner.TimeAndAttendance.Application.csproj:4-6` |
| `TA.Infrastructure` | TA.Application, Infrastructure | `TA-INF/BusPlanner.TimeAndAttendance.Infrastructure.csproj:4-5` |
| `BusPlannerAPI` (host) | Application, Infrastructure, BPClientRegistry, TA.Application, TA.Infrastructure, Chatbot.Application, Chatbot.Infrastructure | `API/BusPlannerAPI.csproj:35-41` |

- Module registration is explicit in `API/Program.cs:59-69`: `AddApplication()`, `AddInfrastructure(config)`, `AddTimeAndAttendance()`, `AddTimeAndAttendanceInfrastructure()`, `AddChatbot()`, `AddChatbotInfrastructure(config)`, `AddChatbotTools()`, `AddMapServices()`.
- EF entity configurations of the T&A and Chatbot modules are discovered **by assembly name at model-build time** (`INF/Persistence/AppDbContext.cs:444-466`); the model is built eagerly at startup and a failure stops the host (`API/Program.cs:284-292`).
- Startup also force-builds the GraphQL schema but only prints `SCHEMA_BUILD_FAILED` to console and continues (`API/Program.cs:294-306`, marked `TEMP-REPRO`).

## 2. Request path

### 2.1 Authentication
- Identity provider is **in-house**: ASP.NET Core Identity tables in each client DB + self-issued HMAC-SHA256 JWT (`INF/Auth/AuthService.cs:42-64,177-188`). No external IdP found in scope.
- Login `POST api/auth/login` takes email + password + `ClientCode`; any failure (missing client code, unknown client, unknown user, bad password) returns the same 401 "Invalid credentials." (`INF/Auth/AuthService.cs:26-64`, `API/Controllers/AuthController.cs:10-24`).
- Login does NOT use `UserManager`/`SignInManager`: it reads `AspNetUsers` with raw SQL and verifies the hash — so **no account lockout, no email-confirmed check** on web login (`INF/Auth/AuthService.cs:46-64`).
- `GLOBAL_LOGIN` registry flag is NOT checked by `api/auth/login` (UI-only gate) but IS enforced (403) on the mobile PIN endpoint (`docs/multi-tenant-local-dev.md:75-81`, `API-TA/TimescanAuthController.cs:67-71`).
- JWT claims: user id, email, names, `client_code`, role names, `permission` (role + direct, de-duplicated), and scope claims `customer_access`, `department_access`, `school_access`, `district_access`, `operator_access`, `depot_access` (`INF/Auth/AuthService.cs:107-164`).
- Role named `Admin` (case-insensitive) gets `"*"` on all six scope claims at login (`INF/Auth/AuthService.cs:141-175`); `CurrentUserService` also treats `IsInRole("Admin")` as all-access (`INF/Services/CurrentUserService.cs:27-29`).
- Token lifetime = `Jwt:ExpiryMinutes` (default 60 in code if unset); **no refresh-token endpoint found in scope** (`INF/Auth/AuthService.cs:180-184`, `API/Controllers/AuthController.cs`). Permissions are frozen into the token until it expires.
- JWT validation: issuer, audience, lifetime, signing key (`API/Program.cs:147-159`). Outside Development a missing/placeholder/<32-char `Jwt:Secret` aborts startup; in Development a fixed dev key is substituted (`API/Program.cs:124-139`).
- Second JWT scheme for the mobile clock ("timescan session"): same key and issuer, distinct audience, `ClockSkew = 0` (`API/Program.cs:164-177`). Issued by `POST api/ta/timescan/auth/pin`.
- Password policy for Identity: digit required, min length 8 (`INF/DependencyInjection.cs:72-76`).

### 2.2 Multi-tenancy (two layers)
1. **Database per client.** A registry DB (`Client_Registry`: `BPCustomers`, `BPUsers`, `BPFeatureFlag`) maps a client code to server + database (`docs/multi-tenant-local-dev.md:9-20`).
   - Every request's `AppDbContext` connection comes from the `client_code` claim via `TenantConnectionResolver` (`INF/Persistence/TenantConnectionResolver.cs:35-74`).
   - No `client_code` or unknown client → `UnauthorizedAccessException` → **401**; there is no default DB (`TenantConnectionResolver.cs:56-68`, `API/Middleware/ExceptionHandlingMiddleware.cs:45`).
   - Only exception: route prefix `/api/ta/timescan/auth` may name its client with header `X-Client-Code` (`TenantConnectionResolver.cs:52-54`).
   - Connection strings are cached process-wide per client code for the life of the process (`TenantConnectionResolver.cs:33,59-73`) — registry changes to server/DB need a restart.
   - Resolving `AppDbContext` outside an HTTP request throws `InvalidOperationException` (`TenantConnectionResolver.cs:39-42`).
2. **Row scoping inside one client DB** by EF global query filters driven by the scope claims (`INF/Persistence/AppDbContext.cs:493-902`).
   - T&A customer-owned entities filter on `customer_access` (`AppDbContext.cs:503-523`); Department, Employee, Shift, Absence, TripCredit, TimescanTransaction, Schedule, EmployeePosition/Fte/Location/FieldValue also filter on `department_access` (`AppDbContext.cs:497-591`).
   - Employee visibility requires an ACTIVE department assignment (`RetireDate == null`) in the user's departments unless the user has all-departments (`AppDbContext.cs:534-538`).
   - `customer_access="*"` does NOT imply all departments (`AppDbContext.cs:190-204`).
   - Transportation entities use school/district/operator/depot claims; scopes union, wildcard in any dimension = full visibility, no grants = no rows (`AppDbContext.cs:593-762`).
   - Scoping is bypassed when there is no user id (no HttpContext) or `UseSystemContext()` is called (`AppDbContext.cs:173-188,349-359`). The timescan handlers call `UseSystemContext()` and scope manually (`TA-APP/Timescan/Commands/ClockIn/TimescanClockInCommandHandler.cs:33`).
   - Deliberately unfiltered tables: `pln_stop_school`, `pln_student_school`, `veh_vehicle_operator`, `pln_address_type`, `pln_substitution_reason` (`AppDbContext.cs:886-901`, `BusPlannerUnified/CLAUDE.md:147-149`).
- GraphQL uses a context-per-resolver factory registered **Scoped** so tenant + user scope still apply (`INF/DependencyInjection.cs:38-70`, `API/Program.cs:268`).

### 2.3 Middleware order (`API/Program.cs:311-370`)
ResponseCompression → (Dev only) Swagger → `ExceptionHandlingMiddleware` → CORS → `/health` and `/health/ready` (anonymous) → Authentication → Authorization → RateLimiter → controllers → `/graphql` (`RequireAuthorization`) → SPA fallback `index.html`.
- `/health` is liveness with no checks; `/health/ready` checks only the client registry (`API/Program.cs:231-232,362-363`).
- CORS origins come from configuration; with none configured the policy allows no origin (`API/Program.cs:200,210-226`). `Content-Disposition` is exposed for payroll downloads (`API/Program.cs:223`).
- JSON: `TimeOnly` accepts `HH:mm` without seconds (`API/Program.cs:28-32`, `API/Infrastructure/LenientTimeOnlyJsonConverter.cs`).

### 2.4 Authorization / permission model
- Permissions are string constants `area:entity:action` in `DOM/Authorization/Permissions.cs:5-228`; `Permissions.GetAll()` enumerates them by reflection (`:233-257`).
- Any `[Authorize(Policy="x:y")]` containing a colon becomes a `PermissionRequirement` dynamically (`INF/Auth/PermissionPolicyProvider.cs:16-22`); it passes only on an exact `permission` claim match — no wildcards, no Admin bypass (`INF/Auth/PermissionAuthorizationHandler.cs:11-15`).
- Admin gets permissions only through seeded role claims (migration `27_SeedDevteamAdmin`); new permissions need a follow-up migration (`BusPlannerUnified/CLAUDE.md:159`).
- Second check inside many T&A handlers: `ITaAuthorizationService.EnsurePermission(...)` → `ForbiddenException` → 403; bypassed when there is no user id (`TA-INF/Services/TaAuthorizationService.cs:16-25`).
- Per-client feature gate: `[RequireClientFeature(code)]` reads `BPFeatureFlag` live each request and returns 403 `{error}` (`API/Infrastructure/RequireClientFeatureAttribute.cs:17-38`). Feature codes: `GLOBAL_LOGIN`, `GPS`, `CHATBOT` (`REG/FeatureCodes.cs:12,20,30`). Only Chatbot controllers use the attribute in scope (`API/Modules/Chatbot/ChatbotController.cs:23`).
- **GraphQL requires authentication only**; individual resolvers are generally NOT permission-gated (code comment: "GraphQL reads being un-gated in general is a separate known gap", `API/GraphQL/Query.cs:75-77`). Exceptions: `auditEvents` / `auditEventTypeCounts` need `ta:auditlogs:read` (`Query.cs:227,244`); `shifts(includeDeleted:true)` needs `ta:shift:read` (`Query.cs:94-98`).
- `docs/specs/TimeAndAttendance-Permissions.md` is partly stale: it lists many controllers as auth-only (`:168-183`) but they now carry policies (see section 3), and it omits `ta:employeepin:write`, `ta:auditlogs:read`, `pln:*`, `analytics:read`, `gpsplus:*`, `chatbot:*`.

### 2.5 Validation
- FluentValidation validators are registered by assembly scan but are **not auto-executed**; each handler must call `ValidateAndThrow` itself (`TA-APP/DependencyInjection.cs:44`, `TA-APP/Shifts/Commands/EditShiftTimes/EditShiftTimesCommandHandler.cs:25-26`).
- `CreateShiftCommandValidator` (shift date not more than 1 day in the future) is never invoked: no reference outside its own file, and `CreateShiftCommandHandler` takes no validator (`TA-APP/Shifts/Commands/CreateShift/CreateShiftCommandValidator.cs:10-12`, `CreateShiftCommandHandler.cs:11-19`).
- Controllers that bypass handlers throw `ValidationException`/`ConflictException` inline (e.g. `API-TA/PayPeriodsController.cs:79-89`).

### 2.6 Error handling (`API/Middleware/ExceptionHandlingMiddleware.cs`)

| Exception | Status | Line |
|---|---|---|
| `NotFoundException` | 404 | 40 |
| `ConflictException` | 409 | 41 |
| `ForbiddenException` | 403 | 42 |
| `UnauthorizedAccessException` | 401 | 45 |
| `ServiceUnavailableException` | 503 | 46 |
| `FluentValidation.ValidationException` | 400 (messages joined with "; ") | 47-50 |
| `DbUpdateException` with SQL 2627/2601 (unique violation) | 409 "The change conflicts with an existing record." | 55-56,180-181 |
| SQL timeout (-2), read or write | 504 | 63-65,76-78 |
| Deadlock (1205) | 503 | 79-86 |
| Transient connection faults on GET/HEAD/OPTIONS only | 503 | 97-99,194-202 |
| Client aborted request | 499, no body | 106-107,133-134 |
| anything else (incl. `ArgumentException`, `FormatException`) | 500 "An unexpected error occurred." | 108 |

- Body shape: `{ error, traceId }`; in Development also `detail` (stack) and `db` (server/database) (`:143-173`). Environment is read from `ASPNETCORE_ENVIRONMENT` directly (`:204-208`).
- Some controllers return a different shape (`{ message }` in Auth/Tenant, bare strings in `BadRequest(...)`): `API/Controllers/AuthController.cs:22`, `API/Controllers/TenantController.cs:23`, `API-TA/PayrollExportController.cs:339`, `API-TA/ShiftsController.cs:65`.

## 3. API surface

Class-level policy applies to GETs; write policies are per action. "auth" = any valid app JWT.

### 3.1 Platform controllers (`API/Controllers/`)

| Controller | Route | Purpose | Permissions |
|---|---|---|---|
| `AuthController` | `api/auth/login` | Login, returns JWT + permission/scope lists | anonymous (`:7-10`) |
| `TenantController` | `api/tenant/by-code`, `resolve-email`, `logo` | Pre-auth branding, email→client list, logo proxy | anonymous (`:7-54`) |
| `SessionController` | `api/session/time-zone`, `hours-format` | Display zone / hours format for the session | auth (`:17-18,41,122`) |
| `UsersController` | `api/users` (+`/permissions`, `/roles`, `/{id}`, `/{id}/password`) | User admin; writes also maintain registry routing rows (`API/Program.cs:76-78`) | `admin:users:read` / `:write` / `:delete` (`:17,188,348,460,483`) |
| `RolesController` | `api/roles` (+`/permissions`, `/{id}/users`) | Role + role-permission + membership admin | `admin:roles` for everything (`:13`) |
| `CustomersController` | `api/customers` (+`/time-zones`) | Customer CRUD | `customer:read` / `:write` / `:delete` (`:16,48,58,72`) |
| `SchoolsController`, `DistrictsController`, `OperatorsController`, `DepotsController` | `api/schools`, `api/districts`, `api/operators`, `api/depots` | Read-only lists | `pln:school:read`, `pln:district:read`, `pln:operator:read`, `pln:depot:read` (each `:10-14`) |

### 3.2 T&A controllers (`API-TA/`)

| Controller | Route prefix | Purpose | Read / Write / Delete |
|---|---|---|---|
| `EmployeesController` | `api/ta/employees` (+`/import`) | Employee CRUD, CSV import | `ta:employee:read` / `:write` / `:delete` (`:21,75,85,366,380`) |
| `EmployeePinController` | `api/ta/employees/{id}/pin` | Set/reset mobile PIN (PUT) | `ta:employeepin:write` (`:15`) |
| `EmployeeDepartmentController` | `api/ta/employee-departments` | Assign department (PUT) | `ta:employee:read` / `:write` (`:13,18`) |
| `EmployeePositionController` | `api/ta/employee-positions` | Position links (GET/POST/DELETE) | `ta:employee:read`; POST and DELETE both `ta:employee:write` (`:13,63,108`) |
| `EmployeeLocationController` | `api/ta/employee-locations` | Location links | `ta:employee:read`; POST and DELETE `ta:employee:write` (`:13,49,77`) |
| `EmployeeFieldsController` | `api/ta/employee-fields` (`/definitions`, `/values`) | Custom-field definitions + values | `ta:employee:read` / `:write` / `:delete` (`:13,19,45,61,74`) |
| `DepartmentsController` | `api/ta/departments` | CRUD | `ta:department:*` (`:15,41,62,90`) |
| `PositionsController` | `api/ta/positions` | CRUD | `ta:position:*` (`:13,17,46,71`) |
| `PositionJobCodeController` | `api/ta/position-job-codes` | Eligibility links | `ta:position:read`; POST and DELETE `ta:position:write` (`:13,49,74`) |
| `JobCodesController` | `api/ta/job-codes` (+`/{id}/has-shifts`) | CRUD | `ta:jobcode:*` (`:13,17,44,86`) |
| `LocationsController` | `api/ta/locations` | CRUD (geofence centres) | `ta:location:*` (`:16,23,31,40`) |
| `AbsenceTypesController` | `api/ta/absence-types` | CRUD | `ta:absencetype:*` (`:13,17,40,59`) |
| `AbsencesController` | `api/ta/absences` (+`/range`) | List by employee, create, range-create, edit, delete | `ta:absence:*` (`:15,34,44,72,80`) |
| `HolidaysController` | `api/ta/holidays` (+`/batch`) | CRUD + batch | `ta:holiday:*` (`:14,18,76,166,226`) |
| `ShiftTemplatesController` | `api/ta/shift-templates` | CRUD | `ta:shifttemplate:*` (`:14,18,43,64`) |
| `SchedulesController` | `api/ta/schedules` (+`/bulk`) | Planned shifts | `ta:schedule:*` (`:13,59,96,195,226`) |
| `ShiftsController` | `api/ta/shifts` (+`/pay-period/{id}`, `/{id}/times`, `/{id}/clock-out`) | Shift read, clock-in (POST), edit times, clock-out, delete | `ta:shift:read` / `:write` / `:delete` (`:16,48,58,72,90`) |
| `TimesheetController` | `api/ta/timesheet` (`/bulk-approve`, `/shifts`, `/shifts/{id}/vehicle`, `/shifts/{id}/job-code`, `/clock-in`, `/shifts/{id}/delete-punches`) | Driver Time Sheet writes | class: auth only (`:18`); bulk-approve `ta:approval:write` (`:107`); all others `ta:shift:write` (`:297,359,417,517,652`) |
| `ApprovalsController` | `api/ta/approvals/shifts/{id}/approve` | Approve next step of one shift | `ta:approval:write` (`:14`) |
| `ApprovalStepsController` | `api/ta/approval-steps` | Approval chain config | `ta:approval:read` / `:write` / `:delete` (`:14,18,60,85`) |
| `RoundingRulesController` | `api/ta/rounding-rules` (+`/recalculate`) | Rule CRUD + payable recalculation | `ta:roundingrule:*`; recalc = `:write` (`:17,25,33,51,62`) |
| `TaSettingsController` | `api/ta/settings` | Per-customer name/value settings | `ta:tasettings:*` (`:14,18,45,67`) |
| `PayPeriodsController` | `api/ta/pay-periods` (+`/counts`, `/auto-generate`) | Pay-period CRUD, generator | `ta:payperiod:*` (`:17,76,104,214,265`) |
| `PayrollExportController` | `api/ta/payroll-export` (`/pay-periods`, `/departments/{id}`, `/review`, `/generate`, `/recompute`) | Export wizard | `ta:payperiod:read`; generate + recompute `ta:payperiod:write` (`:19,189,280`) |
| `PayrollExportHistoryController` | `api/ta/payroll-export/history` (`/{id}`, `/{id}/download`, `/{id}/reproduce`) | Preserved exports | `ta:payperiod:read` for all, incl. POST reproduce (`:18,99`) |
| `PayrollSimulateController` | `api/ta/payroll-export/simulate` | Engine playground (POST, no DB writes per spec) | `ta:payperiod:read` (`:18`) |
| `TripCreditsController` | `api/ta/trip-credits` | GET + POST only (no PUT/DELETE endpoint) | `ta:tripcredit:read` / `:write` (`:12,28`) |
| `UserPreferencesController` | `api/preferences` | Per-user UI prefs | auth (`:13`) |
| `TimescanAuthController` | `api/ta/timescan/auth/pin` | Mobile PIN → session token | anonymous + rate limit (`:21-22`) |
| `TimescanClockController` | `api/ta/timescan` (`/clock-in`, `/change-job`, `/clock-out`, `/current-state`, `/eligible-job-codes`, `/eligible-vehicles`, `/last-shift`) | Mobile clock | timescan session token only (`:24`) |

### 3.3 Other controllers in `API/Modules/` (logic owned by other maps)

| Route | Permission | Source |
|---|---|---|
| `api/analytics/stop-classification/*` (17 GETs), `api/analytics/otp`, `api/analytics/path-deviation`, `api/analytics/ride-time` | `analytics:read` | `API/Modules/Analytics/*.cs` |
| `api/gpsplus/compare/{grid,map,on-path}` | `gpsplus:compare:read` | `API/Modules/GpsPlus/CompareController.cs:39` |
| `api/gpsplus/event-log` | `gpsplus:events:read` | `EventLogController.cs:19` |
| `api/gpsplus/route-management` (`routes`, `drivers`, POST `vehicle`, POST `driver`) | `gpsplus:routemanagement:write` (GETs too) | `RouteManagementController.cs:17` |
| `api/gpsplus/route-selection` | auth only | `RouteSelectionController.cs:25` |
| `api/map/*` (incl. POST `draw`, `stops/{id}/students`) | auth only | `API/Modules/Map/MapController.cs:15` |
| `api/planning/map/{runs,students,schools,zones}` | auth only | `API/Modules/Planning/PlanningMapController.cs:25` |
| `api/chatbot/*`, `api/admin/chatbot/*` | `chatbot:read`, `admin:chatbot:read/write` + `CHATBOT` feature | `API/Modules/Chatbot/*Controller.cs` |

### 3.4 GraphQL (`/graphql`, `API/GraphQL/Query.cs`)
- Query type only — no mutations or subscriptions registered (`API/Program.cs:237-257`).
- Cursor paging with total count; default page 50, max 500 on T&A/core fields (`Query.cs:19`); planning fields have no explicit max (`Query.cs:323`); one field allows 2500 (`Query.cs:670`).
- T&A root fields: `customers`, `employees`, `employeeById`, `departments`, `positions`, `jobCodes`, `locations`, `shifts`, `payPeriods`, `absences`, `absenceTypes`, `holidays`, `positionHolidays`, `tripCredits`, `timescanTransactions`, `roundingRules`, `shiftTemplates`, `schedules`, `approvalSteps`, `auditEvents`, `auditEventTypeCounts`, `timescanDevices`, `taSettings`, `employeeDepartments`, `employeePositions`, `positionJobCodes`, `employeeLocations`, `departmentPayPeriods` (`Query.cs:23-319`).
- Most list fields take `includeDeleted`, implemented with `IgnoreQueryFilters()` (`Query.cs:32-33,44-66,111-133,176-191`). Only `shifts` and `roundingRules` re-apply the tenant scope after that (`Query.cs:100-104,167-170`).
- Field/type cost limits are set to effectively unlimited (`API/Program.cs:270-280`). Exception details only in Development (`API/Program.cs:269`).
- Computed fields: `TimescanTransaction.localTimestamp`, `ShiftTransaction.editedLocalTimestamp`; `PasswordHash` hidden (`API/Program.cs:240-247`, `BusPlannerUnified/CLAUDE.md:160`).

## 4. Domain model

- Base: GUID PKs with `NEWSEQUENTIALID()`, soft delete (`is_deleted`), audit columns stamped in `SaveChanges` (UTC + user email) (`BusPlannerUnified/CLAUDE.md:143-151`, `INF/Persistence/AppDbContext.cs:394-414`). Cascade delete disabled globally (`AppDbContext.cs:474-479`).
- Core: `Customer` (has `TimeZone`), `AppSettings` (`DOM/Entities/`). A client DB can hold more than one customer (`TA-APP/Timescan/Commands/AuthenticatePin/AuthenticatePinCommandHandler.cs:31-37`).

| T&A entity (`TA-DOM/Entities/`) | Key facts and relationships |
|---|---|
| `Employee` | belongs to Customer; `EmployeeNumber`, `HireDate`, `TerminationDate`, `IsActive`, `ExternalGuid`; has DepartmentAssignments, PositionAssignments, FteHistory, Shifts, Absences, TripCredits, TimescanTransactions (`Employee.cs:5-29`) |
| `Department`, `Position`, `JobCode`, `Location` | customer-owned lookups; `JobCode` has `RequiresVehicle`, `ExternalPaycode` (`TA-APP/Timescan/Services/TimescanShiftWriter.cs:67`, `TA-APP/PayrollExport/PayrollDataLoader.cs:196`); `Location` has lat/long + `GeofenceRadiusFeet` |
| `EmployeeDepartment`, `EmployeePosition`, `EmployeeFte`, `EmployeeLocation` | temporal joins with `EffectiveDate` / `RetireDate` |
| `PositionJobCode` | which job codes a position may clock into (eligibility, "BR-57") |
| `PositionHoliday` | which positions a holiday applies to (none = everyone) |
| `Shift` | Employee, optional PayPeriod/Location/JobCode; three time tiers `Actual*` (private setters), `Edited*`, `Payable*` as `TimeOnly` on `ShiftDate`; `ApprovalStatus` PENDING/APPROVED (`Shift.cs:5-32`) |
| `TimescanTransaction` + `ShiftTransaction` | punches (UTC instant, type CLOCK_IN/CLOCK_OUT, vehicle, lat/long, `IsManualEntry`) linked to shifts; link carries per-punch correction `EditedLocalTimestamp` |
| `TimescanAudit`, `AuditEvent` | field-level audit rows; `AuditEvent` is a keyless view `ta_audit_event_v` (`AppDbContext.cs:54-55`) |
| `Schedule`, `ShiftTemplate` | planned start/end per employee/day (floor/cap anchor) |
| `RoundingRule` | customer default, or scoped to ONE position or ONE job code; `RoundToMinutes`, `RoundType`, `MinFloorEnabled`, `MaxCapBufferMinutes` |
| `PayPeriod`, `DepartmentPayPeriod` | Customer; StartDate/EndDate; Status OPEN/CLOSED/EXPORTED; `ExportedDate/By` |
| `Absence`, `AbsenceType` | per employee per date, `Hours`, `Status`; type has `IsPaid`, `TypeCode` |
| `TripCredit`, `TripCreditApproval` | credited hours per employee/date/job code |
| `Holiday` | date, `IsPaid` |
| `ApprovalStep`, `ShiftApproval`, `ApprovalHistory` | ordered chain with optional `PermissionName`; unique (shift, step); history used for SHIFT, ABSENCE, PAY_PERIOD events |
| `PayrollExport`, `PayrollExportLine` | frozen snapshot + rendered bytes + per-employee/day lines; `PayPeriodId` null = ad-hoc range |
| `PayableRecalculation`, `PayableRecalculationLine` | history of recalculation runs |
| `EmployeePin` | salted PIN hash, `FailedAttemptCount`, `LockoutUntilUtc` |
| `TaSettings` | per-customer name/value |
| `EmployeeFieldDefinition`, `EmployeeFieldValue` | EAV custom fields |
| `Usr*`, `UserEntityScope`, `UserPreference`, `WorkspaceLayout` | legacy user/role tables; `usr_user_entity_scope` is not wired into query filters (`BusPlannerUnified/CLAUDE.md:169-170`) |

- Transportation chain (`DOM/Entities/Transportation/`): `PlnSnapshot` (per customer per date) → `PlnRoute` → `PlnRun` → `PlnStop` → `PlnStudentStop` → `PlnStudent`; `PlnSchool` → `PlnDistrict`; `VehVehicle` ↔ `OprOperator` / `PlnDepot`; `GpsStopVisited`; view `GpsLiveFleetRow` (`AppDbContext.cs:77-124,660-809`).

## 5. Time & Attendance

### 5.1 Three time tiers and the payable engine
Single owner: `IPayableTimeService` → `TA-INF/Services/PayableTimeService.cs`. Rounding: `TA-INF/Services/RoundingService.cs`.

- Payable input is `edited ?? actual`, per endpoint (`PayableTimeService.cs:23-24`).
- A shift that has punches is paid from its punches as the SUM of each window's (rounded) length, not first-in to last-out (`PayableTimeService.cs:83-110`).
- Rule precedence is job-code rule → position rule (assignment active on shift date; primary first, then latest effective) → customer default → none (`PayableTimeService.cs:254-297`).
- With no resolvable rule, payable equals the unrounded candidate times and no floor/cap applies (`PayableTimeService.cs:117-119`).
- NEAREST rounds a half interval up (away from zero); UP is ceiling; DOWN is floor (`RoundingService.cs:20-26`).
- Seconds participate in rounding: a 1-minute NEAREST rule turns 06:25:45 into 06:26 (`RoundingService.cs:11-13`).
- Rounded results are clamped to 00:00–23:59, so 23:55 rounded UP to 15 gives 23:59, not 00:00 (`RoundingService.cs:31-32`).
- An unknown `RoundType` on a stored rule throws a validation error (400) at compute time (`RoundingService.cs:27-28`).
- Rule validation: `RoundToMinutes` 1–60; type NEAREST/UP/DOWN; scope is position OR job code, never both; name ≤100 (`TA-APP/RoundingRules/Commands/CreateRoundingRule/CreateRoundingRuleCommandValidator.cs:15-28`).
- Duplicate rule name or duplicate scope → 409 (`TA-APP/RoundingRules/Commands/CreateRoundingRule/CreateRoundingRuleCommandHandler.cs:35,62`).
- Floor only raises payable start to the matched schedule's start; cap only lowers payable end to schedule end + buffer (`PayableTimeService.cs:142-156`).
- Cap buffer = rule's `MaxCapBufferMinutes`, else setting `payable.max_cap.default_buffer_minutes`, else cap is off (`PayableTimeService.cs:133-134`).
- Floor/cap silently do nothing when the employee has no schedule that day (`PayableTimeService.cs:139-140,313`).
- Schedule matching is strict on job code when the shift has one and any same-day schedule has one; otherwise closest scheduled start wins (`PayableTimeService.cs:315-334`).
- A shift entirely outside its planned window pays zero (end forced to start) (`PayableTimeService.cs:162-163,236-240`).
- For punched shifts floor/cap are applied per window; windows crossing midnight skip clamping (`PayableTimeService.cs:210-232`).
- Settings `payable.rounding.enabled`, `payable.min_floor.enabled`, `payable.max_cap.enabled` default true; `payable.override_allow` defaults false (`TA-APP/Interfaces/ITaSettingsReader.cs:15-53`).
- Setting names match case-insensitively; booleans accept true/false/1/0 (trimmed); an invalid value falls back to the default with a log warning (`TA-INF/Services/TaSettingsReader.cs:34-64`).
- Default cap buffer must be an integer 0–1440 or it is ignored (`TaSettingsReader.cs:71-77`).
- `applyRounding:false` or an explicit `roundingRuleId` on an edit returns 403 unless `payable.override_allow` is true (`PayableTimeService.cs:41-43`).
- An explicit `roundingRuleId` that is deleted or belongs to another customer returns 404 (`PayableTimeService.cs:77-80`).
- Payable is computed at write time only; changing a rule or setting does not change existing shifts until re-save or a recalculation run (`docs/qa/TimeAndAttendance-RoundingRules-TestGuide.md:135-137`).

### 5.2 Supervisor clock-in/out and shift edits (web)
- `POST api/ta/shifts` opens a shift with actual start and payable start only; 409 if the employee already has an open shift on the SAME date (`TA-APP/Shifts/Commands/CreateShift/CreateShiftCommandHandler.cs:25-50`).
- The new shift links to the pay period containing its date, or to none (`CreateShiftCommandHandler.cs:40-45`).
- `PUT api/ta/shifts/{id}/clock-out`: 409 if already clocked out, 409 if the day is frozen, 409 if end is before start (`TA-APP/Shifts/Commands/ClockOutShift/ClockOutShiftCommandHandler.cs:26-35`).
- `PUT api/ta/shifts/{id}/times`: route id must equal body `ShiftId` or 400 (`API-TA/ShiftsController.cs:64-65`).
- Span-mode edit with end before start is rejected (400) — overnight shifts cannot be corrected this way (`TA-APP/Shifts/Commands/EditShiftTimes/EditShiftTimesCommandValidator.cs:33-36`).
- A NEW zero-length edit (start == end) is rejected (400) unless the shift was already zeroed (`EditShiftTimesCommandHandler.cs:72-75`).
- Editing a frozen shift returns 409 (`EditShiftTimesCommandHandler.cs:40-41`).
- Changing job code in the edit must pass position↔job-code eligibility, checked only when the value changes (`EditShiftTimesCommandHandler.cs:81-83`).
- Editing an APPROVED or partially approved shift resets it to PENDING, deletes its approval rows and writes an approval-history row (`EditShiftTimesCommandHandler.cs:90-109`).
- Per-window edit must list every punch window exactly once, or 400 (`EditShiftTimesCommandHandler.cs:313-318`, validator `:40-43`).
- Per-window edit cannot remove a logged clock-out (400) and cannot move an existing punch across midnight (`EditShiftTimesCommandHandler.cs:342-345,292-299`).
- A per-window edit where every time equals its raw punch clears the edited tier (works as undo) (`EditShiftTimesCommandHandler.cs:393-394`).
- Edits write `shift_times` and `job_code_guid` audit rows only when the shift has at least one live punch (`EditShiftTimesCommandHandler.cs:197-259`).
- `DELETE api/ta/shifts/{id}` soft-deletes the shift and its punches; 409 if frozen; voids approvals (`TA-APP/Shifts/Commands/DeleteShift/DeleteShiftCommandHandler.cs:42-83`).
- Manual shift (`POST api/ta/timesheet/shifts`): out-of-scope employee → 404; frozen day → 409; ineligible job code refused; payable always computed server-side; overnight (end < start) allowed (`API-TA/TimesheetController.cs:302-345`).
- Add punch pair (`POST api/ta/timesheet/clock-in`): equal in/out → 409; out before in means next day; attaches to an un-edited shift with same employee + date + job code, else creates a new shift; overlapping an existing window → 409 (`TimesheetController.cs:528-595`).
- `PUT .../shifts/{id}/job-code` recomputes payable and resets approvals; no-op when unchanged (`TimesheetController.cs:437-503`).
- `PUT .../shifts/{id}/vehicle` writes the vehicle to every punch of the shift and returns `updatedPunches` (0 for punchless shifts) (`TimesheetController.cs:385-407`).

### 5.3 Mobile clock-in (timescan)
- `POST api/ta/timescan/auth/pin` needs header `X-Client-Code`; missing/unknown → 400; client without `GLOBAL_LOGIN` → 403 (`API-TA/TimescanAuthController.cs:57-71`).
- Wrong employee number and wrong PIN return the same 401 "Employee ID or PIN is incorrect." (`TimescanAuthController.cs:84-86`).
- Lockout is reported as HTTP 200 with `locked_out:true` and `lockout_minutes` (`TimescanAuthController.cs:79-80`).
- After K consecutive wrong PINs (default 5, per-customer setting overrides) the PIN locks for N minutes (default 15) and the counter resets (`TA-APP/Timescan/Commands/AuthenticatePin/AuthenticatePinCommandHandler.cs:69-82,110-127`, `TA-APP/Timescan/TimescanAuthOptions.cs:15-18`).
- While locked, even the correct PIN is refused (`AuthenticatePinCommandHandler.cs:64-65`).
- An employee number matching two active employees (across customers in one DB) fails like a bad PIN (`AuthenticatePinCommandHandler.cs:38-46`).
- Inactive or soft-deleted employees cannot authenticate (`AuthenticatePinCommandHandler.cs:39-41`).
- PIN must be 4–8 digits when set (`TA-APP/Timescan/Commands/SetEmployeePin/SetEmployeePinCommandValidator.cs:12-15`).
- PIN endpoint is rate-limited per client IP, fixed 1-minute window, 429 on excess (`API/Program.cs:185-197`).
- Session token lifetime defaults to 300 s (`TimescanAuthOptions.cs:12`, `API/appsettings.json:25`).
- Clock endpoints take employee and customer from token claims, never from the body (`API-TA/TimescanClockController.cs:16-21`).
- Clock-in when a shift is already open (any date) → 409 "You are already clocked in." (`TA-APP/Timescan/Commands/ClockIn/TimescanClockInCommandHandler.cs:36-39`).
- Job code must be active and reachable through an employee position active on the shift date, else 403 (`TA-APP/Timescan/Services/TimescanShiftWriter.cs:63-81`).
- A job code with `RequiresVehicle` and no vehicle → 400; a vehicle not currently assigned to the employee → 403 (`TimescanShiftWriter.cs:84-102`).
- Clock-in into a CLOSED/EXPORTED pay period → 409, checked before the geofence (`TimescanShiftWriter.cs:118-119`).
- Outside every geofence → HTTP 422 with the nearest location name, and nothing is recorded (`TimescanClockController.cs:60-61`, `TimescanShiftWriter.cs:122-124`).
- Geofence is OFF (always passes) when the customer has no active location with coordinates; a null radius means 500 ft; boundary is inclusive (`TA-INF/Services/GeofenceService.cs:25-34,51-53`).
- `captured_at` is treated as a UTC instant and converted to the customer's zone to derive `shift_date` and wall-clock times; the punch row keeps the UTC instant (`TimescanShiftWriter.cs:44-54,141`).
- Shift times are truncated to whole seconds (`TimescanShiftWriter.cs:217-220`).
- Clock-out with no open shift → 409 "You are not clocked in."; geofence is re-checked independently (`TA-APP/Timescan/Commands/ClockOut/TimescanClockOutCommandHandler.cs:38-48`).
- An overnight mobile shift stores end < start on the clock-in's date (`TimescanShiftWriter.cs:168-172`).
- Change-job closes the old shift and opens a new one in one save; a stale `open_transaction_guid` → 409; any failure leaves the driver on the original job (`TA-APP/Timescan/Commands/ChangeJob/TimescanChangeJobCommandHandler.cs:44-66`).
- `GET current-state` returns 204 when the driver has no open shift (`TimescanClockController.cs:143-149`).

### 5.4 Approvals
- Shift status is PENDING or APPROVED only; REJECTED is never written (`TA-DOM/Entities/Shift.cs:23-24`).
- Approve advances the next pending active step; the shift becomes APPROVED only when the last step is approved (`TA-APP/Approvals/Commands/ApproveShift/ApproveShiftCommandHandler.cs:49-60,108`).
- With zero active steps, approve sets APPROVED directly (`ApproveShiftCommandHandler.cs:62-77`).
- A step with `PermissionName` requires the current user to hold it, else 403 (single-approve path) (`ApproveShiftCommandHandler.cs:82-86`).
- Approving an already APPROVED shift → 409; a shift missing a clock-out → 409; exported time → 409 (`ApproveShiftCommandHandler.cs:33-44`).
- A shift counts as "missing clock-out" by FIFO pairing of punches unless it has an edited end time (`Shift.cs:76-116`).
- Bulk approve covers the given employees and date range; ANY unresolved shift rejects the whole request with 409 (`API-TA/TimesheetController.cs:129-146`).
- Bulk approve also approves the employees' absences in range and returns per-outcome counts that sum to matched records (`TimesheetController.cs:238-292`).

### 5.5 Pay periods and the freeze
- Status values: OPEN, CLOSED, EXPORTED (`API-TA/PayPeriodsController.cs:220-221`).
- Create/update with end before start → 400; overlap with another period of the same customer → 409 (`PayPeriodsController.cs:79-89,236-240`).
- EXPORTED cannot be reopened and cannot be set manually (both 409); EXPORTED periods cannot be deleted (`PayPeriodsController.cs:226-233,271-272`).
- Status changes write a `PAY_PERIOD` approval-history row (`PayPeriodsController.cs:244-255`).
- Auto-generate supports weekly, semimonthly (1st/16th), monthly (anchored day), default biweekly; overlapping generated periods are skipped and counted (`PayPeriodsController.cs:129-153`).
- A day is frozen when a CLOSED or EXPORTED period covers it, OR the employee's day appears in an export line of a pay-period export (`TA-APP/PayPeriodLock.cs:38-59`).
- Ad-hoc range exports never freeze anything (`PayPeriodLock.cs:22-25,50`).
- A shift with no pay-period link falls back to the date check (`PayPeriodLock.cs:102-117`).
- Frozen days refuse: shift edit, supervisor clock-out, shift delete, set vehicle, set job code, manual shift, add punch, absence create/edit/delete (409 each) (`EditShiftTimesCommandHandler.cs:40`, `ClockOutShiftCommandHandler.cs:31`, `DeleteShiftCommandHandler.cs:42`, `TimesheetController.cs:57-69,370,428`, `TA-APP/Absences/Commands/CreateAbsence/CreateAbsenceCommandHandler.cs:41`, `EditAbsence/EditAbsenceCommandHandler.cs:32`, `DeleteAbsence/DeleteAbsenceCommandHandler.cs:24`).

### 5.6 Absences, trip credits, holidays
- One absence per employee per date (409 on duplicate); hours 0.01–24 (`CreateAbsenceCommandHandler.cs:38`, `CreateAbsenceCommandValidator.cs:11`).
- Edited absence hours must be > 0 and ≤ 24 (`TA-APP/Absences/Commands/EditAbsence/EditAbsenceCommandValidator.cs:12-14`).
- Range create: end ≥ start, manual hours/day 0.01–24 (`TA-APP/Absences/Commands/CreateAbsence/CreateAbsenceRangeCommandHandler.cs:25-29`).
- Trip credit needs employee, job code, credited hours 0.01–24 (`TA-APP/TripCredits/Commands/CreateTripCredit/CreateTripCreditCommandValidator.cs:9-11`).

### 5.7 Payable recalculation (`POST api/ta/rounding-rules/recalculate`)
Source: `TA-APP/RoundingRules/Commands/RecalculatePayable/RecalculatePayableCommandHandler.cs`.
- Requires `ta:roundingrule:write` (not a shift permission) (`:60`).
- Range capped at 13 weeks (validator `:29-31`) and 25,000 shifts (400 above) (`:50,89-93`).
- `DryRun` changes nothing and returns counts plus a sample (`:244,287-292`).
- Frozen shifts are skipped and counted (`:152-156,487-494`).
- A shift whose new payable would be incomplete while the stored one is complete is skipped (`skippedNoSource`) (`:177-183`).
- A punched shift whose correction exists only in legacy `edited_*` columns is skipped (`skippedLegacyEdit`) (`:201-205,465-480`).
- A changed shift that was approved (fully or partly) goes back to PENDING with a history row (`:213,246-265`).
- A run that changes nothing writes no history record and returns a null run id (`:296-315`).
- Department filter is effective-dated over the range; department + employee filters intersect; a filter resolving to nobody scans nothing (`:73-76,328-352`).

### 5.8 Payroll export
Engine: `TA-APP/PayrollExport/PayrollCalculationService.cs` (pure). Loader: `PayrollDataLoader.cs`. Controller: `API-TA/PayrollExportController.cs`. Spec: `docs/specs/PayrollExport-BusinessLogic.md`.
- Hours resolve per endpoint as payable ?? edited ?? actual (`PayrollCalculationService.cs:78-79,153-159`).
- Export never re-rounds (`ApplyRounding=false`); threshold 40 h; week starts Sunday; holiday fallback 8 h (`PayrollExportController.cs:374-381`).
- End < start means overnight (+24 h); end == start is zero hours (`PayrollCalculationService.cs:112-119`).
- A shift with only one endpoint counts 0 hours and adds a warning (`PayrollCalculationService.cs:123-127`).
- Overtime is weekly and attributed to the day the running total crosses 40; regular = clamp(40 − runningBefore, 0, dayWorked) (`PayrollCalculationService.cs:163-195`).
- Absence, trip-credit and holiday hours never count toward the 40-hour threshold (`PayrollCalculationService.cs:140-151`).
- Shifts are loaded by DATE over whole Sun–Sat weeks overlapping the range; out-of-range days advance the weekly total but are excluded from rollups (`PayrollDataLoader.cs:26-39`, `PayrollCalculationService.cs:57-61`).
- Shifts with status REJECTED are excluded; PENDING shifts are included and flagged unapproved (`PayrollDataLoader.cs:34,193`).
- Absences: in range, not REJECTED, paid types only (`PayrollDataLoader.cs:43-50`).
- Trip credits: in range, excluded if any live approval row is REJECTED; approved when no approval rows exist (`PayrollDataLoader.cs:53-61,201-208`).
- Paid holidays credit every ACTIVE employee of the customer whose hire/termination window covers the date; with position links, only holders of a linked position (`PayrollDataLoader.cs:109-162`).
- Holiday hours = FTE row effective on the date, else 8 (`PayrollDataLoader.cs:173-181`).
- Shift pay code = job code's `ExternalPaycode`, else its `Code`; holiday pay code is `HOL`; absence pay code is the absence type's `TypeCode` (`PayrollDataLoader.cs:161,196,199`).
- Totals are rounded to 2 decimals, half away from zero (`PayrollCalculationService.cs:292`).
- Scope is exactly one of `payPeriodId` or `startDate`+`endDate`; both, half a range, or inverted range → 400 (`PayrollExportController.cs:335-351`).
- Ad-hoc range: 400 when end − start ≥ 60 days (`PayrollExportController.cs:352-353`).
- `generate` on an EXPORTED pay period → 409 for state-mutating formats (`PayrollExportController.cs:200-201`).
- A full (unfiltered) pay-period generate sets status EXPORTED, stamps exported date/by, writes history; a filtered or department-restricted run does NOT change the period status (`PayrollExportController.cs:235-256`).
- Every state-mutating generate/recompute stores a versioned snapshot; versions count per pay period, or per exact date span for ad-hoc (`PayrollExportController.cs:262-267,363-371`).
- `recompute` is allowed on EXPORTED periods and appends a version (`PayrollExportController.cs:279-310`).
- Formats `generic`, `yankton`, `devraw`; `devraw` writes nothing and ignores inclusion settings (`docs/specs/PayrollExport-BusinessLogic.md:149-160`, `TA-APP/DependencyInjection.cs:92-94`).
- Settings `payroll.export.include_absences` / `include_trip_credits` / `include_holidays` (default true) remove those rows from FILES only, not from review (`docs/specs/PayrollExport-BusinessLogic.md:132-141`, `PayrollExportController.cs:213-217`).
- CSV cells are always quoted; a cell whose first non-space character is `=`, `+`, `-` or `@` gets a leading apostrophe; decimals use `.` (`TA-APP/PayrollExport/Formatters/CsvCell.cs:9-19`).
- Download name: `payroll-export-<start>_to_<end>.<ext>` (`PayrollExportController.cs:317-318`).
- Step-1 list excludes EXPORTED periods and periods with no shifts; `anyConfigured` ignores both (`PayrollExportController.cs:48-77`).

## 6. Data access

- ORM: EF Core 8, SQL Server, **single `AppDbContext`** = `IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>` holding core, T&A, transportation, chatbot and user tables (`INF/Persistence/AppDbContext.cs:13-147`).
- Registered twice: scoped context (controllers, handlers, Identity) and a scoped factory (GraphQL resolvers) (`INF/DependencyInjection.cs:35-70`).
- SQL compatibility level 120 is set on purpose so `Contains` lists inline as `IN (...)`; removing it reintroduces scope-filter timeouts (`INF/DependencyInjection.cs:167-178`).
- `DisableRowGoalInterceptor` rewrites tagged queries only (`INF/DependencyInjection.cs:179-182`).
- Unit of work: `INF/Persistence/UnitOfWork.cs` (`IUnitOfWork.SaveChangesAsync`); no explicit transactions seen in the T&A write paths read — atomicity relies on one `SaveChanges` per request.
- Raw SQL exists for login (`INF/Auth/AuthService.cs:46-82`) and for analytics/GPS readers (`INF/Services/StopClassificationService.cs`, `INF/Services/GpsPlus/*`) — these bypass EF query filters.
- **Schema changes do NOT use EF migrations.** `BusPlanner.MigrationTool` applies numbered idempotent SQL pairs `NN_Name.up.sql` / `.down.sql`; state per DB in `BPMigrationHistory` (`BusPlannerUnified/CLAUDE.md:198-213`).
- Highest migration in the snapshot: `75_SeedOnTimeEarlyThreshold.up.sql` (`BusPlannerUnified/BusPlanner.MigrationTool/Migrations/`).
- Baseline DDL is `BusPlannerUnified/BusPlanner.ETL/docs/bus-planner-schema-v7_21.sql` (v7.21) (`BusPlannerUnified/CLAUDE.md:234-235`).
- Admin user/role seeding is a migration (`27_SeedDevteamAdmin`), not startup code (`API/Program.cs:353-355`).
- Payroll seed scripts (`BusPlannerUnified/scripts/payroll-testdata/`) are coupled to schema and payroll code and must change together (`BusPlannerUnified/CLAUDE.md:215-219`).
- UNVERIFIED: how migrations are run against each client DB in deployed environments (tool is WPF + a CLI project; pipeline not in this map's scope).

## 7. Configuration and feature flags (names only)

Defined in `API/appsettings.json`, overridden by `appsettings.Development.json`, user-secrets or environment variables (`__` form). Secret values are empty in the committed file (`API/appsettings.json:9-16`).

| Key | Used for | Read at |
|---|---|---|
| `ConnectionStrings:ClientRegistry` | registry catalog DB | `API/Program.cs:73-78` |
| `Jwt:Secret`, `Jwt:Issuer`, `Jwt:Audience`, `Jwt:ExpiryMinutes` | app JWT | `API/Program.cs:125-158`, `INF/Auth/AuthService.cs:177-180` |
| `Timescan:SessionTokenSeconds`, `SessionTokenAudience`, `DefaultLockoutMaxAttempts`, `DefaultLockoutMinutes`, `RateLimitPermitsPerMinute` | mobile PIN auth | `API/Program.cs:119-121`, `TA-APP/Timescan/TimescanAuthOptions.cs` |
| `PayrollExport:DefaultFormatKey` | default export format | `API/Program.cs:63-64`, `API-TA/PayrollExportOptions.cs` |
| `Cors:AllowedOrigins` | CORS | `API/Configuration/CorsConfiguration.cs` |
| `Ibm:ApiKey`, `Cos:Endpoint`, `Cos:Bucket`, `Cos:ApiKey` | logo storage | `API/Program.cs:83-90` |
| `SecretsManager:ServiceUrl`, `SecretGroup`, `ApiKey`; `EmailHash:KeyVersion` | email-hash pepper | `API/Program.cs:93-104` |
| `Db:MasterUser`, `Db:MasterPassword` | per-client DB credentials (else Secrets Manager) | `API/Program.cs:108-114` |
| `BpInfo:WritesEnabled` | environment switch for GPS+ route-management writes | `INF/DependencyInjection.cs:132-133`, `API/appsettings.json:21-23` |
| `Anthropic:*`, `Chatbot:*` | chatbot (other map) | `API/appsettings.json:31-42` |
| `ASPNETCORE_ENVIRONMENT` | Dev-only error detail, Swagger, dev JWT key | `ExceptionHandlingMiddleware.cs:204-208`, `API/Program.cs:128,314` |

Per-client flags (registry table `BPFeatureFlag`): `GLOBAL_LOGIN`, `GPS`, `CHATBOT` (`REG/FeatureCodes.cs`).

Per-customer `ta_settings` keys (DB rows, managed at `api/ta/settings`):
- `payable.rounding.enabled`, `payable.min_floor.enabled`, `payable.max_cap.enabled`, `payable.max_cap.default_buffer_minutes`, `payable.override_allow` (`TA-APP/Interfaces/ITaSettingsReader.cs:15-37`).
- `payroll.export.include_absences`, `payroll.export.include_trip_credits`, `payroll.export.include_holidays` (`docs/specs/PayrollExport-BusinessLogic.md:136-141`; resolver `API-TA/PayrollExportSettingsResolver.cs`).
- PIN lockout max-attempts and lockout-minutes keys: constants in `TA-APP/Timescan/TimescanAuthDefaults.cs` (exact strings not read — UNVERIFIED).
- Per-client `app_settings` rows also exist (e.g. `BPInfo/WritesEnabled`, GPS+ thresholds) — `INF/Services/CLAUDE.md` ("Switch" paragraph); owned by the GPS map.

## 8. Risk notes for QA

**Permission checks that look inconsistent**
- GraphQL list reads need only a valid token; a user with no `ta:*:read` permission can still query `employees`, `shifts`, `absences`, `payPeriods`, `taSettings` etc. within their row scope (`API/GraphQL/Query.cs:28-33,75-77,107-119,272-276`).
- `includeDeleted:true` uses `IgnoreQueryFilters()` WITHOUT re-applying customer/department scope on `employees`, `departments`, `positions`, `jobCodes`, `locations`, `payPeriods`, `absences`, `absenceTypes`, `holidays`, `shiftTemplates`, `schedules`, `approvalSteps` — possible cross-customer/department read inside one client DB (`Query.cs:32-33,44-66,111-133,176-191`; contrast the re-scoped `Query.cs:100-104,167-170`; gap acknowledged for locations at `Query.cs:165-166`).
- Bulk approve does NOT enforce an approval step's `PermissionName`; single approve does (`API-TA/TimesheetController.cs:184-208` vs `TA-APP/Approvals/Commands/ApproveShift/ApproveShiftCommandHandler.cs:82-86`).
- Approval steps are loaded without a customer predicate in both approve paths (`ApproveShiftCommandHandler.cs:49-52`, `TimesheetController.cs:148-151`); for a user with access to several customers the steps of all of them apply — UNVERIFIED impact.
- `delete-punches` can soft-delete a whole shift with `ta:shift:write`, while `DELETE api/ta/shifts/{id}` needs `ta:shift:delete` (`TimesheetController.cs:648-652` vs `API-TA/ShiftsController.cs:89-90`).
- Deleting position/location/job-code links needs only `:write`, not `:delete` (`API-TA/EmployeePositionController.cs:107-108`, `EmployeeLocationController.cs:76-77`, `PositionJobCodeController.cs:73-74`).
- `RolesController` uses the single `admin:roles` permission for reads and writes (`API/Controllers/RolesController.cs:13`); GPS+ route-management GET lists require the WRITE permission (`API/Modules/GpsPlus/RouteManagementController.cs:17`).
- `api/map/*`, `api/planning/map/*`, `api/gpsplus/route-selection` are auth-only (`API/Modules/Map/MapController.cs:15`, `API/Modules/Planning/PlanningMapController.cs:25`, `API/Modules/GpsPlus/RouteSelectionController.cs:25`).
- `TaAuthorizationService` and `AppDbContext` treat "no user id" as a trusted system caller (`TA-INF/Services/TaAuthorizationService.cs:16-21`, `INF/Persistence/AppDbContext.cs:353-359`); a timescan session token carries no `NameIdentifier` — UNVERIFIED whether any handler reachable with that token relies on this.
- Web login has no lockout or throttling (`INF/Auth/AuthService.cs:46-64`; rate limiter covers only the PIN route, `API/Program.cs:185-197`).
- `api/tenant/resolve-email` is anonymous and reveals which clients an email belongs to (`API/Controllers/TenantController.cs:36-50`).

**Freeze / pay-period inconsistencies**
- `POST api/ta/shifts` (supervisor clock-in) has NO frozen-period check, unlike mobile clock-in and manual shift (`TA-APP/Shifts/Commands/CreateShift/CreateShiftCommandHandler.cs:17-55` vs `TA-APP/Timescan/Services/TimescanShiftWriter.cs:118-119`).
- Mobile clock-in/out check only the linked period's status — not the per-employee "already exported" lock and not the date fallback for unlinked shifts (`TimescanShiftWriter.cs:106-119,177-185` vs `TA-APP/PayPeriodLock.cs:102-117`).
- Approval is blocked only for EXPORTED, not CLOSED; bulk-approve absences check only EXPORTED period ranges, not per-employee exported days (`ApproveShiftCommandHandler.cs:33-35`, `TimesheetController.cs:245-259`).
- An EXPORTED period's dates can still be changed via PUT as long as status stays EXPORTED (`API-TA/PayPeriodsController.cs:226-259`); OPEN/CLOSED periods can be deleted even with shifts linked (`PayPeriodsController.cs:264-276`).
- Pay-period lookups in `TimesheetController` and `PayPeriodLock.IsDateLockedAsync` have no customer predicate — with two customers in one DB, one customer's CLOSED period freezes the other's same dates for an all-customer user (`TimesheetController.cs:60-63`, `PayPeriodLock.cs:38-41`). UNVERIFIED in practice.
- Spec says a pay-period generate always freezes the period; code freezes only unfiltered runs (`docs/specs/PayrollExport-BusinessLogic.md:193` vs `PayrollExportController.cs:235-237`). The in-code comment "a per-employee freeze does not exist" (`PayrollExportController.cs:230-233`) contradicts `PayPeriodLock.WasExportedAsync`.

**Date / time / timezone**
- `ta_shift` times are LOCAL wall-clock `TimeOnly` on one `ShiftDate`; punches are UTC instants; conversion uses `pln_customer.time_zone` (`TimescanShiftWriter.cs:44-54`).
- Missing or invalid customer time zone silently falls back to UTC with only an error log — punches land on the wrong time/date (`TA-INF/Services/CustomerTimeZoneService.cs:63-84`).
- Mobile `captured_at` comes from the device and is not compared with server time (`TimescanShiftWriter.cs:52-54,141`) — backdated/future punches are accepted; UNVERIFIED whether another layer limits this.
- Overnight handling differs by path: mobile and add-punch allow end < start; supervisor clock-out and span edits reject it (`ClockOutShiftCommandHandler.cs:34-35`, `EditShiftTimesCommandValidator.cs:33-36`, `TimesheetController.cs:525-535`).
- An overnight shift belongs entirely to its clock-in date for weekly overtime and period membership (`PayrollCalculationService.cs:112-119`, `PayrollDataLoader.cs:33-34`).
- DST: engine math is wall-clock only (`PayrollCalculationService.cs:16-17`) — a shift spanning a DST change is paid by clock difference, not elapsed time. UNVERIFIED as intended.
- A multi-punch payable span is synthetic (start + sum of windows) and can wrap past midnight for long days (`PayableTimeService.cs:203-209,242`); anything reading `payable_end` as a clock time is wrong.
- Session time zone for multi-customer users is "most common zone" (`API/Controllers/SessionController.cs:49-58`).
- Program comment calls the timescan token "60-second"; actual default is 300 s (`API/Program.cs:160-163` vs `TimescanAuthOptions.cs:12`).

**Rounding / calculation**
- `MinutesOf` drops seconds in per-window floor/cap math while the envelope path compares full times (`PayableTimeService.cs:226-227,337` vs `:152-155`).
- Rounding near midnight clamps to 23:59 instead of rolling over (`RoundingService.cs:31-32`).
- Cap is clamped to 23:59 (`PayableTimeService.cs:152,219`).
- Open shift at clock-in stores payable start only; payroll counts a one-ended shift as 0 h with a warning (`CreateShiftCommandHandler.cs:49-50`, `PayrollCalculationService.cs:123-127`).
- Job-code change on a punchless (manual) shift does not recompute payable — `RecomputePunchPayableAsync` returns early with no punch pairs (`TimesheetController.cs:97,456`).
- Recalculation skips legacy-edit and no-source shifts rather than fixing them; check the counters, not just "changed" (`RecalculatePayableCommandHandler.cs:177-205`).
- `docs/qa/TimeAndAttendance-RoundingRules-TestGuide.md:132-133,257-260` lists carve-outs (Add Clock-In uses default rule only; Set Job Code does not recompute) that the code comments say were removed (`TimesheetController.cs:19-28,447-456`) — treat the guide as stale there.
- Holiday candidates use `EmployeePosition.RetireDate == null` (current), not the position held on the holiday date (`PayrollDataLoader.cs:133-135`).
- Export department list maps an employee to the first current department only (`PayrollExportController.cs:100-108`).

**Concurrency**
- "Already clocked in" is check-then-insert with no lock; two simultaneous clock-ins can both pass (`TimescanClockInCommandHandler.cs:36-48`, `CreateShiftCommandHandler.cs:25-53`). UNVERIFIED whether a DB unique index backs it.
- Two simultaneous `generate` calls can both pass the EXPORTED check and both write a version (`PayrollExportController.cs:200-201,262-267`). UNVERIFIED whether version number is unique-constrained.
- Pay-period overlap check is check-then-insert (`PayPeriodsController.cs:85-99`).
- No optimistic concurrency token was seen on `Shift` (`TA-DOM/Entities/Shift.cs`) — last write wins on concurrent edits. UNVERIFIED for row-version columns configured elsewhere.
- Unique-key races surface as a generic 409 (`ExceptionHandlingMiddleware.cs:55-56`).
- Tenant connection-string cache is process-wide and never invalidated (`TenantConnectionResolver.cs:33`).

**Swallowed or surprising errors**
- GraphQL schema build failure at startup is caught and only printed (`API/Program.cs:294-306`).
- `Guid.Parse` on `department_access` claim values throws on a malformed claim → 500 (`PayrollExportController.cs:113,395`).
- `GetCurrentUser()` in the context swallows all exceptions and stamps "system" (`INF/Persistence/AppDbContext.cs:416-426`).
- Dev-only `db` info lookup swallows exceptions (`ExceptionHandlingMiddleware.cs:146-157`).
- Invalid `ta_settings` values are ignored with a warning, not rejected (`TaSettingsReader.cs:59-63,74-77`).
- Auto-generate treats any unknown `CycleType` as biweekly and has no upper bound on `Count` (`PayPeriodsController.cs:117,123,143`); semimonthly with a start day other than 1 or 16 ends at month end (`PayPeriodsController.cs:292-304`).
- Deleting an unapproved shift leaves no audit event (`DeleteShiftCommandHandler.cs:85-91`); edits to punchless shifts write no audit row (`EditShiftTimesCommandHandler.cs:197-203`).
- Payroll rows for soft-deleted employees appear with display name "Unknown" (`PayrollCalculationService.cs:289-290`, `PayrollDataLoader.cs:218-221`).
- Error bodies are not uniform (`{error,traceId}` vs `{message}` vs plain string) — see 2.6.

## 9. Feature-to-code index

| Feature | Key source paths |
|---|---|
| Startup, DI, middleware order | `API/Program.cs`, `INF/DependencyInjection.cs`, `TA-APP/DependencyInjection.cs`, `TA-INF/DependencyInjection.cs` |
| Web login + JWT | `API/Controllers/AuthController.cs`, `INF/Auth/AuthService.cs`, `APP/Auth/LoginRequest.cs`, `APP/Auth/LoginResponse.cs` |
| Client lookup / branding / feature flags | `API/Controllers/TenantController.cs`, `REG/ClientDirectory.cs`, `REG/FeatureCodes.cs`, `API/Infrastructure/RequireClientFeatureAttribute.cs` |
| Tenant DB routing | `INF/Persistence/TenantConnectionResolver.cs`, `REG/DbCredentials.cs`, `API/Health/RegistryHealthCheck.cs`, `docs/multi-tenant-local-dev.md` |
| Permissions | `DOM/Authorization/Permissions.cs`, `INF/Auth/PermissionPolicyProvider.cs`, `INF/Auth/PermissionAuthorizationHandler.cs`, `TA-INF/Services/TaAuthorizationService.cs` |
| Row scoping | `INF/Persistence/AppDbContext.cs` (`ApplyScopedQueryFilters`), `INF/Services/CurrentUserService.cs`, `INF/Services/EntityScopeService.cs` |
| Error mapping | `API/Middleware/ExceptionHandlingMiddleware.cs`, `DOM/Exceptions/*.cs` |
| GraphQL reads | `API/GraphQL/Query.cs`, `API/GraphQL/Types/*.cs` |
| Users / roles admin | `API/Controllers/UsersController.cs`, `API/Controllers/RolesController.cs`, `REG/RegistryUserStore.cs` |
| Customers + time zones | `API/Controllers/CustomersController.cs`, `INF/Customers/**`, `API/Infrastructure/TimeZoneCatalog.cs`, `API/Controllers/SessionController.cs` |
| Employees (CRUD, import, custom fields, assignments) | `API-TA/EmployeesController.cs`, `API-TA/EmployeeFieldsController.cs`, `API-TA/EmployeeDepartmentController.cs`, `API-TA/EmployeePositionController.cs`, `TA-APP/Employees/**` |
| Supervisor clock-in/out, shift edit, delete | `API-TA/ShiftsController.cs`, `TA-APP/Shifts/Commands/**` |
| Driver Time Sheet writes (manual shift, add punch, delete punches, vehicle, job code) | `API-TA/TimesheetController.cs`, `TA-APP/Shifts/PunchPayable.cs`, `TA-APP/Shifts/JobCodeEligibility.cs` |
| Payable engine + rounding | `TA-INF/Services/PayableTimeService.cs`, `TA-INF/Services/RoundingService.cs`, `TA-INF/Services/TaSettingsReader.cs`, `TA-APP/Interfaces/ITaSettingsReader.cs` |
| Rounding rules admin | `API-TA/RoundingRulesController.cs`, `TA-APP/RoundingRules/Commands/**` |
| Payable recalculation | `TA-APP/RoundingRules/Commands/RecalculatePayable/*` |
| Mobile PIN auth | `API-TA/TimescanAuthController.cs`, `API-TA/EmployeePinController.cs`, `TA-APP/Timescan/Commands/AuthenticatePin/*`, `TA-APP/Timescan/Commands/SetEmployeePin/*`, `TA-INF/Services/PinHasher.cs`, `TA-INF/Services/TimescanSessionTokenService.cs` |
| Mobile clock-in / change job / clock-out | `API-TA/TimescanClockController.cs`, `TA-APP/Timescan/Commands/{ClockIn,ChangeJob,ClockOut}/*`, `TA-APP/Timescan/Services/TimescanShiftWriter.cs` |
| Geofence | `TA-INF/Services/GeofenceService.cs`, `API-TA/LocationsController.cs`, `TA-APP/Locations/**` |
| Customer time-zone conversion | `TA-INF/Services/CustomerTimeZoneService.cs` |
| Approvals | `API-TA/ApprovalsController.cs`, `API-TA/ApprovalStepsController.cs`, `TA-APP/Approvals/Commands/ApproveShift/*`, `API-TA/TimesheetController.cs` (bulk-approve) |
| Pay periods + freeze | `API-TA/PayPeriodsController.cs`, `TA-APP/PayPeriodLock.cs`, `TA-APP/PayPeriods/**` |
| Absences / absence types | `API-TA/AbsencesController.cs`, `API-TA/AbsenceTypesController.cs`, `TA-APP/Absences/**` |
| Trip credits | `API-TA/TripCreditsController.cs`, `TA-APP/TripCredits/**` |
| Holidays / schedules / shift templates | `API-TA/HolidaysController.cs`, `API-TA/SchedulesController.cs`, `API-TA/ShiftTemplatesController.cs` |
| Payroll export (wizard, history, simulate) | `API-TA/PayrollExportController.cs`, `API-TA/PayrollExportHistoryController.cs`, `API-TA/PayrollSimulateController.cs`, `API-TA/PayrollExportRosterResolver.cs`, `API-TA/PayrollExportSettingsResolver.cs`, `API-TA/PayrollExportRecordFactory.cs` |
| Payroll engine, loader, formatters | `TA-APP/PayrollExport/PayrollCalculationService.cs`, `PayrollDataLoader.cs`, `PayrollSnapshotSerializer.cs`, `Formatters/{GenericCsvExporter,YanktonSynoviaExporter,DevRawExporter,CsvCell,PayrollFormatterFactory}.cs` |
| Audit log | `API/GraphQL/Query.cs:193-263`, `TA-DOM/Entities/AuditEvent.cs`, `TA-DOM/AuditEventTypes.cs`, `TA-APP/Shifts/TimeEditAuditPayload.cs` |
| T&A settings | `API-TA/TaSettingsController.cs`, `TA-DOM/Entities/TaSettings.cs` |
| Analytics / GPS+ / maps (controllers only) | `API/Modules/Analytics/*.cs`, `API/Modules/GpsPlus/*.cs`, `API/Modules/Map/MapController.cs`, `API/Modules/Planning/PlanningMapController.cs`, `INF/Services/**` (rules: `INF/Services/CLAUDE.md`) |
| Existing QA docs | `docs/qa/TimeAndAttendance-QA-Test-Plan.md`, `docs/qa/TimeAndAttendance-RoundingRules-TestGuide.md`, `docs/qa/TimeAndAttendance-WhatsNew.md`, `docs/specs/TimeAndAttendance-Permissions.md`, `docs/specs/PayrollExport-BusinessLogic.md` |

## Not determined

- Bodies of `UsersController`, `RolesController`, `EmployeesController` (CSV import), `HolidaysController`, `SchedulesController`, absence range hour-calculation methods, `PunchPayable`, export formatters and history controller were not read line by line; their rules above come from attributes, validators, docs or callers.
- `docs/qa/TimeAndAttendance-QA-Test-Plan.md` was only scanned by headings (defect list and test-case IDs not extracted).
- DB-level constraints (unique indexes, check constraints) were not read from the migration SQL; concurrency notes that depend on them are marked UNVERIFIED.
- Exact `ta_settings` key strings for PIN lockout, and which code path consumes the `GPS` feature flag.
- Whether a token refresh/logout endpoint exists outside the folders in scope.
