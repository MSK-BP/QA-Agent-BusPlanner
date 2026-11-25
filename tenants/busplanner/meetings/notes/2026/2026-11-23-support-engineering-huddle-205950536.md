# Support and Engineering daily huddle (2026-11-23)

- **Recording:** https://fathom.video/calls/909167338
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Release and branching, Old World defects, QA process and priorities, Forms engine

## Decisions

- Final 2026 main release is 13.5.2 in the week of 2026-12-14, aiming at **2026-12-15** (a Newfoundland workflow item is due 12-15); the 2026-12-22 release is removed; two bugs wanted before year end are pulled into it — owner: Nikki Tilano; agreed by Chris MacLeod, Amanda McInnis, Andy Tompkins — decided — [18:47](https://fathom.video/calls/909167338?timestamp=1127), [22:43](https://fathom.video/calls/909167338?timestamp=1363), [23:24](https://fathom.video/calls/909167338?timestamp=1404)
- SPT-1006 (Toronto report sharing): a workaround exists and the customer accepts it; the fix waits for a later release — owner: Andy Tompkins — decided — [04:02](https://fathom.video/calls/909167338?timestamp=242), [04:39](https://fathom.video/calls/909167338?timestamp=279)
- The CX enablement sessions: Nikki Tilano's "How Product and Engineering Works" goes first; the second session is shortened to a RACI workshop with a smaller group if the two overlap — owner: Amanda McInnis, Nikki Tilano — tentative — [17:41](https://fathom.video/calls/909167338?timestamp=1061), [18:30](https://fathom.video/calls/909167338?timestamp=1110)

## Positions and concerns

- **December 22 release:** Nikki Tilano: few developers and support people online, schools on holiday, so a break has no one to fix it. Chris MacLeod: customers would not respond anyway. Amanda McInnis would rather wait for January. Murtaza Khalil: only the Newfoundland items are affected by moving 12-08 to 12-15 — [18:47](https://fathom.video/calls/909167338?timestamp=1127), [20:49](https://fathom.video/calls/909167338?timestamp=1249), [21:28](https://fathom.video/calls/909167338?timestamp=1288), [23:11](https://fathom.video/calls/909167338?timestamp=1391)
- **Ticket 963 (district admin sees other districts' routes):** Andy Tompkins first read "operator" as an operator user; it is a district user running a report by operator. Expected: the report shows routes of that district AND that operator; today it may be an OR. Amanda McInnis expects other consortiums to see it. The ticket prefix is unclear (spoken "963"; summary "SPT 963"; action item "SBD-963") — [06:21](https://fathom.video/calls/909167338?timestamp=381), [06:54](https://fathom.video/calls/909167338?timestamp=414)
- **SPT-997 (intermittent, Chipmunk-related):** Andy Tompkins worries it is slow to fix because it turns bad over time and needs to reproduce. Amanda McInnis suggested an upgrade; the customer is on 13.4.2 (spoken "13.42"), after the school-opening fixes — [08:30](https://fathom.video/calls/909167338?timestamp=510), [09:09](https://fathom.video/calls/909167338?timestamp=549)

## Rules and facts

- A district-permission user who runs a route report by operator must see only routes in their own district for that operator — stated (expected behaviour, ticket 963) — [06:54](https://fathom.video/calls/909167338?timestamp=414)
- Workflow forms are custom per customer and today only developers change them; the goal is that Projects and senior Support staff make small changes — stated — [14:03](https://fathom.video/calls/909167338?timestamp=843), [14:39](https://fathom.video/calls/909167338?timestamp=879)
- Maricar wrote QA documentation on how to test workflow forms; it is to be shared with CX — stated — [12:40](https://fathom.video/calls/909167338?timestamp=760)

## Plans

- PLANNED: workflow-forms enablement session with Janice (Thursday morning) — decided — [12:07](https://fathom.video/calls/909167338?timestamp=727)

## Defects and risks

- SPT-1006: Toronto report sharing does not work as expected; workaround in place — [04:02](https://fathom.video/calls/909167338?timestamp=242)
- 963: district admin route report by operator shows routes outside the district — [06:21](https://fathom.video/calls/909167338?timestamp=381)
- SPT-997: intermittent Chipmunk-area defect, customer on 13.4.2 — [07:54](https://fathom.video/calls/909167338?timestamp=474)

## Open questions

- Is ticket 963 in SPT or another project?

## Differs from knowledge base

- 13.5.2 on 2026-12-15 is the last 2026 release; 12-22 cancelled — updates `process.md` (weekly train, no dates); supersedes the 2026-11-20 meeting item (13.5.3 on 12-22)
- SPT-1006, 963 and SPT-997 — absent (`jira/other-projects.md` has none of them)
- Route report by operator must also filter by the user's district — absent (`domain.md` access model has operator and depot grants, no district rule)

## Confirms

- Workflow lives in BP Web as forms and approvals — `domain.md`

## Action items

- [ ] Assign SPT-1006; track the workaround — owner: Murtaza Khalil — [03:51](https://fathom.video/calls/909167338?timestamp=231)
- [ ] Assign 963 and SPT-997 to Michel or Mitch — owner: Murtaza Khalil — [05:08](https://fathom.video/calls/909167338?timestamp=308), [07:43](https://fathom.video/calls/909167338?timestamp=463)
- [ ] Primer for "How Product and Engineering Works" to Amanda McInnis — owner: Nikki Tilano — [17:01](https://fathom.video/calls/909167338?timestamp=1021)
- [ ] Prepare workflow-forms session with Janice; collect CX questions — owner: Nikki Tilano — [12:29](https://fathom.video/calls/909167338?timestamp=749)
- [ ] Update December release plan; pull in 2 bugs; sign-offs — owner: Nikki Tilano — [23:13](https://fathom.video/calls/909167338?timestamp=1393)
