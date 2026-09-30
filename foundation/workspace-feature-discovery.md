# WORKSPACE FEATURE DISCOVERY

## Purpose

Workspace Feature Discovery is a focused analysis and design sequence used to discover the Features and Outcomes required by a Workspace.

The sequence starts from an existing Workspace and ends at Feature and Outcome.

Its purpose is to answer:

> What Features are required for an Actor to perform the work of this Workspace and achieve the intended Outcomes?

This sequence does not define implementation.

---

# Scope

## Included

Workspace Feature Discovery includes:

* Workspace analysis
* Domain identification
* Capability identification
* Actor identification
* Operational Scenario analysis
* Use Case definition
* User Journey definition
* Feature discovery
* Outcome definition

## Excluded

Workspace Feature Discovery does not include:

* Navigation design
* UI Layout design
* Database design
* API design
* Application architecture
* Technical implementation
* Testing strategy

These activities belong to later stages.

---

# Conceptual Boundary

Workspace Feature Discovery operates between Business Capability and System Feature.

```text
BUSINESS

Domain
    ↓
Capability


WORKSPACE FEATURE DISCOVERY

Workspace
    ↓
Domain + Capability
    ↓
Actor
    ↓
Operational Scenario
    ↓
Use Case
    ↓
User Journey
    ↓
Feature
    ↓
Outcome


DEVELOPMENT

UI
API
Database
Code
Test
Deployment
```

The sequence ends when Features and Outcomes are clearly defined.

The sequence does not determine how Features are implemented.

---

# Mental Model

Workspace Feature Discovery follows a single principle:

> A Workspace exists to enable an Actor to achieve Outcomes through Features that realize Business Capabilities.

```text
Business Need
      │
      ▼
Capability
      │
      ▼
Actor performs work
      │
      ▼
Operational Scenario
      │
      ▼
Use Case
      │
      ▼
User Journey
      │
      ▼
Feature
      │
      ▼
Outcome
```

Every discovered Feature must be traceable back to:

* a Capability;
* an Actor;
* a Scenario;
* a Use Case;
* a User Journey.

If traceability cannot be established, the Feature should be questioned.

---

# Discovery Sequence

## Step 1 — Workspace

### Purpose

Define the Workspace being analyzed.

### Question

> What work area are we designing?

### Input

Existing Workspace definition.

### Output

Workspace.

### Example

```text
Pathologist Workspace
```

---

## Step 2 — Domain and Capability

### Purpose

Identify the business capabilities required by the Workspace.

### Questions

> Which Domains participate?

> Which Capabilities are required?

### Input

Workspace.

### Output

Relevant Domains and Capabilities.

### Example

```text
LAB
 └─ Lab Result Management

PAS
 └─ Patient Data
```

### Rule

A Workspace may involve Capabilities from multiple Domains.

---

## Step 3 — Actor

### Purpose

Identify who performs the work.

### Question

> Who is responsible for achieving the Outcome?

### Input

Workspace.

### Output

Actor.

### Example

```text
Pathologist
```

---

## Step 4 — Operational Scenario

### Purpose

Describe the real operational situation that requires work to be performed.

### Question

> What is happening in the real world?

### Input

Domain, Capability, Actor.

### Output

Operational Scenario.

### Example

```text
Pathologist receives laboratory
results requiring verification.
```

### Rule

Operational Scenarios describe reality.

They do not describe software screens.

---

## Step 5 — Use Case

### Purpose

Define what the Actor needs to accomplish.

### Question

> What does the Actor need to achieve?

### Input

Operational Scenario.

### Output

Use Case.

### Example

```text
Verify Laboratory Result
```

### Rule

Use Cases describe intent.

They do not describe interaction details.

---

## Step 6 — User Journey

### Purpose

Describe how the Actor performs the work.

### Question

> What activities must be performed to complete the Use Case?

### Input

Use Case.

### Output

User Journey.

### Example

```text
Open Result
    ↓
Review Result
    ↓
Review Patient Context
    ↓
Verify Result
    ↓
Submit Verification
```

### Rule

User Journeys describe work activities.

They do not describe UI components.

---

## Step 7 — Feature

### Purpose

Discover the concrete system behaviors required to support the User Journey.

### Question

> What must the system provide?

### Input

User Journey.

### Output

Features.

### Example

```text
View Result
View Patient Context
Verify Result
Reject Result
```

### Rule

Features are concrete system behaviors.

Features are not:

* screens;
* forms;
* tables;
* reports;
* APIs;
* database structures.

---

## Step 8 — Outcome

### Purpose

Define the business result achieved by the Feature.

### Question

> What has been achieved?

### Input

Feature.

### Output

Outcome.

### Example

```text
Laboratory Result Verified
```

### Rule

Outcomes are expressed in business terms.

Outcomes are never technical results.

---

# Traceability Model

Every Outcome must be traceable to a Feature.

Every Feature must be traceable to a User Journey.

Every User Journey must be traceable to a Use Case.

Every Use Case must be traceable to an Operational Scenario.

Every Operational Scenario must be traceable to an Actor and Capability.

Every Capability must belong to a Domain.

```text
Domain
    ↓
Capability
    ↓
Actor
    ↓
Operational Scenario
    ↓
Use Case
    ↓
User Journey
    ↓
Feature
    ↓
Outcome
```

This chain forms the complete justification for the existence of a Feature.

---

# Completion Criteria

Workspace Feature Discovery is complete when:

* the Workspace is identified;
* participating Domains are identified;
* participating Capabilities are identified;
* Actors are identified;
* Operational Scenarios are defined;
* Use Cases are defined;
* User Journeys are defined;
* Features are discovered;
* Outcomes are defined;
* traceability exists from Outcome back to Domain.

At this point Feature Discovery ends.

Implementation begins in the Development stage.

# Mental Boundary

Capability explains WHY a Feature exists.

Actor explains WHO needs it.

Scenario explains WHEN it is needed.

Use Case explains WHAT must be accomplished.

Journey explains HOW work is performed.

Feature explains WHAT the system must provide.

Outcome explains WHAT is achieved.