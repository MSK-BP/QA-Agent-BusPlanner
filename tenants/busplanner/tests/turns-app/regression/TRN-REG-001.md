---
id: TRN-REG-001
title: Turns - Initial checks
module: turns-app
flow: regression
ticket:
priority: P1
spec: [sheet:Turns!3-7]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is not installed. The device is an emulator assigned by the run plan (`device` resource). The current test APK and the previous release APK are available. A QA quick code and a Turns user (from environment variables) are available.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).

## Steps
1. Install the Turns app on the device, then start it.
2. On the Setup page, type the driver's name, then tap Next.
3. On the Quick code page, type a quick code, tap Verify, then tap Next.
4. On the Login page, type the user name and password. Check the password with Show off, turn Show on, then tap Login.
5. Uninstall Turns. Install the previous release, complete setup, then install the current build over it and start it.

## Expected (each line must be checkable)
- E1 (step 1, device): The Setup page opens.
- E2 (step 2, device): The Setup page fields accept the typed driver's name.
- E3 (step 2, device): The Quick code page opens.
- E4 (step 3, device): The Quick code field accepts the typed quick code.
- E5 (step 3, device): The app shows the quick code as verified (ASSUMPTION: the exact indicator is unknown).
- E6 (step 3, device): The Login page opens.
- E7 (step 4, device): The user name and password fields accept the typed text.
- E8 (step 4, device): The password is not readable while "show" is off.
- E9 (step 4, device): The password is readable while "show" is on.
- E10 (step 4, device): The Menu page opens if PPI is enabled.
- E11 (step 4, device): The Route Selection page opens if PPI is not enabled.
- E12 (step 5, device): Settings > More shows the DB version of the new build (ASSUMPTION: row 120).
- E13 (step 5, device): The app opens with the setup of the older build kept, no crash (ASSUMPTION).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 3 to 8. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Initial checks: wording, two OS steps split (iOS 13, Android 8), compound E lines split.
- Refined 2026-11-26 (review fixes): the oldest-OS steps (iOS 13, Android 8) moved to TRN-REG-020; spec now rows 3 to 7.
- Refined 2026-11-26 (second review): preconditions (APKs, credentials), update step moved to the end with new E2/E3 (ASSUMPTION), Next, Verify and Show steps, E7 ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
