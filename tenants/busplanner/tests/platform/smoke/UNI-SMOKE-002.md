---
id: UNI-SMOKE-002
title: The signed-in US staging app opens without a sign-in page or console errors
module: platform
flow: smoke
ticket:
priority: P1
spec: [environments.md]
channels: [ui]
roles: [staging-qa]
env: us-staging
data: []
tags: [smoke]
status: reviewed
approved-by:
convert-later: ui
---
## Preconditions
- The tester signed in to US staging with the staging QA account in the Playwright window before (the sign-in persists).

## Steps
1. As staging-qa, open https://bpu-us-staging-app.busplannerweb.com/.
2. Wait until the page stops loading, then read the page snapshot and the console messages.

## Expected (each line must be checkable)
- E1 (step 2, ui): the page URL is still on `bpu-us-staging-app.busplannerweb.com`; the page shows no sign-in form (no password field).
- E2 (step 2, ui): the page shows a navigation region with at least one link.
- E3 (step 2, ui): the console shows no message of level "error".

## Clean-up
- None. The case only reads.

## Notes
- If E1 shows a sign-in page, the persisted session expired: the result is Blocked, not Fail. Sign in again in the Playwright window and rerun.
