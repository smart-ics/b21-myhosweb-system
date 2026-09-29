---
Title: <Domain Name>
Code: <DOMAIN_CODE>
Artifact: DOMAIN
Version: 1.0
LastUpdated: YYYY-MM-DD
Status: Draft | Active | Deprecated
---

# 1. Domain Identity

## Name

<Domain Name>

## Code

<DOMAIN_CODE>

## Type

Business Capability

## Summary

One-paragraph description of the business capability owned by this domain.

---

# 2. Domain Purpose

## Why This Domain Exists

Describe the business purpose of this domain.

Answer:

> What business capability does this domain provide?

## Business Value

Describe the value delivered by this capability to the organization.

---

# 3. Domain Boundary

## In Scope

Responsibilities and knowledge owned by this domain.

- ...
- ...
- ...

## Out Of Scope

Responsibilities explicitly owned by other domains.

- ...
- ...
- ...

## Ownership Statement

This domain is the authoritative owner of:

- ...
- ...
- ...

---

# 4. Business Overview

Provide a concise overview of how this business capability operates.

Include:

- major responsibilities
- important concepts
- key decisions
- ownership boundaries

Avoid:

- user workflows
- screen descriptions
- implementation details

---

# 5. Domain Capabilities

## CAP-01 — <Capability Name>

### Definition

Short definition of the capability.

### Responsibility

What responsibility does this capability own?

### Scope

What is included in this capability?

### Explicit Non-Responsibilities

What does this capability NOT own?

### Owned Knowledge

Business facts and information owned by this capability.

### Authorities

Who can make decisions within this capability?

### Inputs

Business information required by this capability.

### Outputs

Business information produced by this capability.

### Business Rules

Rules specific to this capability.

### Invariants

Conditions that must always remain true.

### State Ownership

Business state owned by this capability.

### Related Domain Objects

- ...
- ...
- ...

### Related Aggregates

- ...
- ...
- ...

### Domain Events

- ...
- ...
- ...

---

## CAP-02 — <Capability Name>

### Definition

...

### Responsibility

...

### Scope

...

### Explicit Non-Responsibilities

...

### Owned Knowledge

...

### Authorities

...

### Inputs

...

### Outputs

...

### Business Rules

...

### Invariants

...

### State Ownership

...

### Related Domain Objects

...

### Related Aggregates

...

### Domain Events

...

---

# 6. Authorities

Define business authorities that govern this domain.

| Authority | Responsibility |
|------------|---------------|
| ... | ... |
| ... | ... |

Examples:

- Doctor
- Nurse
- Laboratory Staff
- Pharmacist
- Finance Officer
- Department Head

Use business authority, not system roles.

---

# 7. Ubiquitous Language

| Term | Definition |
|--------|-----------|
| ... | ... |
| ... | ... |

All terms should have a single agreed meaning inside this domain.

---

# 8. Domain Objects

## <Object Name>

### Purpose

Description.

### Owned Information

- ...
- ...
- ...

### Relationships

- ...
- ...
- ...

---

## <Object Name>

...

---

# 9. Aggregates

## <Aggregate Name>

### Purpose

Description.

### Root Entity

<Entity>

### Protected Invariants

- ...
- ...
- ...

### Managed Objects

- ...
- ...
- ...

---

# 10. Business Rules

## BR-001

### Rule

Description.

### Rationale

Why the rule exists.

---

## BR-002

### Rule

Description.

### Rationale

Why the rule exists.

---

# 11. Domain State Model

Describe business state ownership.

This section defines:

- valid states
- allowed transitions
- invariants
- terminal states

This section does NOT define:

- UI flow
- user workflow
- SOP
- implementation flow

## <State Model Name>

### States

```text
<State A>
→ <State B>
→ <State C>
```

### Allowed Transitions

| From | To |
|--------|----|
| ... | ... |
| ... | ... |

### Terminal States

- ...
- ...

### State Rules

- ...
- ...
```

## 12. Domain Events

### EVT-001 — <Event Name>

#### Trigger

What causes the event?

#### Meaning

Business meaning of the event.

#### Produced By

Capability or aggregate producing the event.

#### Consumers

Known business consumers.

---

### EVT-002 — <Event Name>

...

---

# 13. Cross Domain Relationships

## Upstream Domains

Domains that provide information or authority to this domain.

| Domain | Relationship |
|----------|-------------|
| ... | ... |
| ... | ... |

## Downstream Domains

Domains that consume information from this domain.

| Domain | Relationship |
|----------|-------------|
| ... | ... |
| ... | ... |

## Shared Concepts

Concepts referenced across domains.

| Concept | Owner Domain |
|----------|-------------|
| ... | ... |
| ... | ... |

---

# 14. Open Questions

Document unresolved knowledge.

## OQ-001

### Question

...

### Why It Matters

...

### Current Assumption

...

---

# 15. Notes

Additional domain-specific information that does not fit elsewhere.

---

# Validation Checklist

- [ ] Domain boundary is clear.
- [ ] In-scope responsibilities are explicit.
- [ ] Out-of-scope responsibilities are explicit.
- [ ] Capabilities represent business responsibilities.
- [ ] Capabilities are not Features.
- [ ] User outcomes are not modeled here.
- [ ] Business authorities are identified.
- [ ] Business rules are documented.
- [ ] State ownership is documented.
- [ ] Domain events are documented.
- [ ] Cross-domain relationships are identified.
- [ ] No UI concepts included.
- [ ] No API design included.
- [ ] No database design included.
- [ ] No implementation details included.
- [ ] No Feature definitions included.