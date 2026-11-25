# Engineering show and tell, pre-release demo (2026-11-20)

- **Recording:** https://fathom.video/calls/908095429
- **Class:** qa-core
- **Source read:** summary (ticket keys and customers from the AI summary; not checked in the transcript)
- **Areas:** Release and branching, Old World defects, GPS+ Path & Stop Compare, Chatbot, BP Info, Eligibility
- **Duplicate skipped:** 205431982 (same meeting, other recorder)

## Rules and facts

All items: stated (summary only).

- Five releases reviewed: four live, one due Tuesday 2026-11-24 — [02:04](https://fathom.video/calls/908095429?timestamp=124)
- BP Web: new "Confidential" student setting hides student names in about 25 BP Web reports (school name in charts; hidden from Contact Tracer) while bus loads stay correct — [04:42](https://fathom.video/calls/908095429?timestamp=282)
- BP Web Student Listing Report: optional Student ID column on screen, PDF and Excel (PGCPS) — [03:39](https://fathom.video/calls/908095429?timestamp=219)
- Path server: ENG-2971 Geotab Reader 1-hour error from an Alberta time zone change; ENG-2967 thread/memory leak in concurrent eligibility runs; ENG-2948 silent database open failure at startup; ENG-3043 eligibility not calculated for some CCSD schools; ENG-3050/3051 crashes on unplaceable or identical path endpoints — [06:50](https://fathom.video/calls/908095429?timestamp=410)
- Fleet: ENG-1176 PO payment totals use received/returned cost, not ordered cost; ENG-1993 missing-part cost flows to the work order line; ENG-1995 "Received Missing Part" follows "Restrict Missing Parts to Open Work Orders"; ENG-2706 PO number held until save; ENG-2726 charged parts on closed work orders leave inventory — [10:10](https://fathom.video/calls/908095429?timestamp=610)
- Workflow forms: ENG-2822 a second submission no longer deletes the open workflow; ENG-3063 missing exclusion group no longer blocks form load; ENG-347 District Admin search sees all students — [13:00](https://fathom.video/calls/908095429?timestamp=780)
- Reports and trips: ENG-2743/2745 Route Directions layout and "no runs" message; ENG-2135 trip invoices open; ENG-2759 trip billing split — [16:20](https://fathom.video/calls/908095429?timestamp=980)
- BP Pro and GPS: ENG-2065 old GPS Path Compare loads runs; ENG-2410 vehicle mappings no longer bleed across groups sharing a Route ID; route optimizer no longer duplicates runs on old and new routes; ENG-2724 eligibility no longer needs a map folder — [19:22](https://fathom.video/calls/908095429?timestamp=1162)
- Performance: ENG-1997 BP Web memory and SQL fixes; ENG-2443 BP Pro SQL uses parameters instead of literal GUIDs — [21:44](https://fathom.video/calls/908095429?timestamp=1304)
- BP Info: ENG-3152 new APIs for Unified GPS vehicle assignments — [23:20](https://fathom.video/calls/908095429?timestamp=1400)
- Unified: substitutions entered in BP Web, Quick or Pro flow to the New World even for clients without Dispatch — [24:55](https://fathom.video/calls/908095429?timestamp=1495)
- Chatbot: answers on-time scorecards and trend comparisons; internal evaluation harness extended against regressions; reviewed for prompt injection; answers BusPlanner data only — [25:00](https://fathom.video/calls/908095429?timestamp=1500), [26:00](https://fathom.video/calls/908095429?timestamp=1560)

## Differs from knowledge base

- Chatbot "BusPlanner data only" and prompt-injection review stated as done vs `knowledge/repos/BusPlannerUnified/chatbot-spec.md` (declines cover out-of-scope BusPlanner questions only) — updates (partly answers the 2026-11-18 open question; summary only)
- BP Web "Confidential" student setting — absent

## Confirms

- ENG-1997 BP Web disconnect / memory work — `knowledge/jira/eng-1601-2000.md`
- ENG-2967 PathServer threads in concurrent eligibility runs — `knowledge/jira/eng-2801-latest.md`
- BP Info APIs for vehicle assignment (2026-11-13 meeting) — `meetings/` only
