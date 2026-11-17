---
run: 2026-11-18-0222-smoke-us-staging
env: us-staging
build: c7a2c81d03088885680edebe1bd0e815711c291c
started: 2026-11-18 02:22
rehearsal: yes
selection: suite smoke
verdict: incomplete
---
# Run 2026-11-18-0222-smoke-us-staging

Rehearsal: unapproved cases included. These results do not count for a sign-off. Evidence (screenshots, network logs) is outside git, in `C:\Users\skhan\Repos\qa-runs\busplanner\runs\2026-11-18-0222-smoke-us-staging`.

## Verdict

**Incomplete (rehearsal).** 1 Pass, 1 Blocked. The API is healthy and US staging serves build `c7a2c81`. The signed-in app check is Blocked: the persisted browser sign-in has expired. This was the first end-to-end run of the case loop; it does not count for a sign-off.

## Cases

| Case | P | Status | Channels | Roles | Title | Result | Verdict |
|---|---|---|---|---|---|---|---|
| [UNI-SMOKE-001](../../platform/smoke/UNI-SMOKE-001.md) | P1 | reviewed | api |  | The US staging API is healthy and the app reports its environment and build | [result](UNI-SMOKE-001.md) | Pass |
| [UNI-SMOKE-002](../../platform/smoke/UNI-SMOKE-002.md) | P1 | reviewed | ui | staging-qa | The signed-in US staging app opens without a sign-in page or console errors | [result](UNI-SMOKE-002.md) | Blocked |

## Failures and triage

No failures. UNI-SMOKE-002 is Blocked (environment: sign-in expired), not failed.

## Bugs drafted (not filed)

None.

## Not run, and why