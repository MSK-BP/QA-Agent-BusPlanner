---
id: PRO-REG-006
title: BP Pro (over RDP) - Run Editor
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!18-21]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-average-run]
tags: [regression, from-sheet]
depends-on: []
resources: [exclusive]
status: reviewed
approved-by:
convert-later: none
---
## Preconditions
- Signed in to BP Pro (over RDP) on QA1 (client 1221), an approved test client that is safe to change.
- Data the case creates starts with `QA-AUTO-<initials>-`.

## Steps
1. In Student Manager, add student QA-AUTO-<initials>-P006-01 with one address. Save.
2. In Run Editor, create run QA-AUTO-<initials>-P006-RUN1. Add three stops, one way point, one turnaround point and one school stop, then click Calculate.
3. In Run Editor, create runs QA-AUTO-<initials>-P006-RUN2 and QA-AUTO-<initials>-P006-RUN3 with one stop each. Assign QA-AUTO-<initials>-P006-01 to QA-AUTO-<initials>-P006-RUN2. Add a transfer from QA-AUTO-<initials>-P006-RUN2 to QA-AUTO-<initials>-P006-RUN3, then save.
4. In Run Editor, open QA-AUTO-<initials>-P006-RUN1, change the order of two stops and move one way point, then click Calculate.
5. In Run Editor, build QA-AUTO-<initials>-P006-RUN4 to match the length of the existing run named in data entry client-1221-average-run (needs: name of an existing client 1221 run of average length). Click Calculate and time it with a stopwatch.

## Expected (each line must be checkable)
- E1 (step 2, desktop): All six points show on the run in the order added, and the calculated path is drawn through them with no error dialog.
- E2 (step 2, desktop): The run shows total distance and time values after calculation. (ASSUMPTION)
- E3 (step 3, desktop): The transfer shows on both QA-AUTO-<initials>-P006-RUN2 and QA-AUTO-<initials>-P006-RUN3, and QA-AUTO-<initials>-P006-01 shows on QA-AUTO-<initials>-P006-RUN3 at the transfer stop. (ASSUMPTION)
- E4 (step 4, desktop): The new path follows the new stop order and the moved way point, and the old path no longer shows.
- E5 (step 5, desktop): The path calculation finishes within 1 minute.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 18 to 21. Converted 2026-11-26.
- Row 18: last manual result pass on 13.3.0.195.
- Row 19: last manual result pass on 13.3.0.195.
- Row 20: last manual result pass on 13.3.0.195.
- Row 21: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: resources exclusive because step 5 is timed. The case now creates its own student. 'Average length' is not defined in the sheet; the data entry names an existing run to copy. Clean-up: delete the QA-AUTO runs and student. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
