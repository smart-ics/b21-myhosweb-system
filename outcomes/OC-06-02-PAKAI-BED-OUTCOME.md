# OUTCOME: Pakai Bed

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-02     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan penggunaan aktual tempat tidur (*bed*) oleh pasien selama menjalani pelayanan rawat inap.

**Pakai Bed** adalah pencatatan penggunaan tempat tidur tertentu oleh pasien dalam pelayanan rawat inap, sejak bed mulai digunakan sampai penggunaannya berakhir.

Fokus outcome ini adalah **penggunaan aktual bed sebagai sumber daya operasional rumah sakit oleh pasien**. Pakai Bed merupakan **Operasional Service Event**, bukan clinical event. Outcome ini memastikan rumah sakit memiliki fakta operasional bahwa pasien benar-benar menggunakan bed tertentu dalam episode rawat inap, sejak mulai digunakan sampai penggunaan tersebut berakhir.

---

## 2. Outcome Statement

**Pakai Bed adalah pencatatan penggunaan tempat tidur tertentu oleh pasien dalam pelayanan rawat inap, sejak bed mulai digunakan sampai penggunaannya berakhir.**

Outcome ini merepresentasikan fakta operasional bahwa seorang pasien menggunakan bed tertentu dalam konteks episode rawat inap yang aktif, dengan waktu mulai penggunaan dan waktu berakhir penggunaan apabila penggunaannya telah selesai.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | **Domain Utama (Owner):** Bertanggung jawab atas pencatatan operasional penggunaan tempat tidur oleh pasien di rawat inap sejak mulai digunakan sampai penggunaannya berakhir |
| Admission (`ADM`) | **Supporting / Context Domain:** Menyediakan konteks episode rawat inap aktif pasien |
| Pasien (`PAS`) | **Supporting / Context Domain:** Menyediakan identitas pasien yang menggunakan tempat tidur |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan identitas tempat tidur (*bed*) yang valid dalam fasilitas pelayanan rumah sakit |

> **Catatan Batasan Domain:**
> `RNA Rawat Inap` adalah pemilik utama outcome ini. Domain `ADM`, `PAS`, dan `ORG` berpartisipasi murni sebagai penyedia konteks dan referensi (pasien, episode rawat inap, dan identitas bed) tanpa memperluas kepemilikan outcome ke domain-domain tersebut.

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RNA-BED` Pakai Bed | Rawat Inap | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-BANGSAL` Room Bangsal Management | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Domain Catalog:**
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain Capability. OC-06-02 tidak menetapkan atau memperluas capability baru secara sepihak. OC-06-02 tidak mengambil alih kepemilikan master data bed dari `ORG-BANGSAL`. Kebutuhan capability tambahan (jika ada) harus dieskalasikan kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Pasien yang menggunakan bed teridentifikasi dalam konteks pelayanan rawat inap.
- Episode/konteks rawat inap yang menaungi penggunaan bed teridentifikasi.
- Bed tertentu yang digunakan oleh pasien teridentifikasi.
- Waktu mulai penggunaan bed tercatat saat bed mulai digunakan.
- Waktu berakhirnya penggunaan bed tercatat apabila penggunaan bed telah berakhir.
- Penggunaan yang telah berakhir dapat dibedakan dari penggunaan yang masih berlangsung melalui pencatatan waktu berakhir penggunaan.
- Jika pasien berganti bed, penggunaan bed sebelumnya berakhir dan penggunaan bed berikutnya dimulai sebagai catatan penggunaan baru.

### 5.2 Required Recorded Information

Pencatatan Pakai Bed harus dapat membuktikan informasi bisnis inti berikut secara *implementation-independent*:

- Siapa pasien yang menggunakan bed.
- Pada episode rawat inap apa penggunaan bed tersebut berlangsung.
- Bed mana yang digunakan oleh pasien.
- Kapan bed tersebut mulai digunakan (waktu mulai).
- Kapan penggunaan bed tersebut berakhir (waktu berakhir, jika penggunaan telah selesai).

### 5.3 Required Business Conditions

- Penggunaan bed harus berada dalam konteks episode rawat inap yang aktif.
- Tempat tidur yang digunakan harus merupakan bed yang valid dalam konteks pelayanan rumah sakit.
- Tempat tidur tidak boleh digunakan secara bersamaan oleh lebih dari satu pasien pada kurun waktu yang sama.
- Pasien tidak dapat memiliki lebih dari satu active bed secara bersamaan dalam episode rawat inap yang sama.
- Waktu mulai penggunaan harus merupakan waktu yang sah dan tidak berada di masa depan.
- Waktu berakhir penggunaan harus sama dengan atau setelah waktu mulai penggunaan.

### 5.4 Completion Proof

- Terbukti bahwa pasien mulai menggunakan bed tertentu dengan waktu mulai tercatat dalam konteks episode rawat inap.
- Terbukti bahwa penggunaan bed telah selesai ketika waktu berakhirnya penggunaan tercatat saat pasien tidak lagi menggunakan bed tersebut.
- Penggunaan bed yang telah selesai dapat dibedakan dari penggunaan bed yang masih berlangsung.

---

## 6. Outcome Boundary

### Start

Ketika pasien benar-benar mulai menggunakan/menempati bed tertentu dalam pelayanan rawat inap.

### End

Ketika pasien tidak lagi menggunakan bed tersebut (ditandai dengan tercatatnya waktu berakhir penggunaan).

> **Catatan Batasan:**
> Berakhirnya penggunaan bed dapat terjadi karena pasien pindah bed, pindah unit pelayanan, atau tidak lagi menggunakan bed karena episode rawat inap berakhir (misalnya discharge). Peristiwa bisnis tersebut dapat menjadi pemicu berakhirnya pemakaian bed, namun bukan merupakan bagian dari definisi inti Pakai Bed. Pakai Bed murni mencatat awal dan berakhirnya penggunaan bed tertentu.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Konteks Rawat Inap:** Pakai Bed mencatat penggunaan aktual bed tertentu oleh pasien dalam konteks episode rawat inap. Outcome ini bukan mekanisme umum untuk mencatat siapa yang berada pada suatu bed di luar konteks rawat inap.
2. **Dimensi Waktu Penggunaan:** Penggunaan bed memiliki waktu mulai dan, apabila penggunaan telah berakhir, memiliki waktu berakhir.
3. **Pergantian Bed:** Jika pasien berganti bed, maka penggunaan bed sebelumnya berakhir dan penggunaan bed berikutnya dimulai.
4. **Boundary Tegas dengan Transfer Unit:**
   - **Perubahan bed dalam unit pelayanan yang sama adalah perubahan penggunaan bed dan bukan Transfer Unit.**
   - Pakai Bed menjawab: *“Bed mana yang digunakan oleh pasien dan dalam periode kapan bed tersebut digunakan?”*
   - Transfer Unit menjawab: *“Apakah pasien berpindah dari satu unit pelayanan ke unit pelayanan lainnya?”*
   - Jika pasien berpindah antar-unit pelayanan:
     - **Transfer Unit dicatat sebagai outcome tersendiri pada OC-06-03.**
     - **Perubahan penggunaan bed yang menyertai perpindahan tersebut tetap dicatat sebagai Pakai Bed** (penggunaan bed di unit asal berakhir, dan penggunaan bed di unit tujuan dimulai).
   - Ringkasan:
     - **Bed 01 → Bed 02 dalam unit yang sama = Pakai Bed berubah, bukan Transfer Unit.**
     - **Unit A → Unit B = Transfer Unit + perubahan penggunaan bed.**
5. **Boundary dengan Registrasi Rawat Inap:** Registrasi Rawat Inap (`OC-01-03`) menetapkan konteks episode rawat inap, sedangkan Pakai Bed mencatat penggunaan bed aktual. Proses registrasi rawat inap tidak dimasukkan ke dalam OC-06-02.
6. **Ketunggalan Penggunaan Bed:** Suatu bed tidak boleh digunakan secara bersamaan oleh lebih dari satu pasien, dan seorang pasien tidak dapat memiliki lebih dari satu active bed secara bersamaan dalam episode rawat inap yang sama.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak memiliki episode rawat inap aktif saat penggunaan bed dicatat | **Pencatatan ditolak.** Penggunaan bed harus berada dalam episode rawat inap yang aktif. |
| Bed sedang digunakan oleh pasien lain pada kurun waktu yang sama | **Pencatatan ditolak.** Bed tidak dapat digunakan secara bersamaan oleh lebih dari satu pasien. |
| Pasien masih tercatat memiliki active bed lain yang belum diakhiri | **Pencatatan ditolak.** Penggunaan bed sebelumnya harus diakhiri terlebih dahulu sebelum penggunaan bed baru dapat dicatat. |
| Bed yang dipilih bukan bed yang valid dalam konteks pelayanan rumah sakit | **Pencatatan ditolak.** Penggunaan hanya sah pada bed yang valid. |
| Waktu berakhir penggunaan mendahului waktu mulai penggunaan | **Pencatatan ditolak.** Waktu berakhir harus sama dengan atau setelah waktu mulai. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Pakai Bed telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Pasien dapat diidentifikasi sebagai pengguna bed dalam pencatatan. | Completeness |
| AC-02 | Bed yang digunakan dapat diidentifikasi secara jelas. | Completeness |
| AC-03 | Penggunaan bed terbukti terkait dengan konteks episode rawat inap yang sah. | Correctness |
| AC-04 | Terdapat waktu mulai penggunaan yang dapat diketahui saat pasien mulai menggunakan bed. | Completeness |
| AC-05 | Penggunaan bed dapat berakhir dan waktu berakhirnya penggunaan dapat diketahui saat pasien tidak lagi menggunakan bed tersebut. | Completeness |
| AC-06 | Penggunaan bed yang telah berakhir dapat dibedakan dari penggunaan bed yang masih berlangsung. | Correctness |
| AC-07 | Perubahan bed mengakhiri penggunaan bed lama (waktu berakhir tercatat) dan memulai penggunaan bed baru (waktu mulai tercatat). | Correctness |
| AC-08 | Perubahan bed dalam unit pelayanan yang sama tidak menghasilkan pencatatan Transfer Unit. | Constraint |
| AC-09 | Perpindahan pasien antar-unit pelayanan merupakan tanggung jawab OC-06-03 Transfer Unit, sementara perubahan penggunaan bed yang menyertainya tetap tercatat sebagai Pakai Bed. | Constraint |
| AC-10 | Sistem menolak pencatatan jika bed sedang digunakan oleh pasien lain atau pasien masih memiliki active bed yang belum diakhiri. | Constraint |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pendaftaran pasien rawat inap dan pembentukan episode rawat inap → **OC-01-03 Registrasi Rawat Inap** (`ADM-REG`).
- Pencatatan dan pengelolaan perpindahan pasien antar-unit pelayanan → **OC-06-03 Transfer Unit** (`RNA-TRANSFER`).
- Pengelolaan pemulangan pasien rawat inap → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Pengelolaan master data tempat tidur, ruangan, dan bangsal → **Organisasi Domain** (`ORG-BANGSAL`).
- Reservasi atau pemesanan tempat tidur.
