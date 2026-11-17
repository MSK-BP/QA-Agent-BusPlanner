# Meeting harvest config (BusPlanner)

- **Source:** Fathom connector (read-only). Tools: `list_meetings`, `get_meeting_summary`, `get_meeting_transcript`.
- **Scope:** every meeting the connected account can see: own recordings, team recordings and shared ones.
- **Fathom teams visible (2026-11-18):** Customer Success, Development, Marketing, Operations, Projects, Support, USG. All in scope; triage decides relevance.
- **Recorders in scope:** all.
- **Always skip, unread beyond the title:** titles with interview, candidate, HR, performance review, payroll, compensation, 1:1 with a manager about the person.
- **Customer names allowed in notes:** district codes and names that `knowledge/` already uses (for example in `jira/other-projects.md`). Never customer staff names.
- **Protected people:** students, parents, drivers, schools, employees (see `TENANT.md`).
- **Schedule:** weekdays 18:00 local, scheduled task `qa-meeting-harvest` in the Claude desktop app. Runs only while the app is open; a missed run catches up on next launch, and the window from `last_run` covers the gap.
