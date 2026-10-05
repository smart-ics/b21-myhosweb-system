# OUTCOME: External Registration

| Field       | Value                   |
|-------------|-------------------------|
| Code        | OC-08-01                |
| Version     | 2.0                     |
| Status      | Draft                   |
| LastUpdated | 2026-10-05              |

---

## 1. Business Purpose

Unit laboratorium rumah sakit menerima pasien yang datang langsung tanpa melalui proses registrasi rawat jalan atau IGD reguler. Pasien-pasien ini harus memiliki konteks kunjungan yang sah dan permintaan pemeriksaan laboratorium yang terdokumentasi agar seluruh pelayanan laboratorium dapat dilakukan secara terstruktur, terlacak, dan dapat dipertanggungjawabkan.

OC-08-01 bertanggung jawab atas pembentukan External Registration yang selalu menghasilkan satu Visit/Encounter baru — serta memastikan bahwa tepat satu Lab Order tersedia pada akhir proses registrasi, baik melalui pembuatan Lab Order baru maupun penggunaan Lab Order existing yang memenuhi syarat. Visit/Encounter inilah yang menjadi konteks resmi bagi seluruh pelayanan laboratorium yang menyusul.

---

## 2. Outcome Statement

External Registration untuk pasien yang datang langsung ke unit laboratorium **telah berhasil terbentuk: satu Visit/Encounter baru tercatat sebagai kunjungan aktif, dan tepat satu Lab Order tersedia dan terhubung pada Visit/Encounter tersebut — siap menjadi konteks pelayanan laboratorium untuk proses berikutnya**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                                          |
|---------------|-------------------------------------------------------------------------------------------------------------------------------|
| Laboratory    | Pemilik utama outcome: mencatat dan mengelola External Registration, Visit/Encounter, serta keterhubungan dengan Lab Order.   |
| Pasien        | Menyediakan identitas pasien (pasien baru maupun existing) yang menjadi subjek kunjungan.                                     |
| Admission     | Menyediakan kapabilitas registrasi kunjungan yang diadaptasi untuk konteks laboratorium eksternal.                            |
| Organisasi    | Menyediakan identitas petugas yang melakukan External Registration.                                                           |

---

## 4. Participating Capabilities

| Capability                          | Domain     | Status               |
|-------------------------------------|------------|----------------------|
| `LAB-EXT-REG` External Registration | Laboratory | Capability Candidate |
| `LAB-ORDER` Order Lab               | Laboratory | Known                |
| `PAS-DATSOS` Data Sosial Pasien     | Pasien     | Known                |
| `ADM-REG` Registration              | Admission  | Known                |
| `ORG-USER` User & Petugas           | Organisasi | Known                |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

> **Catatan:** `LAB-EXT-REG` adalah Capability Candidate — kapabilitas baru yang spesifik untuk alur laboratorium eksternal. Perlu konfirmasi Product Owner bahwa kapabilitas ini masuk dalam scope domain Laboratory. `LAB-ORDER` diikutsertakan karena OC-08-01 mensyaratkan keberadaan Lab Order sebagai hasil akhir registrasi, meskipun detail Lab Order dikelola oleh OC-08-02.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- External Registration telah tercatat dalam sistem.
- External Registration memiliki atribut **`RegistrationSource`** yang tercatat, dengan nilai yang diakui sistem: `ExternalReferral`, `ExistingLabOrder`, atau `SelfRequested`.
- Tepat **satu** Visit/Encounter baru telah terbentuk sebagai hasil dari External Registration.
- Visit/Encounter berstatus aktif, merujuk pada identitas pasien yang valid.
- Tepat **satu** Lab Order tersedia dan terhubung pada Visit/Encounter tersebut:
  - Untuk `ExternalReferral` dan `SelfRequested`: satu Lab Order baru telah dibuat, dengan item pemeriksaan yang ditentukan oleh petugas laboratorium.
  - Untuk `ExistingLabOrder`: satu Lab Order existing yang memenuhi syarat eligibilitas telah dihubungkan ke Visit/Encounter.
- External Registration dianggap berhasil **hanya apabila** Visit/Encounter dan Lab Order keduanya berhasil terbentuk/terhubung.

### 5.2 Required Recorded Information

- Identitas pasien (Nomor Rekam Medis untuk pasien existing; data minimal pasien baru apabila pasien belum terdaftar).
- Nilai `RegistrationSource` yang valid (`ExternalReferral`, `ExistingLabOrder`, atau `SelfRequested`).
- Nomor Visit/Encounter yang unik.
- Tanggal dan waktu External Registration dibuat.
- Identitas petugas yang melakukan External Registration.
- Referensi ke Lab Order yang terhubung (Lab Order baru atau Lab Order existing yang dipilih).
- Payer yang berlaku:
  - `ExistingLabOrder`: Payer mengikuti Lab Order / kunjungan sebelumnya.
  - `ExternalReferral` dan `SelfRequested`: Payer default = **Umum**.

### 5.3 Required Business Conditions

- Pasien harus dapat diidentifikasi sebelum External Registration dapat diselesaikan:
  - Pasien existing: Nomor Rekam Medis harus valid dan ditemukan dalam sistem.
  - Pasien baru: data minimal pasien harus dicatat terlebih dahulu sehingga identitas terbentuk.
- Nilai `RegistrationSource` wajib terisi dengan salah satu dari nilai yang diakui sistem; External Registration tidak dapat terbentuk tanpa `RegistrationSource` yang valid.
- Petugas yang melakukan External Registration harus merupakan pengguna terautentikasi dengan hak akses ke menu laboratorium.
- **Untuk `ExistingLabOrder`**, Lab Order existing yang akan dihubungkan harus memenuhi seluruh syarat eligibilitas berikut secara bersamaan:
  - Lab Order masih aktif.
  - Lab Order belum terealisasi.
  - Lab Order tidak sedang memiliki External Registration yang aktif (tidak ada External Registration aktif lain yang sudah menghubungkan diri ke Lab Order tersebut).
- Sumber kebenaran eligibilitas Lab Order existing ditentukan melalui **relationship/inquiry External Registration → Lab Order**, bukan melalui flag khusus pada Lab Order.
- Apabila Lab Order gagal dibuat (untuk `ExternalReferral` / `SelfRequested`) atau Lab Order existing tidak memenuhi syarat eligibilitas (untuk `ExistingLabOrder`), External Registration **tidak boleh** dianggap berhasil.
- Apabila proses gagal setelah Visit/Encounter terbentuk namun sebelum Lab Order berhasil dihubungkan, sistem harus menerapkan prinsip **business rollback/cancel** — menghindari kondisi External Registration atau Visit/Encounter terbentuk tanpa Lab Order yang terhubung. Hard delete dihindari apabila domain membutuhkan audit trail.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Nomor Visit/Encounter yang unik telah diterbitkan dan tercatat dalam sistem dengan status aktif.
- External Registration merujuk pada identitas pasien yang valid dan nilai `RegistrationSource` yang sah.
- Tepat satu Lab Order tersedia dan terhubung pada Visit/Encounter.
- Payer yang berlaku telah tercatat sesuai aturan `RegistrationSource`.
- External Registration dan Visit/Encounter dapat ditemukan berdasarkan nomor Visit/Encounter, identitas pasien, atau tanggal registrasi.
- Visit/Encounter dapat dijadikan konteks bagi proses Order Laboratorium berikutnya (OC-08-02).

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas laboratorium memulai proses External Registration untuk pasien yang datang langsung ke unit laboratorium — yaitu ketika identitas pasien dan nilai `RegistrationSource` telah dinyatakan dan dikonfirmasi.

### End

Berakhir ketika seluruh kondisi berikut terpenuhi secara atomik:
1. Visit/Encounter baru berhasil tercatat dalam sistem dengan nomor unik dan status aktif; **dan**
2. Tepat satu Lab Order berhasil terbentuk (baru) atau terhubung (existing) pada Visit/Encounter tersebut.

Apabila salah satu kondisi di atas tidak terpenuhi, External Registration dianggap gagal dan sistem menerapkan business rollback/cancel.

> **Batas Tanggung Jawab OC-08-01:** OC-08-01 memastikan bahwa tepat satu Lab Order tersedia sebagai hasil akhir registrasi. Detail Lab Order — termasuk pengelolaan item pemeriksaan, status, edit, pembatalan, dan seluruh lifecycle Lab Order — merupakan tanggung jawab **OC-08-02 Order Laboratorium**.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Selalu Membuat Visit/Encounter Baru**: Setiap External Registration wajib menghasilkan tepat satu Visit/Encounter baru. External Registration tidak dapat menggunakan atau meneruskan Visit/Encounter yang sudah ada.
- **Satu Jenis Registrasi**: External Registration adalah satu jenis registrasi tunggal. Variasi konteks kedatangan dibedakan melalui atribut `RegistrationSource`, bukan melalui pemisahan jenis registrasi.
- **RegistrationSource Wajib dan Closed**: Setiap External Registration wajib memiliki nilai `RegistrationSource` yang valid. Nilai yang diakui sistem adalah `ExternalReferral`, `ExistingLabOrder`, dan `SelfRequested` (fixed/closed list). External Registration tidak dapat terbentuk tanpa `RegistrationSource` yang valid.
- **Identitas Pasien Wajib**: Visit/Encounter tidak dapat terbentuk tanpa identitas pasien yang valid, baik pasien baru maupun pasien existing.
- **Pasien Baru dan Existing Didukung**: External Registration dapat melayani pasien baru maupun pasien existing.
- **Lab Order Wajib Tersedia di Akhir Registrasi**: External Registration tidak dianggap selesai sebelum tepat satu Lab Order tersedia dan terhubung pada Visit/Encounter. Kardinalitas akhir yang disyaratkan adalah **1 : 1 : 1** (External Registration : Visit/Encounter : Lab Order).
- **Lab Order untuk ExternalReferral dan SelfRequested**: Lab Order baru dibuat dan item pemeriksaan ditentukan oleh petugas laboratorium. Detail item adalah tanggung jawab OC-08-02.
- **Eligibilitas Lab Order untuk ExistingLabOrder**: Lab Order existing hanya dapat digunakan apabila masih aktif, belum terealisasi, dan tidak memiliki External Registration aktif lain. Sumber kebenaran eligibilitas adalah relationship External Registration → Lab Order, bukan flag pada Lab Order.
- **Satu Lab Order Maksimal Satu External Registration Aktif**: Satu Lab Order hanya boleh memiliki satu External Registration aktif pada satu waktu. Apabila External Registration sebelumnya telah dibatalkan (cancelled), Lab Order dapat kembali eligible apabila seluruh syarat eligibilitas lain terpenuhi.
- **Payer Ditentukan oleh RegistrationSource**: Payer tidak perlu menjadi input manual wajib pada External Registration. Untuk `ExistingLabOrder`, Payer mengikuti Lab Order / kunjungan sebelumnya. Untuk `ExternalReferral` dan `SelfRequested`, Payer default = Umum.
- **Atomisitas Registrasi**: External Registration hanya dianggap berhasil apabila Visit/Encounter dan Lab Order keduanya berhasil terbentuk/terhubung. Kegagalan pada salah satu komponen menghasilkan business rollback/cancel pada seluruh proses registrasi.
- **Scope Terbatas pada Registrasi**: OC-08-01 bertanggung jawab atas External Registration, pembentukan Visit/Encounter, dan keterhubungan dengan Lab Order. Detail Lab Order, lifecycle Lab Order, item pemeriksaan, pengambilan spesimen, pemrosesan, dan hasil pemeriksaan berada di luar boundary OC-08-01.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                                      | Expected Behavior                                                                                                                                                          |
|------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pasien existing tidak dapat ditemukan berdasarkan identitas yang diberikan                     | External Registration ditolak. Pasien harus dapat diidentifikasi atau didaftarkan sebagai pasien baru sebelum registrasi dapat dilanjutkan.                                |
| Pasien baru tidak memiliki data minimal yang cukup untuk membentuk identitas                   | External Registration ditolak. Identitas pasien baru harus terbentuk terlebih dahulu sebelum Visit/Encounter dapat dibuat.                                                 |
| `RegistrationSource` tidak diisi atau bernilai di luar daftar yang diakui sistem               | External Registration ditolak. Nilai `RegistrationSource` wajib ada dan harus merupakan salah satu dari: `ExternalReferral`, `ExistingLabOrder`, `SelfRequested`.          |
| Petugas tidak memiliki hak akses ke menu laboratorium                                          | External Registration ditolak. Hanya pengguna terautentikasi dengan hak akses laboratorium yang dapat membuat External Registration.                                       |
| Untuk `ExternalReferral` / `SelfRequested`: Lab Order baru gagal dibuat                        | External Registration dianggap gagal. Sistem menerapkan business rollback/cancel; Visit/Encounter yang mungkin sudah terbentuk tidak dibiarkan dalam kondisi tanpa Lab Order. |
| Untuk `ExistingLabOrder`: Lab Order yang dipilih tidak aktif atau sudah terealisasi             | External Registration ditolak. Lab Order yang tidak memenuhi syarat eligibilitas tidak dapat digunakan.                                                                    |
| Untuk `ExistingLabOrder`: Lab Order yang dipilih sudah memiliki External Registration aktif lain | External Registration ditolak. Satu Lab Order hanya boleh memiliki satu External Registration aktif pada satu waktu.                                                      |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                                     | Validates    |
|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | External Registration yang dikonfirmasi menghasilkan tepat satu Visit/Encounter baru dengan nomor yang unik dan status aktif.                                                                  | Completeness |
| AC-02 | Tepat satu Lab Order tersedia dan terhubung pada Visit/Encounter; External Registration tidak dianggap selesai tanpa Lab Order yang terhubung.                                                 | Completeness |
| AC-03 | Visit/Encounter yang terbentuk merujuk pada identitas pasien yang valid dan nilai `RegistrationSource` yang sah (`ExternalReferral`, `ExistingLabOrder`, atau `SelfRequested`).                | Correctness  |
| AC-04 | External Registration berhasil dibuat untuk pasien baru (yang belum memiliki Nomor Rekam Medis) maupun pasien existing.                                                                       | Correctness  |
| AC-05 | Untuk `ExternalReferral` dan `SelfRequested`: Lab Order baru terbentuk dan terhubung pada Visit/Encounter; item pemeriksaan dicatat oleh petugas laboratorium.                                | Correctness  |
| AC-06 | Untuk `ExistingLabOrder`: Lab Order existing yang memenuhi syarat eligibilitas berhasil dihubungkan ke Visit/Encounter baru.                                                                   | Correctness  |
| AC-07 | Untuk `ExistingLabOrder`: Lab Order yang tidak aktif, sudah terealisasi, atau sudah memiliki External Registration aktif lain tidak dapat digunakan; External Registration ditolak.           | Constraint   |
| AC-08 | Satu Lab Order hanya dapat dihubungkan ke satu External Registration aktif pada satu waktu. Apabila External Registration sebelumnya dibatalkan, Lab Order dapat kembali eligible.            | Constraint   |
| AC-09 | Payer yang berlaku tercatat sesuai aturan `RegistrationSource`: Umum untuk `ExternalReferral` dan `SelfRequested`; mengikuti Lab Order / kunjungan sebelumnya untuk `ExistingLabOrder`.       | Correctness  |
| AC-10 | Apabila Lab Order gagal dibuat atau dihubungkan, External Registration tidak dianggap berhasil dan sistem menerapkan business rollback/cancel; tidak ada Visit/Encounter tanpa Lab Order.     | Constraint   |
| AC-11 | External Registration ditolak apabila `RegistrationSource` tidak diisi atau bernilai di luar daftar yang diakui sistem.                                                                       | Constraint   |
| AC-12 | External Registration ditolak apabila identitas pasien tidak dapat diverifikasi atau tidak dapat dibentuk.                                                                                    | Constraint   |
| AC-13 | External Registration dan Visit/Encounter dapat ditemukan berdasarkan nomor Visit/Encounter, identitas pasien, atau tanggal registrasi.                                                       | Correctness  |
| AC-14 | Petugas yang tidak memiliki hak akses ke menu laboratorium tidak dapat membuat External Registration.                                                                                         | Constraint   |

---

## 10. Cancellation Behavior

> Perilaku sistem apabila External Registration dibatalkan setelah berhasil terbentuk.

| RegistrationSource   | Perilaku Cancellation                                                                                                       |
|----------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `ExternalReferral`   | External Registration dibatalkan **dan** Lab Order baru yang dibuat untuk registrasi ini ikut dibatalkan.                   |
| `SelfRequested`      | External Registration dibatalkan **dan** Lab Order baru yang dibuat untuk registrasi ini ikut dibatalkan.                   |
| `ExistingLabOrder`   | External Registration dibatalkan; **Lab Order existing tidak dicancel** dan tetap aktif, kembali eligible untuk digunakan apabila seluruh syarat eligibilitas terpenuhi. |

> **Catatan:** Cancellation Lab Order yang dihasilkan dari `ExternalReferral` / `SelfRequested` mengikuti semantik cancellation Lab Order yang berlaku di OC-08-02.

---

## 11. Out of Scope

> What this Outcome explicitly does NOT cover.

- Detail pembuatan, pengelolaan item, status, edit, dan lifecycle Lab Order → **OC-08-02 Order Laboratorium**.
- Pembebanan biaya (*charging*) pemeriksaan laboratorium → **OC-08-03 Charge**.
- Pengambilan dan pengelolaan spesimen → **OC-08-04 Sample Collection**.
- Pemrosesan, pencatatan hasil, verifikasi, dan rilis hasil pemeriksaan → **OC-08-05 Result Management**.
- Registrasi rawat jalan dan IGD melalui jalur admisi rumah sakit → **OC-01-02 Registrasi Rawat Jalan dan IGD**.
- Registrasi rawat inap → **OC-01-03 Registrasi Rawat Inap**.
- Pengelolaan identitas dan data sosial pasien → **Pasien Domain** (`PAS-DATSOS`).
- Penentuan formula tarif dan besaran tarif pemeriksaan → **Tata Rekening Domain** (`TRK-TARIF`).
- Pemakaian barang/reagen oleh unit laboratorium → **OC-08-06 Pakai Barang**.
- Mutasi barang/reagen antar unit → **OC-08-07 Mutasi Barang**.
- Stok opname di unit laboratorium → **OC-08-08 Opname**.

---

## 12. Relasi: External Registration → Visit/Encounter → Lab Order

```
External Registration (OC-08-01)
        │
        │ selalu menghasilkan (1:1)
        ▼
  Visit/Encounter
   [status: Aktif]
        │
        │ wajib memiliki tepat satu (1:1)
        │
        ├─── ExternalReferral / SelfRequested ──► Lab Order BARU
        │                                         (item ditentukan petugas lab)
        │
        └─── ExistingLabOrder ──────────────────► Lab Order EXISTING
                                                  (eligible: aktif, belum terealisasi,
                                                   tidak ada Ext.Reg aktif lain)
```

**Penjelasan relasi:**

| Relasi                                              | Kardinalitas | Keterangan                                                                                                           |
|-----------------------------------------------------|:------------:|----------------------------------------------------------------------------------------------------------------------|
| External Registration → Visit/Encounter             | 1 : 1        | Setiap External Registration selalu menghasilkan tepat satu Visit/Encounter baru.                                    |
| External Registration → Lab Order                   | 1 : 1        | External Registration tidak dianggap selesai tanpa tepat satu Lab Order yang terhubung.                              |
| Visit/Encounter → Lab Order                         | 1 : 1        | Satu Visit/Encounter dari External Registration memiliki tepat satu Lab Order.                                       |
| Lab Order → External Registration aktif             | 0..1         | Satu Lab Order hanya boleh memiliki satu External Registration aktif pada satu waktu.                                |

---

## 13. Business Decisions & Open Questions

> Keputusan bisnis yang telah dikonfirmasi dan status pertanyaan terbuka.

### Confirmed Decisions

1. **External Registration Selalu Membuat Visit/Encounter Baru**: Setiap External Registration menghasilkan satu Visit/Encounter baru; tidak ada mekanisme untuk meneruskan atau menggunakan Visit/Encounter yang sudah ada.
2. **Pasien Baru dan Existing Didukung**: External Registration dapat melayani pasien baru maupun pasien existing.
3. **Satu Jenis Registrasi**: External Registration adalah satu jenis registrasi tunggal. Variasi konteks dibedakan melalui `RegistrationSource`.
4. **RegistrationSource Wajib dan Closed**: Atribut `RegistrationSource` wajib ada. Nilai yang diakui adalah `ExternalReferral`, `ExistingLabOrder`, dan `SelfRequested` (fixed/closed list).
5. **Lab Order Wajib di Akhir Registrasi**: External Registration tidak dianggap selesai sebelum tepat satu Lab Order terbentuk atau terhubung. Kardinalitas final: External Registration (1) → Visit/Encounter (1) → Lab Order (1).
6. **Lab Order untuk ExternalReferral dan SelfRequested**: Lab Order baru dibuat; item pemeriksaan ditentukan oleh petugas laboratorium; detail dikelola OC-08-02.
7. **Eligibilitas Lab Order untuk ExistingLabOrder**: Lab Order existing harus aktif, belum terealisasi, dan tidak memiliki External Registration aktif lain. Sumber kebenaran adalah relationship External Registration → Lab Order, bukan flag pada Lab Order.
8. **Satu Lab Order Maksimal Satu External Registration Aktif**: Constraint yang berlaku pada Lab Order existing. Apabila External Registration sebelumnya dibatalkan, Lab Order dapat kembali eligible.
9. **Payer**: `ExistingLabOrder` mengikuti Payer Lab Order / kunjungan sebelumnya. `ExternalReferral` dan `SelfRequested` default Payer = Umum. Payer bukan input manual wajib.
10. **Cancellation ExternalReferral / SelfRequested**: Cancel External Registration → cancel Lab Order baru yang dibuat untuk registrasi ini.
11. **Cancellation ExistingLabOrder**: Cancel External Registration → hanya cancel External Registration; Lab Order existing tetap aktif.
12. **Atomisitas dan Failure Handling**: External Registration hanya berhasil apabila Visit/Encounter dan Lab Order keduanya berhasil. Kegagalan salah satu menghasilkan business rollback/cancel. Hard delete dihindari apabila audit trail diperlukan.
13. **Visit/Encounter Sebagai Konteks Pelayanan**: Visit/Encounter yang terbentuk menjadi konteks resmi bagi seluruh pelayanan laboratorium berikutnya.
14. **Separation of Concern OC-08-01 vs OC-08-02**: OC-08-01 memastikan keberadaan Lab Order sebagai hasil akhir registrasi. Detail Lab Order, item pemeriksaan, status, lifecycle, dan business rules Lab Order adalah tanggung jawab OC-08-02.

### Open Questions

*Tidak ada Open Question yang tersisa. Seluruh pertanyaan terbuka dari versi sebelumnya (OQ-01 s/d OQ-04) telah dijawab dan diintegrasikan ke dalam spesifikasi Outcome ini.*
