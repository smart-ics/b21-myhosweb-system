# OUTCOME: VClaim BPJS

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit yang melayani pasien peserta BPJS Kesehatan wajib melakukan komunikasi resmi dengan sistem VClaim BPJS untuk setiap transaksi pelayanan yang dijamin BPJS — mulai dari penerbitan Surat Eligibilitas Peserta (SEP), pemrosesan rujukan, hingga pengajuan data klaim — sebagai persisted business fact yang menjadi bukti sah pelayanan BPJS dalam sistem rumah sakit.

VClaim BPJS memastikan bahwa setiap transaksi BPJS yang terjadi di rumah sakit — baik untuk kunjungan Rawat Jalan Tingkat Lanjut (RJTL), Rawat Inap Tingkat Lanjut (RITL), maupun IGD — memiliki catatan yang sah, dapat ditelusuri, dan terhubung dengan kunjungan atau episode pelayanan yang terkait.

Tanpa catatan transaksi VClaim yang tersimpan dalam sistem, klaim BPJS tidak dapat diajukan, validitas pelayanan tidak dapat dibuktikan kepada BPJS Kesehatan, dan audit kepatuhan BPJS tidak dapat dilakukan.

---

## 2. Outcome Statement

Transaksi VClaim BPJS atas pelayanan pasien peserta BPJS Kesehatan **telah tercatat sebagai persisted business fact dalam sistem, dengan SEP yang diterbitkan, data rujukan yang tervalidasi, dan informasi pelayanan yang siap menjadi dasar pengajuan klaim kepada BPJS Kesehatan**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                           |
|---------------|----------------------------------------------------------------------------------------------------------------|
| BPJS          | Pemilik utama: mengelola seluruh transaksi VClaim termasuk SEP, rujukan, dan data klaim sebagai persisted fact |
| Admission     | Co-owner: kunjungan rawat jalan dan rawat inap yang membutuhkan SEP diterbitkan melalui proses registrasi      |
| Pasien        | Menyediakan identitas pasien dan data kepesertaan BPJS yang menjadi subjek transaksi VClaim                    |
| Tata Rekening | Menggunakan hasil VClaim (SEP) sebagai dasar penetapan jenis jaminan BPJS pada episode pelayanan              |
| Berkas Rekam Medis | Menggunakan data diagnosa dan prosedur dari episode pelayanan sebagai input pengajuan klaim BPJS        |

---

## 4. Participating Capabilities

| Capability                              | Domain             | Status |
|-----------------------------------------|--------------------|--------|
| `BPJ-VCLAIM` VClaim                     | BPJS               | Known  |
| `BPJ-EKLAIM` e-Klaim                    | BPJS               | Known  |
| `ADM-REG` Registration                  | Admission          | Known  |
| `PAS-DATSOS` Data Sosial Pasien         | Pasien             | Known  |
| `TRK-JAMINAN` Jaminan                  | Tata Rekening      | Known  |
| `BRM-CODING` Diagnosis/Coding           | Berkas Rekam Medis | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Transaksi VClaim telah dilakukan terhadap sistem BPJS Kesehatan atas nama pasien peserta BPJS yang teridentifikasi.
- SEP (Surat Eligibilitas Peserta) telah diterbitkan oleh sistem VClaim BPJS dan nomor SEP-nya telah tercatat dalam sistem rumah sakit.
- Transaksi VClaim dikaitkan dengan kunjungan atau episode pelayanan yang relevan (kunjungan rawat jalan, episode rawat inap, atau kunjungan IGD).
- Tipe pelayanan BPJS telah ditentukan: Rawat Jalan Tingkat Lanjut (RJTL), Rawat Inap Tingkat Lanjut (RITL), atau IGD.
- Data rujukan yang digunakan sebagai dasar pelayanan (jika berlaku) telah tervalidasi melalui VClaim.

### 5.2 Required Recorded Information

**Informasi SEP wajib:**

- Nomor SEP yang diterbitkan oleh BPJS Kesehatan (unik per kunjungan / episode).
- Nomor kartu BPJS / Nomor Induk Kepesertaan (NIK) peserta.
- Nama peserta BPJS sesuai data kepesertaan.
- Tanggal penerbitan SEP.
- Jenis pelayanan: RJTL / RITL / IGD.
- Diagnosa awal (ICD-10) yang dicatat pada saat penerbitan SEP.
- Poli / unit pelayanan tujuan sesuai SEP.
- Kelas perawatan yang berlaku (untuk RITL).
- Referensi kunjungan atau nomor registrasi episode pelayanan yang terkait di sistem rumah sakit.

**Informasi rujukan (jika berlaku):**

- Nomor surat rujukan dari Fasilitas Kesehatan Tingkat Pertama (FKTP) atau rumah sakit perujuk.
- Tanggal dan masa berlaku rujukan.
- Diagnosa dan kode diagnosa dari surat rujukan.
- Nama FKTP / fasilitas perujuk.

**Informasi tambahan:**

- Petugas yang melakukan transaksi VClaim.
- Waktu transaksi VClaim dilakukan.
- Respons atau konfirmasi dari sistem VClaim BPJS (status sukses / gagal beserta kode pesan).

### 5.3 Required Business Conditions

- Pasien harus terdaftar sebagai peserta BPJS Kesehatan yang aktif pada tanggal pelayanan.
- Status kepesertaan BPJS pasien harus valid (aktif) pada saat transaksi VClaim dilakukan.
- Untuk pelayanan RJTL dan RITL, surat rujukan dari FKTP harus valid dan masih berlaku pada tanggal pelayanan, kecuali untuk kunjungan khusus yang dikecualikan dari ketentuan rujukan (sesuai regulasi BPJS yang berlaku).
- Rumah sakit harus terdaftar sebagai Fasilitas Kesehatan Rujukan Tingkat Lanjut (FKRTL) yang aktif dalam jaringan BPJS Kesehatan.
- SEP hanya dapat diterbitkan untuk satu kunjungan atau satu episode rawat inap. Satu SEP tidak boleh digunakan untuk lebih dari satu kunjungan atau episode.
- Transaksi VClaim harus dilakukan melalui koneksi resmi ke API VClaim BPJS Kesehatan.

### 5.4 Completion Proof

- Nomor SEP yang valid telah tercatat dalam sistem rumah sakit dan terhubung dengan kunjungan atau episode pelayanan yang relevan.
- Sistem VClaim BPJS memberikan konfirmasi berhasil (respons sukses) atas transaksi SEP yang dilakukan.
- SEP dapat ditemukan berdasarkan nomor SEP, nomor rekam medis pasien, nomor kartu BPJS, atau nomor kunjungan yang terkait.
- Informasi SEP dapat dijadikan dasar penetapan jaminan BPJS pada episode pelayanan dan sebagai input pengajuan klaim.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kunjungan atau episode pelayanan pasien peserta BPJS Kesehatan diidentifikasi memerlukan transaksi VClaim — yaitu saat identitas peserta BPJS, tipe pelayanan yang dibutuhkan, dan kunjungan atau episode yang terkait telah ditentukan dan petugas memulai proses penerbitan SEP.

Transaksi VClaim dapat dipicu dari:
- Proses registrasi kunjungan rawat jalan (RJTL) oleh Admission.
- Proses registrasi rawat inap (RITL) oleh Admission.
- Proses pencatatan kunjungan IGD oleh unit Gawat Darurat.
- Permintaan penerbitan SEP secara manual oleh petugas yang berwenang.

### End

Berakhir ketika transaksi VClaim telah berhasil dilakukan, nomor SEP yang valid telah diterbitkan dan tercatat dalam sistem rumah sakit, serta SEP tersebut telah dikaitkan dengan kunjungan atau episode pelayanan yang relevan.

> Outcome ini berakhir pada titik terbitnya SEP dan tercatatnya data transaksi VClaim. Pengajuan e-Klaim setelah episode pelayanan selesai adalah tanggung jawab BPJS Domain (`BPJ-EKLAIM`) dan bukan bagian dari Outcome ini.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Pasien harus menjadi peserta BPJS Kesehatan yang aktif pada tanggal pelayanan. Transaksi VClaim tidak dapat dilakukan atas nama peserta yang status kepesertaannya tidak aktif.
- SEP hanya dapat diterbitkan melalui koneksi resmi ke API VClaim BPJS Kesehatan. Penerbitan SEP secara manual (tanpa konfirmasi dari sistem BPJS) tidak diakui sebagai transaksi VClaim yang sah.
- Satu SEP hanya berlaku untuk satu kunjungan rawat jalan atau satu episode rawat inap. SEP tidak dapat dibagi atau digunakan ulang untuk kunjungan atau episode yang berbeda.
- Untuk pelayanan RJTL dan RITL, rujukan dari FKTP yang valid dan masih berlaku adalah prasyarat penerbitan SEP, kecuali untuk kondisi yang dikecualikan oleh regulasi BPJS (misalnya: kasus gawat darurat, pelayanan khusus tanpa rujukan).
- Nomor SEP bersifat unik dan diterbitkan oleh sistem BPJS Kesehatan; rumah sakit tidak boleh membuat atau memodifikasi nomor SEP secara mandiri.
- SEP yang sudah diterbitkan dan dikaitkan dengan kunjungan aktif tidak dapat dibatalkan secara sepihak oleh rumah sakit tanpa melalui prosedur pembatalan yang berlaku di sistem VClaim BPJS.
- Transaksi VClaim dan data SEP yang tersimpan di sistem harus konsisten dengan data yang tersimpan di sistem BPJS Kesehatan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                          | Expected Behavior                                                                                                                                                    |
|------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kepesertaan BPJS pasien tidak aktif pada tanggal pelayanan                         | SEP tidak dapat diterbitkan. Informasikan kepada pasien bahwa kepesertaannya tidak aktif; tawarkan pilihan pelayanan dengan jaminan lain atau biaya mandiri.         |
| Surat rujukan dari FKTP tidak valid, sudah kadaluarsa, atau tidak ditemukan        | SEP tidak dapat diterbitkan untuk pelayanan RJTL/RITL. Pasien diarahkan untuk melengkapi rujukan yang valid dari FKTP, atau proses dilanjutkan sesuai regulasi yang berlaku untuk kasus tanpa rujukan. |
| Sistem VClaim BPJS tidak dapat diakses (gangguan jaringan atau sistem BPJS down)  | SEP tidak dapat diterbitkan secara online. Kunjungan dapat dicatat sementara dengan status menunggu SEP; penerbitan SEP dilakukan segera setelah sistem VClaim dapat diakses kembali, sesuai prosedur offline BPJS yang berlaku. |
| Nomor kartu BPJS / NIK pasien tidak terdaftar atau tidak ditemukan di sistem BPJS | SEP tidak dapat diterbitkan. Petugas harus memverifikasi identitas kepesertaan BPJS pasien; jika tidak dapat diselesaikan, pelayanan dilanjutkan dengan jaminan lain atau biaya mandiri. |
| Rumah sakit tidak terdaftar sebagai FKRTL aktif untuk jenis pelayanan yang diminta | SEP tidak dapat diterbitkan untuk jenis pelayanan tersebut. Eskalasi ke manajemen untuk verifikasi status jaringan BPJS rumah sakit.                                |
| SEP untuk kunjungan atau episode yang sama sudah pernah diterbitkan                | Sistem menolak penerbitan SEP duplikat. Petugas diarahkan untuk menggunakan nomor SEP yang sudah ada atau mengajukan pembatalan SEP lama melalui prosedur yang berlaku sebelum menerbitkan yang baru. |
| Diagnosa awal yang dimasukkan tidak valid atau tidak dikenali oleh sistem VClaim   | Transaksi VClaim ditolak. Petugas harus mengoreksi kode diagnosa (ICD-10) agar sesuai dengan ketentuan BPJS sebelum mengulang transaksi.                            |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                           | Validates    |
|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Transaksi VClaim yang berhasil menghasilkan nomor SEP unik yang diterbitkan oleh sistem BPJS Kesehatan dan tersimpan dalam sistem rumah sakit.                                       | Completeness |
| AC-02 | SEP yang tersimpan memuat informasi lengkap: nomor SEP, nomor kartu BPJS, nama peserta, tanggal terbit, tipe pelayanan, diagnosa awal, dan poli/unit layanan tujuan.                | Correctness  |
| AC-03 | SEP yang tersimpan terhubung dengan kunjungan atau nomor registrasi episode pelayanan yang relevan di sistem rumah sakit.                                                            | Correctness  |
| AC-04 | SEP dapat ditemukan berdasarkan nomor SEP, nomor kartu BPJS, nomor rekam medis pasien, atau nomor kunjungan yang terkait.                                                           | Completeness |
| AC-05 | Data transaksi VClaim yang tersimpan di sistem rumah sakit konsisten dengan data yang dikonfirmasi oleh sistem BPJS Kesehatan (nomor SEP dan detail kepesertaan sesuai).            | Correctness  |
| AC-06 | SEP tidak dapat diterbitkan jika kepesertaan BPJS pasien tidak aktif pada tanggal pelayanan.                                                                                        | Constraint   |
| AC-07 | SEP tidak dapat diterbitkan tanpa surat rujukan yang valid untuk pelayanan RJTL dan RITL, kecuali untuk kondisi yang dikecualikan regulasi BPJS.                                    | Constraint   |
| AC-08 | Sistem menolak penerbitan SEP duplikat untuk kunjungan atau episode yang sudah memiliki SEP aktif.                                                                                  | Constraint   |
| AC-09 | Jika sistem VClaim tidak dapat diakses, kunjungan tetap dapat dicatat sementara dan SEP dapat diterbitkan segera setelah koneksi dipulihkan sesuai prosedur offline yang berlaku.   | Exception    |
| AC-10 | SEP yang telah diterbitkan dapat digunakan sebagai dasar penetapan jaminan BPJS pada episode pelayanan dan sebagai input proses pengajuan klaim (`BPJ-EKLAIM`).                     | Correctness  |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Proses registrasi kunjungan rawat jalan atau IGD yang memerlukan SEP → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Proses registrasi rawat inap yang memerlukan SEP → **OC-01-03 Registrasi Rawat Inap**.
- Pengajuan klaim BPJS pasca episode pelayanan (e-Klaim) → **BPJS Domain** (`BPJ-EKLAIM`).
- Pengelolaan antrian online BPJS (Antrol / P-Care) → **BPJS Domain** (`BPJ-ANTROL`).
- Pelaporan dan updating data fasilitas kesehatan ke BPJS (HFIS) → **BPJS Domain** (`BPJ-HFIS`).
- Coding diagnosa dan prosedur untuk keperluan casemix BPJS → **Berkas Rekam Medis Domain** (`BRM-CODING`).
- Pengelolaan data kepesertaan BPJS pasien (identitas dan nomor kartu BPJS) → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan tarif dan paket BPJS (INA-CBGs) → **Tata Rekening Domain** (`TRK-TARIF`).
- Proses pembayaran klaim BPJS oleh BPJS kepada rumah sakit → di luar sistem MYHOSWEB (eksternal).
- Pengelolaan surat rujukan masuk dan keluar dalam konteks rekam medis → **Berkas Rekam Medis Domain**.
- Pelaporan RL (Laporan Rumah Sakit) ke Kemenkes → **OC-04-04 Pelaporan RL** (`BRM-RL`).
