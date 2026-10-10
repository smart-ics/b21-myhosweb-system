# OUTCOME: Purchase Request (PurchaseReq)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-PUR-PURCHASE-REQ    |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Pengadaan barang di rumah sakit memerlukan konsolidasi kebutuhan menyeluruh dan pengawasan anggaran yang ketat agar belanja operasional tetap efisien, terencana, dan tidak melampaui pagu anggaran rumah sakit.

Bagian Purchasing mengumpulkan seluruh permintaan material unit operasional yang telah disetujui (Material Request), mengintegrasikan hasil perkiraan kebutuhan (Procurement Forecasting), serta memperhitungkan kebutuhan stok penyangga (buffer stock) gudang utama. Kebutuhan-kebutuhan tersebut dikompilasi menjadi satu dokumen resmi **Purchase Request** per kelompok anggaran/pengadaan.

Purchase Request berfungsi sebagai dokumen justifikasi kebutuhan dan otorisasi anggaran sebelum rumah sakit membuat komitmen kontraktual kepada pemasok eksternal. Melalui Purchase Request, Departemen Keuangan dapat mengevaluasi kepatutan belanja terhadap ketersediaan dana rumah sakit.

Tanpa Purchase Request yang sah dan disetujui secara finansial, Bagian Purchasing tidak memiliki wewenang untuk menerbitkan pesanan pembelian (Purchase Order) kepada supplier.

---

## 2. Outcome Statement

Permintaan pengadaan barang rumah sakit untuk kelompok pengadaan dan periode tertentu (memuat kuantitas agregat dan estimasi nilai pembiayaan) **telah dikompilasi oleh Bagian Purchasing, disetujui oleh Departemen Keuangan (dan Direksi jika berlaku), serta berstatus sah untuk diterbitkan menjadi Purchase Order**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Purchasing | Pemilik utama: mengompilasi kebutuhan barang rumah sakit, memelihara estimasi biaya, dan mengelola dokumen Purchase Request hingga siap diterbitkan menjadi PO |

> *Catatan Tata Kelola: Otorisasi persetujuan oleh Departemen Keuangan (Finance Department Approval) bertindak sebagai gerbang kendali finansial (financial authorization gate) yang diintegrasikan dalam siklus persetujuan dokumen Purchase Request.*

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `PUR-PURREQ` Purchase Request | Purchasing | Known |
| `PUR-MATREQ` Material Request | Purchasing | Known |
| `PUR-FORECAST` Procurement Forecasting | Purchasing | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Purchase Request tercatat secara persisten dalam sistem dengan nomor referensi unik.
- Dokumen Purchase Request merujuk pada kelompok pengadaan/anggaran tertentu yang terpisah (misal: PR Farmasi/Medis atau PR Logistik Umum/Non-Medis).
- Seluruh kebutuhan yang dikonsolidasikan memiliki asal usul yang dapat ditelusuri (berasal dari Material Request yang telah disetujui, kalkulasi Forecasting, atau kebutuhan buffer stock gudang).
- Setiap item barang memiliki kuantitas agregat definitif dan estimasi harga/biaya nominal pengadaan.
- Persetujuan resmi dari Departemen Keuangan (dan Direksi bila nilai melebihi batas kewenangan tertentu) tercatat persisten.
- Status Purchase Request dapat dibedakan secara tegas: **Draf Pengajuan**, **Menunggu Persetujuan Keuangan**, **Disetujui (Approved)**, **Ditolak (Rejected)**, **Sebagian Dipesan (Partially Ordered)**, **Selesai Dipesan (Fully Ordered)**, atau **Dibatalkan**.

### 5.2 Required Recorded Information

- Nomor referensi unik Purchase Request (format standar PR per kelompok pengadaan dan periode).
- Kelompok pengadaan/anggaran (Medis/Farmasi, Logistik Umum/Non-Medis, Gizi, dll.).
- Periode kebutuhan / siklus pengadaan.
- Sumber kebutuhan yang dikonsolidasikan (daftar referensi Material Request, referensi dokumen Forecasting, atau catatan kebutuhan penyangga gudang).
- Tanggal & waktu pengajuan oleh Purchasing.
- Identitas staf / pejabat Purchasing penanggung jawab pengajuan.
- Total estimasi nilai pengadaan (Total Estimated Budget).
- Tanggal & waktu persetujuan/penolakan oleh Departemen Keuangan.
- Identitas pejabat Keuangan (dan Direksi jika berlaku) yang menandatangani/mengesahkan.
- Catatan / justifikasi persetujuan atau alasan penolakan.
- Daftar rincian barang yang diajukan:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang.
  - Kuantitas agregat yang diajukan.
  - Estimasi harga satuan acuan (berdasarkan harga pembelian terakhir atau HPS).
  - Total estimasi biaya per item (\(\text{Kuantitas} \times \text{Estimasi Harga}\)).
  - Kuantitas yang telah diterbitkan menjadi Purchase Order (`Ordered Qty`).
  - Sisa kuantitas yang belum dibuatkan PO.
- Status Purchase Request.

### 5.3 Required Business Conditions

- Seluruh dokumen Material Request yang ditarik ke dalam PR harus berstatus **Disetujui Unit (Approved by Unit)**.
- Dokumen PR harus terpisah berdasarkan kelompok pengadaan/anggaran; tidak menggabungkan anggaran medis dan non-medis dalam satu dokumen PR.
- Kuantitas dan estimasi nilai nominal per item harus bernilai positif (\(> 0\)).
- Departemen Keuangan **tidak melakukan pemotongan atau pengeditan sepihak atas kuantitas per baris item**. Jika anggaran tidak mencukupi, Keuangan **menolak (Reject)** seluruh dokumen PR disertai catatan alasan, agar Purchasing menyusun ulang pengajuan dengan penyesuaian kuantitas/prioritas baru.
- Satu dokumen PR yang telah berstatus *Approved* dapat ditransformasikan menjadi satu atau beberapa Purchase Order (PO) berdasarkan pengelompokan pemasok/supplier.
- PR yang telah berstatus *Approved* terkunci secara permanen dari pengeditan langsung oleh Purchasing.

### 5.4 Completion Proof

- Dokumen Purchase Request tersimpan secara persisten dengan nomor referensi unik.
- Status dokumen bernilai **Disetujui (Approved)** oleh Departemen Keuangan (dan Direksi jika berlaku).
- Dokumen tersedia dalam antrean pemrosesan Bagian Purchasing untuk pemilahan rekanan dan penerbitan Purchase Order (`PUR-PO`).

---

## 6. Outcome Boundary

### Start

Dimulai ketika Bagian Purchasing menginisiasi kompilasi kebutuhan (dari Material Request yang telah disetujui, estimasi Forecasting, dan/atau kebutuhan buffer stock gudang) ke dalam draf Purchase Request untuk kelompok komoditas tertentu, lengkap dengan estimasi harga satuan dan total nominal anggaran.

### End

Berakhir ketika dokumen Purchase Request secara resmi disetujui oleh Departemen Keuangan (dan Direksi bila melampaui batas nilai kewenangan) dengan status **Approved**, sehingga dokumen tersebut sah dan terotorisasi untuk dikelompokkan ke supplier dalam penerbitan Purchase Order (`PUR-PO`).

---

## 7. Business Constraints

1. **Procurement Stream Segregation**: Dokumen PR harus dipisahkan berdasarkan kelompok anggaran/pengadaan (PR Medis/Farmasi terpisah dari PR Logistik Umum/Non-Medis).
2. **Mandatory Valuation**: Setiap baris item dalam PR wajib mencantumkan estimasi harga satuan acuan dan estimasi total nominal biaya guna memungkinkan evaluasi pagu anggaran.
3. **Binary Approval Decision by Finance**: Bagian Keuangan tidak diperkenankan mengubah atau memotong kuantitas item dalam PR. Keuangan hanya dapat menyetujui penuh (*Approve*) atau menolak (*Reject*) seluruh dokumen PR.
4. **Immutability of Approved PR**: Dokumen PR yang telah berstatus *Approved* tidak dapat diedit atau diubah item dan kuantitasnya oleh Purchasing.
5. **Traceability to Material Request & Forecast**: Kuantitas yang diajukan dalam PR harus dapat diaudit asal-usulnya ke Material Request atau dokumen estimasi Forecasting yang mendasarinya.
6. **One-to-Many Transformation to PO**: Satu dokumen PR yang disetujui dapat ditransformasikan menjadi beberapa dokumen Purchase Order sesuai pengelompokan rekanan/supplier, dengan pemeliharaan akumulasi kuantitas yang telah dipesan (`Ordered Qty`).

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Pagu anggaran rumah sakit tidak mencukupi | Departemen Keuangan menolak (*Reject*) seluruh PR dengan catatan kendala anggaran. Purchasing harus menyusun draf pengajuan ulang dengan kuantitas yang disesuaikan. |
| Material Request belum berstatus Approved | Sistem menolak pengikutsertaan Material Request tersebut ke dalam kompilasi PR sampai ada persetujuan sah dari Kepala Unit. |
| Harga acuan/HPS belum tersedia di sistem | Sistem mewajibkan Purchasing melengkapi estimasi harga satuan sebelum dokumen PR dapat diajukan ke Bagian Keuangan. |
| Pembatalan kebutuhan setelah PR Approved | Jika ada pembatalan pengadaan sebelum PO diterbitkan, pembatalan harus melalui persetujuan pembatalan formal (*Void/Cancel*) dengan notifikasi ke Bagian Keuangan. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Bagian Purchasing dapat mengompilasi kebutuhan dari berbagai Material Request yang telah berstatus *Approved*, hasil Forecasting, dan kebutuhan buffer stock ke dalam draf Purchase Request. | Completeness |
| AC-02 | Dokumen PR terbit secara terpisah sesuai kelompok pengadaan/anggaran (Medis vs Non-Medis) dengan rincian kuantitas agregat dan estimasi nominal biaya. | Correctness |
| AC-03 | Persetujuan oleh Departemen Keuangan berhasil mencatatkan otorisasi finansial, mengubah status dokumen menjadi *Approved*, dan membuka akses pembentukan Purchase Order. | Completeness |
| AC-04 | Penolakan oleh Departemen Keuangan (*Reject*) mencatatkan alasan penolakan dan mengunci dokumen dari pembuatan Purchase Order. | Exception |
| AC-05 | Sistem mencegah pengeditan kuantitas atau penambahan item baru pada dokumen PR yang telah berstatus *Approved*. | Constraint |
| AC-06 | Sistem mendukung pemecahan satu PR *Approved* menjadi beberapa Purchase Order per supplier serta memantau status pemenuhan (*Partially Ordered* hingga *Fully Ordered*). | Completeness |

---

## 10. Out of Scope

- **Pengajuan Kebutuhan Lokal Unit**: Pencatatan kebutuhan operasional berkala di tingkat ruangan/unit pelayanan merupakan tanggung jawab `Material Request` (`PUR-MATREQ`).
- **Komitmen Legal & Pemesanan Supplier**: Negosiasi harga final, pemilihan rekanan resmi, dan penerbitan pesanan pembelian ke pemasok merupakan tanggung jawab `Purchase Order` (`PUR-PO`).
- **Penerimaan Barang Fisik**: Pemeriksaan fisik barang yang dikirim oleh supplier merupakan tanggung jawab `TerimaBrg` (`PUR-DO`).
- **Pencatatan Hutang & Pembayaran**: Penagihan faktur rekanan, pembukuan akuntansi, dan pengeluaran kas/bank untuk pelunasan berada di luar cakupan Purchasing.
