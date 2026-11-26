---
id: DLY-REG-003
title: Delays - Setup - Schools
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!16-24]
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
- The authority is resolved with the QA quick code and the Schools screen is open.

## Steps
1. On the Schools screen, open the Select Schools dropdown.
2. Type a partial school name in the dropdown.
3. Select a single school.
4. Select several more schools, one after the other.
5. Tap the minus button next to one chosen school.
6. Tick Subscribe to all alerts for all schools.
7. Tap OK on the confirmation dialog.
8. Untick Subscribe to all alerts for all schools.
9. Remove every chosen school.
10. With no school chosen and Subscribe-to-all unticked, tap Next.
11. Select two schools and tap Next to open the Routes screen.
12. Go back from the Routes screen.

## Expected (each line must be checkable)
- E1 (step 1, device): The school list loads for the chosen authority.
- E2 (step 2, device): The school list filters as you type.
- E3 (step 3, device): The school appears under Chosen schools.
- E4 (step 3, device): The chosen school has a remove (minus) button.
- E5 (step 4, device): All selected schools appear under Chosen schools.
- E6 (step 4, device): The dropdown does not offer a school that is already chosen.
- E7 (step 5, device): The school is removed from Chosen schools.
- E8 (step 5, device): The school returns to the dropdown list.
- E9 (step 6, device): A confirmation dialog appears.
- E10 (step 7, device): The school dropdown is disabled.
- E11 (step 8, device): The school dropdown is selectable again.
- E12 (step 8, device): The earlier school choices are retained.
- E13 (step 10, device): Setup does not advance.
- E14 (step 10, device): Next is disabled, or a prompt is shown.
- E15 (step 12, device): The Schools screen shows the chosen schools exactly as left.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 16 to 24. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Refined 2026-11-26: split compound Expected lines, split the Subscribe-to-all tick into the tick and the OK tap, added steps to remove all schools and to reach the Routes screen so the last checks have a defined state, added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, added the start state, step 11 selects two schools, set resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
