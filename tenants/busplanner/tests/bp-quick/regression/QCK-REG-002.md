---
id: QCK-REG-002
title: BP Quick - Student – transportation assignment wizard
module: bp-quick
flow: regression
ticket:
priority: P1
spec: [sheet:BP Quick!5-6]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221, client-1221-wizard-case]
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
1. In Run Console, create run QA-AUTO-<initials>-Q002-RUN1 with stops QA-AUTO-<initials>-Q002-STOP1, QA-AUTO-<initials>-Q002-STOP2 and QA-AUTO-<initials>-Q002-STOP3 in path order. Save. (needs: three locations along one path, in data entry client-1221-wizard-case)
2. In Student Manager, add student QA-AUTO-<initials>-Q002-01 with the address named in data entry client-1221-wizard-case (needs: student address and the expected nearest eligible stop). Save.
3. Open the transportation assignment wizard for QA-AUTO-<initials>-Q002-01 and run Find stop.
4. In the wizard, assign the student to the proposed stop on the run and look at the run's stop list.

## Expected (each line must be checkable)
- E1 (step 3, ui): The wizard proposes the expected nearest eligible stop written in the data entry. (needs: expected nearest eligible stop, from the data and not from the wizard's own distances)
- E2 (step 4, ui): The stop sits between QA-AUTO-<initials>-Q002-STOP1 and QA-AUTO-<initials>-Q002-STOP3 in the run's stop list. (needs: expected stop position on the run, from the data)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 5 to 6. Converted 2026-11-26.
- Row 5: last manual result pass on 13.1.12.153.
- Row 6: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: the case builds its own run, so no existing client 1221 run changes. Expected values come from the data entry, not from the wizard. Clean-up: remove the assignment, delete the QA-AUTO run, stops and student. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
