---
id: PRO-REG-001
title: BP Pro (over RDP) - Simple Checks
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!2-7]
channels: [desktop]
roles: []
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: none
---
## Preconditions
- The tester has a BP Pro test user for client 1221 for BP authentication and for Windows authentication.
- Data the case creates starts with `QA-AUTO-<initials>-P001-` (this case creates none).

## Steps
1. Start BP Pro through Open Remote on the RDP host, once with BP authentication and once with Windows authentication, and sign in as the client 1221 test user each time.
2. In the main window, open the map view and pan and zoom across the client 1221 service area.
3. On the map, click an existing student, then an existing stop, then an existing run.
4. Open Find Student, search for an existing client 1221 student by name, and select the result.
5. Open Find Run, search for an existing client 1221 run by name, and select the result.
6. Open Route Manager from the main menu.

## Expected (each line must be checkable)
- E1 (step 1, desktop): After the BP login and again after the Windows login, the BP Pro main window opens with no error dialog. (ASSUMPTION)
- E2 (step 1, desktop): Sign-in finishes with no Open Remote settings prompt.
- E3 (step 2, desktop): Map tiles, streets and the client 1221 stops and runs draw with no blank areas and no error dialog, and they stay in place after pan and zoom. (ASSUMPTION)
- E4 (step 3, desktop): After the click on the student, the student is highlighted on the map and its details show in the selection panel or tooltip. (ASSUMPTION)
- E5 (step 3, desktop): After the click on the stop, the stop is highlighted on the map and its details show in the selection panel or tooltip. (ASSUMPTION)
- E6 (step 3, desktop): After the click on the run, the run is highlighted on the map and its details show in the selection panel or tooltip. (ASSUMPTION)
- E7 (step 4, desktop): Find Student lists the student searched for, and selecting the result opens that student's record or centres the map on the student. (ASSUMPTION)
- E8 (step 5, desktop): Find Run lists the run searched for, and selecting the result opens that run or centres the map on it. (ASSUMPTION)
- E9 (step 6, desktop): Route Manager opens and lists the existing client 1221 routes with their runs, with no error dialog. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 2 to 7. Converted 2026-11-26.
- Row 2: last manual result Ask for settings of remote on 132.1.2.106; other results: 12.2.1.336: remote pass; 132.1.2.106: Ask for settings of remote.
- Row 3: last manual result pass on 13.3.0.195.
- Row 4: last manual result pass on 13.3.0.195; other results: 12.2.1.336: uncle to select run.
- Row 5: last manual result pass on 13.3.0.195.
- Row 6: last manual result pass on 13.3.0.195.
- Row 7: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: the sign-in is step 1, so Preconditions no longer say 'Signed in'; E2 now checks no Open Remote settings prompt (row 2 manual result on 132.1.2.106: Ask for settings of remote); E4 split into student, stop and run. No data created; the case is read-only. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
