# OUTCOME: Data Sosial Pasien

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap orang yang menerima pelayanan kesehatan di rumah sakit harus terdaftar secara sah dan memiliki identitas master yang tunggal, konsisten, dan terpercaya. Rumah sakit harus mampu mencatat, memvalidasi, memelihara, dan mempersistensi profil **Data Sosial Pasien** sebagai *persisted business fact* yang menjadi fondasi utama seluruh aktivitas klinis, administratif, operasional, dan finansial.

Data Sosial Pasien mencakup identitas kependudukan resmi (NIK/Paspor), data demografi dan sosiologis, alamat tempat tinggal (KTP dan domisili), kontak komunikasi, serta penanggung jawab/keluarga. Data ini dikaitkan secara permanen dengan **Nomor Rekam Medis (No RM)** unik seumur hidup menganut prinsip *Unit Numbering System* ("Satu Pasien, Satu Nomor Rekam Medis").

Tanpa Data Sosial Pasien yang terdefinisi dan terpersistensi secara otoritatif:
- Risiko salah identifikasi pasien (*wrong patient identity*) dapat membahayakan keselamatan pasien (*patient safety*) pada tindakan medis, transfusi, pembedahan, dan pemberian terapi obat.
- Riwayat kesehatan pasien terfragmentasi akibat penciptaan rekam medis ganda (*duplicate medical records*).
- Rumah sakit tidak dapat menagihkan klaim asuransi atau BPJS Kesehatan karena ketidaksesuaian data kependudukan dengan Dukcapil dan BPJS VClaim.
- Rumah sakit tidak dapat memenuhi kepatuhan regulasi rekam medis nasional (Permenkes No. 24 Tahun 2022 tentang Rekam Medis) dan integrasi platform satu data kesehatan nasional (SATUSEHAT Kemenkes).

---

## 2. Outcome Statement

Profil data sosial dan demografi pasien — yang mencakup dokumen kependudukan resmi, identitas personal, data sosiologis, wilayah KTP dan domisili, informasi kontak, penanggung jawab/keluarga, serta status keaktifan — **telah terverifikasi, dicatat, dan terpersistensi secara sah dengan Nomor Rekam Medis unik seumur hidup, siap menjadi fondasi identifikasi pasien yang konsisten dan otoritatif bagi seluruh episode pelayanan klinis, administratif, penagihan, dan pelaporan di rumah sakit.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Pasien** | **Pemilik Utama (*Primary Owner*)**: Mengelola identitas master pasien, penerbitan dan asosiasi Nomor Rekam Medis unik, pemutakhiran data sosial, demografi, wilayah, kontak, data penanggung jawab, serta status keaktifan record pasien melalui kapabilitas `PAS-DATSOS`. |
| **Berkas Rekam Medis** | **Pengelola Operasional Master Patient Index (MPI)**: Menjaga integritas penomoran rekam medis seumur hidup (*Unit Numbering System*), memverifikasi keabsahan data sosial pada berkas rekam medis pasien baru dan lama, serta memastikan kesiapan dokumen rekam medis untuk pelayanan lanjutan. |
| **Admission** | **Inisiator & Konsumen Primer**: Mendaftarkan data sosial pasien baru pada saat kedatangan pertama kali (baik *walk-in* maupun *booking*), memverifikasi identitas pasien lama, serta memperbarui kontak atau alamat domisili saat registrasi kunjungan (`ADM-REG`). |
| **Organisasi** | **Penyedia Referensi Baku**: Menyediakan standarisasi master data wilayah administrasi pemerintahan (Provinsi, Kabupaten/Kota, Kecamatan, Kelurahan/Desa, Kode Pos) dan master data sosiologis (Agama, Pekerjaan, Pendidikan, Status Kawin, Suku). |
| **BPJS** | **Verifikator Eksternal Kepesertaan**: Memvalidasi kesesuaian Nomor Induk Kependudukan (NIK) dan Nomor Kartu Peserta dengan basis data nasional BPJS Kesehatan melalui kapabilitas `BPJ-VCLAIM`. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `PAS-MERGE` Merge Duplicated Pasien | Pasien | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-BOOKING` Booking | Admission | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Master data pasien telah dibentuk dan tersimpan dalam basis data sistem rumah sakit sebagai representasi definitif dari satu orang individu nyata.
- Pasien memiliki satu Nomor Rekam Medis (Nomor Medrec / No RM) yang unik, tidak berulang, dan berlaku permanen seumur hidup (*Unit Numbering System*).
- Identitas kependudukan resmi pasien (Nomor Induk Kependudukan / NIK 16 digit bagi WNI, atau Paspor/KITAS bagi WNA) telah dicatat dan terhubung dengan profil pasien.
- Profil demografi kependudukan dasar pasien (Nama lengkap, nama panggilan, tempat lahir, tanggal lahir, jenis kelamin, golongan darah, dan nama ibu kandung) telah tercatat dan tervalidasi.
- Data sosiologis pasien (Agama, status perkawinan, tingkat pendidikan terakhir, pekerjaan, dan suku/etnis) telah terdokumentasi sesuai standar kodifikasi rumah sakit.
- Alamat tempat tinggal pasien terdokumentasi secara terstruktur dengan pemisahan yang jelas antara **Alamat Sesuai KTP** dan **Alamat Domisili Terkini**, mencakup hierarki administrasi wilayah lengkap (Jalan, RT, RW, Kelurahan/Desa, Kecamatan, Kabupaten/Kota, Provinsi, dan Kode Pos).
- Saluran komunikasi pasien (nomor ponsel/WhatsApp, nomor telepon rumah, dan alamat email) telah tercatat.
- Data kontak darurat dan penanggung jawab/keluarga pasien (nama, relasi hubungan, nomor telepon, alamat) telah tercatat untuk keperluan persetujuan tindakan medis dan penanganan kegawatdaruratan.
- Pasien memiliki status keaktifan master data (**Aktif** atau **Non-Aktif**) yang dapat dipelihara tanpa menghapus riwayat fisik (*soft state*).
- Setiap tindakan pembuatan data baru maupun pemutakhiran elemen data sosial terekam dalam jejak audit (*audit trail / change log*) yang memuat tanggal, waktu, petugas, jenis perubahan, nilai lama, dan nilai baru.

### 5.2 Required Recorded Information

**Identitas Pokok Pasien & Rekam Medis:**
- Nomor Rekam Medis (No RM / Nomor Medrec) yang unik.
- ID Pasien unik internal sistem (*Pasien ID*).
- Tanggal dan waktu pembuatan nomor rekam medis pertama kali.
- Nama lengkap pasien (sesuai dokumen kependudukan resmi, tanpa singkatan yang meragukan).
- Nama panggilan / alias (*Nick Name*).
- Tempat lahir.
- Tanggal lahir (format baku: YYYY-MM-DD).
- Umur pasien (terhitung otomatis dalam satuan tahun, bulan, hari).
- Jenis kelamin (Laki-laki / Perempuan).
- Nama gadis ibu kandung (*Mother's Maiden Name*) — data kunci verifikasi MPI.
- Golongan darah dan Rhesus (A / B / AB / O; Positif / Negatif / Belum Diketahui).
- Status keaktifan pasien (Aktif / Non-Aktif).

**Dokumen Identitas Kependudukan Resmi:**
- Jenis dokumen identitas (KTP-el, Kartu Identitas Anak / KIA, Paspor, KITAS/KITAP, Identitas Sementara).
- Nomor identitas (NIK 16 digit bagi WNI, Nomor Paspor bagi WNA).
- Nomor Kartu Keluarga (KK 16 digit).
- Status kewarganegaraan (WNI / WNA) dan nama negara asal bagi WNA.

**Data Sosiologis & Demografi:**
- Agama (Islam, Kristen Protestan, Katolik, Hindu, Buddha, Khonghucu, Aliran Kepercayaan, Lainnya).
- Status perkawinan (Belum Kawin, Kawin, Cerai Hidup, Cerai Mati).
- Tingkat pendidikan terakhir (Tidak/Belum Sekolah, SD, SMP, SMA/SMK, Diploma, Sarjana, Pascasarjana).
- Pekerjaan (PNS, TNI/Polri, BUMN, Karyawan Swasta, Wiraswasta, Petani/Nelayan, Pelajar/Mahasiswa, Ibu Rumah Tangga, Tidak Bekerja, Lainnya).
- Suku / Etnis.
- Bahasa komunikasi utama / bahasa daerah yang dikuasai.

**Alamat & Hierarki Wilayah Administratif:**
- **Alamat KTP (Sesuai Identitas Resmi):**
  - Alamat jalan, nomor rumah, gedung/blok.
  - Rukun Tetangga (RT) dan Rukun Warga (RW).
  - Kelurahan / Desa (ID & Nama).
  - Kecamatan (ID & Nama).
  - Kabupaten / Kota (ID & Nama).
  - Provinsi (ID & Nama).
  - Kode Pos.
- **Alamat Domisili (Tempat Tinggal Saat Ini, jika berbeda):**
  - Alamat jalan dan detail tempat tinggal.
  - Rukun Tetangga (RT) dan Rukun Warga (RW).
  - Kelurahan / Desa (ID & Nama).
  - Kecamatan (ID & Nama).
  - Kabupaten / Kota (ID & Nama).
  - Provinsi (ID & Nama).
  - Kode Pos.
  - Keterangan domisili.

**Kontak Komunikasi Pasien:**
- Nomor telepon seluler / handphone utama (WhatsApp aktif).
- Nomor telepon rumah / telepon alternatif.
- Alamat surat elektronik (email).

**Data Keluarga / Penanggung Jawab / Kontak Darurat:**
- Nama lengkap penanggung jawab / keluarga terdekat.
- Hubungan / relasi keluarga dengan pasien (Suami, Istri, Ayah, Ibu, Anak, Saudara Kandung, Wali, Kerabat).
- Nomor identitas penanggung jawab (NIK / KTP).
- Nomor kontak telepon / HP penanggung jawab.
- Pekerjaan penanggung jawab.
- Alamat penanggung jawab (jalan, kota, kode pos).

**Metadata & Jejak Audit (Audit Trail):**
- Tanggal dan waktu pencatatan pertama kali.
- ID dan nama petugas pembuat (*Created By*).
- Tanggal dan waktu pemutakhiran terakhir (*Last Modified Date*).
- ID dan nama petugas pemutakhiran terakhir (*Modified By*).
- Riwayat perubahan (*Change Log*): Timestamp, aktivitas, User ID, nama field/properti yang diubah, nilai lama (*old value*), dan nilai baru (*new value*).

### 5.3 Required Business Conditions

- Satu orang individu fisik di dunia nyata hanya boleh direpresentasikan oleh satu Nomor Rekam Medis yang aktif (*Unit Numbering System*).
- Pemeriksaan riwayat pencarian mendalam (*Deep Search*) wajib dilakukan sebelum registrasi pasien baru disetujui, menggunakan kriteria NIK, nama lengkap, tanggal lahir, nama ibu kandung, atau nomor telepon untuk mencegah terbentuknya rekam medis ganda.
- Elemen data minimum wajib (*mandatory core attributes*) untuk pembentukan pasien baru meliputi: Nama Lengkap, Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung, dan minimal satu alamat atau nomor kontak yang dapat dihubungi.
- Pasien gawat darurat yang tidak sadar atau tidak memiliki identitas saat tiba di IGD (*Mr./Ms. X*) dapat didaftarkan dengan nomor rekam medis darurat dan identitas sementara, dengan kewajiban melakukan pemutakhiran (*patch*) data sosial lengkap segera setelah identitas asli terkonfirmasi.
- Nomor Rekam Medis yang telah diterbitkan bersifat permanen dan tidak dapat dialihkan atau digunakan ulang untuk individu lain, meskipun pasien yang bersangkutan telah meninggal dunia atau dinonaktifkan.
- Pemutakhiran profil data sosial dapat dilakukan secara parsial (*granular patch*) melalui fungsi:
  - *Patch KTP/Identitas Resmi*: Pembaruan NIK, nama resmi, tempat/tanggal lahir, alamat KTP, RT/RW, dan kelurahan KTP.
  - *Patch Demografi & Sosiologis*: Pembaruan status perkawinan, agama, suku, pendidikan, pekerjaan, alamat domisili, dan data keluarga/penanggung jawab.
  - *Patch Kontak*: Penambahan atau pembaruan nomor telepon, handphone, dan email.
  - *Toggle Status Keaktifan*: Penonaktifan (*deactivate*) atau pengaktifan kembali (*reactivate*) status pasien.
- Penonaktifan pasien tidak menghapus data rekam medis secara fisik (*no physical hard delete*) guna menjaga integritas medikolegal dan keterhubungan riwayat medis masa lalu.
- Apabila terjadi kasus duplikasi data rekam medis yang terlanjur terbentuk, penyelesaian tidak boleh dilakukan dengan menghapus salah satu record, melainkan harus diproses melalui kapabilitas `PAS-MERGE` (Merge Duplicated Pasien).

### 5.4 Completion Proof

- Record Data Sosial Pasien tersimpan dalam basis data sistem rumah sakit dengan Nomor Rekam Medis (No RM) dan Pasien ID yang valid dan unik.
- Profil data sosial pasien dapat ditemukan kembali melalui pencarian cepat maupun pencarian mendalam (*search by No RM, NIK, nama, tanggal lahir, nama ibu kandung, atau nomor handphone*).
- Status master data pasien adalah **Aktif** dan data sosialnya siap dijadikan subjek untuk proses bisnis pelayanan rumah sakit (Booking, Registrasi Rawat Jalan/Inap/IGD, Pengkajian Medis, Order Laboratorium/Radiologi, Pelayanan Resep Farmasi, dan Billing Kasir).
- Jejak audit (*audit trail*) terbentuk secara otomatis mencatat rincian transaksi pembentukan data baru atau perubahan atribut data sosial.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas (Perekam Medis atau Petugas Loket Admisi Pendaftaran) menerima permohonan pendaftaran pasien baru atau permohonan pemutakhiran data sosial pasien yang sudah ada, ditandai dengan penyerahan dokumen identitas kependudukan resmi (KTP-el/KK/KIA/Paspor) atau informasi identitas diri dari pasien/keluarga.

### End

Berakhir ketika data sosial pasien telah divalidasi, disimpan, dan dipersistensi dalam sistem dengan Nomor Rekam Medis yang terasosiasi secara unik dan berstatus **Aktif**, sehingga identitas pasien tersebut secara resmi siap digunakan oleh seluruh unit pelayanan rumah sakit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Prinsip Keunikan Nomor Rekam Medis**: Setiap Nomor Rekam Medis hanya boleh diasosiasikan dengan tepat satu orang pasien, dan satu pasien tidak boleh memiliki lebih dari satu Nomor Rekam Medis aktif di rumah sakit.
- **Prinsip Keunikan Dokumen Kependudukan (NIK)**: Satu Nomor Induk Kependudukan (NIK 16 digit) yang valid hanya boleh terdaftar pada satu profil pasien aktif dalam sistem.
- **Prinsip Kekekalan Nomor Rekam Medis (*Immutability of Medical Record Number*)**: Nomor Rekam Medis yang telah diterbitkan tidak boleh diubah nomornya dan tidak boleh dihapus atau dipindahtangankan kepada orang lain.
- **Larangan Penghapusan Fisik (*Zero Hard Delete*)**: Data master pasien yang sudah memiliki riwayat kunjungan, rekam medis klinis, atau transaksi billing dilarang keras dihapus dari basis data; pemeliharaan status hanya diizinkan melalui perubahan status keaktifan (*soft-state*).
- **Pembatasan Transaksi Pasien Non-Aktif**: Pasien yang berstatus **Non-Aktif** tidak dapat digunakan untuk membuat booking baru atau registrasi kunjungan baru sebelum diaktifkan kembali (*Reactivate*) oleh petugas yang berwenang.
- **Integritas Jejak Audit (*Immutable Audit Log*)**: Setiap riwayat perubahan pada elemen data sosial pasien (nama, tanggal lahir, NIK, alamat, status) harus tercatat permanen dalam tabel log dan tidak dapat dimanipulasi atau dihapus.
- **Kepatuhan Format NIK**: NIK yang direkam harus berupa 16 digit numerik sesuai standar Direktorat Jenderal Kependudukan dan Pencatatan Sipil (Dukcapil) Republik Indonesia.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Pasien sudah terdaftar dalam sistem (Duplikasi NIK atau kesamaan identitas terdeteksi)** | Sistem menolak pembuatan data pasien baru. Sistem menampilkan data profil pasien yang sudah ada untuk diverifikasi oleh petugas, dan mengarahkan petugas untuk menggunakan No RM yang telah ada atau melakukan pemutakhiran data jika terdapat perubahan alamat/kontak. |
| **Nomor Induk Kependudukan (NIK) tidak valid** | Sistem menolak penyimpanan data jika format NIK bukan 16 digit numerik. Petugas diminta memverifikasi kembali fisik KTP-el pasien atau menggunakan kartu identitas resmi lainnya. |
| **Elemen data wajib (*mandatory fields*) tidak lengkap** | Sistem menolak penyimpanan jika Nama Lengkap, Tanggal Lahir, Jenis Kelamin, atau Nama Ibu Kandung tidak diisi, kecuali pada alur darurat (*Emergency Unidentified Patient*). |
| **Pasien darurat tanpa identitas (*Mr./Ms. X*) tiba di IGD** | Sistem menerbitkan Nomor Rekam Medis sementara dengan penandaan darurat (*flag emergency unidentified*). Sistem mewajibkan petugas rekam medis untuk memperbarui (*patch*) data sosial lengkap segera setelah identitas pasien terungkap. |
| **Pasien berstatus Non-Aktif mencoba didaftarkan kunjungan** | Registrasi kunjungan diblokir oleh sistem. Petugas diarahkan untuk melakukan proses verifikasi dan aktivasi kembali status pasien (*Reactivate*) dengan mencantumkan alasan reaktivasi sebelum registrasi kunjungan dapat dilanjutkan. |
| **Ditemukan dua Nomor Rekam Medis berbeda untuk pasien yang sama di kemudian hari** | Sistem melarang pembuatan nomor ketiga. Kasus dieskalasi ke Perekam Medis untuk dilakukan penggabungan rekam medis melalui kapabilitas `PAS-MERGE` (Merge Duplicated Pasien). |
| **Koneksi jaringan validasi eksternal (Dukcapil / BPJS VClaim) terputus** | Sistem mengizinkan penyimpanan data sosial secara lokal berdasarkan dokumen fisik pasien demi kelancaran pelayanan kesehatan, dengan memberikan tanda status *Unverified Online* untuk disinkronkan kembali saat koneksi pulih. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Data sosial pasien baru yang berhasil disimpan memiliki Pasien ID unik dan Nomor Rekam Medis (No RM) yang diterbitkan secara otomatis dan tidak berulang. | Completeness |
| **AC-02** | Seluruh atribut demografi pokok (Nama Lengkap, Tempat & Tanggal Lahir, Umur terhitung, Jenis Kelamin, Golongan Darah, Nama Ibu Kandung) tersimpan secara akurat dan lengkap. | Completeness |
| **AC-03** | Data alamat tersimpan secara terstruktur dan terpisah antara Alamat KTP dan Alamat Domisili, lengkap dengan hierarki wilayah (RT, RW, Kelurahan, Kecamatan, Kota/Kabupaten, Provinsi, Kode Pos). | Completeness |
| **AC-04** | Data kontak pasien (No HP/WhatsApp, telepon, email) dan data penanggung jawab (nama, relasi, no kontak, alamat) tersimpan dan terhubung ke profil pasien. | Completeness |
| **AC-05** | Profil data sosial pasien dapat dicari dan ditemukan kembali secara tepat melalui pencarian No RM, NIK, Nama Lengkap, Tanggal Lahir, atau No HP. | Correctness |
| **AC-06** | Status data sosial pasien yang baru dibuat adalah **Aktif** dan langsung dapat dipilih dalam transaksi Booking (`ADM-BOOKING`) serta Registrasi Rawat Jalan, Rawat Inap, dan IGD (`ADM-REG`). | Correctness |
| **AC-07** | Sistem menolak pendaftaran pasien baru jika NIK yang diinput sudah terdaftar pada pasien aktif lain dalam sistem. | Constraint |
| **AC-08** | Sistem menolak pendaftaran pasien baru jika format NIK bukan 16 digit numerik. | Constraint |
| **AC-09** | Sistem menolak pendaftaran pasien baru jika salah satu atribut wajib (Nama Lengkap, Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung) kosong pada registrasi reguler. | Constraint |
| **AC-10** | Pemutakhiran parsial (*Patch KTP*, *Patch Demografi*, *Patch Kontak*) berhasil memperbarui data terkait dan mencatat rincian perubahannya pada tabel jejak audit (*change log*). | Correctness |
| **AC-11** | Pasien yang dinonaktifkan (*Deactivated*) berstatus **Non-Aktif**, tidak dapat digunakan dalam pendaftaran kunjungan baru, dan datanya tidak hilang dari basis data. | Constraint |
| **AC-12** | Pasien yang dinonaktifkan dapat diaktifkan kembali (*Reactivated*) dan dapat langsung digunakan kembali dalam proses pelayanan rumah sakit. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Registrasi Kunjungan Pasien ke Unit Pelayanan**: Pencatatan kunjungan resmi pasien ke poliklinik atau IGD dikelola oleh **OC-01-02 Registrasi Rawat Jalan dan IGD**, sedangkan pendaftaran masuk rawat inap dikelola oleh **OC-01-03 Registrasi Rawat Inap**.
- **Booking & Penjadwalan Janji Temu Pasien**: Pengelolaan reservasi dan jadwal kunjungan pasien sebelum hari H dikelola oleh **OC-01-01 Booking**.
- **Penggabungan Rekam Medis Duplikat (*Merge Pasien*)**: Rekonsiliasi struktural dua atau lebih nomor rekam medis yang mewakili orang yang sama dikelola oleh kapabilitas **`PAS-MERGE` (Merge Duplicated Pasien)**.
- **Manajemen Fisik Berkas Rekam Medis**: Pengelolaan map rekam medis manual, pengarsipan (*filing*), penomoran rak, dan pelacakan keluar-masuk berkas (*tracer/ekspedisi*) dikelola oleh **OC-04-02 Manajemen Berkas**.
- **Kodifikasi Penyakit dan Prosedur Medis**: Pengkodean diagnosis (ICD-10) dan tindakan (ICD-9-CM) untuk keperluan klaim dan casemix dikelola oleh **OC-04-03 Casemix dan Coding**.
- **Pelaporan Statistik Rumah Sakit**: Penyusunan laporan Rekapitulasi Laporan Rumah Sakit (RL 1 s/d RL 5) dikelola oleh **OC-04-04 Pelaporan RL**, serta sensus harian dikelola oleh **OC-04-05 Pelaporan Index dan Sensus**.
- **Master Data Wilayah & Referensi**: Pengelolaan tabel master nama provinsi, kabupaten/kota, kecamatan, kelurahan, dan jenis-jenis pekerjaan/pendidikan dikelola oleh **Organisasi Domain** (`ORG-LAYANAN` / Master Wilayah).
- **Penerbitan Surat Eligibilitas Peserta (SEP)**: Pembuatan SEP dan administrasi klaim BPJS dikelola oleh **OC-01-04 VCLAIM BPJS**.
- **Transaksi Finansial & Tagihan Pasien**: Penagihan biaya layanan, pengelolaan deposit, dan pembayaran kasir dikelola oleh **Tata Rekening Domain** (`TRK-BILLING`, `TRK-DEPOSIT`, `TRK-PAYMENT`).
