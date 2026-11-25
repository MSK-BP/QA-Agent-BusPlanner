# BusPlannerUnified — backend tests, CI/CD, infrastructure, environments

Snapshot: commit 0137276 (read-only copy under `repos/BusPlannerUnified`). Mapped with Read/Grep/Glob only — nothing was built or run.
Paths are repo-relative. The git root holds `pipelines/`, `deploy/`, `infra/`, `docs/`, `README.md`; the .NET solution is in the inner `BusPlannerUnified/` folder (abbreviated `BPU/` below).
`UNVERIFIED` = inferred, not proven from a file. Secrets are never reproduced here; only where they live.

---

## 1. Backend test stack

| Item | Value | Source |
|---|---|---|
| Framework | xUnit 2.7.0, `Microsoft.NET.Test.Sdk` 17.9.0, `xunit.runner.visualstudio` 2.5.7, net8.0 | `BPU/BusPlanner.Tests.Unit/BusPlanner.Tests.Unit.csproj:3-15`, `BPU/BusPlanner.Tests.Integration/BusPlanner.Tests.Integration.csproj:3-15` |
| Assertions | FluentAssertions 6.12.0 (both projects) | same csproj files |
| Mocking | Moq 4.20.70 (Unit only). Integration has no mocking library; it uses hand-written fakes | Unit csproj:16 |
| Validators | FluentValidation 12.1.* + `FluentValidation.TestHelper` (`TestValidate`) | Unit csproj:22; `BPU/BusPlanner.Tests.Unit/Validators/CreateEmployeeCommandValidatorTests.cs:3,20` |
| Unit DB | EF Core InMemory 8.0.* (unique DB name per context) | Unit csproj:20; `BPU/BusPlanner.Tests.Unit/Helpers/TestDbContextFactory.cs:21-29` |
| Integration host | `Microsoft.AspNetCore.Mvc.Testing` 8.0.* (`WebApplicationFactory<Program>`) + real SQL Server via `Microsoft.EntityFrameworkCore.SqlServer` | Integration csproj:19-20 |
| Conditional skip | `Xunit.SkippableFact` 1.4.13 (`[SkippableFact]`, `[SkippableTheory]`, `Skip.If`) | both csproj files |
| Coverage | `coverlet.collector` 8.0.1 referenced in both projects. No pipeline collects coverage | both csproj:9 |
| Testcontainers / Docker | **Not used.** No Testcontainers package; integration tests need an existing SQL Server | csproj files |
| Parallelism | `parallelizeTestCollections: false` in BOTH projects (collections run serially) | `BPU/BusPlanner.Tests.Unit/xunit.runner.json`, `BPU/BusPlanner.Tests.Integration/xunit.runner.json` |
| Third test project | `BPU/BusPlanner.ETL/BpPro.Etl.Tests` (ETL; outside this map, run only by the ETL pipeline) | `pipelines/backend-deploy-etl-dev.yml:66` |

### Unit project layout (`BPU/BusPlanner.Tests.Unit/`)
- Folders by feature: `Auth`, `Chatbot`, `Configuration`, `Customers`, `Employees`, `GpsPlus`, `Locations`, `Middleware`, `Persistence`, `Queries`, `RoundingRules`, `Services`, `StopClassification`, `SubstitutionImport`, `TimeAndAttendance/{Controllers,Csv,Handlers,PayrollExport,Services}`, `Timescan`, `Transportation`, `Validators`, plus `Helpers`.
- No base test class. Shared helpers in `Helpers/`:
  - `TestDbContextFactory.Create()` / `Create(ICurrentUserService)` — isolated InMemory `AppDbContext`; the no-arg form runs as a trusted system caller (scoping bypassed) (`Helpers/TestDbContextFactory.cs`). `InMemoryDbContextFactory` when code needs `IDbContextFactory<AppDbContext>`.
  - `TestDataBuilders.cs` — fluent builders (`EmployeeBuilder`, `ShiftBuilder`, `PayPeriodBuilder`, …, `With*().Build()`).
  - `MockUserService` — configurable `Mock<ICurrentUserService>`.
  - Hand-written fakes: `FakeTaAuthorizationService`, `FakeChatSettingsReader`, `FakeChatFeatureFlagReader`, `FakeGroundednessJudge`, `FakeStopClassificationService`, etc.; `TestPayableTimeService`, `CultureScope`, `SqlExceptionFactory`, seeds (`StudentActualsSeed`, `JobCodeEligibilitySeed`).
- Golden files: `TimeAndAttendance/PayrollExport/Golden/canonical-{yankton,generic}.golden.csv`, byte-compared; regenerate with env `BP_UPDATE_GOLDEN=1` (`PayrollFormatterGoldenTests.cs:15-43`).
- Copied fixtures: `Chatbot/Fixtures/*.json` (template committed, filled `.local.json` gitignored) (Unit csproj:49-52).

### Integration project layout (`BPU/BusPlanner.Tests.Integration/`)
| Folder | What | xUnit collection / fixture |
|---|---|---|
| `Infrastructure/` | `TestSqlServer`, `TestWebApplicationFactory`, `SeededDatabaseFixture`, `SeededWebApplicationFactory`, `GpsPlusFixture`, `BaselineBuilder`, `SqlBatchRunner`, `AuthHelper`, `PayrollSeedIds`, fleet-grant helpers; one test file `TestSqlServerTests.cs` | — |
| `Auth/`, `Controllers/`, `Endpoints/`, `Chatbot/` | HTTP tests through the real pipeline against an empty-schema DB | `[Collection("Integration")]` → shared `TestWebApplicationFactory` (`Infrastructure/TestWebApplicationFactory.cs:250`) |
| `Seeded/` | Tests against fully built + seeded databases (payroll, GPS+) | `"SeededPayroll"` → `SeededDatabaseFixture` (`:114`); `"SeededGpsPlus"` → `GpsPlusFixture` (`GpsPlusFixture.cs:143`) |
| `SubstitutionImport/` | GPS substitution import service against a schema-only DB | `"SubstitutionDb"` → `SubstitutionDbFixture` (`SubstitutionDbFixture.cs:53-56`); `"TodaySnapshotDb"` (`TodaySnapshotTests.cs:15`) |
| `Eval/` | Chatbot regression evals with a real model against a read-only pilot snapshot | `"ChatbotEval"` → `ChatEvalFixture` (`Eval/ChatbotEvalSuiteTests.cs:25-26,68`) |

### How integration tests get a database
- **One class decides the server:** `Infrastructure/TestSqlServer.cs`. No default host; it throws "No test SQL Server configured" unless `BP_TEST_SQL_CONNECTION` (full connection string, wins) or `BP_TEST_SQL_SERVER` (instance, trusted connection) is set (`TestSqlServer.cs:26-28,142-170`). Any `Database=` in the value is ignored; each fixture sets its own.
- **Every fixture CREATES and DROPS databases** on that server (`SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE`) (`BPU/BusPlanner.Tests.Integration/CLAUDE.md`). Fixed database names, optionally suffixed by `BP_TEST_DB_SUFFIX`:
  | Fixture | Database (base name) | Built from |
  |---|---|---|
  | `TestWebApplicationFactory` | `BusPlanner_Test` | empty DB + `AppDbContext.Database.EnsureCreated()` (EF model, **not** the migration scripts) + in-test seed of Admin role and the devteam admin user (`TestWebApplicationFactory.cs:25,86-157`) |
  | `SeededDatabaseFixture` | `BusPlanner_Unified_PayrollComplex`, `BusPlanner_Unified_PayrollSimple` | baseline v7.21 DDL → every migration in filename order → `scripts/payroll-testdata/SeedPayroll{Complex,Simple}.sql` (`SeededDatabaseFixture.cs:26-29,96-101`) |
  | `GpsPlusFixture` | `BusPlanner_Unified_GpsPlusTests` | baseline + migrations → `scripts/gpsplus-testdata/` `GpsPlusConstants.sql`, `GenerateGpsPlusPlan.sql`, `SeedGpsPlusLiveViewer.sql`, `SeedGpsPlusEventLog.sql` (`GpsPlusFixture.cs:43,69-73`) |
  | `SubstitutionDbFixture` | `BusPlanner_Unified_SubstitutionTest` | baseline + migrations, no seed; each test seeds its own graph (`SubstitutionDbFixture.cs:15-53`) |
- Host wiring in `TestWebApplicationFactory`: environment `Development`; settings injected with `UseSetting` (connection, JWT, timescan rate limit raised to 100000/min); `ITenantConnectionResolver` replaced by `FixedTenantConnectionResolver` (all requests go to the test DB, no `client_code` routing); `IClientDirectory` replaced by `FakeClientDirectory` (`TestWebApplicationFactory.cs:32-84,194-244`).
- `appsettings.Testing.json` deliberately has no `ConnectionStrings` block (values there are never read) (`BPU/BusPlanner.Tests.Integration/CLAUDE.md`).
- No per-test transaction rollback. Tests in the `Integration` collection share one database for the whole run and isolate by creating fresh data with random codes (`Controllers/EmployeesControllerTests.cs:21-31`). `docs/testing/BackendIntegrationTests.md` describes a `TransactionScope` design that was **not** implemented (stale spec).

### "Seeded" and "Eval" folders
- **`Seeded/`** — tests whose expected numbers come from SQL seed scripts, trait `Category=SeededDb`. Payroll expectations are documented in `BPU/scripts/payroll-testdata/ExpectedResults.md` (`Seeded/PayrollSimplePipelineTests.cs:11-16`). GPS+ runs `VerifyGpsPlusLiveViewer.sql` and fails on any FAIL row (`Seeded/GpsPlusVerifyTests.cs`). Payroll seeds, automated tests and the manual QA scripts are coupled and must change together (`BPU/CLAUDE.md`, section on payroll seed data).
- **`Eval/`** — chatbot regression suite, trait `Category=Eval`. One theory case per JSON case in `BPU/Modules/Chatbot/EvalCases/*.json` plus generated decline cases. Makes live, billable Anthropic calls against the read-only pilot snapshot `BusPlanner_Unified_ChatbotEval_HRCE`. Deliberately bypasses `TestSqlServer` and must never write. Opt-in: every case reports **skipped** unless `RUN_CHATBOT_EVALS=1`, an Anthropic key and `BP_EVAL_SQL_CONNECTION` are all set (`Eval/ChatbotEvalSuiteTests.cs:8-56`; `BPU/BusPlanner.Tests.Integration/CLAUDE.md`).
- A second, older family of evals lives in the **Unit** project (`Chatbot/*EvalTests.cs`, `ChatEvalHarness.cs`): also opt-in via `RUN_CHATBOT_EVALS=1` + key; the pilot-dataset ones read `CHATBOT_EVAL_DB` (a shared live tenant, read-only login) (`Chatbot/ChatEvalHarness.cs:47-72`; Integration `CLAUDE.md`).

---

## 2. Exact commands

Run from `repos/BusPlannerUnified/BusPlannerUnified` (the folder with `BusPlannerUnified.slnx`). Source for the base commands: `BPU/CLAUDE.md` ("Build / run / test"). Filters use standard `dotnet test --filter` syntax; the specific filter strings below are the ones the repo itself uses where a source is cited, otherwise standard xUnit filter forms (UNVERIFIED by execution — nothing was run).

```powershell
# Build
dotnet build BusPlannerUnified.slnx

# All unit tests (no DB, no Docker)
dotnet test BusPlanner.Tests.Unit
# What CI actually runs (pipelines/templates/backend-build-test.yml:34-37)
dotnet test BusPlanner.Tests.Unit/BusPlanner.Tests.Unit.csproj --filter "FullyQualifiedName!~GetFlaggedMessagesQueryHandlerTests"

# All integration tests (needs a SQL Server you may create/drop databases on)
$env:BP_TEST_SQL_SERVER = "<instance>"            # trusted connection, OR
$env:BP_TEST_SQL_CONNECTION = "<connection string without Database>"
$env:BP_TEST_DB_SUFFIX = "<yourname>"             # required on a shared server
dotnet test BusPlanner.Tests.Integration

# One class
dotnet test BusPlanner.Tests.Unit --filter "FullyQualifiedName~ApproveShiftCommandHandlerTests"
# One test
dotnet test BusPlanner.Tests.Unit --filter "FullyQualifiedName~ApproveShiftCommandHandlerTests.Handle_ValidApproval_CreatesShiftApproval"
# By name fragment (CI uses this form: pipelines/templates/stop-classification-build.yml:28)
dotnet test BusPlanner.Tests.Unit --filter "FullyQualifiedName~StopClassification"

# By trait (only three traits exist, all in the Integration project)
dotnet test BusPlanner.Tests.Integration --filter "Category=SeededDb"
dotnet test BusPlanner.Tests.Integration --filter "Category=Eval"       # pipelines/backend-eval.yml:70
dotnet test BusPlanner.Tests.Integration --filter "Category!=Eval&Category!=KnownGap"

# Coverage (coverlet.collector is referenced; no repo script or pipeline uses it — UNVERIFIED by execution)
dotnet test BusPlanner.Tests.Unit --collect:"XPlat Code Coverage"

# TRX results as CI writes them
dotnet test BusPlanner.Tests.Unit --logger "trx;LogFileName=unit.trx" --results-directory <dir>
```

### Prerequisites
- .NET 8 SDK (`pipelines/templates/backend-build-test.yml:21-25`). No Docker requirement for any test.
- Unit tests: nothing else.
- Integration tests: a reachable SQL Server and a login allowed to `CREATE DATABASE` / `DROP DATABASE`. The repo does not say which server QA should use — ask; never point it at a shared client server without `BP_TEST_DB_SUFFIX`.

### Environment variables (names only)
| Variable | Used by | Effect |
|---|---|---|
| `BP_TEST_SQL_CONNECTION` / `BP_TEST_SQL_SERVER` | all Integration fixtures except Eval | choose the SQL Server; one is required (`TestSqlServer.cs:26-27`) |
| `BP_TEST_DB_SUFFIX` | same | appended to every fixture DB name; letters, digits, underscore only (`TestSqlServer.cs:28,54-90`) |
| `BP_QA_DB_REUSE` (=1) | `SeededDatabaseFixture`, `GpsPlusFixture` | skip rebuild if seed version matches (GPS+ also requires seed age ≤ 30 min) (`GpsPlusFixture.cs:56,84-104`) |
| `BP_QA_DB_KEEP` (=1) | Seeded, GpsPlus, Substitution fixtures | keep databases after the run |
| `RUN_CHATBOT_EVALS` (=1) | Unit `ChatEvalHarness`, Integration `ChatEvalFixture` | opt in to live-model evals |
| `ANTHROPIC_API_KEY` or `Anthropic__ApiKey` | evals | model key (`ChatEvalHarness.cs:47-48`, `ChatEvalFixture.cs:65`) |
| `BP_EVAL_SQL_CONNECTION`, `BP_EVAL_USER_EMAIL` | Integration Eval | read-only pilot snapshot + the account to ask as (`pipelines/backend-eval.yml:78-79`) |
| `CHATBOT_EVAL_RUNS`, `CHATBOT_EVAL_MIN_PASSES`, `CHATBOT_EVAL_RESULTS` | Integration Eval | repeat count, pass threshold, NDJSON output path (`pipelines/backend-eval.yml:80-82`) |
| `CHATBOT_EVAL_DB` | Unit pilot-dataset evals | read-only live tenant connection (Integration `CLAUDE.md`) |
| `BP_UPDATE_GOLDEN` (=1) | `PayrollFormatterGoldenTests` | rewrites golden CSVs, then fails on purpose |

---

## 3. Backend test conventions

Derived from: `ApproveShiftCommandHandlerTests`, `CreateEmployeeCommandValidatorTests`, `TimesheetControllerBulkApproveTests`, `ChatbotAdminTests`, `StopClassifierTests`, `PayrollFormatterGoldenTests` (Unit); `LoginTests`, `EmployeesControllerTests`, `ChatbotEndpointTests`, `PayrollSimplePipelineTests`, `PayrollExportApiSeededTests`, `GpsPlusVerifyTests`, `ChatbotEvalSuiteTests`, `SubstitutionDbFixture` (Integration); plus helpers `TestDbContextFactory`, `AuthHelper`, `TestWebApplicationFactory`.

- **Class naming:** `<SystemUnderTest>Tests` (`ApproveShiftCommandHandlerTests`, `EmployeesControllerTests`); behaviour slices get a suffix (`TimesheetControllerBulkApproveTests`, `PayableTimeService_FloorCapTests`). Namespace mirrors the folder (`BusPlanner.Tests.Unit.TimeAndAttendance.Handlers.Approvals`). File-scoped namespaces; `Xunit` is a global using.
- **Method naming:** `Method_Condition_ExpectedResult` (`Handle_ValidApproval_CreatesShiftApproval`, `Validate_MissingFirstName_Fails`, `Login_WrongPassword_Returns401`, `Post_CreatesEmployee_Returns201`). Newer GPS+/seeded tests also use sentence style (`Every_verify_check_passes`, `OpenPeriod_ComputesTheDocumentedRollups`).
- **Attributes:** `[Fact]` dominant; `[Theory]` with `[InlineData]`/`[MemberData]`; `[SkippableFact]`/`[SkippableTheory]` only for evals.
- **AAA:** older handler tests use explicit `// Arrange` `// Act` `// Assert` comments; newer tests use blank-line separation. Exceptions asserted with `var act = () => ...; await act.Should().ThrowAsync<T>()` (`ChatbotAdminTests.cs:59-60`).
- **Assertions:** FluentAssertions with a "because" string explaining the business rule (`.Should().Be(1, "only the open-period shift is approvable")`); `BeEquivalentTo(new { ... }, o => o.ExcludingMissingMembers())` for rollups; validators via `ShouldHaveValidationErrorFor(x => x.Prop)`.
- **Unit data setup:** `await using var context = TestDbContextFactory.Create();` + builders; `IUnitOfWork` mocked to delegate to `context.SaveChangesAsync` (`ApproveShiftCommandHandlerTests.cs:31-34`). Controllers are instantiated directly and results unwrapped from `IActionResult` (`TimesheetControllerBulkApproveTests.cs:24-48`). Fixed calendar dates (`new DateOnly(2026, 6, 1)`) rather than "today" in payroll/timesheet tests.
- **Faking auth and tenant (unit):** `Mock<ICurrentUserService>` (email, `UserId`, `CustomerAccess`, `DepartmentAccess`) passed to `TestDbContextFactory.Create(mock.Object)` so scoping and audit stamping are live; `FakeTaAuthorizationService` for T&A permission checks.
- **Faking auth and tenant (integration):** `AuthHelper` mints JWTs signed with the test host's key — `GenerateAdminToken()` (Admin role, `customer_access=*`, a fixed permission list), `GenerateUserToken(perms…)`, `GenerateWildcardUserToken`, `GenerateClientUserToken(clientCode, …)`, `GenerateDepartmentScopedToken`, `GenerateEntityScopedToken`, `GenerateExpiredToken` (`Infrastructure/AuthHelper.cs`). Every token gets `client_code=INTEGRATION` unless it names its own. Tenant routing is pinned by `FixedTenantConnectionResolver`; `FakeClientDirectory` treats a client code containing `UNKNOWN` as not found and `DISABLED` as all features off. Rules: entity-scope tests must use `GenerateEntityScopedToken` (no Admin role); `GenerateAdminToken` has no `analytics:read` (Integration `CLAUDE.md`).
- **Integration shape:** class takes the collection fixture in its constructor (classic or primary constructor), builds `HttpClient` via `factory.CreateClient()`, sets `Authorization: Bearer`. Never use `IClassFixture<TestWebApplicationFactory>` — a second factory would drop the shared DB (`Chatbot/ChatbotEndpointTests.cs:26-27`). Per-test host overrides use `_factory.WithWebHostBuilder(...)`. The Anthropic model is the only thing faked in chatbot endpoint tests (scripted `IAnthropicMessageClient`).
- **Traits:** only `Category` = `SeededDb`, `Eval`, `KnownGap`. No traits in the Unit project; filter by name there.
- **Project rule for AI/automation edits:** any change in `BusPlanner.Tests.Integration` must be reported to the user with the file list; never set a SQL server value yourself; never report the suite as passing if it was not run (Integration `CLAUDE.md`).

### Unit test skeleton (house style)
```csharp
using BusPlanner.Domain.Interfaces;
using BusPlanner.Tests.Unit.Helpers;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Moq;

namespace BusPlanner.Tests.Unit.TimeAndAttendance.Handlers.Shifts;

public class DeleteShiftCommandHandlerTests
{
    [Fact]
    public async Task Handle_ExistingShift_SoftDeletes()
    {
        // Arrange
        await using var context = TestDbContextFactory.Create();
        var unitOfWork = new Mock<IUnitOfWork>();
        unitOfWork.Setup(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()))
            .Returns(async (CancellationToken ct) => await context.SaveChangesAsync(ct));
        var employee = new EmployeeBuilder().Build();
        var shift = new ShiftBuilder().WithEmployee(employee.Id).Build();
        context.Employees.Add(employee);
        context.Shifts.Add(shift);
        await context.SaveChangesAsync();
        var handler = new DeleteShiftCommandHandler(context, unitOfWork.Object); // ctor args: check the handler
        // Act
        await handler.HandleAsync(new DeleteShiftCommand(shift.Id));
        // Assert
        (await context.Shifts.IgnoreQueryFilters().FirstAsync(s => s.Id == shift.Id))
            .IsDeleted.Should().BeTrue("deletes are soft everywhere");
    }
}
```

### Integration test skeleton (house style)
```csharp
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using BusPlanner.Tests.Integration.Infrastructure;
using FluentAssertions;

namespace BusPlanner.Tests.Integration.Controllers;

[Collection("Integration")]
public class HolidaysControllerTests
{
    private readonly HttpClient _client;

    public HolidaysControllerTests(TestWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
        _client.DefaultRequestHeaders.Authorization =
            new AuthenticationHeaderValue("Bearer", AuthHelper.GenerateAdminToken());
    }

    [Fact]
    public async Task GetById_NonexistentId_Returns404()
    {
        var response = await _client.GetAsync($"/api/ta/holidays/{Guid.NewGuid()}"); // route: verify in controller

        response.StatusCode.Should().Be(HttpStatusCode.NotFound);
    }
}
```

---

## 4. Test inventory

Counts are `.cs` files containing tests, from directory listings (approximate; helper/support files excluded where obvious).

### Unit (`BPU/BusPlanner.Tests.Unit/`)
| Folder | Covers | ~Files |
|---|---|---|
| `Chatbot/` | Orchestrator (incl. streaming, persistence, history), every chat tool, tool registry/contract, scope parity, admin handlers, feedback, eval harness + evaluator + gate + coverage floor, prompt composer, thinking sanitizer | 72 (+4 support) |
| `TimeAndAttendance/Controllers/` | T&A controllers called directly (timesheet, payroll export/history/simulate, pay periods, positions, settings, preferences, approval steps) | 15 |
| `TimeAndAttendance/Handlers/` | Absence, approval, payable recalculation, shift, timescan command handlers; geofence | 12 |
| `TimeAndAttendance/PayrollExport/` | Calculation engine, data loader, formatters (golden files, culture), roster/settings resolvers, snapshot serializer | 11 |
| `TimeAndAttendance/Services/` | `PayableTimeService` (rule resolution, floor/cap, schedule matching, overrides), rounding, settings reader, customer time zone | 9 |
| `TimeAndAttendance/` root + `Csv/` | Audit events, pay-period lock, query scope, CSV parser | 6 |
| `GpsPlus/` | BP Info client, scope validators, fleet grants, evidence/coverage/due resolvers, substitution + driver reassignment, route-management controllers | 16 |
| `Transportation/` | GPS live fleet view/model/guards, GraphQL contract, planning entity scope, entity mapping, on-time parity | 14 |
| `Customers/` | Customer handlers, time-zone catalog/normalizer, session time zone | 8 |
| `SubstitutionImport/` | Matching, precedence, reassign diff, run coverage, parsing | 8 |
| `Validators/` | FluentValidation validators (employee, customer, absence, rounding rule) | 7 |
| `Services/` | `CurrentUserService`, `EntityScopeService`, department scoping, GPS/on-time settings readers, SQL scope helper | 6 |
| `Persistence/` | Scoped query filters, model warm-up, DbContext factory lifetime, row-goal interceptor, **migration catalog consistency** | 5 |
| `StopClassification/` | Classifier, batch, comparer, geo math | 4 |
| `Employees/`, `Locations/`, `RoundingRules/`, `Queries/`, `Timescan/` | CRUD handlers, query handlers, PIN auth/hasher | 3 each |
| `Auth/`, `Configuration/` | Permission handler, GPS permission catalog; CORS + response compression config | 2 each |
| `Middleware/` | `ExceptionHandlingMiddleware` | 1 |

### Integration (`BPU/BusPlanner.Tests.Integration/`)
| Folder | Covers | ~Files |
|---|---|---|
| `Seeded/` | GPS+ (compare, event log, fleet view, route management/selection, substitute vehicle, verify script, feed coverage, fleet-grant parity), payroll (simple/complex pipeline, export API, seed contract), on-time performance, planning map, plan geometry, stop classification, stop lookup, chatbot GPS tools | 22 |
| `Controllers/` | Customers, Departments, Employees, JobCodes, PayPeriods, PayrollExport, Shifts, Timescan auth/clock, GpsPlus event log, OnTimePerformance, PathDeviation | 12 |
| `Chatbot/` | Chat endpoint, admin, streaming, scoped thinking, GPS tools, school directory, planned-driver-change SQL | 7 |
| `SubstitutionImport/` | Writer, driver schedule sync, matcher coverage, plan change history, precedence, route reassign, today snapshot | 7 |
| `Auth/` | Login, protected endpoints (401/403) | 2 |
| `Endpoints/` | Health checks | 1 |
| `Eval/` | Chatbot eval suite (opt-in) | 1 (+fixture) |
| `Infrastructure/` | `TestSqlServerTests` (naming/validation rules) | 1 |

### Obvious gaps (source area → no matching test found)
Controller list from `BPU/BusPlannerAPI/**/*Controller.cs`; "no match" = no test file named for it and no reference found by grep in either test project.
- `Controllers/UsersController`, `RolesController`, `SessionController`, `TenantController`, `SchoolsController`, `DistrictsController`, `OperatorsController`, `DepotsController` — no controller tests. Users/Roles integration tests are specified in `docs/testing/BackendIntegrationTests.md` (P1) but not implemented.
- `AuthService` — no unit test class (`Auth/` holds only the permission handler and GPS catalog tests), although `docs/testing/BackendUnitTests.md` specifies `AuthServiceTests`. Login is covered only by `Integration/Auth/LoginTests.cs`.
- **Multi-tenant routing** (`TenantConnectionResolver`, `Client_Registry` lookup, `client_code` claim): replaced by fakes in every integration fixture, so the real resolver/registry path is not exercised by automated tests.
- **GraphQL read layer** (`BusPlannerAPI/GraphQL/Query.cs`): no dedicated integration tests (spec'd as P2 in `BackendIntegrationTests.md`); `/graphql` is touched only incidentally (a few seeded/analytics tests and one unit contract test).
- T&A controllers with no test file: `Absences`, `AbsenceTypes`, `Approvals`, `Holidays`, `Locations`, `RoundingRules` (controller level), `Schedules`, `ShiftTemplates`, `TripCredits`, `EmployeeFields`, `EmployeeLocation`, `EmployeePin`, `PositionJobCode`.
- `Modules/Map/MapController`, `Modules/Chatbot/ChatbotAvailabilityController` — no test file by name.
- `BPGPSReaderService` (GPS ingestion from Geotab/Zonar/Synovia/Samsara/GTS) — not referenced by either test project (see csproj project references); its pipeline builds only (`pipelines/templates/gps-reader-build.yml:26`).
- `BPClientRegistry` — no direct tests (UNVERIFIED beyond file names).
- Migration SQL scripts: only catalog consistency is unit-tested; scripts are executed for real only by the Seeded/Substitution integration fixtures, which no pipeline runs.

---

## 5. Pipelines (Azure DevOps YAML, `pipelines/`)

Agents: Microsoft-hosted `ubuntu-latest` everywhere except `backend-eval.yml` (self-hosted Windows pool `Unmanaged`). Root `azure-pipelines.yml` is a placeholder (`trigger: none`, echoes hello).

| Pipeline file | Trigger | Stages | Tests / gates that run | Deploys what, where |
|---|---|---|---|---|
| `backend-pr.yml` | PR to `dev`/`staging`/`main`, path-filtered to `BusPlannerAPI`, `BusPlanner.Application`, `.Domain`, `.Infrastructure`, `Modules`, `BusPlanner.Tests.Unit`, `deploy/k8s`, the two pipeline files | BuildAndTest | restore + Release build of `BusPlannerAPI.csproj`; `dotnet test BusPlanner.Tests.Unit` excluding `GetFlaggedMessagesQueryHandlerTests`; TRX published, fails on failed tests (`templates/backend-build-test.yml`) | nothing |
| `frontend-pr.yml` | PR to `dev`/`staging`/`main`, paths `BusPlannerUnified/client/**` | BuildAndTest | `npm ci` → `npm run lint` (ESLint incl. jsx-a11y) → `npx jest --ci` → `npm run build` (`templates/frontend-build-test.yml`) | nothing (publishes `frontend-dist` artifact) |
| `pr-review-pipeline.yml` | `trigger: none`, `pr: none`; runs only as an ADO **Build Validation policy** (meant to be registered Optional on dev/staging/main) | one job, one pwsh step, `checkout: none` | **Branch guard** + optional **Claude code review** (details below). Always exits 0 | nothing |
| `backend-eval.yml` | manual only (`trigger: none`, `pr: none`) | ChatbotEval | `dotnet test BusPlanner.Tests.Integration --filter "Category=Eval"`, 3 runs per case, pass on 2; TRX + NDJSON artifact | nothing |
| `backend-deploy-dev.yml` | push to `dev` (path-filtered); region param default `both` | BuildAndTest → ContainerizeAndPush (`dev-latest`, also pushed to `us.icr.io`) → DeployCanada / DeployUS | same unit tests as PR; ADO Environment approval (`dev`, `dev-us`) | API image → `busplanner-dev` namespace on CA dev and US dev clusters via `kubectl apply` + secret upsert from ADO variable groups + rollout restart/status |
| `backend-deploy-staging.yml` | push to `staging`; region default `canada` | BuildAndTest → Containerize (`staging-latest`) → Deploy | unit tests; Environment approval (`staging`, `staging-us`) | API → namespace `busplanner-staging`; secrets owned by External Secrets Operator (`injectSecret: false`) |
| `backend-deploy-prod.yml` | **manual only**; region default `canada` | BuildAndTest → Containerize (`prod-latest`) → Deploy | unit tests; Environment approval (`prod`, `prod-us`) | API → namespace `busplanner-prod` (manifests `deploy/k8s/prod`, `deploy/k8s/prod-us`) |
| `frontend-deploy-dev.yml` | push to `dev` (client paths); default `both` | BuildAndTest → DeployCanada / DeployUS | lint + jest + build; Environment approval | SPA bundle + generated `config.json` → COS bucket, then CloudFront invalidation of `/index.html` and `/config.json` (`templates/frontend-deploy.yml`) |
| `frontend-deploy-staging.yml` | push to `staging`; region default `us` | same | same | SPA → staging buckets (CA / US) |
| `frontend-deploy-prod.yml` | **manual only**; region default `us` | same | same | SPA → prod buckets (CA / US) |
| `backend-deploy-etl-dev.yml` | push to `dev` (ETL code / `deploy/helm/etl`) | BuildAndTest → ContainerizeAndPush → Deploy | `dotnet test BpPro.Etl.Tests`; Environment `dev` approval | `etl-extract` + `etl-load` images; `helm upgrade` of each existing `etl-<client>` release in `busplanner-dev` (clients with values files: `sdcc`, `stsbhn`) |
| `gps-reader-deploy.yml` | push to `dev` (defaults dev/canada); staging/prod by manual run with env + region pickers | build → containerize → deploy | **build only, no tests** (`templates/gps-reader-build.yml`); Environment approval | `busplanner-gps-reader` → `busplanner-<env>` |
| `gps-substitution-import-deploy.yml` | same pattern | build → containerize → deploy | **build only, no tests** (`templates/gps-substitution-import-build.yml`) | substitution import service → `busplanner-<env>` |
| `stop-classification-deploy.yml` | same pattern, plus back-fill parameters (`historicalMode`, `historicalDateFrom`) | build+test → containerize → deploy | unit tests filtered `FullyQualifiedName~StopClassification` only (`templates/stop-classification-build.yml:27-28`) | `busplanner-stop-classification` → `busplanner-<env>` |

`templates/backend-deploy-argocd.yml` (bump a Kustomize tag for ArgoCD) exists but no leaf pipeline references it; the staging and prod leaves state "kubectl, no ArgoCD" (`backend-deploy-staging.yml:1`, `backend-deploy-prod.yml:1`).

### What blocks a PR — precisely
1. **Unit tests + API build** (`backend-pr.yml`) and **lint + jest + vite build** (`frontend-pr.yml`) run on PRs when the path filters match. Whether a red run *blocks merge* is an Azure DevOps branch-policy setting, not in the repo. `README.md` "Known follow-ups" item 8 says the PR build "currently runs but doesn't block" on `dev`. Current policy state: **UNVERIFIED** — check ADO → Repos → Branch policies.
2. **Branch guard** (`pr-review-pipeline.yml:121-178,344-349,433-452`): the only automated reject. The build service casts a **−10 vote** when the source→target flow is wrong: `staging` accepts only `dev`; `main` accepts only `staging`; feature branches must target `dev`. Sources starting `revert/`, `un-revert/`, `cherry-pick/` are exempt. The vote clears automatically when fixed; the header comment says a human reviewer can still approve to override, and setup step 3 asks for "Allow completion even if some reviewers vote to wait or reject" — so it is a strong signal, not a hard block.
3. **Non-blocking warnings** (PRs into `dev` only): PR title without `ENG-<n>`; source branch without `/eng-<n>`; more than `MAX_FILES_WARN` (10) changed files.
4. **Not run on any PR:** integration tests, chatbot evals, coverage, security/dependency scans, any end-to-end/UI test.
5. **Path-filter holes:** a PR touching only `BusPlanner.Tests.Integration`, `BPClientRegistry`, `BPGPSReaderService`, `BPStopClassificationService`, `BPGPSSubstitutionImportService`, `BusPlanner.ETL`, `BusPlanner.MigrationTool` or `scripts/` triggers no backend PR validation (`backend-pr.yml:14-25`).
6. CI builds `BusPlannerAPI.csproj` and the unit test project, not `BusPlannerUnified.slnx`; the Integration project is compiled only by the manual eval pipeline.

### AI code review (`pr-review-pipeline.yml`)
- Dormant unless the secret pipeline variable `ANTHROPIC_API_KEY` is set in ADO (`:23-25,220-222`). Whether it is set: UNVERIFIED.
- Reviews PRs **into `dev` only**, and only when the branch guard did not reject (`:188`).
- Sends up to `REVIEW_FILE_CAP` (12) text files, capped at 8000 lines total: new files in full, modified files as one excerpt around the change with 35 context lines (`:254-290`). Model `REVIEW_MODEL` = `claude-sonnet-4-6`, strictness `balanced`.
- Returns **at most 2 findings**, restricted to changed lines. Findings are comment-only: one summary comment (updated in place via a marker), **never a vote, never a build failure** (`:344-349`, `continueOnError: true`, always `exit 0`).
- The "house rules" prompt is written for the legacy C++/MFC product (SQL concatenation, PII, non-idempotent migrations, DPAPI, MFC leaks) (`:299`). It has no rule about tests. Treat it as a light sanity pass, not QA coverage.

### Chatbot eval pipeline (`backend-eval.yml`)
- Manual only by decision (a run is ~10–25 min and costs several dollars); "a branch policy must not require it" (`:35-38`).
- Variable groups `busplanner-dev-secrets` (Anthropic key) and `chatbot-eval-secrets` (snapshot server, DB, read-only login, user email).
- Target DB: pilot snapshot `BusPlanner_Unified_ChatbotEval_HRCE` on the shared CA dev SQL server. Read-only; never created, migrated or written.
- Results artifact `chatbot-eval-results` (NDJSON) contains transcripts including student names — keep it inside the ADO project (`:92-95`).
- The per-PR floor is a unit test (`ChatEvalSuiteCoverageTests`): one eval case per tool/exclusion/flag must exist. Process rule: every chatbot change lands with its eval cases and a refreshed baseline (`BPU/CLAUDE.md`).

---

## 6. Environments

Cloud is IBM Cloud (IKS Kubernetes, COS, Secrets Manager) with an AWS edge (Route 53 zone `busplannerweb.com`, CloudFront, ACM). CA and US are **separate IBM Cloud accounts**: `Busplanner` (Toronto, `ca-tor`) and `BusPlanner USA Inc.` (`us-east`) (`docs/infra/deploy-runbook.md:22-40`).

| Environment | URLs / hostnames | Cloud / cluster / namespace | Deployed by | Database |
|---|---|---|---|---|
| **Local** | API `http://localhost:5000` (`/swagger`, `/graphql`, `/health`); SPA `http://localhost:3000` (Vite; `client/.claude/launch.json` uses 5173) | developer machine | `dotnet run --project BusPlannerAPI`, `npm run dev` | per-client DB chosen through a registry catalog; see section 8 |
| **Dev — CA** | API `bpu-dev-api.busplannerweb.com` (+ fallback `busplanner-api.k8-dev-ca-tor-97fbb866ee26d22f894e75b086d53df6-0000.ca-tor.containers.appdomain.cloud`); SPA `bpu-dev-app.busplannerweb.com` (+ `busplanner-dev-frontend.s3-web.ca-tor.cloud-object-storage.appdomain.cloud`) | cluster `k8-dev-ca-tor` (RG `Default`), namespace `busplanner-dev`, `ASPNETCORE_ENVIRONMENT=Development` | push to `dev` → `backend-deploy-dev.yml` / `frontend-deploy-dev.yml`, approval on ADO Environment `dev` | SQL VSI `k8-mssql`: private `10.50.0.4`, public floating IP `163.66.84.14`; SQL Server 2022 Developer; catalog `Client_Registry`; client DBs `BusPlanner_Unified_7_21_<CODE>` (`docs/inventory/dev-environment.md:77-98`) |
| **Dev — US** | API `bpu-us-dev-api.busplannerweb.com` (+ `k8-dev-us-east-31416ca0858f2ba11b41737f0aa5ded0-0000.us-east.containers.appdomain.cloud`); SPA `bpu-us-dev-app.busplannerweb.com` | cluster `k8-dev-us-east` (RG `k8-dev-us`), namespace `busplanner-dev` | same pipelines, Environment `dev-us` | not identified in the files read |
| **Staging — CA** | API `bpu-staging-api.busplannerweb.com` (+ `busplanner-staging.k8-dev-ca-tor-…containers.appdomain.cloud`); SPA `bpu-staging-app.busplannerweb.com` (+ `busplanner-staging-frontend.s3-web.ca-tor…`) | **runs in the dev cluster** `k8-dev-ca-tor`, namespace `busplanner-staging` (`deploy/argocd/README.md:21`, `deploy/k8s/staging/40-ingress.yaml:33`) | push to `staging` → `backend-deploy-staging.yml`, Environment `staging`; secrets via ESO from Secrets Manager `secrets-manager-ca-tor-v2` | SQL VSI `k8-staging-mssql` in `k8-dev-vpc`, RG `k8-dev` (`infra/terraform/staging/variables.tf`) |
| **Staging — US** | API `bpu-us-staging-api.busplannerweb.com` (+ `k8-staging-us-east-31416ca…us-east.containers.appdomain.cloud`); SPA `bpu-us-staging-app.busplannerweb.com` | cluster `k8-staging-us-east` (RG `k8-staging-us`), namespace `busplanner-staging` | same, Environment `staging-us` | not identified |
| **Prod — CA** | API `bpu-api.busplannerweb.com`; SPA `app.busplanner.ca` (CORS primary), `bpu-app.busplannerweb.com`, bucket endpoint `busplanner-prod-frontend.s3-web.ca-tor…` | cluster `k8-prod` (RG `k8-prod-ca`), namespace `busplanner-prod`, 3 replicas, `ASPNETCORE_ENVIRONMENT=Production` | manual run of `backend-deploy-prod.yml` / `frontend-deploy-prod.yml`, Environment `prod` | SQL VSI `k8-prod-mssql` (private `10.51.0.11`), DB `BusPlanner_Prod` as of 2026-06-02 (`docs/infra/deploy-progress.md:14-15`); per-client DB credentials from Secrets Manager |
| **Prod — US** | API `bpu-us-prod-api.busplannerweb.com` (+ `k8-prod-us-east-31416ca…us-east.containers.appdomain.cloud`); SPA `app.busplanner.com`, `bpu-us-prod-app.busplannerweb.com` | cluster `k8-prod-us-east` (RG `k8-prod-us`, US account), namespace `busplanner-prod` | same pipelines, Environment `prod-us` | planned VSI name `k8-prod-us-mssql` (`docs/inventory/dev-environment.md:329`); live state UNVERIFIED |

Notes that matter for telling environments apart:
- **Namespace names repeat across regions** (`busplanner-dev`, `busplanner-staging`, `busplanner-prod` exist in both CA and US clusters). The cluster/kubeconfig decides the region.
- **CA staging shares a cluster and a VPC with CA dev.** Load or destructive tests on dev infrastructure can affect staging.
- Docs disagree on deployment mechanism: `deploy/argocd/README.md`, `docs/infra/deploy-progress.md` and `infra/terraform/prod/k8s.tf` describe ArgoCD (auto-sync) for staging/prod; the current pipelines say "kubectl, no ArgoCD". The pipelines are newer. Which is live: UNVERIFIED.
- `README.md` still calls the staging/prod pipelines "skeleton — not yet registered"; the YAML is complete. README is stale there.
- Purpose-built test databases on the dev SQL server (not client tenants): `BusPlanner_Unified_GpsPlus_<dev>`, `BusPlanner_Unified_GpsPlusGen` (client codes `GPS<DEV>`, `GPSGEN`, GPS feature flag off), per-developer `T&A_<name>`, BP Pro source restores `SDCC_*`, `STSBHN_*`, `P_US_MD_PGCPS_*` (`docs/inventory/dev-environment.md:105-116`).
- Quick identity probes: `GET https://<spa-host>/config.json` returns `apiUrl`, Datadog `env` and the deployed commit (`version`); `GET https://<api-host>/health` and `/health/ready` (`docs/infra/deploy-progress.md:44`; `README.md:179-189`).

### PRODUCTION IDENTIFIERS
Treat every item below as production. Names only.

Hostnames
- `bpu-api.busplannerweb.com` (CA prod API)
- `bpu-us-prod-api.busplannerweb.com` (US prod API)
- `k8-prod-us-east-31416ca0858f2ba11b41737f0aa5ded0-0000.us-east.containers.appdomain.cloud` (US prod ingress fallback)
- `app.busplanner.ca` (CA prod SPA)
- `app.busplanner.com` (US prod SPA)
- `bpu-app.busplannerweb.com` (CA prod SPA, CloudFront)
- `bpu-us-prod-app.busplannerweb.com` (US prod SPA)
- `busplanner-prod-frontend.s3-web.ca-tor.cloud-object-storage.appdomain.cloud`
- `bpu-us-prod-app.s3-web.us-east.cloud-object-storage.appdomain.cloud`
- Secrets Manager endpoints `98251614-0fa1-4bd6-9f4d-01c9e9500b05.private.ca-tor.secrets-manager.appdomain.cloud` (CA prod) and `70cb8ebe-b575-4343-a75e-943823de3915.private.us-east.secrets-manager.appdomain.cloud` (US prod)

Clusters, namespaces, deploy targets
- IKS clusters `k8-prod` (id `d8etuhcr0lba3p53kmvg`, ca-tor) and `k8-prod-us-east`
- Kubernetes namespace `busplanner-prod` (in both)
- ADO Environments `prod`, `prod-us`; secure files `busplanner-prod.kubeconfig`, `busplanner-prod-us.kubeconfig`; variable groups `busplanner-prod-infra`, `busplanner-prod-us-infra`
- Manifest folders `deploy/k8s/prod`, `deploy/k8s/prod-us`, `deploy/argocd/overlays/prod`; Terraform `infra/terraform/prod`
- Git branch `main`; image tag `prod-latest`; Datadog env tags `prod`, `prod-us`; frontend env names `prod-ca`, `prod-us`

Resource groups, accounts, network
- Resource groups `k8-prod-ca`, `k8-prod-us` (the latter exists in both IBM accounts)
- IBM accounts `Busplanner` (CA) and `BusPlanner USA Inc.` (US) — both also hold non-prod, so the account name alone does not mean prod
- VPCs `k8-prod-vpc`, `k8-prod-us-vpc`; subnets `10.51.0.0/22`, `10.51.64.0/22`, `10.51.128.0/22`; VPN `k8-prod-client-vpn`; Transit Gateway `tg-busplanner-prod`

Databases
- SQL VSIs `k8-prod-mssql` (`10.51.0.11`), `k8-prod-us-mssql`
- Database `BusPlanner_Prod`; per-client secrets named `client-db-<CODE>`

Storage, secrets, identities
- Secrets Manager instance `secrets-manager-prod`, secret group `busplanner-prod`
- COS instance `busplanner-prod-cos`; buckets `busplanner-prod-frontend`, `busplanner-prod-ca-blob`, `busplanner-prod-us-blob`, `busplanner-ca-prod-logos`, `bpu-us-prod-app` (bucket name inferred from its endpoint host — UNVERIFIED)
- CloudFront distribution `E270CTV1Q2LKLM` (CA prod SPA)
- Key Protect `busplanner-keys-prod-ca-tor`; service IDs `busplanner-icr-push-prod`, `busplanner-prod-terraform`

Production reachable from non-prod — handle with care
- **Client BP Info endpoints:** "the dev and staging databases name production BP Info URLs" (`deploy/k8s/prod/10-configmap.yaml:39-41`), and CA dev runs with `BpInfo__WritesEnabled: "true"` (`deploy/k8s/dev/10-configmap.yaml:44-46`). Route-management actions in dev (substitute vehicle, reassign driver) can write to a client's real BP Info when that client's `app_settings` write flag is on.
- **`CHATBOT_EVAL_DB`** points at "a shared live tenant" (read-only login) (Integration `CLAUDE.md`).
- The dev SQL server holds restored BP Pro customer databases (`SDCC_*`, `STSBHN_*`, `P_US_MD_PGCPS_*`) and the HRCE snapshot — real customer and student data in a non-prod environment.
- Shared edge: one Route 53 zone `busplannerweb.com` and the IAM users `busplanner-certmanager-dns01` / `busplanner-cf-invalidator` serve every environment including prod.

---

## 7. Infrastructure

| Area | Detail | Source |
|---|---|---|
| Cloud | IBM Cloud: IKS (VPC Gen2, 3 workers `bx2.4x16`, multi-zone, Kubernetes 1.35), VPC, Container Registry, COS, Secrets Manager, Key Protect, Transit Gateway, client VPN. AWS for Route 53, CloudFront, ACM | `infra/terraform/prod/*.tf`; `docs/inventory/dev-environment.md`; `README.md:55` |
| Terraform — prod (`infra/terraform/prod`) | `cluster.tf` (IKS `k8-prod`), `main.tf` + `modules/data-region` (VPC, subnets, public gateways, SQL VSI + data volume + security group), `secrets.tf` (Secrets Manager), `key_protect.tf`, `cos.tf` (blob + frontend buckets, HMAC key), `icr.tf` (push service ID), `k8s.tf` (namespaces, External Secrets Operator, Datadog operator + agent, ArgoCD + Application), `cert_manager.tf` (cert-manager + Let's Encrypt ClusterIssuer via Route 53 DNS-01), `redis.tf`, `rabbitmq.tf` (Bitnami Helm charts), `transit_gateway.tf`, `vpn.tf`; `cloudflare.tf.disabled` | grep of `infra/terraform` |
| Terraform — staging | only the staging SQL VSI (`k8-staging-mssql`), its security group and data volume, attached to the dev VPC | `infra/terraform/staging/main.tf`, `variables.tf` |
| Terraform — dev | Redis (ETL load queue) and a COS bucket for ETL extracts in the existing dev cluster/COS instance | `infra/terraform/dev/main.tf` |
| State | S3-compatible backend in COS bucket `terraform-state-store` | `infra/terraform/prod/backend.tf` |
| Ansible | `infra/ansible` role `sql-server`: installs SQL Server 2022 on the VSIs, data volume, backup scripts uploading to COS | `infra/ansible/**` |
| Not in Terraform | Route 53 records, worker security-group egress rules, ArgoCD repo credential, image pull secret, bucket website config workaround | `docs/infra/deploy-runbook.md` corrections 14, 18, 19, 23, 28 |
| Container images | `ca.icr.io/busplanner/<image>` (CA) and `us.icr.io/busplanner-us/<image>` (US); tagged with git SHA plus `<env>-latest`. Images: `busplanner-api`, `busplanner-gps-reader`, `etl-extract`, `etl-load`, stop-classification, substitution import | deploy pipelines |
| Workload hardening | non-root UID 1654, read-only root filesystem, probes `/health` (startup, liveness) and `/health/ready` (readiness), rolling update `maxUnavailable: 0` | `deploy/k8s/prod/20-deployment.yaml` |
| Helm charts | `deploy/helm/etl` (per-client CronJob extract + Deployment load; values for `sdcc`, `stsbhn`), `deploy/helm/stop-classification` (older per-client model, replaced by one multi-tenant deployment) | `deploy/helm/**`; `pipelines/stop-classification-deploy.yml:5-8` |

### Secrets management
- **Dev:** ADO variable groups `busplanner-dev-infra`, `busplanner-dev-secrets` (+ `-us-` variants). The deploy step writes the Kubernetes Secret `busplanner-api-secrets` (`pipelines/templates/backend-deploy.yml:98-118`). Kubeconfigs are ADO secure files.
- **Staging / prod:** External Secrets Operator syncs IBM Secrets Manager → `busplanner-api-secrets` (`05-secretstore.yaml`, `06-externalsecret.yaml` per env). Only the registry push key stays in ADO. Prod Secrets Manager is private-endpoint only.
- **Runtime:** the API reads per-client DB credentials and the email-hash pepper from Secrets Manager; in dev a master DB login (`Db__MasterUser`/`Db__MasterPassword`) is used instead (`deploy/k8s/dev/10-configmap.yaml:32-35`; `deploy/k8s/prod/10-configmap.yaml:27-30`).
- **Local:** `dotnet user-secrets` or environment variables (`ConnectionStrings__ClientRegistry`, `Jwt__Secret`, …). `appsettings.json` ships those empty (`BPU/CLAUDE.md`).
- Secret key names the API expects: `ConnectionStrings__ClientRegistry`, `Jwt__Secret`, `Anthropic__ApiKey`, `Ibm__ApiKey`, `Db__MasterUser`, `Db__MasterPassword` (shape in `deploy/k8s/secret-shape/busplanner-api-secrets.example.yaml`).

### Observability
- **Datadog** (site `datadoghq.com`). Backend: Datadog Operator + Cluster Agent; APM auto-instrumentation injected per namespace; container logs collected cluster-wide (`logCollection.containerCollectAll`); `DD_LOGS_INJECTION` and `DD_RUNTIME_METRICS_ENABLED` on the API; unified service tags `env` / `service=busplanner-api` / `version=<git sha>` (`README.md:191-198`; `deploy/k8s/prod/20-deployment.yaml:9-11,50-53`).
- **Frontend:** Datadog RUM browser SDK, service `busplanner-frontend`, env = pipeline `envName` (`dev-ca`, `dev-us`, `staging-ca`, `staging-us`, `prod-ca`, `prod-us`), configured from `/config.json`; disabled locally (`pipelines/templates/frontend-deploy.yml:61-75`; `README.md:169,200-205`).
- Where to look for a failing request: Datadog APM/logs filtered by `env` + `service` + `version`. Dashboards, monitors and alert routing are not defined in the repo (UNVERIFIED whether they exist). `docs/infra/prod-prerequisites.md:5` notes a Datadog trial had expired at one point.

---

## 8. Local dev setup (brief)

Sources: `BPU/CLAUDE.md`, `README.md` ("Local dev workflow"), `docs/multi-tenant-local-dev.md`, `docs/database/MultiTenant-Local-Login-Setup.md`, `DEV_SETUP_T&A.txt`, `BPU/.vscode/`.

Prerequisites: .NET 8 SDK; Node 22 (CI version) + npm; network access to a SQL Server holding a registry catalog and at least one client DB (VPN for the private dev SQL address); values for the secrets below from the team.

1. Configure the API through user-secrets or env vars (names only): `ConnectionStrings:ClientRegistry`, `Jwt:Secret` (32+ chars), `Db:MasterUser`, `Db:MasterPassword`, `Ibm:ApiKey` (email-first login and logos), optional `Anthropic:ApiKey` (chatbot), optional `Cos:Endpoint`/`Cos:Bucket`, `SecretsManager:ServiceUrl`/`SecretGroup`, `EmailHash:KeyVersion`.
2. `dotnet build BusPlannerUnified.slnx`, then `dotnet run --project BusPlannerAPI` → `http://localhost:5000` (Swagger `/swagger`, GraphQL `/graphql`). VS Code: F5 "Debug BusPlannerAPI" (`BPU/.vscode/launch.json`; build task uses `-p:EnableSourceLink=false`).
3. `cd client; npm install; npm run dev` → `http://localhost:3000`. The SPA reads `client/public/config.json` (API at `http://localhost:5000`).
4. **Multi-tenant login:** there is no default database. Open `http://localhost:3000/login?client=<CODE>` (default example `STSBHN`) and sign in with the seeded dev admin account (`devteam@busplanner.com`; password is in the setup docs). The `?client=` path validates against that client DB's `AspNetUsers` and needs no `BPUsers` routing row. Email-first login needs a `BPUsers` row plus the `GLOBAL_LOGIN` flag.
5. The client DB needs the Identity tables and the admin seed: apply migrations with `BusPlanner.MigrationTool`, including migration 27 (`SeedDevteamAdmin`). Never use `dotnet ef migrations`.
6. Feature flags live in the registry table `BPFeatureFlag`: `GLOBAL_LOGIN` (login form shown; enforced with 403 on the timescan PIN endpoint), `CHATBOT` (chat bubble + `api/chatbot/*`), `GPS`.

Conflicts between the setup docs (ask the team before relying on either):
- `docs/multi-tenant-local-dev.md:22-29` says local dev must use `Client_Registry_Local` and never `Client_Registry`; `docs/database/MultiTenant-Local-Login-Setup.md:56-65` says the opposite (use `Client_Registry` over VPN).
- `DEV_SETUP_T&A.txt` and the `README.md` snippet describe the older single-database setup (`ConnectionStrings:Default`); `BPU/CLAUDE.md` says there is no default DB.

---

## 9. Manual QA documents

### `docs/testing/`
| File | Purpose |
|---|---|
| `BackendUnitTests.md` | Original **specification** for T&A unit tests (120 planned tests, helper design). Partly stale: some planned classes do not exist (e.g. `AuthServiceTests`), folders have moved |
| `BackendIntegrationTests.md` | Original **specification** for integration tests (~75 planned). Stale on infrastructure (it describes a `DatabaseFixture`, `SeedData.sql` and `TransactionScope` rollback that were not built) and on coverage (Users/Roles/GraphQL tests not implemented) |
| `FrontendTests.md` | Frontend test specification (Jest + React Testing Library) and the "Accessibility Checks" section (jsx-a11y gate, jest-axe) |
| `GpsPlus-Performance-Baseline.md` | GPS+ read-path timing baseline (2026-09-28) against client DBs on the dev SQL server, with the measurement method and its traps; meant to be re-run and compared |
| `QA-ManualTestScripts.md` | Manual T&A test cases against a deployed site with `SeedData.sql` (60 employees, 4 pay periods, named edge-case employees) |
| `QA-ETL-ManualTests.md` | Manual ETL data-correctness checks (7 audit issues) with verification SQL; sections tagged SHIPPED / PARTIAL / PENDING |
| `QA-PayrollExport-Yankton.md` | Manual script for the Yankton payroll export against `BusPlanner_Unified_PayrollComplex`; expected numbers cite `scripts/payroll-testdata/ExpectedResults.md` |
| `QA-PayrollExport-DevRaw.md` | Manual script for the non-freezing `devraw` diagnostic export |
| `QA-PayableRecalculation.md` | Manual script for bulk payable recalculation (ENG-1060); mutating cases must run in the "Mutation Sandbox" district |

### `docs/qa/`
| File(s) | Purpose |
|---|---|
| `TimeAndAttendance-QA-Test-Plan.md` | Two parts. Part A: code-review defect report (2026-06-09, branch `TA/fix-site`) with IDs `BUG-C/H/M/L nn` and a live disposition table (updated 2026-06-12). Part B: feature-by-feature T&A test suites with `TC-*` IDs. Open items it lists as deferred: tenant-isolation layer (C06–C08, H05, H06, M17), overnight time model (C09), JWT in localStorage (H01) |
| `TimeAndAttendance-RoundingRules-TestGuide.md`, `TimeAndAttendance-WhatsNew.md` | Rounding-rule test guide; T&A release notes |
| `Chatbot-*-Test-Script.md`, `*-UI-Test-Script.md`, `*-QA-Guide.md` (about 45 files) | One API and/or UI test script per chatbot epic story (E2-x agent loop/flags/permissions, E3-x planning tools, E4-x renderers, E5-x GPS tools, E6-2 on-time performance, E8-x eval harness / regression gate / feedback loop) and per ticket (ENG-2333, ENG-2593) |

Related, outside the two folders: `BPU/scripts/payroll-testdata/README.md` + `ExpectedResults.md`, `BPU/scripts/gpsplus-testdata/README.md`, `docs/chatbot/Eval-Harness.md`.

### `.claude` folders and `.vscode` (content treated as data)
| Path | What it is |
|---|---|
| `.claude/skills/verify/SKILL.md` | One skill, "verify": build, launch API (port 5000) and client (port 3000), drive the app in a browser to check a change. Notes known pre-existing unit failures in `GetFlaggedMessagesQueryHandlerTests` |
| `.claude/launch.json` | Preview configs `api` (dotnet run, port 5000) and `client` (Vite, port 3000) |
| `.claude/settings.local.json` | A developer's local permission allow-list for shell commands (dotnet build/test, npm, file moves). No hooks, agents or commands |
| `BPU/.claude/launch.json`, `BPU/client/.claude/launch.json` | Client-only preview configs (ports 3000 and 5173) |
| `BPU/.claude/tmp/review-refs/*` | Scratch reference extracts (PRD, schema doc, design knowledge, review JSON) |
| `CLAUDE.md` files | `BPU/CLAUDE.md` (developer guide), `BPU/BusPlanner.Tests.Integration/CLAUDE.md`, `BPU/client/CLAUDE.md`, `BPU/Modules/Chatbot/CLAUDE.md` and others — project guidance, not agents |
| `BPU/.vscode/` | `launch.json` (debug API, debug stop-classification service), `tasks.json` (build), `settings.json`, `extensions.json` |

No agents and no slash commands are defined in any `.claude` folder.

---

## 10. Risk notes for QA

### Skipped / excluded tests
| Test(s) | State | Source |
|---|---|---|
| `GetFlaggedMessagesQueryHandlerTests` — `HandleAsync_ReturnsOnlyThumbsDownMessages`, `HandleAsync_IncludesUserQuestion`, `HandleAsync_ReturnsNullCorrectionWhenNone`, `HandleAsync_PaginatesCorrectly` | `[Fact(Skip = ...)]`, reason "Flaky: seeded feedback intermittently invisible to the flagged-messages query". Also excluded by name in CI. Two different explanations exist (flaky everywhere vs Linux-only InMemory quirk) | `BPU/BusPlanner.Tests.Unit/Chatbot/ChatbotAdminTests.cs:356-463`; `pipelines/templates/backend-build-test.yml:4-7,35`; `README.md:232` |
| `PayrollExportApiSeededTests.Generate_EightParallelRequests_ExactlyOneSucceeds` | Trait `KnownGap`; documents a real race (no unique index on pay period + version; parallel exports can double-freeze). Expected to fail intermittently. Nothing in the repo excludes it from a plain `dotnet test` run | `Seeded/PayrollExportApiSeededTests.cs:199-219` |
| All `[SkippableFact]`/`[SkippableTheory]` eval tests: Unit `ChatOrchestratorEvalTests`, `ChatDeclineEvalTests`, `GpsToolsEvalTests`, `PlanMapEvalTests`, `ChatGpsPilotEvalTests`; Integration `ChatbotEvalSuiteTests.Case` | Skipped unless opted in; eval cases with status other than `active` skip with their status | grep of `Skippable`; `Eval/ChatbotEvalSuiteTests.cs:45-50` |

A green PR run therefore reports a block of skipped tests. Skipped is not passed.

### Flaky-looking patterns
- **Shared database, no rollback:** everything in the `Integration` collection shares `BusPlanner_Test` for the whole run. Tests that count or list rows can see other tests' data.
- **Order-dependent rate limiting** already bit once: timescan tests returned 429 in full runs only; fixed by raising the limit in the test host (`TestWebApplicationFactory.cs:45-50`).
- **Wall-clock dependence:** the GPS+ fixture ages in real time; its verify script fails a seed older than 30 minutes, so a long or paused run, or `BP_QA_DB_REUSE=1` on an old database, turns red (`GpsPlusFixture.cs:27-32,84-104`). `DateTime.UtcNow`/`Now` appears in about 50 test files (e.g. `StopClassifierTests.cs:22`, `StopClassificationSnapshotResolutionTests.cs`), plus "recent timestamp" assertions in handler tests.
- **Process-global environment mutation:** `ExceptionHandlingMiddlewareTests` and `TestWebApplicationFactory` set `ASPNETCORE_ENVIRONMENT` for the whole process. Safe only because collections do not run in parallel.
- **Real delays:** `ChatTurnPersistenceTests.cs:336` (`Task.Delay(10)`); `ChatOrchestratorTests.cs:1250` uses an uncancelled 60-second delay as a "rogue tool" (relies on a timeout path). Other `Task.Delay` uses are cancellation-driven.
- **Concurrent runs on one SQL server destroy each other** (teardown kills connections and drops fixed-name databases) unless `BP_TEST_DB_SUFFIX` is set. Best-effort cleanup swallows errors, so databases can leak.
- **Schema drift between suites:** the `Integration` collection builds schema with EF `EnsureCreated`, the seeded fixtures with DDL + migration scripts. A migration bug can be invisible to the first group.
- **Golden files** are byte-exact apart from line endings; any formatter change fails `PayrollFormatterGoldenTests` by design.
- **Model nondeterminism:** eval cases pass on 2 of 3 runs.
- **Serial execution** in both projects: slow, and it hides parallel-safety problems.

### Missing gates
- Integration tests (about 50 test files, including all payroll and GPS+ seeded checks) run in **no pipeline** — only when a developer runs them locally.
- No coverage measurement or threshold; no end-to-end/UI test stage; no post-deploy smoke test (deploys end at `kubectl rollout status`; the `/health` curl checks in `README.md` are manual); no dependency or security scanning stage.
- PR build status may not be a required branch policy (see section 5) — confirm in ADO.
- GPS reader and GPS substitution import pipelines deploy with no tests; stop-classification runs only its own unit subset.
- Deploy pipelines for dev auto-run from a merge; the only human gate is the ADO Environment approval. `docs/infra/deploy-progress.md:109-120` lists configuring those approvals (2 reviewers for prod, branch control to `main`) as an open item — current state UNVERIFIED.
- AI review is capped at 2 findings, dev-target only, and uses legacy-product house rules.
- Branch guard is a vote that reviewers are allowed to override.

### Other findings worth raising
- **Credentials committed to the repo.** `DEV_SETUP_T&A.txt` line 4 contains a full SQL connection string (server, user, password) for the dev SQL server in plain text. `docs/infra/deploy-progress.md:102` contains an AWS access key ID in a rotation command. Seeded test-account passwords are written in several docs and in `Integration/Auth/LoginTests.cs`. Values intentionally not copied here. Recommend rotation and removal.
- The same seeded admin account exists in every client database created by migration 27 (`BPU/CLAUDE.md`). Whether production client databases carry it with the documented password is UNVERIFIED and worth asking.
- Dev can write to real client BP Info systems (see "Production reachable from non-prod").
- Dev and staging SQL servers run SQL Server Developer Edition; `docs/infra/deploy-progress.md:14` records prod CA as Developer Edition too on 2026-06-02, which the inventory doc says is not licensed for production. Current state UNVERIFIED.
- The T&A test plan records tenant isolation as a deferred release blocker (2026-06-12); `BPU/CLAUDE.md` now describes global scoped query filters. Whether every deferred item (C06–C08, H05, H06, M17) is closed is UNVERIFIED — good candidate for targeted regression tests.

### Could not determine from the repo
- Actual ADO branch policies, required reviewers, Environment approvers, and whether `ANTHROPIC_API_KEY` is set for the review pipeline.
- Which SQL Server QA should use for integration tests.
- US dev/staging/prod database servers and names.
- Whether staging/prod are currently reconciled by ArgoCD or by the kubectl pipelines.
- Whether a dedicated QA/test environment exists beyond dev and staging (none is defined in `deploy/` or `pipelines/`).
- Test counts (tests were not executed) and real pass/fail state.

## Learned in run 2026-11-25-2241 (ENG-3306)

- **PRs are squash-merged.** PR 1902 has `mergeStrategy: squash`; `dev` has 0 merge commits in 378. Find a PR's commit with `git log --grep='^Merged PR <n>:'`, never `git log --merges`. Beware: `Select-String '<n>'` also matches unrelated `ENG-<n>` commits.
- **Pipeline `BusPlannerUnified-backend-dev` (definition 246, `pipelines/backend-deploy-dev.yml`)** runs on every push to `dev` (`individualCI`). It calls `templates/backend-build-test.yml`: `dotnet build -c Release`, then `dotnet test` on `BusPlanner.Tests.Unit`. Its test runs hold the unit-test results per commit (for example build 81899, run 22369, for `dff1fbc7`). Read them with `harness/ado.ps1` (GET).
- **A dev build stays `inProgress`** after "Build & test" succeeds, because the two "Deploy to dev (Canada/US)" stages wait at a manual gate. Judge tests by the stage and the test run, not the build status.
- `azure-pipelines.yml` at the root is a starter that only echoes "hello" (trigger none).
- **Running the unit tests locally:** `BusPlanner.Tests.Unit` targets `net8.0` and its test host needs both `Microsoft.NETCore.App 8.x` and `Microsoft.AspNetCore.App 8.x`. This machine has them in a user install at `%LOCALAPPDATA%\dotnet-qa` (SDK 10.0.404 + runtimes 8.0.34 and 10.0.15); put it first on PATH. Run `dotnet build-server shutdown` afterwards, or the build servers lock `dotnet.exe`.
- **Forms engine condition library** (ENG-3306): `BusPlannerUnified/Modules/Forms/BusPlanner.Forms.Conditions`, `netstandard2.1`, no package dependencies, referenced by `BusPlannerAPI` as a `ProjectReference` (no NuGet package published). Tests: `BusPlanner.Tests.Unit/Forms/ConditionSharedCasesTests` (57 rows from `docs/forms-engine/tests/frm-condition-tests-draft-01.json`, read at run time; a copy under the test `bin` folder is read first) and `ConditionTests` (23). Python reference: `docs/forms-engine/tests/frm_condition_reference.py`. On 9 edge probes the two evaluators agree exactly.
