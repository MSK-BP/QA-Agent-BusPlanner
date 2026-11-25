# Mobile app product and process knowledge transfer (2026-11-24)

- **Recording:** https://fathom.video/calls/905359612
- **Class:** qa-core
- **Source read:** summary only
- **Duplicates skipped:** 206564828, 206564110, 206563932
- **Areas:** Mobile apps, Ride Support (Discipline), Environments and access, QA process and priorities
- **Dropped:** AI summary sections that rate the team (readiness, engagement, adoption confidence)

## Decisions

- Mobile app testing moves from developers to the QA team — owner: Nikki Tilano — decided — [00:35](https://fathom.video/calls/905359612?timestamp=35)
- Quick Codes that point the apps at QA1/QA2 back ends get a one-time setup — owner: Mitchell Bland, Stephen Hu — decided (summary only) — [10:30](https://fathom.video/calls/905359612?timestamp=630)
- Emran Moradian prepares to own the store submission process — owner: Emran Moradian — stated (summary only) — [19:47](https://fathom.video/calls/905359612?timestamp=1187)

## Positions and concerns

- **Build distribution to QA:** Ibrahim Usman proposed Firebase App Distribution (free tier) for Android builds; Mitchell Bland: a viable option, discussed before — [08:38](https://fathom.video/calls/905359612?timestamp=518)
- **Debug tools:** Nikki Tilano asked for debug menus; Mitchell Bland and Emran Moradian: they exist in debug builds only; accessible debug toggles are future tech debt — [18:00](https://fathom.video/calls/905359612?timestamp=1080)

## Rules and facts

- Delays: alert app; delay, breakdown and weather notices posted from BP Web reach parents — stated — [02:50](https://fathom.video/calls/905359612?timestamp=170)
- Chipmunk: parent app for live bus location, ETA, alerts and student details; has a chatbot; no BPU integration yet — stated — [03:23](https://fathom.video/calls/905359612?timestamp=203)
- Turns: driver app, mainly on vehicle-mounted Android tablets (landscape and portrait); navigation, student scans, bus substitutions, pre/post-trip inspections configured in BP Quick; driver clock-in/out to BPU with employee code and PIN — stated — [03:42](https://fathom.video/calls/905359612?timestamp=222)
- Ride Support in Turns connects to BPU in 1 to 2 months; drivers submit positive or negative student reports to school and district staff — stated — [05:23](https://fathom.video/calls/905359612?timestamp=323)
- iOS builds go through TestFlight (Apple Developer team membership needed); approved builds are promoted to release — stated — [06:42](https://fathom.video/calls/905359612?timestamp=402)
- Android builds: release APK uploaded to cloud storage, shared by QR code, installed with external downloads enabled; the tested APK goes to Google Play — stated — [07:33](https://fathom.video/calls/905359612?timestamp=453)
- An app reaches a back end through a Quick Code; earlier Beta 1, from now QA1 or QA2 — stated — [10:30](https://fathom.video/calls/905359612?timestamp=630)
- Turns navigation tests use a built-in location spoofer that plays pre-generated points along a run; choosing another run path simulates a deviation; a recorded live drive (coordinates and times) can be replayed on another device. No third-party mock-location app — stated (Mitchell Bland) — [16:01](https://fathom.video/calls/905359612?timestamp=961), [16:56](https://fathom.video/calls/905359612?timestamp=1016), [23:03](https://fathom.video/calls/905359612?timestamp=1383), [23:45](https://fathom.video/calls/905359612?timestamp=1425)
- The regression documentation is out of date and omits Delays; Stephen Hu updates the master regression sheet with the .NET 9 regression findings — stated — [25:25](https://fathom.video/calls/905359612?timestamp=1525)

## Defects and risks

- QA has no physical test devices yet; hands-on mobile testing waits for devices and Quick Code setup — [15:26](https://fathom.video/calls/905359612?timestamp=926)

## Open questions

- Which devices does QA get, and what navigation testing scope applies?

## Differs from knowledge base

- QA owns mobile testing; TestFlight and APK-by-QR distribution; QA1/QA2 Quick Codes — updates `access.md` row A2 (needs APK, QA quick code, tablet or emulator; pipeline shows no artifacts)
- Turns location spoofer and drive replay — absent (`repos/Apps.md`)
- Mobile regression plan exists but is outdated — updates `INDEX.md` Known holes ("no regression checklist")

## Confirms

- Turns, Chipmunk, Delays are the apps — `repos/Apps.md`, `domain.md`

## Action items

- [ ] Provide QA devices; agree navigation test scope with Tommy Zwirblia and Andy Tompkins — owner: Nikki Tilano — [15:34](https://fathom.video/calls/905359612?timestamp=934)
- [ ] Send the app development workflow documents to QA — owner: Nikki Tilano — [14:42](https://fathom.video/calls/905359612?timestamp=882)
- [ ] Update the regression plan; Mitchell Bland reviews; then to Nikki Tilano for QA — owner: Stephen Hu — [25:14](https://fathom.video/calls/905359612?timestamp=1514)
- [ ] Device shipment status — owner: Mitchell Bland — [22:07](https://fathom.video/calls/905359612?timestamp=1327)
