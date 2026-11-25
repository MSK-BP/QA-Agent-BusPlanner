---
run: 2026-11-26-0158-adhoc-local
env: local
build: BusPlannerUnified dev at 114f99a4 (contains PR 1902, squash commit dff1fbc7), checkout %USERPROFILE%\Repos\qa-checkouts\BusPlannerUnified-dev. Rerun of ENG-3306-01, -02, -03, -05 after the triage fixes of run 2026-11-25-2241.
started: 2026-11-26 01:58
rehearsal: no
selection: id=ENG-3306-01 id=ENG-3306-03 id=ENG-3306-02 id=ENG-3306-05
verdict: green
finished: 2026-11-26 02:20
---
# Run 2026-11-26-0158-adhoc-local

Approved cases only. Evidence (screenshots, network logs) is outside git, in `C:\Users\skhan\Repos\qa-runs\busplanner\runs\2026-11-26-0158-adhoc-local`.

## Verdict

**Green: 4 of 4 Pass.** Rerun of ENG-3306-01, -02, -03 and -05 after the triage fixes of run 2026-11-25-2241 (approved by Sharaiz Khan in chat, 2026-11-26). No product bug. Together with that run, ENG-3306 now has 6 of 7 cases passing; ENG-3306-04 stays Blocked (no Turns branch uses the library, open item R10).

| Case | Before | Now | What changed |
|---|---|---|---|
| ENG-3306-01 | Inconclusive | Pass | Step 5 names pipeline 246 and checks build `sourceVersion` = PR `lastMergeCommit` |
| ENG-3306-02 | Fail | Pass | E2 count corrected to `58 of 59` |
| ENG-3306-03 | Fail | Pass | E10 finds the squash commit, not a merge commit. First verification Inconclusive on E8 (em-dash byte check not saved); step 8 re-run with saved bytes, verified again |
| ENG-3306-05 | Blocked | Pass | Timing loop in compiled C#: median 2.3 ms (limit 100); CI 6 ms |

How it ran: runners one at a time (shared build folder); each verifier started as soon as its runner finished, alongside the next runner (pipelined, up to 3 agents at once).

## Cases

| Case | P | Status | Channels | Roles | Title | Result | Verdict |
|---|---|---|---|---|---|---|---|
| [ENG-3306-01](../../forms-engine/general/ENG-3306-01.md) | P1 | approved | cli |  | The shared condition test file runs in full and 57 of 57 cases pass | [result](ENG-3306-01.md) | Pass |
| [ENG-3306-03](../../forms-engine/general/ENG-3306-03.md) | P1 | approved | cli |  | The library has no ASP.NET, EF or MAUI dependency; the API references it; decision and changelog are recorded | [result](ENG-3306-03.md) | Pass |
| [ENG-3306-02](../../forms-engine/general/ENG-3306-02.md) | P2 | approved | cli |  | A case added to the shared test file runs with no code change | [result](ENG-3306-02.md) | Pass |
| [ENG-3306-05](../../forms-engine/general/ENG-3306-05.md) | P2 | approved | cli |  | 10,000 evaluations of a cached condition take under 100 ms | [result](ENG-3306-05.md) | Pass |

## Failures and triage

None.

## Bugs drafted (not filed)

None.

## Not run, and why

None.