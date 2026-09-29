# RADIOLOGI DOMAIN

Domain Code: **RAD**

## Purpose

The **Radiology Domain** manages the operational delivery of radiology examinations for patients.

It manages radiology orders, examination scheduling, examination execution, and radiologist expertise/reporting.

Clinical findings and broader medical records remain the responsibility of the EMR domain.

---

## Definition

**Radiology** is the domain responsible for managing the operational lifecycle of a patient's radiology examination, from the radiology order through scheduling, examination, and expertise.

Unlike Laboratory services, radiology examination requires the **patient to be physically present at the examination time** because the examination is performed directly on the patient using radiology equipment.

---

## Responsibilities

The Radiology Domain is responsible for:

* Managing radiology orders.
* Scheduling radiology examinations.
* Managing examination slots for patients and radiology equipment.
* Recording the execution of radiology examinations.
* Managing radiologist expertise and examination reporting.

---

## Capabilities

### 1. RAD-ORDER — Order Radiologi

The capability to create and manage a **radiology examination order** for a patient.

The order identifies the radiology service requested for the patient and provides the basis for scheduling and examination.

The order may originate from an outpatient, inpatient, emergency, or other authorized clinical context.

The order represents the **request for examination**, not the examination itself.

---

### 2. RAD-JADWAL — Jadwal Radiologi

The capability to schedule a patient's radiology examination against a specific radiology equipment resource and examination time.

Radiology scheduling is required because the patient must be physically present when the examination is performed.

The capability manages:

* Examination date and time.
* Patient.
* Radiology examination/order.
* Radiology equipment used for the examination.
* Availability of examination slots.

The fundamental scheduling relationship is:

```text
Patient
   +
Radiology Examination
   +
Radiology Equipment
   +
Date / Time
```

A time slot is therefore created **for a patient on a specific radiology equipment resource**.

This is different from Laboratory scheduling or specimen collection, where the patient does not necessarily need to remain present during the analytical processing of the specimen.

---

### 3. RAD-EXAM — Examination

The capability to perform and record the **radiology examination** for the patient according to the applicable order and schedule.

It manages the operational execution of the examination, including:

* Confirming the patient for examination.
* Performing the examination using the scheduled equipment.
* Recording that the examination has been performed.
* Associating the examination with the resulting radiology study/data.

The clinical interpretation of the examination belongs to the **RAD-EXPERTISE** capability.

---

### 4. RAD-EXPERTISE — Expertise

The capability to produce and manage the **radiologist's expertise/report** for a completed radiology examination.

It records the radiologist's interpretation of the radiology study and the resulting report.

The expertise is associated with the corresponding radiology examination.

Detailed clinical documentation and the broader medical record remain within the EMR domain.

---

## Domain Boundary

### Owns

* Radiology orders.
* Radiology examination schedules.
* Patient-specific equipment scheduling.
* Radiology examination execution.
* Radiology examination studies.
* Radiologist expertise/reporting.

### Does Not Own

* Patient identity and demographic information → **Pasien Domain**
* Hospital service units, equipment ownership, and PPA master data → **Organisasi Domain**
* Hospital registration and visit creation → **Admission Domain**
* Outpatient clinical care → **Rawat Jalan Domain**
* Inpatient care → **Rawat Inap Domain**
* Emergency care → **Gawat Darurat Domain**
* Laboratory services → **Laboratory Domain**
* Clinical documentation and broader medical records → **EMR / relevant clinical domains**
* Tariff and financial transactions → **Tata Rekening Domain**

---

## Relationships

| Related Domain | Relationship                                                                                              |
| -------------- | --------------------------------------------------------------------------------------------------------- |
| Pasien         | Radiology uses the authoritative patient identity for radiology orders and examinations.                  |
| Organisasi     | Radiology uses services, PPA, and radiology equipment defined by Organisasi.                              |
| Admission      | Radiology may receive examination orders within the context of a registered patient visit.                |
| Rawat Jalan    | Outpatient care may create a radiology order as part of the patient's care.                               |
| Rawat Inap     | Inpatient care may create a radiology order for an admitted patient.                                      |
| Gawat Darurat  | Emergency care may create a radiology order as part of emergency treatment.                               |
| Laboratory     | Radiology and Laboratory are separate diagnostic service domains.                                         |
| EMR            | Clinical documentation and broader medical records are maintained outside the Radiology Domain.           |
| Tata Rekening  | Radiology services may generate chargeable services using tariff information maintained by Tata Rekening. |

---

## Capability Map

| Capability    | Business Ability                                                                        |
| ------------- | --------------------------------------------------------------------------------------- |
| RAD-ORDER     | Manage radiology examination orders for patients                                        |
| RAD-JADWAL    | Schedule a patient examination on a specific radiology equipment resource and time slot |
| RAD-EXAM      | Perform and record the radiology examination                                            |
| RAD-EXPERTISE | Produce and manage the radiologist's examination report                                 |

---

## Core Invariants

1. A radiology examination must be associated with a patient.
2. A scheduled radiology examination is assigned to a specific radiology equipment resource and time slot.
3. A radiology schedule does not itself constitute completion of the examination.
4. An examination must be performed before its expertise/report can be finalized.
5. Radiology scheduling must prevent conflicting use of the same equipment and time slot.
6. Radiology owns the operational examination process; broader clinical documentation belongs to the EMR domain.
