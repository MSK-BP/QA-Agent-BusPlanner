# Repo map: QA_Automation (Old World Fleet UI tests)

> Read 2026-11-17 from `C:\Users\skhan\Repos\QA_Automation` (Azure DevOps `Managed/_git/QA_Automation`, branch `main`). Static reading only: the suite was not run.

## Verdict for QA

This is the only existing QA automation found at BusPlanner. It is a small Playwright suite for **Old World Fleet** (work orders and purchase orders) on the QA2 site of client 1230. It does not cover BusPlanner Unified or Turns, so it gives Ride Support nothing to reuse except the house style (JavaScript, page objects, JUnit output to Azure DevOps).

## Facts

| Item | Value |
|---|---|
| Stack | Playwright Test 1.52 (JavaScript), Node 22, Chromium only |
| Layout | `tests/*.spec.js` (5 specs), `pageobjects/` (page objects incl. work-order tabs), `helpers/` (login, work order), `data/testData.json` |
| Size | 46 tests: login 4, work order create 5, open work order and calculations 35, purchase order 1 |
| Target | `1230webqa2.busplannerweb.com` (Old World QA2, client 1230). Not yet an approved environment in `environments.md` |
| Config | 40 s per test, 40 min global, `retries` 1 in CI, trace on first retry, screenshot and video on failure; HTML locally, HTML plus JUnit in CI |
| CI | `azure-pipelines.yml`, trigger `main`, Windows agent; publishes the HTML report and JUnit results. Pipeline `QA_Automation`, last run 2026-02-11, succeeded |
| History | 190 commits, 2025-05-29 to 2026-07-23. Authors: Yusra Abbasi, `dev1`, Mitchell Bland |
| README | Template text only |

## Security finding

`data/testData.json` holds a QA2 user name and password in clear text, in 30 commits of history. Raise with the repo owner; never copy the values. Do not reuse that login for the agent: use a `QA-AUTO-` account from the secret store instead.

## Relevance to the test approach

- Confirms the team already accepts Playwright and Azure DevOps test publishing. In Track 2 (when Track 1 is stable), approved Ride Support cases can convert into a Playwright suite in the same style (`reports/2026-11-16-agentic-test-approach.md`, section 12).
- Data creation (work orders) has no clean-up step and no `QA-AUTO-` prefix.
