---
id: PRO-REG-002
title: BP Pro (over RDP) - Add a student
module: bp-pro
flow: regression
ticket:
priority: P2
spec: [sheet:BP Pro!8-11]
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
- Signed in to BP Pro (over RDP) on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Student Manager, add student QA-AUTO-<initials>-P002-01 and, on its Addresses tab, add two addresses of the same type: one with effective dates 2026-09-01 to 2026-12-31, one with 2027-01-01 to 2027-06-30. Save.
2. In Student Manager, add student QA-AUTO-<initials>-P002-02, and add two addresses of two different types (Home and Mailing), both with effective dates 2026-09-01 to 2026-12-31. Save.
3. In Student Manager, add student QA-AUTO-<initials>-P002-03, and on its Enrollments tab add two enrollments of the same type: one with dates 2026-09-01 to 2026-12-31, one with 2027-01-01 to 2027-06-30. Save.
4. In Student Manager, add student QA-AUTO-<initials>-P002-04, and add two enrollments of two different types, both with dates 2026-09-01 to 2026-12-31. Save.

## Expected (each line must be checkable)
- E1 (step 1, desktop): Both addresses save with no error or overlap warning, and both show in the Addresses list with their own effective and retire dates.
- E2 (step 1, desktop): Closing and reopening the student shows both addresses still saved. (ASSUMPTION)
- E3 (step 2, desktop): Both addresses save with no error, and the Addresses list shows one row of each type.
- E4 (step 3, desktop): Both enrollments save with no error or overlap warning, and both show in the Enrollments list with their own dates.
- E5 (step 4, desktop): Both enrollments save with no error, and the Enrollments list shows one row of each type. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 8 to 11. Converted 2026-11-26.
- Row 8: last manual result pass on 13.3.0.195.
- Row 9: last manual result pass on 13.3.0.195.
- Row 10: last manual result pass on 13.3.0.195.
- Row 11: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: each step adds its own student (QA-AUTO-<initials>-P002-01 to -04) with fixed dates; the 'different types' pairs use the same dates (ASSUMPTION). Clean-up: delete the four QA-AUTO students. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
