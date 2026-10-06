# OUTCOME: Pakai Bed

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-02     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan penggunaan aktual tempat tidur (*bed*) oleh pasien selama menjalani pelayanan rawat inap.

**Pakai Bed** adalah pencatatan penggunaan tempat tidur tertentu oleh pasien dalam pelayanan rawat inap, sejak bed mulai digunakan sampai penggunaannya berakhir.

Fokus outcome ini adalah **penggunaan aktual bed sebagai sumber daya operasional rumah sakit oleh pasien**. Outcome ini memastikan rumah sakit memiliki fakta bisnis yang jelas mengenai bed mana yang digunakan oleh pasien dan dalam periode kapan bed tersebut digunakan dalam konteks episode rawat inap yang aktif.

---

## 2. Outcome Statement

**Pakai Bed adalah pencatatan penggunaan tempat tidur tertentu oleh pasien dalam pelayanan rawat inap, sejak bed mulai digunakan sampai penggunaannya berakhir.**

Penggunaan bed tercatat sebagai fakta bisnis bahwa seorang pasien benar-benar menggunakan suatu bed tertentu dalam episode rawat inap aktif, dengan waktu mulai penggunaan yang pasti dan waktu berakhir penggunaan apabila penggunaannya telah selesai.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | Pemilik utama: mencatat awal penggunaan dan berakhirnya penggunaan tempat tidur aktual oleh pasien di bangsal |
| Admission (`ADM`) | Menyediakan konteks episode registrasi rawat inap aktif pasien |
| Pasien (`PAS`) | Menyediakan identitas pasien yang menggunakan tempat tidur |
| Organisasi (`ORG`) | Menyediakan data identitas fisik tempat tidur (*bed*), kamar, dan bangsal |

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
> Domain Catalog tetap menjadi sumber otoritatif untuk penetapan Domain Capability. OC-06-02 tidak menetapkan atau memperluas capability baru secara sepihak. Kebutuhan capability tambahan (jika ada) harus dieskalasikan kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Fakta pencatatan penggunaan tempat tidur fisik tertentu oleh pasien dalam konteks episode rawat inap aktif.
- Identitas pasien yang menggunakan bed.
- Identitas tempat tidur (bed) yang digunakan.
- Konteks episode rawat inap yang menjadi dasar perawatan pasien.
- Waktu mulai penggunaan tempat tidur.
- Waktu berakhir penggunaan tempat tidur, apabila penggunaan bed telah selesai.
- Pembedaan fakta penggunaan: penggunaan yang telah berakhir dibedakan dari penggunaan yang masih berlangsung melalui keberadaan waktu berakhir penggunaan.
- Fakta pergantian bed: jika pasien berganti bed, penggunaan bed sebelumnya berakhir dan penggunaan bed berikutnya dimulai sebagai rekaman penggunaan baru.

### 5.2 Required Recorded Information

Pencatatan Pakai Bed mencakup informasi bisnis berikut secara *implementation-independent*:

- Identitas pasien (Nomor Rekam Medis).
- Referensi episode/registrasi rawat inap aktif.
- Identitas fisik tempat tidur (*bed*) yang digunakan.
- Konteks lokasi ruangan/kamar dan bangsal tempat bed berada.
- Waktu mulai penggunaan (tanggal dan jam mulai aktual).
- Waktu berakhir penggunaan (tanggal dan jam berakhir aktual, tercatat saat penggunaan selesai).

### 5.3 Required Business Conditions

- Pasien harus terikat pada episode registrasi rawat inap yang aktif.
- Tempat tidur yang digunakan harus valid dan terdaftar aktif dalam master fasilitas ruangan/bangsal.
- Tempat tidur tidak boleh digunakan secara bersamaan oleh lebih dari satu pasien aktif pada kurun waktu yang sama.
- Seorang pasien tidak boleh menggunakan lebih dari satu bed aktif secara bersamaan dalam episode rawat inap yang sama.
- Waktu mulai penggunaan harus berada dalam rentang episode rawat inap pasien dan tidak berada di masa depan.
- Waktu berakhir penggunaan harus sama dengan atau setelah waktu mulai penggunaan, dan tidak berada di masa depan.

### 5.4 Completion Proof

- Tercatatnya fakta bahwa pasien mulai menggunakan tempat tidur tertentu dengan waktu mulai yang terverifikasi dalam konteks rawat inap aktif.
- Tercatatnya waktu berakhir penggunaan ketika pasien tidak lagi menggunakan tempat tidur tersebut, membuktikan bahwa penggunaan bed telah selesai.
- Fakta penggunaan tempat tidur dapat ditelusuri per pasien, per episode rawat inap, dan per tempat tidur.

---

## 6. Outcome Boundary

### Start

Ketika pasien mulai menggunakan bed tertentu dalam konteks pelayanan rawat inap.

### End

Ketika pasien tidak lagi menggunakan bed tersebut (ditandai dengan tercatatnya waktu berakhir penggunaan).

> **Catatan Batasan:**
> Berakhirnya penggunaan bed dapat dipicu oleh pergantian bed dalam unit yang sama, perpindahan ke unit layanan lain (`OC-06-03`), pemulangan pasien (`OC-06-04`), atau peristiwa operasional lainnya. Peristiwa-peristiwa tersebut dapat menjadi pemicu bisnis berakhirnya pemakaian bed, namun bukan merupakan inti dari definisi OC-06-02. OC-06-02 murni mencatat fakta awal dan berakhirnya penggunaan tempat tidur tertentu.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi untuk Outcome ini.

1. **Konteks Rawat Inap:** Pakai Bed mencatat penggunaan aktual bed tertentu oleh pasien dalam konteks pelayanan rawat inap. Model konseptual yang berlaku:
   $$\text{Pasien} \longrightarrow \text{Episode Rawat Inap} \longrightarrow \text{Bed}$$
   Outcome ini bukan mekanisme umum untuk mencatat siapa yang berada pada suatu bed di luar konteks rawat inap.
2. **Dimensi Waktu Penggunaan:** Penggunaan bed memiliki waktu mulai dan, apabila penggunaan telah berakhir, waktu berakhir.
3. **Pergantian Bed:** Jika pasien berganti bed, maka penggunaan bed sebelumnya berakhir (pencatatan waktu berakhir) dan penggunaan bed berikutnya dimulai (pencatatan waktu mulai).
4. **Pemisahan Tegas dari Transfer Unit:**
   - Perubahan bed dalam unit pelayanan yang sama **bukan Transfer Unit**. Tidak perlu membuat konsep atau outcome baru untuk pergantian bed dalam unit yang sama.
   - Pakai Bed menjawab: *“Bed mana yang digunakan oleh pasien dan dalam periode kapan bed tersebut digunakan?”*
   - Transfer Unit menjawab: *“Apakah pasien berpindah dari satu unit pelayanan ke unit pelayanan lainnya?”*
   - Perpindahan pasien antar-unit pelayanan menjadi tanggung jawab **OC-06-03 Transfer Unit**. OC-06-02 hanya mencatat fakta penggunaan bed yang terkait dengan perpindahan tersebut (berakhirnya bed di unit asal, dan dimulainya bed di unit tujuan).
5. **Pemisahan dari Registrasi Rawat Inap:** Registrasi Rawat Inap (`OC-01-03`) menetapkan episode rawat inap dan tujuan pelayanan, sedangkan Pakai Bed mencatat penggunaan bed aktual. Proses registrasi rawat inap tidak dimasukkan ke dalam OC-06-02.
6. **Ketunggalan Penggunaan Bed:** Satu tempat tidur hanya dapat digunakan oleh satu pasien dalam satu kurun waktu, dan seorang pasien hanya dapat menggunakan satu tempat tidur aktif pada satu waktu.
7. **Bukan Reservasi atau Master Data:** Pakai Bed bukan permintaan atau reservasi tempat tidur, dan bukan pengelolaan data master tempat tidur maupun status ketersediaan bed secara umum.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk.

| Exception | Expected Behavior |
|-----------|-------------------|
| Pasien tidak memiliki episode rawat inap aktif saat penggunaan bed dicatat | **Pencatatan ditolak.** Pasien harus memiliki episode registrasi rawat inap aktif. |
| Tempat tidur sedang digunakan oleh pasien lain pada kurun waktu yang sama | **Pencatatan ditolak.** Tempat tidur tidak dapat digunakan secara ganda pada waktu yang sama. |
| Pasien masih tercatat menggunakan tempat tidur lain yang belum diakhiri | **Pencatatan ditolak.** Penggunaan bed sebelumnya harus diakhiri terlebih dahulu sebelum penggunaan bed baru dapat dicatat. |
| Tempat tidur tidak terdaftar atau tidak aktif dalam master ruangan/bangsal | **Pencatatan ditolak.** Penggunaan hanya berlaku untuk tempat tidur yang terdaftar aktif. |
| Waktu berakhir penggunaan mendahului waktu mulai penggunaan | **Pencatatan waktu berakhir ditolak.** Waktu berakhir harus sama dengan atau setelah waktu mulai. |
| Waktu mulai penggunaan berada di masa depan atau mendahului registrasi rawat inap | **Pencatatan ditolak.** Waktu mulai harus valid dalam rentang episode rawat inap. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Pakai Bed telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Pasien yang menggunakan bed dapat diketahui dan teridentifikasi dalam pencatatan. | Completeness |
| AC-02 | Bed yang digunakan dapat diketahui dan teridentifikasi secara spesifik beserta konteks ruangan dan bangsalnya. | Completeness |
| AC-03 | Penggunaan bed terbukti berada dalam konteks episode pelayanan rawat inap yang sah dan aktif. | Correctness |
| AC-04 | Waktu mulai penggunaan bed dapat diketahui dan tercatat saat pasien mulai menggunakan bed. | Completeness |
| AC-05 | Penggunaan bed yang telah berakhir dapat dibedakan secara jelas dari penggunaan bed yang masih berlangsung melalui pencatatan waktu berakhir. | Correctness |
| AC-06 | Waktu berakhir penggunaan bed dapat diketahui dan tercatat ketika pasien tidak lagi menggunakan bed tersebut. | Completeness |
| AC-07 | Perubahan bed menghasilkan berakhirnya penggunaan bed sebelumnya (tercatat waktu berakhir) dan dimulainya penggunaan bed berikutnya (tercatat waktu mulai baru). | Correctness |
| AC-08 | Perubahan bed dalam unit pelayanan yang sama tidak dianggap atau dicatat sebagai Transfer Unit. | Constraint |
| AC-09 | Perpindahan pasien antar-unit pelayanan tetap menjadi tanggung jawab OC-06-03 Transfer Unit, di mana OC-06-02 hanya mencatat berakhirnya penggunaan bed di unit asal dan dimulainya penggunaan bed di unit tujuan. | Constraint |
| AC-10 | Sistem menolak pencatatan jika bed sedang digunakan oleh pasien lain atau pasien masih memiliki penggunaan bed aktif yang belum diakhiri. | Constraint |
| AC-11 | Spesifikasi Outcome didefinisikan secara murni berbasis fakta bisnis yang *implementation-independent* tanpa bergantung pada rancangan antarmuka (UI), workflow aplikasi, skema database, atau API teknis. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pendaftaran pasien rawat inap dan penerbitan registrasi rawat inap → **OC-01-03 Registrasi Rawat Inap** (`ADM-REG`).
- Pengelolaan antrian pasien masuk bangsal sebelum penggunaan bed → **RNA-ANTRIAN Antrian Masuk Bangsal** (Rawat Inap Domain).
- Pengelolaan alur perpindahan administratif dan serah terima pasien antar-unit pelayanan → **OC-06-03 Transfer Unit** (`RNA-TRANSFER`).
- Pengelolaan keputusan medis dan administrasi pemulangan pasien rawat inap → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Master data tempat tidur, kamar, bangsal, dan pengaturan kapasitas fasilitas → **Organisasi Domain** (`ORG-BANGSAL`).
- Reservasi, pemesanan, atau permohonan tempat tidur → **Admisi / Rawat Inap Domain**.
- Pengelolaan status fisik, kebersihan, dan kesiapan tempat tidur pasca penggunaan → **Housekeeping Bed Readiness** (`RNA-HK`).
- Penentuan struktur tarif kamar dan perhitungan tagihan akomodasi/sewa kamar (*room charge*) → **Tata Rekening Domain** (`TRK-TARIF`, `TRK-BILLING`).
- Prosedur medis, tindakan asuhan keperawatan, dan dokumentasi klinis pasien rawat inap → **OC-06-01 Tindakan Rawat Inap** dan **Domain EMR**.
- Desain antarmuka pengguna (UI), formulir isian, endpoint API, skema tabel database, atau implementasi teknis aplikasi.
