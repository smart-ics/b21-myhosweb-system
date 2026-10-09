# OUTCOME: OrderOk (Order Kamar Operasi)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-KMO-ORDER-OK   |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, dan memelihara permintaan tindakan pembedahan (*surgical operation order*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Order Kamar Operasi memungkinkan klinisi pengorder dari berbagai unit layanan (Rawat Jalan, Rawat Inap, maupun Gawat Darurat) untuk mengomunikasikan kebutuhan operasi pasien secara terstruktur kepada instalasi kamar operasi, menetapkan dokter operator penanggung jawab, merinci rencana prosedur bedah beserta tingkat urgensinya (Elektif atau Cito), dan mengidentifikasi kebutuhan sumber daya khusus (seperti kesiapan darah, implan, peralatan penunjang, dan tempat tidur intensif pasca-bedah).

Fakta Order Kamar Operasi ini merupakan fondasi operasional yang esensial untuk:
1. Menyediakan dasar otorisasi resmi bagi koordinator kamar operasi untuk melakukan alokasi dan penjadwalan kamar bedah (*JadwalOk* / `KMO-JADWAL`).
2. Memicu koordinasi persiapan pra-bedah (*PreOperativeClearance* / `KMO-PREOP`) guna memastikan kesiapan klinis dan keselamatan pasien sebelum memasuki ruang operasi.
3. Memberikan visibilitas awal bagi unit penunjang terkait (Bank Darah, Farmasi/Logistik Alkes, dan Ruang Perawatan Intensif/ICU) mengenai kebutuhan sumber daya spesifik yang diperlukan saat operasi berlangsung.

---

## 2. Outcome Statement

Permintaan tindakan pembedahan atas nama pasien telah tercatat secara resmi sebagai fakta bisnis persisten (`Surgical Operation Order exists`) dan siap digunakan sebagai dasar penjadwalan kamar operasi serta koordinasi persiapan pra-bedah.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Kamar Operasi** (`KMO`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas penerimaan, pengelolaan, pemeliharaan status operasional permintaan operasi (`KMO-ORDER`), serta menyediakan data dasar bagi penjadwalan kamar bedah. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data dokter pengorder, dokter spesialis bedah (operator), dan unit layanan melalui `ORG-PPA` dan `ORG-LAYANAN`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif resmi episode kunjungan aktif pasien (`RegId` aktif melalui `ADM-REG`). |
| **Rawat Jalan** (`RJL`) / **Rawat Inap** (`RNA`) / **Gawat Darurat** (`IGD`) | **Contributing Domains:** Menyediakan konteks encounter klinis tempat permintaan operasi diinisiasi (`RJL-KONSUL`, `RNA-TRANSFER`, `IGD-VISIT`). |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known | **Primary Capability:** Menerima, memvalidasi, mempersistensi catatan permintaan tindakan operasi pasien, serta mengelola status siklus hidup order. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan data identitas pasien yang menjadi subjek tindakan pembedahan (Nomor Rekam Medis, nama, jenis kelamin, tanggal lahir). |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi dan kredensial klinis dokter pengorder serta dokter operator spesialis bedah. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit layanan asal pengorder (Klinik Rawat Jalan, Bangsal Rawat Inap, atau IGD). |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks nomor registrasi kunjungan aktif (`RegId`) sebagai prasyarat otorisasi penerbitan order. |
| `RJL-KONSUL` / `RNA-TRANSFER` / `IGD-VISIT` Encounter Klinis | Pelayanan Klinis Terkait | Known | Menyediakan konteks episode pelayanan klinis pengorder saat keputusan tindakan operasi ditetapkan. |

> **Catatan Batasan Kapabilitas Terkait:**
> Sesuai pemisahan tanggung jawab domain MyHosWeb, penjadwalan kamar operasi fisik (`KMO-JADWAL`), verifikasi kelayakan pra-bedah (`KMO-PREOP`), pelaksanaan operasi (`KMO-OPR`), dokumentasi klinis informed consent (EMR), dan pembebanan tarif (`TRK-BILLING` / `TRK-TARIF`) dikelola oleh kapabilitas masing-masing dan bertindak sebagai penerus (*downstream consumers*) dari fakta `OrderOk`.

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Permintaan Kamar Operasi (*OrderOk*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Permintaan Operasi**:
   - Terbentuk satu catatan permintaan operasi unik dengan nomor referensi order (*OrderOkId*) yang sah.
2. **Keterikatan Konteks Pasien & Kunjungan**:
   - Order terikat secara valid pada pasien terdaftar (`PAS-DATSOS`) dan nomor registrasi kunjungan aktif (`RegId` pada `ADM-REG`).
3. **Akuntabilitas Tim Klinis Penanggung Jawab**:
   - Teridentifikasi dokter pengorder yang berwenang.
   - Teridentifikasi dokter operator spesialis bedah utama penanggung jawab tindakan (`ORG-PPA`).
4. **Kejelasan Rencana Tindakan & Indikasi Medis**:
   - Memuat diagnosis pra-bedah (indikasi klinis operasi).
   - Memuat minimal satu rencana prosedur bedah utama (*primary procedure*), disertai prosedur tambahan opsional jika ada.
   - Memuat estimasi klasifikasi tingkat keparahan/kompleksitas operasi (Kecil, Sedang, Besar, atau Khusus).
5. **Penetapan Urgensi & Alokasi Waktu**:
   - Menetapkan tingkat urgensi operasi secara definitif: **Elektif (Terencana)** atau **Cito (Darurat/Emergency)**.
   - Memuat estimasi tanggal dan jam rencana operasi serta perkiraan durasi operasi (menit/jam).
6. **Identifikasi Kebutuhan Sumber Daya Penunjang**:
   - Memuat rencana jenis anestesi (Umum, Regional/Spinal, Lokal, Sedasi, atau Tanpa Anestesi).
   - Memuat penanda (*flags*) kebutuhan sumber daya khusus: kebutuhan darah (beserta jumlah labu/jenis), implan/alat kesehatan khusus, peralatan penunjang khusus (C-Arm, Laparoskopi), dan kebutuhan tempat tidur perawatan intensif (ICU/PICU/NICU/PACU) pasca-bedah.
7. **Status Siklus Hidup Definitif**:
   - Order memiliki status siklus hidup yang jelas: **Diajukan (Requested)**, **Terjadwal (Scheduled)**, **Selesai (Completed)**, atau **Dibatalkan (Cancelled)**.

---

### 5.2 Required Recorded Information

Setiap entitas `OrderOk` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Order & Konteks Pelayanan:
- **`OrderOkId`**: Nomor unik identitas permintaan kamar operasi.
- **`RegId`**: Nomor unik registrasi kunjungan aktif pasien.
- **Identitas Pasien**: Nomor Rekam Medis (Nomor RM), nama lengkap, jenis kelamin, dan tanggal lahir pasien.
- **Unit Layanan Pengorder**: Kode dan nama unit kerja pengorder (Klinik RJL, Bangsal Perawatan RNA, atau Instalasi Gawat Darurat IGD).
- **Waktu Pencatatan**: Tanggal dan jam pembuatan order.

#### B. Tanggung Jawab Medis:
- **Dokter Pengorder**: Identitas dokter yang menerbitkan instruksi permintaan operasi.
- **Dokter Operator Utama**: Identitas dokter spesialis bedah yang ditunjuk sebagai pelaksana utama operasi.
- **KSM / Spesialisasi Bedah**: Bidang spesialisasi pembedahan (misal: Bedah Umum, Ortopedi, Obgyn, Bedah Saraf, dsb.).

#### C. Rencana Klinis & Prosedur Pembedahan:
- **Diagnosis Pra-Bedah**: Indikasi klinis atau diagnosis kerja yang mendasari kebutuhan operasi.
- **Daftar Rencana Prosedur Bedah**:
  - *Prosedur Utama (Primary Procedure)*: Kode/nama tindakan pembedahan utama.
  - *Prosedur Tambahan (Secondary Procedures)*: Daftar tindakan tambahan/penyerta terstruktur (opsional).
- **Klasifikasi Tingkat Operasi**: Estimasi kategori kompleksitas tindakan:
  - `Kecil`
  - `Sedang`
  - `Besar`
  - `Khusus`

#### D. Urgensi & Estimasi Waktu:
- **Tingkat Urgensi**:
  - `Elektif`: Operasi terencana sesuai antrean slot jadwal reguler kamar operasi.
  - `Cito`: Operasi darurat dengan prioritas tertinggi untuk segera dialokasikan ke kamar operasi darurat.
- **Rencana Tanggal & Jam Operasi**: Waktu pelaksanaan operasi yang diharapkan atau ditargetkan.
- **Estimasi Durasi Operasi**: Perkiraan lama waktu prosedur bedah berlangsung (dalam satuan menit/jam).

#### E. Rencana Anestesi & Kebutuhan Sumber Daya Khusus:
- **Rencana Jenis Anestesi**: Pemilihan rencana metode anestesi:
  - `Anestesi Umum (General Anesthesia)`
  - `Anestesi Regional / Spinal / Epidural`
  - `Anestesi Lokal`
  - `Sedasi`
  - `Tanpa Anestesi`
- **Kebutuhan Darah**:
  - *Flag Kebutuhan Darah*: Penanda boolean apakah operasi memerlukan persediaan darah.
  - *Detail Darah*: Jumlah kantong/labu dan komponen darah yang diminta (misal: PRC, WB, FFP, TC) jika flag bernilai ya.
- **Kebutuhan Implan / Alkes Khusus**: Penanda boolean dan deskripsi implan/perangkat prostesis/alat sekali pakai khusus yang harus disiapkan.
- **Kebutuhan Peralatan Khusus**: Penanda kebutuhan peralatan operasional kamar bedah (misal: C-Arm Fluoroscopy, Mesin Laparoskopi, Mikroskop Bedah, Laser).
- **Kebutuhan Fasilitas Rawat Pasca-Operasi**:
  - Penanda kebutuhan alokasi tempat tidur khusus pasca-bedah (`ICU`, `ICCU`, `PICU`, `NICU`, `PACU / Recovery Room`, atau `Bangsal Biasa`).

#### F. Status Siklus Hidup & Audit Pembatalan:
- **Status Order**:
  - `Diajukan (Requested)`: Status awal saat order berhasil disimpan dan menunggu penjadwalan.
  - `Terjadwal (Scheduled)`: Order telah dialokasikan slot kamar operasi dan waktu pada `KMO-JADWAL`.
  - `Selesai (Completed)`: Prosedur pembedahan telah selesai dilaksanakan pada `KMO-OPR`.
  - `Dibatalkan (Cancelled)`: Order dibatalkan sebelum operasi dilaksanakan.
- **Petugas Pencatat**: Identitas pengguna sistem yang menginput order.
- **Data Pembatalan** (wajib terisi jika status `Dibatalkan`):
  - *Waktu Pembatalan*: Tanggal dan jam pencatatan pembatalan.
  - *Petugas Pembatal*: Identitas staf/dokter yang membatalkan order.
  - *Alasan Pembatalan*: Kategori dan deskripsi alasan pembatalan (misal: kondisi umum pasien memburuk, pasien/keluarga menolak operasi, kontraindikasi klinis, atau kendala fasilitas).

---

### 5.3 Required Business Conditions

1. **Keabsahan Episode Registrasi Kunjungan**:
   - Pasien harus terdaftar aktif dalam episode pelayanan rumah sakit (`RegId` pada `ADM-REG`) bertipe Rawat Jalan, Rawat Inap, atau Gawat Darurat.
   - Episode kunjungan pasien belum ditutup secara administratif.
2. **Kredensial dan Otoritas Dokter**:
   - Dokter pengorder dan dokter operator utama harus terdaftar aktif dengan kredensial profesi yang sah pada master `ORG-PPA`.
3. **Kelengkapan Rencana Prosedur**:
   - Order wajib memiliki minimal 1 (satu) tindakan pembedahan utama yang terdefinisi.
4. **Prioritas Alokasi Order Cito**:
   - Order berkategori **Cito** secara otomatis mendapatkan penanda prioritas tertinggi pada daftar antrean penjadwalan kamar operasi untuk segera dialokasikan slot kamar darurat tanpa harus menunggu siklus penjadwalan elektif reguler.
5. **Kebijakan Multi-Order Konkuren**:
   - Sistem mengizinkan seorang pasien memiliki lebih dari satu OrderOK aktif secara bersamaan sepanjang sesi pelaksanaan, target waktu operasi, atau tim operatornya berbeda (misalnya tahapan operasi bertahap / *staged procedure* atau operasi multidisiplin).
6. **Aturan Pembatalan Non-Destructive**:
   - Pembatalan order hanya dapat dilakukan sebelum tindakan operasi dimulai di kamar bedah (`KMO-OPR`).
   - Pembatalan wajib disertai pencatatan alasan resmi dan identitas petugas pembatal.
7. **Pemisahan Tanggung Jawab Operasional dan Klinis**:
   - Entitas OrderOK murni mencatat pesanan kebutuhan operasional pembedahan. Kepatuhan penandatanganan formulir persetujuan tindakan medis (*Informed Consent*) dikelola secara independen di dokumen EMR dan diverifikasi mutlak pada gerbang persiapan pra-bedah (*PreOperativeClearance* / `KMO-PREOP`).

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan permintaan operasi tersimpan secara persisten dengan identifier unik `OrderOkId`.
2. Status awal order tercatat sebagai **Diajukan (Requested)**.
3. OrderOK dapat ditemukan dan diakses melalui kueri daftar pesanan operasi oleh koordinator kamar operasi, unit pengorder asal, dan dokter operator terkait.
4. OrderOK tersedia sebagai dokumen masukan resmi untuk proses alokasi dan pembentukan jadwal kamar operasi pada `KMO-JADWAL`.
5. Indikator kebutuhan khusus (darah, implan, alat khusus, dan bed intensif) dapat dilihat oleh instalasi terkait sebagai dasar koordinasi logistik pra-bedah.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:** Dokter pengorder atau staf klinis yang diberi wewenang di unit rawat jalan, bangsal rawat inap, atau gawat darurat menginisiasi permintaan pembedahan untuk pasien berdasarkan indikasi klinis hasil pemeriksaan medis.

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat:** Seluruh informasi spesifikasi permintaan operasi telah divalidasi, disimpan secara persisten ke dalam sistem dengan nomor unik `OrderOkId`, dan berstatus **Diajukan (Requested)**, sehingga siap ditindaklanjuti oleh koordinator kamar operasi untuk penjadwalan.

---

## 7. Business Constraints

1. **Keterikatan Tunggal pada Episode Kunjungan**:
   - Setiap entitas OrderOK harus terikat secara spesifik pada tepat satu nomor registrasi kunjungan pasien (`RegId`).
2. **Kemandirian Operasional dari Dokumen Rekam Medis (EMR Boundary)**:
   - OrderOK mengelola koordinasi alur operasional permintaan pembedahan, bukan ringkasan rekam medis klinis lengkap. Catatan medis detail, laporan konsultasi pra-anestesi, dan lembar informed consent tetap menjadi wewenang domain EMR.
3. **Integritas Kronologis Siklus Hidup**:
   - Order yang telah berstatus **Selesai (Completed)** tidak dapat diubah statusnya menjadi Dibatalkan.
4. **Sinkronisasi Otomatis dengan Jadwal Kamar Operasi**:
   - Apabila suatu OrderOK yang telah berstatus **Terjadwal (Scheduled)** dibatalkan, sistem wajib mengirimkan notifikasi dan memicu pelepasan atau pembatalan slot jadwal terkait pada `KMO-JADWAL` agar kamar operasi dapat dialokasikan untuk kebutuhan lain.
5. **Jejak Audit Pembatalan (Audit Trail)**:
   - Pembatalan order tidak menghapus data secara fisik (*non-destructive*), melainkan mengubah status menjadi `Dibatalkan` dengan merekam riwayat audit waktu, petugas pembatal, dan alasan pembatalan.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Registrasi Kunjungan Tidak Valid / Ditutup** | Pengguna membuat OrderOK menggunakan nomor registrasi (`RegId`) yang tidak ditemukan, dibatalkan, atau status episode pelayanannya sudah ditutup (*discharged*). | Sistem menolak pembuatan order dan menampilkan pesan bahwa pasien harus memiliki status kunjungan aktif di ADM/RJL/RNA/IGD. |
| **EX-02: Dokter Operator Tidak Memiliki Kredensial Bedah** | Dokter yang dipilih sebagai operator utama tidak terdaftar aktif atau tidak memiliki kewenangan klinis spesialisasi bedah di `ORG-PPA`. | Sistem menolak penyimpanan order dan mewajibkan pemilihan dokter operator yang memiliki kredensial bedah aktif. |
| **EX-03: Prosedur Tindakan Bedah Kosong** | Formulir order disubmit tanpa menyertakan minimal 1 rencana tindakan pembedahan utama. | Sistem menolak order dan memberikan peringatan bahwa rencana prosedur bedah utama wajib diisi. |
| **EX-04: Pembatalan Tanpa Alasan** | Pengguna mengubah status order menjadi `Dibatalkan` tanpa mengisi keterangan alasan pembatalan. | Sistem menolak pembatalan dan mewajibkan pengisian alasan pembatalan resmi. |
| **EX-05: Pembatalan pada Order yang Sudah Berjalan atau Selesai** | Pengguna berupaya membatalkan OrderOK yang statusnya sudah `Selesai` atau prosedurnya telah dimulai di `KMO-OPR`. | Sistem menolak pembatalan langsung dan menginstruksikan bahwa prosedur operasional kamar bedah telah dieksekusi sehingga tidak dapat dibatalkan melalui level order. |
| **EX-06: Kuota Kamar Bedah Elektif Penuh** | Order elektif diajukan untuk tanggal di mana seluruh kapasitas kamar bedah telah terisi penuh. | Sistem menerima pencatatan order dengan status `Diajukan`, namun memberikan peringatan bahwa kapasitas tanggal tersebut penuh sehingga penjadwalan perlu diarahkan ke tanggal alternatif. Jika order bertipe Cito, sistem memprioritaskan alokasi slot darurat. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat permintaan operasi baru dengan identifier unik `OrderOkId`, status awal 'Diajukan', dan menghubungkannya dengan `RegId` kunjungan aktif yang sah. | Completeness |
| **AC-02** | Catatan OrderOK memuat secara lengkap dokter pengorder, dokter operator penanggung jawab, diagnosis pra-bedah, dan minimal satu tindakan pembedahan utama terstruktur beserta estimasi klasifikasi tingkat operasi (Kecil/Sedang/Besar/Khusus). | Correctness |
| **AC-03** | Penetapan urgensi 'Cito' berhasil direkam dan secara otomatis menandai order dengan prioritas tertinggi pada antrean penjadwalan kamar operasi darurat. | Business Rule (Urgensi Cito) |
| **AC-04** | Flag kebutuhan sumber daya penunjang (darah beserta rincian jumlah/jenis, implan/alkes khusus, alat C-Arm/khusus, dan bed intensif ICU/PACU) tersimpan secara akurat pada entitas order. | Correctness (Penunjang) |
| **AC-05** | Pasien yang sama dapat memiliki lebih dari satu OrderOK aktif secara bersamaan sepanjang waktu atau rencana tindakan pembedahannya berbeda (staged/multidisciplinary surgery). | Business Rule (Multi-Order) |
| **AC-06** | Upaya pembuatan order pada nomor registrasi yang tidak aktif atau dengan dokter operator tanpa kredensial bedah berhasil dicegah dengan notifikasi validasi yang informatif. | Exception Handling |
| **AC-07** | Pembatalan order berhasil mengubah status menjadi 'Dibatalkan' dan merekam waktu, identitas petugas pembatal, serta alasan pembatalan dalam jejak audit, asalkan tindakan bedah belum dilaksanakan. | Constraint & Audit Trail |
| **AC-08** | OrderOK yang berstatus 'Diajukan' dapat diakses dan digunakan oleh kapabilitas `KMO-JADWAL` sebagai entitas masukan untuk pembentukan jadwal kamar operasi. | Integration (Downstream) |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `OrderOk`:

- **Penjadwalan Definitif Ruangan & Slot Waktu:** Alokasi nomor kamar bedah fisik, penentuan slot jam mulai-selesai definitif, dan penetapan tim perawat bedah/anestesi lengkap (merupakan wewenang `KMO-JADWAL` / Outcome *JadwalOk*).
- **Pemeriksaan Kelayakan Medis Pra-Bedah:** Verifikasi hasil laboratorium, rontgen, asesmen pra-anestesi, dan kelengkapan informed consent fisik/digital (merupakan wewenang `KMO-PREOP` / Outcome *PreOperativeClearance* dan domain EMR).
- **Pelaksanaan Prosedur Bedah & Laporan Operasi:** Pencatatan waktu mulai sayatan (*incisi*), waktu selesai bedah, pemakaian obat anestesi riil, serta laporan operasi intra-bedah (merupakan wewenang `KMO-OPR` dan EMR).
- **Pelayanan Pemulihan Pasca-Bedah:** Monitoring observasi pemulihan pasien di ruang PACU dan penentuan skor aldrete (merupakan wewenang `KMO-RECOVERY`).
- **Penyediaan & Pemotongan Fisik Stok Darah/Obat:** Pengambilan dan alokasi kantong darah fisik dari Bank Darah serta dispensing obat/implan dari instalasi Farmasi/Gudang (merupakan wewenang Bank Darah, `APT-DISPENSING`, dan `INV-PAKAI`).
- **Penetapan Tarif & Penagihan Finansial:** Perhitungan nominal rupiah biaya pembedahan, jasa dokter operator, sewa alat, dan pencatatan ke dalam tagihan pasien (merupakan wewenang `TRK-BILLING` dan `TRK-TARIF`).
