---

DocumentName: Rawat Jalan Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
----------------------

# RAWAT JALAN DOMAIN

Domain Code: **RJL**

## Purpose

The **Rawat Jalan** Domain manages the delivery of outpatient clinical services after a patient has been registered for an outpatient visit.

The domain is responsible for the patient's outpatient clinical encounter, recording chargeable procedures and interventions performed during the encounter, outpatient queue management, internal referral, and optional initial examination before the patient reaches the target clinic.

## Definition

**Rawat Jalan** is the domain that manages the **clinical service delivery of an outpatient visit**.

It begins after outpatient registration and covers the clinical activities performed in outpatient service units until the outpatient clinical encounter is completed or transferred to another service.

## Capabilities

### 1. Konsultasi

The capability to conduct and record the **clinical consultation** between the patient and the healthcare provider during an outpatient encounter.

It includes the clinical assessment and decision-making performed as part of the consultation.

### 2. Tindakan Klinis (RJL-TINDAKAN)

The capability to **record and manage chargeable procedures and interventions associated with an outpatient encounter, representing them as billable service items for financial processing**.

This capability represents the administrative recording of chargeable services delivered in an outpatient setting. It associates each chargeable item with the appropriate patient and outpatient service context to support the financial processing of the resulting charges.

This capability remains consistent with the shared legacy header-detail entity used to record chargeable services across care settings. It focuses strictly on the administrative recording of charges for financial processing.

Clinical documentation, clinical findings, observations, assessments, diagnoses, and medical records are outside the responsibility of this capability and belong to the EMR domain.

Recording a charge does not prove or imply that a clinical procedure was performed or that clinical documentation has been completed.

Examples:

* Consultation charge
* Outpatient procedure charge
* Nursing intervention charge
* Minor surgery charge
* Other billable outpatient service items


### 3. Antrian Poli

The capability to manage the **outpatient clinic queue**.

It organizes patients waiting for service at a specific outpatient clinic and supports the progression of patients through the clinic service queue.

### 4. Rujukan Internal

The capability to transfer a patient from one outpatient service to another service within the hospital as part of the same episode of care.

Examples:

```text
Poli Mata
   ↓
Laboratorium
```

```text
Poli Penyakit Dalam
   ↓
Poli Gizi
```

The destination service remains within the hospital's internal service structure.

### 5. Pemeriksaan Awal

The capability to automatically place patients into a queue for an **initial examination or screening service** before they are served by their target outpatient clinic.

This capability is primarily intended for hospitals where all patients must undergo a common preliminary examination before entering their respective target clinics.

Example:

```text
Patient Registered
       ↓
Initial Examination Queue
       ↓
Initial Examination / Screening
       ↓
Target Outpatient Clinic
```

For example, in a specialized eye hospital, patients may first undergo an initial eye screening before being served by their respective ophthalmology clinic.

The capability determines the patients who require initial examination and automatically places them in the appropriate initial examination queue.

## Domain Boundary

### Owns

* Outpatient clinical consultation.
* Administrative recording of chargeable outpatient procedures and interventions for financial processing.
* Outpatient clinic queues.
* Internal referral between outpatient services.
* Initial examination and screening workflow before outpatient clinic service.

### Does Not Own

* Patient identity and demographic information → **Pasien Domain**
* Booking and appointment → **Admission Domain**
* Hospital registration and visit creation → **Admission Domain**
* Service units, doctors, PPA, and practice schedules → **Organisasi Domain**
* Inpatient care → **Rawat Inap Domain**
* Emergency care → **Gawat Darurat Domain**
* Laboratory services → **Laboratory Domain**
* Radiology services → **Radiology Domain**
* Pharmacy services → **Apotek Domain**
* Clinical documentation, findings, assessments, diagnoses, and medical records → **EMR Domain**
* Tariff master data, billing, and payment processing → **Tata Rekening Domain**

## Relationships

| Domain                          | Relationship                                                                                                           |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Pasien                          | Rawat Jalan uses the authoritative patient identity for outpatient clinical care.                                      |
| Organisasi                      | Rawat Jalan uses service units, PPA, and outpatient practice schedules to deliver and organize outpatient services.    |
| Admission                       | Admission provides the registered outpatient visit that becomes the context for outpatient clinical care.              |
| Rawat Inap                      | A patient may be transferred from outpatient care to inpatient care when clinically required.                          |
| Gawat Darurat                   | A patient may be directed to emergency care when the required service falls outside outpatient care.                   |
| Laboratory / Radiology / Apotek | Rawat Jalan may initiate or direct patient care toward these service domains as part of the patient's outpatient care. |
| Tata Rekening                   | Provides applicable procedure tariffs and receives billable outpatient service charges for patient billing.            |

## Capability Map

| Capability       | Business Ability                                                                                               |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| Konsultasi       | Conduct and record outpatient clinical consultation                                                            |
| Tindakan Klinis  | Record and manage chargeable outpatient procedures and interventions for financial processing                  |
| Antrian Poli     | Manage the patient queue for outpatient clinics                                                                |
| Rujukan Internal | Transfer patients between internal outpatient services                                                         |
| Pemeriksaan Awal | Automatically queue patients for required initial examination or screening before the target outpatient clinic |
