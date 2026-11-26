---
id: PRO-REG-008
title: BP Pro (over RDP) - GPS
module: bp-pro
flow: regression
ticket:
priority: P2
spec: [sheet:BP Pro!25-25]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-gps-run-date]
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
1. In the GPS module, open Bus Stop Compare for the run and day named in data entry client-1221-gps-run-date. (needs: a client 1221 run and a day that have GPS data on QA1)

## Expected (each line must be checkable)
- E1 (step 1, desktop): The planned stops and the actual (GPS) stops show side by side, and each planned stop pairs with its matching actual stop. (needs: run and day with GPS data)
- E2 (step 1, desktop): The screen shows data and no 'No data visible' message for that day and run. (needs: run and day with GPS data)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 25 to 25. Converted 2026-11-26.
- Row 25: last manual result pass on 13.3.0.195; other results: 13.0.2.68: No data visible, need domain.
- Refined 2026-11-26: on 13.0.2.68 the result was 'No data visible, need domain'. No QA-AUTO data created. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
