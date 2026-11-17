# Engineering Deep Dive (2026-11-13)

- **Recording:** https://fathom.video/calls/899726761
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** GPS+ Route Management, BP Info, ETL, GPS readers, GPS+ Path & Stop Compare, Ride Support (Discipline)

## Decisions

- Three new BP Info APIs: affected records on a mapping save, routes without a GPS vehicle for a date, and the operator-provider (platform to operator) mapping — owner: Mitchell Bland — decided — [20:51](https://fathom.video/calls/899726761?timestamp=1251)
- Client-side detection of affected routes (call get before and after save, then diff) is rejected: concurrent edits by two users cannot be told apart, and the get returns large unsorted, unpaged data — owner: Mitchell Bland, Michel Walther — decided — [16:52](https://fathom.video/calls/899726761?timestamp=1012)
- Filtering by `platform` instead of operator is not acceptable: platform names are provider-specific (for example a depot) and one operator can have several platforms — owner: Mitchell Bland — decided — [12:02](https://fathom.video/calls/899726761?timestamp=722)
- The bus drop-down filters by operator, not by depot — owner: Mitchell Bland, accepted by Awais Akram — decided — [36:37](https://fathom.video/calls/899726761?timestamp=2197)

## Positions and concerns

- **Affected routes on save (M1), client-side or API:** Mitchell Bland first proposed deriving affected routes client-side (get before and after the save, then diff) if the Old World logic is simple. Michel Walther objected: the get has no sorting or paging, so all data must load in the front end. Mitchell Bland then raised a concurrency concern: two users saving close together cannot be told apart. Michel Walther: "we just have to make that API". Mitchell Bland called it "a little unfortunate". Outcome: decided (new API) — [04:02](https://fathom.video/calls/899726761?timestamp=242), [15:46](https://fathom.video/calls/899726761?timestamp=946), [16:52](https://fathom.video/calls/899726761?timestamp=1012)
- **Using the "modified by" column instead:** Shikhar Patel proposed adding a user name to the modified-by column to tell changes apart. Mitchell Bland rejected it: an unassignment with no effective or retired date deletes the record, so no trace remains. Outcome: rejected — [17:18](https://fathom.video/calls/899726761?timestamp=1038)
- **Design for typical use only:** Shikhar Patel noted that clients usually make future-dated assignments. Mitchell Bland was reluctant to make the tool work only for how clients most often use it, because same-day and past changes also happen. Outcome: the API covers all cases — [17:59](https://fathom.video/calls/899726761?timestamp=1079), [18:19](https://fathom.video/calls/899726761?timestamp=1099)
- **Routes without vehicles (M5):** Mitchell Bland proposed a client-side approach (route get all compared with GPS route vehicle get, filtered by date). Andy Tompkins accepted client-side; Michel Walther said "we can try it". Mitchell Bland then asked to scope the third API now so that QA1 is not updated twice. Michel Walther preferred the same BP Info-API approach planned for two-way Dispatch. Outcome: decided (third API) — [06:37](https://fathom.video/calls/899726761?timestamp=397), [19:22](https://fathom.video/calls/899726761?timestamp=1162), [20:51](https://fathom.video/calls/899726761?timestamp=1251)
- **Filter buses by depot:** Awais Akram asked for depot filtering of the bus list. Mitchell Bland held that depots link only to planning vehicles and that he is isolating changes so they can ship that day. Awais Akram accepted operator filtering. Outcome: decided (operator only) — [35:34](https://fathom.video/calls/899726761?timestamp=2134)
- **ENG-3136 inverted door signals, cause:** Matthew Hayes suspects a hardware wiring error on the buses. Mitchell Bland holds that it may be a Geotab software inversion setting (`0 = on`) that is set wrong or read wrong by us; if it is not set up, implementers must fix the wiring or the Geotab portal. Vladislav Derbenev found the provider data matches the New World data. Outcome: left open — [26:25](https://fathom.video/calls/899726761?timestamp=1585), [27:07](https://fathom.video/calls/899726761?timestamp=1627)
- **ENG-3136 path not driven in BP Pro, cause:** Mitchell Bland holds that GPS data is not invented, so the New World shows the wrong vehicle, several vehicles, or a wider time window than BP Pro. Shikhar Patel suspects the time window. Vladislav Derbenev noted the turnaround patch will reduce extra stops but not the extra path. Outcome: left open; compare the same vehicle and time in both worlds — [29:08](https://fathom.video/calls/899726761?timestamp=1748), [30:00](https://fathom.video/calls/899726761?timestamp=1800), [32:58](https://fathom.video/calls/899726761?timestamp=1978)

## Rules and facts

- In BP Quick, a GPS vehicle assignment that conflicts shows a conflict pop-up naming the route ID only after the change is applied — stated — [03:40](https://fathom.video/calls/899726761?timestamp=220)
- Adding a dated mapping inside an open-ended one splits the existing mapping into three records (before, during, after). A second overlapping dated mapping shortens the first one, so four records exist — stated — [22:28](https://fathom.video/calls/899726761?timestamp=1348)
- Unassigning a vehicle from a route with no effective or retired date deletes the mapping record, so no "modified" trace remains — stated — [17:33](https://fathom.video/calls/899726761?timestamp=1053)
- Each GPS vehicle has a provider (GTS, Geotab, Zonar and others) and a platform (a grouping inside the provider). Platform maps to operator only through the internal `BPL Operator-Provider Pairing` table, which BP Info does not expose — stated — [09:59](https://fathom.video/calls/899726761?timestamp=599)
- Depots link to planning vehicles only, not to GPS vehicles; the bus list filters by operator, not depot — stated — [36:08](https://fathom.video/calls/899726761?timestamp=2168)
- Geotab door-sensor AUX settings are per client, but devices can use different AUX ports (comma-separated, for example AUX 1 and AUX 3). Geotab can invert a signal in software ("0 = on"). Mixed polarity on the same AUX port cannot be reconciled and needs a hardware or portal fix by the implementer — stated — [39:16](https://fathom.video/calls/899726761?timestamp=2356)
- AUX settings were copied once from the customer's Old World server into the New World and are not synced afterwards — stated — [39:08](https://fathom.video/calls/899726761?timestamp=2348)
- The Discipline module is a New World module requested by New Caney, a client starting in January — stated — [41:37](https://fathom.video/calls/899726761?timestamp=2497)
- The Discipline workflow touches Turns, Chipmunk and its own module — stated — [41:54](https://fathom.video/calls/899726761?timestamp=2514)

## Plans

- PLANNED: build the three BP Info APIs the same day (2026-11-13) and deploy them to QA1, owner Mitchell Bland — decided — [19:22](https://fathom.video/calls/899726761?timestamp=1162), [21:12](https://fathom.video/calls/899726761?timestamp=1272)
- PLANNED: fix the ETL Extract mapping selection to pick the mapping active today, no target date, owner Shikhar Patel — decided — [23:08](https://fathom.video/calls/899726761?timestamp=1388)
- PLANNED: ENG-3136 scope addition: detect reversing, add turnaround stops, flag an unplanned turnaround as a violation, no target date, owner not named (requested by Tommy Zwirblia) — tentative — [34:46](https://fathom.video/calls/899726761?timestamp=2086)
- PLANNED: Discipline module walkthrough moved to the next week, owner Murtaza Khalil — decided — [41:13](https://fathom.video/calls/899726761?timestamp=2473)

## Defects and risks

- ETL Extract picks a vehicle mapping by latest effective date with a null or future retired date. With future-dated assignments this picks a mapping that is not active today. Fix owner: Shikhar Patel (no ticket key said) — [23:08](https://fathom.video/calls/899726761?timestamp=1388)
- ENG-3136 (Landmark): about half the buses send inverted door signals (0 = open), which breaks stop classification — [24:38](https://fathom.video/calls/899726761?timestamp=1478)
- ENG-3136: the New World path for one run shows roads not driven in BP Pro; suspected wider time window, wrong or extra vehicle. Turnaround stops add extra stops until the patch is deployed — [29:08](https://fathom.video/calls/899726761?timestamp=1748)

## Terms

- **M1, M5, M6**: requirement ids for the vehicle assignment page (M1 affected routes on save, M5 routes without vehicles, M6 filter by operator).
- **Platform (GPS)**: a provider-side grouping of vehicles, often a depot.
- **GPS Data Viewer**: BP Pro tool to review raw GPS data; the reference for "is the data right".

## Open questions

- Does the ETL Extract fix also need a regression test for a run with three or four split mappings?
- What exact time window does the New World Path Compare use compared with BP Pro?
- Is the ENG-3136 door inversion a wiring fault or a Geotab setting we read wrong?

## Differs from knowledge base

- ETL Extract future-dated mapping defect (picks a mapping not active today) vs `knowledge/test-strategy.md`: no line covers it in the flaky, skipped and known-gap list or the ETL gaps — answers a gap (new defect, absent from the knowledge base)
- ENG-3136 (Landmark inverted door signals and path differences) vs `knowledge/` — absent: no file names ENG-3136 — updates (new ticket)
- AUX settings copied once from the Old World server and not synced vs `knowledge/` — absent — updates

## Confirms

- Mapping records are dated; a record applies when effective date <= day < retire date, and the later effective date wins — `knowledge/repos/BusPlannerUnified/data-services.md`
- New Caney is a known customer name — `knowledge/jira/other-projects.md`
- Ride Support (Discipline, code name `conduct`) is not started — `knowledge/domain.md`
- Landmark (NPSSTS) GPS+ stand-up had blockers in device mapping — `knowledge/confluence.md`
- The Unified reader supports Geotab, Zonar, Synovia, GTS and Samsara — `knowledge/domain.md`

## Action items

- [ ] Test the three BP Info APIs on QA1 when deployed, including concurrent edits and split mappings — owner: QA — [21:12](https://fathom.video/calls/899726761?timestamp=1272)
- [ ] Add a regression case for the ETL Extract future-dated mapping fix — owner: QA — [23:08](https://fathom.video/calls/899726761?timestamp=1388)
- [ ] Compare New World and BP Pro GPS data for the same vehicle and time (ENG-3136) — owner: Vladislav Derbenev — [32:58](https://fathom.video/calls/899726761?timestamp=1978)
- [ ] Reschedule the Discipline module discussion for next week — owner: Murtaza Khalil — [41:13](https://fathom.video/calls/899726761?timestamp=2473)
