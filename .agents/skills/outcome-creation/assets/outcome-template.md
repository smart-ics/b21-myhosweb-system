# OUTCOME: {Outcome Name}

| Field       | Value             |
|-------------|-------------------|
| Code        | {CODE}            |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | {YYYY-MM-DD}      |

---

## 1. Business Purpose

> What business need does this Outcome fulfill?

{Describe in 1–3 sentences why this persisted business result must exist.
Use business language. Do not describe implementation or UI.}

---

## 2. Outcome Statement

> What business fact must now exist or change?

{State the Outcome in a single, clear business sentence.}

Example format:
- "{Entity} exists and is ready for {next business activity}."
- "{Entity} has been updated to reflect {business event}."

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| {Domain Name} | {Why this domain is involved} |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| {Capability Name} | {Domain Name} | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- {Business fact that must exist}
- {Business fact that must exist}

### 5.2 Required Recorded Information

- {Information that must be recorded}
- {Information that must be recorded}

### 5.3 Required Business Conditions

- {Condition that must hold true}
- {Condition that must hold true}

### 5.4 Completion Proof

> What proves this Outcome is complete?

- {Observable, verifiable business evidence}
- {Observable, verifiable business evidence}

---

## 6. Outcome Boundary

### Start

{Describe the trigger or event that begins this Outcome.
Example: "Begins when the actor initiates registration."}

### End

{Describe the condition that closes this Outcome.
Example: "Ends when the visit record is persisted and confirmed."}

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- {Constraint: e.g., "A patient must exist before a visit can be registered."}
- {Constraint}

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| {Exception condition} | {What should happen} |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | {Business-oriented, testable statement} | Completeness |
| AC-02 | {Business-oriented, testable statement} | Correctness |
| AC-03 | {Business-oriented, testable statement} | Constraint |
| AC-04 | {Business-oriented, testable statement} | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- {Excluded concern — e.g., "Billing processing is not part of this Outcome."}
- {Excluded concern}
