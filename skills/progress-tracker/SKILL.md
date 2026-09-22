# Skill: Program Tracking

## Purpose

Maintain `MYHOSWEB-PROGRAM-TRACKER.md` as the authoritative source of truth for project execution progress.

This skill records actual progress, preserves planning baselines, validates tracker consistency, and generates derived reporting artifacts.

---

# Scope

This skill MAY update:

```text
project-management/phase-0-planning/MYHOSWEB-PROGRAM-TRACKER.md
generated/program-tracker.json
generated/progress.html
```

This skill MUST NOT update:

```text
MYHOSWEB-DEVELOPMENT-ORDER.md
MYHOSWEB-FEATURE-COMPLEXITY-ASSESSMENT.md
FEATURE REGISTRY
ARCHITECTURE
IMPLEMENTATION PLAN
```

Those artifacts remain authoritative planning sources.

---

# Responsibilities

1. Record Progress
2. Record Testing Activity
3. Record Pilot Deployment Activity
4. Record Rollout Activity
5. Synchronize Tracker Structure
6. Generate Reporting Artifacts
7. Validate Consistency

---

# Daily Progress Update

Supported requests:

```text
Update FT-07-02 analysis completed.

Update FT-07-02 implementation started.

Update FT-07-02 testing completed.

Update FT-07-02 pilot deployment started at RS ABC.

Update FT-07-02 rollout completed at RS XYZ.
```

The skill must locate the affected:

```text
Milestone
Screen
Feature
```

inside the tracker and update only relevant fields.

---

# Tracker Synchronization

When Development Order changes:

```text
New Milestone
New Screen
New Feature
Feature moved to different milestone
```

The tracker structure must be synchronized.

Rules:

* Preserve historical execution data.
* Never delete completed history.
* Mark removed items as RETIRED.
* Add new items with default placeholder values.

---

# Status Values

Feature Status:

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

Activity Status:

```text
NOT_STARTED
IN_PROGRESS
COMPLETED
BLOCKED
```

---

# Validation Rules

The skill must validate:

## Analysis

* Actual End requires Actual Start.
* COMPLETED requires Actual End.

## Testing

* Actual End requires Actual Start.
* COMPLETED requires Actual End.

## Pilot Deployment

* Actual End requires Actual Start.
* COMPLETED requires Actual End.

## Rollout

* Hospital must have PIC.
* Hospital rollout status must be valid.

## General

* Feature must belong to an existing Milestone.
* Feature must belong to an existing Screen.
* Complexity must match Complexity Assessment.
* Unknown values must remain TBD.

---

# JSON Generation

Generate:

```text
generated/program-tracker.json
```

from:

```text
MYHOSWEB-PROGRAM-TRACKER.md
```

Markdown remains authoritative.

JSON is disposable.

---

# HTML Generation

Generate:

```text
generated/progress.html
```

from:

```text
generated/program-tracker.json
```

HTML is a reporting view only.

HTML is never manually edited.

---

# Progress Calculation

Derived metrics may be generated:

* Feature Completion %
* Milestone Completion %
* Testing Completion %
* Rollout Completion %

Derived values must never overwrite tracker data.

---

# Operating Principle

The Program Tracker records reality.

Planning artifacts define intent.

If tracker and planning disagree:

```text
Planning Artifact = Planned State
Program Tracker   = Actual State
```

The skill must preserve both.
