# MYHOSWEB Feature Dependency ↔ Capability Mapping — Consistency Review

**Scope:** `MYHOSWEB-SCREEN-FEATURE-DEPENDENCY.md` (91 dependencies) vs `MYHOSWEB-FEATURE-CAPABILITY-MAPPING.md` and `MYHOSWEB-FEATURE-REGISTRY.md`.

**Basis note:** The Feature Registry defines 86 features (FT-01…FT-14). The Feature–Capability Mapping covers only 81 (FT-01…FT-13). The five Mastering features **FT-14-01…FT-14-05 have no capability rows**. All 20 dependencies on FT-14-* therefore rest on name-based inference from capability labels (e.g., `CAP-02-02 Dokter` ↔ `FT-14-02 Master Dokter`). This is documented per-row below.

---

## 1. Executive Summary

| Metric                        | Count |
| ----------------------------- | ----- |
| Total Dependencies Reviewed   | 91    |
| Aligned                       | 69    |
| Review Required               | 22    |
| Unjustified                   | 0     |
| Possible Missing Dependencies | 9     |

---

## 2. Dependency Alignment Matrix

| Feature (A) | Dependency (B) | Alignment | Reason |
| ----------- | -------------- | --------- | ------ |
| FT-01-01 Booking | FT-01-06 Jadwal Praktek | ALIGNED | Booking requires `CAP-02-02 Dokter`/`CAP-02-04 Jadwal Praktek`; FT-01-06 is the schedule provider (mapped `CAP-02-01`+`CAP-02-02`). *Note: `CAP-02-04` is not mapped to FT-01-06 — ownership gap.* |
| FT-01-02 Registrasi RJ/IGD | FT-04-01 Data Sosial Pasien | ALIGNED | A requires `CAP-01-01`; B provides it. |
| FT-01-02 Registrasi RJ/IGD | FT-01-01 Booking (opt) | REVIEW REQUIRED | Optional; relationship is operational (booking→registration flow) not capability-driven; shared `CAP-01-01`/`CAP-03-04` are incidental. |
| FT-01-02 Registrasi RJ/IGD | FT-14-02 Master Dokter | ALIGNED | A requires `CAP-02-02 Dokter`; inferred Master Dokter provides it (name match). |
| FT-01-02 Registrasi RJ/IGD | FT-14-03 Master Jaminan | ALIGNED | A requires `CAP-13-02 Jaminan`; inferred provider (name match). |
| FT-01-02 Registrasi RJ/IGD | FT-14-01 Master Organisasi | REVIEW REQUIRED | No capability counterpart named "Organisasi"; inferred `CAP-02-01 Layanan` correspondence is not documented. |
| FT-01-03 Registrasi Rawat Inap | FT-14-02 Master Dokter | ALIGNED | A requires `CAP-02-02 Dokter` (inferred provider). |
| FT-01-03 Registrasi Rawat Inap | FT-14-03 Master Jaminan | ALIGNED | A requires `CAP-13-02 Jaminan` (inferred provider). |
| FT-01-03 Registrasi Rawat Inap | FT-14-01 Master Organisasi | REVIEW REQUIRED | Master Organisasi ↔ Layanan correspondence unverified. |
| FT-01-03 Registrasi Rawat Inap | FT-04-01 Data Sosial Pasien | ALIGNED | A requires `CAP-01-01`; B provides it. |
| FT-01-06 Jadwal Praktek | FT-14-02 Master Dokter | ALIGNED | Requires `CAP-02-02 Dokter` (inferred provider). |
| FT-01-06 Jadwal Praktek | FT-14-01 Master Organisasi | REVIEW REQUIRED | Master Organisasi ↔ Layanan correspondence unverified. |
| FT-02-01 Rincian Tagihan | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01 Registrasi`; B provides it. |
| FT-02-02 Alokasi Pembayaran | FT-02-01 Rincian Tagihan | ALIGNED | A requires `CAP-13-03 Billing`; B provides it. |
| FT-02-02 Alokasi Pembayaran | FT-14-03 Master Jaminan | ALIGNED | A requires `CAP-13-02 Jaminan` (inferred provider). |
| FT-02-03 Deposit | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-03-01 Registrasi`; B provides it. |
| FT-02-04 Refund | FT-03-02 Pembayaran | ALIGNED | A requires `CAP-13-04 Payment`; B provides it. |
| FT-02-05 Reg-Out | FT-02-02 Alokasi Pembayaran | ALIGNED | A requires `CAP-13-03`/`CAP-13-04`; B provides both. |
| FT-03-01 Order Bayar | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-03-02 Pembayaran | FT-03-01 Order Bayar | ALIGNED | A requires `CAP-13-04`/`CAP-13-02`; B provides both. |
| FT-03-02 Pembayaran | FT-02-03 Deposit | ALIGNED | Shared `CAP-13-04 Payment`; deposit application is a payment flow. |
| FT-03-02 Pembayaran | FT-02-05 Reg-Out | ALIGNED | Shared `CAP-13-03`/`CAP-13-04`; final billing feeds payment. |
| FT-03-03 Closing Shift | FT-03-02 Pembayaran | ALIGNED | Both map `CAP-13-04 Payment`. |
| FT-04-02 Manajemen Berkas | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-04-02 Manajemen Berkas | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-04-03 Casemix & Coding | FT-01-02 Registrasi RJ/IGD | REVIEW REQUIRED | No capability overlap (A maps only `CAP-14-01`/`CAP-14-03`). Relationship is operational (casemix per admission); A's mapping omits `CAP-03-01`. |
| FT-05-02 Tindakan | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-05-02 Tindakan | FT-14-05 Master Tarif | ALIGNED | A requires `CAP-13-01 Tarif` (inferred provider, name match). |
| FT-05-02 Tindakan | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-05-03 Rujuk Internal | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-05-04 CPOE | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-05-04 CPOE | FT-14-02 Master Dokter | REVIEW REQUIRED | A's mapping omits `CAP-02-02 Dokter` (only `CAP-15-0x`, `CAP-03-01`, `CAP-02-01`); Dokter need is implied not mapped. |
| FT-05-04 CPOE | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-05-05 Pakai Barang | FT-07-05 Pakai Barang (shared) | ALIGNED | Shared-feature reuse; canonical FT-07-05 provides `CAP-11-01/05/06`. |
| FT-05-06 Mutasi Barang | FT-12-02 Mutasi (shared) | ALIGNED | Canonical FT-12-02 provides `CAP-11-02/05/06`. |
| FT-05-07 Opname | FT-12-03 Opname (shared) | ALIGNED | Canonical FT-12-03 provides `CAP-11-03/05/06`. |
| FT-06-01 Tindakan | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-06-02 Pakai Bed | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-05-01`+`CAP-03-01`; B provides both. |
| FT-06-02 Pakai Bed | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-06-02 Pakai Bed | FT-14-05 Master Tarif | REVIEW REQUIRED | A's mapping lacks `CAP-13-01 Tarif`; bed-tariff need is implied, not mapped. |
| FT-06-03 Transfer Unit | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-06-03 Transfer Unit | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-06-04 Discharge | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-06-04 Discharge | FT-06-02 Pakai Bed | REVIEW REQUIRED | Justification is operational (bed release on discharge); A's mapping lacks `CAP-05-01`; shared `CAP-03-01` is incidental. |
| FT-06-05 Pakai Barang | FT-07-05 (shared) | ALIGNED | Shared-feature reuse. |
| FT-06-06 Mutasi Barang | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-06-07 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-07-01 IGD Visit | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-07-01 IGD Visit | FT-14-01 Master Organisasi | REVIEW REQUIRED | A maps only `CAP-06-01`+`CAP-03-01`; no `CAP-02-01`; org-unit need implied, Master Organisasi correspondence unverified. |
| FT-07-02 Triage | FT-07-01 IGD Visit | ALIGNED | A requires `CAP-06-01`; B provides it. |
| FT-07-03 Ambulance | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-07-04 Tindakan | FT-07-01 IGD Visit | REVIEW REQUIRED | No capability overlap (A maps `CAP-04-01`, `CAP-13-01/03`, `CAP-02-01/02`); linkage is operational (procedure within IGD visit), A omits `CAP-06-01`. |
| FT-07-06 Mutasi Barang | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-07-07 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-08-03 Charge | FT-14-05 Master Tarif | ALIGNED | A requires `CAP-13-01 Tarif` (inferred provider, name match). |
| FT-08-03 Charge | FT-01-02 Registrasi RJ/IGD (opt) | REVIEW REQUIRED | Optional; capability overlap exists (`CAP-03-01`) but marked conditional. |
| FT-08-04 Sample Collection | FT-08-02 Order Laboratorium | ALIGNED | A requires `CAP-15-02 Order Lab`; B provides it. |
| FT-08-05 Result Management | FT-08-02 Order Laboratorium | ALIGNED | A requires `CAP-15-02`; B provides it. |
| FT-08-05 Result Management | FT-08-04 Sample Collection (opt) | REVIEW REQUIRED | Optional; capability overlap `CAP-15-02` is indirect to the sample linkage. |
| FT-08-06 Pakai Barang | FT-07-05 (shared) | ALIGNED | Shared-feature reuse. |
| FT-08-07 Mutasi Barang | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-08-08 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-09-01 Order Radiologi | FT-01-02 Registrasi RJ/IGD | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-09-02 Scheduling | FT-09-01 Order Radiologi | ALIGNED | A requires `CAP-15-03 Order Radiologi`; B provides it. |
| FT-09-03 Imaging | FT-09-01 Order Radiologi | ALIGNED | A requires `CAP-15-03`; B provides it. |
| FT-09-04 Expertise | FT-09-01 Order Radiologi | ALIGNED | Shared `CAP-15-03`. |
| FT-09-04 Expertise | FT-09-03 Imaging (opt) | REVIEW REQUIRED | Optional; overlap `CAP-15-03`/`CAP-08-02` is secondary to reading workflow. |
| FT-09-05 Verification | FT-09-04 Expertise | ALIGNED | A requires `CAP-08-03`; B provides it. |
| FT-09-06 Pakai Barang | FT-07-05 (shared) | ALIGNED | Shared-feature reuse. |
| FT-09-07 Mutasi Barang | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-09-08 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-10-01 Order Operasi | FT-01-03 Registrasi Rawat Inap | ALIGNED | A requires `CAP-03-01`; B provides it. |
| FT-10-01 Order Operasi | FT-14-01 Master Organisasi | REVIEW REQUIRED | Requires `CAP-02-01 Layanan`; Master Organisasi correspondence unverified. |
| FT-10-02 Scheduling | FT-10-01 Order Operasi | ALIGNED | A requires `CAP-15-04 Order Operasi`; B provides it. |
| FT-10-03 Pre-Op Clearance | FT-10-02 Scheduling | ALIGNED | Shared `CAP-15-04`+`CAP-02-02`. |
| FT-10-04 Post-Op Mgmt | FT-10-03 Pre-Op Clearance | ALIGNED | Shared `CAP-15-04`+`CAP-02-02`. |
| FT-10-05 Pakai Barang | FT-07-05 (shared) | ALIGNED | Shared-feature reuse. |
| FT-10-06 Mutasi Barang | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-10-07 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-11-01 Antrian Apotek | FT-11-02 Telaah Resep | ALIGNED | Shared `CAP-15-01 Prescription`+`CAP-11-06`. |
| FT-11-03 Penjualan | FT-11-01 Antrian Apotek | ALIGNED | Shared `CAP-10-02`/`CAP-15-01`/`CAP-11-06`/`CAP-13-03`. |
| FT-11-03 Penjualan | FT-11-02 Telaah Resep | ALIGNED | Shared `CAP-15-01`+`CAP-11-06`. |
| FT-11-04 Dispensing | FT-11-02 Telaah Resep | ALIGNED | Workflow (dispense reviewed Rx) with shared `CAP-11-06`; justification leans operational. |
| FT-11-05 Serah Obat | FT-11-04 Dispensing | ALIGNED | Shared `CAP-10-03`+`CAP-10-02`. |
| FT-11-06 Opname | FT-12-03 (shared) | ALIGNED | Shared-feature reuse. |
| FT-11-07 Mutasi | FT-12-02 (shared) | ALIGNED | Shared-feature reuse. |
| FT-12-01 Terima Barang (DO) | FT-13-04 Purchase Order | ALIGNED | A requires `CAP-12-01 Purchasing`; B provides it. |
| FT-13-04 Purchase Order | FT-13-01 Material Request (opt) | REVIEW REQUIRED | Optional; overlap `CAP-12-01`+`CAP-11-06` but conditional. |
| FT-13-04 Purchase Order | FT-13-03 Purchase Request (opt) | REVIEW REQUIRED | Optional; overlap `CAP-12-01`+`CAP-11-06` but conditional. |
| FT-13-05 Faktur Tagihan | FT-13-04 Purchase Order | ALIGNED | Shared `CAP-12-05 Supplier`+`CAP-11-06`. |
| FT-13-05 Faktur Tagihan | FT-12-01 Terima Barang (opt) | REVIEW REQUIRED | Optional; operational link (match to receiving), no direct capability need. |

---

## 3. Unjustified Dependencies

**None.** Every one of the 91 dependencies has at least a plausible capability overlap, a documented name-based master-data correspondence, or a reasonable operational/inferred justification. No dependency appears fully unsupported by the Feature–Capability Mapping.

---

## 4. Possible Missing Dependencies

| Feature | Capability | Candidate Provider | Reason |
| ------- | ---------- | ------------------ | ------ |
| FT-05-01 Antrian (SC-05) | `CAP-03-01 Registrasi`, `CAP-02-01 Layanan` | FT-01-02 Registrasi RJ/IGD | Has **no dependencies** yet maps Registrasi + Layanan; sibling FT-01-07 Antrian maps only `CAP-03-03` and every other SC-05 feature depends on FT-01-02. |
| FT-08-01 External Registration | `CAP-01-01 Data Sosial Pasien`, `CAP-03-01 Registrasi` | FT-04-01 Data Sosial Pasien, FT-01-02 | Has **no dependencies**; requires exactly the two capabilities those features provide. |
| FT-08-02 Order Laboratorium | `CAP-03-01 Registrasi`, `CAP-02-01 Layanan` | FT-01-02 Registrasi RJ/IGD | Has **no dependencies**; inconsistent with sibling FT-09-01 Order Radiologi which correctly depends on FT-01-02. |
| FT-11-02 Telaah Resep | `CAP-03-01 Registrasi` | FT-01-02 Registrasi RJ/IGD | Requires Registrasi (patient verification) but has no dependency, unlike every other clinical order feature. |
| FT-13-01 Material Request | `CAP-02-01 Layanan` | FT-14-04 Master Layanan / FT-14-01 Master Organisasi | Requires Layanan capability; no master-data dependency present. |
| FT-02-01 Rincian Tagihan | `CAP-13-02 Jaminan` | FT-14-03 Master Jaminan | Requires Jaminan but has no Master Jaminan dependency; sibling FT-02-02 correctly depends on FT-14-03. |
| FT-05-02 / FT-06-01 / FT-07-04 Tindakan | `CAP-02-02 Dokter`, `CAP-13-03 Billing`, `CAP-13-01 Tarif`, `CAP-02-01 Layanan` | FT-14-02 Master Dokter, FT-02-01 Rincian Tagihan, FT-14-05 Master Tarif, FT-14-01 Master Organisasi | Tindakan features require Dokter/Billing/Tarif/Layanan but depend only on Registrasi (FT-07-04 depends only on FT-07-01). No Master Dokter or billing-provider dependency. |
| FT-09-04 / FT-09-05 Expertise/Verification, FT-10-01…04 Operasi | `CAP-02-02 Dokter` | FT-14-02 Master Dokter | Radiology read/expertise and OR scheduling require the Dokter capability; no Master Dokter dependency (FT-05-04 is the only non-admission feature that has one). |
| FT-06-04 Discharge | `CAP-13-01 Tarif` | FT-14-05 Master Tarif | Discharge maps `CAP-13-01` but carries no Master Tarif dependency (FT-06-02 has one instead). |

---

## 5. Reviewer Notes

- **Master-data gap (systemic):** FT-14-01…FT-14-05 (SC-14 Mastering) exist in the Feature Registry but have **no rows in the Feature–Capability Mapping**. All 20 dependencies on these features are justified only by capability-label name matching. Recommend adding FT-14-* capability rows to make the mapping authoritative. `FT-14-01 Master Organisasi` is the weakest case — no capability literally named "Organisasi" exists (`CAP-02-01` is "Layanan"), hence all 10 of its dependencies were classified REVIEW REQUIRED.

- **Heavy fan-in / hub coupling:** FT-01-02 Registrasi RJ/IGD (5 deps) and FT-01-03 Registrasi Rawat Inap (4 deps) are prerequisites for nearly every clinical feature via `CAP-03-01 Registrasi`. This is structurally sound but makes registration a single point of failure in the dependency graph; optional dependency on FT-01-01 Booking adds to the hub.

- **Capability ownership inconsistencies:**
  - `CAP-02-04 Jadwal Praktek` is required by FT-01-01 Booking but **owned by no feature** in the mapping (FT-01-06 maps only `CAP-02-01`/`CAP-02-02`).
  - Several features depend on a capability their own mapping omits: FT-05-04 CPOE (dep Master Dokter, no `CAP-02-02`), FT-06-02 Pakai Bed (dep Master Tarif, no `CAP-13-01`), FT-07-01 IGD Visit (dep Master Organisasi, no `CAP-02-01`), FT-06-04 Discharge (dep Pakai Bed, no `CAP-05-01`), FT-07-04 Tindakan (dep IGD Visit, no `CAP-06-01`), FT-04-03 Casemix (dep Registrasi, no `CAP-03-01`). Either the dependencies are ungrounded or the capability mapping is incomplete for these features.

- **Optional dependencies (7):** all classified REVIEW REQUIRED. They introduce conditional semantics into a static dependency artifact (`(opt)`), e.g. FT-13-04 PO → MR/PR and FT-13-05 Faktur → DO. Consider a separate "conditional/optional" section or explicit guard conditions so the dependency graph remains deterministic for scheduling.

- **Billing/Dokter/Tarif/Jaminan/Layanan coverage:** `CAP-13-03 Billing`, `CAP-02-02 Dokter`, `CAP-13-01 Tarif`, `CAP-13-02 Jaminan`, `CAP-02-01 Layanan` are required across many features, but only a few features carry corresponding dependencies to their provider (FT-02-01 for Billing; FT-14-02 for Dokter; FT-14-05 for Tarif; FT-14-03 for Jaminan). This is the single largest source of POSSIBLE MISSING DEPENDENCY findings.

- **Shared-feature modeling — correctly handled:** All `Pakai Barang`/`Mutasi`/`Opname` occurrences reference canonical implementations (FT-07-05, FT-12-02, FT-12-03) per the Shared Feature Registry; canonical features themselves correctly declare no dependencies. No false positives caused by reuse. Minor observation: the canonical `Pakai Barang` (FT-07-05) lives in SC-07 IGD, which is an unusual canonical placement but documented and consistent.

- **Reporting features:** FT-04-04/FT-04-05 (Pelaporan RL / Index & Sensus) map only `CAP-14-02` and have no dependencies. Operationally they consume registrasi/billing data, but the capability mapping does not reflect that, so no issue is reported under the strict capability-only model — a deliberate documentation gap to revisit.

**Note on the no-edit rule:** This review is read-only with respect to the source artifacts; only this deliverable document was created.