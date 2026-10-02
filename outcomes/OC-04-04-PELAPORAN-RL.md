# OUTCOME: Pelaporan RL (Rekapitulasi Laporan Rumah Sakit)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-04     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap rumah sakit di Indonesia memiliki kewajiban hukum dan regulasi untuk menyusun dan menyampaikan laporan Rekapitulasi Laporan (RL) Rumah Sakit secara periodik kepada Kementerian Kesehatan Republik Indonesia dan Dinas Kesehatan terkait (sebagaimana diatur dalam regulasi perumahsakitan dan pedoman Sistem Informasi Rumah Sakit / SIRS). Laporan RL mencakup seri laporan **RL 1 sampai RL 5** yang merefleksikan seluruh profil kapasitas, ketenagaan, aktivitas pelayanan, morbiditas-mortalitas, dan statistik kunjungan rumah sakit.

Outcome **Pelaporan RL** hadir untuk memastikan bahwa rumah sakit dapat menghasilkan seluruh seri laporan RL 1 sampai RL 5 secara otomatis, terintegrasi, dan konsisten dari data operasional pelayanan yang telah dicatat dalam sistem MyHospital Web sebagai *single source of truth*. Petugas Rekam Medis **tidak melakukan input ulang (*no duplicate entry*) atau membuat data rekaan khusus hanya untuk memenuhi format formulir RL**. Seluruh angka yang dilaporkan merupakan rekapitulasi murni dari fakta pelayanan nyata yang tercatat pada unit-unit kerja rumah sakit.

Untuk menjamin kualitas dan akuntabilitas pelaporan tanpa membebani operasional, outcome ini diperkuat dengan dua pilar pragmatis:
1. **Validasi Kesiapan Data Sumber (*Source Data Readiness Validation*)**: Sistem menyediakan telaah kelayakan data secara informatif dan terarah (*actionable*) sebelum atau saat laporan dihasilkan. Sistem menunjukkan anomali data (seperti episode pelayanan belum dikoding, episode rawat inap belum di-discharge, atau data demografi wajib yang belum lengkap), jumlah kasus terdampak, serta rincian episode pelayanan yang bersangkutan sehingga perbaikan dapat diselesaikan langsung pada modul operasional sumbernya.
2. **Keterlacakan Penuh (*End-to-End Traceability*)**: Setiap angka atau nilai rekapitulasi yang tertera pada laporan RL dapat ditelusuri balik (*drill-down / auditable*) secara transparan hingga ke daftar kasus, nomor rekam medis, nomor registrasi, dan transaksi pelayanan operasional yang membentuknya.

Tanpa formalisasi Pelaporan RL yang terintegrasi dan terlacak:
- Rumah sakit menghadapi risiko inkonsistensi data yang parah antara laporan yang diserahkan ke kementerian dengan kenyataan operasional di lapangan.
- Petugas Rekam Medis terbebani oleh proses kompilasi manual yang lambat, rentan kesalahan manusia (*human error*), serta memicu pembuatan data ganda/fiktif hanya demi memenuhi tenggat waktu pelaporan SIRS.
- Rumah sakit tidak dapat mempertanggungjawabkan angka-angka laporan saat diaudit oleh regulator atau pihak berwenang karena ketiadaan riwayat keterlacakan ke episode pelayanan sumber.
- Ketiadaan validasi kesiapan mengakibatkan data dilaporkan secara tidak lengkap (*under-reporting*) tanpa disadari oleh manajemen rumah sakit.

---

## 2. Outcome Statement

Laporan Rekapitulasi Laporan Rumah Sakit (seri laporan RL 1 sampai RL 5) untuk suatu periode pelaporan yang ditetapkan — yang dikompilasi dan diagregasikan dari data operasional pelayanan rumah sakit yang sah, dilengkapi telaah validasi kesiapan data sumber (*readiness validation*) serta keterlacakan penuh (*traceability*) ke setiap episode pelayanan sumber — **telah terbentuk, terverifikasi konsistensinya, dan terpersistensi secara otoritatif dalam sistem, siap diperiksa, diekspor/dicetak sesuai standar pelaporan Kementerian Kesehatan, dan dilaporkan ke otoritas kesehatan tanpa proses input data manual tersendiri.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama (*Primary Owner*)**: Mengelola kompilasi, agregasi, validasi kesiapan data sumber, pembentukan snapshot berkala, dan persistensi rekaman laporan RL 1–RL 5 melalui kapabilitas `BRM-RL`. Memanfaatkan data kodifikasi morbiditas (`BRM-CODING` dan `BRM-MORBID`) serta formulasi indikator efisiensi pelayanan rumah sakit (`BRM-INDIKATOR`). |
| **Admission** | **Penyedia Konteks Kunjungan & Registrasi**: Menyediakan data volume registrasi, jenis kunjungan (Rawat Jalan, Rawat Inap, IGD), nomor registrasi, alur tracking pasien, dan status kedatangan melalui kapabilitas `ADM-REG` dan `ADM-TRACKER`. |
| **Rawat Inap** | **Penyedia Data Sensus & Kepulangan**: Menyediakan data pemakaian tempat tidur, mutasi ruang rawat, sensus harian bangsal, hari perawatan (`RNA-BED`), serta catatan pemulangan pasien (`RNA-DISCHARGE`) mencakup tanggal/jam pulang, cara pulang (sembuh, dirujuk, APS, meninggal < 48 jam atau >= 48 jam). |
| **Rawat Jalan** | **Penyedia Data Pelayanan Poliklinik**: Menyediakan catatan kehadiran pasien di poliklinik spesialis, konsultasi dokter (`RJL-KONSUL`), dan tindakan medis rawat jalan (`RJL-TINDAKAN`) untuk kebutuhan RL 3 dan RL 5. |
| **Gawat Darurat** | **Penyedia Data Pelayanan Darurat**: Menyediakan data kunjungan unit gawat darurat (`IGD-VISIT`), kategori triage, tindakan darurat (`IGD-TINDAKAN`), rujukan darurat, dan kasus kematian darurat (*Dead on Arrival* / meninggal di IGD). |
| **Laboratorium** | **Penyedia Data Pelayanan Laboratorium**: Menyediakan data volume dan jenis pemeriksaan laboratorium patologi klinik, patologi anatomi, mikrobiologi, dan bank darah (`LAB-RESULT`). |
| **Radiologi** | **Penyedia Data Pelayanan Radiologi**: Menyediakan data volume pemeriksaan radiodiagnostik dan pencitraan medis per modalitas (rontgen konvensional, CT-Scan, USG, MRI) melalui `RAD-EXAM`. |
| **Kamar Operasi** | **Penyedia Data Pelayanan Bedah**: Menyediakan data volume dan klasifikasi tindakan operasi pembedahan (bedah khusus, besar/mayor, sedang/moderat, kecil/minor) serta spesialisasi pembedahan melalui `KMO-OPR`. |
| **Apotek** | **Penyedia Data Pelayanan Kefarmasian**: Menyediakan data transaksi peresepan dan dispensing obat, termasuk volume resep dan proporsi peresepan generik/non-generik melalui `APT-DISPENSING`. |
| **Pasien** | **Penyedia Profil Demografi Pasien**: Menyediakan data kependudukan pasien (`PAS-DATSOS`) mencakup jenis kelamin, tanggal lahir (untuk pemilahan kelompok umur RL), dan wilayah domisili untuk pelaporan morbiditas dan kunjungan. |
| **Organisasi** | **Penyedia Referensi Fasilitas & Ketenagaan**: Menyediakan master unit layanan dan kapasitas tempat tidur operasional (`ORG-LAYANAN`, `ORG-BANGSAL`) untuk RL 1, serta data profil tenaga medis, paramedis, dan non-kesehatan (`ORG-PPA`) untuk RL 2. |
| **Tata Rekening** | **Penyedia Data Cara Bayar**: Menyediakan informasi jaminan dan kepesertaan penjamin pasien (`TRK-JAMINAN`) guna mendukung pelaporan rekapitulasi cara bayar pasien (RL 3.15). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `BRM-RL` Laporan RL | Berkas Rekam Medis | Known |
| `BRM-CODING` Diagnosis/Coding | Berkas Rekam Medis | Known |
| `BRM-INDIKATOR` Indikator RS | Berkas Rekam Medis | Known |
| `BRM-MORBID` Morbiditas Pasien | Berkas Rekam Medis | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `RNA-BED` Pakai Bed | Rawat Inap | Known |
| `RNA-DISCHARGE` Discharge | Rawat Inap | Known |
| `RJL-KONSUL` Konsultasi | Rawat Jalan | Known |
| `RJL-TINDAKAN` Charge Tindakan Klinis | Rawat Jalan | Known |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known |
| `IGD-TINDAKAN` IGD Procedure | Gawat Darurat | Known |
| `LAB-RESULT` Lab Result Management | Laboratory | Known |
| `RAD-EXAM` Examination | Radiology | Known |
| `KMO-OPR` Operative Procedure | Kamar Operasi | Known |
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-BANGSAL` Room Bangsal Management | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Rekapitulasi laporan RL 1 sampai RL 5 untuk periode pelaporan tertentu (Tahunan atau Bulanan/Periodik) telah berhasil dibentuk oleh sistem berdasarkan kompilasi data operasional rumah sakit.
- Setiap angka dan nilai agregat dalam laporan RL 1–RL 5 bersumber murni dari data operasional MyHospital Web tanpa ada penambahan data khusus atau entri fiktif/ganda yang terpisah dari operasional.
- Evaluasi validasi kesiapan data sumber (*source data readiness validation*) telah dieksekusi untuk periode tersebut, menghasilkan status kesiapan data (*Siap / Siap dengan Peringatan / Belum Lengkap*), klasifikasi anomali data, jumlah kasus terdampak, dan daftar kasus konkret yang belum lengkap.
- Setiap angka rekapitulasi memiliki keterlacakan (*traceability*) ke kumpulan data operasional sumber yang membentuknya (daftar episode registrasi, No RM, dan detail transaksi).
- Status rekaman laporan RL tercatat secara definitif dalam sistem (*Draft Rekapitulasi*, *Terverifikasi*, atau *Final/Terkunci*).
- Riwayat kompilasi dan finalisasi laporan tersimpan dalam jejak audit resmi yang memuat identitas petugas, parameter periode, tanggal/jam eksekusi, serta catatan kelayakan data.

### 5.2 Required Recorded Information

#### A. Metadata Periode & Status Laporan RL
- Identitas Faskes: Kode Rumah Sakit resmi Kemenkes, Nama Rumah Sakit, dan Kelas Rumah Sakit.
- Parameter Periode Pelaporan: Jenis Periode (Tahunan, Semesteran, Triwulanan, Bulanan), Tahun Pelaporan (misal: 2026), dan Bulan Pelaporan (bila periodik bulanan).
- Rentang Tanggal Data Operasional: Tanggal awal dan tanggal akhir pencakupan data pelayanan.
- Waktu Pembentukan Rekapitulasi (*Generation Timestamp*).
- Petugas Penanggung Jawab Rekapitulasi: ID dan nama staf Rekam Medis yang melakukan kompilasi/telaah.
- Status Siklus Laporan:
  - *Draft Rekapitulasi*: Laporan baru dibentuk dari data operasional berjalan.
  - *Terverifikasi*: Laporan telah ditelaah oleh staf Rekam Medis bersamaan dengan hasil validasi kesiapan data.
  - *Final / Terkunci*: Laporan telah disetujui untuk pelaporan resmi, snapshot data dibekukan dari modifikasi otomatis.

#### B. Rekapitulasi Seri Laporan RL 1 s/d RL 5
- **RL 1 (Data Dasar & Pelayanan Umum Rumah Sakit):**
  - *RL 1.1 Data Dasar Rumah Sakit*: Informasi profil statis rumah sakit, kepemilikan, akreditasi, izin operasional, dan kapasitas total tempat tidur.
  - *RL 1.2 Indikator Pelayanan Rumah Sakit*: Nilai kalkulasi indikator standar statistik rumah sakit yang terhitung otomatis dari akumulasi sensus dan hari perawatan:
    - *Bed Occupancy Rate (BOR)* (persentase pemakaian tempat tidur).
    - *Average Length of Stay (ALOS)* (rata-rata lama rawat pasien rawat inap dalam hari).
    - *Bed Turn Over (BTO)* (frekuensi pemakaian tempat tidur dalam satu periode).
    - *Turn Over Interval (TOI)* (rata-rata hari tempat tidur kosong sebelum terisi kembali).
    - *Net Death Rate (NDR)* (angka kematian >= 48 jam rawat per 1.000 pasien keluar).
    - *Gross Death Rate (GDR)* (angka kematian total per 1.000 pasien keluar).
  - *RL 1.3 Fasilitas Tempat Tidur Rawat Inap*: Rekapitulasi jumlah tempat tidur operasional menurut kelas rawat inap (VVIP, VIP, Kelas 1, Kelas 2, Kelas 3) dan ruang khusus/intensif (ICU, ICCU, NICU, PICU, Isolasi, HCU, Perinatologi).
- **RL 2 (Ketenagaan Rumah Sakit):**
  - Rekapitulasi jumlah kuantitas tenaga kerja rumah sakit berdasarkan kualifikasi resmi:
    - Tenaga Medis: Dokter Sub-Spesialis, Dokter Spesialis, Dokter Umum, Dokter Gigi Spesialis, Dokter Gigi.
    - Tenaga Keperawatan & Kebidanan: Perawat Spesialis, Perawat Primer/Vokasi, Bidan.
    - Tenaga Kefarmasian: Apoteker, Tenaga Teknis Kefarmasian.
    - Tenaga Kesehatan Lainnya: Pranata Laboratorium, Radiografer, Fisioterapis, Nutrisionis/Dietisien, Perekam Medis dan Informasi Kesehatan.
    - Tenaga Non-Kesehatan: Manajemen, Administrasi, IT, Pemeliharaan Sarana, Keamanan, Logistik.
    - Status Ketenagaan: Pegawai Tetap, Pegawai Kontrak, Pegawai Tamu/Mitra, jenis kelamin, dan status keaktifan.
- **RL 3 (Pelayanan Kegiatan Rumah Sakit):**
  - *RL 3.1 Rawat Inap*: Rekapitulasi per spesialisasi/instalasi rawat inap memuat: Pasien Awal, Pasien Masuk, Pasien Pindahan, Pasien Dipindahkan, Pasien Keluar Hidup, Pasien Keluar Mati (< 48 jam dan >= 48 jam), Pasien Akhir Periode, Jumlah Lama Dirawat, dan Akumulasi Hari Perawatan.
  - *RL 3.2 Rawat Darurat (IGD)*: Total kunjungan pasien IGD, pemilahan kasus (Bedah, Non-Bedah, Kebidanan, Psikiatri, Anak), tindak lanjut pelayanan (Dirawat Inap, Dirujuk ke Faskes Lain, Pulang, Meninggal di IGD, *Dead on Arrival* / DOA).
  - *RL 3.3 Pelayanan Gigi & Mulut*: Rekapitulasi volume tindakan tumpatan, ekstraksi, perawatan saluran akar, pembersihan karang gigi (scaling), dan tindakan bedah mulut.
  - *RL 3.4 Kebidanan*: Rekapitulasi persalinan normal, persalinan dengan komplikasi/penyulit, tindakan sectio caesarea, tindakan abortus, serta penanganan komplikasi obstetri.
  - *RL 3.5 Perinatologi*: Jumlah bayi lahir hidup, pengelompokan berat badan lahir (< 2.500 gram dan >= 2.500 gram), angka kematian perinatal/neonatal, kejadian asfiksia, dan kelainan bawaan.
  - *RL 3.6 Pembedahan*: Rekapitulasi tindakan pembedahan per spesialisasi bedah menurut kategori tingkat keparahan operasi: Bedah Khusus, Bedah Besar (Mayor), Bedah Sedang (Moderat), dan Bedah Kecil (Minor).
  - *RL 3.7 Radiologi*: Jumlah pemeriksaan diagnostik pencitraan menurut modalitas: Rontgen Tanpa Kontras, Rontgen Dengan Kontras, CT-Scan, Ultrasonografi (USG), MRI, dan tindakan radiologi intervensional.
  - *RL 3.8 Laboratorium*: Jumlah tindakan pemeriksaan laboratorium patologi klinik (hematologi, kimia klinik, serologi, urinalisis), patologi anatomi (histopatologi, sitologi), mikrobiologi, serta pengelolaan darah/transfusi.
  - *RL 3.9 Rehabilitasi Medik*: Volume tindakan pelayanan fisioterapi, terapi okupasi, terapi wicara, ortotik-prostetik, dan psikologi rehabilitasi.
  - *RL 3.10 Pelayanan Khusus*: Volume tindakan hemodialisa, endoskopi gastrointestinal, bronkoskopi, kateterisasi jantung (Cath Lab), kemoterapi, dan terapi hiperbarik.
  - *RL 3.11 Kesehatan Jiwa*: Volume tindakan konsultasi psikiatri, psikoterapi, elektrokonvulsi (ECT), dan napza.
  - *RL 3.12 Keluarga Berencana*: Jumlah akseptor KB baru dan ulangan menurut metode kontrasepsi (IUD, Implant, MOW, MOP, Suntik, Pil, Kondom).
  - *RL 3.13 Farmasi*: Volume penulisan dan dispensing resep, proporsi resep obat generik vs non-generik, serta kepatuhan peresepan terhadap formularium nasional/rumah sakit.
  - *RL 3.14 Rujukan*: Rekapitulasi rujukan masuk (dari Puskesmas, Dokter Praktek Mandiri, RS lain) dan rujukan keluar (ke RS vertikal/faskes tingkat lanjut) menurut status rujukan diterima/dikembalikan.
  - *RL 3.15 Cara Bayar*: Rekapitulasi jumlah pasien dan kunjungan rawat jalan serta rawat inap berdasarkan kelompok penjamin pembiayaan (BPJS Kesehatan PBI, BPJS Kesehatan Non-PBI, Asuransi Komersial, Ikatan Kerja Sama Perusahaan, Biaya Sendiri/Umum, Jamkesda/Bantuan Sosial).
- **RL 4 (Morbiditas dan Mortalitas Pasien):**
  - *RL 4a Morbiditas Pasien Rawat Inap*: Rekapitulasi tabulasi penyakit berdasarkan kode diagnosis utama ICD-10 menurut Daftar Tabulasi Dasar Kemenkes:
    - Distribusi kelompok umur pasien keluar (< 28 hari, 28 hari - < 1 tahun, 1-4 tahun, 5-14 tahun, 15-24 tahun, 25-44 tahun, 45-64 tahun, >= 65 tahun).
    - Distribusi jenis kelamin (Laki-laki / Perempuan).
    - Jumlah pasien keluar hidup.
    - Jumlah pasien keluar mati.
  - *RL 4b Morbiditas Pasien Rawat Jalan*: Rekapitulasi tabulasi penyakit berdasarkan kode diagnosis utama ICD-10 menurut Daftar Tabulasi Dasar Kemenkes:
    - Distribusi kelompok umur pasien rawat jalan.
    - Distribusi jenis kelamin (Laki-laki / Perempuan).
    - Jumlah kasus baru (pertama kali terdiagnosis penyakit tersebut).
    - Jumlah kasus lama (kunjungan ulang untuk penyakit yang sama).
- **RL 5 (Pengunjung dan Kunjungan Rumah Sakit):**
  - *RL 5.1 Pengunjung Rumah Sakit*: Jumlah total pengunjung baru (pertama kali berobat di rumah sakit) dan pengunjung lama.
  - *RL 5.2 Kunjungan Rawat Jalan*: Jumlah total kunjungan per poliklinik / unit spesialisasi rawat jalan.
  - *RL 5.3 Daftar 10 Besar Penyakit Rawat Inap*: Pemeringkatan 10 penyakit dengan frekuensi kasus terbanyak pada pasien rawat inap beserta jumlah kasus dan jumlah kematian.
  - *RL 5.4 Daftar 10 Besar Penyakit Rawat Jalan*: Pemeringkatan 10 penyakit dengan frekuensi kasus terbanyak pada pasien rawat jalan beserta pemisahan kasus baru dan kasus lama.

#### C. Catatan Validasi Kesiapan Data Sumber (*Readiness Validation Record*)
- Status Kelayakan Data Global: *Data Ready (100% Siap)*, *Ready with Warnings (Siap dengan Catatan)*, atau *Incomplete Data (Data Belum Memenuhi Batas Minimum)*.
- Ringkasan Metrik Kesiapan:
  - Total episode pelayanan dalam periode.
  - Jumlah episode pelayanan yang memenuhi syarat kompilasi utuh.
  - Jumlah episode pelayanan yang mengalami kendala/anomali data.
  - Persentase kesiapan data operasional (% Readiness Score).
- Daftar Kategori Anomali Data yang Ditemukan:
  - *Uncoded Episodes*: Jumlah episode kunjungan/rawat yang telah selesai secara operasional namun belum memiliki penetapan kode ICD-10 definitif dari `BRM-CODING`.
  - *Unclosed Inpatient Episodes*: Pasien rawat inap yang secara fisik telah meninggalkan bangsal tetapi status administrasinya belum di-discharge atau belum memiliki tanggal/jam keluar dan cara pulang di `RNA-DISCHARGE`.
  - *Missing Mandatory Demographics*: Episode pelayanan yang pasiennya tidak memiliki kelengkapan tanggal lahir/usia atau jenis kelamin pada `PAS-DATSOS`.
  - *Unclassified Procedures*: Tindakan medis/operasi yang belum memiliki penandaan kategori keparahan pembedahan di `KMO-OPR` atau belum memiliki koding ICD-9-CM.
  - *Unmapped Operational Units*: Transaksi operasional yang terjadi pada unit layanan yang belum dipetakan ke referensi instalasi/spesialisasi standar RL Kemenkes.
- Detail Kasus Terdampak (*Actionable Impacted Cases*):
  - Nomor Rekam Medis (No RM).
  - Nomor Registrasi Kunjungan / Episode ID.
  - Nama Pasien.
  - Unit Pelayanan Asal (Nama Poli/Bangsal).
  - Tanggal Pelayanan.
  - Nama Dokter Penanggung Jawab Pelayanan (DPJP).
  - Jenis Masalah Data dan Petunjuk Tindakan Koreksi pada modul sumber.

#### D. Metadata Keterlacakan Data Sumber (*Traceability References*)
- Referensi Tautan Agregasi: Setiap sel/angka pada tabel rekapitulasi RL 1–RL 5 menyimpan daftar kunci penelusuran (*trace keys*) ke data operasional:
  - Kumpulan ID episode registrasi pelayanan yang berkontribusi pada angka tersebut.
  - Tautan ke entitas transaksi operasional terkait (misal: ID sensus tempat tidur, ID tindakan pembedahan, ID pemeriksaan penunjang).
- Tingkat Kedalaman Penelusuran (*Drill-down path*):
  `Nilai Rekapitulasi RL` → `Daftar Pasien & Episode Pelayanan` → `Detail Rekam Medis / Transaksi Operasional Sumber`.

### 5.3 Required Business Conditions

- **Prinsip Kebenaran Tunggal (*Single Source of Truth*)**: Angka dalam laporan RL 1 sampai RL 5 harus merupakan hasil agregasi kalkulasi sistem dari data operasional MyHospital Web. Tidak diperbolehkan adanya fitur modifikasi angka langsung (*direct inline editing*) pada tabel rekapitulasi laporan RL tanpa melalui perubahan data transaksi sumber.
- **Tanpa Entri Khusus RL (*Zero Redundant Entry*)**: Petugas Rekam Medis dilarang dibebani tugas melakukan input data ulang atau entri data pendukung fiktif yang semata-mata dibuat untuk memenuhi formulir RL. Setiap kebutuhan data RL wajib berhulu pada data transaksi operasional yang sah di unit pelayanan.
- **Koreksi Data Berada di Modul Sumber (*Source-Unit Correction*)**: Jika proses validasi kesiapan menunjukkan adanya data yang belum lengkap (misalnya episode belum dikoding atau cara pulang belum diisi), perbaikan data harus diselesaikan pada modul operasional yang berwenang (misal pada modul Casemix & Coding untuk koding, atau modul Rawat Inap untuk kepulangan). Pelaporan RL tidak menyediakan mekanisme *patching* atau perbaikan data operasional secara lokal.
- **Kompilasi Non-Blocking (*Pragmatic Readiness*)**: Ketiadaan kelengkapan data operasional tidak memblokir pembentukan laporan RL secara absolut. Sistem tetap mengizinkan pembentukan rekapitulasi data yang tersedia, dengan catatan laporan tersebut secara wajib menyertakan laporan validasi kesiapan data (*readiness disclaimer*) yang menegaskan batasan kelengkapan dan jumlah kasus yang belum dapat direkap.
- **Konsistensi Batas Waktu Periode**: Kriteria penarikan data transaksi operasional harus mematuhi batasan tanggal periode pelaporan secara ketat:
  - Pelayanan Rawat Jalan dan Gawat Darurat didasarkan pada tanggal kedatangan/registrasi kunjungan pada periode tersebut.
  - Pelayanan Rawat Inap untuk morbiditas (RL 4a) dan mortalitas didasarkan pada pasien yang pulang (*discharge date*) pada periode tersebut.
  - Pelayanan sensus hari perawatan (RL 1.2 dan RL 3.1) didasarkan pada akumulasi hari rawat aktual pasien selama berada dalam rentang tanggal periode pelaporan.
- **Kekekalan Snapshot Final (*Final Snapshot Immutability*)**: Ketika suatu laporan RL telah diverifikasi dan ditetapkan ke dalam status *Final / Terkunci*, rekapitulasi laporan tersebut dibekukan (*immutable*). Perubahan atau transaksi susulan yang terjadi pada data operasional di kemudian hari tidak boleh mengubah angka rekapitulasi historis yang telah difinalisasi, kecuali dilakukan proses *Kompilasi Ulang Resmi (Amandemen)* yang menghasilkan versi revisi baru dengan pencatatan audit trail yang sah.

### 5.4 Completion Proof

- Seluruh seri laporan RL 1 sampai RL 5 untuk periode pelaporan yang dipilih telah terbentuk dan terisi angka rekapitulasinya secara otomatis dari data operasional.
- Laporan validasi kesiapan data sumber tersedia secara utuh, menampilkan ringkasan kelayakan data, identifikasi masalah, jumlah kasus terdampak, serta daftar kasus konkret yang dapat diekspor untuk tindak lanjut unit terkait.
- Bukti keterlacakan (*traceability proof*) dapat diuji: memilih salah satu angka pada laporan RL menyajikan daftar kasus dan episode pelayanan yang membentuk angka tersebut.
- Hasil laporan RL siap disajikan, dicetak, atau diekspor ke dalam format dokumen dan berkas elektronik standar pelaporan resmi SIRS Kementerian Kesehatan RI.
- Status rekapitulasi periode tercatat sebagai *Terverifikasi* atau *Final/Terkunci* lengkap dengan stempel waktu dan identitas petugas yang bertanggung jawab.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas Rekam Medis (atau jadwal berkala sistem) menginisiasi proses pembentukan laporan RL untuk suatu periode pelaporan tertentu (menentukan tahun, bulan, atau rentang periode) dan sistem mulai melakukan penarikan serta evaluasi data operasional rumah sakit yang relevan.

### End

Berakhir ketika:
1. Rekapitulasi seri laporan RL 1–RL 5 untuk periode tersebut telah terbentuk secara lengkap dari data operasional MyHospital Web;
2. Evaluasi validasi kesiapan data sumber (*readiness validation*) telah diterbitkan dan menyajikan rincian kesiapan serta daftar anomali kasus yang terdampak;
3. Tautan keterlacakan (*traceability links*) antara angka agregat laporan dengan episode pelayanan sumber telah terpersistensi;
4. Laporan telah ditelaah dan berstatus resmi (*Terverifikasi* atau *Final/Terkunci*), siap disajikan, diekspor, atau dicetak untuk pemenuhan pelaporan resmi rumah sakit ke Kementerian Kesehatan RI.

---

## 7. Business Constraints

- **Keaslian Data Operasional (*Authentic Operational Derivation*)**: Angka laporan RL wajib dihasilkan secara deterministik dari transaksi operasional. Sistem dilarang menyediakan mekanisme pengubahan angka agregat (*override / bypass*) secara manual tanpa bukti transaksi operasional.
- **Karakteristik Read-Only Terhadap Operasional**: Domain Pelaporan RL bersifat murni membaca (*read-only*) terhadap data operasional rumah sakit. Outcome ini tidak memiliki hak untuk menambah, memodifikasi, atau menghapus catatan klinis, transaksi keuangan, atau status registrasi pasien di modul operasional sumber.
- **Kepatuhan Terhadap Standar Baku SIRS Kemenkes**: Struktur pengelompokan klasifikasi, pembagian kelompok umur, pengelompokan diagnosa/tindakan, dan rumus indikator efisiensi pelayanan rumah sakit wajib tunduk pada pedoman teknis pelaporan Kementerian Kesehatan RI yang sah.
- **Sifat Validasi Informatif, Bukan Engine Tata Kelola Kompleks**: Validasi kesiapan data dirancang secara pragmatis dan langsung (*actionable informational validation*). Outcome ini tidak menyelenggarakan workflow assignment PIC kualitas data, sistem penilaian data governance yang rumit, atau generic rule engine yang membebani sistem.
- **Kemandirian Format Ekspor/Cetak**: Penyajian, pencetakan, dan ekspor laporan ke berbagai format (PDF, Excel, format pertukaran SIRS Kemenkes) merupakan mekanisme interaksi yang mengonsumsi hasil akhir outcome ini dan tidak boleh mengubah angka rekapitulasi yang telah terbentuk.
- **Integritas Jejak Audit (*Auditability*)**: Seluruh riwayat pembentukan laporan, tanggal kompilasi, status kesiapan data saat kompilasi, dan penetapan status final harus terdokumentasi dalam jejak audit yang tidak dapat dimanipulasi.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Episode pelayanan rawat inap/jalan telah selesai secara fisik tetapi belum dikoding (status *Uncoded*) saat batas waktu pelaporan tiba** | Sistem tetap mengompilasi laporan RL berdasarkan data kasus yang telah terkoding, dan secara transparan mencantumkan jumlah kasus yang belum terkoding beserta daftar No RM/registrasi pada laporan validasi kesiapan (*readiness report*), sehingga petugas dapat mengoordinasikan penyelesaian koding di modul Casemix & Coding (`BRM-CODING`). |
| **Pasien rawat inap telah meninggalkan ruangan tetapi belum diproses *Discharge* secara administratif di bangsal** | Episode rawat inap tersebut belum dapat dihitung sebagai pasien keluar hidup/mati dan hari rawat akhirnya belum tuntas. Sistem mengidentifikasi episode ini dalam daftar peringatan validasi kesiapan agar unit rawat inap (`RNA-DISCHARGE`) segera menyelesaikan administrasi kepulangan pasien. |
| **Data demografi pasien sumber tidak lengkap (misal tanggal lahir/usia kosong atau jenis kelamin tidak tercatat)** | Kasus terkait dimasukkan ke dalam kategori agregasi "Tidak Terdefinisi / Data Tidak Lengkap" pada tabulasi umur/gender, dan dimunculkan sebagai item anomali pada laporan validasi kesiapan agar unit pendaftaran (`PAS-DATSOS`) melengkapi profil data sosial pasien. |
| **Tindakan operasi pembedahan belum memiliki klasifikasi kategori tingkat kesulitan (khusus, besar, sedang, kecil)** | Volume tindakan tetap terhitung pada total operasi, namun dikelompokkan ke dalam kategori "Belum Terklasifikasi" pada RL 3.6, serta dilaporkan dalam temuan validasi kesiapan agar unit kamar operasi (`KMO-OPR`) melengkapi klasifikasi prosedur. |
| **Terdapat transaksi pelayanan pada unit layanan yang belum dipetakan ke referensi instalasi/spesialisasi standar Kemenkes** | Sistem menandai transaksi tersebut dalam kelompok "Unit Belum Terpetakan (*Unmapped Unit*)" dan menyajikan peringatan validasi agar administrator organisasi (`ORG-LAYANAN`) melengkapi pemetaan kode unit ke referensi standar pelaporan SIRS. |
| **Terjadi penambahan atau perbaikan data operasional pada periode yang laporannya telah berstatus *Final / Terkunci*** | Sistem menolak perubahan otomatis pada snapshot laporan yang telah dikunci guna menjaga integritas laporan resmi yang telah diserahkan ke kementerian. Jika diperlukan pembaruan, petugas Rekam Medis harus menjalankan prosedur *Amandemen Laporan* resmi yang membentuk versi revisi baru (misal V1.1) dengan alasan perubahan tercatat dalam jejak audit. |
| **Periode pelaporan yang dipilih tidak memiliki transaksi pelayanan operasional sama sekali (faskes baru / layanan non-aktif)** | Sistem menghasilkan laporan RL dengan nilai nol (nihil) secara valid dan sah, disertai keterangan kesiapan data bahwa tidak ditemukan aktivitas pelayanan pada rentang periode yang bersangkutan. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sistem dapat menghasilkan seluruh seri laporan RL 1 sampai RL 5 untuk suatu periode pelaporan yang dipilih secara otomatis dari data operasional MyHospital Web. | Completeness |
| **AC-02** | Setiap nilai dan angka dalam laporan RL 1–RL 5 dihitung secara deterministik dari data transaksi operasional, tanpa adanya mekanisme input angka langsung atau pembuatan data dummy khusus untuk RL. | Constraint |
| **AC-03** | Laporan indikator pelayanan rumah sakit (RL 1.2) menghitung nilai BOR, ALOS, BTO, TOI, NDR, dan GDR secara akurat berdasarkan agregasi data sensus tempat tidur dan catatan kepulangan pasien rawat inap. | Correctness |
| **AC-04** | Laporan ketenagaan rumah sakit (RL 2) mengompilasi jumlah tenaga kesehatan dan non-kesehatan secara tepat menurut kualifikasi profesi, spesialisasi, dan status kepegawaian dari master SDM aktif (`ORG-PPA`). | Completeness |
| **AC-05** | Laporan kegiatan rumah sakit (RL 3.1–RL 3.15) merangkum volume aktivitas pelayanan rawat inap, rawat darurat, bedah, penunjang medis (lab, radiologi), farmasi, rujukan, dan cara bayar secara konsisten dari modul operasional masing-masing. | Completeness |
| **AC-06** | Laporan morbiditas RL 4a (rawat inap) dan RL 4b (rawat jalan) mengelompokkan kasus diagnosis ICD-10 secara akurat berdasarkan pembagian kelompok umur dan jenis kelamin standar Kemenkes dari episode yang telah tervalidasi kodingnya. | Correctness |
| **AC-07** | Laporan pengunjung dan kunjungan RL 5 menyajikan data pengunjung baru/lama, volume kunjungan poliklinik, dan peringkat 10 besar penyakit secara konsisten dengan data registrasi kunjungan dan penetapan diagnosis. | Completeness |
| **AC-08** | Sistem menyajikan laporan validasi kesiapan data sumber (*source data readiness validation*) yang menampilkan status kelayakan, jenis masalah, jumlah kasus terdampak, dan rincian episode pelayanan yang belum lengkap. | Completeness |
| **AC-09** | Validasi kesiapan bersifat non-blocking: laporan RL tetap dapat dihasilkan meskipun terdapat anomali data sumber, dengan menyertakan catatan resmi mengenai potensi ketidaklengkapan data dan kasus yang belum dapat direkap. | Correctness |
| **AC-10** | Setiap angka agregasi dalam laporan RL 1–RL 5 memiliki tautan keterlacakan (*traceability*) yang memungkinkan penelusuran kembali ke daftar pasien, nomor rekam medis, nomor registrasi, dan episode pelayanan operasional pembentuknya. | Correctness |
| **AC-11** | Sistem tidak menyediakan fitur perbaikan/pengeditan data operasional secara lokal pada modul Pelaporan RL; perbaikan data diarahkan untuk dilakukan pada modul operasional sumber. | Constraint |
| **AC-12** | Episode pelayanan yang belum dikoding (*uncoded*) atau episode rawat inap yang belum di-discharge terdeteksi dan tercatat secara rinci dalam laporan anomali kesiapan data. | Exception |
| **AC-13** | Laporan RL yang telah berstatus *Final / Terkunci* tidak mengalami perubahan nilai secara otomatis akibat adanya transaksi susulan pada data operasional, dan setiap pembentukan ulang amandemen tercatat dalam jejak audit. | Constraint |
| **AC-14** | Seluruh hasil laporan RL 1–RL 5 dapat disajikan, diekspor, atau dicetak sesuai dengan struktur dan format formulir standar Sistem Informasi Rumah Sakit (SIRS) Kementerian Kesehatan RI. | Completeness |
| **AC-15** | Setiap aktivitas inisiasi kompilasi laporan, penelaahan validasi, penetapan status final, dan pembentukan versi revisi tercatat dalam jejak audit sistem dengan identitas petugas dan stempel waktu. | Constraint |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pencatatan Transaksi Pelayanan Operasional**: Pendaftaran pasien, pencatatan asuhan klinis harian, pelaksanaan tindakan medis, pemulangan pasien di bangsal, peresepan, dan pemeriksaan laboratorium/radiologi → domain dan kapabilitas operasional masing-masing (`ADM`, `RNA`, `RJL`, `IGD`, `LAB`, `RAD`, `KMO`, `APT`).
- **Kodifikasi Penyakit & Tindakan (Coding ICD-10 & ICD-9-CM)**: Proses telaah resume medis dan penetapan kode diagnosis/prosedur klinis pada setiap episode pelayanan pasien → **OC-04-03 Casemix dan Coding** (`BRM-CODING`).
- **Pengolahan Indeks Penyakit & Sensus Harian Ruangan**: Pengelolaan sensus harian ruangan bangsal per shift dan indeks pencarian rekam medis internal harian/bulanan di luar format rekapitulasi RL → **OC-04-05 Pelaporan Index dan Sensus** (`BRM-RPT`).
- **Pengelolaan Fisik Berkas Rekam Medis**: Pelacakan posisi map fisik rekam medis dan ekspedisi peminjaman berkas → **OC-04-02 Manajemen Berkas** (`BRM-MUTASI`).
- **Sistem Manajemen Kualitas Data Umum (*Enterprise Data Quality Governance*)**: Workflow penugasan tiket/task perbaikan data ke PIC instalasi, mekanisme persetujuan berjenjang tata kelola data (*approval workflow*), pemberian skor tata kelola data (*data governance scoring*), dan rule engine generik.
- **Koneksi Integrasi / Web Service Pengiriman Elektronik ke SIRS Online Kemenkes**: Mekanisme komunikasi API/protokol pertukaran data otomatis dari MyHospital Web ke server eksternal Kementerian Kesehatan RI (merupakan kapabilitas integrasi sistem/use case integrasi tersendiri).
- **Rekonsiliasi Keuangan dan Penutupan Kas Rumah Sakit**: Penagihan klaim BPJS, penutupan kasir, dan rekonsiliasi penerimaan kas rumah sakit → domain Tata Rekening (`TRK`) dan Kasir.
