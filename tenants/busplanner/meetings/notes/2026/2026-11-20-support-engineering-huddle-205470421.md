# Support and Engineering daily huddle (2026-11-20)

- **Recording:** https://fathom.video/calls/908095428
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Release and branching, QA process and priorities, Old World defects, Ride Support (Discipline)

## Decisions

- SPT-999 (billing report fails for one of a client's two districts after its SaaS server migration) raised from High to Highest — owner: Chris MacLeod — decided — [04:05](https://fathom.video/calls/908095428?timestamp=245)
- Support staff may point Claude at the source code (company or secured devices only); people stay responsible for every answer, Claude is a tool — owner: Andy Tompkins — decided — [06:45](https://fathom.video/calls/908095428?timestamp=405), [10:20](https://fathom.video/calls/908095428?timestamp=620)
- PROD-486 and PROD-487 stay Medium and unscheduled; product decides priority — owner: Andy Tompkins, Nikki Tilano — decided — [15:38](https://fathom.video/calls/908095428?timestamp=938), [20:05](https://fathom.video/calls/908095428?timestamp=1205)
- Remaining 2026 main releases: 13.5.2 on 2026-12-15 (with some required features) and 13.5.3 on 2026-12-22 (lightest, bug-focused); the first release after the holidays is bug-focused too; avoid large features — owner: Nikki Tilano — stated — [24:21](https://fathom.video/calls/908095428?timestamp=1461)
- ENG-246 and ENG-588 must ship before year end — owner: Nikki Tilano — stated — [24:21](https://fathom.video/calls/908095428?timestamp=1461)

## Positions and concerns

- **Who takes SPT-999:** Murtaza Khalil holds the finance expert (Stephen Hu) is on Discipline, which cannot be pushed, so SPT-999 would wait about a month. Chris MacLeod holds a month is too late for the client's billing. Andy Tompkins holds Discipline comes "from the top" (New Caney, Texas sales) and suggests a first pass with Claude. Outcome: left open; Chris MacLeod tries Claude first, then Engineering assigns someone. (The AI summary says Discipline "may be pushed"; the transcript says it cannot.) — [04:32](https://fathom.video/calls/908095428?timestamp=272), [05:21](https://fathom.video/calls/908095428?timestamp=321), [05:50](https://fathom.video/calls/908095428?timestamp=350), [13:11](https://fathom.video/calls/908095428?timestamp=791)
- **PROD-486 (remove users not in the sync file):** Andy Tompkins holds it does not work for everyone and risks removing valid BP Web users who are not in the file; today an explicit removal file is required. Details are not settled between the consortium and the board — stated — [16:43](https://fathom.video/calls/908095428?timestamp=1003)
- **PROD-487 (match users on employee number, not email):** Andy Tompkins agrees a better identifier than email is right, so an email change updates the user instead of creating a new one; unsure the file carries the employee number — stated — [16:43](https://fathom.video/calls/908095428?timestamp=1003)
- **December capacity:** Nikki Tilano warns many December PTOs leave little cover; a bug in a large feature may find no one to fix it. Andy Tompkins is "not overly concerned" but wants a plan — [23:36](https://fathom.video/calls/908095428?timestamp=1416), [28:15](https://fathom.video/calls/908095428?timestamp=1695)

## Rules and facts

- BP Web user sync today: the file adds and updates users and matches on email; removals need a separate explicit file — stated — [16:43](https://fathom.video/calls/908095428?timestamp=1003)
- An Ontario Ministry report put everyone as "Other" because two required extended properties were missing; the report read the third value as blank without error — stated — [12:17](https://fathom.video/calls/908095428?timestamp=737)

## Plans

- PLANNED: more `.md` files in the repository to direct Claude — owner Andy Tompkins — tentative — [10:20](https://fathom.video/calls/908095428?timestamp=620)
- PLANNED: December coverage plan in an extended sprint refinement — owner Nikki Tilano, Murtaza Khalil, Andy Tompkins — decided — [28:40](https://fathom.video/calls/908095428?timestamp=1720)

## Defects and risks

- SPT-999: finance billing report fails for one district, works for the other; after SaaS server migration; Highest — [03:49](https://fathom.video/calls/908095428?timestamp=229)
- Risk: Ministry report silently classifies students as "Other" when extended properties are missing — [12:17](https://fathom.video/calls/908095428?timestamp=737)

## Open questions

- Who fixes SPT-999, and does it take time from Discipline?

## Differs from knowledge base

- 13.5.2 on 2026-12-15 and 13.5.3 on 2026-12-22, bug-focused year end — absent (`knowledge/process.md` has the weekly train, no dates)
- ENG-246 and ENG-588 must ship by year end vs `knowledge/jira/eng-0001-0400.md` and `eng-0401-0800.md`: both "Open", no priority or date — updates
- SPT-999 Highest — absent

## Confirms

- PROD-486 / PROD-487 content and "Ready for Development" status — `knowledge/jira/other-projects.md`
- Ontario courtesy flag comes from extended properties (ENG-2536) — `knowledge/jira/eng-2401-2800.md`

## Action items

- [ ] Set SPT-999 to Highest — owner: Chris MacLeod — [03:54](https://fathom.video/calls/908095428?timestamp=234)
- [ ] Try SPT-999 with Claude, report back — owner: Chris MacLeod / Andy Tompkins — [13:04](https://fathom.video/calls/908095428?timestamp=784)
- [ ] Tell product and CSM leads about PROD-486/487 — owner: Chris MacLeod — [19:46](https://fathom.video/calls/908095428?timestamp=1186)
- [ ] Year-end coverage plan session — owner: Nikki Tilano — [28:29](https://fathom.video/calls/908095428?timestamp=1709)
