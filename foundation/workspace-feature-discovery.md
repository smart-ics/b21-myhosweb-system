# WORKSPACE FEATURE DISCOVERY

## Purpose

Workspace Feature Discovery is a focused analysis and design sequence used to discover the Features and Outcomes required by a Workspace.

The sequence starts from an existing Workspace and ends at one or more Features and their Outcomes.

Its purpose is to answer:

> What Features are required for the Actors of this Workspace to perform their work and achieve the intended Outcomes?

This sequence does not define implementation.

---

# Scope

## Included

Workspace Feature Discovery includes:

- Workspace definition
- Domain identification
- Capability identification
- Actor identification
- Work Scenario analysis
- Feature discovery
- Outcome definition
- Traceability between these concepts

## Excluded

Workspace Feature Discovery does not include:

- Navigation design
- UI Layout design
- Database design
- API design
- Application architecture
- Technical implementation
- Testing strategy

These activities belong to later stages.

---

# Conceptual Boundary

Workspace Feature Discovery connects an existing Workspace with the Business Capabilities and Actors relevant to that Workspace, then discovers the Features required to produce the intended Outcomes.

```text
BUSINESS CONTEXT

Domain
    ↓
Capability


WORKSPACE CONTEXT

Screen
    ↓
Workspace
    ↓
Actor


FEATURE DISCOVERY

Domain + Capability + Actor
              ↓
        Work Scenario
              ↓
           Feature
              ↓
           Outcome


DEVELOPMENT

Feature + Outcome
        ↓
Technical Design
        ↓
Implementation
        ↓
Test
```

The sequence ends at Feature + Outcome.

It does not determine how a Feature is implemented.

---

# Mental Model

Workspace Feature Discovery follows one simple idea:

> A Workspace exists for an Actor to perform work using Features that realize Business Capabilities and produce Outcomes.

```text
                    WHY?
               Domain Capability
                      │
                      ▼
                   WHO?
                    Actor
                      │
                      ▼
               WHAT HAPPENS?
               Work Scenario
                      │
                      ▼
             WHAT SYSTEM PROVIDES?
                    Feature
                      │
                      ▼
             WHAT IS ACHIEVED?
                    Outcome
```

The Workspace provides the context:

```text
Screen
  ↓
Workspace
  ↓
Actor + Capability
  ↓
Work Scenario
  ↓
Feature
  ↓
Outcome
```

---

# Discovery Sequence

## Step 1 — Workspace

### Purpose

Establish the Workspace being analyzed.

### Question

> What Workspace are we discovering Features for?

### Input

Existing Workspace definition.

### Output

Workspace context.

### Example

```text
Screen:
Laboratory

Workspace:
Pathologist Workspace
```

### Boundary

This step defines the scope of discovery.

Do not redesign the Screen or Workspace here.

---

## Step 2 — Domain and Capability

### Purpose

Identify the business capabilities relevant to the Workspace.

### Questions

> Which Domains participate in this Workspace?

> Which Capabilities are required?

### Input

Workspace context.

### Output

One or more Domain and Capability references.

### Example

```text
LAB
 └─ LAB-04 Lab Result Management

PAS
 └─ PAS-01 Patient Information
```

### Rules

- A Workspace may involve multiple Domains.
- A Capability belongs to exactly one Domain.
- A Feature may realize Capabilities from multiple Domains.
- Identify existing business capabilities.
- Do not invent implementation structures.

### Boundary

This step identifies business abilities.

It does not define Features or implementation behavior.

---

## Step 3 — Actor

### Purpose

Identify who performs the work.

### Question

> Who performs the work in this Workspace?

### Input

Workspace context.

### Output

One or more Actors.

### Example

```text
Pathologist
```

### Boundary

This step identifies responsibility.

It does not define permissions, roles in software, or technical authorization.

---

## Step 4 — Work Scenario

### Purpose

Describe the operational situation that requires work to be performed.

### Question

> What is happening, what must be achieved, and what activities are performed?

### Input

Workspace, Domain, Capability, and Actor.

### Output

One or more Work Scenarios.

### Structure

A Work Scenario consists of:

- Situation
- Goal
- Activities

### Example

```text
Scenario:
Verify Laboratory Result

Situation:
A laboratory result is ready for medical review.

Goal:
Determine whether the result is valid and can be released.

Activities:
1. Open pending result.
2. Review patient context.
3. Review laboratory result.
4. Verify or reject result.
```

### Rules

- Work Scenarios describe real operational work.
- Work Scenarios describe reality, not software.
- Work Scenarios replace the separate Scenario, Use Case, and User Journey artifacts in this workflow.

### Boundary

This step describes work.

It does not define system behavior.

---

## Step 5 — Feature Discovery

### Purpose

Discover the system behaviors required to support the Work Scenario.

### Question

> What must the system provide?

### Input

Work Scenario.

### Output

One or more candidate Features.

### Example

```text
F01 — View Laboratory Result

F02 — View Patient Context

F03 — Verify Laboratory Result

F04 — Reject Laboratory Result
```

### Rules

- A Workspace may produce one or more Features.
- A Feature may support one or more activities.
- A Feature may realize Capabilities from multiple Domains.
- Features are concrete system behaviors.
- Features are actor-oriented and outcome-oriented.

### Features Are Not

- Database tables
- API endpoints
- API responses
- Forms
- Pages
- Reports
- Charts
- UI components
- Technical implementations

### Boundary

This step identifies what the system must provide.

It does not formally define the Feature.

Formal Feature definition is handled by the Feature Creation Skill.

---

## Step 6 — Outcome

### Purpose

Define the business result produced by a Feature.

### Question

> What business result is achieved?

### Input

Feature.

### Output

One or more Outcomes.

### Example

```text
Feature:
Verify Laboratory Result

Outcome:
Laboratory result becomes medically verified.
```

### Rules

- Outcomes are expressed in business language.
- Outcomes describe observable business results.
- Outcomes are not technical results.

### Boundary

This step defines the achieved result.

It does not define outcome boundaries, flow, orchestration, constraints, exceptions, or acceptance criteria.

Those belong to the formal Feature artifact.

---

# Traceability Model

Every discovered Feature should be traceable.

```text
Screen
   ↓
Workspace
   ↓
Domain + Capability
   ↓
Actor
   ↓
Work Scenario
   ↓
Feature
   ↓
Outcome
```

Example:

```text
Laboratory
  ↓
Pathologist Workspace
  ↓
LAB → Lab Result Management
  ↓
Pathologist
  ↓
Result requires verification
  ↓
Verify Laboratory Result
  ↓
Laboratory result becomes medically verified
```

Traceability exists to explain why a Feature exists.

---

# Result

The result of Workspace Feature Discovery is an informal list of candidate Features with complete discovery context.

Each discovered Feature should contain at least:

```text
Feature
Actor
Domain
Capability
Work Scenario
Outcome
```

Example:

```text
Feature:
Verify Laboratory Result

Actor:
Pathologist

Domain:
Laboratory

Capability:
Lab Result Management

Work Scenario:
A laboratory result is ready for medical review.
The pathologist reviews the patient context and result,
then verifies or rejects it.

Outcome:
Laboratory result becomes medically verified.
```

A Workspace may produce multiple Features.

```text
Pathologist Workspace

F01 — View Laboratory Result
F02 — View Patient Context
F03 — Verify Laboratory Result
F04 — Reject Laboratory Result
```

---

# Handoff to Feature Creation

Each discovered Feature is handed independently to the Feature Creation Skill.

```text
WORKSPACE FEATURE DISCOVERY
              ↓
       Candidate Feature
              ↓
     FEATURE CREATION SKILL
              ↓
      Formal FEATURE Artifact
              ↓
          DEVELOPMENT
```

Workspace Feature Discovery answers:

> What Features are needed?

Feature Creation answers:

> What is the formal definition of this Feature?

Development answers:

> How should this Feature be implemented?

---

# Completion Criteria

Workspace Feature Discovery is complete when:

- Workspace is identified.
- Relevant Domains are identified.
- Relevant Capabilities are identified.
- Actors are identified.
- Work Scenarios are described.
- Required Features are discovered.
- Outcomes are defined.
- Traceability exists from Outcome back to Domain.

The process may produce one or many Features.

Discovery ends when the required Outcomes of the Workspace are sufficiently covered.

---

# Relationship With Other Artifacts

```text
CONCEPTUAL MODEL
Defines:
Domain
Capability
Actor
Screen
Workspace
Feature
Outcome

        ↓

WORKSPACE FEATURE DISCOVERY
Discovers:
What Features a Workspace needs

        ↓

FEATURE CREATION
Formalizes:
What a Feature means

        ↓

DEVELOPMENT
Implements:
How a Feature works
```

---

# Core Mental Model

```text
Domain      = BUSINESS AREA

Capability  = BUSINESS ABILITY

Workspace   = WORK AREA

Actor       = WHO WORKS

Scenario    = WHAT IS HAPPENING

Feature     = WHAT SYSTEM PROVIDES

Outcome     = WHAT IS ACHIEVED
```

The discovery sequence is:

```text
Workspace
    ↓
Context
    ↓
Work Scenario
    ↓
Features
    ↓
Outcomes
```

The sequence stops at:

```text
Feature + Outcome
```

Implementation starts after this boundary.