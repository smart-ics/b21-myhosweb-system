---

DocumentName: Apotek Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
----------------------

# APOTEK DOMAIN

Domain Code: **APT**

## 1. Purpose

The **Apotek** Domain manages the provision of patient medication from accepted medication demand through medication sales, dispensing, and handover.

It ensures that medication demand is professionally assessed, commercially accountable, physically fulfilled, and traceable to its source.

## 2. Definition

**Apotek** is the domain responsible for managing **patient-specific medication fulfillment and its related pharmacy transaction**.

The domain covers medication demand accepted by Pharmacy, its commercial representation, physical dispensing, medication handover, and resolution of unfulfilled medication.

The original prescription remains authoritative in the clinical-order source. Apotek uses that prescription as the source for its pharmacy processing.

## 3. Responsibilities

The Apotek Domain is responsible for:

* Reviewing and accepting prescription medication demand.
* Accepting or declining medication requests without a prescription.
* Creating and managing the pharmacy sales order.
* Managing the commercial representation of medication sales.
* Managing medication dispensing and preparation.
* Managing the pharmacy queue and medication pickup process.
* Completing medication handover.
* Managing return and other unfulfilled medication outcomes.
* Maintaining traceability between accepted medication demand, commercial transactions, and physical fulfillment.

## 4. Capabilities

### 4.1 APT-RESEP — Resep

**Definition**

The capability to receive and manage medication prescriptions as the source of patient medication demand processed by Pharmacy.

**Responsibility**

* Receive prescription information from the authoritative clinical-order source.
* Create the pharmacy working representation of a prescription when required.
* Maintain traceability to the original prescription.
* Provide prescription items as the basis for professional review.

Apotek does not become the owner of the original clinical prescription.

### 4.2 APT-TELAAH — Telaah Resep

**Definition**

The capability to perform and record the Pharmacist's professional review of prescription medication demand before it is accepted for fulfillment.

**Responsibility**

* Review prescription items.
* Determine accepted, partially accepted, or rejected medication demand.
* Record the result of the review.
* Provide accepted medication items for subsequent pharmacy processing.

### 4.3 APT-QUEUE — Antrian Apotek

**Definition**

The capability to manage the patient's participation in the Pharmacy service queue.

**Responsibility**

* Identify patients waiting for Pharmacy service.
* Associate a Pharmacy queue entry with the applicable medication demand.
* Support the progression of the patient through the Pharmacy service process.
* Support patient pickup and completion of the Pharmacy queue interaction.

The canonical queue identity and queue lifecycle are owned by the Patient Tracker / queue authority. Apotek owns the pharmacy meaning and mapping of the queue interaction.

### 4.4 APT-ORDER — Sales Order

**Definition**

The capability to establish and manage the accepted medication demand as a pharmacy Sales Order.

**Responsibility**

* Establish accepted medication demand as Sales Order Items.
* Maintain the accountable quantity available for billing and fulfillment.
* Coordinate commercial and physical fulfillment from the same accepted demand.
* Support partial fulfillment and other accountable fulfillment outcomes.

A Sales Order is the common source for the commercial and physical fulfillment processes.

### 4.5 APT-BILL — Sales Bill

**Definition**

The capability to represent the commercial transaction resulting from accepted medication demand.

**Responsibility**

* Create medication sales billing from Sales Order Items.
* Maintain the commercial information required for financial processing.
* Support billing independently from physical dispensing.
* Maintain traceability from billed medication back to the Sales Order.

Financial payment, settlement, and broader hospital billing authority remain outside this capability.

### 4.6 APT-DISPENSING — Dispensing

**Definition**

The capability to prepare and physically fulfill medication from accepted Sales Order Items.

**Responsibility**

* Establish dispensing instructions.
* Allocate medication quantities for physical fulfillment.
* Support medication preparation.
* Support professional final dispensing review where required.
* Record medication dispense.
* Coordinate stock movement with the Inventory Domain.

Dispensing is independent from the Sales Bill lifecycle, while both remain traceable to the Sales Order.

### 4.7 APT-SERAH — Serah Obat

**Definition**

The capability to complete the transfer of prepared medication to the patient or authorized recipient.

**Responsibility**

* Prepare medication for pickup.
* Call the patient for pickup when applicable.
* Perform the final professional check before handover.
* Record patient education acknowledgement where applicable.
* Record medication handover.
* Support accountable no-show or uncollected-medication resolution.

Medication handover is the final pharmacy fulfillment act. It does not represent clinical medication administration.

### 4.8 APT-RETUR — Return

**Definition**

The capability to manage medication returned after or during the fulfillment process.

**Responsibility**

* Record medication return.
* Determine the applicable return outcome.
* Coordinate eligible returned stock with the Inventory Domain.
* Preserve traceability to the original dispensing and medication transaction.

## 5. Domain Boundary

### Owns

* Pharmacy prescription processing and working prescription representation.
* Prescription review results.
* Acceptance of medication demand without a prescription.
* Sales Order and Sales Order Items for accepted medication demand.
* Medication sales / Sales Bill representation.
* Dispensing and dispensing outcomes.
* Medication dispense and handover.
* Pharmacy-specific pickup and uncollected-medication resolution.
* Medication return processing.
* Traceability across pharmacy fulfillment.

### Does Not Own

* Patient identity and demographics → **Pasien Domain**
* Original clinical prescription / clinician medication order → **clinical-order / EMR authority**
* Hospital service units, PPA, and pharmacy organization → **Organisasi Domain**
* Hospital registration and visit creation → **Admission Domain**
* Outpatient clinical care → **Rawat Jalan Domain**
* Inpatient care → **Rawat Inap Domain**
* Emergency care → **Gawat Darurat Domain**
* Medication master and formulary authority → **Medication Catalog / formulary authority**
* Physical inventory and stock ledger → **Inventory Domain**
* Supplier and procurement → **Purchasing Domain**
* Financial responsibility, billing authority, payment, and settlement → **Tata Rekening / Payment authority**
* Clinical medication administration → **clinical care / EMR domain**

## 6. Relationships

| Domain                                   | Relationship                                                                                                                              |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Pasien                                   | Apotek uses the authoritative patient identity for medication fulfillment.                                                                |
| Organisasi                               | Apotek uses pharmacy service units and PPA defined by Organisasi.                                                                         |
| Admission                                | Apotek uses the patient's active registration / visit context where required.                                                             |
| Rawat Jalan / Rawat Inap / Gawat Darurat | Apotek fulfills medication demand originating from the relevant care setting.                                                             |
| Inventory                                | Apotek requests stock movement and fulfillment-related inventory actions. Inventory remains authoritative for physical stock.             |
| Tata Rekening                            | Apotek provides medication sale information for financial processing and consumes financial / coverage outcomes required for fulfillment. |
| Clinical Order / EMR                     | Apotek uses the authoritative prescription while keeping pharmacy processing separate from clinical documentation.                        |

## 7. Capability Map

| Capability                  | Business Ability                                                        |
| --------------------------- | ----------------------------------------------------------------------- |
| APT-RESEP — Resep           | Manage prescription-based medication demand entering Pharmacy.          |
| APT-TELAAH — Telaah Resep   | Professionally assess prescription medication demand before acceptance. |
| APT-QUEUE — Antrian Apotek  | Manage the patient's Pharmacy service queue interaction.                |
| APT-ORDER — Sales Order     | Manage accepted medication demand as the accountable pharmacy order.    |
| APT-BILL — Sales Bill       | Represent accepted medication demand as a commercial medication sale.   |
| APT-DISPENSING — Dispensing | Physically prepare and fulfill medication.                              |
| APT-SERAH — Serah Obat      | Transfer medication to the patient or authorized recipient.             |
| APT-RETUR — Return          | Manage returned medication and its resulting outcome.                   |
