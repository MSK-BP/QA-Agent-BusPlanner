# Turns: undo student scans and driver scan-card login (2026-11-24)

- **Recording:** https://fathom.video/calls/906837081
- **Class:** qa-core
- **Source read:** summary only
- **Areas:** Mobile apps, Ridership, Auth

## Positions and concerns

- **Undo a manual scan:** drivers want to undo an accidental manual scan (not a student card scan). Three options, none chosen:
  1. Hard delete: low effort; risk of client backlash, no audit trail.
  2. Soft delete: high effort; an `is_deleted` column on the scan card table (BP Pro database change, summary only) plus changes to all reports and queries; keeps the audit trail.
  3. 30-second undo window in the app before the write: conflicts with the US sales priority for sub-second Chipmunk notifications, important in competitive demos.
  Awais Akram checks with product and sales whether a hard delete is acceptable — tentative — [01:07](https://fathom.video/calls/906837081?timestamp=67), [02:09](https://fathom.video/calls/906837081?timestamp=129), [09:53](https://fathom.video/calls/906837081?timestamp=593)
- **Driver sign-in by card:** current RFID readers act as keyboards and type a number-only value; a number-only "password" can be read by any NFC phone and gives access to student data. Secure path: NFC driver cards, reader compatibility check, long alphanumeric card values (for example 64 characters) — tentative — [14:34](https://fathom.video/calls/906837081?timestamp=874), [16:24](https://fathom.video/calls/906837081?timestamp=984), [18:49](https://fathom.video/calls/906837081?timestamp=1129)
- **Sync Turns users from BP Quick:** a "very big project"; BP Service Administration (manages Turns users) is a Web Forms app with no API; an iFrame needs a separate sign-in; only viable after Turns is on the New World platform — stated — [20:44](https://fathom.video/calls/906837081?timestamp=1244), [22:24](https://fathom.video/calls/906837081?timestamp=1344), [23:42](https://fathom.video/calls/906837081?timestamp=1422)

## Rules and facts

- Undo applies only to manual driver scans, not to student card scans — stated — [01:21](https://fathom.video/calls/906837081?timestamp=81)
- Turns users are managed in BP Service Administration, a Web Forms app with no public API — stated (summary only) — [22:24](https://fathom.video/calls/906837081?timestamp=1344)

## Defects and risks

- Security risk: number-only RFID values as sign-in secrets would expose student data — [16:24](https://fathom.video/calls/906837081?timestamp=984)

## Open questions

- Is a hard delete of manual scans acceptable without an audit trail?
- Do NFC driver cards work with the existing RFID readers?

## Differs from knowledge base

- Undo of manual scans and card sign-in for drivers under study — absent (`repos/Apps.md`; `jira/eng-0001-0400.md` ENG-154 only says manual scans are marked manual)
- Turns users live in BP Service Administration with no API — absent (`architecture.md`)

## Action items

- [ ] Hard delete acceptable? Chipmunk latency conflict — owner: Awais Akram — [05:49](https://fathom.video/calls/906837081?timestamp=349)
- [ ] Ask the card vendor about secure NFC sign-in — owner: Awais Akram — [24:05](https://fathom.video/calls/906837081?timestamp=1445)
- [ ] Tell sales that BP Quick user sync waits for the New World — owner: Awais Akram — [23:31](https://fathom.video/calls/906837081?timestamp=1411)
