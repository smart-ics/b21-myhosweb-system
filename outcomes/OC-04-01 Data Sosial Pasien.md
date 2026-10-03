# OUTCOME: Data Sosial Pasien

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-04-01          |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-03        |

---

## 1. Business Purpose

Setiap individu yang menerima pelayanan kesehatan di rumah sakit harus terdaftar secara sah dan memiliki identitas master yang tunggal, terpercaya, dan konsisten. Rumah sakit wajib membentuk, memvalidasi, memelihara, dan mempersistensi profil **Data Sosial Pasien** sebagai *persisted business fact* yang menjadi fondasi identitas bagi seluruh aktivitas pelayanan klinis, penunjang medis, administrasi, operasional, dan finansial di rumah sakit.

Dalam arsitektur informasi rumah sakit:
- **Master Data Pasien** merupakan istilah payung yang mencakup kumpulan data master mengenai pasien.
- **OC-04-01 Data Sosial Pasien** secara khusus mendefinisikan konten identitas dasar, data sosial-demografi, alamat dan komunikasi, serta hubungan sosial pasien yang menjadi bagian inti dari Master Data Pasien. OC-04-01 tidak mendefinisikan seluruh lifecycle pasien atau seluruh pengelolaan pelayanan pasien, melainkan berfokus pada lifecycle pembentukan dan pemeliharaan data sosial pasien.

Sistem rumah sakit menggunakan **Nomor Rekam Medis (No. RM)** sebagai **business identifier (business key)** pasien yang bersifat unik, permanen, dan berlaku seumur hidup menganut prinsip *Unit Numbering System* ("Satu Pasien, Satu Nomor Rekam Medis"). No. RM adalah satu-satunya jangkar identitas bisnis pasien yang menjadi referensi lintas domain. Nomor Induk Kependudukan (NIK) dan dokumen kependudukan resmi lainnya berfungsi sebagai atribut verifikasi identitas yang vital, namun tidak menggantikan No. RM sebagai business key.

Data Sosial Pasien dibentuk ketika pasien pertama kali didaftarkan ke rumah sakit, kemudian dipelihara secara berkelanjutan sepanjang siklus hidup master pasien (*master patient lifecycle*). Setiap pembaruan data tetap melekat pada pasien yang sama dan No. RM yang sama, serta menjadi sumber data master dan referensi otoritatif bagi domain lain.

### Pertimbangan Regulasi dan Batasan Lingkup Bisnis

Kepatuhan terhadap **Permenkes Nomor 24 Tahun 2022 tentang Rekam Medis** menjadi dasar regulasi penyelenggaraan rekam medis. Terdapat pemisahan yang jelas antara mandat regulasi dan keputusan cakupan bisnis sistem:
1. **Mandat Eksplisit Regulasi (Permenkes No. 24/2022)**: Menetapkan bahwa rekam medis wajib memuat data identitas pasien yang paling sedikit mencakup: nomor rekam medis, nama pasien, nomor induk kependudukan (NIK) atau identitas resmi lainnya, tempat dan tanggal lahir, jenis kelamin, alamat tempat tinggal, nomor kontak yang dapat dihubungi, serta persetujuan/penanggung jawab.
2. **Keputusan Cakupan Bisnis MYHOSWEB**: Merupakan pengayaan informasi yang ditetapkan untuk operasional dan sosiologis rumah sakit, meliputi data agama, status perkawinan, tingkat pendidikan, pekerjaan, suku/etnis, bahasa komunikasi utama, pemisahan terstruktur alamat KTP dan domisili, serta saluran komunikasi digital (WhatsApp dan email).

Tanpa Data Sosial Pasien yang terdefinisi dan terpersistensi secara otoritatif:
- Risiko salah identifikasi pasien (*wrong patient identity*) dapat membahayakan keselamatan pasien (*patient safety*) pada tindakan bedah, transfusi, pemberian obat, dan prosedur invasif.
- Terjadi fragmentasi data riwayat kesehatan akibat penciptaan rekam medis ganda (*duplicate patient records*).
- Setiap unit kerja dan domain operasional cenderung membuat salinan identitas pasien yang berdiri sendiri (*siloed patient copies*), merusak konsistensi data rumah sakit.
- Kegagalan verifikasi data kependudukan menghambat penerbitan jaminan BPJS Kesehatan (VClaim) maupun asuransi lain, serta menghalangi pemenuhan kepatuhan pelaporan nasional (SATUSEHAT Kemenkes).

---

## 2. Outcome Statement

Informasi identitas dan sosial pasien sebagai bagian dari Master Data Pasien **telah terbentuk pada pendaftaran pertama atau telah diperbarui sepanjang siklus hidup master pasien, terasosiasi secara unik dan permanen dengan Nomor Rekam Medis (No. RM) sebagai business key, serta siap menjadi sumber data master dan referensi otoritatif bagi seluruh domain pelayanan klinis, penunjang, administratif, penagihan, dan pelaporan di rumah sakit.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Pasien** | **Pemilik Utama (*Primary Owner*)**: Bertanggung jawab penuh atas pendefinisian profil Data Sosial Pasien, penerbitan dan asosiasi No. Rekam Medis unik seumur hidup, pemutakhiran atribut identitas dan sosial, serta pemeliharaan status keaktifan master data pasien melalui kapabilitas `PAS-DATSOS`. |
| **Admission** | **Inisiator & Pemutakhiran Operasional**: Memfasilitasi pembentukan data sosial pasien baru pada saat pendaftaran pertama kali (baik *walk-in* maupun *booking*), memverifikasi identitas pasien terdaftar pada kunjungan ulang, serta memfasilitasi pemutakhiran data kontak atau alamat saat registrasi pelayanan melalui kapabilitas `ADM-REG`. |
| **Organisasi** | **Penyedia Standar Referensi**: Menyediakan data master referensi baku wilayah administratif pemerintahan (Provinsi, Kabupaten/Kota, Kecamatan, Kelurahan/Desa, Kode Pos) dan referensi sosiologis (Agama, Pekerjaan, Pendidikan, Status Kawin, Suku) melalui kapabilitas `ORG-LAYANAN`. |
| **BPJS** | **Verifikator Eksternal Kepesertaan (Kondisional)**: Memvalidasi kesesuaian Nomor Induk Kependudukan (NIK) dan data demografi pasien dengan basis data nasional BPJS Kesehatan melalui kapabilitas `BPJ-VCLAIM` pada saat pendaftaran atau verifikasi penjamin. |

> **Catatan Konsumen Domain**: Domain lain seperti **Rawat Jalan**, **Rawat Inap**, **Gawat Darurat**, **Laboratorium**, **Radiologi**, **Apotek**, **Berkas Rekam Medis**, **Tata Rekening**, dan **Pelaporan** berperan sebagai **konsumen referensi** dari Data Sosial Pasien. Domain-domain tersebut mereferensikan No. RM dan data sosial pasien yang dipelihara oleh OC-04-01, namun tidak memiliki kepemilikan (*ownership*) atas master data identitas dan sosial tersebut.

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ADM-REG` Registration | Admission | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Master Data Pasien (khususnya komponen Data Sosial Pasien) terbentuk dan terpersistensi dalam sistem sebagai representasi definitif dan tunggal dari satu individu fisik nyata.
- Pasien diidentifikasi secara tunggal oleh Nomor Rekam Medis (No. RM) yang unik, permanen, tidak berulang, dan berlaku seumur hidup (*Unit Numbering System*). No. RM berfungsi sebagai business key pasien.
- Identitas kependudukan resmi pasien (Nomor Induk Kependudukan / NIK 16 digit bagi WNI, atau Paspor/KITAS bagi WNA) telah dicatat dan terhubung secara permanen dengan profil pasien.
- Profil demografi kependudukan dasar pasien (Nama lengkap, nama panggilan/alias, tempat lahir, tanggal lahir, jenis kelamin, golongan darah/rhesus, dan nama ibu kandung) tercatat dan terhubung dengan No. RM.
- Data sosial-demografi pasien (Agama, status perkawinan, tingkat pendidikan terakhir, pekerjaan, suku/etnis, dan bahasa komunikasi) terdokumentasi sesuai standar referensi rumah sakit.
- Alamat tempat tinggal pasien terdokumentasi secara terstruktur dengan pemisahan yang jelas antara **Alamat Sesuai KTP** dan **Alamat Domisili Terkini**, mencakup hierarki wilayah administratif yang lengkap.
- Saluran komunikasi pasien (nomor telepon/HP, WhatsApp bila ada, dan email bila ada) tercatat dan dapat dihubungi.
- Data hubungan sosial pasien (keluarga, penanggung jawab, kontak darurat beserta relasi hubungan dan nomor kontak pihak terkait) tercatat untuk kebutuhan persetujuan tindakan medis dan penanganan darurat.
- Pasien memiliki status keaktifan master data (**Aktif** atau **Non-Aktif**) yang dipelihara secara *soft-state* tanpa penghapusan rekaman data fisik (*no hard delete*).
- Setiap tindakan pembentukan awal maupun pemutakhiran atribut data sosial terekam dalam jejak audit bisnis (*audit trail / change log*) yang memuat waktu perubahan, identitas petugas penanggung jawab, jenis atribut yang diubah, nilai lama, dan nilai baru.
- Data Sosial Pasien tersedia sebagai sumber data master dan referensi otoritatif tunggal bagi domain lain, mencegah setiap domain membuat salinan master identitas pasien yang berdiri sendiri.

### 5.2 Required Recorded Information

Profil Data Sosial Pasien memuat kelompok informasi sebagai berikut:

**A. Identitas Dasar Pasien & Kependudukan Resmi:**
- Nomor Rekam Medis (No. RM) — *Business key pasien, unik dan permanen*.
- Dokumen Identitas Resmi:
  - Jenis dokumen identitas (KTP-el, Kartu Identitas Anak / KIA, Paspor, KITAS/KITAP, Identitas Sementara).
  - Nomor identitas resmi (NIK 16 digit bagi WNI, Nomor Paspor bagi WNA).
  - Nomor Kartu Keluarga (KK 16 digit, bila tersedia).
  - Status kewarganegaraan (WNI / WNA) dan nama negara asal bagi WNA.
- Nama lengkap pasien (sesuai dokumen kependudukan resmi, tanpa singkatan yang membingungkan).
- Nama panggilan / alias (*Nick Name*), jika ada.
- Tempat lahir.
- Tanggal lahir (format baku: YYYY-MM-DD).
- Umur pasien (terhitung otomatis berdasarkan tanggal lahir dalam tahun, bulan, dan hari).
- Jenis kelamin (Laki-laki / Perempuan).
- Golongan darah dan rhesus (A / B / AB / O; Positif / Negatif / Belum Diketahui).
- Nama gadis ibu kandung (*Mother's Maiden Name*) — atribut kunci untuk verifikasi identitas dan pencegahan duplikasi.
- Status keaktifan master pasien (Aktif / Non-Aktif).

**B. Data Sosial-Demografi Pasien:**
- Agama (Islam, Kristen Protestan, Katolik, Hindu, Buddha, Khonghucu, Aliran Kepercayaan, Lainnya).
- Status perkawinan (Belum Kawin, Kawin, Cerai Hidup, Cerai Mati).
- Tingkat pendidikan terakhir (Tidak/Belum Sekolah, SD, SMP, SMA/SMK, Diploma, Sarjana, Pascasarjana).
- Pekerjaan (PNS, TNI/Polri, BUMN, Karyawan Swasta, Wiraswasta, Petani/Nelayan, Pelajar/Mahasiswa, Ibu Rumah Tangga, Tidak Bekerja, Lainnya).
- Suku / Etnis.
- Bahasa komunikasi utama / bahasa daerah yang dikuasai.

**C. Alamat dan Saluran Komunikasi:**
- **Alamat KTP (Sesuai Dokumen Kependudukan Resmi):**
  - Alamat jalan, nomor rumah, blok/gedung.
  - Rukun Tetangga (RT) dan Rukun Warga (RW).
  - Kelurahan / Desa.
  - Kecamatan.
  - Kabupaten / Kota.
  - Provinsi.
  - Kode Pos.
- **Alamat Domisili (Tempat Tinggal Saat Ini, jika berbeda dari KTP):**
  - Alamat jalan dan detail tempat tinggal.
  - RT dan RW.
  - Kelurahan / Desa, Kecamatan, Kabupaten/Kota, Provinsi, Kode Pos.
  - Keterangan domisili.
- **Saluran Komunikasi Pasien:**
  - Nomor telepon seluler / handphone utama (dan indikasi ketersediaan WhatsApp).
  - Nomor telepon rumah / telepon alternatif.
  - Alamat surat elektronik (email, bila tersedia).

**D. Hubungan Sosial Pasien (Keluarga, Penanggung Jawab, Kontak Darurat):**
- Nama lengkap pihak terkait (keluarga, penanggung jawab, atau kontak darurat).
- Status hubungan / relasi keluarga dengan pasien (Suami, Istri, Ayah, Ibu, Anak, Saudara Kandung, Wali, Kerabat).
- Nomor kontak telepon / HP pihak terkait.
- Alamat tempat tinggal pihak terkait.
- Nomor identitas resmi pihak terkait (NIK/KTP), bila dipersyaratkan.

**E. Metadata dan Jejak Audit Bisnis (Audit Trail):**
- Waktu pencatatan pertama kali (*Creation Timestamp*).
- Petugas pembuat rekaman awal (*Created By*).
- Waktu pemutakhiran terakhir (*Last Modified Timestamp*).
- Petugas pemutakhiran terakhir (*Modified By*).
- Riwayat perubahan data (*Change Log*): Timestamp, identitas petugas, elemen/atribut data yang diubah, nilai lama (*old value*), dan nilai baru (*new value*).

### 5.3 Required Business Conditions

- Satu orang individu fisik di dunia nyata hanya boleh direpresentasikan oleh satu profil Master Data Pasien dengan Nomor Rekam Medis aktif (*Unit Numbering System*).
- Nomor Rekam Medis (No. RM) adalah business key pasien yang bersifat permanen, tidak dapat diubah, tidak dapat diganti dengan identifier baru, dan tidak dapat dialihkan atau digunakan ulang untuk individu lain seumur hidup.
- Pemeriksaan pencegahan duplikasi (*deduplication check*) wajib dilakukan sebelum nomor rekam medis baru diterbitkan, dengan memeriksa kombinasi No. RM, NIK, nama lengkap, tanggal lahir, dan nama ibu kandung.
- Elemen data minimum wajib (*mandatory core attributes*) untuk pembentukan pasien baru reguler meliputi: No. RM, Nama Lengkap, Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung, dan minimal satu alamat atau nomor kontak yang dapat dihubungi.
- Pasien gawat darurat yang tidak sadar atau tidak memiliki identitas saat tiba di IGD (*Emergency Unidentified Patient / Mr./Ms. X*) dapat didaftarkan dengan No. RM darurat dan identitas sementara, dengan kewajiban bagi rumah sakit untuk melakukan pemutakhiran data sosial lengkap segera setelah identitas asli terkonfirmasi.
- Pemutakhiran profil Data Sosial Pasien dapat dilakukan kapan saja sepanjang lifecycle master pasien (misal saat registrasi kunjungan baru atau saat pasien melaporkan pembaruan data) tanpa mengubah No. RM yang bersangkutan.
- Penonaktifan pasien dilakukan secara *soft-state* (mengubah status menjadi Non-Aktif); dilarang keras melakukan penghapusan fisik (*hard delete*) pada data master pasien demi menjamin integritas medikolegal dan historis asuhan klinis masa lalu.
- Pasien berstatus Non-Aktif tidak dapat digunakan untuk membuat booking baru atau registrasi kunjungan baru sebelum diaktifkan kembali (*Reactivate*) secara resmi oleh petugas yang berwenang.
- Apabila di kemudian hari terdeteksi adanya dua No. RM berbeda untuk individu yang sama, penyelesaian tidak boleh dilakukan dengan menghapus salah satu record, melainkan harus diproses melalui kapabilitas `PAS-MERGE` (Merge Duplicated Pasien).

### 5.4 Completion Proof

- Rekaman Data Sosial Pasien tersimpan dalam Master Data Pasien dengan Nomor Rekam Medis (No. RM) yang valid, unik, dan berstatus **Aktif**.
- Profil Data Sosial Pasien dapat ditemukan kembali melalui pencarian bisnis berdasarkan No. RM, NIK, nama lengkap, tanggal lahir, nama ibu kandung, atau nomor kontak.
- Data Sosial Pasien siap dan tersedia secara otoritatif untuk direferensikan oleh modul pelayanan dan transaksi hilir (Booking, Registrasi Rawat Jalan, Registrasi Rawat Inap, Registrasi IGD, Pelayanan Klinis, Farmasi, Laboratorium, Radiologi, Berkas Rekam Medis, Tata Rekening, dan Pelaporan).
- Jejak audit bisnis (*audit trail*) terbentuk secara otomatis mencatat rincian transaksi pembentukan awal atau pemutakhiran atribut data sosial pasien.

---

## 6. Outcome Boundary

### Start

Dimulai ketika:
1. Pendaftaran pasien baru diinisiasi pada saat kedatangan pertama kali ke rumah sakit (baik melalui loket pendaftaran rawat jalan/rawat inap, kedatangan darurat di IGD, maupun booking pra-registrasi) dengan penyerahan dokumen identitas kependudukan resmi atau informasi identitas diri dari pasien/keluarga; ATAU
2. Permohonan/kebutuhan pemutakhiran data sosial pasien terdaftar diterima oleh petugas rumah sakit.

### End

Berakhir ketika data sosial pasien telah divalidasi, disimpan, dan terpersistensi dalam Master Data Pasien dengan No. RM unik dan status **Aktif** (atau status pemutakhiran terkonfirmasi), sehingga identitas pasien tersebut secara resmi siap dijadikan referensi otoritatif lintas domain. Pemeliharaan data sosial pasien berlangsung secara berkelanjutan sepanjang lifecycle master pasien.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Prinsip Keunikan dan Permanensi No. RM sebagai Business Key**: Setiap Nomor Rekam Medis hanya boleh diasosiasikan dengan tepat satu orang pasien, tidak boleh diubah nomornya, dan tidak boleh dipindahtangankan kepada individu lain seumur hidup pasien.
- **Prinsip Keunikan Dokumen Kependudukan (NIK)**: Satu Nomor Induk Kependudukan (NIK 16 digit) yang valid hanya boleh terdaftar pada satu profil pasien aktif dalam sistem.
- **Larangan Penghapusan Fisik (*Zero Hard Delete*)**: Data master pasien yang telah tersimpan dilarang dihapus secara fisik dari sistem; pemeliharaan status hanya diperbolehkan melalui perubahan status keaktifan (*soft-state*).
- **Prinsip Sumber Referensi Tunggal (*Single Source of Truth*)**: Seluruh domain operasional rumah sakit wajib mereferensikan Master Data Pasien (OC-04-01) dan dilarang membuat atau menyimpan salinan master identitas pasien yang berdiri sendiri.
- **Pembatasan Transaksi Pasien Non-Aktif**: Pasien yang berstatus Non-Aktif diblokir dari pencatatan booking baru dan registrasi kunjungan baru hingga diaktifkan kembali (*Reactivate*) dengan justifikasi yang sah.
- **Integritas Jejak Audit Bisnis (*Immutable Audit Trail*)**: Setiap perubahan pada atribut identitas, sosial, alamat, kontak, maupun status keaktifan pasien wajib tercatat permanen dalam riwayat log perubahan dan tidak dapat dimanipulasi atau dihapus.
- **Kepatuhan Format Identitas Kependudukan**: NIK yang direkam untuk WNI wajib berupa 16 digit numerik sesuai standar Direktorat Jenderal Kependudukan dan Pencatatan Sipil (Dukcapil) Republik Indonesia.
- **Independensi Implementasi**: Definisi outcome ini tidak bergantung pada rancangan tabel database, skema teknis, API, form layout, maupun framework tertentu.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Pasien sudah terdaftar dalam sistem (Duplikasi NIK atau kesamaan identitas terdeteksi saat pendaftaran baru)** | Sistem menolak pembentukan No. RM baru. Sistem menampilkan data profil pasien yang telah ada untuk diverifikasi oleh petugas, dan mengarahkan petugas untuk menggunakan No. RM yang sudah ada (serta melakukan pemutakhiran data jika terdapat perubahan alamat atau kontak). |
| **Nomor Induk Kependudukan (NIK) tidak valid** | Sistem menolak penyimpanan data jika format NIK untuk WNI bukan 16 digit numerik. Petugas diminta memverifikasi kembali fisik KTP-el/KK pasien atau menggunakan dokumen identitas resmi yang sah. |
| **Elemen data wajib (*mandatory core attributes*) tidak lengkap pada pendaftaran reguler** | Sistem menolak penyimpanan data pasien baru jika salah satu atribut wajib (Nama Lengkap, Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung) belum terisi. |
| **Pasien gawat darurat tiba tanpa identitas (*Emergency Unidentified Patient / Mr./Ms. X*)** | Sistem menerbitkan No. RM darurat dengan penanda identitas sementara (*flag emergency unidentified*). Sistem mewajibkan petugas untuk memperbarui profil data sosial secara lengkap segera setelah identitas pasien terungkap. |
| **Pasien berstatus Non-Aktif mencoba didaftarkan pelayanan baru** | Transaksi registrasi kunjungan diblokir oleh sistem. Petugas diarahkan untuk melakukan proses verifikasi dan aktivasi kembali status pasien (*Reactivate*) dengan mencantumkan alasan reaktivasi sebelum transaksi dapat dilanjutkan. |
| **Ditemukan dua Nomor Rekam Medis berbeda untuk individu yang sama di kemudian hari** | Sistem melarang pembuatan No. RM ketiga. Kasus dieskalasi ke Perekam Medis untuk diproses rekonsiliasi penggabungan melalui kapabilitas `PAS-MERGE` (Merge Duplicated Pasien). |
| **Gangguan koneksi verifikasi eksternal (Dukcapil / BPJS VClaim)** | Sistem mengizinkan penyimpanan Data Sosial Pasien secara lokal berdasarkan dokumen fisik resmi agar pelayanan kesehatan pasien tidak terhambat, dengan memberikan tanda status *Unverified Online* untuk disinkronkan kembali saat koneksi pulih. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Profil Data Sosial Pasien baru yang disimpan memiliki Nomor Rekam Medis (No. RM) unik yang diterbitkan sistem dan berlaku permanen sebagai business key pasien. | Completeness |
| **AC-02** | Seluruh atribut identitas pokok (Nama Lengkap, Tempat & Tanggal Lahir, Umur terhitung, Jenis Kelamin, Golongan Darah/Rhesus, Nama Ibu Kandung) dan dokumen resmi (NIK 16 digit / Paspor) tersimpan secara akurat. | Completeness |
| **AC-03** | Data alamat tersimpan secara terstruktur dengan pemisahan yang jelas antara Alamat KTP dan Alamat Domisili, lengkap dengan hierarki wilayah administrasi (Jalan, RT/RW, Kelurahan, Kecamatan, Kota/Kabupaten, Provinsi, Kode Pos). | Completeness |
| **AC-04** | Data saluran komunikasi pasien (No. HP/WhatsApp, telepon, email) dan data penanggung jawab/keluarga (nama, relasi, nomor kontak, alamat) tersimpan dan terhubung ke No. RM pasien. | Completeness |
| **AC-05** | Profil Data Sosial Pasien dapat dicari dan ditemukan kembali secara tepat melalui pencarian No. RM, NIK, Nama Lengkap, Tanggal Lahir, Nama Ibu Kandung, atau Nomor Telepon. | Correctness |
| **AC-06** | Status Data Sosial Pasien yang baru dibentuk adalah **Aktif** dan data sosialnya langsung tersedia sebagai referensi otoritatif bagi transaksi Booking (`ADM-BOOKING`) serta Registrasi Rawat Jalan, Rawat Inap, dan IGD (`ADM-REG`). | Correctness |
| **AC-07** | Sistem menolak pembentukan pasien baru jika NIK yang diinput sudah terdaftar pada profil pasien aktif lain dalam sistem. | Constraint |
| **AC-08** | Sistem menolak penyimpanan data jika format NIK untuk WNI bukan 16 digit numerik. | Constraint |
| **AC-09** | Sistem menolak pembentukan pasien baru jika atribut wajib (Nama Lengkap, Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung) kosong pada pendaftaran reguler. | Constraint |
| **AC-10** | Pemutakhiran data sosial sepanjang lifecycle pasien berhasil memperbarui atribut yang bersangkutan tanpa mengubah No. RM, dan rincian perubahan terekam dalam jejak audit bisnis (*change log*). | Correctness |
| **AC-11** | Pasien yang dinonaktifkan berstatus **Non-Aktif**, tidak dapat digunakan dalam pendaftaran kunjungan baru, dan seluruh datanya tetap utuh dalam sistem tanpa penghapusan fisik (*no hard delete*). | Constraint |
| **AC-12** | Pasien berstatus Non-Aktif dapat diaktifkan kembali (*Reactivated*) melalui prosedur otorisasi yang sah dan datanya dapat langsung digunakan kembali dalam proses pelayanan rumah sakit. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Registrasi Kunjungan Pasien ke Unit Pelayanan**: Pencatatan kunjungan resmi pasien ke poliklinik atau IGD dikelola oleh **OC-01-02 Registrasi Rawat Jalan dan IGD**, sedangkan pendaftaran rawat inap dikelola oleh **OC-01-03 Registrasi Rawat Inap**.
- **Booking & Reservasi Jadwal Janji Temu**: Pengelolaan reservasi dan jadwal kunjungan pasien sebelum hari H dikelola oleh **OC-01-01 Booking**.
- **Penggabungan Rekam Medis Duplikat (*Merge Pasien*)**: Rekonsiliasi struktural dua atau lebih nomor rekam medis yang mewakili orang yang sama dikelola oleh kapabilitas **`PAS-MERGE` (Merge Duplicated Pasien)**.
- **Manajemen Berkas Fisik Rekam Medis**: Pengelolaan map rekam medis fisik, pengarsipan (*filing*), penomoran rak penyimpanan, dan pelacakan mutasi keluar-masuk berkas dikelola oleh **OC-04-02 Manajemen Berkas**.
- **Dokumentasi Asuhan Medis & Rekam Medis Elektronik (RME)**: Pencatatan rekam medis klinis, asesmen, riwayat alergi, pengkajian dokter/perawat, lembar observasi, dan resume medis dikelola oleh domain pelayanan klinis terkait (Rawat Jalan, Rawat Inap, IGD).
- **Kodifikasi Klinis dan Casemix**: Pengkodean diagnosis (ICD-10) dan prosedur tindakan (ICD-9-CM) serta penentuan tarif klaim INA-CBG dikelola oleh **OC-04-03 Casemix dan Coding**.
- **Pelaporan Statistik Rumah Sakit**: Penyusunan laporan Rekapitulasi Laporan Rumah Sakit dikelola oleh **OC-04-04 Pelaporan RL**, serta pelaporan sensus harian dan indeks rekam medis dikelola oleh **OC-04-05 Pelaporan Index dan Sensus**.
- **Pengelolaan Master Wilayah dan Organisasi**: Pengelolaan tabel master nama provinsi, kabupaten/kota, kecamatan, kelurahan, dan unit layanan dikelola oleh **Organisasi Domain** (`ORG-LAYANAN`).
- **Penerbitan Surat Eligibilitas Peserta (SEP)**: Pembuatan SEP dan administrasi klaim kepesertaan dikelola oleh **OC-01-04 VCLAIM BPJS**.
- **Transaksi Finansial & Tagihan Pasien**: Penagihan tarif pelayanan, pengelolaan deposit, alokasi pembayaran, dan penerimaan kasir dikelola oleh **Tata Rekening Domain** (`TRK-BILLING`, `TRK-DEPOSIT`, `TRK-PAYMENT`, `TRK-KASIR`).
