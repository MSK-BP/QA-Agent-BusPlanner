# Engineering Deep Dive (2026-11-18)

- **Recording:** https://fathom.video/calls/906734017
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Chatbot, GPS+ Path & Stop Compare, GPS+ Live Viewer, Database migrations, Release and branching, Environments and access, Ridership, Ride Support (Discipline)

## Decisions

- Chatbot go-live: make the current features work correctly; net-new items from the "AI Chatbot Feature Feedback" doc (scheduled report tasks, custom reports, multi-database comparison) are not go-live blockers — owner: Tommy Zwirblia — decided — [07:26](https://fathom.video/calls/906734017?timestamp=446)
- Chatbot uses the AWS-hosted model in Canada; prompts must not cross the border — owner: Tommy Zwirblia ("that decision was made") — decided — [07:26](https://fathom.video/calls/906734017?timestamp=446)
- Chatbot: BusPlanner provides all model keys; clients never bring their own keys — owner: Tommy Zwirblia, Andy Tompkins — decided — [13:01](https://fathom.video/calls/906734017?timestamp=781)
- Chatbot: no customer-facing usage or cost display, no customer or per-user spend limits, no client admin screens for usage; usage (questions, tokens) is tracked internally per customer and per user — owner: Tommy Zwirblia, Andy Tompkins — decided — [07:26](https://fathom.video/calls/906734017?timestamp=446), [13:57](https://fathom.video/calls/906734017?timestamp=837)
- GPS+ Path & Stop Compare gets Live Viewer behaviour: auto-refresh of path and vehicle location every 30 s, a manual refresh button and a pause button; the same page opens from Live Viewer in a new tab. Three old views become two (Live Viewer, Path & Stop Compare) — owner: Tommy Zwirblia; ticket by Vladislav Derbenev — decided — [15:55](https://fathom.video/calls/906734017?timestamp=955)
- The new index on the GPS event table is not added to the migration tool sequence; it goes in the create-database script (new databases) and is applied by a separate script to existing databases — owner: Shikhar Patel, Vladislav Derbenev — decided — [31:05](https://fathom.video/calls/906734017?timestamp=1865)
- Index rollout: HRCE staging and production tonight (critical); other databases offline during working hours — owner: Shikhar Patel — decided — [32:00](https://fathom.video/calls/906734017?timestamp=1920)
- Container registry: short term, keep the latest 25–30 images; long term, a scheduled job that keeps images in use and the previous (rollback) image and deletes the rest — owner: Shikhar Patel, Andy Tompkins — decided — [38:36](https://fathom.video/calls/906734017?timestamp=2316)

## Positions and concerns

- **GPS event retention for the index build:** Shikhar Patel proposed keeping only the last 15 days of GPS events, because no customer uses the data yet and a smaller table builds the index faster. Andy Tompkins holds that GPS data is not to be dropped; with about one hour per database the plan works without it. Outcome: not adopted; separate-script plan chosen — [25:11](https://fathom.video/calls/906734017?timestamp=1511), [21:49](https://fathom.video/calls/906734017?timestamp=1309)
- **Migration tool timeout:** Vladislav Derbenev holds that the migration tool timeout cannot be raised without limit, because a stuck migration then blocks until the timeout. Shikhar Patel adds that the tool is sequential, so one long migration blocks all later small ones. Outcome: decided (separate script) — [24:14](https://fathom.video/calls/906734017?timestamp=1454), [31:11](https://fathom.video/calls/906734017?timestamp=1871)
- **Missed databases:** Andy Tompkins is concerned that a database created in parallel (for example Tri-County) could miss the index; he proposes a check of all databases in about a week. Outcome: agreed as a check, no owner named — [32:32](https://fathom.video/calls/906734017?timestamp=1952)
- **Chatbot misuse:** Tommy Zwirblia holds that the chatbot must answer only about BusPlanner data and must not work as a generic chatbot, because general use raises cost. Outcome: stated as a requirement, no ticket named — [07:26](https://fathom.video/calls/906734017?timestamp=446)
- **Ridership placement:** Matthew Hayes asked where ridership and student scanning go in the New World. Tommy Zwirblia wants a ridership menu item with full reporting, and rider scans toggled on in Path & Stop Compare for customers who bought ridership. Andy Tompkins agrees in general and wants bridges so Chipmunk keeps parent-facing scan data during the move. Outcome: not decided — [41:07](https://fathom.video/calls/906734017?timestamp=2467), [44:17](https://fathom.video/calls/906734017?timestamp=2657)

## Rules and facts

- The chatbot answers only questions about the customer's BusPlanner data; it must not answer general questions — stated — [07:26](https://fathom.video/calls/906734017?timestamp=446)
- Chatbot prompts are processed by a model hosted in Canada — decided (built status not said) — [07:26](https://fathom.video/calls/906734017?timestamp=446)
- Old World has no historical plan and no future plan: a BP Pro path compare for a past date compares that date's GPS data with **today's** plan. New World snapshots are what fix this — stated (Andy Tompkins, Tommy Zwirblia) — [26:00](https://fathom.video/calls/906734017?timestamp=1560)
- Old World run validity holds one effective-from / retire date range only; earlier or later versions are not kept — stated — [27:07](https://fathom.video/calls/906734017?timestamp=1627)
- The fix that reads late-arriving GPS events needs a new index on the GPS event table; without the index, stop classification fails after the rollout — stated (Shikhar Patel) — [19:44](https://fathom.video/calls/906734017?timestamp=1184), [30:31](https://fathom.video/calls/906734017?timestamp=1831)
- The GPS event table is partitioned by month; building the index still scans the whole table and is disk-bound — stated (Vladislav Derbenev) — [22:27](https://fathom.video/calls/906734017?timestamp=1347)
- The migration tool runs migrations in sequence and has a timeout — stated — [31:11](https://fathom.video/calls/906734017?timestamp=1871)
- In the old GPS+, Path Compare and Stop Compare do not refresh; the path view opened from Live Viewer does refresh — stated (Tommy Zwirblia) — [15:55](https://fathom.video/calls/906734017?timestamp=955)

## Plans

- PLANNED: Path & Stop Compare auto-refresh (30 s), refresh and pause buttons, ticket to be created — owner Vladislav Derbenev — decided — [15:55](https://fathom.video/calls/906734017?timestamp=955)
- PLANNED: Ridership in the New World: phase 1 recreates Ridership Pro features, phase 2 adds wider reporting (for example US state reporting); bridges keep Old World consumers (Chipmunk) working until the move is complete — owner Tommy Zwirblia, Andy Tompkins — tentative — [43:59](https://fathom.video/calls/906734017?timestamp=2639), [44:17](https://fathom.video/calls/906734017?timestamp=2657)
- PLANNED: Discipline (Ride Support) schema walkthrough with Stephen Hu, Emran Moradian, Jon Borromeo, Ibrahim Usman and Sharaiz Khan; Stephen Hu sends an epic list so tickets can start — owner Tommy Zwirblia — decided — [35:22](https://fathom.video/calls/906734017?timestamp=2122), [36:07](https://fathom.video/calls/906734017?timestamp=2167)
- PLANNED: Tri-County database stood up today in production only (not dev or staging), after the index is in the create-database script — owner Andy Tompkins — decided — [32:32](https://fathom.video/calls/906734017?timestamp=1952)

## Environments, access, release

- The index build took about one hour on SDCC on dev (online mode). HRCE, Austin and Niagara are of similar size; Prince George's is about twice SDCC and exists on dev only; Landmark is newer and smaller — stated — [27:56](https://fathom.video/calls/906734017?timestamp=1676), [29:32](https://fathom.video/calls/906734017?timestamp=1772)
- Staging and production each hold about four client databases (the three Canadian clients and Brantford on staging) — stated — [29:52](https://fathom.video/calls/906734017?timestamp=1792), [32:32](https://fathom.video/calls/906734017?timestamp=1952)
- Stop classification may fail for a time on databases without users while the index is applied — stated, accepted — [32:00](https://fathom.video/calls/906734017?timestamp=1920)
- The container registry is shared by every environment in a region (one for Canada, one for the US) — stated — [40:09](https://fathom.video/calls/906734017?timestamp=2409)
- The IBM native retention rule ("keep the latest 20") deletes images that environments still use; IBM gives no way to see which image a cluster uses — stated (Shikhar Patel) — [37:42](https://fathom.video/calls/906734017?timestamp=2262), [38:59](https://fathom.video/calls/906734017?timestamp=2339)
- Opening Path & Stop Compare in a new tab is merged to `dev` — stated (Vladislav Derbenev) — [14:31](https://fathom.video/calls/906734017?timestamp=871)

## Defects and risks

- A deploy failed on 2026-11-17 because the container registry was full; this happened twice before and was fixed by raising the quota — [37:15](https://fathom.video/calls/906734017?timestamp=2235)
- Risk: a long index build inside the migration tool would time out or block later migrations — [24:14](https://fathom.video/calls/906734017?timestamp=1454)
- Risk: a database created outside the index rollout (for example Tri-County) could miss the index — [32:32](https://fathom.video/calls/906734017?timestamp=1952)
- Risk: test comparisons of New World Path & Stop Compare with BP Pro for past dates differ by design, because BP Pro uses today's plan — [26:31](https://fathom.video/calls/906734017?timestamp=1591)

## Terms

- **Bridge**: temporary link that keeps an Old World consumer (for example Chipmunk, substitutions) working while a feature moves to the New World; removed when nothing uses the Old World path.
- **Online / offline index build**: build with the table in use, or with the database taken offline (faster, needs no users).

## Open questions

- Does the 30-second refresh also apply when Path & Stop Compare shows a past date, or only for today?
- Is the "BusPlanner data only" chatbot rule built and tested (decline eval for off-topic questions), or still a requirement?
- Who runs the one-week check that every database has the GPS event index?
- Where do ridership and rider scans live in the New World (module, GPS+ or both)?

## Differs from knowledge base

- Path & Stop Compare gets 30 s auto-refresh, refresh and pause, and opens from Live Viewer in a new tab vs `knowledge/confluence.md` 5.3: Compare opens "for the bus's route, last 7 days ending today"; the GPS+ pages are described as historical with no auto-refresh — updates (planned)
- GPS event table gets an index for late-arriving events, applied outside the migration tool; stop classification fails without it vs `knowledge/jira/eng-0801-1200.md`: ENG-1193 "No index leading on gps_event_history.event_timestamp." — updates
- Chatbot model hosted in Canada; prompts stay in Canada vs `knowledge/repos/BusPlannerUnified/chatbot.md`: no hosting region recorded (judge model is `Anthropic:JudgeModel`) — absent
- Chatbot usage tracked per customer and per user; no customer spend limits or usage display; no client keys vs `knowledge/repos/BusPlannerUnified/chatbot-spec.md`: "Token-cost ceiling and per-user rate limits are **deferred** … Token usage per conversation visible to admins" — updates (limits dropped, not deferred; per-customer and per-user tracking added)
- Chatbot must refuse general (non-BusPlanner) questions vs `knowledge/repos/BusPlannerUnified/chatbot-spec.md`: declines cover out-of-scope BusPlanner questions "naming the gap"; no rule for general questions — absent
- Container registry full caused deploy failures; retention plan vs `knowledge/architecture.md`: no registry or retention rule — absent
- Old World has no historical plan; BP Pro past-date path compare uses today's plan vs `knowledge/domain.md`: snapshot glossary only — absent (partly answers the open question on New World vs BP Pro path compare windows)
- Tri-County database in production only vs `knowledge/jira/eng-2401-2800.md`: "Tri-County CA-NS-TCRCE (In Progress, P2 net new)" — updates (no dev or staging copy)

## Confirms

- Snapshots hold the plan per service day in the New World — `knowledge/domain.md`
- Stop classification is a separate service that classifies GPS events against planned stops — `knowledge/architecture.md`
- CA and US run in separate IBM Cloud accounts — `knowledge/architecture.md`

## Action items

- [ ] Email Michel Walther on per-customer and per-user question and token tracking (no dashboards, no spend limits) — owner: Tommy Zwirblia — [11:42](https://fathom.video/calls/906734017?timestamp=702)
- [ ] Create ticket: Path & Stop Compare 30 s auto-refresh and pause — owner: Vladislav Derbenev — [17:05](https://fathom.video/calls/906734017?timestamp=1025)
- [ ] Add the GPS event index to the create-database script; tell Andy Tompkins — owner: Vladislav Derbenev — [31:39](https://fathom.video/calls/906734017?timestamp=1899)
- [ ] Apply the index to HRCE staging and production, then to the other databases — owner: Shikhar Patel, Vladislav Derbenev — [32:00](https://fathom.video/calls/906734017?timestamp=1920)
- [ ] Schedule the Discipline schema walkthrough — owner: Tommy Zwirblia — [35:56](https://fathom.video/calls/906734017?timestamp=2156)
- [ ] Create a Jira ticket for container registry retention; meet Dan on in-use image tracking — owner: Shikhar Patel — [37:20](https://fathom.video/calls/906734017?timestamp=2240)
