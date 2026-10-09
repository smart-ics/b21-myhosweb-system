# OUTCOME: JadwalOk (Jadwal Kamar Operasi)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-KMO-JADWAL-OK  |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, mengalokasikan, memvalidasi, dan memelihara jadwal pemanfaatan kamar operasi (*surgical operating schedule*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Jadwal Kamar Operasi memungkinkan koordinator instalasi kamar operasi untuk mengalokasikan ruangan bedah fisik (*operating room*), menetapkan rentang waktu pembedahan (tanggal, jam mulai, estimasi durasi, dan jam selesai), serta menugaskan tim medis/bedah (dokter operator utama, dokter anestesi, perawat asisten/instrumen/sirkuler) berdasarkan permintaan tindakan operasi resmi (*OrderOk* / `KMO-ORDER`) yang telah diajukan.

Fakta Jadwal Kamar Operasi ini merupakan fondasi operasional yang esensial untuk:
1. Menjamin ketersediaan dan mencegah konflik bentrok fisik (*room collision*) pada fasilitas kamar bedah rumah sakit.
2. Menyediakan jangkar lini masa operasional bagi proses verifikasi kelayakan pra-bedah (*PreOperativeClearance* / `KMO-PREOP`) guna memastikan kesiapan klinis pasien sebelum memasuki ruang operasi.
3. Memberikan kepastian waktu dan lokasi bagi tim bedah (operator, tim anestesi, perawat bedah) serta unit penunjang terkait (Bank Darah, Farmasi, Sterilisasi Alat/CSSD, dan Ruang Perawatan Intensif/ICU).
4. Menyediakan dasar otorisasi bagi staf kamar bedah untuk memulai pelaksanaan tindakan operasi (*KMO-OPR*).
5. Memberikan visibilitas alur waktu pelayanan pasien (*Patient Journey*) bagi keluarga pasien dan unit perawatan asal (Rawat Inap, Rawat Jalan, atau IGD).

---

## 2. Outcome Statement

Alokasi kamar bedah fisik, rentang waktu pembedahan, dan tim bedah atas permintaan operasi yang sah telah tercatat secara resmi sebagai fakta bisnis persisten (`Surgical Operating Schedule exists`) dengan status `ACTIVE` dan siap digunakan sebagai dasar verifikasi pra-bedah serta pelaksanaan tindakan operasi.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Kamar Operasi** (`KMO`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pengelolaan jadwal kamar bedah (`KMO-JADWAL`), alokasi slot waktu, validasi konflik ruangan, dan pemeliharaan status jadwal, serta mengonsumsi data permintaan operasi dari `KMO-ORDER`. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data kamar bedah fisik melalui `ORG-LAYANAN` serta master data dokter operator, dokter anestesi, dan perawat bedah melalui `ORG-PPA`. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif episode registrasi kunjungan aktif pasien (`RegId` aktif melalui `ADM-REG`) serta menerima pembaruan tahapan perjalanan pasien melalui `ADM-TRACKER`. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `KMO-JADWAL` Jadwal Operasi | Kamar Operasi | Known | **Primary Capability:** Menjadwalkan prosedur operasi pasien terhadap kamar bedah fisik yang tersedia, tanggal, rentang waktu, dan alokasi tim bedah. |
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known | Menyediakan rujukan resmi permintaan operasi yang sah (*OrderOk*) sebagai prasyarat mutlak pembentukan jadwal. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi ruangan kamar operasi fisik (`Ruang OK`) yang aktif dan beroperasi. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi dan kredensial klinis dokter operator utama, dokter anestesi, dan tim perawat bedah. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien (Nomor RM, nama, jenis kelamin, tanggal lahir) yang tercantum dalam jadwal. |
| `ADM-REG` Registration | Admission | Known | Memastikan episode kunjungan pasien masih berstatus aktif dan sah selama periode penjadwalan. |
| `ADM-TRACKER` Pasien Tracker | Admission | Known | Menerima peristiwa pembaruan status penjadwalan operasi untuk visibilitas perjalanan pasien (*Patient Journey*). |

> **Catatan Batasan Kapabilitas Terkait:**
> Sesuai pemisahan tanggung jawab domain MyHosWeb:
> - Permintaan awal operasi dan kebutuhan sumber daya khusus dikelola oleh `KMO-ORDER` (Outcome *OrderOk*).
> - Pemeriksaan kelayakan medis pra-bedah dikelola oleh `KMO-PREOP` (Outcome *PreOperativeClearance*).
> - Pelaksanaan prosedur operasi di kamar bedah dikelola oleh `KMO-OPR`.
> - Pembebanan tarif sewa kamar operasi dan jasa medis dikelola oleh Tata Rekening (`TRK-BILLING` / `TRK-TARIF`).

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Jadwal Kamar Operasi (*JadwalOk*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Jadwal Unik**:
   - Terbentuk satu catatan jadwal operasi unik dengan identifier resmi (*JadwalOkId*) yang tersimpan secara persisten.
2. **Keterikatan Mutlak pada OrderOK yang Sah**:
   - Jadwal terikat secara valid pada tepat 1 (satu) catatan permintaan kamar operasi (*OrderOkId* pada `KMO-ORDER`) yang berstatus `Diajukan (Requested)` saat dijadwalkan.
3. **Alokasi Kamar Bedah Fisik Definitif**:
   - Teralokasi satu kamar operasi fisik tertentu (`KamarOkId` pada `ORG-LAYANAN`) yang berstatus aktif dan siap digunakan.
4. **Alokasi Slot Waktu Terstruktur**:
   - Memuat tanggal pelaksanaan operasi.
   - Memuat jam mulai rencana dan estimasi durasi operasi (menit) atau jam selesai rencana.
   - Memperhitungkan estimasi jeda waktu pembersihan/sterilisasi (*turnover buffer time*) antar operasi di ruangan yang sama.
5. **Akuntabilitas Penugasan Tim Medis (PPA)**:
   - Teridentifikasi Dokter Operator Utama penanggung jawab tindakan (`ORG-PPA`) yang wajib terisi sejak penjadwalan.
   - Mengakomodasi penugasan anggota tim bedah lainnya (Dokter Anestesi, Asisten Operator, Perawat Penata Anestesi, Perawat Instrumen/Scrub Nurse, dan Perawat Sirkuler) yang dapat dilengkapi menyusul sebelum gerbang *PreOperativeClearance*.
6. **Bebas Konflik Ruangan Fisik (Zero Room Collision)**:
   - Terverifikasi bahwa kamar bedah fisik yang dipilih tidak memiliki jadwal aktif lain yang bertabrakan (*overlapping*) pada rentang waktu tersebut.
7. **Status Siklus Hidup Jadwal Definitif**:
   - Jadwal berstatus eksplisit: **`ACTIVE`** (jadwal aktif dan slot kamar terkunci) atau **`CANCELED`** (jadwal dibatalkan dan slot kamar dilepaskan).

---

### 5.2 Required Recorded Information

Setiap entitas `JadwalOk` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Jadwal & Referensi Order:
- **`JadwalOkId`**: Nomor unik identitas jadwal operasi.
- **`OrderOkId`**: Nomor unik permintaan kamar operasi (`OrderOk`) yang menjadi dasar penjadwalan.
- **`RegId`**: Nomor unik registrasi kunjungan aktif pasien.
- **Identitas Pasien**: Nomor Rekam Medis (Nomor RM), nama lengkap, jenis kelamin, dan tanggal lahir pasien.
- **Rencana Tindakan Bedah**: Rencana prosedur bedah utama dan diagnosis pra-bedah (diperoleh dari OrderOK).
- **Tingkat Urgensi**: Penanda urgensi `Elektif` atau `Cito` (diperoleh dari OrderOK).

#### B. Alokasi Fasilitas & Lini Masa:
- **`KamarOkId` & Nama Kamar Bedah**: Identitas fasilitas kamar operasi fisik yang dialokasikan (`ORG-LAYANAN`).
- **Tanggal Operasi**: Tanggal pelaksanaan tindakan pembedahan.
- **Jam Mulai Rencana**: Waktu (jam dan menit) rencana pasien masuk/mulai di kamar bedah.
- **Estimasi Durasi Operasi**: Perkiraan durasi pembedahan (dalam satuan menit).
- **Jam Selesai Rencana**: Waktu estimasi berakhirnya operasi di kamar bedah.
- **Estimasi Waktu Jeda Pembersihan (*Turnover Buffer*)**: Estimasi waktu sterilisasi dan penyiapan kamar bedah untuk operasi berikutnya (dalam satuan menit).

#### C. Penugasan Tim Medis / Bedah (PPA):
- **Dokter Operator Utama**: Identitas dokter spesialis bedah penanggung jawab utama (Wajib terisi saat jadwal dibuat).
- **Dokter Operator Pendamping / Asisten**: Identitas dokter asisten/pendamping (opsional).
- **Dokter Spesialis Anestesi**: Identitas dokter spesialis anestesi (opsional saat pembuatan awal, wajib dilengkapi sebelum verifikasi *PreOperativeClearance*).
- **Penata / Perawat Anestesi**: Identitas perawat anestesi yang bertugas mendampingi dokter anestesi (opsional saat pembuatan awal).
- **Perawat Instrumen (*Scrub Nurse*)**: Identitas perawat instrumen steril yang bertugas (opsional saat pembuatan awal).
- **Perawat Sirkuler (*Circulating Nurse*)**: Identitas perawat sirkuler penanggung jawab logistik ruang bedah (opsional saat pembuatan awal).

#### D. Catatan Operasional & Logistik Penjadwalan:
- **Status Kesiapan Penunjang Khusus**: Konfirmasi kesiapan darah, implan/alkes khusus, alat C-Arm/Laparoskopi, dan reservasi tempat tidur rawat intensif (ICU/PICU/PACU) sesuai kebutuhan yang tercatat di OrderOK.
- **Catatan Penjadwalan**: Keterangan atau instruksi khusus dari koordinator kamar bedah (misal: urutan antrean dalam sesi, perhatian khusus desinfeksi pasca-operasi infeksius).

#### E. Status Siklus Hidup & Jejak Audit:
- **Status Jadwal**:
  - `ACTIVE`: Jadwal berlaku aktif, slot kamar dan waktu teralokasi resmi.
  - `CANCELED`: Jadwal dibatalkan dan alokasi kamar dilepaskan.
- **Pembuat Jadwal**: Identitas pengguna sistem dan stempel waktu (*timestamp*) saat jadwal dibuat.
- **Histori Revisi Jadwal (*Reschedule Audit Trail*)**:
  - *Catatan Perubahan Waktu/Kamar*: Jika terjadi perubahan kamar, tanggal, atau jam pada jadwal berstatus `ACTIVE`, sistem merekam stempel waktu perubahan, identitas petugas pengubah, kamar/waktu lama, kamar/waktu baru, serta alasan perubahan jadwal.
- **Data Pembatalan** (wajib terisi jika status `CANCELED`):
  - *Waktu Pembatalan*: Tanggal dan jam pencatatan pembatalan.
  - *Petugas Pembatal*: Identitas staf koordinator yang membatalkan jadwal.
  - *Alasan Pembatalan*: Kategori dan deskripsi alasan pembatalan jadwal (misal: kondisi umum pasien tidak layak/memburuk, penolakan tindakan oleh keluarga, dislokasi darurat operasi Cito, kendala fasilitas teknis kamar bedah).

---

### 5.3 Required Business Conditions

1. **Keabsahan dan Ketersediaan OrderOK**:
   - JadwalOK mutlak mensyaratkan adanya catatan `OrderOk` yang sah dengan status `Diajukan (Requested)`.
   - Tidak diperkenankan membuat JadwalOK tanpa referensi `OrderOk` yang terverifikasi.
2. **Kardinalitas Tunggal 1-to-1 Aktif**:
   - Satu entitas `OrderOk` hanya dapat memiliki maksimal 1 (satu) entitas `JadwalOk` yang berstatus `ACTIVE` dalam satu waktu.
3. **Hard Constraint Bentrok Kamar Operasi (No Room Collision)**:
   - Sistem menolak secara mutlak penyimpanan JadwalOK berstatus `ACTIVE` apabila kamar bedah fisik yang dipilih telah memiliki jadwal `ACTIVE` lain pada rentang jam yang bertabrakan (*overlapping*).
4. **Soft Warning Bentrok Dokter Operator & Turnover Buffer**:
   - Jika Dokter Operator Utama telah terjadwal pada kamar bedah lain di jam yang bersamaan, atau jika jeda waktu sterilisasi antar operasi kurang dari standar *turnover buffer*, sistem wajib menampilkan peringatan (*warning*).
   - Koordinator kamar bedah berwenang melakukan konfirmasi persetujuan (*override*) dengan mencatat konfirmasi operasional.
5. **Kebijakan Dislokasi Terkendali untuk Kasus Cito (*Controlled Cito Displacement*)**:
   - Pada situasi darurat (*Cito*) di mana seluruh kamar bedah terisi penuh oleh jadwal operasi elektif, koordinator kamar operasi berwenang memindahkan/menjadwal ulang (*reschedule*) atau membatalkan (*cancel*) jadwal elektif dengan mencatat alasan darurat dislokasi Cito, guna membebaskan slot ruangan untuk operasi darurat Cito.
6. **Mekanisme Penjadwalan Ulang di Tempat (*In-Place Revision*)**:
   - Penjadwalan ulang (pergeseran tanggal, jam, atau kamar) dilakukan dengan memperbarui data pada record `JadwalOk` yang tetap berstatus `ACTIVE`, disertai pencatatan histori perubahan lengkap dalam jejak audit.
7. **Sinkronisasi Otomatis Siklus Hidup Dua Arah**:
   - Pembentukan JadwalOK (`ACTIVE`) secara otomatis memperbarui status `OrderOk` terkait menjadi **`Terjadwal (Scheduled)`**.
   - Pembatalan JadwalOK (`CANCELED`) secara otomatis mengembalikan status `OrderOk` terkait menjadi **`Diajukan (Requested)`** (sehingga siap dijadwalkan ulang).
   - Pembatalan `OrderOk` (`CANCELED`) secara otomatis memicu pembatalan JadwalOK terkait menjadi **`CANCELED`**.
8. **Pencegahan Modifikasi Pasca Operasi Berjalan**:
   - JadwalOK yang prosedurnya telah dimulai atau diselesaikan di `KMO-OPR` tidak dapat diubah slot waktunya atau dibatalkan melalui level penjadwalan.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan jadwal tersimpan secara persisten dengan nomor unik `JadwalOkId` dan status `ACTIVE`.
2. Slot kamar operasi fisik dan rentang waktu terkunci pada matriks papan jadwal kamar operasi (*Operating Theatre Master Board*).
3. Status entitas `OrderOk` terkait tersinkronisasi menjadi `Terjadwal (Scheduled)`.
4. Peristiwa penjadwalan operasi tercatat pada riwayat perjalanan pasien di `ADM-TRACKER`.
5. Jadwal tersedia dan dapat diakses sebagai dokumen rujukan bagi tahap verifikasi pra-bedah (*PreOperativeClearance* / `KMO-PREOP`) dan persiapan pelaksanaan pembedahan (*KMO-OPR*).

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:** Koordinator atau staf penjadwalan kamar bedah membuka daftar permintaan operasi (`OrderOk` berstatus `Requested`), memilih kamar bedah fisik yang tersedia, menentukan rentang waktu pelaksanaan, dan menetapkan dokter operator utama.

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat:** Seluruh parameter jadwal kamar operasi berhasil divalidasi, disimpan secara persisten dengan identifier unik `JadwalOkId` dan status `ACTIVE`, slot kamar terkunci, dan status `OrderOk` terkait tersinkronisasi menjadi `Scheduled`.

---

## 7. Business Constraints

1. **Integritas Alokasi Fasilitas Fisik (Invarian Ruangan Eksklusif)**:
   - Satu kamar operasi fisik tidak dapat dialokasikan untuk lebih dari satu tindakan pembedahan pada interval waktu yang sama.
2. **Ketergantungan Mutlak pada Permintaan Operasi (Order-Driven Scheduling)**:
   - Penjadwalan kamar operasi tidak dapat berdiri sendiri tanpa adanya entitas `OrderOk` yang sah dan aktif.
3. **Pemisahan Semantik Status Jadwal vs Status Order**:
   - Status entitas JadwalOK murni merepresentasikan status alokasi slot: **`ACTIVE`** atau **`CANCELED`**.
   - Tahapan siklus hidup perjalanan klinis pasien (`SCHEDULED`, `CLEARED`, `IN-PROGRESS`, `COMPLETED`) dikelola secara berdaulat oleh entitas `OrderOk` dan tahapan operasional masing-masing.
4. **Audit Trail Revisi & Pembatalan Non-Destructive**:
   - Sistem tidak melakukan penghapusan data secara fisik (*no hard delete*). Setiap pergeseran jadwal dan pembatalan slot kamar wajib tercatat dengan riwayat kronologis lengkap (waktu, petugas, dan alasan).
5. **Kemandirian dari Dokumentasi Klinis Intra-Bedah**:
   - JadwalOK mengelola alokasi fasilitas, waktu, dan tim, bukan mencatat sayatan operasi riil, laporan pembedahan, atau rekam medis anestesi intra-bedah yang merupakan wewenang domain EMR dan `KMO-OPR`.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: OrderOK Tidak Ditemukan atau Tidak Valid** | Pengguna berupaya membuat jadwal tanpa referensi `OrderOkId`, atau OrderOK berstatus selain `Diajukan (Requested)`. | Sistem menolak pembuatan jadwal dan menampilkan pesan bahwa penjadwalan hanya dapat dilakukan pada pesanan operasi aktif yang berstatus `Diajukan`. |
| **EX-02: Bentrok Ruang Kamar Operasi (Room Collision)** | Pengguna memilih kamar bedah fisik dan rentang waktu yang bertabrakan (*overlapping*) dengan JadwalOK berstatus `ACTIVE` lainnya. | Sistem menolak secara mutlak (Hard Block) penyimpanan jadwal dan menampilkan informasi jadwal yang sedang menempati slot kamar tersebut. |
| **EX-03: Bentrok Dokter Operator Utama** | Dokter operator utama yang dipilih telah memiliki jadwal operasi `ACTIVE` di kamar lain pada rentang waktu yang sama. | Sistem memunculkan dialog peringatan (*Soft Warning*). Penjadwalan dapat dilanjutkan jika koordinator kamar operasi memberikan konfirmasi otorisasi (*override*). |
| **EX-04: Pelanggaran Jeda Waktu Sterilisasi (Turnover Buffer Violation)** | Jadwal baru dialokasikan langsung bersambung dengan jadwal sebelumnya di kamar yang sama tanpa menyisakan standar waktu sterilisasi/pembersihan. | Sistem memunculkan dialog peringatan (*Soft Warning*). Jadwal dapat disimpan jika koordinator memberikan konfirmasi *override* (misal: kasus darurat Cito atau prosedur bersih berturut-turut). |
| **EX-05: Pembatalan Jadwal Tanpa Alasan Resmi** | Staf mengubah status JadwalOK menjadi `CANCELED` tanpa menginput keterangan alasan pembatalan. | Sistem menolak pembatalan jadwal dan mewajibkan pengisian alasan pembatalan resmi. |
| **EX-06: Upaya Modifikasi pada Operasi yang Telah Berjalan atau Selesai** | Staf mencoba menggeser waktu, kamar, atau membatalkan JadwalOK yang prosedurnya telah dimulai di `KMO-OPR`. | Sistem menolak perubahan jadwal secara mutlak dan mengarahkan pengguna bahwa tindakan bedah sedang berlangsung/telah selesai di ruang operasi. |
| **EX-07: Dokter Operator Tidak Memiliki Kredensial Bedah Aktif** | Dokter yang ditugaskan sebagai operator utama tidak memiliki surat penugasan klinis / kewenangan klinis spesialisasi bedah aktif di `ORG-PPA`. | Sistem menolak penyimpanan jadwal dan mewajibkan penugasan dokter operator yang memiliki kredensial bedah sah. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat jadwal operasi baru dengan identifier unik `JadwalOkId`, status `ACTIVE`, kamar bedah fisik teralokasi, tanggal dan rentang jam definitif, serta dokter operator utama. | Completeness |
| **AC-02** | Keberhasilan pembentukan JadwalOK (`ACTIVE`) secara otomatis memperbarui status `OrderOk` terkait menjadi `Terjadwal (Scheduled)` dan mencatat event penjadwalan pada `ADM-TRACKER`. | Synchronization (Order & Tracker) |
| **AC-03** | Upaya penjadwalan pada kamar bedah fisik yang telah memiliki jadwal `ACTIVE` lain pada jam yang sama ditolak secara mutlak oleh sistem (Hard Constraint). | Constraint (Zero Room Collision) |
| **AC-04** | Upaya penjadwalan dokter operator yang bentrok atau jeda turnover yang kurang memunculkan peringatan (*Soft Warning*), namun berhasil disimpan jika di-override oleh koordinator OK. | Business Rule (Warning & Override) |
| **AC-05** | Perubahan tanggal, jam, atau kamar pada jadwal operasi mempertahankan status `ACTIVE` dan merekam riwayat perubahan (data lama, data baru, alasan, petugas) dalam jejak audit. | Correctness (Reschedule In-Place) |
| **AC-06** | Pembatalan JadwalOK berhasil mengubah status jadwal menjadi `CANCELED`, melepaskan slot kamar bedah, merekam alasan pembatalan dalam audit trail, dan mengembalikan status `OrderOk` terkait menjadi `Diajukan (Requested)`. | Lifecycle Rollback & Audit Trail |
| **AC-07** | Pembatalan pada entitas `OrderOk` secara otomatis membatalkan (`CANCELED`) entitas `JadwalOk` aktif terkait dan melepaskan slot kamar bedah fisik. | Two-Way Synchronization |
| **AC-08** | Koordinator OK dapat melakukan dislokasi terkendali (*Controlled Bump*) terhadap jadwal elektif dengan mencatat alasan darurat Cito guna membebaskan kamar untuk operasi Cito. | Exception / Policy (Cito Bump) |
| **AC-09** | JadwalOK berstatus `ACTIVE` dapat diakses dan digunakan oleh kapabilitas `KMO-PREOP` (*PreOperativeClearance*) dan `KMO-OPR` (*Operative Procedure*) sebagai entitas masukan resmi. | Integration (Downstream Consumers) |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `JadwalOk`:

- **Pencatatan Permintaan & Indikasi Klinis Operasi:** Penentuan kebutuhan operasi, prosedur yang diminta, diagnosis pra-bedah, dan penandaan kebutuhan darah/implan (merupakan wewenang `KMO-ORDER` / Outcome *OrderOk*).
- **Verifikasi Kelayakan Klinis Pra-Bedah:** Pemeriksaan hasil laboratorium/radiologi pra-bedah, verifikasi informed consent, dan asesmen pra-anestesi (merupakan wewenang `KMO-PREOP` / Outcome *PreOperativeClearance* dan domain EMR).
- **Pelaksanaan Prosedur Bedah & Laporan Operasi:** Pencatatan waktu insisi riil, waktu penutupan luka riil, pemakaian obat anestesi, serta laporan operasi intra-bedah (merupakan wewenang `KMO-OPR` dan EMR).
- **Pemulihan Pasca-Bedah:** Observasi dan pemantauan kondisi pasien di ruang pemulihan / PACU (merupakan wewenang `KMO-RECOVERY`).
- **Penetapan Tarif & Penagihan Finansial:** Perhitungan biaya pemakaian sewa kamar bedah, biaya sewa alat khusus, serta jasa medis tim dokter (merupakan wewenang `TRK-BILLING` dan `TRK-TARIF`).
- **Manajemen Master Fasilitas & Kredensial PPA:** Pendaftaran master fisik kamar bedah dan pengelolaan izin/kredensial staf medis (merupakan wewenang domain `ORG`).
