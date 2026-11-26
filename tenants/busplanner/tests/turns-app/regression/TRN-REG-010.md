---
id: TRN-REG-010
title: Turns - Navigation - Turns Navigation
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!81-98]
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

## Steps
1. On the Route Selection page, select a route and a run, then tap Start Driving.
2. On the Turns Navigation page, tap Directions, count the items, rotate the tablet, count again.
3. On the Turns Navigation page, tap Map.
4. On the Turns Navigation page, tap Split.
5. Drive the run.
6. With blackout while moving enabled, drive at a speed of about 5 km/h in portrait.
7. With blackout while moving enabled, rotate the device to landscape and drive at about 5 km/h.
8. With map disabled while moving enabled, drive at a speed of about 5 km/h.
9. Connect a card scanner to the device.
10. Drive through a stop, close enough for the Stop radius, time and speed set in Settings.
11. On the Turns Navigation page, tap a stop in the directions list.
12. On the Turns Navigation page, tap a stop icon on the map.
13. Within 200 m of a stop, on the Turns Navigation page, tap Open Stop (if Ridership is enabled).
14. More than 200 m from all stops, on the Turns Navigation page, tap Open Stop.
15. On the Turns Navigation page, tap Repeat.
16. On the Turns Navigation page, tap Skip Stop.
17. Open a run that has several stops at the same location.
18. Arrive at the location of the several stops.
19. Exit and Start Driving again, then at the location of the several stops, tap Skip Stop once.
20. On the Turns Navigation page, tap reroute and select a stop after the next stop (reroute forward).
21. Reroute back: tap reroute and select a serviced stop.
22. On the Turns Navigation page, tap exit, then tap Cancel.
23. On the Turns Navigation page, tap the toolbar back arrow, then tap Cancel.
24. On the Turns Navigation page, press the Android back button, then tap Cancel.

## Expected (each line must be checkable)
- E1 (step 1, device): The Turns Navigation page loads the right information for the selected run.
- E2 (step 1, device): The directions list shows the directions for the run.
- E3 (step 1, device): The directions list shows the stops for the run.
- E4 (step 1, device): The page shows a Directions button.
- E5 (step 1, device): The page shows a Map button.
- E6 (step 1, device): The page shows a Split button.
- E7 (step 1, device): The page shows a Repeat button.
- E8 (step 1, device): The page shows a Skip stop button.
- E9 (step 1, device): The page shows a reroute button.
- E10 (step 1, device): The page shows an Open stop button (if Ridership is enabled).
- E11 (step 2, device): The view changes to directions only.
- E12 (step 2, device): Landscape on the tablet shows more directions than portrait (ASSUMPTION).
- E13 (step 2, device): The directions list shows no more than 12 directions.
- E14 (step 3, device): The view changes to map only.
- E15 (step 3, device): The map zooms to a set altitude automatically.
- E16 (step 3, device): The route on the map connects all stops.
- E17 (step 3, device): The next stop shows as a red icon.
- E18 (step 4, device): The view changes to map and directions.
- E19 (step 4, device): The directions list shows no more than 8 directions.
- E20 (step 4, device): The route on the map connects all stops.
- E21 (step 4, device): The next stop shows as a red icon.
- E22 (step 5, device): The location on the map moves with the actual location of the device (needs: emulator route playback or GPS spoofer).
- E23 (step 5, device): The route on the map follows all stops in the right direction (needs: emulator route playback or GPS spoofer).
- E24 (step 6, device): A dark overlay appears (needs: emulator route playback or GPS spoofer).
- E25 (step 6, device): The input is locked (needs: emulator route playback or GPS spoofer).
- E26 (step 7, device): The same dark overlay as in portrait appears (needs: emulator route playback or GPS spoofer). Known issue ENG-2091: no overlay shows in landscape.
- E27 (step 8, device): Directions is the only view selected (needs: emulator route playback or GPS spoofer).
- E28 (step 9, device): The current UI does not change (needs: physical card reader).
- E29 (step 10, device): The current stop is marked as serviced (needs: emulator route playback or GPS spoofer).
- E30 (step 10, device): The serviced stop shows a grey icon (needs: emulator route playback or GPS spoofer).
- E31 (step 11, device): The Bus Stop page opens.
- E32 (step 11, device): The Bus Stop page shows the list of students that belong to the stop.
- E33 (step 12, device): The Bus Stop page opens.
- E34 (step 12, device): The Bus Stop page shows the list of students that belong to the stop.
- E35 (step 13, device): The Bus Stop page opens.
- E36 (step 13, device): The Bus Stop page loads the closest stop within a radius of 200 m (needs: emulator route playback or GPS spoofer).
- E37 (step 14, device): The Bus Stop page loads an unknown stop if no stop is found within 200 m (needs: emulator route playback or GPS spoofer).
- E38 (step 15, device): The app repeats the Text-To-Speech command for the next direction (needs: a person to listen).
- E39 (step 16, device): The next stop is marked as serviced.
- E40 (step 16, device): The skipped stop shows a grey icon.
- E41 (step 16, device): The app shows an indication of the action that ran.
- E42 (step 16, device): The route trace changes to show the skipped stop.
- E43 (step 17, device): The page shows the stops at the same location as one stop.
- E44 (step 17, device): The stop lists all of its students.
- E45 (step 18, device): Arriving clears all of the stops at that location (needs: emulator route playback or GPS spoofer).
- E46 (step 18, device): The stop count goes up by one (needs: emulator route playback or GPS spoofer).
- E47 (step 19, device): One Skip Stop clears all of the stops at that location.
- E48 (step 19, device): The stop count goes up by one.
- E49 (step 20, device): The skipped stops show grey (ASSUMPTION).
- E50 (step 20, device): The app shows an indication of the action that ran.
- E51 (step 20, device): The route trace changes to show the skipped stops.
- E52 (step 21, device): Those stops show red or green (ASSUMPTION).
- E53 (step 21, device): The route trace changes to show the enabled stops.
- E54 (step 22, device): The app shows a confirmation to exit navigation.
- E55 (step 23, device): The app shows the same exit confirmation (known issue ENG-2694: the iOS back arrow skips it).
- E56 (step 24, device): The app shows the same exit confirmation.

## Clean-up
- The run history created by this case is local to the device. Reset the app data (`adb shell pm clear <package>`).

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 81 to 98. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: Turns Navigation: steps split to one action (driving, landscape, arrival, skip, back), E lines split, GPS and card reader steps marked, typos fixed.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001); GPS marker now says emulator route playback or GPS spoofer.
- Refined 2026-11-26 (second review): step 2 counts directions in portrait and landscape, E12 and E20 deleted, tablet landscape E reworded (ASSUMPTION), Open Stop split by distance (within 200 m, more than 200 m) with emulator playback marker, Skip Stop step restarts navigation, reroute split forward and back (ASSUMPTION), exit steps tap Cancel, Repeat needs a person to listen, cleanup.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
