# OUTCOME: Terima Barang (DO)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-12-01     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Terima Barang (DO) memastikan barang obat dan BHP yang dikirim pemasok berdasarkan Purchase Order (PO) yang disetujui dapat diperiksa, diputuskan penerimaannya, dan diakui sebagai persediaan aktif rumah sakit secara akurat dan tertelusur.

Outcome ini membentuk fakta bisnis penerimaan yang sah sebagai dasar penambahan persediaan aktif dan penetapan HPP, sekaligus memastikan barang yang belum disahkan atau ditolak tidak menambah stok.

---

## 2. Outcome Statement

Barang obat atau BHP berdasarkan Purchase Order (PO) yang disetujui **telah diperiksa dan disahkan oleh pihak yang berwenang, sehingga kuantitas yang disahkan diterima diakui sebagai penambahan persediaan aktif rumah sakit yang tertelusur beserta nomor batch/lot, tanggal kedaluwarsa, dan penetapan HPP**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Purchasing (`PUR`)** | **Pemilik Utama:** Mengelola penerimaan barang dari pemasok (`PUR-DO`) terhadap PO yang disetujui (`PUR-PO`), memverifikasi fisik, mendokumentasikan ketidaksesuaian/penolakan, dan menerbitkan pengesahan penerimaan. |
| **Inventory (`INV`)** | **Kolaborator Persediaan:** Mengakui penambahan stok aktif (`INV-STOK`) dan mencatat mutasi masuk (`INV-MUTASI`) di gudang tujuan sebesar kuantitas yang disahkan diterima, serta mencatat nomor batch/lot, tanggal kedaluwarsa, dan HPP perolehan barang. |
| **Organisasi (`ORG`)** | **Kolaborator Organisasi:** Menyediakan definisi unit kerja gudang penerima (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PUR-DO` DO Penerimaan Barang | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Rujukan PO Sah:** Penerimaan mengacu pada PO yang telah berstatus disetujui (*Approved*).
- **Hasil Pemeriksaan Tertelusur:** Pemeriksaan fisik terhadap surat jalan pemasok dan PO tercatat per item (sesuai, selisih kurang/lebih, rusak/cacat, atau ditolak).
- **Penerimaan Sebagian (*Partial Acceptance*):** Item yang memenuhi syarat dapat disahkan diterima tanpa terhambat oleh item lain yang berselisih atau ditolak.
- **Penolakan Terdokumentasi:** Barang yang ditolak memiliki catatan alasan penolakan dan bukti pemeriksaan, serta tidak diakui sebagai persediaan aktif.
- **Pengesahan Berwenang (*Sign-Off*):** Penerimaan sah setelah diverifikasi dan disahkan oleh pihak berwenang; barang yang belum disahkan tidak menambah stok aktif.
- **Pengakuan Stok Berdasarkan Kuantitas Disahkan:** Penambahan stok aktif hanya bertambah sebesar kuantitas yang disahkan diterima (*Accepted Quantity*).
- **Batch, Kedaluwarsa, dan HPP:** Seluruh barang yang diterima sah memiliki nomor batch/lot, tanggal kedaluwarsa, dan penetapan nilai HPP perolehan saat pengesahan.

---

### 5.2 Required Recorded Information

- Identitas unik penerimaan (*Goods Receipt / DO*), nomor PO rujukan, surat jalan pemasok, pemasok, gudang tujuan, pemeriksa, pengesah, dan tanggal pengesahan;
- Rincian item: identitas barang, satuan, kuantitas disahkan diterima (*Accepted Qty*), nomor batch/lot, tanggal kedaluwarsa, dan nilai HPP;
- Catatan selisih dan penolakan (jika ada): kuantitas ditolak/selisih dan alasan penolakan;
- Status dokumen penerimaan (**Disahkan** / *Approved* atau **Ditolak** / *Rejected*).

---

### 5.3 Required Business Conditions

- PO rujukan aktif dan berstatus disetujui (*Approved*);
- Pemasok dan item sesuai dengan PO (atau substitusi yang disetujui pihak berwenang);
- Pengesahan dilakukan oleh personel yang berwenang sebelum mutasi stok dan HPP terbentuk.

---

### 5.4 Completion Proof

- Dokumen penerimaan berstatus **Disahkan** (*Approved*) yang tertaut pada PO dan surat jalan pemasok;
- Mutasi penambahan stok aktif tercatat di Inventory sebesar kuantitas yang disahkan diterima lengkap dengan nomor batch/lot, tanggal kedaluwarsa, dan HPP.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kiriman fisik barang tiba di gudang rumah sakit bersama dokumen pengiriman pemasok dengan merujuk pada PO yang telah disetujui.

### End

- **Hasil Primer (Outcome Selesai):** Dokumen penerimaan disahkan oleh pihak berwenang dan kuantitas yang diterima sah diakui sebagai penambahan persediaan aktif gudang beserta nomor batch/lot, tanggal kedaluwarsa, dan penetapan HPP.
- **Hasil Alternatif (Terminal Exception):** Jika seluruh kiriman ditolak saat pemeriksaan fisik, penerimaan ditutup dengan status ditolak (*Rejected*) sebagai jejak audit pengadaan tanpa penambahan stok aktif.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Mandatori PO Disetujui:** Penerimaan dilarang diproses tanpa merujuk pada PO yang telah disetujui (*Approved*).
2. **Verifikasi Fisik Mandatori:** Kuantitas penerimaan ditentukan melalui pemeriksaan fisik nyata, bukan penyalinan otomatis dari PO atau surat jalan pemasok.
3. **Pemisahan Pengakuan Stok:** Kedatangan fisik barang atau draf penerimaan belum menambah stok aktif; penambahan stok hanya terjadi setelah pengesahan resmi.
4. **Plafon Penambahan Stok:** Stok aktif hanya bertambah sebesar kuantitas yang disahkan diterima (*Accepted Quantity*). Barang yang ditolak atau masih berselisih dilarang menambah stok.
5. **Mandatori Batch dan Kedaluwarsa:** Seluruh item yang disahkan diterima wajib memiliki nomor batch/lot dan tanggal kedaluwarsa yang valid.
6. **Penetapan HPP Terpisah dari Faktur:** Nilai HPP perolehan barang ditetapkan saat penerimaan disahkan berdasarkan nilai pesanan PO dan aturan biaya perolehan yang berlaku, tanpa bergantung pada rekonsiliasi faktur pemasok.
7. **Legalitas Penerimaan Parsial:** Adanya barang yang ditolak, rusak, atau kurang tidak membatalkan penerimaan atas item lain yang memenuhi syarat dan disahkan.
8. **Finalitas Catatan Pengesahan:** Dokumen penerimaan yang telah disahkan bersifat permanen dan tidak dapat diubah melalui alur operasional normal.
9. **Batas Kepemilikan Hukum:** Pengesahan penerimaan mencatat pengakuan fisik dan operasional persediaan internal, serta tidak menyatakan peralihan kepemilikan yuridis (*legal title*).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Kiriman barang tiba tanpa PO yang disetujui** | Penerimaan ditolak atau ditangguhkan hingga PO yang disetujui tersedia. |
| **Kuantitas kiriman kurang dari PO (*Under-delivery*)** | Item fisik yang memenuhi syarat disahkan diterima; selisih kurang dicatat untuk tindak lanjut pihak berwenang. |
| **Kuantitas kiriman melebihi PO (*Over-delivery*)** | Kelebihan kuantitas ditolak, kecuali ada otorisasi tertulis dari pihak berwenang sebelum pengesahan. |
| **Barang rusak, cacat kemasan, salah item, atau ED di bawah batas toleransi** | Barang ditolak dan dicatat dengan alasan spesifik tanpa menambah stok aktif. |
| **Nomor batch atau tanggal kedaluwarsa tidak valid/tidak tercantum** | Pengesahan ditahan hingga verifikasi sah terpenuhi, atau barang ditolak. |
| **Seluruh kiriman barang ditolak (*Total Rejection*)** | Dokumen penerimaan ditutup dengan status terminal ditolak (*Rejected*) sebagai jejak audit tanpa penambahan stok aktif. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Penerimaan barang hanya dapat diproses dengan merujuk pada PO yang telah berstatus disetujui (*Approved*). | Constraint |
| **AC-02** | Catatan penerimaan menyajikan hasil pemeriksaan fisik per item terhadap rincian PO dan surat jalan pemasok. | Completeness |
| **AC-03** | Setiap ketidaksesuaian (kurang, lebih, rusak, salah item, ED) terdokumentasi lengkap dengan alasan dan keputusan tindak lanjut pihak berwenang. | Correctness |
| **AC-04** | Kiriman dengan penerimaan sebagian (*partial acceptance*) dapat disahkan untuk item yang memenuhi syarat tanpa terhambat item lain yang berselisih. | Completeness |
| **AC-05** | Barang yang ditolak atau kiriman yang belum disahkan terbukti tidak menambah saldo persediaan aktif gudang. | Constraint |
| **AC-06** | Penambahan saldo stok aktif di gudang persediaan terbukti hanya terjadi sebesar kuantitas yang disahkan diterima (*Accepted Quantity*). | Correctness |
| **AC-07** | Setiap item yang disahkan diterima tercatat lengkap dengan nomor batch/lot dan tanggal kedaluwarsa yang valid. | Constraint |
| **AC-08** | Nilai HPP ditetapkan saat penerimaan disahkan berdasarkan pesanan PO dan aturan biaya perolehan yang berlaku, independen dari proses faktur pemasok. | Correctness |
| **AC-09** | Seluruh catatan penerimaan, termasuk barang yang diterima maupun ditolak, dapat ditelusuri kembali ke PO rujukan dan dokumen pengiriman pemasok. | Completeness |
| **AC-10** | Dokumen penerimaan yang telah disahkan berstatus final dan tidak dapat diubah melalui alur operasional penerimaan normal. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Persetujuan dan Perubahan PO:** Siklus penerbitan, persetujuan, atau revisi pesanan pembelian → **Purchasing Domain** (`PUR-PO`).
- **Pengelolaan Backorder dan Penutupan PO:** Pemenuhan sisa pesanan tertunda dan penutupan administratif PO → **Purchasing Domain** (`PUR-PO`).
- **Faktur Pemasok dan Rekonsiliasi Tagihan:** Pengelolaan faktur pemasok dan pencocokan komersial (*matching*) → **Purchasing Domain** (`PUR-FAKTUR`).
- **Retur Pembelian Mandiri:** Pengembalian fisik barang yang telah masuk persediaan aktif atau penerbitan nota retur ke pemasok → **Purchasing Domain** (`PUR-RETURN` / **OC-12-05 Retur Beli**).
- **Pengeluaran Persediaan dan Mekanisme FEFO/FIFO:** Pengambilan barang dari gudang, distribusi mutasi, atau pemakaian barang → **Inventory Domain** (`INV-MUTASI`, `INV-PAKAI`).
- **Peralihan Kepemilikan Yuridis (*Legal Title*):** Penentuan saat peralihan kepemilikan secara hukum yang diatur dalam kontrak komersial pengadaan.
- **Detail Teknis dan Interaksi UI:** Skema tabel database, struktur kode/API, transaksi database, sinkronisasi teknis, dan rancangan antarmuka pengguna (UI).
