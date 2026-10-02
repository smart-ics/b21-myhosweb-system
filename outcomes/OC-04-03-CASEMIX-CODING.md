# OUTCOME: Casemix dan Coding

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-03     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap episode pelayanan pasien di rumah sakit — baik Rawat Jalan, Rawat Inap, maupun Gawat Darurat — menghasilkan dokumentasi asuhan klinis berupa diagnosis dan tindakan medis yang dicatat oleh tenaga medis. Agar informasi klinis tersebut dapat digunakan secara konsisten untuk pelaporan morbiditas nasional, analisis mutu dan efisiensi layanan, serta pembiayaan kesehatan, diagnosis dan prosedur harus diterjemahkan ke dalam standar klasifikasi baku dan terpersistensi sebagai fakta bisnis yang sah.

Outcome **Casemix dan Coding** memastikan bahwa setiap episode pelayanan yang selesai memiliki **representasi terstandarisasi dari informasi klinisnya** — yaitu kode diagnosis (ICD-10) dan kode prosedur (ICD-9-CM) yang telah divalidasi berdasarkan dokumentasi klinis yang tersedia. Untuk episode yang memerlukan grouping casemix (umumnya pasien peserta BPJS Kesehatan), outcome ini juga memastikan tersedianya **hasil casemix** (kode INA-CBG/IDRG dan nilai tarif klaim) yang terpersistensi dan siap digunakan oleh proses downstream.

Tanpa coded clinical information yang terpersistensi secara otoritatif:
- Klaim pembiayaan kesehatan (BPJS dan asuransi lainnya) tidak memiliki dasar pengkodean yang valid.
- Data morbiditas rumah sakit tidak dapat dikontribusikan pada pelaporan nasional (SATUSEHAT/SIRS).
- Rumah sakit tidak dapat melakukan analisis efisiensi biaya pelayanan secara berbasis kasus (*casemix analysis*).

---

## 2. Outcome Statement

Episode pelayanan pasien **telah memiliki diagnosis dan prosedur yang terkodifikasi secara tervalidasi berdasarkan dokumentasi klinis yang tersedia**, serta hasil casemix tersedia untuk episode yang memerlukan grouping, sehingga data tersebut siap digunakan untuk klaim, pelaporan morbiditas, dan analisis.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama (*Primary Owner*)**: Menetapkan dan memvalidasi kode diagnosis (ICD-10) dan kode prosedur (ICD-9-CM) berdasarkan dokumentasi klinis yang tersedia, memperbarui data morbiditas pasien, serta memelihara status dan jejak audit pengkodean melalui kapabilitas `BRM-CODING` dan `BRM-MORBID`. |
| **BPJS** | **Penyedia Hasil Casemix (Kondisional)**: Mengeksekusi grouping INA-CBG/IDRG dan mempersistensi kode CBG serta tarif klaim berdasarkan variabel koding dan data episode yang disediakan, melalui kapabilitas `BPJ-EKLAIM`. Relevan hanya untuk episode dengan penjamin BPJS Kesehatan. |
| **Tata Rekening** | **Penyedia Data Konteks Episode**: Menyediakan informasi jenis penjamin pasien (`TRK-JAMINAN`) dan akumulasi biaya riil pelayanan yang dibutuhkan sebagai variabel grouping casemix (`TRK-BILLING`). |
| **Admission** | **Penyedia Konteks Kunjungan**: Menyediakan data episode pelayanan (jenis pelayanan, nomor registrasi, waktu masuk/pulang, cara pulang, DPJP) sebagai konteks pengkodean melalui `ADM-REG`. |
| **Pasien** | **Penyedia Identitas Subjek**: Menyediakan identitas pasien (No RM, tanggal lahir, jenis kelamin) sebagai parameter konteks pengkodean dan grouping melalui `PAS-DATSOS`. |
| **Organisasi** | **Penyedia Referensi Tenaga Medis**: Menyediakan data DPJP dan dokter operator sebagai atribut episode pelayanan yang dikodifikasikan, melalui `ORG-PPA`. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `BRM-CODING` Diagnosis/Coding | Berkas Rekam Medis | Known |
| `BRM-MORBID` Morbiditas Pasien | Berkas Rekam Medis | Known |
| `BPJ-EKLAIM` e-Klaim | BPJS | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `ADM-REG` Registration | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Episode pelayanan pasien yang telah selesai secara klinis memiliki setidaknya satu kode diagnosis utama (ICD-10) yang sah dan tervalidasi berdasarkan dokumentasi klinis yang tersedia.
- Diagnosis penyerta yang relevan — komorbiditas dan komplikasi — yang terdokumentasi telah dikodifikasikan dengan ICD-10 sebagai diagnosis sekunder.
- Prosedur dan tindakan medis yang dilakukan selama episode perawatan dan terdokumentasikan telah dikodifikasikan menggunakan ICD-9-CM.
- Pengkodean telah divalidasi oleh Coder/Petugas Casemix yang berwenang dan statusnya tercatat secara otoritatif.
- Data morbiditas pasien telah diperbarui berdasarkan hasil pengkodean yang tervalidasi.
- Untuk episode yang memerlukan grouping casemix (pasien peserta BPJS Kesehatan): hasil grouping INA-CBG/IDRG — berupa kode CBG dan nilai tarif klaim — telah tersedia dan terpersistensi, terhubung dengan episode pelayanan yang bersangkutan.

### 5.2 Required Recorded Information

**Konteks Episode Pelayanan:**
- Nomor Rekam Medis (No RM) pasien.
- Nomor registrasi episode pelayanan.
- Jenis pelayanan: Rawat Jalan, Rawat Inap, atau Gawat Darurat.
- Tanggal masuk dan tanggal keluar/pulang.
- Cara pulang dan kondisi saat pulang.
- Dokter Penanggung Jawab Pelayanan (DPJP Utama).

**Kodifikasi Diagnosis (ICD-10):**
- Diagnosis Utama: teks klinis dari dokter, kode ICD-10 yang ditetapkan, dan deskripsi standar.
- Diagnosis Sekunder: daftar diagnosis penyerta beserta kode ICD-10 dan kategori kondisinya (komorbiditas atau komplikasi).

**Kodifikasi Prosedur (ICD-9-CM):**
- Prosedur Utama: teks klinis, kode ICD-9-CM, tanggal tindakan, dan dokter pelaksana.
- Prosedur Sekunder: daftar prosedur tambahan beserta kode ICD-9-CM dan tanggal pelaksanaan.

**Hasil Casemix (Kondisional — untuk pasien BPJS Kesehatan):**
- Nomor SEP yang menjadi dasar grouping.
- Kode INA-CBG/IDRG yang dihasilkan dan deskripsinya.
- Nilai tarif klaim yang ditetapkan (tarif pokok dan tarif tambahan bila ada).
- Perbandingan antara tarif klaim dan akumulasi biaya riil rumah sakit (*casemix variance*).

**Jejak Audit Pengkodean:**
- Identitas Coder yang menetapkan dan memvalidasi kode.
- Waktu pengkodean pertama kali dicatat dan waktu validasi.
- Riwayat perubahan kode: kode sebelumnya, kode pengganti, dan alasan perubahan.

### 5.3 Required Business Conditions

- Episode pelayanan harus telah selesai secara operasional sebelum pengkodean dapat divalidasi dan difinalisasi.
- Setiap kode diagnosis dan prosedur yang dicatat harus bersumber dari dokumentasi klinis yang tersedia dalam rekam medis episode tersebut.
- Setiap kode yang ditetapkan harus merupakan kode yang valid pada daftar referensi master klasifikasi yang berlaku (ICD-10 dan ICD-9-CM).
- Tepat satu kode ditetapkan sebagai Diagnosis Utama per episode pelayanan.
- Pengkodean yang telah divalidasi bersifat terkunci; perubahan setelah validasi hanya dapat dilakukan melalui otorisasi khusus dengan alasan yang tercatat dalam jejak audit.
- Untuk episode dengan penjamin BPJS Kesehatan: grouping casemix hanya dapat dieksekusi jika episode memiliki Nomor SEP yang sah dan seluruh variabel grouping yang diperlukan telah tersedia.

### 5.4 Completion Proof

- Episode pelayanan memiliki status pengkodean **Tervalidasi (*Coded & Validated*)** yang tercatat secara otoritatif dalam sistem.
- Setidaknya satu kode Diagnosis Utama (ICD-10) yang valid tersimpan dan terhubung dengan episode pelayanan.
- Data morbiditas pasien mencerminkan kode diagnosis dan prosedur dari episode ini.
- Untuk pasien BPJS Kesehatan: kode INA-CBG/IDRG dan nilai tarif klaim telah tersimpan dan terhubung dengan nomor SEP dan nomor registrasi episode pelayanan.
- Data pengkodean episode tersedia dan dapat dikonsumsi oleh proses pelaporan morbiditas, analisis casemix, dan penagihan klaim.

---

## 6. Outcome Boundary

### Start

Dimulai ketika episode pelayanan pasien telah selesai secara klinis — pasien rawat jalan telah menyelesaikan konsultasi atau tindakan, pasien IGD telah selesai penanganan, atau pasien rawat inap telah resmi dipulangkan — dan dokumentasi klinis awal (setidaknya diagnosis yang ditulis dokter) tersedia sebagai dasar pengkodean.

> Kunjungan yang masih berlangsung aktif di ruang asuhan belum memasuki batas kerja outcome ini.

### End

Berakhir ketika:

1. Kode diagnosis (ICD-10) dan kode prosedur (ICD-9-CM) berdasarkan dokumentasi klinis yang tersedia telah ditetapkan dan divalidasi oleh Coder yang berwenang;
2. Status pengkodean episode tercatat sebagai **Tervalidasi (*Coded & Validated*)**;
3. Untuk episode yang memerlukan grouping: hasil casemix (kode INA-CBG/IDRG dan tarif klaim) telah tersimpan dan terhubung dengan episode pelayanan.

---

## 7. Business Constraints

- **Prinsip Diagnosis Utama Tunggal**: Setiap episode pelayanan hanya memiliki tepat satu Diagnosis Utama.
- **Kepatuhan Standar Klasifikasi Baku**: Kode diagnosis mengacu pada ICD-10 dan kode prosedur mengacu pada ICD-9-CM sesuai edisi yang ditetapkan oleh Kementerian Kesehatan RI.
- **Keterikatan pada Dokumentasi Klinis**: Setiap kode yang ditetapkan harus dapat dibuktikan keberadaannya pada dokumentasi klinis rekam medis episode tersebut.
- **Isolasi Episode**: Kode diagnosis, prosedur, dan hasil casemix terikat pada satu nomor episode registrasi dan tidak dapat dipindahkan atau dipakai ulang untuk episode lain.
- **Keabsahan SEP untuk Grouping BPJS**: Grouping casemix hanya dapat dieksekusi jika episode memiliki Nomor SEP yang sah.
- **Kekekalan Jejak Audit**: Perubahan kode setelah validasi tidak menghapus data sebelumnya; setiap revisi dicatat sebagai riwayat beruntun yang permanen.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Dokumentasi klinis yang tersedia belum cukup untuk menetapkan kode (misalnya diagnosis yang ditulis dokter tidak spesifik atau meragukan)** | Coder mengajukan klarifikasi kepada DPJP. Episode ditandai dengan status *Pending Klarifikasi*. Pengkodean ditunda hingga klarifikasi diterima. |
| **Episode memerlukan grouping casemix tetapi Nomor SEP belum tersedia** | Pengkodean ICD tetap dapat dicatat dan divalidasi. Grouping casemix ditunda hingga Nomor SEP tersedia. |
| **Grouping casemix menghasilkan kegagalan karena inkonsistensi variabel** | Coder melakukan verifikasi data klinis dan variabel episode, melakukan perbaikan yang sah, kemudian grouping dieksekusi ulang. |
| **Pasien meninggal dalam perawatan** | Cara pulang wajib dicatat secara spesifik sebagai bagian dari data episode yang menjadi variabel pengkodean dan grouping. |
| **Terdapat revisi kode setelah status Tervalidasi** | Revisi hanya dapat dilakukan melalui otorisasi khusus. Status validasi dikembalikan, revisi dilakukan, dan episode divalidasi ulang. Seluruh perubahan tercatat dalam jejak audit. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Episode pelayanan yang selesai dapat memiliki status pengkodean yang tercatat dan dapat diketahui kondisinya setiap saat. | Completeness |
| **AC-02** | Episode pelayanan yang tervalidasi memiliki tepat satu Diagnosis Utama dengan kode ICD-10 yang valid. | Correctness |
| **AC-03** | Diagnosis penyerta (komorbiditas dan komplikasi) yang terdokumentasi dapat dikodifikasikan sebagai diagnosis sekunder dengan kode ICD-10 yang valid. | Completeness |
| **AC-04** | Prosedur medis yang terdokumentasi dapat dikodifikasikan dengan kode ICD-9-CM yang valid beserta tanggal tindakan dan dokter pelaksana. | Completeness |
| **AC-05** | Pengkodean yang tervalidasi secara otomatis memperbarui data morbiditas pasien. | Completeness |
| **AC-06** | Kode diagnosis atau prosedur yang tidak memiliki dasar pada dokumentasi klinis yang tersedia tidak dapat disimpan sebagai bagian dari coding episode. | Constraint |
| **AC-07** | Episode pelayanan dengan penjamin BPJS Kesehatan yang telah tervalidasi kodingnya dapat mengeksekusi grouping casemix dan memperoleh kode INA-CBG/IDRG serta tarif klaim yang terpersistensi. | Correctness |
| **AC-08** | Grouping casemix ditolak jika episode tidak memiliki Nomor SEP yang sah. | Constraint |
| **AC-09** | Perbandingan antara tarif klaim casemix dan biaya riil rumah sakit dapat dihitung dan diakses per episode pelayanan yang telah di-grouping. | Correctness |
| **AC-10** | Episode dengan status *Pending Klarifikasi* tidak dapat difinalisasi kodingnya hingga klarifikasi diterima dari DPJP. | Exception |
| **AC-11** | Perubahan kode setelah status Tervalidasi menghasilkan entri jejak audit yang permanen dan tidak dapat dihapus. | Constraint |
| **AC-12** | Data pengkodean yang berstatus Tervalidasi tersedia sebagai sumber data yang konsisten untuk pelaporan morbiditas, indeks penyakit, dan penagihan klaim. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pengelolaan Kelengkapan Berkas Rekam Medis**: Telaah dan administrasi kelengkapan dokumen fisik rekam medis (ketersediaan resume medis, laporan operasi, dan dokumen penunjang) → **OC-04-02 Manajemen Berkas**.
- **Pencatatan Asuhan Klinis oleh Tenaga Medis**: Penulisan catatan medis harian, resume medis, dan laporan tindakan oleh dokter → domain pelayanan klinis terkait (Rawat Jalan, Rawat Inap, Gawat Darurat).
- **Registrasi Kunjungan & Penerbitan SEP**: Pendaftaran pasien dan penerbitan Surat Eligibilitas Peserta → **OC-01-02**, **OC-01-03**, dan **OC-01-04 VClaim BPJS**.
- **Pengiriman dan Rekonsiliasi Klaim ke BPJS**: Proses pengiriman berkas klaim, tanda terima penagihan ke kantor BPJS, dan rekonsiliasi pembayaran.
- **Aturan dan Pedoman Teknis Pengkodean**: Detail kaidah pengkodean klinis (aturan morbiditas WHO, pengecualian per tipe kode, dsb.) → Coding Rules / SOP Pengkodean (Business Rules artifact).
- **Mekanisme Integrasi e-Klaim**: Detail teknis protokol komunikasi, mekanisme antrean ulang, dan spesifikasi API e-Klaim → Integration Specification artifact.
- **Pelaporan Morbiditas RL**: Agregasi dan pengiriman laporan RL 4a/4b ke Kementerian Kesehatan → **OC-04-04 Pelaporan RL**.
- **Sensus & Indeks Penyakit**: Pengolahan statistik BOR/LOS/TOI dan indeks morbiditas berkala → **OC-04-05 Pelaporan Index dan Sensus**.
