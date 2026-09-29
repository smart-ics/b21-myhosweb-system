---
name: mhw-domain-creation
description: Create or update a DOMAIN artifact that formalizes a Business Capability and its owned business knowledge.
license: Proprietary
compatibility: myhospital-web
metadata:
  audience: analyst, architect, product-owner
  artifact: DOMAIN
---

# Purpose

Create a DOMAIN artifact that serves as the authoritative definition of a Business Capability.

A DOMAIN artifact exists to answer:

"What business capability does this domain own?"

The DOMAIN artifact is a business knowledge contract.

It defines:

- capability ownership,
- business boundaries,
- owned knowledge,
- business responsibilities,
- authorities,
- business rules,
- state ownership.

The artifact must be understandable by:

- humans,
- analysts,
- architects,
- AI agents.

---

# Core Concept

## Domain

A Domain represents a Business Capability.

A Domain owns:

- business knowledge,
- business rules,
- business state,
- business authority,
- business terminology.

A Domain must remain valid even if:

- screens change,
- workflows change,
- features change,
- implementations change.

---

## Capability

A Capability is not a Feature.

Capability answers:

"What responsibility does this domain own?"

Examples:

- Patient Management
- Admission Management
- Laboratory Result Management
- Inventory Management
- Request Management

Capabilities are stable.

---

## Feature

A Feature represents a User Outcome.

Feature answers:

"What meaningful outcome can a user achieve?"

Examples:

- Register Patient
- Admit Patient
- Print Laboratory Result
- Transfer Stock
- Approve Request

Features consume Domain Capabilities.

Domains do not consume Features.

---

# Domain Principles

## Principle 1

A Domain owns business knowledge.

It does not own implementation.

---

## Principle 2

A Domain owns responsibilities.

It does not own user workflows.

---

## Principle 3

A Domain owns business state.

It does not own UI flow.

---

## Principle 4

A Domain must have explicit boundaries.

Every Domain must clearly state:

- what it owns,
- what it does not own.

---

## Principle 5

A Domain must be independently understandable.

An analyst should understand the Domain without reading:

- Feature artifacts,
- UI artifacts,
- Architecture artifacts.

---

# Capability Identification Rules

A candidate Capability should:

- represent a stable business responsibility,
- own business knowledge,
- own business rules,
- own business state,
- have clear authority,
- have explicit boundaries.

A candidate Capability should NOT be created merely because:

- a menu exists,
- a screen exists,
- a database table exists,
- an API exists,
- a use-case exists.

---

# Domain Boundary Test

For every Domain ask:

1. What responsibility does this Domain own?
2. What knowledge does this Domain own?
3. What state does this Domain own?
4. What authority does this Domain own?
5. What decisions belong to this Domain?
6. What explicitly belongs elsewhere?

If these questions cannot be answered clearly, the Domain boundary is not yet mature.

---

# What Belongs In DOMAIN

DOMAIN may contain:

- Domain Purpose
- Domain Boundary
- Business Overview
- Ubiquitous Language
- Domain Capabilities
- Authorities
- Domain Objects
- Aggregates
- Business Rules
- Domain State Model
- Domain Events
- Cross Domain Relationships

---

# What Does NOT Belong In DOMAIN

DOMAIN must not contain:

- Features
- User Outcomes
- User Journeys
- Use Cases
- Navigation
- Screens
- UI Layout
- Acceptance Criteria
- SOPs
- APIs
- Database Design
- Source Code Design
- Technical Architecture
- Infrastructure Design

---

# Domain State Model

A Domain may define business state ownership.

The Domain State Model describes:

- valid business states,
- allowed transitions,
- invariants,
- terminal states.

Example:

Request

Draft
→ Submitted
→ Assessed
→ Approved
→ Completed
→ Closed

The Domain State Model must not describe:

- UI workflow,
- screen flow,
- operational procedures,
- user interaction sequences.

---

# Cross Domain Relationship Rules

Relationships should be expressed as:

- depends on,
- references,
- receives information from,
- provides information to.

Avoid implementation relationships.

The artifact describes business relationships only.

---

# Output

Produce:

<CODE>-DOMAIN.md

The artifact must follow:

assets/domain-template.md

---

# Versioning

Use:

Major.Minor

Update:

- Version
- LastUpdated

Do not maintain change history inside the artifact.

---

# Agent Behaviour

When creating or updating a Domain:

1. Identify the business capability.
2. Establish the domain boundary.
3. Identify owned responsibilities.
4. Identify owned knowledge.
5. Identify owned state.
6. Identify authorities.
7. Identify business rules.
8. Identify domain events.
9. Identify relationships to other domains.
10. Identify what is explicitly out of scope.

Prefer explicit boundaries over exhaustive documentation.

Avoid inventing business knowledge.

If information is unclear:

- mark it as unresolved,
- identify ambiguity,
- do not fabricate facts.

The resulting artifact should function as the authoritative business definition of the capability.