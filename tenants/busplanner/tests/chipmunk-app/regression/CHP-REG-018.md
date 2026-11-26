---
id: CHP-REG-018
title: Chipmunk - Oldest supported OS versions
module: chipmunk-app
flow: regression
ticket:
priority: P2
spec: [sheet:Chipmunk!9-9]
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
- The current Chipmunk test build (needs: Chipmunk test APK).
- An iOS 13 device (needs: iOS 13 device) and an Android 5 image (needs: Android 5 image).
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).

## Steps
1. Install the app on the iOS 13 device and start it.
2. Install the app on the Android 5 image and start it.

## Expected (each line must be checkable)
- E1 (step 1, device): The app installs on iOS 13 (needs: iOS 13 device).
- E2 (step 1, device): The app runs on iOS 13 (needs: iOS 13 device).
- E3 (step 2, device): The app installs on Android 5 (needs: Android 5 image).
- E4 (step 2, device): The app runs on Android 5 (needs: Android 5 image).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Chipmunk, row 9. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The case was split out of CHP-REG-001 step 7 on 2026-11-26. It needs an iOS 13 device and an Android 5 image; the current emulators run Android 11 and 16.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
