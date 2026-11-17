# Repo map: Apps (Turns, Chipmunk, Delays, Subs)

> Read from code 2026-11-17. Clone: `C:\src\Apps` (Azure DevOps `Managed/_git/Apps`, branch `dev`). Static reading only: nothing was built or run. This replaces the second-hand map of 2026-11-16, which came from the PRD. Paths are relative to the repo root.

## Verdict for QA

- Turns is a .NET MAUI app for **Android and iOS** (not Android only). The Ride Support door alert goes into `StudentsPageViewModel.ScanStudent`.
- The offline queue holds only scans and form results. Ride Support needs a new queue for referrals and drafts. This is the highest risk for F3 and F4b.
- Unit coverage of Turns is thin. Nothing tests `SyncService`, `ScanStudent`, offline sign-in or the SQLite layer. No UI automation exists.
- No build flavour picks the server. A sign-in with a quick code or client code picks it. A test client in the directory is enough to point a test build at QA.

## PRD claims checked

| Claim (PRD) | Result | Evidence |
|---|---|---|
| Turns at `MauiTurns`, Chipmunk at `MauiChipmunk`; Turns Android only; package `com.GeorefSystems_TRPT` | PARTLY | `Apps/MauiTurns/Turns/Turns.csproj:4` targets `net10.0-android;net10.0-ios`. Android id `com.GeorefSystems_TRPT` (`:35`), iOS id `com.busplanner.turns` (`:39`). Chipmunk id `com.busplanner.parent` |
| BPInfo role `TurnsAppRole`, 7 controllers, reads only; `Turns_UseDispatchDatabase` | NOT IN THIS REPO | Server side. The client calls `api/TurnsSettings/Get`, `GetTurnsSettingsV2`, `GetMissedStopSettings`. Turns also writes: `SubmitScan`, `SubmitFormTemplateResult`. `UseDispatchDatabase` is a client flag (`Models/TurnsSettings.cs:63`) |
| `SyncService` queues scans and inspections, retries every 60 s | PARTLY | `Turns/Services/SyncService.cs:20`. Only scans start the retry timer (`:226-228`); a failed form waits for reconnect or restart. Uploads one at a time, 800 ms apart (`:19`) |
| T&A clock posts to `{BPUnifiedUrl}/api/ta/timescan/auth/pin`, `X-Client-Code`, anonymous | TRUE | `Services/TimeAttendanceAuthService.cs:19-34` |
| Offline sign-in accepts credentials that match the saved ones; run history only on device | TRUE | `ViewModels/LoginPageViewModel.cs:255-277`; history in local SQLite (`SQLite/Services/SQLiteConnection.cs:502`) |
| Settings as an order-dependent list of booleans; trailing space in `Turns_EnablePrePostInspections` | PARTLY | True for the old API only (`Models/TurnsSettings.cs:12-35`). The V2 JSON API is used when the server supports it. The trailing space is server side, not checked |
| Crash reports go to App Center | FALSE | App Center is commented out (`Georef.Apps.Shared/Logging/AppCenterReporting.cs:42,55`). Sentry is the crash reporter (`Turns/MauiProgram.cs:36-59`) |

## Layout

| Item | Purpose |
|---|---|
| `Apps/Apps.sln` | One solution for all apps |
| `MauiTurns/Turns` | Turns 2.10.2, driver and crew tablet app |
| `MauiChipmunk/Chipmunk` | Parent app 2.12.1 |
| `MauiDelays/Delays`, `MauiSubs/Subs` | Delays 2.4.8; Subs (`net8.0`) |
| `Georef.Apps.Shared` | Shared project: logging, utilities, translations, security |
| `Georef.Apps.Shared.Services.BPInfo` | REST client `BPInfoServiceClient` and models |
| `Georef.Apps.Shared.SQLite`, `.Mapsui`, `.XamForms` | SQLite helpers, offline map tiles, MAUI controls |
| `AppTests` | MSTest 3.7, `net10.0` |

## Turns architecture

- MAUI XAML pages, CommunityToolkit.Mvvm view models, `BPInfoServiceClient` (REST) and an EF Core SQLite database `turns.db3`, encrypted with SQLCipher. The key is in SecureStorage (`App.xaml.cs:403-436`). If the key is lost, the app deletes the database and queued data is lost (`:414-418`).
- Startup: `MauiProgram.cs`, then `App.xaml.cs` `ChooseLandingPage` (`:223`).
- Settings: `Models/ClientSettings.cs`. Offline it uses the saved copy; a failed fetch keeps the last good copy (`:68-99`).
- Rider tap-on: card and RFID readers act as a keyboard (`Platforms/Android/ScanKeyboardBuffer.cs`). `StudentsPageViewModel.ScanStudent` (`:1178`) splits the input, checks duplicates, searches the run roster (`:1208`), adds the rider to the list (`:1247`), then `ProcessScanWorkItemAsync` (`:1322`) writes a pending scan and sends it.
- **Door alert hook:** after the roster search and before the list add. The suspended flag must come from the downloaded roster, because the server answer is too late and absent offline.

### Files Ride Support will most likely touch

| Feature | Files |
|---|---|
| Stop and rider list | `Pages/StudentsPage.xaml`, `StudentsPageViewModel.cs`, `StudentViewModel.cs`, `Models/StudentWrapper.cs` |
| Route scope for a new referral | `RouteRunPageViewModel.cs`, `SQLite/Models/RunModel.cs`, `StudentAssignedStopModel.cs` |
| Not-riding list | `Pages/NoScanStudentsPage.xaml` (exists), `NoScanStudentsPageViewModel.cs` |
| Instructions beside the rider | `StudentInputPage`, `Models/StudentScanInfoView.cs` |
| Offline queue and drafts | `SyncService.cs`, `SQLiteConnection.cs`, `DatabaseContext.cs` (DbSets `:23-41`), `SQLite/Utils/SchemaUpgradeService` |
| Settings flag | `Georef.Apps.Shared.Services.BPInfo/.../Models/TurnsSettings.cs` |
| Menu tile | `Models/AppFeature.cs`, `FeatureNavigationPageViewModel.cs` |

No messaging component exists. Ride Support needs a new one.

## How a build picks the server

1. `Turns/Models/Constants.cs:10` hard-codes the access-code directory `appapi.busplannerweb.com` (same in all four apps).
2. The user enters a quick code or client code. The directory returns `ClientEndpointUrl`, saved in `XamSettings.ClientEndpoint`. All BPInfo calls use it.
3. The BP Unified URL and client code come from the server settings `BPUnifiedUrl`, `BPUnifiedClientCode` (`ClientSettings.cs:21-22`).
4. Demo quick codes skip the server and use stubs (`QuickCodePageViewModel.cs:104-132`).
5. Debug builds accept any TLS certificate (`App.xaml.cs:48-62`), so a local mock server is possible.

**Test point:** a QA quick code must map to a test client whose BPInfo and BP Unified hosts are dev or staging. Ask the Apps team for one (Q16).

## Hosts found in code

| Class | Hosts |
|---|---|
| Test, beta, dev | `1230turnsbeta1`, `1210turnsbeta1`, `1200stsbhnbeta1` (:9000), `1111stsbhnbeta1` (:9000), `appdemo` (all `.busplannerweb.com`); `fhsd_bpweb_1200.devweb1.georef.local`; local IPs `192.168.16.x` |
| Production directory (blocked) | `appapi.busplannerweb.com` |
| Customer trackers, production (blocked) | `tracker<district>.mybusplanner.ca` and `.com` on port 9000, used by `AppTests/.../ChipmunkAuthenticationTest.cs:30-43` |
| Production services (blocked) | `maptiles.mybusplanner.com` |
| Third party | Sentry, OneSignal, Google Maps, RapidAPI map tiles, Microsoft login |
| Unknown | `bpu-api.busplannerweb.com` appears in `TurnsSettingsTest.cs:153` as a string; it is BP Unified **production** CA (`environments.md`) |

## Tests

- `AppTests/AppTests.csproj`: MSTest. 39 files, about 790 test markers. `Readme.txt` calls most tests "pretty useless" and says some access-code tests are test bugs.
- It compiles shared projects only. It does not reference Turns.
- Pure unit tests: utilities, SQL utilities, `TurnsSettingsTest`, password rules, translations, storage.
- Live-server tests (inference): `RunTest`, `RouteTest`, `SchoolTest`, `WebAccountTests`, `TrackerSettingsTest`, `AccessCodeVerifierTest`, `ChipmunkAuthenticationTest`, map download tests. `ChipmunkAuthenticationTest` calls the customer tracker hosts above.
- CI pipeline `Apps_Test` (project `Managed`) on PR 1774, 2026-11-13: 804 tests, 509 passed, 287 failed, 8 not run. The failures were not triaged. Likely cause: live-server tests (environment class, UNVERIFIED).
- `BPInfoServiceClientDemoFixture.cs:51-76` creates an account on a live server and leaves it for a person to delete.

## Secrets in source (security finding, not for chat)

- Credentials in `AppTests/Constants.cs` and `BPInfoServiceClientDemoFixture.cs`. Some test **names** carry a password, so it shows in the Azure DevOps test results.
- The Android keystore password in clear text in `Turns/Turns.csproj:45-62`, and the keystore `BusPlannerKeystore.keystore` is checked in.
- A Sentry DSN in code.
Raise with the Apps owner: rotate and move to the pipeline secure files. Never copy the values.

## CI and build

- `turns-pipeline.yml` (pipeline `Turns-Android`): trigger `dev`. Publishes `-f net8.0-android`, but the project targets `net10.0-android`. `exit 0` follows the publish (`:86-87`), so a failed build still shows green. Artifact `drop-android` (pipeline artifact). No test step. Variable group `AppsGroup`.
- `android-pipeline.yml`: no trigger, stale.
- Variants: Debug and Release only. Output is APK.
- The last three `Turns-Android` builds (dev, 2026-11) "succeeded" but list no build artifacts through the build API. UNVERIFIED whether an APK is produced; check the pipeline artifacts before asking for one (A2).

## Branches

`dev` (CI trigger), `main`, `master`, `release/turns/2.9.13` to `2.10.2`, `release/chipmunk/*`, `release/delays/*`, feature branches such as `turns/eng-1308-...` (Jira ENG keys). Tags `Turns-2.x.x`. Inference: feature to `dev`, then `release/turns/x.y.z`.

## Risks for Ride Support on Turns

| Risk | Evidence | Plan link |
|---|---|---|
| No generic offline queue for referrals and drafts | `SyncService.cs:123-124` | GAP-07, GAP-08 |
| No ordering rule between scans, forms and new item types | `SyncService.cs:195-210` | GAP-07 |
| Failed forms retry only on reconnect or restart | `SyncService.cs:225-228` | F3 offline |
| A scan with "No matching scan cards found" is marked sent and dropped | `SyncService.cs:205-206` | F4b door alert |
| Scan time is device local `DateTime.Now`, no zone | `StudentsPageViewModel.cs:1636` | Q11 |
| Offline sign-in does not recheck permission or route scope | `LoginPageViewModel.cs:268` | TU-R36 |
| Stale settings after a failed fetch | `ClientSettings.cs:68-74` | C4, GAP-27 |
| A suspended rider on another run has no roster data | `StudentsPageViewModel.cs:1214` | F4b |
| Errors logged and swallowed; server 500s filtered from Sentry | `StudentsPageViewModel.cs:1279`, `MauiProgram.cs:42-45` | C16 |

## Device testing: what exists and what is missing

- Exists: demo quick codes, `SpoofLocationProvider`, `FakeLocationGenerator`, the `ADB_Location_UI` GPS tool, the Debug certificate bypass. A scan is keyboard input, so `adb shell input text` plus Enter should simulate a tap (UNVERIFIED).
- Missing: a mock BPInfo server, UI automation (no Appium project), a settable clock, an Android SDK and emulator on the QA machine.
- Needed: a test client in the directory with a QA quick code, dev or staging hosts behind it, a seeded suspended rider on a known run.
