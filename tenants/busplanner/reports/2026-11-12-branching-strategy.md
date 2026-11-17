# New World branching strategy: study and proposal

**Verdict.** Move to **trunk-based development with build-once-promote and release toggles**. The promotion unit becomes one immutable build (a commit SHA), and "is this item tested?" is answered per item by a toggle, not per branch. Our pipelines are already 80% shaped for this: images and the front-end bundle are environment-agnostic, prod is already manual, and a per-client feature-flag table already exists. The two things that need real work are **schema migrations** (manual, sequentially numbered) and **toggle discipline**.

Evidence: static read of `pipelines/*.yml`, `pipelines/templates/*.yml` and `deploy/` in BusPlannerUnified (commit `0137276`), plus Azure DevOps build, PR and branch-policy data read on 2026-11-12. Nothing was executed against any environment.

---

## 1. How build and deploy actually work today

| Fact | Where |
|---|---|
| Every deploy pipeline **rebuilds from its own branch**: `imageTag = $(Build.SourceVersion)`. dev builds `dev`, staging builds `staging`, prod builds `main`. The prod image is therefore **not the image that was regression-tested on staging**; it is a fresh build of the merge commit. | `backend-deploy-{dev,staging,prod}.yml`, `templates/backend-containerize.yml` |
| The backend image carries **no environment config**. Hosts come from ConfigMaps via `envsubst`, secrets from ESO (staging/prod) or an ADO variable group (dev). | `templates/backend-deploy.yml`, `deploy/k8s/<env>/` |
| The front-end bundle is also **environment-agnostic**: `config.json` (API URL, Datadog) is injected at deploy time per region. | `templates/frontend-deploy.yml` |
| → So **build once, promote the same artifact** is already technically possible. Only the branch-per-environment triggers prevent it. | |
| Triggers: push to `dev` auto-deploys dev (CA + US). Push to `staging` auto-deploys staging (behind an approval). Prod is **manual only** (`trigger: none`) with an approval gate. | same files |
| Staging and prod deploy with **kubectl**, not ArgoCD. An ArgoCD template (`backend-deploy-argocd.yml`) and overlays exist but no pipeline uses them. | `backend-deploy-staging.yml:1`, `backend-deploy-prod.yml:1` |
| **Region defaults disagree**: the backend staging/prod default is `canada` and the front end's is `us`. A default run can ship the FE to one region and the BE to the other. | `frontend-deploy-staging.yml`, `frontend-deploy-prod.yml` |
| Service pipelines (GPS reader, substitution import, stop classification) use an env picker and a **manual run on any branch**. Nothing stops `dev` code going to staging or prod. | `gps-reader-deploy.yml:10-12` |
| **Schema migrations are not in any pipeline.** `BusPlanner.MigrationTool` applies numbered SQL pairs (`NN_Name.up/down.sql`, now at 75) by hand, per client DB. Each needs an entry in an ordered list in `MigrationCatalog.cs`. | `BusPlannerUnified/CLAUDE.md`, `MigrationTool/Migrations/` |
| CI gates are **unit tests only**. Integration tests run in no pipeline. PR validation path filters skip MigrationTool, ETL, BPClientRegistry and the GPS/stop services. | `templates/backend-build-test.yml`, `backend-pr.yml:14-25` |
| The branch guard (Claude-Code-Review) is an **optional vote**, and the policy allows completion despite a reject. On 2026-11-03 a feature branch merged **straight into `main`**, so main now holds a commit that dev and staging don't. | `pr-review-pipeline.yml:31-37`, ADO PR data |
| There's no hotfix lane: the guard exempts only `revert/`, `un-revert/` and `cherry-pick/`. | `pr-review-pipeline.yml:127` |
| Feature flags exist, but **only per client** (`BPFeatureFlag`: `GLOBAL_LOGIN`, `GPS`, `CHATBOT`), read live on each request. | `RequireClientFeatureAttribute.cs`, `FeatureCodes.cs` |
| The Unified `dev` branch has **no QA required-reviewer policy** (just "min 1 reviewer"). The Old World `PR-APPROVERS` QA gate was never applied here. | ADO policy configurations |

### The numbers (ADO, read 2026-11-12)

- **About 20 PRs a week merge into `dev`** (weeks 39-45: 20, 27, 17, 17, 18, 23, 27).
- Dev deploys: backend 118 and front end 97 auto-runs in the sample. Prod deploys: **3** (Sep 17, Oct 9, Oct 21).
- **70 PRs have merged into `dev` since the last prod promote (Oct 22), and 61 since the last staging promote (Oct 26).** That's the "10 untested items" problem at 7× scale.
- Promote PR titles show staging and prod were often promoted for env setup or one feature ("for chatbot setup", "before client handover"), not on a cadence.

---

## 2. Why the current model can't be fixed by working harder

The root cause in the brief is right: **the promotion unit is the whole branch, but tested-ness is per item.** Two things in our infra make it worse:

1. **What QA tested is not what ships.** Every environment rebuilds, so regression on staging validates a different binary from the one prod gets.
2. **The schema couples items.** Migrations are sequential and applied by hand to shared DBs. Reverting an item's code out of `dev` doesn't revert its migration, so the dev DB drifts ahead of the code. Two parallel branches both claim migration `76`, and `MigrationCatalog.cs` becomes a merge-conflict hotspot.

So a revert-storm is riskier here than it looks, and sealing dev throws away the 20/week throughput.

---

## 3. The options

| Option | How it fixes the mismatch | Fit with our infra | Verdict |
|---|---|---|---|
| **A. Trunk-based + build-once + release toggles** | Untested work merges but ships **dark**. Promote one SHA; turn the toggle on when QA passes. | Strong: artifacts are already env-agnostic, prod is already manual, and a flag table exists. | **Recommend** |
| B. QA-before-merge (test on the branch, ephemeral env per PR) | Only tested work enters the integration branch. | Expensive: DB-per-client plus a registry DB, and dev talks to real client BP Info. Per-PR environments with real data are hard and risky. | Use as a **gate for un-toggleable changes** only |
| C. Release branches with cherry-picks | Cut `release/x` and pick in only the approved items. | Old World already rejected this: "dependent PRs conflict" (Confluence PE/50429953). Migrations make it worse. | Reject |
| D. GitFlow as today, plus a QA approval gate on `dev` | Item is QA-approved before merge (Old World model). | Cheap, but it moves the bottleneck: devs wait on QA to merge, which is a soft "seal dev". | Fallback if A is rejected |

---

## 4. Proposal (option A, phased)

### Branch model in GitHub
- **One long-lived branch: `main`.** Short-lived `feature/ENG-1234-*` branches; PR into `main`; squash merge.
- **No `dev`/`staging` branches.** Environments are deploy targets, not branches.
- **Releases are tags** (`v14.2.0`) on a SHA. A **hotfix** is a `hotfix/*` branch cut from the release tag, built, deployed, then merged back to `main`.
- GitHub **rulesets** (blocking, not an optional vote): PR required, CI green, 1 review, linear history, no direct pushes. This replaces the Claude branch guard.

### Pipeline (GitHub Actions)
1. **On PR:** build + unit tests (fix the path-filter holes, so every project is covered) + migration-catalog check.
2. **On merge to `main`:** build **once**, push the `:<sha>` image and FE bundle, auto-deploy **dev** (CA + US).
3. **Promote to staging:** a manual workflow that takes a SHA (the "release candidate") and redeploys the **same image tag** with staging config. Regression runs here.
4. **Promote to prod:** the same SHA, behind GitHub Environment required reviewers. No rebuild.
5. One workflow deploys **BE + FE + services together** for a SHA and region. This fixes the region-default mismatch and the "any branch to staging" hole on the service pipelines.

### Release toggles (fixes QA vs merge speed)
- Extend `BPFeatureFlag` (or add a small `ReleaseToggle` table) with **global and per-environment** toggles, alongside per-client.
- Rule: **any user-visible change that isn't QA-approved ships behind a toggle that's off in staging and prod.**
- QA tests the toggle-on behaviour in dev, then flips it on in staging, and regression covers it. Untested items in the release candidate ride along **dark**. No reverts and no freeze.
- Toggles carry the ticket key (`ENG-1234`) and get removed after release. Track removal as a definition-of-done item.

### Schema (the hard part)
- **Expand/contract migrations only.** Additive first, so old code still works. Removals go in a later release once nothing reads the column. Then a migration can deploy ahead of its feature.
- **Run MigrationTool from the pipeline** (CLI project exists) as a step before the deploy, per environment and client, so dev, staging and prod schema always match the SHA.
- Switch filenames from `NN_` to the **timestamp ids the catalog already uses** (`YYYYMMDDhhmmss_Name`) to end number collisions between parallel branches.
- Changes that **can't** be toggled (schema contract, infra, auth) need **QA approval before merge** (option B/D for that small slice).

### Phasing
1. **Migration day:** move to GitHub with `main` + feature branches + rulesets. Build once, auto-deploy dev, promote by SHA. Align region defaults. Add the hotfix lane.
2. **Next sprint:** add release toggles and the "untested = dark" rule. Put MigrationTool into the pipeline.
3. **Later:** integration tests in CI. Optional per-PR preview environments for the FE only (static bundle pointing at the dev API is cheap and safe).

---

## 5. Talking points for the call (short version)

1. **Our artifacts are already promotable.** The image and FE bundle carry no env config. We rebuild per branch only because triggers are wired to branches. Build once, promote the SHA, and QA tests exactly what ships. Today they don't.
2. **Promote a SHA, not a branch.** Environments become deploy targets. `dev`/`staging` branches go away, and with them the dev→staging→main merge PRs and drift. Main already has a commit (ENG-2963, Nov 3) that staging doesn't.
3. **Untested work ships dark, not reverted.** Release toggles turn "promote the whole branch" into "promote everything, enable what's tested". We already have `BPFeatureFlag` read live per request; it just needs global and per-env scope.
4. **Scale of the problem:** ~20 merges/week into dev, 70 unreleased since Oct 22, 3 prod deploys since mid-Sep. No QA gate in the world keeps up with that if the batch is the whole branch.
5. **Schema is the real risk, not git.** Migrations are manual, sequentially numbered and outside the pipeline. Reverting code doesn't revert schema. Any strategy needs expand/contract migrations, MigrationTool in the pipeline and timestamped ids.
6. **Cherry-pick release branches are a known dead end.** Old World tried it and rejected it for dependency conflicts, and our migration ordering makes it worse.
7. **Use GitHub rulesets, not an advisory bot.** Today's branch guard is an optional vote with "allow completion even if rejected", and it was bypassed.
8. **Quick infra fixes regardless of strategy:** FE/BE region defaults disagree (`us` vs `canada`). Service pipelines can deploy any branch to staging or prod. PR validation skips MigrationTool, ETL and the GPS services. Integration tests run nowhere.
9. **QA's role shifts left.** Functional test on dev with the toggle on, flip the toggle as the "Approved for Release" act, then regression on a fixed SHA in staging. Changes that can't be toggled need QA approval before merge.

### Questions to put to the group
- Who owns toggle cleanup, and what's the limit on live toggles?
- Do we want the US and CA releases to share one SHA, or ship independently?
- Who runs MigrationTool in staging and prod today, and against which client DBs?
- Is anyone relying on `dev` or `staging` as branches (e.g. ENG-2963's "create DB from `staging`")?

## Not verified
- Merge strategy settings per branch (the policy exists; its type wasn't read).
- How migrations are actually run in staging and prod today (no pipeline does it; asked above).
- The run sample is the last 548 ADO builds. Counts are lower bounds, not complete history.
