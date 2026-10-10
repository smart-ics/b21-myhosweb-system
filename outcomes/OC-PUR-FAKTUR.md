# OUTCOME: Faktur (Faktur)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-PUR-FAKTUR          |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Setiap pengadaan barang dan logistik rumah sakit yang telah diterbitkan melalui Purchase Order (PO) menimbulkan hak tagih komersial bagi rekanan pemasok (supplier). Rekanan pemasok menagihkan kewajiban pembayaran tersebut kepada rumah sakit dengan menerbitkan dokumen fisik tagihan komersial (Faktur / Supplier Invoice).

Pencatatan Faktur di Bagian Purchasing bertujuan untuk merekam, memverifikasi kesesuaian komersial, dan memvalidasi rincian klaim penagihan dari rekanan terhadap pesanan resmi yang telah disepakati dalam PO. Dokumen PO dapat ditagihkan secara bertahap (termin atau pengiriman bertahap) melalui beberapa Faktur terpisah, di mana setiap Faktur mengikat tepat satu PO dan tidak bergantung pada ada/tidaknya dokumen fisik Surat Jalan / DO Penerimaan Barang Gudang.

Tanpa pencatatan dan verifikasi Faktur yang tertib di Bagian Purchasing, rumah sakit berisiko mengalami penagihan ganda (*double billing*), penagihan melebihi kuota komitmen PO (*over-invoicing*), atau ketidaksesuaian nilai tagihan yang menghambat proses pengakuan hutang dan pembayaran oleh Departemen Keuangan.

---

## 2. Outcome Statement

Tagihan komersial dari rekanan pemasok untuk rincian item barang dan kuantitas tertentu atas dasar komitmen Purchase Order yang sah **telah dicatat secara persisten oleh Bagian Purchasing, diverifikasi kesesuaian harga dan ketentuannya terhadap PO, disahkan (Approved/Verified) oleh pejabat berwenang, memperbarui akumulasi kuota tertagih pada PO, dan tersedia sebagai referensi tagihan terverifikasi bagi Bagian Keuangan/Akuntansi**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Purchasing | Pemilik utama: mengelola pencatatan dokumen faktur supplier, memvalidasi kuantitas tagihan terhadap PO, memverifikasi kesesuaian komersial, dan memelihara siklus hidup dokumen Faktur |
| Organisasi | Menyediakan konteks unit kerja organisasi rumah sakit (`ORG-LAYANAN`, Bagian Purchasing / Unit Pengadaan) |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `PUR-FAKTUR` Faktur | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `PUR-SUPPLIER` Supplier | Purchasing | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Faktur tercatat secara persisten dalam sistem dengan nomor registrasi internal unik resmi.
- Dokumen Faktur mengikat tepat 1 (satu) dokumen Purchase Order resmi yang berstatus aktif/diterbitkan (*Issued / Open* atau *Partially Invoiced*).
- Dokumen Faktur mengikat tepat 1 (satu) rekanan pemasok aktif (`PUR-SUPPLIER`) yang identik dengan supplier pada dokumen PO terkait.
- Penagihan dijalankan berbasis rincian item barang (*line-item based*): setiap item yang ditagihkan merujuk langsung ke baris item barang pada PO asal.
- Kuantitas yang ditagihkan (`Invoiced Qty`) pada setiap item tidak boleh melampaui sisa kuantitas PO yang belum difakturkan (`Remaining Invoiced Qty = Ordered Qty - Total Previous Invoiced Qty`).
- Harga satuan barang, diskon persentase per baris, dan ketentuan tarif pajak (PPN) terkunci otomatis mengikuti kesepakatan komersial pada PO asal (*Strict PO Matching*).
- Penyesuaian non-item resmi yang lazim pada tagihan fisik supplier (seperti Bea Materai, Ongkos Kirim yang belum masuk PO, dan Pembulatan/Rounding) tercatat secara definitif.
- Faktur mencatat identitas dokumen fisik eksternal dari rekanan: Nomor Faktur Pemasok (harus unik per rekanan), Tanggal Faktur Pemasok, Tanggal Jatuh Tempo, dan Nomor Seri Faktur Pajak (bila transaksi dikenakan PPN).
- Pembentukan Faktur independen dari penerimaan fisik gudang: keberadaan atau ketiadaan DO (`PUR-DO`) tidak menjadi prasyarat untuk pencatatan maupun pengesahan Faktur di Purchasing.
- Status dokumen Faktur dapat dibedakan secara tegas: **Draf**, **Disetujui / Diverifikasi (Verified / Approved)**, atau **Dibatalkan (Cancelled / Void)**.

### 5.2 Required Recorded Information

- Nomor registrasi internal unik dokumen Faktur (format penomoran standar Faktur Purchasing).
- Nomor referensi Purchase Order (`PO Number`) yang ditagih.
- Identitas rekanan pemasok (Supplier ID, nama perusahaan, NPWP, kontak dari master `PUR-SUPPLIER`).
- Nomor Faktur Pemasok (nomor referensi tagihan asli dari vendor).
- Tanggal Faktur Pemasok (tanggal cetak/terbit invoice dari vendor).
- Tanggal penerimaan/pencatatan berkas tagihan di rumah sakit.
- Tanggal Jatuh Tempo pembayaran (*Due Date*), dihitung dari Term of Payment (TOP) PO atau tanggal dokumen vendor.
- Nomor Seri Faktur Pajak (NSFP e-Faktur DJP) beserta tanggal faktur pajak (bila kena PPN).
- Rincian item barang yang ditagihkan:
  - Kode dan nama barang (sesuai baris item PO).
  - Satuan kemasan pembelian.
  - Kuantitas pesanan pada PO (`Ordered Qty`).
  - Akumulasi kuantitas yang telah difakturkan sebelumnya (`Previously Invoiced Qty`).
  - Sisa kuantitas PO yang dapat difakturkan (`Remaining Invoiced Qty`).
  - Kuantitas yang ditagihkan pada faktur ini (`Invoiced Qty`).
  - Harga satuan netto (terkunci dari PO).
  - Nilai diskon per baris item (terkunci dari PO).
  - Subtotal harga per baris item (`Invoiced Qty` × Harga Netto).
- Ringkasan nilai finansial tagihan:
  - Subtotal nilai item yang ditagih sebelum pajak.
  - Total nilai diskon per baris item.
  - Nilai PPN (dihitung berdasarkan tarif PPN PO atas dasar pengenaan pajak).
  - Biaya tambahan non-item yang diizinkan (Biaya Ongkos Kirim, Bea Materai).
  - Nilai pembulatan selisih kas/nominal (*Rounding Adjustment*).
  - Grand Total nilai tagihan Faktur.
- Identitas staf Bagian Purchasing pembuat draf.
- Identitas supervisor/pejabat Bagian Purchasing yang memverifikasi/menyetujui.
- Tanggal dan waktu pengesahan resmi.
- Catatan operasional tagihan (opsional).
- Status dokumen Faktur.

### 5.3 Required Business Conditions

- **Strict Single PO Reference**: Satu dokumen Faktur hanya boleh merujuk ke tepat 1 (satu) dokumen PO. Tidak diizinkan menggabungkan beberapa PO berbeda ke dalam satu Faktur (*no multi-PO consolidation*).
- **Multi-Faktur per PO Allowed**: Satu dokumen PO diizinkan memiliki beberapa Faktur bertahap (*partial invoicing*), sepanjang total akumulasi kuantitas tagihan tidak melebihi kuantitas yang dipesan pada PO.
- **Anti-Over-Invoicing**: Kuantitas yang ditagih (`Invoiced Qty`) untuk setiap item barang tidak boleh melebihi sisa kuantitas PO yang belum difakturkan (`Remaining Invoiced Qty`).
- **Strict Commercial Matching**: Harga satuan dan ketentuan diskon tidak dapat diedit langsung pada Faktur. Apabila terdapat selisih harga dari pihak supplier, PO harus direvisi atau dibatalkan terlebih dahulu sebelum Faktur dapat diproses.
- **Supplier Invoice Number Uniqueness**: Nomor Faktur Pemasok wajib unik untuk supplier yang sama guna mencegah penagihan ganda (*anti-double billing*).
- **Independence from Goods Receipt (DO)**: Pencatatan dan validasi Faktur tidak memerlukan konfirmasi penerimaan fisik barang gudang (`PUR-DO`). Kedua proses berjalan pada jalurnya masing-masing di bawah relasi PO.
- **Immutability of Approved Invoice**: Dokumen Faktur yang telah disahkan (*Verified / Approved*) terkunci permanen dari pengeditan langsung.
- **Conditional Cancellation**: Pembatalan Faktur yang telah berstatus *Verified / Approved* hanya dapat dilakukan selama Bagian Keuangan/Akuntansi belum mencatat realisasi pembayaran atas faktur tersebut. Pembatalan faktur secara otomatis memulihkan kuota sisa tertagih pada PO terkait.

### 5.4 Completion Proof

- Dokumen Faktur tersimpan persisten dengan nomor internal unik dalam sistem.
- Nomor Faktur Pemasok terverifikasi unik untuk rekanan terkait.
- Status dokumen bernilai **Disetujui / Diverifikasi (Verified / Approved)** dengan jejak audit pejabat penyetuju tercatat lengkap.
- Akumulasi `Invoiced Qty` pada dokumen PO bertambah sesuai kuantitas yang disahkan, dan status progres penagihan pada PO terbarui (*Partially Invoiced* atau *Fully Invoiced*).
- Dokumen Faktur terverifikasi tersedia dalam antrean aktif Bagian Keuangan/Tata Rekening untuk proses verifikasi pencairan hutang usaha.

---

## 6. Outcome Boundary

### Start

Dimulai ketika Bagian Purchasing menerima berkas tagihan fisik/digital dari rekanan pemasok dan menginisiasi pencatatan draf Faktur dengan memilih dokumen Purchase Order (`PUR-PO`) yang bersangkutan, merekam identitas faktur supplier (nomor faktur, tanggal, jatuh tempo, faktur pajak), serta memilih item dan kuantitas barang yang ditagihkan.

### End

Berakhir ketika dokumen Faktur diperiksa dan disetujui oleh pejabat berwenang Bagian Purchasing dengan status **Verified / Approved**, mengunci nilai tagihan secara persisten, memperbarui akumulasi kuota tertagih pada PO, serta menyediakannya bagi Bagian Keuangan/Akuntansi.

---

## 7. Business Constraints

1. **Exact Single PO Binding**: Setiap Faktur hanya mengikat tepat 1 (satu) dokumen PO; konsolidasi multi-PO dalam satu Faktur dilarang.
2. **Strict Invoicing Cap**: Kuantitas penagihan item barang dibatasi secara ketat oleh sisa kuantitas pesanan yang belum ditagih pada PO asal (`Invoiced Qty <= Remaining Invoiced Qty`).
3. **Decoupled from Warehouse Receiving (DO)**: Penagihan supplier tidak bergantung pada penerimaan fisik gudang. Satu PO dapat memiliki beberapa Faktur dan beberapa DO secara independen.
4. **Strict PO Price Lock**: Harga satuan, diskon, dan ketentuan PPN mengacu mutlak pada PO asal tanpa toleransi pengubahan sepihak pada formulir Faktur.
5. **Supplier Invoice Number Uniqueness**: Kombinasi `Supplier ID` dan `Nomor Faktur Pemasok` harus unik dalam seluruh riwayat sistem rumah sakit.
6. **Dual PO Progress Tracking**: Dokumen PO memelihara status pemenuhan fisik (*Receipt Status*) dan status penagihan (*Invoicing Status*) sebagai dua indikator independen yang tidak saling mengunci.
7. **Controlled Revocation**: Faktur yang telah disahkan (*Approved*) hanya dapat dibatalkan (*Void/Cancel*) jika belum terdapat transaksi pengeluaran kas/pembayaran dari Bagian Keuangan.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Nomor Faktur Pemasok sudah pernah tercatat untuk supplier yang sama | Sistem menolak penyimpanan dokumen dan memberikan peringatan indikasi penagihan ganda (*duplicate invoice number*). |
| Kuantitas item yang ditagih melebihi sisa kuantitas PO | Sistem menolak pengesahan Faktur dan memblokir kuantitas yang melampaui sisa kuota PO (*over-invoicing prevention*). |
| Dokumen PO yang dipilih belum berstatus Issued (masih Draf / Pending Approval / Cancelled) | Sistem menolak pengaitan Faktur; Faktur hanya dapat diterbitkan atas PO yang telah berstatus *Issued* atau *Partially Invoiced*. |
| Harga satuan pada tagihan fisik supplier berbeda dari PO | Sistem menolak pengubahan harga satuan pada Faktur. Staf Purchasing harus mengembalikan invoice ke supplier untuk koreksi atau memproses revisi PO sesuai prosedur pengadaan. |
| Pengajuan pembatalan Faktur yang telah dibayar oleh Bagian Keuangan | Sistem menolak pembatalan dokumen Faktur. Koreksi finansial harus diselesaikan melalui mekanisme nota retur, memo debit, atau penyesuaian di Bagian Keuangan. |
| Supplier mengenakan PPN padahal PO berstatus Non-PPN (atau sebaliknya) | Sistem menolak inkonsistensi perlakuan pajak terhadap PO asal; ketentuan perpajakan harus diselaraskan melalui revisi PO terlebih dahulu. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Bagian Purchasing dapat mencatat dokumen Faktur dengan memilih 1 dokumen PO aktif dan menarik rincian item, harga satuan, diskon, serta PPN secara terkunci dari PO asal. | Completeness |
| AC-02 | Sistem mengizinkan penerbitan beberapa dokumen Faktur terpisah atas 1 dokumen PO yang sama (*partial invoicing*). | Completeness |
| AC-03 | Sistem menolak penagihan item barang apabila kuantitas yang ditagihkan melebihi sisa kuantitas yang belum difakturkan pada PO (`Invoiced Qty > Remaining Invoiced Qty`). | Constraint |
| AC-04 | Sistem menolak perekaman dokumen Faktur apabila kombinasi Supplier ID dan Nomor Faktur Pemasok telah tercatat sebelumnya di sistem (*anti-double billing*). | Constraint |
| AC-05 | Dokumen Faktur dapat diproses dan disahkan (*Verified / Approved*) tanpa memerlukan adanya dokumen Surat Jalan / Penerimaan Barang Gudang (`PUR-DO`). | Constraint |
| AC-06 | Pengesahan Faktur secara otomatis menambah akumulasi `Invoiced Qty` pada baris item PO dan memperbarui status penagihan PO menjadi *Partially Invoiced* atau *Fully Invoiced*. | Correctness |
| AC-07 | Sistem mendukung pencatatan penyesuaian resmi non-item berupa Bea Materai, Ongkos Kirim, dan Pembulatan (*Rounding*) pada total tagihan Faktur. | Completeness |
| AC-08 | Sistem mengizinkan pembatalan Faktur berstatus *Verified/Approved* hanya jika belum ada transaksi pembayaran di Keuangan, dan pembatalan tersebut otomatis mengembalikan sisa kuota tertagih pada PO. | Exception |

---

## 10. Out of Scope

- **Penerbitan dan Amandemen Purchase Order**: Pembuatan dan perubahan komitmen pesanan pembelian awal merupakan tanggung jawab `PurchaseOrder` (`PUR-PO`).
- **Penerimaan Fisik dan Pemeriksaan Barang**: Penerimaan fisik barang di gudang, inspeksi mutu/kerusakan fisik, dan penerbitan bukti terima barang merupakan tanggung jawab `TerimaBrg` (`PUR-DO`).
- **Pencatatan Saldo dan Mutasi Fisik Persediaan**: Penambahan kuantitas fisik stok barang di gudang rumah sakit merupakan tanggung jawab domain `Inventory` (`INV-STOK`, `INV-MUTASI`).
- **Pencatatan Jurnal Hutang Usaha (AP Posting)**: Pengakuan hutang dagang akuntansi, pencatatan buku besar pembantu hutang, dan verifikasi akhir *3-way matching* sebelum pencairan dana merupakan tanggung jawab Bagian Akuntansi / Tata Rekening.
- **Pencairan Kas / Pembayaran ke Supplier**: Pelaksanaan pembayaran transfer/cek/bilyet giro ke rekening supplier merupakan tanggung jawab Bagian Keuangan / Kasir Pengeluaran (`TRK`).
