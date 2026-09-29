---

DocumentName: Inventory Domain
Version: 1.0
LastUpdate: 2026-09-30
UpdatedBy: Drury Yudis
----------------------

# INVENTORY DOMAIN

Domain Code: **INV**

## Purpose

The **Inventory** Domain manages the hospital's inventory of goods and materials.

Its responsibility is to maintain item master information, track stock quantities and movements, record inventory consumption and destruction, manage repack and production activities, and support stock counting.

## Definition

**Inventory** is the domain that manages the **availability, quantity, movement, and usage of hospital goods and materials**.

The domain focuses on the current and historical state of inventory within the hospital.

## Responsibilities

The Inventory Domain is responsible for:

* Maintaining inventory item master information.
* Maintaining stock quantities by inventory location.
* Recording inventory movements.
* Recording goods used for operational purposes.
* Recording goods that are destroyed or removed from usable stock.
* Managing repack and production of inventory items.
* Performing and recording stock opname.

## Capabilities

### 1. INV-MASTER — Item Master

The capability to maintain the master information of goods and materials managed by the hospital inventory.

It defines the identity and basic characteristics of an inventory item.

Examples:

* Item identity
* Item name
* Unit of measure
* Item classification
* Other attributes required to identify and manage the item

### 2. INV-STOK — Stock

The capability to maintain the **current stock state** of inventory items at each inventory location.

It provides the current quantity and availability of an item.

Stock is the authoritative current state of inventory quantity.

### 3. INV-MUTASI — Mutasi

The capability to record **inventory movements** that change stock quantities.

Examples:

* Stock receipt
* Stock transfer
* Stock adjustment
* Stock issue
* Other movements affecting inventory quantity

Each movement contributes to the resulting stock state.

### 4. INV-MUSNAH — Musnah

The capability to record inventory items that are **destroyed, expired, damaged, or otherwise removed from usable stock**.

It provides an explicit record of the removal of inventory from available stock.

### 5. INV-REPACK — Repack / Produksi

The capability to transform inventory items through **repacking or internal production**.

Examples:

* Repack one item into another package size.
* Produce a new inventory item from one or more source items.

The transformation changes the quantities of the involved inventory items.

### 6. INV-PAKAI — Pakai Barang

The capability to record **inventory consumption for operational use**.

It represents the use of inventory items by a hospital service or operational activity.

Consumption reduces the available stock of the consumed items.

### 7. INV-OPNAME — Stok Opname

The capability to perform and record **physical stock counting and reconciliation**.

It compares the physical quantity with the recorded stock and records the resulting adjustment when required.

## Domain Boundary

### Owns

* Inventory item master.
* Current stock quantity.
* Inventory movements.
* Inventory destruction/removal.
* Repack and internal production.
* Inventory consumption.
* Stock opname and stock reconciliation.

### Does Not Own

* Supplier master and purchasing process → **Purchasing Domain**
* Purchase orders and goods receiving process → **Purchasing Domain**
* Patient identity → **Pasien Domain**
* Clinical service delivery → relevant clinical domain
* Billing and payment → **Tata Rekening Domain**
* Medication prescribing and dispensing → **Apotek Domain**

## Relationships

| Domain           | Relationship                                                                               |
| ---------------- | ------------------------------------------------------------------------------------------ |
| Purchasing       | Purchasing provides incoming goods that may increase Inventory stock.                      |
| Apotek           | Apotek consumes and manages pharmaceutical inventory through pharmacy operations.          |
| Organisasi       | Inventory stock may be associated with hospital organizational units and locations.        |
| Tata Rekening    | Inventory consumption or item usage may contribute to financial charging where applicable. |
| Clinical Domains | Clinical services may consume inventory items as part of service delivery.                 |

## Capability Map

| Capability | Business Ability                                 |
| ---------- | ------------------------------------------------ |
| INV-MASTER | Maintain inventory item master information       |
| INV-STOK   | Maintain the current stock state                 |
| INV-MUTASI | Record inventory movements                       |
| INV-MUSNAH | Record destroyed or removed inventory            |
| INV-REPACK | Transform inventory through repack or production |
| INV-PAKAI  | Record inventory consumption                     |
| INV-OPNAME | Count and reconcile physical stock               |
