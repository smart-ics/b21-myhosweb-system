# OUTCOME: Discharge Rawat Inap

| Field       | Value        |
|-------------|--------------|
| Code        | OC-06-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-07   |

---

## 1. Business Purpose

Rumah sakit memerlukan pencatatan operasional yang membuktikan secara sah dan akuntabel bahwa suatu episode pelayanan rawat inap pasien telah berakhir, sehingga episode tersebut resmi ditutup dan tidak lagi berstatus aktif.

**Discharge adalah Operasional Service Event yang mencatat berakhirnya episode pelayanan rawat inap pasien pada suatu unit atau fasilitas pelayanan, sehingga episode pelayanan tersebut tidak lagi berstatus aktif.**

Fokus utama outcome ini adalah **berakhirnya episode pelayanan pasien**, bukan sekadar "pasien pulang" secara fisik. Dalam konteks operasional rumah sakit:
1. Pasien dapat keluar atau mengakhiri episode pelayanan melalui berbagai cara/disposisi bisnis (misalnya: pulang atas izin dokter/sembuh, pulang atas permintaan sendiri/pulang paksa, dirujuk ke fasilitas pelayanan kesehatan lain, meninggal dunia, atau cara keluar lain yang secara bisnis dinyatakan sebagai akhir episode pelayanan).
2. Cara pasien keluar (*disposition*) merupakan atribut informasi bisnis yang melekat pada event Discharge, sedangkan inti dari Outcome adalah **fakta bisnis bahwa episode pelayanan telah berakhir dan ditutup**.
3. Pencatatan ini memastikan organisasi rumah sakit memiliki kepastian operasional bahwa:
   - Episode rawat inap pasien telah selesai dan tidak lagi menerima aktivitas pelayanan baru yang mensyaratkan episode aktif;
   - Unit bangsal rawat inap terakhir tempat pasien dirawat telah melepaskan tanggung jawab operasional perawatan aktif terhadap pasien tersebut;
   - Batas akhir masa perawatan pasien tercatat secara pasti sebagai dasar bagi proses downstream rumah sakit.

Pencatatan Discharge beroperasi dalam siklus hidup (*lifecycle*) pelayanan rawat inap:
`Opname → Episode Rawat Inap Aktif → aktivitas pelayanan (Tindakan, Pakai Bed, Transfer Unit) → Discharge → Episode Selesai`

Aktivitas pelayanan operasional seperti pelaksanaan tindakan klinis, penggunaan bed, dan transfer unit berlangsung selama episode berstatus aktif. Discharge menjadi event penutup yang mengakhiri seluruh rangkaian aktivitas pelayanan aktif pada episode tersebut.

---

## 2. Outcome Statement

> Pertanyaan bisnis utama:
> **“Apakah episode pelayanan rawat inap pasien telah berakhir dan tidak lagi berstatus aktif dengan cara keluar (disposition) yang terverifikasi?”**

**Discharge adalah Operasional Service Event yang mencatat berakhirnya episode pelayanan pasien pada suatu unit atau fasilitas pelayanan rawat inap, sehingga episode tersebut tidak lagi berstatus aktif.**

Outcome ini merepresentasikan fakta operasional yang dapat diverifikasi:
1. Episode pelayanan rawat inap pasien telah berakhir;
2. Episode pelayanan rawat inap tersebut tidak lagi aktif;
3. Terdapat pencatatan resmi bahwa episode telah diakhiri beserta waktu, unit pelayanan terakhir, dan disposition/cara keluar yang terverifikasi.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Rawat Inap (`RNA`) | **Domain Utama (Owner):** Bertanggung jawab atas pencatatan operasional Discharge yang menandai berakhirnya episode pelayanan rawat inap (`RNA-DISCHARGE`). |
| Admission (`ADM`) | **Supporting / Context Domain:** Menyediakan konteks episode rawat inap aktif yang diakhiri (`ADM-REG`). |
| Pasien (`PAS`) | **Supporting / Context Domain:** Menyediakan data identitas pasien yang episode pelayanannya diakhiri (`PAS-DATSOS`). |
| Organisasi (`ORG`) | **Supporting / Context Domain:** Menyediakan referensi unit layanan rawat inap terakhir (`ORG-LAYANAN`) serta data Petugas Pemberi Asuhan / staf yang berwenang mencatat Discharge (`ORG-PPA`). |

> **Catatan Batasan Domain:**
> `RNA Rawat Inap` adalah pemilik utama outcome ini. Domain `ADM`, `PAS`, dan `ORG` berpartisipasi murni sebagai penyedia konteks dan referensi (episode pelayanan, identitas pasien, unit layanan terakhir, dan petugas pencatat). Outcome ini tidak mengambil alih kepemilikan atas pencatatan alokasi tempat tidur (`RNA-BED` pada OC-06-02), pelaksanaan prosedur klinis (`OC-06-01`), perpindahan unit pelayanan (`RNA-TRANSFER` pada OC-06-03), penutupan transaksi keuangan/kasir (`TRK-BILLING`, `TRK-PAYMENT`, `OC-02-04 Reg-Out`), maupun penyusunan ringkasan medis pemulangan (*Discharge Summary*) pada domain rekam medis klinis/EMR.

---

## 4. Participating Capabilities

| Capability | Domain | Status | Konteks Partisipasi |
|------------|--------|--------|---------------------|
| `RNA-DISCHARGE` Discharge | Rawat Inap | Known | Capability utama yang mencatat berakhirnya episode pelayanan rawat inap dan mengakhiri status aktif episode. |
| `ADM-REG` Registration | Admission | Known | Menyediakan konteks episode pelayanan rawat inap aktif yang akan diakhiri. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien yang episode pelayanannya diakhiri. |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Menyediakan referensi unit layanan rawat inap terakhir tempat pasien di-discharge. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan identitas tenaga kesehatan / petugas yang berwenang menetapkan dan mencatat Discharge. |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate
>
> **Catatan Tata Kelola & Otoritas Capability Catalog:**
> Domain Catalog pada `domain/DOMAIN-CATALOG.md` adalah sumber otoritatif tunggal (*authoritative source*). Seluruh capability yang berpartisipasi dalam OC-06-04 telah terdaftar dan berstatus **Known**. Outcome ini tidak membuat, mengusulkan, atau mengubah capability baru secara mandiri. Sesuai aturan `SKILL.md`, jika di kemudian hari timbul kebutuhan capability yang belum tersedia dalam katalog, analis wajib menghentikan proses (STOP) dan melakukan eskalasi kepada Product Owner untuk persetujuan ruang lingkup (*scope approval*).

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Keberadaan episode pelayanan rawat inap yang sah dan sebelumnya berstatus aktif.
- Episode pelayanan rawat inap tersebut dinyatakan berakhir dan status aktifnya dihentikan (episode tidak lagi aktif).
- Waktu Discharge (tanggal dan jam) tercatat secara sah dalam rentang waktu episode rawat inap.
- Unit pelayanan rawat inap terakhir (*last care unit*) tempat pasien mengakhiri masa perawatan teridentifikasi.
- Cara pasien keluar (*disposition*) tercatat dan dapat diverifikasi (misalnya: izin dokter/sembuh/membaik, pulang atas permintaan sendiri/pulang paksa, rujuk ke fasilitas lain, meninggal dunia, atau cara keluar sah lainnya).
- Petugas yang berwenang menetapkan dan mencatat Discharge teridentifikasi.
- Terdapat pencatatan resmi bahwa episode telah diakhiri (rekaman operasional Discharge terbentuk).
- Integritas rekaman historis terpelihara (apabila terjadi koreksi atau pembatalan pencatatan Discharge, fakta historis tidak hilang diam-diam dan audit trail tetap terjaga).

### 5.2 Required Recorded Information

Pencatatan Operational Service Event Discharge harus memuat informasi bisnis esensial berikut secara *implementation-independent*:

- **Identitas Pasien:** Identitas unik pasien yang menjalani perawatan rawat inap.
- **Identitas Episode Rawat Inap:** Identifikasi episode pelayanan rawat inap yang diakhiri.
- **Waktu Discharge:** Tanggal dan jam resmi berakhirnya episode pelayanan rawat inap.
- **Unit Pelayanan Terakhir:** Identifikasi unit bangsal/ruangan rawat inap terakhir tempat pasien di-discharge.
- **Disposition / Cara Pasien Keluar:** Klasifikasi cara pasien mengakhiri masa perawatannya (misalnya: Pulang Sembuh/Izin Dokter, Pulang Atas Permintaan Sendiri / PAPS, Rujuk ke Faskes Lain, Meninggal Dunia, atau disposisi akhir lain yang sah).
- **Petugas Pencatat Discharge:** Identitas petugas/tenaga kesehatan yang berwenang menetapkan atau mencatat event Discharge.
- **Informasi Pendukung Tercatat (Kondisional):** Catatan/keterangan operasional pemulangan, kondisi umum saat keluar (seperti membaik, belum sembuh), faskes tujuan rujukan (jika dirujuk), atau alasan pembatalan/koreksi (apabila terjadi koreksi administratif pasca-pencatatan). Informasi pendukung ini dicatat sebagai data pelengkap operasional tanpa mengubah identitas inti Outcome Discharge.

### 5.3 Required Business Conditions

- Episode pelayanan rawat inap yang diakhiri harus berada dalam kondisi aktif saat Discharge ditetapkan (tidak dapat melakukan Discharge pada episode yang belum mulai, sudah di-discharge sebelumnya, atau telah dibatalkan).
- Satu episode rawat inap aktif hanya memiliki satu event Discharge final.
- Waktu Discharge harus sah secara kronologis (tidak berada di masa depan dan berada pada atau setelah waktu admisi/registrasi rawat inap).
- Unit pelayanan terakhir harus merupakan unit pelayanan rawat inap yang sah dan aktif dalam struktur organisasi rumah sakit.
- Disposition / cara pasien keluar harus merupakan disposisi yang diakui secara bisnis dan dapat diverifikasi.
- Petugas yang mencatat Discharge harus terdaftar dan memiliki wewenang operasional.
- Setelah Discharge tercatat dan episode berakhir, episode tersebut tidak lagi dapat menerima aktivitas pelayanan baru yang mensyaratkan episode aktif (seperti pencatatan tindakan baru, alokasi penggunaan bed baru, atau transfer unit baru).

### 5.4 Completion Proof

Outcome Discharge dinyatakan established apabila:

- **Rekaman operasional Discharge telah berhasil terbentuk dalam sistem**, yang membuktikan bahwa episode pelayanan rawat inap pasien telah resmi berakhir dan tidak lagi aktif.
- Rekaman tersebut memuat waktu Discharge yang sah, unit pelayanan terakhir, disposition yang dapat diverifikasi, dan identitas petugas pencatat yang akuntabel.
- Status episode rawat inap terkonfirmasi telah ditutup/selesai dalam sistem operasional rumah sakit.

---

## 6. Outcome Boundary

### Start

Dimulai ketika terdapat kondisi bisnis bahwa episode pelayanan rawat inap yang aktif memenuhi kondisi untuk diakhiri dan proses Discharge ditetapkan oleh pihak yang berwenang.

### End

Berakhir ketika fakta bisnis bahwa episode pelayanan rawat inap telah berakhir berhasil dicatat dan Discharge memiliki disposition yang dapat diverifikasi.

> **Catatan Batasan Operasional:**
> - Batasan ini menggambarkan *business event/result*, bukan interaksi antarmuka pengguna (seperti penekanan tombol form) atau langkah teknis sistem (seperti eksekusi API endpoint atau database trigger).
> - **Keterkaitan dengan Penggunaan Bed:** Pengakhiran penggunaan tempat tidur dicatat secara terpisah pada **OC-06-02 Pakai Bed** (waktu berakhir penggunaan bed tercatat saat pasien meninggalkan bed). Pelepasan fisik bed dapat dipicu oleh pemulangan, namun pelepasan bed bukan merupakan definisi inti Discharge.
> - **Keterkaitan dengan Administrasi Keuangan:** Penutupan rincian tagihan, pelunasan kasir, atau pelepasan tanggungan pembayaran (*Reg-Out*) dikelola pada domain Tata Rekening (**OC-02-04 Reg-Out**). Kelengkapan administrasi finansial bukan merupakan prasyarat tercapainya fakta operasional penutupan episode rawat inap.
> - **Keterkaitan dengan Dokumentasi Klinis:** Pembuatan resume medis pemulangan (*Discharge Summary*) merupakan tanggung jawab domain rekam medis klinis/EMR dan berada di luar batasan OC-06-04.

---

## 7. Business Constraints

> Aturan bisnis yang harus selalu terpenuhi dan dipertahankan dalam formalisasi Outcome ini.

1. **Pemodelan sebagai Outcome / Persisted Business Result:**
   Discharge dimodelkan secara murni sebagai Outcome (Operasional Service Event), bukan sebagai Use Case interaksi pengguna, bukan sekadar perubahan status teknis, dan bukan atribut statis pada profil pasien.

2. **Outcome Utama Penutupan Episode:**
   Outcome utama Discharge adalah:
   - Episode pelayanan rawat inap pasien berakhir;
   - Episode rawat inap tersebut tidak lagi aktif;
   - Terdapat pencatatan resmi bahwa episode telah diakhiri.

3. **Discharge Bukan Sekadar "Pasien Pulang":**
   Discharge tidak boleh didefinisikan sebagai "pasien pulang" saja. Cara pasien mengakhiri episode pelayanan (*disposition*) dapat beragam:
   - Pulang (sembuh / perbaikan / izin dokter);
   - Pulang atas permintaan sendiri (PAPS / pulang paksa);
   - Dirujuk ke fasilitas pelayanan kesehatan lain;
   - Meninggal dunia;
   - Disposisi lain yang secara bisnis diakui sebagai akhir episode pelayanan.
   Disposition merupakan informasi yang melekat pada event Discharge, bukan pengganti definisi berakhirnya episode.

4. **Transfer Unit Bukan Discharge (Transfer Unit ≠ Discharge):**
   Perpindahan pasien dari satu unit pelayanan ke unit pelayanan lain tidak mengakhiri episode pelayanan rawat inap. Jika episode pelayanan tetap berlanjut di unit baru, event tersebut adalah **Transfer Unit (OC-06-03)**, bukan Discharge.

5. **Discharge Summary Bukan Discharge (Discharge Summary ≠ Discharge):**
   Discharge adalah event/outcome operasional yang menandai berakhirnya episode pelayanan rawat inap. Discharge Summary adalah dokumen atau ringkasan klinis pemulangan yang dikelola oleh domain EMR. Ringkasan klinis bukan merupakan definisi atau syarat pembentukan Outcome Discharge operasional.

6. **Pemisahan dari Detail Klinis Lanjutan:**
   Detail klinis lanjutan seperti rencana kontrol poliklinik, instruksi perawatan di rumah, atau evaluasi terapi lanjutan tidak dimasukkan ke dalam definisi inti Outcome. Informasi tersebut dapat dicatat sebagai data pendukung atau dikelola oleh capability terkait tanpa mengaburkan esensi penutupan episode.

7. **Konteks Spesifik SC-06 Bangsal Rawat Inap:**
   Formalisasi berfokus secara tegas pada berakhirnya **episode pelayanan rawat inap**, menjaga relevansi konteks operasional bangsal rawat inap, dan tidak menggunakan definisi generik yang kehilangan konteks rawat inap.

8. **Kepatuhan pada Model Konseptual Lifecycle:**
   Mengikuti lifecycle operasional pelayanan:
   `Opname → Episode Rawat Inap Aktif → aktivitas pelayanan (Tindakan, Pakai Bed, Transfer Unit) → Discharge → Episode Selesai`
   Discharge adalah event yang mengakhiri episode aktif tersebut.

9. **Prasyarat Episode Pelayanan Aktif:**
   Discharge hanya dapat terjadi pada episode pelayanan rawat inap yang masih berstatus aktif. Episode yang belum mulai, sudah di-discharge sebelumnya, atau berstatus batal tidak dapat di-discharge.

10. **Satu Episode Aktif Memiliki Satu Discharge Final:**
    Satu episode pelayanan rawat inap yang aktif hanya memiliki satu pencatatan Discharge final yang menutup episode tersebut.

11. **Penghentian Aktivitas Layanan Pasca-Discharge:**
    Setelah event Discharge tercatat, episode pelayanan tidak lagi dapat menerima aktivitas pelayanan baru yang mensyaratkan episode aktif (seperti order/tindakan klinis baru, alokasi bed baru, atau transfer unit baru).

12. **Disposition Wajib Terverifikasi:**
    Setiap pencatatan Discharge harus memiliki disposition / cara keluar yang jelas, sah, dan dapat diverifikasi secara bisnis.

13. **Integritas Audit dan Koreksi Bisnis:**
    Koreksi atau pembatalan pencatatan Discharge harus dilakukan melalui mekanisme koreksi bisnis yang sah (*void* / koreksi terkelola) dengan tetap memelihara riwayat audit. Sistem tidak boleh menghapus fakta historis pencatatan Discharge secara diam-diam (*silent delete*).

14. **Pemisahan dari Pengakhiran Pakai Bed:**
    Berakhirnya penggunaan tempat tidur dicatat melalui outcome **OC-06-02 Pakai Bed**. Pelepasan fisik bed dapat menyertai pemulangan pasien, namun keduanya adalah outcome yang terpisah dengan batas tanggung jawab yang berbeda.

15. **Independensi dari Administrasi Finansial / Billing:**
    Pencatatan Discharge sebagai event operasional tidak bergantung pada status pelunasan tagihan kasir. Proses billing, pelunasan pembayaran, dan verifikasi kasir dikelola pada domain Tata Rekening (`TRK-BILLING`, `TRK-PAYMENT`, `OC-02-04 Reg-Out`) dan bukan merupakan syarat mutlak keberadaan event operasional penutupan episode.

---

## 8. Business Exceptions

> Kondisi perkecualian di mana Outcome tidak dapat terbentuk atau memerlukan penanganan bisnis khusus.

| Exception | Expected Behavior |
|-----------|-------------------|
| Episode pelayanan rawat inap tidak aktif (belum terdaftar, sudah di-discharge sebelumnya, atau dibatalkan) | **Pencatatan Discharge ditolak.** Discharge hanya sah dilakukan pada episode rawat inap yang sedang berstatus aktif. |
| Pencatatan Discharge diajukan tanpa cara keluar (*disposition*) yang sah | **Pencatatan ditolak.** Disposition pasien merupakan atribut wajib yang harus terdefinisi dan dapat diverifikasi. |
| Waktu Discharge tidak valid (berada di masa depan atau mendahului waktu masuk/admisi rawat inap) | **Pencatatan ditolak.** Waktu Discharge harus logis secara kronologis dan berada dalam rentang masa perawatan pasien. |
| Petugas pencatat tidak teridentifikasi atau tidak memiliki wewenang operasional | **Pencatatan ditolak.** Discharge harus dilakukan dan dicatat oleh pihak yang berwenang demi akuntabilitas hukum dan operasional. |
| Unit pelayanan terakhir tidak teridentifikasi atau bukan unit rawat inap yang valid | **Pencatatan ditolak.** Unit pelayanan terakhir harus merupakan unit layanan aktif yang terdaftar dalam struktur organisasi rumah sakit. |
| Pengajuan aktivitas pelayanan baru (Tindakan, Pakai Bed, Transfer Unit) pada episode yang telah di-discharge | **Aktivitas pelayanan baru ditolak.** Episode yang telah berstatus selesai/inaktif tidak menerima transaksi baru yang mensyaratkan episode aktif. |
| Upaya pembatalan atau koreksi Discharge diajukan tanpa alasan bisnis yang sah atau mencoba menghapus jejak historis secara langsung | **Tindakan ditolak.** Koreksi Discharge wajib menyertakan alasan bisnis yang dapat diaudit dan riwayat pencatatan sebelumnya harus tetap terpelihara. |
| Dokumen Discharge Summary (resume medis klinis) belum lengkap atau belum ditandatangani dokter saat pasien di-discharge secara operasional | **Fakta operasional Discharge tetap sah terbentuk dan episode rawat inap ditutup.** Keterlambatan atau kelengkapan resume medis diselesaikan pada domain EMR/klinis sesuai regulasi rekam medis tanpa membatalkan fakta operasional penutupan episode. |

---

## 9. Acceptance Criteria

> Kriteria verifikasi terukur yang membuktikan bahwa Outcome Discharge telah terbentuk sesuai spesifikasi bisnis.

| # | Kriteria Penerimaan | Validates |
|---|---------------------|-----------|
| AC-01 | Pasien dan episode pelayanan rawat inap aktif teridentifikasi secara jelas dalam pencatatan Discharge. | Completeness |
| AC-02 | Episode pelayanan rawat inap bertransisi menjadi tidak lagi berstatus aktif (berstatus selesai/ditutup) setelah Discharge berhasil dicatat. | Completeness |
| AC-03 | Waktu Discharge (tanggal dan jam) tercatat secara sah dan terbukti berada dalam rentang waktu kronologis yang valid. | Completeness |
| AC-04 | Unit pelayanan rawat inap terakhir tempat pasien di-discharge tercatat secara akurat sesuai unit tempat pasien terakhir dirawat. | Completeness |
| AC-05 | Disposition / cara pasien keluar (pulang izin dokter, pulang atas permintaan sendiri/PAPS, rujuk faskes lain, meninggal dunia, atau disposisi sah lainnya) tercatat dan dapat diverifikasi. | Correctness |
| AC-06 | Identitas petugas yang menetapkan atau mencatat Discharge tercatat secara akuntabel dalam rekaman operasional. | Completeness |
| AC-07 | Perpindahan pasien dari satu bangsal ke bangsal lain atau ke ICU dalam episode yang sama terbukti dicatat sebagai OC-06-03 Transfer Unit dan tidak menghasilkan event Discharge. | Constraint |
| AC-08 | Ringkasan medis pemulangan (*Discharge Summary*) terbukti terpisah dari definisi operasional Discharge, dan ketiadaan resume medis tidak membatalkan keabsahan outcome Discharge operasional. | Constraint |
| AC-09 | Episode pelayanan yang telah di-discharge terbukti tidak dapat menerima pencatatan aktivitas pelayanan baru yang mensyaratkan episode aktif (seperti order/tindakan baru, penggunaan bed baru, atau transfer unit baru). | Constraint |
| AC-10 | Upaya pencatatan Discharge kedua kali pada episode yang sama atau pada episode yang tidak berstatus aktif ditolak oleh sistem sesuai aturan bisnis. | Exception |
| AC-11 | Koreksi atau pembatalan pencatatan Discharge memelihara riwayat audit bisnis dan tidak menghilangkan fakta historis secara diam-diam. | Constraint |
| AC-12 | Spesifikasi Outcome Discharge dinyatakan secara murni dalam konsep dan aturan bisnis yang *implementation-independent* tanpa bergantung pada skema database, tabel, kolom, API endpoint, formulir UI, atau tipe data teknis. | Correctness |

---

## 10. Out of Scope

> Hal-hal yang secara eksplisit berada di luar tanggung jawab Outcome ini.

- Pendokumentasian resume medis pemulangan (*Discharge Summary*), asesmen medis akhir, resume keperawatan, dan telaah klinis DPJP → **Domain EMR / Rekam Medis Klinis**.
- Pencatatan awal dan berakhirnya penggunaan fisik tempat tidur (*bed*) → **OC-06-02 Pakai Bed** (`RNA-BED`).
- Pengelolaan kebersihan, sterilisasi, dan kesiapan operasional bed pasca-pemulangan pasien → **Rawat Inap Domain** (`RNA-HK`).
- Pencatatan perpindahan pasien antar-unit pelayanan dalam episode rawat inap yang sama → **OC-06-03 Transfer Unit** (`RNA-TRANSFER`, `IGD-RANAP`).
- Pencatatan dan pelaksanaan tindakan atau prosedur medis/keperawatan → **OC-06-01 Tindakan** (`RNA-TINDAKAN`, `ORG-PPA`).
- Penyelesaian administrasi keuangan, penerbitan rincian tagihan akhir, pelunasan pembayaran kasir, dan penutupan akun keuangan pasien (*Reg-Out*) → **OC-02-04 Reg-Out**, **SC-02 Tata Rekening**, **SC-03 Kasir** (`TRK-BILLING`, `TRK-PAYMENT`).
- Pengurusan klaim jaminan asuransi atau BPJS Kesehatan pasca-pemulangan → **Domain BPJS** (`BPJ-VCLAIM`, `BPJ-EKLAIM`).
- Pelacakan pergerakan fisik pasien atau titik alur kunjungan (*patient journey tracking*) → **OC-01-05 Patient Journey Tracking** (`ADM-TRACKER`).
- Desain antarmuka pengguna (UI), tata letak layar, form entri pemulangan, spesifikasi API endpoint, skema relasional tabel database, atau tipe data teknis.
