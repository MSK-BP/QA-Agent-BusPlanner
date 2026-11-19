---
name: run-cases
description: Run markdown test cases (a suite, IDs or filters) against an allowed environment with case-runner agents, have every result judged by result-verifier, triage failures, and write the run report and coverage matrix. Use when the user asks to run test cases, a test suite, or a module's cases.
argument-hint: <suite name, case IDs, or filters like module=x priority=P1> [env] [rehearsal]
---

Run `$ARGUMENTS`.

## 1. Prepare
1. Read `<tenant>/knowledge/environments.md` (hard rules included) and `<tenant>/tests/README.md`. Pick the environment: the one given, else the suite's `env`, else the cases' lowest `env`. It must be allowed. Refuse production.
2. Run `harness\cases.ps1 -Action validate`. Stop on errors in the selected cases.
3. Create the run: `harness\cases.ps1 -Action new-run <selector> -Env <env> -Json`. Add `-Rehearsal` only if the user said "rehearsal": then unapproved cases run too, and nothing counts for sign-off. The JSON gives the run folder, the evidence folder and two lists: `Sequential` (ui or device cases: one browser, one device) and `Parallel` (api and sql only).
4. Get the data prefix: `QA-AUTO-<tester initials>-`. Ask once if you do not know the tester's initials.
5. If the run has ui cases: make sure each environment and role it needs has a fresh saved sign-in in `<run folder>\auth\<env>-<role>.json`. If the tenant's tests README names a scripted sign-in helper, run it for each one (it signs in through the API on non-production environments; you never see the credentials). Otherwise ask the tester to run `harness\save-signin.ps1` and sign in.
6. Record the build under test in RUN.md (`build:`), from the app's `config.json`, a health or version endpoint, or the deployed commit.

## 2. Run
- For each case, start one `case-runner` with: the case file path, the result file path (`<run folder>/<ID>.md`), the evidence folder, the environment, the data prefix, and whether it is a rehearsal.
- `Parallel` cases: up to 4 runners at the same time.
- `Sequential` cases: one at a time, because they share the browser or the device.
- If the environment is down (health check fails, sign-in page appears for every case), stop starting new cases, and mark the rest "Not run: environment" in RUN.md.

## 3. Verify
For each result file, start one `result-verifier` with only the case file and the result file. Copy its table into the result file's Verdicts section, its case verdict into the front matter `verdict:`, and `verified-by: result-verifier`. Do not change a verdict yourself.

Spot-check: for every tenth P1 case that passed, show the user the evidence and ask them to confirm. Record their answer in RUN.md.

## 4. Triage and bugs
1. Give every Fail and Inconclusive case to `failure-triager`, with the case, the result and the evidence. Record its class (product bug, test bug, environment, test data, flaky) and evidence in RUN.md.
2. For each product bug, draft a report with the `/bug-report` steps and list it in RUN.md under "Bugs drafted (not filed)". File nothing without the user's yes.
3. A test bug is a fix to the case: propose it, do not apply it, and never weaken an expected line to make a case pass.

## 5. Report
1. Fill RUN.md: verdict first (green: all Pass; red: any Fail; incomplete: any Blocked, Inconclusive or Not run), totals by verdict, the Verdict column of the case table, failures with class, bugs drafted, cases not run and why, run concerns from the verifier, data left behind.
2. Run `harness\cases.ps1 -Action matrix`.
3. Reply with the verdict, the totals, each failure with its class, and the bug drafts waiting for approval. Link RUN.md.

A case that did not run is "Not run", never "Pass". A rehearsal run is labelled as one everywhere.
