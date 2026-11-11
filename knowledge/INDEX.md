# Knowledge index

Last built 2026-11-10. Code knowledge is from static reading of `BusPlannerUnified` at commit `0137276`; nothing has been executed. Anything marked UNVERIFIED, TODO or NOT FOUND in a file is not knowledge.

| File | Covers | Status |
|---|---|---|
| domain.md | Products (Old World and New World), roles, glossary, business rules, bug themes | sourced from Confluence and Jira; Slack not readable |
| process.md | Jira projects, QA workflow, release train, people, channels, Confluence pages | sourced from Confluence and Jira |
| confluence.md | All 76 non-PRD Confluence pages: QA and release process, environments, runbooks, feature handoffs, people, answers to the hunt list | 2026-11-10; supersedes the process summary in process.md where they differ |
| confluence-prd.md | All 87 "PRD" pages in Confluence: system map (SY/CX/IC ids), 318-term glossary, 626 shipped ("today") rules, 680 proposed rules, contradictions | 2026-11-10; about 2,850 lines, so Grep it for a module or term instead of reading it whole; "verified" there is the PRD author's tag, not a QA result |
| jira/README.md | FULL Jira read: every issue in ENG (2,882) and PROD, IN, SPT, SOC, MDP (1,277), as 9 digest files with rules, defect patterns and QA evidence | 2026-11-10; grep by key or term |
| jira.md | All projects, every epic, all 2,879 ENG issues at summary level, bug themes with counts, QA queue snapshot, ticket conventions | 2026-11-10; 80 issues read in full, see its "Read coverage" section |
| architecture.md | Systems, request flow, data, integrations, CI/CD | Unified filled; Old World not onboarded |
| environments.md | Environment URLs, what is allowed, hard rules, BusPlanner browser specifics | Unified filled; dev and staging approved 2026-11-10; Playwright set up 2026-11-12; QA1/QA2 URLs missing |
| test-strategy.md | Suites and commands, gates, gaps, flaky list | Unified filled; commands unverified by execution |
| conventions.md | House style for backend, front-end and manual tests | Unified filled |
| repos/BusPlannerUnified.md | Repo map and index to the five detailed maps | filled |
| repos/BusPlannerUnified/*.md | backend-core, chatbot, data-services, frontend, tests-ci-infra | filled, each lists what it could not determine |
| repos/BusPlannerUnified/ta-requirements.md | T&A PRD v1.9 requirements, calculations, state machines, spec-vs-code gaps | from the repo's Word docs, 2026-11-10 |
| repos/BusPlannerUnified/chatbot-spec.md | Chatbot spec and backlog, stories, eval numbers, spec-vs-code gaps | from the repo's Word docs, 2026-11-10 |
| repos/BusPlannerUnified/schema-and-etl-spec.md | Schema v7.22 tables, invariants, ETL spec and QA validation, data checks | from the repo's Word docs, 2026-11-10 |
| repos/BusPlannerUnified/platform-prd-and-ux.md | UI/UX decisions, design-system and a11y commitments, cross-cutting UI rules | from the repo's Word docs and meeting notes, 2026-11-10 |

## What to read for which task

- **Test plan:** domain.md, then the one detailed map for the feature's area, then its requirements file (ta-requirements, chatbot-spec, schema-and-etl-spec or platform-prd-and-ux) for expected behaviour; test-strategy.md for gaps.
- **Writing tests:** conventions.md, then the skeleton in the detailed map it points to.
- **Running or triaging:** environments.md (hard rules first), test-strategy.md (commands, flaky list).
- **Bug report:** domain.md for expected behaviour, jira.md section E for the bug and "QA Verification" comment conventions, process.md for the workflow.
- **What needs testing now:** jira.md "QA queue snapshot" (dated; refresh it from Jira before relying on it).
- **PR review:** the detailed map for the changed area; test-strategy.md for what CI does and does not gate.
- **Release sign-off:** process.md (release train), test-strategy.md.

## Known holes

- Old World products: no repo access yet, no environment URLs (QA1/QA2 hosts are in no Confluence page).
- Not documented anywhere: definition of done, test strategy or regression checklist, severity/priority definitions, QA team roster.
- Jira: every issue read (see jira/README.md for depth per slice); attachments and change history not read.
- Slack: the account is in two general channels only.
- `.docx` specs: the current ones are read (text extracted to `repos/BusPlannerUnified/_docx_text/` by `harness/docx2txt.ps1`); the superseded versions under `archive/` were not.
- Test accounts for dev and staging, and which SQL Server QA may use.
- No test has been executed; `dotnet` and `git` are not installed here. Node v26.13.1 is (2026-11-12), used for the Playwright browser.
