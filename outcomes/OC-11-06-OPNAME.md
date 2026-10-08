# OUTCOME: Opname

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-06     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Opname menghasilkan **hasil resmi penghitungan persediaan** pada satu lokasi persediaan (*Inventory Location*), yang menunjukkan jumlah fisik persediaan, perbandingannya dengan catatan persediaan pada waktu penghitungan, selisih yang ditemukan, serta hasil verifikasi dan persetujuannya.

Hasil opname menjadi dasar yang disetujui untuk penyesuaian persediaan (*Inventory Adjustment*).

Tanpa hasil Opname yang disetujui, perbedaan antara fisik dan catatan persediaan tidak dapat dipertanggungjawabkan dan tidak memiliki dasar untuk penyesuaian persediaan.

---

## 2. Outcome Statement

Hasil penghitungan persediaan pada satu *Inventory Location* **telah diverifikasi dan disetujui (*Approved*) oleh Manager beserta konsekuensi bisnis dari selisih yang ditemukan, serta siap menjadi dasar penyesuaian persediaan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | Pemilik utama outcome Opname: mengelola penghitungan fisik, membandingkan hasil fisik dengan catatan persediaan pada waktu penghitungan, memverifikasi selisih, dan menerbitkan hasil opname yang disetujui sebagai dasar penyesuaian persediaan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-OPNAME` Stok Opname | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Satu Lokasi:** Satu sesi opname hanya berlaku untuk satu *Inventory Location*.
- **Cakupan Item:** Sesi memiliki cakupan item yang terdefinisi (*Full Opname* maupun *Cycle Counting*). Hanya item dalam cakupan yang menjadi bagian dari hasil opname. Item di luar cakupan tidak dianggap berselisih.
- **Fisik Nol:** Item dalam cakupan yang tidak ditemukan fisik dicatat dengan jumlah fisik 0.
- **Waktu Penghitungan per Item:** Setiap item memiliki waktu penghitungan fisik. Catatan pembanding merepresentasikan kondisi persediaan pada waktu penghitungan tersebut. Transaksi operasional setelah waktu hitung tidak mengubah catatan pembanding.
- **Verifikasi Selisih:** Item tanpa selisih langsung menjadi hasil final. Item berselisih diverifikasi melalui penghitungan ulang oleh pihak yang berbeda dari penghitung awal, dan hasilnya menjadi jumlah fisik final.
- **Kelengkapan Sebelum Persetujuan:** Seluruh item dalam cakupan sesi telah memiliki jumlah fisik final sebelum diajukan untuk persetujuan.
- **Verifikasi dan Persetujuan:** Supervisor memastikan kebenaran jumlah fisik final. Manager memberikan persetujuan (*Approved*) atas hasil opname dan konsekuensi bisnis dari selisih tersebut.
- **Kuantitas Saja:** Hasil opname menyajikan kuantitas fisik final, catatan pembanding, dan selisih kuantitas tanpa menetapkan nilai finansial (Rupiah).
- **Finalitas Catatan:** Hasil opname yang telah disetujui menjadi catatan resmi dan tidak dapat diubah melalui proses Opname biasa. Koreksi dilakukan melalui proses korektif tersendiri dengan mempertahankan riwayat lama.

---

### 5.2 Required Recorded Information

- Identitas sesi opname dan *Inventory Location* yang dihitung;
- Waktu pembukaan sesi dan daftar item dalam cakupan;
- Rincian per item dalam cakupan:
  - Identitas item dan satuan ukuran;
  - Waktu penghitungan fisik;
  - Jumlah fisik awal dan identitas penghitung awal;
  - Catatan persediaan pembanding pada waktu penghitungan;
  - Hasil verifikasi selisih (jika ada): identitas pemverifikasi dan jumlah fisik hasil hitung ulang;
  - Jumlah fisik final dan selisih final;
- Konfirmasi verifikasi fisik oleh Supervisor;
- Bukti persetujuan Manager (identitas, waktu persetujuan, dan pernyataan persetujuan);
- Status sesi: **Approved** dan **Closed**.

---

### 5.3 Required Business Conditions

- Sesi dibuka untuk satu *Inventory Location* yang aktif;
- Pemverifikasi selisih berbeda dari penghitung awal;
- Seluruh item dalam cakupan telah memiliki jumlah fisik final sebelum diajukan untuk persetujuan;
- Persetujuan diberikan oleh Manager atas hasil opname dan konsekuensi bisnis selisih.

---

### 5.4 Completion Proof

> What proves this Outcome is complete?

- **Approved:** Sesi berstatus Approved dengan bukti persetujuan Manager, seluruh item dalam cakupan memiliki hasil fisik final dan selisih yang jelas, serta siap menjadi dasar penyesuaian persediaan.
- **Closed:** Sesi berstatus Closed setelah proses penyesuaian persediaan lanjutan selesai dan sesi diarsipkan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika sesi opname pada satu *Inventory Location* dibuka dan cakupan item ditetapkan untuk dihitung.

### End

- **Batas Tanggung Jawab Opname:** Berakhir ketika hasil opname disetujui oleh Manager (**Approved**) sebagai dasar penyesuaian persediaan.
- **Batas Siklus Sistem:** Sesi opname ditutup (**Closed**) setelah proses penyesuaian persediaan lanjutan selesai dan sesi diarsipkan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Satu Sesi = Satu Lokasi:** Sesi opname hanya berlaku untuk satu *Inventory Location*.
2. **Batasan Cakupan:** Hanya item dalam cakupan sesi yang dihitung dan menjadi bagian dari hasil opname. Item di luar cakupan tidak dianggap berselisih dan tidak disesuaikan.
3. **Fisik Tidak Ditemukan:** Item dalam cakupan yang tidak ditemukan fisik wajib dicatat dengan jumlah fisik 0.
4. **Waktu Penghitungan:** Setiap item wajib memiliki waktu penghitungan, dan catatan pembanding mencerminkan kondisi persediaan pada waktu penghitungan tersebut.
5. **Independensi Transaksi Berjalan:** Transaksi persediaan yang terjadi setelah waktu penghitungan suatu item tidak mengubah catatan pembanding item tersebut.
6. **Pemisahan Fungsi Verifikasi:** Verifikasi selisih wajib dilakukan oleh pihak yang berbeda dari penghitung awal. Penghitung awal dilarang memverifikasi selisihnya sendiri.
7. **Prasyarat Persetujuan:** Approval Manager hanya dapat diberikan jika seluruh item dalam cakupan sesi sudah memiliki jumlah fisik final. Tidak boleh ada item yang masih menunggu verifikasi.
8. **Lingkup Persetujuan Manager:** Manager menyetujui hasil opname dan konsekuensi bisnis dari selisih tersebut sebagai dasar penyesuaian persediaan.
9. **Kuantitas Saja:** Hasil opname hanya menetapkan kuantitas fisik final, catatan pembanding, dan selisih kuantitas; opname tidak menetapkan nilai finansial (Rupiah).
10. **Catatan Tidak Dapat Diubah:** Hasil Opname yang telah disetujui menjadi catatan resmi dan tidak dapat diubah melalui proses Opname biasa. Koreksi kesalahan dilakukan melalui proses korektif tersendiri dengan mempertahankan riwayat lama.
11. **Batas Tanggung Jawab:** Pelaksanaan penyesuaian saldo persediaan (*Inventory Adjustment*) dan pembaruan buku persediaan berada di luar tanggung jawab Opname.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Item cakupan tidak ditemukan fisik** | Dicatat dengan jumlah fisik 0. Jika terdapat selisih dengan catatan persediaan, item diverifikasi ulang sebelum hasil ditetapkan final. |
| **Penghitung awal mencoba memverifikasi selisih sendiri** | Ditolak. Verifikasi selisih dialihkan kepada pemeriksa independen yang berbeda. |
| **Pengajuan Approval saat masih ada item belum final** | Ditolak. Seluruh item dalam cakupan wajib memiliki jumlah fisik final sebelum diajukan untuk persetujuan. |
| **Transaksi persediaan terjadi selama sesi berlangsung** | Transaksi tetap berjalan. Catatan pembanding item tetap mengacu pada kondisi saat item dihitung. |
| **Koreksi pasca-Approval** | Pengubahan langsung ditolak. Koreksi diproses melalui mekanisme korektif terpisah dengan persetujuan tersendiri. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sesi opname hanya dapat dibuat untuk satu *Inventory Location* dengan cakupan item yang terdefinisi. | Constraint |
| **AC-02** | Item dalam cakupan sesi yang tidak ditemukan fisik tercatat dengan jumlah fisik 0. | Completeness |
| **AC-03** | Setiap item yang dihitung mencatat waktu penghitungan dan membandingkan fisik dengan catatan persediaan pada waktu tersebut. | Correctness |
| **AC-04** | Transaksi persediaan setelah waktu penghitungan tidak mengubah catatan pembanding item yang telah dihitung. | Correctness |
| **AC-05** | Item tanpa selisih langsung menjadi hasil final, sedangkan item berselisih diverifikasi ulang oleh petugas yang berbeda dari penghitung awal. | Constraint |
| **AC-06** | Pengajuan Approval ditolak jika masih terdapat item dalam cakupan sesi yang belum memiliki jumlah fisik final. | Constraint |
| **AC-07** | Approval Manager mengesahkan seluruh hasil fisik final dan konsekuensi bisnis selisih menjadi status **Approved**. | Correctness |
| **AC-08** | Hasil opname menyajikan kuantitas fisik final, catatan pembanding, dan selisih tanpa menetapkan nilai finansial (Rupiah). | Completeness |
| **AC-09** | Hasil opname berstatus **Approved** tidak dapat diubah langsung; koreksi dilakukan melalui proses korektif terpisah dengan riwayat lama dipertahankan. | Constraint |
| **AC-10** | Tanggung jawab bisnis Opname selesai pada status **Approved**, dan status berubah menjadi **Closed** setelah proses penyesuaian persediaan selesai dan sesi diarsipkan. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Penyesuaian Persediaan (*Inventory Adjustment*):** Pelaksanaan penyesuaian saldo persediaan dan pembaruan buku persediaan → Domain Persediaan (`INV-STOK`, `INV-MUTASI`).
- **Valuasi Finansial:** Penilaian nilai uang/Rupiah atas selisih persediaan dan pencatatan akuntansi keuangan → Akuntansi / Keuangan.
- **Pengelolaan Master Data:** Pengelolaan master barang dan master lokasi persediaan.
- **Kebijakan Operasional dan Media Penghitungan:** Pemilihan format opname (*Full* vs *Cycle Counting*) dan sarana penghitungan fisik (formulir kertas vs pemindai elektronik).
- **Desain Teknis:** Skema basis data, spesifikasi API, antarmuka pengguna (UI), dan prosedur teknis implementasi.
