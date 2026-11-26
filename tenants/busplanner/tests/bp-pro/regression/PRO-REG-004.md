---
id: PRO-REG-004
title: BP Pro (over RDP) - Calculate Student Eligibility
module: bp-pro
flow: regression
ticket:
priority: P1
spec: [sheet:BP Pro!14-14]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-eligibility-addresses]
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
1. In Student Manager, add five students QA-AUTO-<initials>-P004-01 to QA-AUTO-<initials>-P004-05. Give each the address of one type from data entry client-1221-eligibility-addresses: Walker, Bussed, Hazard, Out of Bounds, Out of District, in that order. (needs: one client 1221 address per eligibility type)
2. Run Calculate Eligibility on each student.

## Expected (each line must be checkable)
- E1 (step 2, desktop): QA-AUTO-<initials>-P004-01 shows eligibility Walker. (needs: Walker address in client-1221-eligibility-addresses)
- E2 (step 2, desktop): QA-AUTO-<initials>-P004-02 shows eligibility Bussed. (needs: Bussed address in client-1221-eligibility-addresses)
- E3 (step 2, desktop): QA-AUTO-<initials>-P004-03 shows eligibility Hazard. (needs: Hazard address in client-1221-eligibility-addresses)
- E4 (step 2, desktop): QA-AUTO-<initials>-P004-04 shows eligibility Out of Bounds. (needs: Out of Bounds address in client-1221-eligibility-addresses)
- E5 (step 2, desktop): QA-AUTO-<initials>-P004-05 shows eligibility Out of District. (needs: Out of District address in client-1221-eligibility-addresses)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 14 to 14. Converted 2026-11-26.
- Row 14: last manual result pass on 13.3.0.195; other results: 132.1.2.106: Unable to repro walker; 13.1.8.155: Unable to repro walker.
- Refined 2026-11-26: addresses must come from known client 1221 boundaries; the data entry holds one address per type. Walker could not be reproduced on 132.1.2.106 and 13.1.8.155. Clean-up: delete the five QA-AUTO students. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
