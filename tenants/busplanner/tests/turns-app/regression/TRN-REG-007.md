---
id: TRN-REG-007
title: Turns - Navigation - Route Selection
module: turns-app
flow: regression
ticket:
priority: P2
spec: [sheet:Turns!60-70]
channels: [device, ui]
roles: [professional]
env: qa1
data: []
tags: [regression, from-sheet]
depends-on: []
resources: [device, data:qa1-turns-route-substitution]
status: reviewed
approved-by:
convert-later: device
---
## Preconditions
- Turns (driver and crew tablet app, package `com.GeorefSystems_TRPT`) is installed on an emulator assigned by the run plan (`device` resource), from the current test build.
- The app is set up against an approved QA1 or QA2 test client with a QA quick code (access A2 and BPInfo are pending until then).
- Location permission is not granted (`pm clear` or revoke).
- The substitution check uses BP Web on QA1, signed in as a professional.

## Steps
1. Open the Route Selection page (after the Login or Menu page).
2. On the Route Selection page, select a route.
3. On the Route Selection page, select a run.
4. On the Route Selection page, tap the wrench icon.
5. Go back to Route Selection, then tap the gear icon.
6. Put the device in offline mode while the Route Selection page is open.
7. Restore the network.
8. On the Route Selection page, select a vehicle and a route, then tap Submit (if substitutions are enabled) (needs: named go-ahead for this run, writes through BP Info).
9. On the Route Selection page, select the whole route when some runs have their own vehicle, then tap Submit.
10. In the submit anyway prompt, tap No.
11. Tap Submit again, then in the prompt tap Yes (needs: named go-ahead for this run, writes through BP Info).
12. On the Route Selection page, tap View Directions.
13. Go back to Route Selection, then tap Run History (if enabled).
14. Go back to Route Selection, then tap Start Driving.
15. With the vehicle picker enabled and no vehicle selected, tap Start Driving.
16. With run history enabled and an active run that is not marked as finished, tap Start Driving.

## Expected (each line must be checkable)
- E1 (step 1, device): The page title shows the name saved on the Setup page.
- E2 (step 1, device): The app asks for permission to use the location.
- E3 (step 1, device): The page loads the Vehicle field (if enabled).
- E4 (step 1, device): The page loads the Route field.
- E5 (step 1, device): Each field shows a list of items.
- E6 (step 1, device): The items in each field are searchable.
- E7 (step 1, device): The app downloads a set of routes and runs for offline use (if enabled).
- E8 (step 1, device): A downloading icon shows while the download runs.
- E9 (step 2, device): The app downloads the list of runs for the route.
- E10 (step 2, device): The run pick list fills with the runs of the route.
- E11 (step 3, device): The View directions button is enabled.
- E12 (step 3, device): The Run history button is enabled (if enabled).
- E13 (step 3, device): The Submit button is enabled (if substitutions are enabled).
- E14 (step 3, device): The Start driving button is enabled.
- E15 (step 4, device): The initial Setup page opens.
- E16 (step 5, device): The Settings page opens.
- E17 (step 6, device): The toolbar shows an offline icon.
- E18 (step 6, device): The vehicle input is disabled.
- E19 (step 8, device): The Submit button is enabled when a vehicle and a route are selected.
- E20 (step 8, ui): A successful submission creates a substitution in the backend (needs: named go-ahead for this run, writes through BP Info).
- E21 (step 9, device): The app lists the runs that have their own vehicle (needs: matching BP Web release).
- E22 (step 9, device): The app asks to submit anyway (needs: matching BP Web release).
- E23 (step 10, device): The app submits nothing (needs: matching BP Web release).
- E24 (step 11, device): The app submits for the whole route (needs: matching BP Web release) (needs: named go-ahead for this run, writes through BP Info).
- E25 (step 12, device): The Directions page opens.
- E26 (step 13, device): The Route Review page opens.
- E27 (step 14, device): The Turns Navigation page opens.
- E28 (step 15, device): The app shows an alert.
- E29 (step 16, device): The app shows an alert to prefill.

## Clean-up
- Remove the substitutions from the two Submit steps in BP Web (they have no QA-AUTO- prefix; find them by route, vehicle and time).
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Turns, rows 60 to 70. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- The Submit steps write through BP Info (substitution): run them only with a named go-ahead for that run (tests README rule).
- Refined 2026-11-26: Route Selection: steps name the screen and action, E lines split, typos fixed.
- Refined 2026-11-26 (review fixes): depends-on emptied (no dependency on TRN-REG-001).
- Refined 2026-11-26 (second review): BP Info write markers on the two Submit steps and E20/E24, substitution check moved to ui with role professional, network restore step, back-to-Route-Selection prefixes, location permission precondition, resources, cleanup.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
