# OUTCOME: Registrasi Pelayanan Pasien (Unified Registrasi)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-ADM-REGISTRASI     |
| Version     | 2.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

> **Catatan Konsolidasi Arsitektur:**
> Dokumen ini merupakan artefak kanonikal tunggal (*unified Outcome*) yang mengonsolidasikan dan menggantikan dokumen terpisah sebelumnya (`OC-01-02-REG-JALAN-IGD-OUTCOME.md` dan `OC-01-03-REG-INAP.md`). Outcome ini memformalkan satu konsep registrasi pelayanan terpadu yang mencakup 4 tipe registrasi: **Rawat Jalan**, **IGD / Rawat Darurat**, **Rawat Inap**, dan **External**.

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat registrasi pelayanan pasien secara resmi sebagai fakta bisnis persisten (*persisted business fact*) yang menjadi konteks administratif resmi (*recognized administrative context*) bagi seluruh episode kunjungan dan pelayanan kesehatan di rumah sakit.

Registrasi pelayanan memastikan bahwa setiap pasien yang mengakses fasilitas rumah sakit — baik melalui jalur Rawat Jalan (poliklinik), Gawat Darurat (IGD), Rawat Inap (opname), maupun Pelayanan Penunjang Langsung (External: Laboratorium / Farmasi) — tercatat dengan identifikasi yang sah, jenis penjaminan pembiayaan yang berlaku, unit/tujuan pelayanan yang tepat, serta menerbitkan identitas registrasi warisan sistem (*legacy registration identity*) yaitu **RegId**.

Identitas `RegId` ini berfungsi krusial sebagai **kunci pengelompokan penagihan (*billing collection key*)** bagi Tata Rekening dan Kasir untuk mengagregasi seluruh pembebanan biaya pelayanan klinis, penunjang, tindakan, farmasi, dan administrasi selama episode pelayanan terkait.

Tanpa registrasi resmi yang terpersistensi:
1. Pelayanan klinis dan penunjang tidak memiliki konteks administratif yang sah untuk dikaitkan dengan pasien yang benar.
2. Penempatan tempat tidur (*bed*) untuk rawat inap tidak dapat diotorisasi.
3. Rincian tagihan (*billing*) tidak dapat dibentuk dan dikelompokkan secara akuntabel.
4. Perjalanan administratif dan riwayat episode pelayanan pasien tidak dapat ditelusuri.

---

## 2. Outcome Statement

Registrasi pelayanan pasien telah tercatat sebagai fakta bisnis aktif yang diakui sistem dengan identitas registrasi unik (`RegId`), siap menjadi konteks administratif resmi dan kunci pengelompokan penagihan (*billing collection key*) bagi seluruh aktivitas pelayanan klinis/penunjang, alokasi sumber daya operasional, dan penagihan finansial selama episode pelayanan yang bersangkutan.

---

## 3. Participating Domains

Berdasarkan tata kelola arsitektur sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan beberapa Contributing Domains:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Admission** (`ADM`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pencatatan, pemeliharaan status bisnis registrasi pelayanan pasien, penerbitan `RegId`, penentuan tipe registrasi, dan pengendalian masa berlaku administratif episode pelayanan. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan identitas pasien otoritatif (Nomor Rekam Medis terkelola dan data sosial) untuk registrasi hospital-managed reguler (Rawat Jalan, IGD teridentifikasi, Rawat Inap), serta mencatat nomor rekam medis eksternal (*distinguishable External MR*) untuk registrasi External. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan data master unit layanan, poliklinik, instalasi penunjang, bangsal/kamar, serta Petugas Pemberi Asuhan (dokter DPJP) dan jadwal praktik dokter. |
| **Gawat Darurat** (`IGD`) | **Contributing Domain:** Mengelola episode kegawatdaruratan operasional (`IGD-VISIT`) yang dapat berdiri sendiri mendahului registrasi admisi. Registrasi tipe IGD kemudian menautkan konteks administratif `RegId` ke `IGD-VISIT` aktif tersebut. |
| **Rawat Inap** (`RNA`) | **Contributing Domain:** Menerima notifikasi registrasi rawat inap sebagai pemicu antrean masuk bangsal (`RNA-ANTRIAN`) sebelum penempatan bed aktual dilakukan oleh unit bangsal penerima. |
| **Laboratory** (`LAB`) | **Contributing Domain:** Mendukung inisiasi registrasi penunjang eksternal langsung melalui kapabilitas `LAB-EXTERNAL` untuk pasien laboratorium tanpa melalui registrasi rawat jalan/inap. |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan data penjamin/coverage (`TRK-JAMINAN`), acuan tarif (`TRK-TARIF`), dan deposit (`TRK-DEPOSIT`), serta mengonsumsi `RegId` sebagai billing collection key pada pencatatan tagihan (`TRK-BILLING`) dan penyelesaian pembayaran kasir (`TRK-KASIR`). |
| **BPJS** (`BPJ`) | **Contributing Domain:** Memvalidasi kepesertaan jaminan BPJS Kesehatan dan menerbitkan Surat Eligibilitas Peserta (`BPJ-VCLAIM` / SEP) untuk kunjungan yang ditanggung oleh BPJS. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `ADM-REG` Registration | Admission | Known | **Primary Capability:** Mencatat kunjungan/pelayanan pasien dan menerbitkan `RegId` untuk seluruh tipe registrasi. |
| `ADM-ANTRIAN` Antrian Registrasi | Admission | Known | Mengelola antrean kedatangan pasien di loket pendaftaran. |
| `ADM-BOOKING` Booking | Admission | Known | Menyediakan referensi reservasi/appointment untuk registrasi rawat jalan terjadwal. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan verifikasi identitas pasien, demografi, dan nomor rekam medis. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan unit kerja, poliklinik, instalasi, dan bangsal tujuan registrasi. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan data dokter pemeriksa / DPJP yang ditugaskan. |
| `ORG-JADWAL` Jadwal Praktek Dokter | Organisasi | Known | Menyediakan validasi ketersediaan jadwal praktik dokter untuk registrasi rawat jalan. |
| `ORG-BANGSAL` Room Bangsal Management | Organisasi | Known | Menyediakan konfigurasi bangsal dan kelas perawatan untuk registrasi rawat inap. |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known | Menyediakan konteks operasional kunjungan IGD yang dapat eksis secara independen sebelum registrasi admisi. |
| `RNA-ANTRIAN` Antrian Masuk Bangsal | Rawat Inap | Known | Menampung pasien rawat inap yang telah terdaftar ke dalam antrian masuk bangsal tujuan. |
| `LAB-EXTERNAL` Registrasi External | Laboratory | Known | Menginisiasi registrasi langsung di unit laboratorium tanpa admisi umum. |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known | Menentukan penjamin pembiayaan (Umum/Bayar Sendiri, BPJS, Asuransi, Perusahaan). |
| `TRK-TARIF` Tariff | Tata Rekening | Known | Menyediakan kelas tarif dasar yang berlaku untuk registrasi. |
| `TRK-DEPOSIT` Deposit | Tata Rekening | Known | Mengaitkan saldo deposit awal pasien (terutama pada rawat inap). |
| `TRK-BILLING` Billing | Tata Rekening | Known | Mengonsumsi `RegId` sebagai kunci pengelompokan akun tagihan pasien. |
| `TRK-KASIR` Kasir | Tata Rekening | Known | Mengonsumsi `RegId` untuk transaksi pembayaran kasir di loket kasir. |
| `BPJ-VCLAIM` VClaim | BPJS | Known | Menerbitkan dan memvalidasi nomor SEP untuk pasien berpenjamin BPJS Kesehatan. |

> **Catatan Kesenjangan Kapabilitas (Scope Gap Note):**
> Kunjungan langsung pasien luar ke unit Farmasi/Apotek saat ini tidak memiliki kapabilitas terdaftar `APT-EXTERNAL` pada `domain/DOMAIN-CATALOG.md`. Sesuai aturan tata kelola, sistem tidak mengada-ada kapabilitas baru; aspek administratif registrasi eksternal farmasi dijalankan melalui `ADM-REG` dengan unit tujuan Apotek, sementara kebutuhan formal kapabilitas `APT-EXTERNAL` dilaporkan sebagai eskalasi persetujuan lingkup kepada Product Owner (lihat Bagian 11).

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Registrasi Pelayanan Pasien dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

#### 1. Fakta Bersama (Seluruh Tipe Registrasi):
- Registrasi pelayanan pasien atas subjek yang teridentifikasi telah tercatat dengan identitas unik **`RegId`**.
- Registrasi memiliki tipe yang definitif: **Rawat Jalan**, **IGD / Rawat Darurat**, **Rawat Inap**, atau **External**.
- Registrasi memiliki penjamin pembiayaan (*coverage*) yang valid (Bayar Sendiri / Umum, BPJS, Asuransi Swasta, atau Kerjasama Institusi).
- Registrasi berstatus aktif: **Terdaftar** (*Registered*).
- `RegId` tersedia dan siap dikonsumsi oleh Tata Rekening (`TRK-BILLING`) dan Kasir (`TRK-KASIR`) sebagai kunci agregasi transaksi finansial.

#### 2. Khusus Rawat Jalan:
- Kunjungan merujuk pada poliklinik tujuan dan dokter spesialis (DPJP) yang aktif pada jadwal tanggal tersebut.
- Jika berasal dari booking, reservasi terkait telah berstatus **Sudah Digunakan**.
- Pasien telah tercatat dalam antrean pelayanan poliklinik tujuan (`RJL-ANTRIAN`).
- Masa berlaku administratif registrasi dibatasi tepat **satu hari kalender pelayanan**.

#### 3. Khusus IGD / Rawat Darurat:
- Registrasi menautkan `RegId` ke catatan operasional **`IGD-VISIT`** yang sedang aktif.
- Registrasi dapat melintasi pergantian tanggal tengah malam (*cross midnight*) sebagai **satu kesatuan episode pelayanan darurat yang utuh**.
- Keberadaan registrasi admisi tidak menjadi prasyarat mutlak dimulainya tindakan pertolongan darurat atau pencatatan tindakan klinis (`IGD-TINDAKAN`).

#### 4. Khusus Rawat Inap:
- Registrasi merujuk pada DPJP penanggung jawab, bangsal tujuan, dan kelas perawatan yang sah.
- Pasien telah tercatat dalam antrean masuk bangsal penerima (`RNA-ANTRIAN`), menunggu penempatan bed (`RNA-BED`).
- Masa berlaku administratif registrasi mencakup **seluruh durasi episode rawat inap** (multi-hari, dari tanggal masuk hingga pasien resmi keluar/discharge).
- Asal rujukan admisi terdokumentasi (dari IGD, rujukan internal Rawat Jalan, atau Direct Admission).

#### 5. Khusus External (Penunjang Langsung: Lab / Farmasi):
- Pasien datang langsung ke unit penunjang tanpa melalui admisi rawat jalan atau rawat inap.
- Registrasi menerbitkan `RegId` yang sah dan mengaitkan subjek dengan **Nomor Rekam Medis Eksternal (*External MR*)** yang dapat dibedakan secara tegas dari Nomor RM reguler rumah sakit.
- Registrasi **tidak mengimplikasikan** kepemilikan atau pemeliharaan master rekam medis permanen rumah sakit.
- Masa berlaku administratif registrasi dibatasi tepat **satu hari kalender pelayanan**.

---

### 5.2 Required Recorded Information

#### A. Informasi Wajib Bersama (Seluruh Tipe):
- **`RegId`**: Nomor unik registrasi (identitas registrasi warisan sistem dan kunci pengelompokan penagihan).
- **Tipe Registrasi**: Nilai salah satu dari `Rawat Jalan`, `IGD`, `Rawat Inap`, atau `External`.
- **Waktu Registrasi**: Tanggal dan jam registrasi dibuat.
- **Identitas Subjek Pasien**:
  - Nomor Rekam Medis (Nomor RM reguler untuk RJ, IGD, RI; atau External MR untuk External).
  - Nama pasien, jenis kelamin, tanggal lahir/usia.
- **Penjamin Pembiayaan**: Kode dan nama penjamin (Umum/Bayar Sendiri, BPJS, Asuransi, dsb.).
- **Unit Layanan / Lokasi Tujuan**: Unit kerja tujuan pelayanan pasien.
- **Petugas Registrasi**: Identitas pengguna/petugas yang mencatat registrasi.
- **Status Registrasi**: Status siklus hidup registrasi (misal: *Terdaftar*, *Selesai*, *Batal*).

#### B. Informasi Spesifik Rawat Jalan:
- Poliklinik tujuan dan kode instalasi.
- Dokter pemeriksa / DPJP yang bertugas.
- Nomor urut antrean poliklinik.
- Sumber kedatangan: Datang langsung (*walk-in*) atau dari reservasi (*booking*).
- Nomor referensi booking (jika berasal dari booking).

#### C. Informasi Spesifik IGD / Rawat Darurat:
- Referensi ID `IGD-VISIT` yang ditautkan.
- Lokasi penanganan gawat darurat (Ruang Triage / Ruang Tindakan IGD).
- Cara kedatangan pasien (Sendiri, Rujukan Faskes Lain, Ambulans).
- Tanggal dan jam kedatangan IGD aktual (dapat mendahului waktu registrasi admisi).
- Kategori Triase (jika triase telah ditetapkan saat registrasi admisi dicatat).

#### D. Informasi Spesifik Rawat Inap:
- DPJP utama yang merawat.
- Bangsal/ruang perawatan tujuan.
- Kelas perawatan yang diminta/disetujui.
- Asal rujukan rawat inap (Rujukan IGD, Rujukan Rawat Jalan, Pasien Langsung).
- Referensi kunjungan asal (`RegId` Rawat Jalan atau ID `IGD-VISIT`, jika relevan).
- Riwayat deposit awal rawat inap (jika ada transaksi deposit).

#### E. Informasi Spesifik External:
- Unit penunjang yang dikunjungi (Laboratorium, Farmasi/Apotek).
- **External Medical Record Number**: Format penomoran khusus yang membedakannya dari RM reguler (misal: dengan prefiks/format khusus penunjang luar).
- Dokter perujuk eksternal / instansi perujuk luar (jika ada).
- Catatan bahwa rekam medis bersifat *unmanaged/one-time* untuk kebutuhan pelayanan penunjang langsung.

#### F. Informasi Khusus Penjamin BPJS (Berlaku untuk RJ, IGD, RI):
- Nomor kartu kepesertaan BPJS dan NIK.
- Nomor SEP (Surat Eligibilitas Peserta) resmi dari BPJS VClaim.
- Jenis pelayanan BPJS: Rawat Jalan Tingkat Lanjut (RJTL), Rawat Inap Tingkat Lanjut (RITL), atau Pelayanan Gawat Darurat.
- Tanggal SEP dan diagnosa awal/rujukan BPJS.

---

### 5.3 Required Business Conditions

1. **Kelayakan Identitas Subjek**:
   - Untuk Rawat Jalan dan Rawat Inap, pasien harus terdaftar secara sah dalam master Pasien Domain (`PAS-DATSOS`) dengan Nomor Rekam Medis reguler.
   - Untuk IGD, jika pasien belum teridentifikasi (kondisi darurat / Mr./Mrs. X), registrasi darurat dapat menggunakan identitas sementara dan dimutakhirkan setelah proses stabilisasi.
   - Untuk External, subjek dapat didaftarkan langsung pada loket penunjang dengan Nomor RM Eksternal tanpa perlu membentuk data sosial pasien permanen di Pasien Domain.
2. **Ketersediaan Sumber Daya Klinis**:
   - Untuk Rawat Jalan, dokter yang dipilih harus memiliki jadwal praktik aktif (`ORG-JADWAL`) pada hari registrasi, atau terdapat penugasan dokter pengganti resmi.
   - Untuk Rawat Inap, bangsal tujuan harus berstatus aktif dan DPJP harus memiliki kewenangan klinis aktif merawat pasien inap.
3. **Validasi Penjaminan BPJS**:
   - Registrasi berbasis BPJS memerlukan penerbitan nomor SEP yang sah melalui `BPJ-VCLAIM`. Jika sistem BPJS mengalami gangguan, registrasi dapat dicatat dengan mekanisme penandaan darurat/offline sesuai regulasi yang berlaku.
4. **Validasi Reservasi (Booking)**:
   - Jika registrasi rawat jalan menggunakan booking, referensi booking harus berstatus **Terjadwal**. Booking yang sudah dibatalkan atau kedaluwarsa tidak dapat digunakan.

---

### 5.4 Completion Proof

Outcome ini dinyatakan selesai dan terbukti terbentuk apabila:
1. Nomor registrasi unik **`RegId`** telah diterbitkan dan tersimpan secara persisten.
2. Status registrasi tercatat sebagai **Terdaftar**.
3. Bukti keterhubungan operasional terbentuk:
   - Rawat Jalan: Pasien terdaftar dalam antrean poli tujuan (`RJL-ANTRIAN`).
   - IGD: `RegId` terhubung ke catatan `IGD-VISIT` aktif.
   - Rawat Inap: Pasien terdaftar dalam antrean masuk bangsal (`RNA-ANTRIAN`).
   - External: Nomor RM Eksternal dan `RegId` terbentuk serta siap menerima pesanan layanan di unit penunjang.
4. Kueri pencarian berdasarkan `RegId`, Nomor RM, tanggal pelayanan, atau unit tujuan mengembalikan data registrasi yang valid dan konsisten.
5. `RegId` dapat digunakan secara langsung oleh domain penagihan (`TRK-BILLING`) untuk membebankan biaya layanan dan oleh Kasir (`TRK-KASIR`) untuk menerima pembayaran.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Rawat Jalan:** Dimulai saat pasien tiba di loket pendaftaran rawat jalan dan petugas menginisiasi pembuatan kunjungan untuk poliklinik dan dokter tujuan.
- **IGD / Rawat Darurat:** Dimulai saat petugas pendaftaran admisi mencatat data administratif pasien darurat untuk menautkan `RegId` ke pasien yang sedang atau telah ditangani di IGD (`IGD-VISIT`).
- **Rawat Inap:** Dimulai saat keputusan opname diterbitkan (oleh dokter IGD, dokter poli, atau dokter rujukan) dan petugas pendaftaran menginisiasi pendaftaran rawat inap dengan bangsal tujuan dan kelas perawatan yang ditentukan.
- **External:** Dimulai saat pasien tiba langsung di loket unit penunjang (Laboratorium / Farmasi) dan petugas penunjang menginisiasi registrasi pelayanan penunjang langsung.

### 6.2 End Boundary (Titik Akhir)

- **Rawat Jalan:** Berakhir saat data registrasi tersimpan dengan status **Terdaftar**, `RegId` terbit, dan pasien masuk antrean poliklinik tujuan.
- **IGD / Rawat Darurat:** Berakhir saat registrasi administratif tersimpan dengan status **Terdaftar**, `RegId` terbit, dan terhubung secara resmi ke catatan `IGD-VISIT`.
- **Rawat Inap:** Berakhir saat registrasi tersimpan dengan status **Terdaftar**, `RegId` terbit, dan pasien masuk dalam antrean masuk bangsal tujuan (`RNA-ANTRIAN`). Penempatan aktual ke tempat tidur (`RNA-BED`) berada di luar batasan Outcome ini.
- **External:** Berakhir saat registrasi tersimpan dengan status **Terdaftar**, `RegId` dan External MR terbit, dan data siap digunakan untuk pemrosesan order/penjualan penunjang.

---

## 7. Business Constraints

### 7.1 Batasan Umum
1. **Keunikan `RegId`**: Setiap nomor registrasi (`RegId`) bersifat unik secara global di seluruh sistem dan tidak boleh digunakan ulang (*reused*).
2. **Kunci Penagihan Tunggal**: Seluruh transaksi keuangan dan pembebanan biaya selama satu episode pelayanan harus mengacu pada satu `RegId` yang sama.
3. **Non-Destructive Cancellation**: Registrasi yang telah memiliki pembebanan tindakan klinis, penggunaan barang/obat, atau transaksi finansial tidak dapat dihapus secara langsung; pembatalan hanya dapat dilakukan melalui prosedur otorisasi khusus pembatalan registrasi.

### 7.2 Aturan Khusus Masa Berlaku (Validity Rules)
4. **Masa Berlaku Rawat Jalan (One Calendar Day):**
   - Registrasi Rawat Jalan hanya sah untuk **satu hari kalender pelayanan** yang sama dengan tanggal registrasi.
   - Kunjungan rawat jalan tidak dapat diperpanjang ke hari berikutnya; kedatangan di hari lain memerlukan registrasi rawat jalan baru.
5. **Masa Berlaku IGD (Episode Crossing Midnight):**
   - Registrasi IGD berlaku sepanjang durasi penanganan gawat darurat dan **diperbolehkan melintasi tengah malam (*cross midnight*)**.
   - Contoh: Pasien terdaftar di IGD pada tanggal 10 Oktober pukul 23:00 dan dipulangkan/dipindahkan pada tanggal 11 Oktober pukul 02:00 tetap berada dalam **satu episode registrasi IGD tunggal** (`RegId` yang sama). Sistem dilarang membagi atau menutup registrasi secara sepihak hanya karena pergantian tanggal kalender.
6. **Masa Berlaku Rawat Inap (Full Stay Episode):**
   - Registrasi Rawat Inap tetap berlaku secara berkelanjutan selama seluruh masa perawatan opname pasien (satu hari, beberapa hari, berminggu-minggu) hingga pasien secara resmi dipulangkan (*discharge* klinis dan administrasi *Reg-Out*).
   - Pasien tidak boleh memiliki lebih dari satu episode registrasi rawat inap aktif secara bersamaan di rumah sakit.
7. **Masa Berlaku External (One Calendar Day):**
   - Registrasi External hanya berlaku untuk **satu hari kalender pelayanan** di unit penunjang terkait.
   - Pemeriksaan atau pembelian penunjang di hari berikutnya memerlukan penerbitan registrasi eksternal baru.

### 7.3 Aturan External Registration & Rekam Medis Eksternal
8. **Distinguishable External MR**:
   - Nomor Rekam Medis untuk registrasi eksternal harus memiliki pola penomoran atau format yang secara visual dan logis dapat dibedakan dari Nomor Rekam Medis reguler rumah sakit.
9. **Ketiadaan Kewajiban Pemeliharaan Rekam Medis**:
   - External Registration tidak mewajibkan rumah sakit untuk membuka, mengelola, atau memelihara berkas rekam medis permanen pasien di Pasien Domain (`PAS-DATSOS`) maupun Berkas Rekam Medis (`BRM`).
   - External MR bersifat *one-time use* dalam konteks episode pelayanan penunjang langsung tersebut.
10. **Pemisahan Tanggung Jawab Penunjang**:
    - Pelaksanaan analisis spesimen laboratorium (`LAB-RESULT`), peracikan obat apotek (`APT-DISPENSING`), dan pemrosesan kasir (`TRK-KASIR`) berada di luar tanggung jawab REGISTRASI Outcome.

### 7.4 Aturan Independensi IGD Visit
11. **Independensi Operasional `IGD-VISIT`**:
    - Catatan kunjungan darurat (`IGD-VISIT`) dapat dibuat dan aktif sebelum registrasi admisi (`ADM-REG`) dicatat.
    - Pelayanan gawat darurat, penanganan medis segera, dan pencatatan tindakan darurat (`IGD-TINDAKAN`) tidak boleh diblokir atau ditunda demi menunggu penyelesaian registrasi admisi.
    - Registrasi admisi tipe IGD dapat dibuat menyusul (*post-arrival / post-triage registration*) dan ditautkan ke `IGD-VISIT` yang telah ada.

---

## 8. Business Exceptions

| Exception Condition | Expected Business Behavior |
|---------------------|----------------------------|
| Pasien rawat jalan / rawat inap tidak terdaftar di sistem master pasien | Registrasi reguler ditolak. Pasien harus didaftarkan terlebih dahulu di Pasien Domain (`PAS-DATSOS`) atau ditemukan data lamanya sebelum registrasi dilanjutkan. |
| Pasien darurat IGD datang tanpa identitas dan tanpa pendamping (*unidentified patient*) | Registrasi IGD tetap dapat diproses menggunakan identitas sementara darurat (*Mr./Mrs. X*). Layanan medis segera diberikan, dan identitas dimutakhirkan setelah teridentifikasi. |
| Dokter poliklinik tidak memiliki jadwal praktik aktif pada tanggal kunjungan | Registrasi Rawat Jalan ditolak. Petugas diarahkan memilih dokter pengganti yang memiliki jadwal aktif atau mengubah tanggal kunjungan. |
| Kepesertaan BPJS pasien tidak aktif atau tidak ditemukan saat verifikasi VClaim | Penerbitan SEP gagal. Registrasi BPJS ditunda atau dialihkan ke penjamin lain (Bayar Sendiri / Asuransi lain) atas persetujuan pasien. |
| Gangguan koneksi ke server BPJS VClaim saat pendaftaran pasien BPJS | Sistem mengizinkan registrasi darurat dengan penandaan menunggu SEP offline sesuai prosedur kontingensi BPJS rumah sakit. |
| Booking rujukan telah berstatus bukan 'Terjadwal' (misal: 'Sudah Digunakan' atau 'Dibatalkan') | Registrasi rawat jalan berbasis booking ditolak. Pasien diarahkan mendaftar sebagai pasien langsung (*walk-in*) jika kuota masih tersedia. |
| Pasien rawat inap masih memiliki registrasi rawat inap aktif lain yang belum di-Reg-Out | Registrasi Rawat Inap baru ditolak untuk mencegah tumpang tindih episode rawat inap. Episode aktif sebelumnya harus diselesaikan terlebih dahulu. |
| Pasien datang langsung ke Penunjang (Lab/Farmasi) meminta menggunakan jaminan BPJS tanpa rujukan faskes/internal | Registrasi External ditolak untuk penjaminan BPJS. Pasien diarahkan ke loket pendaftaran Rawat Jalan reguler untuk mendapatkan asesmen klinis dan rujukan penunjang sesuai regulasi BPJS. |
| Bangsal rawat inap yang dipilih sedang tidak aktif atau ditutup sementara | Registrasi rawat inap ke bangsal tersebut ditolak. Petugas harus memilih bangsal aktif alternatif yang sesuai dengan kelas perawatan pasien. |

---

## 9. Acceptance Criteria

| # | Kriteria Penerimaan (Acceptance Criterion) | Aspek yang Divalidasi |
|---|--------------------------------------------|------------------------|
| **AC-01** | Sistem mampu mencatat dan membedakan empat tipe registrasi: **Rawat Jalan**, **IGD / Rawat Darurat**, **Rawat Inap**, dan **External** di bawah satu entitas registrasi kanonikal dengan pengenal `RegId` unik. | Completeness |
| **AC-02** | Setiap registrasi yang berhasil terbentuk memiliki nomor registrasi unik (`RegId`) dan status bisnis aktif **Terdaftar**. | Completeness |
| **AC-03** | Registrasi Rawat Jalan memiliki masa berlaku tepat satu hari kalender, merujuk pada poliklinik tujuan, dokter aktif (`ORG-JADWAL`), serta jenis penjamin yang valid. | Correctness |
| **AC-04** | Registrasi Rawat Jalan yang merujuk pada booking terbukti mencatat nomor booking berstatus 'Terjadwal', dan mengubah status booking menjadi 'Sudah Digunakan' segera setelah registrasi terbentuk. | Correctness |
| **AC-05** | Registrasi Rawat Jalan yang berhasil otomatis menempatkan pasien ke dalam antrean poliklinik tujuan (`RJL-ANTRIAN`). | Completeness |
| **AC-06** | Registrasi IGD dapat melintasi tengah malam (*cross midnight*) dalam satu kesatuan episode pelayanan dan mempertahankan `RegId` yang sama tanpa dipecah menjadi dua registrasi kalender terpisah. | Correctness |
| **AC-07** | Catatan kunjungan gawat darurat (`IGD-VISIT`) dapat terbentuk dan tindakan pertolongan darurat (`IGD-TINDAKAN`) dapat dicatat sebelum registrasi admisi (`ADM-REG`) diselesaikan. | Constraint |
| **AC-08** | Registrasi admisi tipe IGD yang dibuat menyusul dapat ditautkan secara akurat ke ID `IGD-VISIT` aktif yang mendahuluinya. | Correctness |
| **AC-09** | Registrasi Rawat Inap tetap berlaku aktif sepanjang durasi episode rawat inap pasien (multi-hari) hingga pasien resmi dipulangkan (*discharge*). | Correctness |
| **AC-10** | Registrasi Rawat Inap mencatat identitas pasien, DPJP yang berwenang, bangsal tujuan, dan kelas perawatan, serta otomatis menempatkan pasien ke antrean masuk bangsal (`RNA-ANTRIAN`). | Completeness |
| **AC-11** | Sistem menolak pembuatan registrasi rawat inap baru jika pasien yang bersangkutan masih memiliki episode registrasi rawat inap aktif yang belum diselesaikan (*no overlapping inpatient stays*). | Constraint |
| **AC-12** | Registrasi External dapat dibuat untuk pasien yang datang langsung ke unit penunjang (Laboratorium / Farmasi) tanpa melalui pendaftaran rawat jalan atau admisi rawat inap. | Completeness |
| **AC-13** | Registrasi External menerbitkan Nomor Rekam Medis Eksternal yang polanya dapat dibedakan secara tegas dari format Nomor Rekam Medis reguler rumah sakit. | Correctness |
| **AC-14** | Nilai `RegId` yang diterbitkan dari Registrasi External valid dan dapat dikonsumsi oleh Tata Rekening (`TRK-BILLING`) dan Kasir (`TRK-KASIR`) sebagai kunci agregasi tagihan dan transaksi pembayaran. | Correctness |
| **AC-15** | Registrasi External tidak membentuk master pasien permanen di Pasien Domain dan tidak mewajibkan pembentukan berkas rekam medis permanen rumah sakit. | Constraint |
| **AC-16** | Registrasi berpenjamin BPJS Kesehatan (RJ, IGD, RI) mencatat nomor SEP yang sah dari sistem BPJS VClaim sebelum registrasi dinyatakan lengkap, kecuali diterapkan prosedur darurat offline resmi. | Correctness |
| **AC-17** | Seluruh data registrasi dapat ditelusuri (*traceable*) secara akurat berdasarkan `RegId`, Nomor RM / External RM, tanggal registrasi, unit tujuan, dan identitas penjamin. | Correctness |
| **AC-18** | Sistem menolak pendaftaran rawat jalan ke dokter yang jadwal praktiknya tidak aktif pada tanggal kunjungan jika tidak terdapat dokter pengganti resmi. | Exception |

---

## 10. Out of Scope

Outcome ini secara tegas **TIDAK** mencakup tanggung jawab berikut:

- **Pengelolaan Reservasi / Booking Sebelum Kunjungan:** Pengelolaan jadwal janji temu dan kuota booking sebelum hari pelayanan dikelola oleh **OC-ADM-BOOKING Booking** (`ADM-BOOKING`).
- **Pengelolaan Antrean Fisik Loket Pendaftaran:** Pengambilan nomor antrean tiket loket fisik pendaftaran dikelola oleh **OC-ADM-ANTRIAN Antrian** (`ADM-ANTRIAN`).
- **Penempatan Bed Rawat Inap Aktual:** Alokasi aktual tempat tidur, transfer kamar, dan pergerakan fisik bed dikelola oleh Rawat Inap Domain (**`RNA-BED`**, `OC-06-02 Pakai Bed`).
- **Pelayanan & Tindakan Medis Klinis:** Konsultasi dokter, pemeriksaan medis, dan tindakan klinis di poliklinik, IGD, maupun bangsal dikelola oleh masing-masing domain pelayanan klinis terkait (`RJL-KONSUL`, `RJL-TINDAKAN`, `IGD-TINDAKAN`, `RNA-TINDAKAN`).
- **Triase Gawat Darurat:** Pemeriksaan dan penentuan prioritas kegawatdaruratan klinis dikelola oleh Gawat Darurat Domain (`IGD-TRIAGE`, `OC-07-02 Triage`).
- **Pelaksanaan Pemeriksaan Laboratorium:** Proses pengambilan spesimen, analisis sampel, dan validasi hasil tes laboratorium dikelola oleh Laboratory Domain (`LAB-COLLECT`, `LAB-RESULT`, `OC-08-04`, `OC-08-05`).
- **Pelayanan Farmasi & Penyerahan Obat:** Telaah resep, peracikan obat, dan serah obat dikelola oleh Apotek Domain (`APT-TELAAH`, `APT-DISPENSING`, `APT-SERAH`).
- **Pembentukan Tarif, Rincian Tagihan, dan Kasir:** Penentuan tarif (`TRK-TARIF`), penggabungan rincian biaya (`TRK-BILLING`, `OC-TRK-BILLING`), alokasi pembayaran (`OC-TRK-ALOKASI-PEMBAYARAN`), dan transaksi kasir (`TRK-KASIR`, `OC-TRK-KASIR`) dikelola oleh Tata Rekening Domain.
- **Penyelesaian Administrasi Kepulangan (Reg-Out):** Penutupan finansial dan administrasi kepulangan pasien dikelola oleh **OC-TRK-REG-OUT Reg-Out** (`TRK-BILLING`, `TRK-KASIR`).
- **Master Data Pasien & Resolusi Duplikasi:** Pengelolaan demografi kependudukan master dan merge rekam medis duplikat dikelola oleh Pasien Domain (`PAS-DATSOS`, `PAS-MERGE`, `OC-PAS-DATA-SOSIAL-PASIEN`).
- **Manajemen Berkas & Pengkodean Casemix:** Pengarsipan berkas RM fisik, pengkodean ICD-10/ICD-9-CM, dan klaim e-Klaim dikelola oleh Berkas Rekam Medis Domain (`BRM-*`) dan BPJS Domain (`BPJ-EKLAIM`).

---

## 11. Open Questions & Governance Decisions

Berikut adalah catatan tata kelola dan pertanyaan terbuka untuk peninjauan Product Owner dan Arsitek Sistem:

1. **Ketiadaan Kapabilitas `APT-EXTERNAL` pada Domain Catalog:**
   - *Status Saat Ini:* `domain/DOMAIN-CATALOG.md` hanya mencatat kapabilitas `LAB-EXTERNAL` pada Domain Laboratory. Tidak terdapat kapabilitas ekivalen untuk penjualan langsung pasien luar di Domain Apotek (misal: `APT-EXTERNAL`).
   - *Keputusan yang Dibutuhkan:* Apakah Product Owner menyetujui penambahan kapabilitas `APT-EXTERNAL` pada Domain Apotek, ataukah seluruh registrasi penunjang eksternal langsung (Lab, Apotek, dsb.) secara kanonikal dipusatkan di bawah kapabilitas `ADM-REG` milik Admission Domain?
2. **Spesifikasi Format Penomoran External MR Number:**
   - *Status Saat Ini:* Artefak legacy dan domain Laboratory menetapkan bahwa Nomor RM eksternal harus dapat dibedakan dari Nomor RM reguler dan bersifat *one-time use only*. Namun, aturan konvensi penomoran spesifik (misal: penggunaan prefiks `EXT-` atau rentang angka tertentu) belum dibakukan dalam spesifikasi tingkat sistem.
   - *Keputusan yang Dibutuhkan:* Pembakuan konvensi format identitas External MR oleh Tim Rekam Medis dan Arsitektur.
3. **Kunjungan IGD Singkat Tanpa Admisi:**
   - *Status Saat Ini:* `IGD-VISIT` dapat berjalan mandiri sebelum admisi. Pada kasus langka di mana pasien gawat darurat ditangani secara sangat singkat lalu segera dirujuk keluar atau menolak tindakan sebelum sempat didaftarkan di loket admisi, bagaimana kebijakan penagihan finansialnya? Karena `TRK-BILLING` menghendaki `RegId`, apakah sistem mewajibkan pembuatan *auto-generated emergency RegId* secara sistemik?
