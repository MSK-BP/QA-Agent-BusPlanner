---
id: QCK-REG-007
title: BP Quick - Reports
module: bp-quick
flow: regression
ticket:
priority: P2
spec: [sheet:BP Quick!17-20]
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
1. In Add a new student, create student QA-AUTO-<initials>-Q007-01. In Run Console, create run QA-AUTO-<initials>-Q007-RUN1 with stops QA-AUTO-<initials>-Q007-STOP1, QA-AUTO-<initials>-Q007-STOP2, QA-AUTO-<initials>-Q007-STOP3 in path order and click Calculate. Assign QA-AUTO-<initials>-Q007-01 to QA-AUTO-<initials>-Q007-STOP2. In Route Console, create route QA-AUTO-<initials>-Q007-ROUTE and add QA-AUTO-<initials>-Q007-RUN1.
2. In Reports, run Bus Pass for QA-AUTO-<initials>-Q007-01.
3. In Reports, run Route Summary for QA-AUTO-<initials>-Q007-ROUTE.
4. In Reports, run Route Details for QA-AUTO-<initials>-Q007-RUN1.
5. In Reports, run Route Directions for QA-AUTO-<initials>-Q007-RUN1.

## Expected (each line must be checkable)
- E1 (step 2, ui): The bus pass shows the student, QA-AUTO-<initials>-Q007-RUN1 and the stop name QA-AUTO-<initials>-Q007-STOP2 with the stop time. (ASSUMPTION)
- E2 (step 3, ui): The report lists QA-AUTO-<initials>-Q007-STOP1, QA-AUTO-<initials>-Q007-STOP2 and QA-AUTO-<initials>-Q007-STOP3 in that order.
- E3 (step 4, ui): QA-AUTO-<initials>-Q007-01 shows under QA-AUTO-<initials>-Q007-STOP2.
- E4 (step 4, ui): No other stop lists the student.
- E5 (step 5, ui): The report lists every stop, and the directions follow the calculated run path.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 17 to 20. Converted 2026-11-26.
- Row 17: last manual result pass on 13.1.12.153.
- Row 17 note: ENG-1126.
- Row 18: last manual result pass on 13.1.12.153.
- Row 19: last manual result fail on 13.1.12.153; other results: 13.1.12.153: fail.
- Row 19 note: ENG-1135.
- Row 20: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: the case builds its own student, run and route. Manual results: row 17 note ENG-1126; row 19 (Route Details) fail on 13.1.12.153, ENG-1135. Expected lines keep the sheet meaning, so a fail is a product bug. Clean-up: delete the QA-AUTO records. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
