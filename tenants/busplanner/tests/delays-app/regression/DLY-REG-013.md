---
id: DLY-REG-013
title: Delays - Oldest supported OS versions
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!8]
channels: [device]
roles: []
env: qa1
data: [qa1-delays-quick-code, qa1-delays-schools-routes]
tags: [regression, from-sheet]
depends-on: []
resources: [device:ios13-device, device:android5-image, data:qa1-delays-settings]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Delays (delay notification app) is installed on an iOS 13 device and on an Android 5 device or image, from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Subscriptions use the QA test client only. No real parent, student or school record is subscribed, so no test data notifies a real person.
- No app data is present (fresh install on each device).

## Steps
1. Install the app on an iOS 13 device and launch it.
2. Install the app on an Android 5 device and launch it.

## Expected (each line must be checkable)
- E1 (step 1, device): The app installs and runs on iOS 13 (needs: an iOS 13 device).
- E2 (step 2, device): The app installs and runs on Android 5 (needs: an Android 5 image).

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, row 8. Moved 2026-11-26 from DLY-REG-001 steps 6 and 7; wording kept.
- Priority set by the conversion (the sheet has none): P2.
- The current emulators run Android 11 and 16, so Android 5 needs an image; no iOS device or simulator is available. Device resource names are an ASSUMPTION.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
