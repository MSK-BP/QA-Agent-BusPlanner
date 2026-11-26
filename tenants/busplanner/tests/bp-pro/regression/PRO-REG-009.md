---
id: PRO-REG-009
title: BP Pro (over RDP) - Find Eligibility tool
module: bp-pro
flow: regression
ticket:
priority: P2
spec: [sheet:BP Pro!26-26]
channels: [desktop]
roles: []
env: qa1
data: [client-1221, client-1221-find-eligibility-case]
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
1. Open Find Eligibility, enter the address from data entry client-1221-find-eligibility-case and run the search. (needs: a client 1221 address)

## Expected (each line must be checkable)
- E1 (step 1, desktop): The tool shows the expected eligibility type for the address. (needs: address and its expected eligibility type)
- E2 (step 1, desktop): The tool lists the expected school names for the address. (needs: expected school names for that address)

## Clean-up
- Remove every `QA-AUTO-` record the case created.

## Notes
- Source: `knowledge/sources/master-regression-testing-list.xlsx`, sheet BP Pro, rows 26 to 26. Converted 2026-11-26.
- Row 26: last manual result pass on 13.3.0.195.
- Refined 2026-11-26: the address, its expected eligibility and its school names are held in the data entry and must be supplied from client 1221 data. No QA-AUTO data created. Revised after reviewer: unique case-prefixed data names, own build steps, concrete dates.
- Reviewed 2026-11-26: independent test-reviewer per module; all its fixes applied by the refiner; no second review after the fixes. A person approves before any run.
