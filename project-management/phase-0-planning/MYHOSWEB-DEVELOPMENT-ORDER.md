# MYHOSWEB Development Order V1.0

## 1. Purpose

This artifact formalizes and **freezes** the agreed MYHOSWEB macro development sequence for Phase-0 planning. It establishes the authoritative order in which the business capabilities defined in the Screen-Feature Catalog will be delivered.

It is the direct input for:

- Feature Task / Work Breakdown
- Capacity Planning
- Development Roadmap

This document does **not** modify the Screen-Feature Catalog or the Feature Complexity Assessment. It only orders their content.

## 2. Frozen Decision

The development order is **FROZEN** as six macro development-order groups:

```
1. Rawat Jalan
2. IGD
3. Rawat Inap
4. Inventory
5. Shared Barang Concern
6. Remaining Features
```

```
Rawat Jalan → IGD → Rawat Inap → Inventory → Shared Barang Concern → Remaining Features
```

| Order | Macro Development-Order Group | Primary Screen |
| ----- | ----------------------------- | -------------- |
| 1 | Pasien Lifecycle — Rawat Jalan | SC-05 Poli Rawat Jalan |
| 2 | Pasien Lifecycle — IGD | SC-07 IGD |
| 3 | Pasien Lifecycle — Rawat Inap | SC-06 Bangsal Rawat Inap |
| 4 | Inventory | SC-12 Gudang |
| 5 | Shared Barang Concern | Canonical shared features |
| 6 | Remaining Features | Unordered |

The six groups are **macro development-order groups**, not phases.

## 3. Sequencing Rationale

The frozen sequence follows these principles:

- **Patient lifecycle is the primary business progression.** The system first delivers the core patient-care journey, then the supporting operational and shared capabilities.
- **Rawat Jalan → IGD → Rawat Inap is the initial patient-lifecycle delivery sequence.** Outpatient care is delivered first, followed by emergency care, then inpatient care.
- **Inventory follows Rawat Inap.** Inventory is a supporting operational capability and is placed after the patient-lifecycle sequence is established.
- **Inventory must be established before shared barang functionality.** The shared barang capabilities depend on an established inventory foundation.
- **`Pakai Barang`, `Mutasi Barang`, and `Opname` are canonical shared features.** They are the same business capabilities reused by multiple Screens; their appearance in a Screen is contextual usage, not a separate implementation.
- **Remaining features are intentionally left unordered.** No internal delivery order among them is established yet.

## 4. Feature Mapping

Every feature from `MYHOSWEB-SCREEN-FEATURE-CATALOG.md` is mapped into one of the six groups below. Shared-feature occurrences are **not** treated as independent implementations; each canonical shared feature is mapped once under Order 5.

### Order 1 — Pasien Lifecycle — Rawat Jalan

Primary Screen: `SC-05 Poli Rawat Jalan`

| Feature ID | Feature |
| ---------- | ------- |
| FT-05-01 | Antrian |
| FT-05-02 | Tindakan |
| FT-05-03 | Rujuk Internal |
| FT-05-04 | CPOE (Order Pemeriksaan) |

### Order 2 — Pasien Lifecycle — IGD

Primary Screen: `SC-07 IGD`

| Feature ID | Feature |
| ---------- | ------- |
| FT-07-01 | IGD Visit |
| FT-07-02 | Triage |
| FT-07-03 | Ambulance |
| FT-07-04 | Tindakan |

### Order 3 — Pasien Lifecycle — Rawat Inap

Primary Screen: `SC-06 Bangsal Rawat Inap`

| Feature ID | Feature |
| ---------- | ------- |
| FT-06-01 | Tindakan |
| FT-06-02 | Pakai Bed |
| FT-06-03 | Transfer Unit |
| FT-06-04 | Discharge |

### Order 4 — Inventory

Primary Screen: `SC-12 Gudang`

| Feature ID | Feature |
| ---------- | ------- |
| FT-12-01 | Terima Barang (DO) |
| FT-12-04 | Musnah |
| FT-12-05 | Retur Beli |

The `SC-12 Gudang` occurrences of `Mutasi` (FT-12-02) and `Opname` (FT-12-03) are canonical shared features and are mapped to Order 5.

### Order 5 — Shared Barang Concern

Canonical shared features, counted once each regardless of Screen usage count.

| Canonical Feature | Catalog Occurrences |
| ----------------- | ------------------- |
| Pakai Barang | FT-05-05, FT-06-05, FT-07-05, FT-08-06, FT-09-06, FT-10-05 |
| Mutasi Barang | FT-05-06, FT-06-06, FT-07-06, FT-08-07, FT-09-07, FT-10-06, FT-11-07, FT-12-02 |
| Opname | FT-05-07, FT-06-07, FT-07-07, FT-08-08, FT-09-08, FT-10-07, FT-11-06, FT-12-03 |

The catalog labels `Mutasi Barang` as `Mutasi` in `SC-11 Apotek` and `SC-12 Gudang`; these occurrences are the same canonical feature.

### Remaining Features

All features not included in Orders 1–5 remain deferred. No internal order among them is established yet.

| Feature ID | Feature | Source Screen |
| ---------- | ------- | ------------- |
| FT-01-01 | Booking | SC-01 Admisi |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | SC-01 Admisi |
| FT-01-03 | Registrasi Rawat Inap | SC-01 Admisi |
| FT-01-04 | VCLAIM BPJS | SC-01 Admisi |
| FT-01-05 | Patient Journey Tracking | SC-01 Admisi |
| FT-01-06 | Jadwal Praktek | SC-01 Admisi |
| FT-01-07 | Antrian | SC-01 Admisi |
| FT-02-01 | Rincian Tagihan Pasien | SC-02 Tata Rekening |
| FT-02-02 | Alokasi Pembayaran | SC-02 Tata Rekening |
| FT-02-03 | Deposit | SC-02 Tata Rekening |
| FT-02-04 | Refund | SC-02 Tata Rekening |
| FT-02-05 | Reg-Out | SC-02 Tata Rekening |
| FT-03-01 | Order Bayar | SC-03 Kasir |
| FT-03-02 | Pembayaran | SC-03 Kasir |
| FT-03-03 | Closing Shift | SC-03 Kasir |
| FT-04-01 | Data Sosial Pasien | SC-04 Rekam Medis |
| FT-04-02 | Manajemen Berkas | SC-04 Rekam Medis |
| FT-04-03 | Casemix dan Coding | SC-04 Rekam Medis |
| FT-04-04 | Pelaporan RL | SC-04 Rekam Medis |
| FT-04-05 | Pelaporan Index dan Sensus | SC-04 Rekam Medis |
| FT-08-01 | External Registration | SC-08 Laboratorium |
| FT-08-02 | Order Laboratorium | SC-08 Laboratorium |
| FT-08-03 | Charge | SC-08 Laboratorium |
| FT-08-04 | Sample Collection | SC-08 Laboratorium |
| FT-08-05 | Result Management | SC-08 Laboratorium |
| FT-09-01 | Order Radiologi | SC-09 Radiologi |
| FT-09-02 | Scheduling | SC-09 Radiologi |
| FT-09-03 | Imaging | SC-09 Radiologi |
| FT-09-04 | Expertise | SC-09 Radiologi |
| FT-09-05 | Verification | SC-09 Radiologi |
| FT-10-01 | Order Operasi | SC-10 Kamar Operasi |
| FT-10-02 | Scheduling | SC-10 Kamar Operasi |
| FT-10-03 | Pre-Operative Clearance | SC-10 Kamar Operasi |
| FT-10-04 | Post-Operative Management | SC-10 Kamar Operasi |
| FT-11-01 | Antrian Apotek | SC-11 Apotek |
| FT-11-02 | Telaah Resep | SC-11 Apotek |
| FT-11-03 | Penjualan | SC-11 Apotek |
| FT-11-04 | Dispensing | SC-11 Apotek |
| FT-11-05 | Serah Obat | SC-11 Apotek |
| FT-13-01 | Material Request | SC-13 Purchasing |
| FT-13-02 | Forecasting | SC-13 Purchasing |
| FT-13-03 | Purchase Request | SC-13 Purchasing |
| FT-13-04 | Purchase Order | SC-13 Purchasing |
| FT-13-05 | Faktur Tagihan | SC-13 Purchasing |
| FT-14-01 | Master Organisasi | SC-14 Mastering |
| FT-14-02 | Master Dokter | SC-14 Mastering |
| FT-14-03 | Master Jaminan | SC-14 Mastering |
| FT-14-04 | Master Layanan | SC-14 Mastering |
| FT-14-05 | Master Tarif | SC-14 Mastering |

## 5. Frozen Planning Rules

- This development order is **FROZEN**.
- All subsequent planning artifacts must respect this order.
- Feature complexity does **not** override this order.
- Complexity may affect effort, duration, and task sequencing **within** an ordered group.
- Technical dependencies may require prerequisite preparation, but such preparation does not change the frozen business development order.
- No detailed sequence for the Remaining Features is established yet.

## 6. Relationship to Other Artifacts

```text
Screen-Feature Catalog
        +
Feature Complexity Assessment
        ↓
MYHOSWEB Development Order
        ↓
Feature Task / Work Breakdown
        ↓
Capacity Planning
        ↓
Development Roadmap
```
