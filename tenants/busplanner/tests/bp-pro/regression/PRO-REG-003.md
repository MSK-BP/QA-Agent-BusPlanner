---
id: PRO-REG-003
title: BP Pro (over RDP) - Student – adding student to transportation
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!12-13]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-walkable-address]
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
1. In Run Editor, create run QA-AUTO-<initials>-P003-RUN1 with stop QA-AUTO-<initials>-P003-STOP1, and run QA-AUTO-<initials>-P003-RUN2 with stop QA-AUTO-<initials>-P003-STOP2. Save both.
2. In Student Manager, add student QA-AUTO-<initials>-P003-01 with an address within walking distance of QA-AUTO-<initials>-P003-STOP1 (needs: an address within the client 1221 walk-to-stop distance of STOP1; data client-1221-walkable-address). On its Transportation tab, assign the student to QA-AUTO-<initials>-P003-RUN1 with effective date 2026-09-01. Save.
3. In Student Manager, add student QA-AUTO-<initials>-P003-02. On its Transportation tab, assign QA-AUTO-<initials>-P003-RUN1 with effective dates 2026-09-01 to 2026-12-31 (row 1) and QA-AUTO-<initials>-P003-RUN2 with effective dates 2027-01-01 to 2027-06-30 (row 2). Save.
4. On the Transportation tab of QA-AUTO-<initials>-P003-02, change the effective date of row 1 to start 2026-09-15. Save. Remove row 2. Save.

## Expected (each line must be checkable)
- E1 (step 2, desktop): The Transportation tab of QA-AUTO-<initials>-P003-01 shows the assignment to QA-AUTO-<initials>-P003-RUN1 and QA-AUTO-<initials>-P003-STOP1 with effective date 2026-09-01.
- E2 (step 2, desktop): QA-AUTO-<initials>-P003-STOP1 lists QA-AUTO-<initials>-P003-01 in its student list after save. (ASSUMPTION)
- E3 (step 3, desktop): Both assignments save with no error, and the Transportation tab lists two rows, each with its own effective dates.
- E4 (step 4, desktop): Row 1 shows the new date.
- E5 (step 4, desktop): Only row 1 remains.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 12 to 13. Converted 2026-11-26.
- Row 12: last manual result pass on 13.3.0.195.
- Row 13: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: the case now builds its own QA-AUTO runs and stops, so no client 1221 record is changed. The sheet group 'Add, update dates, remove' is covered by step 4. The 'walking distance' limit is a client setting and the sheet gives no value. Clean-up: remove the assignments, then delete both students, both runs and both stops. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
