# Environments

> Status: empty. Fill this before acting on any environment, and confirm with the user which ones are allowed.

## Environments

| Name | API | App | Allowed | Notes |
|---|---|---|---|---|
| TODO | | | | |

How to tell which build an environment is running: TODO.

## Hard rules for non-production environments

TODO: anything that is not isolated from real systems or real people, shared infrastructure, billable services, real data.

## Credentials

Never written here. Name the source only: environment variable names or the secret store.

## Test data

- Prefix for data the agent creates: `QA-AUTO-`.
- How to seed and reset: TODO.

## Browser

The core Playwright browser uses this tenant's `playwright.json` for blocked origins (run `harness\use-tenant.ps1` after changing it). The user signs in in the browser window; the agent never types a password. Screenshots go to `browser/` in the tenant's run folder (default `reports/`; see the core README, "Run folder"). It is never committed.

## Guard

Production hosts, IPs and databases are listed in `blocked-patterns.txt` in this tenant's root.
