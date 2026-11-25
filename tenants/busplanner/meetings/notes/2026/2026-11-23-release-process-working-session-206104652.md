# Release Process Working Session: hotfix and P0 process (2026-11-23)

- **Recording:** https://fathom.video/calls/909167337 (second recording: 206098688)
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** Release and branching, QA process and priorities

A personal matter at the end of the meeting is left out.

## Decisions

- Goal: fewer hotfixes; a hotfix is the last resort. The number of hotfixes is a metric to track next year — owner: Nikki Tilano — stated — [03:40](https://fathom.video/calls/909167337?timestamp=220)
- The hotfix process applies only when a code change and a release are needed. Fixes without code (a configuration change by Dan; a direct database or server fix by Mitchell or Michelle) do not follow it — owner: Nikki Tilano; agreed by Amanda McInnis — decided — [14:01](https://fathom.video/calls/909167337?timestamp=841)
- A ticket goes through the normal escalation first; only if that fails and a developer says a code change is needed can it become a P0 — owner: Amanda McInnis, Nikki Tilano — decided — [16:00](https://fathom.video/calls/909167337?timestamp=960), [18:12](https://fathom.video/calls/909167337?timestamp=1092)
- Amanda McInnis, Tommy Zwirblia or Umar make the P0 call (Andy Tompkins' proposal, to be merged into Nikki Tilano's definitions doc) — owner: Andy Tompkins, Nikki Tilano — tentative — [03:40](https://fathom.video/calls/909167337?timestamp=220), [22:56](https://fathom.video/calls/909167337?timestamp=1376)
- Every P0 hotfix gets a "Control Center" Teams meeting with the relevant people, one person tracking the timeline, findings and expected release, and an RCA afterwards — owner: Nikki Tilano — stated — [09:00](https://fathom.video/calls/909167337?timestamp=540), [11:00](https://fathom.video/calls/909167337?timestamp=660)
- The Thursday CX session becomes a smaller working group (leads from CX, Support, Projects, plus Canadian CSMs) on the escalation and P0 process, with real examples; documentation comes out of it — owner: Amanda McInnis, Andy Tompkins — decided — [28:09](https://fathom.video/calls/909167337?timestamp=1689), [29:26](https://fathom.video/calls/909167337?timestamp=1766)

## Positions and concerns

- **Why fewer hotfixes:** Nikki Tilano: repeated hotfixes treated symptoms, not root cause, and cost client trust (Calgary Catholic example); hotfixes pull people off planned work and delay main and Fleet releases. Andy Tompkins: rushed hotfixes skip full QA and bring new bugs, then more hotfixes; extra tickets get pulled into a hotfix and delay it — [03:40](https://fathom.video/calls/909167337?timestamp=220), [14:01](https://fathom.video/calls/909167337?timestamp=841), [18:44](https://fathom.video/calls/909167337?timestamp=1124), [20:14](https://fathom.video/calls/909167337?timestamp=1214)
- **P0 examples needed:** Amanda McInnis wants prescriptive examples (is a whole module down a P0 or a P1? GPS+ fully down?); Andy Tompkins: much grey area. Nikki Tilano's example of a true hotfix: the Alberta time-zone GPS defect (no workaround, many clients). Security issues and legal impact also count — [12:01](https://fathom.video/calls/909167337?timestamp=721), [13:07](https://fathom.video/calls/909167337?timestamp=787), [17:36](https://fathom.video/calls/909167337?timestamp=1056)
- **Regressions:** Nikki Tilano: a regression is not a hotfix by default; it must make the next main release, unless it meets the P0 definition — stated — [09:00](https://fathom.video/calls/909167337?timestamp=540)
- **SLA:** Nikki Tilano proposes fix-time targets per priority (for example a P0 within about two days); not agreed — tentative — [03:40](https://fathom.video/calls/909167337?timestamp=220), [09:00](https://fathom.video/calls/909167337?timestamp=540)
- **Calendared deadlines:** ministry or state reporting and school opening are known in advance and should be built in early; school opening can raise a ticket's priority — Amanda McInnis — stated — [01:21](https://fathom.video/calls/909167337?timestamp=81)

## Rules and facts

- A customer site outage this morning (Niagara) was fixed by Dan without code; it did not need a P0 — stated — [16:18](https://fathom.video/calls/909167337?timestamp=978)
- The support backlog will be run through Claude first to find already-fixed or duplicate tickets, then walked through with CSMs and Support — stated — [02:40](https://fathom.video/calls/909167337?timestamp=160)

## Plans

- PLANNED: Nikki Tilano turns the P0/P1 definitions doc into a deck with examples and the non-code path; review by end of week — decided — [22:56](https://fathom.video/calls/909167337?timestamp=1376), [30:28](https://fathom.video/calls/909167337?timestamp=1828)
- PLANNED: Wednesday session "How Product and Engineering Works" (Tommy Zwirblia): process complexity, SOC compliance, the feature-request backlog, enterprise vs weekend prototypes — stated — [26:25](https://fathom.video/calls/909167337?timestamp=1585), [27:26](https://fathom.video/calls/909167337?timestamp=1646)

## Open questions

- Which module outages are P0 and which P1?
- Will engineering commit to fix-time SLAs per priority?

## Differs from knowledge base

- Hotfix only for code changes, after normal escalation, approved by Amanda McInnis / Tommy Zwirblia / Umar, with Control Center and RCA — updates `process.md` (hotfixes go out the same or next day with targeted regression; RCA pages exist for incidents, PE/256081921)
- No severity/priority definitions exist — `knowledge/INDEX.md` "Known holes" lists "severity/priority definitions" as not documented; a draft P0/P1 doc now exists (Nikki Tilano), not yet read
- A regression goes into the next main release unless it is a P0 — absent (`process.md` says "A regression failure is fixed forward through `dev`", for release regression testing)

## Confirms

- RCA pages for incidents, e.g. the Alberta GPS-time incident — `process.md` (PE/256081921)
- Hotfixes share the Stage slot and can delay a promote — `process.md`

## Action items

- [ ] Update definitions doc: merge hotfix authority, add the non-code path and P0 examples; share — owner: Nikki Tilano — [22:45](https://fathom.video/calls/909167337?timestamp=1365)
- [ ] Reduce the Thursday CX session invite list to leads plus Canadian CSMs — owner: Amanda McInnis — [29:15](https://fathom.video/calls/909167337?timestamp=1755)
- [ ] Clean up example slides; send to Nikki Tilano — owner: Amanda McInnis — [31:05](https://fathom.video/calls/909167337?timestamp=1865)
