# QA Agent: the agentic test approach for BusPlanner

Date: 2026-11-16, revised 2026-11-17. Status: **plan for team review.** First use: Ride Support V1. Team: two QA testers and the engineering manager.

## Verdict

Test current-sprint work with the **QA Agent** now. Build conventional automation later, on stable work, and let the QA Agent feed it.

1. **The QA Agent is our QA workspace.** It does the complete workflow of a QA engineer at BusPlanner: plan, write cases, run, verify, triage, report bugs and sign off. It is built from skills, sub-agents and a harness, and it is on our work GitHub.
2. **Track 1, now: agentic testing of the current sprint.** Agents write, review, run and report the tests, on the web and on the Turns tablet. People approve the cases, approve the bugs and sign off. Ride Support V1 is the first module.
3. **Track 2, later: conventional automation of stable work.** A Playwright framework covers work from the previous one or two sprints (N-1, N-2), not the current sprint. Its flow is agentic too: agents write and maintain the framework code.
4. **Track 1 leads into Track 2.** The approved cases, run history, product knowledge and lessons from the QA Agent are the input for the framework.

## 1. What the QA Agent is

The QA Agent is not a side experiment. It is the workspace in which a QA engineer tests BusPlanner, with agents doing most of the work.

| Part | What it does |
|---|---|
| Skills | One per QA job: `/test-plan`, `/write-tests`, `/run-suite`, `/triage`, `/bug-report`, `/pr-qa`, `/explore`, `/release-signoff`, `/onboard-repo`, `/learn-domain` |
| Sub-agents | Specialists: `test-designer`, `test-reviewer`, `test-automator`, `failure-triager`, `exploratory-tester`, `code-mapper` |
| Harness | Guard hooks (production is blocked, every action is logged), read-only SQL, Azure DevOps access, signed-in browser |
| Knowledge | BusPlanner domain, architecture, environments, Jira and Confluence digests, a map of each repo |
| Reports | Test plans, run reports, triage notes, sign-offs |

## 2. Two tracks: agentic now, conventional next

| | Track 1: agentic testing | Track 2: conventional automation |
|---|---|---|
| Scope | **Current sprint**: new, changing work | **Stable work** from sprints N-1 and N-2 |
| When | Now, starting with Ride Support V1 | When Track 1 is stable and has the data |
| Tests are | Markdown case files that agents run | Playwright (web), Appium (tablet) and xUnit (API) code in CI |
| Who does the work | QA Agent skills and sub-agents | Agents again: skills, harness and sub-agents that write and maintain code |
| People | Approve cases and bugs, sign off | Review the code pull requests |
| Strength | Ready the day a feature lands; survives UI change | Fast, repeatable regression safety net |

**How work moves from Track 1 to Track 2**

```
 Current sprint            Sprint N-1, N-2 (stable)          Regression in CI
 ───────────────           ────────────────────────          ────────────────
 QA Agent tests it   ──►   Approved cases + run history ──►   Agent writes the
 (agentic, Track 1)        mark a flow as stable              Playwright test
                                                              (Track 2)
```

What Track 2 takes from Track 1:

- **The cases.** Each approved case is a specification. The `convert-later` field says what to turn into code.
- **The evidence.** Run history shows which flows are stable and worth coding.
- **The knowledge.** Domain rules, selectors by role and label, test data and environment quirks.
- **The method.** The same agentic loop, guard rails and human gates. Only the output changes: framework code instead of case files.

## 3. Why no framework for the current sprint

| Reason | Detail |
|---|---|
| Moving target | Current-sprint screens change every week. Coded UI tests break. An agent reads the screen by role and label, so a changed layout does not break the case. |
| Time | A framework for BusPlanner Unified needs weeks before the first useful test. Current-sprint work needs testing now. |
| No base | BusPlanner Unified has no end-to-end or browser tests today (`knowledge/test-strategy.md`). |
| Scope | A framework serves the whole product. It must be designed once, on stable work, not for one module under time pressure. |

Developers still write their own unit and component tests in every story. The QA Agent reviews them with `/pr-qa`.

## 4. Strengths, weaknesses and controls

| Topic | Strength | Weakness | Control |
|---|---|---|---|
| Start-up | Cases run the day a feature lands on dev | — | — |
| Changing UI | Finds controls by role and label | — | — |
| Repeatability | — | Two runs can take different paths | Fixed steps and checkable expected results; the verifier judges only the evidence |
| False pass | — | An agent can claim a pass it did not prove | Verifier agent; evidence for every check; a person spot-checks 1 P1 case in 10 |
| Speed | API and SQL cases run in parallel | A browser case takes minutes | Run API and SQL often; browser cases when their flow changes |
| Cost | Uses our Claude seats | Long runs use seat limits | Cheaper model for the runner, strong model for review and verify |
| Regression | — | No fast safety net in CI | Track 2 |

## 5. The test loop

| # | Stage | Who | QA Agent part | Exists? |
|---|---|---|---|---|
| 1 | Plan | Agent; a tester approves | `/test-plan` | Yes (done for Ride Support) |
| 2 | Write cases | `test-designer` | `/write-cases` | **New** |
| 3 | Review cases | `test-reviewer`, then a person | `test-reviewer` | Yes |
| 4 | Approve cases | **The other tester**, by merging the pull request | Git | Yes |
| 5 | Run | `case-runner` | `/run-cases` | **New** |
| 6 | Verify | `result-verifier`, from the evidence only | — | **New** |
| 7 | Triage | `failure-triager` | `/triage` | Yes |
| 8 | Bug report | Agent drafts; **a person approves** | `/bug-report` | Yes |
| 9 | Report | Agent: run report and coverage matrix | `/run-cases` | **New** |
| 10 | Sign-off | Agent recommends; **people decide** | `/release-signoff` | Yes |

Six of the ten stages exist today. `/test-module <module>` (**new**) runs stages 2 to 9 for one module and stops at each human gate.

## 6. Test cases and results

**Home:** markdown files in the QA Agent repo, at `tests/<module>/<flow>/<case-id>.md`. A pull request is the review. No paid test-management tool for now.

| Option | Cost | Review | Run history | Agent access | Verdict |
|---|---|---|---|---|---|
| **Markdown in the QA Agent repo** | None | Pull request | Run folders in git | Native | **Use now** |
| Jira with Xray or Zephyr | Paid add-on | In Jira | Yes | Slow, through the connector | Possible later |
| Azure Test Plans | Paid per user | In ADO | Yes | Through REST | Possible later |
| Confluence or Excel | None | Weak | No | Weak | No |

Each case keeps its data in front matter, so a script can export all cases to CSV for Xray, Zephyr or Azure Test Plans later.

**One file per case.** Example (`tests/ride-support/F2/RS-QA-012.md`):

```markdown
---
id: RS-QA-012
title: Take it from the transportation list
module: ride-support
flow: F2
priority: P1
spec: [SC-R19, RS-AC-5.4]
channels: [ui, sql]             # ui | api | sql | device
roles: [transportation-1]
env: dev
status: approved                # draft | reviewed | approved | retired
convert-later: ui               # what Track 2 turns into code
---
## Steps
1. As Transportation 1, open the referral list.
2. Open the referral. Do not take it.
3. Select "Take it".

## Expected (each line must be checkable)
- E1 (step 2, ui): status stays "Sent". No holder is shown.
- E2 (step 2, sql): the referral row has no holder.
- E3 (step 3, ui): status "With transportation", "You are reviewing it".
- E4 (step 3, sql): one hand-off log row: taken by Transportation 1.

## Clean-up
- Withdraw the referral with reason "QA-AUTO clean-up".
```

**Results.** Each run writes a folder `runs/<date>-<module>-<env>-<build>/` with `REPORT.md` and one result per case. `tests/<module>/MATRIX.md` shows the last verdict of every case. Screenshots go to a QA folder on SharePoint, not git, because they can show data.

## 7. Execution channels

| Channel | Tool | Use for | Status |
|---|---|---|---|
| Browser | Playwright MCP | What each role sees and can do | Works. Needs one signed-in profile per role |
| API | Test helper | Server refusals, holder rules, scope, races | Read-only today. Needs a guarded write helper |
| Database | `harness/sql.ps1`, read-only | The oracle: status, holder, logs, letters | Works |
| Device | Appium MCP, Android emulator or tablet | Turns cases (F3, F4b) | To build. Needs a Turns test build and a QA quick code (section 7.1) |

Every channel is agentic. No case depends on a person who follows steps by hand.

### 7.1 Mobile and tablet: Turns with Appium

Turns, the driver and crew tablet app, is a .NET MAUI app for Android and iOS (repo `Apps` in the Azure DevOps project `Managed`). It has no UI automation today. Ride Support changes it in F3 and F4b: the door alert, the not-riding list and offline referrals. The agent tests it the same way as the web.

| Topic | Approach |
|---|---|
| Driver | Appium 2 with the UiAutomator2 driver, through an Appium MCP server. The agent drives the tablet as it drives the browser with Playwright MCP. iOS (XCUITest) comes later and needs a Mac |
| Device | An Android tablet emulator on the QA machine first. A real tablet for the P1 sign-off run |
| Build | A debug APK from the `Turns-Android` pipeline. Today that pipeline builds the wrong framework, hides failures and publishes no APK. It needs a fix (P6) |
| Server | A QA quick code that maps to a dev client. Demo quick codes work for screen-only checks without a server |
| Locators | An `AutomationId` on each control that Ride Support adds, so Appium finds it by a fixed id (P7) |
| Card scans | Card readers type into the app like a keyboard. The agent simulates a tap with `adb` text input |
| GPS and offline | Emulator location and the existing `ADB_Location_UI` tool. Airplane mode or network off for offline cases |
| Oracle | The same as the web: the server side through the API and SQL |

Run the highest risks first: the new offline queue for referrals and drafts, and the door alert for a suspended rider.

## 8. Prerequisites from engineering

Testing runs on dev. Agentic runs create and change data there, all prefixed `QA-AUTO-`. These must be ready before the first run.

| # | Need | Why |
|---|---|---|
| P1 | Alert engine in sink mode on dev: messages are captured, never sent | Agents create referrals and letters on dev. A letter must never reach a real family |
| P2 | One test account per role | Role tests |
| P3 | A test clock and a job trigger | Timer and suspension-day cases |
| P4 | Each Ride Support change on dev soon after merge | QA runs each flow as it lands |
| P5 | Confirmation that Ride Support writes nothing to BP Info | Dev and staging point at production BP Info today |
| P6 | A Turns debug APK from a fixed pipeline, and a QA quick code that maps to a dev client | Device cases for F3 and F4b |
| P7 | An `AutomationId` on the Turns controls that Ride Support adds | Stable Appium locators |

## 9. QA Agent changes for Track 1 (not built yet)

| Part | Type | Does |
|---|---|---|
| `/write-cases <plan>` | Skill | Turns a test plan into case files, has them reviewed, opens them as `draft` |
| `/run-cases <selector> [env]` | Skill | Runs cases by module, flow, priority or tag; writes the run folder; calls the verifier and triager; updates the matrix |
| `/test-module <module>` | Skill | The full loop with the two human gates |
| `case-runner` | Agent | Runs one case. Creates `QA-AUTO-` data only and cleans it up. Cannot edit product code or cases |
| `result-verifier` | Agent | Gets the case and the evidence, not the runner's story. Gives a verdict per expected line |
| Templates, matrix, CSV export | Template and script | Case and run report templates; `MATRIX.md` and CSV from front matter |
| Per-role browser profiles | Harness | A person signs in once per role. The agent never types a password |
| `harness/api.ps1` | Harness | Write calls to dev only, `QA-AUTO-` data only, token per role, every call logged |
| Appium MCP and device harness | Harness | Starts the emulator, installs the APK, drives Turns, simulates card scans, GPS and offline |

**Rehearse before the code lands.** Run the F2 cases against the Ride Support prototype before its code lands on dev. Its known defects act as seeded bugs: the runner and verifier must fail those cases. Keep them as evals and run them again when a skill or agent changes.

## 10. How the team uses it

**Access.** The QA Agent is on our work GitHub. It moves into a company-owned home (Azure DevOps or the company GitHub organisation) before the team joins. The guard hooks come with the repo, so every person gets the production block and the audit log.

| Each person needs | Detail |
|---|---|
| A Claude seat with Claude Code | One per person who runs jobs |
| The QA Agent repo | Set-up steps are in its README |
| Their own credentials | Own ADO token, connectors, browser sign-ins. Never share a credentials file |
| Their own data prefix | `QA-AUTO-<initials>-`, so two people do not collide on dev |

| Role | Uses the QA Agent to |
|---|---|
| QA testers (two) | Own the plan and cases, run cases for one flow each, triage, draft bugs. Each reviews and approves the other's pull requests. Recommend go or no-go |
| Engineering manager | Approve this approach, get seats and prerequisites, decide go or no-go from the sign-off report |
| Developers | Run `/pr-qa` before merge; read the run report for their flow |
| Product owner | Answer open questions; read the run reports |

**Rhythm.** One person and one session per flow. Daily: run a flow's cases when its change lands on dev. Nightly: API and SQL cases on dev, triage ready in the morning. Weekly: a full P1 run on the sign-off environment.

## 11. Risks

| # | Risk | Control |
|---|---|---|
| 1 | A false pass reaches sign-off | Verifier, evidence per expected line, human spot-checks |
| 2 | A run on dev sends a real letter or notice | P1 and P5, `QA-AUTO-` data only. Without them, letter cases stay Blocked |
| 3 | Two people collide on dev data | One flow per person; data prefix per person |
| 4 | Seat limits stop a run near a release | Run the full P1 suite well before the release day |
| 5 | No Turns build or quick code in time | Ask now (P6). Emulator first. If still missing when F3 lands, Turns cases stay Blocked and the gap goes to the sign-off |
| 6 | No regression safety net | Track 2 |
| 7 | The QA Agent becomes one person's tool | Both testers use it daily; company-owned repo, a short how-to, every change by pull request |

## 12. Track 2: from the QA Agent to conventional automation

Track 2 starts when Track 1 is stable and has enough approved cases and run history. It covers stable work only (sprints N-1 and N-2).

1. **Choose the framework.** Playwright for the web, xUnit for the API, Appium for Turns (likely with the Appium .NET client), in CI. A team decision.
2. **Build it the agentic way.** The same pattern as the QA Agent: skills, harness and sub-agents. The difference: they write, review and maintain framework code, not case files.
3. **Feed it from Track 1.** Agents convert approved, stable cases into code, guided by `convert-later`. The case stays the specification; a person reviews each code pull request.
4. **Keep both tracks.** Track 1 keeps testing the current sprint, new modules and exploration. Track 2 grows the regression suite as each sprint becomes stable.

## 13. Decisions needed

| # | Decision | Who |
|---|---|---|
| D1 | Agentic testing (Track 1) for current-sprint work, starting with Ride Support | Engineering manager, testers |
| D2 | Conventional automation (Track 2) on stable N-1/N-2 work when Track 1 is stable, fed by Track 1 | Engineering manager, testers |
| D3 | Cases live in the QA Agent repo | Testers |
| D4 | The company-owned home for the QA Agent repo | Engineering manager or admin |
| D5 | Claude seats for both testers | Engineering manager |
| D6 | Prerequisites P1, P5, P6 and P7 | Engineering, Apps owner |
| D7 | The sign-off environment | Engineering manager, product |
