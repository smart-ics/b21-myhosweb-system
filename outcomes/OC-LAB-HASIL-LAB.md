# OUTCOME: HasilLab (Hasil Pemeriksaan Laboratorium Terverifikasi)

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-LAB-HASIL-LAB  |
| Version     | 1.0               |
| Status      | Draft             |
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, memverifikasi secara medis, dan memelihara dokumen hasil pemeriksaan laboratorium (*validated laboratory result*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan Hasil Pemeriksaan Laboratorium Terverifikasi menjamin bahwa parameter analitis yang diuji dari spesimen pasien (*SampleCollection*) telah melewati kendali mutu analitik, dinilai kesesuaiannya terhadap rentang nilai rujukan (*reference range*) berdasarkan usia dan jenis kelamin pasien, diidentifikasi nilai kritisnya (*critical / panic value*), serta disahkan secara medis oleh Dokter Spesialis Patologi Klinik.

Fakta Hasil Laboratorium Terverifikasi ini merupakan fondasi operasional dan legal yang esensial untuk:
1. Menyediakan dasar pertimbangan diagnostik dan evaluasi terapi yang sahih bagi dokter penanggung jawab pelayanan (DPJP) di seluruh unit rawat jalan, rawat inap, gawat darurat, maupun kamar operasi.
2. Mengamankan keabsahan dokumen legal hasil penunjang medik rumah sakit dengan menegakkan aturan ketidakubahan (*immutability*) dan pencatatan versi amandemen (*full snapshot versioning*).
3. Memisahkan secara tegas antara keabsahan klinis-medis (*medical verification*) dengan otorisasi penyerahan dokumen ke pasien (*administrative result release*) yang tunduk pada aturan penyelesaian tagihan (*Billing Clearance* / `TRK-BILLING`).

---

## 2. Outcome Statement

Dokumen hasil pemeriksaan laboratorium atas nama pasien telah dicatat dan diverifikasi secara medis oleh Dokter Spesialis Patologi Klinik sebagai fakta bisnis persisten (`Validated Laboratory Result exists`) dan siap digunakan sebagai dasar pertimbangan klinis serta rilis administratif penyerahan hasil.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Laboratory** (`LAB`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pengelolaan entri nilai analitik, evaluasi nilai rujukan, pemeliharaan versi amandemen, serta otorisasi verifikasi medis hasil laboratorium (`LAB-RESULT`). |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data demografi pasien (`PAS-DATSOS`) seperti jenis kelamin dan tanggal lahir untuk penentuan rentang nilai rujukan yang akurat. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan data kredensial Dokter Spesialis Patologi Klinik sebagai pihak tunggal yang berwenang memvalidasi hasil secara medis (`ORG-PPA`), serta analis laboratorium penginput hasil. |
| **Tata Rekening** (`TRK`) | **Contributing Domain:** Menyediakan otoritas validasi kelayakan rilis administratif (*Billing Release Eligibility*) melalui `TRK-BILLING` saat penyerahan dokumen hasil ke pasien dilakukan. |
| **Pelayanan Klinis** (`RJL` / `RNA` / `IGD` / `EMR`) | **Contributing Domains:** Bertindak sebagai konsumen hasil terverifikasi untuk evaluasi kondisi klinis dan penyesuaian rencana pengobatan pasien. |

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `LAB-RESULT` Lab Result Management | Laboratory | Known | **Primary Capability:** Mengelola perancah komponen hasil, mencatat nilai parameter uji, melakukan flagging otomatis, mengelola versi amandemen, serta mengeksekusi verifikasi medis dan rilis hasil. |
| `LAB-ORDER` Order Lab | Laboratory | Known | Menyediakan referensi order asli yang mendasari pembentukan dokumen hasil. |
| `LAB-COLLECT` Specimen Collection | Laboratory | Known | Memastikan ketersediaan spesimen biologis yang sah dan memenuhi syarat sebagai sumber analit uji. |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan referensi staf analis kesehatan dan kredensial Dokter Spesialis Patologi Klinik penverifikasi. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan snapshot data demografi pasien untuk penetapan interval nilai normal parameter laboratorium. |
| `TRK-BILLING` Billing | Tata Rekening | Known | Menyediakan status kelayakan penyelesaian kewajiban tagihan pasien sebagai syarat gerbang rilis administratif ke pasien. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Hasil Pemeriksaan Laboratorium Terverifikasi (*HasilLab*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Dokumen Hasil Laboratorium Unik**:
   - Terbentuk satu dokumen hasil laboratorium unik (*ResultDocumentId*) dengan nomor versi yang sah (*VersionNumber*).
2. **Keterikatan Tunggal pada Order & Spesimen**:
   - Dokumen hasil terikat secara tepat pada satu permintaan laboratorium (`OrderLabId`) dan spesimen biologis yang sah (`SampleCollectionId`).
3. **Struktur Parameter Hasil Lengkap (Scaffolded Structure)**:
   - Dokumen memuat rincian parameter uji terstruktur yang bersumber dari spesifikasi katalog tes pada order, mencakup nama komponen, satuan (*unit*), dan rentang nilai rujukan (*reference range*).
4. **Kejelasan Nilai Hasil & Tipe Data**:
   - Setiap komponen uji terisi dengan nilai yang valid sesuai tipe datanya (Numerik, Teks, Opsi/Kualitatif, atau Naratif).
5. **Evaluasi Rentang Nilai Rujukan & Flagging Otomatis**:
   - Sistem menetapkan indikator keparahan nilai secara otomatis (*auto-flagging*): **Normal**, **Tinggi (High)**, **Rendah (Low)**, atau **Kritis (Critical / Panic Value)**.
6. **Otorisasi Verifikasi Medis Sah**:
   - Dokumen telah ditelaah dan ditandatangani/diverifikasi secara digital oleh Dokter Spesialis Patologi Klinik yang sah (`ORG-PPA`).
7. **Ketidakterubahan Versi (Immutability & Snapshot Versioning)**:
   - Dokumen hasil yang telah diverifikasi bersifat *immutable* (tidak dapat diubah di tempat). Setiap revisi/koreksi wajib membentuk nomor versi baru dengan mempertahankan riwayat versi terdahulu secara utuh.
8. **Pemisahan Verifikasi Medis vs Rilis Administratif**:
   - Dokumen yang berstatus `Verified` secara otomatis dapat dilihat oleh tim medis internal rumah sakit, namun status rilis ke pasien (*Released*) dikendalikan secara independen melalui verifikasi kelayakan billing (`TRK-BILLING`).
9. **Status Siklus Hidup Definitif**:
   - Dokumen hasil memiliki status operasional definitif: **Terekam (Recorded)**, **Terverifikasi (Verified)**, **Dirilis (Released)**, atau **Diamandemen (Amended)**.

---

### 5.2 Required Recorded Information

Setiap entitas `HasilLab` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Dokumen Hasil & Versi:
- **`ResultDocumentId`**: Identifier unik dokumen hasil laboratorium.
- **`VersionNumber`**: Nomor versi hasil (dimulai dari versi 1; bertambah jika terjadi amandemen).
- **`IsCurrentVersion`**: Penanda boolean apakah rekaman ini merupakan versi operasional paling terkini.
- **`OrderLabId`**: Nomor referensi order laboratorium terkait.
- **`OrderNo`**: Nomor transaksi order operasional laboratorium.
- **`SampleCollectionId`**: Nomor referensi pengambilan spesimen terkait.
- **Snapshot Pasien**:
  - Nomor Rekam Medis (`PatientId`).
  - Nama Lengkap Pasien.
  - Jenis Kelamin dan Tanggal Lahir (serta usia saat tes).

#### B. Rincian Parameter Uji & Nilai Analitik (Item Snapshot):
Daftar seluruh parameter uji yang diperiksa, dengan struktur per baris komponen:
- **`ComponentId`**: Kode unik master komponen uji laboratorium.
- **`TestId` / `TestName`**: Kode dan nama kelompok panel tes laboratorium (misal: Hematologi Lengkap, Fungsi Hati).
- **`ComponentName`**: Nama parameter pemeriksaan (misal: Hemoglobin, Leukosit, SGOT, Glukosa Puasa).
- **`ResultType`**: Tipe data hasil:
  - `Numeric`: Nilai angka (misal: 14.2).
  - `Text`: Keterangan teks singkat (misal: "Positif (+1)").
  - `Option`: Pilihan nilai terstruktur (misal: "Reaktif", "Non-Reaktif").
  - `Narrative`: Catatan mikroskopis/deskriptif panjang.
- **`ResultValue`**: Nilai hasil pemeriksaan riil yang dicatat.
- **`Unit`**: Satuan ukuran resmi (misal: g/dL, /uL, mg/dL, U/L).
- **`ReferenceRangeText`**: Teks rentang nilai rujukan yang berlaku spesifik untuk umur dan jenis kelamin pasien.
- **`FlagStatus`**: Status interpretasi otomatis:
  - `Normal`
  - `Low (L)`
  - `High (H)`
  - `Critical (Panic Value)`
- **`IsMandatory`**: Penanda apakah parameter ini wajib terisi untuk menyelesaikan verifikasi.

#### C. Tanggung Jawab Analitik & Sumber Nilai:
- **`ResultSource`**: Sumber masukan data hasil uji:
  - `Manual`: Diinput manual oleh analis melalui antarmuka sistem.
  - `Instrument`: Ditransfer dari mesin analyzer otomatis.
  - `External-LIS`: Diterima dari integrasi laboratorium rujukan luar.
- **Petugas Analis Penginput**: Identitas staf analis kesehatan yang mencatat nilai awal.
- **Waktu Input Nilai**: Tanggal dan jam pencatatan nilai hasil dilakukan.

#### D. Otorisasi Verifikasi Medis (Patologi Klinik):
- **Dokter Verifikator**: Identitas dan nama Dokter Spesialis Patologi Klinik yang memeriksa dan mengesahkan hasil.
- **Waktu Verifikasi Medis**: Tanggal dan jam pelaksanaan verifikasi medis.
- **Catatan / Ekspertise Patolog**: Kesimpulan klinis atau saran diagnostik tambahan dari dokter patolog klinik (bila ada).

#### E. Rilis Administratif & Riwayat Amandemen:
- **Status Rilis Administratif**:
  - `Unreleased`: Hasil terverifikasi belum diserahkan ke pasien/keluarga.
  - `Released`: Hasil resmi telah diserahkan/dicetak untuk pasien setelah verifikasi kelayakan billing lolos.
  - `Blocked`: Hasil ditahan penyerahannya karena tagihan pasien belum memenuhi syarat kelayakan rilis di `TRK-BILLING`.
- **Waktu Rilis**: Tanggal dan jam penyerahan hasil.
- **Petugas Rilis**: Identitas staf administrasi laboratorium yang merilis hasil.
- **Data Amandemen (wajib ada jika VersionNumber > 1)**:
  - *Versi Sebelumnya*: Referensi ke nomor versi terdahulu yang digantikan.
  - *Dokter Pemohon Amandemen*: Identitas dokter spesialis yang mengotorisasi perubahan hasil.
  - *Alasan Amandemen*: Keterangan resmi penyebab koreksi (misal: kesalahan pengetikan analitis, pengulangan tes atas permintaan klinisi, kalibrasi ulang instrumen).
  - *Waktu Amandemen*: Tanggal dan jam pembentukan versi amandemen.

---

### 5.3 Required Business Conditions

1. **Kelayakan Spesimen**:
   - Perekaman hasil hanya dapat dilakukan terhadap order yang spesimennya telah berstatus `Collected / Received` dan tidak berstatus `Rejected`.
2. **Kelengkapan Parameter Mandatori**:
   - Seluruh komponen pemeriksaan yang ditandai sebagai mandatori (*mandatory*) wajib memiliki nilai yang terisi sebelum dokter patolog dapat mengeksekusi verifikasi.
3. **Eksklusivitas Kewenangan Verifikasi**:
   - Hak otorisasi verifikasi medis pada status `Verified` dibatasi secara mutlak hanya untuk akun pengguna yang terdaftar sebagai Dokter Spesialis Patologi Klinik di `ORG-PPA`.
4. **Prosedur Nilai Kritis (Critical / Panic Value Reporting)**:
   - Jika satu atau lebih parameter menghasilkan flag `Critical`, sistem wajib menandai dokumen secara mencolok dan mewajibkan petugas mencatat bukti pelaporan segera ke dokter DPJP / perawat ruangan.
5. **Kepatuhan Billing Clearance pada Rilis Administratif**:
   - Saat petugas melakukan tindakan rilis (*release attempt*), sistem melakukan validasi langsung ke domain Tata Rekening (`TRK-BILLING`).
   - Apabila Tata Rekening mengembalikan status `CLEAR`, hasil bertransisi menjadi `Released`.
   - Apabila Tata Rekening mengembalikan status `BLOCKED`, hasil tetap berstatus `Verified` dan dapat dilihat oleh staf medis internal RS, namun pencetakan dokumen resmi penyerahan ke pasien diblokir sementara sampai kewajiban keuangan diselesaikan.

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan hasil pemeriksaan laboratorium tersimpan persisten dengan status `Verified` pada versi dokumen aktif (`IsCurrentVersion = true`).
2. Identitas Dokter Spesialis Patologi Klinik penverifikasi beserta stempel waktu verifikasi terekam secara permanen.
3. Seluruh baris parameter uji memiliki nilai, satuan, nilai rujukan, dan flag status yang valid.
4. Dokumen hasil terverifikasi dapat dilihat dan diakses oleh dokter DPJP pada ringkasan rekam medis pasien di rawat jalan, rawat inap, atau IGD.
5. Laporan hasil laboratorium dalam format dokumen resmi (PDF) dapat dihasilkan secara on-demand dengan mencantumkan status versi terkini secara jelas.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)
- **Dimulai saat:** Petugas analis laboratorium atau modul antarmuka alat analyzer mulai mencatat nilai-nilai parameter uji dari spesimen yang telah selesai dianalisis di laboratorium.

### 6.2 End Boundary (Titik Akhir)
- **Berakhir saat:** Seluruh nilai parameter uji divalidasi kelengkapannya, diverifikasi dan ditandatangani secara medis oleh Dokter Spesialis Patologi Klinik, serta tersimpan secara persisten berstatus `Verified`, siap digunakan untuk pengambilan keputusan medis dan penyerahan administratif.

---

## 7. Business Constraints

1. **Kemandirian Immutability Dokumen Terverifikasi**:
   - Sekali dokumen hasil berstatus `Verified`, seluruh baris nilai parameter di dalamnya terkunci permanen. Pengguna dilarang melakukan pembaruan langsung (*in-place update*) terhadap nilai hasil yang sudah diverifikasi.
2. **Kewajiban Full Snapshot Versioning saat Amandemen**:
   - Perubahan atas hasil yang telah diverifikasi wajib dilakukan melalui prosedur amandemen yang menghasilkan dokumen versi baru. Versi baru menyimpan salinan penuh (*full snapshot*) dari seluruh komponen hasil, bukan sekadar perbedaan parsial (*delta diff*), sementara versi terdahulu tetap dipertahankan dengan penanda `IsCurrentVersion = false`.
3. **Pemisahan Validitas Klinis dan Finansial**:
   - Hambatan pembayaran administratif tidak membatalkan keabsahan medis hasil uji. Hasil terverifikasi tetap dapat diakses oleh dokter demi keselamatan nyawa pasien (*clinical visibility preserved*), tetapi pelepasan berkas hasil fisik ke pasien ditahan sampai syarat billing terpenuhi.
4. **Keaslian Nilai Rujukan Historis**:
   - Nilai rujukan yang tercatat pada baris komponen adalah snapshot pada saat pengujian dilakukan dan tidak boleh berubah meskipun master rentang rujukan diubah di kemudian hari.

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: Verifikasi oleh Petugas Non-Patolog** | Pengguna yang bukan Dokter Spesialis Patologi Klinik mencoba mengeksekusi verifikasi medis hasil laboratorium. | Sistem menolak aksi verifikasi dan menampilkan notifikasi bahwa verifikasi hasil hanya berhak dilakukan oleh Dokter Patologi Klinik. |
| **EX-02: Komponen Pemeriksaan Mandatori Kosong** | Dokter mencoba memverifikasi hasil padahal satu atau lebih parameter wajib (*mandatory component*) belum memiliki nilai. | Sistem menolak proses verifikasi dan menandai parameter mana saja yang masih kosong dan harus diisi. |
| **EX-03: Amandemen Hasil Tanpa Alasan Koreksi** | Pengguna membuat amandemen hasil tanpa memasukkan keterangan alasan revisi. | Sistem memblokir pembentukan versi baru dan mewajibkan pengisian alasan amandemen secara jelas. |
| **EX-04: Rilis Administratif Terhalang Tagihan (Blocked by Billing)** | Petugas mencoba merilis hasil resmi ke pasien, namun pengecekan ke Tata Rekening (`TRK-BILLING`) mengembalikan status `BLOCKED` (misal tagihan belum lunas / deposit kurang). | Sistem merespons secara operasional (HTTP 200 normal) dengan memberitahukan bahwa rilis ditahan karena syarat tagihan belum terpenuhi. Status hasil tetap `Verified` dan dapat dilihat staf medis internal, namun dokumen resmi penyerahan ke pasien belum dapat diserahkan. |
| **EX-05: Nilai Hasil Terdeteksi Sebagai Nilai Kritis (Panic Value)** | Nilai analit berada jauh di luar batas normal dan berpotensi mengancam nyawa pasien (misal Kalium 7.5 mEq/L atau Hemoglobin 4.0 g/dL). | Sistem secara otomatis menetapkan flag `Critical`, mewarnai baris hasil secara mencolok, dan memicu formulir konfirmasi pelaporan nilai kritis ke perawat/dokter ruangan. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat dokumen hasil laboratorium baru dengan identifier unik `ResultDocumentId`, terikat pada order dan spesimen yang sah. | Completeness |
| **AC-02** | Seluruh baris parameter uji memuat nilai analitik, satuan, rentang rujukan berbasis usia/gender, serta indikator flag (Normal/Low/High/Critical) yang akurat. | Correctness |
| **AC-03** | Verifikasi medis berhasil dieksekusi oleh Dokter Spesialis Patologi Klinik, mengubah status dokumen menjadi 'Verified', serta mencatat identitas verifikator dan waktu verifikasi secara permanen. | Business Rule (Medical Authority) |
| **AC-04** | Upaya verifikasi oleh staf selain Dokter Patologi Klinik atau saat komponen wajib masih kosong berhasil dicegah dengan pesan penolakan yang tepat. | Exception Handling |
| **AC-05** | Hasil yang telah berstatus 'Verified' terkunci permanen terhadap perubahan langsung; koreksi berhasil membuat dokumen versi baru dengan full snapshot versioning. | Constraint (Immutability & Versioning) |
| **AC-06** | Hasil terverifikasi dengan status tagihan belum lunas (Blocked by Billing) tetap dapat diakses oleh dokter internal, namun penyerahan resmi ke pasien ditahan secara tertib. | Business Rule (Billing Gate) |
| **AC-07** | Parameter yang menyentuh ambang nilai kritis berhasil mendapatkan flag 'Critical' dan memicu pencatatan audit pelaporan nilai kritis. | Safety Rule (Panic Value) |
| **AC-08** | Dokumen hasil laboratorium terverifikasi dapat ditampilkan on-demand dalam format PDF resmi yang mencerminkan versi operasional terkini. | Usability & Downstream Output |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `HasilLab`:

- **Keputusan Klinis Diagnosa Medis Pasien:** Analisis dokter DPJP dalam menetapkan diagnosis penyakit akhir berdasarkan hasil laboratorium (merupakan wewenang DPJP dan domain EMR/Pelayanan Klinis).
- **Prosedur Pengambilan Sampel & Flebotomi:** Pengambilan darah dan penanganan spesimen di ruang sampling (merupakan wewenang `LAB-COLLECT` / Outcome *SampleCollection*).
- **Pembayaran Kasir & Penagihan Piutang:** Transaksi kasir, pelunasan kwitansi, atau klaim asuransi (merupakan wewenang `TRK-KASIR` dan `TRK-BILLING`).
- **Komunikasi Teknis Mesin Analyzer / HL7:** Protokol serial/TCP/IP interfacing mesin dan manajemen kurva kalibrasi instrumen (merupakan wewenang middleware laboratorium / OWR).
