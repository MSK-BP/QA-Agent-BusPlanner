# Engineering Deep Dive (2026-11-24)

- **Recording:** https://fathom.video/calls/911670989
- **Class:** qa-core
- **Source read:** summary + transcript
- **Duplicates skipped:** 206344933, 206344792, 206344380, 206342927, 206341388
- **Areas:** Ride Support (Discipline), Mobile apps, Time & Attendance, Environments and access, Notifications and two-way sync, Dispatch, GPS+ Path & Stop Compare, Ridership

## Decisions

- Discipline markdown (MD) changes: developers review each other; Tommy Zwirblia and Andy Tompkins are added as optional reviewers; every decision gets a summary to them; questions go to the channel first — owner: Tommy Zwirblia, Stephen Hu — decided — [00:00](https://fathom.video/calls/911670989?timestamp=0), [02:25](https://fathom.video/calls/911670989?timestamp=145)
- Stephen Hu starts the API that connects Unified and Turns; Emran Moradian may start Turns in parallel; Tommy Zwirblia hands the Discipline stories to Murtaza Khalil and Nikki Tilano for Jira import — owner: Stephen Hu, Tommy Zwirblia — decided — [03:36](https://fathom.video/calls/911670989?timestamp=216)
- Two-way sync: Michel Walther gets an overview, then spends about half a day finding flaws in the plan; he does the Vehicle Manager first; who builds it in depth is decided later — owner: Tommy Zwirblia — decided — [20:15](https://fathom.video/calls/911670989?timestamp=1215)
- Two-way sync and the Notification service use the same queue (pub/sub) design; it is designed for two-way sync first and reused for notifications — owner: Tommy Zwirblia — decided — [28:38](https://fathom.video/calls/911670989?timestamp=1718)
- GPS gap display: a gap of more than **3 minutes** between GPS samples is drawn as a dashed straight line with an info circle; the 3-minute value comes from the PRD; straight line, not routed around water — owner: Vladislav Derbenev; approved by Tommy Zwirblia, Matthew Hayes — decided — [30:21](https://fathom.video/calls/911670989?timestamp=1821), [33:33](https://fathom.video/calls/911670989?timestamp=2013)

## Positions and concerns

- **Mobile store release first:** Tommy Zwirblia wants the bug backlog fixed and an app pushed to the store to prove store releases still work before Discipline work in Turns moves in; he is "really nervous" about it. Order left to Nikki Tilano and Murtaza Khalil — [04:06](https://fathom.video/calls/911670989?timestamp=246)
- **Overlapping T&A shifts:** Shikhar Patel, from the code: overlapping punches should be refused except when an admin edited one of the shifts. Yusra Abbasi and Tommy Zwirblia: overlapping shifts must never be allowed, not even after an admin edit. The one example sent so far was on two different days; Shikhar Patel checks the database — [06:32](https://fathom.video/calls/911670989?timestamp=392), [08:25](https://fathom.video/calls/911670989?timestamp=505), [08:38](https://fathom.video/calls/911670989?timestamp=518)
- **Two-way sync effort:** Vladislav Derbenev: the queue service with logging, stability, security and performance is a lot of work on a short timeline; look for a library or third-party service. Tommy Zwirblia: open to that. Michel Walther: at least two developers should review it, one with Old World knowledge — [15:52](https://fathom.video/calls/911670989?timestamp=952), [17:32](https://fathom.video/calls/911670989?timestamp=1052)
- **Who reviews two-way sync:** Nikki Tilano suggested Lee, Janice or Ibrahim, since others are on New World work; Tommy Zwirblia ranked Janice, then Ibrahim, then Lee, but chose Michel Walther for his Old World and New World knowledge — [20:00](https://fathom.video/calls/911670989?timestamp=1200), [20:15](https://fathom.video/calls/911670989?timestamp=1215)
- **Missing estimates:** Tommy Zwirblia cannot judge Dispatch progress with many items unestimated; asks for high-level estimates — [22:15](https://fathom.video/calls/911670989?timestamp=1335)

## Rules and facts

- The US dev Audit Log module was missing because a new permission was added without a migration that grants it to the admin role — stated (Shikhar Patel) — [06:32](https://fathom.video/calls/911670989?timestamp=392)
- US dev and Canada dev are on the same code after a fresh deployment, yet US dev allows overlapping shifts and Canada dev blocks them — stated — [05:43](https://fathom.video/calls/911670989?timestamp=343), [06:32](https://fathom.video/calls/911670989?timestamp=392)
- Some front-end requests time out before they reach the API: no log in the API pods or Datadog. Seen in US dev and Canada dev, not reported in staging or prod — stated — [08:59](https://fathom.video/calls/911670989?timestamp=539)
- Two-way sync splits the Substitution Service: the half that writes to the queue stays; a new service reads the queue and writes to the Old World through BP Info, to snapshots and to the audit table — stated (Tommy Zwirblia) — [14:44](https://fathom.video/calls/911670989?timestamp=884)
- Dispatch front end: close to done next week, with no back-end connection; the back end (logic, queues) is larger — stated (Vladislav Derbenev) — [23:48](https://fathom.video/calls/911670989?timestamp=1428)
- Dispatch optimize and merge need the street network graph, which is not imported into the New World; Michel Walther and Michelle Prichard are expected to bring it over — stated — [25:03](https://fathom.video/calls/911670989?timestamp=1503), [26:01](https://fathom.video/calls/911670989?timestamp=1561)
- The January commitment is the Discipline module, about 20% of Smart Tag's functions — stated (Tommy Zwirblia) — [39:47](https://fathom.video/calls/911670989?timestamp=2387)
- Two lines that differ only by colour fail accessibility; the GPS gap line uses a different pattern from the planned line — stated (Vladislav Derbenev) — [34:42](https://fathom.video/calls/911670989?timestamp=2082)

## Plans

- PLANNED: seating chart for the January delivery is simplified to a list of students with seats added as needed; it is a "follow fast" item; the goal is not a feature-for-feature Smart Tag replacement — owner: Tommy Zwirblia, Matthew Hayes — tentative — [38:03](https://fathom.video/calls/911670989?timestamp=2283), [39:47](https://fathom.video/calls/911670989?timestamp=2387)
- PLANNED: Thursday Unified walkthrough may show the GPS gap display, Vehicle Manager progress and a two-way sync overview — tentative — [36:11](https://fathom.video/calls/911670989?timestamp=2171)
- PLANNED: a limited ridership integration that "checks the box" before a full one — tentative (Tommy Zwirblia) — [38:03](https://fathom.video/calls/911670989?timestamp=2283)

## Defects and risks

- US dev: Audit Log module missing (permission migration missing); Jira to be filed — [06:32](https://fathom.video/calls/911670989?timestamp=392)
- US dev: overlapping shifts accepted; bug to be logged after a DB check — [05:43](https://fathom.video/calls/911670989?timestamp=343)
- US and CA dev: sporadic time-outs before the API, no logs — [08:59](https://fathom.video/calls/911670989?timestamp=539)
- US dev: schedule page did not load until reload — [05:43](https://fathom.video/calls/911670989?timestamp=343)
- Some buses show long GPS gaps (15 to 60 minutes) — a separate issue, not investigated — [31:48](https://fathom.video/calls/911670989?timestamp=1908)
- Risk: Dispatch blocked by the two-way sync queue design and the street network import — [28:05](https://fathom.video/calls/911670989?timestamp=1685)

## Open questions

- Is overlapping-shift acceptance a code defect, an environment setting or a data issue?
- Who builds the two-way sync service in depth, and will a library or third-party queue be used?

## Differs from knowledge base

- GPS gap dashed over 3 minutes (from the PRD) — supersedes the 2026-11-19 meeting decision (over 1 minute); `confluence.md` has "A track break is called a 'GPS gap' only when the tracker went quiet" and no threshold — updates
- Overlapping shifts must never be allowed — contradicts `repos/BusPlannerUnified/ta-requirements.md` TA-11 "V1 performs no time-overlap validation between punches of one shift" and D10 (code returns 409 for an overlap on the matched shift); related ENG-1589 (`jira/eng-1201-1600.md`) — contradicts
- US dev Audit Log permission migration missing; pre-API time-outs in dev — absent (`environments.md`, `test-strategy.md`)
- Two-way sync splits the Substitution Service and shares its queue design with notifications — absent (`architecture.md`)

## Confirms

- Dispatch optimize/merge blocked by the street graph — `jira/eng-1601-2000.md` ENG-1787 "Blocked: needs street graph"
- Two-way sync is the Dispatch back end — `jira/eng-2801-latest.md` ENG-2987..2998

## Action items

- [ ] Add Tommy Zwirblia and Andy Tompkins as optional reviewers on MD changes — owner: Stephen Hu — [02:25](https://fathom.video/calls/911670989?timestamp=145)
- [ ] Send Discipline stories to Murtaza Khalil and Nikki Tilano for Jira import — owner: Tommy Zwirblia — [02:49](https://fathom.video/calls/911670989?timestamp=169)
- [ ] File Jira for the audit-log permission migration — owner: Shikhar Patel — [08:59](https://fathom.video/calls/911670989?timestamp=539)
- [ ] Investigate pre-API time-outs; file Jira — owner: Shikhar Patel — [08:59](https://fathom.video/calls/911670989?timestamp=539)
- [ ] Send overlapping-shift evidence to Shikhar Patel; then log the bug — owner: Yusra Abbasi — [08:38](https://fathom.video/calls/911670989?timestamp=518)
- [ ] Two-way sync overview with Michel Walther, then half-day review — owner: Tommy Zwirblia, Michel Walther — [20:15](https://fathom.video/calls/911670989?timestamp=1215)
- [ ] Reshare street network plan; meet Michel Walther and Vladislav Derbenev — owner: Tommy Zwirblia — [26:01](https://fathom.video/calls/911670989?timestamp=1561)
- [ ] High-level estimates on unestimated Dispatch items — owner: Tommy Zwirblia — [22:15](https://fathom.video/calls/911670989?timestamp=1335)
- [ ] Seating chart and ridership options for the walkthrough — owner: Matthew Hayes, Tommy Zwirblia — [37:26](https://fathom.video/calls/911670989?timestamp=2246)
