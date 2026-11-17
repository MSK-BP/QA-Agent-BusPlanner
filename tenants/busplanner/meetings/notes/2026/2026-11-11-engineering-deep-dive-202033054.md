# Engineering Deep Dive (2026-11-11)

- **Recording:** https://fathom.video/calls/896182600
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** GPS+ Live Viewer, GPS+ Path & Stop Compare, GPS+ Route Management, BP Info, Auth, Release and branching

## Decisions

- HRCE tickets go to "Highest" priority so HRCE can move off the old GPS+ — owner: Nikki Tilano — decided — [13:16](https://fathom.video/calls/896182600?timestamp=796)
- Session timeout: interim change from 1 hour to 12 hours in one ticket; a proper token-refresh mechanism in a second ticket, later — owner: Andy Tompkins — decided — [15:50](https://fathom.video/calls/896182600?timestamp=950)
- The 12-hour change goes through the normal release process, not straight to prod — owner: Shikhar Patel — stated — [1:03:53](https://fathom.video/calls/896182600?timestamp=3833)
- ENG-2788: hide waypoints and turnarounds in Path & Stop Compare and Live Viewer now — owner: Tommy Zwirblia — decided — [00:57](https://fathom.video/calls/896182600?timestamp=57)
- New vehicle assignment page mimics the old GPS+ assignment page; writes go to the Old World through BP Info and come back through the substitution import — owner: Andy Tompkins — decided — [57:26](https://fathom.video/calls/896182600?timestamp=3446)
- A vehicle-to-run assignment is applied in the New World by moving the run onto the destination vehicle's existing route; if that vehicle has no route, a new route is made for it. The source route is never moved onto the destination vehicle — owner: Andy Tompkins — decided — [49:00](https://fathom.video/calls/896182600?timestamp=2940)
- Ship HRCE fixes in several promotes; give the customer a delivery date only after design and QA scope are known — owner: Andy Tompkins — decided — [33:49](https://fathom.video/calls/896182600?timestamp=2029)
- The device-to-vehicle mapping page is a follow-up, not a blocker for HRCE's move to the new GPS+ — owner: Andy Tompkins — stated — [27:50](https://fathom.video/calls/896182600?timestamp=1670)

## Positions and concerns

- **Waypoints in Compare and Live Viewer:** Vladislav Derbenev asked whether to delay ENG-2788 and make waypoint display configurable, because some users may want waypoints shown. Tommy Zwirblia held: hide them now, add configuration later. Ahnaf Rahman agreed. Outcome: decided (hide now) — [00:00](https://fathom.video/calls/896182600?timestamp=0)
- **Delivery date for HRCE:** Nikki Tilano pressed for the full scope of work so the customer could be told when the waiting items arrive, delivered over several promotes. Andy Tompkins disagreed with giving a "drop-dead date": first finish the UI design and the list of pieces, then give a date. Outcome: decided (Andy's view) — [32:37](https://fathom.video/calls/896182600?timestamp=1957), [33:49](https://fathom.video/calls/896182600?timestamp=2029)
- **New design or copy of the old page:** Vladislav Derbenev asked whether the vehicle assignment page gets a new design or copies the old page, because a copy will look different from the rest of the New World UI. Andy Tompkins wanted product (Awais Akram) to decide what the UI looks like. Outcome: decided to mimic the old page; no design existed yet — [22:44](https://fathom.video/calls/896182600?timestamp=1364), [24:50](https://fathom.video/calls/896182600?timestamp=1490)
- **Run-level meaning in the Old World:** Michel Walther held that the Old World intent of a run-to-vehicle mapping is unclear (two cases cannot be told apart). In the Old World a run mapping overrides the route mapping without moving the run. Andy Tompkins held that the New World must move the run to the destination vehicle's route. Outcome: decided (Andy's rule) — [29:06](https://fathom.video/calls/896182600?timestamp=1746), [48:29](https://fathom.video/calls/896182600?timestamp=2909)
- **Overlap with Dispatch:** Matthew Hayes was concerned that the run-level assignment page does about 75% of what Dispatch does, so it takes value from Dispatch. Awais Akram said it may be a question of what is sold with what. Andy Tompkins said product, CSMs and leadership must decide the split. Outcome: left open — [39:13](https://fathom.video/calls/896182600?timestamp=2353), [51:06](https://fathom.video/calls/896182600?timestamp=3066)
- **BP Quick as a stop-gap:** Andy Tompkins noted that customers could manage mappings in BP Quick now and use the new GPS+. Awais Akram was concerned that operators use BP Quick for much more (adding vehicles and drivers), so those functions will also need New World equivalents. Andy Tompkins held that Staff Manager is needed in the New World sooner than planned, but is not a blocker for HRCE. Outcome: left open (to be double-checked) — [58:10](https://fathom.video/calls/896182600?timestamp=3490), [58:42](https://fathom.video/calls/896182600?timestamp=3522)
- **Run-level mapping and Dispatch edits:** Matthew Hayes stated that in current Dispatch, buses cannot be changed while a run is in the GPS assignment, so assignment has to be at route level. Outcome: not resolved in the meeting — `summary only` for the rule detail — [04:08](https://fathom.video/calls/896182600?timestamp=248)
- **Session timeout fix path:** Shikhar Patel first tried to patch the timeout directly on the production environment, then said that is not the right way: the right fix is a token refresh, and the interim change must go through the regular release. Andy Tompkins held: 12 hours now, refresh later. Vladislav Derbenev noted that no ticket existed for either. Outcome: decided (two tickets, normal release) — [15:00](https://fathom.video/calls/896182600?timestamp=900), [1:03:46](https://fathom.video/calls/896182600?timestamp=3826)
- **How the gap happened:** Andy Tompkins stated that the team focused on the main GPS+ pages and missed that users must also do the mappings; he asked for repeated checks so that no other requirement is missed. Outcome: follow-up validation call planned — [30:20](https://fathom.video/calls/896182600?timestamp=1820), [1:00:11](https://fathom.video/calls/896182600?timestamp=3611)

## Rules and facts

- HRCE stays on the old GPS+ until the vehicle-to-route/run assignment page exists in the New World — stated — [03:08](https://fathom.video/calls/896182600?timestamp=188)
- New GPS+ is for Canadian customers at this point; US customers move to GPS+ when Dispatch is ready — stated — [03:54](https://fathom.video/calls/896182600?timestamp=234)
- The old GPS+ assignment page supports run-level mapping; the New World is route-centric and a run cannot exist without a route — stated — [01:28](https://fathom.video/calls/896182600?timestamp=88)
- A New World driver change is written only to the New World snapshot and ends with the day; it is not written to the Old World — stated — [23:54](https://fathom.video/calls/896182600?timestamp=1434)
- Turns driver substitutions are run-level and write to the same Old World table the substitution import reads — stated — [40:47](https://fathom.video/calls/896182600?timestamp=2447)
- Assignment data must exist in both worlds: GPS+ runs in the New World, but Chipmunk and Turns talk to the Old World — stated — [57:42](https://fathom.video/calls/896182600?timestamp=3462)
- In the Old World, users find an unmapped route by searching for it and seeing no mapping; there is no "unmapped" list — stated — [53:55](https://fathom.video/calls/896182600?timestamp=3235)
- Routes, runs and vehicles are still created and managed in BP Pro; the new page only maps vehicles — stated — [56:04](https://fathom.video/calls/896182600?timestamp=3364)

## Plans

- PLANNED: proper token-refresh mechanism (second ticket), no target date, owner Murtaza Khalil holds the design details — decided — [1:03:12](https://fathom.video/calls/896182600?timestamp=3792)
- PLANNED: waypoint and turnaround display made configurable later, no target, owner not named — tentative — [00:57](https://fathom.video/calls/896182600?timestamp=57)
- PLANNED: vehicle-to-route and vehicle-to-run assignment page in the New World, no target until design and QA scope are known, owner Andy Tompkins (direction), Awais Akram (UI) — decided — [57:26](https://fathom.video/calls/896182600?timestamp=3446)
- PLANNED: Staff Manager in the New World "sooner than we were thinking", no target, owner not named — tentative — [58:42](https://fathom.video/calls/896182600?timestamp=3522)
- PLANNED: US customers moved to new GPS+ when Dispatch is ready, no target, owner not named — stated — [03:58](https://fathom.video/calls/896182600?timestamp=238)

## Defects and risks

- Live Viewer shows only stop IDs; descriptions needed (ENG-2789, ready for QA) — [05:01](https://fathom.video/calls/896182600?timestamp=301)
- Status column does not sort by lateness (ENG-2880, ready for QA) — [05:38](https://fathom.video/calls/896182600?timestamp=338)
- 1-hour timing offset (ENG-2695) confirmed fixed; buses reported late in the second sample were really late, not the offset bug — [06:24](https://fathom.video/calls/896182600?timestamp=384)
- Path Compare: default range should be today, not last week (SPT-924); open in new tab (SPT-841); SPT-844 stays low — [07:11](https://fathom.video/calls/896182600?timestamp=431)
- Users are logged out every hour (token expiry) — [08:21](https://fathom.video/calls/896182600?timestamp=501)
- Unclear whether BP Info has an API for run-level assignment changes (Vladislav Derbenev to check) — [23:54](https://fathom.video/calls/896182600?timestamp=1434)
- Requirements risk: the mapping page was missed in the GPS+ scope; other requirements may also be missing — [30:20](https://fathom.video/calls/896182600?timestamp=1820)

## Terms

- **Subscription Service vs substitution service**: the meeting summary says "Subscription Service"; the speaker corrected it to the substitution service (import). The Subscription Service is the parent-email service.
- **Planned vehicle vs GPS vehicle**: in the Old World the GPS vehicle is really the GPS device.

## Open questions

- Does the run-level reinterpretation (run moved to the vehicle's route) change what reports and other pages show as the run's route?
- What does the 12-hour change cover: the Unified JWT only, or also BP Info tokens?
- Which assignment functions belong to GPS+ and which to Dispatch (product and packaging decision)?
- Which BP Quick functions (vehicles, drivers) must move to the New World, and when?

## Differs from knowledge base

- Session lifetime: interim change from 1 hour to 12 hours, then refresh tokens vs `knowledge/domain.md` "Auth as built": "one JWT per login, 60 minutes plus 5 minutes clock skew … Refresh tokens are a proposal." — updates (planned change; not built at meeting time)
- ENG-2788 scope: hide waypoints and turnarounds in Path & Stop Compare **and Live Viewer**, configuration later vs `knowledge/jira/eng-2401-2800.md`: "New World GPS+ Stop Compare must exclude stop types "Turnaround Point" and "Way Point" entirely." — updates (wider scope, configurable later)

## Confirms

- ENG-2789 is Ready for QA (stop description instead of stop ID) — `knowledge/jira.md`
- ENG-2880 status sort by lateness — `knowledge/domain.md` (GPS+ Live Viewer rules), `knowledge/jira.md`
- ENG-2695 hour-offset theme — `knowledge/domain.md`
- SPT-924, SPT-841, SPT-844 exist as GPS+ Path Compare backlog items — `knowledge/jira/other-projects.md`
- A run-level substitution moves the run onto the vehicle's route ("a route is what a vehicle does in a day") — `knowledge/domain.md` (GPS+ Route Management, ENG-2738)
- The substitution import pulls from BP Info — `knowledge/domain.md`, `knowledge/architecture.md`

## Action items

- [ ] QA ENG-2789 (stop descriptions) and ENG-2880 (status sort) — owner: Nikki Tilano (assign to QA) — [12:33](https://fathom.video/calls/896182600?timestamp=753)
- [ ] Create the 12-hour ticket and the token-refresh ticket — owner: Nikki Tilano — [15:50](https://fathom.video/calls/896182600?timestamp=950)
- [ ] Check whether BP Info supports run-level assignment changes — owner: Vladislav Derbenev — [23:54](https://fathom.video/calls/896182600?timestamp=1434)
- [ ] Schedule a follow-up call to validate the vehicle assignment strategy and catch missed requirements — owner: Awais Akram — [59:50](https://fathom.video/calls/896182600?timestamp=3590)
- [ ] Test the 12-hour session ticket when it is created; re-check the browser profile note in `environments.md` — owner: QA — [15:50](https://fathom.video/calls/896182600?timestamp=950)
- [ ] Plan tests for the vehicle assignment page (route and run level, BP Info write-back, return through substitution import) once designed — owner: QA — [46:49](https://fathom.video/calls/896182600?timestamp=2809)
