# MYHOSWEB Feature Registry

## 1. Purpose

This document is the authoritative registry of MYHOSWEB Features. It is the
single source of truth (SSOT) for Feature identity across the planning
repository. Every Feature is defined exactly once in this registry.

Other planning artifacts may reference Feature IDs and Feature Names, but must
not independently redefine them. This registry defines Feature identity only;
it does not define scheduling, complexity, dependencies, or implementation
details.

## 2. Ownership Rules

### Registry-Owned Properties

The registry exclusively owns:

| Property | Description |
| --- | --- |
| Feature ID | Canonical Feature Identifier |
| Feature Name | Canonical Feature Name |
| Screen ID | Owning Screen |
| Screen Name | Owning Screen Name |
| Feature Status | Active / Deprecated / Removed |
| Shared Feature Flag | Whether the Feature is reused across Screens |

These properties must never be maintained independently in other planning
documents. Downstream artifacts must reference the values defined here.

## 3. Synchronization Policy

### Rule 1: Feature Added

When a Feature is added:

* Update the registry first.
* Review affected downstream artifacts.

### Rule 2: Feature Renamed

When a Feature is renamed:

* Update the registry first.
* Synchronize all references across the repository.

### Rule 3: Feature Removed

When a Feature is removed:

* Update the registry first, using the appropriate Feature Status.
* Review dependency impact.
* Synchronize downstream artifacts.

### Rule 4: Feature ID Changed

When a Feature ID changes:

* Update the registry first.
* Synchronize the entire repository.

## 4. Agent Maintenance Guidance

### Repository Synchronization Requirement

When any Registry-Owned Property changes, the agent must identify and
synchronize all affected references across the repository.

At minimum, review:

* Screen Feature Catalog
* Complexity Assessment
* Development Order
* Feature Dependency
* Future planning artifacts

The registry is authoritative. Other artifacts must be synchronized to the
registry. The registry must never be synchronized to downstream documents.

Direction of authority:

```text
FEATURE REGISTRY
        |
        v
Screen Feature Catalog
        |
        v
Complexity Assessment
        |
        v
Development Order
        |
        v
Dependency
        |
        v
Roadmap / Future Planning
```

## 5. Feature Registry Table

All Features currently defined in `MYHOSWEB-SCREEN-FEATURE-CATALOG.md` are
listed below. Existing Feature IDs and Feature Names are preserved. All
currently listed Features are Active. A `Yes` Shared value identifies a
Screen-specific occurrence of a shared business capability.

| Feature ID | Feature Name | Screen ID | Screen Name | Shared | Status |
| --- | --- | --- | --- | --- | --- |
| FT-01-01 | Booking | SC-01 | Admisi | No | Active |
| FT-01-02 | Registrasi Rawat Jalan dan IGD | SC-01 | Admisi | No | Active |
| FT-01-03 | Registrasi Rawat Inap | SC-01 | Admisi | No | Active |
| FT-01-04 | VCLAIM BPJS | SC-01 | Admisi | No | Active |
| FT-01-05 | Patient Journey Tracking | SC-01 | Admisi | No | Active |
| FT-01-06 | Jadwal Praktek | SC-01 | Admisi | No | Active |
| FT-01-07 | Antrian | SC-01 | Admisi | No | Active |
| FT-02-01 | Rincian Tagihan Pasien | SC-02 | Tata Rekening | No | Active |
| FT-02-02 | Alokasi Pembayaran | SC-02 | Tata Rekening | No | Active |
| FT-02-03 | Deposit | SC-02 | Tata Rekening | No | Active |
| FT-02-04 | Refund | SC-02 | Tata Rekening | No | Active |
| FT-02-05 | Reg-Out | SC-02 | Tata Rekening | No | Active |
| FT-03-01 | Order Bayar | SC-03 | Kasir | No | Active |
| FT-03-02 | Pembayaran | SC-03 | Kasir | No | Active |
| FT-03-03 | Closing Shift | SC-03 | Kasir | No | Active |
| FT-04-01 | Data Sosial Pasien | SC-04 | Rekam Medis | No | Active |
| FT-04-02 | Manajemen Berkas | SC-04 | Rekam Medis | No | Active |
| FT-04-03 | Casemix dan Coding | SC-04 | Rekam Medis | No | Active |
| FT-04-04 | Pelaporan RL | SC-04 | Rekam Medis | No | Active |
| FT-04-05 | Pelaporan Index dan Sensus | SC-04 | Rekam Medis | No | Active |
| FT-05-01 | Antrian | SC-05 | Poli Rawat Jalan | No | Active |
| FT-05-02 | Tindakan | SC-05 | Poli Rawat Jalan | No | Active |
| FT-05-03 | Rujuk Internal | SC-05 | Poli Rawat Jalan | No | Active |
| FT-05-04 | CPOE (Order Pemeriksaan) | SC-05 | Poli Rawat Jalan | No | Active |
| FT-05-05 | Pakai Barang | SC-05 | Poli Rawat Jalan | Yes | Active |
| FT-05-06 | Mutasi Barang | SC-05 | Poli Rawat Jalan | Yes | Active |
| FT-05-07 | Opname | SC-05 | Poli Rawat Jalan | Yes | Active |
| FT-06-01 | Tindakan | SC-06 | Bangsal Rawat Inap | No | Active |
| FT-06-02 | Pakai Bed | SC-06 | Bangsal Rawat Inap | No | Active |
| FT-06-03 | Transfer Unit | SC-06 | Bangsal Rawat Inap | No | Active |
| FT-06-04 | Discharge | SC-06 | Bangsal Rawat Inap | No | Active |
| FT-06-05 | Pakai Barang | SC-06 | Bangsal Rawat Inap | Yes | Active |
| FT-06-06 | Mutasi Barang | SC-06 | Bangsal Rawat Inap | Yes | Active |
| FT-06-07 | Opname | SC-06 | Bangsal Rawat Inap | Yes | Active |
| FT-07-01 | IGD Visit | SC-07 | IGD | No | Active |
| FT-07-02 | Triage | SC-07 | IGD | No | Active |
| FT-07-03 | Ambulance | SC-07 | IGD | No | Active |
| FT-07-04 | Tindakan | SC-07 | IGD | No | Active |
| FT-07-05 | Pakai Barang | SC-07 | IGD | Yes | Active |
| FT-07-06 | Mutasi Barang | SC-07 | IGD | Yes | Active |
| FT-07-07 | Opname | SC-07 | IGD | Yes | Active |
| FT-08-01 | External Registration | SC-08 | Laboratorium | No | Active |
| FT-08-02 | Order Laboratorium | SC-08 | Laboratorium | No | Active |
| FT-08-03 | Charge | SC-08 | Laboratorium | No | Active |
| FT-08-04 | Sample Collection | SC-08 | Laboratorium | No | Active |
| FT-08-05 | Result Management | SC-08 | Laboratorium | No | Active |
| FT-08-06 | Pakai Barang | SC-08 | Laboratorium | Yes | Active |
| FT-08-07 | Mutasi Barang | SC-08 | Laboratorium | Yes | Active |
| FT-08-08 | Opname | SC-08 | Laboratorium | Yes | Active |
| FT-09-01 | Order Radiologi | SC-09 | Radiologi | No | Active |
| FT-09-02 | Scheduling | SC-09 | Radiologi | No | Active |
| FT-09-03 | Imaging | SC-09 | Radiologi | No | Active |
| FT-09-04 | Expertise | SC-09 | Radiologi | No | Active |
| FT-09-05 | Verification | SC-09 | Radiologi | No | Active |
| FT-09-06 | Pakai Barang | SC-09 | Radiologi | Yes | Active |
| FT-09-07 | Mutasi Barang | SC-09 | Radiologi | Yes | Active |
| FT-09-08 | Opname | SC-09 | Radiologi | Yes | Active |
| FT-10-01 | Order Operasi | SC-10 | Kamar Operasi | No | Active |
| FT-10-02 | Scheduling | SC-10 | Kamar Operasi | No | Active |
| FT-10-03 | Pre-Operative Clearance | SC-10 | Kamar Operasi | No | Active |
| FT-10-04 | Post-Operative Management | SC-10 | Kamar Operasi | No | Active |
| FT-10-05 | Pakai Barang | SC-10 | Kamar Operasi | Yes | Active |
| FT-10-06 | Mutasi Barang | SC-10 | Kamar Operasi | Yes | Active |
| FT-10-07 | Opname | SC-10 | Kamar Operasi | Yes | Active |
| FT-11-01 | Antrian Apotek | SC-11 | Apotek | No | Active |
| FT-11-02 | Telaah Resep | SC-11 | Apotek | No | Active |
| FT-11-03 | Penjualan | SC-11 | Apotek | No | Active |
| FT-11-04 | Dispensing | SC-11 | Apotek | No | Active |
| FT-11-05 | Serah Obat | SC-11 | Apotek | No | Active |
| FT-11-06 | Opname | SC-11 | Apotek | Yes | Active |
| FT-11-07 | Mutasi | SC-11 | Apotek | Yes | Active |
| FT-12-01 | Terima Barang (DO) | SC-12 | Gudang | No | Active |
| FT-12-02 | Mutasi | SC-12 | Gudang | Yes | Active |
| FT-12-03 | Opname | SC-12 | Gudang | Yes | Active |
| FT-12-04 | Musnah | SC-12 | Gudang | No | Active |
| FT-12-05 | Retur Beli | SC-12 | Gudang | No | Active |
| FT-13-01 | Material Request | SC-13 | Purchasing | No | Active |
| FT-13-02 | Forecasting | SC-13 | Purchasing | No | Active |
| FT-13-03 | Purchase Request | SC-13 | Purchasing | No | Active |
| FT-13-04 | Purchase Order | SC-13 | Purchasing | No | Active |
| FT-13-05 | Faktur Tagihan | SC-13 | Purchasing | No | Active |
| FT-14-01 | Master Organisasi | SC-14 | Mastering | No | Active |
| FT-14-02 | Master Dokter | SC-14 | Mastering | No | Active |
| FT-14-03 | Master Jaminan | SC-14 | Mastering | No | Active |
| FT-14-04 | Master Layanan | SC-14 | Mastering | No | Active |
| FT-14-05 | Master Tarif | SC-14 | Mastering | No | Active |

## 6. Shared Feature Registry

Shared Features are implemented once as canonical business capabilities and
reused in contextual Screen occurrences. This prevents double-counting
complexity and implementation effort. Screen-specific occurrences remain in
the Feature Registry for identity and traceability.

| Canonical Capability | Canonical Implementation Feature | Reusing Features |
| --- | --- | --- |
| Pakai Barang | FT-07-05 Pakai Barang | FT-05-05, FT-06-05, FT-08-06, FT-09-06, FT-10-05 |
| Mutasi Barang | FT-12-02 Mutasi | FT-05-06, FT-06-06, FT-07-06, FT-08-07, FT-09-07, FT-10-06, FT-11-07 |
| Opname | FT-12-03 Opname | FT-05-07, FT-06-07, FT-07-07, FT-08-08, FT-09-08, FT-10-07, FT-11-06 |

`Mutasi` in `SC-11 Apotek` and `SC-12 Gudang` is the existing Screen-context
label for the shared `Mutasi Barang` capability. The registry preserves those
current Feature Names while identifying `FT-12-02 Mutasi` as the canonical
implementation source.

## 7. Traceability Matrix

```text
Feature Registry
        |
        v
Screen Feature Catalog
        |
        v
Complexity Assessment
        |
        v
Development Order
        |
        v
Dependency
```

All downstream planning artifacts depend on Feature identity defined by this
registry. The Screen Feature Catalog maps registry Features to Screens. The
Complexity Assessment evaluates those Features without changing their
identity. The Development Order and Feature Dependency artifacts reference
the same registry-defined IDs and Names. Roadmap and future planning artifacts
must follow the same chain.

Changes to complexity values, development order, or dependencies are outside
the ownership of this registry and must not be made here.
