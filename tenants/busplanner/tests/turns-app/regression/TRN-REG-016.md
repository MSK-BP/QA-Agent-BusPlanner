---
id: TRN-REG-016
title: Turns - Device / layout
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!133-139]
channels: [device]
roles: []
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device:QA-Phone-Pixel8-API36, device:QA-Tablet-PixelTablet-API36, device:QA-Tablet-10in-API30]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).

## Steps
1. Open the app on the tablet emulator QA-Tablet-PixelTablet-API36 and visit each page (Setup, Quick code, Login, Menu, Route Selection, Settings, Turns Navigation, Bus Stop, Route Review).
2. Open the app on the phone emulator QA-Phone-Pixel8-API36 and visit each page (Setup, Quick code, Login, Menu, Route Selection, Settings, Turns Navigation, Bus Stop, Route Review).
3. On an iPhone, rotate the device on each page.
4. On an iPad, rotate the device on each page.
5. On the emulators QA-Phone-Pixel8-API36 and QA-Tablet-10in-API30, rotate the device on each page.
6. On the tablet emulator QA-Tablet-PixelTablet-API36, start a drive, then rotate the device during the drive.
7. Increase the system font size, then open each page.
8. Open each page on a notched device.
9. Open each page on an Android 15 device, then check the top and bottom of the page.
10. Open each page on an Android 16 device, then check the top and bottom of the page.
11. On an iPhone, use Reroute and Route Review.
12. On an iPad, use Reroute and Route Review.

## Expected (each line must be checkable)
- E1 (step 1, device): The layout is usable on each page.
- E2 (step 1, device): The layout is not a stretched phone UI (tablets are the normal Turns deployment).
- E3 (step 2, device): The layout is usable on each page.
- E4 (step 2, device): On each page, every button is reachable; clipping in portrait only does not fail the case.
- E5 (step 3, device): The iPhone stays in portrait (needs: iPhone).
- E6 (step 4, device): The iPad stays in landscape (needs: iPad).
- E7 (step 5, device): The pages reflow.
- E8 (step 5, device): Nothing is clipped on a tablet.
- E9 (step 6, device): The drive screen keeps the orientation it started in.
- E10 (step 7, device): The text scales without clipping.
- E11 (step 7, device): The text scales without overlap.
- E12 (step 7, device): The buttons stay reachable.
- E13 (step 8, device): No content shows under the status bar.
- E14 (step 8, device): No content shows under the notch.
- E15 (step 8, device): No content shows under the Dynamic Island (needs: iPhone with Dynamic Island).
- E16 (step 8, device): No content shows under the home indicator (needs: iPhone).
- E17 (step 9, device): Nothing is hidden under the status bar (needs: Android 15 image).
- E18 (step 9, device): Nothing is hidden under the navigation bar (needs: Android 15 image).
- E19 (step 10, device): Nothing is hidden under the status bar.
- E20 (step 10, device): Nothing is hidden under the navigation bar.
- E21 (step 11, device): The app does not crash (needs: iPhone).
- E22 (step 12, device): The app does not crash (needs: iPad).

## Clean-up
- Reset the system font size.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 133 to 139. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Device / layout: steps split per device and action, E lines split, iOS and Android 15 steps marked, typos fixed.
- Black bars on Android 16 tablets if the device rotates during the drive are accepted.
- Refined 2026-11-26 (review fixes): resources set, pages listed, emulators named, E4 reachability wording, nothing-clipped limited to tablets, black bars moved to Notes, clean-up resets font size.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
