---
id: QCK-REG-003
title: BP Quick - Add a new student
module: bp-quick
flow: regression
ticket:
priority: P2
spec: [sheet:BP Quick!7-9]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: []
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Quick on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. Control: in Add a new student, create QA-AUTO-<initials>-Q003-01 with two addresses of the same type: one with effective dates 2026-09-01 to 2026-12-31, one with 2027-01-01 to 2027-06-30. Save.
2. In Add a new student, create QA-AUTO-<initials>-Q003-02 with two addresses of the same type with overlapping dates: 2026-09-01 to 2026-12-31 and 2026-11-01 to 2027-03-31. Save.
3. In Add a new student, create QA-AUTO-<initials>-Q003-03 with two addresses of different types (Home and Mailing), both with dates 2026-09-01 to 2026-12-31. Save.
4. In Add a new student, create QA-AUTO-<initials>-Q003-04 with two enrollments of the same type with overlapping dates: 2026-09-01 to 2026-12-31 and 2026-11-01 to 2027-03-31. Save.

## Expected (each line must be checkable)
- E1 (step 1, ui): Both addresses save with no error, which shows the refusal in step 2 comes from the overlap.
- E2 (step 2, ui): The save is refused and an error message names the date overlap for the address type. (ASSUMPTION)
- E3 (step 3, ui): Both addresses save with no error and show in the student's address list, one row per type.
- E4 (step 4, ui): The save is refused and an error message names the date overlap for the enrollment type. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 7 to 9. Converted 2026-11-26.
- Row 7: last manual result fail on 13.1.12.153; other results: 13.1.8.155: fail; 13.1.9.116: fail; 13.1.12.153: fail.
- Row 7 note: ENG-129.
- Row 8: last manual result pass on 13.1.12.153.
- Row 9: last manual result fail on 13.1.12.153; other results: 13.1.8.155: fail; 13.1.9.116: fail; 13.1.12.153: fail.
- Row 9 note: ENG-128.
- Refined 2026-11-26: Known issues: ENG-129 (addresses overlap, fail on 13.1.8.155, 13.1.9.116, 13.1.12.153) and ENG-128 (enrollments overlap, same versions). The expectation stays as the sheet states, so a fail is a product bug. Step 1 is a control added to the sheet. Clean-up: delete any QA-AUTO student that saved. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
