# Engineering Deep Dive (2026-11-23)

- **Recording:** https://fathom.video/calls/911927762 (5 more recordings of the same meeting: 205888234, 205875421, 205872441, 205871840, 205865407)
- **Class:** qa-core
- **Source read:** summary + transcript
- **Areas:** QA process and priorities, Environments and access, ETL, Ride Support (Discipline), Auth, Chatbot, GPS+ Path & Stop Compare

## Decisions

- QA pivots to Time & Attendance (T&A) this week so a US-only T&A release can go out; then QA returns to the New World backlog — owner: Tommy Zwirblia, Nikki Tilano — decided — [05:45](https://fathom.video/calls/911927762?timestamp=345), [08:00](https://fathom.video/calls/911927762?timestamp=480)
- Chatbot QA for the Canadian New World promote is reduced to "enough to know" it causes no regression, because no client has the chatbot enabled there — owner: Nikki Tilano — stated — [05:02](https://fathom.video/calls/911927762?timestamp=302), [05:45](https://fathom.video/calls/911927762?timestamp=345)
- After the T&A client's production database is restored to staging, QA validates the export against a "known good" export that Tommy Zwirblia supplies — owner: Tommy Zwirblia — decided — [08:00](https://fathom.video/calls/911927762?timestamp=480)
- Landmark weekly copy script (ENG-3058) is Old World work; it is changed to handle Staff and Vehicles this week so the 2026-11-27 run can be switched back on. Owner: Matthew Hayes, assigned by Murtaza Khalil (the AI summary names Murtaza Khalil; the transcript and all action-item lists name Matthew Hayes). Drew Weeks stays on Discipline — decided — [11:34](https://fathom.video/calls/911927762?timestamp=694), [17:12](https://fathom.video/calls/911927762?timestamp=1032)
- Ride Support on Turns must be behind a real sign-in, not the T&A employee PIN, because referrals show student PII — owner: Tommy Zwirblia — decided — [21:20](https://fathom.video/calls/911927762?timestamp=1280), [33:00](https://fathom.video/calls/911927762?timestamp=1980)
- Feature detection for Ride Support on Turns follows the current Turns pattern (as for Ridership and T&A), to touch Turns less — owner: Tommy Zwirblia — decided — [46:53](https://fathom.video/calls/911927762?timestamp=2813)
- Ride Support data uses New World keys (riders, runs); runs come from the New World snapshot tables, riders from the static New World list — owner: Tommy Zwirblia — decided — [47:44](https://fathom.video/calls/911927762?timestamp=2864)
- Ride Support has an offline mode: a driver can write and submit a referral with no signal; the form JSON template on the device holds everything needed — owner: Tommy Zwirblia — decided — [53:55](https://fathom.video/calls/911927762?timestamp=3235), [55:00](https://fathom.video/calls/911927762?timestamp=3300)
- A referral started on a form version is finished on that version; submit against a version older than the newest one is allowed; a new referral takes the latest version the device has — owner: Tommy Zwirblia — decided — [55:00](https://fathom.video/calls/911927762?timestamp=3300), [56:29](https://fathom.video/calls/911927762?timestamp=3389)
- Suspended-rider alerts (FRT8, at the bus door through Old World Ridership) are not in V1 — owner: Tommy Zwirblia, Stephen Hu — decided, pending the sales check below — [59:05](https://fathom.video/calls/911927762?timestamp=3545), [1:01:00](https://fathom.video/calls/911927762?timestamp=3660)
- A driver can write a referral for any student in the system, found by student search, not only students on the driver's run (same as manual scan-on in Ridership) — owner: Tommy Zwirblia — decided — [1:09:45](https://fathom.video/calls/911927762?timestamp=4185), [1:10:29](https://fathom.video/calls/911927762?timestamp=4229)
- Discipline stories are written one epic ahead; the repo is the source of truth and Claude updates Jira from it; after Wave 1, its measured effort is used to estimate the rest — owner: Tommy Zwirblia — stated — [1:14:43](https://fathom.video/calls/911927762?timestamp=4483), [1:15:39](https://fathom.video/calls/911927762?timestamp=4539), [1:16:11](https://fathom.video/calls/911927762?timestamp=4571)

## Positions and concerns

- **Promote T&A to stage before full QA:** Sharaiz Khan would accept a promote to stage for the T&A client only as an exception, and not to production without QA; normal process is QA before stage. Tommy Zwirblia: do nothing out of the ordinary; restoring production databases to stage should become a regular process, this is the forcing function — [00:03](https://fathom.video/calls/911927762?timestamp=3), [00:32](https://fathom.video/calls/911927762?timestamp=32)
- **T&A scope for US:** Nikki Tilano counts about 10 T&A tickets; the 2026-11-18 promote went to Canadian clients only. Shikhar Patel expects more, because several New World promotes happened since the last US deployment — [01:51](https://fathom.video/calls/911927762?timestamp=111), [08:53](https://fathom.video/calls/911927762?timestamp=533)
- **Ride Support sign-in options:** (a) separate sign-ins for Ridership and Ride Support (Tommy Zwirblia's first option; Stephen Hu: drivers would sign in twice, two places to create users); (b) one sign-in with a behind-the-scenes sign-in to the other system. Shikhar Patel is "not thrilled" but accepts moving drivers to individual accounts; in the Old World almost nobody creates individual accounts. Direction: assume drivers keep signing in to BPInfo REST and Unified signs them in automatically; Stephen Hu researches it, including user mapping and email change — tentative — [24:27](https://fathom.video/calls/911927762?timestamp=1467), [31:26](https://fathom.video/calls/911927762?timestamp=1886), [37:26](https://fathom.video/calls/911927762?timestamp=2246), [41:12](https://fathom.video/calls/911927762?timestamp=2472)
- **Suspended-rider alerts and seating charts:** the requirement came from New Caney, whose current system shows suspended students. Matthew Hayes checks with sales (Josh) whether V1 can ship without it, and gathers seating-chart needs; BP Pro seating charts have many rules (auto-build, sort orders, distancing) — open — [1:01:00](https://fathom.video/calls/911927762?timestamp=3660), [1:06:45](https://fathom.video/calls/911927762?timestamp=4005)
- **Estimating Discipline:** Murtaza Khalil worries that without all stories in Jira the team learns too late that it needs more developers; Tommy Zwirblia answers that Claude estimates the rest from Wave 1 effort — [1:13:06](https://fathom.video/calls/911927762?timestamp=4386), [1:16:11](https://fathom.video/calls/911927762?timestamp=4571)

## Rules and facts

- The Landmark server receives a weekly copy of three Old World client databases; ETL Extract loads New World from it. The download script runs Saturday morning, the upload Friday night. Only the Landmark-side script was paused — stated — [12:31](https://fathom.video/calls/911927762?timestamp=751), [14:01](https://fathom.video/calls/911927762?timestamp=841), [15:28](https://fathom.video/calls/911927762?timestamp=928)
- Turns today: navigation and Ridership sign in as an Old World (BPInfo REST) driver; T&A signs in with an employee PIN to New World — stated — [22:59](https://fathom.video/calls/911927762?timestamp=1379), [23:21](https://fathom.video/calls/911927762?timestamp=1401)
- New World user manager lets a user change their email — stated — [41:12](https://fathom.video/calls/911927762?timestamp=2472)
- New World customer stand-up recreates Old World Quick users as New World users (done for Landmark); REST users are a different set — stated — [39:00](https://fathom.video/calls/911927762?timestamp=2340)
- "Ride Support" is the current working name, not final; "Discipline" stays in use — stated — [23:21](https://fathom.video/calls/911927762?timestamp=1401)

## Plans

- PLANNED: full list of T&A tickets in US staging, then QA effort estimates the same day (Shikhar Patel, Nikki Tilano, Murtaza Khalil, Yusra Abbasi) — tentative — [09:55](https://fathom.video/calls/911927762?timestamp=595)
- PLANNED: Bus Compare page gets an extra row for stored visits; a rank-display fix is in an open PR (Vladislav Derbenev) — stated — [18:00](https://fathom.video/calls/911927762?timestamp=1080)
- PLANNED: Stephen Hu lists API tickets (green rows in his sheet) for the API that Unified and Turns call; Drew Weeks confirms which need Jira tickets — tentative — [20:06](https://fathom.video/calls/911927762?timestamp=1206)

## Environments, access, branching, CI/CD, release

- The T&A client's production database is to be restored to staging; this becomes a repeated process to keep stage data fresh — tentative — [00:32](https://fathom.video/calls/911927762?timestamp=32)

## Defects and risks

- Risk: US environments are several New World promotes behind Canada; T&A items may be in staging untested for the US — [08:53](https://fathom.video/calls/911927762?timestamp=533)
- Risk: New Caney was sold parity with its current system; V1 lacks suspended-rider alerts and seating charts — [1:01:00](https://fathom.video/calls/911927762?timestamp=3660)
- Second-device and MDM handling for offline referrals is not decided — [51:34](https://fathom.video/calls/911927762?timestamp=3094)

## Open questions

- How does a driver signed in to BPInfo REST get signed in to Unified, and how are users matched when an email changes? (Stephen Hu researching)
- Can New Caney accept V1 without suspended-rider alerts and seating charts?

## Differs from knowledge base

- Ride Support sign-in: real sign-in, not PIN; REST-to-Unified auto sign-in under study — absent (`domain.md` Ride Support section has no sign-in rule; only T&A PIN, `domain.md` line 19)
- Offline referral submit decided — answers "P1 Turns offline rider data" in open items (`domain.md`, "Open items that affect QA")
- Referral for any student in the system — absent (`domain.md`)
- Suspended-rider alerts not in V1 — absent; `domain.md` V1 "Not in V1" lists letters, emergency incident report, seating chart, automated notifications, but not suspended-rider alerts
- QA pivot to T&A this week; chatbot QA reduced to regression on CA — updates QA priority (no QA-order line in `test-strategy.md`; earlier meeting order in meetings INDEX)
- Landmark ENG-3058 weekly copy script paused, change due for 2026-11-27 — absent (no file names ENG-3058)

## Confirms

- "A published form version never changes; a draft keeps its version, and submit accepts it after a newer version is published" — `domain.md` (FE handoff, D47)
- Seating chart not in V1 — `domain.md` V1 scope (D39)
- Landmark/NPSSTS is a New World stand-up client — `confluence.md`

## Action items

- [ ] Known-good T&A export for QA validation — owner: Tommy Zwirblia — [07:50](https://fathom.video/calls/911927762?timestamp=470)
- [ ] Full list of US T&A tickets in staging; QA estimates — owner: Shikhar Patel — [09:06](https://fathom.video/calls/911927762?timestamp=546)
- [ ] Change ENG-3058 script for Staff and Vehicles; switch on for the 2026-11-27 run — owner: Matthew Hayes — [17:23](https://fathom.video/calls/911927762?timestamp=1043)
- [ ] Review green API rows; confirm tickets with Stephen Hu — owner: Drew Weeks — [19:55](https://fathom.video/calls/911927762?timestamp=1195)
- [ ] Design REST-to-Unified auto sign-in, user mapping, email change — owner: Stephen Hu — [37:18](https://fathom.video/calls/911927762?timestamp=2238)
- [ ] Check with sales on deferring suspended-rider alerts; gather seating-chart needs vs BP Pro — owner: Matthew Hayes — [1:01:11](https://fathom.video/calls/911927762?timestamp=3671), [1:03:22](https://fathom.video/calls/911927762?timestamp=3802)
- [ ] Share Discipline epics and stories with Jon Borromeo; Wave 1 estimate — owner: Murtaza Khalil — [1:12:55](https://fathom.video/calls/911927762?timestamp=4375)
