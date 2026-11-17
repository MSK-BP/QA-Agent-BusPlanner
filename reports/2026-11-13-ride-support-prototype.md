# Ride Support (Discipline Module): connected prototype walkthrough

Date: 2026-11-13. Module status: development not started. Core flows must be built and pass QA by 2026-12-18.

## Verdict

The prototype is a usable reference for the core flows, with conditions. Use it for screens, wording and the step engine. Do not use it as the truth where it differs from Ride Support V1 v0.6 (PE/239108122, PE/241500162). The spec wins. Six differences below need a product decision before the test plan is final.

## Evidence

- Source read: `connected-prototype.html` (user's Work Docs folder, 97 MB). The Ride Support back end is the port of `BusPlanner.Conduct`, `server/14-conduct/*`, lines 8874-17500. Line numbers below refer to that file.
- UI checked: in Chrome, served from `http://127.0.0.1:8765/` (a local file server; Chrome's extension does not open `file:` URLs). Data is in-browser only. "Start over" resets it.
- Not run: the prototype's own SelfTest (14594-14762). No product code exists to test.
- Three code claims re-checked by hand: retention settings never read (9524-9525), opening holds the referral (10159-10183), a failed email still closes the referral (10404-10427).

## Two modes

| Mode | What it is | Statuses |
|---|---|---|
| V1: off (default) | Dark UI, user "Transportation reviewer" | Nine statuses, "setup A" |
| V1: on (top bar switch) | Light UI, user "Demo: every step" (District admin), extra tabs: The school, Concerns, Drafts not sent | Routing chains: "In review · step N of M · held by …" (six-status model) |

V1 v0.6 SC-R19 keeps nine statuses. The prototype's V1 mode shows the chain model. **Ask the product owner which one V1 builds (open question Q123/Q138).**

## Core flow as built

| Step | Who | Rule | Code |
|---|---|---|---|
| Referral from the tablet or the web | Driver or crew on the run; web needs `cnd:referral:create` | Same report ID twice gives one report. An Incident with "suspected abuse" becomes a Concern | 44371-44412, 10192, 11723 |
| First routing | System | Concern to contacts, Praise to school, Incident to transportation, others by `Conduct_FirstReview` | 14836 |
| Open | Reviewer | **Opening takes the referral** (status goes Sent to With transportation, "You are reviewing it"). Seen in the UI in both modes | 10159-10183 |
| Review | Transportation | Handle (T05) or Send to the school (T06) | 14876, 14887 |
| Decide | School reviewer | Open (T09), decide (T11). Suspension needs the special-ed gate | 14908, 14917, 14965 |
| Bus instruction | System | Driver sees the district word only, never the reason | 15096-15107 |
| Family letter | Reviewer | Sending the letter closes the referral (T13) | 10383-10435 |
| Withdraw | Writer before first open; reviewer after, with a reason | Withdrawn is final | 14858, 14869 |
| Reopen | Supervisor or admin | Needs a reason | 14944 |

Step table T01..T19 matches the spec. T17 (system auto-send of a draft) exists but nothing calls it, which matches "never auto-sent".

## Prototype vs V1 spec

**Update 2026-11-14:** The V1 spec (page 1, v0.7) settles three of these. D1: "Opening doesn't take it" (§0.2, decided 2026-10-19). D2: V1 has one path and no routing chains (§2.2). D5: Close at Transportation is not in V1 (§2.2). So the prototype is wrong on D1 and D2 (in "V1: on" mode), and D5 is out of scope. D3, D4 and D6 are prototype defects against the spec. The real build must not copy them. The test plan guards each one.

| # | Topic | Spec | Prototype | Evidence |
|---|---|---|---|---|
| D1 | Opening a referral | Taking is deliberate (Take it); opening does not take it (RS-AC-5.2..5.8) | Opening takes it. No "Take it" button | UI, both modes; 10176 |
| D2 | Statuses | Nine (SC-R19) | Nine in V1 off; chains in V1 on | UI |
| D3 | Unknown rider sent to school | Until a student is attached, no school and no letter (SC-R4) | A referral with "A rider I don't know" and "No school found" went to "With the school" | UI, V1 on, as District admin |
| D4 | Driver route scope on New referral | Server limits routes, runs, riders to the driver's route scope (TU-R36, RS-AC-T36.8) | Tablet lists all routes; a run on another route shows its riders and stops | UI, V1 on (submit not tried) |
| D5 | Close at Transportation | Button on the default path (SC-R33) | Only `CLOSE_CALL` on chains; label not in the default UI | 14496, 9502 |
| D6 | Nobody decides their own referral | Always-on rule (SC-R27) | Not checked in StepEngine | 14876, 14917 |

## Risks for the test plan

1. A failed email still closes the referral. No retry path (10404-10427).
2. `Conduct_RetentionYears` and `Conduct_IncidentRetentionYears` are defined and never read (9524-9525).
3. NameCheck covers reviewer text only, and only names of riders on the run and students on the referral. It misses a last name alone, nicknames and a lower-case first name. A name in a letter template only adds a notice (14050-14085, 10345). INFERRED from code.
4. A DAY exception still counts as a day off the bus; only RUN exceptions are subtracted (15242).
5. Bulk actions validate all items then apply, and ignore `Conduct_TransportationDecides` (12414-12446).
6. Tablet withdraw uses separate code: a blank or OTHER reason becomes MISTAKE (44547).
7. Errors are swallowed for events, driver messages and reminders (10631, 10689, 10944, 10985, 11953, 13471, 13701).
8. Saving `Conduct_Enabled` off ends every open bus instruction after one confirm (35723). Setting ranges from the spec are not enforced (35704-35732).
9. Driver-facing names: KEEP_APART shows the other student's first name and last initial (10045); the suspended-rider message names the student (10983). Confirm with the product owner.
10. Praise shows "Not opened in 2 school days" in the list. Check this is wanted for Praise (UI).

## Do not copy into test design

- `Me()` falls back to a default user when no user header is sent (34737).
- Jobs (reminders, escalations, notices) run on each request, not on a timer (10489).
- Simulated email, push and text ("Outbox (simulated)").

## Walkthroughs

The prototype has one guided walkthrough (Dispatch, Chipmunk and Turns, 16 steps). None covers Ride Support.

## Next

Write the core-flow test plan against V1 v0.6, with D1-D6 marked as open until the product owner answers.
