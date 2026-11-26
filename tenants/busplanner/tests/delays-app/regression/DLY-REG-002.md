---
id: DLY-REG-002
title: Delays - Setup - Transportation Authority
module: delays-app
flow: regression
ticket:
priority: P2
spec: [sheet:Delays!9-15]
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

## Steps
1. On the Setup screen, open the Select Transportation Authority dropdown.
2. Type a partial authority name in the dropdown.
3. Type a valid quick code and tap Next.
4. Go back to the authority screen, tap X, type an invalid quick code and tap Next.
5. With an authority resolved (repeat step 3 first), tap the X next to it.
6. Clear any selection and tap Next with nothing selected.
7. Tap the info (i) icon.
8. Dismiss the info dialog.

## Expected (each line must be checkable)
- E1 (step 1, device): The authority list loads.
- E2 (step 2, device): The authority list filters as you type.
- E3 (step 3, device): The authority resolves from the quick code.
- E4 (step 3, device): The authority friendly name is shown.
- E5 (step 3, device): Setup continues only after the friendly name is shown.
- E6 (step 4, device): A clear error message is shown.
- E7 (step 4, device): Setup stays on the same screen.
- E8 (step 4, device): Next does not advance Setup.
- E9 (step 5, device): The selection clears.
- E10 (step 5, device): The dropdown is usable again.
- E11 (step 6, device): Setup does not advance.
- E12 (step 6, device): Next is disabled, or a prompt is shown.
- E13 (step 7, device): The info dialog appears.
- E14 (step 8, device): The info dialog closes and the Setup screen is shown again.

## Clean-up
- Remove any QA-AUTO- data the case created on the server.
- Reset the app data (`adb shell pm clear <package>`) if the next case needs a fresh state.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet Delays, rows 9 to 15. Converted 2026-11-26; wording kept, typos fixed.
- Priority set by the conversion (the sheet has none): P1 for initial checks, offline and app lifecycle, P2 otherwise.
- Known issue: ENG-2717. With an invalid quick code the Next button only greys out and shows no error. The E lines for step 4 state the correct behaviour, so they fail until the bug is fixed.
- Refined 2026-11-26: split compound Expected lines, added steps to dismiss the info dialog and to resolve an authority before the X check, added the QA-test-client precondition.
- Refined 2026-11-26 (after review): Review fixes: removed the dependency on DLY-REG-001, added the start state, step 4 now returns to the authority screen first, set resources.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
