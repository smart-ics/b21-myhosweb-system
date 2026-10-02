# OUTCOME: Order Laboratorium

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-02          |
| Version     | 1.1               |
| Status      | Draft             |
| LastUpdated | 2026-10-02        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat dan mengelola permintaan pemeriksaan laboratorium (order laboratorium) untuk pasien secara resmi, sejak permintaan dibuat hingga siap diproses oleh unit laboratorium.

Pencatatan ini memastikan bahwa setiap pemeriksaan laboratorium yang diinstruksikan oleh dokter tercatat dengan konteks kunjungan pasien yang sah, dokter pemberi instruksi (*Requester*), pembuat order (*Order Creator*), justifikasi klinis, tingkat urgensi pemeriksaan, serta rincian tarif/pemeriksaan laboratorium yang diminta.

Tanpa order laboratorium yang terkelola dan berstatus valid (**`Ordered`**), unit laboratorium tidak memiliki dasar operasional yang sah untuk membebankan biaya (**`Charged`**), mengambil spesimen (**`Sample Collected`**), maupun memproses dan merilis hasil pemeriksaan laboratorium.

---

## 2. Outcome Statement

Permintaan pemeriksaan laboratorium untuk pasien dalam konteks kunjungan pelayanan rumah sakit telah berhasil dibuat, divalidasi, dan tercatat dengan status **`Ordered`**, siap untuk diproses ke tahap pembebanan biaya (*Charged*) dan penanganan sampel oleh unit laboratorium.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Pemilik utama outcome: mencatat, mengesahkan, dan mengelola order pemeriksaan laboratorium serta status daur hidup order pada tahap `Ordered`. |
| Admission | Menyediakan konteks kunjungan aktif pasien (registrasi rawat jalan, rawat inap, atau IGD) yang menjadi dasar pelaksanaan order laboratorium internal RS. |
| Pasien | Menyediakan identitas pasien yang menjadi subjek permintaan pemeriksaan laboratorium. |
| Organisasi | Menyediakan data identitas tenaga medis dan staf (PPA) untuk menetapkan Dokter Requester dan Petugas Order Creator yang sah. |
| Tata Rekening | Menyediakan katalog dan definisi tarif/tindakan pemeriksaan laboratorium yang valid. |

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

- Permintaan pemeriksaan laboratorium telah tercatat secara persisten dalam sistem dengan status awal **`Ordered`**.
- Order merujuk pada identitas pasien yang valid dan terdaftar.
- Order merujuk pada konteks kunjungan pelayanan aktif pasien di rumah sakit (Rawat Jalan, Rawat Inap, atau IGD).
- Order merujuk pada identitas dokter yang memberikan instruksi klinis sebagai **Requester / Instruction Giver**.
- Identitas **Order Creator** (user pembuat/penginput order) tercatat secara persisten dan dapat dibedakan dari Dokter Requester ketika order diinput oleh staf atas instruksi dokter.
- Indikasi klinis, alasan pemeriksaan, atau diagnosis kerja dokter telah tercatat sebagai dasar justifikasi medis pemeriksaan laboratorium.
- Tingkat urgensi pemeriksaan laboratorium (misalnya **Rutin** atau **CITO / Darurat**) telah ditetapkan secara eksplisit pada order.
- Order memuat sekurang-kurangnya satu item tarif/pemeriksaan laboratorium yang valid.
- Order berstatus `Ordered` siap menjadi rujukan operasional bagi unit laboratorium untuk diproses ke tahap lanjutan (*Charged* pada OC-08-03).
- Order yang dibatalkan sebelum tahap `Charged` bertransisi status menjadi **`Cancelled`** secara persisten (bukan dihapus) disertai alasan pembatalan dan identitas pembatal untuk keperluan audit log.

### 5.2 Required Recorded Information

- Identitas atau nomor referensi unik order laboratorium.
- Identitas Pasien (ID Pasien).
- Identitas Kunjungan Pasien (ID Kunjungan / Registrasi aktif).
- Identitas Dokter Pemberi Instruksi / Requester (ID Dokter).
- Identitas Pembuat Order / Order Creator (User ID Dokter, Perawat Ruangan, Petugas Administrasi Poli/Bangsal, atau Staf Klinis Terverifikasi).
- Peran Order Creator terhadap order (Dokter langsung, atau Perawat/Petugas atas instruksi dokter).
- Indikasi klinis / alasan pemeriksaan / diagnosis kerja dokter.
- Tingkat urgensi pemeriksaan (Rutin / CITO).
- Rincian item pemeriksaan laboratorium yang diminta (satu atau lebih item tarif/pemeriksaan laboratorium).
- Status order saat ini (**`Ordered`**, atau **`Cancelled`** jika dibatalkan sebelum *Charged*).
- Waktu pencatatan atau pengiriman order.
- Riwayat perubahan item order (apabila terjadi penambahan, pengurangan, atau penggantian item saat order masih berstatus `Ordered`).
- Data pembatalan order (waktu pembatalan, alasan pembatalan, dan identitas user yang membatalkan apabila order dibatalkan sebelum berstatus `Charged`).

### 5.3 Required Business Conditions

- Subjek order harus merupakan pasien yang terdaftar secara sah dan memiliki kunjungan aktif (Rawat Jalan, Rawat Inap, atau IGD). Permintaan pemeriksaan pasien luar tanpa kunjungan RS dialihkan ke OC-08-01 External Registration.
- Dokter yang dicatat sebagai Requester harus terdaftar secara sah sebagai dokter/PPA yang memiliki kewenangan memberikan instruksi pemeriksaan klinis.
- Pembuat order (*Order Creator*) harus terautentikasi dan memiliki kewenangan sah, yaitu:
  - Dokter itu sendiri; atau
  - Staf klinis/administratif yang berwenang dari unit asal pasien (perawat ruangan asal pasien, petugas administrasi poli/bangsal, atau staf klinis terverifikasi lainnya) yang bertindak atas instruksi dokter.
- Indikasi klinis, alasan pemeriksaan, atau diagnosis kerja dokter wajib diisi dan tidak boleh kosong saat order diajukan.
- Tingkat urgensi pemeriksaan (Rutin / CITO) wajib ditentukan secara eksplisit saat order diajukan.
- Seluruh item pemeriksaan yang dipilih harus merupakan tarif/pemeriksaan laboratorium yang valid dan aktif.
- Minimal terdapat 1 (satu) item tarif/pemeriksaan laboratorium dalam satu order.
- Pengubahan rincian pemeriksaan (menambah, menghapus, atau mengganti item) hanya dapat dilakukan selama order masih berstatus **`Ordered`**.
- Pembatalan order hanya dapat dilakukan selama order masih berstatus **`Ordered`** (sebelum `Charged`), dan wajib mencatat alasan pembatalan serta identitas pembatal.
- Status **`Charged`** merupakan batas mutlak yang tidak dapat diubah (*immutable boundary*); setelah order berstatus `Charged`, perubahan maupun pembatalan tidak lagi diizinkan melalui OC-08-02.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Order laboratorium tersimpan dalam sistem dengan nomor referensi unik dan berstatus **`Ordered`**.
- Data order dapat ditelusuri dan diverifikasi memuat ID Pasien, konteks kunjungan aktif, ID Dokter Requester, identitas Order Creator, indikasi klinis, tingkat urgensi (Rutin/CITO), dan daftar item tarif/pemeriksaan laboratorium.
- Order berstatus `Ordered` tersedia dan dapat diambil (*retrievable*) oleh unit laboratorium sebagai dasar pembebanan biaya (*Charged*) pada OC-08-03.
- Jika order dibatalkan sebelum berstatus `Charged`, status order tercatat secara persisten sebagai **`Cancelled`** lengkap dengan alasan pembatalan dan identitas pembatal, serta tidak dapat dilanjutkan ke tahap pembebanan biaya maupun pemrosesan laboratorium.

---

## 6. Outcome Boundary

### Start

Dimulai ketika pembuat order (*Order Creator*: Dokter, atau perawat ruangan asal pasien, petugas administrasi poli/bangsal, maupun staf klinis terverifikasi atas instruksi dokter) memulai pembuatan permintaan pemeriksaan laboratorium untuk pasien dengan kunjungan aktif, menentukan Dokter Requester pemberi instruksi, mencatat indikasi klinis/diagnosis kerja, menetapkan tingkat urgensi (Rutin/CITO), memilih satu atau lebih item tarif/pemeriksaan laboratorium, serta mengonfirmasi dan mengirimkan order tersebut.

### End

Berakhir ketika salah satu dari kondisi berikut terpenuhi:
1. Order pemeriksaan laboratorium telah tervalidasi dan tercatat secara persisten dengan status **`Ordered`**, siap untuk diproses ke tahap pembebanan biaya (**`Charged`**) pada OC-08-03; **ATAU**
2. Order yang masih berstatus **`Ordered`** berhasil diubah rincian pemeriksaannya (tambah/hapus/ganti item) dan tersimpan kembali dengan status **`Ordered`**; **ATAU**
3. Order yang masih berstatus **`Ordered`** berhasil dibatalkan sebelum memasuki status **`Charged`**, beralih ke status terminal **`Cancelled`** disertai pencatatan alasan pembatalan dan identitas pembatal untuk audit log.

> **Batas Tanggung Jawab:** Begitu order laboratorium beralih ke status **`Charged`** (ditangani oleh OC-08-03), daur hidup order keluar dari batas kewenangan OC-08-02. OC-08-02 tidak mengelola perubahan, pembatalan, pembebanan biaya, penanganan spesimen, maupun hasil pemeriksaan setelah batas `Charged` tersebut.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Minimum Business Facts**: Sebuah order laboratorium tidak boleh dibentuk atau berstatus `Ordered` tanpa adanya ID Pasien yang valid, konteks kunjungan aktif, ID Dokter sebagai Requester, indikasi klinis/diagnosis kerja, tingkat urgensi pemeriksaan, dan minimal satu item tarif/pemeriksaan laboratorium.
- **Mandatory Clinical Indication**: Indikasi klinis, alasan pemeriksaan, atau diagnosis kerja dokter wajib tercatat pada setiap order laboratorium sebagai justifikasi medis tindakan.
- **Explicit Urgency Level**: Tingkat urgensi pemeriksaan laboratorium (Rutin vs CITO/Darurat) wajib ditentukan secara eksplisit pada saat pembuatan order.
- **Actor Accountability & Administrative Delegation**: Identitas *Order Creator* harus selalu tercatat. Perawat ruangan asal pasien, petugas administrasi poli/bangsal, atau staf klinis terverifikasi lainnya memiliki kewenangan administratif untuk membuat order atas instruksi dokter, namun tanggung jawab klinis atas order tetap melekat pada Dokter Requester.
- **Scope Boundary vs External Registration**: Permintaan pemeriksaan laboratorium yang berasal dari pasien luar atau alur pendaftaran langsung di laboratorium diakomodir melalui **OC-08-01 External Registration** dan berada di luar cakupan alur kunjungan RS pada OC-08-02.
- **Scope Boundary vs CPOE**: OC-08-02 berada pada level yang sama dengan OC-05-04 CPOE (Order Pemeriksaan) dan bukan merupakan turunan dari CPOE. OC-08-02 khusus mengelola order tindakan/tarif pemeriksaan laboratorium, sedangkan OC-05-04 CPOE mengelola order tarif/tindakan selain laboratorium dan radiologi.
- **Immutable Boundary on Charged**: Pengubahan item pemeriksaan laboratorium maupun pembatalan order HANYA diperbolehkan sebelum order berstatus `Charged`. Status `Charged` adalah batas mutlak (*immutable boundary*) bagi OC-08-02.
- **Persisted Cancellation State**: Pembatalan order yang berstatus `Ordered` sebelum tahap `Charged` tidak menghapus data order secara fisik, melainkan mencatat status secara persisten sebagai `Cancelled` dengan mewajibkan pencatatan alasan pembatalan dan identitas petugas pembatal untuk keperluan audit log.
- **Non-Empty Order**: Pengubahan item pemeriksaan pada order berstatus `Ordered` tidak boleh menyisakan order tanpa item pemeriksaan (daftar item tidak boleh kosong). Apabila seluruh pemeriksaan tidak lagi dibutuhkan, order harus dibatalkan, bukan dikosongkan.
- **Strict Separation of Lifecycle**: OC-08-02 bertanggung jawab eksklusif pada pembentukan dan pengelolaan order pada tahap `Ordered`. OC-08-02 tidak menangani proses billing/keuangan, pengambilan spesimen, pemrosesan analitika lab, maupun pengelolaan hasil pemeriksaan.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| ID Pasien tidak ditemukan atau tidak valid | Order ditolak. Sistem menolak pembentukan order dan meminta identitas pasien yang valid. |
| Konteks kunjungan aktif pasien tidak ditemukan | Order ditolak. Pasien internal RS harus memiliki kunjungan aktif (Rawat Jalan, Rawat Inap, atau IGD). Untuk pasien tanpa kunjungan RS, alur dialihkan ke OC-08-01 External Registration. |
| ID Dokter Requester tidak ditemukan atau tidak valid | Order ditolak. Dokter pemberi instruksi klinis wajib dipilih dari data PPA dokter yang sah. |
| Indikasi klinis / alasan pemeriksaan / diagnosis kerja kosong | Order ditolak. Justifikasi klinis wajib diisi sebelum order dapat dikirimkan. |
| Tingkat urgensi pemeriksaan belum ditentukan | Order ditolak. Tingkat urgensi (Rutin atau CITO) wajib dipilih. |
| Pembuat order tidak memiliki kewenangan administratif | Order ditolak. User pembuat order harus terverifikasi sebagai Dokter atau staf klinis/administratif yang berwenang dari unit asal pasien. |
| Tidak ada item tarif/pemeriksaan laboratorium yang disertakan (daftar kosong) | Order ditolak. Minimal satu tarif/pemeriksaan laboratorium harus dipilih. |
| Item yang dipilih bukan merupakan tarif/pemeriksaan laboratorium yang valid | Order ditolak. Hanya tindakan/tarif kategori laboratorium yang dapat diproses dalam OC-08-02. |
| Pembatalan order diajukan tanpa mengisi alasan pembatalan | Pembatalan ditolak. Alasan pembatalan wajib disertakan untuk audit log. |
| Upaya pengubahan (tambah/hapus/ganti item) atau pembatalan pada order yang telah berstatus `Charged` atau status berikutnya | Perubahan atau pembatalan ditolak. Sistem menginformasikan bahwa order telah berstatus `Charged` (*immutable boundary*) dan tidak dapat dimodifikasi atau dibatalkan melalui OC-08-02. |
| Pengubahan order menyebabkan seluruh item pemeriksaan terhapus | Perubahan ditolak. Order harus mempertahankan minimal satu item pemeriksaan laboratorium. Jika seluruh pemeriksaan ditiadakan, order harus melalui alur pembatalan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Order laboratorium yang dikonfirmasi dan tervalidasi tersimpan secara persisten dengan nomor referensi unik dan berstatus awal **`Ordered`**. | Completeness |
| AC-02 | Order laboratorium berstatus `Ordered` memuat informasi wajib: ID Pasien, konteks kunjungan aktif, ID Dokter Requester, identitas Order Creator, indikasi klinis/diagnosis kerja, tingkat urgensi (Rutin/CITO), dan daftar tarif/pemeriksaan laboratorium. | Completeness |
| AC-03 | Jika order dibuat oleh perawat ruangan asal pasien, petugas administrasi poli/bangsal, atau staf klinis terverifikasi lainnya, identitas Order Creator tercatat berbeda dari Dokter Requester, dan Dokter Requester tetap tercatat sebagai pemberi instruksi klinis. | Correctness |
| AC-04 | Pembuatan order ditolak apabila salah satu dari fakta wajib berikut tidak terpenuhi: ID Pasien, konteks kunjungan aktif, ID Dokter Requester, indikasi klinis, tingkat urgensi, atau minimal satu item pemeriksaan laboratorium. | Constraint |
| AC-05 | Item pemeriksaan pada order diverifikasi terhadap master tarif laboratorium dan menolak tarif yang bukan merupakan pemeriksaan laboratorium. | Constraint |
| AC-06 | Selama order masih berstatus `Ordered` (sebelum `Charged`), item pemeriksaan laboratorium dapat ditambah, dikurangi, atau diganti dengan tetap menyisakan minimal satu item pemeriksaan. | Correctness |
| AC-07 | Selama order masih berstatus `Ordered` (sebelum `Charged`), order dapat dibatalkan dengan mencatat status persisten **`Cancelled`**, waktu pembatalan, alasan pembatalan, dan identitas user pembatal untuk audit log. | Correctness |
| AC-08 | Upaya pembatalan order berstatus `Ordered` ditolak apabila alasan pembatalan tidak disertakan. | Exception |
| AC-09 | Upaya pengubahan atau pembatalan order yang telah berstatus `Charged` (atau status lanjutan: `Sample Collected`, `Processing`, `Resulted`, `Released`) ditolak karena `Charged` merupakan *immutable boundary* untuk OC-08-02. | Constraint |
| AC-10 | Pembentukan order laboratorium berstatus `Ordered` tidak mengeksekusi billing, pengambilan spesimen, ataupun penginputan hasil lab, melainkan menyerahkan daur hidup berikutnya ke outcome terkait (`OC-08-03`, `OC-08-04`, `OC-08-05`). | Boundary |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pembebanan biaya pemeriksaan laboratorium (*charging/billing*) saat order berstatus `Charged` → **OC-08-03 Charge**.
- Pengambilan, pelabelan, dan pengelolaan spesimen laboratorium saat order berstatus `Sample Collected` → **OC-08-04 Sample Collection**.
- Pemrosesan teknis laboratorium, pencatatan hasil, verifikasi, dan rilis hasil pemeriksaan laboratorium (`Processing`, `Resulted`, `Released`) → **OC-08-05 Result Management**.
- Registrasi dan permintaan pemeriksaan laboratorium untuk pasien luar/langsung tanpa melalui registrasi kunjungan RS → **OC-08-01 External Registration**.
- Pemakaian barang medis habis pakai (BMHP/reagen) oleh unit laboratorium → **OC-08-06 Pakai Barang**.
- Mutasi barang/reagen antar unit laboratorium atau gudang → **OC-08-07 Mutasi Barang**.
- Stok opname barang/reagen di unit laboratorium → **OC-08-08 Opname**.
- Permintaan/order pemeriksaan dan tindakan selain laboratorium dan radiologi → **OC-05-04 CPOE (Order Pemeriksaan)**.
- Permintaan/order pemeriksaan radiologi dan pencitraan → **OC-09-01 Order Radiologi**.
- Registrasi kunjungan rawat jalan, rawat inap, atau IGD → **Admission Domain** (`ADM-REG`, `OC-01-02`, `OC-01-03`, `OC-07-01`).
- Pengelolaan master data sosial dan identitas pasien → **Pasien Domain** (`PAS-DATSOS`).
- Pengelolaan master data tenaga medis dan PPA → **Organisasi Domain** (`ORG-PPA`).
- Pengelolaan master tarif dan skema tarif laboratorium → **Tata Rekening Domain** (`TRK-TARIF`).

---

## 11. Business Decisions & Clarifications

> Rekam keputusan bisnis resmi yang menyelesaikan pertanyaan klarifikasi pada spesifikasi OC-08-02:

1. **Konteks Kunjungan Pasien (Visit Context)**:
   - *Keputusan Bisnis:* Order laboratorium dalam OC-08-02 terkait dengan kunjungan aktif pasien di lingkungan rumah sakit (Rawat Jalan, Rawat Inap, atau IGD). Permintaan pemeriksaan yang bersumber dari pasien luar atau pendaftaran langsung di laboratorium diakomodir secara khusus melalui **OC-08-01 External Registration**.
2. **Keterangan Klinis dan Diagnosis (Clinical Indication)**:
   - *Keputusan Bisnis:* Indikasi klinis, alasan pemeriksaan, atau diagnosis kerja dokter **wajib dicatat** saat pembentukan order laboratorium sebagai justifikasi medis.
3. **Mekanisme dan Alasan Pembatalan Order**:
   - *Keputusan Bisnis:* Ketika order yang berstatus `Ordered` dibatalkan sebelum tahap `Charged`, status order dicatat secara persisten menjadi **`Cancelled`** disertai pencatatan alasan pembatalan dan identitas pembatal untuk keperluan *audit log*.
4. **Kewenangan Perawat/Petugas Pembuat Order**:
   - *Keputusan Bisnis:* Semua perawat ruangan asal pasien, petugas administrasi poli/bangsal, atau staf klinis terverifikasi lainnya memiliki kewenangan administratif untuk membuat order atas instruksi dokter. Tanggung jawab klinis tetap berada pada Dokter Requester.
5. **Prioritas / Urgensi Pemeriksaan (CITO vs Rutin)**:
   - *Keputusan Bisnis:* Order laboratorium memerlukan penandaan tingkat urgensi (**CITO / Darurat** vs **Rutin**) secara eksplisit pada tahap pembentukan order `Ordered`.
