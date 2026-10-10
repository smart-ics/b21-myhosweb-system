# OUTCOME: Pemakaian Barang Operasional (PakaiBrg)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-PAKAI-BRG       |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Dalam operasional rumah sakit sehari-hari, unit pelayanan klinis (seperti Rawat Inap, Rawat Jalan, IGD, ICU, Kamar Operasi, Laboratorium) maupun unit pendukung/non-klinis (seperti Administrasi, Rekam Medis, Keuangan, Sanitasi) secara rutin mengonsumsi barang persediaan logistik yang digunakan bersama untuk kepentingan operasional tanpa diatribusikan ke satu pasien tertentu (contoh: Betadine 1 liter, alkohol 70%, hand rub desinfektan, kassa gulung bersama, reagen kontrol lab, atau kertas formulir dan alat tulis kantor).

Untuk menjamin akurasi saldo persediaan perpetual dan akuntabilitas pembiayaan operasional rumah sakit, setiap konsumsi barang operasional unit harus dicatat secara persisten sebagai transaksi pemakaian barang (*Inventory Consumption*). Transaksi ini memotong persediaan fisik pada lokasi stok unit pengguna dan membebankan nilai perolehan barang (HPP) sebagai biaya operasional unit kerja bersangkutan (*Cost Center*).

Tanpa pencatatan pemakaian barang yang definitif, saldo persediaan *floor stock* di unit kerja akan mengalami selisih tidak terjelaskan (*unaccounted shrinkage*), manajemen rumah sakit kehilangan ketertelusuran atas konsumsi barang habis pakai, dan laporan akuntansi biaya tidak dapat mengidentifikasi efisiensi serta beban pengeluaran riil per unit kerja.

---

## 2. Outcome Statement

Pengurangan persediaan fisik barang operasional pada lokasi unit kerja (mencakup rincian item, nomor batch/lot dan tanggal kedaluwarsa untuk komoditas medis, kuantitas konsumsi, dan valuasi harga pokok perolehan) **telah disahkan, saldo stok fisik pada lokasi unit telah dipotong, dan nilai nominal beban biaya pemakaian tercatat secara persisten sebagai beban operasional unit pengguna (Cost Center)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** | Pemilik utama: mencatat transaksi pemakaian barang operasional (`INV-PAKAI`), memverifikasi ketersediaan dan memotong saldo stok fisik unit (`INV-STOK`), serta memvalidasi katalog master barang dan harga pokok perolehan (`INV-MASTER`). |
| **Organisasi** | Menyediakan struktur organisasi unit kerja pemakai/penanggung beban biaya dan lokasi persediaan *floor stock* unit yang sah dan aktif (`ORG-LAYANAN`), serta data staf/petugas yang mencatat pemakaian (`ORG-PPA`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-PAKAI` Pakai Barang | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Tenaga Medis / Petugas | Organisasi | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen transaksi pemakaian barang operasional (*Inventory Consumption Record*) telah tercatat secara persisten dengan nomor transaksi unik.
- Unit kerja pemakai teridentifikasi dan bertindak sebagai lokasi persediaan sumber (*floor stock*) sekaligus unit penanggung beban biaya (*Cost Center*).
- Saldo fisik persediaan pada lokasi unit telah berkurang tepat sejumlah kuantitas pemakaian yang disahkan.
- Nilai nominal rupiah beban pemakaian barang (kuantitas × HPP/unit cost) terhitung dan dibekukan (*locked*) pada saat dokumen disahkan.
- Transaksi murni bersifat konsumsi operasional internal unit tanpa pencatatan identitas pasien dan tanpa penagihan ke akun pasien (`TRK-BILLING`).
- Status dokumen pemakaian barang berada pada siklus hidup yang valid: **Draft**, **Disahkan (Posted)**, atau **Dibatalkan (Void/Cancelled)**.

### 5.2 Required Recorded Information

- Nomor transaksi unik pemakaian barang (format penomoran standar dokumen pemakaian unit).
- Identitas unit kerja pengguna / penanggung beban biaya (ID unit dan nama unit kerja).
- Identitas lokasi persediaan unit (ID lokasi/depo *floor stock* tempat stok dipotong).
- Tanggal dan waktu pengesahan pemakaian barang.
- Identitas staf/petugas persediaan/layanan yang mencatat pemakaian (*recorded by*).
- Catatan keterangan bebas keperluan pemakaian barang (misal: "Keperluan tindakan perawatan luka bangsal", "Operasional desinfeksi poli", "Formulir pendaftaran loket").
- Total nilai nominal rupiah beban operasional pemakaian dokumen.
- Rincian item barang yang dipakai:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang (*Unit of Measure*).
  - Kuantitas yang dipakai (`Qty Pakai`) — bernilai \(\gt 0\).
  - Nomor Batch / Lot (wajib untuk komoditas medis/farmasi).
  - Tanggal Kedaluwarsa / *Expired Date* (wajib untuk komoditas medis/farmasi).
  - Harga Pokok Perolehan satuan (HPP / *unit cost*) pada saat transaksi disahkan.
  - Subtotal nilai beban biaya per item (\(\text{Qty} \times \text{HPP}\)).
  - Saldo stok unit sebelum dan sesudah pemakaian (audit trail saldo).
- Status dokumen pemakaian (`Draft`, `Posted`, `Void`).
- Riwayat audit pembatalan (waktu pembatalan, alasan pembatalan, dan identitas staf pengesah pembatalan — jika berstatus `Void`).

### 5.3 Required Business Conditions

- Unit kerja pemakai dan lokasi persediaan harus terdaftar aktif dalam `ORG-LAYANAN`.
- **Aturan Lokasi Tunggal (Intra-Unit Storage)**: Lokasi persediaan sumber pemotongan stok harus merupakan lokasi *floor stock* milik unit pengguna itu sendiri. Pengambilan barang dari unit/gudang lain harus diselesaikan terlebih dahulu melalui siklus mutasi persediaan (`ReqMutasi` → `Mutasi` → `TerimaMutasi`).
- Kuantitas pemakaian (`Qty Pakai`) tidak boleh melebihi saldo persediaan fisik yang tersedia di lokasi unit (\(\text{Qty Pakai} \le \text{Saldo Fisik Unit}\)). Dilarang keras menghasilkan saldo fisik bernilai negatif.
- Pengeluaran komoditas medis/farmasi wajib mematuhi penelusuran batch dan prinsip FEFO (*First Expired, First Out*) / FIFO (*First In, First Out*).
- Nilai HPP/unit cost perolehan barang harus bernilai non-negatif (\(\ge 0\)).
- Nilai nominal beban biaya operasional dibekukan permanen saat dokumen disahkan untuk menjamin konsistensi pelaporan akuntansi biaya.

### 5.4 Completion Proof

- Dokumen pemakaian barang operasional tersimpan secara persisten dengan nomor transaksi unik.
- Status dokumen bernilai **Disahkan (Posted)**.
- Saldo fisik persediaan di lokasi unit berkurang sebesar `Qty Pakai` dan tercatat dalam kartu stok/buku pembantu unit bersangkutan.
- Rincian beban biaya operasional unit (kuantitas × HPP) teralokasi secara persisten untuk kebutuhan pelaporan akuntansi biaya per unit (*Cost Center*).

---

## 6. Outcome Boundary

### Start

Dimulai ketika staf/petugas unit kerja membuka transaksi pemakaian barang operasional baru, memilih unit/lokasi *floor stock* persediaan miliknya, serta menentukan barang yang telah/akan digunakan.

### End

Berakhir ketika transaksi pemakaian barang operasional disahkan (*posted*): saldo stok fisik di lokasi unit resmi terpotong, nilai nominal beban pemakaian dibekukan, dan dokumen pemakaian berstatus `Posted`.

---

## 7. Business Constraints

1. **Non-Patient Operational Burden Invariant**: Pemakaian barang operasional murni dialokasikan sebagai beban operasional unit (*Cost Center*). Dokumen tidak mencatat identitas pasien dan tidak pernah menghasilkan penagihan finansial kepada pasien (`TRK-BILLING`).
2. **Strict Intra-Unit Consumption**: Unit pengguna hanya dapat mencatat pemakaian dari saldo stok yang berada pada lokasi persediaan unit itu sendiri. Pemakaian langsung lintas gudang tanpa proses mutasi dilarang.
3. **No Negative Stock**: Transaksi pemakaian ditolak jika kuantitas pemakaian melebihi saldo fisik tersedia di lokasi unit.
4. **Cost Valuation Freezing**: Nilai rupiah beban operasional (HPP × kuantitas) dibekukan pada saat dokumen disahkan untuk mencegah perubahan nilai historis biaya saat terjadi fluktuasi harga pengadaan di kemudian hari.
5. **Traceability of Medical Items**: Setiap pemakaian komoditas medis/farmasi wajib mencantumkan nomor batch/lot dan tanggal kedaluwarsa yang valid.
6. **Authorized Void / Reversal**: Pembatalan dokumen yang telah disahkan (*Void*) hanya dapat dilakukan dengan otorisasi khusus dan alasan pembatalan terdokumentasi, yang secara otomatis memulihkan saldo stok fisik ke unit dan menganulir alokasi beban biaya operasional.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Saldo persediaan fisik di lokasi unit tidak mencukupi (\(\text{Qty Pakai} \gt \text{Saldo Fisik}\)) | Sistem menolak pengesahan transaksi pemakaian barang; unit diarahkan untuk mengajukan permintaan mutasi (`ReqMutasi`) ke gudang utama atau melakukan stok opname jika terjadi selisih fisik. |
| Komoditas medis/farmasi dicatat tanpa nomor batch atau tanggal kedaluwarsa | Sistem menolak pengesahan dokumen hingga data nomor batch dan tanggal kedaluwarsa dilengkapi sesuai aturan ketertelusuran farmasi. |
| Terjadi kesalahan pencatatan pemakaian pada dokumen yang telah disahkan (`Posted`) | Staf berwenang melakukan pembatalan dokumen (*Void*) dengan menyertakan alasan pembatalan; sistem mengembalikan saldo fisik stok ke unit dan membatalkan beban biaya. Koreksi dilakukan dengan menerbitkan dokumen pemakaian baru yang benar. |
| Periode pembukuan/akuntansi telah ditutup saat hendak melakukan pembatalan (*Void*) | Sistem menolak pembatalan dokumen pemakaian pada periode tertutup; penyesuaian wajib diselesaikan melalui transaksi penyesuaian persediaan/stok opname pada periode berjalan. |
| Komoditas barang tidak terdaftar aktif dalam master barang (`INV-MASTER`) | Sistem menolak penambahan item ke dalam dokumen pemakaian barang. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem berhasil menerbitkan dokumen pemakaian barang operasional dengan nomor unik, mencatat identitas unit, tanggal, petugas, catatan keperluan pemakaian, rincian barang, kuantitas, dan nilai nominal beban biaya (HPP). | Completeness |
| AC-02 | Pengesahan dokumen pemakaian memotong saldo fisik persediaan di lokasi unit secara tepat dan seketika pada kartu stok unit. | Correctness |
| AC-03 | Sistem menolak pengesahan pemakaian jika kuantitas pakai melebihi saldo persediaan fisik yang tersedia di lokasi unit (mencegah stok negatif). | Constraint |
| AC-04 | Sistem mewajibkan pencatatan nomor batch dan tanggal kedaluwarsa untuk komoditas medis/farmasi dan menolak pengesahan jika data tersebut tidak diisi. | Constraint |
| AC-05 | Nilai nominal rupiah beban biaya (HPP × kuantitas) dibekukan pada saat transaksi berstatus `Posted` dan teralokasi ke unit pengguna (*Cost Center*). | Correctness |
| AC-06 | Dokumen pemakaian tidak mencatat identitas pasien dan tidak menghasilkan pembebanan tagihan ke domain Tata Rekening (`TRK-BILLING`). | Constraint |
| AC-07 | Pembatalan dokumen berstatus `Posted` (*Void*) dengan otorisasi sah berhasil mengembalikan saldo fisik persediaan ke unit dan mengubah status dokumen menjadi `Void`. | Exception |

---

## 10. Out of Scope

- **Penagihan Obat & BMHP Pasien**: Pemakaian obat atau bahan medis yang diperuntukkan bagi pasien perorangan merupakan tanggung jawab siklus resep/dispensing (`OrderDispensing` di Domain Apotek), penjualan apotek (`Penjualan` di Domain Apotek), atau pembebanan tindakan (`Tindakan` di Domain Tata Rekening).
- **Perpindahan Persediaan Antar-Lokasi**: Mutasi barang dari gudang utama ke depo/unit kerja merupakan tanggung jawab siklus tiga tahap Mutasi (`ReqMutasi`, `Mutasi`, `TerimaMutasi`).
- **Pemusnahan Barang Rusak/Kedaluwarsa**: Pencatatan barang yang kedaluwarsa, rusak, atau dimusnahkan merupakan tanggung jawab kapabilitas `INV-MUSNAH`.
- **Rekonsiliasi Fisik Berkala**: Penghitungan fisik dan penyesuaian selisih stok secara periodik di unit merupakan tanggung jawab Outcome `StokOpname` (`INV-OPNAME`).
- **Jurnal Akuntansi Buku Besar Keuangan**: Pembukuan jurnal umum debit/kredit ke buku besar akuntansi rumah sakit merupakan tanggung jawab domain Akuntansi Keuangan (*General Ledger*).
