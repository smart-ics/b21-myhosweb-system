# OUTCOME: External Registration

| Field       | Value                   |
|-------------|-------------------------|
| Code        | OC-08-01                |
| Version     | 1.0                     |
| Status      | Draft                   |
| LastUpdated | 2026-10-05              |

---

## 1. Business Purpose

Unit laboratorium rumah sakit menerima pasien yang datang langsung tanpa melalui proses registrasi admisi rumah sakit. Pasien-pasien ini harus tetap memiliki konteks kunjungan yang sah agar pelayanan laboratorium dapat dilakukan secara terstruktur, terlacak, dan dapat ditagih dengan benar.

OC-08-01 bertanggung jawab atas pembentukan konteks kunjungan (*Visit/Encounter*) secara mandiri di lingkungan unit laboratorium — memastikan bahwa setiap pasien yang datang langsung ke laboratorium tercatat dengan identitas yang valid, sumber kedatangan yang jelas (*Registration Source*), dan memiliki konteks Visit/Encounter yang siap menjadi landasan bagi proses pelayanan laboratorium berikutnya.

---

## 2. Outcome Statement

Visit/Encounter untuk pasien yang datang langsung ke unit laboratorium **telah tercatat sebagai kunjungan aktif yang diakui sistem, siap menjadi konteks pelayanan laboratorium untuk proses Order Laboratorium dan seluruh aktivitas laboratorium selama episode kunjungan tersebut**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                      |
|---------------|-----------------------------------------------------------------------------------------------------------|
| Laboratory    | Pemilik utama outcome: mencatat dan mengelola External Registration serta Visit/Encounter yang terbentuk. |
| Pasien        | Menyediakan identitas pasien (baik pasien baru maupun pasien existing) yang menjadi subjek kunjungan.     |
| Admission     | Menyediakan kapabilitas registrasi yang diadaptasi untuk konteks laboratorium eksternal.                   |
| Organisasi    | Menyediakan identitas petugas yang melakukan External Registration.                                       |

---

## 4. Participating Capabilities

| Capability                          | Domain     | Status                      |
|-------------------------------------|------------|-----------------------------|
| `LAB-EXT-REG` External Registration | Laboratory | Capability Candidate        |
| `PAS-DATSOS` Data Sosial Pasien     | Pasien     | Known                       |
| `ADM-REG` Registration              | Admission  | Known                       |
| `ORG-USER` User & Petugas           | Organisasi | Known                       |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

> **Catatan:** `LAB-EXT-REG` adalah Capability Candidate karena merupakan kapabilitas baru yang spesifik untuk alur laboratorium eksternal. Perlu konfirmasi dari Product Owner bahwa kapabilitas ini masuk dalam scope domain Laboratory.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Visit/Encounter atas nama pasien yang teridentifikasi telah tercatat dalam sistem.
- Visit/Encounter dihasilkan dari External Registration — bukan dari proses admisi rumah sakit.
- External Registration memiliki atribut **`RegistrationSource`** yang tercatat dan menunjukkan konteks/sumber kedatangan pasien.
- Visit/Encounter berstatus aktif dan siap digunakan sebagai konteks pelayanan laboratorium.
- Satu External Registration selalu menghasilkan tepat **satu** Visit/Encounter.
- Satu Visit/Encounter dari External Registration dapat memiliki **maksimal satu** Lab Order (0..1); namun Lab Order tidak wajib tersedia pada saat External Registration dibuat.

### 5.2 Required Recorded Information

- Identitas pasien (Nomor Rekam Medis untuk pasien existing; data pendaftaran untuk pasien baru).
- Nilai `RegistrationSource` yang valid (minimal: `ExternalReferral` atau `ExistingLabOrder`).
- Nomor Visit/Encounter yang unik.
- Tanggal dan waktu External Registration dibuat.
- Identitas petugas yang melakukan External Registration.

### 5.3 Required Business Conditions

- Pasien yang menjadi subjek kunjungan harus dapat diidentifikasi:
  - Jika pasien existing: Nomor Rekam Medis harus valid dan ditemukan dalam sistem.
  - Jika pasien baru: data sosial pasien minimal harus dicatat terlebih dahulu sehingga identitas terbentuk sebelum Visit/Encounter dapat dibuat.
- Nilai `RegistrationSource` harus terisi dengan nilai yang diakui sistem; External Registration tidak dapat terbentuk tanpa `RegistrationSource` yang valid.
- Petugas yang melakukan External Registration harus merupakan pengguna terautentikasi dengan hak akses ke menu laboratorium.
- External Registration tidak mensyaratkan keberadaan Lab Order pada saat registrasi dilakukan.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Nomor Visit/Encounter yang unik telah diterbitkan dan tercatat dalam sistem.
- Visit/Encounter merujuk pada identitas pasien yang valid dan nilai `RegistrationSource` yang sah.
- Visit/Encounter berstatus aktif dan dapat digunakan sebagai konteks bagi proses Order Laboratorium (OC-08-02).
- External Registration dapat ditemukan berdasarkan nomor Visit/Encounter, identitas pasien, atau tanggal registrasi.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas laboratorium memulai proses External Registration untuk pasien yang datang langsung ke unit laboratorium — yaitu ketika identitas pasien (Nomor Rekam Medis untuk pasien existing, atau data pasien baru) dan nilai `RegistrationSource` telah dinyatakan dan dikonfirmasi.

### End

Berakhir ketika Visit/Encounter berhasil tercatat dalam sistem dengan nomor yang unik dan status aktif — yaitu business result utama dari Outcome ini.

> **Batas Tanggung Jawab:** Setelah Visit/Encounter terbentuk, proses pembuatan Lab Order merupakan tanggung jawab **OC-08-02 Order Laboratorium**. OC-08-01 tidak mengelola detail Lab Order, pencatatan tindakan, pengambilan spesimen, pemrosesan, maupun hasil pemeriksaan.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Selalu Membuat Visit/Encounter Baru**: Setiap External Registration wajib menghasilkan Visit/Encounter baru. External Registration tidak dapat menggunakan atau meneruskan Visit/Encounter yang sudah ada dari registrasi lain.
- **Satu Jenis Registrasi**: External Registration adalah satu jenis registrasi tunggal, bukan kumpulan jenis-jenis registrasi. Variasi konteks kedatangan dibedakan melalui atribut `RegistrationSource`, bukan melalui pemisahan jenis registrasi.
- **RegistrationSource Wajib**: Setiap External Registration wajib memiliki nilai `RegistrationSource` yang valid. Nilai minimal yang diakui adalah `ExternalReferral` dan `ExistingLabOrder`. External Registration tidak dapat terbentuk tanpa `RegistrationSource`.
- **Identitas Pasien Wajib**: Visit/Encounter tidak dapat terbentuk tanpa identitas pasien yang valid, baik pasien baru maupun pasien existing.
- **Pasien Baru dan Existing Didukung**: External Registration dapat melayani pasien baru (yang belum terdaftar di sistem) maupun pasien existing (yang sudah memiliki Nomor Rekam Medis). Tidak ada batasan bahwa External Registration hanya untuk salah satu jenis pasien.
- **Lab Order Opsional Saat Registrasi**: Keberadaan Lab Order bukan syarat pembentukan External Registration. Visit/Encounter dapat terbentuk meskipun Lab Order belum ada.
- **Kardinalitas Visit/Encounter ↔ Lab Order**: Satu Visit/Encounter dari External Registration dapat memiliki maksimal satu Lab Order (relasi 0..1). Visit/Encounter tidak dapat dikaitkan dengan lebih dari satu Lab Order dalam konteks OC-08-01.
- **Scope Terbatas pada Registrasi**: OC-08-01 hanya bertanggung jawab atas pembentukan External Registration dan Visit/Encounter. Seluruh aktivitas setelah Visit/Encounter terbentuk — termasuk pembuatan Lab Order, pengambilan spesimen, pemrosesan, dan hasil — berada di luar boundary OC-08-01.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                 | Expected Behavior                                                                                                               |
|---------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| Pasien existing tidak dapat ditemukan berdasarkan identitas yang diberikan | External Registration ditolak. Pasien harus dapat diidentifikasi atau didaftarkan sebagai pasien baru sebelum registrasi dibuat. |
| `RegistrationSource` tidak diisi atau bernilai tidak valid                | External Registration ditolak. Nilai `RegistrationSource` wajib ada dan harus bernilai yang diakui sistem.                      |
| Petugas tidak memiliki hak akses ke menu laboratorium                     | External Registration ditolak. Hanya pengguna terautentikasi dengan hak akses laboratorium yang dapat membuat External Registration. |
| Pasien baru tidak memiliki data minimal yang cukup untuk membentuk identitas | External Registration ditolak. Identitas pasien baru harus terbentuk terlebih dahulu sebelum Visit/Encounter dapat dibuat.     |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                      | Validates    |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | External Registration yang dikonfirmasi menghasilkan tepat satu Visit/Encounter baru dengan nomor yang unik.                                                   | Completeness |
| AC-02 | Visit/Encounter yang terbentuk merujuk pada identitas pasien yang valid dan nilai `RegistrationSource` yang sah.                                                | Correctness  |
| AC-03 | External Registration berhasil dibuat untuk pasien baru (yang belum memiliki Nomor Rekam Medis) maupun pasien existing.                                        | Correctness  |
| AC-04 | Visit/Encounter yang terbentuk berstatus aktif dan dapat digunakan sebagai konteks bagi proses Order Laboratorium (OC-08-02).                                   | Completeness |
| AC-05 | External Registration berhasil terbentuk meskipun Lab Order belum ada pada saat registrasi dilakukan.                                                          | Correctness  |
| AC-06 | External Registration ditolak apabila `RegistrationSource` tidak diisi atau bernilai tidak valid.                                                              | Constraint   |
| AC-07 | External Registration ditolak apabila identitas pasien tidak dapat diverifikasi atau tidak dapat dibentuk.                                                     | Constraint   |
| AC-08 | Satu Visit/Encounter dari External Registration tidak dapat dikaitkan dengan lebih dari satu Lab Order.                                                        | Constraint   |
| AC-09 | External Registration dapat ditemukan berdasarkan nomor Visit/Encounter, identitas pasien, atau tanggal registrasi.                                            | Correctness  |
| AC-10 | Petugas yang tidak memiliki hak akses ke menu laboratorium tidak dapat membuat External Registration.                                                          | Constraint   |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembuatan dan pengelolaan Lab Order → **OC-08-02 Order Laboratorium**.
- Pembebanan biaya (*charging*) pemeriksaan laboratorium → **OC-08-03 Charge**.
- Pengambilan dan pengelolaan spesimen → **OC-08-04 Sample Collection**.
- Pemrosesan, pencatatan hasil, verifikasi, dan rilis hasil pemeriksaan → **OC-08-05 Result Management**.
- Registrasi rawat jalan dan IGD melalui jalur admisi rumah sakit → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Registrasi rawat inap → **OC-01-03 Registrasi Rawat Inap**.
- Pengelolaan identitas dan data sosial pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan master tarif laboratorium → **Tata Rekening Domain** (`TRK-TARIF`).
- Pemakaian barang/reagen oleh unit laboratorium → **OC-08-06 Pakai Barang**.
- Mutasi barang/reagen antar unit → **OC-08-07 Mutasi Barang**.
- Stok opname di unit laboratorium → **OC-08-08 Opname**.

---

## 11. Relasi: External Registration → Visit/Encounter → Lab Order

```
External Registration (OC-08-01)
        │
        │ selalu menghasilkan
        │ (1:1)
        ▼
  Visit/Encounter
   [status: Aktif]
        │
        │ dapat memiliki (0..1)
        │ tidak wajib saat registrasi
        ▼
    Lab Order
  (OC-08-02)
```

**Penjelasan relasi:**

| Relasi                                     | Kardinalitas | Keterangan                                                                                               |
|--------------------------------------------|:------------:|----------------------------------------------------------------------------------------------------------|
| External Registration → Visit/Encounter    | 1 : 1        | Setiap External Registration selalu menghasilkan tepat satu Visit/Encounter baru.                        |
| Visit/Encounter → Lab Order                | 0..1         | Satu Visit/Encounter dapat memiliki nol atau satu Lab Order. Lab Order tidak wajib ada saat registrasi.  |
| Visit/Encounter → Aktivitas Lab lainnya    | di luar scope | Proses selanjutnya (Charge, Sample Collection, Result) menggunakan Visit/Encounter sebagai konteks.     |

---

## 12. Business Decisions & Open Questions

> Keputusan bisnis yang telah dikonfirmasi dan status pertanyaan terbuka.

### Confirmed Decisions

1. **External Registration Selalu Membuat Visit/Encounter Baru**: Setiap External Registration menghasilkan satu Visit/Encounter baru; tidak ada mekanisme untuk meneruskan atau menggunakan Visit/Encounter yang sudah ada.
2. **Pasien Baru dan Existing Didukung**: External Registration tidak dibatasi hanya untuk pasien baru atau pasien existing; keduanya didukung.
3. **Satu Jenis Registrasi**: External Registration adalah satu jenis registrasi tunggal. Variasi konteks dibedakan melalui `RegistrationSource`.
4. **RegistrationSource Wajib**: Atribut `RegistrationSource` wajib ada pada setiap External Registration untuk menunjukkan konteks/sumber kedatangan pasien.
5. **Nilai RegistrationSource Minimal**: `ExternalReferral` (datang berdasarkan permintaan pemeriksaan dari faskes lain) dan `ExistingLabOrder` (datang untuk merealisasikan Lab Order dari kunjungan sebelumnya).
6. **Lab Order Tidak Wajib Saat Registrasi**: External Registration dapat diselesaikan tanpa keberadaan Lab Order.
7. **Kardinalitas 1 Visit/Encounter per External Registration**: Satu External Registration → satu Visit/Encounter.
8. **Kardinalitas 0..1 Lab Order per Visit/Encounter**: Satu Visit/Encounter dari External Registration dapat memiliki maksimal satu Lab Order.
9. **Visit/Encounter Sebagai Konteks Pelayanan**: Visit/Encounter yang terbentuk menjadi konteks bagi seluruh aktivitas laboratorium pada episode kunjungan tersebut.
10. **Scope Terbatas pada Registrasi**: Detail proses Lab Order adalah tanggung jawab OC-08-02; OC-08-01 hanya bertanggung jawab hingga Visit/Encounter terbentuk.

### Open Questions

| # | Pertanyaan | Dampak Bisnis |
|---|------------|---------------|
| OQ-01 | Apakah nilai `RegistrationSource` bersifat extensible (dapat ditambah di masa mendatang) atau fixed/closed? Jika extensible, siapa yang berwenang menambah nilai baru? | Menentukan apakah `RegistrationSource` perlu dikelola sebagai master data atau sebagai enum tetap. |
| OQ-02 | Apakah satu Visit/Encounter dari External Registration dapat digunakan sebagai konteks untuk tindakan laboratorium lain selain Lab Order (misal: tindakan non-order)? | Menentukan apakah kardinalitas 0..1 Lab Order cukup menggambarkan seluruh aktivitas yang dapat terjadi dalam satu Visit/Encounter. |
| OQ-03 | Bagaimana penanganan jika pasien datang dengan `RegistrationSource = ExistingLabOrder` tetapi Lab Order yang direferensikan tidak ditemukan atau sudah tidak valid? Apakah External Registration tetap dapat dibuat? | Menentukan apakah validasi Lab Order yang direferensikan menjadi bagian dari business rule OC-08-01 atau diserahkan ke OC-08-02. |
| OQ-04 | Apakah External Registration mendukung jenis jaminan pembayaran (misalnya: umum, BPJS, asuransi)? Jika ya, apakah jenis jaminan menjadi bagian dari data yang wajib dicatat pada saat External Registration? | Menentukan keterlibatan domain Tata Rekening dan apakah `TRK-JAMINAN` perlu menjadi Participating Capability. |
