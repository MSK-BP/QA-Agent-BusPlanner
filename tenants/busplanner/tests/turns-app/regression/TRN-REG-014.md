---
id: TRN-REG-014
title: Turns - Settings
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!111-122]
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
- The route has runs today and on other days.
- The client has map tiles (map tiles exist only for some districts; known issue ENG-2709).

## Steps
1. On the Route Selection page, tap the gear icon to open the Settings page.
2. On the Settings page, select imperial in the Unit picker, then start Turns Navigation.
3. On the Settings page, select metric in the Unit picker, then start Turns Navigation.
4. Turn the Lock map orientation north switch on, then drive in Turns Navigation.
5. Turn the Lock map orientation north switch off, then drive in Turns Navigation.
6. Turn the Only show today's runs switch on, then open the Route Selection page.
7. Turn the Only show today's runs switch off, then open the Route Selection page.
8. Turn the Enable Missed Stop prompt switch on, then drive past a stop without meeting the Stop radius, time and speed set in Settings.
9. Turn the Enable Missed Stop prompt switch off, then drive past a stop without meeting the Stop radius, time and speed set in Settings.
10. Turn the Increase map zoom at low speeds switch on, then decrease the speed while driving.
11. Turn the Increase map zoom at low speeds switch off, then decrease the speed while driving.
12. Turn the Enable Spoken Directions switch on, then drive in Turns Navigation.
13. Turn the Enable Spoken Directions switch off, then drive in Turns Navigation.
14. On the Settings page, tap Download All Route and Student Data.
15. On the Settings page, tap Download All Map Tiles.
16. On the Settings page, tap More.
17. On the Settings page, tap Less.
18. On the Settings page, tap Database Statistics.

## Expected (each line must be checkable)
- E1 (step 1, device): The Settings page shows the status of the bulk route download (if enabled).
- E2 (step 1, device): The Settings page shows the Unit picker.
- E3 (step 1, device): The Settings page shows the Lock map orientation north switch.
- E4 (step 1, device): The Settings page shows the Only show today's runs switch.
- E5 (step 1, device): The Settings page shows the Enable Missed Stop prompt switch.
- E6 (step 1, device): The Settings page shows the Increase map zoom at low speeds switch.
- E7 (step 1, device): The Settings page shows the Enable spoken directions switch.
- E8 (step 1, device): The Settings page shows a Download all route and student data button (if enabled).
- E9 (step 1, device): The Settings page shows a Download all map tiles button.
- E10 (step 1, device): The Settings page shows a More button.
- E11 (step 2, device): Directions show distances in miles and feet (ASSUMPTION).
- E12 (step 3, device): Directions show distances in km and m (ASSUMPTION).
- E13 (step 4, device): The map in Navigation points north while driving (needs: emulator route playback or GPS spoofer).
- E14 (step 5, device): The map in Navigation rotates to follow the device direction (needs: emulator route playback or GPS spoofer).
- E15 (step 6, device): The Route Selection page shows only today's runs for the selected route.
- E16 (step 7, device): The Route Selection page shows all runs for the selected route.
- E17 (step 8, device): The app alerts the driver (needs: emulator route playback or GPS spoofer).
- E18 (step 9, device): The app does not prompt the driver (needs: emulator route playback or GPS spoofer).
- E19 (step 10, device): The map in Turns Navigation zooms in (needs: emulator route playback or GPS spoofer).
- E20 (step 11, device): The map keeps the same zoom (needs: emulator route playback or GPS spoofer). Known issue ENG-2698.
- E21 (step 12, device): The app reads the directions aloud with Text-To-Speech (needs: emulator route playback or GPS spoofer).
- E22 (step 13, device): The app mutes all directions (needs: emulator route playback or GPS spoofer).
- E23 (step 14, device): The app starts to download the route and student data in bulk for offline use.
- E24 (step 14, device): A download prompt appears when the download is done.
- E25 (step 15, device): The app downloads the map tiles for offline mode.
- E26 (step 15, device): A download prompt appears when the download is done.
- E27 (step 16, device): The Settings page shows a Less button.
- E28 (step 16, device): The Settings page shows a Database statistics button.
- E29 (step 16, device): The Settings page shows the app version, DB version, build number, client and rest user.
- E30 (step 16, device): The displayed version matches the installed APK version (`adb shell dumpsys package com.GeorefSystems_TRPT`) and the current database migration version.
- E31 (step 17, device): The More section collapses.
- E32 (step 17, device): The Settings page shows the More button.
- E33 (step 18, device): A popup shows the current database status.
- E34 (step 18, device): The popup shows the number of directions, runs, students, student bus stops, student contacts and map tiles.

## Clean-up
- The case creates no data. Set the Settings switches and the Unit picker back to their start values.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 111 to 127. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Settings: ON and OFF split into separate steps, E lines split, GPS steps marked, Developer Mode steps split, typos fixed.
- Rows 123 to 127 (Developer Mode) moved to TRN-REG-021.
- Refined 2026-11-26 (review fixes): split: Developer Mode (rows 123 to 127) moved to TRN-REG-021; units steps start Turns Navigation; E11/E12 distance wording (ASSUMPTION); missed stop steps reworded; map tiles line moved to a precondition; E31 oracle; preconditions and clean-up added.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
