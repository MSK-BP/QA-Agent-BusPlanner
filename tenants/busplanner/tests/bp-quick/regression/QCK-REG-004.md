---
id: QCK-REG-004
title: BP Quick - Calculate Student Eligibility
module: bp-quick
flow: regression
ticket:
priority: P1
spec: [sheet:BP Quick!10-11]
channels: [ui]
roles: [qa-user]
env: qa1
data: [client-1221, client-1221-eligibility-addresses]
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
1. In Add a new student, create five students QA-AUTO-<initials>-Q004-01 to QA-AUTO-<initials>-Q004-05. Give each the address of one type from data entry client-1221-eligibility-addresses: Walker, Bussed, Hazard, Out of Bounds, Out of District, in that order. (needs: one client 1221 address per eligibility type)
2. For each student, click Calculate Eligibility and time it with a stopwatch.

## Expected (each line must be checkable)
- E1 (step 2, ui): QA-AUTO-<initials>-Q004-01 shows eligibility Walker. (needs: Walker address in client-1221-eligibility-addresses)
- E2 (step 2, ui): QA-AUTO-<initials>-Q004-02 shows eligibility Bussed. (needs: Bussed address in client-1221-eligibility-addresses)
- E3 (step 2, ui): QA-AUTO-<initials>-Q004-03 shows eligibility Hazard. (needs: Hazard address in client-1221-eligibility-addresses)
- E4 (step 2, ui): QA-AUTO-<initials>-Q004-04 shows eligibility Out of Bounds. (needs: Out of Bounds address in client-1221-eligibility-addresses)
- E5 (step 2, ui): QA-AUTO-<initials>-Q004-05 shows eligibility Out of District. (needs: Out of District address in client-1221-eligibility-addresses)
- E6 (step 2, ui): Each eligibility calculation finishes in under 15 seconds.

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Quick, rows 10 to 11. Converted 2026-11-26.
- Row 10: last manual result pass on 13.1.12.153.
- Row 11: last manual result pass on 13.1.12.153.
- Refined 2026-11-26: resources exclusive because step 2 is timed. Addresses come from the shared data entry. Clean-up: delete the five QA-AUTO students. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
