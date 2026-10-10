# OUTCOME: Pengeluaran Mutasi Stok (Mutasi)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-MUTASI          |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Dalam operasional rumah sakit sehari-hari, barang logistik medis (obat, bahan medis habis pakai/BMHP, vaksin, cairan infus) dan barang umum/non-medis (alat tulis kantor, linen, bahan pembersih) harus dipindahkan secara terkontrol antar-lokasi persediaan—seperti dari Gudang Utama ke Depo Farmasi/Unit Layanan (sebagai *floor stock*), antar-depo layanan, maupun pengembalian stok berlebih dari unit ke gudang utama.

Untuk menjamin akuntabilitas persediaan fisik dan mencegah hilangnya barang tanpa jejak, setiap pengeluaran fisik barang dari suatu lokasi penyimpanan harus dicatat secara persisten sebagai transaksi pengeluaran stok (*Stock Dispatch*). Transaksi ini memotong persediaan fisik di unit asal dan mencatat barang berstatus "Dalam Perjalanan" (*In-Transit*), baik dipicu atas dasar permintaan dari unit tujuan (*ReqMutasi*) maupun didorong langsung atas inisiatif unit asal (*Direct Mutation*).

Tanpa pencatatan pengeluaran mutasi yang definitif dan independen, rumah sakit tidak dapat mempertanggungjawabkan perbedaan saldo barang yang telah keluar dari gudang asal tetapi belum sampai atau belum diverifikasi di unit tujuan, sehingga berisiko menimbulkan perselisihan stok, kebocoran logistik, dan kekaburan status tanggung jawab barang.

---

## 2. Outcome Statement

Pengeluaran fisik barang dari lokasi persediaan asal menuju lokasi tujuan (mencakup rincian item, nomor batch/lot, tanggal kedaluwarsa untuk komoditas tertelusur, dan kuantitas kirim) **telah disahkan, saldo stok fisik unit asal telah dipotong, dan kiriman tercatat berstatus Dalam Perjalanan (In-Transit) serta tersedia dalam antrean penerimaan unit tujuan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** | Pemilik utama: mencatat transaksi pengeluaran mutasi (`INV-MUTASI`), memverifikasi dan memotong saldo stok unit asal (`INV-STOK`), serta memvalidasi katalog master barang (`INV-MASTER`). |
| **Organisasi** | Menyediakan data struktur unit kerja dan lokasi gudang/depo persediaan yang aktif dan sah (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> *Catatan: Jika mutasi dipicu oleh permintaan unit tujuan, dokumen ini membaca nomor referensi dan kuantitas dari Outcome `ReqMutasi` (`INV-MUTASI` Tahap 1) untuk keperluan pemenuhan permintaan.*

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen pengeluaran mutasi stok (*Stock Dispatch*) telah tercatat secara persisten dengan nomor registrasi unik.
- Asal mutasi teridentifikasi dengan jelas melalui dua moda inisiasi:
  - **Inisiasi ReqMutasi**: Merujuk pada dokumen `ReqMutasi` resmi yang disetujui, dengan pemenuhan kuantitas dapat bernilai penuh (*full*) atau sebagian (*partial*) sesuai ketersediaan stok fisik di unit asal.
  - **Inisiasi Direct Mutation**: Diterbitkan langsung oleh unit asal tanpa referensi `ReqMutasi` (alokasi langsung / *push distribution*).
- Saldo fisik persediaan pada lokasi asal telah berkurang tepat sejumlah kuantitas yang dikeluarkan (`Qty Kirim`).
- Barang yang dikeluarkan berstatus **Dalam Perjalanan (*In-Transit*)** dan belum menambah saldo fisik persediaan di lokasi tujuan hingga Outcome `TerimaMutasi` disahkan.
- Status dokumen mutasi berada pada status operasional yang valid: **Draft**, **Terkirim (In-Transit)**, **Diterima (Received)**, **Diterima dengan Selisih (Received with Discrepancy)**, atau **Dibatalkan (Cancelled)**.

### 5.2 Required Recorded Information

- Nomor transaksi unik pengeluaran mutasi (format penomoran standar mutasi gudang).
- Jenis inisiasi mutasi (`Berdasarkan ReqMutasi` atau `Direct Mutation`).
- Nomor referensi `ReqMutasi` (wajib terisi jika jenis inisiasi berdasarkan permintaan).
- Identitas lokasi persediaan asal (ID unit/gudang dan nama unit, misal: Gudang Farmasi Pusat, Depo Rawat Inap).
- Identitas lokasi persediaan tujuan (ID unit/gudang dan nama unit, misal: Depo IGD, Bangsal Mawar, Gudang Farmasi Pusat).
- Tanggal dan waktu pengesahan pengeluaran/pengiriman barang.
- Identitas staf/petugas persediaan yang mengeluarkan barang (*issuer*).
- Catatan pengiriman/keterangan mutasi (opsional).
- Rincian item barang yang dimutasi:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang (*Unit of Measure*).
  - Kuantitas yang dikirim (`Qty Kirim`) — bernilai \(\gt 0\).
  - Nomor Batch / Lot (wajib untuk barang medis/farmasi).
  - Tanggal Kedaluwarsa / *Expired Date* (wajib untuk barang medis/farmasi).
  - Saldo stok unit asal sebelum dan sesudah mutasi (audit trail).
- Status dokumen mutasi.

### 5.3 Required Business Conditions

- Lokasi persediaan asal dan lokasi persediaan tujuan harus terdaftar aktif dalam `ORG-LAYANAN` dan **tidak boleh identik** (Lokasi Asal \(\ne\) Lokasi Tujuan).
- Seluruh pergerakan antar-lokasi persediaan yang sah didukung:
  1. Gudang Utama ke Depo / Unit Layanan.
  2. Antar-Depo / Antar-Unit Layanan (*inter-unit transfer*).
  3. Pengembalian dari Unit Layanan / Depo ke Gudang Utama (*internal stock return*).
- Kuantitas pengeluaran (`Qty Kirim`) tidak boleh melebihi saldo persediaan fisik yang tersedia di lokasi asal (\(\text{Qty Kirim} \le \text{Saldo Fisik Asal}\)). Dilarang keras menghasilkan saldo fisik bernilai negatif.
- Pengeluaran barang farmasi/medis wajib mematuhi aturan penelusuran batch dan prinsip FEFO (*First Expired, First Out*) / FIFO (*First In, First Out*).
- Komoditas barang yang dimutasi harus sesuai dengan kewenangan penanganan lokasi gudang asal (misal: Gudang Farmasi hanya memutasikan komoditas farmasi/alkes, Gudang Umum hanya memutasikan logistik umum).
- Apabila mengacu pada `ReqMutasi`:
  - `Qty Kirim` tidak boleh melebihi sisa kuantitas permintaan yang belum terpenuhi pada dokumen `ReqMutasi` tersebut.
  - Pemenuhan parsial mencatat sisa *backorder* pada `ReqMutasi` untuk pemenuhan berikutnya (atau ditutup sesuai kesepakatan unit).

### 5.4 Completion Proof

- Dokumen Mutasi tersimpan secara persisten dengan nomor transaksi unik.
- Status dokumen bernilai **Terkirim (In-Transit)**.
- Saldo fisik persediaan di lokasi asal berkurang sebesar `Qty Kirim` dan tercatat dalam buku pembantu/kartu stok lokasi asal.
- Dokumen mutasi tampil dan tersedia secara *real-time* pada antrean penerimaan (*TerimaMutasi*) di lokasi tujuan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas di lokasi persediaan asal membuat transaksi pengeluaran barang—baik dengan memilih dokumen `ReqMutasi` yang telah disetujui unit pemohon dari daftar antrean pemenuhan, atau dengan membuka formulir pengeluaran langsung (*Direct Mutation*).

### End

Berakhir ketika transaksi pengeluaran resmi disahkan (*posted/dispatched*): saldo fisik di lokasi asal resmi terpotong, barang berstatus dalam perjalanan (*In-Transit*), dan dokumen mutasi terbit serta siap diverifikasi dan diterima oleh unit tujuan melalui siklus `TerimaMutasi`.

> *Catatan: Pembaruan status dokumen mutasi menjadi `Received` (Diterima) atau `Received with Discrepancy` (Diterima dengan Selisih) merupakan efek dari eksekusi Outcome downstream `TerimaMutasi`.*

---

## 7. Business Constraints

1. **Strict Three-Stage Invariant**: Pengeluaran mutasi (`Mutasi`) merupakan fakta fisik terpisah dari permintaan (`ReqMutasi`) dan penerimaan (`TerimaMutasi`). Pembuatan dokumen Mutasi tidak boleh secara otomatis menambah saldo fisik di lokasi tujuan.
2. **Immediate Source Balance Deduction**: Pada detik transaksi mutasi disahkan, saldo fisik di unit asal harus langsung berkurang untuk mencegah barang yang sama dialokasikan ke transaksi lain.
3. **No Negative Stock**: Transaksi pengeluaran mutasi ditolak jika kuantitas kirim melebihi stok fisik tersedia di lokasi asal.
4. **Permanent Dispatched Quantity**: Nilai `Qty Kirim` pada dokumen Mutasi bersifat permanen dan tidak dapat diubah setelah dokumen disahkan, guna mencatat fakta historis apa yang secara aktual dikeluarkan oleh unit asal.
5. **Conditional Cancellation**: Pembatalan dokumen mutasi hanya diizinkan selama kiriman masih berstatus *In-Transit* (belum diproses atau disahkan oleh dokumen `TerimaMutasi` di unit tujuan). Pembatalan otomatis mengembalikan saldo fisik ke lokasi asal.
6. **Immutability upon Receipt**: Dokumen Mutasi yang telah memiliki relasi transaksi `TerimaMutasi` di unit tujuan terkunci mutlak (*immutable*). Segala bentuk pengembalian fisik setelah penerimaan wajib diselesaikan melalui dokumen mutasi balik baru.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Stok fisik di lokasi asal tidak mencukupi untuk memenuhi kuantitas `ReqMutasi` | Petugas diperbolehkan mengeluarkan kuantitas yang tersedia (pemenuhan parsial) atau menunda hingga stok tersedia; sistem menolak pengeluaran yang melebihi saldo riil. |
| Pengiriman barang dibatalkan sebelum diterima unit tujuan | Petugas unit asal melakukan pembatalan dokumen mutasi dengan mencantumkan alasan pembatalan; status berubah menjadi `Cancelled` dan saldo fisik barang otomatis dikembalikan ke lokasi asal. |
| Lokasi asal dan lokasi tujuan sama | Sistem menolak pembuatan mutasi karena perpindahan persediaan internal pada lokasi yang sama bukan merupakan transaksi mutasi antar-unit. |
| Barang medis dikeluarkan tanpa nomor batch atau tanggal kedaluwarsa | Sistem menolak pengesahan mutasi hingga atribut batch dan *expired date* dilengkapi sesuai aturan ketertelusuran farmasi. |
| Unit tujuan telah mengonfirmasi penerimaan (`TerimaMutasi`) saat unit asal hendak membatalkan | Sistem menolak pembatalan dokumen mutasi; unit asal diarahkan untuk berkoordinasi agar unit tujuan menerbitkan mutasi retur/balik. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem berhasil menerbitkan dokumen pengeluaran mutasi dengan nomor unik, mencatat lokasi asal, lokasi tujuan, rincian barang, nomor batch/ED (untuk barang medis), dan `Qty Kirim`. | Completeness |
| AC-02 | Pengesahan dokumen mutasi memotong saldo fisik persediaan di lokasi asal secara tepat dan seketika tanpa menambah saldo fisik lokasi tujuan. | Correctness |
| AC-03 | Dokumen mutasi yang disahkan berstatus `In-Transit` dan langsung muncul pada antrean penerimaan barang di lokasi tujuan untuk diproses oleh `TerimaMutasi`. | Completeness |
| AC-04 | Sistem menolak transaksi pengeluaran mutasi jika `Qty Kirim` melebihi saldo fisik tersedia di lokasi asal (mencegah stok minus). | Constraint |
| AC-05 | Sistem mendukung pemenuhan penuh maupun parsial terhadap dokumen `ReqMutasi`, serta mendukung pengeluaran tanpa referensi permintaan (*Direct Mutation*). | Correctness |
| AC-06 | Pembatalan dokumen berstatus `In-Transit` berhasil mengembalikan saldo fisik persediaan ke lokasi asal dan mengubah status dokumen menjadi `Cancelled`. | Exception |
| AC-07 | Sistem menolak pembatalan atau perubahan pada dokumen mutasi yang telah diverifikasi dan disahkan dalam transaksi `TerimaMutasi`. | Constraint |

---

## 10. Out of Scope

- **Pencatatan Permintaan Mutasi**: Pengajuan kebutuhan logistik dari unit tujuan merupakan tanggung jawab Outcome `ReqMutasi` (`INV-MUTASI` Tahap 1).
- **Penerimaan Fisik dan Pencatatan Selisih**: Pemeriksaan fisik, pencatatan kuantitas yang diterima secara riil, dan penanganan barang rusak/hilang selama transit merupakan tanggung jawab Outcome `TerimaMutasi` (`INV-MUTASI` Tahap 3).
- **Pemesanan dan Pembelian Barang Eksternal**: Pengadaan logistik dari pemasok luar rumah sakit merupakan tanggung jawab domain `Purchasing` (`PUR-PO`, `PUR-DO`).
- **Konsumsi Operasional Unit**: Pemakaian barang di titik pelayanan klinis/operasional merupakan tanggung jawab Outcome `PakaiBrg` (`INV-PAKAI`).
- **Penyesuaian Fisik Berkala**: Rekonsiliasi selisih fisik berkala di gudang merupakan tanggung jawab Outcome `StokOpname` (`INV-OPNAME`).
