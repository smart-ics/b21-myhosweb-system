# OUTCOME: Ambulance (Penggunaan dan Pembebanan Biaya Ambulans)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-IGD-AMBULANCE  |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, mengoordinasikan, memvalidasi, dan mengunci penggunaan armada ambulans beserta pembebanan biayanya secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan penggunaan ambulans memastikan seluruh pergerakan transportasi medis rumah sakit—baik berupa **penjemputan darurat di lapangan (*emergency retrieval / inbound*)**, **transfer rujukan antar fasilitas kesehatan (*inter-facility referral / outbound*)**, **pemulangan pasien pasca-rawat inap/rawat jalan (*patient discharge transport*)**, maupun **layanan mobil jenazah (*hearse transport*)**—memiliki akuntabilitas operasional dan penagihan finansial yang sahih.

Fakta bisnis penggunaan ambulans ini berfungsi esensial untuk:
1. **Akuntabilitas Operasional Armada & Personel**: Memastikan penugasan armada kendaraan ambulans, pengemudi (*driver*), dan tenaga medis pendamping (*paramedic/nurse/doctor escort*) tercatat secara bertanggung jawab dengan pemantauan waktu serta jarak tempuh perjalanan.
2. **Kepatuhan Penentuan Tarif Resmi**: Menerapkan kalkulasi tarif dasar transportasi yang transparan dan taat asas berdasarkan salah satu dari dua metode yang ditetapkan rumah sakit—yaitu **Berdasarkan Wilayah Tujuan (*Destination Area*)** ATAU **Berdasarkan Jarak Tempuh (*Travel Distance*)**—sesuai aturan inti domain bahwa kedua metode tidak boleh digabungkan dalam satu penagihan.
3. **Agregasi Komponen Biaya Perjalanan Lengkap**: Memungkinkan konsolidasi biaya tambahan perjalanan (jasa pendamping medis, pemakaian alat kesehatan/oksigen darurat selama transportasi, serta biaya operasional tol/waktu tunggu) ke dalam satu paket pembebanan terpadu.
4. **Integrasi Akun Penagihan Pasien (*Billing*)**: Menyediakan bukti pembebanan biaya perjalanan yang siap dikirimkan ke akun tagihan pasien (`TRK-BILLING`) untuk diselesaikan oleh kasir (`TRK-KASIR`), diklaimkan kepada penjamin BPJS (`BPJ-VCLAIM` / e-Klaim), atau ditagihkan langsung sebagai biaya tunai/mandiri.

---

## 2. Outcome Statement

Penggunaan armada ambulans rumah sakit beserta pembebanan biayanya telah tercatat secara resmi sebagai fakta bisnis persisten (`Ambulance Usage & Charge exists`), terverifikasi akuntabilitas operasional perjalanannya, dan siap ditagihkan ke akun penagihan pasien (`TRK-BILLING`) atau diselesaikan pembayarannya.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan didukung Contributing Domains terkait:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Gawat Darurat** (`IGD`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab penuh atas operasional mobilisasi ambulans, penerimaan pesanan/panggilan darurat, penugasan armada dan personil, pengawasan keberangkatan dan kepulangan armada (`IGD-AMBULANCE`), serta penetapan status siklus hidup perjalanan. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan identitas demografi resmi dan Nomor Rekam Medis pasien yang menjadi subjek transportasi medis melalui `PAS-DATSOS`. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data armada ambulans fisik (sebagai aset/fasilitas unit layanan `ORG-LAYANAN`), serta master data supir, perawat, dan dokter pendamping melalui `ORG-PPA`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks nomor registrasi kunjungan aktif (`RegId` melalui `ADM-REG`) untuk rujukan/pemulangan, serta menerima penautan registrasi kunjungan baru IGD saat penjemputan pasien darurat tiba di rumah sakit. |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan master tarif ambulans berbasis wilayah dan tarif per kilometer (`TRK-TARIF`), mengelola data penjamin pembiayaan (`TRK-JAMINAN`), serta mengonsumsi pembebanan tagihan final ke akun tagihan pasien (`TRK-BILLING`) untuk pembayaran kasir (`TRK-KASIR`). |
| **BPJS** (`BPJ`) | **Contributing Domain:** Memvalidasi eligibilitas penjaminan rujukan darurat antar faskes sesuai regulasi BPJS Kesehatan melalui `BPJ-VCLAIM`. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `IGD-AMBULANCE` Ambulance | Gawat Darurat | Known | **Primary Capability:** Mencatat penggunaan armada ambulans, mengelola penugasan supir & tim pendamping, mencatat data rute/odometer, dan menghitung pembebanan tarif transportasi. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien resmi (Nomor RM, nama, umur, alamat) bagi pasien yang sudah terdaftar. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Mengelola master unit armada transportasi ambulans dan unit instalasi gawat darurat. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi petugas pengemudi (driver), perawat pendamping, dan dokter pendamping rujukan. |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks nomor registrasi aktif (`RegId`) bagi pasien rujukan/pemulangan, atau menerima asosiasi registrasi IGD pasca-penjemputan. |
| `TRK-TARIF` Tariff | Tata Rekening | Known | Menyediakan konfigurasi tarif resmi rumah sakit untuk tarif dasar zona/wilayah, tarif per km, tarif sewa mobil jenazah, dan tarif jasa pendamping. |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known | Menentukan status penjamin pembiayaan ambulans (Ditanggung Penjamin/BPJS vs Bayar Sendiri). |
| `TRK-BILLING` Billing | Tata Rekening | Known | Mengonsumsi rincian pembebanan biaya ambulans ke dalam rekening tagihan aktif pasien. |
| `BPJ-VCLAIM` VClaim | BPJS | Known | Menyediakan validasi kepesertaan jaminan BPJS Kesehatan untuk klaim rujukan antar faskes yang memenuhi indikasi medis. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Penggunaan Ambulans (*Ambulance*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Perjalanan Unik**:
   - Terbentuk satu catatan penggunaan ambulans unik dengan nomor transaksi resmi (**`AmbulanceUsageId`**).
2. **Kejelasan Kategori & Alasan Transportasi**:
   - Menetapkan tipe perjalanan transportasi medis secara definitif:
     - **Penjemputan Darurat (*Inbound Emergency Retrieval*)**
     - **Transfer Rujukan Antar Fasilitas Kesehatan (*Outbound Inter-Facility Referral*)**
     - **Pemulangan Pasien (*Patient Discharge Transport*)**
     - **Mobil Jenazah (*Hearse Transport*)**
3. **Keterikatan Konteks Subjek & Registrasi Pasien (Fleksibel Berbasis Tipe)**:
   - Untuk **Transfer Rujukan** dan **Pemulangan Pasien**, wajib terikat secara valid ke nomor registrasi aktif pasien (`RegId` pada `ADM-REG`).
   - Untuk **Penjemputan Darurat**, ambulans dapat diberangkatkan mendahului admisi formal (menggunakan identitas panggilan darurat atau `IGD-VISIT` awal) dan wajib ditautkan ke `RegId` setelah pasien tiba di IGD.
   - Untuk **Mobil Jenazah**, terikat pada data rekam medis pasien meninggal atau identitas subjek jenazah yang sah.
4. **Alokasi Armada & Personel yang Bertanggung Jawab**:
   - Teridentifikasi armada ambulans fisik spesifik (Nomor Polisi / ID Armada) dengan tipe kendaraan yang sesuai (Ambulans Transport, Ambulans Gawat Darurat/Advance Life Support [ALS], atau Mobil Jenazah).
   - Teridentifikasi petugas pengemudi resmi (*driver*).
   - Teridentifikasi tim medis pendamping (perawat dan/atau dokter pendamping jika kondisi klinis pasien darurat/kritis).
5. **Kepastian Rute, Lokasi, dan Pencatatan Waktu/Jarak**:
   - Teridentifikasi lokasi asal keberangkatan dan alamat/lokasi tujuan (nama faskes rujukan, alamat rumah, atau tempat pemakaman).
   - Tercatat waktu keberangkatan (*departure time*) dan waktu kembali armada ke rumah sakit (*return time*).
   - Tercatat angka odometer awal (*start odometer*) dan odometer akhir (*end odometer*) jika metode perhitungan berbasis jarak tempuh diterapkan.
6. **Kepatuhan Aturan Tunggal Metode Tarif (Core Invariant 6)**:
   - Penetapan tarif dasar transportasi dilakukan menggunakan **salah satu dari dua metode**, tidak boleh digabungkan:
     - **Metode Wilayah Tujuan (*Destination Area Charge*)**: Dihitung berdasarkan tabel zona/wilayah tujuan tetap.
     - **Metode Jarak Tempuh (*Travel Distance Charge*)**: Dihitung dari selisih odometer (KM riil) dikalikan tarif per kilometer.
7. **Agregasi Biaya Tambahan Perjalanan Terstruktur**:
   - Komponen biaya tambahan (jasa pendamping medis, sewa alat medis darurat/tabung oksigen selama perjalanan, serta biaya tol/parkir/waktu tunggu) dirinci secara eksplisit dan diagregasikan ke dalam total tagihan ambulans.
8. **Penetapan Penjaminan & Integrasi Akun Tagihan (`TRK-BILLING`)**:
   - Teridentifikasi penjamin pembiayaan ambulans (Ditanggung BPJS/Penjamin Rujukan atau Bayar Sendiri/Umum).
   - Pada status perjalanan selesai (*Completed*), total rincian tagihan ambulans telah terposting ke akun tagihan pasien (`TRK-BILLING`).
9. **Status Siklus Hidup yang Jelas**:
   - Memiliki status siklus hidup yang definitif: **Dipesan (*Requested*)**, **Berangkat (*Dispatched*)**, **Selesai (*Completed*)**, atau **Dibatalkan (*Cancelled*)**.

---

### 5.2 Required Recorded Information

Setiap transaksi `Ambulance` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Order & Sumber Permintaan:
- **`AmbulanceUsageId`**: Nomor unik transaksi penggunaan ambulans.
- **`RequestSource`**: Sumber permintaan (Panggilan Darurat Call Center 119/PSC, SISRUTE, Bangsal Rawat Inap, IGD, atau Permintaan Mandiri Keluarga Pasien).
- **`RegId`**: Nomor unik registrasi kunjungan aktif (wajib untuk rujukan/pemulangan; ditautkan kemudian untuk penjemputan darurat).
- **`IgdVisitId`**: Nomor kunjungan IGD terkait (opsional/kondisional).
- **Identitas Pasien/Subjek**: Nomor Rekam Medis (Nomor RM), nama pasien/subjek, usia, jenis kelamin, dan nomor kontak keluarga pemohon.

#### B. Armada & Personel Penugasan:
- **`VehicleId` / Nomor Polisi**: Nomor plat kendaraan dan nama/nomor lambung ambulans.
- **Tipe Armada**: Tipe ambulans (Ambulans Transport Dasar, Ambulans Gawat Darurat / Emergency ALS, Mobil Jenazah).
- **Pengemudi (*Driver*)**: ID dan nama petugas pengemudi penanggung jawab (`ORG-PPA`).
- **Petugas Medis Pendamping (*Escort Crew*)**: ID dan nama perawat pendamping serta dokter pendamping (opsional pada pemulangan non-kritis dan mobil jenazah).

#### C. Logistik Perjalanan, Rute, & Waktu:
- **Lokasi Asal**: Unit penjemputan / lokasi awal keberangkatan ambulans.
- **Lokasi Tujuan**: Nama fasilitas kesehatan tujuan, alamat rumah tujuan, atau lokasi kejadian.
- **Area / Zona Wilayah**: Nama zona wilayah tujuan (jika menggunakan metode wilayah).
- **Waktu Permintaan (*Request Time*)**: Tanggal dan jam pesanan dibuat.
- **Waktu Berangkat (*Dispatch Time*)**: Tanggal dan jam ambulans berangkat meninggalkan RS.
- **Waktu Tiba di Tujuan (*Arrival Time*)**: Tanggal dan jam armada tiba di lokasi tujuan.
- **Waktu Kembali (*Return Time*)**: Tanggal dan jam armada kembali ke posko ambulans RS.
- **Odometer Awal (*Start Odometer*)**: Angka KM pada speedometer saat berangkat.
- **Odometer Akhir (*End Odometer*)**: Angka KM pada speedometer saat kembali ke RS.
- **Jarak Tempuh Riil (*Total Distance KM*)**: Selisih jarak tempuh dalam kilometer (`End Odometer - Start Odometer`).

#### D. Komponen Finansial & Pembebanan Biaya:
- **Metode Charging**: `WILAYAH` (*Destination Area*) atau `JARAK` (*Travel Distance*).
- **Tarif Dasar Transportasi**: Nilai moneter tarif pokok perjalanan ambulans.
- **Rincian Komponen Tambahan**:
  - Jasa Medis Pendamping (Dokter / Perawat).
  - Pemakaian Alat Medis & Oksigen Darurat Transport.
  - Biaya Operasional Riil (Karcis Tol, Parkir, Waktu Tunggu / Standby).
- **Total Biaya Ambulans**: Akumulasi tarif dasar dan seluruh komponen tambahan.
- **Penjamin Pembiayaan**: `JaminanId` (BPJS Kesehatan, Asuransi Kerjasama, atau Bayar Sendiri / Umum).
- **Status Penagihan**: `BillingPostedStatus` (Belum Terposting, Terposting ke TRK-BILLING, atau Non-Billable/Dibatalkan).

#### E. Status Siklus Hidup & Keterangan:
- **Status**: `Requested` | `Dispatched` | `Completed` | `Cancelled`.
- **Catatan / Evaluasi Perjalanan**: Catatan insiden di perjalanan, kondisi pasien saat serah terima di tujuan, atau alasan pembatalan jika dibatalkan.
- **Biaya Pembatalan (*Standby Fee*)**: Nilai biaya pembatalan yang dikenakan (jika dibatalkan setelah armada berangkat).

---

### 5.3 Required Business Conditions

Untuk memastikan keabsahan dan integritas operasional, kondisi bisnis berikut wajib dipenuhi:

1. **Aturan Tunggal Metode Tarif (Core Invariant 6 IGD Domain)**:
   Perhitungan tarif dasar ambulans wajib memilih tepat **satu metode**: Berdasarkan Wilayah Tujuan ATAU Berdasarkan Jarak Tempuh. Sistem dilarang mengenakan kedua formula tarif dasar secara bersamaan pada transaksi ambulans yang sama.
2. **Ketersediaan Armada Fisik & Pengemudi**:
   Saat status pesanan diubah menjadi `Dispatched`, armada kendaraan dan pengemudi yang ditugaskan harus berstatus aktif, laik jalan, dan tidak sedang ditugaskan pada transaksi ambulans lain yang masih berlangsung (*no overlapping dispatch*).
3. **Integritas Nilai Odometer**:
   Bila metode perhitungan berbasis Jarak Tempuh digunakan, nilai Odometer Akhir wajib bernilai lebih besar atau sama dengan Odometer Awal (`End Odometer >= Start Odometer`).
4. **Otorisasi Petugas Medis Pendamping**:
   Untuk rujukan pasien kategori darurat atau pasien dalam perawatan intensif (ICU/HCU), penugasan minimal satu orang tenaga perawat berkualifikasi gawat darurat (didampingi dokter bila kondisi kritis) adalah wajib.
5. **Kesesuaian Penjaminan Rujukan BPJS**:
   Status penjaminan BPJS untuk biaya ambulans hanya dapat disetujui jika perjalanan memenuhi kriteria rujukan medis darurat antar faskes yang terakreditasi dan memiliki nomor rujukan / surat pengantar rujukan yang sah sesuai ketentuan `BPJ-VCLAIM`. Pemulangan atas permintaan sendiri (APS) atau mobil jenazah wajib diarahkan ke penjamin Bayar Sendiri.

---

### 5.4 Completion Proof

Penggunaan Ambulans dinyatakan selesai (*completed and established*) apabila bukti bisnis berikut dapat diverifikasi:

1. Transaksi memiliki status operasional final **`Completed`**.
2. Armada ambulans telah kembali ke posko rumah sakit dengan waktu kepulangan (*Return Time*) dan odometer akhir yang tercatat lengkap.
3. Total pembebanan biaya perjalanan ambulans telah dikunci (*locked*) dan terkirim secara utuh ke akun tagihan pasien (`TRK-BILLING`) dengan nomor referensi `AmbulanceUsageId`.
4. Status operasional kendaraan dan pengemudi pada master organisasi (`ORG-LAYANAN` dan `ORG-PPA`) telah dilepaskan dan kembali berstatus **Tersedia (*Available*)**.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika:
1. Unit klinis rumah sakit (IGD atau Bangsal Rawat Inap) membuat permintaan resmi pemesanan ambulans untuk rujukan/pemulangan pasien; ATAU
2. Petugas posko ambulans / IGD menerima panggilan darurat penjemputan dari masyarakat / PSC 119 dan mencatat inisiasi penjemputan ambulans ke dalam sistem.

### End
Outcome berakhir ketika:
1. Armada ambulans telah menyelesaikan perjalanan, bukti serah terima pasien/jenazah di tujuan dikonfirmasi, data log perjalanan (KM dan jam kembali) terekam, serta pembebanan biaya terkunci di Tata Rekening (`TRK-BILLING`); ATAU
2. Transaksi penggunaan ambulans dibatalkan secara sah (*Cancelled*) dengan pencatatan alasan pembatalan dan pembebanan biaya *standby fee* (jika pembatalan terjadi pasca-keberangkatan armada).

---

## 7. Business Constraints

Aturan mutlak yang wajib dipatuhi:

1. **Constraint Invariant Tarif**: Penghitungan tarif transportasi ambulans tidak boleh mencampurkan formula zona wilayah dan jarak kilometer untuk menentukan komponen tarif dasar yang sama.
2. **Constraint Eksklusivitas Armada**: Satu armada ambulans fisik tidak boleh ditugaskan pada lebih dari satu perjalanan aktif yang bersamaan (*concurrent dispatches are prohibited*).
3. **Constraint Penguncian Tagihan Pasca-Selesai**: Setelah status transaksi mencapai `Completed` dan biaya terposting ke `TRK-BILLING`, data rincian pembebanan ambulans tidak boleh diubah secara langsung tanpa melalui prosedur pembatalan/koreksi tagihan resmi di modul Tata Rekening.
4. **Constraint Penjaminan Rujukan vs APS**: Pemulangan pasien atas permintaan sendiri (APS) dilarang dibebankan kepada penjamin asuransi/BPJS kecuali terdapat persetujuan tertulis khusus dari penjamin bersangkutan; secara standar wajib diset ke Bayar Sendiri.
5. **Constraint Waktu Respon Cito**: Pesanan ambulans untuk rujukan darurat cito atau penjemputan darurat wajib mencatat waktu respon pemberangkatan (*response time*) dari saat pemesanan hingga armada bergerak.

---

## 8. Business Exceptions

| Kondisi Pengecualian | Perilaku Bisnis yang Diharapkan (*Expected Behavior*) |
|----------------------|------------------------------------------------------|
| **Armada ambulans tidak tersedia** (seluruh unit sedang bertugas atau dalam perbaikan) | Sistem menolak perubahan status ke `Dispatched`, memberi peringatan ketiadaan armada siaga, dan merekomendasikan koordinasi dengan penyedia ambulans jejaring eksternal / PSC 119. |
| **Pembatalan saat status `Requested`** (sebelum armada berangkat) | Transaksi ditandai `Cancelled` dengan alasan pembatalan; tidak ada biaya (*zero fee*) yang dibebankan kepada pasien atau penjamin. |
| **Pembatalan saat status `Dispatched`** (armada sudah berangkat di jalan) | Transaksi ditandai `Cancelled`, sistem menghitung dan membebankan biaya operasional/standby pembatalan (*cancellation fee*) sesuai regulasi tarif RS ke `TRK-BILLING`, dan status armada segera dikembalikan menjadi `Available`. |
| **Pasien menolak dirujuk saat ambulans tiba di lokasi / meninggal di perjalanan** | Petugas mencatat berita acara penolakan/insiden medis; biaya perjalanan tetap dihitung hingga titik lokasi kejadian dan diposting ke tagihan pasien/penjamin yang berwenang. |
| **Kerusakan armada / kecelakaan di jalan** | Petugas posko memberangkatkan armada pengganti; transaksi mencatat nomor armada pengganti tanpa melipatgandakan tarif dasar transportasi kepada pasien. |
| **Anomali Odometer (KM Akhir < KM Awal)** | Sistem memvalidasi dan menolak input penyelesaian perjalanan dengan memberikan pesan kesalahan verifikasi fisik odometer sebelum status dapat diubah ke `Completed`. |

---

## 9. Acceptance Criteria

| # | Kriteria Penerimaan (*Criterion*) | Memvalidasi (*Validates*) |
|---|----------------------------------|---------------------------|
| **AC-01** | Sistem berhasil mencatat transaksi ambulans baru (`AmbulanceUsageId`) lengkap dengan jenis perjalanan, identitas pemesan, dan tujuan perjalanan. | Completeness |
| **AC-02** | Pada pemesanan rujukan outbound dan pemulangan pasien, sistem berhasil memvalidasi keberadaan `RegId` aktif pasien; sedangkan pada penjemputan darurat inbound, sistem mengizinkan keberangkatan tanpa `RegId` di muka dan menyediakan mekanisme penautan `RegId` susulan. | Constraint & Correctness |
| **AC-03** | Sistem memvalidasi ketersediaan armada ambulans dan supir, serta mencegah penugasan ganda armada yang sedang bertugas (*in-transit*). | Constraint |
| **AC-04** | Sistem menerapkan penghitungan tarif dasar secara ketat menggunakan salah satu dari metode Wilayah ATAU metode Jarak Tempuh, dan menolak penggabungan kedua formula tarif dasar pada satu transaksi (Core Invariant 6). | Constraint |
| **AC-05** | Komponen tambahan (jasa medis pendamping, pemakaian oksigen, dan biaya tol) berhasil diagregasikan bersama tarif dasar ke dalam total tagihan akhir. | Correctness |
| **AC-06** | Saat status perjalanan diubah menjadi `Completed`, total pembebanan biaya ambulans otomatis terposting ke akun tagihan pasien (`TRK-BILLING`) dan status armada kembali menjadi `Available`. | Completeness & Correctness |
| **AC-07** | Pembatalan pesanan sebelum keberangkatan menghasilkan tagihan bernilai 0; pembatalan pasca-keberangkatan armada mengenakan biaya standby/pembatalan sesuai ketentuan rumah sakit. | Exception |
| **AC-08** | Sistem menolak input penyelesaian perjalanan berbasis jarak jika nilai odometer akhir lebih kecil daripada nilai odometer awal. | Exception & Correctness |

---

## 10. Out of Scope

Outcome ini secara tegas **TIDAK mencakup**:

1. **Dokumentasi Klinis Resume Medis Perjalanan Pasien**: Formulir transfer intra-fasilitas, pemantauan tanda-tanda vital di perjalanan, dan catatan medis informed consent rujukan dikelola secara mandiri oleh domain Rekam Medis Elektronik (EMR).
2. **Pemeliharaan Fisik & Servis Berkala Armada**: Manajemen jadwal servis mesin, ganti oli, pengujian kelayakan kendaraan bermotor (KIR), dan pemeliharaan aset fisik kendaraan dikelola oleh domain Manajemen Aset / Logistik Umum Rumah Sakit.
3. **Penyelesaian Pembayaran Kasir (*Cash Settlement*)**: Proses penagihan uang tunai, gesek kartu debit/kredit, dan pelunasan kuitansi pembayaran di loket kasir dikelola oleh Outcome Kasir (`OC-TRK-KASIR`) dan Alokasi Pembayaran (`OC-TRK-ALOKASI-PEMBAYARAN`).
4. **Platform Koordinasi Rujukan Nasional Eksternal**: Pengiriman data resume rujukan antar rumah sakit ke SISRUTE Kementerian Kesehatan dikelola oleh modul integrasi interoperabilitas eksternal rujukan.
