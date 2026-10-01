# OUTCOME: Registrasi Rawat Inap

| Field       | Value        |
|-------------|--------------|
| Code        | OC-01-03     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat keputusan opname pasien secara resmi — yaitu bahwa pasien akan menjalani perawatan rawat inap — sebagai persisted business fact yang menjadi landasan seluruh aktivitas operasional dan klinis selama episode rawat inap berlangsung.

Registrasi rawat inap memastikan bahwa setiap pasien yang diputuskan untuk dirawat inap tercatat dengan identitas yang terverifikasi, DPJP yang bertanggung jawab, kelas perawatan dan bangsal tujuan yang telah ditentukan, serta jenis jaminan yang berlaku — sehingga unit bangsal penerima dapat memproses penempatan pasien ke bed, dan seluruh pencatatan klinis serta pembentukan tagihan dapat dikaitkan dengan episode rawat inap yang benar.

Tanpa registrasi rawat inap yang tercatat secara resmi, penempatan pasien ke bed tidak dapat diotorisasi, tagihan rawat inap tidak dapat dibentuk, dan perjalanan klinis selama episode opname tidak dapat dilacak dan dikaitkan dengan konteks yang tepat.

---

## 2. Outcome Statement

Keputusan rawat inap atas nama pasien yang teridentifikasi **telah tercatat sebagai registrasi rawat inap aktif yang diakui sistem, dengan bangsal tujuan dan kelas perawatan yang ditentukan, siap menjadi konteks bagi penempatan bed oleh unit bangsal penerima, seluruh aktivitas klinis, dan pembentukan tagihan selama episode rawat inap tersebut**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                                              |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------|
| Admission     | Pemilik utama: mencatat dan mengelola registrasi rawat inap sebagai persisted business fact keputusan opname pasien               |
| Rawat Inap    | Co-owner operasional: menerima registrasi sebagai trigger antrian masuk bangsal dan penempatan bed oleh unit penerima             |
| Pasien        | Menyediakan identitas pasien yang menjadi subjek registrasi rawat inap                                                            |
| Organisasi    | Menyediakan data bangsal tujuan, kelas kamar, bed, dan DPJP yang menjadi tujuan penempatan rawat inap                            |
| Tata Rekening | Menyediakan jenis jaminan (coverage), kelas tarif, dan deposit yang berlaku untuk episode rawat inap                             |
| BPJS          | Menyediakan validasi kepesertaan BPJS dan surat eligibilitas peserta (SEP) untuk registrasi rawat inap berbasis BPJS              |

---

## 4. Participating Capabilities

| Capability                              | Domain        | Status |
|-----------------------------------------|---------------|--------|
| `ADM-REG` Registration                  | Admission     | Known  |
| `RNA-ANTRIAN` Antrian Masuk Bangsal     | Rawat Inap    | Known  |
| `RNA-BED` Pakai Bed                     | Rawat Inap    | Known  |
| `PAS-DATSOS` Data Sosial Pasien         | Pasien        | Known  |
| `ORG-BANGSAL` Room Bangsal Management   | Organisasi    | Known  |
| `ORG-PPA` Petugas Pemberi Asuhan        | Organisasi    | Known  |
| `ORG-LAYANAN` Unit Layanan              | Organisasi    | Known  |
| `TRK-JAMINAN` Jaminan                  | Tata Rekening | Known  |
| `TRK-TARIF` Tariff                      | Tata Rekening | Known  |
| `TRK-DEPOSIT` Deposit                   | Tata Rekening | Known  |
| `BPJ-VCLAIM` VClaim                     | BPJS          | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Registrasi rawat inap atas nama pasien yang teridentifikasi telah tercatat dalam sistem.
- Registrasi merujuk pada DPJP (dokter penanggung jawab pelayanan) yang valid dan aktif.
- Registrasi merujuk pada bangsal tujuan dan kelas perawatan yang valid.
- Registrasi memiliki jenis jaminan pembayaran yang ditentukan (umum, BPJS, asuransi, atau jaminan lain).
- Registrasi memiliki status aktif: **Terdaftar**.
- Pasien tercatat dalam antrian masuk bangsal (`RNA-ANTRIAN`) di bangsal tujuan, menunggu penempatan bed oleh petugas bangsal penerima.
- Asal registrasi tercatat: dari IGD, dari rawat jalan (rujukan internal), atau langsung dari keputusan dokter.

### 5.2 Required Recorded Information

**Informasi wajib:**

- Nomor registrasi rawat inap yang unik.
- Identitas pasien (Nomor Rekam Medis).
- Tanggal dan waktu registrasi.
- DPJP (dokter penanggung jawab pelayanan) yang ditugaskan.
- Bangsal tujuan dan kelas perawatan yang diminta.
- Jenis jaminan pembayaran yang berlaku.
- Petugas yang melakukan registrasi.
- Asal / sumber kunjungan rawat inap:
  - Dari IGD (referensi ke IGD Visit yang terkait, jika ada)
  - Dari rawat jalan (referensi ke kunjungan rawat jalan yang merujuk)
  - Langsung (direct admission)

**Khusus BPJS:**

- Nomor kartu BPJS / nomor kepesertaan.
- Nomor SEP (Surat Eligibilitas Peserta) untuk tipe Rawat Inap yang telah diterbitkan melalui VClaim.
- Tipe pelayanan BPJS: Rawat Inap Tingkat Lanjut (RITL).

### 5.3 Required Business Conditions

- Pasien yang menjadi subjek registrasi rawat inap harus dapat diidentifikasi melalui Nomor Rekam Medis yang ada, atau pasien baru harus didaftarkan terlebih dahulu sebelum registrasi rawat inap dapat dicatat.
- DPJP harus terdaftar, aktif, dan memiliki kewenangan klinis untuk merawat pasien rawat inap.
- Bangsal tujuan harus aktif dan terdaftar dalam sistem sebagai unit layanan rawat inap yang tersedia.
- Untuk kunjungan BPJS, kepesertaan pasien harus valid pada tanggal registrasi dan SEP untuk Rawat Inap harus berhasil diterbitkan dari sistem VClaim BPJS.
- Satu nomor registrasi rawat inap hanya berlaku untuk satu episode opname.
- Pasien yang sudah memiliki episode rawat inap aktif tidak dapat mendapatkan registrasi rawat inap baru yang tumpang tindih tanpa penyelesaian atau penutupan episode yang sedang berjalan.

### 5.4 Completion Proof

- Nomor registrasi rawat inap yang unik telah diterbitkan.
- Status registrasi adalah **Terdaftar**.
- Pasien tercatat dalam antrian masuk bangsal (`RNA-ANTRIAN`) di bangsal tujuan, menunggu penempatan bed.
- Untuk registrasi BPJS: SEP Rawat Inap telah terbit dan terlampir pada registrasi.
- Registrasi dapat ditemukan berdasarkan nomor registrasi, nomor rekam medis pasien, atau tanggal registrasi.
- Registrasi dapat dijadikan konteks bagi penempatan bed oleh bangsal penerima, pencatatan tindakan klinis, dan pembentukan tagihan rawat inap.

---

## 6. Outcome Boundary

### Start

Dimulai ketika ada keputusan klinis atau administratif bahwa pasien akan menjalani perawatan rawat inap — yaitu saat identitas pasien (Nomor Rekam Medis), DPJP yang bertanggung jawab, bangsal tujuan, kelas perawatan, dan jenis jaminan telah ditentukan dan petugas pendaftaran memulai proses registrasi rawat inap.

Registrasi dapat dimulai dari:
- Unit pendaftaran / Admission, berdasarkan instruksi dokter atau rujukan dari poli rawat jalan.
- Unit IGD, setelah IGD Visit memutuskan bahwa pasien harus dirawat inap.

### End

Berakhir ketika registrasi rawat inap telah berhasil tercatat dengan nomor registrasi unik, status **Terdaftar**, dan pasien telah masuk dalam antrian bangsal tujuan (`RNA-ANTRIAN`).

> Outcome ini berakhir pada titik selesainya registrasi administratif. Penempatan pasien ke bed aktual adalah tanggung jawab Rawat Inap Domain (`RNA-BED`) dan bukan bagian dari Outcome ini.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Pasien harus dapat diidentifikasi (sudah terdaftar atau sedang didaftarkan sebagai pasien baru) sebelum registrasi rawat inap dapat diselesaikan.
- DPJP harus terdaftar aktif dan memiliki kewenangan klinis untuk merawat pasien rawat inap. Registrasi rawat inap tidak boleh dibuat tanpa DPJP yang valid.
- Bangsal tujuan harus aktif dan terdaftar sebagai unit layanan rawat inap yang tersedia di sistem.
- Untuk registrasi BPJS, SEP dengan tipe Rawat Inap harus berhasil diterbitkan dari VClaim sebelum registrasi dianggap lengkap. Registrasi BPJS tanpa SEP tidak dapat diajukan klaim.
- Satu pasien tidak boleh memiliki lebih dari satu episode rawat inap aktif yang tumpang tindih tanpa justifikasi bisnis yang berlaku.
- Nomor registrasi rawat inap bersifat unik dan tidak dapat digunakan ulang.
- Registrasi yang sudah memiliki aktivitas klinis (tindakan, order, penempatan bed, atau tagihan yang terbentuk) tidak dapat dibatalkan tanpa prosedur koreksi yang berlaku.
- Jika registrasi berasal dari IGD Visit, referensi ke IGD Visit tersebut harus dicatat dan IGD Visit harus berstatus **Aktif**.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                              | Expected Behavior                                                                                                                                             |
|----------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pasien tidak dapat diidentifikasi                                                       | Registrasi ditolak. Pasien harus didaftarkan sebagai pasien baru atau identitas yang ada harus ditemukan sebelum registrasi dapat dilanjutkan.                |
| DPJP tidak terdaftar atau tidak aktif dalam sistem                                     | Registrasi ditolak. Informasikan bahwa DPJP yang dipilih tidak dapat digunakan; petugas harus menentukan DPJP yang valid.                                     |
| Bangsal tujuan tidak aktif atau tidak tersedia                                         | Registrasi ditolak. Informasikan bahwa bangsal tujuan tidak tersedia; petugas dapat mengarahkan ke bangsal alternatif.                                        |
| Kepesertaan BPJS tidak aktif atau tidak valid pada tanggal registrasi                  | SEP tidak dapat diterbitkan. Registrasi dapat dilanjutkan dengan jenis jaminan lain (umum) setelah konfirmasi dari pasien.                                   |
| VClaim BPJS tidak dapat diakses (gangguan sistem)                                     | SEP tidak dapat diterbitkan. Registrasi dapat dicatat sementara dengan status menunggu SEP, sesuai prosedur offline BPJS yang berlaku.                       |
| Pasien sudah memiliki episode rawat inap aktif yang belum diselesaikan                 | Registrasi baru ditolak. Petugas diberitahu bahwa episode rawat inap aktif sudah ada dan diminta konfirmasi apakah episode lama harus diselesaikan lebih dahulu. |
| IGD Visit yang menjadi asal registrasi tidak ditemukan atau tidak berstatus Aktif       | Referensi ke IGD Visit tidak dapat dikaitkan. Petugas harus memverifikasi IGD Visit yang benar sebelum registrasi rawat inap dapat diselesaikan.              |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                        | Validates    |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Registrasi yang terdaftar memiliki nomor registrasi unik yang dapat digunakan untuk menemukan registrasi tersebut.                                                               | Completeness |
| AC-02 | Registrasi yang terdaftar merujuk pada pasien, DPJP, bangsal tujuan, kelas perawatan, dan jenis jaminan yang sesuai dengan permintaan.                                           | Correctness  |
| AC-03 | Registrasi yang terdaftar memiliki status **Terdaftar** dan pasien tercatat dalam antrian masuk bangsal tujuan.                                                                  | Completeness |
| AC-04 | Registrasi dapat ditemukan berdasarkan nomor registrasi, nomor rekam medis pasien, DPJP, bangsal tujuan, dan tanggal registrasi.                                                 | Correctness  |
| AC-05 | Registrasi BPJS memiliki nomor SEP Rawat Inap yang valid dan terlampir pada registrasi sebelum registrasi dianggap lengkap.                                                       | Completeness |
| AC-06 | Registrasi yang berasal dari IGD mencatat referensi IGD Visit yang benar dan terhubung dengan IGD Visit tersebut.                                                                | Correctness  |
| AC-07 | Registrasi yang berhasil dibuat dapat dijadikan konteks bagi penempatan bed oleh bangsal penerima, pencatatan tindakan klinis, dan pembentukan tagihan rawat inap.               | Correctness  |
| AC-08 | Registrasi tidak dapat dibuat jika pasien tidak dapat diidentifikasi.                                                                                                            | Constraint   |
| AC-09 | Registrasi tidak dapat dibuat tanpa DPJP yang terdaftar dan aktif dalam sistem.                                                                                                  | Constraint   |
| AC-10 | Registrasi tidak dapat dibuat ke bangsal yang tidak aktif atau tidak tersedia.                                                                                                   | Constraint   |
| AC-11 | Registrasi BPJS tidak dapat diselesaikan tanpa SEP Rawat Inap yang berhasil diterbitkan, kecuali prosedur offline BPJS yang berlaku diterapkan.                                  | Constraint   |
| AC-12 | Registrasi baru tidak dapat dibuat jika pasien sudah memiliki episode rawat inap aktif yang tumpang tindih, tanpa penyelesaian episode sebelumnya.                               | Constraint   |
| AC-13 | Registrasi yang berasal dari IGD hanya dapat dikaitkan dengan IGD Visit yang berstatus **Aktif**.                                                                                | Constraint   |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penempatan pasien ke bed aktual di bangsal penerima → **RNA-BED** (Rawat Inap Domain, `OC-06-02 Pakai Bed`).
- Antrian pasien di dalam bangsal menunggu penempatan bed → **RNA-ANTRIAN** (Rawat Inap Domain).
- IGD Visit dan triage pasien di IGD → **OC-07-01 IGD Visit**, **OC-07-02 Triage**.
- Proses transfer pasien dari IGD ke bangsal rawat inap → **IGD-RANAP** (Gawat Darurat Domain).
- Transfer pasien antar unit rawat inap setelah diopname → **OC-06-03 Transfer Unit** (`RNA-TRANSFER`).
- Proses VCLAIM BPJS secara penuh (verifikasi SEP, e-klaim) → **OC-01-04 VCLAIM BPJS**.
- Pencatatan perjalanan pasien antar layanan selama episode rawat inap → **OC-01-05 Patient Journey Tracking**.
- Tindakan klinis dan pelayanan medis di bangsal rawat inap → **Rawat Inap Domain** (`RNA-*`) dan domain klinis terkait.
- Discharge / pemulangan pasien rawat inap → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Pengelolaan master data pasien dan data sosial → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan master bangsal, kamar, dan bed → **Organisasi Domain** (`ORG-BANGSAL`).
- Pembentukan tagihan rawat inap dan proses pembayaran → **Tata Rekening Domain** (`TRK-BILLING`, `TRK-PAYMENT`).
- Pengelolaan deposit rawat inap → **Tata Rekening Domain** (`TRK-DEPOSIT`), meskipun deposit dapat dikaitkan dengan episode rawat inap ini.
- Dokumentasi rekam medis klinis selama rawat inap → **EMR / domain klinis terkait**.
- Booking / appointment rawat jalan yang mendahului keputusan opname → **OC-01-01 Booking**.
- Registrasi kunjungan rawat jalan atau IGD → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
