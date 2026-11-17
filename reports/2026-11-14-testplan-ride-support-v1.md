# Test plan: Ride Support (Discipline Module) V1, core flows

Date: 2026-11-14. Target: core flows built and passed by QA on **2026-12-18**. Development has not started.

## Verdict

The spec already holds the main test design: RS-QA-001 to RS-QA-201 in "PRD · Ride Support V1" v0.7 (PE/239108122, PE/241500162). This plan does not rewrite those tests. It does five things:

1. It proposes the Dec 18 milestone (flows F1 to F7).
2. It maps every spec test to a flow, an automation level and a repo.
3. It adds 22 gap cases (RS-GAP-01 to RS-GAP-27, with gaps in the numbering). Most check that the server enforces each refusal, and that the build does not copy the prototype defects.
4. It ranks the top 8 risks.
5. It lists the open questions that block the milestone or an expected result.

Three spec questions block whole flows: Q50 (service days), Q197 (guardians and SIS ID) and Q198 (alert engine). The Turns work is the critical path (spec §2.4). Dec 18 is a milestone, not V1: the spec says "V1 cuts whole flows, never the ends of a flow" (§0.1), and this milestone leaves out Deny at the door.

## Sources

- Spec page 1, v0.7 (version 11 in Confluence): scope §2, path §3, requirements §4, edge cases RS-EC-01..64 §5, screen rules §6, test district §7, tests RS-QA-001..084 and 177..201 §8.
- Spec page 2: tests RS-QA-085..176.
- Prototype walkthrough: `reports/2026-11-13-ride-support-prototype.md`. The spec settles D1 (opening does not take a referral, decided 2026-10-19), D2 (one path with nine statuses, no routing chains, §2.2) and D5 (Close at Transportation is not in V1). D3, D4 and D6 are prototype defects. The gap cases guard all of them.
- `knowledge/conventions.md`, `knowledge/test-strategy.md`, `knowledge/environments.md`, `knowledge/repos/BusPlannerUnified/tests-ci-infra.md`.
- Review: a test-reviewer checked this plan against page 1. Its fixes are applied.

## Scope

### In scope: the proposed Dec 18 milestone

| # | Flow | Requirements | Dec 18? | Reason |
|---|---|---|---|---|
| F1 | Setup minimum: starter roles, work areas, invitations, contacts, reasons, actions, letters, Getting started | SC-R23, SC-R24, SC-R31, SC-R30 | **In.** After: import from a file, Show technical names | Without roles and work areas, no referral can move |
| F2 | Web referral path: 9 statuses, Take it, Take over, Hand to a colleague, Send back, school split and fallbacks, always-on rules, decision (no suspension), + New referral, hand-off log, access log, withdraw, stale page | SC-R19, SC-R5, SC-R27, SC-R8, SC-R22, SC-R29, SC-R18, SC-R16 (access) | **In** | The web is built first, and every flow passes through it |
| F3 | Tablet referral: report at a stop, Mark it, drafts, offline queue, My referrals, New referral within route scope, unknown rider, Incident fields | TU-R18, TU-R36, SC-R3, SC-R4, SC-R34, SC-R1 | **In.** After: spell-check checks | Critical path: every V1 flow starts on the tablet |
| F4a | Decision reaches the bus, web side: seat, keep apart, suspension, service days, special-ed tick, notice days, overlap, lift, suspension log | SC-R9, SC-R25 | **In.** Blocked by Q50 | F4b needs it. Suspension days are service days (RS-AC-9.1) |
| F4b | Turns: instructions beside the rider, not-riding list, alert at the door, Allow only (Deny hidden), tap log, scan notice | TU-R19, TU-R34 (part) | **In** | The door alert is the safety core |
| F5a | Letters through the alert engine: name check, a copy per guardian, print, failed letter, close, the "may ride again" letter; urgent notice; staff notices; review timers | SC-R10, SC-R6, SC-R7 | **In.** Blocked by Q198 and Q50 | A referral cannot close without a letter or "no letter" |
| F7 | Offline draft and not-riding check under 1 s (RS-QA-167) | §6.5 | **In** | Safety |

### After Dec 18, before the pilot

| # | Flow | Requirements | Reason |
|---|---|---|---|
| F4c | Deny (adult check, Undo, late Deny), Ask the office to call, family opt-out | TU-R34 (rest), TU-R50 | With no Deny the child rides (§5.1), so the milestone stays safe. Deny depends on Q127. `Turns_SuspendedDenyFromSchool` defaults to on, so the milestone build must hide Deny (RS-GAP-27) |
| F5b | Praise, concern | SC-R11, SC-R12 | Not needed to close a Problem. Concern needs Q52 |
| F6 | SIS CSV, history across years, records PDF, retention job | SC-R14, SC-R16, SC-R29 (history) | Export is last in §2.4 |
| F7 rest | List speed, 100-tablet reconnect, keyboard only, colour, WCAG audit | §6.5, §6.1 | Load tests need agreement on dev and staging |

### Out of scope (not in V1, spec §2.2)

Routing chains, district-built roles, driver groups, accident package, saved views, seating charts on the web, safety labels, emergency button, empty-bus check, video requests, Behavior by run, notes to the driver, suspension exceptions, parents' app (Chipmunk) letters, anything on Dispatch's screens, driver messages, Close at Transportation, forms by reason, SIS API, grammar checks.

## Risks

| # | Risk | Who it hurts | Guard |
|---|---|---|---|
| 1 | The server trusts the screen: a hidden step succeeds through the API | Students (wrong decider), districts (legal) | GAP-01, GAP-02; RS-QA-003, 007, 017, 018, 024, 025, 084, 108, 112, 175. CI must run the integration tests |
| 2 | Turns is late, or its queue loses or doubles referrals | Pilot go-live; drivers' trust | RS-QA-033, 034 (with GAP-08 extension), 068, 169; GAP-07 |
| 3 | The build copies prototype behaviour (D1, D3, D4, D6) | Recusal, privacy, routing | GAP-03 to GAP-06 |
| 4 | Privacy leak: another student in a letter, a name in a notice, the reason on a tablet | Families; the district (FERPA) | RS-QA-079, 094, 117, 132, 173; GAP-09, GAP-10, GAP-22 |
| 5 | Wrong service-day maths: wrong suspension days or first day | Students kept off the bus wrongly | RS-QA-097, 105, 110, 174; GAP-13, GAP-14, GAP-17. Blocked by Q50 |
| 6 | A failed letter silently closes the referral, or alert-engine errors are swallowed | Families never told | RS-QA-119, 120, 123, 176; GAP-11, GAP-12 |
| 7 | Races: two holders, or overlapping suspensions | Record integrity | RS-QA-021, 107; GAP-18 to GAP-20 |
| 8 | The door alert misses a suspended rider offline, or is too slow | Child safety | RS-QA-048, 051, 053, 167 |

## Open questions

### For the product owner

| # | Question | Blocks |
|---|---|---|
| OQ-1 | Is the milestone above (F1, F2, F3, F4a, F4b, F5a) what "core flows" means for Dec 18? Dec 18 is a milestone, not V1 (§0.1): Deny and Ask the office to call come later | The whole plan |
| Q-new-9 | **The spec contradicts itself on the withdraw cut-off.** SC-R19, SC-R18 and TU-R36 say the writer may withdraw "until someone opens it". The v0.2 change log says RS-AC-18.2 uses "taken, not opened". Which one? | GAP-03, RS-QA-113, 114 |
| Q193 | May transportation suspend from the bus? | RS-QA-028, 106 |
| Q127 | Deny on runs to school | F4c |
| Q52 | Counsel on the special-ed check and concerns | RS-QA-100, F5b |
| Q201 | Which pilot items go-live needs | The milestone |
| Q-new-1 | The writer is the only reviewer in range. Where does the referral go? | GAP-06 |
| Q-new-2 | Does a referral close when every copy of its letter failed? SC-R10 says it "closes when its letter is sent or printed", which is not clear for a bounce | GAP-11 |
| Q-new-3 | After a lift, does the days-off count use days served or days planned? | RS-QA-102, 103 |
| Q-new-4 | How do review timers behave across the summer and the year end? | GAP-17 |
| Q-new-5 | What does `Conduct_Enabled` off do to suspensions in force? Are there ranges per setting? | GAP-21 |
| Q-new-6 | Name-check scope: last name alone, any letter case, nicknames, the subject line? | GAP-22 |
| Q-new-10 | For a withdraw queued offline, does the server judge it by the device time or the arrival time? | GAP-07 |
| RS-EC-26 | The year-end cap is still "to check with the pilot" (§5.3) | RS-QA-105 |

### For engineering

| # | Question | Blocks |
|---|---|---|
| Q50 | The source of service days, and the calendar API | All timers and suspension days; F4a, F5a |
| Q197 | Guardians (email, language, "not to receive"), and the SIS ID across years | RS-QA-116, 124, 146; F5a |
| Q198 | The alert-engine contract, its status callbacks and its outage mode. No table exists yet | F5a; GAP-09, 11, 12 |
| Q118, Q119, Q139 | Turns calls, the not-riding list format, rider and route scope endpoints | F3, F4b |
| Q140 | Confirm nothing goes to Dispatch screens in V1 | RS-QA-058 wording |
| Q123, Q138 | Settled for V1 by §2.2 (no chains). Confirm engineering agrees | D2, GAP-25 |
| Q141, Q144 | A lift while a tablet is offline; the first day moves when a letter goes late | RS-QA-052, 123 |
| Q-new-7 | Will the server have a clock a test can set, and a test trigger for jobs? The repo reads the wall clock in about 50 files | All timer tests |
| Q-new-8 | What is the Turns test framework and emulator? Which environment counts as "passed QA" on Dec 18? | Levels, sign-off |

## Coverage of the spec tests

Repos: **BPU** = BusPlannerUnified (xUnit unit and integration; Jest and React Testing Library with jest-axe). **Turns** = the Apps repo (branch `dev`), not mapped yet. No web UI end-to-end framework exists. Choosing one is a team decision.

Priority changes from the review: RS-QA-035 (RS-EC-05, bus moves while writing), 051 (RS-EC-36, a substitute driver sees the alert), 022 (RS-EC-18, holder's roles end) and 187 (RS-EC-59, two riders with one name) go from P2 to **P1** in this plan.

| Flow | Requirement | Spec tests (RS-QA), P1; P2-3 | Automation level | Repo |
|---|---|---|---|---|
| F1 | SC-R23 people, roles, work area | 022, 149, 150, 151; 152-158 | API (151 scope, 149 invitation, 022 roles end); UI component (150) | BPU |
| F1 | SC-R24, SC-R31, SC-R30 | 159; 160-166 | UI component; API for the change history | BPU |
| F2 | SC-R19 steps | 001, 003-008; 002, 009 | Unit (step table); API (refusals, stale page); UI component (what is offered) | BPU |
| F2 | SC-R5 who reviews | 010, 011, 013-019, 021; 012, 020, 023 | Unit (split ranges); API with alert-engine stub | BPU |
| F2 | SC-R27 always-on rules | 024-026; 027 | API | BPU |
| F2 | SC-R6, SC-R7, SC-R8 | 085, 086, 089, 092-096; 087, 088, 090, 091 | Unit (3 in 30 days, duplicate window); API with a set clock | BPU |
| F2 | SC-R22 | 082, 084; 083 | API and UI component | BPU |
| F2 | SC-R18 withdraw | 113, 114, 115 (count and letter parts) | API; Turns device for the tablet withdraw | BPU, Turns |
| F2 | SC-R16, SC-R29 access and hand-off log | 140, 141, 145 | API | BPU |
| F3 | TU-R18 | 029-035, 038, 039; 036, 037, 040 | Turns device; 034 also API (replayed send) | Turns, BPU |
| F3 | TU-R36 | 041, 043-045, 182-187; 042, 188-190 | Turns device; 186 API | Turns, BPU |
| F3 | SC-R1, SC-R3, SC-R4, SC-R34 | 064, 066, 068-074, 076, 079, 080; 063, 065, 067, 075, 078, 081 | Unit (field merge); API; Turns device. The CSV checks in 064, 079 and 081 move to F6 | BPU, Turns |
| F3 | SC-R43 | 181; 177-180 | Manual; 181 by network capture | Turns |
| F4b | TU-R19 | 046-050, 051, 052 (warning from the old list only); — | Turns device; 049 by device storage | Turns |
| F4b | TU-R34 (part) | 053, 057, 061 (alert and log only); 059, 062 | Turns device; log rows through the API | Turns, BPU |
| F4c | TU-R34 (rest), TU-R50 | 052 and 061 (Deny, Undo parts), 054-056, 058, 060, 191-195, 197-199; 196, 200, 201 | Turns device, API | After Dec 18 |
| F4a | SC-R9, SC-R25 | 028, 097, 100, 102, 103, 106-108, 110-112; 098, 099, 101, 104, 105, 109 | Unit (service-day maths); API; UI component | BPU |
| F5a | SC-R10 | 116-120, 122-124; 121 | Unit (name check); API with stub; manual PDF review | BPU |
| F5b | SC-R11, SC-R12 | 077, 125, 126, 131, 132, 134; 127-130, 133, 135 | API | After Dec 18 |
| F6 | SC-R14, SC-R16, SC-R29 | 136, 137, 139, 142, 146; 138, 143, 144, 147, 148; CSV parts of 064, 079, 081, 115 | Unit (golden-file CSV); API | After Dec 18 |
| F7 | §6.5, §6.1 | 167-170, 172, 173, 175; 171, 174, 176 | Turns device timing (167); API performance (168); reconnect harness (169); jest-axe and manual colour check (170, 172); API with stub (173, 175) | BPU, Turns |

**Gate gap:** CI does not run the integration tests; they run only on a developer's machine (`test-strategy.md`). Every "sent straight to the server" test lives there. Until a pipeline runs them, record those tests as "not run" on each PR.

## New cases (gaps in the spec tests)

Names are the spec's §7 test district. Removed after review: GAP-15 (= RS-QA-105), GAP-16 (= RS-QA-174), GAP-26 (no bulk endpoint ships in V1). GAP-05, GAP-08 and GAP-11 extend a spec test.

| ID | Covers | Type | P | Given | When | Then | Level |
|---|---|---|---|---|---|---|---|
| RS-GAP-01 | SC-R19 "no" steps, IC-4, D5 | Negative | 1 | Ben's referral in each status | Admin 1's token sends each step the table marks "no" straight to the server: any to Draft, an unfinished Draft to Sent, Sent to Decided, Sent to the school to Sent (system only), and a "Close at transportation" step | Each is refused. Status, log and notices do not change (extends RS-QA-003, 009) | Unit, API |
| RS-GAP-02 | SC-R5 holder, SC-R23 | Permission | 1 | Oak AP 1 holds Ben's referral | Oak AP 2 sends decide, send back, withdraw and hand-on with no Take over. Viewer 1 sends Take it and a comment | All refused. Oak AP 1 still holds it | API |
| RS-GAP-03 | D1, SC-R5, SC-R18 | Regression | 1 | Ben's referral Sent at 7:32 | Transportation 1 opens it at 7:38 and adds a comment | The comment does not take it: no holder, no "Taken by", the log shows no "taken". Whether Lee may still withdraw depends on Q-new-9 | API |
| RS-GAP-04 | D3, SC-R4 | Regression | 1 | `Conduct_FirstReview` is the school | Lee sends "A rider I don't know: boy in a red jacket" from Run 15A. Then "Send to the school" and a letter go straight to the server | It waits at transportation and never shows "Sent to the school". Both requests are refused | API |
| RS-GAP-05 | D4, TU-R36, SY-22 | Regression | 1 | Lee's scope is `OwnRoutes` | Lee's token asks for Run 30A's riders and searches for ID 100107 | No response holds Run 30A or Tess (extends RS-QA-186 to the API) | API |
| RS-GAP-06 | D6, SC-R27 | Regression | 1 | Oak Elementary split: Oak AP 1 A-L, Oak AP 2 M-Z. School first. Oak AP 1 writes a web referral about Ben | Oak AP 1 sends Take it, a decision, and a hand-on to self | Each is refused by the server. Where it goes: Q-new-1 | API |
| RS-GAP-07 | SC-R18, prototype risk 6 | Edge | 1 | Ben's referral Sent at 7:45. Bus 42 loses signal at 7:48 | Lee taps Withdraw at 7:50 (queued). Transportation 1 takes it at 7:55. Signal returns at 8:00 | The server refuses the withdraw. Status is With transportation. The tablet shows "Being reviewed". The log has no withdraw row. Open: Q-new-10 (device time or arrival time) | Turns device, API |
| RS-GAP-08 | RS-EC-02 | Edge | 1 | Lee sends offline | The queue retries 5 times with replies dropped, then once more after an app restart | One referral, one "sent" row, one notice each to Transportation 1 and Supervisor 1 (extends RS-QA-034) | API, Turns device |
| RS-GAP-09 | IC-7, §6.2, extends RS-QA-173 | Data | 1 | Alert-engine stub. Omar suspended. "Weapon" about Ben. Lee's draft unsent for 48 h. A referral unopened for 2 school days | Every staff notice kind fires: new, urgent, morning, not opened, returned, draft 24 h and 48 h, taken over, handed on, roles ended, suspended scan | No subject or body holds a student's name, SIS ID or the reason text | API, stub |
| RS-GAP-10 | SC-R27, TU-R19, TU-R36 | Data | 1 | Ben decided "Keep apart from Eve" with the reason "Repeated pushing" | Capture Bus 42's sync payloads: instructions, not-riding list, My referrals | The tablet shows "Keep apart from Eve" (TU-R19) and no payload holds the reason | API payload |
| RS-GAP-11 | SC-R10, RS-EC-38, prototype risk 1 | Negative | 1 | Leo's referral Decided | The letter goes and the stub returns "bounced" for his only guardian | "failed: bounced" with Print instead (RS-AC-10.4). Whether the referral closes: Q-new-2 (extends RS-QA-119) | API, stub |
| RS-GAP-12 | §6.5, RS-EC-41, prototype risk 7 | Negative | 1 | The stub returns HTTP 500 for 10 minutes | Lee sends "Weapon" about Ben. Pine Principal sends Tess's suspension letter | The referral is Sent and listed first. The urgent notice and the letter show "queued" and go once, when the engine returns. Each failure is logged, not swallowed (extends RS-QA-123, 176) | API, stub |
| RS-GAP-13 | SC-R25, SC-R9, Q50 | Edge | 1 | Tess. Her letter is sent Tue 10 Nov at 15:00. `Conduct_SuspensionNoticeDays` is 2 | Pine Dean sets the first day to Thu 12 Nov, then Fri 13 Nov | Thu 12 is refused, with the rule under the field (Wed 11 has no service). Fri 13 is accepted. With calendar days Thu 12 would pass, so this case tells the two methods apart | Unit, API |
| RS-GAP-14 | SC-R19, SC-R25 | Data | 1 | Ava has 8 days. A 3-day suspension is saved (11) | Elm Principal changes it to 1 day | Ava's count of days off shows 9, not 12 or 11 (count only; the change itself is RS-QA-006) | Unit |
| RS-GAP-17 | SC-R7, Q50 | Edge | 2 | Ben's referral Sent to the school Thu 3 Jun 2027, unopened | The clock runs through the summer | No return during the summer. The return day in the next year: Q-new-4 | Unit with clock |
| RS-GAP-18 | RS-EC-17, SC-R18 | Concurrency | 1 | Ben's referral Sent to Oak Elementary, no split | 20 parallel Take it calls from Oak AP 1 and Oak AP 2. Separately: Lee's Withdraw and Transportation 1's Take it in the same second | Exactly one wins each race. The others are refused with the holder's name. One log row (load extension of RS-QA-021) | API, parallel |
| RS-GAP-19 | SC-R25 | Concurrency | 1 | Tess has no suspension | Pine Dean and Pine Principal save overlapping suspensions in parallel | One is saved. The other gets "Tess is already suspended through …". Days count once | API, parallel |
| RS-GAP-20 | SC-R19, SC-R5 | Concurrency | 2 | Transportation 1 holds Ben's referral | Supervisor 1 takes it over at the same moment that Transportation 1 records an action | Only one stands. The other gets "This referral changed: open it again" (race form of RS-QA-008) | API |
| RS-GAP-21 | `Conduct_Enabled`, prototype risk 8 | Edge | 1 | Omar suspended through Thu 12 Nov. Ben has a seat instruction | Admin 1 sets `Conduct_Enabled` off on Tue 10 Nov | The effect on open instructions shows before saving, and none ends silently (Q-new-5). The change history records old and new | API, UI component |
| RS-GAP-22 | SC-R10 name check | Negative | 1 | A referral naming Ben and Omar. Omar's letter | The body holds "Adams", "ben" or "BEN ADAMS", or the subject holds "Ben". Each is sent through the UI and straight to the server | Each is refused: "This names another student. Take the name out." (scope: Q-new-6) | Unit, API, UI component |
| RS-GAP-23 | SC-R16 retention, prototype risk 2 | Data | 2 | Clock in 2026-27. A Problem from 2020-21 and 2021-22; an Incident from 2020-21 and 2018-19 | The scheduled job runs with no user request | The 2020-21 Problem and the 2018-19 Incident are removed. The others stay. Each removal is logged with no name. With `Conduct_RetentionYears` 6, the 2020-21 Problem stays | API with job trigger |
| RS-GAP-24 | SC-R16 access log | Data | 2 | Ben's referral | Oak AP 1 reads it through the API only. Admin 1 exports | Both are logged with who and when | API |
| RS-GAP-25 | D2, SC-R19 | Regression | 2 | — | Read the status values that the API and the list filters expose | The nine statuses, plus the concern and praise states that SC-R19 names. No "step N of M" | Unit |
| RS-GAP-27 | TU-R34, RS-EC-30, milestone safety | Negative | 1 | The Dec 18 build. `Turns_SuspendedDenyFromSchool` at its default (on). Omar suspended | Omar scans on a run from school and on a run to school | No run offers Deny. The alert lets him ride and the office is told (RS-QA-057's notice goes). The tap is logged | Turns device, API |

## Test approach

**Decision (QA lead, 2026-11-16): no new automation framework before Dec 18.** QA runs the tests agentically with the QA Agent hub. Design: `reports/2026-11-16-agentic-test-approach.md`.

| Who | What | How | When |
|---|---|---|---|
| Developers | Unit tests: step table (SC-R19), service-day maths, name check, school split ranges, 3-in-30 and duplicate windows, field merge, CSV rows. Component tests for each screen | Their normal tests in BPU (xUnit, Jest). Part of each story's definition of done. The agent reviews them with `/pr-qa` | With each story |
| QA agent, browser | What each role sees and can do; the web path end to end | Case files run by `case-runner` through Playwright, checked by `result-verifier` | When the flow lands on dev |
| QA agent, API | Every "sent straight to the server" refusal, scope, holder rules, races: GAP-01..06, 18..24 | Case files run through a guarded API helper on dev | Daily and nightly |
| QA agent, SQL | The oracle for status, holder, logs and letter counts | `harness/sql.ps1`, read-only | In every case that names it |
| QA agent with a person | Turns: report at a stop, Mark it, offline queue, door alert, GAP-07, 08, 27 | Agent-guided manual on a tablet, server side checked by API and SQL | When a Turns test build exists (Q-new-8) |
| Person | Spell check, letter PDF review, colour simulation | Manual | Before Dec 18 |

In the coverage table above, the "Automation level" column now names the channel: "API" means the agent's API channel, unless a developer covers the case in an integration test. After Dec 18, stable cases are converted into code for the BP Unified framework.

## Test data and environment

- **Seed:** the §7 test district as a `QA-AUTO-` district on dev. Use staging only for final checks, and never with real email. Staging holds real customer data, and dev is not isolated from real customer systems (`environments.md`). Give each data-changing test a fresh copy.
- **Calendar:** 2026-27 school year with no service on Wed 11 Nov 2026. Clocks go back Sun 1 Nov 2026 (US Eastern). Last service day Fri 4 Jun 2027. A 2027-28 start date.
- **Earlier years:** a 2025-26 history for Ben, re-keyed at rollover (RS-QA-146). Records from 2018-19, 2020-21 and 2021-22 for retention (GAP-23).
- **Clock control:** a server clock that a test can set, and a test trigger for the reminder, review and retention jobs (Q-new-7). Do not copy the prototype, which runs its jobs on each request.
- **Alert-engine stub:** captures each message, one record per recipient, and can inject bounce, HTTP 500 and outage. Nothing may reach a real inbox.
- **Turns:** two tablets or emulators, network on and off, mocked GPS and speed, card-scan injection, app restart mid-queue, and a 100-tablet reconnect harness (RS-QA-169).
- **Accounts:** one per §7 person. Drivers need both `OwnOperator` and `OwnRoutes` scope. No dev accounts exist yet.
- **Performance:** a synthetic district of about 1,100 buses on dev for RS-QA-168. CA dev shares infrastructure with CA staging, so agree the load first.

## Schedule (proposed)

| Week | Dev (§2.4 order) | QA |
|---|---|---|
| 17-20 Nov | F1 setup | Seed district, stub, clock; answers to OQ-1, Q-new-9, Q50, Q197, Q198 |
| 23-27 Nov | F2 web path | Unit and API tests for F1 and F2; GAP-01..06 |
| 30 Nov-4 Dec | F3 tablet; F4a | Turns device tests; GAP-07, 08, 13, 14, 18, 19, 21 |
| 7-11 Dec | F4b door; F5a letters | Door, letters, privacy: GAP-09..12, 22, 27 |
| 14-18 Dec | Fixes | Full P1 run on staging; sign-off report |
