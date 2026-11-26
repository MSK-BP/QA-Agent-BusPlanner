---
id: TRN-REG-020
title: Turns - Oldest supported OS versions
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!8]
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
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- A device with iOS 13 and an Android 8 image are available. The current emulators run Android 11 and 16, so both steps are Blocked until then.

## Steps
1. Install the app on a device with iOS 13, then start it.
2. Install the app on a device with Android 8, then start it.

## Expected (each line must be checkable)
- E1 (step 1, device): The app installs on iOS 13 (needs: iOS 13 device).
- E2 (step 1, device): The app runs on iOS 13 (needs: iOS 13 device).
- E3 (step 2, device): The app installs on Android 8 (needs: Android 8 image).
- E4 (step 2, device): The app runs on Android 8 (needs: Android 8 image).

## Clean-up
- Remove the app from the device.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, row 8. Split out of TRN-REG-001 on 2026-11-26, because these steps cannot pass on the current emulators.
- Priority set by the conversion (the sheet has none): P2.
- Refined 2026-11-26: created from the oldest-OS steps of TRN-REG-001.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
