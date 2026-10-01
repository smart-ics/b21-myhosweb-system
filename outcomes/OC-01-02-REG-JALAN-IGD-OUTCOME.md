# OUTCOME: Registrasi Rawat Jalan dan IGD

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-02     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat kunjungan pasien secara resmi ke unit pelayanan rawat jalan atau IGD sebagai persisted business fact yang menjadi dasar seluruh aktivitas klinis dan administratif selama kunjungan tersebut.

Registrasi kunjungan memastikan bahwa setiap pasien yang datang ke rumah sakit — baik melalui jalur rawat jalan (poliklinik) maupun jalur gawat darurat (IGD) — tercatat dengan identitas yang terverifikasi, jenis jaminan yang berlaku, dan unit layanan tujuan yang tepat.

Tanpa kunjungan yang terdaftar secara resmi, pelayanan klinis tidak dapat dikaitkan dengan pasien dan kunjungan yang benar, tagihan tidak dapat dibentuk, dan perjalanan pasien selama kunjungan tidak dapat dilacak.

---

## 2. Outcome Statement

Kunjungan pasien ke unit pelayanan rawat jalan atau IGD **telah tercatat sebagai kunjungan aktif yang diakui sistem, siap menjadi konteks bagi seluruh aktivitas klinis, administratif, dan penagihan selama episode pelayanan tersebut**.

---

## 3. Participating Domains

| Domain      | Role in this Outcome                                                                                       |
|-------------|------------------------------------------------------------------------------------------------------------|
| Admission   | Pemilik utama: mencatat dan mengelola registrasi kunjungan rawat jalan sebagai persisted business fact     |
| Gawat Darurat | Co-owner untuk kunjungan IGD: IGD Visit dapat dibuat mandiri sebelum registrasi Admission tersedia      |
| Pasien      | Menyediakan identitas pasien yang menjadi subjek kunjungan                                                 |
| Organisasi  | Menyediakan data unit layanan, poliklinik, PPA (dokter), dan jadwal praktek yang menjadi tujuan kunjungan  |
| Tata Rekening | Menyediakan jenis jaminan (coverage) yang berlaku untuk kunjungan                                       |
| BPJS        | Menyediakan validasi kepesertaan BPJS dan surat eligibilitas peserta (SEP) untuk kunjungan berbasis BPJS   |

---

## 4. Participating Capabilities

| Capability                          | Domain        | Status |
|-------------------------------------|---------------|--------|
| `ADM-REG` Registration              | Admission     | Known  |
| `ADM-ANTRIAN` Antrian Registrasi    | Admission     | Known  |
| `ADM-BOOKING` Booking               | Admission     | Known  |
| `IGD-VISIT` IGD Visit               | Gawat Darurat | Known  |
| `PAS-DATSOS` Data Sosial Pasien     | Pasien        | Known  |
| `ORG-LAYANAN` Unit Layanan          | Organisasi    | Known  |
| `ORG-PPA` Petugas Pemberi Asuhan    | Organisasi    | Known  |
| `ORG-JADWAL` Jadwal Praktek Dokter  | Organisasi    | Known  |
| `TRK-JAMINAN` Jaminan              | Tata Rekening | Known  |
| `BPJ-VCLAIM` VClaim                 | BPJS          | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

**Untuk Rawat Jalan:**

- Kunjungan rawat jalan atas nama pasien yang teridentifikasi telah tercatat dalam sistem.
- Kunjungan merujuk pada poliklinik tujuan dan dokter yang valid.
- Kunjungan memiliki jenis jaminan pembayaran yang ditentukan (umum, BPJS, asuransi, atau jaminan lain).
- Kunjungan memiliki status aktif: **Terdaftar**.
- Jika kunjungan berasal dari booking yang ada, booking tersebut ditandai **Sudah Digunakan**.

**Untuk IGD:**

- IGD Visit atas nama pasien yang teridentifikasi atau dapat diidentifikasi kemudian telah tercatat.
- IGD Visit dapat berdiri sendiri tanpa adanya Admission Registration terlebih dahulu.
- IGD Visit memiliki status aktif: **Aktif**.
- Registrasi Admission untuk kunjungan IGD dapat dibuat kemudian dan dikaitkan dengan IGD Visit yang sudah ada.

### 5.2 Required Recorded Information

**Informasi bersama (Rawat Jalan & IGD):**

- Nomor kunjungan (nomor registrasi) yang unik.
- Identitas pasien (Nomor Rekam Medis).
- Tanggal dan waktu registrasi.
- Jenis kunjungan: Rawat Jalan atau IGD.
- Jenis jaminan pembayaran yang berlaku.
- Petugas yang melakukan registrasi.

**Khusus Rawat Jalan:**

- Poliklinik tujuan.
- Dokter tujuan (DPJP).
- Nomor urut antrian poli.
- Sumber kunjungan: dari booking, atau datang langsung (walk-in).
- Referensi booking jika kunjungan berasal dari booking yang ada.

**Khusus BPJS (Rawat Jalan & IGD):**

- Nomor kartu BPJS / nomor kepesertaan.
- Nomor SEP (Surat Eligibilitas Peserta) yang telah diterbitkan melalui VClaim.
- Tipe pelayanan BPJS (Rawat Jalan Tingkat Lanjut / IGD).

**Khusus IGD:**

- Unit IGD sebagai lokasi penanganan.
- Keterangan cara kunjungan (datang sendiri, dirujuk, atau dibawa ambulance).
- Triage level (jika triage sudah dilakukan pada saat registrasi).

### 5.3 Required Business Conditions

- Pasien yang menjadi subjek kunjungan harus dapat diidentifikasi melalui Nomor Rekam Medis yang ada, atau pasien baru harus didaftarkan terlebih dahulu melalui proses pendaftaran pasien baru sebelum kunjungan dapat dicatat.
- Untuk kunjungan rawat jalan, jadwal praktek dokter pada tanggal kunjungan harus aktif, kecuali dokter pengganti telah ditetapkan.
- Untuk kunjungan BPJS, kepesertaan pasien harus valid pada tanggal kunjungan dan SEP harus berhasil diterbitkan dari sistem VClaim BPJS.
- Satu nomor kunjungan hanya berlaku untuk satu episode pelayanan pada satu tanggal kunjungan.
- Untuk kunjungan rawat jalan yang berasal dari booking, referensi booking harus berstatus **Terjadwal** sebelum dapat digunakan sebagai dasar registrasi.

### 5.4 Completion Proof

- Nomor kunjungan (nomor registrasi) yang unik telah diterbitkan.
- Untuk rawat jalan: status kunjungan adalah **Terdaftar** dan pasien telah masuk dalam antrian poli tujuan.
- Untuk IGD: IGD Visit telah tercatat dengan status **Aktif**.
- Untuk kunjungan BPJS: SEP telah terbit dan terlampir pada kunjungan.
- Kunjungan dapat ditemukan berdasarkan nomor kunjungan, nomor rekam medis pasien, atau tanggal kunjungan.
- Kunjungan dapat dijadikan konteks bagi pencatatan tindakan klinis, order pemeriksaan, dan pembentukan tagihan.

---

## 6. Outcome Boundary

### Start

**Rawat Jalan:** Dimulai ketika petugas pendaftaran memulai proses registrasi untuk pasien yang datang ke loket, yaitu saat identitas pasien (Nomor Rekam Medis atau data pasien baru) dan poliklinik tujuan telah dinyatakan.

**IGD:** Dimulai ketika pasien tiba di IGD dan identitasnya mulai dicatat — atau ketika petugas IGD membuat IGD Visit (yang dapat dilakukan bahkan sebelum identitas pasien sepenuhnya diverifikasi, dalam kondisi darurat).

### End

**Rawat Jalan:** Berakhir ketika kunjungan rawat jalan telah berhasil tercatat dengan nomor kunjungan unik, status **Terdaftar**, dan pasien telah masuk antrian poli tujuan.

**IGD:** Berakhir ketika IGD Visit telah berhasil tercatat dengan status **Aktif**. Jika registrasi Admission dibuat kemudian dan dikaitkan dengan IGD Visit, maka Outcome ini dianggap lengkap ketika kedua catatan — IGD Visit dan Admission Registration — telah terhubung.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Pasien harus dapat diidentifikasi (sudah terdaftar atau sedang didaftarkan sebagai pasien baru) sebelum registrasi kunjungan rawat jalan dapat diselesaikan. Pengecualian berlaku untuk kondisi darurat IGD di mana identifikasi dapat dilakukan setelah IGD Visit dibuat.
- Untuk kunjungan rawat jalan, dokter tujuan harus terdaftar dan aktif dalam sistem, serta terkait dengan poliklinik tujuan yang valid.
- Untuk kunjungan BPJS, SEP harus berhasil diterbitkan dari VClaim sebelum kunjungan dianggap lengkap. Kunjungan BPJS tanpa SEP tidak dapat diajukan klaim.
- Satu pasien tidak boleh memiliki lebih dari satu kunjungan aktif di poliklinik yang sama pada tanggal yang sama dengan dokter yang sama, kecuali ada justifikasi bisnis yang berlaku.
- Nomor kunjungan bersifat unik dan tidak dapat digunakan ulang.
- Kunjungan yang sudah memiliki aktivitas klinis (tindakan, order, atau tagihan yang terbentuk) tidak dapat dibatalkan tanpa prosedur koreksi yang berlaku.
- Jika kunjungan berasal dari booking, booking tersebut hanya boleh digunakan satu kali; setelah digunakan, status booking berubah menjadi **Sudah Digunakan** dan tidak dapat digunakan untuk registrasi kunjungan lain.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                    | Expected Behavior                                                                                                                                       |
|------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pasien tidak dapat diidentifikasi (bukan kasus darurat)                      | Registrasi ditolak. Pasien harus didaftarkan sebagai pasien baru atau identitas yang ada harus ditemukan sebelum registrasi dapat dilanjutkan.           |
| Jadwal praktek dokter tidak aktif pada tanggal kunjungan (rawat jalan)       | Registrasi ke dokter tersebut ditolak. Petugas dapat mengarahkan ke dokter pengganti jika tersedia, atau menjadwalkan ulang kunjungan.                   |
| Kepesertaan BPJS tidak aktif atau tidak valid pada tanggal kunjungan         | SEP tidak dapat diterbitkan. Kunjungan dapat dilanjutkan dengan jenis jaminan lain (umum) setelah konfirmasi dari pasien.                               |
| VClaim BPJS tidak dapat diakses (gangguan sistem)                            | SEP tidak dapat diterbitkan. Kunjungan dapat dicatat sementara dengan status menunggu SEP, sesuai prosedur offline BPJS yang berlaku.                   |
| Booking yang digunakan sebagai dasar registrasi berstatus bukan Terjadwal    | Registrasi berbasis booking ditolak. Booking yang sudah digunakan atau dibatalkan tidak dapat menjadi dasar registrasi baru.                            |
| Pasien sudah memiliki kunjungan aktif di poli dan dokter yang sama pada hari yang sama | Registrasi ditolak. Petugas diberitahu bahwa kunjungan aktif sudah ada dan diminta konfirmasi apakah akan membuat kunjungan baru atau menggunakan yang ada. |
| Unit layanan atau poliklinik tujuan tidak aktif atau tidak tersedia           | Registrasi ke unit tersebut ditolak. Informasikan bahwa unit layanan tidak tersedia pada hari tersebut.                                                 |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                              | Validates    |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Kunjungan yang terdaftar memiliki nomor kunjungan unik yang dapat digunakan untuk menemukan kunjungan tersebut.                                                                        | Completeness |
| AC-02 | Kunjungan yang terdaftar merujuk pada pasien, jenis kunjungan, jenis jaminan, dan unit layanan tujuan yang sesuai dengan permintaan.                                                   | Correctness  |
| AC-03 | Kunjungan rawat jalan yang terdaftar memiliki status **Terdaftar** dan pasien tercatat dalam antrian poli tujuan.                                                                      | Completeness |
| AC-04 | IGD Visit yang terdaftar memiliki status **Aktif** dan dapat menjadi konteks bagi tindakan IGD tanpa memerlukan Admission Registration terlebih dahulu.                                | Completeness |
| AC-05 | Kunjungan dapat ditemukan berdasarkan nomor kunjungan, nomor rekam medis pasien, tanggal kunjungan, dan unit layanan.                                                                  | Correctness  |
| AC-06 | Kunjungan yang berasal dari booking mencatat referensi booking yang benar, dan status booking tersebut berubah menjadi **Sudah Digunakan** setelah registrasi selesai.                 | Correctness  |
| AC-07 | Kunjungan BPJS memiliki nomor SEP yang valid dan terlampir pada kunjungan sebelum kunjungan dianggap lengkap.                                                                          | Completeness |
| AC-08 | Kunjungan tidak dapat dibuat jika pasien tidak dapat diidentifikasi (untuk kunjungan non-darurat).                                                                                     | Constraint   |
| AC-09 | Kunjungan rawat jalan tidak dapat dibuat ke dokter yang jadwal prakteknya tidak aktif pada tanggal kunjungan, tanpa penetapan dokter pengganti.                                        | Constraint   |
| AC-10 | Kunjungan BPJS tidak dapat diselesaikan tanpa SEP yang berhasil diterbitkan, kecuali prosedur offline BPJS yang berlaku diterapkan.                                                    | Constraint   |
| AC-11 | Booking yang sudah berstatus bukan **Terjadwal** tidak dapat digunakan sebagai dasar registrasi kunjungan baru.                                                                        | Constraint   |
| AC-12 | Kunjungan yang berhasil didaftarkan dapat dijadikan konteks bagi pencatatan tindakan klinis, order pemeriksaan, dan pembentukan tagihan.                                               | Correctness  |
| AC-13 | Registrasi Admission yang dibuat setelah IGD Visit terbentuk dapat dikaitkan dengan IGD Visit yang sudah ada.                                                                          | Correctness  |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Proses booking/appointment rawat jalan yang terjadi sebelum hari kunjungan → **OC-01-01 Booking**.
- Pengelolaan antrian fisik pendaftaran rawat jalan di loket → **OC-01-07 Antrian**.
- Registrasi rawat inap (opname) → **OC-01-03 Registrasi Rawat Inap**.
- Pengelolaan proses VCLAIM BPJS secara penuh (verifikasi SEP, e-klaim) → **OC-01-04 VCLAIM BPJS**.
- Pencatatan perjalanan pasien antar layanan selama kunjungan → **OC-01-05 Patient Journey Tracking**.
- Tindakan klinis dan pelayanan medis di poliklinik → **Rawat Jalan Domain** (`RJL-*`).
- Tindakan klinis dan pelayanan medis di IGD → **Gawat Darurat Domain** (`IGD-TINDAKAN`).
- Triage IGD → **OC-07-02 Triage** (`IGD-TRIAGE`).
- Transfer pasien IGD ke rawat inap → `IGD-RANAP`.
- Pengelolaan master data pasien dan data sosial → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan master jadwal praktek dokter → **Organisasi Domain** (`ORG-JADWAL`).
- Pembentukan tagihan dan proses pembayaran atas kunjungan → **Tata Rekening Domain** (`TRK-BILLING`, `TRK-PAYMENT`).
- Dokumentasi rekam medis klinis → **EMR / domain klinis terkait**.
