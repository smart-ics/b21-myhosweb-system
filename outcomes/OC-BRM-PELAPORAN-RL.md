# OUTCOME: Pelaporan RL (Rekapitulasi Laporan Rumah Sakit)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-BRM-PELAPORAN-RL     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap rumah sakit di Indonesia memiliki kewajiban hukum dan regulasi untuk menyusun dan menyampaikan Rekapitulasi Laporan (RL) Rumah Sakit secara periodik kepada Kementerian Kesehatan RI (sebagaimana diatur dalam regulasi perumahsakitan dan pedoman Sistem Informasi Rumah Sakit / SIRS). Laporan RL mencakup seri **RL 1 sampai RL 5** yang merefleksikan profil kapasitas, ketenagaan, aktivitas pelayanan, morbiditas-mortalitas, dan statistik kunjungan rumah sakit.

MyHospital Web harus menghasilkan laporan RL dari data operasional yang sudah tersedia di sistem. Petugas Rekam Medis **tidak melakukan input ulang atau membuat data khusus hanya untuk memenuhi kebutuhan laporan RL**. Seluruh angka RL merupakan rekapitulasi murni dari fakta pelayanan yang tercatat pada unit-unit kerja rumah sakit sebagai sumber kebenaran tunggal.

Untuk menjamin akuntabilitas pelaporan, outcome ini didukung dua business requirement yang melekat:

1. **Validasi Kesiapan Data Sumber**: Sistem mendeteksi data operasional yang tidak lengkap atau tidak valid yang menyebabkan suatu nilai RL tidak dapat dihitung secara benar, dan menunjukkan kasus-kasus terdampak sehingga perbaikan dapat diselesaikan pada modul operasional sumbernya.
2. **Keterlacakan ke Data Sumber**: Setiap angka dalam laporan RL dapat ditelusuri balik ke data dan kasus operasional yang membentuknya.

Tanpa Pelaporan RL yang terintegrasi dari data operasional:
- Rumah sakit berisiko menyampaikan data yang tidak konsisten dengan fakta pelayanan nyata.
- Petugas Rekam Medis terbebani kompilasi manual yang lambat dan rawan kesalahan, mendorong pembuatan data rekaan.
- Rumah sakit tidak dapat mempertanggungjawabkan angka laporan saat diaudit regulator.

### Hubungan dengan OC-BRM-SENSUS-INDEX Pelaporan Index dan Sensus

OC-BRM-PELAPORAN-RL dan **OC-BRM-SENSUS-INDEX Pelaporan Index dan Sensus** keduanya diturunkan secara independen dari data operasional rumah sakit sebagai sumber kebenaran tunggal. **OC-BRM-SENSUS-INDEX bukan sumber kebenaran bagi RL**, dan angka RL tidak didefinisikan sebagai hasil rekap dari laporan Index maupun Sensus.

```text
Data Operasional Rumah Sakit
(Sumber Kebenaran Tunggal)
            │
  ┌─────────┴─────────┐
  ▼                   ▼
OC-BRM-PELAPORAN-RL           OC-BRM-SENSUS-INDEX
Pelaporan RL       Pelaporan Index dan Sensus
(Regulatori)       (Operasional, Audit & Analisis)
  │                   ▲
  └── Drill-Down / ───┘
      Verifikasi
```

Peran OC-BRM-SENSUS-INDEX dalam konteks Pelaporan RL adalah:
- **Lapisan Verifikasi**: Ketika angka RL perlu diperiksa keabsahannya (misal total kematian, total kasus morbiditas tertentu, atau hari perawatan), informasi Indeks dan Sensus pada OC-BRM-SENSUS-INDEX menyediakan sarana *drill-down* ke kelompok kasus dan pasien individual yang membentuk angka tersebut.
- **Lapisan Keterlacakan (*Traceability Layer*)**: OC-BRM-SENSUS-INDEX memungkinkan penelusuran audit dari angka agregat RL ke fakta pelayanan granular melalui Indeks Rekam Medis dan Sensus Pelayanan.
- **Lapisan Analitik Operasional**: OC-BRM-SENSUS-INDEX dimanfaatkan secara mandiri oleh instalasi Rekam Medis dan komite medis untuk pengawasan mutu layanan harian — terlepas dari siklus pelaporan RL kepada Kemenkes.

RL tetap dapat dihitung dan diterbitkan secara penuh tanpa bergantung pada laporan tertentu yang tersedia di OC-BRM-SENSUS-INDEX.

---

## 2. Outcome Statement

Laporan RL sesuai struktur dan ketentuan pelaporan yang berlaku (RL 1–RL 5) untuk suatu periode pelaporan **telah tersedia berdasarkan data operasional rumah sakit, disertai informasi mengenai kasus atau data sumber yang tidak dapat direkap sepenuhnya, serta kemampuan penelusuran dari angka laporan ke data operasional yang membentuknya.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama**: Mengompilasi dan mengagregasikan data operasional menjadi laporan RL 1–RL 5 melalui kapabilitas `BRM-RL`. Mengonsumsi data kodifikasi morbiditas (`BRM-CODING`, `BRM-MORBID`) dan indikator pelayanan (`BRM-INDIKATOR`). |
| **Admission** | **Penyedia Konteks Kunjungan & Registrasi**: Menyediakan data volume registrasi dan jenis kunjungan (Rawat Jalan, Rawat Inap, IGD) melalui `ADM-REG` dan `ADM-TRACKER`. |
| **Rawat Inap** | **Penyedia Data Sensus & Kepulangan**: Menyediakan data pemakaian tempat tidur dan hari perawatan (`RNA-BED`), serta catatan kepulangan pasien termasuk cara pulang dan waktu keluar (`RNA-DISCHARGE`). |
| **Rawat Jalan** | **Penyedia Data Pelayanan Poliklinik**: Menyediakan data kunjungan dan tindakan klinis rawat jalan (`RJL-KONSUL`, `RJL-TINDAKAN`). |
| **Gawat Darurat** | **Penyedia Data Pelayanan Darurat**: Menyediakan data kunjungan IGD, triage, tindakan, dan tindak lanjut pelayanan darurat (`IGD-VISIT`, `IGD-TINDAKAN`). |
| **Laboratorium** | **Penyedia Data Pelayanan Laboratorium**: Menyediakan data volume pemeriksaan laboratorium per jenis (`LAB-RESULT`). |
| **Radiologi** | **Penyedia Data Pelayanan Radiologi**: Menyediakan data volume pemeriksaan radiodiagnostik per modalitas (`RAD-EXAM`). |
| **Kamar Operasi** | **Penyedia Data Pelayanan Bedah**: Menyediakan data volume dan klasifikasi tindakan operasi (`KMO-OPR`). |
| **Apotek** | **Penyedia Data Pelayanan Kefarmasian**: Menyediakan data peresepan dan dispensing obat (`APT-DISPENSING`). |
| **Pasien** | **Penyedia Profil Demografi**: Menyediakan data demografi pasien (jenis kelamin, tanggal lahir, wilayah domisili) yang diperlukan untuk tabulasi morbiditas dan statistik kunjungan (`PAS-DATSOS`). |
| **Organisasi** | **Penyedia Referensi Fasilitas & Ketenagaan**: Menyediakan master unit layanan dan kapasitas tempat tidur (`ORG-LAYANAN`, `ORG-BANGSAL`) serta profil tenaga kerja rumah sakit (`ORG-PPA`). |
| **Tata Rekening** | **Penyedia Data Cara Bayar**: Menyediakan informasi penjamin dan kepesertaan pasien untuk rekapitulasi cara bayar (`TRK-JAMINAN`). |

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

- Laporan RL 1–RL 5 sesuai struktur dan ketentuan pelaporan yang berlaku untuk periode pelaporan yang ditetapkan telah tersedia dari data operasional rumah sakit.
- Setiap angka dalam laporan RL berasal murni dari data transaksi operasional MyHospital Web; tidak terdapat entri data khusus atau rekaan yang dibuat semata-mata untuk keperluan RL.
- Sistem mendeteksi dan menunjukkan data operasional yang tidak lengkap atau tidak valid yang menyebabkan suatu nilai RL tidak dapat dihitung secara benar, beserta kasus-kasus yang terdampak.
- Setiap angka dalam laporan RL dapat ditelusuri kembali ke data dan kasus operasional yang membentuknya.

### 5.2 Required Recorded Information

**Konteks Laporan:**
- Identitas rumah sakit (kode dan nama rumah sakit).
- Parameter periode pelaporan: jenis periode dan rentang tanggal pencakupan data.

**Hasil Rekapitulasi RL:**
- Nilai rekapitulasi untuk seluruh seri RL 1–RL 5 sesuai struktur dan ketentuan pelaporan yang berlaku, yang dihasilkan dari agregasi data operasional.

**Temuan Kesiapan Data Sumber:**
- Jenis masalah data yang terdeteksi beserta jumlah kasus yang terdampak.
- Identitas kasus terdampak (nomor rekam medis, nomor registrasi, unit pelayanan, tanggal pelayanan) yang diperlukan untuk penelusuran dan tindak lanjut perbaikan di modul sumber.

### 5.3 Required Business Conditions

- **Sumber Kebenaran Tunggal**: Angka laporan RL harus merupakan hasil agregasi dari data operasional. Tidak boleh ada mekanisme modifikasi angka agregat secara langsung pada laporan tanpa perubahan pada data transaksi sumber.
- **Tanpa Entri Khusus RL**: Tidak boleh ada data yang dibuat semata-mata untuk memenuhi formulir RL di luar data transaksi operasional yang sah.
- **Koreksi di Modul Sumber**: Perbaikan atas masalah data yang dideteksi oleh validasi kesiapan dilakukan pada modul operasional yang berwenang atas data tersebut, bukan melalui mekanisme koreksi lokal di Pelaporan RL.
- **Non-blocking**: Keberadaan data yang belum lengkap tidak mencegah laporan RL dihasilkan. Laporan yang dihasilkan dalam kondisi data belum lengkap mencerminkan data yang tersedia pada saat itu, disertai informasi mengenai bagian yang tidak dapat direkap sepenuhnya.
- **Konsistensi Batas Periode**: Kriteria penarikan data harus konsisten sesuai jenis pelayanan:
  - Pelayanan Rawat Jalan dan Gawat Darurat didasarkan pada tanggal kunjungan/registrasi dalam periode tersebut.
  - Pelayanan Rawat Inap untuk morbiditas dan mortalitas didasarkan pada tanggal kepulangan pasien dalam periode tersebut.
  - Hari perawatan didasarkan pada akumulasi hari rawat aktual pasien selama rentang tanggal periode pelaporan.

### 5.4 Completion Proof

- Laporan RL 1–RL 5 untuk periode yang ditetapkan tersedia dan dapat diperiksa oleh petugas Rekam Medis.
- Sistem dapat menunjukkan kasus atau data sumber yang menyebabkan suatu nilai tidak dapat direkap secara lengkap.
- Angka dalam laporan dapat ditelusuri ke data dan kasus operasional yang membentuknya.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas Rekam Medis menginisiasi pembentukan laporan RL untuk suatu periode pelaporan dan sistem mulai menarik serta mengagregasikan data operasional yang relevan.

### End

Berakhir ketika laporan RL 1–RL 5 untuk periode tersebut telah tersedia dari data operasional — termasuk informasi mengenai keterbatasan kesiapan data sumber dan kemampuan penelusuran dari angka laporan ke data operasional — dan siap untuk diperiksa, diekspor, atau dicetak.

---

## 7. Business Constraints

- **Keaslian Data Operasional**: Angka laporan RL wajib dihasilkan dari data transaksi operasional. Sistem tidak menyediakan mekanisme pengubahan angka agregat secara manual.
- **Read-Only terhadap Operasional**: Outcome ini tidak memiliki kewenangan untuk mengubah catatan klinis, transaksi keuangan, atau status registrasi di modul operasional sumber.
- **Kepatuhan Standar Baku SIRS Kemenkes**: Struktur pengelompokan, pembagian kelompok umur, klasifikasi tindakan, dan rumus indikator statistik pelayanan rumah sakit wajib mengacu pada pedoman teknis pelaporan Kementerian Kesehatan RI yang berlaku.
- **Validasi Bersifat Informatif, Bukan Sistem Tata Kelola Data**: Validasi kesiapan data dirancang pragmatis dan informatif. Outcome ini tidak mengelola workflow penugasan perbaikan data, tidak memberikan penilaian/skor kualitas data, dan tidak menyediakan generic rule engine.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Episode pelayanan telah selesai secara operasional tetapi belum dikoding saat periode pelaporan dijalankan** | Laporan RL dihasilkan dari data yang telah terkoding; kasus yang belum terkoding dicantumkan sebagai bagian yang tidak dapat direkap, lengkap dengan identitas kasus agar petugas dapat menindaklanjuti di modul Casemix & Coding (`BRM-CODING`). |
| **Pasien rawat inap belum diproses discharge secara administratif** | Episode tersebut belum dapat dihitung sebagai pasien keluar dan hari rawat akhirnya belum terhitung. Kasus ini ditunjukkan sebagai data yang belum siap agar unit rawat inap (`RNA-DISCHARGE`) menyelesaikan administrasi kepulangan. |
| **Data demografi pasien tidak lengkap (tanggal lahir atau jenis kelamin tidak tercatat)** | Kasus terkait tidak dapat dimasukkan ke dalam tabulasi yang memerlukan kelompok umur atau jenis kelamin. Kasus ini ditunjukkan agar unit pendaftaran (`PAS-DATSOS`) dapat melengkapi data sosial pasien. |
| **Tindakan pembedahan belum memiliki klasifikasi kategori tingkat keparahan operasi** | Volume tindakan terhitung pada total operasi tetapi tidak dapat diklasifikasikan lebih lanjut. Kasus ini ditunjukkan agar unit kamar operasi (`KMO-OPR`) melengkapi klasifikasi prosedur. |
| **Transaksi pelayanan pada unit yang belum dipetakan ke referensi instalasi/spesialisasi standar SIRS** | Transaksi tidak dapat dialokasikan ke baris laporan yang tepat. Kasus ini ditunjukkan agar administrator organisasi (`ORG-LAYANAN`) melengkapi pemetaan unit ke referensi standar pelaporan. |
| **Periode pelaporan yang dipilih tidak memiliki transaksi pelayanan operasional** | Laporan RL dihasilkan dengan nilai nol yang sah, disertai keterangan bahwa tidak ditemukan aktivitas pelayanan pada periode tersebut. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sistem dapat menghasilkan laporan RL 1–RL 5 untuk suatu periode pelaporan yang dipilih dari data operasional MyHospital Web, sesuai struktur dan ketentuan pelaporan yang berlaku. | Completeness |
| **AC-02** | Setiap angka dalam laporan RL dihasilkan dari agregasi data transaksi operasional; tidak tersedia mekanisme input angka langsung atau modifikasi nilai agregat secara manual pada laporan. | Constraint |
| **AC-03** | Laporan RL 1 menghasilkan nilai indikator pelayanan (BOR, ALOS, BTO, TOI, NDR, GDR) dari data sensus tempat tidur dan kepulangan pasien rawat inap sesuai formula standar yang berlaku. | Correctness |
| **AC-04** | Laporan RL 4 mengelompokkan kasus diagnosis ICD-10 berdasarkan pembagian kelompok umur dan jenis kelamin standar Kemenkes, hanya dari episode yang telah memiliki kode diagnosis tervalidasi. | Correctness |
| **AC-05** | Sistem menampilkan jenis masalah data yang terdeteksi, jumlah kasus terdampak, dan identitas kasus yang tidak dapat direkap secara lengkap beserta modul sumber yang perlu ditindaklanjuti. | Completeness |
| **AC-06** | Laporan RL dapat dihasilkan meskipun terdapat data yang belum lengkap; bagian yang tidak dapat direkap ditunjukkan dengan jelas, bukan memblokir keseluruhan laporan. | Correctness |
| **AC-07** | Dari suatu angka dalam laporan RL, petugas dapat menelusuri kembali ke daftar kasus dan data operasional yang membentuk angka tersebut. | Correctness |
| **AC-08** | Sistem tidak menyediakan fitur perbaikan data operasional secara lokal pada modul Pelaporan RL; temuan masalah data mengarahkan ke modul operasional sumber yang berwenang. | Constraint |
| **AC-09** | Laporan RL yang telah tersedia dapat disajikan, diekspor, atau dicetak sesuai format standar SIRS Kementerian Kesehatan RI. | Completeness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pencatatan Transaksi Pelayanan Operasional**: Pendaftaran pasien, asuhan klinis, tindakan medis, pemulangan di bangsal, peresepan, dan pemeriksaan penunjang → domain operasional masing-masing (`ADM`, `RNA`, `RJL`, `IGD`, `LAB`, `RAD`, `KMO`, `APT`).
- **Kodifikasi Penyakit & Tindakan**: Penetapan kode ICD-10 dan ICD-9-CM pada setiap episode pelayanan → **OC-BRM-CASEMIX-CODING Casemix dan Coding** (`BRM-CODING`).
- **Sensus Pelayanan, Indeks Rekam Medis, dan Statistik Operasional**: Penyajian sensus volume pelayanan, indeks kasus rekam medis (penyakit, operasi, dokter, kematian, kelahiran, rujukan), statistik indikator efisiensi rawat inap (BOR, ALOS, TOI, BTO, GDR, NDR), dan analitik morbiditas operasional untuk keperluan audit klinis, evaluasi mutu, dan pengawasan pelayanan — termasuk pemanfaatannya sebagai lapisan verifikasi dan penelusuran (*drill-down*) angka RL → **OC-BRM-SENSUS-INDEX Pelaporan Index dan Sensus** (`BRM-RPT`).
- **Pengelolaan Fisik Berkas Rekam Medis**: Pelacakan posisi map fisik dan ekspedisi berkas → **OC-BRM-MUTASI-BERKAS Manajemen Berkas** (`BRM-MUTASI`).
- **Sistem Manajemen Kualitas Data Umum**: Workflow penugasan perbaikan data ke PIC, mekanisme persetujuan tata kelola data, penilaian skor kualitas data, dan generic rule engine.
- **Pengiriman Elektronik ke SIRS Online Kemenkes**: Mekanisme komunikasi API/protokol transmisi data ke server eksternal Kementerian Kesehatan RI.
- **Lifecycle Pengelolaan Laporan (Draft–Verified–Final, Amandemen)**: Mekanisme penguncian laporan, versioning, dan amandemen resmi — bila diperlukan, akan diformalisasi sebagai Use Case tersendiri.
