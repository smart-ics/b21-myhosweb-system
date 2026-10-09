# OUTCOME: Terima Barang (DO)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-12-01     |
| Version     | 1.3          |
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
| **Inventory (`INV`)** | **Kolaborator Persediaan:** Mengakui penambahan stok aktif (`INV-STOK`) dan mencatat mutasi masuk (`INV-MUTASI`) di gudang tujuan sebesar kuantitas yang disahkan diterima, serta mencatat nomor batch/lot, tanggal kedaluwarsa, dan HPP perolehan barang (`INV-MASTER`). |
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

- **Penerimaan Berdasar PO Sah:** Catatan penerimaan terbentuk dengan rujukan sah ke PO yang disetujui dan dokumen pengiriman pemasok.
- **Kuantitas Disahkan Tercatat Lengkap:** Kuantitas yang disahkan diterima (*Accepted Quantity*) tercatat per item barang beserta nomor batch/lot, tanggal kedaluwarsa, dan penetapan HPP definitif.
- **Pengakuan Stok Mengikuti Pengesahan:** Penambahan stok aktif di gudang persediaan terbentuk hanya sebesar kuantitas yang disahkan diterima.
- **Ketidaksesuaian dan Penolakan Terdokumentasi:** Selisih fisik (kurang/lebih) dan barang yang ditolak memiliki dokumentasi alasan dan keputusan pihak berwenang tanpa menambah stok aktif.

---

### 5.2 Required Recorded Information

- Identitas unik penerimaan (*Goods Receipt / DO*), nomor PO rujukan, surat jalan pemasok, pemasok, gudang tujuan, tanggal penerimaan dan pengesahan, serta identitas pemeriksa dan pejabat pengesah;
- Rincian item diterima: identitas barang, kuantitas disahkan (*Accepted Qty*), nomor batch/lot, tanggal kedaluwarsa, dan nilai HPP;
- Catatan selisih dan penolakan (jika ada): kuantitas selisih/ditolak dan alasan ketidaksesuaian/penolakan;
- Status dokumen penerimaan (**Disahkan** / *Approved* atau **Ditolak** / *Rejected*).

---

### 5.3 Required Business Conditions

- PO rujukan berstatus aktif dan disetujui (*Approved*);
- Pengesahan dilakukan oleh pejabat berwenang sebelum mutasi stok persediaan diakui.

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

1. **Rujukan PO Mandatori:** Penerimaan dilarang diproses tanpa merujuk pada PO yang telah disetujui (*Approved*).
2. **Penetapan Fisik Obyektif:** Kuantitas penerimaan wajib didasarkan pada hasil pemeriksaan fisik nyata, bukan penyalinan otomatis dari PO atau surat jalan pemasok.
3. **Plafon Stok Berdasarkan Pengesahan:** Kedatangan fisik barang atau draf penerimaan dilarang menambah stok aktif; penambahan stok aktif hanya bertambah setelah pengesahan resmi dan dibatasi sebesar kuantitas yang disahkan diterima (*Accepted Quantity*).
4. **Mandatori Batch dan Kedaluwarsa:** Seluruh item yang disahkan diterima wajib memiliki nomor batch/lot dan tanggal kedaluwarsa yang valid.
5. **Prinsip Penetapan HPP:** HPP perolehan ditetapkan saat pengesahan mengacu pada harga pesanan PO, kecuali terdapat penyesuaian biaya perolehan yang disetujui resmi oleh pihak berwenang pada dokumen penerimaan; nilai HPP yang telah disahkan bersifat mengikat sebagai nilai perolehan persediaan dan tidak berubah surut oleh rekonsiliasi faktur di kemudian hari.
6. **Independensi Penerimaan Parsial:** Adanya barang yang ditolak, rusak, atau berselisih dalam satu kiriman tidak membatalkan penerimaan atas item lain yang memenuhi syarat dan disahkan.
7. **Finalitas Catatan:** Dokumen penerimaan yang telah disahkan bersifat permanen dan tidak dapat diubah melalui alur operasional normal.
8. **Batas Yuridis:** Pengesahan penerimaan mencatat pengakuan fisik dan operasional persediaan internal, serta tidak menyatakan peralihan kepemilikan yuridis (*legal title*).

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
| **AC-01** | Penerimaan barang memvalidasi rujukan ke PO yang berstatus disetujui (*Approved*). | Constraint |
| **AC-02** | Catatan penerimaan menyajikan hasil pemeriksaan fisik per item terhadap rincian PO dan surat jalan pemasok. | Completeness |
| **AC-03** | Setiap ketidaksesuaian (kurang, lebih, rusak, salah item, ED) terdokumentasi lengkap dengan alasan dan keputusan tindak lanjut pihak berwenang. | Correctness |
| **AC-04** | Penerimaan sebagian (*partial acceptance*) dapat disahkan untuk item yang memenuhi syarat tanpa terhambat item lain yang berselisih. | Completeness |
| **AC-05** | Barang yang ditolak atau kiriman yang belum disahkan terbukti tidak menambah saldo persediaan aktif gudang. | Constraint |
| **AC-06** | Penambahan saldo stok aktif di gudang persediaan terbukti hanya terjadi sebesar kuantitas yang disahkan diterima (*Accepted Quantity*). | Correctness |
| **AC-07** | Setiap item yang disahkan diterima tercatat lengkap dengan nomor batch/lot dan tanggal kedaluwarsa yang valid. | Constraint |
| **AC-08** | Nilai HPP ditetapkan saat pengesahan mengacu pada harga PO atau penyesuaian yang disahkan berwenang, dan bersifat definitif terlepas dari proses faktur. | Correctness |
| **AC-09** | Seluruh catatan penerimaan, termasuk barang yang diterima maupun ditolak, dapat ditelusuri kembali ke PO rujukan dan dokumen pengiriman pemasok. | Completeness |
| **AC-10** | Dokumen penerimaan yang telah disahkan berstatus final dan tidak dapat diubah melalui alur operasional normal. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Siklus Purchase Order:** Penerbitan, persetujuan, amandemen, dan penutupan administratif PO.
- **Pengelolaan Backorder:** Kebijakan pemenuhan sisa pesanan tertunda oleh pemasok.
- **Faktur Pemasok dan Pembayaran:** Verifikasi invoice tagihan pemasok (*three-way matching*), utang usaha, dan pelunasan pembayaran.
- **Retur Pembelian Mandiri:** Pengembalian fisik barang yang telah masuk persediaan aktif atau penerbitan nota retur ke pemasok.
- **Pengeluaran dan Alokasi Persediaan:** Pengambilan barang dari gudang, distribusi antar-unit, pemakaian operasional, dan metode fisik FEFO/FIFO.
- **Peralihan Kepemilikan Yuridis (*Legal Title*):** Pengakuan kepemilikan secara hukum yang ditentukan oleh perjanjian kontrak komersial pengadaan.
- **Detail Desain Teknis & UI:** Skema basis data, model entitas kode/API, transaksi database, sinkronisasi dual-write teknis, dan tata letak layar pengguna.
