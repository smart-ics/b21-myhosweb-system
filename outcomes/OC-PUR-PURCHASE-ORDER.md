# OUTCOME: Purchase Order (PurchaseOrder)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-PUR-PURCHASE-ORDER  |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Pengadaan barang dan logistik di rumah sakit (mencakup obat-obatan farmasi, alat kesehatan, reagen laboratorium, serta bahan logistik umum/non-medis) memerlukan ikatan komersial dan komitmen hukum yang sah kepada pemasok/rekanan eksternal terpilih. 

Setelah kebutuhan barang disetujui dalam dokumen Purchase Request (PR), Bagian Purchasing menyusun kesepakatan komersial berupa harga satuan akhir, diskon, perlakuan perpajakan (PPN), termin pembayaran, serta tujuan gudang penerimaan fisik. Dokumen **Purchase Order** diterbitkan sebagai instrumen kontraktual resmi rumah sakit kepada pemasok yang menjamin kepastian pasokan barang dengan spesifikasi dan waktu pengiriman yang disepakati.

Tanpa Purchase Order yang sah dan terotorisasi, rumah sakit tidak memiliki komitmen pemesanan yang mengikat kepada pemasok, dan Bagian Gudang tidak memiliki dasar hukum yang valid untuk menerima dan memverifikasi kiriman barang fisik dari vendor.

---

## 2. Outcome Statement

Pesanan pembelian resmi rumah sakit kepada rekanan pemasok terpilih untuk rincian item, kuantitas, harga, dan syarat komersial yang disepakati **telah diterbitkan oleh Bagian Purchasing, disetujui oleh pejabat berwenang sesuai limit otorisasi, berstatus sah (Issued) sebagai komitmen kontraktual yang mengikat, dan siap menjadi acuan penerimaan barang di Gudang (PUR-DO)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Purchasing | Pemilik utama: mengelola penunjukan rekanan, penyusunan komitmen pemesanan komersial, otorisasi berjenjang, dan pemeliharaan siklus hidup dokumen Purchase Order |
| Organisasi | Menyediakan informasi unit gudang penerimaan fisik resmi rumah sakit (`ORG-LAYANAN`, misal: Gudang Farmasi Utama, Gudang Logistik Umum) |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `PUR-PO` Purchase Order | Purchasing | Known |
| `PUR-PURREQ` Purchase Request | Purchasing | Known |
| `PUR-SUPPLIER` Supplier | Purchasing | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Purchase Order tercatat secara persisten dalam sistem dengan nomor referensi unik resmi.
- Dokumen Purchase Order mengikat tepat 1 (satu) rekanan pemasok aktif (`PUR-SUPPLIER`).
- Penunjukan lokasi gudang fisik penerimaan barang tercatat jelas merujuk pada unit kerja organisasi rumah sakit (`ORG-LAYANAN`).
- Sumber kebutuhan terverifikasi sah:
  - **Jalur Rutin**: Mengacu pada satu atau beberapa dokumen Purchase Request yang telah berstatus *Approved* (`PUR-PURREQ`) untuk kelompok pengadaan yang sama.
  - **Jalur Emergency/Direct PO**: Mengakomodasi kebutuhan mendesak tanpa PR terdahulu dengan pencatatan justifikasi darurat dan otorisasi khusus.
- Setiap item barang memiliki kuantitas pemesanan definitif (`Ordered Qty`), harga satuan kesepakatan bersih, diskon, dan tarif pajak yang berlaku.
- Ketentuan komersial (Term of Payment / TOP dalam hari/tempo) tercatat definitif.
- Persetujuan otorisasi resmi tercatat persisten sesuai limit nilai transaksi:
  - Nilai \(\le \text{Rp 10.000.000}\): Disetujui oleh Kepala/Manajer Bagian Purchasing.
  - Nilai \(> \text{Rp 10.000.000}\) (atau Emergency PO bernilai tinggi): Wajib memperoleh otorisasi Direksi/Manajemen Keuangan.
- Status dokumen Purchase Order dapat dibedakan secara tegas: **Draf**, **Menunggu Persetujuan**, **Diterbitkan (Issued / Open)**, **Sebagian Diterima (Partially Received)**, **Selesai / Ditutup (Fully Received / Closed)**, **Ditutup Paksa (Force Closed)**, atau **Dibatalkan (Cancelled / Void)**.

### 5.2 Required Recorded Information

- Nomor referensi unik Purchase Order (format standar PO per kelompok komoditas dan periode anggaran).
- Kelompok pengadaan/komoditas (Farmasi/Medis atau Logistik Umum/Non-Medis).
- Jenis penerbitan PO (Rutin berbasis PR atau Emergency/Direct PO).
- Daftar referensi dokumen Purchase Request yang dikonsolidasi (nomor PR dan baris item PR terkait).
- Identitas rekanan pemasok (Supplier ID, nama perusahaan, alamat, PIC kontak, nomor telepon/email dari master `PUR-SUPPLIER`).
- Lokasi gudang penerimaan tujuan (ID dan nama unit layanan gudang dari `ORG-LAYANAN`).
- Tanggal penerbitan PO.
- Estimasi tanggal pengiriman yang diharapkan (*Expected Delivery Date*).
- Syarat pembayaran / Term of Payment (TOP, e.g., Cash, COD, Kredit 30 Hari, Kredit 60 Hari).
- Perlakuan pajak PPN (Non-PPN, Exclude PPN, atau Include PPN beserta tarif persentase berlaku).
- Identitas staf Bagian Purchasing pembuat dokumen.
- Identitas dan jabatan pejabat penyetuju (Kepala Purchasing / Direksi).
- Tanggal dan waktu persetujuan resmi.
- Catatan dan instruksi pengiriman khusus kepada supplier.
- Nilai finansial ringkasan:
  - Subtotal nilai barang sebelum diskon dan pajak.
  - Total nilai diskon (akumulasi diskon per baris dan diskon global).
  - Total nilai PPN.
  - Grand Total nilai komitmen PO.
- Daftar rincian barang yang dipesan:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan kemasan pembelian (dan rasio konversi ke satuan terkecil bila berlaku).
  - Kuantitas pesanan (`Ordered Qty`).
  - Harga satuan netto kesepakatan.
  - Nilai diskon per baris item (persentase atau nominal).
  - Subtotal harga per baris item.
  - Akumulasi kuantitas yang telah diterima secara fisik (`Received Qty`, diinisialisasi 0).
  - Sisa kuantitas pesanan yang belum diterima (`Remaining Qty = Ordered Qty - Received Qty`).
- Status Purchase Order.

### 5.3 Required Business Conditions

- Pemasok yang dipilih harus berstatus aktif dan tidak dalam status penangguhan/daftar hitam (blacklist).
- Dokumen PO harus terpisah berdasarkan kelompok pengadaan (tidak menggabungkan barang farmasi/medis dengan barang logistik umum non-medis dalam satu PO).
- Satu dokumen PO diperbolehkan mengonsolidasi item dari beberapa PR Approved yang berbeda (*Multi-PR Consolidation*), asalkan ditujukan kepada rekanan pemasok yang sama dan kelompok pengadaan yang sama.
- Kuantitas barang yang ditarik dari PR tidak boleh melebihi sisa kuota kuantitas PR yang belum dipesan (`Remaining Qty on PR`).
- **Strict Budget Cap**: Harga satuan kesepakatan pada baris item PO tidak boleh melampaui harga estimasi yang telah disetujui pada dokumen PR. Jika pemasok menaikkan harga di atas estimasi PR, PR harus direvisi atau dibatalkan terlebih dahulu sebelum PO dapat diterbitkan.
- Nilai kuantitas dan harga satuan harus bernilai positif (\(> 0\)).
- **Immutability of Issued PO**: Sekali dokumen PO disetujui dan berstatus **Issued**, rincian item, kuantitas, harga, dan ketentuan komersial terkunci secara permanen. Perubahan minor (seperti jadwal kirim atau catatan pengemasan) hanya dicatat melalui log adendum internal.
- Perubahan substantif atas item atau kuantitas pada PO yang telah berstatus *Issued* hanya dapat dilakukan melalui pembatalan resmi (*Cancel/Void*) atas PO tersebut dengan syarat belum ada penerimaan barang fisik yang tercatat.

### 5.4 Completion Proof

- Dokumen Purchase Order tersimpan secara persisten dengan nomor resmi unik.
- Status dokumen bernilai **Diterbitkan (Issued / Open)** dengan otorisasi sah dari pejabat berwenang tercatat dalam jejak audit sistem.
- Kuantitas yang dipesan telah memotong saldo kuota yang belum dipesan pada dokumen Purchase Request asal (`Ordered Qty` pada PR bertambah, `Remaining PR Qty` berkurang).
- Dokumen tersedia dalam antrean aktif Bagian Gudang sebagai referensi pencatatan Surat Jalan / Penerimaan Barang fisik (`PUR-DO` / `TerimaBrg`).

---

## 6. Outcome Boundary

### Start

Dimulai ketika Bagian Purchasing menginisiasi pembentukan draf Purchase Order dengan memilih rekanan pemasok aktif, menarik item barang dari satu atau beberapa Purchase Request yang telah berstatus *Approved* (atau menginisiasi jalur Emergency PO terjustifikasi), serta menetapkan harga kesepakatan, diskon, PPN, termin pembayaran, dan gudang tujuan penerimaan.

### End

Berakhir ketika dokumen Purchase Order disetujui oleh pejabat berwenang (Kepala Purchasing atau Direksi sesuai batas nilai kewenangan) dan secara resmi diterbitkan dengan status **Issued**, mengikat rumah sakit dan pemasok dalam komitmen pengadaan resmi serta siap menjadi acuan fisik penerimaan barang di Gudang (`PUR-DO`).

---

## 7. Business Constraints

1. **Single Supplier per Order**: Setiap satu dokumen Purchase Order hanya ditujukan kepada tepat 1 (satu) rekanan pemasok resmi.
2. **Strict Budget Cap against PR**: Harga satuan kesepakatan pada PO tidak boleh melebihi estimasi harga yang disetujui pada Purchase Request asal guna menjamin kepatuhan pagu anggaran rumah sakit.
3. **Multi-PR Consolidation Allowed**: Satu PO dapat menggabungkan kebutuhan barang dari beberapa PR *Approved* yang berbeda selama berada dalam kelompok pengadaan dan supplier yang identik.
4. **Tiered Authorization Gate**: Otorisasi PO diatur berjenjang; pengadaan dengan total nilai di atas Rp 10.000.000 (atau Emergency PO bernilai tinggi) wajib memperoleh persetujuan Direksi/Manajemen Keuangan.
5. **Immutability of Issued PO**: Dokumen PO yang telah berstatus *Issued* terkunci secara permanen dari pengeditan langsung. Perubahan item atau kuantitas mewajibkan pembatalan resmi (*Void*) sebelum penerimaan fisik dimulai.
6. **Force Close Handling**: Jika rekanan pemasok tidak mampu memenuhi sisa kuantitas pesanan akibat diskontinu atau kekosongan stok permanen, sistem mendukung penutupan paksa (*Force Close*); sisa kuantitas yang tidak terkirim hangus dari PO tersebut dan tidak otomatis kembali ke kuota PR tanpa otorisasi pembukaan ulang PR.
7. **Warehouse Designator**: Setiap PO wajib menunjuk unit gudang penerimaan resmi dari struktur organisasi (`ORG-LAYANAN`) guna memastikan ketertelusuran lokasi fisik serah terima logistik.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Rekanan pemasok berstatus non-aktif atau diblacklist | Sistem menolak pemilihan rekanan dan memblokir penerbitan draf PO sampai status rekanan diaktifkan kembali oleh manajemen. |
| Harga kesepakatan supplier melebihi estimasi harga PR | Sistem menolak penerbitan PO (pelanggaran *Strict Budget Cap*). Bagian Purchasing harus mengajukan revisi PR ke Bagian Keuangan atau mencari rekanan alternatif. |
| Kuantitas yang dimasukkan melebihi sisa kuota PR | Sistem menolak alokasi item melebihi kuota PR yang belum dipesan. |
| Emergency PO melebihi batas Rp 10.000.000 tanpa persetujuan Direksi | Sistem menahan dokumen pada status *Menunggu Persetujuan Direksi* dan tidak dapat diterbitkan menjadi *Issued*. |
| Rekanan pemasok tidak mampu mengirim sisa barang pesanan | Pejabat Purchasing mengeksekusi aksi *Force Close* pada PO dengan mencantumkan alasan ketidaksanggupan vendor; status PO berubah menjadi *Force Closed* dan sisa kuantitas dianggap hangus. |
| Pembatalan pesanan setelah PO berstatus Issued (sebelum barang dikirim) | Pejabat Purchasing melakukan aksi pembatalan resmi (*Cancel/Void*) dengan justifikasi pembatalan; status PO menjadi *Cancelled*, dan kuota kuantitas pada PR dikembalikan (*unreserved*). |
| Barang telah diterima sebagian saat pengajuan pembatalan | Sistem menolak pembatalan penuh PO; pembatalan hanya dapat dilakukan atas sisa kuantitas yang belum diterima melalui mekanisme *Force Close*. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Bagian Purchasing dapat menyusun draf PO dengan menarik item dari satu atau beberapa PR *Approved* untuk supplier yang sama, lengkap dengan rincian harga, diskon, PPN, TOP, dan gudang tujuan. | Completeness |
| AC-02 | Sistem mengizinkan pembentukan Emergency PO tanpa referensi PR dengan pencatatan justifikasi darurat dan rute persetujuan bertingkat. | Completeness |
| AC-03 | Sistem menolak penerbitan item PO apabila harga satuan kesepakatan melebihi harga estimasi pada PR (*Strict Budget Cap*). | Constraint |
| AC-04 | Dokumen PO dengan nilai \(\le \text{Rp 10.000.000}\) dapat disahkan oleh Kepala Purchasing, sedangkan dokumen dengan nilai \(> \text{Rp 10.000.000}\) mewajibkan persetujuan Direksi untuk mencapai status *Issued*. | Correctness |
| AC-05 | Penerbitan PO berstatus *Issued* secara otomatis memperbarui kuantitas pesanan (`Ordered Qty`) pada PR asal dan mengunci dokumen PO dari pengeditan langsung. | Correctness |
| AC-06 | Sistem menyediakan dokumen PO berstatus *Issued* ke dalam antrean referensi penerimaan barang fisik di Bagian Gudang (`PUR-DO`). | Completeness |
| AC-07 | Sistem mendukung eksekusi *Force Close* untuk menutup PO yang tidak dapat dipenuhi sisa kuantitasnya oleh supplier, dengan mencatatkan alasan penutupan dan menghanguskan sisa kuota. | Exception |
| AC-08 | Sistem menolak pembatalan penuh (*Cancel/Void*) atas dokumen PO yang telah mencatatkan penerimaan barang sebagian (`Received Qty > 0`). | Exception |

---

## 10. Out of Scope

- **Pengajuan Kebutuhan Unit**: Permintaan operasional awal dari unit kerja ruangan merupakan tanggung jawab `Material Request` (`PUR-MATREQ`).
- **Otorisasi Pagu Anggaran Pengadaan**: Konsolidasi kebutuhan rumah sakit dan evaluasi anggaran oleh Departemen Keuangan merupakan tanggung jawab `Purchase Request` (`PUR-PURREQ`).
- **Penerimaan Fisik Barang**: Pemeriksaan fisik barang datang, kesesuaian surat jalan, dan pencatatan tanda terima merupakan tanggung jawab `TerimaBrg` (`PUR-DO`).
- **Pencatatan Saldo dan Mutasi Stok**: Perubahan saldo stok fisik di gudang rumah sakit merupakan tanggung jawab domain `Inventory` (`INV-STOK`, `INV-MUTASI`).
- **Faktur Tagihan Rekanan**: Pengelolaan dan verifikasi tagihan komersial dari pemasok merupakan tanggung jawab `Faktur` (`PUR-FAKTUR`).
- **Pencatatan Hutang dan Pembayaran Finansial**: Pengakuan hutang dagang akuntansi dan pencairan kas/bank kepada rekanan berada di luar batas operasional Purchasing (dikelola oleh Akuntansi / Tata Rekening).
