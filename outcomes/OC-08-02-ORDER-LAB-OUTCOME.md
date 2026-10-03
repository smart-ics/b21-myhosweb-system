# OUTCOME: Order Laboratorium

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-02          |
| Version     | 2.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-03        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat permintaan pemeriksaan laboratorium (order laboratorium) untuk pasien secara resmi, sejak order dibuat oleh Order Creator hingga order siap diproses oleh unit laboratorium.

OC-08-02 bertanggung jawab atas pembentukan dan pengelolaan order pada status **`Ordered`** — yaitu memastikan order tercatat dengan identitas pasien, kode registrasi asal, dokter pemberi instruksi (*Requester*), tingkat urgensi/prioritas pemeriksaan, dan daftar pemeriksaan laboratorium yang diminta (beserta *clinical intent* jika disertakan), termasuk pemeliharaan order (edit atau pembatalan menjadi **`Cancelled`**) selama belum berstatus **`Charged`**.

---

## 2. Outcome Statement

Order pemeriksaan laboratorium untuk pasien telah berhasil dibuat dan tercatat dengan status **`Ordered`** (merujuk pada Kode Registrasi asal, Dokter Requester, Urgensi/Prioritas, dan rincian item pemeriksaan), siap untuk dilanjutkan ke proses berikutnya dalam lifecycle laboratorium.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: mencatat dan mengelola order pemeriksaan laboratorium pada status `Ordered`. |
| Admission | Menyediakan konteks Kode Registrasi asal yang wajib tersedia pada saat order laboratorium dibuat. |
| Pasien | Menyediakan identitas pasien yang menjadi subjek order pemeriksaan laboratorium. |
| Organisasi | Menyediakan identitas dokter/PPA yang dicatat sebagai Requester serta identitas pengguna Order Creator. |
| Tata Rekening | Menyediakan katalog tarif/tindakan pemeriksaan laboratorium yang valid serta aturan penarifan yang terkait dengan Urgensi/Prioritas pemeriksaan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `LAB-ORDER` Order Lab | Laboratory | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Order pemeriksaan laboratorium telah tercatat dalam sistem dengan status **`Ordered`**.
- Order merujuk pada identitas pasien yang valid (**Patient ID**).
- Order merujuk pada **Kode Registrasi asal** yang valid saat pembuatan order. *(Catatan: Order tidak terikat secara eksklusif 1:1 pada satu Kode Registrasi sepanjang lifecycle; pelaksanaan pemeriksaan downstream dapat diproses pada registrasi yang sama, registrasi berbeda, atau tanpa registrasi baru apabila pelayanan tidak memerlukannya).*
- Order merujuk pada identitas dokter sebagai pemberi instruksi klinis (**Requester / Instruction Giver** — **Doctor ID**).
- Identitas **Order Creator** (siapa pun user yang memiliki hak akses ke menu Laboratorium) tercatat dan dapat dibedakan dari Dokter Requester.
- Order memuat tingkat **Urgensi/Prioritas** (*Urgency/Priority*) pemeriksaan yang wajib dimiliki setiap order, memiliki nilai default (*default value*), dan terkait dengan komponen tarif pada `TRK-TARIF`.
- Order memuat satu atau lebih item tarif/pemeriksaan laboratorium yang valid.
- *Clinical Intent* (alasan klinis, indikasi, atau diagnosis kerja) bersifat opsional; order tetap sah dan valid baik dengan maupun tanpa Clinical Intent, termasuk untuk kebutuhan laboratorium eksternal.
- Order berstatus `Ordered` yang dibatalkan sebelum memasuki status `Charged` mengalami transisi status bisnis menjadi **`Cancelled`**, membedakannya secara tegas dari order aktif dan menghentikan kelanjutan order ke lifecycle berikutnya.

### 5.2 Required Recorded Information

- Identitas Pasien (Patient ID).
- Kode Registrasi asal (Originating Registration Code).
- Identitas Dokter Pemberi Instruksi / Requester (Doctor ID).
- Identitas Pembuat Order / Order Creator (User ID dari pengguna yang memiliki hak akses ke menu Laboratorium).
- Peran/relasi Order Creator terhadap Dokter Requester (apakah Dokter sendiri atau pengguna lain atas instruksi dokter).
- Tingkat Urgensi/Prioritas (*Urgency/Priority*) pemeriksaan (wajib ada; terisi nilai pilihan atau nilai default).
- Daftar item pemeriksaan laboratorium yang diminta (satu atau lebih item tarif/tindakan pemeriksaan laboratorium).
- *Clinical Intent* / alasan pemeriksaan (opsional; dicatat apabila diisi).
- Status order (**`Ordered`**, atau **`Cancelled`** apabila order dibatalkan sebelum `Charged`).
- Waktu order dibuat/dikirimkan.

### 5.3 Required Business Conditions

- Patient ID harus valid dan terdaftar dalam sistem.
- Kode Registrasi asal harus valid dan tersedia pada saat order dibuat.
- Doctor ID yang dicatat sebagai Requester harus valid dan dikenal oleh sistem.
- Order Creator harus merupakan pengguna terautentikasi yang memiliki hak akses ke menu Laboratorium (tidak dibatasi role spesifik).
- Tingkat Urgensi/Prioritas wajib terisi pada order (menggunakan nilai default apabila tidak ditentukan secara manual oleh Order Creator), dan memiliki keterkaitan dengan ketentuan tarif pada `TRK-TARIF`.
- Minimal terdapat 1 (satu) item tarif/pemeriksaan laboratorium dalam order.
- Seluruh item yang dipilih harus merupakan tarif/pemeriksaan laboratorium yang valid.
- *Clinical Intent* bersifat opsional; ketiadaannya tidak menggugurkan keabsahan pembentukan order.
- Edit item pemeriksaan dan atribut order hanya dapat dilakukan selama order masih berstatus **`Ordered`** (sebelum `Charged`).
- Pembatalan order hanya dapat dilakukan selama order masih berstatus **`Ordered`** (sebelum `Charged`), dan menghasilkan transisi status bisnis menjadi **`Cancelled`**.
- Order yang telah bertransisi menjadi **`Cancelled`** bersifat final dalam OC-08-02 dan tidak dapat dilanjutkan ke tahap `Charged` maupun tahapan lifecycle berikutnya.
- Setelah order berstatus **`Charged`**, perubahan maupun pembatalan bukan lagi tanggung jawab OC-08-02.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Order pemeriksaan laboratorium tersimpan dan berstatus **`Ordered`**.
- Order memuat Patient ID, Kode Registrasi asal, Doctor ID (Requester), identitas Order Creator, tingkat Urgensi/Prioritas, dan minimal satu item pemeriksaan laboratorium (serta Clinical Intent apabila diisi).
- Jika order diedit, rincian terbaru tersimpan dan order tetap berstatus `Ordered`.
- Jika order dibatalkan sebelum `Charged`, status order tercatat secara persisten sebagai **`Cancelled`** yang membedakannya secara tegas dari order aktif berstatus `Ordered`, dan order tidak dapat dilanjutkan ke tahap `Charged`.

---

## 6. Outcome Boundary

### Start

Dimulai ketika Order Creator (pengguna terautentikasi yang memiliki hak akses ke menu Laboratorium) mengajukan permintaan pemeriksaan laboratorium untuk pasien — menyertakan Patient ID, Kode Registrasi asal, Doctor ID sebagai Requester, tingkat Urgensi/Prioritas (atau menggunakan nilai default), dan minimal satu item pemeriksaan laboratorium (dengan Clinical Intent opsional) — kemudian mengonfirmasi dan mengirimkan order tersebut.

### End

Berakhir ketika order berhasil tercatat dengan status **`Ordered`** — yaitu business result utama dari Outcome ini.

Selama order masih berstatus `Ordered` dan belum memasuki status `Charged`, Order Creator dapat melakukan maintenance terhadap order:
- **Edit**: menambah, menghapus, atau mengganti item pemeriksaan laboratorium, maupun memperbarui atribut order, dengan order tetap berada pada status `Ordered`.
- **Batal**: membatalkan order apabila pemeriksaan tidak lagi diperlukan, yang menghasilkan transisi status bisnis menjadi **`Cancelled`** (terminal state dalam OC-08-02) sehingga order tidak lagi dapat diproses ke tahap `Charged`.

> **Batas Tanggung Jawab:** Setelah order beralih ke status **`Charged`** (ditangani oleh OC-08-03), pengelolaan lifecycle order keluar dari cakupan OC-08-02. OC-08-02 tidak mengelola pembatalan, perubahan, billing, pengambilan spesimen, pemrosesan, maupun hasil pemeriksaan setelah batas `Charged` tersebut. Pelaksanaan pemeriksaan laboratorium selanjutnya dapat menggunakan Kode Registrasi yang sama, berbeda, atau tanpa registrasi baru sesuai ketentuan pelayanan laboratorium downstream.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Minimum Business Facts**: Order laboratorium tidak dapat berstatus `Ordered` tanpa Patient ID yang valid, Kode Registrasi asal yang valid, Doctor ID sebagai Requester yang valid, tingkat Urgensi/Prioritas, dan minimal satu item tarif/pemeriksaan laboratorium.
- **Originating Registration Code Flexibility**: Kode Registrasi asal wajib tersedia pada saat order dibuat. Namun, order tidak terikat secara eksklusif 1:1 pada Kode Registrasi tersebut sepanjang lifecycle. Pelayanan pemeriksaan downstream dapat diproses pada registrasi yang sama, registrasi berbeda, atau tanpa registrasi baru apabila pelayanan tidak memerlukannya.
- **Optional Clinical Intent**: Pengisian *Clinical Intent* (alasan klinis, indikasi, atau diagnosis kerja) bersifat opsional. Ketiadaan Clinical Intent tidak boleh menghambat terbentuknya order berstatus `Ordered`, termasuk untuk kebutuhan alur laboratorium eksternal.
- **Mandatory Urgency/Priority with Tariff Relationship**: Setiap order laboratorium wajib memiliki tingkat Urgensi/Prioritas. Sistem menyediakan nilai default (*default value*) apabila Order Creator tidak menentukan nilai lain. Urgensi/Prioritas memiliki keterkaitan dengan komponen tarif pada `TRK-TARIF`.
- **Broad Order Creator Authorization**: Otorisasi pembuatan order tidak dibatasi pada role profesi tertentu (seperti hanya Dokter atau Perawat/Staf ruangan); siapa pun user yang memiliki hak akses ke menu Laboratorium berwenang membuat Order Laboratorium. Identitas Order Creator tetap wajib tercatat secara terpisah dari Doctor Requester.
- **Doctor Requester Accountability**: Identitas Dokter pemberi instruksi klinis (Requester / Instruction Giver) wajib tercatat pada setiap order laboratorium sebagai fakta bisnis yang terpisah dari pembuat order.
- **Order Item Scope**: Hanya tarif/tindakan yang termasuk kategori pemeriksaan laboratorium yang dapat dimasukkan ke dalam order OC-08-02.
- **Edit Window**: Penambahan, penghapusan, atau penggantian item pemeriksaan serta pembaruan atribut order hanya diperbolehkan selama order berstatus `Ordered`.
- **Cancellation Window & State Transition**: Pembatalan order hanya diperbolehkan selama order berstatus `Ordered` (sebelum `Charged`). Pembatalan menghasilkan transisi status bisnis yang tegas menjadi **`Cancelled`**, bukan penghapusan data order. Order berstatus `Cancelled` tidak dapat dilanjutkan ke status `Charged` atau tahapan lifecycle berikutnya.
- **Charged is the Boundary**: Setelah order berstatus `Charged`, order telah berada di luar boundary OC-08-02; OC-08-02 tidak lagi memiliki wewenang atas perubahan atau pembatalan order tersebut.
- **Scope Boundary vs CPOE**: OC-08-02 berada pada level yang sama dengan OC-05-04 CPOE. OC-08-02 khusus mengelola order/tindakan/tarif pemeriksaan laboratorium. OC-05-04 CPOE mengelola order tarif/tindakan selain laboratorium dan radiologi.
- **Lifecycle & Branching**: Lifecycle utama order laboratorium adalah: `Ordered → Charged → Sample Collected → Processing → Resulted → Released`. Pembatalan dalam OC-08-02 merepresentasikan transisi cabang: `Ordered → Cancelled` yang menghentikan alur lifecycle sebelum mencapai `Charged`.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Patient ID tidak valid atau tidak ditemukan | Order ditolak. Patient ID wajib ada dan valid. |
| Kode Registrasi asal tidak valid atau tidak tersedia saat order dibuat | Order ditolak. Kode Registrasi asal wajib tersedia saat pembuatan order. |
| Doctor ID (Requester) tidak valid atau tidak ditemukan | Order ditolak. Doctor ID sebagai Requester wajib ada dan valid. |
| Pengguna tidak memiliki hak akses ke menu Laboratorium | Order ditolak. Pembuatan order hanya dapat dilakukan oleh pengguna dengan hak akses ke menu Laboratorium. |
| Tidak ada item pemeriksaan laboratorium yang disertakan | Order ditolak. Minimal satu item pemeriksaan laboratorium wajib ada. |
| Item yang dipilih bukan merupakan tarif/pemeriksaan laboratorium yang valid | Order ditolak. Hanya item kategori laboratorium yang dapat dimasukkan ke dalam order OC-08-02. |
| Upaya edit atau pembatalan pada order yang sudah berstatus `Charged` atau status berikutnya | Ditolak. Setelah `Charged`, perubahan dan pembatalan bukan lagi cakupan OC-08-02. |
| Upaya pemrosesan ke tahap `Charged` atau edit terhadap order yang sudah berstatus `Cancelled` | Ditolak. Order yang berstatus `Cancelled` tidak lagi aktif dan tidak dapat diedit atau diproses ke tahapan lanjutan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Order pemeriksaan laboratorium yang dikonfirmasi oleh Order Creator tersimpan dengan status **`Ordered`**. | Completeness |
| AC-02 | Order berstatus `Ordered` memuat Patient ID, Kode Registrasi asal, Doctor ID (Requester), identitas Order Creator, tingkat Urgensi/Prioritas, dan minimal satu item tarif/pemeriksaan laboratorium. | Completeness |
| AC-03 | Order laboratorium dapat dibuat oleh siapa pun user yang memiliki hak akses ke menu Laboratorium, dengan identitas Order Creator tercatat dan dapat dibedakan dari Doctor Requester. | Correctness |
| AC-04 | Pembuatan order ditolak apabila Patient ID tidak valid, Kode Registrasi asal tidak tersedia/tidak valid, Doctor ID (Requester) tidak valid, atau tidak ada item pemeriksaan laboratorium. | Constraint |
| AC-05 | Order pemeriksaan laboratorium tetap berhasil terbentuk dan berstatus `Ordered` meskipun *Clinical Intent* tidak diisi oleh Order Creator. | Correctness |
| AC-06 | Setiap order laboratorium yang terbentuk memiliki tingkat Urgensi/Prioritas; jika tidak dipilih secara khusus oleh Order Creator, sistem menerapkan nilai default (*default value*) yang berlaku. | Correctness |
| AC-07 | Item yang dipilih dalam order diverifikasi sebagai tarif/tindakan pemeriksaan laboratorium yang valid; item di luar kategori laboratorium ditolak. | Constraint |
| AC-08 | Selama order masih berstatus `Ordered`, item pemeriksaan dapat ditambah, dihapus, atau diganti, dan order tersimpan kembali dengan status `Ordered`. | Correctness |
| AC-09 | Selama order masih berstatus `Ordered` (sebelum `Charged`), order dapat dibatalkan dan mengalami transisi status bisnis menjadi **`Cancelled`**. | Correctness |
| AC-10 | Order yang telah berstatus `Cancelled` tidak dapat diproses ke status `Charged` atau tahapan lifecycle lanjutan. | Constraint |
| AC-11 | Upaya edit atau pembatalan order yang sudah berstatus `Charged` (atau status lanjutan dalam lifecycle) ditolak karena telah melewati boundary OC-08-02. | Constraint |
| AC-12 | Order laboratorium yang tercatat dengan Kode Registrasi asal tidak terikat eksklusif 1:1, dan dapat diproses downstream pada registrasi yang sama, berbeda, atau tanpa registrasi baru sesuai kebutuhan pelayanan. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembebanan biaya (*charging*) pemeriksaan laboratorium → **OC-08-03 Charge**.
- Pengambilan dan pengelolaan spesimen → **OC-08-04 Sample Collection**.
- Pemrosesan, pencatatan hasil, verifikasi, dan rilis hasil pemeriksaan → **OC-08-05 Result Management**.
- Pelaksanaan registrasi kunjungan (baik rawat jalan, rawat inap, IGD, maupun registrasi eksternal) → **Admission Domain** (`ADM-REG`, `OC-01-02`, `OC-01-03`, `OC-08-01`).
- Penentuan formula tarif, besaran nominal tarif, atau perkalian tarif berdasarkan urgensi/prioritas → **Tata Rekening Domain** (`TRK-TARIF`).
- Pemakaian barang/reagen oleh unit laboratorium → **OC-08-06 Pakai Barang**.
- Mutasi barang/reagen antar unit → **OC-08-07 Mutasi Barang**.
- Stok opname di unit laboratorium → **OC-08-08 Opname**.
- Order tindakan/tarif selain laboratorium dan radiologi → **OC-05-04 CPOE (Order Pemeriksaan)**.
- Order pemeriksaan radiologi → **OC-09-01 Order Radiologi**.
- Pengelolaan identitas dan data sosial pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan data dokter dan PPA → **Organisasi Domain** (`ORG-PPA`).
- Pengelolaan master tarif laboratorium → **Tata Rekening Domain** (`TRK-TARIF`).

---

## 11. Business Decisions & Open Questions

> Keputusan bisnis yang telah dikonfirmasi dan status pertanyaan terbuka.

### Confirmed Decisions

1. **OC-08-02 adalah Order Laboratorium**: Permintaan pemeriksaan laboratorium dan order laboratorium adalah konsep yang sama dalam domain ini.
2. **Scope Laboratorium**: OC-08-02 hanya menangani order/tindakan/tarif pemeriksaan laboratorium. Tindakan/tarif selain laboratorium dan radiologi ditangani OC-05-04 CPOE.
3. **Kedudukan Outcome**: OC-08-02 berada pada level yang sama dengan OC-05-04 CPOE; bukan turunan dari CPOE.
4. **Order Creator Authorization (OQ#4)**: Tidak ada pembatasan role khusus pada level Outcome. Siapa pun user yang memiliki hak akses ke menu Laboratorium dapat membuat Order Laboratorium. Konsep Doctor Requester / Instruction Giver tetap dipertahankan sebagai business fact yang terpisah dari Order Creator.
5. **Minimum Business Facts**: Patient ID + Kode Registrasi asal + Doctor ID (Requester) + Urgensi/Prioritas + minimal satu item pemeriksaan laboratorium.
6. **Kode Registrasi Asal (OQ#1)**: Kode Registrasi asal wajib tersedia saat Order Laboratorium dibuat. Namun, order tidak terikat secara eksklusif 1:1 pada satu Kode Registrasi sepanjang lifecycle. Pemeriksaan dapat dilakukan pada registrasi yang sama, registrasi berbeda, atau tanpa registrasi baru apabila pelayanan tidak memerlukannya.
7. **Clinical Intent Bersifat Opsional (OQ#2)**: Clinical Intent (alasan klinis, indikasi, atau diagnosis kerja) bersifat opsional, bukan mandatory business fact. Order tetap sah terbentuk tanpa Clinical Intent, termasuk untuk kebutuhan laboratorium eksternal.
8. **Urgensi/Prioritas Wajib & Relasi Tarif (OQ#3)**: Urgensi/Prioritas wajib dimiliki oleh setiap order laboratorium dan memiliki nilai default (*default value*). Urgensi/Prioritas memiliki keterkaitan dengan penarifan pada `TRK-TARIF`.
9. **Trigger**: Order terbentuk saat Order Creator melakukan confirm/submit dan order berhasil masuk ke status `Ordered`.
10. **Edit Window**: Order dapat diedit (tambah, hapus, ganti item, perbarui atribut) selama masih berstatus `Ordered`. Setelah `Charged`, perubahan bukan lagi tanggung jawab OC-08-02.
11. **Cancellation Semantics**: Order dapat dibatalkan selama masih berstatus `Ordered` (sebelum `Charged`). Pembatalan menghasilkan transisi status bisnis yang tegas menjadi **`Cancelled`** (bukan penghapusan), membedakannya secara eksplisit dari order aktif `Ordered` dan menghentikan order untuk diproses ke tahap `Charged`. Setelah `Charged`, pembatalan bukan lagi tanggung jawab OC-08-02.
12. **Lifecycle & Branching**: Alur utama order laboratorium adalah `Ordered → Charged → Sample Collected → Processing → Resulted → Released`. Pembatalan dalam OC-08-02 adalah transisi cabang `Ordered → Cancelled`.

### Open Questions

*Tidak ada Open Question yang belum terselesaikan. Seluruh pertanyaan bisnis (OQ#1 s/d OQ#4) telah diputuskan secara definitif oleh Product Owner dan diintegrasikan ke dalam spesifikasi Outcome ini.*
