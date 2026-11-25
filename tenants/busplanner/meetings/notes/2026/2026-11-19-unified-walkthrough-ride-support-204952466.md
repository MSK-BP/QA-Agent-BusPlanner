# BusPlanner Unified Walkthrough: Ride Support (2026-11-19)

- **Recording:** https://fathom.video/calls/906690734
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Ride Support (Discipline), Forms engine, Release and branching, GPS+ Live Viewer, Chatbot

## Decisions

- Ride Support (and Dispatch) V1 target moves from end of year to **early January** — owner: Tommy Zwirblia — stated — [28:17](https://fathom.video/calls/906690734?timestamp=1697)
- V1: all communication with parents, and alerts between transportation and schools, are manual and offline; nothing goes to Chipmunk — owner: Tommy Zwirblia — stated — [02:30](https://fathom.video/calls/906690734?timestamp=150)
- One form engine: every product (Discipline, Inspection, Workflow) sits on the same form builder and workflow service; a submission goes to one form-submission table, then to the module's processing — owner: Tommy Zwirblia — stated — [19:00](https://fathom.video/calls/906690734?timestamp=1140), [21:00](https://fathom.video/calls/906690734?timestamp=1260)
- Inspections port as they are today; Workflow gets a new user experience on the same engine — owner: Tommy Zwirblia — stated — [22:21](https://fathom.video/calls/906690734?timestamp=1341)
- Ride Support is a new module priced per bus per month (commercial detail not recorded) — owner: Umar Mir — stated — [17:21](https://fathom.video/calls/906690734?timestamp=1041)

## Positions and concerns

- **Suspension start date:** Marty Miller asks for a default of the next day to save clicks. Matthew Hayes prefers no default so the user must choose. Lauri-Ann Turnbull notes a same-day start is sometimes needed and suggests a default by time of day. Outcome: action for Tommy Zwirblia to decide (require a date, no default) in the PRD — tentative — [15:37](https://fathom.video/calls/906690734?timestamp=937), [16:05](https://fathom.video/calls/906690734?timestamp=965), [16:44](https://fathom.video/calls/906690734?timestamp=1004)
- **Who may message families:** Lauri-Ann Turnbull notes that in some provinces drivers never contact parents. Matthew Hayes: role-based tick-box permissions, modelled on Fleet, let the district control each action — [10:15](https://fathom.video/calls/906690734?timestamp=615), [10:40](https://fathom.video/calls/906690734?timestamp=640)
- **V1 must-haves:** Josh Rice: basics first are acceptable if the roadmap is visible. Tommy Zwirblia: align the feature list with Josh, Gus and Marty to avoid a blocking gap — [14:25](https://fathom.video/calls/906690734?timestamp=865), [14:37](https://fathom.video/calls/906690734?timestamp=877)
- **Form builder in V1:** Tommy Zwirblia wants a customer form builder with versions in V1, at a lower priority than core functions — tentative — [18:00](https://fathom.video/calls/906690734?timestamp=1080)
- **Quality:** Umar Mir wants high velocity with Claude but quality first; Tommy Zwirblia: no shortcuts in this foundation — [28:46](https://fathom.video/calls/906690734?timestamp=1726)

## Rules and facts (prototype as shown)

- Driver on Turns: quick referral mid-run (student, reason such as "out of seat"); a counter reminds the driver; details (what happened, action taken) are finished later and sent — stated (prototype) — [03:33](https://fathom.video/calls/906690734?timestamp=213)
- Routing chain is set in Settings › Ride Support: steps by role; when a step reaches several people, the first to open it handles it; unopened for one school day, it moves on; the school step returns to transportation if unopened — stated (prototype) — [03:33](https://fathom.video/calls/906690734?timestamp=213)
- Supervisor actions: pass on, close at transportation, withdraw. School actions: decide, send back, withdraw — stated (prototype)
- Decisions (for example a 3-day bus suspension) are customisable; a decision sends a message to the driver's tablet — stated (prototype)
- Video request: a flag plus status tracking only; no link to camera vendors — stated — [11:43](https://fathom.video/calls/906690734?timestamp=703)
- Starter referral types: Problem, Incident, Concern, Praise; each district can add or remove types (rows in a table) — stated — [25:00](https://fathom.video/calls/906690734?timestamp=1500)
- Discipline records attach to the one New World student list — stated — [26:40](https://fathom.video/calls/906690734?timestamp=1600)
- GPS+ pushed to production the night of 2026-11-18; one or two HRCE enhancements and a Landmark bug fix remain — stated — [26:47](https://fathom.video/calls/906690734?timestamp=1607)

## Plans

- PLANNED (not V1): parent/school notifications through Chipmunk, suspended-student scan alert on the tablet, photo/video attachments, purge of closed referrals after a set time (for example 60 days), link from a referral to an inspection report — tentative — [08:43](https://fathom.video/calls/906690734?timestamp=523), [13:01](https://fathom.video/calls/906690734?timestamp=781), [14:05](https://fathom.video/calls/906690734?timestamp=845), [23:27](https://fathom.video/calls/906690734?timestamp=1407)

## Defects and risks

- Risk: V1 date moved; scope still being aligned with sales/CX — [14:37](https://fathom.video/calls/906690734?timestamp=877)

## Open questions

- Suspension start date: required with no default, or a time-of-day default?
- Is the customer form builder in V1?
- Is the routing chain fully configurable in V1, and is the escalation timer one school day?

## Differs from knowledge base

- V1 release early January vs `knowledge/domain.md`: "Core flows must be built and pass QA by **2026-12-18**" — updates (the 2026-11-13 meeting already called 2026-12-18 a dev-complete target)
- Prototype routing: configurable chain, unopened for **one** school day moves on vs `knowledge/confluence-prd.md`: "A report unopened for Conduct_ReviewDays school days (default 2) escalates", and Ride Support V1 is "one path from two settings and starter roles instead of routing chains" — contradicts (prototype demo, not a spec change)
- V1 sends nothing to families or Chipmunk vs `knowledge/domain.md`: users include "families (letters only)" — updates
- GPS+ in production since 2026-11-18 — absent from `knowledge/` (status)

## Confirms

- Referral types Problem, Praise, Concern, Incident — `knowledge/confluence-prd.md`
- Suspended-scan alert on Turns is a specified feature — `knowledge/confluence-prd.md` (not V1 per this meeting)

## Action items

- [ ] Decide the suspension start-date behaviour (require date, no default); record in the PRD — owner: Tommy Zwirblia — [15:26](https://fathom.video/calls/906690734?timestamp=926)
- [ ] Review Drew Weeks's V1 feature list with the technical team; then align with Josh, Gus and Marty — owner: Tommy Zwirblia — [14:37](https://fathom.video/calls/906690734?timestamp=877)
