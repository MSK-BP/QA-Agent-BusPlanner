---
case: UNI-SMOKE-002
run: 2026-11-18-0222-smoke-us-staging
env: us-staging
build: unknown (config.json on the app host returns only the keys apiUrl and dd; no commit or version)
rehearsal: yes
runner: case-runner
verdict: Blocked
verified-by: result-verifier
---
# UNI-SMOKE-002: result

## Observations (case-runner)

| E | Channel | Observed (exactly what was seen) | Evidence |
|---|---|---|---|
| E1 | ui | After load, URL was `https://bpu-us-staging-app.busplannerweb.com/login` (host unchanged; the path changed from `/` to `/login`). The page shows heading "Welcome back", text "Sign in to your BusPlanner account to continue.", textbox "Work email" and a disabled button "Continue". `input[type=password]` count: 0 (the sign-in form has an email field only, no password field yet). | UNI-SMOKE-002-E1.png |
| E2 | ui | Not observed: the page is the sign-in page. The snapshot has no navigation region and no links. DOM query: 0 `nav` or `[role=navigation]` elements. | UNI-SMOKE-002-E1.png |
| E3 | ui | Console (all levels, since session start) shows 1 message, level ERROR: "Datadog Browser SDK: Application ID is not configured, no RUM data will be collected." from `/assets/index-CWIOQqTi.js:15`. This was on the sign-in page, not the signed-in app. | UNI-SMOKE-002-console.txt |

## Steps taken
1. As the Playwright window session (no signed-in user was visible), opened https://bpu-us-staging-app.busplannerweb.com/ (time about 02:23 local). The page redirected to `/login`.
2. Waited 3 seconds. Read the snapshot, a DOM query and the console messages. A sign-in page was shown, so the run stopped here. No credentials typed, no field filled.
3. Read `/config.json` for the build: keys `apiUrl` and `dd` only.

## Data created and clean-up
- None created. Nothing to clean up.

## Problems while running
- The sign-in page appeared: the persisted session is missing or expired. The case Notes say this makes the result Blocked and the tester must sign in again in the Playwright window.
- The Playwright tool could only write files under `...\qa-runs\busplanner\browser`; the screenshot and console file were saved there and copied into the run evidence folder.

## Verdicts (result-verifier)

| E | Verdict | Reason |
|---|---|---|
| E1 | Blocked | Redirected to `/login`; `UNI-SMOKE-002-E1.png` shows the sign-in form ("Welcome back", "Work email"). Case Notes: sign-in page means Blocked |
| E2 | Blocked | Precondition not met: the signed-in app never loaded |
| E3 | Blocked | The one console error (Datadog Browser SDK: Application ID is not configured) came from the sign-in page, not the signed-in app |

Case verdict: Blocked

Run concerns: Persisted sign-in expired. Console capture covered the whole session (fixed: capture after the case URL loads). The Datadog error will likely appear in the signed-in app too: E3 may then fail on a known, non-functional message.
