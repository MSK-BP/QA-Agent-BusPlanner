---
case: MOD-001
run: 2026-01-01-0900-suite-dev
env: dev
build:                          # deployed commit or version, as the app or API reports it
rehearsal: no
runner: case-runner
verdict:                        # filled by the run skill from result-verifier: Pass | Fail | Blocked | Inconclusive
verified-by:
---
# MOD-001: result

## Observations (case-runner)

| E | Channel | Observed (exactly what was seen) | Evidence |
|---|---|---|---|
| E1 | ui | ... | screenshot file name, snapshot excerpt, or "none" |
| E2 | sql | ... | the query and its rows |

## Steps taken
1. What was done for each step, with the role and the time. Note any step that could not be done as written.

## Data created and clean-up
- Each QA-AUTO- record created, and whether clean-up removed it.

## Problems while running
- Anything that stopped or changed the run: sign-in, environment down, missing data. "None" if nothing.

## Verdicts (result-verifier)

| E | Verdict | Reason |
|---|---|---|
| E1 | | |

Case verdict: 
