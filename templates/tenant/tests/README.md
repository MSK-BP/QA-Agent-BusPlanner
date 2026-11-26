# Test cases

Markdown test cases that the QA agent writes, reviews, runs and reports on. People approve them. One file per case. Git is the history and a pull request (or an approval through `/review-cases`) is the review.

## Layout

```
tests/
├─ <module>/<flow>/<ID>.md   one case (template: templates/cases/CASE.md in the hub)
├─ suites/<name>.md          a named suite: filters and/or case IDs (templates/cases/SUITE.md)
├─ runs/<run-id>/RUN.md      one run: case list, verdict, failures, bugs drafted
├─ runs/<run-id>/<ID>.md     one result per case (templates/cases/RESULT.md)
├─ MATRIX.md                 last verdict of every case (generated)
└─ cases.csv                 every case as a row, for a test-management import (generated)
```

Screenshots and network logs never go in git. They go to the tenant's run folder, `runs/<run-id>/`.

## Life of a case

| Status | Set by | Meaning |
|---|---|---|
| `draft` | `/write-cases` | Written by `test-designer` |
| `reviewed` | `/write-cases`, `/review-cases` | `test-reviewer` checked it and its fixes are in |
| `approved` | A person, through `/review-cases approve` or by editing the file | Counts for runs and sign-off. `approved-by` names the person |
| `retired` | A person | Kept for history, never run |

A person changes an approved case only through a new review. Editing the steps or expected lines sets it back to `reviewed`.

## Rules for a good case

- Every expected line is checkable and names its channel: `- E2 (step 3, sql): ...`.
- One expected result per line. "It works" is not an expected result.
- Every expected result traces to a requirement, a ticket, or a rule in `knowledge/domain.md`. Mark anything else `ASSUMPTION`.
- Data the case creates starts with the tester's prefix (`QA-AUTO-<initials>-`), and Clean-up removes it.
- The lowest channel that can prove a result wins: SQL or API before UI when the UI adds nothing.

## Running cases in parallel

`/run-cases` plans every run in **waves** (`harness\cases.ps1 -Action new-run`). The cases of one wave run at the same time, up to the limit in `tests/parallel.json` (4 without it, or `-MaxParallel`). Two optional fields in the case front matter drive the plan:

| Field | Value | Meaning |
|---|---|---|
| `depends-on` | case IDs, e.g. `[MOD-001]` | Start this case only after those cases passed. Use it when a case needs another case's build, data or end state. |
| `resources` | `kind:name` items, e.g. `[build:MyRepo, device:Tablet-A]` | No other case may hold the same item at the same time. A bare kind (`device`) means any item of that kind. `exclusive` runs the case alone (timing and load cases). |

Without `resources`, the channel gives a safe default: `ui` holds `browser` (one browser), `device` holds `device` (one device), `cli` holds `build` (any build folder). `api` and `sql` cases hold nothing, so they run in parallel unless they declare a resource, for example the same test-data record (`data:<record>`).

**Limits and pools: `tests/parallel.json`** (optional):

```json
{
  "maxParallel": 15,
  "maxParallelByEnv": { "staging": 8 },
  "pools": {
    "browser": ["pw-1", "pw-2", "pw-3", "pw-4", "pw-5", "pw-6", "pw-7", "pw-8"],
    "device": ["Phone-A", "Tablet-B"]
  },
  "limits": { "device": 2 }
}
```

- `maxParallel`: the most cases at the same time. `maxParallelByEnv` lowers it for a shared environment, so a run is never a load test by accident.
- `pools`: a case that needs "a browser" or "a device" gets a free slot by name (`browser:pw-3`), and its runner uses only that one. The browser slots are the headless Playwright connections `pw-1` to `pw-8` in the hub's `.mcp.json`; each is its own isolated browser. A case can also name a slot (`device:Tablet-B`).
- `limits`: an extra cap per kind. The default cap of a pooled kind is its pool size.
- Without the file: limit 4 and one shared browser (`browser:session`).

`harness\cases.ps1 -Action validate` reports a dependency that is not a case, a circular dependency and a badly formed resource. The plan is written to the run's RUN.md (section Plan).

## Commands

| Do | Command |
|---|---|
| Write cases from a plan, a ticket or a feature | `/write-cases <plan file, ticket key or feature>` |
| Review cases, or approve them | `/review-cases <selector>`, `/review-cases approve <selector>` |
| Run a suite or a selection | `/run-cases <suite or selector> [env]` |
| The whole loop for a module or ticket | `/test-module <module or ticket>` |
| List, validate, matrix (no agent) | `harness\cases.ps1 -Action list|validate|matrix` |

Selectors: a suite name, case IDs, or filters such as `module=checkout flow=F2 priority=P1 tag=smoke ticket=PROJ-12`.
