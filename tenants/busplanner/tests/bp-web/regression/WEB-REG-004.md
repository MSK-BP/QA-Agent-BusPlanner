---
id: WEB-REG-004
title: BP Web - Where is the Bus Page
module: bp-web
flow: regression
ticket:
priority: P1
spec: [sheet:BP Web!21-22]
channels: [ui]
roles: [anonymous]
env: qa1
data: [client-1221, data:1221-test-student]
tags: [regression, from-sheet]
depends-on: []
resources: [data:1221-vehicle-mapping]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- BP Web on QA1 (client 1221) is open with no sign-in.
- A test student with a bus and live GPS data exists (`data:1221-test-student`: student number and date of birth for the lookup) (ASSUMPTION; needs: the values named in the tests README).
- This case only reads; it posts no alert or notice.

## Steps
1. As the anonymous user, open the Where is the Bus page of client 1221.
2. As the anonymous user, on the Where is the Bus page, look up the test student by student number and date of birth.
3. As the anonymous user, on the result, view the bus on the map.
4. As the anonymous user, on the result, read the ETA.
5. As the anonymous user, on the Where is the Bus page, refresh the data.
6. As the anonymous user, on the Where is the Bus page, open the Bus (ETA) view (ASSUMPTION: the sheet names the item only).

## Expected (each line must be checkable)
- E1 (step 3, ui): The bus of the student shows on the map.
- E2 (step 4, ui): An ETA shows for the student.
- E3 (step 5, ui): The 'Updated' time shows after the refresh.
- E4 (step 5, ui): The "Last reported" time shows.
- E5 (step 6, ui): The Bus (ETA) view opens and shows an ETA with no error (ASSUMPTION: the sheet gives no observed result).

## Clean-up
- None. The case only reads.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Web, rows 21 to 22. Converted 2026-11-26; expected results come from the sheet's observed result column.
- Row 21: last manual status Passed.
- Row 22: last manual status Passed.
- Refined 2026-11-26: map, ETA, Updated time and Last reported time split into separate E lines; Bus (ETA) step kept with ASSUMPTION. Reviewer fixes: E3 now "Updated time shows after the refresh", lookup data named, Clean-up None, resources set.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
