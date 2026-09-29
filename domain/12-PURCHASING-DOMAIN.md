---

DocumentName: Purchasing Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
----------------------

# PURCHASING DOMAIN

Domain Code: **PUR**

## Purpose

The **Purchasing** Domain manages the hospital procurement lifecycle from identifying material requirements through supplier purchasing, goods receipt, invoice processing, and purchase return.

Its responsibility is to ensure that the hospital's material procurement is properly requested, purchased, received, invoiced, and traceable to its source.

## Definition

**Purchasing** is the domain responsible for managing the **procurement of goods and materials from suppliers for the hospital**.

The Domain covers supplier management and the operational lifecycle of procurement documents:

```text
Material Requirement
        ↓
Purchase Request
        ↓
Purchase Order
        ↓
Goods Receipt
        ↓
Supplier Invoice
        ↓
Purchase Return
```

Purchasing does not own the physical stock balance. Physical inventory and stock movements remain authoritative in the **Inventory Domain**.

## Responsibilities

The Purchasing Domain is responsible for:

* Maintaining supplier information used for procurement.
* Managing material requirements.
* Managing purchase requests.
* Managing purchase orders with suppliers.
* Managing receipt of purchased goods.
* Managing supplier invoices related to purchases.
* Managing purchase returns.
* Maintaining traceability across the procurement lifecycle.

## Capabilities

### 1. PUR-SUPPLIER — Supplier

The capability to maintain suppliers that provide goods or materials to the hospital.

It manages the supplier information required for procurement activities, including:

* Supplier identity.
* Supplier contact information.
* Supplier address.
* Supplier commercial information.
* Supplier status.

The Supplier capability provides the authoritative supplier information used by procurement transactions.

---

### 2. PUR-MATREQ — Material Request

The capability to record and manage a request for materials required by the hospital.

A Material Request represents the **need for goods or materials** before a purchase decision is made.

It may originate from an operational unit that requires materials for hospital activities.

The capability manages:

* Requested materials.
* Requested quantities.
* Requesting unit.
* Required date when applicable.
* Request status.
* The relationship between the requirement and subsequent procurement activity.

A Material Request represents a material need, not yet a purchase from a supplier.

---

### 3. PUR-PURREQ — Purchase Request

The capability to convert identified material requirements into an authorized request to procure goods.

A Purchase Request represents the **intent to procure** one or more materials through the Purchasing process.

The capability manages:

* Requested procurement items.
* Quantities.
* Required supplier or supplier selection criteria when applicable.
* Requesting unit.
* Procurement justification when required.
* Authorization or approval required by the hospital's procurement process.

A Purchase Request does not itself create a supplier commitment.

---

### 4. PUR-PO — Purchase Order

The capability to create and manage a formal purchase order issued to a supplier.

A Purchase Order represents the hospital's **procurement commitment to a supplier**.

The capability manages:

* Supplier.
* Ordered items.
* Ordered quantities.
* Agreed prices.
* Order terms.
* Delivery information.
* Purchase order lifecycle.

The Purchase Order becomes the primary reference for receiving and subsequent supplier invoice processing.

A Purchase Order does not constitute physical receipt of goods.

---

### 5. PUR-DO — DO Penerimaan Barang

The capability to record goods received from a supplier against a Purchase Order.

A Goods Receipt represents the **physical receipt of purchased goods** by the hospital.

The capability manages:

* Purchase Order reference.
* Received items.
* Received quantities.
* Receipt date.
* Supplier delivery information.
* Receipt discrepancies.
* Acceptance or rejection of received goods where applicable.

The Goods Receipt records what was received. It does not own the hospital's resulting stock balance.

The resulting physical stock transaction is managed by the **Inventory Domain**.

---

### 6. PUR-FAKTUR — Faktur

The capability to manage supplier invoices associated with purchased goods.

A supplier invoice represents the supplier's **commercial billing for goods supplied to the hospital**.

The capability manages:

* Supplier invoice information.
* Invoice items.
* Invoice amounts.
* References to Purchase Orders and Goods Receipts.
* Invoice verification status.
* Invoice discrepancies where applicable.

Purchasing maintains the procurement-side representation and traceability of the supplier invoice.

Financial posting, payable settlement, and payment remain outside this Domain.

---

### 7. PUR-RETURN — Purchase Return

The capability to manage the return of purchased goods to a supplier.

A Purchase Return represents the **hospital's return of previously received goods**.

The capability manages:

* Returned items.
* Returned quantities.
* Return reason.
* Supplier.
* Reference to the original purchase and/or goods receipt.
* Return status.
* Return outcome.

The resulting inventory adjustment is coordinated with the **Inventory Domain**, which remains authoritative for physical stock.

## Domain Boundary

### Owns

* Supplier master information used for procurement.
* Material requirements.
* Purchase Requests.
* Purchase Orders.
* Goods Receipts.
* Supplier invoices as procurement transactions.
* Purchase Returns.
* Procurement document relationships and traceability.

### Does Not Own

* Patient identity and demographic information → **Pasien Domain**
* Hospital organization and service units → **Organisasi Domain**
* Item master and physical inventory → **Inventory Domain**
* Stock balance and stock movements → **Inventory Domain**
* Pharmacy medication demand and dispensing → **Apotek Domain**
* Hospital billing and payment → **Tata Rekening Domain**
* Clinical service requirements → relevant clinical Domain

## Relationships

| Related Domain   | Relationship                                                                                                                                              |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Organisasi       | Purchasing uses organizational units as the source of material requirements and procurement activity.                                                     |
| Inventory        | Purchasing receives material requirements and sends received/returned goods information to Inventory. Inventory remains authoritative for physical stock. |
| Apotek           | Pharmacy may generate material requirements or procurement needs for medications and pharmacy supplies.                                                   |
| Clinical Domains | Clinical units may generate material requirements for operational needs.                                                                                  |
| Tata Rekening    | Purchasing provides procurement and supplier invoice information required for financial processing.                                                       |
| Supplier         | Purchasing maintains the procurement relationship and transactions with suppliers.                                                                        |

## Capability Map

| Capability   | Business Ability                                 |
| ------------ | ------------------------------------------------ |
| PUR-SUPPLIER | Maintain suppliers used for hospital procurement |
| PUR-MATREQ   | Manage material requirements                     |
| PUR-PURREQ   | Manage requests to procure materials             |
| PUR-PO       | Manage purchase orders issued to suppliers       |
| PUR-DO       | Record goods received from suppliers             |
| PUR-FAKTUR   | Manage supplier invoices related to purchases    |
| PUR-RETURN   | Manage goods returned to suppliers               |

## Core Rules

1. Every Purchase Order must reference a supplier.
2. A Purchase Order represents a procurement commitment, not physical receipt.
3. A Goods Receipt must reference the applicable Purchase Order unless an explicitly approved exception exists.
4. Received quantity must not be represented as stock directly by Purchasing.
5. Inventory remains the authoritative source for physical stock and stock movements.
6. A supplier invoice must remain traceable to the corresponding procurement transaction.
7. A Purchase Return must remain traceable to the original purchase or goods receipt.
8. Purchasing owns procurement transactions; financial payment and settlement remain outside the Purchasing Domain.
