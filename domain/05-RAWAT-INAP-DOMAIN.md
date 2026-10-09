---
DocumentName: Rawat Inap Domain
Version: 1.1
LastUpdate: 2026-10-10
UpdatedBy: Drury Yudis
---

# RAWAT INAP DOMAIN

Domain Code: **RNA**

## Purpose

The Rawat Inap Domain manages the operational administration of inpatient care after a patient is admitted until the inpatient stay ends or the patient is transferred or discharged.

It is responsible for managing the patient's inpatient placement, bed occupancy, movement between inpatient units, room charging, recording chargeable inpatient procedures and interventions, and operational readiness of beds.

Clinical and medical records remain the responsibility of the EMR domain.

---

## Definition

Rawat Inap is the domain responsible for managing the operational lifecycle of a patient's inpatient stay, including placement into an inpatient unit and bed, transfer between units, bed readiness, the determination of room charges, and the administrative recording of chargeable inpatient procedures and interventions.

---

## Responsibilities

The Rawat Inap Domain is responsible for:

* Managing inpatient placement and bed occupancy.
* Managing patient movement between inpatient units.
* Managing the queue of patients waiting to be placed in an inpatient bed.
* Managing bed readiness for patient placement.
* Determining the final room charge for an inpatient stay.
* Recording and managing chargeable procedures and interventions associated with an inpatient stay.
* Maintaining the operational record of the patient's inpatient location.

---

## Capabilities

### 1. RNA-WAITLIST — Waiting List

Manages patients who have been assigned an inpatient destination but have not yet been registered to a specific inpatient unit and bed.

This capability exists because the authority to place a patient into a specific inpatient unit belongs to the receiving unit.

For example:

* Admission may specify **Bangsal Anggrek** as the destination.
* The patient is therefore visible in the Anggrek admission queue.
* The patient is not considered registered in Anggrek until an authorized Anggrek nurse places the patient into a bed.

The same principle applies to transfers:

* A patient may be released from Anggrek with **ICU** as the destination.
* The Anggrek nurse records the patient's departure and destination.
* The ICU nurse performs the actual registration and bed placement in ICU.

Therefore:

**Destination is not the same as inpatient registration.**

---

### 2. RNA-BED — Bed Occupancy

Registers a patient into an inpatient unit, assigns the patient to an available bed, and manages the active occupancy of inpatient beds by patients.

This capability establishes the patient's actual inpatient location and maintains the current relationship between:

* Inpatient unit
* Bed
* Patient
* Occupancy period

Registration is performed by the authorized staff of the receiving inpatient unit. A bed is considered occupied only when a patient has actually been placed into that bed.

---

### 3. RNA-TRANSFER — Patient Transfer

Manages the movement of an inpatient from one inpatient unit to another.

A transfer consists of:

* Leaving the current inpatient unit.
* Recording the destination unit when applicable.
* Allowing the receiving unit to perform the actual registration and bed placement.

The transfer capability does not itself imply that the patient has already been registered in the destination unit.

---

### 4. RNA-ROOMCHARGE — Room Charge

Determines the final charge for the room occupied by an inpatient.

The **Tata Rekening Domain** provides the base room tariff according to the applicable room class and room type.

The Rawat Inap Domain determines the final charge based on the patient's actual occupancy, including:

* Applicable charge multiplier.
* Full-day or partial-day occupancy.
* Same-day admission and discharge.
* Room changes during the day.
* Transfer from one inpatient unit to another.

When a patient transfers between rooms or units, this capability determines the charge attributable to the originating room and the destination room according to the applicable occupancy periods and charging rules.

The Rawat Inap Domain therefore determines **how the room tariff is applied**, while Tata Rekening determines **the tariff value itself**.

---

### 5. RNA-HK — Housekeeping

Manages the operational readiness of inpatient beds after a patient leaves a bed and before another patient may occupy it.

A bed being physically empty does not necessarily mean that it is available for placement.

Housekeeping may be required to:

* Clean the bed and room.
* Perform sterilization or other required sanitation.
* Prepare the room for the next patient.
* Apply special preparation requirements.
* Prepare the room for isolation or other special patient needs.

This capability determines whether an otherwise empty bed is operationally ready to be occupied.

---

### 6. RNA-DISCHARGE — Inpatient Discharge

Manages the operational completion of an inpatient stay when the patient leaves inpatient care.

This capability records the patient's departure from the inpatient bed and releases the occupied bed into the appropriate post-occupancy state for housekeeping.

Clinical discharge documentation remains within the appropriate clinical/EMR responsibilities.

---

### 7. RNA-TINDAKAN — Inpatient Tindakan

The capability to **record and manage chargeable procedures and interventions associated with an inpatient stay, representing them as billable service items for financial processing**.

This capability represents the administrative recording of chargeable services associated with an inpatient stay. It associates each chargeable item with the appropriate patient and inpatient stay context (ward, room, and bed) to support the financial processing of the resulting charges.

This capability remains consistent with the shared legacy header-detail entity used to record chargeable services across care settings. It focuses strictly on the administrative recording of charges for financial processing.

This capability does not own or include clinical documentation, findings, observations, assessments, diagnoses, care plans, or medical records, which remain outside Rawat Inap and belong to the EMR domain.

Recording a charge does not prove or imply that a clinical procedure was performed or that clinical documentation has been completed.

Examples:

* Ward nursing intervention charge
* Inpatient physician procedure charge
* Bedside treatment and therapy charge
* Other billable inpatient service items

---

## Domain Boundary

### Owns

* Inpatient waiting list.
* Bed occupancy and inpatient bed registration.
* Inpatient transfer.
* Inpatient location.
* Room charging calculation based on occupancy.
* Administrative recording of chargeable inpatient procedures and interventions for financial processing.
* Bed readiness and housekeeping state.
* Operational inpatient discharge.

### Does Not Own

**Patient Domain**

* Patient identity.
* Patient demographic and social information.
* Patient master record.

**Organisasi Domain**

* Definition of inpatient units.
* Definition of rooms and beds as organizational resources.

**Admission Domain**

* Booking/appointment.
* Registration into the hospital admission process.
* Initial admission decision and destination assignment.

**Tata Rekening**

* Definition of room tariffs and procedure tariffs.
* Tariff master data.
* Pricing rules independent of inpatient occupancy.
* Patient billing and financial settlement.

**EMR / Clinical Domains**

* Clinical documentation.
* Diagnosis.
* Clinical procedures and medical observations.
* Nursing/medical clinical records.

---

## Relationships

| Related Domain | Relationship                                                                                                                                            |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pasien         | Rawat Inap operates on a specific patient.                                                                                                              |
| Organisasi     | Rawat Inap uses inpatient units, rooms, and beds defined by Organisasi.                                                                                 |
| Admission      | Admission may assign an inpatient destination, but the receiving unit performs actual inpatient registration.                                           |
| Tata Rekening  | Provides base room tariffs used by Room Charge and procedure tariffs for chargeable inpatient services; receives billable charges for patient billing. |
| EMR            | Clinical and medical information is maintained outside Rawat Inap.                                                                                      |

---

## Capability Map

| Capability Code | Capability Name     | Business Ability                                                                             |
| --------------- | ------------------- | -------------------------------------------------------------------------------------------- |
| RNA-WAITLIST    | Waiting List        | Manage patients assigned an inpatient destination waiting for ward placement                 |
| RNA-BED         | Bed Occupancy       | Register a patient into an inpatient bed and manage active bed occupancy                     |
| RNA-TRANSFER    | Patient Transfer    | Manage movement of inpatients between inpatient units                                        |
| RNA-ROOMCHARGE  | Room Charge         | Determine room charges based on occupancy duration, room class, and transfer rules          |
| RNA-HK          | Housekeeping        | Manage bed cleaning and operational readiness for patient placement                          |
| RNA-DISCHARGE   | Inpatient Discharge | Manage operational discharge and bed release when an inpatient stay ends                     |
| RNA-TINDAKAN    | Inpatient Tindakan  | Record and manage chargeable inpatient procedures and interventions for financial processing |

---

## Core Invariant

A patient is considered **actually admitted to an inpatient unit only after the receiving unit has registered the patient into a bed**.

An assigned destination or waiting list entry does not constitute inpatient bed occupancy.
