# OUTCOME: Penjualan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-03     |
| Version     | 1.3          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Memastikan obat yang telah disetujui untuk dijual menjadi komitmen penjualan yang tercatat dan dapat dipertanggungjawabkan sampai memiliki disposisi akhir.

Melalui outcome ini, Apotek mengunci komitmen pelayanan atas permintaan obat yang sah secara terpisah per jalur penjamin, membedakan komitmen kuantitas dari komitmen penagihan, serta memastikan setiap komitmen yang terbentuk diselesaikan secara tertib.

---

## 2. Outcome Statement

Terciptanya Sales Order yang mencatat item, jumlah yang disetujui, dan jalur pembayarannya, serta memiliki disposisi akhir yang dapat dipertanggungjawabkan.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama: membentuk Sales Order dari permintaan obat yang disetujui, mencatat kuantitas komitmen (`AcceptedQty`), memisahkan jalur penjamin, menerbitkan faktur tagihan (Invoice), dan mengawal siklus komitmen hingga disposisi akhir. |
| **Tata Rekening (`TRK`)** | Kolaborator finansial: menyediakan aturan tarif dan penjaminan, serta mengonsumsi komitmen finansial Invoice ke dalam tagihan pasien. |
| **Kasir (`KSR`)** | Kolaborator pembayaran: memproses penerimaan kas/non-kas atas tagihan dan penyelesaian pembatalan kas jika terjadi koreksi resmi. |
| **Inventory (`INV`)** | Kolaborator persediaan: menyediakan master identitas obat dan informasi ketersediaan stok yang menjadi batas kuantitas komitmen. |
| **Pasien (`PAS`)** | Subjek pelayanan: menyediakan identitas pasien yang sah sebagai subjek komitmen operasional dan pihak yang bertransaksi. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-ORDER` Sales Order | Apotek | Known |
| `APT-BILL` Sales Bill / Invoice | Apotek | Known |
| `APT-TELAAH` Telaah Resep | Apotek | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- **Sales Order terbentuk:** Permintaan obat yang telah disetujui secara sah (hasil Telaah Resep atau persetujuan Jual Bebas/OTC) resmi ditransformasikan menjadi komitmen operasional Apotek yang akuntabel.
- **Item dan AcceptedQty tercatat:** Setiap baris komitmen mencatat identitas obat yang disetujui dan batas kuantitas pelayanan (`AcceptedQty`).
- **PayerPath tercatat:** Setiap Sales Order memiliki satu jalur penjamin yang homogen. Permintaan dengan campuran penjamin menghasilkan Sales Order terpisah per jalur penjamin.
- **Ketertelusuran sumber permintaan:** Sales Order dan seluruh itemnya dapat ditelusuri secara utuh ke sumber permintaan asal (resep yang disetujui atau permintaan OTC).
- **Disposisi akhir:** Sales Order memiliki disposisi akhir yang definitif (**Resolved** atau **Cancelled**).
- **Pencatatan konsekuensi finansial:** Jika Invoice diterbitkan, konsekuensi finansial tagihan tercatat secara sah dan diselesaikan sebelum disposisi akhir Sales Order.

### 5.2 Required Recorded Information

- Nomor identitas unik Sales Order.
- Tanggal dan waktu pembentukan Sales Order.
- Identitas pasien dan unit apotek yang menerbitkan komitmen.
- Jalur penjamin tunggal (`PayerPath`).
- Referensi sumber permintaan asal (nomor resep/telaah atau permintaan OTC).
- Rincian item komitmen: identitas obat, kuantitas yang disetujui (`AcceptedQty`), dan kuantitas hasil pemenuhan/penutupan.
- Status siklus hidup Sales Order saat ini dan status disposisi akhir.
- Referensi komitmen finansial/Invoice terkait (jika ada) beserta status penyelesaiannya.

### 5.3 Required Business Conditions

- Permintaan obat yang menjadi dasar Sales Order harus berstatus disetujui secara sah; item yang ditolak dilarang masuk ke Sales Order.
- Kuantitas yang disetujui (`AcceptedQty`) tidak boleh melebihi jumlah stok yang tersedia pada saat pembentukan komitmen.
- Satu Sales Order hanya memuat satu jalur penjamin (`PayerPath`).
- Komitmen finansial (Invoice) tidak boleh menagihkan kuantitas yang melebihi `AcceptedQty`.
- Sales Order tidak dapat dinyatakan mencapai disposisi akhir selama masih memiliki komitmen kuantitas atau konsekuensi finansial yang belum berstatus definitif.

### 5.4 Completion Proof

- Dokumen Sales Order tersimpan secara persisten dengan nomor unik dan terhubung ke sumber permintaan yang sah.
- Seluruh item komitmen memiliki kuantitas `AcceptedQty` yang tuntas dipertanggungjawabkan (terpenuhi atau tidak terpenuhi dengan alasan yang jelas).
- Konsekuensi finansial atas Invoice terkait (jika ada) telah memiliki disposisi penyelesaian resmi dari unit yang berwenang.
- Status Sales Order telah berada pada status disposisi akhir terminal (**Resolved** atau **Cancelled**).

---

## 6. Outcome Boundary

### Start

Ada permintaan obat yang telah disetujui untuk dijual — baik bersumber dari resep yang telah tuntas ditelaah (**OC-11-02**) maupun permintaan jual bebas (OTC) yang telah disetujui Apotek.

### End

Sales Order memiliki disposisi akhir yang dapat dipertanggungjawabkan (seluruh kuantitas komitmen dan konsekuensi finansial terkait telah tuntas diselesaikan).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Satu Sales Order = Tepat Satu PayerPath:** Satu Sales Order dilarang memuat lebih dari satu jalur penjamin.
2. **Plafon Komitmen Kuantitas:** `AcceptedQty` tidak boleh melebihi jumlah yang tersedia/disetujui. Seluruh kuantitas proses downstream dilarang melebihi `AcceptedQty`.
3. **Larangan Item Ditolak:** Sales Order tidak boleh dibuat dari item yang ditolak pada proses telaah/persetujuan.
4. **Ketertelusuran Sumber:** Sales Order tidak boleh memiliki item yang tidak dapat ditelusuri ke sumber permintaannya.
5. **Non-Empty Order Invariant:** Sales Order dilarang kosong; wajib memiliki minimal satu baris item dengan `AcceptedQty > 0`.
6. **Prasyarat Disposisi Akhir:** Sales Order dilarang ditutup ke disposisi akhir jika masih ada kuantitas komitmen yang belum jelas statusnya atau konsekuensi finansial invoice yang belum terselesaikan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Stok tersedia kurang dari kuantitas yang diminta** | Sales Order tetap dapat terbentuk sebesar kuantitas yang tersedia (`AcceptedQty <= Available Stock`), sisa kuantitas dieksklusi tanpa menggagalkan pembentukan order. |
| **Permintaan resep belum selesai ditelaah (*Under Review*)** | Sales Order tidak dapat terbentuk hingga telaah resep selesai secara sah (**OC-11-02**). |
| **Permintaan memiliki campuran jalur penjamin (*Multi-Payer*)** | Terbentuk Sales Order terpisah yang masing-masing homogen sesuai jalur penjaminnya. |
| **Pasien menolak sebagian atau seluruh obat komitmen** | Kuantitas yang tidak diambil dicatat sebagai tidak terpenuhi; Sales Order ditutup ke disposisi akhir setelah penyesuaian finansial selesai. |
| **Pembatalan Sales Order yang telah memiliki Invoice** | Pembatalan hanya dapat difinalisasi setelah konsekuensi finansial Invoice diselesaikan secara sah oleh unit Tata Rekening/Kasir. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sales Order terbentuk hanya dari permintaan obat yang telah disetujui secara sah dan dapat ditelusuri ke sumber permintaan asalnya. | Completeness |
| **AC-02** | Item yang ditolak pada telaah resep tidak dapat dimasukkan ke dalam Sales Order. | Constraint |
| **AC-03** | Setiap Sales Order mencatat item, `AcceptedQty` yang tidak melebihi kuantitas tersedia/disetujui, dan tepat satu jalur penjamin (`PayerPath`). | Correctness |
| **AC-04** | Permintaan dengan multi-penjamin menghasilkan Sales Order terpisah yang homogen untuk masing-masing jalur penjamin. | Completeness |
| **AC-05** | Jika diterbitkan Invoice, kuantitas tagihan tidak melebihi `AcceptedQty` dan konsekuensi finansialnya tercatat secara sah. | Correctness |
| **AC-06** | Sales Order mencapai disposisi akhir terminal (Resolved atau Cancelled) dengan seluruh kuantitas komitmen dan konsekuensi finansial terselesaikan secara akuntabel. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Telaah Klinis & Pengkajian Resep Dokter:** Pemeriksaan dosis, interaksi obat, dan persetujuan substitusi obat → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Penyiapan & Peracikan Fisik Obat:** Pengambilan obat dari rak, peracikan puyer/kapsul/salep, dan pengemasan fisik → **OC-11-04 Dispensing** (`APT-DISPENSING`).
- **Penyerahan Obat & Edukasi Pasien:** Penyerahan fisik obat kepada pasien dan pemberian edukasi/KIE obat → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Penerimaan Pembayaran Kasir & Refund:** Penerimaan uang tunai/non-tunai, pencetakan kuitansi kasir, dan pengembalian uang → domain **Kasir** dan **Tata Rekening**.
- **Pencatatan Kartu Stok & Gudang Persediaan:** Pengurangan saldo kartu stok farmasi, stok opname, dan mutasi barang gudang → **Inventory Domain** (`INV-STOK`, `INV-OPNAME`, `INV-MUTASI`).
- **Detail Teknis dan Prosedur Operasional:** Skema tabel database, endpoint API, rancangan antarmuka layar (UI/wireframe), dan SOP operasional staf.
