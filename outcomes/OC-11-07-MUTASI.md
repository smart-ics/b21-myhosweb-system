# OUTCOME: Mutasi

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-07     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Mutasi persediaan digunakan ketika suatu unit kerja membutuhkan persediaan dari unit lain yang bertindak sebagai penyedia. Unit Pemohon mengajukan kebutuhan barang kepada satu Unit Penyedia, memperoleh persetujuan resmi, dan menerima pemenuhan barang secara fisik. Perpindahan persediaan harus tercatat sehingga stok berpindah dari Unit Penyedia ke Unit Pemohon secara tertelusur tanpa mengubah total persediaan rumah sakit.

Outcome utama bukan sekadar persetujuan permintaan atau pengurangan stok di gudang, melainkan tercapai ketika **barang yang diminta telah diterima secara fisik oleh unit pemohon dan perpindahan persediaannya telah tercatat**.

---

## 2. Outcome Statement

Barang persediaan yang diminta oleh Unit Pemohon **telah diterima secara fisik dari Unit Penyedia dan perpindahan persediaannya telah tercatat**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Inventory (`INV`)** | Pemilik utama outcome Mutasi: mengelola pencatatan mutasi persediaan, pergerakan stok antar-lokasi, dan pengendalian status stok dalam perjalanan (*in-transit*). |
| **Apotek (`APT`)** | Konteks unit pelayanan kefarmasian: berperan sebagai Unit Pemohon atau Unit Penyedia dalam pengelolaan perbekalan farmasi. |
| **Organisasi (`ORG`)** | Menyediakan definisi unit kerja rumah sakit (unit layanan, instalasi, ruangan, bangsal, depo) dan identitas personel yang berwenang. |

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

- **Permintaan Terotorisasi:** Order Mutasi diterbitkan oleh Unit Pemohon kepada satu Unit Penyedia dan telah disetujui (`Approved`) oleh Penyedia.
- **Serah Terima Fisik Riil:** Barang yang diminta telah diserahterimakan dan diterima secara fisik oleh personel yang berwenang atas nama Unit Pemohon.
- **Perpindahan Persediaan Berpasangan:** Catatan pengurangan stok pada Unit Penyedia dan penambahan stok pada Unit Pemohon telah terbentuk dalam kuantitas yang sama.
- **Netralitas Total Persediaan:** Perpindahan persediaan memindahkan penanggungjawaban stok antar-unit tanpa menambah atau mengurangi total persediaan rumah sakit.
- **Status Akhir Selesai:** Order Mutasi berstatus **Completed**.

---

### 5.2 Required Recorded Information

- Identitas unik Order Mutasi (nomor referensi);
- Identitas Unit Pemohon dan Unit Penyedia;
- Rincian item: identitas barang, satuan, kuantitas diminta, dan kuantitas disetujui;
- Bukti persetujuan Penyedia (waktu dan identitas penyetuju);
- Bukti serah terima fisik (identitas penerima atas nama Unit Pemohon dan waktu penerimaan);
- Bukti perpindahan stok berpasangan (pengurangan stok Penyedia dan penambahan stok Pemohon);
- Status akhir Order Mutasi (`Completed`, `Cancelled`, atau `Rejected`).

---

### 5.3 Required Business Conditions

- Unit Pemohon dan Unit Penyedia aktif serta merupakan dua unit yang berbeda;
- Kuantitas fisik yang diserahterimakan sesuai penuh (100%) dengan yang disetujui/dikirim (*all-or-nothing*);
- Penerima fisik berwenang bertindak atas nama Unit Pemohon;
- Saldo persediaan Penyedia mencukupi pada saat pengeluaran barang.

---

### 5.4 Completion Proof

> What proves this Outcome is complete?

- **Completed:** Order Mutasi berstatus **Completed** dengan bukti serah terima fisik sah (identitas penerima atas nama Unit Pemohon dan waktu penerimaan tercatat).
- **Stok Berpindah Seimbang:** Catatan mutasi persediaan terbit secara berpasangan (stok berkurang di Penyedia dan bertambah di Pemohon dengan kuantitas yang sama).

---

## 6. Outcome Boundary

### Start

Dimulai ketika personel Unit Pemohon membuat pengajuan kebutuhan barang (Order Mutasi) yang ditujukan kepada satu Unit Penyedia.

### End

Berakhir ketika barang diterima secara fisik atas nama Unit Pemohon, status Order Mutasi menjadi **Completed**, dan perpindahan persediaan telah tercatat pada kedua unit.

(Batas terminal alternatif: **Cancelled** oleh Pemohon sebelum persetujuan, atau **Rejected** secara permanen oleh Penyedia).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Satu Order = Satu Penyedia:** Satu Order Mutasi hanya boleh ditujukan kepada satu Unit Penyedia. Kebutuhan ke beberapa penyedia wajib dipisahkan menjadi order berbeda.
2. **Approval Mandatori:** Order wajib disetujui (`Approved`) oleh Penyedia sebelum barang dapat dikeluarkan/dikirim atau diselesaikan (`Completed`). Order pada status `Draft` atau `Submitted` dilarang diselesaikan langsung.
3. **Alur Status Resmi:** Mengikuti tahapan `Draft` → `Submitted` → `Approved` → [`Dispatched`] → `Completed`. Status `Dispatched` hanya digunakan jika terdapat jeda pengiriman kurir internal. Pada serah terima langsung di loket, status dapat langsung beralih dari `Approved` ke `Completed`.
4. **Batasan Pembatalan:** Pemohon hanya dapat membatalkan order saat berstatus `Draft` atau `Submitted`. Setelah `Approved`, pembatalan sepihak dilarang dan harus dikoordinasikan melalui Penyedia.
5. **Terminalitas Penolakan:** Status `Rejected` bersifat terminal. Order yang ditolak tidak dapat diedit atau diaktifkan kembali; kebutuhan lanjutan diproses melalui order baru.
6. **Pemenuhan All-or-Nothing:** Barang fisik yang diterima wajib sesuai penuh dengan yang disetujui/dikirim. Tidak ada penerimaan sebagian (*partial receipt*) atau pesanan tunda (*back-order*).
7. **Penerima Atas Nama Pemohon:** Penerima fisik tidak harus personel yang membuat Order, namun wajib merupakan personel yang berwenang atas nama Unit Pemohon.
8. **Stok Dalam Perjalanan (*In-Transit*):** Barang yang berstatus `Dispatched` belum diakui sebagai stok tersedia pada Unit Pemohon sampai penerimaan fisik dikonfirmasi.
9. **Kekekalan Transaksi Selesai:** Transaksi mutasi yang telah `Completed` tidak boleh dihapus. Pembatalan dilakukan melalui transaksi pembalik (*reversal*) dengan mempertahankan referensi asal demi jejak audit (*audit trail*).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Ketidaksesuaian fisik saat serah terima** | Penyelesaian order ditahan. Penerimaan tidak dapat diselesaikan (`Completed`) sampai ketidaksesuaian diselesaikan secara operasional (sesuai prinsip *all-or-nothing*). |
| **Permintaan ditolak oleh Penyedia** | Order menjadi status terminal `Rejected`. Order tidak dapat diaktifkan kembali; Pemohon membuat order baru jika masih memerlukan barang. |
| **Pembatalan diajukan oleh Pemohon** | Hanya diproses jika order masih berstatus `Draft` atau `Submitted`. Jika sudah `Approved`, permintaan pembatalan dialihkan ke Unit Penyedia. |
| **Stok Penyedia tidak mencukupi saat persetujuan** | Order tidak dapat disetujui penuh; Penyedia menolak permintaan atau menunda persetujuan hingga stok tersedia. |
| **Koreksi atas transaksi mutasi yang sudah `Completed`** | Data transaksi asal tetap utuh; koreksi dilakukan melalui penerbitan transaksi pembalik (*reversal*) yang mereferensikan transaksi asal. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Order Mutasi hanya ditujukan kepada tepat satu Unit Penyedia. | Constraint |
| **AC-02** | Order Mutasi tidak dapat berpindah menjadi `Completed` tanpa melalui persetujuan (`Approved`) oleh Unit Penyedia. | Constraint |
| **AC-03** | Order pada status `Draft` atau `Submitted` dapat dibatalkan oleh Pemohon menjadi `Cancelled`, namun order `Approved` tidak dapat dibatalkan sepihak. | Constraint |
| **AC-04** | Order yang ditolak Penyedia berstatus `Rejected` secara permanen dan tidak dapat diedit atau dibuka kembali. | Exception |
| **AC-05** | Pada alur pengiriman, barang berstatus `Dispatched` tidak menambah stok tersedia pada Unit Pemohon sampai berstatus `Completed`. | Correctness |
| **AC-06** | Order hanya dapat diselesaikan (`Completed`) jika fisik barang yang diterima sesuai penuh dengan yang disetujui/dikirim (*all-or-nothing*). | Constraint |
| **AC-07** | Penyelesaian mencatat bukti serah terima berupa identitas penerima atas nama Unit Pemohon dan waktu penerimaan fisik. | Completeness |
| **AC-08** | Status `Completed` mencatat perpindahan stok berpasangan (berkurang di Penyedia dan bertambah di Pemohon) tanpa mengubah total persediaan rumah sakit. | Completeness |
| **AC-09** | Pembatalan transaksi `Completed` dilakukan melalui penerbitan transaksi pembalik (*reversal*) tanpa menghapus catatan transaksi asal. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Strategi Pemilihan Stok Internal Penyedia:** Metode pengambilan fisik (FIFO/FEFO), alokasi nomor batch, dan masa kedaluwarsa (*expiry date*) di gudang Penyedia.
- **Valuasi Akuntansi & Biaya:** Penilaian harga pokok persediaan dan jurnal akuntansi biaya antar-unit (*inter-unit cost allocation*).
- **Detail Teknis Sistem:** Perintah teknis database (`MT_OUT`, `MT_IN`), skema tabel, atau sinkronisasi *legacy ledger*.
- **Pengadaan Eksternal:** Pembelian dan penerimaan barang dari pemasok/vendor luar (*Purchasing*).
- **Konsumsi Operasional:** Penggunaan langsung barang untuk pelayanan pasien (*Dispensing* farmasi atau *Pakai Barang*).
