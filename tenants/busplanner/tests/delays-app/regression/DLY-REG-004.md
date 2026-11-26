---
id: DLY-REG-004
title: Delays - Setup - Routes/Runs
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!25-32]
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
- Setup is open after the app data is cleared (`adb shell pm clear <package>`).
- The authority is resolved with the QA quick code, two schools are chosen, and the Routes screen is open. Each chosen school has routes or runs on the QA test client (ASSUMPTION).

## Steps
1. On the Routes screen, open the Select Route/Run dropdown.
2. Type a partial route or run name in the dropdown.
3. Select one route/run.
4. Select several more routes/runs, one after the other.
5. Tap the remove button next to one chosen route/run.
6. Tick Subscribe to all routes for selected schools.
7. Tap OK on the confirmation dialog.
8. Untick Subscribe to all routes for selected schools.
9. Select a route/run that belongs to one chosen school.
10. Go back to the Schools screen and remove that school from the chosen schools.
11. Tap Next to return to the Routes screen.
12. Tap Done.

## Expected (each line must be checkable)
- E1 (step 1, device): The route and run list loads.
- E2 (step 1, device): The list shows only routes and runs of the chosen schools.
- E3 (step 2, device): The list filters as you type.
- E4 (step 3, device): The route/run appears in the chosen list.
- E5 (step 3, device): The chosen route/run has a remove button.
- E6 (step 4, device): Every selected route/run appears in the chosen list.
- E7 (step 4, device): Every chosen route/run has a remove button.
- E8 (step 5, device): The route/run is removed from the chosen list.
- E9 (step 5, device): The route/run returns to the dropdown.
- E10 (step 6, device): A confirmation dialog appears.
- E11 (step 7, device): The route/run dropdown is disabled.
- E12 (step 8, device): The route/run dropdown is selectable again.
- E13 (step 11, device): The route list shows only routes of the new school selection.
- E14 (step 11, device): The pick that belonged to the removed school is dropped.
- E15 (step 12, device): Setup completes.
- E16 (step 12, device): The Notifications screen is shown.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 25 to 32. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split compound Expected lines, split the Subscribe-to-all tick into the tick and the OK tap, made the school-change row concrete as remove one school that has a chosen route (ASSUMPTION), added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, added the start state, set resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
