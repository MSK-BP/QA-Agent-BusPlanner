---
case: UNI-SMOKE-001
run: 2026-11-18-0222-smoke-us-staging
env: us-staging
build: c7a2c81d03088885680edebe1bd0e815711c291c
rehearsal: yes
runner: case-runner
verdict: Pass
verified-by: result-verifier
---
# UNI-SMOKE-001: result

## Observations (case-runner)

| E | Channel | Observed (exactly what was seen) | Evidence |
|---|---|---|---|
| E1 | api | GET /health on bpu-us-staging-api: status 200, body `Healthy` | UNI-SMOKE-001-step1.txt |
| E2 | api | GET /health/ready on bpu-us-staging-api: status 200, body `Healthy` | UNI-SMOKE-001-step2.txt |
| E3 | api | GET /config.json on bpu-us-staging-app: status 200; `apiUrl` = `https://bpu-us-staging-api.busplannerweb.com` | UNI-SMOKE-001-step3.txt |
| E4 | api | same response: `dd.env` = `staging (US)` | UNI-SMOKE-001-step3.txt |
| E5 | api | same response: `dd.version` = `c7a2c81d03088885680edebe1bd0e815711c291c` (40 hex characters, counted) | UNI-SMOKE-001-step3.txt |

## Steps taken
1. 21:23:25Z, no role (public URL): GET /health. Done as written.
2. 21:23:26Z: GET /health/ready. Done as written.
3. 21:23:27Z: GET /config.json on the app host. Done as written.

Evidence folder: C:\Users\skhan\Repos\qa-runs\busplanner\runs\2026-11-18-0222-smoke-us-staging

## Data created and clean-up
- None created. Nothing to clean up.

## Problems while running
- None.

## Verdicts (result-verifier)

| E | Verdict | Reason |
|---|---|---|
| E1 | Pass | `UNI-SMOKE-001-step1.txt`: GET /health, status 200, body `Healthy` |
| E2 | Pass | `UNI-SMOKE-001-step2.txt`: GET /health/ready, status 200, body `Healthy` |
| E3 | Pass | `UNI-SMOKE-001-step3.txt`: status 200, `apiUrl` = `https://bpu-us-staging-api.busplannerweb.com` |
| E4 | Pass | `UNI-SMOKE-001-step3.txt`: `dd.env` = `staging (US)` |
| E5 | Pass | `UNI-SMOKE-001-step3.txt`: `dd.version` = `c7a2c81d03088885680edebe1bd0e815711c291c`, 40 hex characters |

Case verdict: Pass

Run concerns: Evidence times have no date (fixed in case-runner: ISO date-times). Evidence is retyped text, not raw output with headers (fixed: `curl -i`).
