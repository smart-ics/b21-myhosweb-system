# TATA REKENING DOMAIN

Domain Code: **TRK**

## Purpose

The **Tata Rekening** Domain manages the hospital's financial charging and payment structure related to patient services.

It defines the tariff and guarantee structures used to determine patient charges, records billing and payment activity, manages patient deposits and vouchers, and manages cash receipt and disbursement through the cashier.

## Definition

**Tata Rekening** is the domain responsible for managing **how hospital services are valued, charged, covered, and paid for** in the context of patient care.

The domain provides the financial structures used by clinical and operational domains when services generate charges.

---

## Responsibilities

The Tata Rekening Domain is responsible for:

* Maintaining hospital tariff master data.
* Maintaining guarantee/payer master data and patient membership.
* Managing patient billing and charges.
* Managing payment transactions.
* Managing hospital-issued payment vouchers.
* Managing patient deposits.
* Managing cashier receipts and disbursements.
* Maintaining the financial relationship between charges, guarantees, and payments.

---

## Capabilities

### 1. TRK-TARIF — Tariff

The capability to maintain the hospital's **tariff master data** used to determine the value of chargeable services and facilities.

Tariff includes:

* Procedure Tariff
* Room Tariff
* Ambulance Tariff

Procedure Tariff may include procedures performed by:

* Clinical services
* Operating Room
* Laboratory
* Radiology
* Other chargeable hospital services

Tariff is determined using at least two dimensions:

* **Class** — the service class received by the patient.
* **Tariff Type** — the tariff dimension used to determine the applicable price, commonly mapped to a guarantee/payer.

Therefore, the applicable tariff value is determined by the combination of the chargeable item, **Class**, and **Tariff Type**.

---

### 2. TRK-JAMINAN — Jaminan

The capability to maintain the hospital's **guarantee/payer master data** and the patient's membership in a guarantee.

Jaminan represents the party or mechanism responsible for covering patient charges.

A Jaminan is not limited to insurance. It may include:

* Insurance
* Corporate guarantee
* Other institutional guarantees
* **BAYAR SENDIRI**

A patient who pays without an external guarantee is represented by the **BAYAR SENDIRI** Jaminan.

The capability also manages:

#### Guarantee Classification

A Jaminan may have:

* **Grup Jaminan** — super-dimension
* **Tipe Jaminan** — sub-dimension

It also maintains the government grouping **CaraBayarDK**.

#### Patient Membership

The capability manages patient membership through **Polis**.

Relationship:

```text
Polis
  ↓
Polis Cover
  ↓
Pasien
```

Rules:

* One Polis belongs to one Tipe Jaminan.
* One Polis may cover one or more patients.
* One patient may have multiple Polis.
* A patient may have multiple Polis only when they belong to different Tipe Jaminan.
* **BAYAR SENDIRI** is treated as a Jaminan.

---

### 3. TRK-BILLING — Billing

The capability to manage the **financial charges incurred by a patient within a register**.

Billing is the collection of charge values generated during a patient visit.

Examples include:

* Procedure charges
* Room charges
* Ambulance charges
* Other patient-related charges

Billing represents **what is charged to the patient**, regardless of the operational domain that generated the service.

The source of the service charge remains owned by the corresponding operational or clinical domain.

---

### 4. TRK-PAYMENT — Payment

The capability to manage the **settlement of patient charges**.

Payment records how a patient's financial obligation is paid in relation to the applicable Jaminan.

Payment may therefore be associated with:

* Insurance
* Corporate guarantee
* **BAYAR SENDIRI**
* Other supported payment arrangements

The capability records the financial settlement rather than defining the underlying guarantee master data.

---

### 5. TRK-VOUCHER — Voucher

The capability to manage **hospital-issued payment vouchers** used to reduce or settle eligible patient charges.

Vouchers are issued by the hospital and may be used for:

* Promotions
* Events
* Special programs
* Other authorized purposes

The voucher capability manages the voucher as a financial instrument used in patient billing and payment.

---

### 6. TRK-KASIR — Kasir

The capability to manage **cash receipts and disbursements** handled by hospital cashier operations.

It includes:

* Cash receipt
* Cash disbursement
* Cashier transactions
* Shift-based cashier closing

Cashier activity is operationally closed by **work shift**.

---

### 7. TRK-DEPOSIT — Deposit

The capability to manage **money deposited with the hospital as payment security**, primarily during inpatient care.

A deposit represents money entrusted to the hospital in advance to support settlement of the patient's financial obligations.

Deposit may subsequently be used or accounted for against the patient's financial obligations according to applicable rules.

---

## Domain Boundary

### Owns

* Tariff master data.
* Tariff Class and Tariff Type.
* Jaminan master data.
* Grup Jaminan and Tipe Jaminan.
* CaraBayarDK classification.
* Patient guarantee membership.
* Polis.
* Polis Cover.
* Patient billing.
* Patient payment transactions.
* Hospital-issued vouchers.
* Patient deposits.
* Cashier receipts and disbursements.
* Cashier shift closing.

### Does Not Own

* Patient identity and demographic information → **Pasien**
* Hospital service units, rooms, and beds → **Organisasi**
* Creation of patient registrations and visits → **Admission**
* Clinical service delivery → corresponding clinical Domain
* Generation of clinical procedure charges → corresponding clinical Domain
* Determination of actual room occupancy → **Rawat Inap**
* Determination of how room tariff is applied to occupancy → **Rawat Inap**
* Government claim submission and claim processing → **BPJS**

Tata Rekening owns the **tariff value and financial structures**, while the operational Domains own the service activity that generates the charge.

For example:

```text
Rawat Inap
    ↓
Determines room occupancy
    ↓
Tata Rekening
    ↓
Provides applicable room tariff
```

---

## Relationships

| Related Domain | Relationship                                                                                                   |
| -------------- | -------------------------------------------------------------------------------------------------------------- |
| Pasien         | Tata Rekening uses the authoritative patient identity for billing, payment, deposit, and guarantee membership. |
| Organisasi     | Tata Rekening uses organizational service and room context when defining or applying tariffs.                  |
| Admission      | Billing is associated with a registered patient visit/register created by Admission.                           |
| Rawat Jalan    | Generates chargeable outpatient services that become patient charges in Tata Rekening.                         |
| Rawat Inap     | Uses room tariffs maintained by Tata Rekening and provides room occupancy information for charging.            |
| Gawat Darurat  | Generates chargeable emergency services.                                                                       |
| Laboratory     | Generates chargeable laboratory services.                                                                      |
| Radiology      | Generates chargeable radiology services.                                                                       |
| Kamar Operasi  | Generates chargeable operating room services and procedures.                                                   |
| Apotek         | Generates chargeable pharmacy transactions.                                                                    |
| BPJS           | Uses Jaminan-related information for government guarantee and claim processing.                                |

---

## Capability Map

| Capability  | Business Ability                                                                    |
| ----------- | ----------------------------------------------------------------------------------- |
| TRK-TARIF   | Maintain tariff master data and tariff dimensions used to determine service prices. |
| TRK-JAMINAN | Maintain guarantees/payers and patient guarantee membership.                        |
| TRK-BILLING | Manage patient charges within a register.                                           |
| TRK-PAYMENT | Manage settlement of patient financial obligations.                                 |
| TRK-VOUCHER | Manage hospital-issued payment vouchers.                                            |
| TRK-KASIR   | Manage cashier receipts, disbursements, and shift closing.                          |
| TRK-DEPOSIT | Manage patient deposits held as payment security.                                   |

## Core Rules

1. The applicable tariff is determined by the chargeable item together with the applicable **Class** and **Tariff Type**.
2. **BAYAR SENDIRI** is represented as a Jaminan.
3. One Polis belongs to exactly one Tipe Jaminan.
4. One Polis may cover one or more patients through Polis Cover.
5. One patient may have multiple Polis when the Tipe Jaminan is different.
6. Tata Rekening owns tariff values; operational Domains own the service activity that generates the charge.
7. Billing represents the financial charges associated with a patient register.
8. Cashier activity is closed by work shift.
