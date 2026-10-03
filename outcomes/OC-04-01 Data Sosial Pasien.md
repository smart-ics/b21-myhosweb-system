# OUTCOME: Data Sosial Pasien

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-04-01          |
| Version     | 1.1               |
| Status      | Draft             |
| LastUpdated | 2026-10-03        |

---

## 1. Business Purpose

Rumah sakit harus memiliki identitas master setiap pasien yang tunggal, konsisten, dan dapat dipercaya sebagai dasar seluruh pelayanan. **OC-04-01 Data Sosial Pasien** memastikan bahwa informasi identitas dan sosial pasien terbentuk sebagai bagian dari **Master Data Pasien**, terasosiasi dengan **Nomor Rekam Medis (No. RM)** sebagai business key yang unik dan permanen, serta dipelihara sepanjang siklus hidup master pasien.

Master Data Pasien adalah istilah payung untuk kumpulan data master pasien. OC-04-01 secara khusus mendefinisikan bagian identitas, sosial-demografi, alamat dan komunikasi, serta hubungan sosial pasien — bukan seluruh siklus hidup pelayanan pasien.

Tanpa data sosial pasien yang terdefinisi secara otoritatif, setiap domain pelayanan berisiko menyimpan dan mengelola versi identitas pasien secara mandiri, yang merusak konsistensi data dan menghambat kepatuhan regulasi rekam medis (**Permenkes No. 24 Tahun 2022**).

> **Catatan regulasi**: Permenkes No. 24/2022 mewajibkan rekam medis memuat paling sedikit: No. RM, nama pasien, NIK atau identitas resmi lainnya, tempat dan tanggal lahir, jenis kelamin, alamat, nomor kontak, serta penanggung jawab pasien. Atribut tambahan dalam OC-04-01 (agama, pendidikan, pekerjaan, suku, bahasa, pemisahan alamat KTP dan domisili, saluran komunikasi digital) merupakan keputusan cakupan bisnis MYHOSWEB, bukan mandat regulasi.

---

## 2. Outcome Statement

Informasi identitas dan sosial pasien **telah terbentuk atau diperbarui sebagai bagian dari Master Data Pasien, terasosiasi secara unik dan permanen dengan Nomor Rekam Medis (No. RM), serta siap menjadi sumber master dan referensi otoritatif bagi domain lain.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Pasien** | **Pemilik Utama**: Mengelola profil Data Sosial Pasien, menerbitkan No. RM sebagai business key, memelihara atribut identitas dan sosial, serta memelihara status keaktifan master data pasien melalui kapabilitas `PAS-DATSOS`. |
| **Admission** | **Inisiator & Pemutakhir Operasional**: Memfasilitasi pembentukan data sosial pasien baru pada pendaftaran pertama, memverifikasi identitas pasien pada kunjungan ulang, dan memfasilitasi pemutakhiran data saat registrasi pelayanan melalui kapabilitas `ADM-REG`. |
| **Organisasi** | **Penyedia Referensi Baku**: Menyediakan data master referensi wilayah administratif dan atribut sosiologis yang digunakan pada profil pasien melalui kapabilitas `ORG-LAYANAN`. |
| **BPJS** | **Verifikator Eksternal (Kondisional)**: Memvalidasi kesesuaian data identitas pasien (NIK) dengan basis data nasional BPJS Kesehatan melalui kapabilitas `BPJ-VCLAIM` pada saat pendaftaran atau verifikasi penjamin. |

> **Catatan**: Domain lain (Rawat Jalan, Rawat Inap, Gawat Darurat, Laboratorium, Radiologi, Apotek, Berkas Rekam Medis, Tata Rekening, Pelaporan) berperan sebagai **konsumen referensi**. Mereka mereferensikan No. RM dan data sosial pasien yang dipelihara oleh OC-04-01, tetapi tidak menjadi pemilik master identitas dan sosial tersebut.

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

- Profil Data Sosial Pasien terbentuk dan terpersistensi dalam sistem sebagai representasi definitif dari satu individu nyata.
- Pasien diidentifikasi secara tunggal oleh **Nomor Rekam Medis (No. RM)** yang unik dan permanen sebagai business key (*Unit Numbering System*).
- Identitas kependudukan resmi pasien (NIK bagi WNI, atau dokumen identitas resmi lainnya bagi WNA) tercatat dan terhubung dengan No. RM.
- Data demografi dasar pasien (nama lengkap, tempat dan tanggal lahir, jenis kelamin, dan nama ibu kandung) tercatat dan dapat diverifikasi.
- Data sosial-demografi pasien (agama, status perkawinan, pendidikan, pekerjaan, suku/etnis, dan bahasa) terdokumentasi sesuai standar referensi rumah sakit.
- Alamat pasien terdokumentasi, dengan pemisahan antara **Alamat KTP** dan **Alamat Domisili** bila berbeda.
- Saluran komunikasi pasien (nomor telepon/HP dan saluran komunikasi lain yang tersedia) tercatat dan dapat digunakan untuk dihubungi.
- Data hubungan sosial pasien (keluarga, penanggung jawab, atau kontak darurat beserta relasi dan informasi kontaknya) tercatat.
- Pasien memiliki status keaktifan master data yang terdefinisi (**Aktif** atau **Non-Aktif**).
- Setiap pembentukan dan pemutakhiran profil Data Sosial Pasien terekam dalam jejak audit yang dapat ditelusuri.

### 5.2 Required Recorded Information

**A. Identitas Dasar Pasien:**
- Nomor Rekam Medis (No. RM) — *business key, unik dan permanen*.
- Jenis dan nomor dokumen identitas resmi (NIK bagi WNI, atau identitas resmi lainnya bagi WNA dan pasien anak).
- Nama lengkap pasien sesuai dokumen kependudukan resmi.
- Nama panggilan/alias, jika ada.
- Tempat dan tanggal lahir.
- Jenis kelamin.
- Nama ibu kandung — atribut kunci untuk verifikasi identitas dan pencegahan duplikasi.
- Status kewarganegaraan.
- Status keaktifan master pasien (Aktif / Non-Aktif).

**B. Data Sosial-Demografi Pasien:**
- Agama.
- Status perkawinan.
- Tingkat pendidikan terakhir.
- Pekerjaan.
- Suku / Etnis.
- Bahasa komunikasi utama.

**C. Alamat dan Saluran Komunikasi:**
- Alamat sesuai dokumen identitas resmi (Alamat KTP), mencakup hierarki wilayah administratif yang lengkap.
- Alamat domisili terkini, jika berbeda dari alamat KTP.
- Nomor telepon/HP utama yang dapat dihubungi.
- Saluran komunikasi lain yang tersedia (telepon alternatif, email, atau saluran lain yang relevan).

**D. Hubungan Sosial Pasien:**
- Nama dan informasi kontak pihak terkait (keluarga, penanggung jawab, atau kontak darurat).
- Relasi hubungan pihak terkait dengan pasien.

**E. Jejak Audit:**
- Waktu pembentukan dan identitas petugas yang mencatat pertama kali.
- Waktu dan identitas petugas dari setiap pemutakhiran data.

### 5.3 Required Business Conditions

- Satu individu fisik hanya boleh direpresentasikan oleh satu No. RM aktif dalam sistem (*Unit Numbering System*).
- No. RM bersifat permanen: tidak dapat diubah, tidak dapat dialihkan ke individu lain, dan tidak dapat diterbitkan ulang.
- Pemeriksaan duplikasi wajib dilakukan sebelum No. RM baru diterbitkan.
- Atribut minimum wajib untuk pembentukan pasien baru adalah: Nama Lengkap, Tanggal Lahir, Jenis Kelamin, dan Nama Ibu Kandung.
- Pemutakhiran data sosial pasien dapat dilakukan kapan saja sepanjang lifecycle master pasien tanpa mengubah No. RM.
- Penghapusan fisik data master pasien yang telah tersimpan tidak diperbolehkan; perubahan status dilakukan secara *soft-state*.

### 5.4 Completion Proof

- Profil Data Sosial Pasien tersimpan dalam sistem dengan No. RM yang valid dan unik.
- Profil pasien dapat ditemukan kembali berdasarkan No. RM, identitas kependudukan, nama, atau tanggal lahir.
- Data Sosial Pasien tersedia sebagai referensi bagi domain lain yang membutuhkan identitas pasien.
- Setiap pembentukan atau pemutakhiran menghasilkan jejak audit yang dapat ditelusuri.

---

## 6. Outcome Boundary

### Start

**Pembentukan baru**: Dimulai ketika informasi identitas pasien diserahkan untuk pertama kali ke rumah sakit, baik melalui loket pendaftaran, IGD, maupun kanal registrasi lain.

**Pemutakhiran**: Dimulai ketika petugas menerima permohonan perubahan data sosial pasien yang sudah terdaftar.

### End

**Pembentukan baru**: Berakhir ketika profil Data Sosial Pasien tersimpan dengan No. RM yang unik dan berstatus **Aktif**.

**Pemutakhiran**: Berakhir ketika data sosial yang diperbarui tersimpan dan terasosiasi dengan No. RM yang sama, serta perubahannya tercatat dalam jejak audit.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Keunikan dan Permanensi No. RM**: Setiap No. RM hanya boleh diasosiasikan dengan tepat satu pasien, tidak dapat diubah nomornya, dan tidak dapat dipindahtangankan kepada individu lain.
- **Keunikan Identitas Kependudukan**: Nomor identitas resmi yang valid (NIK) hanya boleh terdaftar pada satu profil pasien aktif.
- **Larangan Penghapusan Fisik**: Data master pasien tidak dapat dihapus secara fisik dari sistem; perubahan status dilakukan melalui mekanisme *soft-state*.
- **OC-04-01 sebagai Sumber Master Otoritatif**: OC-04-01 merupakan sumber master dan referensi otoritatif untuk identitas dan data sosial pasien. Domain lain tidak menjadi pemilik master tersebut.
- **Kekekalan Jejak Audit**: Riwayat perubahan pada atribut data sosial pasien tidak dapat dimanipulasi atau dihapus.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Identitas pasien sudah terdaftar (duplikasi terdeteksi)** | Pembentukan No. RM baru ditolak. Profil pasien yang sudah ada ditampilkan untuk diverifikasi; petugas diarahkan untuk menggunakan No. RM yang ada atau melakukan pemutakhiran data. |
| **Atribut minimum wajib tidak lengkap** | Pembentukan profil pasien baru ditolak hingga atribut minimum wajib terpenuhi. |
| **Pasien gawat darurat tiba tanpa identitas yang terverifikasi** | No. RM dapat diterbitkan dengan identitas sementara agar pelayanan tidak terhambat. Pemutakhiran data sosial lengkap wajib dilakukan segera setelah identitas asli terkonfirmasi. |
| **Koneksi verifikasi eksternal (Dukcapil / BPJS VClaim) tidak tersedia** | Penyimpanan data sosial dapat dilakukan berdasarkan dokumen fisik yang tersedia, dengan penanda status verifikasi tertunda untuk diselesaikan saat koneksi pulih. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Profil Data Sosial Pasien baru yang disimpan memiliki No. RM unik yang diterbitkan sistem dan berlaku permanen sebagai business key. | Completeness |
| **AC-02** | Atribut identitas dasar (Nama Lengkap, Tempat & Tanggal Lahir, Jenis Kelamin, Nama Ibu Kandung, dan nomor identitas resmi) tersimpan dan dapat diverifikasi. | Completeness |
| **AC-03** | Data sosial-demografi (agama, pendidikan, pekerjaan, status perkawinan, suku, bahasa) tersimpan dan terhubung ke No. RM pasien. | Completeness |
| **AC-04** | Alamat pasien tersimpan dengan pemisahan antara Alamat KTP dan Alamat Domisili, lengkap dengan hierarki wilayah administratif. | Completeness |
| **AC-05** | Data komunikasi pasien dan informasi hubungan sosial (penanggung jawab, kontak darurat, beserta relasi dan kontak) tersimpan dan terhubung ke No. RM. | Completeness |
| **AC-06** | Profil Data Sosial Pasien dapat ditemukan kembali berdasarkan No. RM, nomor identitas resmi, nama lengkap, atau tanggal lahir. | Correctness |
| **AC-07** | Data Sosial Pasien yang berstatus Aktif tersedia sebagai referensi bagi domain lain yang membutuhkan identitas pasien. | Correctness |
| **AC-08** | Pembentukan pasien baru ditolak jika nomor identitas resmi sudah terdaftar pada profil pasien aktif lain. | Constraint |
| **AC-09** | Pembentukan pasien baru ditolak jika atribut minimum wajib belum terpenuhi. | Constraint |
| **AC-10** | Pemutakhiran data sosial berhasil memperbarui atribut yang bersangkutan tanpa mengubah No. RM, dan perubahan terekam dalam jejak audit. | Correctness |
| **AC-11** | Data master pasien yang telah tersimpan tidak dapat dihapus secara fisik; perubahan status dilakukan melalui mekanisme *soft-state*. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Registrasi Kunjungan**: Pencatatan kunjungan pasien ke unit pelayanan → **OC-01-02 Registrasi Rawat Jalan dan IGD**, **OC-01-03 Registrasi Rawat Inap**.
- **Booking & Reservasi**: Pengelolaan jadwal janji temu pasien → **OC-01-01 Booking**.
- **Penggabungan Rekam Medis Duplikat**: Rekonsiliasi No. RM ganda untuk individu yang sama → kapabilitas **`PAS-MERGE`**.
- **Manajemen Berkas Fisik Rekam Medis**: Keterlacakan dan mutasi berkas fisik → **OC-04-02 Manajemen Berkas**.
- **Dokumentasi Asuhan Medis**: Catatan klinis, asesmen, dan rekam medis elektronik → domain pelayanan klinis terkait.
- **Kodifikasi Klinis dan Casemix**: Pengkodean diagnosis dan tindakan → **OC-04-03 Casemix dan Coding**.
- **Pelaporan Statistik Rumah Sakit**: Laporan RL dan sensus → **OC-04-04 Pelaporan RL**, **OC-04-05 Pelaporan Index dan Sensus**.
- **Pengelolaan Master Wilayah dan Referensi**: Tabel master wilayah administratif → **Organisasi Domain** (`ORG-LAYANAN`).
- **Penerbitan SEP dan Klaim BPJS**: Administrasi kepesertaan dan klaim → **OC-01-04 VCLAIM BPJS**.
- **Transaksi Finansial dan Tagihan**: Billing, deposit, pembayaran, kasir → **Tata Rekening Domain**.
- **Blocking transaksi pasien Non-Aktif**: Aturan bahwa pasien Non-Aktif tidak dapat diregistrasi merupakan tanggung jawab outcome/capability yang melakukan registrasi, bukan OC-04-01.
- **Reactivation pasien**: Proses aktivasi kembali pasien Non-Aktif merupakan tanggung jawab use case atau capability yang menangani perubahan status tersebut.
