# Environments

> Status: BusPlanner Unified filled 2026-11-10 from the repo (`knowledge/repos/BusPlannerUnified/tests-ci-infra.md` section 6 has the full table with clusters and sources). Old World QA1/QA2 URLs were NOT FOUND in any source. Dev and staging (CA and US) were approved by the user on 2026-11-10. That approval covers testing within the hard rules below; it does not lift any of them.

## BusPlanner Unified

| Name | API | App | Allowed | Notes |
|---|---|---|---|---|
| local | `http://localhost:5000` (`/swagger`, `/graphql`, `/health`) | `http://localhost:3000` | yes | needs .NET, Node and a SQL Server; none installed on this machine yet |
| dev CA | `bpu-dev-api.busplannerweb.com` | `bpu-dev-app.busplannerweb.com` | yes | auto-deploys from `dev`; BP Info writes are enabled here |
| dev US | `bpu-us-dev-api.busplannerweb.com` | `bpu-us-dev-app.busplannerweb.com` | yes | |
| staging CA | `bpu-staging-api.busplannerweb.com` | `bpu-staging-app.busplannerweb.com` | yes | shares a cluster and network with dev CA |
| staging US | `bpu-us-staging-api.busplannerweb.com` | `bpu-us-staging-app.busplannerweb.com` | yes | |
| production CA | `bpu-api.busplannerweb.com` | `app.busplanner.ca`, `bpu-app.busplannerweb.com` | **no** | blocked by the guard hook |
| production US | `bpu-us-prod-api.busplannerweb.com` | `app.busplanner.com`, `bpu-us-prod-app.busplannerweb.com` | **no** | blocked by the guard hook |

Which environment you are on: `GET https://<app-host>/config.json` returns the API URL, the environment name and the deployed commit. `GET https://<api-host>/health` and `/health/ready` check the API.

## Unified SQL Servers (IBM Cloud, Toronto)

From Dan Sukhram (DevOps Architect), Slack 2026-11-10, and the IBM Cloud console. Reach them over the CA VPN (OpenVPN Connect) on their private IPs, port 1433, SQL authentication, login `sharaiz`. The password lives with the user, never in this hub.

| Server | Private IP | Floating (public) IP | Network | Environment | Agent may connect |
|---|---|---|---|---|---|
| `k8-mssql` | 10.50.0.4 | 163.66.84.14 | `k8-dev-vpc`, RG `Default` | dev | yes, when the user supplies a connection; reachable over VPN (checked 2026-11-10) |
| `k8-staging-mssql` | 10.50.0.5 | 163.66.89.183 | `k8-dev-vpc`, RG `k8-dev` | staging (real customer data) | read-only queries only, when the user asks; reachable over VPN (checked 2026-11-10) |
| `k8-prod-mssql` | 10.51.0.11 | 163.66.89.202 | `k8-prod-vpc`, RG `k8-prod-ca` | **production** | **never**: private and public IPs are in the guard's blocklist |
| unknown | 10.52.200.5 | ? | unknown (not a `k8-` VPC in Toronto) | **unknown, possibly US** | **no** until identified; blocked in the guard to be safe |

Source: IBM Cloud console, VPC virtual server instances, Toronto, filter `k8` (user screenshot 2026-11-12). Use the private IPs over the VPN; the floating IPs are for reference only.

SSMS on this machine (2026-11-12) has saved connections from Dan's earlier setup: `10.50.0.4`, `10.50.0.5` and `10.51.0.11` as login `dan`, and `10.52.200.5` as `sa`. Never use these. The `10.51.0.11` entry is **production**, and `sa` is the server admin. Connect as `sharaiz` only, to dev or staging. TODO: ask Dan what `10.52.200.5` is (US SQL? Old World?).

Rules:
- The agent never types or stores the SQL password. The user runs `harness\set-sql-password.ps1 -Env dev|staging` (with `powershell -ExecutionPolicy Bypass -File ...`, since script execution is disabled on this machine). It asks for the password with hidden input and stores it in the user environment variable `BP_QA_SQL_PASSWORD_DEV` or `_STAGING`. Without `-Env` it sets `BP_QA_SQL_PASSWORD`, which serves as the fallback; staging currently uses it. Dev and staging have different passwords.
- The agent queries through `harness\sql.ps1 -Env dev|staging -Action ping|databases|query`. It reaches only these two IPs, accepts only SELECT/WITH, runs each query in a transaction that is always rolled back, and shows at most 200 rows.
- Login status 2026-11-12:
  - **Staging: connected** through `sql.ps1` after the password change. The server reports itself as `k8-staging-mssql`, SQL Server 16.0.4255.1 (2022), Developer Edition. The `sharaiz` login is **sysadmin** (also dbcreator and securityadmin), so the server enforces nothing. Read-only depends entirely on `sql.ps1` and on the user's own care in SSMS.
  - Staging databases: `BP_Unified_HRCE`, `BP_Unified_NPSSTS`, `BP_Unified_NSTS`, `BP_Unified_OSTA`, `BP_Unified_STSBHN` (one per CA staging client), `Client_Registry`, `BusPlanner_Staging`, `STSBHN_20262027_LIVE_2026_10_22` (by its name, a snapshot of live STSBHN data; treat it as real customer data).
  - The US staging clients (`NCPS`, `YSD`) have **no database on this server**. Their SQL server is not yet identified (possibly `10.52.200.5`, see above).
  - **Dev: connected** 2026-11-12, with a password separate from staging's (`BP_QA_SQL_PASSWORD_DEV`). The server reports itself as `k8-mssql`, SQL Server 16.0.4250.1 (2022), Developer Edition. `sharaiz` is **sysadmin** here too.
  - Dev databases (54): versioned Unified databases `BusPlanner_Unified_7_<ver>[_<CLIENT>]`, the newest being `7_21_*` for about 20 clients, CA and US alike (e.g. HRCE, OSTA, YSD, PGCPS, HCPS, SAPS); feature databases (`_Chatbot_SDCC`, `_ChatbotEval_HRCE`, `_GpsPlus_*`, `_TimeAndAttendance`); `Client_Registry` and `Client_Registry_Local`; per-developer `T&A_<name>`; and BP Pro restores named after customers (`STSBHN_20252026_LIVE*`, `SDCC_*`, `P_US_MD_PGCPS_SUMMER_*`).
  - **Dev also holds real customer data**: the `*_LIVE*` and plan/summer restores are customer copies. Hard rule 5 applies to them as it does on staging.
  - Which database each dev client uses: read it from `Client_Registry`, never guess from the name.
- Integration tests create and drop databases: dev only, with `BP_TEST_DB_SUFFIX` set, and only when the user names the server (hard rule 2).
- Never run writes, DDL or `DROP` on staging.

## Old World (BusPlanner Main, Fleet)

QA1 (built from `dev`) and QA2 (built from `stage`) exist per Confluence (`knowledge/process.md`). Found 2026-11-17 in `Managed/QA_Automation`: QA2 for client 1230 is `1230webqa2.busplannerweb.com` (Fleet). The Apps tests name beta hosts `<client>turnsbeta1.busplannerweb.com` and `<client>stsbhnbeta1.busplannerweb.com:9000` (`repos/Apps.md`). **None of these is approved yet.** TODO: QA1 hosts, the host pattern per client, and the user's approval before any test there.

## Mobile devices: Android emulators and Appium (set up 2026-11-26)

Turns (and the other MAUI apps) are tested on Android emulators on the tester's laptop. iOS needs a Mac and is not set up.

| Item | Where | Version |
|---|---|---|
| JDK | `%LOCALAPPDATA%\Programs\jdk\jdk-17.0.21.1+2` (user env `JAVA_HOME`) | Microsoft OpenJDK 17.0.21 |
| Android SDK | `%LOCALAPPDATA%\Android\Sdk` (user env `ANDROID_HOME`): cmdline-tools, platform-tools, emulator, platforms 36 and 30 | adb 1.0.41 |
| System images | `system-images;android-36;google_apis;x86_64`, `system-images;android-30;google_apis;x86_64` | Android 16 and Android 11 |
| Appium | global npm `appium` with driver `uiautomator2` | 4.0.1, driver 10.4.0 |
| Acceleration | Windows Hypervisor Platform (WHPX), already on | `emulator -accel-check`: usable |

| Emulator (AVD) | Device | Android | Screen | Cold boot |
|---|---|---|---|---|
| `QA-Phone-Pixel8-API36` | Pixel 8 | 16 (API 36) | 1080x2400, 420 dpi | 55 s |
| `QA-Tablet-PixelTablet-API36` | Pixel Tablet | 16 (API 36) | 2560x1600, 320 dpi | 57 s |
| `QA-Tablet-10in-API30` | 10.1 in WXGA tablet, for older fleet tablets | 11 (API 30) | 1280x800, 160 dpi | 40 s |

- Start one: `& "$env:ANDROID_HOME\emulator\emulator.exe" -avd QA-Tablet-PixelTablet-API36 -no-snapshot-save` (add `-no-window` for a headless run). Check boot: `adb shell getprop sys.boot_completed` returns `1`.
- Install an APK: `adb install -r <file>.apk`. Start Appium: `appium` (port 4723).
- `appium driver doctor uiautomator2`: 0 required fixes. Optional and not needed for APKs: bundletool (app bundles), ffmpeg (screen recording), GStreamer (screen streaming).
- `sdkmanager` is now a wrapper around the new `android sdk` command. From PowerShell, quote package names (`'"platforms;android-36"'`): the wrapper splits names at `;`. Pass `--no-metrics` so that the tool sends no usage data.
- Turns supports Android 8 (API 26) and up (`SupportedOSPlatformVersion` 26.0). The API 30 tablet covers older OS versions; add an API 26 image if a client runs Android 8 or 9.
- **Still missing for device cases:** a Turns test APK and a QA quick code or client code (access A2), and an approved Old World server (QA1/QA2, access A4), because Turns talks to BPInfo.

## Hard rules for non-production environments

These come from what the repo shows, and are not optional:

1. **Dev and staging are not isolated from real customer systems.** Dev has BP Info writes enabled, and dev and staging databases name production BP Info URLs. Never exercise a path that writes through BP Info (GPS+ Route Management: substitute vehicle, reassign driver) without a named go-ahead from the user for that specific test.
2. **The integration tests create and drop databases.** Never point `BP_TEST_SQL_SERVER` / `BP_TEST_SQL_CONNECTION` at a shared server without `BP_TEST_DB_SUFFIX`, and never choose the server yourself: the user supplies it.
3. **CA staging shares infrastructure with CA dev.** No load or destructive testing on dev without agreement.
4. **The chatbot eval suite calls a live, billable model.** Run it only when asked.
5. **Staging holds real customer data** (Confluence, see `confluence.md`). Read it only as the task needs; never copy student, parent, driver or employee details into reports, tickets or chat; never send anything that could notify a real person (held Dispatch notices, parent emails).

## Credentials

Never written here. Sources:

- Environment variables for backend tests (names only): `BP_TEST_SQL_SERVER`, `BP_TEST_SQL_CONNECTION`, `BP_TEST_DB_SUFFIX`, `BP_QA_DB_REUSE`. Full list in the tests map section 2.
- All secrets live in the local file `Infra Creds.txt` (git-ignored, and the agent's Read tool is denied on it). Never open, print or copy it. Use the helpers, which load it internally and print no secret:
  - Azure DevOps (GET only): `harness/ado.ps1 <api path>`. `AZURE_DEVOPS_PAT` overrides the file.
  - Unified staging (sign in, then one read-only call): `harness/unified.ps1 -Env us-staging|ca-staging [-Client CODE] -Action envs|login|get|graphql`.
  - Unified writes (added 2026-11-25): `harness/api-write.ps1 -Env <env> -Method POST|PUT|PATCH|DELETE -Path <api path> -Body <json> [-Case <id>]`, then `-Action ledger` or `-Action cleanup`. Guards: dev and staging hosts only; refuses `api/gpsplus/route-management` (hard rule 1), `api/auth` and password paths, and chatbot message and eval runs unless `-Billable` (hard rule 4); a POST body must contain `QA-AUTO-`; PUT, PATCH and DELETE only on records it created (`-NoMarker` and `-ExistingRecord` relax this on dev only). Ledger: `<run root>\writes\ledger.jsonl`. Tested 2026-11-25 on US staging (NCPS): absence type created (201, the API returns a bare GUID), updated (204) and deleted (204). T&A deletes look like soft deletes (`IsDeleted`), so the row stays in the database marked deleted.
- Staging QA account, verified by sign-in on 2026-11-10:
  - **US staging** clients: `NCPS`, `YSD`. 67 permissions: T&A full read/write/delete, user and role admin, chatbot, analytics. No GPS+ permissions.
  - **CA staging** clients: `HRCE`, `NPSSTS`, `NSTS`, `OSTA`, `STSBHN`. 73 permissions: the same plus GPS+ (`live`, `events`, `compare`, `devicemapping`, and `gpsplus:routemanagement:write`).
  - All six scope claims are unrestricted on both. This is an admin-level account, so it cannot test permission denial or entity scoping by itself; a restricted account is needed for that.
  - The account can write and delete. The helpers only read. Any write on staging (through the UI or API) follows rule 7 in `CLAUDE.md` (`QA-AUTO-` data, cleaned up), and `gpsplus:routemanagement:write` falls under hard rule 1 above.
  - Tokens last 60 minutes and there is no refresh endpoint.
- Dev accounts: none provided yet. Do not use the passwords written in the repo docs; they are flagged for rotation.
- Deployed secrets live in IBM Secrets Manager; the agent has no access and needs none.

## Test data

- Purpose-built test databases exist on the dev SQL server (GPS+ fixtures, per-developer T&A databases, BP Pro source restores). See the tests map section 6.
- Prefix for data the agent creates: `QA-AUTO-`.
- How to seed and reset on dev/staging: TODO.

## Browser (Playwright MCP)

The browser itself is core (see the hub `README.md`: Playwright MCP, pinned, Chrome, headed, no disk profile). What is BusPlanner-specific:

- **Blocked origins:** the six production app and API origins in `playwright.json` (this tenant's root). `harness\use-tenant.ps1 busplanner` writes them into the browser config. Blocking was tested 2026-11-12 with a throwaway blocked origin: the navigation failed as intended.
- **Guard:** the core hook blocks any `mcp__playwright__browser_*` call whose input names a host in `blocked-patterns.txt` (tested 2026-11-12: prod CA and US blocked, dev and staging allowed). Neither layer stops a server-side redirect; stop and report if one ever lands on production.
- **Signing in (rule changed 2026-11-19 by the user):** on **dev and staging only**, the agent signs the test account in itself with `harness\signin.ps1 -Env <env> [-Role <role>] [-Client <code>]`. The script reads the account from the local credentials file, calls `POST /api/auth/login`, and saves the session as the web app keeps it (localStorage `bp_*` keys) to `<run folder>\auth\<env>-<role>.json`. The agent never sees or prints the email, password or token, and still never reads `Infra Creds.txt` itself. The script refuses any host without a `-dev-` or `-staging-` label; production stays blocked. The session lasts about 1 hour (`expiresAt` in the output): run it again before each ui run. Each Claude session has its own isolated browser and loads the file with `browser_set_storage_state`, so sessions run in parallel (tested 2026-11-19: two browsers at once, both signed in to US staging). `harness\save-signin.ps1` (a person signs in in a window) remains for accounts not in the credentials file. The old persisted profile (`%LOCALAPPDATA%\qa-agent\browser-profiles\busplanner`) is no longer used and can be deleted.
- **Seen 2026-11-18 (smoke run `tests/runs/2026-11-18-0222-smoke-us-staging`):** the persisted US staging sign-in had expired; the app redirected to `/login`, an email-first form ("Welcome back", "Work email", "Continue"; no password field on the first screen). Sign in again before any ui run. Every staging page logs one console error, "Datadog Browser SDK: Application ID is not configured" (`config.json` has empty `dd.applicationId`): known noise, not a product failure by itself. `config.json` keys are `apiUrl` and `dd` (`dd.env` = environment name, `dd.version` = deployed commit).
- **Smoke check:** US staging app loads with title "Time & Attendance" (2026-11-12).
- **Evidence:** screenshots go to the run folder `C:\Users\skhan\Repos\qa-runs\busplanner\browser\` (outside OneDrive, never committed). Do not capture student, parent, driver or employee details (hard rule 5); pick screens that show only `QA-AUTO-` or synthetic data.
- **Locators:** the app has no `data-testid`; use role and accessible name (`knowledge/repos/BusPlannerUnified/frontend.md` section 10).
- The desktop app's own browser pane also exists for quick looks. Use Playwright for test sessions, since sub-agents can use it and the guard covers it.

## Guard

`blocked-patterns.txt` in this tenant's root holds the production hosts, database, SQL address and CDN id listed in the tests map under "PRODUCTION IDENTIFIERS". Anything named `*-prod*` is caught by the core's generic patterns. Side effect: shell commands that merely mention a production pipeline or file name are also blocked; use the Read tool for those files.
