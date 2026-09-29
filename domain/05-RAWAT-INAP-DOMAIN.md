# RAWAT INAP DOMAIN

## Purpose

The Rawat Inap Domain manages the operational administration of inpatient care after a patient is admitted until the inpatient stay ends or the patient is transferred or discharged.

It is responsible for managing the patient's inpatient placement, bed occupancy, movement between inpatient units, room charging, and operational readiness of beds.

Clinical and medical records remain the responsibility of the EMR domain.

---

## Definition

Rawat Inap is the domain responsible for managing the operational lifecycle of a patient's inpatient stay, including placement into an inpatient unit and bed, transfer between units, bed readiness, and the determination of room charges.

---

## Responsibilities

The Rawat Inap Domain is responsible for:

* Managing inpatient placement and bed occupancy.
* Managing patient movement between inpatient units.
* Managing the queue of patients waiting to be placed in an inpatient bed.
* Managing bed readiness for patient placement.
* Determining the final room charge for an inpatient stay.
* Maintaining the operational record of the patient's inpatient location.

---

## Capabilities

### 1. Antrian Masuk Bangsal

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

### 2. Inpatient Registration

Registers a patient into an inpatient unit and assigns the patient to an available bed.

This capability establishes the patient's actual inpatient location.

Registration is performed by the authorized staff of the receiving inpatient unit.

---

### 3. Bed Occupancy

Manages the occupancy of inpatient beds by patients.

This capability maintains the current relationship between:

* Inpatient unit
* Bed
* Patient
* Occupancy period

A bed is considered occupied only when a patient has actually been placed into that bed.

---

### 4. Patient Transfer

Manages the movement of an inpatient from one inpatient unit to another.

A transfer consists of:

* Leaving the current inpatient unit.
* Recording the destination unit when applicable.
* Allowing the receiving unit to perform the actual registration and bed placement.

The transfer capability does not itself imply that the patient has already been registered in the destination unit.

---

### 5. Room Charge

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

### 6. Housekeeping

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

### 7. Inpatient Discharge

Manages the operational completion of an inpatient stay when the patient leaves inpatient care.

This capability records the patient's departure from the inpatient bed and releases the occupied bed into the appropriate post-occupancy state for housekeeping.

Clinical discharge documentation remains within the appropriate clinical/EMR responsibilities.

---

## Domain Boundary

### Owns

* Inpatient destination queue.
* Inpatient registration.
* Bed occupancy.
* Inpatient transfer.
* Inpatient location.
* Room charging calculation based on occupancy.
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

* Definition of room tariffs.
* Tariff master data.
* Pricing rules independent of inpatient occupancy.

**EMR / Clinical Domains**

* Clinical documentation.
* Diagnosis.
* Clinical procedures and medical observations.
* Nursing/medical clinical records.

---

## Relationships

| Related Domain | Relationship                                                                                                  |
| -------------- | ------------------------------------------------------------------------------------------------------------- |
| Pasien         | Rawat Inap operates on a specific patient.                                                                    |
| Organisasi     | Rawat Inap uses inpatient units, rooms, and beds defined by Organisasi.                                       |
| Admission      | Admission may assign an inpatient destination, but the receiving unit performs actual inpatient registration. |
| Tata Rekening  | Provides the base room tariff used by Room Charge.                                                            |
| EMR            | Clinical and medical information is maintained outside Rawat Inap.                                            |

---

## Core Invariant

A patient is considered **actually admitted to an inpatient unit only after the receiving unit has registered the patient into a bed**.

An assigned destination or inpatient queue entry does not constitute inpatient bed occupancy.
