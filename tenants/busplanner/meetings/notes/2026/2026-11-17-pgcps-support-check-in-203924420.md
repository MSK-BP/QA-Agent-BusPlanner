# PGCPS bi-weekly support check-in (2026-11-17)

- **Recording:** https://fathom.video/calls/902763535
- **Class:** qa-context
- **Source read:** summary
- **Areas:** Stop boundaries

## Positions and concerns

- **Why hazards are not enough:** the customer (PGCPS) holds that in dense areas several stops share one intersection, and hazards cannot split the students into busloads, so auto-assign is unusable for them; they need a definite way to assign a student to one stop even when several are in walking range. BusPlanner accepted the need. Outcome: decided to build boundaries (MVP) — [04:04](https://fathom.video/calls/902763535?timestamp=244), [07:57](https://fathom.video/calls/902763535?timestamp=477)
- **Quick win before the full feature:** BusPlanner proposed a "Comprehensive Stops" map layer first, as a visual guide for new stop placement, for PGCPS to validate. No objection recorded. Outcome: tentative — [32:45](https://fathom.video/calls/902763535?timestamp=1965), [35:02](https://fathom.video/calls/902763535?timestamp=2102)

## Rules and facts

- Problem: in dense areas several stops share one intersection, and hazards cannot split students into busloads; PGCPS cannot use auto-assign today — stated — [04:04](https://fathom.video/calls/902763535?timestamp=244)
- Requirement: a student whose address is inside a stop's boundary polygon is assigned to that stop, overriding the normal walking-distance rules — tentative — [08:36](https://fathom.video/calls/902763535?timestamp=516)
- Requirement: boundaries must not overlap; the earlier system butted adjacent polygons against each other — tentative — [17:00](https://fathom.video/calls/902763535?timestamp=1020)
- Requirement: the initial boundary is a 0.5-mile street-network area around the stop, constrained by hazards and other boundaries; users can edit the polygon — tentative — [17:29](https://fathom.video/calls/902763535?timestamp=1049)
- Requirement: boundaries show on the map for all selected runs, coloured by run — tentative — [22:05](https://fathom.video/calls/902763535?timestamp=1325)
- Comprehensive Stops layer: stops with `Position Type` = Corner on numbered (not alphanumeric) routes; one point and boundary per unique location (duplicates merged) — tentative — [32:45](https://fathom.video/calls/902763535?timestamp=1965)

## Plans

- PLANNED: custom stop boundary feature (MVP) for PGCPS, requirements agreed, build not started, no target date, owner Ahnaf Rahman — tentative — [17:19](https://fathom.video/calls/902763535?timestamp=1039)
- PLANNED: "Comprehensive Stops" map layer first, shared with PGCPS for validation, no target date, owner Ahnaf Rahman — tentative — [34:02](https://fathom.video/calls/902763535?timestamp=2042)

## Open questions

- Which product gets the boundary feature: BP Pro, BP Web or BP Unified?
- What happens to a student inside a boundary whose stop is retired or moved?
- Does the summary's "0.5-mile radius" mean a straight radius or a street-network distance? (`summary only`)

## Differs from knowledge base

- Stop boundaries: polygons that override walk rules, non-overlapping, 0.5-mile default, hazard-constrained, plus a Comprehensive Stops layer vs `knowledge/jira/other-projects.md`: "BP Pro - PGCPS - Custom stop boundaries with lasso-to-assign students on the map" (To Do) — updates (adds requirements; no lasso-to-assign was mentioned)

## Confirms

- PGCPS asked for custom stop boundaries (PROD-622, To Do) — `knowledge/jira/other-projects.md`
- PGCPS router feature requests exist as a delivery plan — `knowledge/confluence.md`

## Action items

- [ ] When the Comprehensive Stops layer and boundary MVP reach QA, test the non-overlap, hazard constraint and override-of-walk-rules cases — owner: QA — [17:19](https://fathom.video/calls/902763535?timestamp=1039)
