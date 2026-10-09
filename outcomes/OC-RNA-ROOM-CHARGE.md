# OUTCOME: RoomCharge (Calculated Inpatient Room Charge)

| Field       | Value               |
|-------------|---------------------|
| Code        | OC-RNA-ROOM-CHARGE  |
| Version     | 1.0                 |
| Status      | Draft               |
| LastUpdated | 2026-10-10          |

---

## 1. Business Purpose

Rumah sakit harus dapat menghitung, membebankan, dan memelihara status pembebanan biaya akomodasi rawat inap (*Room Charge*) secara resmi, akurat, dan transparan sebagai fakta bisnis persisten (*persisted business fact*).

Fakta Room Charge merupakan jembatan operasional-keuangan antara penempatan fisik tempat tidur pasien di unit bangsal (`RNA-BED`) dengan penatausahaan tagihan finansial pasien di Tata Rekening (`TRK-BILLING`). Perhitungan sewa kamar menetapkan lama hari rawat yang dapat dibebankan (*chargeable units*), tarif dasar yang berlaku berdasarkan hak kelas dan konfigurasi ruangan, penanganan perpindahan kamar (*intra-day transfer*), pembebanan kasus rawat gabung (*rooming-in*), serta selisih kelas (*titip kelas* dan *naik kelas*).

Keberadaan fakta bisnis ini penting untuk:
1. Menjamin bahwa pasien dan penjamin dikenakan biaya sewa kamar yang adil, konsisten, dan dapat dipertanggungjawabkan sesuai durasi okupansi riil, jam cut-off, dan toleransi keterlambatan (*grace period*).
2. Memfasilitasi pencatatan pembebanan harian secara berkala (model harian otomatis) sehingga akun tagihan pasien mencerminkan posisi biaya riil terkini (*real-time billing visibility*) tanpa menunggu kepulangan akhir.
3. Mencegah sengketa penagihan (*billing disputes*) dan tagihan ganda (*double-billing*) saat terjadi pergantian tempat tidur atau alih rawat bangsal dalam siklus hari yang sama.
4. Menyediakan rincian transparansi komponen biaya akomodasi (sewa kamar, asuhan keperawatan bangsal, dan konsumsi/makan) yang dapat ditelusuri (*traceable*) ke episode registrasi dan interval penempatan tempat tidur yang sah.

---

## 2. Outcome Statement

Perhitungan biaya sewa kamar rawat inap telah ditetapkan dan tersimpan secara persisten sebagai fakta pembebanan akomodasi yang sah (`Calculated Room Charge exists`), menetapkan durasi hari rawat yang dapat ditagihkan, tarif dasar yang berlaku, serta komponen rincian biaya akomodasi berdasarkan interval penempatan tempat tidur terverifikasi, dan siap dikonsolidasikan ke dalam rincian tagihan pasien (`TRK-BILLING`).

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Rawat Inap** (`RNA`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas logika perhitungan pembebanan kamar (`RNA-CHARGE`), evaluasi durasi penempatan tempat tidur, penegakan jam *cut-off* dan toleransi *checkout*, penerapan aturan penyerapan alih rawat (*intra-day transfer*), serta penerbitan transaksi sewa kamar. |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan master struktur dan besaran nominal tarif kamar (`TRK-TARIF`), serta mengonsolidasikan item tagihan akomodasi kamar ke dalam rekening tagihan episode pasien (`TRK-BILLING`). |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan data struktural kelas fisik tempat tidur, ruangan, dan unit bangsal perawatan melalui `ORG-BANGSAL`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks resmi episode registrasi rawat inap aktif (`RegId`) pasien melalui `ADM-REG`. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan identitas demografi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `RNA-CHARGE` Room Charge | Rawat Inap | Known | **Primary Capability:** Menghitung durasi hari rawat, menentukan aturan pembebanan kamar (harian, transfer, same-day, titip kelas), mempersistensikan kalkulasi Room Charge, dan menerbitkan item transaksi akomodasi. |
| `RNA-BED` Pakai Bed | Rawat Inap | Known | Menyediakan data interval okupansi aktif dan historis (`OccupancyId`, waktu *check-in*, waktu *check-out*, kelas fisik, *billing class*, dan relasi *rooming-in*). |
| `TRK-TARIF` Tarif | Tata Rekening | Known | Menyediakan master tarif dasar sewa kamar per kelas rawat beserta struktur komponennya (akomodasi, keperawatan bangsal, gizi/makan). |
| `TRK-BILLING` Billing | Tata Rekening | Known | Menerima dan menghimpun item tagihan akomodasi kamar ke dalam akun episode tagihan pasien dan menyediakan verifikasi status kelayakan transaksi (sebelum `Final`). |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks registrasi rawat inap aktif (`RegId`) sebagai prasyarat otorisasi pembebanan. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien (Nomor RM dan nama lengkap) untuk ketertelusuran tagihan. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Perhitungan Biaya Sewa Kamar (*Room Charge*) dinyatakan terbentuk (*established*) jika fakta bisnis berikut terpenuhi secara lengkap:

1. **Eksistensi Record Kalkulasi Terverifikasi**:
   - Terbentuk satu catatan kalkulasi unik (`RoomChargeId`) yang mengaitkan subjek pasien, episode registrasi (`RegId`), dan interval okupansi (`PakaiBedId`).
2. **Penetapan Durasi Terhitung (*Chargeable Units*)**:
   - Tercatat kuantitas hari rawat yang dapat dibebankan (misal: 1.0 hari untuk hari penuh/same-day, atau 0.5 hari untuk keterlambatan *checkout* parsial sesuai *grace period*).
3. **Penerapan Tarif Berdasarkan Billing Class**:
   - Nilai tarif dasar diambil secara akurat dari `TRK-TARIF` pada tanggal kalkulasi yang berlaku dengan mengacu pada `Billing Class` yang ditetapkan pada interval `PakaiBed`.
   - Transparansi perbedaan antara kelas fisik tempat tidur (`Physical Class`), kelas hak penjamin (`Payer Class`), dan kelas pembebanan (`Billing Class`) tercatat secara audit.
4. **Dekomposisi Komponen Biaya Akomodasi**:
   - Nilai sewa kamar tercatat baik dalam total lump-sum maupun terurai ke sub-komponennya (jasa akomodasi kamar, asuhan keperawatan bangsal, konsumsi/makan) mengikuti konfigurasi struktur tarif pada `TRK-TARIF`.
5. **Keterikatan dengan Rincian Tagihan (*Billing Synchronization*)**:
   - Item tagihan akomodasi sewa kamar berhasil diterbitkan dan tertaut ke akun tagihan pasien di `TRK-BILLING` dengan mempertahankan referensi ketertelusuran ke `RoomChargeId`.
6. **Status Siklus Hidup yang Definitif**:
   - Record memiliki status yang jelas: **Posted (Aktif Masuk Billing)**, **Reconciled / Adjusted (Telah Disesuaikan)**, atau **Reversed / Cancelled (Dibatalkan / Distorno)**.

---

### 5.2 Required Recorded Information

Setiap transaksi `RoomCharge` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Kalkulasi & Pelayanan:
- **`RoomChargeId`**: Identitas unik catatan kalkulasi sewa kamar.
- **`PakaiBedId` / `OccupancyId`**: Referensi ke interval penempatan tempat tidur sumber (`OC-RNA-PAKAI-BED`).
- **`RegId`**: Nomor unik registrasi rawat inap aktif pasien.
- **Identitas Pasien**: Nomor Rekam Medis dan nama lengkap pasien.

#### B. Lokasi Perawatan & Parameter Kelas:
- **Unit Bangsal & Kamar**: Kode bangsal, ruangan, dan nomor tempat tidur yang ditempati.
- **Kelas Fisik Tempat Tidur (*Physical Class*)**: Kelas tempat tidur riil berdasarkan master `ORG-BANGSAL`.
- **Kelas Pembebanan (*Billing Class*)**: Kelas tarif rawat inap yang digunakan sebagai basis perkalian sewa kamar.
- **Kelas Hak Penjamin (*Payer Class*)**: Kelas perawatan yang dijamin oleh penjamin/asuransi pasien (misal BPJS Kelas 1/2/3).
- **Indikator Titip Kelas / Naik Kelas**:
  - `IsTitipKelas`: Penanda boolean jika pasien dititipkan di kelas lebih tinggi karena kamar haknya penuh.
  - `IsNaikKelas`: Penanda boolean jika pasien meningkatkan kelas perawatan atas permintaan sendiri.
  - `DifferentialAmount`: Nilai selisih tarif per hari yang menjadi dasar iur biaya pasien di Tata Rekening.

#### C. Parameter Waktu & Aturan Durasi:
- **Tanggal Siklus Tagihan (*Charge Cycle Date*)**: Tanggal kalender pembebanan kamar yang diproses.
- **Waktu Masuk & Keluar (*Check-in & Check-out Timestamp*)**: Rentang waktu okupansi pada hari/interval terkait.
- **Kuantitas Hari Pembebanan (*Charged Units*)**: Nilai numerik hari rawat yang dikenakan (contoh: 1.0, 0.5).
- **Kategori Aturan Durasi yang Diterapkan**:
  - `Daily Cut-off Posting`: Pembebanan harian rutin melewati jam cut-off bangsal.
  - `Same-day Stay`: Admisi dan pemulangan pada tanggal kalender yang sama (dihitung minimal 1 hari).
  - `Checkout Grace Period`: Pembebanan saat pemulangan (gratis toleransi, 0.5 hari, atau 1.0 hari penuh).
  - `Intra-day Transfer Absorption`: Pembebanan hari alih rawat dengan penyerapan kelas tertinggi.

#### D. Komposisi Finansial & Rincian Tarif:
- **Tarif Dasar Satuan (*Base Tariff*)**: Tarif kamar per hari sesuai `Billing Class`.
- **Nilai Total Sewa Kamar (*Total Room Charge Amount*)**: Hasil perkalian durasi x tarif dasar.
- **Rincian Sub-Komponen Tarif (sesuai konfigurasi TRK-TARIF)**:
  - *Porsi Jasa Fasilitas / Akomodasi Kamar*
  - *Porsi Jasa Asuhan Keperawatan Bangsal*
  - *Porsi Biaya Konsumsi / Gizi Pasien*

#### E. Status Operasional & Jejak Audit (*Audit Trail*):
- **Status Transaksi**: `Posted`, `Adjusted`, atau `Reversed`.
- **ID Transaksi Billing (*BillingItemRefId*)**: Nomor referensi item tagihan di `TRK-BILLING`.
- **Waktu & Pemicu Kalkulasi**: Waktu pembentukan transaksi beserta pemicunya (*Daily Scheduled Job* atau *Event Checkout/Transfer*).
- **Petugas / Sistem**: Identitas sistem otomatis atau staf perawat/kasir yang memicu proses.
- **Keterangan Koreksi**: Alasan penyesuaian/storno dan referensi transaksi pembalik (wajib jika terjadi rekalkulasi).

---

### 5.3 Required Business Conditions

1. **Keabsahan Interval PakaiBed**:
   - Interval penempatan tempat tidur harus berstatus sah (`Occupied` atau `Released`) pada `OC-RNA-PAKAI-BED`.
2. **Ketersediaan Master Tarif**:
   - Master tarif untuk kelas pembebanan yang bersangkutan harus aktif dan berlaku pada tanggal pembebanan di `TRK-TARIF`.
3. **Episode Billing Terbuka**:
   - Episode penagihan pasien pada `TRK-BILLING` belum berstatus `Final`. Pembebanan atau koreksi baru ditolak jika tagihan telah difinalisasi.
4. **Bebas Biaya Kamar Tambahan untuk Rawat Gabung (*Rooming-in*)**:
   - Bayi baru lahir yang berstatus rawat gabung di tempat tidur ibu tidak dikenakan biaya sewa kamar mandiri (kuantitas unit kamar bayi = 0, sewa kamar ditagihkan penuh pada registrasi ibu).
   - Apabila bayi dipindahkan ke ruang perinatologi/inkubator/NICU terpisah, pembebanan sewa ruang neonatus mandiri baru diberlakukan.
5. **Penyerapan Kelas Tertinggi pada Intra-day Transfer**:
   - Jika pasien berpindah kamar lebih dari satu kali dalam satu siklus hari pembebanan yang sama, sistem hanya menerbitkan 1 kali tagihan kamar untuk hari tersebut dengan menerapkan tarif kelas tertinggi yang ditempati.
6. **Ketentuan Minimal Rawat (*Same-day Admission & Discharge*)**:
   - Pasien yang masuk dan keluar pada hari kalender yang sama dikenakan biaya sewa kamar minimal 1 hari penuh (kecuali ditentukan lain oleh paket tindakan one-day care di Tata Rekening).

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan `RoomCharge` tersimpan persisten dengan identitas unik, durasi hari rawat terhitung, dan rincian tarif yang sah.
2. Item transaksi sewa kamar berhasil terbit dan terdaftar pada rincian tagihan pasien di `TRK-BILLING` dengan mencantumkan referensi `RoomChargeId`.
3. Jumlah akumulasi tagihan akomodasi pada rekening pasien bertambah secara presisi dan konsisten secara matematis sesuai kuantitas durasi x tarif kamar.
4. Informasi keterisian sewa kamar pada panel bangsal dan dashboard kasir menampilkan status "Up to Date / Posted" untuk tanggal siklus terkait.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:**
  - Waktu *cut-off* harian bangsal tercapai (misal pukul 12.00 siang atau 00.00 tengah malam) untuk pasien yang sedang aktif menempati tempat tidur rawat inap (*Daily Posting Trigger*), **ATAU**
  - Staf bangsal mencatat pelepasan tempat tidur pada saat alih rawat (*transfer*) atau pemulangan pasien (*discharge*) sebelum proses finalisasi kasir (*Event-driven Reconciliation Trigger*).

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat:**
  - Perhitungan durasi dan nominal sewa kamar selesai dikalkulasi, tersimpan persisten sebagai entitas `RoomCharge`, dan seluruh item transaksi tagihan akomodasi kamar berhasil disinkronkan ke dalam rincian tagihan pasien di `TRK-BILLING`.

---

## 7. Business Constraints

1. **Model Pembebanan Hybrid (Daily Cut-off + Final Reconciliation)**:
   - Sistem wajib melakukan pembebanan harian rutin berjalan pada setiap jam cut-off agar biaya sewa kamar terakumulasi secara bertahap dan dapat dilihat secara riil setiap hari.
   - Pada saat pasien pulang atau alih rawat, sistem melakukan rekonsiliasi final untuk menghitung sisa waktu sejak cut-off terakhir hingga waktu pelepasan bed.
2. **Aturan Jam Cut-off & Toleransi Bertingkat (*Tiered Grace Period*)**:
   - Batas jam cut-off harian rumah sakit (misal jam 12.00 siang) menjadi penanda pergantian hari rawat.
   - Waktu checkout melewati jam cut-off dievaluasi dengan aturan berjenjang:
     - Keterlambatan dalam rentang toleransi (*grace period*, misal s/d 2 jam): bebas biaya tambahan (0 hari).
     - Keterlambatan melebihi toleransi hingga batas parsial (misal > 2 jam s/d 6 jam): dikenakan sewa 0.5 hari.
     - Keterlambatan melebihi batas parsial (misal > 6 jam): dikenakan sewa 1 hari penuh.
3. **Larangan Double-Billing pada Intra-day Transfer**:
   - Pasien yang berpindah bed/kamar reguler pada tanggal yang sama tidak boleh dikenakan dua tagihan hari penuh sekaligus; sistem menyerap pembebanan menjadi 1 tagihan dengan tarif kelas kamar tertinggi yang ditempati pada hari tersebut.
4. **Non-Charging untuk Bayi Rawat Gabung (*Rooming-in*)**:
   - Tempat tidur ibu yang ditempati bersama bayi rawat gabung hanya menerbitkan satu tagihan sewa kamar (pada registrasi ibu). Tindakan medis atau keperawatan bayi tetap dicatat mandiri di tindakan tanpa membebankan sewa kamar tambahan untuk bayi.
5. **Basis Billing Class & Audit Transparansi Selisih**:
   - Kalkulasi sewa kamar selalu mengalikan kuantitas durasi dengan tarif dasar yang sesuai dengan `Billing Class`.
   - Pada kasus Titip Kelas (kamar penuh), `Billing Class` diset setara hak kelas pasien, dan selisih terhadap tarif kelas fisik dicatat sebagai beban subsidi internal RS.
   - Pada kasus Naik Kelas atas permintaan sendiri, `Billing Class` diset ke kelas upgrade, dan selisih terhadap hak penjamin dicatat sebagai tagihan iur biaya pasien.
6. **Immutability Setelah Billing Episode Berstatus Final**:
   - Apabila akun tagihan pasien pada `TRK-BILLING` telah berstatus `Final`, sistem menolak seluruh pembebanan baru, koreksi otomatis, maupun pembatalan Room Charge pada episode terkait. Koreksi data historis hanya dapat dilakukan setelah status `Final` dibuka kembali melalui wewenang supervisi Tata Rekening.
7. **Mekanisme Koreksi Non-Destruktif (Storno & Penyesuaian Ter-audit)**:
   - Jika interval `PakaiBed` dikoreksi (misal perubahan jam checkout atau pembatalan penempatan) sebelum billing `Final`, sistem tidak menghapus transaksi sewa kamar historis secara destruktif, melainkan menerbitkan transaksi pembalik (*storno / reversal item*) dan catatan rekalkulasi baru yang saling tertaut dalam jejak audit.
8. **Ketertelusuran Mutlak (*Traceability*)**:
   - Setiap transaksi sewa kamar wajib memelihara referensi langsung ke `PakaiBedId`, `RegId`, dan `BillingItemRefId` di Tata Rekening.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Tarif Kamar Tidak Ditemukan / Tidak Aktif** | Master tarif untuk `Billing Class` dan tanggal siklus yang bersangkutan tidak ditemukan atau dinonaktifkan di `TRK-TARIF`. | Perhitungan sewa kamar diblokir; sistem mencatat status gagal kalkulasi dan memunculkan peringatan konfigurasi master tarif kepada petugas/administrator. |
| **EX-02: Episode Billing Telah Berstatus Final** | Proses kalkulasi harian atau rekonsiliasi checkout dipicu, namun akun tagihan episode pasien di `TRK-BILLING` telah ditetapkan `Final`. | Sistem menolak penerbitan transaksi sewa kamar baru, mencatat insiden penolakan dalam log audit, dan menginstruksikan pengguna untuk berkoordinasi dengan Tata Rekening jika koreksi diperlukan. |
| **EX-03: Anomali Kronologis Waktu Penempatan** | Waktu checkout yang tercatat pada interval `PakaiBed` mendahului waktu check-in, atau format timestamp korup. | Kalkulasi sewa kamar ditolak; sistem menandai interval penempatan sebagai anomali data yang wajib diperbaiki pada domain Rawat Inap (`RNA-BED`). |
| **EX-04: Upaya Double-Posting pada Siklus yang Sama** | Pemicu pembebanan harian dijalankan ulang untuk tanggal kalender dan interval bed yang transaksinya telah berstatus `Posted`. | Sistem mengenali transaksi yang telah ada (*idempotent verification*) dan mencegah penerbitan tagihan ganda untuk siklus yang sama. |
| **EX-05: Pelanggaran Penempatan Bayi Non-Rawat Gabung** | Bayi baru lahir tercatat menempati bed fisik tersendiri di luar bed ibu, namun diklaim sebagai pembebanan 0 (rawat gabung). | Sistem menolak penerapan aturan bebas biaya kamar dan mewajibkan pembebanan sewa kamar sesuai kelas fasilitas ruang neonatus yang ditempati. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat kalkulasi `RoomCharge` dengan identifier unik, waktu perhitungan yang valid, durasi terhitung, dan menghubungkannya secara presisi dengan `PakaiBedId` dan `RegId`. | Completeness |
| **AC-02** | Nilai sewa kamar terhitung tepat secara matematis berdasarkan durasi x tarif dasar `Billing Class` yang aktif di `TRK-TARIF`, serta mendukung dekomposisi komponen biaya akomodasi. | Correctness |
| **AC-03** | Admisi dan discharge pada tanggal kalender yang sama (*same-day stay*) secara akurat dibebankan minimal 1 hari rawat penuh. | Business Rule (Same-day) |
| **AC-04** | Keterlambatan *checkout* melewati jam cut-off harian dievaluasi secara akurat sesuai batas *grace period* (toleransi gratis, 0.5 hari, atau 1.0 hari penuh). | Business Rule (Grace Period) |
| **AC-05** | Pasien yang berpindah kamar pada hari yang sama hanya dibebankan 1 kali sewa kamar dengan menerapkan tarif kelas tertinggi yang ditempati hari itu. | Business Rule (Intra-day Transfer) |
| **AC-06** | Bayi baru lahir dengan status Rawat Gabung (*Rooming-in*) pada tempat tidur ibu tidak dikenakan biaya sewa kamar tambahan (kuantitas kamar = 0). | Business Rule (Rooming-in) |
| **AC-07** | Kasus Titip Kelas dan Naik Kelas mencatat kelas fisik riil dan kelas penjamin secara transparan, serta menghitung selisih tarif (*Differential Amount*) untuk kebutuhan iur biaya di Tata Rekening. | Business Rule (Selisih Kelas) |
| **AC-08** | Item tagihan akomodasi kamar berhasil diterbitkan ke `TRK-BILLING` dan langsung tercermin pada rincian tagihan pasien. | Boundary (TRK-BILLING Sync) |
| **AC-09** | Koreksi interval penempatan sebelum tagihan `Final` berhasil memicu rekalkulasi dan penerbitan transaksi pembalik (*storno*) ter-audit tanpa menghapus data historis secara destruktif. | Constraint & Audit Trail |
| **AC-10** | Upaya pembebanan atau rekalkulasi sewa kamar pada episode tagihan yang telah berstatus `Final` berhasil dicegah oleh sistem. | Constraint & Exception Handling |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `RoomCharge`:

- **Pencatatan Fisik Check-in dan Check-out Bed:** Pendaftaran penempatan fisik pasien ke tempat tidur dan pelepasan bed di bangsal (merupakan wewenang `RNA-BED` pada [`OC-RNA-PAKAI-BED`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-PAKAI-BED.md)).
- **Penetapan Nilai Rupiah Master Tarif:** Pembuatan, pembaruan, dan pengelolaan nominal master tarif kamar dan formula harga (merupakan wewenang `TRK-TARIF` pada Domain Tata Rekening).
- **Konsolidasi Akun Tagihan & Finalisasi Episode:** Penutupan episode tagihan, verifikasi rincian tagihan keseluruhan, dan penetapan status tagihan menjadi `Final` (merupakan wewenang `TRK-BILLING` pada [`OC-TRK-BILLING`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-BILLING.md)).
- **Penerimaan Pembayaran Kasir & Alokasi Pembayaran:** Pembayaran tunai/non-tunai di loket kasir dan pelunasan piutang tagihan (merupakan wewenang `TRK-KASIR` dan `TRK-PAYMENT` pada [`OC-TRK-ALOKASI-PEMBAYARAN`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-ALOKASI-PEMBAYARAN.md)).
- **Pengelolaan Uang Deposit:** Penerimaan dan pemotongan uang titipan/deposit pasien (merupakan wewenang `TRK-DEPOSIT` pada [`OC-TRK-DEPOSIT`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-DEPOSIT.md)).
- **Tindakan & Prosedur Medis Inap:** Pembebanan biaya tindakan medis, visit dokter, terapi keperawatan, dan BHP medis di luar komponen akomodasi kamar (merupakan wewenang `RNA-TINDAKAN` dan `TRK-BILLING`).
- **Pembersihan & Kesiapan Fisik Bed:** Tata kelola pembersihan kasur dan sterilisasi ruangan setelah pasien checkout (merupakan wewenang `RNA-HK`).
