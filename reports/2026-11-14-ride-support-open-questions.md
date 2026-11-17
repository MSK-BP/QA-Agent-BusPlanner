# Ride Support V1: open questions and confusions from QA

Date: 2026-11-14, updated 2026-11-16. Status: **draft, not sent.**
From: QA. To: the product owner and engineering.
Spec: "PRD · Ride Support V1" v0.7 (PE/239108122, PE/241500162). Test plan: `reports/2026-11-14-testplan-ride-support-v1.md`.

This document has two parts:

- **Part 1, Questions:** information that is missing. Somebody must decide or tell us.
- **Part 2, Confusions:** places where two sources disagree, or where the text can be read two ways. Somebody must choose one meaning.

## Summary: answer these five by Friday 20 November

| # | Item | Type | Owner |
|---|---|---|---|
| Q1 | What does "core flows" mean for 18 December? | Question | Product |
| C1 | Withdraw cut-off: "opened" or "taken"? | Confusion | Product |
| Q2 | Where do service days come from? | Question | Engineering |
| Q3 | Where do guardians and the SIS ID come from? | Question | Engineering |
| Q4 | What is the alert-engine contract? | Question | Engineering |

Everything else can wait until the date in its "Answer by" column. A short answer is enough. QA will update the spec tests and the plan.

---

# Part 1: Questions

## 1A. For the product owner

| # | Spec ref | Question | Why QA asks | Answer by |
|---|---|---|---|---|
| Q1 | OQ-1 | Is this the 18 December scope? **In:** F1 setup minimum, F2 web referral path, F3 tablet referral, F4a decision and suspension on the web, F4b Turns door alert with **Allow only**, F5a letters, urgent notice, staff notices, review timers, F7 offline draft and not-riding check under 1 s. **After:** F4c Deny, "Ask the office to call", family opt-out; F5b praise and concern; F6 SIS CSV, history, records PDF, retention; F7 rest. If not, which flows move? See also C3. | The whole plan | 20 Nov |
| Q5 | Q-new-1 | The writer is the only reviewer in range. Nobody decides their own referral (SC-R27). Where does the referral go? | GAP-06 | 24 Nov |
| Q6 | Q193 | May transportation suspend a rider from the bus? | RS-QA-028, 106 | 24 Nov |
| Q7 | Q201 | Which pilot items does go-live need? | The milestone | 24 Nov |
| Q8 | Q-new-3 | After a lift, does the days-off count use the days served or the days planned? | RS-QA-102, 103 | 1 Dec |
| Q9 | Q-new-4 | How do review timers behave across the summer and the year end? | GAP-17 | 1 Dec |
| Q10 | Q-new-5 | What does `Conduct_Enabled` off do to suspensions in force? Does each setting have a range? | GAP-21 | 1 Dec |
| Q11 | Q-new-10 | A driver withdraws offline. The withdraw arrives after a reviewer took the referral. Does the server use the device time or the arrival time? | GAP-07 | 1 Dec |
| Q12 | Q-new-6 | What must the name check catch: a last name alone, any letter case, nicknames, the subject line? | GAP-22 | 8 Dec |
| Q13 | Q52 | What does counsel say on the special-ed check and on concerns? | RS-QA-100; F5b | 8 Dec |
| Q14 | Q127 | Is Deny allowed on runs to school? | F4c, after 18 Dec | — |

## 1B. For engineering

| # | Spec ref | Question | Why QA asks | Answer by |
|---|---|---|---|---|
| Q2 | Q50 | What is the source of service days, and what is the calendar API? | All timers and suspension days (F4a, F5a) | 20 Nov |
| Q3 | Q197 | Where do guardians come from (email, language, "not to receive")? How does the SIS ID carry across school years? | Letters: RS-QA-116, 124, 146 | 20 Nov |
| Q4 | Q198 | What is the alert-engine contract: request, status callbacks, behaviour during an outage? No table exists yet. | Every letter and notice; GAP-09, 11, 12 | 20 Nov |
| Q15 | Q-new-7 | Will the server have a clock that a test can set, and a test trigger for jobs? The repo reads the wall clock in about 50 files today. | Without both, no timer test can run | 20 Nov |
| Q16 | Q-new-8 | Which environment counts as "passed QA" on 18 December: dev or staging? Can QA get a Turns test build and a test tablet or emulator? | Sign-off and the Turns tests | 20 Nov |
| Q17 | Q118, Q119, Q139 | Which calls does Turns make? What is the not-riding list format? Which endpoints give the rider and route scope? | F3, F4b; GAP-05 | 1 Dec |
| Q18 | Q141, Q144 | What happens to a lift while a tablet is offline? Does the first day move when a letter goes late? | RS-QA-052, 123 | 1 Dec |
| Q19 | Q140 | Confirm that nothing goes to Dispatch screens in V1. | RS-QA-058 wording | 1 Dec |
| Q20 | — | Can each Ride Support PR deploy to dev before merge, or only after? | QA tests each flow as it lands | 1 Dec |
| Q21 | — | Can we have a test client with the §7 test district in its own database on dev, with no real people, and the alert engine in sink mode for it (messages captured, never sent)? | QA's agents create referrals and letters on dev | 24 Nov |
| Q22 | — | Does Ride Support write anything to BP Info? Dev and staging point at production BP Info URLs today | A test write must never reach production | 24 Nov |

---

# Part 2: Confusions

## 2A. The spec disagrees with itself

| # | Topic | Source 1 | Source 2 | What QA needs | Answer by |
|---|---|---|---|---|---|
| C1 | Withdraw cut-off (Q-new-9) | SC-R18, SC-R19, TU-R36: the writer may withdraw "until someone opens it" | v0.2 change log, RS-AC-18.2: the cut-off is "taken, not opened" | One rule in the spec. Since 2026-10-19, opening does not take a referral, so the two rules give different results. Example: a reviewer opens a referral and does not take it. Can the driver still withdraw it? It changes RS-QA-113, 114 and GAP-03 | 20 Nov |
| C2 | A letter that bounced (Q-new-2) | SC-R10: the referral "closes when its letter is sent or printed" | — | Does "sent" mean "handed to the alert engine" or "delivered"? If every copy bounced, does the referral close? | 8 Dec |
| C3 | Dec 18 versus "whole flows" | §0.1: "V1 cuts whole flows, never the ends of a flow" | The 18 December date with Deny left out | Confirm that 18 December is a milestone, not V1. Then the §0.1 rule applies to V1 only | 20 Nov |
| C4 | Deny in the milestone | Deny is after 18 December (Q1) | `Turns_SuspendedDenyFromSchool` defaults to on | Confirm that the milestone build hides Deny (GAP-27) | 24 Nov |
| C5 | Year-end cap (RS-EC-26) | §5.3 has the rule | §5.3 marks it "to check with the pilot" | The final rule, or "not in V1" | 1 Dec |

## 2B. Names

| # | Topic | Confusion | What QA needs |
|---|---|---|---|
| C6 | One module, three names | Jira says "Discipline Module" (epics 847, 848, 849 in the PROD project). The spec and the screens say "Ride Support". The code will say `conduct` (`Conduct_*` settings, `cnd:` permissions) | One name for tickets, test cases and reports. QA suggests "Ride Support", with "conduct" in code only |

## 2C. The prototype disagrees with the spec

The connected prototype is a reference, not the spec. QA follows the spec, and has a test for each difference. Please confirm each row, so that developers do not copy the prototype.

| # | The prototype does | The spec says | Spec ref | Status |
|---|---|---|---|---|
| C7 | Opening a referral takes it | Opening does not take it; "Take it" is deliberate | RS-AC-5.2..5.8, decided 2026-10-19 | Settled by the spec |
| C8 | "V1: on" shows routing chains ("step N of M") | V1 has one path with nine statuses, no chains | SC-R19, §2.2 (Q123, Q138) | Settled by the spec. Engineering, please confirm |
| C9 | A referral with an unknown rider and no school goes to "With the school" | No school and no letter until a student is attached | SC-R4 | Prototype defect |
| C10 | The tablet lists all routes and other runs' riders | The server limits the driver to their route scope | TU-R36, RS-AC-T36.8 | Prototype defect |
| C11 | A person can decide their own referral | Nobody decides their own referral | SC-R27 | Prototype defect |
| C12 | A failed email still closes the referral | Unclear (see C2) | SC-R10 | Waits for C2 |
| C13 | The retention settings are never read | Retention applies | SC-R29 (F6) | Prototype gap |
| C14 | A DAY exception still counts as a day off the bus | Days off are service days | RS-AC-9.1 (Q2) | Waits for Q2 |
| C15 | Bulk actions ignore `Conduct_TransportationDecides` | Not stated for bulk actions | — | QA expects the setting to apply. Please confirm |
| C16 | Errors in events, driver messages and reminders are swallowed | Not stated | — | QA expects no failure to be lost silently. Please confirm |
| C17 | The driver sees the other student's first name for "keep apart", and the student's name in the suspended-rider message | The reason never reaches the tablet; the spec does not say if names may | TU-R19 | Is a name on the tablet allowed? |
| C18 | Praise shows "Not opened in 2 school days" in the list | Not stated for Praise | — | Is this wanted for Praise? |
