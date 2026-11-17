---
id: UNI-SMOKE-001
title: The US staging API is healthy and the app reports its environment and build
module: platform
flow: smoke
ticket:
priority: P1
spec: [environments.md]
channels: [api]
roles: []
env: us-staging
data: []
tags: [smoke]
status: reviewed
approved-by:
convert-later: api
---
## Preconditions
- None. The case only reads public health and config URLs.

## Steps
1. Call GET https://bpu-us-staging-api.busplannerweb.com/health.
2. Call GET https://bpu-us-staging-api.busplannerweb.com/health/ready.
3. Call GET https://bpu-us-staging-app.busplannerweb.com/config.json.

## Expected (each line must be checkable)
- E1 (step 1, api): status 200, body `Healthy`.
- E2 (step 2, api): status 200, body `Healthy`.
- E3 (step 3, api): status 200; `apiUrl` is `https://bpu-us-staging-api.busplannerweb.com`.
- E4 (step 3, api): `dd.env` is `staging (US)`.
- E5 (step 3, api): `dd.version` is a 40-character commit hash. Record it as the build.

## Clean-up
- None.

## Notes
- Source: `knowledge/environments.md` ("Which environment you are on"). A different `apiUrl` or `dd.env` means the app points at the wrong back end.
