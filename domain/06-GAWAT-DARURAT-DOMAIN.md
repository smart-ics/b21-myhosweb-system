---
DocumentName: Gawat Darurat Domain
Version: 1.1
LastUpdate: 2026-10-10
UpdatedBy: Drury Yudis
---

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
* Recording and managing chargeable emergency procedures and interventions.
* Managing transfer from emergency care to inpatient care.
* Managing ambulance usage and its associated charges.

---

## Capabilities

### 1. IGD-VISIT — IGD Visit

The capability to record and manage a patient's **emergency visit**.

An IGD Visit is created when a patient arrives at the Emergency Department and requires emergency care.

An IGD Visit does **not require an Admission registration to exist first**.

This allows emergency care to begin immediately when administrative registration cannot or should not precede treatment.

An Admission registration may be created later and associated with the existing IGD Visit.

The IGD Visit therefore provides the operational context for emergency care before formal admission registration is completed.

---

### 2. IGD-TRIAGE — Triage

The capability to perform and record **emergency triage**.

Triage determines the patient's emergency priority and supports the ordering of care according to the urgency of the patient's condition.

Triage is an operational emergency-care activity and is performed within the IGD encounter.

Clinical findings and detailed medical documentation remain within the EMR domain.

---

### 3. IGD-TINDAKAN — IGD Tindakan

The capability to **record and manage chargeable procedures and interventions associated with an emergency visit, representing them as billable service items for financial processing**.

This capability represents the administrative recording of chargeable services delivered in an emergency care setting. It associates each chargeable item with the appropriate patient and emergency service context to support the financial processing of the resulting charges.

**Emergency-Specific Rule**:
**Chargeable tindakan may be recorded before an Admission registration exists**, because emergency care may begin before formal admission registration. An Admission registration may be linked to the emergency encounter and its charges at a later stage.

This capability remains consistent with the shared legacy header-detail entity used to record chargeable services across care settings. It focuses strictly on the administrative recording of charges for financial processing.

This capability does not own or include clinical documentation, findings, observations, assessments, diagnoses, or medical records, which remain outside its responsibility and belong to the EMR domain.

Recording a charge does not prove or imply that a clinical procedure was performed or that clinical documentation has been completed.

Examples:

* Emergency procedure charge
* Nursing intervention charge
* Minor emergency procedure charge
* Other billable emergency service items

---

### 4. IGD-RANAP — IGD Transfer Ranap

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

### 5. IGD-AMBULANCE — Ambulance

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
* Administrative recording of chargeable emergency procedures and interventions for financial processing.
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

| Related Domain | Relationship                                                                                                                                         |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pasien         | Gawat Darurat uses the authoritative patient identity for an emergency visit.                                                                        |
| Organisasi     | Gawat Darurat uses the IGD service unit and relevant PPA defined by Organisasi.                                                                      |
| Admission      | An IGD Visit may exist before Admission registration; the admission registration may subsequently reference the emergency episode.                   |
| Rawat Inap     | IGD transfers patients to Rawat Inap when inpatient care is required.                                                                                |
| Tata Rekening  | Provides applicable tariff information for chargeable emergency services and ambulance services, and receives billable charges for patient billing. |
| EMR            | Clinical findings, assessments, procedures, and medical documentation are maintained by EMR/clinical domains.                                        |

---

## Capability Map

| Capability Code | Capability Name    | Business Ability                                                                             |
| --------------- | ------------------ | -------------------------------------------------------------------------------------------- |
| IGD-VISIT       | IGD Visit          | Record and manage emergency visits without requiring prior Admission registration            |
| IGD-TRIAGE      | Triage             | Perform and record emergency triage priority for incoming patients                           |
| IGD-TINDAKAN    | IGD Tindakan       | Record and manage chargeable emergency procedures and interventions for financial processing |
| IGD-RANAP       | IGD Transfer Ranap | Manage transfer of emergency patients into inpatient care                                    |
| IGD-AMBULANCE   | Ambulance          | Record ambulance usage and determine distance- or area-based charges                         |

---

## Core Invariants

1. An **IGD Visit may exist without an Admission registration**.
2. Emergency treatment may be performed before Admission registration exists.
3. **Chargeable emergency procedures and interventions may be recorded before an Admission registration exists**.
4. Admission registration may be completed after the IGD Visit has already started.
5. IGD transfer to inpatient care does not itself constitute inpatient registration.
6. Ambulance charging uses **either destination area or travel distance**, not both for the same charge.
