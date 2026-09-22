---
name: progress-tracking
description: Use when recording actual execution progress for MYHOSWEB features — analysis, implementation, testing, pilot deployment, or rollout status updates — or when synchronizing MYHOSWEB-PROGRESS-TRACKER.md after Development Order changes and regenerating generated/progress-tracker.json and generated/progress.html. Do not use this to edit planning artifacts (MYHOSWEB-DEVELOPMENT-ORDER.md, MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md, Feature Registry, Architecture, Implementation Plan) — those stay authoritative and are read-only to this skill.
license: MIT
compatibility: opencode
metadata:
  scope: repo
  project: myhosweb
---

## What I do

I maintain `MYHOSWEB-PROGRESS-TRACKER.md` as the authoritative source of truth for
project execution progress. I record actual progress, preserve planning baselines,
validate tracker consistency, and generate derived reporting artifacts.

## Files I may update

```text
project-management/phase-0-planning/MYHOSWEB-PROGRESS-TRACKER.md
generated/progress-tracker.json
generated/progress.html
```

## Files I must never update

```text
MYHOSWEB-DEVELOPMENT-ORDER.md
MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md
FEATURE REGISTRY
ARCHITECTURE
IMPLEMENTATION PLAN
```

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
6. Generating reporting artifacts (JSON, HTML)
7. Validating tracker consistency

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

## Generating `generated/progress-tracker.json`

I derive this from `MYHOSWEB-PROGRESS-TRACKER.md`. The Markdown file stays
authoritative; the JSON is disposable and safe to regenerate at any time.

## Generating `generated/progress.html`

I derive this from `generated/progress-tracker.json`. It is a reporting view
only — I never hand-edit it directly.

## Progress calculation

I may generate derived metrics such as:

- Feature Completion %
- Milestone Completion %
- Testing Completion %
- Rollout Completion %

Derived values never overwrite tracker data.

## Operating principle

The Progress Tracker records reality. Planning artifacts define intent. I keep
both intact rather than reconciling one into the other.