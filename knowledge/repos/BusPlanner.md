# Repo map: BusPlanner (Old World monorepo)

> Read 2026-11-17 from `C:\src\BusPlanner` (Azure DevOps `Unmanaged/_git/BusPlanner`, branch `main`, shallow clone, latest commit 2026-11-13). Top-level map by sampling (Glob and Grep); nothing was built or run. Some searches were cut short: marked "incomplete". The repo has its own `CLAUDE.md` with build notes; read it before deeper work.

## Verdict for QA

- One repo holds all Old World products: a .NET Framework solution (`Managed/`) and a C++ solution (`Unmanaged/`).
- **CI runs no tests.** Test projects exist, but `azure-pipelines.yml` has no test step. No test covers BPInfo's Turns controllers or the Turns settings order.
- BPInfo's Turns role is **not read-only**: Turns posts scans and can create route-vehicle mappings in the live database.
- The email, SMS and push senders have no visible test-mode guard. A test on a database with real subscribers can notify real parents (inference). Never run these services against a database with real people.

## Layout

| Folder | Products | Stack |
|---|---|---|
| `Managed/` (`Managed.sln`) | BP Web (`Georef.Web.BPWeb`), BPInfo REST (`BPInfo.Rest.Service`), Quick (`Goldilox`, `BPQuickService`), Fleet (`BusPlannerFleet`, `BPFleetService`), Trips (`TripsStandardEdition`, `TripsBidEdition`, `BPTripsService`, `BPTripsSEService`), trackers (`BPTrackerService`, `Georef.Web.TrackerModels`), subscription and email service (`BPSubscriptionService`), GPS readers (Geotab, Samsara, Zonar, Synovia, CTS, GTS), Workflow, `Georef.Web.*` shared libraries | C#, ASP.NET WebForms, MVC and Web API, Windows services. BPInfo targets .NET Framework 4.8 |
| `Unmanaged/` (`Everything.sln`) | BP Pro desktop, GEDI, GBPUI, PathServer, GeoIMS, SpatialServer, BPScript | C++ (VS2022) |
| `Unmanaged/Dependencies/` | vcpkg, ChartDirector | Third party. Exclude from searches |
| `docs/` | `tracker-dispatch-triage.md`, `ridership-reports.md`, `database-quick-reference.md` | Notes |

Dispatch database logic is in BPInfo and the tracker code. Database scripts are inside projects (for example `Managed/Georef.Web.BPWeb/Database/Upgrade/`).

## BPInfo REST and Turns (PRD claims checked)

| PRD claim | Result | Evidence |
|---|---|---|
| Role `TurnsAppRole` covers 7 controllers | TRUE | Role string `"TurnsApp"` (`Managed/Georef.Web.ServiceAdministration/Roles.cs:15`). Controllers: GPS, GPSVehicleID, GPSRouteVehicle (class level); Student, RunV, Run, Route (action level) |
| They only read | **FALSE** | `GPSController.SubmitScanEvent` (POST) writes scans (`GPSController.cs:33-42`). `GPSRouteVehicleController.Submit` (PUT) creates a route-vehicle mapping (`:190-195`) |
| With `Turns_UseDispatchDatabase` on, five controllers read Dispatch | FALSE: four | Route, RunV, Run, Student (`RunController.cs:16,25`). Default off (`SettingDefaults.cs:98`). The flag is a static, set once: a change probably needs an app-pool recycle (inference) |
| `TurnsSettingsController.Get` returns an order-dependent list of booleans | TRUE | `Controllers/TurnsSettingsController.cs:29-47`, 11 booleans; comment at `:32` |
| `Turns_EnablePrePostInspections` has a trailing space | TRUE | `Managed/Georef.Web.BPWeb/Settings/SettingKeys.cs:81` |

- `Get`, `GetMissedStopSettings` and `GetTurnsSettingsV2` allow anonymous calls (`TurnsSettingsController.cs:26,54,68`).
- `GetTurnsSettingsV2` returns 29 named fields, including `BPUnifiedUrl`, `BPUnifiedClientCode`, `TimeAttendanceEnabled` (`Models/TurnsSettingsV2.cs`).
- Quirk: key `Turns_EnableBlackoutWhileMoving` has the value `"TurnsEnableBlackoutWhileMoving"` (`SettingKeys.cs:85`).

## Settings (`georef_Setting`)

- Table: `Managed/Georef.Web.BPWeb/Settings/Setting.cs:20`. Keys in `SettingKeys.cs` (Turns at `:76-92`), defaults in `SettingDefaults.cs`, typed readers in `SettingHelper.cs`.
- No `Conduct_*` key exists yet.
- A new Turns setting (inference): key in `SettingKeys.cs`, default in `SettingDefaults.cs`, property in `TurnsSettingsV2.cs`; for the old list, append at the end only. How defaults reach existing client databases is UNVERIFIED (`Database/Upgrade/DatabaseUpgrade.cs`).

**Test points for Ride Support:** each new `Turns_*` or `Conduct_*` setting is present in V2, absent from the old list or appended at its end, has no trailing space, and has the right default on an upgraded database.

## Tests

| Project (`Managed/`) | Covers |
|---|---|
| `Georef.Web.Test` | Ridership calculations, database tests, caching; Selenium helpers |
| `TrackerService.Test` | ETA, auth, Dispatch import, `DispatchPushNotifierTest` |
| `BPSubscriptionServiceTest` | Transport change detector, OneSignal and push |
| `Goldilox.Tests` | Quick view models |
| `BPWeb.Tests` | Scan card assignment history |
| `BusPlannerFleet.Tests`, `BPFleetService.Test`, `Georef.GPS.Test` | Fleet and GPS |
| `Unmanaged/BuildScripts/GoogleTestRunner.ps1` | Native GoogleTest runner, not in CI |

Frameworks per project are not confirmed. No BPInfo test project exists.

## CI and branches

- `azure-pipelines.yml`: CI on `stage`, `main`, `fleet-stage`, `fleet-main`; PRs to `dev` and `fleet-dev` run a compile-only build; `dev` and `fleet-dev` build nightly. Self-hosted pool `Managed`, MSBuild VS2022. Version from `git describe` tags.
- Output to the `\\drops\builds\<branch>\...` share and by FTP to `/Nightly/<branch>/...`.
- Branches: `dev` → `stage` → `main` (promotion), plus `fleet-*`. PRs target `dev`.
- The pipelines `BusPlanner-Build`, `BusPlanner-Release`, `PR-Review`, `dev-branch-tracker` have no YAML in the repo (probably classic pipelines). QA1 and QA2 deployment is not in this repo.

## Hosts (incomplete)

| Class | Hosts | Where |
|---|---|---|
| Internal SQL servers, purpose unknown | `italy-sql\sql2019`, `geneva\sql2019`, `brussels\sql2022`, `HAMBURG\SQL2019`, `ITALY-GEOIMS\SQLSERVER2014`, `CHICAGO`, `PARIS`, `LAGOS`, `PETRA` | `*.config` files. The repo's `CLAUDE.md` says some configs hold per-developer connection strings. Database names carry client numbers and district codes, so they may be customer copies. UNVERIFIED; do not connect |
| Demo | `appdemo.busplannerweb.com` | `ClientListEditor/ClientListEditorForm.cs:388` |
| Production or customer (blocked) | `*.busplannertools.com`, `*.mybusplanner.ca` and `.com` (incl. `dispatchtracker*`), `locator.busplanner.com`, `ftp.busplanner.com` | `ClientListEditorForm.cs:335`, `docs/tracker-dispatch-triage.md:126`, `Georef.Web.GPS/.../LocatorServiceRef/Reference.cs:18`, `azure-pipelines.yml` |
| Third party | Synovia APIs, AWS SES (`email-smtp.us-east-1.amazonaws.com`) | `Georef.Web.Synovia/app.config`, `CompanyEvents/Web.config` |

No QA1 or QA2 host is in the files read.

## Secrets in source (security finding, not for chat)

`azure-pipelines.yml` holds the FTP user name and password for `ftp.busplanner.com` in clear text, in four upload steps, and accepts any TLS host certificate. Raise with DevOps; never copy the values. `.cs` files and `Unmanaged/` were not scanned.

## What sends messages to real people

| Channel | Code |
|---|---|
| Email, SMS, push, tweet queues | `Managed/Georef.Web.BPWeb/SubscriptionService/EmailQueue.cs`, `SMSQueue.cs`, `PushQueue.cs`, `TweetQueue.cs` |
| Sender | `Managed/BPSubscriptionService/SenderThreads/MailingWorker.cs` (no test-mode guard found) |
| Parent route-change emails | `BPSubscriptionService/QueueThreads/StudentRouteChange*`; settings `StudentRouteChange_*` |
| Staff UI senders | `BPWeb/Notification/Messages.aspx.cs`, `SchoolAlerts.aspx.cs`; Trips `SentEmails.aspx.cs`, `TripReminderWorker.cs` |
| Push | `Managed/Georef.Web.OneSignal/Sender.cs`; `FakePushNotificationSender.cs` exists (wiring not read) |
| General notices, Dispatch push | `GeneralNoticeUtilities.cs`, `GeneralNoticeController.cs`, `DispatchPushNotifier` |

Letters: no letter code found. Ride Support letters are new work in BP Unified (alert engine, Q4).
