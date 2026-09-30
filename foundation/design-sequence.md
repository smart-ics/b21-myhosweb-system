# ICS DESIGN SEQUENCE

## FULL SEQUENCE
```
1. Domain
      ↓
2. Actor / Role
      ↓
3. Operational Scenario
      ↓
4. Use Case
      ↓
5. User Journey
      ↓
6. Navigation
      ↓
7. UI Layout
      ↓
8. Feature
      ↓
9. Implementation
```


## 1. Domain

**Definition**

A Domain is a bounded business capability that defines a specific area of organizational responsibility, knowledge, and operational concern.

It describes the business concepts, rules, states, and relationships that exist within that capability, independent of actors, workflows, user interfaces, or software implementation.

---

## 2. Actor / Role

**Definition**

An Actor is a category of participant that interacts with the operational system and possesses a distinct responsibility, authority, or perspective within the organization.

It defines who participates in operational activities and how that participant relates to the business domain.

---

## 3. Operational Scenario

**Definition**

An Operational Scenario is a real-world operational situation that occurs within the business environment and requires one or more actors to pursue a business outcome.

It describes the context in which operational work occurs, independent of software interaction or user interface concerns.

---

## 4. Use Case

**Definition**

A Use Case is a goal-oriented interaction between an actor and the system that enables the actor to achieve a specific operational outcome within an operational scenario.

It defines what the actor intends to accomplish through the system.

---

## 5. User Journey

**Definition**

A User Journey is the end-to-end progression of an actor through one or more use cases while pursuing a broader objective.

It describes the sequence of experiences, decisions, and transitions encountered by the actor from initiation to completion of an operational objective.

---

## 6. Navigation

**Definition**

Navigation is the structural organization of access paths within the system that enables actors to locate and move between system capabilities, information, and interactions.

It defines how the system is organized from the user's perspective.

---

## 7. UI Layout

**Definition**

A UI Layout is the spatial arrangement of information, controls, and interaction elements within a user interface.

It defines how a system capability is visually presented to an actor on a specific screen or view.

---

## 8. Feature

**Definition**

A Feature is a system capability that delivers a specific user outcome by enabling or supporting one or more use cases.

It represents a unit of functionality that provides measurable value to an actor within the operational system.

---

## Relationship Between Artifacts

```text
Domain
    defines
        WHAT business capability exists

Actor
    defines
        WHO participates

Operational Scenario
    defines
        WHEN and WHY operational work occurs

Use Case
    defines
        WHAT an actor wants to accomplish

User Journey
    defines
        HOW the actor progresses toward an objective

Navigation
    defines
        WHERE the actor moves within the system

UI Layout
    defines
        WHAT the actor sees

Feature
    defines
        WHAT the system must do
```

These definitions are sufficiently formal to serve as the authoritative glossary for both humans and agents, while keeping validation rules, quality criteria, and artifact assessment in separate Skills.
