# OUTCOME: Purchase Request (PR)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-13-03     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-09   |

---

## 1. Business Purpose

Pengelolaan pengadaan material dan barang rumah sakit memerlukan mekanisme pengendalian internal yang tertib, transparan, dan akuntabel sebelum komitmen pembelian formal diterbitkan kepada pemasok (*supplier*).

***Purchase Request* (PR)** adalah dokumen resmi internal rumah sakit yang digunakan untuk mengajukan kebutuhan pembelian barang kepada pihak manajemen atau pejabat yang berwenang, sebelum proses pemesanan kepada *supplier* dilakukan.

PR berfungsi sebagai dokumen pengajuan resmi yang memuat rincian kebutuhan pembelian, kuantitas rencana beli, estimasi biaya, justifikasi pengadaan, dan usulan vendor. PR digunakan sebagai dasar evaluasi, verifikasi kelayakan, dan persetujuan internal rumah sakit.

PR secara tegas **bukan *Purchase Order* (PO)**, tidak dengan sendirinya mengikat rumah sakit secara hukum maupun komersial kepada *supplier*, dan tidak mencakup proses pemesanan maupun penerimaan barang. Dokumen PR yang telah disetujui (*Approved*) menjadi referensi resmi bagi tahap pengadaan berikutnya, termasuk penerbitan Purchase Order sesuai prosedur operasional rumah sakit.

---

## 2. Outcome Statement

Satu dokumen pengajuan **Purchase Request (PR)** resmi internal rumah sakit yang berbasis rekomendasi Forecasting **telah berhasil dibentuk, divalidasi kelengkapannya, dan diputuskan status akhirnya (Approved, Rejected, atau Cancelled) sebagai rekaman persisten (*persisted record*), merekam rincian item kebutuhan, kuantitas rencana beli beserta justifikasi penyesuaian, estimasi harga satuan dan total biaya, usulan vendor, keterlacakan unit asal dan rekomendasi Forecasting sumber, serta riwayat keputusan persetujuan secara transparan, siap dijadikan acuan resmi bagi inisiasi penerbitan Purchase Order (PO).**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Purchasing** | **Domain pemilik siklus pengadaan internal**: Mengelola pembentukan dokumen PR (`PUR-PURREQ`), mengonsumsi rekomendasi dari dokumen Forecasting (`PUR-FORECAST`), mencatat usulan vendor terdaftar maupun baru (`PUR-SUPPLIER`), mengelola alokasi kuantitas rekomendasi, memfasilitasi proses persetujuan oleh pejabat berwenang, dan menyediakan referensi kebutuhan yang sah bagi penerbitan Purchase Order (`PUR-PO`). |
| **Inventory** | **Penyedia master data material**: Menyediakan data katalog item master aktif, deskripsi barang, kategori/kelompok komoditas material, dan satuan ukuran standar (*Unit of Measure* / UoM) melalui `INV-MASTER`. |
| **Organisasi** | **Penyedia struktur unit kerja dan wewenang pengguna**: Menyediakan identitas unit kerja pemohon/asal kebutuhan (`ORG-LAYANAN`) serta memvalidasi hak akses dan wewenang pengguna pembuat PR dan pejabat penyetujui (*approver*). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PUR-PURREQ` Purchase Request | Purchasing | Known |
| `PUR-FORECAST` Forecasting & Rekomendasi Pengadaan | Purchasing | Capability Candidate |
| `PUR-SUPPLIER` Supplier | Purchasing | Known |
| `PUR-PO` Purchase Order | Purchasing | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Catatan Tata Kelola Arsitektur:**  
> Kapabilitas `PUR-FORECAST` merupakan kapabilitas analitis perencanaan yang diidentifikasi pada `OC-13-02 Forecasting` dan tercatat sebagai **Capability Candidate** menunggu siklus pembaruan `DOMAIN-CATALOG.md`. Kapabilitas `PUR-PURREQ` bertindak sebagai kapabilitas inti yang mengelola siklus hidup dokumen Purchase Request. Kapabilitas `PUR-PO` berposisi sebagai konsumen hilir (*downstream*) yang menerima PR berstatus *Approved*.

---

## 5. Outcome Specification

### 5.1 Required Business Facts

- **Sifat Dokumen Pengajuan Internal (Bukan PO):** PR merupakan instrumen pengajuan kebutuhan internal rumah sakit. Dokumen ini tidak mengikat komitmen finansial/hukum terhadap pihak eksternal (*supplier*), tidak memesan barang, dan tidak mengubah saldo fisik persediaan di gudang.
- **Basis Tunggal Pembentukan (Forecasting-Driven):** PR hanya dapat dibuat berdasarkan rekomendasi pengadaan yang sah dari dokumen Forecasting (`OC-13-02`). Pembentukan PR secara bebas tanpa referensi rekomendasi Forecasting dilarang.
- **Konsolidasi Multi-Rekomendasi dan Lintas Unit:** Satu PR dapat menggabungkan beberapa rekomendasi Forecasting asalkan seluruh rekomendasi tersebut termasuk dalam kelompok atau fungsi pengadaan yang sama (misal: kelompok Farmasi/Obat, BMHP Medis, atau Bahan Non-Medis/Umum), meskipun berasal dari unit kerja pemohon yang berbeda.
- **Keterlacakan Penuh Item ke Sumber (End-to-End Traceability):** Setiap baris item yang diajukan dalam PR wajib dapat ditelusuri secara spesifik ke dokumen Forecasting sumber, baris rekomendasi sumber, dan unit kerja asalnya.
- **Snapshot Rekomendasi (Frozen Baseline):** Dokumen PR menyimpan rekaman *snapshot* dari data rekomendasi Forecasting yang digunakan pada saat PR dibuat. Perubahan atau revisi pada dokumen Forecasting di kemudian hari tidak secara otomatis mengubah isi dokumen PR yang telah terbentuk.
- **Penyesuaian Kuantitas Disertai Justifikasi Wajib:** Kuantitas rencana beli dalam PR dapat disesuaikan (dinaikkan atau diturunkan) dari kuantitas rekomendasi Forecasting. Setiap penyesuaian kuantitas wajib disertai alasan justifikasi tertulis yang jelas.
- **Pencegahan Pengajuan Kuantitas Berulang (Anti-Duplicate Submission):** Rekomendasi Forecasting hanya dapat digunakan kembali untuk kebutuhan kuantitas yang belum tercakup dalam PR aktif sebelumnya. Sistem mencegah pengajuan berulang atas kuantitas rekomendasi yang sama.
- **Siklus Alokasi Kuantitas Rekomendasi (Allocation Lifecycle):**
  1. *Alokasi saat Pembuatan:* Kuantitas rekomendasi Forecasting dialokasikan secara eksklusif segera setelah PR dibuat (berstatus draf).
  2. *Proteksi Selama PR Aktif:* Kuantitas yang telah dialokasikan tidak dapat digunakan kembali untuk PR lain selama dokumen PR tersebut masih berstatus aktif (`Draft`, `Submitted / Awaiting Approval`, atau `Returned for Revision`).
  3. *Pertahanan Alokasi Saat Revisi:* Ketika PR dikembalikan oleh approver untuk diperbaiki (*Returned for Revision*), alokasi kuantitas tetap berlaku penuh dan tidak dilepas.
  4. *Pelepasan Alokasi Saat Pembatalan / Penolakan:* Apabila PR dibatalkan oleh pengaju (*Cancelled*) atau ditolak oleh approver (*Rejected*), seluruh alokasi kuantitas rekomendasi dilepas kembali ke *pool* kebutuhan sehingga dapat diajukan kembali pada PR berikutnya.
  5. *Pengakhiran Batas Tanggung Jawab Alokasi:* Tanggung jawab kapabilitas `PUR-PURREQ` (OC-13-03) atas tata kelola alokasi kuantitas rekomendasi berakhir saat dokumen PR disetujui (*Approved*). Pengelolaan kuantitas dan penyesuaian kebutuhan setelah persetujuan dialihkan sepenuhnya ke proses pengadaan hilir (`PUR-PO`).
- **Kelengkapan Estimasi Harga & Biaya Total:** Setiap item wajib memiliki estimasi harga satuan yang valid sebelum PR dapat diajukan untuk persetujuan. Total estimasi biaya PR dihitung secara otomatis sebagai akumulasi estimasi biaya seluruh item. PR mencatat estimasi biaya sebagai informasi evaluasi internal, tanpa melakukan validasi kecukupan anggaran.
- **Ketentuan Usulan Vendor:**
  - Usulan vendor dapat berupa vendor yang sudah terdaftar dalam master supplier (`PUR-SUPPLIER`) maupun usulan vendor baru.
  - Usulan vendor boleh belum ditentukan saat PR masih berupa draf, tetapi wajib diisi sebelum PR diajukan untuk persetujuan.
  - PR tidak memvalidasi legalitas vendor baru atau mendaftarkannya secara otomatis ke master supplier; proses pendaftaran dan verifikasi vendor baru mengikuti kebijakan rumah sakit di luar batas outcome ini.
- **Otorisasi Pembuat:** Pembuatan dan pengajuan PR hanya dapat dilakukan oleh pengguna yang memiliki kewenangan akses untuk unit atau fungsi terkait.
- **Mekanisme Persetujuan Tunggal Menyeluruh (Single-Approver, Whole-Document Decision):**
  - PR yang diajukan diproses oleh satu *approver* berwenang yang ditentukan berdasarkan kebijakan rumah sakit.
  - Keputusan approver berlaku untuk **keseluruhan dokumen PR**, bukan persetujuan parsial per item.
  - Tiga hasil keputusan approver:
    - `Approved`: PR disetujui secara penuh, proses PR selesai dan siap diteruskan ke PO.
    - `Rejected`: PR ditolak dan proses dokumen PR tersebut berakhir permanen.
    - `Returned for Revision`: PR dikembalikan kepada pengaju untuk diperbaiki.
- **Kewajiban Alasan Keputusan:** Alasan keputusan **wajib diberikan** apabila PR ditolak (*Rejected*) atau dikembalikan untuk revisi (*Returned for Revision*). Alasan persetujuan bersifat opsional.
- **Penguncian Dokumen Selama Pengajuan (*Document Locking*):** PR yang sedang menunggu keputusan (*Submitted / Awaiting Approval*) terkunci dan tidak dapat diedit langsung oleh pengaju. Perbaikan data hanya dapat dilakukan setelah dokumen dikembalikan oleh approver (*Returned for Revision*).
- **Pembatalan oleh Pengaju (*Cancellation by Submitter*):** Pengaju dapat membatalkan PR selama approver belum memberikan keputusan resmi. Alasan pembatalan wajib dicatat. Dokumen yang dibatalkan tersimpan dalam riwayat audit (*audit trail*), tidak dihapus fisik, dan alokasi kuantitasnya dilepas kembali.
- **Finalitas Dokumen Ditolak (*Rejection Finality*):** Dokumen PR yang berstatus `Rejected` berakhir permanen dan tidak dapat diedit atau diajukan ulang melalui nomor dokumen yang sama. Kebutuhan yang masih diperlukan harus diajukan melalui pembuatan dokumen PR baru berdasarkan rekomendasi Forecasting yang relevan. Riwayat PR yang ditolak tetap dapat ditelusuri.

---

### 5.2 Required Recorded Information

#### A. Informasi Header Dokumen PR
- **Identifikasi Dokumen:** Nomor unik PR (misal: `PR-YYYYMM-XXXX`).
- **Tanggal & Waktu Dokumen:** Timestamp pembuatan, tanggal pengajuan, timestamp keputusan, atau timestamp pembatalan.
- **Aktor Pengaju (*Submitter*):** Identitas pengguna pembuat (*User ID*, Nama Lengkap) dan unit kerja pengguna.
- **Kelompok / Fungsi Pengadaan:** Kategori kelompok pengadaan konsolidasi (misal: Obat & Farmasi, BMHP Medis, Logistik Umum/Non-Medis).
- **Status Dokumen PR:** Status terkini dalam siklus hidup:
  - `Draft` — PR dalam proses penyusunan/penyuntingan awal.
  - `Submitted / Awaiting Approval` — PR diajukan dan sedang menunggu evaluasi approver.
  - `Returned for Revision` — PR dikembalikan oleh approver untuk diperbaiki oleh pengaju.
  - `Approved` — PR disetujui resmi oleh approver.
  - `Rejected` — PR ditolak secara permanen oleh approver.
  - `Cancelled` — PR dibatalkan secara mandiri oleh pengaju sebelum diputus approver.
- **Usulan Vendor (*Proposed Vendor*):**
  - Tipe Vendor: `Registered Vendor` atau `New Proposed Vendor`.
  - Identitas Vendor: Kode Vendor dan Nama Vendor (jika terdaftar pada `PUR-SUPPLIER`), atau Nama Usulan Vendor beserta kontak awal (jika usulan baru).
- **Justifikasi Pengadaan Umum:** Keterangan umum mengenai latar belakang pengajuan pembelian barang.
- **Total Estimasi Biaya PR:** Akumulasi nilai finansial rencana pengadaan ($\sum \text{Subtotal Estimasi Item}$), dicatat dalam mata uang operasional rumah sakit.
- **Informasi Evaluasi / Keputusan Persetujuan:**
  - Identitas Approver (*User ID*, Nama Lengkap, Peran/Jabatan).
  - Tanggal & Waktu Keputusan.
  - Hasil Keputusan (`Approved`, `Rejected`, `Returned for Revision`).
  - Alasan Keputusan (wajib untuk *Rejected* dan *Returned for Revision*; opsional untuk *Approved*).
- **Informasi Pembatalan Dokumen (bila dibatalkan):**
  - Identitas Pengguna Pembatal.
  - Tanggal & Waktu Pembatalan.
  - Alasan Pembatalan (wajib dicatat).
- **Jejak Audit (*Audit Trail*):** Catatan riwayat seluruh perubahan status dokumen, timestamp setiap transisi, dan aktor penanggung jawab.

#### B. Informasi Rincian Baris Item (*Line Items*)
- **Nomor Urut Item:** Penomoran baris item dalam dokumen PR.
- **Identitas Material:**
  - Kode Item dan Nama Material (sesuai master katalog `INV-MASTER`).
  - Kategori / Golongan Material.
  - Satuan Ukuran Rencana Beli (*Unit of Measure* / UoM).
- **Informasi Sumber Kebutuhan:**
  - Unit Kerja Asal Kebutuhan (Kode dan Nama Unit Layanan dari `ORG-LAYANAN`).
  - Referensi Dokumen Forecasting Sumber (Nomor Dokumen Forecasting dari `OC-13-02`).
  - Referensi Baris Rekomendasi Sumber (ID unik rekomendasi item forecasting).
- **Kuantitas & Penyesuaian:**
  - Kuantitas Rekomendasi Forecasting Asal (*Snapshot Quantity*).
  - Kuantitas Rencana Beli PR (*Requested PR Quantity*, nilai $> 0$).
  - Selisih Kuantitas Penyesuaian ($\Delta Q = \text{Kuantitas PR} - \text{Kuantitas Snapshot}$).
  - Justifikasi Penyesuaian Kuantitas (wajib diisi apabila $\Delta Q \ne 0$).
- **Nilai Estimasi Keuangan Item:**
  - Estimasi Harga Satuan (*Estimated Unit Price*, nilai $> 0$, wajib sebelum diajukan).
  - Subtotal Estimasi Biaya Item ($\text{Kuantitas PR} \times \text{Estimasi Harga Satuan}$).
- **Catatan Spesifikasi Item:** Keterangan teknis, merk yang disarankan, atau instruksi kemasan khusus (opsional).

---

### 5.3 Required Business Conditions

- **Keabsahan Sumber Rekomendasi:** Seluruh item yang dipilih bersumber dari dokumen Forecasting yang berstatus final (`Finalized` pada `OC-13-02`).
- **Ketersediaan Alokasi Kebutuhan:** Kuantitas rekomendasi yang ditarik ke dalam PR memiliki sisa kuantitas kebutuhan yang belum dialokasikan pada PR aktif lain.
- **Keseragaman Fungsi Pengadaan:** Seluruh rekomendasi yang dikonsolidasikan ke dalam satu PR berada dalam kelompok/fungsi pengadaan yang seragam.
- **Kelengkapan Data Sebelum Pengajuan (*Pre-Submission Completeness*):**
  - Seluruh baris item memiliki kuantitas rencana beli valid ($> 0$).
  - Setiap penyesuaian kuantitas terhadap kuantitas rekomendasi memiliki justifikasi tertulis.
  - Seluruh baris item memiliki estimasi harga satuan yang valid ($> 0$).
  - Usulan vendor (terdaftar atau usulan baru) telah dicantumkan pada dokumen PR.
  - Justifikasi pengadaan umum telah diisi.
- **Validitas Hak Akses:** Pengguna pembuat dan pengaju terverifikasi memiliki wewenang akses untuk unit kerja dan fungsi pengadaan terkait.
- **Wewenang Pejabat Penyetuju (*Approver Authority*):** Approver yang memproses persetujuan memiliki wewenang resmi sesuai ketentuan kebijakan rumah sakit.
- **Kewajiban Alasan Penolakan/Pengembalian:** Approver tidak dapat mengeksekusi keputusan *Rejected* atau *Returned for Revision* tanpa menginput alasan keputusan secara tertulis.
- **Ketiadaan Modifikasi Saat Menunggu Putusan:** Selama PR berstatus `Submitted / Awaiting Approval`, sistem menjamin data tidak dapat diubah oleh pengaju maupun pengguna lain selain aksi penetapan keputusan oleh approver.

---

### 5.4 Completion Proof

- Dokumen Purchase Request tersimpan secara persisten dengan nomor identifikasi unik, snapshot rekomendasi sumber, rincian baris item, estimasi total biaya, dan status definitif.
- Dokumen yang disetujui (**`Approved`**) memuat tanda otorisasi approver resmi, catatan waktu persetujuan, dan terkunci secara permanen, siap dibaca serta dirujuk oleh proses pembuatan Purchase Order (`OC-13-04`).
- Dokumen yang berstatus terminasi akhir (**`Rejected`** atau **`Cancelled`**) tersimpan lengkap dalam riwayat dokumen bersama alasan tertulis, dan seluruh alokasi kuantitas rekomendasi sumber terbukti telah dilepas kembali ke *pool* kebutuhan.
- Rekaman *audit trail* mencatat seluruh perjalanan status dokumen dari pembuatan draf hingga status akhir secara kronologis dan tidak dapat diubah (*immutable*).

---

## 6. Outcome Boundary

### Start
Dimulai ketika staf unit atau petugas pengadaan terotorisasi menginisiasi pembentukan dokumen Purchase Request dengan memilih satu atau beberapa rekomendasi pengadaan dari dokumen Forecasting (`OC-13-02`) yang berstatus final dalam kelompok pengadaan yang sama, yang secara otomatis mengalokasikan kuantitas rekomendasi tersebut.

### End
Berakhir pada salah satu dari dua kondisi penyelesaian permanen berikut:
1. **Disetujui (*Approved*):** Dokumen PR disetujui secara menyeluruh oleh approver berwenang, seluruh data terkunci sebagai dokumen resmi internal rumah sakit, dan siap dijadikan dasar penerbitan Purchase Order (`OC-13-04`); atau
2. **Dibatalkan / Ditolak (*Cancelled / Rejected*):** Dokumen PR dibatalkan oleh pengaju sebelum diputus, atau ditolak secara menyeluruh oleh approver, di mana proses dokumen berakhir permanen, riwayat dokumen diarsipkan untuk penelusuran audit, dan seluruh alokasi kuantitas rekomendasi dilepas kembali untuk pengajuan berikutnya.

---

## 7. Business Constraints

> Aturan bisnis mutlak yang wajib dipatuhi pada Outcome ini.

1. **Bukan Purchase Order dan Bukan Komitmen Finansial Eksternal:** PR murni dokumen pengajuan internal rumah sakit. Dokumen ini **dilarang menerbitkan Purchase Order ke supplier, dilarang menimbulkan kewajiban utang piutang usaha rumah sakit, dan dilarang mengubah saldo fisik persediaan di gudang**.
2. **Eksklusivitas Sumber Berbasis Rekomendasi Forecasting:** Dokumen PR hanya dapat dibentuk dari rekomendasi pengadaan pada dokumen Forecasting (`OC-13-02`). Pembentukan item PR secara mandiri tanpa referensi baris rekomendasi forecasting dilarang.
3. **Syarat Keseragaman Kelompok Pengadaan:** Konsolidasi multi-rekomendasi dan lintas unit dalam satu PR hanya sah apabila seluruh rekomendasi berada dalam kelompok/fungsi pengadaan yang sama. Penggabungan komoditas yang berbeda kelompok pengadaannya dilarang.
4. **Keterlacakan Menyeluruh ke Sumber (*End-to-End Traceability*):** Setiap baris item PR wajib memelihara referensi persisten ke dokumen forecasting sumber, nomor baris rekomendasi, dan unit kerja asal.
5. **Immutabilitas Snapshot Rekomendasi:** PR menyimpan *snapshot* data rekomendasi saat PR dibuat. Pembaruan data atau revisi dokumen forecasting di kemudian hari dilarang mengubah data PR yang sedang berjalan atau sudah disahkan secara otomatis.
6. **Kewajiban Justifikasi Penyesuaian Kuantitas:** Pengguna diizinkan menyesuaikan kuantitas beli dari angka rekomendasi forecasting, namun setiap penyesuaian kuantitas ($\Delta Q \ne 0$) **wajib disertai justifikasi tertulis**.
7. **Pencegahan Pengajuan Berulang (*Anti-Duplicate Protection*):** Kuantitas rekomendasi yang telah dialokasikan pada PR aktif dilarang digunakan untuk pembentukan PR lain. Rekomendasi hanya dapat digunakan kembali sebesar sisa kuantitas yang belum diajukan.
8. **Integritas Alokasi Kuantitas Selama Siklus Hidup:**
   - Alokasi kuantitas terbentuk saat PR dibuat.
   - Alokasi kuantitas **tetap dipertahankan** saat PR berstatus `Returned for Revision`.
   - Alokasi kuantitas **wajib dilepas** kembali saat PR berstatus `Cancelled` atau `Rejected`.
9. **Batas Tanggung Jawab Alokasi OC-13-03:** Tanggung jawab outcome ini atas alokasi kuantitas rekomendasi berakhir begitu dokumen PR berstatus `Approved`. Perubahan kuantitas atau pembatalan kebutuhan pasca-persetujuan ditangani oleh proses pengadaan lanjutan (`PUR-PO`) dan berada di luar batas outcome ini.
10. **Kewajiban Estimasi Harga Sebelum Pengajuan:** Setiap baris item wajib memiliki estimasi harga satuan ($> 0$) agar PR dapat diajukan (*Submitted*). Dilarang mengajukan PR dengan item yang tidak memiliki estimasi harga.
11. **Pemisahan Validasi Kecukupan Anggaran:** Outcome ini mencatat total estimasi biaya untuk kebutuhan evaluasi internal. Dokumen PR **tidak melakukan validasi kecukupan plafon anggaran dan tidak mencakup proses otorisasi anggaran keuangan**.
12. **Kewajiban Usulan Vendor Sebelum Pengajuan:** Usulan vendor boleh kosong saat PR masih berupa draf, tetapi **wajib diisi sebelum PR diajukan untuk persetujuan**.
13. **Independensi Master Vendor Baru:** Usulan vendor baru tidak otomatis didaftarkan ke master supplier (`PUR-SUPPLIER`) oleh outcome ini. Verifikasi dan registrasi vendor baru mengikuti tata kelola domain Purchasing secara terpisah.
14. **Keputusan Menyeluruh oleh Approver Tunggal (*Whole-Document, Single Approver*):** Keputusan persetujuan diproses oleh satu approver berwenang dan berlaku untuk **keseluruhan dokumen PR**. Sistem melarang persetujuan parsial per item (*no partial approval*).
15. **Kewajiban Alasan Keputusan Penolakan & Pengembalian:** Approver dilarang menetapkan status `Rejected` atau `Returned for Revision` tanpa mencantumkan alasan keputusan tertulis.
16. **Penguncian Dokumen Selama Evaluasi:** PR berstatus `Submitted / Awaiting Approval` terkunci secara mutlak (*read-only*) bagi pengaju. Perbaikan dokumen hanya dapat dilakukan apabila dokumen telah resmi dikembalikan oleh approver (`Returned for Revision`).
17. **Ketentuan Hak Pembatalan Pengaju:** Pengaju hanya dapat membatalkan PR selama dokumen belum diputuskan oleh approver. Pembatalan wajib disertai alasan dan tidak menghapus fisik dokumen dari database (*audit-preserved*).
18. **Finalitas Terminasi Dokumen yang Ditolak:** PR yang ditolak (`Rejected`) berakhir permanen dan tidak dapat diajukan ulang melalui dokumen yang sama. Pemenuhan kebutuhan harus ditempuh dengan menerbitkan dokumen PR baru.

---

## 8. Business Exceptions

> Kondisi pengecualian bisnis dan perilaku yang diharapkan dari sistem.

| Exception | Expected Behavior |
|-----------|-------------------|
| Rekomendasi Forecasting yang dipilih sudah habis dialokasikan pada PR aktif lain | Sistem menolak penambahan item ke dalam PR dan menampilkan notifikasi bahwa kuantitas rekomendasi telah terpakai penuh pada pengajuan PR aktif lain. |
| Pengguna mencoba menggabungkan rekomendasi Forecasting dari kelompok pengadaan yang berbeda dalam satu PR | Sistem menolak konsolidasi item dan membatasi pemilihan hanya pada rekomendasi dalam kelompok/fungsi pengadaan yang sama. |
| Pengguna mengubah kuantitas rencana beli dari kuantitas rekomendasi namun tidak mengisi justifikasi | Sistem menolak penyimpanan atau pengajuan item hingga teks justifikasi penyesuaian kuantitas diisi secara lengkap. |
| Pengguna mencoba mengajukan PR (*Submit*) yang memuat item tanpa estimasi harga satuan | Sistem memblokir pengajuan dan menampilkan pesan validasi bahwa estimasi harga satuan wajib diisi untuk seluruh item. |
| Pengguna mencoba mengajukan PR (*Submit*) tanpa mencantumkan usulan vendor | Sistem memblokir pengajuan dan mewajibkan pengguna memilih vendor terdaftar atau menginput usulan vendor baru. |
| Pengaju mencoba menyunting data PR saat dokumen sedang berstatus `Submitted / Awaiting Approval` | Sistem menolak aksi penyuntingan (*read-only lock*) dan menginformasikan bahwa dokumen sedang menunggu keputusan approver. |
| Approver mengeksekusi penolakan (*Reject*) atau pengembalian revisi (*Return for Revision*) tanpa menginput alasan keputusan | Sistem memblokir penetapan keputusan hingga kolom alasan keputusan diisi secara memadai oleh approver. |
| Pengaju mencoba membatalkan PR yang telah disetujui (`Approved`) atau telah ditolak (`Rejected`) oleh approver | Sistem menolak pembatalan. Hak pembatalan mandiri pengaju hanya berlaku sebelum approver memberikan keputusan resmi. |
| Pengguna mencoba menyunting atau mengajukan kembali dokumen PR yang telah berstatus `Rejected` | Sistem menolak aksi. Dokumen berstatus ditolak bersifat permanen. Pengguna diarahkan untuk membuat dokumen PR baru. |
| Terjadi pembaruan atau revisi pada dokumen Forecasting sumber setelah draf PR dibuat | Dokumen PR tetap mempertahankan data snapshot rekomendasi saat PR dibuat; PR tidak berubah otomatis mengikuti revisi forecasting. |
| Dokumen PR dibatalkan oleh pengaju atau ditolak oleh approver | Sistem menandai dokumen berstatus `Cancelled` atau `Rejected`, mempertahankan rekam jejak dokumen, dan secara otomatis melepaskan kuantitas rekomendasi sumber agar tersedia kembali. |

---

## 9. Acceptance Criteria

> Kriteria pengujian yang dapat diverifikasi untuk membuktikan keberadaan Outcome sesuai spesifikasi.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Sistem berhasil membentuk dokumen Purchase Request (PR) persisten hanya dari rekomendasi pengadaan dokumen Forecasting (`OC-13-02`) yang sah. | Completeness |
| AC-02 | Sistem mengizinkan penggabungan beberapa rekomendasi Forecasting dan lintas unit ke dalam satu PR selama berada dalam kelompok/fungsi pengadaan yang sama. | Correctness |
| AC-03 | Sistem menolak penggabungan rekomendasi Forecasting yang berasal dari kelompok/fungsi pengadaan yang berbeda dalam satu PR. | Constraint |
| AC-04 | Setiap baris item dalam PR menyimpan referensi yang dapat ditelusuri ke dokumen Forecasting sumber, ID rekomendasi, dan unit kerja pemohon asalnya. | Completeness |
| AC-05 | Data rekomendasi pada baris item PR tersimpan sebagai *snapshot* yang tidak berubah secara otomatis meskipun dokumen Forecasting sumber mengalami pembaruan. | Correctness |
| AC-06 | Pengguna dapat menyesuaikan kuantitas rencana beli dari kuantitas rekomendasi, dan sistem mewajibkan pengisian alasan justifikasi untuk setiap penyesuaian kuantitas. | Correctness |
| AC-07 | Sistem mengalokasikan kuantitas rekomendasi Forecasting saat PR dibuat dan mencegah penggunaan kuantitas yang sama pada PR lain selama PR aktif. | Constraint |
| AC-08 | Sistem menghitung total estimasi biaya PR berdasarkan akumulasi kuantitas rencana beli dan estimasi harga satuan per item. | Correctness |
| AC-09 | Sistem memblokir pengajuan PR untuk persetujuan apabila terdapat baris item yang belum memiliki estimasi harga satuan. | Constraint |
| AC-10 | Sistem mengizinkan usulan vendor kosong saat draf, namun memblokir pengajuan PR untuk persetujuan apabila usulan vendor (terdaftar atau usulan baru) belum diisi. | Constraint |
| AC-11 | Sistem mengizinkan penginputan usulan vendor baru tanpa melakukan registrasi otomatis ke master supplier (`PUR-SUPPLIER`). | Correctness |
| AC-12 | Sistem mengunci dokumen PR (*read-only*) bagi pengaju selama dokumen berstatus `Submitted / Awaiting Approval`. | Constraint |
| AC-13 | Approver berwenang dapat menetapkan keputusan persetujuan yang berlaku untuk keseluruhan dokumen PR (*Approved*, *Rejected*, atau *Returned for Revision*). | Correctness |
| AC-14 | Sistem menolak keputusan persetujuan parsial per baris item dalam satu dokumen PR. | Constraint |
| AC-15 | Sistem mewajibkan pengisian alasan keputusan apabila approver memilih keputusan *Rejected* atau *Returned for Revision*. | Correctness |
| AC-16 | Saat PR diputuskan berstatus *Returned for Revision*, dokumen kembali dapat disunting oleh pengaju dan alokasi kuantitas rekomendasi tetap dipertahankan. | Correctness |
| AC-17 | Pengaju dapat membatalkan PR selama dokumen belum diputus oleh approver, dengan mewajibkan pencatatan alasan pembatalan. | Correctness |
| AC-18 | Dokumen PR yang dibatalkan (*Cancelled*) atau ditolak (*Rejected*) tetap tersimpan riwayatnya dalam database (*audit trail*) dan alokasi kuantitas rekomendasinya otomatis dilepas. | Correctness |
| AC-19 | Dokumen PR yang berstatus *Rejected* tidak dapat diedit atau diajukan ulang; pengajuan kebutuhan harus menggunakan dokumen PR baru. | Constraint |
| AC-20 | Tanggung jawab pengelolaan alokasi kuantitas rekomendasi pada OC-13-03 berakhir saat dokumen PR berstatus *Approved*. | Constraint |
| AC-21 | Dokumen PR tidak menghasilkan komitmen finansial ke supplier, tidak menerbitkan Purchase Order, dan tidak memicu pergerakan fisik persediaan di gudang. | Constraint |
| AC-22 | Dokumen PR berstatus *Approved* terkunci permanen dan dapat diakses sebagai referensi resmi bagi proses penerbitan Purchase Order (`OC-13-04`). | Completeness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit tidak dicakup oleh Outcome ini.

- **Perhitungan dan Pembaruan Rekomendasi Forecasting:** Kalkulasi kebutuhan konsumsi historis, safety stock, lead time, dan penerbitan proyeksi perencanaan kebutuhan $\rightarrow$ **OC-13-02 Forecasting** (`PUR-FORECAST`).
- **Validasi Kecukupan Anggaran dan Otorisasi Anggaran Finansial:** Pengecekan ketersediaan plafon anggaran unit (*budget checking*), persetujuan pos anggaran terpisah, dan alokasi pagu dana $\rightarrow$ Domain Tata Rekening (`TRK-*`) / Manajemen Anggaran Rumah Sakit.
- **Verifikasi, Pendaftaran, dan Pengelolaan Master Vendor:** Verifikasi legalitas pemasok, evaluasi vendor, pendaftaran ke katalog master supplier, dan pemeliharaan data rekening/pajak vendor $\rightarrow$ **PUR-SUPPLIER** (`PUR-SUPPLIER`).
- **Pembuatan dan Pengelolaan Purchase Order:** Pembentukan kontrak pembelian resmi dengan supplier, negosiasi harga final, penerbitan dokumen PO, dan pengiriman order $\rightarrow$ **OC-13-04 Purchase Order** (`PUR-PO`).
- **Penerimaan Fisik Barang dan Surat Jalan:** Pemeriksaan fisik barang kiriman dari supplier, pencatatan Delivery Order, dan berita acara penerimaan $\rightarrow$ **OC-12-01 Terima Barang (DO)** (`PUR-DO`).
- **Pencatatan Faktur Tagihan dan Pembayaran Supplier:** Verifikasi invoice tagihan supplier (*three-way matching*), pengakuan utang usaha, dan pelunasan pembayaran $\rightarrow$ **OC-13-05 Faktur Tagihan** (`PUR-FAKTUR`) dan Tata Rekening Domain (`TRK-BILLING`, `TRK-PAYMENT`).
- **Perubahan Kebutuhan atau Alokasi Pasca-Persetujuan:** Penyesuaian kuantitas, pembatalan item, atau perubahan alokasi setelah PR berstatus *Approved* ditangani sepenuhnya oleh proses pengadaan lanjutan (`PUR-PO`).

---

## 11. Points Requiring Further Business Decision

> Poin-poin spesifikasi detail yang berada di luar kesepakatan dasar dan memerlukan penetapan kebijakan operasional / SOP lebih lanjut oleh Komite Pengadaan Rumah Sakit.

1. **Matriks Penentuan Approver Tunggal Berwenang:**  
   Aturan spesifik penentuan figur atau jabatan approver tunggal untuk suatu PR (misalnya: apakah penentuan approver didasarkan pada batas nominal rupiah total estimasi biaya PR, kelompok komoditas material, atau struktur hirarki unit pengaju).
2. **Batas Toleransi Penyesuaian Kuantitas terhadap Rekomendasi:**  
   Kebijakan apakah terdapat batas persentase maksimum kenaikan kuantitas PR terhadap kuantitas rekomendasi Forecasting (misal deviasi $> 20\%$) yang memicu telaah khusus atau eskalasi otorisasi.
3. **Prosedur dan Waktu Verifikasi Usulan Vendor Baru:**  
   Penetapan titik waktu pelaksanaan *due diligence* dan pendaftaran master vendor bagi PR yang memuat usulan vendor baru (apakah verifikasi vendor diselesaikan sebelum approver menyetujui PR, atau dilakukan oleh tim pengadaan saat penyusunan Purchase Order).
4. **Batas Waktu Kedaluwarsa Draf dan PR yang Dikembalikan (*Time-to-Decision / Expiration Policy*):**  
   Ketentuan mengenai batas masa berlaku draf PR atau PR yang berstatus *Returned for Revision* sebelum dokumen dibatalkan otomatis oleh sistem (*auto-expire*) demi menghindari penguncian alokasi rekomendasi yang berkepanjangan tanpa tindak lanjut.
