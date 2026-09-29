# GAWAT DARURAT DOMAIN

Domain Code: **IGD**

## Purpose

The **Gawat Darurat** Domain manages the operational delivery of emergency care from the moment a patient arrives at the Emergency Department until the emergency episode is completed, transferred to inpatient care, or referred onward.

The domain is designed for the specific characteristics of emergency care, where patient treatment may begin immediately without waiting for hospital admission registration.

Clinical and medical documentation remains the responsibility of the EMR domain.

---

## Definition

**Gawat Darurat** is the domain responsible for managing the operational lifecycle of an emergency care episode, including emergency patient arrival, triage, emergency procedures, and transfer to inpatient care when required.

Unlike regular outpatient or inpatient care, an emergency episode may begin **before an admission registration exists**.

---

## Responsibilities

The Gawat Darurat Domain is responsible for:

* Recording an emergency visit.
* Managing emergency triage.
* Recording chargeable emergency procedures and interventions.
* Managing transfer from emergency care to inpatient care.
* Managing ambulance usage and its associated charges.

---

## Capabilities

### 1. IGD Visit

The capability to record and manage a patient's **emergency visit**.

An IGD Visit is created when a patient arrives at the Emergency Department and requires emergency care.

An IGD Visit does **not require an Admission registration to exist first**.

This allows emergency care to begin immediately when administrative registration cannot or should not precede treatment.

An Admission registration may be created later and associated with the existing IGD Visit.

The IGD Visit therefore provides the operational context for emergency care before formal admission registration is completed.

---

### 2. Triage

The capability to perform and record **emergency triage**.

Triage determines the patient's emergency priority and supports the ordering of care according to the urgency of the patient's condition.

Triage is an operational emergency-care activity and is performed within the IGD encounter.

Clinical findings and detailed medical documentation remain within the EMR domain.

---

### 3. IGD Tindakan

The capability to record and manage **chargeable procedures and interventions performed during an emergency visit**.

Emergency procedures may be performed **without an Admission registration existing first**.

This is intentional because emergency treatment may need to begin immediately.

This capability focuses on the administrative representation of procedures for service charging.

It does not own the clinical documentation of the procedure.

Examples:

* Emergency procedure charge
* Nursing intervention charge
* Minor emergency procedure
* Other billable emergency services

Clinical documentation, findings, observations, assessments, and medical records remain within the EMR domain.

---

### 4. IGD Rawat Inap

The capability to transfer an emergency patient into inpatient care when continued hospitalization is required.

The capability records the transition from emergency care to the inpatient process.

Example:

```text
IGD Visit
   ↓
Emergency Care
   ↓
Decision for Inpatient Care
   ↓
Rawat Inap
```

The Gawat Darurat Domain records the patient's transfer from IGD.

The Rawat Inap Domain remains responsible for inpatient registration, bed placement, and inpatient stay management.

---

### 5. Ambulance

The capability to record the **use of a hospital ambulance** and determine the associated charge.

Ambulance charging is based on one of two charging methods configured by the hospital:

* **Destination Area** — charge based on the destination area.
* **Travel Distance** — charge based on the distance traveled.

Only one charging method is applied for a particular ambulance service.

This capability records the ambulance usage and the information required to determine the applicable charge.

---

## Domain Boundary

### Owns

* IGD Visit.
* Emergency triage.
* Emergency procedures and interventions for charging purposes.
* Transfer from IGD to inpatient care.
* Ambulance usage and ambulance charge calculation.

### Does Not Own

* Patient identity and demographic information → **Pasien Domain**
* Hospital registration and general admission process → **Admission Domain**
* Hospital service units, PPA, and organizational structure → **Organisasi Domain**
* Inpatient registration and bed placement → **Rawat Inap Domain**
* Outpatient clinical care → **Rawat Jalan Domain**
* Clinical documentation and medical records → **EMR / relevant clinical domains**
* Billing and payment → **Tata Rekening Domain**
* Tariff master data → **Tata Rekening Domain**

---

## Relationships

| Related Domain | Relationship                                                                                                                       |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Pasien         | Gawat Darurat uses the authoritative patient identity for an emergency visit.                                                      |
| Organisasi     | Gawat Darurat uses the IGD service unit and relevant PPA defined by Organisasi.                                                    |
| Admission      | An IGD Visit may exist before Admission registration; the admission registration may subsequently reference the emergency episode. |
| Rawat Inap     | IGD transfers patients to Rawat Inap when inpatient care is required.                                                              |
| Tata Rekening  | Provides applicable tariff information for chargeable emergency services and ambulance services.                                   |
| EMR            | Clinical findings, assessments, procedures, and medical documentation are maintained by EMR/clinical domains.                      |

---

## Core Invariants

1. An **IGD Visit may exist without an Admission registration**.
2. Emergency treatment may be performed before Admission registration exists.
3. Admission registration may be completed after the IGD Visit has already started.
4. IGD transfer to inpatient care does not itself constitute inpatient registration.
5. Ambulance charging uses **either destination area or travel distance**, not both for the same charge.
