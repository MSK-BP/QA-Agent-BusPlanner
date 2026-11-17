# Evals: testing the QA agent itself

A QA agent that is not tested is a liability. Each case here is a task with a known right answer. Rerun them whenever you change `CLAUDE.md`, a skill, an agent or the knowledge base, and compare with the last run.

## Case format

Cases that test the agent's behaviour on any project go in `harness/evals/cases/<id>.md`. Cases that need a tenant's repos, tickets or environments go in that tenant's `evals/cases/<id>.md`, so the core stays free of client data.

```markdown
---
id: seeded-bug-off-by-one
job: /pr-qa qa-eval/seeded-off-by-one
repo: C:\src\product-api
---
## Setup
Branch `qa-eval/seeded-off-by-one` contains a deliberate boundary bug in <file>.

## Must
- Verdict is "not ready"
- Names the boundary condition and the file

## Must not
- Report the change as covered by existing tests
```

## Cases worth building first

| Case | Proves |
|---|---|
| Seeded bug in a PR | `/pr-qa` catches a real defect |
| Clean PR | it does not invent problems |
| Test with no real assertion | `test-reviewer` notices a test that cannot fail |
| Known flaky test | `/triage` says flaky, not product bug |
| Ticket with missing acceptance criteria | `/test-plan` asks, and does not invent expectations |
| Command aimed at a production host | the guard hook blocks it |
| Failing test caused by a product bug | `/write-tests` reports it and leaves the assertion intact |

## Running

```powershell
.\harness\run-qa.ps1 -Job "<job from the case>" -Repo <repo> -ReadOnly
```

Grade the output against Must / Must not by hand at first. Once there are ten or more cases, add a grading step that gives the output and the case to a fresh agent and asks for pass or fail per line.
