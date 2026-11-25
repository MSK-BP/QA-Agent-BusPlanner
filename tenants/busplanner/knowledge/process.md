# Process: how work flows at BusPlanner

> Sourced 2026-11-10 from Confluence space PE and Jira (site `busplanner.atlassian.net`). Slack could not be read (see "Slack channel directory"). Items marked UNVERIFIED are inferences.
>
> `PE/<id>` = `https://busplanner.atlassian.net/wiki/spaces/PE/pages/<id>`.
>
> Updated 2026-11-10 after a full read of every non-PRD page in space PE and of the personal spaces. The complete rule set, with the page inventory, is in `confluence.md`; where the two differ, `confluence.md` section 2 is the fuller version.

## Jira projects

Source: Jira project list, 2026-11-10 (6 projects visible to the connected account).

| Key | Name | What it is for | Source |
|---|---|---|---|
| ENG | Development | All engineering work: epics, stories, tasks, bugs, sprints, fix versions | PE/174850052 |
| PROD | Product Management | Feature Requests (the "why/what"). Every ENG epic must be a child of a PROD Feature Request. Statuses: Backlog, To Do, Gathering Requirements, Scheduled, Ready for Development, In Progress, User Acceptance Testing, Approved for Release, On Hold, Declined, Done | PE/174850052; Jira statuses |
| SPT | Support Queue | Client-reported issues from CX/support, usually with a Zendesk ticket. Reviewed in a daily triage call; chosen tickets are moved (not copied) to ENG. Statuses: Backlog, Ready for Development, In Progress, On Hold, Done | PE/174850052; Jira statuses |
| IN | Infrastructure | Infrastructure / DevOps and incidents (e.g. IN-221 GPS time incident, IN-45 backups, IN-213 server memory) | PE/256081921, PE/195297284, ENG-3043. Purpose UNVERIFIED beyond these examples |
| SOC | BusPlanner SOC2 | SOC 2 compliance work. UNVERIFIED (name only) | Jira project list |
| MDP | My discovery project | Jira Product Discovery sandbox. UNVERIFIED (name only) | Jira project list |

## ENG issue types (PE/174850052)

```
Feature Request (PROD)
  -> Epic (ENG)
       -> Story / Task / Bug / Bug - ENG
            -> Sub-task
```

| Type | Use | Origin |
|---|---|---|
| Epic | Groups the work for a feature | Child of a PROD Feature Request |
| Story | Client-facing functionality | Epic |
| Task | Internal engineering work (infra, refactor, spike, docs) | Epic or standalone |
| Bug | Defect reported by a client or CX | SPT via daily triage; Zendesk ticket where possible |
| Bug - ENG | Defect found internally by a developer or QA (the issue-type guide spells it "Bug - Eng") | No SPT/Zendesk needed. **This is the type QA uses** (PE/235470851) |
| Sub-task | Split of a parent; aim for at most 5-6 | Parent |
| Also present in Jira, undocumented | Feature, Product, Dev Question, Workflow | Jira statuses API. Stand-up note: "10-15 min is roughly when move a question to a bug" (PE/9699329; reading it as about Dev Question is UNVERIFIED) |

Rules from the issue-type guide (PE/174850052): an Epic is never created on ENG without a parent Feature Request on PROD; a Bug on ENG without an SPT origin "may have been created incorrectly"; the SPT ticket is moved to ENG, not copied, so its number and Zendesk reference travel with it; feature requests are never created directly on ENG.

## ENG workflow and where QA acts

Statuses on Story / Task / Bug / Bug - ENG (Jira statuses API): Open, Reopened, Investigation, In Progress, Blocked, Code Review, Ready for QA, QA Review, Approved for Release, Resolved, RELEASED. Epics use a separate set: Open, Ready for Development, In Progress, On Hold, In QA, QA Approved, Resolved.

Flow for Old World (Main and Fleet), from PE/235175938 and PE/50429953:

1. Dev opens a PR into `dev` (Azure DevOps). Ticket is in **Code Review**.
2. **QA gate:** the PR cannot merge without one approval from the QA Reviewers group (PR-APPROVERS: Nikki, Murtaza, Andy, Yusra, Hamad; normally QA, but engineering leads can approve must-have items).
3. PR merges -> ticket moves to **Ready for QA**. Code reaches **QA1** only after the next `dev` build (nightly, or a midday build requested in `#qa-env-updates`). Testing before that build lands means testing old code.
4. QA picks it up -> **QA Review**. Functional / first-pass testing on QA1 against the ticket's acceptance criteria. Running notes go in comments.
5. Pass -> **Approved for Release**, after writing what was tested and why it passes in the ticket's QA Notes tab. This status decides what survives the weekly promote.
6. Wednesday: whole `dev` branch promoted to `stage` -> deployed to **QA2**.
7. Thursday, Friday, Monday: **regression** on QA2 (combined batch, not per ticket). A regression task is created per release, e.g. "[QA] 12.4.13 Miami Fleet - Regression Testing" (PE/205389841).
8. Tuesday: release to production (`main`) -> **RELEASED**.
9. A regression failure is fixed forward through `dev` and the same gate, not by reverting.

Clarifications from the full read:
- Functional testing (QA1) checks one ticket against its acceptance criteria. Regression (QA2) checks the combined batch for side effects and does not re-test each ticket. A ticket must pass functional testing before it is eligible for regression (PE/235175938).
- Main, Fleet and hotfixes share one Stage slot; only one can occupy it at a time (PE/235175938).
- Hotfixes do not follow steps 6-8. The calendar shows them promoted and released the same or next day, with "QA Targeted Regression Testing" or, once, "regression testing deemed not needed" (PE database 59998210).
- The 3-working-day regression window is the plan. In September regular releases spent 1-2 days on Stage (13.2.5: Sep 15 -> 16; 12.4.12: Sep 21 -> 22; 13.3.0: Sep 29 -> Oct 1) (PE database 59998210).
- PE/50429953 is the July proposal that introduced the gate. It says BusPlanner has "only the existing Stage environment"; the October page describes QA1 and QA2. Which describes the hardware today is UNVERIFIED.
- "Resolved" means waiting for the reporter to confirm the fix (PE/185204738).
- Midday builds are described as a temporary answer to QA running out of work (PE/50429953).

Finding your queue: the **QA Reviewer** field (multi-user) names the tester; the Dev board has a "My QA Items" quick filter (PE/235175938).

BP Unified (New World): separate repo, branches `dev` / `staging` / `main`, own environment, does not use QA1/QA2 (PE/235175938). The same Jira statuses are used on Unified tickets (e.g. ENG-3030 Ready for QA, ENG-773 QA Review). The Unified promote/release schedule is not documented in these sources.

What is written for New World:
- Three environments per country: dev, staging, prod. Each runs its own branch's migrations; the ETL image is built as `dev-latest` and retagged for staging and prod (PE/157450256, PE/251756545).
- The one QA rule: "Run the health check in prod, where the customer will look. If a check fails, fix in dev, run a full regression in stage, then promote to prod. The full QA sequence is to be written up by Shikhar." (PE/157450256). That write-up was not found.
- Customer stand-up health check: Q.1 vehicle count matches old-world GPS+; Q.2 GPS data arriving for every vehicle; Q.3 routes and mappings match old-world GPS+; Q.4 substitutions and substituted vehicles flow through; Q.5 stop classification working as expected; Q.6 product flags show and hide the right menus. Then H.1 confirm every QA check passed, H.2 hand over to Customer Success, H.3 close the Jira stand-up item (stories under ENG-2417) (PE/157450256).
- Stand-up agenda items ("NW Release Plan", "New world to Stage and Prod", "Skip dev. Skip stage??", "Mid day deploy to ca-dev unified?") show the release path is still being agreed (PE/9699329).
- Feature handoff: developers write a "QA & Product Handoff" page per feature (use cases, scenarios, business rules, limitations, roles, test accounts needed). Three exist, all GPS+ (PE/138313730, PE/137822221, PE/139231233). The practice came from a deep-dive item "Dev -> QA Handoff Documentation" (PE/87031810).

Sprints: two weeks, Monday kickoff/planning to Friday retrospective (PE/59310084, marked "In progress"). Current: "ENG Sprint 91", 2026-10-31 to 2026-11-13 (Sprint field on ENG-3043). Unfinished tasks roll over or return to the backlog. Earlier sprints per the calendar: 83 Jul 13-24, 84 Jul 27-Aug 7, 85 Aug 10-21, 86 Aug 24-Sep 4, 87 Sep 7-18, 88 from Sep 21 (PE database 59998210).

Meetings with a Confluence agenda: Daily Standup (PE/9699329) and Deep Dive (PE/87031810). At-risk sprint items are reported to Nikki and Murtaza (PE/9699329). A daily triage call with support moves SPT tickets to ENG (PE/174850052). Engineers log hours (PE/9699329).

## Issue conventions

| Topic | Convention | Source |
|---|---|---|
| Acceptance criteria | No dedicated field. Written in the **Description** under "Acceptance criteria:" or "Done when". New World features also carry AC-n and QA test tables in PRD pages | ENG-773, ENG-3030, ENG-3043; PE/238485608 |
| QA Testing Notes (`customfield_10460`) | Dev-written "what to test", setup, what dev checked, what was not tested. Shown as the QA Notes tab; QA also records approval rationale there | ENG-3043, ENG-3030; PE/235175938 |
| QA Reviewer (`customfield_10304`) | Assigned tester(s) | ENG-3043 |
| Code Reviewer (`customfield_10693`) | PR reviewer | ENG-3043 |
| Client (`customfield_10392`) | Customer code + name; "BusPlanner" when found internally | PE/235470851 |
| Release Notes (`customfield_10660`) | Client-facing note text, feeds the release-notes pages | ENG-3043 |
| Affected Version | Release the bug was found on; may be blank if unknown | PE/235470851 |
| Fix Version | The release train and number, e.g. "13.4.4- BusPlanner Main", "11.2026 - New World" | Jira versions |
| Priority | Highest / High / Medium / Low / Lowest. Meant to reflect urgency (clients affected, workaround, blocks a release or deadline), not just severity. No separate severity field found. No page defines the levels or a severity scale (confirmed by the full read); release notes occasionally tag an item "(Critical)" or "(High)" | PE/235470851; Jira; PE/65667073, PE/57606145 |
| Bug template (PE/235470851) | Type Bug - ENG; Affected Version; Client; Priority; numbered repro steps from a known start incl. environment and data; **Expected** / **Actual**; screenshots when useful; link to the Story under test with "relates to". Examples: ENG-2853, ENG-2851, ENG-2357 | PE/235470851 |
| Summary style | `<Product>: <Module> - <symptom>` e.g. "BP Unified: Chatbot - ..."; client bugs `[ticket#] [CC-PP-CODE] - ...` or `ZD:nnnnn - ...` | Observed across ENG |
| Labels | Automation: `jira_escalated` (came from SPT), `jira_auto_reopened`, `pss-stamped`. Programme: `P30_BP_Unified`, `P28_Time_And_Attendance`, `BP_Unified_Chatbot_v1.0`, `BP_Unified_Chatbot_v1.5`. Others ad hoc (`triaged`, `reports`, ...). Meanings of `pss-stamped` and `triaged` are UNVERIFIED | Observed across ENG |
| Components | 12 exist, rarely used on bugs: "BP Unified Dispatch - Wave 1..8", "MVP - GPS+ Live Viewer", "MVP - Time and Attendance", "Chipmunk-Robustness", "Chipmunk-Tracker" | Jira components API |
| Bug grouping | Bugs are usually parented to a per-product bucket epic, e.g. ENG-2917 "BP Unified: Chatbot - Bugs", ENG-2646 mobile compliance bugs, ENG-81 Fleet, ENG-56 Chipmunk, ENG-76 BP Pro (bucket names partly UNVERIFIED) | Parent field on sampled bugs |

## Release cadence and announcements

Trains (Jira fix versions, ENG):

| Train | Version pattern | Cadence observed |
|---|---|---|
| BusPlanner Main (Old World) | `13.x.y - BusPlanner Main`, hotfixes `... - Hotfix` | Planned: promote Wednesday, release the following Tuesday, alternating weekly with Fleet. Actual: roughly weekly plus frequent hotfixes (e.g. 13.4.0 on Oct 29, 13.4.1 on Nov 4, 13.4.2 on Nov 6; 13.4.3 hotfix and 13.4.4 open) |
| Miami Fleet | `12.4.x - Miami Fleet` | About every two weeks (12.4.12 Sep 22, 12.4.13 Oct 6, 12.4.14 Nov 6; 12.4.15 open) |
| New World (BP Unified) | `11.2026 - New World`; earlier `2.8.10.2026 - New World` | Month-labelled; unreleased as of 2026-11-10. Cadence not documented |
| Mobile | `2.12.x - Chipmunk`, `2.x - Turns`, `2.4.x - Delays` | Ad hoc |
| Customer go-live | `T&A - Yankton` ("Go Live For Yankton") | One-off |

The schedule "is the usual cadence, not a guarantee" (PE/235175938). Main, Fleet and hotfixes share a single Stage slot, so a hotfix can delay a promote.

Counts from the 31 dev release-notes pages (Jul 15 to Nov 6): Main 8 releases / 155 issues; Main Hotfix 13 / 54; Miami Fleet 8 / 63; Chipmunk 1; Delays 1. Largest: 13.3.0 with 32 issues.

Upgrade coupling stated in release notes: components sharing a GeoIMS protocol version ship together (13000007 BP Web + GeoIMS, PE/178683906; 13000011, PE/232685569; 13000013 adds BP Quick, PE/256868354); Path Server with BP Pro and BPServer (PE/232685569); tracker fixes need the tracker updated separately (PE/169639937). Fleet upgrades at one customer must finish before an 8:15 pm cost export (PE/210960386).

How releases are announced (what the sources show):
- A Confluence page per release, auto-titled "Release Notes - Development - <version> - <timestamp>", created by Nikki Tilano from Jira's release-notes template: property table, issue table, then notes. Since 2026-09-02 notes are grouped by product; since 13.3.0 most items carry a "Setup:" line with settings, defaults and upgrade order (e.g. PE/262406145 for 13.4.2). No page records QA sign-off, test results or the environment tested. Only one lists a QA task (ENG-2441, PE/205389841).
- A running client-facing page: "Client Facing Release Notes" (PE/242876418), newest first, from October 2026 (13.3.0.235 to 13.4.1.231), last edited by Murtaza Khalil. One sentence per change, no ENG keys or client names; a subset of the dev notes. It can disagree with the dev notes (the ridership suite is 13.4.0 in dev notes, 13.4.1 client-facing). Older client notes are in a Word document on SharePoint.
- A calendar database "Important Dates - Engineering - 2026" (PE database 59998210) with sprint kickoffs, stage promotions and release dates; each release row links its notes page. Its last row is 2026-10-02, so it is not current.
- Release-note timing is a stand-up topic ("External Release Note Timing", PE/9699329).
- Build/deploy times for QA1 are posted in `#qa-env-updates` (stated in PE/235175938; not read).
- Whether releases are also announced in a Slack channel: NOT FOUND (Slack unreadable).

Incidents get an RCA page under the "RCA's" folder, e.g. PE/256081921 (GPS times 60 minutes behind for one province after a time-zone rule change; fixed in 13.4.2 by ENG-2971). The page has: summary, field table (incident ticket in IN, severity, detected, mitigated, fix version, incident lead, fix owner, customer validation, escalation/comms), impact, timeline, 5-whys, contributing factors, action items, lessons. A client-facing RCA is derived from it. QA-relevant lessons: agree who verifies in the GUI before an overnight rollout; that hotfix was built, tested and rolled out by one developer from a local machine before the formal build; two BP Web pages were left "not yet validated or QA'd".

Retrospective (PE/158662658) actions that touch QA: a Jira label at intake for school-opening tickets; a clearer bar for support ticket detail before engineering; resolved tickets must carry a root-cause/fix summary; remaining Azure DevOps tickets migrate to Jira; no hard product deadlines in the Aug-Sep window.

## Slack channel directory

**Slack was not readable in this pass.** The connected account belongs only to `#all-busplanner` (company announcements; contained a single join message) and `#social`. Channel and message search returned no results. The list below is copied from Confluence (PE/235175938, "Important QA Slack Channels"), not observed in Slack. Recent content, release announcements, flaky-pipeline chatter and incident threads could not be reviewed.

| Channel | Purpose (per PE/235175938) | When QA should look |
|---|---|---|
| #qa-env-updates | QA1 build/deploy times; request a midday `dev` build | Before testing a Ready for QA ticket; when out of work |
| #qa-bppro | BP Pro bugs: QA posts the Jira link and tags the dev | After filing a BP Pro bug |
| #qa-bpweb | BP Web bugs | Same |
| #qa-bptrips | BP Trips bugs | Same |
| #qa-quick | BP Quick bugs | Same |
| #qa-fleet | BP Fleet bugs | Same |
| #qa-subscription-service | Subscription Service bugs | Same |
| #qa-unified-gpsplus | GPS+ on BP Unified bugs | Same; main channel for New World QA |
| #dev-general | Team-wide dev announcements: environment status, piloting notes, reminders | Daily |

Channels for T&A, Chatbot, releases, deployments or incidents: NOT FOUND.

## People directory

Roles are taken from what each person authored or was assigned; most are UNVERIFIED as job titles.

| Name | Role (evidence) | Ask them about |
|---|---|---|
| Nikki Tilano | Author of the QA/build process, bug guide, issue-type guide, sprint and release-train pages; in PR-APPROVERS. Delivery/QA process owner (UNVERIFIED title) | Process, release schedule, QA gate |
| Hamad Zeb | QA; most frequent QA Reviewer (36 of last 100 reviewed tickets): Fleet, BP Web, reports, Pro, Trips, Path Server; in PR-APPROVERS | Old World testing, QA1/QA2 |
| Yusra Abbasi | QA; QA Reviewer for GPS+, Chatbot, ETL; added the QA Q&A to the Live Viewer handoff; in PR-APPROVERS; "on chatbot and ETL testing" (PE/226918402) | BP Unified GPS+ and Chatbot testing |
| Wajeeha Batool | QA Reviewer for Time & Attendance; named as QA help in stand-up (PE/9699329) | T&A testing |
| Ali Janjua | QA Reviewer for Quick, Path Server | Quick testing |
| Maricar Benedictos | QA Reviewer for Fleet, reports; author of the GPS Plus User Manual (PE/225050641); named as QA help in stand-up | Fleet testing; GPS+ end-user behaviour |
| Murtaza Khalil | In PR-APPROVERS; reporter of escalations (ENG-3043); collects at-risk sprint items with Nikki; last editor of the client-facing release notes; owns the Azure DevOps-to-Jira migration with Nikki | Sprint risks, client release notes |
| Andy Tompkins | In PR-APPROVERS; author of GPS+ multi-day vehicle assignment design (PE/226918402); fix owner of the Alberta GPS-time incident (PE/256081921); load-testing first steps with Tommy (PE/87031810) | GPS readers, GPS+ substitutions, Old World internals |
| Tommy Zwirblia ("Tommy Z", "TZ") | Created the space home, stand-up and deep-dive pages; engineering decision owner (PE/226918402); escalation/comms on the RCA; author of the chatbot question scope (PE/137232386). Engineering lead (UNVERIFIED title) | New World priorities, chatbot scope, release plan |
| Shikhar Patel | Author of the stand-up checklist and GPS services scalability draft; device links; "full QA sequence to be written up by Shikhar" (PE/157450256) | GPS services, client stand-up, New World health checks |
| Vladislav Derbenev ("Vlad") | Author of the JWT page (PE/162430977); developer feedback on the Reassign Dashboard (PE/220561412) | Unified auth, Dispatch, GPS+ pages |
| Drew Weeks | Author of the substitution service setup (PE/156794883); supplies BP Info endpoints; builds the importer (PE/226918402) | BP Info, substitution import |
| Awais Akram | Author of requirement and analysis pages (API, Maryland reports, router requests, Reassign Dashboard, Trips feasibility). Product (UNVERIFIED title) | Requirements for Old World features, Dispatch |
| Amanda McInnis, Haley Ace, Chris MacLeod, Lauri-Ann Turnbull, Caroline Van Winden, Josh | Support / CX: escalation and comms, customer validation in the GUI, ticket quality (PE/256081921, PE/158662658) | Reproducing customer reports, verifying fixes with product knowledge |
| Binford Sloan | Customer success manager for a large Maryland district (PE/167837697) | Customer context |
| Mitchell Bland | Developer; code reviewer; QA Reviewer on Chatbot/Chipmunk tickets | Chatbot, Chipmunk |
| Janice Fritz | Developer; most frequent assignee in sample; Path Server, BP Pro, reports | Path Server, eligibility, Pro |
| Dong-Ik Lee | Developer; Fleet releases; code reviewer | Fleet |
| Michelle Prichard, Stephen Hu, Drew Weeks, Ibrahim Ali Asgher, Shikhar Patel, Vladislav Derbenev, Peter Xiao | Developers (assignees / release contributors) | Per ticket |
| Michel Walther | Author of the BP Unified client stand-up runbook and the three GPS+ handoff pages; owner of health check Q.1; raised "Dev -> QA Handoff Documentation" (PE/87031810). A "Mike" on stand-up pages may be the same person (UNVERIFIED) | Unified environments, ETL, stand-up, GPS+ rules |
| Daniel Sukhram | DevOps (named owner, PE/195297284) | Infrastructure, backups, environments |
| Ahnaf Rahman | Product; owner of Users and Access PRD and Turns PRD | Requirements, PROD tickets |
| Matthew Hayes | Publishes the Connected PRD pages; author of the old-world Dispatch escalations page (PE/185204738) | PRD content, Dispatch escalations |

No page lists the QA team. The retrospective speaks of "about 4 QA staff" (PE/158662658). The QA Reviewers group is "typically QA but Eng leads can approve items that must make it in" (PE/50429953).

## Confluence space directory

One global space plus 54 personal spaces (type = space search, 55 results).

| Space | Key | Notes |
|---|---|---|
| Product / Engineering | PE | The only team space; 212 items: 106 titled "PRD ..." and 106 others (76 pages, 1 database, 29 folders). Full inventory in `confluence.md` section 1 |
| Personal spaces | ~... | One per staff member, plus one named "BusPlanner Integrations". Reviewed 2026-11-10: 111 items, all default "Overview" pages, three template pages and one empty doc. Nothing about engineering or QA |

### Where QA publishes in Confluence (rule from Sharaiz, 2026-11-25)

All QA documentation goes under one folder: PE home > **QA Documentation** (folder `PE/folder/293666820`). Each QA activity gets its own subfolder, and that activity's pages go in it. Examples of activities: the test approach, sprint-wise QA documentation, onboarding and scaffolding, the plan to move to conventional automation, ETL testing. Do not put QA pages in other folders.

| Subfolder | Folder id | Pages |
|---|---|---|
| Test Approach: Agentic Testing and Conventional Automation | 293502990 | Agentic Test Approach: Track 1 and Track 2 (PE/293699587, PDF attached) |
| ETL Testing: BP Pro to BusPlanner Unified | 293797890 | ETL: Questions and Findings for the Dev Team (QA POC) (PE/293502993, native page so devs answer inline; source `reports/2026-11-25-etl-dev-questions.md`) |

Publishing pattern (Sharaiz, 2026-11-25): put the **full document content** on the page as native Confluence content. Attach the PDF only as a file card at the end, under "Attachment". Never embed the PDF with the PDF viewer: readers do not want to scroll a PDF inside Confluence.

A PDF is optional. From now on, write QA documents directly in Confluence, with no PDF. Attach a PDF only when one already exists and Sharaiz asks for it. A page without a PDF is complete: do not make a PDF for it and do not report the PDF as missing.

#### Page design standard (Sharaiz, 2026-11-25)

Goal: every QA page is beautiful, minimal and easy to use. A reader gets the point in five seconds and finds any item without scrolling through clutter. Apply this to every new or edited page in QA Documentation.

| Part | Rule |
|---|---|
| Top of page | No table of contents macro and no list of anchor links. Readers rejected plain blue links at the top |
| Hero | One custom panel (light blue `#DEEBFF`, one icon) with a one-sentence headline (H3) and one or two short lines on why the page exists |
| Fact cards | Under the hero, a three-column layout of small grey (`#F4F5F7`) custom panels: status (as a lozenge), date, and the one thing the reader must know (for example "Answer first" or "First use") |
| Sections | H2 headings, each with one emoji before the text. One emoji per section type; do not decorate H3 or body text |
| Status | Use status lozenges, not words: green = yes, works, use now; blue = new, to build; yellow = open, in review, partial; red = no, blocked; neutral = later, counts |
| Key points | Two-column layout of soft-coloured custom panels when a page has 2 to 4 headline points |
| Call-outs | A custom panel for each instruction, rule or warning the reader must not miss ("How to answer", "Rehearse first"). Use one colour per meaning |
| Questions to others | A purple (`#EAE6FF`) question panel under each item, so the ask stands out |
| Long items | One expand per item (title "A1 · short title", plain text) when a section has many items. Reference data, examples and scope notes also go in expands |
| Decisions | Native decision list (undecided or decided), not a table |
| Tables | Short cells. First column as row headers where rows are attributes. Lozenges for status cells |
| Attachments | Last section, "Attachment", with a file card only. Never the PDF viewer |
| Emoji | Send each emoji with its shortname, its id (hex code point) and its Unicode character, and give each custom panel an icon id and icon text. Without the id, Confluence shows the shortname as text (for example ":railway_track:") |
| Words | Keep the document text. Restyling changes layout only; check that no words are lost by comparing word counts before and after |

Examples that follow the standard: PE/293699587 (agentic test approach) and PE/293502993 (ETL questions).

Most useful PE pages:

| Page | Link | Use |
|---|---|---|
| Build, Deployment and QA Testing Process | PE/235175938 | Pipeline, environments, statuses, Slack channels. Start here |
| Release Train and Merge Queue Process | PE/50429953 | Why the QA gate exists; constraints |
| How to Write a Proper Bug | PE/235470851 | Bug checklist |
| ENG Board - Jira Issue Type Guide | PE/174850052 | Issue types, SPT/PROD flow |
| Dev Sprint Process | PE/59310084 | Sprint cadence (stub) |
| Important Dates - Engineering - 2026 | `https://busplanner.atlassian.net/wiki/spaces/PE/database/59998210` | Sprint and release calendar |
| Client Facing Release Notes | PE/242876418 | What shipped, client wording |
| GPS+ Live Viewer - QA & Product Handoff | PE/138313730 | Use cases, scenarios, 18 business rules |
| GPS+ Event Viewer - QA & Product Handoff | PE/137822221 | 17 business rules; read in full, see `confluence.md` 5.2 |
| GPS+ Path & Stop Compare - QA & Product Handoff | PE/139231233 | 32 business rules; read in full, see `confluence.md` 5.3 |
| BusPlanner GPS Plus User Manual | PE/225050641 | Newest description of shipped GPS+ behaviour, incl. Route Management and exact UI messages |
| AI Assistant - Question Scope (V1) | PE/137232386 | The 42 questions the chatbot should answer, with flags; read in full, see `confluence.md` 5.5 |
| GPS+ New Customer Stand-Up Checklist | PE/157450256 | Stand-up steps and the Q.1-Q.6 health check |
| Multi-day Vehicle Assignments - Phase 1 Design | PE/226918402 | Draft; 11 acceptance criteria; known substitution defects |
| Old-World Dispatch Escalations | PE/185204738 | Open Dispatch defects and the top regression area |
| Daily Standup Agenda / Deep Dive Agenda | PE/9699329, PE/87031810 | What the team is discussing this week |
| PRD - Users and Access (BusPlanner Unified) | PE/237043713 | Roles and permissions (not read in full) |
| PRD - Glossary and plain language | PE/239271938 | Terms and code names |
| PRD - System map | PE/239173635 | How products connect; today vs to-be |
| PRD - Time and attendance (TA) | PE/238485608 | T&A requirements, AC and proposed QA tests |
| PRD - Dashboard V1 / Dispatch build section | PE/238551042, PE/238419992 | AC and QA test tables (not read in full) |
| New client stand-up runbook (BusPlanner Unified) | PE/251756545 | Environments, ETL, known issues (work in progress) |
| GPS services scalability | PE/174227457 | GPS Reader / Stop Classification / Substitution Import as built, plus a scaling proposal (draft) |
| JWT renewal (refresh tokens) | PE/162430977 | Auth behaviour |
| RCA: GPS times 60 min behind | PE/256081921 | Incident write-up |
| School Opening 2026: Retrospective | PE/158662658 | Peak-season lessons and 15 actions |
| Tracker - Diagnosing and Fixing Set Up Issues | PE/79757313 | Old World tracker logs, start-up checks, common issues |
| IBM Cloud Server Backups - Quick Start Guide | PE/195297284 | Names the dev/staging/prod SQL servers; backup retention |

Not found in Confluence (confirmed by reading every non-PRD page and the personal spaces): definition of done, test strategy, regression checklist, test-case repository, engineering onboarding, severity/priority definitions, a QA team roster, an environment list with URLs for QA1/QA2 or for Unified dev/staging. Text search finds "definition of done"/"test plan" wording only inside the PRD family.

## Test environments mentioned in these sources

Do not treat any URL here as approved for testing; confirm with the team and with `knowledge/environments.md`.

| Name | Kind | Built from | URL / host | Source |
|---|---|---|---|---|
| QA1 (Main) | TEST: functional first pass | `dev` | NOT FOUND | PE/235175938 |
| QA2 (Main) | TEST: weekly regression (Stage) | `stage` | NOT FOUND | PE/235175938 |
| QA1 / QA2 (Fleet) | TEST: separate instances | `fleet-dev` / `fleet-stage` | NOT FOUND | PE/235175938 |
| Production / Main | **PRODUCTION** | `main`, `fleet-main` | Per customer; NOT FOUND | PE/235175938 |
| BP Unified dev (CA) | TEST; called "ca-dev" / "CA-Dev"; SQL server `k8-mssql`; "already overloaded, Devs use it as local"; midday deploys are requested in stand-up | `dev` | App URL NOT FOUND | PE/9699329, PE/87031810, PE/195297284 |
| BP Unified staging (CA) | TEST (called "staging (CA, optional)" or "stage"); namespace `busplanner-staging` on the dev cluster `k8-dev-ca-tor`; SQL server `k8-staging-mssql`; BP Info writes always disabled; ETL image `staging-latest`; the GPS+ user manual was written against its data | `staging` | App URL NOT FOUND | PE/251756545, PE/195297284, PE/225050641 |
| BP Unified dev / staging (US) | TEST; separate cloud account; SQL servers `k8-dev-mssql`, `k8-staging-mssql` | `dev` / `staging` | NOT FOUND | PE/195297284 |
| BP Unified prod (CA) | **PRODUCTION**; namespace `busplanner-prod` | `main` | `https://app.busplanner.ca` | PE/251756545 (E10.2 "App URL") |
| BP Unified prod (US) | **PRODUCTION**; separate cloud account | `main` | `https://app.busplanner.com` | PE/251756545 |
| Tracker / Dispatch monitoring sites | Internal monitoring of customer trackers, Old World; treat as **PRODUCTION** | - | `trackermonitoring.sweden.georef.local`, `dispatchmonitoring.sweden.georef.local` (refresh every 5-10 min), `trackerhealth.sweden.georef.local` (more live) | PE/79757313 |
| Old World customer servers | **PRODUCTION**; per-client Windows servers (`ca-*`, `wwwNN`) reached by per-client RDP | `main` | Per customer | PE/195297284, PE/256081921 |
| "US Demo Site" (BP Fleet) | Demo; treat as non-test | - | NOT FOUND | ENG-3034 |

Notes for QA:
- All Unified ETL buckets live in the production storage instance and every environment's Load reads the same bucket, so staging holds real customer plan data (PE/251756545). Handle it as production data.
- The runbook flags an open security concern about a shared developer account seeded into every new client database, including production (PE/251756545 Known issues 6). Do not use that account for testing; no credentials are recorded here.
- Internal IPs, secret-manager IDs and hashes present in the runbook are deliberately omitted from this file.
- BP Unified login has two entry points, a central URL and a client-slug URL; both are tested for each new user. The user manual shows only the pattern `https://<your-site>.busplannerweb.com/gps-plus` with no host and no test/production label (PE/251756545, PE/157450256, PE/225050641).
- Test accounts, as far as written: QA users are created per client in the admin UI like customer users, and credentials are delivered outside chat and tickets (PE/251756545 E16, PE/157450256). "Prod: never test writes against prod BP Info" (PE/251756545). Accounts a tester needs per feature: Live Viewer four (one per operator/depot grant combination) plus a bus with no depot or operator; Event Viewer two; Path & Stop Compare two, plus two with different depots/operators (PE/138313730, PE/137822221, PE/139231233).
- Dev and staging SQL backups are kept 14 days; prod 90 days daily and 365 days monthly (PE/195297284).
- The Old World Dispatch database is rebuilt from Live every night at 2 AM, so Dispatch test data entered today is gone tomorrow (PE/185204738). Whether QA1/QA2 do the same is UNVERIFIED.
- Still unknown after the full read: every QA1/QA2 URL, the Unified dev and staging app URLs, and how a tester gets an account on any of them.
