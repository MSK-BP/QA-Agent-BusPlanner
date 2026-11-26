---
id: DLY-REG-008
title: Delays - About
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!62-66]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- Setup is completed with the subscription from qa1-delays-quick-code and qa1-delays-schools-routes; the Notifications screen is open.

## Steps
1. On the Notifications screen, open About.
2. Read versionName with `adb shell dumpsys package <package>` and compare it with the version on About.
3. Tap Re-Select Transportation Authority.
4. Open About again from the Notifications screen.
5. Tap More.
6. Navigate back from About.

## Expected (each line must be checkable)
- E1 (step 1, device): The About screen shows the logo.
- E2 (step 1, device): The About screen shows the version number.
- E3 (step 2, device): The version number matches the version of the build under test.
- E4 (step 3, device): Setup opens.
- E5 (step 3, device): The current authority is preselected.
- E6 (step 5, device): The additional info or links open.
- E7 (step 5, device): The app shows no error.
- E8 (step 6, device): The Notifications screen is shown.
- E9 (step 6, device): The Notifications state is the same as before About.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 62 to 66. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split compound Expected lines, added a step to return to About after Re-Select, added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, version read with adb, start state, resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
