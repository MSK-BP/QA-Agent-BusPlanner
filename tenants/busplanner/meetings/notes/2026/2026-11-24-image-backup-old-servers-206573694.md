# Image backup of old servers (2026-11-24)

- **Recording:** https://fathom.video/calls/913529693
- **Class:** qa-context
- **Source read:** summary only
- **Areas:** Environments and access, Old World SaaS migration

## Decisions

- Old IBM servers are backed up as an IBM image template, then exported to Object Storage; this replaces Pulseway RMM backups for these servers — owner: Andy Tompkins — decided — [08:46](https://fathom.video/calls/913529693?timestamp=526), [09:15](https://fathom.video/calls/913529693?timestamp=555)
- Image name format `ClientName-ServerName-YYYY-MM-DD`; all disks included; the server is shut down first — owner: Andy Tompkins, Caroline — decided — [02:01](https://fathom.video/calls/913529693?timestamp=121), [03:12](https://fathom.video/calls/913529693?timestamp=192), [07:49](https://fathom.video/calls/913529693?timestamp=469)
- The first server gets a full restore test from Object Storage before it is deleted; later servers do not — owner: Andy Tompkins — decided — [12:09](https://fathom.video/calls/913529693?timestamp=729)

## Rules and facts

- All old servers in scope must be decommissioned by the end of the month — stated — [15:35](https://fathom.video/calls/913529693?timestamp=935)
- The IBM portal's "stopped" status is often wrong; it gives no ETA during image creation — stated — [05:16](https://fathom.video/calls/913529693?timestamp=316), [07:49](https://fathom.video/calls/913529693?timestamp=469)

## Differs from knowledge base

- Old servers decommissioned by month end with image backups — absent (`architecture.md` Old World not onboarded)

## Action items

- [ ] Export the first image and verify a restore (2026-11-25) — owner: Andy Tompkins, Caroline, Barry — [13:38](https://fathom.video/calls/913529693?timestamp=818)
- [ ] Check permissions needed for the Object Storage export — owner: Andy Tompkins — [15:00](https://fathom.video/calls/913529693?timestamp=900)
