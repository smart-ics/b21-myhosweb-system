# OUTCOME: Order Laboratorium

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-02          |
| Version     | 1.2               |
| Status      | Draft             |
| LastUpdated | 2026-10-02        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat permintaan pemeriksaan laboratorium (order laboratorium) untuk pasien secara resmi, sejak order dibuat oleh Order Creator hingga order siap diproses oleh unit laboratorium.

OC-08-02 bertanggung jawab atas pembentukan dan pengelolaan order pada status **`Ordered`** — yaitu memastikan order tercatat dengan identitas pasien, dokter pemberi instruksi (*Requester*), dan daftar pemeriksaan laboratorium yang diminta.

---

## 2. Outcome Statement

Order pemeriksaan laboratorium untuk pasien telah berhasil dibuat dan tercatat dengan status **`Ordered`**, siap untuk dilanjutkan ke proses berikutnya dalam lifecycle laboratorium.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: mencatat dan mengelola order pemeriksaan laboratorium pada status `Ordered`. |
| Pasien | Menyediakan identitas pasien yang menjadi subjek order pemeriksaan laboratorium. |
| Organisasi | Menyediakan identitas dokter/PPA yang dicatat sebagai Requester dan Order Creator. |
| Tata Rekening | Menyediakan katalog tarif/tindakan pemeriksaan laboratorium yang valid. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order pemeriksaan laboratorium telah tercatat dalam sistem dengan status **`Ordered`**.
- Order merujuk pada identitas pasien yang valid (**Patient ID**).
- Order merujuk pada identitas dokter sebagai pemberi instruksi klinis (**Requester / Instruction Giver** — **Doctor ID**).
- Identitas **Order Creator** (Dokter atau Nurse/Staff yang bertindak atas instruksi dokter) tercatat dan dapat dibedakan dari Dokter Requester ketika order diinput oleh Nurse/Staff.
- Order memuat satu atau lebih item tarif/pemeriksaan laboratorium yang valid.

### 5.2 Required Recorded Information

- Identitas Pasien (Patient ID).
- Identitas Dokter Pemberi Instruksi / Requester (Doctor ID).
- Identitas Order Creator (User ID — Dokter, atau Nurse/Staff atas instruksi dokter).
- Peran Order Creator (Dokter langsung, atau Nurse/Staff atas instruksi dokter).
- Daftar item pemeriksaan laboratorium yang diminta (satu atau lebih item tarif/tindakan pemeriksaan laboratorium).
- Status order (**`Ordered`**).
- Waktu order dibuat/dikirimkan.

### 5.3 Required Business Conditions

- Patient ID harus valid dan dikenal oleh sistem.
- Doctor ID yang dicatat sebagai Requester harus valid dan dikenal oleh sistem.
- Order Creator harus terautentikasi: Dokter itu sendiri, atau Nurse/Staff yang bertindak atas instruksi dokter.
- Minimal terdapat 1 (satu) item tarif/pemeriksaan laboratorium dalam order.
- Seluruh item yang dipilih harus merupakan tarif/pemeriksaan laboratorium yang valid.
- Edit item pemeriksaan hanya dapat dilakukan selama order masih berstatus **`Ordered`** (sebelum `Charged`).
- Pembatalan order hanya dapat dilakukan selama order masih berstatus **`Ordered`** (sebelum `Charged`).
- Setelah order berstatus **`Charged`**, perubahan dan pembatalan bukan lagi tanggung jawab OC-08-02.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Order pemeriksaan laboratorium tersimpan dan berstatus **`Ordered`**.
- Order memuat Patient ID, Doctor ID (Requester), identitas Order Creator, dan minimal satu item pemeriksaan laboratorium.
- Jika order diedit, daftar item terbaru tersimpan dan order tetap berstatus `Ordered`.
- Jika order dibatalkan sebelum `Charged`, order tidak lagi aktif dan tidak dapat dilanjutkan ke lifecycle berikutnya.

---

## 6. Outcome Boundary

### Start

Dimulai ketika Order Creator (Dokter, atau Nurse/Staff atas instruksi dokter) mengonfirmasi dan mengirimkan order pemeriksaan laboratorium untuk pasien — menyertakan Patient ID, Doctor ID sebagai Requester, dan minimal satu item pemeriksaan laboratorium — dan order berhasil tercatat dengan status **`Ordered`**.

### End

Berakhir ketika salah satu dari kondisi berikut terpenuhi:
1. Order berhasil terbentuk dengan status **`Ordered`**; **ATAU**
2. Order berstatus `Ordered` berhasil diedit (item ditambah/dihapus/diganti) dan tersimpan kembali dengan status `Ordered`; **ATAU**
3. Order berstatus `Ordered` berhasil dibatalkan sebelum memasuki status `Charged`.

> **Batas Tanggung Jawab:** Setelah order beralih ke status **`Charged`** (ditangani oleh OC-08-03), pengelolaan lifecycle order keluar dari cakupan OC-08-02. OC-08-02 tidak mengelola billing, pengambilan spesimen, pemrosesan, maupun hasil pemeriksaan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Minimum Business Facts**: Order laboratorium tidak dapat berstatus `Ordered` tanpa Patient ID yang valid, Doctor ID sebagai Requester yang valid, dan minimal satu item tarif/pemeriksaan laboratorium.
- **Actor Accountability**: Identitas Order Creator harus selalu tercatat. Apabila order diinput oleh Nurse/Staff, Dokter Requester tetap wajib tercatat sebagai pemberi instruksi klinis.
- **Order Item Scope**: Hanya tarif/tindakan yang termasuk kategori pemeriksaan laboratorium yang dapat dimasukkan ke dalam order OC-08-02.
- **Edit Window**: Penambahan, penghapusan, atau penggantian item pemeriksaan hanya diperbolehkan selama order berstatus `Ordered`.
- **Cancellation Window**: Pembatalan order hanya diperbolehkan selama order berstatus `Ordered`.
- **Charged is the Boundary**: Setelah order berstatus `Charged`, OC-08-02 tidak lagi memiliki wewenang atas perubahan atau pembatalan order tersebut.
- **Scope Boundary vs CPOE**: OC-08-02 berada pada level yang sama dengan OC-05-04 CPOE. OC-08-02 khusus mengelola order/tindakan/tarif pemeriksaan laboratorium. OC-05-04 CPOE mengelola order tarif/tindakan selain laboratorium dan radiologi.
- **Lifecycle**: Order laboratorium mengikuti lifecycle: `Ordered → Charged → Sample Collected → Processing → Resulted → Released`. OC-08-02 bertanggung jawab eksklusif pada status `Ordered`.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Patient ID tidak valid atau tidak ditemukan | Order ditolak. Patient ID wajib ada dan valid. |
| Doctor ID (Requester) tidak valid atau tidak ditemukan | Order ditolak. Doctor ID sebagai Requester wajib ada dan valid. |
| Tidak ada item pemeriksaan laboratorium yang disertakan | Order ditolak. Minimal satu item pemeriksaan laboratorium wajib ada. |
| Item yang dipilih bukan merupakan tarif/pemeriksaan laboratorium yang valid | Order ditolak. Hanya item kategori laboratorium yang dapat dimasukkan ke dalam order OC-08-02. |
| Upaya edit atau pembatalan pada order yang sudah berstatus `Charged` atau status berikutnya | Ditolak. Setelah `Charged`, perubahan dan pembatalan bukan lagi cakupan OC-08-02. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Order pemeriksaan laboratorium yang dikonfirmasi oleh Order Creator tersimpan dengan status **`Ordered`**. | Completeness |
| AC-02 | Order berstatus `Ordered` memuat Patient ID, Doctor ID (Requester), identitas Order Creator, dan minimal satu item tarif/pemeriksaan laboratorium. | Completeness |
| AC-03 | Ketika order dibuat oleh Nurse/Staff, identitas Order Creator tercatat berbeda dari Doctor Requester, dan Doctor Requester tetap tercatat sebagai pemberi instruksi klinis. | Correctness |
| AC-04 | Pembuatan order ditolak apabila Patient ID tidak valid, Doctor ID (Requester) tidak valid, atau tidak ada item pemeriksaan laboratorium. | Constraint |
| AC-05 | Item yang dipilih dalam order diverifikasi sebagai tarif/tindakan pemeriksaan laboratorium; item di luar kategori laboratorium ditolak. | Constraint |
| AC-06 | Selama order masih berstatus `Ordered`, item pemeriksaan dapat ditambah, dihapus, atau diganti, dan order tersimpan kembali dengan status `Ordered`. | Correctness |
| AC-07 | Selama order masih berstatus `Ordered`, order dapat dibatalkan. | Correctness |
| AC-08 | Upaya edit atau pembatalan order yang sudah berstatus `Charged` (atau status lanjutan dalam lifecycle) ditolak. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembebanan biaya (*charging*) pemeriksaan laboratorium → **OC-08-03 Charge**.
- Pengambilan dan pengelolaan spesimen → **OC-08-04 Sample Collection**.
- Pemrosesan, pencatatan hasil, verifikasi, dan rilis hasil pemeriksaan → **OC-08-05 Result Management**.
- Registrasi pasien luar/langsung di laboratorium tanpa kunjungan RS → **OC-08-01 External Registration**.
- Pemakaian barang/reagen oleh unit laboratorium → **OC-08-06 Pakai Barang**.
- Mutasi barang/reagen antar unit → **OC-08-07 Mutasi Barang**.
- Stok opname di unit laboratorium → **OC-08-08 Opname**.
- Order tindakan/tarif selain laboratorium dan radiologi → **OC-05-04 CPOE (Order Pemeriksaan)**.
- Order pemeriksaan radiologi → **OC-09-01 Order Radiologi**.
- Pengelolaan identitas dan data sosial pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan data dokter dan PPA → **Organisasi Domain** (`ORG-PPA`).
- Pengelolaan master tarif laboratorium → **Tata Rekening Domain** (`TRK-TARIF`).

---

## 11. Business Decisions & Open Questions

> Keputusan bisnis yang telah dikonfirmasi dan pertanyaan yang masih membutuhkan konfirmasi Product Owner.

### Confirmed Decisions

1. **OC-08-02 adalah Order Laboratorium**: Permintaan pemeriksaan laboratorium dan order laboratorium adalah konsep yang sama dalam domain ini.
2. **Scope Laboratorium**: OC-08-02 hanya menangani order/tindakan/tarif pemeriksaan laboratorium. Tindakan/tarif selain laboratorium dan radiologi ditangani OC-05-04 CPOE.
3. **Kedudukan Outcome**: OC-08-02 berada pada level yang sama dengan OC-05-04 CPOE; bukan turunan dari CPOE.
4. **Actor**: Order Creator dapat berupa Dokter atau Nurse/Staff yang bertindak atas instruksi dokter. Dokter tetap dicatat sebagai Requester/Instruction Giver.
5. **Minimum Business Facts**: Patient ID + Doctor ID (Requester) + minimal satu item pemeriksaan laboratorium.
6. **Trigger**: Order terbentuk saat Order Creator melakukan confirm/submit dan order berhasil masuk ke status `Ordered`.
7. **Edit & Cancel Window**: Order dapat diedit dan dibatalkan selama masih berstatus `Ordered`. Setelah `Charged`, perubahan dan pembatalan bukan lagi tanggung jawab OC-08-02.
8. **Lifecycle**: `Ordered → Charged → Sample Collected → Processing → Resulted → Released`.

### Open Questions (Membutuhkan Konfirmasi Product Owner)

1. **Konteks Kunjungan (*Visit Context*)**: Apakah order laboratorium wajib terikat pada kunjungan aktif pasien (Rawat Jalan, Rawat Inap, atau IGD), ataukah order dapat dibentuk hanya dengan Patient ID tanpa konteks kunjungan? *(Jawaban ini menentukan apakah Admission Domain perlu ikut sebagai Participating Domain dan apakah `ADM-REG` masuk sebagai Participating Capability.)*

2. **Indikasi Klinis / Diagnosis Kerja (*Clinical Indication*)**: Apakah indikasi klinis, alasan pemeriksaan, atau diagnosis kerja dokter wajib dicatat sebagai bagian dari order, ataukah bersifat opsional?

3. **Urgensi Pemeriksaan (*Urgency / Priority*)**: Apakah order laboratorium wajib menyertakan penandaan tingkat urgensi (misalnya CITO/Darurat vs Rutin) pada tahap pembentukan order `Ordered`?

4. **Mekanisme Pembatalan (*Cancellation State*)**: Ketika order dibatalkan sebelum `Charged`, apakah status order wajib dicatat secara persisten sebagai `Cancelled` (bukan dihapus), dan apakah alasan pembatalan serta identitas pembatal wajib direkam untuk keperluan audit?

5. **Kewenangan Pembuat Order (*Order Creator Authorization*)**: Kategori Nurse/Staff apa saja yang memiliki kewenangan administratif untuk membuat order atas instruksi dokter (misalnya: perawat ruangan asal pasien saja, atau mencakup petugas administrasi poli/bangsal dan staf klinis terverifikasi lainnya)?
