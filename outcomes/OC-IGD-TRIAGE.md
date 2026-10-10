# OUTCOME: IgdTriage (Penilaian Triase Gawat Darurat)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-IGD-TRIAGE     |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Instalasi Gawat Darurat (IGD) rumah sakit beroperasi dalam lingkungan kritis di mana keselamatan nyawa pasien bergantung pada kecepatan, ketepatan, dan objektivitas penentuan derajat kegawatdaruratan medis (*clinical urgency*). 

Rumah sakit wajib memiliki kemampuan untuk mencatat, menetapkan, memvalidasi, dan mengunci hasil penilaian triase darurat pasien secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan hasil triase gawat darurat memastikan:
1. **Prioritas Klinis Objektif & Terstandarisasi**: Penilaian kegawatdaruratan dilakukan segera saat pasien tiba menggunakan instrumen penilaian klinis terstruktur (berdasarkan protokol *Australasian Triage Scale* / ATS), mengevaluasi parameter jalan napas (*Airways*), pernapasan (*Breathing*), sirkulasi darah (*Circulation*), serta status neurologis kesadaran (*Glasgow Coma Scale* / GCS).
2. **Kepatuhan Gerbang Alokasi Tempat Tidur (*Triage Gate for Bed Allocation*)**: Menjamin kepatuhan aturan bahwa tidak ada pasien IGD yang boleh ditempatkan di tempat tidur observasi/tindakan sebelum penilaian triase selesai dicatat, sehingga tempat tidur darurat diprioritaskan bagi pasien dengan ancaman kegawatan tertinggi.
3. **Penetapan Zona Pelayanan & Waktu Tanggap (*Response Time*)**: Mengelompokkan pasien ke dalam kategori tingkat urgensi ATS 1 s.d. ATS 5 dan kode warna (*Red*, *Yellow*, *Green*, serta *Black* untuk kondisi datang meninggal / *Death on Arrival*), sekaligus menentukan batas waktu respon penanganan medis dan jadwal re-evaluasi triase berkala (*Next Re-Triage*).
4. **Integritas Mediko-Legal Bersifat Append-Only**: Rekam jejak triase disimpan secara permanen dan tidak dapat diubah (*immutable*). Setiap perubahan kondisi klinis atau evaluasi ulang pasien dicatat sebagai entitas re-triase baru dengan nomor urut bertambah, menjaga akuntabilitas medikolegal rumah sakit.
5. **Kesiapan Interoperabilitas Asesmen Medis Terstruktur**: Menyediakan data inti kegawatdaruratan yang siap disinkronisasikan ke dokumen asesmen medis terstruktur (*Structured Medical Assessment* / SMASS) tanpa menghambat alur kerja cepat tenaga medis di IGD.

---

## 2. Outcome Statement

Penilaian tingkat kegawatdaruratan klinis pasien Instalasi Gawat Darurat telah tercatat secara resmi sebagai fakta bisnis persisten (`Emergency Triage Assessment exists`), terverifikasi skor parameter klinis dan kategori prioritasnya, serta siap memandu penempatan tempat tidur observasi dan penanganan medis darurat.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan didukung Contributing Domains terkait:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Gawat Darurat** (`IGD`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab penuh atas pelaksanaan penilaian triase, penghitungan level dan warna kegawatan, penentuan jadwal re-triase, penegakan gerbang triase (*triage gate*) terhadap alokasi tempat tidur, serta pemeliharaan histori triase *append-only*. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data petugas pemeriksa triase—baik dokter jaga IGD maupun perawat terlatih triase—melalui kapabilitas `ORG-PPA`. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan identitas demografi resmi pasien (`PAS-DATSOS`) bagi pasien terdaftar, atau menerima data pengunjung sementara (*Visitor*) melalui konteks kunjungan IGD. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks nomor registrasi administratif (`ADM-REG` / `RegId`) apabila telah terbentuk, atau menerima penautan nomor registrasi administratif di kemudian hari tanpa menunda pencatatan triase. |
| **Rekam Medis Elektronik / Asesmen Terstruktur** (`EMR` / `SMASS`) | **Contributing Domain:** Mengonsumsi data penilaian triase untuk pembentukan formulir asesmen medis terstruktur berbasis konsep klinis terstandarisasi. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `IGD-TRIAGE` Triage | Gawat Darurat | Known | **Primary Capability:** Menghitung skor parameter ABC dan GCS, menentukan level ATS (ATS1–ATS5), menetapkan kode warna kegawatan, memvalidasi override Black oleh dokter, mengkalkulasi waktu re-evaluasi triase, dan mengelola riwayat triase yang tidak dapat diubah (*immutable append-only*). |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known | Menyediakan identitas operasional kunjungan IGD (`IgdVisitId`) sebagai induk konteks pelaksanaan triase dan menerima pembaruan indikator triase aktif (`HasTriage = true`). |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi dan validasi identitas tenaga medis pengkaji triase (*Assessor PPA*) dan dokter jaga penanggung jawab. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien resmi (Nomor RM, nama, tanggal lahir, jenis kelamin) jika pasien sudah terdata di sistem rumah sakit. |
| `ADM-REG` Registration | Admission | Known | Mengaitkan nomor registrasi administratif (`RegId`) jika pendaftaran admisi telah diselesaikan. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Penilaian Triase Gawat Darurat (*Emergency Triage Assessment*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Keterikatan Kuat pada Kunjungan IGD Aktif**:
   - Penilaian triase terikat secara valid ke satu nomor kunjungan operasional IGD (**`IgdVisitId`**) yang berstatus aktif (belum *Discharged*, belum *Redirected*, dan belum *Voided*).
2. **Nomor Urut Triase Runtut (*Append-Only Sequence*)**:
   - Setiap penilaian memiliki nomor urut triase (**`NoTriage`**) unik per kunjungan (dimulai dari `1` untuk triase awal, bertambah berurutan `2, 3, ...` untuk setiap penilaian re-triase).
3. **Kelengkapan Parameter Klinis Terukur**:
   - Tercatat nilai skor komponen fisiologis yang valid:
     - **Airways Score** (0–2): evaluasi kepatenan jalan napas (bebas, terancam, atau tersumbat total).
     - **Breathing Score** (0–5): evaluasi frekuensi, usaha napas, dan kecukupan oksigenasi.
     - **Blood Circulation Score** (0–4): evaluasi hemodinamik, pulsasi nadi, tekanan darah, dan perfusi perifer.
     - **Glasgow Coma Scale (GCS)**:
       - *Eye Response* (1–4)
       - *Motor Response* (1–6)
       - *Verbal Response* (1–5)
4. **Metode Penilaian Terstandarisasi**:
   - Menggunakan metode triase yang diakui resmi oleh rumah sakit (secara *default* **`ATS`** / *Australasian Triage Scale*, dengan rancangan sistem yang mendukung metode lain seperti *ESI*, *CTAS*, atau *MTS*).
5. **Penetapan Level dan Kategori Warna Kegawatan**:
   - Dihasilkan klasifikasi tingkat kegawatan klinis yang definitif:
     - **ATS 1 (Resuscitation)**: Ancaman jiwa segera (*immediate life threat*). Warna: **RED**. Waktu tanggap: segera / 0 menit.
     - **ATS 2 (Emergency)**: Kondisi gawat darurat berat / risiko mengancam jiwa dalam waktu dekat. Warna: **RED**. Waktu tanggap: dalam 10–15 menit.
     - **ATS 3 (Urgent)**: Kondisi darurat berpotensi fatal / nyeri hebat. Warna: **YELLOW**. Waktu tanggap: dalam 30 menit.
     - **ATS 4 (Semi-Urgent)**: Kondisi darurat ringan hingga sedang. Warna: **GREEN**. Waktu tanggap: dalam 60 menit.
     - **ATS 5 (Non-Urgent)**: Kondisi tidak darurat / masalah klinis kronik ringan. Warna: **GREEN**. Waktu tanggap: dalam 120 menit.
6. **Otorisasi Khusus Kategori Kematian (*Black / Deceased*)**:
   - Warna **BLACK** (pasien tiba sudah dalam kondisi meninggal dunia / *Death on Arrival* atau tidak ada respon resusitasi) tidak dihasilkan secara otomatis oleh skor rumus, melainkan wajib melalui **Manual Override Black** oleh Dokter Jaga yang berwenang dengan alasan otentik tertulis.
7. **Penetapan Jadwal Re-evaluasi Triase (*Next Re-Triage Schedule*)**:
   - Sistem menetapkan tanggal dan jam re-evaluasi triase berikutnya (`NextReTriageAt`) berdasarkan level ATS:
     - ATS 1: Pemantauan berkelanjutan (*Continuous monitoring*, tanpa batas waktu statis).
     - ATS 2: Interval 15 menit dari waktu asesmen.
     - ATS 3: Interval 30 menit dari waktu asesmen.
     - ATS 4: Interval 60 menit dari waktu asesmen.
     - ATS 5: Interval 120 menit dari waktu asesmen.
8. **Pengaktifan Indikator Triase Kunjungan (*Triage Fulfillment*)**:
   - Kunjungan IGD induk secara otomatis memiliki indikator `HasTriage = true`, mencatat level dan warna triase aktif terkini, serta mengizinkan proses penempatan tempat tidur (*bed assignment*).

---

### 5.2 Required Recorded Information

Setiap transaksi `IgdTriage` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Kunjungan & Asesmen:
- **`IgdVisitId`**: Nomor unik operasional kunjungan IGD induk.
- **`NoTriage`**: Nomor urut pencatatan triase dalam episode kunjungan tersebut.
- **`AssessmentDateTime`**: Tanggal dan waktu tepat saat pemeriksaan triase dilaksanakan.
- **`AssessorUserId` / PPA**: Pengenal petugas medis (dokter/perawat) yang melakukan penilaian triase.

#### B. Parameter Fisiologis & Neurologis:
- **Skor Fisiologis ABC**:
  - `AirwaysScore` (skala integer 0–2)
  - `BreathingScore` (skala integer 0–5)
  - `BloodCirculationScore` (skala integer 0–4)
- **Skor Neurologis GCS**:
  - `GcsEyeScore` (skala integer 1–4)
  - `GcsMotorScore` (skala integer 1–6)
  - `GcsVoiceScore` (skala integer 1–5)
  - `TotalGcs` (akumulasi skor GCS 3–15)

#### C. Klasifikasi & Hasil Triase:
- **`TriageMethod`**: Metode triase yang diterapkan (`ATS`, `ESI`, `CTAS`, atau `MTS`).
- **`TriageLevel`**: Tingkat kegawatan hasil kalkulasi (`ATS1`, `ATS2`, `ATS3`, `ATS4`, `ATS5`).
- **`TriageColor`**: Kode warna visual prioritas (`RED`, `YELLOW`, `GREEN`, atau `BLACK`).
- **`NextReTriageAt`**: Waktu jatuh tempo untuk penilaian re-triase berikutnya.
- **`Notes`**: Catatan ringkas keluhan utama atau observasi tanda bahaya klinis pengkaji.

#### D. Data Override Black (Kondisi Khusus DOA):
- **`IsManualOverrideBlack`**: Flag penandaan khusus (*true/false*).
- **`OverrideByUserId`**: ID dokter pemeriksa yang menetapkan status Black.
- **`OverrideReason`**: Alasan klinis penetapan (contoh: *Cardiac arrest pre-hospital, lebam mayat, ketiadaan tanda vital*).
- **`OverrideDateTime`**: Tanggal dan jam penetapan override.

---

### 5.3 Required Business Conditions

Untuk menjamin keabsahan dan kepatuhan operasional, kondisi bisnis berikut wajib dipenuhi:

1. **Integritas Status Kunjungan IGD (Non-Terminal)**:
   Penilaian triase hanya dapat dilakukan jika kunjungan IGD berada dalam status aktif (`Daftar` atau `Registered`). Penilaian triase ditolak jika kunjungan telah berstatus `Discharged`, `Redirected`, atau berstatus `Voided`.
2. **Kepatuhan Rentang Skor Klinis**:
   Seluruh input komponen skor ABC dan GCS wajib berada dalam batas nilai integer yang valid sesuai standar pedoman klinis.
3. **Hak Otoritas Penetapan Kategori Hitam (*Black*)**:
   Penetapan warna triase *Black* wajib dilakukan melalui aksi *manual override* dengan mengidentifikasi dokter penanggung jawab (`PpaReff`) dan mencantumkan alasan klinis tertulis. Perawat atau staf administrasi tidak memiliki kewenangan menetapkan status *Black* secara mandiri.
4. **Sifat Catatan Permanen & Nir-Ubah (*Append-Only Immutability*)**:
   Baris data triase yang telah tersimpan dilarang diedit atau dihapus. Apabila terjadi perubahan kondisi klinis pasien (misal pasien memburuk dari Green ke Yellow, atau dari Yellow ke Red), petugas wajib menggunakan fungsi re-triase (*Re-Assess Triage*) yang menghasilkan rekaman baru dengan `NoTriage` berikutnya.
5. **Pemutakhiran State Triase Terkini pada Induk Kunjungan**:
   Pencatatan triase baru otomatis memutakhirkan ringkasan triase terkini (*current triage snapshot*) pada entitas induk `IgdVisit`, meliputi `TriageLevel`, `TriageColor`, `LastTriageAt`, dan `NextReTriageAt`.

---

### 5.4 Completion Proof

Penilaian Triase Gawat Darurat dinyatakan selesai dan sah (*completed and established*) apabila bukti bisnis berikut dapat diverifikasi:

1. Terbentuk rekaman data triase baru dengan nomor urut `NoTriage` yang tersimpan persisten.
2. Indikator `HasTriage` pada entitas kunjungan IGD berubah menjadi `true`.
3. Snapshot tingkat kegawatan (`TriageLevel`) dan kode warna (`TriageColor`) pada kunjungan IGD telah terisi dan selaras dengan rekaman triase terkini.
4. Jadwal `NextReTriageAt` terhitung secara akurat dan tampil pada dashboard pemantauan antrean/triase IGD.
5. Gerbang alokasi tempat tidur IGD terbuka, sehingga pasien memenuhi syarat untuk dialokasikan ke tempat tidur observasi/tindakan (`AssignBed`).

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika:
1. Pasien gawat darurat tiba di area penerimaan/triase IGD; DAN
2. Petugas medis (dokter/perawat) melakukan pemeriksaan fisik awal dan menginput komponen penilaian kegawatdaruratan pada sistem.

### End
Outcome berakhir ketika:
1. Skor triase dihitung, level dan warna prioritas kegawatan ditetapkan, jadwal re-triase diterbitkan, serta seluruh rekaman triase terkunci secara persisten (*persisted append-only*); ATAU
2. Pasien dinyatakan *Death on Arrival* (DOA) melalui otorisasi *Manual Override Black* oleh dokter jaga dengan alasan tertulis dan rekaman triase terkunci.

---

## 7. Business Constraints

Aturan mutlak yang wajib dipatuhi:

1. **Constraint Gerbang Alokasi Tempat Tidur (DR-05)**: Sistem dilarang keras mengizinkan proses penempatan tempat tidur (`AssignBed`) terhadap kunjungan IGD yang belum memiliki minimal satu rekaman triase yang sah (`HasTriage = false`).
2. **Constraint Immutabilitas Riwayat Triase (DR-02)**: Rekaman triase yang telah tersimpan bersifat permanen dan mediko-legal; dilarang keras menyediakan fungsi koreksi/timpa langsung (*in-place update*) atau penghapusan (*delete*) terhadap rekaman triase yang telah ada.
3. **Constraint Alur Re-Triase Berkelanjutan**: Setiap evaluasi ulang kondisi pasien wajib dicatat sebagai rekaman re-triase baru dengan `NoTriage = max(NoTriage) + 1`. Rekaman baru ini menjadi dasar pembaruan prioritas aktif pasien dan batas waktu pemantauan berikutnya.
4. **Constraint Otorisasi Penetapan Black (DR-03)**: Kategori warna *Black* dilarang ditetapkan melalui algoritma skor otomatis. Kategori ini mutlak memerlukan input *manual override* dengan otentikasi dokter penanggung jawab dan penjelasan tertulis.
5. **Constraint Waktu Re-Triase Otomatis (DR-04)**: Nilai `NextReTriageAt` wajib dihitung secara otomatis oleh sistem berdasarkan interval resmi tingkat ATS (ATS1: *continuous*, ATS2: 15m, ATS3: 30m, ATS4: 60m, ATS5: 120m) dari waktu pemeriksaan, untuk memandu pengawasan klinis di dashboard operasional.

---

## 8. Business Exceptions

| Kondisi Pengecualian | Perilaku Bisnis yang Diharapkan (*Expected Behavior*) |
|----------------------|------------------------------------------------------|
| **Kunjungan IGD sudah selesai (*Discharged*) atau dialihkan (*Redirected*)** | Sistem menolak input triase baru dan menampilkan pesan kesalahan bahwa kunjungan telah berada pada status terminal. |
| **Kunjungan IGD telah dibatalkan (*Voided*)** | Sistem menolak pencatatan triase baru dengan pemberitahuan bahwa kunjungan telah berstatus batal (*void*). |
| **Nilai skor ABC atau GCS di luar batas nilai baku** | Sistem menolak penyimpanan data dan mewajibkan pengguna melengkapi seluruh nilai skor sesuai rentang nilai yang ditentukan. |
| **Upaya menetapkan kategori Black tanpa otorisasi dokter / alasan kosong** | Sistem menolak aksi penyimpanan dengan peringatan bahwa penetapan kategori *Black* memerlukan otorisasi dokter yang sah dan alasan klinis wajib diisi. |
| **Terjadi perburukan kondisi klinis pasien secara mendadak sebelum jatuh tempo `NextReTriageAt`** | Petugas medis dapat segera melakukan re-triase seketika (*immediate re-assessment*); sistem segera menerbitkan rekaman triase baru dan memperbarui interval pemantauan yang baru. |
| **Pasien menolak pemeriksaan triase dan meninggalkan IGD (*Walk Out / DAMA*)** | Kunjungan IGD diproses melalui mekanisme penutupan khusus dengan pencatatan berita acara penolakan penanganan; triase tidak dapat dipaksakan terbentuk tanpa data klinis riil. |

---

## 9. Acceptance Criteria

| # | Kriteria Penerimaan (*Criterion*) | Memvalidasi (*Validates*) |
|---|----------------------------------|---------------------------|
| **AC-01** | Sistem berhasil mencatat penilaian triase awal (`NoTriage = 1`) yang terikat pada `IgdVisitId` aktif lengkap dengan nilai komponen skor Airways, Breathing, Circulation, dan GCS. | Completeness |
| **AC-02** | Sistem berhasil menghitung dan menetapkan tingkat ATS (ATS1 s.d ATS5) serta kode warna (Red, Yellow, Green) yang tepat sesuai rumus standar triase ATS. | Correctness |
| **AC-03** | Sistem menolak penempatan tempat tidur (`AssignBed`) pada pasien IGD yang belum memiliki penilaian triase aktif (`HasTriage = false`), dan mengizinkannya setelah triase tersimpan. | Constraint |
| **AC-04** | Pelaksanaan re-triase menghasilkan baris rekaman baru dengan `NoTriage` bertambah secara runtut tanpa mengubah atau menimpa isi rekaman triase sebelumnya (*append-only immutability*). | Constraint & Correctness |
| **AC-05** | Sistem menghitung jadwal re-triase berikutnya (`NextReTriageAt`) secara akurat berdasarkan interval waktu level ATS (ATS2: 15 menit, ATS3: 30 menit, ATS4: 60 menit, ATS5: 120 menit). | Correctness |
| **AC-06** | Penetapan warna Black berhasil diproses hanya jika disertai flag *manual override*, ID dokter pemeriksa, dan alasan klinis yang tidak kosong. | Constraint & Correctness |
| **AC-07** | Sistem menolak pencatatan triase pada kunjungan IGD yang telah berstatus *Discharged*, *Redirected*, atau *Voided*. | Exception |
| **AC-08** | Sistem memperbarui ringkasan triase aktif (`TriageLevel`, `TriageColor`, `LastTriageAt`, `NextReTriageAt`) pada entitas induk kunjungan IGD secara konsisten segera setelah triase baru tersimpan. | Completeness & Correctness |

---

## 10. Out of Scope

Outcome ini secara tegas **TIDAK mencakup**:

1. **Dokumentasi Klinis Lengkap Asesmen Medis & Keperawatan (EMR)**: Anamnesis mendalam, pemeriksaan fisik menyeluruh, riwayat alergi komprehensif, dan Catatan Perkembangan Pasien Terintegrasi (CPPT) dikelola secara mandiri oleh domain Rekam Medis Elektronik (EMR).
2. **Pencatatan Tindakan Medis & Pemakaian Obat/BHP Darurat**: Prosedur resusitasi, tindakan medis IGD, dan konsumsi perbekalan farmasi dikelola oleh kapabilitas `IGD-TINDAKAN` dan tata rekening billing (`TRK-BILLING`).
3. **Pengelolaan Antrean Fisik Panggilan Pasien**: Display layar antrean umum ruang tunggu IGD dan mesin tiket nomor antrean fisik dikelola oleh modul sistem antrean rumah sakit.
4. **Pemberian Persetujuan Tindakan Medis (*Informed Consent*)**: Penandatanganan formulir persetujuan atau penolakan tindakan kedokteran dikelola oleh domain tata kelola medikolegal rekam medis.
