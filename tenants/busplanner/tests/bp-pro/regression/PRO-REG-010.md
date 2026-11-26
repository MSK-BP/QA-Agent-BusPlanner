---
id: PRO-REG-010
title: BP Pro (over RDP) - Find Distance tool
module: bp-pro
flow: regression
ticket:
priority: P2
spec: [sheet:BP Pro!27-27]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-walkway-points]
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
1. Open Find Distance, enter the start and end address from data entry client-1221-walkway-points, and run the walking and the driving calculation. (needs: a start and end address with a walkway between them)

## Expected (each line must be checkable)
- E1 (step 1, desktop): The walking path uses the walkway and is drawn separately from the driving path. (needs: point pair with a known walkway)
- E2 (step 1, desktop): Walking distance is shorter than driving distance. (needs: point pair with a known walkway)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 27 to 27. Converted 2026-11-26.
- Row 27: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: the point pair must come from client 1221 data. No QA-AUTO data created. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
