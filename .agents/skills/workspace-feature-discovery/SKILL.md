# SKILL: WORKSPACE FEATURE DISCOVERY

## Purpose

Workspace Feature Discovery is a skill used to discover, formalize, maintain, and validate the Features and Outcomes required by a Workspace.

The purpose of this skill is to answer:

> What Features are required for this Workspace to fulfill its operational responsibilities?

This skill produces and maintains the:

```text
WORKSPACE-FEATURE-DISCOVERY.md
```

artifact.

The output of this skill becomes the input for:

```text
ics-feature-creation
```

---

# Scope

This skill is responsible for:

- Capturing Work Scenarios
- Discovering Features
- Defining Outcomes
- Maintaining Feature Discovery artifacts
- Assessing completeness
- Assessing readiness for Feature Creation

This skill is NOT responsible for:

- Domain creation
- Capability creation
- Actor creation
- Workspace creation
- UI Design
- API Design
- Database Design
- Architecture Design
- Technical Implementation

---

# Authoritative References

The following artifacts are considered authoritative and read-only:

```text
CONCEPTUAL-MODEL.md

DOMAIN/*.md

ACTOR/*.md

WORKSPACE/*.md
```

This skill must never:

- create Domains
- modify Domains
- create Capabilities
- modify Capabilities
- create Actors
- modify Actors
- create Workspaces
- modify Workspaces

These artifacts are owned by higher-level analysis and governance processes.

---

# Discovery Boundary

Workspace Feature Discovery starts with an existing Workspace.

```text
Workspace
    ↓
Work Scenario
    ↓
Feature
    ↓
Outcome
```

The skill stops at:

```text
Feature + Outcome
```

Implementation begins after this boundary.

---

# Core Mental Model

```text
Workspace
    ↓
What work happens?
    ↓
Work Scenario
    ↓
What must the system provide?
    ↓
Feature
    ↓
What is achieved?
    ↓
Outcome
```

---

# Discovery Workflow

## Step 1 — Workspace Context

### Objective

Establish the Workspace being analyzed.

### Required Information

```text
Screen
Workspace
```

### Reference Information

```text
Actors
Domains
Capabilities
```

### Rules

Workspace Context is read-only.

The skill may reference:

- Workspace
- Actor
- Domain
- Capability

The skill must not modify them.

---

## Step 2 — Work Scenario

### Objective

Capture the operational situation occurring within the Workspace.

### Question

```text
What is happening?
What needs to be achieved?
What activities are performed?
```

### Structure

Every Work Scenario contains:

```text
Situation
Goal
Activities
```

### Example

```text
Scenario:
Verify Laboratory Result

Situation:
A laboratory result is waiting for medical review.

Goal:
Determine whether the result is valid.

Activities:
1. Open pending result.
2. Review patient context.
3. Review laboratory result.
4. Verify or reject result.
```

### Rules

Work Scenarios describe operational reality.

Work Scenarios do not describe:

- screens
- forms
- buttons
- UI controls
- technical implementation

---

## Step 3 — Feature Discovery

### Objective

Discover the system behaviors required to support the Work Scenario.

### Question

```text
What must the system provide?
```

### Input

Work Scenario.

### Output

One or more Features.

### Example

```text
View Laboratory Result

View Patient Context

Verify Laboratory Result

Reject Laboratory Result
```

### Rules

Features are:

- concrete
- actor-oriented
- outcome-oriented

Features are NOT:

- screens
- pages
- forms
- reports
- charts
- tables
- API endpoints
- database structures

### Rules

A Workspace may produce:

```text
1..N Features
```

A Feature may support:

```text
1..N Activities
```

A Feature may reference:

```text
1..N Capabilities
```

---

## Step 4 — Outcome Definition

### Objective

Define the business result produced by a Feature.

### Question

```text
What business result is achieved?
```

### Input

Feature.

### Output

Outcome.

### Example

```text
Feature:
Verify Laboratory Result

Outcome:
Laboratory result becomes medically verified.
```

### Rules

Outcomes:

- use business language
- describe observable business results

Outcomes are NOT:

- technical results
- API responses
- database changes

---

# Create Mode

## Trigger

Use Create Mode when:

```text
No Workspace Feature Discovery artifact exists.
```

or

```text
User requests creation of a new discovery artifact.
```

---

## Workflow

### 1. Establish Workspace Context

Identify:

```text
Workspace
Screen
Actor(s)
Domain(s)
Capability(s)
```

using existing authoritative artifacts.

---

### 2. Capture Work Scenarios

Create one or more Work Scenarios.

---

### 3. Discover Features

Identify all Features required to support each Work Scenario.

---

### 4. Define Outcomes

Define business Outcomes for each Feature.

---

### 5. Generate Artifact

Produce:

```text
WORKSPACE-FEATURE-DISCOVERY.md
```

---

# Maintain Mode

## Trigger

Use Maintain Mode when:

```text
WORKSPACE-FEATURE-DISCOVERY.md
```

already exists.

and

```text
User provides additional information.
```

---

## Accepted Updates

The user may provide:

```text
Additional scenario

Additional activity

Additional business rule

Additional operational detail

Additional outcome

Additional feature idea
```

---

## Maintenance Workflow

### 1. Assess Current State

Review current:

```text
Work Scenarios
Features
Outcomes
```

---

### 2. Merge New Information

Update the artifact.

---

### 3. Reassess Features

Determine whether:

```text
new Features are required
```

or

```text
existing Features should change
```

---

### 4. Reassess Outcomes

Determine whether:

```text
new Outcomes are required
```

or

```text
existing Outcomes should change
```

---

### 5. Regenerate Artifact

Produce the updated current state.

---

# Capability Gap Detection

The skill may encounter a scenario that cannot be mapped to any existing Capability.

The skill must NOT invent new Capabilities.

Instead report:

```text
CAPABILITY GAP DETECTED
```

with:

```text
Scenario

Required Business Ability

Reason Mapping Failed
```

and mark:

```text
Authority Review Required
```

---

# Completeness Assessment

The skill must continuously assess:

```text
How complete is the discovery?
```

---

## Work Scenario Completeness

Verify:

```text
Situation exists

Goal exists

Activities exist
```

---

## Feature Completeness

Verify:

```text
Features identified

Features traceable to activities
```

---

## Outcome Completeness

Verify:

```text
Every Feature has Outcome
```

---

# Readiness Assessment

The skill must determine:

```text
READY
```

or

```text
NOT READY
```

for Feature Creation.

---

## READY Criteria

Ready when:

```text
Workspace Context exists.

At least one Work Scenario exists.

At least one Feature exists.

Every Feature has Outcome.

Feature traceability exists.
```

---

## NOT READY Example

```text
Scenario exists.

Features exist.

Outcomes missing.
```

Result:

```text
NOT READY
```

---

# Traceability Model

Every Feature must be traceable.

```text
Workspace
    ↓
Work Scenario
    ↓
Feature
    ↓
Outcome
```

Additionally:

```text
Feature
    ↓
Capability Reference
    ↓
Domain Reference
```

must exist.

---

# Artifact Ownership

Authoritative artifact:

```text
WORKSPACE-FEATURE-DISCOVERY.md
```

This skill is responsible for maintaining its current state.

---

# Handover

When the discovery is complete:

```text
WORKSPACE FEATURE DISCOVERY
              ↓
      Discovered Feature
              ↓
      ics-feature-creation
              ↓
     Formal Feature Artifact
```

The responsibility of this skill ends at:

```text
Feature + Outcome
```

The responsibility of:

```text
ics-feature-creation
```

begins after handover.

---

# Success Definition

The skill succeeds when:

> A Workspace has been analyzed sufficiently to produce a complete and traceable set of Features and Outcomes, and every discovered Feature is ready to be formalized through the Feature Creation Skill.