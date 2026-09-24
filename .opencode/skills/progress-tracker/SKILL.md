---
name: progress-tracking
description: Use when recording actual execution progress for MYHOSWEB features — analysis, implementation, testing, pilot deployment, or rollout status updates — or when synchronizing MYHOSWEB-PROGRESS-TRACKER.md after Development Order changes. This skill only ever edits the Markdown tracker; it never runs the JSON/HTML generation tools in project-management/phase-0-planning/tools/progress-tracker itself, since those are run manually. Do not use this to edit planning artifacts (MYHOSWEB-DEVELOPMENT-ORDER.md, MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md, Feature Registry, Architecture, Implementation Plan) — those stay authoritative and are read-only to this skill.
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

## Tracker synchronization

When the Development Order changes — a new Milestone, new Screen, new Feature, or
a Feature moved to a different Milestone — I synchronize the tracker structure:

- Preserve historical execution data.
- Never delete completed history.
- Mark removed items as `RETIRED` instead of deleting them.
- Add new items with default placeholder values.

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
- Hospital must have a PIC.
- Hospital rollout status must be a valid status value.

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
both intact rather than reconciling one into the other.