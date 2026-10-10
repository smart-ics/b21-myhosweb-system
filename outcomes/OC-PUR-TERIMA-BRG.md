# OUTCOME: Penerimaan Barang / DO (TerimaBrg)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-PUR-TERIMA-BRG      |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Pengadaan barang dan logistik di rumah sakit (mencakup obat-obatan farmasi, alat kesehatan, reagen laboratorium, serta bahan logistik umum/non-medis) dikirimkan secara fisik oleh rekanan pemasok (supplier) atas dasar komitmen Purchase Order (PO) yang sah. 

Penerimaan fisik barang di dermaga atau pintu gudang rumah sakit memerlukan proses pemeriksaan fisik dan inspeksi mutu yang ketat menyangkut kesesuaian jenis barang, kuantitas yang dikirim, keutuhan kemasan, nomor batch/lot, serta tanggal kedaluwarsa (*expired date*). Dokumen **Terima Barang (DO / Delivery Order / Bukti Penerimaan Barang Gudang)** diterbitkan sebagai instrumen pencatatan resmi rumah sakit yang memvalidasi dan mengesahkan barang yang telah diterima secara fisik dari vendor.

Satu dokumen Purchase Order dapat dikirimkan secara bertahap oleh vendor melalui beberapa dokumen Terima Barang terpisah. Dokumen Terima Barang berfungsi sebagai pemicu resmi mutasi penambahan saldo stok fisik pada Domain Inventory (`INV-STOK`) dan pembaruan akumulasi pemenuhan fisik pesanan pada PO, yang berlangsung secara independen dari proses penagihan komersial (*invoicing*) oleh supplier (`PUR-FAKTUR`).

Tanpa pencatatan dan verifikasi Terima Barang yang tertib di Bagian Gudang, rumah sakit berisiko mengalami selisih stok fisik (*stock discrepancy*), penerimaan barang melebihi kuota pesanan (*over-receiving*), masuknya obat/alkes yang mendekati masa kedaluwarsa atau cacat, serta hilangnya ketertelusuran nomor batch persediaan medis.

---

## 2. Outcome Statement

Penerimaan fisik barang dan logistik dari rekanan pemasok berdasarkan dokumen Purchase Order (PO) yang sah **telah diperiksa kesesuaian fisik dan mutunya di gudang tujuan, dicatat secara persisten oleh petugas penerima gudang (mencakup kuantitas diterima, ditolak, nomor batch, dan tanggal kedaluwarsa), disahkan (Confirmed / Received), secara atomik memicu mutasi penambahan saldo persediaan di Domain Inventory, dan memperbarui akumulasi kuantitas pemenuhan fisik pada PO terkait**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Purchasing | Pemilik utama: mengelola pencatatan dokumen penerimaan barang terhadap PO, memvalidasi kuantitas terima terhadap kuota PO, mengelola status pemenuhan fisik PO, dan memelihara jejak dokumen DO |
| Inventory | Bertanggung jawab atas mutasi persediaan masuk (`INV-MUTASI`) dan pembaruan saldo persediaan fisik (`INV-STOK`) di lokasi gudang penerima secara atomik saat DO disahkan, termasuk tracking batch dan expired date |
| Organisasi | Menyediakan konteks unit organisasi rumah sakit (`ORG-LAYANAN`) sebagai lokasi fisik gudang penerimaan yang sah sesuai penunjukan pada dokumen PO |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `PUR-DO` DO Penerimaan Barang | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `PUR-SUPPLIER` Supplier | Purchasing | Known |
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Terima Barang (DO) tercatat secara persisten dalam sistem dengan nomor registrasi internal unik resmi.
- Dokumen DO mengikat tepat 1 (satu) dokumen Purchase Order resmi yang berstatus aktif/diterbitkan (*Issued / Open* atau *Partially Received*) (`Strict 1-to-1 PO Binding`). Konsolidasi pengiriman dari beberapa nomor PO ke dalam satu DO dilarang.
- Dokumen DO mengikat tepat 1 (satu) rekanan pemasok aktif (`PUR-SUPPLIER`) yang identik dengan supplier pada dokumen PO terkait.
- Lokasi fisik gudang penerimaan wajib identik dengan unit gudang yang ditunjuk pada dokumen PO asal (`Strict Destination Warehouse Matching` via `ORG-LAYANAN`).
- Dokumen fisik eksternal dari vendor (Surat Jalan / DO Vendor) tercatat secara wajib: Nomor Surat Jalan Vendor dan Tanggal Surat Jalan Vendor. Kombinasi Supplier ID dan Nomor Surat Jalan Vendor harus unik dalam sistem rumah sakit guna mencegah penerimaan ganda atas kiriman fisik yang sama (`Anti-Double Receiving`).
- Penerimaan barang dijalankan berbasis rincian item barang (*line-item based*): setiap item yang diterima merujuk langsung ke baris item barang pada PO asal.
- Setiap baris item mencatat hasil pemeriksaan fisik dan inspeksi mutu:
  - Kuantitas yang dikirim vendor (`Delivered Qty`).
  - Kuantitas yang diterima baik (*sound/good condition*) (`Accepted Qty`).
  - Kuantitas yang ditolak/rusak/tidak sesuai (`Rejected Qty`) beserta alasan penolakan (`Rejection Reason`).
- Kuantitas yang diterima baik (`Accepted Qty`) dibatasi secara ketat oleh sisa kuantitas pesanan yang belum diterima pada PO (`Remaining Ordered Qty = Ordered Qty - Total Previous Accepted Qty`). Penerimaan fisik melebihi sisa pesanan PO dilarang (*Strict Receiving Cap*).
- Barang bonus resmi dari vendor (bila ada diskon natura/bonus barang) dicatat sebagai baris item bonus khusus dengan referensi PO, harga satuan 0, dan tidak menambah kuota komersial PO.
- Komoditas farmasi dan medis wajib mencatat Nomor Batch / Lot dan Tanggal Kedaluwarsa (*Expired Date*). Barang yang telah kedaluwarsa atau memiliki sisa masa simpan kurang dari batas standar rumah sakit wajib ditolak di pintu gudang, kecuali terdapat dispensasi/persetujuan khusus tertulis dengan surat jaminan retur vendor.
- Dokumen DO mewarisi harga satuan netto dari PO asal secara terkunci semata-mata untuk keperluan valuasi nilai mutasi persediaan (HPP / FIFO / Moving Average di Domain Inventory), tanpa mengubah DO menjadi dokumen penagihan komersial.
- Saat dokumen DO disahkan (*Confirmed / Received*):
  - Sistem secara atomik memicu pencatatan mutasi masuk persediaan (`INV-MUTASI`) dan menambah saldo stok fisik (`INV-STOK`) di gudang tujuan untuk seluruh item sebesar *Accepted Qty* beserta nomor batch dan tanggal kedaluwarsanya.
  - Akumulasi `Received Qty` pada baris item PO asal diperbarui, dan status pemenuhan fisik PO (*Receipt Status*) diperbarui menjadi *Partially Received* atau *Fully Received*.
- Pembentukan Terima Barang independen dari dokumen Faktur: keberadaan atau ketiadaan Faktur (`PUR-FAKTUR`) tidak menjadi prasyarat untuk pencatatan maupun pengesahan DO di Gudang. Satu PO dapat memiliki beberapa DO dan beberapa Faktur secara terpisah.
- Status dokumen DO dapat dibedakan secara tegas: **Draf**, **Dikonfirmasi / Diterima (Confirmed / Received)**, atau **Dibatalkan (Cancelled / Void — hanya saat Draf)**.

### 5.2 Required Recorded Information

- Nomor registrasi internal unik dokumen Terima Barang (format penomoran standar DO Bagian Gudang).
- Nomor referensi Purchase Order (`PO Number`) yang diterima.
- Identitas rekanan pemasok (Supplier ID, nama rekanan dari master `PUR-SUPPLIER`).
- Nomor Surat Jalan Vendor (nomor referensi surat jalan asli dari vendor).
- Tanggal Surat Jalan Vendor.
- Tanggal dan waktu penerimaan fisik barang di gudang rumah sakit.
- Lokasi gudang penerimaan fisik (ID dan nama unit kerja gudang dari `ORG-LAYANAN`).
- Identitas staf pemeriksa / petugas gudang penerima.
- Catatan umum kondisi penerimaan (e.g., kondisi segel, armada angkut, suhu kemasan).
- Rincian item barang yang diterima:
  - Kode dan nama barang (sesuai baris item PO).
  - Satuan kemasan penerimaan (dan faktor konversi ke satuan dasar bila berlaku).
  - Kuantitas pesanan pada PO (`Ordered Qty`).
  - Akumulasi kuantitas yang telah diterima pada DO sebelumnya (`Previously Received Qty`).
  - Sisa kuantitas pesanan PO yang belum diterima (`Remaining Ordered Qty`).
  - Kuantitas yang dikirim fisik oleh vendor (`Delivered Qty`).
  - Kuantitas yang diterima baik (`Accepted Qty`).
  - Kuantitas yang ditolak (`Rejected Qty`).
  - Alasan penolakan barang (jika `Rejected Qty > 0`, misal: Kemasan Rusak/Pecah, Segel Terbuka, Suhu Cold-Chain Tidak Sesuai, Salah Spesifikasi/Dosis, Mendekati Expired Date).
  - Status item bonus (`Is Bonus: Ya/Tidak`).
  - Nomor Batch / Lot pabrikan (wajib untuk farmasi/medis).
  - Tanggal Kedaluwarsa / Expired Date (wajib untuk farmasi/medis).
  - Harga satuan netto (terkunci dari PO untuk valuasi persediaan).
  - Subtotal nilai persediaan masuk (`Accepted Qty` × Harga Netto PO).
- Ringkasan nilai barang diterima:
  - Total kuantitas barang diterima baik.
  - Total kuantitas barang ditolak.
  - Total nilai valuasi persediaan yang masuk ke stok gudang.
- Identitas supervisor / kepala gudang yang mengesahkan (*Confirmed*).
- Tanggal dan waktu pengesahan resmi.
- Nomor referensi transaksi mutasi stok otomatis yang terbentuk (`INV-MUTASI`).
- Status dokumen Terima Barang.

### 5.3 Required Business Conditions

- **Strict Mandatory PO**: Setiap dokumen Terima Barang wajib merujuk ke nomor Purchase Order yang sah dan berstatus *Issued* atau *Partially Received*. Tidak diizinkan membuat penerimaan fisik tanpa PO (kondisi darurat/cito wajib menerbitkan Emergency PO terlebih dahulu melalui Bagian Pengadaan).
- **Strict Single PO Binding**: Satu dokumen Terima Barang hanya boleh merujuk ke tepat 1 (satu) dokumen PO. Konsolidasi beberapa nomor PO ke dalam satu DO dilarang (*no multi-PO receiving*).
- **Multi-DO per PO Allowed**: Satu dokumen PO diizinkan diterima secara bertahap melalui beberapa dokumen DO terpisah (*partial delivery*), sepanjang total akumulasi kuantitas yang diterima baik tidak melampaui kuantitas yang dipesan pada PO.
- **Strict Receiving Cap**: Kuantitas barang yang diterima baik (`Accepted Qty`) untuk setiap item tidak boleh melebihi sisa kuantitas pesanan yang belum diterima pada PO (`Remaining Ordered Qty`).
- **Vendor Delivery Note Uniqueness**: Kombinasi `Supplier ID` dan `Nomor Surat Jalan Vendor` wajib unik dalam seluruh riwayat sistem rumah sakit guna mencegah input ganda (*anti-double receiving*).
- **Strict Destination Warehouse Matching**: Lokasi gudang penerima pada dokumen DO wajib sama persis dengan unit gudang yang telah ditetapkan pada dokumen PO asal. Pengalihan gudang fisik tidak diizinkan tanpa revisi PO.
- **Inspection Integrity Formula**: Berlaku keseimbangan mutlak `Delivered Qty = Accepted Qty + Rejected Qty`. Hanya `Accepted Qty` yang berhak menambah saldo fisik persediaan dan memotong sisa pesanan PO.
- **Mandatory Batch and Expiry Control**: Komoditas farmasi dan medis wajib mencatat nomor batch dan tanggal ED yang valid (di masa depan). Barang dengan tanggal ED yang telah kedaluwarsa wajib ditolak di tempat.
- **Shelf-Life Safety Threshold**: Item farmasi/medis dengan sisa masa simpan kurang dari batas standar rumah sakit (misal < 18–24 bulan) ditolak secara sistem, kecuali terdapat otorisasi khusus manajemen yang dilampiri surat jaminan retur vendor sebelum kedaluwarsa.
- **Atomic Synchronous Inventory Mutation**: Pengesahan DO (*Confirmed / Received*) secara atomik menerbitkan transaksi mutasi masuk persediaan (`INV-MUTASI`) dan menambah saldo fisik (`INV-STOK`) pada gudang tujuan.
- **Immutability of Confirmed DO**: Dokumen DO yang telah disahkan (*Confirmed / Received*) terkunci permanen dari pengeditan langsung. Segala bentuk koreksi fisik atau pengembalian barang pasca-pengesahan wajib diproses melalui dokumen Retur Beli resmi (`PUR-RETURN`).
- **Draft-Only Cancellation**: Pembatalan dokumen (Void/Cancel) hanya dapat dilakukan selama DO masih berstatus Draf (sebelum stok masuk gudang dan sebelum PO diperbarui).

### 5.4 Completion Proof

- Dokumen Terima Barang tersimpan secara persisten dengan nomor internal unik dalam sistem dan berstatus **Dikonfirmasi / Diterima (Confirmed / Received)**.
- Nomor Surat Jalan Vendor terverifikasi unik untuk supplier terkait.
- Transaksi mutasi masuk persediaan (`INV-MUTASI`) terbentuk otomatis dan saldo stok fisik (`INV-STOK`) pada gudang tujuan bertambah sesuai kuantitas `Accepted Qty`, nomor batch, dan tanggal kedaluwarsa.
- Akumulasi `Received Qty` pada dokumen PO asal bertambah sesuai kuantitas yang diterima baik, dan status pemenuhan fisik PO terbarui (*Partially Received* atau *Fully Received*).
- Jejak audit pemeriksaan fisik (termasuk rincian barang ditolak dan alasan penolakan) tercatat lengkap.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas Bagian Gudang menerima kiriman fisik barang dan dokumen Surat Jalan dari kurir/rekanan pemasok, lalu menginisiasi pencatatan draf dokumen Terima Barang dengan memilih nomor Purchase Order aktif (`PUR-PO`), merekam identitas surat jalan vendor (nomor dan tanggal), memeriksa kondisi fisik kemasan dan suhu penyimpanan, serta mencatat hasil verifikasi rincian barang (kuantitas kirim, diterima baik, ditolak, nomor batch, dan tanggal kedaluwarsa).

### End

Berakhir ketika dokumen Terima Barang disahkan oleh petugas/supervisor gudang dengan status **Confirmed / Received**, yang secara atomik memicu transaksi mutasi masuk persediaan di Domain Inventory (`INV-MUTASI` / `INV-STOK`), memperbarui progres pemenuhan fisik pada PO terkait, dan mengunci dokumen penerimaan dari pengeditan langsung.

---

## 7. Business Constraints

1. **Exact Single PO Binding**: Setiap dokumen Terima Barang hanya mengikat tepat 1 (satu) dokumen PO; konsolidasi multi-PO dalam satu DO dilarang.
2. **Strict Receiving Cap**: Kuantitas barang yang diterima baik dibatasi secara ketat oleh sisa kuantitas pesanan yang belum diterima pada PO asal (`Accepted Qty <= Remaining Ordered Qty`).
3. **Mandatory Active PO Reference**: Perekaman penerimaan fisik tanpa referensi PO yang sah dilarang mutlak; kebutuhan darurat wajib disalurkan melalui mekanisme Emergency PO terlebih dahulu.
4. **Strict Destination Warehouse Matching**: Lokasi penerimaan fisik wajib identik dengan gudang tujuan yang ditetapkan pada dokumen PO asal.
5. **Vendor Delivery Note Uniqueness**: Kombinasi `Supplier ID` dan `Nomor Surat Jalan Vendor` harus unik dalam seluruh riwayat sistem rumah sakit (*anti-double receiving*).
6. **Mandatory Batch and Expiry Tracking**: Seluruh item obat, alat kesehatan, dan reagen medis wajib memiliki nomor batch dan tanggal expired date yang valid.
7. **Inspection Accountability**: Formula kuantitas inspeksi berlaku mutlak (`Delivered Qty = Accepted Qty + Rejected Qty`), dengan alasan penolakan wajib dicatat untuk setiap kuantitas yang ditolak.
8. **Atomic Inventory Synchronization**: Pengesahan dokumen DO wajib mengeksekusi penambahan saldo stok fisik secara atomik pada Domain Inventory (`INV-STOK`) melalui transaksi `INV-MUTASI`.
9. **Dual PO Progress Decoupling**: Pemenuhan fisik logistik (DO) dan penagihan finansial vendor (Faktur) berjalan secara terpisah dan independen di bawah PO tanpa saling mengunci.
10. **Immutability of Confirmed DO**: Dokumen DO yang telah disahkan terkunci permanen; koreksi kuantitas atau pengembalian barang pasca-pengesahan wajib diselesaikan melalui dokumen Retur Beli (`PUR-RETURN`).

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Nomor Surat Jalan Vendor sudah pernah tercatat untuk supplier yang sama | Sistem menolak penyimpanan dokumen dan memberikan peringatan indikasi input ganda (*duplicate vendor delivery note*). |
| Kuantitas yang diterima baik melebihi sisa pesanan PO (`Accepted Qty > Remaining Ordered Qty`) | Sistem menolak pengesahan DO dan memblokir kelebihan kuantitas (*over-receiving prevention*). Kelebihan fisik harus dikembalikan ke vendor atau dicatat melalui revisi PO terlebih dahulu. |
| Item obat/alkes memiliki tanggal ED yang telah kedaluwarsa atau hari ini | Sistem menolak penerimaan item sebagai *Accepted Qty* dan mewajibkan kuantitas tersebut dicatat sebagai *Rejected Qty*. |
| Sisa masa kedaluwarsa kurang dari batas standar RS tanpa jaminan retur | Sistem memblokir pengesahan sampai ada otorisasi khusus dari manajemen/kepala instalasi farmasi disertai surat pernyataan jaminan retur dari vendor. |
| Dokumen PO yang dipilih belum berstatus Issued (masih Draf / Pending / Closed / Cancelled) | Sistem menolak pengaitan DO; Terima Barang hanya dapat diterbitkan atas PO yang telah berstatus *Issued* atau *Partially Received*. |
| Gudang fisik penerima berbeda dari gudang tujuan pada PO | Sistem menolak penerimaan dan mengarahkan petugas untuk menerima di gudang yang sesuai dengan PO asal. |
| Upaya pembatalan atau pengeditan DO yang telah berstatus Confirmed | Sistem menolak pembatalan langsung (*locked immutable*). Pengembalian atau koreksi fisik wajib disalurkan melalui modul Retur Beli resmi (`PUR-RETURN`). |
| Seluruh barang yang dikirim vendor rusak total atau salah spesifikasi | Petugas menerbitkan DO dengan `Accepted Qty = 0` dan seluruh kiriman dialokasikan ke `Rejected Qty` beserta alasannya; sistem tidak menambah stok gudang dan tidak mengubah `Received Qty` pada PO. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Petugas gudang dapat mencatat dokumen Terima Barang dengan memilih 1 dokumen PO aktif dan menarik rincian item, satuan, sisa pesanan, serta gudang tujuan secara terkunci dari PO asal. | Completeness |
| AC-02 | Sistem mengizinkan penerbitan beberapa dokumen Terima Barang terpisah atas 1 dokumen PO yang sama (*partial delivery*). | Completeness |
| AC-03 | Sistem menolak penerimaan barang apabila kuantitas yang diterima baik melebihi sisa pesanan yang belum diterima pada PO (`Accepted Qty > Remaining Ordered Qty`). | Constraint |
| AC-04 | Sistem menolak perekaman dokumen Terima Barang apabila kombinasi Supplier ID dan Nomor Surat Jalan Vendor telah tercatat sebelumnya di sistem (*anti-double receiving*). | Constraint |
| AC-05 | Sistem menolak pengesahan dokumen DO untuk komoditas farmasi/medis apabila Nomor Batch atau Tanggal Kedaluwarsa kosong atau sudah kedaluwarsa. | Constraint |
| AC-06 | Sistem memastikan formula inspeksi fisik terpenuhi (`Delivered Qty = Accepted Qty + Rejected Qty`) dan mewajibkan pencatatan alasan penolakan jika `Rejected Qty > 0`. | Correctness |
| AC-07 | Pengesahan dokumen DO (*Confirmed / Received*) secara atomik menambah saldo stok fisik di gudang tujuan (`INV-STOK`) via mutasi masuk (`INV-MUTASI`) dan memperbarui kuantitas diterima pada PO asal. | Correctness |
| AC-08 | Dokumen Terima Barang dapat diproses dan disahkan secara independen tanpa memerlukan keberadaan dokumen Faktur (`PUR-FAKTUR`). | Constraint |
| AC-09 | Sistem mengunci permanen dokumen DO yang telah berstatus *Confirmed / Received* dari pengeditan atau pembatalan langsung, dan mengarahkan pengembalian barang melalui dokumen Retur Beli (`PUR-RETURN`). | Exception |

---

## 10. Out of Scope

- **Penerbitan dan Otorisasi Purchase Order**: Pembuatan, amandemen harga, dan persetujuan komitmen pembelian merupakan tanggung jawab `PurchaseOrder` (`PUR-PO`).
- **Pencatatan dan Verifikasi Tagihan Komersial**: Perekaman faktur tagihan supplier, perhitungan PPN komersial, bea materai, dan jatuh tempo pembayaran merupakan tanggung jawab `Faktur` (`PUR-FAKTUR`).
- **Pengembalian Barang Pasca-Penerimaan (Retur Pembelian)**: Pengelolaan retur fisik barang yang telah masuk stok ke vendor merupakan tanggung jawab `ReturBeli` (`PUR-RETURN`).
- **Mutasi Antar Gudang dan Pengeluaran Persediaan**: Distribusi barang antar gudang rumah sakit dan pemakaian barang oleh unit pelayanan merupakan tanggung jawab `Mutasi` (`INV-MUTASI`) dan `PakaiBrg` (`INV-PAKAI`).
- **Pencatatan Hutang Dagang dan Pengeluaran Kas/Bank**: Pengakuan hutang akuntansi (*Accounts Payable*) dan pembayaran finansial ke rekening supplier berada di luar batas operasional logistik/Purchasing (dikelola oleh Akuntansi dan Kasir Pengeluaran `TRK`).
