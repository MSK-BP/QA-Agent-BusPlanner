---
id: PRO-REG-011
title: BP Pro (over RDP) - Run optimizer
module: bp-pro
flow: regression
ticket:
priority: P2
spec: [sheet:BP Pro!28-28]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-optimizer-stops]
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
1. In Run Editor, create run QA-AUTO-<initials>-P011-RUN and add five stops in this order: QA-AUTO-<initials>-P011-STOP-C, QA-AUTO-<initials>-P011-STOP-A, QA-AUTO-<initials>-P011-STOP-E, QA-AUTO-<initials>-P011-STOP-B, QA-AUTO-<initials>-P011-STOP-D. Use the five locations in data entry client-1221-optimizer-stops (needs: five real client 1221 locations that are not already in path order). Save.
2. In Run Editor, with QA-AUTO-<initials>-P011-RUN open, click the Wand (optimizer) tool and time it with a stopwatch.

## Expected (each line must be checkable)
- E1 (step 2, desktop): The optimizer finishes within 2 minutes.
- E2 (step 2, desktop): The optimized path visits each of the five stops once and has no obvious back-tracking. (ASSUMPTION)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 28 to 28. Converted 2026-11-26.
- Row 28: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: resources exclusive because step 2 is timed. 'Logical path' has no rule in the sheet; the criterion is assumed. Clean-up: delete the QA-AUTO run and stops. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
