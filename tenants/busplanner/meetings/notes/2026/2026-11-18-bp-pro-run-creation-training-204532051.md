# BP Pro run creation training (2026-11-18)

- **Recording:** https://fathom.video/calls/906828635
- **Class:** qa-context
- **Source read:** summary
- **Areas:** BP Pro routing

Customer training for a Yukon operator customer setting up a new rural school community. Customer staff, school and address names are left out. Trainer: Ananya George.

## Rules and facts

- A bus stop is created with `Tools > Add > Bus Stop`, or on the fly in the Run Editor with the toolbar `New Stop` button — stated (summary only) — [09:11](https://fathom.video/calls/906828635?tab=summary&timestamp=551)
- A run is created with `Tools > Add > Run` and filled with `Existing Stop` / `New Stop`; `Add School` appends the serviced school stop to finish the run — stated (summary only) — [09:11](https://fathom.video/calls/906828635?tab=summary&timestamp=551)
- A run must be inserted into a route in Route Manager (`Route > New`, then `Run > Insert`) for routing and scheduling to work — stated (summary only) — [19:50](https://fathom.video/calls/906828635?tab=summary&timestamp=1190)
- Once a run is on a route, new stops are added in the Run Editor only; the run is not inserted again — stated (summary only) — [22:05](https://fathom.video/calls/906828635?tab=summary&timestamp=1325)
- An address that does not geocode can use a manual Location ID (`Tools > Add > Location`, position type Manual, `Set Position`) linked in the student's address record — stated (summary only) — [22:50](https://fathom.video/calls/906828635?tab=summary&timestamp=1370)
- A manual location off the road network needs an access street drawn in the Streets tab, or the routing engine cannot reach it — stated (summary only) — [28:54](https://fathom.video/calls/906828635?tab=summary&timestamp=1734)
- A new school needs School ID, District ID, Type, Grades and an address or Location ID — stated (summary only) — [22:50](https://fathom.video/calls/906828635?tab=summary&timestamp=1370)
- AM and PM runs are told apart by a suffix in the run ID (advice, not a system rule); a complementary run is optional — tentative — [16:25](https://fathom.video/calls/906828635?tab=summary&timestamp=985)

## Terms

- **Location ID (manual)**: a map point placed by hand for an address the GIS cannot match.
- **Complementary run**: a PM run generated from an AM run.

## Differs from knowledge base

- Run-to-route insertion rule, manual Location ID and access-street rule vs `knowledge/domain.md`, `knowledge/confluence-prd.md`: no rule for Route Manager run insertion or manual Location IDs — absent (Old World; useful as test data rules if ETL or snapshots read runs without routes)

## Confirms

- Route Manager is a BP Pro screen — `knowledge/jira/eng-0001-0400.md` (ENG-175)
