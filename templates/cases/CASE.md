---
id: MOD-001                     # unique; equals the file name (MOD-001.md)
title: One line, what is tested
module: module-name             # folder under tests/
flow: F1                        # sub-folder; use "general" if there are no flows
ticket:                         # tracker key, if the case comes from a ticket
priority: P1                    # P1 | P2 | P3
spec: []                        # requirement or acceptance-criteria IDs this case proves
channels: [ui, sql]             # ui | api | sql | device | cli | desktop: every channel an Expected line uses
roles: [role-name]              # who acts in the UI; one signed-in identity per role
env: dev                        # lowest allowed environment where the case can run
data: []                        # named test data it needs (see the tenant's tests/README.md)
tags: []                        # free labels: smoke, regression, gap, ...
depends-on: []                  # case IDs that must pass before this one starts (a build, data, a prior state)
resources: []                   # what no other case may use at the same time: build:<repo>, device:<name>,
                                # browser:session, data:<record>. Empty = the channel default (see the tests README)
status: draft                   # draft -> reviewed (agent review) -> approved (a person) -> retired
approved-by:                    # the person who approved it; required when status is approved
convert-later:                  # what a coded framework should automate later: ui | api | device | none
---
## Preconditions
- The state the system must be in before step 1. Name the test data. Everything the case creates is prefixed QA-AUTO-.

## Steps
1. One action per step, as a user or a call: "As <role>, open ...", "Call GET /api/...".
2. ...

## Expected (each line must be checkable)
- E1 (step 1, ui): what is visible, by role and label, exact text where it matters.
- E2 (step 2, sql): what the database holds, as a query result.
- E3 (step 2, api): status code and the field values that matter.

## Clean-up
- How to remove what the case created. "None" if it creates nothing.

## Notes
- Optional: the rule behind the case, links, known issues.
