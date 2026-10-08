# OUTCOME: Mutasi

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-07     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Mutasi persediaan digunakan ketika suatu unit kerja di rumah sakit membutuhkan persediaan dari unit kerja lain yang bertindak sebagai penyedia. Unit Pemohon mengajukan kebutuhan barang kepada satu Unit Penyedia, memperoleh persetujuan resmi, dan menerima pemenuhan barang secara fisik. Perpindahan persediaan harus tercatat secara akuntabel sehingga stok berpindah dari Unit Penyedia ke Unit Pemohon secara tertelusur.

Outcome utama bukan sekadar persetujuan permintaan atau pengurangan stok di gudang/penyedia, melainkan tercapai ketika **barang yang diminta telah diterima secara fisik oleh unit pemohon dan perpindahan persediaannya telah tercatat**. Perpindahan persediaan ini memindahkan penanggungjawaban persediaan antar-unit secara netral tanpa menambah atau mengurangi total persediaan rumah sakit.

---

## 2. Outcome Statement

Barang persediaan yang diminta oleh Unit Pemohon **telah disetujui, diterima secara fisik oleh Unit Pemohon dari Unit Penyedia, dan perpindahan persediaannya telah tercatat secara berpasangan sehingga stok resmi berpindah dari Unit Penyedia ke Unit Pemohon secara tertelusur**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | Pemilik utama outcome Mutasi: mengelola pencatatan mutasi persediaan antar-lokasi, pembaruan saldo stok berpasangan, pengendalian status stok dalam perjalanan (*in-transit*), dan integritas catatan transaksi persediaan. |
| **Apotek (`APT`)** | Konteks unit pelayanan kefarmasian: berperan sebagai Unit Pemohon (misalnya depo rawat inap/jalan mengajukan kebutuhan ke gudang farmasi) atau Unit Penyedia (misalnya depo farmasi memenuhi permintaan ruangan/unit lain) dalam pengelolaan perbekalan farmasi. |
| **Organisasi (`ORG`)** | Menyediakan definisi unit kerja rumah sakit (unit layanan, instalasi, ruangan, bangsal, depo persediaan) serta kewenangan personel yang bertindak sebagai pemohon, penyetuju, dan penerima barang. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Satu Penyedia Tunggal:** Satu Order Mutasi hanya diajukan kepada tepat satu Unit Penyedia. Permintaan kepada beberapa penyedia harus dibuat dalam Order Mutasi terpisah.
- **Alur Status Resmi:** Order Mutasi berpindah status secara tertib sesuai alur bisnis:
  - Alur serah terima langsung: `Draft` → `Submitted` → `Approved` → `Completed`.
  - Alur dengan pengiriman/kurir internal: `Draft` → `Submitted` → `Approved` → `Dispatched` → `Completed`.
- **Approval Wajib:** Persetujuan oleh Unit Penyedia bersifat mandatori sebelum order dapat diselesaikan. Order yang masih berstatus `Draft` atau `Submitted` dilarang diselesaikan langsung menjadi `Completed`.
- **Terminalitas Penolakan:** Status `Rejected` bersifat terminal dan final. Order yang ditolak tidak dapat diedit atau diaktifkan kembali. Kebutuhan lanjutan diproses melalui pembuatan Order Mutasi baru.
- **Pemenuhan Utuh (*All-or-Nothing*):** Pemenuhan barang pada serah terima fisik dilakukan secara utuh sesuai dengan item dan kuantitas yang disetujui/dikirim. Tidak ada penerimaan sebagian (*partial receipt*) atau pesanan tunda (*back-order*).
- **Penerimaan Fisik Sah:** Serah terima barang fisik wajib dikonfirmasi atas nama Unit Pemohon oleh personel yang berwenang di unit tersebut.
- **Netralitas Persediaan Total:** Mutasi memindahkan penanggungjawaban persediaan dari Penyedia ke Pemohon tanpa menambah atau mengurangi total persediaan rumah sakit.
- **Pencatatan Berpasangan:** Perpindahan stok wajib tercatat secara berpasangan: stok berkurang dari Unit Penyedia dan stok bertambah pada Unit Pemohon dalam kuantitas yang seimbang.
- **Pengakuan Stok Dalam Perjalanan (*In-Transit*):** Pada alur yang menggunakan status `Dispatched`, barang yang telah dikeluarkan oleh Penyedia namun masih dalam perjalanan belum diakui sebagai stok tersedia (*available stock*) pada Unit Pemohon hingga konfirmasi penerimaan fisik selesai.
- **Imutabilitas Transaksi Selesai:** Transaksi mutasi yang telah berstatus `Completed` tidak boleh dihapus (*no deletion/hard-delete*). Koreksi kesalahan transaksi dilakukan melalui transaksi pembalik (*reversal*) yang mereferensikan transaksi asal demi menjaga jejak audit (*audit trail*).

---

### 5.2 Required Recorded Information

- Identitas unik Order Mutasi (nomor/kode referensi dokumen mutasi);
- Identitas Unit Pemohon (kode dan nama unit kerja, ruangan, bangsal, depo, atau instalasi);
- Identitas Unit Penyedia (kode dan nama unit pengelola persediaan);
- Waktu pencatatan dan identitas pembuat order saat berstatus `Draft`;
- Waktu pengajuan order (`Submitted`);
- Waktu, identitas personel penyetuju/penolak, status keputusan (`Approved` atau `Rejected`), serta alasan penolakan (jika ditolak) dari Unit Penyedia;
- Informasi pengiriman (jika melalui kurir internal): waktu keberangkatan (`Dispatched`) dan identitas pengirim/kurir internal;
- Rincian item barang mutasi:
  - Identitas barang (kode item, nama item);
  - Satuan ukuran;
  - Kuantitas barang yang diminta;
  - Kuantitas barang yang disetujui;
- Bukti serah terima fisik (*evidence*):
  - Identitas personel penerima yang berwenang atas nama Unit Pemohon;
  - Waktu konfirmasi penerimaan fisik;
- Bukti pencatatan perpindahan persediaan:
  - Catatan pengurangan stok pada Unit Penyedia;
  - Catatan penambahan stok pada Unit Pemohon;
- Status akhir Order Mutasi: `Completed`, `Cancelled`, atau `Rejected`.

---

### 5.3 Required Business Conditions

- Unit Pemohon dan Unit Penyedia aktif serta terdaftar sah dalam struktur organisasi rumah sakit;
- Unit Pemohon dan Unit Penyedia merupakan dua unit yang berbeda;
- Item barang yang diminta berstatus aktif dalam master barang persediaan;
- Persetujuan diberikan oleh personel yang berwenang dari Unit Penyedia sebelum barang dikeluarkan/diserahkan;
- Fisik barang yang diserahkan dan diterima sesuai penuh (100%) dengan daftar item dan jumlah yang disetujui/dikirim;
- Konfirmasi penerimaan fisik dilakukan oleh personel yang berwenang bertindak atas nama Unit Pemohon;
- Saldo persediaan pada Unit Penyedia mencukupi untuk memenuhi kuantitas yang disetujui pada saat pengeluaran barang.

---

### 5.4 Completion Proof

> What proves this Outcome is complete?

- **Completed:** Order Mutasi berstatus **Completed** dengan bukti serah terima fisik lengkap (identitas personel penerima atas nama Unit Pemohon dan waktu penerimaan fisik tercatat sah).
- **Pencatatan Persediaan Berpasangan Lengkap:** Perpindahan stok telah terbukukan secara berpasangan (stok berkurang pada Unit Penyedia dan bertambah pada Unit Pemohon dengan jumlah yang sama), dengan total saldo persediaan rumah sakit tetap netral.

---

## 6. Outcome Boundary

### Start

Dimulai ketika personel dari Unit Pemohon membuat pengajuan kebutuhan barang (Order Mutasi) yang ditujukan kepada satu Unit Penyedia.

### End

Berakhir ketika barang telah diterima secara fisik oleh personel yang berwenang atas nama Unit Pemohon, status Order Mutasi menjadi **Completed**, dan perpindahan persediaan telah tercatat secara berpasangan pada Unit Penyedia dan Unit Pemohon.

Batas siklus alternatif/terminal terjadi apabila order dibatalkan (**Cancelled**) oleh Pemohon pada tahap Draft atau Submitted, atau ditolak (**Rejected**) secara permanen oleh Unit Penyedia.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Satu Order = Satu Penyedia:** Satu Order Mutasi wajib hanya memiliki satu Unit Penyedia. Jika Pemohon membutuhkan barang dari beberapa penyedia, kebutuhan tersebut wajib dipecah menjadi Order Mutasi terpisah untuk masing-masing penyedia.
2. **Approval Mandatori:** Persetujuan (*Approval*) oleh Unit Penyedia wajib dilakukan sebelum Order Mutasi dapat diselesaikan. Order yang masih berstatus `Draft` atau `Submitted` dilarang diselesaikan langsung menjadi `Completed`.
3. **Progresi Status Tertib:** Status Order Mutasi wajib mengikuti tahapan resmi: `Draft` → `Submitted` → `Approved` → [`Dispatched`] → `Completed`. Status `Dispatched` bukan tahapan wajib pada semua operasional, melainkan hanya digunakan jika ada jeda pengiriman oleh kurir internal. Pada serah terima langsung di loket, status dapat langsung beralih dari `Approved` ke `Completed`.
4. **Batasan Pembatalan Pemohon:**
   - Pemohon berhak membatalkan order saat berstatus `Draft` atau `Submitted` (selama Penyedia belum memberikan keputusan).
   - Setelah order berstatus `Approved`, Pemohon dilarang membatalkan order secara sepihak karena proses pemenuhan barang sudah dapat dimulai.
   - Pembatalan setelah `Approved` wajib dikoordinasikan dan diproses melalui pihak Penyedia sesuai mekanisme pembatalan/reversal resmi.
5. **Terminalitas Penolakan:** Status `Rejected` adalah status terminal. Order yang ditolak tidak boleh diedit atau diaktifkan kembali. Pemenuhan kebutuhan selanjutnya wajib menggunakan Order baru (sistem dapat menyediakan fasilitas duplikasi dari order lama).
6. **Prinsip Pemenuhan All-or-Nothing:** Pemenuhan persediaan menerapkan prinsip *all-or-nothing*. Barang yang diterima harus sesuai persis dengan item dan kuantitas yang disetujui/dikirim. Tidak ada penerimaan sebagian (*partial receipt*) atau pesanan tunda (*back-order*).
7. **Penyelesaian Ketidaksesuaian Fisik:** Jika terjadi ketidaksesuaian fisik saat serah terima, penerimaan dilarang diselesaikan (*Completed*) hingga ketidaksesuaian diselesaikan secara operasional.
8. **Kewenangan Penerimaan:** Penerima tidak harus personel yang membuat Order, namun wajib merupakan personel yang berwenang bertindak atas nama Unit Pemohon, dengan identitas penerima dan waktu penerimaan dicatat sebagai bukti (*evidence*).
9. **Netralitas Persediaan Total:** Mutasi memindahkan penanggungjawaban persediaan antar-unit dan tidak menambah maupun mengurangi total saldo persediaan rumah sakit.
10. **Pencatatan Stok Berpasangan:** Pengurangan stok di Penyedia dan penambahan stok di Pemohon wajib tercatat secara berpasangan dalam jumlah yang seimbang.
11. **Larangan Pengakuan Stok In-Transit:** Barang yang masih berstatus `Dispatched` (dalam perjalanan) belum boleh diakui sebagai stok tersedia pada Unit Pemohon sampai penerimaan fisik dikonfirmasi.
12. **Imutabilitas dan Audit Trail:** Catatan transaksi mutasi yang telah selesai dilarang dihapus. Pembatalan atas transaksi yang sudah selesai dilakukan melalui transaksi pembalik (*reversal*) yang mempertahankan referensi ke transaksi asal untuk menjamin keterlacakan audit (*audit trail*).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Permintaan ditujukan ke lebih dari satu Penyedia** | Pengajuan ditolak. Kebutuhan harus dipisahkan menjadi Order Mutasi terpisah untuk masing-masing Unit Penyedia. |
| **Penyelesaian langsung tanpa Approval Penyedia** | Tindakan ditolak. Order yang masih `Draft` atau `Submitted` tidak dapat diselesaikan menjadi `Completed` sebelum disetujui (`Approved`). |
| **Pemohon membatalkan sepihak setelah status `Approved`** | Pembatalan sepihak ditolak. Pembatalan setelah persetujuan harus diajukan dan diproses melalui pihak Penyedia. |
| **Penyedia menolak permintaan mutasi** | Order diberi status `Rejected`. Order ditutup permanen dan tidak dapat dibuka kembali; jika Pemohon masih memerlukan barang, Pemohon membuat order baru. |
| **Ketidaksesuaian fisik saat serah terima** | Penyelesaian order (*Completed*) ditahan. Penerimaan tidak dapat diproses sampai ketidaksesuaian fisik diselesaikan secara operasional (sesuai prinsip *all-or-nothing*). |
| **Stok Penyedia tidak mencukupi saat persetujuan** | Penyedia tidak dapat menyetujui pemenuhan penuh; Penyedia menolak permintaan atau menunggu ketersediaan stok sebelum persetujuan diberikan. |
| **Penerima bukan personel berwenang Unit Pemohon** | Konfirmasi serah terima ditolak. Penerimaan fisik hanya sah jika dilakukan oleh personel yang memiliki wewenang atas nama Unit Pemohon. |
| **Koreksi atas transaksi mutasi yang sudah `Completed`** | Penghapusan data transaksi ditolak. Pembatalan/koreksi wajib diproses melalui penerbitan transaksi pembalik (*reversal*) yang mereferensikan transaksi asal. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Satu Order Mutasi hanya dapat dibuat dan ditujukan kepada tepat satu Unit Penyedia. | Constraint |
| **AC-02** | Order Mutasi hanya dapat diselesaikan (`Completed`) setelah disetujui (`Approved`) oleh Unit Penyedia, dan dilarang melompat langsung dari status `Draft` atau `Submitted`. | Constraint |
| **AC-03** | Pemohon dapat membatalkan Order yang masih berstatus `Draft` atau `Submitted` menjadi `Cancelled`. | Correctness |
| **AC-04** | Pemohon tidak dapat membatalkan secara sepihak Order yang sudah berstatus `Approved`. | Constraint |
| **AC-05** | Order yang ditolak Penyedia berubah status menjadi `Rejected` sebagai status terminal yang tidak dapat diedit atau diaktifkan kembali. | Exception |
| **AC-06** | Pada alur pengiriman internal, status `Dispatched` mencatat pengeluaran barang oleh Penyedia namun belum menambah stok tersedia pada Unit Pemohon. | Correctness |
| **AC-07** | Order hanya dapat berstatus `Completed` jika barang yang diserahterimakan secara fisik sesuai 100% dengan item dan kuantitas yang disetujui/dikirim (*all-or-nothing*). | Constraint |
| **AC-08** | Konfirmasi penyelesaian mencatat identitas personel penerima atas nama Unit Pemohon dan waktu penerimaan fisik sebagai bukti serah terima sah. | Completeness |
| **AC-09** | Transisi ke status `Completed` mencatat perpindahan stok berpasangan (berkurang di Penyedia dan bertambah di Pemohon) dalam jumlah seimbang tanpa mengubah total persediaan rumah sakit. | Completeness |
| **AC-10** | Pembatalan transaksi mutasi yang sudah `Completed` tidak menghapus data transaksi asal melainkan menerbitkan transaksi pembalik (*reversal*) dengan referensi audit yang jelas. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Strategi Alokasi Stok Internal Penyedia:** Metode pengambilan fisik barang (FIFO/FEFO), pengelolaan nomor batch, dan pemantauan masa kedaluwarsa (*expiry date*) pada gudang Penyedia.
- **Valuasi Akuntansi & Biaya:** Penilaian harga pokok persediaan, jurnal akuntansi keuangan, atau pembebanan biaya antar-unit (*inter-unit cost allocation*).
- **Detail Teknis Ledger & Sistem:** Perintah mutasi teknis database (`MT_OUT`, `MT_IN`), struktur tabel, class/command teknis, atau sinkronisasi dengan *legacy ledger*.
- **Pengadaan Eksternal:** Pembelian dan penerimaan barang dari pemasok/vendor luar rumah sakit (*Purchasing / DO Penerimaan Barang*).
- **Konsumsi Operasional:** Penggunaan langsung barang untuk pelayanan atau tindakan pasien (*Dispensing Farmasi* atau *Pakai Barang*).
