# Engineering Deep Dive (2026-11-19)

- **Recording:** https://fathom.video/calls/905702126 (also recorded as 204914258, 204904514, 204904172)
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** GPS+ Live Viewer, GPS+ Path & Stop Compare, Ride Support (Discipline), Forms engine, Environments and access

## Decisions

- Forms: one set of tables for every form type (Discipline, Inspection, Workflow), not one set per module — owner: Tommy Zwirblia — decided (earlier, restated) — [03:31](https://fathom.video/calls/905702126?timestamp=211)
- Form submission: one central service receives every submission (tablet or web), writes it to the database first, answers success, then puts a record in the queue of the right module; the queue is never the only copy — owner: Tommy Zwirblia — decided — [03:31](https://fathom.video/calls/905702126?timestamp=211)
- Run end phase (ticket 3212): keep the new rule; the 20 of 270 HRCE buses it does not improve stay a known gap unless a simple rule fixes more without breaking the 250 — owner: Andy Tompkins, Tommy Zwirblia — decided — [09:39](https://fathom.video/calls/905702126?timestamp=579), [18:06](https://fathom.video/calls/905702126?timestamp=1086)
- Mid-run substitution with overlapping runs (ticket 3213): known gap, solved in the new Dispatch; meanwhile show that a vehicle has more than one run at a time, if cheap — owner: Tommy Zwirblia, Andy Tompkins — decided — [23:37](https://fathom.video/calls/905702126?timestamp=1417), [25:43](https://fathom.video/calls/905702126?timestamp=1543)
- Ended runs (ticket 3214): now, add a "Run ended" label next to the status; later ticket: replace "On time" with an "Ended" status, with filter changes — owner: Vladislav Derbenev — decided — [33:15](https://fathom.video/calls/905702126?timestamp=1995), [34:44](https://fathom.video/calls/905702126?timestamp=2084)
- GPS path: a gap of more than 1 minute between samples is drawn as a dashed line — owner: Vladislav Derbenev (ticket to create) — decided — [38:31](https://fathom.video/calls/905702126?timestamp=2311), [41:09](https://fathom.video/calls/905702126?timestamp=2469)
- Forms build order: feature by feature from PRD to QA. Form builder (web): Tommy Zwirblia and Matthew Hayes; mobile form display and submit: Stephen Hu and Emran Moradian; Discipline website and workflow processor: Drew Weeks — owner: Tommy Zwirblia — decided — [41:20](https://fathom.video/calls/905702126?timestamp=2480)

## Positions and concerns

- **Extra rule for the 20 buses:** Claude suggested an HRCE-specific rule; Vladislav Derbenev doubts it is safe and wants measurement first. Andy Tompkins: do not fix 5 of 20 at the cost of 15 of 250. Outcome: no rule now — [09:39](https://fathom.video/calls/905702126?timestamp=579)
- **Possible stops:** Matthew Hayes proposes showing "possible" stop visits (door, stop arm) to the user. Vladislav Derbenev: the visit data is already stored in a table, but Path & Stop Compare shows one visit per stop and Live Viewer only its best guess; a page design is needed. Outcome: open — [13:33](https://fathom.video/calls/905702126?timestamp=813), [14:19](https://fathom.video/calls/905702126?timestamp=859)
- **"On time" after the run:** Tommy Zwirblia thinks showing "On time" for a finished, late run is wrong although the PRD asks for it (client feedback: a finished run cannot be late). Vladislav Derbenev warns a new status touches filters. Outcome: label now, status later — [30:11](https://fathom.video/calls/905702126?timestamp=1811), [31:53](https://fathom.video/calls/905702126?timestamp=1913)
- **Form versions (Jon Borromeo's question):** Tommy Zwirblia: a form keeps one GUID; GUID + version is the key; a submission shows only the fields of its own version, never later fields as empty — stated — [57:00](https://fathom.video/calls/905702126?timestamp=3420)

## Rules and facts

- End phase: when a bus has serviced at least one stop of the run and reaches the last stop, the run enters the end phase; if the next run starts within 30 minutes, Live Viewer shows the next run at once — stated (Vladislav Derbenev) — [09:39](https://fathom.video/calls/905702126?timestamp=579), [17:00](https://fathom.video/calls/905702126?timestamp=1020)
- A late run is still tracked up to 90 minutes; the end phase did not change that — stated — [17:00](https://fathom.video/calls/905702126?timestamp=1020)
- After a run ends the bus is tracked about two more hours while it sends GPS; the delta keeps updating — stated — [25:53](https://fathom.video/calls/905702126?timestamp=1553)
- A run-level substitution from the Old World after the run started makes the New World clone a route; the two runs overlap in time and the system cannot tell which run the bus is on — stated — [18:22](https://fathom.video/calls/905702126?timestamp=1102)
- By PRD, a finished run shows "On time" — stated (Vladislav Derbenev) — [30:11](https://fathom.video/calls/905702126?timestamp=1811)
- By PRD, points more than 5 minutes apart are not joined on the map — stated (Vladislav Derbenev) — [37:48](https://fathom.video/calls/905702126?timestamp=2268)
- The QA-found "line between samples" bug is fixed; remaining straight segments are real 3+ minute gaps in the GPS data — stated — [35:47](https://fathom.video/calls/905702126?timestamp=2147), [39:10](https://fathom.video/calls/905702126?timestamp=2350)
- The forms schema adds module, workflow steps, form statuses and confidential forms; Tommy Zwirblia rates it about 90% complete — stated — [41:20](https://fathom.video/calls/905702126?timestamp=2480)

## Plans

- PLANNED: Path & Stop Compare time slider (play the bus along its path) and clickable GPS points with time — owner Tommy Zwirblia — tentative ("not for now") — [39:37](https://fathom.video/calls/905702126?timestamp=2377)
- PLANNED: start with the Discipline features list, then the API over the schema, checked with Claude — owner Tommy Zwirblia — decided — [41:20](https://fathom.video/calls/905702126?timestamp=2480)

## Environments, access, release

- The forms schema lives in a sandbox database on dev: a recent copy of the HRCE database restored under Tommy Zwirblia's name; update scripts (version by version, and one all-in-one) bring another database to that schema — stated — [52:02](https://fathom.video/calls/905702126?timestamp=3122)
- Schema changes to existing tables must be reviewed by Michel Walther before work leaves the sandbox — decided — [52:02](https://fathom.video/calls/905702126?timestamp=3122)
- Discipline documents are in the Slack channel "Dev Unified Discipline" — stated — [52:02](https://fathom.video/calls/905702126?timestamp=3122)

## Defects and risks

- Ticket 3212: 20 of 270 HRCE buses leave the last stop, pass an earlier stop of the same run and stay on the old run — known gap
- Ticket 3213: substitution after run start gives two overlapping runs — known gap
- Risk: a forms schema change to existing tables could break current features if not reviewed — [52:02](https://fathom.video/calls/905702126?timestamp=3122)

## Terms

- **End phase / Run ended**: state of a run after the last stop is reached with at least one stop serviced.
- **Shadow**: the vehicle's representation on Live Viewer (summary wording).

## Open questions

- Which filters and reports change when "On time" becomes "Ended"?
- Does the dashed-line threshold (1 min) replace or sit beside the 5-minute "no line" threshold?

## Differs from knowledge base

- One shared set of form tables for Discipline, Inspection and Workflow, submission written to the database then queued per module vs `knowledge/confluence-prd.md`: Ride Support tables `cnd_` / `sc_`, and SY-16 forms engine "TO-BE the one inspection engine" — updates
- GPS gap of more than 1 minute drawn dashed vs `knowledge/confluence.md`: a break is labelled "GPS gap" only when the tracker went quiet; no 1-minute rule — absent (planned)
- Run end phase, 30-minute next-run switch and "Run ended" label — absent from `knowledge/`
- Mid-run substitution overlap is a known gap until the new Dispatch — absent
- Forms schema in a dev sandbox copy of HRCE vs `knowledge/environments.md`: no such database — absent

## Confirms

- Ride Support code is not built yet; schema stage — `knowledge/domain.md`

## Action items

- [ ] Show more than one active run per vehicle when runs overlap — owner: Vladislav Derbenev — [25:10](https://fathom.video/calls/905702126?timestamp=1510)
- [ ] Update ticket 3214 ("Run ended" label); create a ticket for an "Ended" status with filters — owner: Vladislav Derbenev — [32:10](https://fathom.video/calls/905702126?timestamp=1930)
- [ ] Create a ticket: GPS gaps over 1 minute as dashed lines — owner: Vladislav Derbenev — [38:20](https://fathom.video/calls/905702126?timestamp=2300)
- [ ] Share the inspection schema walkthrough transcript with Drew Weeks — owner: Tommy Zwirblia — [42:09](https://fathom.video/calls/905702126?timestamp=2529)
- [ ] Schedule the Discipline requirements and API session — owner: Tommy Zwirblia — [44:59](https://fathom.video/calls/905702126?timestamp=2699)
- [ ] Review the sandbox schema changes to existing tables — owner: Michel Walther — [53:18](https://fathom.video/calls/905702126?timestamp=3198)
