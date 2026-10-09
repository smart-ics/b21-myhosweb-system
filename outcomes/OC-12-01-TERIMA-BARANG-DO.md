# OUTCOME: Terima Barang (DO)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-12-01          |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-09        |

---

## 1. Business Purpose

Terima Barang (DO) memastikan barang obat atau Bahan Medis Habis Pakai (BHP) yang dikirim oleh pemasok berdasarkan Purchase Order (PO) yang telah disetujui dapat diperiksa kesesuaian fisik dan dokumennya, diputuskan penerimaan maupun penolakannya, serta disahkan sebagai dasar pengakuan persediaan rumah sakit secara akurat, tertib, dan dapat diaudit.

Outcome ini menetapkan fakta bisnis bahwa hanya barang yang telah diperiksa dan disahkan oleh pihak yang berwenang yang diakui sebagai persediaan aktif rumah sakit beserta nomor batch/lot, tanggal kedaluwarsa, dan penetapan HPP, sementara setiap ketidaksesuaian atau penolakan terdokumentasi dengan jejak audit yang utuh.

---

## 2. Outcome Statement

Barang obat atau BHP yang dikirim pemasok berdasarkan Purchase Order (PO) yang disetujui **telah diverifikasi terhadap dokumen pengiriman dan pesanan, diputuskan penerimaannya atas seluruh kondisi barang, dan disahkan oleh pihak yang berwenang, sehingga kuantitas barang yang disahkan diterima menjadi dasar penambahan persediaan aktif rumah sakit yang tertelusur beserta nomor batch/lot, tanggal kedaluwarsa, dan penetapan HPP**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Purchasing (`PUR`)** | Pemilik utama proses penerimaan barang pengadaan: mencatat dokumen pengiriman pemasok (surat jalan/DO), memverifikasi kesesuaian fisik terhadap PO yang disetujui, mencatat hasil pemeriksaan fisik dan ketidaksesuaian, mendokumentasikan penolakan barang, serta menerbitkan pengesahan penerimaan barang. |
| **Inventory (`INV`)** | Pemilik pencatatan persediaan: mengakui penambahan saldo persediaan aktif di lokasi gudang yang dituju hanya sebesar kuantitas yang disahkan diterima, mencatat pergerakan mutasi penerimaan stok, menetapkan HPP penerimaan, serta mencatat nomor batch/lot dan tanggal kedaluwarsa barang. |
| **Organisasi (`ORG`)** | Kolaborator organisasi: menyediakan referensi unit kerja gudang penerima dan informasi wewenang personel yang bertindak sebagai pemeriksa serta pengesah penerimaan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PUR-DO` DO Penerimaan Barang | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `PUR-SUPPLIER` Supplier | Purchasing | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Rujukan PO yang Disetujui:** Setiap penerimaan barang wajib mengacu pada Purchase Order (PO) yang berstatus disetujui (*Approved*). Penerimaan tanpa PO yang disetujui dilarang diproses.
- **Hasil Pemeriksaan Tertelusur:** Barang yang datang diverifikasi terhadap rincian PO dan dokumen pengiriman pemasok (surat jalan/DO). Hasil pemeriksaan fisik (kesesuaian item, kemasan, kuantitas, batch, dan tanggal kedaluwarsa) dicatat secara terperinci dan dapat ditelusuri per item.
- **Tindak Lanjut Ketidaksesuaian Berdasar Keputusan Berwenang:** Setiap ketidaksesuaian (kurang, lebih, rusak, mendekati kedaluwarsa, atau salah spesifikasi) dicatat dan ditindaklanjuti berdasarkan keputusan pihak yang berwenang sesuai aturan bisnis terkait, tanpa mengasumsikan perlakuan yang seragam untuk seluruh jenis selisih.
- **Keabsahan Penerimaan Sebagian (*Partial Acceptance*):** Barang yang memenuhi syarat dan disahkan dapat diterima meskipun terdapat barang lain dalam kiriman yang kurang, berlebih, rusak, mendekati kedaluwarsa, atau tidak sesuai. Perlakuan atas masing-masing selisih mengikuti keputusan yang berwenang dan aturan bisnis terkait.
- **Penolakan Terdokumentasi Tanpa Penambahan Stok:** Barang yang ditolak tetap memiliki jejak pemeriksaan dan alasan penolakan yang dapat diaudit, namun tidak diakui sebagai persediaan aktif rumah sakit.
- **Pengesahan Berwenang (*Authorized Sign-Off*):** Penerimaan baru sah setelah diverifikasi dan disahkan oleh pihak yang berwenang. Barang yang masih dalam proses pemeriksaan atau belum mendapatkan keputusan pengesahan dilarang menambah stok aktif.
- **Pengakuan Stok Berdasarkan Kuantitas Disahkan:** Hanya kuantitas barang yang telah disahkan untuk diterima (*Accepted Quantity*) yang menjadi dasar penambahan stok aktif persediaan rumah sakit. Kuantitas PO maupun kuantitas pada surat jalan pemasok tidak otomatis menjadi kuantitas stok.
- **Kewajiban Batch dan Kedaluwarsa:** Nomor batch/lot dan tanggal kedaluwarsa (*expiry date*) wajib tercatat untuk seluruh barang yang disahkan diterima.
- **Penetapan HPP Definitif:** Harga Pokok Penjualan (HPP) atas barang yang diterima ditetapkan pada saat penerimaan disahkan sesuai dengan aturan bisnis perhitungan harga perolehan yang berlaku.
- **Ketertelusuran Menyeluruh:** Catatan penerimaan dapat ditelusuri kembali ke PO rujukan, dokumen pengiriman pemasok, serta hasil pemeriksaannya, termasuk data barang yang ditolak.

---

### 5.2 Required Recorded Information

- Nomor identitas unik dokumen penerimaan barang (*Goods Receipt / DO*);
- Referensi dokumen pengiriman pemasok (nomor dan tanggal surat jalan/DO fisik dari pemasok);
- Referensi Purchase Order (nomor PO yang telah disetujui);
- Identitas pemasok (*Supplier*);
- Tanggal dan waktu kedatangan fisik serta tanggal dan waktu pengesahan penerimaan;
- Identitas unit gudang / lokasi persediaan penerima;
- Rincian item barang yang diperiksa:
  - Identitas master item barang dan satuan ukuran;
  - Kuantitas yang tercantum pada surat jalan pemasok;
  - Kuantitas hasil pemeriksaan fisik;
  - Kuantitas yang disahkan untuk diterima (*Accepted Quantity*);
  - Nomor batch / lot untuk setiap bagian kuantitas yang diterima;
  - Tanggal kedaluwarsa (*expiry date*) untuk setiap bagian kuantitas yang diterima;
  - Nilai HPP yang ditetapkan pada saat pengesahan penerimaan;
- Rincian ketidaksesuaian dan barang ditolak (jika ada):
  - Kuantitas selisih atau kuantitas ditolak (*Rejected Quantity*);
  - Klasifikasi dan alasan penolakan/ketidaksesuaian (cacat kemasan, rusak fisik, batas ED tidak memenuhi ketentuan rumah sakit, kelebihan kuantitas tanpa otorisasi, salah item, dll.);
  - Catatan keputusan pihak yang berwenang atas tindak lanjut selisih/penolakan;
- Bukti verifikasi dan pengesahan:
  - Identitas pemeriksa barang;
  - Identitas pihak/pejabat berwenang yang mengesahkan penerimaan;
- Status akhir dokumen penerimaan (**Disahkan** / *Approved* atau **Ditolak Total** / *Rejected*).

---

### 5.3 Required Business Conditions

- Purchase Order (PO) yang dirujuk berstatus aktif, telah disetujui (*Approved*), dan masih terbuka untuk pemenuhan;
- Pemasok yang melakukan pengiriman sesuai dengan identitas pemasok yang tercantum pada PO;
- Seluruh barang yang disahkan diterima telah lolos verifikasi fisik dan memenuhi persyaratan mutu serta batas minimum masa simpan (*shelf life*) rumah sakit, kecuali terdapat otorisasi khusus dari pihak yang berwenang;
- Penerimaan disahkan oleh personel yang memiliki wewenang otorisasi sebelum stok aktif diakui;
- Kuantitas barang yang disahkan diterima bernilai lebih dari nol (`Accepted Quantity > 0`) untuk penerimaan yang menghasilkan penambahan stok aktif.

---

### 5.4 Completion Proof

- Dokumen Penerimaan Barang (DO) tersimpan secara persisten dengan nomor identitas resmi dan berstatus disahkan (**Disahkan** / *Approved*);
- Catatan mutasi penerimaan persediaan terbentuk di Inventory Domain hanya sebesar kuantitas yang disahkan diterima (`Accepted Quantity`), lengkap dengan nomor batch/lot, tanggal kedaluwarsa, dan HPP yang valid;
- Catatan ketidaksesuaian dan barang ditolak (jika ada) terdokumentasi secara auditabel dengan rincian alasan dan keputusan pihak yang berwenang;
- Seluruh catatan penerimaan tertaut secara utuh ke Purchase Order (PO) rujukan dan dokumen pengiriman pemasok.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kiriman fisik barang obat atau BHP dari pemasok tiba di gudang rumah sakit bersama dokumen pengiriman pemasok (surat jalan/DO) dengan merujuk pada Purchase Order (PO) yang telah disetujui.

### End

- **Jalur Pengesahan Penerimaan:** Berakhir ketika pemeriksaan fisik selesai, seluruh ketidaksesuaian diputuskan, penerimaan disahkan oleh pihak yang berwenang, dan kuantitas barang yang disahkan diterima telah diakui sebagai dasar penambahan persediaan aktif gudang rumah sakit beserta batch, tanggal kedaluwarsa, dan penetapan HPP.
- **Jalur Penolakan Total:** Berakhir ketika seluruh kiriman barang ditolak pada saat pemeriksaan fisik, alasan penolakan dan bukti pemeriksaan disahkan oleh pihak berwenang sebagai penolakan total tanpa adanya penambahan stok aktif persediaan rumah sakit, dengan catatan penolakan tetap tertaut pada PO.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Mandatori Rujukan PO Sah:** Setiap transaksi penerimaan barang wajib mengacu pada Purchase Order (PO) yang telah disetujui (*Approved*). Penerimaan tanpa PO sah dilarang diproses.
2. **Independensi Pemeriksaan Fisik:** Kuantitas dan kondisi barang yang diterima wajib ditentukan melalui verifikasi fisik nyata. Kuantitas PO maupun angka pada surat jalan pemasok dilarang disalin otomatis menjadi kuantitas penerimaan.
3. **Pemisahan Pengakuan Stok dari Kedatangan Fisik:** Kedatangan fisik barang atau pencatatan draf penerimaan tidak serta-merta menambah persediaan aktif rumah sakit. Barang yang masih dalam proses pemeriksaan atau belum memperoleh keputusan pengesahan dilarang menambah stok aktif.
4. **Plafon Pengakuan Persediaan:** Kuantitas penambahan stok aktif di gudang wajib sama persis dengan kuantitas yang disahkan untuk diterima (*Accepted Quantity*). Kuantitas yang ditolak atau masih berselisih dilarang masuk ke stok aktif.
5. **Kewajiban Identitas Batch dan Kedaluwarsa:** Nomor batch/lot dan tanggal kedaluwarsa (*expiry date*) wajib tercatat lengkap untuk seluruh barang yang disahkan diterima. Pengesahan penerimaan dilarang dilakukan jika data batch atau tanggal kedaluwarsa belum lengkap.
6. **Penetapan HPP Definitif:** Harga Pokok Penjualan (HPP) atas barang yang diterima ditetapkan pada saat penerimaan disahkan sesuai aturan bisnis perhitungan biaya perolehan yang berlaku, dan menjadi nilai dasar perolehan persediaan.
7. **Legalitas Penerimaan Parsial (*Partial Acceptance*):** Adanya barang yang kurang, berlebih, rusak, mendekati kedaluwarsa, atau tidak sesuai dalam satu pengiriman tidak membatalkan penerimaan atas barang lain yang telah memenuhi syarat dan disahkan.
8. **Jejak Audit Penolakan Barang:** Barang yang ditolak wajib memiliki pencatatan kuantitas dan alasan penolakan yang rinci serta dapat diaudit, dengan tetap tertaut ke PO rujukan.
9. **Kewenangan Pengesahan:** Pengesahan penerimaan hanya sah jika dilakukan oleh pihak/pejabat yang memiliki kewenangan otorisasi sesuai kebijakan rumah sakit.
10. **Finalitas Catatan Pengesahan:** Dokumen penerimaan yang telah disahkan menjadi catatan resmi yang tidak dapat diubah secara langsung. Koreksi atas kesalahan administratif pasca-pengesahan harus melalui prosedur korektif formal tersendiri dengan riwayat lama dipertahankan.
11. **Ketidaktergantungan Status Hukum Kepemilikan:** Pengesahan penerimaan mencatat pengakuan fisik dan operasional persediaan internal rumah sakit, serta tidak secara otomatis menyatakan terjadinya peralihan kepemilikan yuridis (*legal title*), yang bergantung pada perjanjian kontrak komersial pengadaan yang berlaku.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Kiriman barang tiba tanpa rujukan PO yang disetujui** | Penerimaan ditolak atau ditangguhkan; pemeriksaan fisik tidak dapat disahkan sebagai penerimaan resmi hingga PO yang sah dan disetujui tersedia. |
| **Kuantitas kiriman fisik kurang dari pesanan PO (*Under-delivery*)** | Barang fisik yang ada tetap diperiksa. Bagian yang memenuhi syarat disahkan diterima sebesar kuantitas fisik yang lolos (*Accepted Quantity*), kekurangan kuantitas dicatat sebagai selisih kurang (*shortage*) dan ditindaklanjuti berdasarkan keputusan pihak berwenang. |
| **Kuantitas kiriman fisik melebihi pesanan PO (*Over-delivery*)** | Kelebihan kuantitas tidak otomatis diterima. Kelebihan dapat ditolak langsung atau diterima bersyarat hanya jika terdapat keputusan otorisasi dari pihak yang berwenang. Kuantitas tanpa otorisasi dilarang menambah stok aktif. |
| **Kondisi fisik barang rusak, kemasan cacat, atau tidak sesuai spesifikasi PO** | Barang dipisahkan dan diputuskan penolakannya. Kuantitas yang ditolak dicatat dengan alasan penolakan yang spesifik, tidak diakui ke dalam stok aktif, dan disimpan jejak pemeriksaannya. |
| **Tanggal kedaluwarsa (ED) berada di bawah batas minimum toleransi rumah sakit** | Barang ditolak sesuai kebijakan masa simpan (*shelf life*), kecuali ada otorisasi khusus atau dispensasi tertulis dari pihak yang berwenang sebelum pengesahan. |
| **Barang fisik berbeda jenis/spesifikasi dengan yang tertera pada PO** | Barang dinyatakan salah kirim dan ditolak, kecuali ada persetujuan substitusi resmi yang disahkan oleh pejabat berwenang sebelum penerimaan disahkan. |
| **Nomor batch/lot atau tanggal kedaluwarsa tidak tercantum pada fisik barang** | Pengesahan penerimaan ditahan hingga konfirmasi sah diperoleh dari pemasok, atau barang diputuskan untuk ditolak jika ketertelusuran batch/ED tidak dapat dipastikan. |
| **Seluruh kiriman barang ditolak (*Total Rejection*)** | Dokumen penerimaan disahkan sebagai penolakan total beserta alasan lengkapnya; tidak ada penambahan stok aktif (`Accepted Quantity = 0`), dan jejak penolakan tetap tertaut pada PO. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Penerimaan barang hanya dapat dibuat dan diproses jika merujuk pada Purchase Order (PO) yang berstatus disetujui (*Approved*). | Constraint |
| **AC-02** | Catatan penerimaan menyajikan hasil verifikasi fisik per item terhadap rincian PO dan dokumen pengiriman pemasok (surat jalan/DO). | Completeness |
| **AC-03** | Setiap ketidaksesuaian pengiriman (kurang, lebih, rusak, salah spesifikasi, atau ED di bawah toleransi) terdokumentasi lengkap beserta keputusan tindak lanjut dari pihak yang berwenang. | Correctness |
| **AC-04** | Kiriman dengan pemenuhan sebagian (*partial delivery*) dapat disahkan untuk item yang memenuhi syarat tanpa terhambat oleh item lain yang ditolak atau berselisih. | Completeness |
| **AC-05** | Barang yang ditolak tercatat kuantitas dan alasan penolakannya secara auditabel, serta terbukti tidak menambah saldo persediaan aktif rumah sakit. | Constraint |
| **AC-06** | Kiriman barang yang masih dalam proses pemeriksaan atau belum disahkan terbukti tidak menambah saldo persediaan aktif gudang. | Constraint |
| **AC-07** | Penambahan saldo stok aktif di gudang persediaan terbukti hanya terjadi sebesar kuantitas yang disahkan untuk diterima (*Accepted Quantity*), bukan sebesar kuantitas PO maupun kuantitas surat jalan pemasok. | Correctness |
| **AC-08** | Setiap item barang yang disahkan diterima mencatat nomor batch/lot dan tanggal kedaluwarsa (*expiry date*) yang valid. | Constraint |
| **AC-09** | Nilai HPP ditetapkan secara definitif pada saat penerimaan disahkan sesuai aturan bisnis perhitungan biaya perolehan yang berlaku. | Correctness |
| **AC-10** | Catatan penerimaan barang, termasuk rincian barang yang disahkan diterima maupun yang ditolak, dapat ditelusuri kembali secara utuh ke PO rujukan dan dokumen pengiriman pemasok. | Completeness |
| **AC-11** | Dokumen penerimaan yang telah disahkan berstatus final dan tidak dapat diubah secara langsung melalui alur operasional penerimaan normal. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Persetujuan dan Perubahan Purchase Order (PO):** Siklus pembuatan, persetujuan, amandemen, atau pembatalan PO → **Purchasing Domain** (`PUR-PO`).
- **Pengelolaan Pesanan Tunda (*Backorder*) dan Penutupan PO:** Kebijakan pemenuhan sisa pesanan PO yang belum terkirim serta penutupan administratif PO → **Purchasing Domain** (`PUR-PO`).
- **Verifikasi Faktur, Tagihan, dan Rekonsiliasi Finansial:** Pencocokan faktur tagihan pemasok (*three-way matching*), utang dagang, syarat pembayaran, dan penyelesaian selisih komersial/diskon faktur → Domain **Tata Rekening** dan **Purchasing** (`PUR-FAKTUR`).
- **Retur Pembelian sebagai Proses Bisnis Mandiri:** Pengembalian fisik barang yang telah masuk persediaan aktif atau penerbitan nota retur pembelian (*Purchase Return*) kepada pemasok → **Purchasing Domain** (`PUR-RETURN` / **OC-12-05 Retur Beli**).
- **Pengeluaran Persediaan dan Mekanisme Pengambilan (FEFO/FIFO):** Pengambilan barang dari gudang, distribusi persediaan antar-unit, atau dispensing pelayanan → Domain **Inventory** (`INV-MUTASI`, `INV-PAKAI`) dan **Apotek** (`APT-DISPENSING`).
- **Penetapan Perpindahan Kepemilikan Hukum (*Legal Title*):** Penentuan saat peralihan kepemilikan yuridis atas barang, yang sepenuhnya diatur oleh klausul kontrak komersial pengadaan dan ketentuan hukum yang berlaku.
- **Detail Desain Teknis dan Antarmuka Pengguna:** Skema tabel database, struktur entitas kode, signature API/Command/Event, mekanisme transaksi/atomicity/idempotensi database, sinkronisasi dual-write teknis, dan rancangan antarmuka pengguna (UI).
