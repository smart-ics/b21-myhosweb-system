# OUTCOME: Casemix dan Coding

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-03     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap episode pelayanan pasien di rumah sakit — baik Rawat Jalan, Rawat Inap, maupun Gawat Darurat — menghasilkan dokumentasi asuhan klinis yang memuat diagnosis penyakit, kondisi medis penyerta, komplikasi, serta tindakan atau prosedur medis yang dilakukan oleh tenaga medis. Untuk kepentingan akuntabilitas medikolegal, penjaminan mutu, analisis statistik morbiditas, dan pembiayaan layanan kesehatan, seluruh informasi klinis tersebut harus ditelaah kelengkapannya dan diterjemahkan ke dalam standar klasifikasi penyakit dan tindakan yang baku secara konsisten.

Outcome **Casemix dan Coding** hadir untuk memastikan bahwa rekam medis setiap episode pelayanan pasien telah diverifikasi kelengkapan administrasinya, dikodifikasikan secara presisi menggunakan standar klasifikasi internasional (ICD-10 untuk diagnosis dan ICD-9-CM untuk prosedur/tindakan), serta dipersiapkan data klaim dan grouping casemix-nya (INA-CBG dan IDRG melalui Modul e-Klaim BPJS) sebagai *persisted business fact* yang sah dan otoritatif.

Bagi pasien peserta BPJS Kesehatan (JKN), outcome ini menjadi jembatan krusial antara catatan klinis dokter dengan sistem pembiayaan berbasis prospektif (*Case-Based Groups*), memastikan ketersediaan seluruh variabel grouping (No SEP, rincian biaya aktual rumah sakit, data demografi, DPJP, cara pulang, dan kode diagnosis/tindakan) hingga terbentuknya penetapan tarif klaim INA-CBG/IDRG yang siap diajukan ke BPJS Kesehatan. Bagi pasien non-BPJS (Umum, Asuransi Swasta, Perusahaan), kodifikasi ini menjamin ketersediaan data morbiditas untuk pelaporan nasional (Kemenkes/SIRS/SATUSEHAT), pemenuhan formulir klaim asuransi komersial, dan analisis biaya pelayanan rumah sakit (*hospital cost analysis*).

Tanpa standarisasi Casemix dan Coding yang terpersistensi secara otoritatif:
- Klaim BPJS Kesehatan tidak dapat diajukan atau berisiko tinggi mengalami penolakan (*klaim dispute/pending/reject*), yang secara langsung mengancam likuiditas dan kelangsungan finansial rumah sakit.
- Terjadinya risiko ketidaktepatan pengkodean klinis (*under-coding* yang merugikan penerimaan rumah sakit atau *up-coding* yang melanggar hukum dan memicu audit fraud).
- Laporan morbiditas dan mortalitas nasional menjadi tidak akurat, melanggar standar rekam medis Permenkes No. 24 Tahun 2022 dan regulasi Satu Data Kesehatan (SATUSEHAT).
- Rumah sakit kehilangan kendali analisis efisiensi biaya (*casemix variance*) karena tidak dapat membandingkan biaya riil pelayanan (*hospital charges*) dengan tarif paket penggantian klaim (*INA-CBG reimbursement*).

---

## 2. Outcome Statement

Rekam medis episode pelayanan pasien — yang mencakup telaah kelengkapan administrasi klinis, kodifikasi diagnosis utama dan diagnosis sekunder (ICD-10), kodifikasi prosedur/tindakan medis (ICD-9-CM), serta penyiapan, validasi, dan eksekusi grouping casemix (INA-CBG dan IDRG melalui integrasi e-Klaim) untuk pasien penjamin BPJS — **telah diverifikasi, dicatat, dan terpersistensi secara sah dalam sistem, siap menjadi dasar yang valid dan otoritatif untuk pelaporan morbiditas rumah sakit, analisis casemix, dan pengajuan klaim pembiayaan kesehatan.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama (*Primary Owner*)**: Menjalankan telaah kelengkapan dokumen asuhan medis, menetapkan dan memvalidasi kode diagnosis utama dan sekunder (ICD-10), menetapkan kode tindakan/prosedur (ICD-9-CM), memperbarui data morbiditas pasien, serta memelihara status dan audit trail pengkodean melalui kapabilitas `BRM-CODING` dan `BRM-MORBID`. |
| **BPJS** | **Penyedia Integrasi e-Klaim & Verifikasi**: Mengelola modul e-Klaim (`BPJ-EKLAIM`), menerima variabel pengkodean dan tarif riil RS, mengeksekusi engine grouping INA-CBG / IDRG, menerbitkan kode CBG dan tarif klaim, serta memastikan validitas transaksi nomor SEP melalui kapabilitas `BPJ-VCLAIM`. |
| **Tata Rekening** | **Penyedia Data Keuangan & Billing Riil**: Menyediakan akumulasi rincian biaya riil pelayanan rumah sakit (*hospital charges*) per komponen tarif sesuai ketentuan variabel e-Klaim (`TRK-BILLING`), serta menyediakan penetapan jenis jaminan pasien (`TRK-JAMINAN`) guna mendukung komparasi margin casemix antara biaya riil dan tarif INA-CBG. |
| **Admission** | **Penyedia Konteks Kunjungan & Registrasi**: Menyediakan data episode pelayanan (Rawat Jalan, Rawat Inap, atau IGD), nomor registrasi, waktu masuk dan pulang/discharge, cara pulang, dan nomor SEP yang terhubung ke kunjungan melalui `ADM-REG` dan `ADM-TRACKER`. |
| **Pasien** | **Penyedia Master Identitas Pasien**: Menyediakan identitas tunggal pasien (Nomor Rekam Medis unik seumur hidup, NIK, nama, tanggal lahir, jenis kelamin, dan usia saat episode pelayanan) melalui kapabilitas `PAS-DATSOS` sebagai parameter determinan algoritma grouping dan morbiditas. |
| **Organisasi** | **Penyedia Referensi Tenaga Medis & Unit**: Menyediakan data identitas Dokter Penanggung Jawab Pelayanan (DPJP Utama, DPJP Tambahan, dokter operator bedah) melalui `ORG-PPA` serta unit asal pelayanan melalui `ORG-LAYANAN`. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `BRM-CODING` Diagnosis/Coding | Berkas Rekam Medis | Known |
| `BRM-MORBID` Morbiditas Pasien | Berkas Rekam Medis | Known |
| `BPJ-EKLAIM` e-Klaim | BPJS | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Rekam medis episode pelayanan pasien (Rawat Jalan, Rawat Inap, atau Gawat Darurat) telah ditelaah kelengkapan dokumen administrasinya oleh Coder / Petugas Casemix resmi.
- Tepat satu Diagnosis Utama (*Principal Diagnosis*) telah ditetapkan dan dikodifikasikan menggunakan standar klasifikasi ICD-10 yang sah dan berlaku.
- Seluruh diagnosis penyerta yang relevan (komorbiditas dan komplikasi) telah diidentifikasi dari catatan klinis dan dikodifikasikan dengan ICD-10 sebagai diagnosis sekunder.
- Seluruh prosedur dan tindakan medis (operatif, diagnostik invasif, terapi khusus) yang dilakukan selama episode perawatan telah dikodifikasikan menggunakan standar klasifikasi ICD-9-CM yang sah dan berlaku.
- Bukti kelengkapan dokumen pendukung medikolegal (resume medis / discharge summary, laporan operasi, informed consent, hasil pemeriksaan laboratorium dan radiologi penunjang) telah diverifikasi ketersediaannya.
- Data morbiditas pasien telah diperbarui dengan kode diagnosis dan prosedur yang telah diverifikasi sebagai riwayat kesehatan yang sah.
- Khusus episode pelayanan dengan penjamin BPJS Kesehatan:
  - Seluruh parameter data klaim e-Klaim (identitas pasien, No SEP, DPJP, tanggal masuk & pulang, cara pulang, kelas rawat hak, kelas rawat aktual, berat lahir bayi jika neonatus, rincian biaya riil RS) telah siap dan tervalidasi.
  - Modul e-Klaim telah mengeksekusi proses grouping INA-CBG dan/atau IDRG secara sukses.
  - Kode CBG/IDRG, deskripsi tarif, nilai tarif INA-CBG, serta tarif tambahan/top-up (*Special CMG*) jika ada telah diterbitkan dan tersimpan dalam sistem.
  - Berkas data klaim e-Klaim berstatus final (*Final Claim*) dan siap untuk pengajuan klaim ke BPJS Kesehatan.
- Analisis varians casemix (perbandingan selisih antara akumulasi tarif riil RS dan tarif klaim paket INA-CBG/IDRG) telah terhitung dan tercatat.
- Status penyelesaian coding episode tercatat secara otoritatif (*Uncoded / In Progress / Coded & Validated / Claim Finalized*).
- Setiap tindakan kodifikasi, modifikasi kode, dan eksekusi grouping tercatat dalam jejak audit (*audit trail*) yang memuat identitas petugas coder, waktu eksekusi, kode awal, kode baru, dan alasan perubahan.

### 5.2 Required Recorded Information

**Identitas Pasien & Konteks Episode Pelayanan:**
- Nomor Rekam Medis (No RM) pasien unik seumur hidup.
- Nomor Induk Kependudukan (NIK) dan Nomor Kartu BPJS (jika peserta BPJS).
- Nama lengkap pasien, jenis kelamin, tanggal lahir, dan usia saat episode pelayanan berlangsung.
- Nomor registrasi episode pelayanan / kunjungan (*Visit Registration ID*).
- Jenis pelayanan: Rawat Jalan (RJTL), Rawat Inap (RITL), atau Gawat Darurat (IGD).
- Unit layanan / poli / bangsal tempat asuhan diberikan.
- Tanggal dan jam masuk perawatan.
- Tanggal dan jam keluar / pulang perawatan (*Discharge DateTime*).
- Lama rawat (*Length of Stay / LOS*) terhitung otomatis dalam satuan hari.
- Cara pulang pasien (Atas Persetujuan Dokter, Rujuk ke Faskes Lain, Pulang Paksa / APS, Meninggal < 48 jam, Meninggal >= 48 jam, Melarikan Diri).
- Kondisi saat pulang (Sembuh, Membaik, Belum Sembuh, Meninggal).
- Dokter Penanggung Jawab Pelayanan (DPJP Utama) dan dokter pelaksana/operator bedah (jika ada).
- Berat badan lahir dalam gram (khusus pasien neonatus / bayi usia < 28 hari).

**Verifikasi Kelengkapan Dokumen Rekam Medis:**
- Status ketersediaan resume medis rawat jalan / resume pulang rawat inap (*Discharge Summary*) bertandatangan DPJP (Lengkap / Belum Lengkap / Tidak Ada).
- Status ketersediaan laporan operasi dan laporan anestesi (untuk kasus tindakan bedah).
- Status ketersediaan laporan pemeriksaan penunjang kritis (Hasil Patologi Anatomi/Laboratorium, Hasil Radiologi/CT-Scan/MRI, dll.).
- Catatan telaah Coder / Klarifikasi Dokter (*Coder-Physician Query*): memuat teks pertanyaan coder kepada DPJP dan jawaban klarifikasi DPJP atas diagnosis yang tidak spesifik atau meragukan.

**Kodifikasi Diagnosis (Standar ICD-10):**
- **Diagnosis Utama (*Principal Diagnosis*):**
  - Teks deskripsi klinis diagnosis yang ditulis oleh dokter pada resume medis.
  - Kode resmi ICD-10 (alfanumerik 3 hingga 5 karakter sesuai tingkat spesifikasi).
  - Deskripsi resmi standar ICD-10.
  - Validasi aturan pengkodean morbiditas (kepatuhan kaidah *Morbidity Coding Rules* WHO).
- **Diagnosis Sekunder (*Secondary Diagnoses*):**
  - Daftar diagnosis penyerta, komorbiditas, atau komplikasi.
  - Teks deskripsi klinis dokter.
  - Kode resmi ICD-10 untuk masing-masing diagnosis sekunder.
  - Deskripsi resmi standar ICD-10.
  - Kategori kondisi: Komorbiditas (*Comorbidity*), Komplikasi (*Complication*), atau Kondisi Luar (*External Cause*).
  - Kode penyebab luar cedera (*External Cause of Injury*, kode V, W, X, Y) dan kode lokasi kejadian (jika kasus trauma/kecelakaan).
  - Kode morfologi neoplasma (kode M) (jika kasus keganasan/onkologi).

**Kodifikasi Prosedur & Tindakan (Standar ICD-9-CM):**
- **Prosedur Utama (*Principal Procedure*):**
  - Teks deskripsi tindakan yang didokumentasikan oleh dokter/operator.
  - Kode resmi ICD-9-CM (numerik 3 hingga 4 digit bertitik).
  - Deskripsi resmi standar ICD-9-CM.
  - Tanggal dan waktu pelaksanaan prosedur.
  - Dokter pelaksana / operator tindakan.
- **Prosedur Sekunder (*Secondary Procedures*):**
  - Daftar tindakan/prosedur tambahan, diagnostik invasif, atau anestesi.
  - Kode resmi ICD-9-CM masing-masing prosedur.
  - Deskripsi resmi standar ICD-9-CM.
  - Tanggal pelaksanaan dan unit pelaksana.

**Data Casemix & Integrasi e-Klaim BPJS (Khusus Pasien JKN):**
- **Variabel Masukan Grouping e-Klaim:**
  - Nomor Surat Eligibilitas Peserta (SEP) yang valid dari sistem VClaim.
  - Jenis kepesertaan BPJS dan jenis tarif RS (Tarif RS Pemerintah / Swasta, Regional tarif, Tipe Kelas RS).
  - Kelas perawatan hak peserta BPJS (Kelas 1, Kelas 2, Kelas 3).
  - Kelas perawatan aktual saat dirawat (Kelas 1, Kelas 2, Kelas 3, VIP, VVIP, Ruang Intensif).
  - Indikasi naik kelas perawatan (Ada / Tidak) beserta dasar perhitungan selisih biaya sesuai Permenkes.
  - Lama hari perawatan di ruang intensif (ICU, ICCU, NICU, PICU) dengan ventilator / tanpa ventilator (jika ada).
  - Rincian akumulasi biaya riil rumah sakit (*Hospital Charges*) per komponen billing:
    - Prosedur Non Bedah
    - Prosedur Bedah
    - Konsultasi
    - Tenaga Ahli
    - Keperawatan
    - Penunjang
    - Radiologi
    - Laboratorium
    - Pelayanan Darah
    - Rehabilitasi Medik
    - Akomodasi / Kamar Rawat
    - Ruang Rawat Intensif
    - Obat-obatan
    - Obat Kronis
    - Obat Kemoterapi
    - Alat Kesehatan (Alkes)
    - Bahan Medis Habis Pakai (BMHP)
    - Sewa Alat Medis
    - Total Biaya Riil Rumah Sakit
- **Hasil Luaran Grouping e-Klaim (INA-CBG / IDRG):**
  - Versi software e-Klaim dan versi tarif INA-CBG yang digunakan.
  - Kode INA-CBG / IDRG (misalnya: `I-4-10-I`, `O-6-10-II`).
  - Deskripsi resmi kode INA-CBG / IDRG.
  - Nilai Tarif Pokok INA-CBG (*Base Tariff*).
  - Kode Special CMG (jika memenuhi kriteria *Special Procedure, Special Drugs, Special Investigations, Special Prosthesis, Sub-acute, Chronic*).
  - Nilai Tarif Tambahan / Top-Up Special CMG.
  - Tarif Tambahan Naik Kelas Perawatan (jika pasien naik kelas).
  - Total Tarif Klaim yang diajukan ke BPJS Kesehatan.
  - Status transaksi e-Klaim: *Draft Grouping*, *Grouped*, *Finalized Claim*, *Terkirim Online BPJS*.
- **Analisis Casemix Finansial:**
  - Nilai selisih biaya (*Casemix Variance*): Total Tarif Klaim INA-CBG dikurangi Total Biaya Riil Rumah Sakit.
  - Indikator efisiensi pembiayaan (Surplus / Defisit) per kasus pelayanan.

**Metadata & Jejak Audit Pengkodean:**
- ID dan nama Petugas Coder / Verifikator Casemix yang bertugas.
- Tanggal dan waktu pengkodean pertama kali dicatat.
- Tanggal dan waktu pengkodean diverifikasi / difinalisasi.
- Riwayat revisi pengkodean: versi perubahan kode ICD, tanggal perubahan, petugas yang mengubah, dan alasan perubahan kode (misal: klarifikasi DPJP, hasil telaah internal komite medis, umpan balik verifikator klaim).

### 5.3 Required Business Conditions

- Episode pelayanan pasien harus telah selesai secara operasional (status registrasi pasien telah berstatus selesai/pulang dan biaya tagihan telah terbit) sebelum pengkodean dapat difinalisasi.
- Tepat satu diagnosis ditetapkan sebagai Diagnosis Utama (*Principal Diagnosis*), yaitu kondisi medis yang ditegakkan pada akhir episode perawatan yang terbukti menjadi penyebab utama pasien dirawat atau mendapatkan penanganan.
- Setiap kode diagnosis ICD-10 dan kode prosedur ICD-9-CM yang dicatat harus merupakan kode yang aktif, sah, dan valid pada daftar referensi master klasifikasi penyakit dan tindakan (tidak diperkenankan menggunakan kode fiktif atau kode induk yang wajib diuraikan pada tingkat karakter lanjutan).
- Pengkodean harus mematuhi kaidah WHO Morbidity Coding Rules (Aturan MB1 s/d MB5): kode gejala, tanda, atau hasil abnormal laboratorium (ICD-10 Bab XVIII kategori R00-R99) tidak boleh dijadikan Diagnosis Utama jika diagnosis definitif penyebab penyakit telah ditegakkan oleh dokter.
- Integritas Dokumentasi Klinis (*Clinical Documentation Integrity*): seluruh penetapan kode ICD-10 dan ICD-9-CM wajib bersumber secara sah dari dokumen rekam medis resmi (resume medis, laporan operasi, catatan penunjang). Tidak dibenarkan melakukan manipulasi kode (*up-coding* atau *down-coding*) tanpa didasari fakta klinis asuhan pasien.
- Rekam medis yang belum memiliki kelengkapan dokumen wajib (resume medis belum ditandatangani DPJP atau laporan operasi belum terbit) tidak boleh difinalisasi kodingnya, melainkan harus ditandai dalam status *Pending Dokumen / Butuh Klarifikasi*.
- Khusus pasien peserta BPJS Kesehatan:
  - Episode pelayanan wajib memiliki Nomor SEP yang sah dan terkonfirmasi aktif pada sistem BPJS VClaim.
  - Rincian biaya riil rumah sakit per komponen tarif e-Klaim harus terakumulasi secara utuh dari billing transaksi pelayanan sebelum grouping dieksekusi.
  - Proses grouping harus dilakukan melalui koneksi resmi ke engine Modul e-Klaim Kemenkes/BPJS. Nilai tarif dan kode CBG tidak boleh diinput secara manual tanpa melalui proses grouping resmi.
- Pasien yang mengalami peningkatan kelas perawatan (naik kelas) wajib memiliki catatan hak kelas, kelas aktual, dan perhitungan selisih biaya yang sesuai dengan ketentuan peraturan menteri kesehatan yang berlaku.
- Finalisasi pengkodean mengunci data koding dari perubahan bebas. Setiap koreksi pasca finalisasi harus melalui otorisasi khusus dengan mencatat alasan perubahan secara transparan dalam jejak audit.

### 5.4 Completion Proof

- Rekam medis episode pelayanan tercatat dalam sistem dengan status pengkodean **Selesai dan Terverifikasi (*Coded & Validated*)**.
- Tersedia tepat satu Diagnosis Utama dengan kode ICD-10 valid beserta deskripsi standar yang tersimpan pada rekam medis episode.
- Tersedia daftar kode ICD-10 untuk diagnosis sekunder dan daftar kode ICD-9-CM untuk prosedur/tindakan (jika ada tindakan yang dilakukan) yang telah tervalidasi.
- Data riwayat morbiditas pasien pada Domain Berkas Rekam Medis (`BRM-MORBID`) terbaharui secara otomatis berdasarkan hasil koding yang telah diverifikasi.
- Khusus untuk pasien peserta BPJS Kesehatan:
  - Data klaim pada Modul e-Klaim (`BPJ-EKLAIM`) berstatus **Final Klaim (*Finalized Claim*)**.
  - Kode INA-CBG/IDRG, deskripsi CBG, nilai tarif klaim INA-CBG, dan tarif top-up (bila ada) tersimpan secara permanen dan terhubung dengan nomor SEP dan episode registrasi pasien.
  - Berkas data klaim e-Klaim digital siap untuk dikirimkan secara daring (*online transmission*) ke server BPJS Kesehatan.
- Nilai varians casemix (perbandingan tarif klaim vs billing riil RS) dapat diakses dan dianalisis untuk kebutuhan evaluasi keuangan dan pengendalian mutu rumah sakit.

---

## 6. Outcome Boundary

### Start

Dimulai ketika episode pelayanan pasien telah selesai secara klinis (pasien rawat jalan telah menyelesaikan konsultasi/tindakan, pasien gawat darurat telah selesai penanganan, atau pasien rawat inap telah resmi dipulangkan/discharge dari bangsal) dan berkas rekam medis episode tersebut masuk ke dalam daftar kerja (*worklist*) telaah Casemix dan Coding.

> Outcome ini dipicu setelah pelayanan klinis selesai dan ringkasan medis awal tersedia. Kunjungan yang masih berlangsung aktif di ruang asuhan belum memasuki batas kerja outcome ini.

### End

Berakhir ketika:
1. Rekam medis telah memenuhi standar kelengkapan administrasi klinis;
2. Seluruh diagnosis (utama dan sekunder) telah dikodifikasi dengan ICD-10 dan seluruh prosedur telah dikodifikasi dengan ICD-9-CM secara sah dan valid;
3. Untuk pasien BPJS Kesehatan: seluruh variabel klaim telah tervalidasi, grouping INA-CBG/IDRG telah sukses dieksekusi melalui Modul e-Klaim, tarif klaim telah terbentuk, dan status data klaim dinyatakan Final (*Finalized Claim*);
4. Status pengkodean episode pelayanan tercatat dan terkunci sebagai **Selesai & Terverifikasi (*Coded & Validated*)**, serta siap dikonsumsi oleh pelaporan morbiditas (RL), indeks sensus, dan penagihan klaim.

---

## 7. Business Constraints

- **Prinsip Diagnosis Utama Tunggal**: Setiap episode pelayanan hanya memiliki tepat satu diagnosis utama yang menjadi penyebab utama asuhan diberikan.
- **Kepatuhan Standar Klasifikasi Baku**: Pengkodean diagnosis wajib mengacu pada ICD-10 dan pengkodean tindakan/prosedur wajib mengacu pada ICD-9-CM edisi resmi yang ditetapkan oleh Kementerian Kesehatan RI.
- **Keterikatan Bukti Dokumentasi (*Evidenced-Based Coding*)**: Setiap kode klasifikasi yang dicatat harus dapat dibuktikan keberadaannya pada dokumen rekam medis pasien. Penambahan kode tanpa bukti klinis (*up-coding*) atau penghilangan komplikasi medis (*down-coding*) merupakan pelanggaran etika dan kepatuhan hukum.
- **Keabsahan SEP untuk Grouping BPJS**: Proses grouping e-Klaim hanya dapat difinalisasi jika nomor SEP telah terbit, sah, dan terverifikasi melalui VClaim BPJS Kesehatan.
- **Keutuhan Variabel Grouping**: Seluruh variabel mandatory e-Klaim (identitas, tanggal masuk/keluar, cara pulang, DPJP, rincian billing riil, kode ICD) wajib terisi lengkap sebelum engine grouping e-Klaim dijalankan.
- **Otoritas Hasil Grouping Modul Resmi**: Nilai kode CBG dan nominal tarif klaim INA-CBG/IDRG wajib dihasilkan secara otomatis oleh web service / engine resmi Modul e-Klaim Kemenkes; petugas tidak diperbolehkan menentukan atau memanipulasi nilai tarif secara manual.
- **Kekekalan Rekam Jejak Audit (*Immutable Audit Trail*)**: Setiap perubahan data koding dan histori grouping pasca finalisasi tidak boleh menghapus data sebelumnya, melainkan dicatat sebagai riwayat revisi beruntun.
- **Isolasi Episode Pelayanan**: Kode diagnosis, prosedur, dan hasil grouping casemix terikat secara spesifik pada satu nomor episode registrasi kunjungan, dan tidak boleh dipindahkan atau dipakai ulang pada kunjungan yang berbeda.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Dokumen rekam medis belum lengkap (Resume medis belum ditandatangani DPJP atau laporan operasi belum tersedia)** | Proses finalisasi koding ditunda (*hold*). Status episode ditetapkan menjadi *Pending Dokumen Rekam Medis*. Sistem mencatat dokumen apa yang belum lengkap dan mengirimkan notifikasi/permintaan kelengkapan kepada DPJP atau unit pelayanan terkait. |
| **Diagnosis yang ditulis dokter ambigu, tidak spesifik, atau bertentangan dengan hasil pemeriksaan penunjang** | Coder tidak boleh menduga atau menetapkan kode spekulatif. Coder mengajukan klarifikasi (*Coder-Physician Query*) ke DPJP melalui sistem. Episode berstatus *Pending Klarifikasi Dokter* hingga DPJP memberikan konfirmasi tertulis yang sah. |
| **Koneksi atau server Modul e-Klaim Kemenkes/BPJS mengalami gangguan teknis (*offline / time out*)** | Pengkodean ICD-10 dan ICD-9-CM tetap dapat dicatat dan disimpan dalam sistem rekam medis. Status e-Klaim ditandai sebagai *Pending Grouping e-Klaim*. Sistem menyediakan mekanisme antrean eksekusi ulang (*retry queue*) setelah modul e-Klaim kembali beroperasi normal. |
| **Hasil grouping e-Klaim gagal (*Grouping Error*) akibat inkonsistensi variabel data (misal: kode diagnosis tidak sesuai jenis kelamin/usia, atau kode ICD tidak berlaku)** | Sistem menampilkan kode pesan kegagalan dari engine e-Klaim secara jelas kepada Coder. Coder melakukan verifikasi ulang kesesuaian data klinis (usia, gender, kode ICD) dan melakukan pembetulan kode yang sah sebelum mengeksekusi grouping ulang. |
| **Pasien meninggal dunia dalam perawatan atau pulang paksa (Atas Permintaan Sendiri / APS)** | Sistem mewajibkan pengisian variabel cara pulang secara spesifik (termasuk verifikasi apakah kematian terjadi < 48 jam atau >= 48 jam sejak masuk, serta pencatatan penyebab kematian) guna memenuhi validasi e-Klaim dan pelaporan mortalitas rumah sakit. |
| **Terdapat revisi pada rincian billing riil RS atau tindakan klinis susulan setelah grouping e-Klaim telah difinalisasi** | Status *Final Klaim* harus dibatalkan secara resmi (*unfinalized claim*) melalui hak akses khusus. Variabel billing dan tindakan diperbarui, kemudian proses grouping e-Klaim wajib dijalankan ulang untuk menghasilkan penetapan tarif klaim yang akurat, dengan alasan pembatalan tercatat dalam jejak audit. |
| **Klaim BPJS dikembalikan oleh Verifikator BPJS (*Klaim Dispute / Pending BPJS*)** | Sistem mencatat status klaim sebagai *Dispute / Pending BPJS* beserta catatan alasan pengembalian dari BPJS. Coder dan Tim Casemix dapat melakukan peninjauan kembali berkas, mengajukan klarifikasi medis lanjutan, memperbaiki kode jika terdapat kekeliruan administratif, dan melakukan re-grouping resmi. |
| **Pasien neonatus (usia < 28 hari) tidak memiliki catatan berat badan lahir** | Sistem menahan eksekusi grouping e-Klaim dan mewajibkan pengisian berat badan lahir dalam gram, karena berat badan lahir merupakan variabel determinan tarif CBG pada kelompok kasus perinatal/neonatologi. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Setiap episode pelayanan yang telah selesai memiliki catatan telaah kelengkapan dokumen rekam medis (resume medis, laporan operasi, penunjang) yang tercatat statusnya. | Completeness |
| **AC-02** | Setiap episode pelayanan yang telah selesai dikodifikasi memiliki tepat satu Diagnosis Utama dengan kode ICD-10 yang sah dan valid. | Correctness |
| **AC-03** | Diagnosis sekunder (komorbiditas dan komplikasi) dapat dikodifikasikan dengan kode ICD-10 yang valid dan terhubung dengan episode pelayanan. | Completeness |
| **AC-04** | Seluruh tindakan medis operatif dan non-operatif dapat dikodifikasikan dengan kode ICD-9-CM yang valid beserta tanggal pelaksanaan dan dokter pelaksana. | Completeness |
| **AC-05** | Kode ICD-10 kategori R00-R99 (gejala dan tanda abnormal) ditolak sebagai Diagnosis Utama apabila dokumen rekam medis memuat diagnosis definitif (kepatuhan WHO Morbidity Coding Rules). | Constraint |
| **AC-06** | Penetapan kode diagnosis dan prosedur secara otomatis memperbarui catatan morbiditas pasien pada Domain Berkas Rekam Medis (`BRM-MORBID`). | Completeness |
| **AC-07** | Untuk pasien peserta BPJS Kesehatan, seluruh variabel grouping e-Klaim (No SEP, identitas, kelas hak/aktual, cara pulang, DPJP, rincian biaya riil RS, kode ICD) terakumulasi secara lengkap sebelum grouping dijalankan. | Completeness |
| **AC-08** | Proses grouping e-Klaim berhasil mengeksekusi integrasi dengan modul e-Klaim dan mempersistensi kode INA-CBG/IDRG, deskripsi tarif, nilai tarif pokok, dan Special CMG (jika ada). | Correctness |
| **AC-09** | Grouping e-Klaim ditolak oleh sistem jika episode pelayanan belum memiliki Nomor SEP yang sah dan tervalidasi pada sistem VClaim. | Constraint |
| **AC-10** | Pasien bayi usia < 28 hari mewajibkan pengisian variabel berat badan lahir (dalam satuan gram) sebelum grouping e-Klaim dapat diproses. | Constraint |
| **AC-11** | Sistem menghitung dan mempersistensi nilai varians casemix (selisih antara tarif klaim INA-CBG dan akumulasi biaya riil rumah sakit). | Correctness |
| **AC-12** | Episode pelayanan yang belum lengkap dokumen medisnya (misal resume medis belum ada) dapat ditandai dalam status *Pending Dokumen* dan tidak dapat difinalisasi kodingnya. | Exception |
| **AC-13** | Keraguan atas penulisan diagnosis dokter dapat diproses melalui mekanisme *Coder-Physician Query* dengan status *Pending Klarifikasi Dokter*. | Exception |
| **AC-14** | Gangguan koneksi modul e-Klaim tidak menggagalkan pencatatan kode ICD; episode ditempatkan pada antrean *Pending Grouping e-Klaim* untuk dieksekusi ulang saat modul kembali aktif. | Exception |
| **AC-15** | Pembatalan status final (*unfinalize*) dan perubahan kode ICD pasca finalisasi mewajibkan pencatatan alasan perubahan dan tersimpan dalam jejak audit (*audit trail*) yang tidak dapat diubah. | Constraint |
| **AC-16** | Data pengkodean diagnosis dan prosedur yang telah berstatus *Coded & Validated* siap dikonsumsi secara konsisten oleh pelaporan morbiditas (RL), indeks sensus, dan penagihan klaim. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pencatatan Asuhan Klinis & Pengisian Resume Medis Digital**: Penulisan asesmen medis harian (CPPT), lembar discharge summary, dan laporan tindakan medis oleh dokter dan tenaga medis → domain pelayanan klinis terkait (Rawat Jalan, Rawat Inap, Gawat Darurat).
- **Registrasi Kunjungan & Penerbitan SEP Awal**: Pencatatan pendaftaran pasien ke loket dan penerbitan awal Surat Eligibilitas Peserta (SEP) saat pasien datang → **OC-01-02 Registrasi Rawat Jalan dan IGD**, **OC-01-03 Registrasi Rawat Inap**, dan **OC-01-04 VClaim BPJS**.
- **Transaksi Pembayaran Kasir & Penagihan Pasien**: Pelunasan biaya tagihan pasien mandiri/umum di kasir rumah sakit → **OC-03-01 Kasir (Terima/Keluar Kas)**.
- **Proses Fisik Pengelolaan Berkas Rekam Medis**: Keterlacakan posisi fisik folder rekam medis dan mutasi berkas antar unit → **OC-04-02 Manajemen Berkas**.
- **Pengiriman Berkas Klaim Fisik/Eksternal ke Kantor BPJS**: Proses penyerahan berkas fisik klaim (FPR), tanda terima berkas penagihan ke kantor cabang BPJS Kesehatan, dan rekonsiliasi pembayaran klaim bank BPJS ke rekening rumah sakit.
- **Penyusunan Formulir Laporan Morbiditas RL Resmi Kemenkes**: Format agregasi dan pengiriman pelaporan sensus rekapitulasi RL 4a / RL 4b ke Kementerian Kesehatan RI → **OC-04-04 Pelaporan RL**.
- **Pengolahan Indeks Penyakit dan Sensus Harian**: Pengolahan statistik BOR/LOS/TOI dan indeks morbiditas berkala → **OC-04-05 Pelaporan Index dan Sensus**.
