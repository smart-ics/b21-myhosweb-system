# KAMAR OPERASI DOMAIN

Domain Code: KMO

## Purpose

The Kamar Operasi Domain manages the operational lifecycle of a patient's
surgical procedure, from receiving the operation order through scheduling,
pre-operative preparation, operative procedure, and post-operative recovery.

The domain focuses on the operational coordination and execution of surgery
in the operating room.

Clinical documentation and detailed medical records remain the responsibility
of the EMR domain.

## Definition

Kamar Operasi is the domain responsible for managing the operational delivery
of surgical procedures in the hospital.

It manages the relationship between the patient, operation order, operating
schedule, operating room, surgical preparation, operative procedure, and
recovery.

## Responsibilities

The Kamar Operasi Domain is responsible for:

- Managing operation orders.
- Scheduling surgical procedures and operating room resources.
- Managing pre-operative preparation.
- Managing the operational execution of surgical procedures.
- Managing post-operative recovery within the operating room service.

## Capabilities

### 1. KMO-ORDER — Order Operasi

The capability to receive and manage an operation order for a patient.

An operation order represents the request for a surgical procedure and
provides the basis for scheduling and subsequent operational management.

The order may originate from outpatient, inpatient, emergency, or another
authorized clinical context.

The order represents the request for surgery, not the scheduled or performed
operation.

### 2. KMO-JADWAL — Jadwal Operasi

The capability to schedule a patient's operation against an available
operating room, date, and time.

The capability manages the operational allocation required for the surgical
procedure, including:

- Patient.
- Operation order.
- Operating room.
- Scheduled date and time.
- Surgical team or required PPA when applicable.

A schedule reserves an operating slot but does not mean that the operation
has already been performed.

### 3. KMO-PREOP — Persiapan Operasi

The capability to manage the patient's pre-operative preparation before
the operation begins.

It ensures that the patient and the required operational conditions are
ready for surgery.

This may include:

- Confirmation of patient and planned procedure.
- Verification of the operation schedule.
- Pre-operative preparation requirements.
- Readiness confirmation.
- Recording operational reasons when preparation is incomplete or surgery
  cannot proceed.

Clinical assessment and detailed pre-operative medical documentation remain
within the EMR domain.

### 4. KMO-OPR — Operative Procedure

The capability to manage the operational execution of the surgical procedure.

It records that the scheduled operation has started and manages the
operational information required during and after the procedure.

This includes:

- Confirmation of the patient and operation.
- Operating room assignment.
- Procedure start and completion.
- Surgical team participation.
- Operational procedure information.
- Completion or cancellation of the operation.

Detailed operative notes, findings, diagnoses, and other clinical
documentation remain within the EMR domain.

### 5. KMO-RECOVERY — Recovery

The capability to manage the patient's post-operative recovery within the
operating room service before the patient is transferred to the next
appropriate care area.

It records the operational recovery process and the patient's readiness for
transfer.

The destination may be, for example:

- Inpatient unit.
- Recovery/PACU area.
- Emergency or other appropriate service area.

Clinical monitoring, assessment, and detailed recovery documentation remain
within the EMR domain.

## Domain Boundary

### Owns

- Operation orders.
- Operating schedules.
- Operating room allocation for scheduled procedures.
- Pre-operative operational preparation.
- Operational execution of surgical procedures.
- Post-operative operational recovery.
- Operational transition from surgery to the next care area.

### Does Not Own

- Patient identity and demographic information → Pasien Domain
- Hospital registration and visit creation → Admission Domain
- Service units, operating rooms as organizational resources, and PPA master
  data → Organisasi Domain
- Outpatient clinical care → Rawat Jalan Domain
- Inpatient placement and bed management → Rawat Inap Domain
- Emergency care → Gawat Darurat Domain
- Laboratory services → Laboratory Domain
- Radiology services → Radiology Domain
- Clinical documentation and medical records → EMR / relevant clinical Domain
- Tariff, billing, and payment → Tata Rekening Domain

## Relationships

| Related Domain | Relationship |
|---|---|
| Pasien | Kamar Operasi uses the authoritative patient identity for operation orders and surgical procedures. |
| Organisasi | Kamar Operasi uses operating rooms, PPA, and other organizational resources defined by Organisasi. |
| Admission | Surgical services may be initiated in the context of a registered hospital visit. |
| Rawat Jalan | Outpatient care may initiate an operation order for a patient. |
| Rawat Inap | Inpatient care may initiate surgery and may receive the patient after recovery. |
| Gawat Darurat | Emergency care may initiate or require an urgent surgical procedure. |
| Laboratory / Radiology | Pre-operative preparation may require results or services from these diagnostic domains. |
| EMR | Detailed clinical documentation of the surgical procedure and recovery is maintained by EMR / relevant clinical domains. |
| Tata Rekening | Surgical services may generate chargeable services using tariff information maintained by Tata Rekening. |

## Capability Map

| Capability | Business Ability |
|---|---|
| KMO-ORDER | Manage operation orders for patients |
| KMO-JADWAL | Schedule a surgical procedure on an operating room and time slot |
| KMO-PREOP | Manage operational pre-operative readiness |
| KMO-OPR | Execute and record the operational surgical procedure |
| KMO-RECOVERY | Manage post-operative operational recovery and readiness for transfer |

## Core Invariants

1. An operation must be associated with a patient.
2. An operation schedule must reference an operation order.
3. A scheduled operation does not constitute a performed operation.
4. An operative procedure may begin only after the required pre-operative
   readiness has been satisfied or explicitly overridden by an authorized
   workflow.
5. An operating room must not have conflicting scheduled operations for the
   same time period.
6. An operation must be completed or cancelled before its operational
   lifecycle is closed.
7. Recovery follows the operative procedure and precedes transfer to the
   next care area.
8. Clinical findings and detailed medical documentation are not owned by the
   Kamar Operasi Domain.