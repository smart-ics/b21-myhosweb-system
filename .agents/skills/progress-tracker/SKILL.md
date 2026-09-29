---
name: progress-tracking
description: Use when recording actual execution progress for MYHOSWEB features — analysis, implementation, testing, pilot deployment, or rollout status updates — or when synchronizing MYHOSWEB-PROGRESS-TRACKER.md after Development Order changes. This skill only ever edits the Markdown tracker; it never runs the JSON/HTML generation tools in project-management/phase-0-planning/tools/progress-tracker itself, since those are run manually. Do not use this to edit planning artifacts (MYHOSWEB-DEVELOPMENT-ORDER.md, MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md, MYHOSWEB-SCREEN-FEATURE-CATALOG.md, Feature Registry, Architecture, Implementation Plan) — those stay authoritative and are read-only to this skill. MYHOSWEB-SCREEN-FEATURE-CATALOG.md is the source of truth for Screen PIC.
license: MIT
compatibility: opencode
metadata:
  scope: repo
  project: myhosweb
---

## What I do

I maintain `MYHOSWEB-PROGRESS-TRACKER.md` as the authoritative source of truth for
project execution progress. I record actual progress, preserve planning baselines,
and validate tracker consistency.

I do **not** generate `generated/progress-tracker.json` or `generated/progress.html`
myself. Those are produced by the tools in
`project-management/phase-0-planning/tools/progress-tracker`, which Jude runs
manually after the Markdown tracker is updated. I never invoke those tools and
never hand-write the JSON or HTML output.

## Files I may update

```text
project-management/phase-0-planning/MYHOSWEB-PROGRESS-TRACKER.md
```

## Files I must never update

```text
MYHOSWEB-DEVELOPMENT-ORDER.md
MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md
MYHOSWEB-SCREEN-FEATURE-CATALOG.md
FEATURE REGISTRY
ARCHITECTURE
IMPLEMENTATION PLAN
generated/progress-tracker.json
generated/progress.html
```

The two `generated/` files are produced by the tools under
`project-management/phase-0-planning/tools/progress-tracker`, run manually by
Jude — not by this skill.

These remain authoritative planning sources. If the tracker and a planning artifact
disagree, I treat the planning artifact as the **planned** state and the tracker as
the **actual** state, and I preserve both rather than overwriting either.

## When to use me

Use me for:

1. Recording progress on a Milestone, Screen, or Feature
2. Recording testing activity
3. Recording pilot deployment activity
4. Recording rollout activity
5. Synchronizing tracker structure after a Development Order change
6. Validating tracker consistency

I am not used to generate or edit `generated/progress-tracker.json` or
`generated/progress.html` — those come from the manually-run tools.

## Daily progress updates

I understand requests like:

```text
Update FT-07-02 analysis completed.
Update FT-07-02 implementation started.
Update FT-07-02 testing completed.
Update FT-07-02 pilot deployment started at RS ABC.
Update FT-07-02 rollout completed at RS XYZ.
```

For each request I locate the affected Milestone, Screen, and Feature inside the
tracker and update only the relevant fields — I never touch unrelated entries.
I never change a Screen `**PIC:**` line during a progress update unless the
request is an explicit Screen PIC reassignment.

## Screen PIC (source of truth)

`MYHOSWEB-SCREEN-FEATURE-CATALOG.md` is the source of truth for Screen PIC.
The tracker mirrors it: every `### SC-xx Screen Name` occurrence carries a
`**PIC:** <name>` line directly under the Screen heading.

Rules:

- On any tracker write, preserve the existing `**PIC:**` lines verbatim unless
  the task is a catalog-driven sync or an explicit PIC reassignment.
- Never invent, guess, or default a person name. If the catalog defines no PIC
  for a Screen (e.g. SC-14 Mastering has no `**PIC:**` line), the tracker uses
  `**PIC:** TBD`.
- Screen PIC is distinct from Rollout hospital PIC (`| Hospital | PIC | Status |`).
  One is Screen ownership; the other is per-hospital rollout accountability.
  Never copy one into the other.

## Tracker synchronization

When the Development Order changes — a new Milestone, new Screen, new Feature, or
a Feature moved to a different Milestone — I synchronize the tracker structure:

- Preserve historical execution data.
- Never delete completed history.
- Mark removed items as `RETIRED` instead of deleting them.
- Add new items with default placeholder values.
- For any new Screen occurrence, set `**PIC:**` from
  `MYHOSWEB-SCREEN-FEATURE-CATALOG.md`; use `**PIC:** TBD` only when the
  catalog defines no PIC for that Screen.
- When the catalog PIC changes, propagate the new PIC to every occurrence of
  that Screen in the tracker; never leave occurrences with divergent PICs.

## Status values

**Feature Status**

```text
NOT_STARTED
ANALYSIS
PLANNING
IMPLEMENTATION
REVIEW
TESTING
PILOT_DEPLOYMENT
ROLLED_OUT
COMPLETED
BLOCKED
RETIRED
```

**Activity Status**

```text
NOT_STARTED
IN_PROGRESS
COMPLETED
BLOCKED
```

## Validation rules

Before writing an update, I validate:

**Analysis**
- Actual End requires Actual Start.
- `COMPLETED` requires Actual End.

**Testing**
- Actual End requires Actual Start.
- `COMPLETED` requires Actual End.

**Pilot Deployment**
- Actual End requires Actual Start.
- `COMPLETED` requires Actual End.

**Rollout**
- Hospital must have a PIC (Rollout hospital PIC, not Screen PIC).
- Hospital rollout status must be a valid status value.

**Screen PIC**
- Every `### SC-xx` occurrence in the tracker must have a `**PIC:**` line.
- Tracker Screen PIC must match `MYHOSWEB-SCREEN-FEATURE-CATALOG.md`; a mismatch
  is a validation failure, not silent drift.
- All occurrences of the same Screen ID must carry the same PIC.
- A missing catalog PIC means `TBD` in the tracker, never a guessed name.

**General**
- Feature must belong to an existing Milestone.
- Feature must belong to an existing Screen.
- Complexity must match the Complexity Assessment.
- Unknown values stay `TBD` rather than being guessed.

## Reporting artifacts (JSON, HTML)

`generated/progress-tracker.json` and `generated/progress.html` are derived from
`MYHOSWEB-PROGRESS-TRACKER.md` by the tools in
`project-management/phase-0-planning/tools/progress-tracker`. Jude runs those
tools manually after I update the Markdown tracker. I do not call them, and I
never write to either generated file directly — including any derived metrics
like Feature/Milestone/Testing/Rollout Completion %, which the tools compute,
not me.

## Operating principle

The Progress Tracker records reality. Planning artifacts define intent. I keep
both intact rather than reconciling one into the other — with one exception:
Screen PIC. For Screen PIC the catalog is the source of truth and the tracker
is a mirror, so a catalog PIC change is propagated to the tracker.