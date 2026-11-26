---
id: CHP-REG-016
title: Chipmunk - Device / layout
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!121-124]
channels: [device]
roles: [chipmunk-parent]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, device:QA-Tablet-PixelTablet-API36]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Chipmunk (parent app, package `com.busplanner.parent`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build (needs: Chipmunk test APK).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Signed in with the QA parent account (credentials file).
- Run steps 1 to 3 on QA-Phone-Pixel8-API36 and step 4 on QA-Tablet-PixelTablet-API36. Step 2 also needs an Android 15 image.

## Steps
1. Rotate the device on each of these pages: Setup, Login, Create account, Password reset, Set password, Map, ETA, My Students, Alerts, Settings, Help, Feedback, Student info, Radius edit, Add student and Message Transportation.
2. On Android 15 and Android 16, look at the top and bottom of each of these pages: Setup, Login, Create account, Password reset, Set password, Map, ETA, My Students, Alerts, Settings, Help, Feedback, Student info, Radius edit, Add student and Message Transportation.
3. Use the Android back button or the back gesture on each of these pages: Setup, Login, Create account, Password reset, Set password, Map, ETA, My Students, Alerts, Settings, Help, Feedback, Student info, Radius edit, Add student and Message Transportation.
4. Run the app on the tablet emulator and open each of these pages: Setup, Login, Create account, Password reset, Set password, Map, ETA, My Students, Alerts, Settings, Help, Feedback, Student info, Radius edit, Add student and Message Transportation.

## Expected (each line must be checkable)
- E1 (step 1, device): The layout reflows on each page.
- E2 (step 1, device): No text or control is clipped on any page.
- E3 (step 1, device): No text or control overlaps another on any page.
- E4 (step 2, device): No content hides under the status bar (needs: Android 15 image).
- E5 (step 2, device): No content hides under the navigation bar (needs: Android 15 image).
- E6 (step 2, device): No content hides under the status bar or navigation bar on Android 16.
- E7 (step 3, device): Each back action goes back exactly one page.
- E8 (step 3, device): No page is skipped and no page blocks the back action.
- E9 (step 4, device): The layout is usable on the tablet.
- E10 (step 4, device): The layout is not a stretched phone layout.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, rows 121 to 124. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: steps rewritten; compound expected lines split; Android 15 needs recorded (emulators run Android 11 and 16).
- Review fixes 2026-11-26: pages listed; the wrong tablet needs tag removed because two tablets exist; device resources added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
