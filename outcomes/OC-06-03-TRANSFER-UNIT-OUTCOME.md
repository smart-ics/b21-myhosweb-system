# OUTCOME: Transfer Unit

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-03     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-07   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan bahwa unit penanggung jawab pelayanan/perawatan pasien telah beralih dari satu unit ke unit lain dalam satu episode pelayanan yang sama.

**Transfer Unit adalah pencatatan perubahan unit pelayanan/perawatan pasien dari unit asal ke unit tujuan dalam satu episode pelayanan.**

Unit tujuan yang dimaksud adalah unit yang menjadi **unit pelayanan/perawatan pasien berikutnya**, bukan sekadar tempat pasien datang untuk mendapatkan layanan.

Fokus outcome ini adalah **fakta bisnis (*business fact*) bahwa unit pelayanan/perawatan pasien telah berubah**, bukan perpindahan fisik pasien semata dan bukan sistem pelacakan pergerakan (*patient tracking* atau *patient journey*). Transfer Unit memastikan bahwa rumah sakit memiliki fakta operasional yang tegas mengenai unit mana yang secara administratif dan operasional bertanggung jawab merawat pasien pada setiap fase dalam episode pelayanan yang aktif.

---

## 2. Outcome Statement

**Unit pelayanan/perawatan pasien dalam satu episode pelayanan telah berubah dari unit asal ke unit tujuan yang menjadi unit pelayanan/perawatan pasien berikutnya.**

Outcome ini merepresentasikan fakta bahwa:
1. Pasien teridentifikasi dalam episode pelayanan yang aktif;
2. Unit pelayanan/perawatan pasien telah berubah dari unit asal ke unit tujuan yang berbeda;
3. Unit tujuan sah menjadi unit pelayanan/perawatan pasien berikutnya dalam episode pelayanan yang sama.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | **Domain Utama (Owner):** Bertanggung jawab atas pengelolaan pencatatan perubahan unit pelayanan/perawatan pasien dan penerimaan di unit perawatan berikutnya (`RNA-TRANSFER`). |
| Gawat Darurat (`IGD`) | **Supporting / Origin Domain:** Bertanggung jawab atas transfer keluar saat pasien beralih dari unit gawat darurat menuju unit rawat inap (`IGD-RANAP`). |
| Admission (`ADM`) | **Supporting / Context Domain:** Menyediakan konteks episode pelayanan aktif tempat terjadinya perubahan unit pelayanan/perawatan (`ADM-REG`). |
| Pasien (`PAS`) | **Supporting / Context Domain:** Menyediakan data identitas pasien yang mengalami perubahan unit pelayanan (`PAS-DATSOS`). |
| Organisasi (`ORG`) | **Supporting / Master Domain:** Menyediakan referensi unit layanan yang sah sebagai unit asal dan unit tujuan (`ORG-LAYANAN`, `ORG-BANGSAL`). |

> **Catatan Batasan Domain:**
> Domain Rawat Inap (`RNA`) adalah pemilik utama outcome ini. Domain `ADM`, `PAS`, dan `ORG` berpartisipasi murni sebagai penyedia konteks dan referensi (episode pelayanan, identitas pasien, dan validitas unit layanan) tanpa memperluas kepemilikan outcome ke domain-domain tersebut. Outcome ini tidak mengambil alih kepemilikan atas pencatatan alokasi tempat tidur (`RNA-BED` pada OC-06-02), pelaksanaan prosedur klinis (`OC-06-01`), pelacakan pergerakan sementara pasien (`ADM-TRACKER`), maupun pemulangan pasien (`RNA-DISCHARGE` pada OC-06-04).

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `RNA-TRANSFER` Transfer Ke Unit Lain | Rawat Inap | Known |
| `IGD-RANAP` Transfer Ranap | Gawat Darurat | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-BANGSAL` Room Bangsal Management | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Capability Catalog:**
> Capability Catalog pada `domain/DOMAIN-CATALOG.md` adalah sumber otoritatif tunggal (*authoritative source*). OC-06-03 tidak membuat atau mengubah Domain/Capability secara sepihak. Seluruh capability yang terlibat telah berstatus **Known** dan merujuk secara ketat pada katalog yang berlaku. Sesuai aturan `SKILL.md`, jika di kemudian hari timbul kebutuhan capability yang belum tersedia dalam katalog, analis wajib menghentikan proses (STOP) dan melakukan eskalasi kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Pasien yang mengalami perubahan unit teridentifikasi dalam episode pelayanan yang aktif.
- Episode pelayanan aktif yang menaungi perubahan unit teridentifikasi.
- Unit pelayanan/perawatan asal (*origin care unit*) teridentifikasi secara sah.
- Unit pelayanan/perawatan tujuan (*destination care unit*) teridentifikasi secara sah dan berbeda dari unit asal.
- Unit tujuan terkonfirmasi sebagai unit pelayanan/perawatan pasien berikutnya.
- Waktu terjadinya perubahan unit pelayanan/perawatan tercatat.
- Fakta operasional bahwa unit pelayanan/perawatan pasien telah beralih ke unit tujuan diakui oleh sistem.

### 5.2 Required Recorded Information

Pencatatan Transfer Unit harus membuktikan informasi bisnis inti berikut secara *implementation-independent* tanpa memasukkan detail transportasi atau proses klinis:

- Identitas pasien.
- Identitas episode pelayanan aktif.
- Unit pelayanan/perawatan asal (*origin care unit*).
- Unit pelayanan/perawatan tujuan (*destination care unit*).
- Waktu terjadinya perubahan unit pelayanan/perawatan (tanggal dan jam efektif).

### 5.3 Required Business Conditions

- Pasien berada dalam episode pelayanan yang aktif (tidak berstatus *discharge*, batal, atau selesai pelayanan).
- Unit asal dan unit tujuan adalah unit pelayanan/perawatan yang sah dalam struktur organisasi rumah sakit.
- Unit tujuan harus berbeda dari unit asal.
- Unit tujuan adalah unit yang menjadi unit pelayanan/perawatan pasien berikutnya, bukan sekadar tempat pasien datang untuk mendapatkan layanan.
- Waktu perubahan unit adalah waktu yang sah dan tidak berada di masa depan.

### 5.4 Completion Proof

> What proves this Outcome is complete?

- Terbukti tercatatnya perubahan unit pelayanan/perawatan pasien dari unit asal ke unit tujuan dalam episode pelayanan aktif.
- Unit tujuan tercatat sebagai unit pelayanan/perawatan aktif pasien berikutnya.
- Unit asal tidak lagi tercatat sebagai unit pelayanan/perawatan aktif pasien.

---

## 6. Outcome Boundary

### Start

Dimulai ketika terjadi pencatatan perubahan unit pelayanan/perawatan pasien dari unit asal ke unit tujuan dalam episode pelayanan yang aktif.

### End

Berakhir ketika perubahan unit pelayanan/perawatan pasien ke unit tujuan telah tercatat dan berlaku efektif.

> **Catatan Batasan:**
> Jika perpindahan unit menyebabkan perubahan bed, perubahan penggunaan bed tersebut bukan merupakan bagian dari batasan outcome ini, melainkan dicatat secara terpisah pada **OC-06-02 Pakai Bed**. Berakhirnya Transfer Unit menandai tuntasnya pencatatan perubahan unit pelayanan/perawatan, bukan selesainya proses fisik perjalanan pasien dan bukan berakhirnya episode pelayanan rawat inap.

---

## 7. Business Constraints

> Aturan bisnis yang menjadi batasan utama (constraints) untuk Outcome ini.

1. **Fokus Tunggal pada Perubahan Unit Pelayanan/Perawatan:**
   Transfer Unit hanya berfokus pada pencatatan perubahan unit pelayanan/perawatan pasien dari unit asal ke unit tujuan. Transfer Unit tidak boleh didefinisikan sebagai pencatatan seluruh perpindahan atau lokasi fisik pasien.
2. **Perpindahan Fisik Sementara Bukan Transfer Unit:**
   Perpindahan fisik sementara untuk memperoleh layanan atau tindakan di unit lain bukan Transfer Unit, selama unit pelayanan/perawatan pasien tetap sama.
   - **Contoh yang BUKAN Transfer Unit:**
     - Rawat Inap → Radiologi untuk pemeriksaan = bukan Transfer Unit.
     - Rawat Inap → Laboratorium untuk pemeriksaan = bukan Transfer Unit.
     - Rawat Inap → Kamar Operasi (OK) untuk operasi = bukan Transfer Unit.
   Pada contoh tersebut pasien hanya berpindah fisik sementara untuk memperoleh layanan/tindakan, bukan berpindah unit pelayanan/perawatan sebagai unit pasien.
3. **Perubahan Bed dalam Unit yang Sama Bukan Transfer Unit:**
   Perubahan atau perpindahan bed di dalam unit pelayanan/perawatan yang sama bukan Transfer Unit.
   - **Contoh:** Perpindahan dari Bed A-01 ke Bed A-05 dalam unit Rawat Inap yang sama adalah domain **OC-06-02 Pakai Bed**, bukan Transfer Unit.
4. **Cakupan Sah Transfer Unit:**
   Perpindahan yang termasuk Transfer Unit adalah perpindahan di mana unit pelayanan/perawatan pasien beralih ke unit berikutnya:
   - IGD → Rawat Inap;
   - Rawat Inap A → Rawat Inap B;
   - Rawat Inap → ICU;
   - ICU → Rawat Inap;
   - Rawat Inap → Ruang Isolasi.
5. **Bukan Patient Tracking atau Patient Journey:**
   Transfer Unit bukan *patient tracking* atau *patient journey*. Tidak perlu memodelkan setiap perpindahan atau jejak fisik pasien.
6. **Bebas dari Detail Proses Klinis dan Transportasi:**
   Tidak memasukkan detail proses klinis atau transportasi seperti alasan klinis, diagnosis, metode transportasi, petugas pengantar, atau detail rute perjalanan fisik pasien.
7. **Bebas dari Klasifikasi Transfer Tambahan:**
   Tidak memasukkan klasifikasi transfer yang tidak diperlukan untuk scope dasar (seperti transfer sementara/permanen, terencana/darurat, atau klasifikasi sejenisnya).
8. **Pemisahan Tegas dari Perubahan Bed:**
   Jika perpindahan unit juga menyebabkan perubahan bed, perubahan bed tersebut bukan merupakan bagian dari definisi Transfer Unit. Keduanya tetap merupakan outcome yang berbeda.
9. **Satu Episode Pelayanan:**
   Transfer Unit berlangsung di dalam satu episode pelayanan yang sama tanpa menutup episode dan tanpa membuka episode baru.
10. **Hubungan Tegas Antar-Outcome (*Zero Overlap*):**
    - **OC-06-01 Tindakan** → mencatat bahwa tindakan/prosedur operasional telah dilakukan.
    - **OC-06-02 Pakai Bed** → mencatat pemakaian/alokasi bed pasien.
    - **OC-06-03 Transfer Unit** → mencatat perubahan unit pelayanan/perawatan pasien.
    - **OC-06-04 Discharge** → mencatat berakhirnya pelayanan/episode sesuai definisinya.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk.

| Exception | Expected Behavior |
|-----------|-------------------|
| Episode pelayanan pasien tidak aktif atau sudah *Discharged* / Batal | **Pencatatan ditolak.** Transfer Unit hanya dapat dilakukan pada pasien dengan episode pelayanan yang masih aktif. |
| Unit tujuan sama dengan unit asal | **Pencatatan ditolak sebagai Transfer Unit.** Apabila terjadi pergantian bed dalam unit yang sama, proses diarahkan ke pencatatan perubahan bed pada OC-06-02 Pakai Bed. |
| Unit tujuan bukan merupakan unit pelayanan/perawatan yang sah dalam master organisasi | **Pencatatan ditolak.** Unit tujuan harus terdaftar, valid, dan aktif sebagai unit pelayanan rumah sakit. |
| Pasien berpindah sementara untuk memperoleh layanan/tindakan (misal ke OK, Lab, Radiologi) tanpa alih unit perawatan | **Pencatatan sebagai Transfer Unit ditolak.** Aktivitas tersebut dicatat sebagai tindakan (OC-06-01) di mana unit perawatan pasien tetap berada di unit asal. |
| Waktu transfer tidak valid (mendahului waktu registrasi/masuk unit asal atau berada di masa depan) | **Pencatatan ditolak.** Waktu transfer harus kronologis dan tidak melampaui waktu saat ini. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Transfer Unit telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validasi |
|---|---------------------|----------|
| AC-01 | Pasien dan episode pelayanan aktif teridentifikasi secara lengkap dalam pencatatan Transfer Unit. | Completeness |
| AC-02 | Unit pelayanan/perawatan asal dan unit tujuan teridentifikasi secara sah dalam struktur organisasi rumah sakit. | Completeness |
| AC-03 | Unit tujuan terbukti berbeda dari unit asal. | Constraint |
| AC-04 | Unit tujuan terkonfirmasi sebagai unit pelayanan/perawatan pasien berikutnya, bukan sekadar unit penerima kunjungan tindakan sementara. | Correctness |
| AC-05 | Waktu perubahan unit tercatat secara valid dan tidak berada di masa depan. | Completeness |
| AC-06 | Setelah Transfer Unit tercatat, unit tujuan resmi menjadi unit pelayanan/perawatan aktif pasien, dan unit asal tidak lagi menjadi unit perawatan aktif. | Correctness |
| AC-07 | Perubahan bed di dalam unit yang sama (misal Bed A-01 ke Bed A-05) tidak menghasilkan pencatatan Transfer Unit. | Constraint |
| AC-08 | Kunjungan sementara ke unit lain untuk tindakan atau pemeriksaan (Radiologi, Laboratorium, OK) tidak menghasilkan pencatatan Transfer Unit. | Constraint |
| AC-09 | Kasus IGD ke Rawat Inap, Rawat Inap A ke Rawat Inap B, Rawat Inap ke ICU, ICU ke Rawat Inap, dan Rawat Inap ke Ruang Isolasi berhasil dicatat sebagai Transfer Unit. | Correctness |
| AC-10 | Pencatatan Transfer Unit tidak memuat detail klinis, metode transportasi, petugas pengantar, atau klasifikasi transfer tambahan yang tidak diperlukan. | Constraint |
| AC-11 | Perubahan penggunaan bed yang menyertai perpindahan unit rawat inap tercatat secara terpisah pada OC-06-02 Pakai Bed dan tidak menjadi bagian dari definisi Transfer Unit. | Constraint |
| AC-12 | Upaya pencatatan transfer unit pada episode yang tidak aktif atau unit tujuan yang tidak sah ditolak oleh sistem sesuai aturan bisnis exception. | Exception |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pencatatan pemakaian dan alokasi tempat tidur (*bed*) pasien → **OC-06-02 Pakai Bed** (`RNA-BED`).
- Pelaksanaan dan pencatatan tindakan/prosedur klinis → **OC-06-01 Tindakan** (`RNA-TINDAKAN`, `ORG-PPA`).
- Pemulangan pasien / akhir episode perawatan → **OC-06-04 Discharge** (`RNA-DISCHARGE`).
- Pelacakan pergerakan fisik pasien atau seluruh titik alur kunjungan (*patient tracking* / *patient journey*) → **OC-01-05 Patient Journey Tracking** (`ADM-TRACKER`).
- Detail proses transportasi dan logistik fisik (metode angkut, brankar, ambulans, petugas pengantar, rute fisik).
- Detail proses klinis, alasan medis, diagnosis, dan serah terima klinis medis/keperawatan (*clinical handover*) → Domain Klinis / EMR.
- Pengelolaan master data instalasi, bangsal, unit layanan, dan ruangan → Organisasi Domain (`ORG-LAYANAN`, `ORG-BANGSAL`).
- Penentuan dan perhitungan tarif kamar / billing tagihan ruang → Tata Rekening Domain (`RNA-CHARGE`, `TRK-TARIF`, `TRK-BILLING`).
