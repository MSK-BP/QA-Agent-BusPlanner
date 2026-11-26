---
id: QCK-REG-005
title: BP Quick - Run Console
module: bp-quick
flow: regression
ticket:
priority: P1
spec: [sheet:BP Quick!12-14]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221]
tags: [regression, from-sheet]
depends-on: []
resources: [exclusive]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- Signed in to BP Quick on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Run Console, create run QA-AUTO-<initials>-Q005-RUN1 with three stops and one way point, and run QA-AUTO-<initials>-Q005-RUN2 with one stop. Add a transfer from QA-AUTO-<initials>-Q005-RUN1 to QA-AUTO-<initials>-Q005-RUN2. Save.
2. In Run Console, click Calculate on QA-AUTO-<initials>-Q005-RUN1 for the first time, time it with a stopwatch, and view the path on the map.

## Expected (each line must be checkable)
- E1 (step 1, ui): The run lists the three stops, the transfer and the way point in the order added, with no error.
- E2 (step 2, ui): The path on the map passes through every stop and the way point in order, and follows roads. (ASSUMPTION)
- E3 (step 2, ui): The first calculation finishes in under 1 minute.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 12 to 14. Converted 2026-11-26.
- Row 12: last manual result pass on 13.1.12.153.
- Row 13: last manual result pass on 13.1.12.153.
- Row 14: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: resources exclusive because step 2 is timed. 'Accurate' is taken as through all points in order on roads (ASSUMPTION). Clean-up: delete the QA-AUTO runs. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
