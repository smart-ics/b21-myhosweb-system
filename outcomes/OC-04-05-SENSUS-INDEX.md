# OUTCOME: Sensus dan Index (Pelaporan Index dan Sensus)

| Field       | Value        |
|-------------|--------------|
| Code        | OC-04-05     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-02   |

---

## 1. Business Purpose

Setiap rumah sakit memerlukan visibilitas menyeluruh dan objektif terhadap volume aktivitas pelayanan, pemanfaatan kapasitas fasilitas, karakteristik populasi pasien yang dilayani, dan pola morbiditas-mortalitas klinis. Dalam penyelenggaraan rekam medis dan tata kelola rumah sakit, kebutuhan tersebut diwujudkan melalui tiga pilar informasi esensial:

1. **Sensus Pelayanan**: Mengetahui berapa banyak dan bagaimana distribusi pergerakan aktivitas pelayanan rumah sakit dalam suatu periode atau titik waktu tertentu (kunjungan pasien, dinamika tempat tidur rawat inap, pasien masuk, pindahan, pasien keluar, pasien meninggal, dan hari perawatan).
2. **Indeks Rekam Medis**: Menyediakan pengelompokan kasus/pasien yang memenuhi kriteria klinis dan administratif tertentu (berdasarkan diagnosis penyakit, tindakan/operasi medis, dokter penanggung jawab, kematian, kelahiran, rujukan, cara pulang, dan demografi) untuk keperluan penemuan kembali (*retrieval*), audit klinis, evaluasi medis, dan riset kesehatan.
3. **Statistik dan Indikator Pelayanan**: Menyediakan metrik agregat dan indikator efisiensi pelayanan rumah sakit (seperti BOR, ALOS, TOI, BTO, NDR, GDR) serta analisis epidemiologis (morbiditas 10 besar penyakit, tren penyakit tidak menular, mortalitas, dan kewaspadaan dini surveilans KLB) untuk pengambilan keputusan manajemen dan evaluasi mutu klinis.

### Prinsip Utama: Derived Information dari Single Source of Truth

Outcome ini **bukan hasil dari entri data manual oleh petugas Rekam Medis**. Rumah sakit menyelenggarakan pelayanan medis di berbagai unit kerja (Admission, Rawat Jalan, Rawat Inap, Gawat Darurat, Kamar Operasi, Laboratorium, Radiologi, dan Casemix/Coding). Fakta pelayanan yang terjadi pada unit-unit tersebut dicatat sekali pada domain operasional yang berwenang sebagai **sumber kebenaran tunggal (*single source of truth*)**.

Petugas Rekam Medis **tidak melakukan input ulang atau membuat data khusus** hanya untuk menghasilkan sensus, indeks, atau statistik. Seluruh informasi dalam outcome ini merupakan **informasi turunan (*derived information*)** yang dikompilasi secara otomatis dan konsisten dari data transaksi operasional yang telah tercatat.

### Hubungan dengan OC-04-04 Pelaporan RL

OC-04-04 (Pelaporan RL) adalah outcome kepatuhan regulatori untuk pelaporan resmi Sistem Informasi Rumah Sakit (SIRS) kepada Kementerian Kesehatan RI. Terdapat perbedaan mendasar dalam peran bisnis kedua outcome ini:

```text
               Data Operasional Rumah Sakit
               (Sumber Kebenaran Tunggal)
                           │
         ┌─────────────────┴─────────────────┐
         ▼                                   ▼
OC-04-04 Pelaporan RL               OC-04-05 Sensus dan Index
(Kepatuhan Regulasi Kemenkes)       (Operasional, Audit & Analisis RM)
         │                                   ▲
         │                                   │
         └──────── Drill-Down / Verifikasi ──┘
```

- **Independensi Sumber**: OC-04-04 dan OC-04-05 keduanya diturunkan langsung dari data operasional rumah sakit. **OC-04-05 bukan source of truth untuk Pelaporan RL**, dan angka RL tidak boleh didefinisikan sebagai hasil rekap laporan Index/Sensus.
- **Lapisan Verifikasi dan Keterlacakan (*Traceability Layer*)**: OC-04-05 berfungsi sebagai lapisan operasional, audit, dan pembuktian fakta. Ketika angka agregat pada Pelaporan RL (misal total kematian atau total kasus morbiditas tertentu) perlu diperiksa keabsahannya, informasi Indeks dan Sensus pada OC-04-05 menyediakan sarana *drill-down* ke kelompok kasus dan pasien individual yang membentuk angka tersebut.
- **Pemanfaatan Mandiri**: Terlepas dari pelaporan eksternal, OC-04-05 dimanfaatkan secara mandiri oleh instalasi Rekam Medis dan komite medis rumah sakit untuk pengawasan mutu layanan harian, audit rekam medis, dan pelaporan manajemen internal.

### Evaluasi dan Rasionalisasi Menu Legacy

Sistem legacy rumah sakit memiliki 38 menu terpisah yang berkembang selama bertahun-tahun berdasarkan permintaan ad-hoc pengguna. Struktur menu legacy tersebut **tidak dijadikan struktur outcome**, melainkan dirasionalisasi ke dalam boundary bisnis yang kohesif:

| Klaster Bisnis OC-04-05 | Resolusi Fungsional Menu Legacy yang Dicakup | Peran Bisnis |
|-------------------------|---------------------------------------------|--------------|
| **Sensus Pelayanan** | `mnuSensusHarian`, `mnuSensusHarianInap`, `mnuRekapHarianRawatInap`, `mnuRekapRuanganRawatInap`, `mnuRekapKegiatanRawatDarurat`, `mnuInfoRekapKunjungan`, `mnuPasienPulang`, `mnuPasienPulangPerJaminan`, `mnuPasienBaru`, `mnuPasienDalamPerawatan` (posisi cut-off) | Mengukur volume kunjungan, pergerakan tempat tidur rawat inap (SHRI), dan sisa pasien pada periode/cut-off. |
| **Indeks Rekam Medis** | `mnuPenyakit`, `mnuPenyakit2` (Indeks Diagnosis), `mnuOperasi`, `mnuTindakanMedis` (Indeks Prosedur/Operasi), `mnuDokter`, `mnuDokter2` (Indeks Dokter DPJP), `mnuKematian` (Indeks Kematian), `mnuKelahiran` (Indeks Kelahiran), `mnuRujukan` (Indeks Rujukan Masuk/Keluar), `mnuRekapPulangPaksa` (Indeks APS), `mnuImunisasi` (Indeks Pelayanan Khusus), `mnuWilayah` (Indeks Demografi Pasien) | Menyediakan daftar kasus granular berbasis filter fakta klinis/administratif untuk audit dan penelusuran fakta. |
| **Statistik & Indikator Pelayanan** | `mnuInfoRekapIndikatorKes`, `mnuRekapIndikatorKesehatan2` (Indikator BOR, ALOS, TOI, BTO, NDR, GDR), `mnuMorbiditasPasien` (10 Besar Morbiditas), `mnuInfoMonitoringPelayanan`, `mnuInfoSurveilansKLB` (Surveilans Penyakit Menular), `mnuMaternal`, `mnuPenyakitTdkMenular`, `mnuRekapKematian`, `mnuRekapKelahiran`, `mnuInfoRekapWilayahPerGrupJaminan`, `mnuRekapKegiatanDepkes` | Menyajikan indikator efisiensi pemanfaatan fasilitas dan tabulasi pola kesehatan/epidemiologi. |
| **Dikeluarkan dari Boundary (Out of Scope)** | `mnuHistoriPasien` (Penelusuran klinis individual → `ADM-TRACKER`), `mnuInfoPasien` (Pencarian master demografi → `PAS-DATSOS`), `mnuInfoPasienAktif` (Monitoring bed operasional real-time bangsal → `RNA-BED`), `mnuPasienNonAktif` (Retensi/keaktifan nomor RM → `PAS-DATSOS`/`BRM-MUTASI`), `mnuPasienUltah` (CRM/Humas non-klinis) | Menjaga integritas boundary agar fokus pada sensus, indeks, dan statistik agregasi rekam medis. |

---

## 2. Outcome Statement

Informasi sensus pelayanan, indeks kasus rekam medis, dan statistik indikator rumah sakit untuk suatu periode atau kriteria tertentu **telah tersedia berdasarkan data transaksi operasional rumah sakit yang sah, disertai kemampuan penelusuran (drill-down) dari angka agregat ke daftar kasus operasional yang membentuknya serta status kelengkapan data sumber, siap digunakan untuk audit klinis, evaluasi mutu, dan verifikasi pelaporan.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Berkas Rekam Medis** | **Pemilik Utama (*Primary Owner*)**: Mengompilasi dan menyediakan informasi sensus, indeks kasus, dan statistik pelayanan melalui kapabilitas `BRM-RPT`. Mengonsumsi hasil kodifikasi klinis (`BRM-CODING`), data morbiditas terstruktur (`BRM-MORBID`), dan formula indikator rumah sakit (`BRM-INDIKATOR`). |
| **Admission** | **Penyedia Konteks Kunjungan & Registrasi**: Menyediakan data registrasi kunjungan (Rawat Jalan, Rawat Inap, IGD), status kunjungan (baru vs lama), cara penerimaan/rujukan masuk, dan perjalanan episode pasien melalui `ADM-REG` dan `ADM-TRACKER`. |
| **Rawat Inap** | **Penyedia Data Dinamika Tempat Tidur & Kepulangan**: Menyediakan data pergerakan tempat tidur, mutasi kamar/bangsal, hari perawatan aktual (`RNA-BED`), serta data kepulangan pasien termasuk waktu keluar dan cara pulang (sembuh, membaik, rujukan keluar, APS, meninggal) melalui `RNA-DISCHARGE`. |
| **Rawat Jalan** | **Penyedia Data Pelayanan Poliklinik**: Menyediakan data volume kunjungan, konsultasi medis per poliklinik/spesialisasi (`RJL-KONSUL`), dan tindakan medis rawat jalan (`RJL-TINDAKAN`). |
| **Gawat Darurat** | **Penyedia Data Pelayanan Darurat**: Menyediakan data kunjungan kegawatdaruratan (`IGD-VISIT`), klasifikasi triase (`IGD-TRIAGE`), dan tindakan darurat (`IGD-TINDAKAN`). |
| **Kamar Operasi** | **Penyedia Data Pelayanan Bedah**: Menyediakan data tindakan pembedahan, dokter operator, dokter anestesi, jenis anestesi, dan klasifikasi operasi untuk pembentukan indeks operasi (`KMO-OPR`). |
| **Laboratorium** | **Penyedia Data Pelayanan Diagnostik**: Menyediakan volume dan aktivitas pemeriksaan laboratorium per kelompok uji (`LAB-RESULT`). |
| **Radiologi** | **Penyedia Data Pelayanan Imejing**: Menyediakan volume dan aktivitas pemeriksaan radiodiagnostik per modalitas imejing (`RAD-EXAM`). |
| **Pasien** | **Penyedia Profil Demografi Pasien**: Menyediakan data sosial demografi (tanggal lahir/kelompok usia, jenis kelamin, alamat/wilayah domisili, dan data kelahiran baru) melalui `PAS-DATSOS`. |
| **Organisasi** | **Penyedia Referensi Fasilitas & Ketenagaan**: Menyediakan master unit layanan/instalasi (`ORG-LAYANAN`), master kapasitas tempat tidur terpasang/tersedia per ruangan dan kelas rawat (`ORG-BANGSAL`), serta profil dokter DPJP/operator (`ORG-PPA`). |
| **Tata Rekening** | **Penyedia Data Penjamin**: Menyediakan data kelompok penjamin/cara bayar (BPJS PBI, BPJS Non-PBI, Asuransi Swasta, Perusahaan, Umum) melalui `TRK-JAMINAN`. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `BRM-RPT` Sensus dan Index | Berkas Rekam Medis | Known |
| `BRM-CODING` Diagnosis/Coding | Berkas Rekam Medis | Known |
| `BRM-MORBID` Morbiditas Pasien | Berkas Rekam Medis | Known |
| `BRM-INDIKATOR` Indikator RS | Berkas Rekam Medis | Known |
| `ADM-REG` Registration | Admission | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `RNA-BED` Pakai Bed | Rawat Inap | Known |
| `RNA-DISCHARGE` Discharge | Rawat Inap | Known |
| `RJL-KONSUL` Konsultasi | Rawat Jalan | Known |
| `RJL-TINDAKAN` Charge Tindakan Klinis | Rawat Jalan | Known |
| `IGD-VISIT` IGD Visit | Gawat Darurat | Known |
| `IGD-TRIAGE` Triage | Gawat Darurat | Known |
| `IGD-TINDAKAN` IGD Procedure | Gawat Darurat | Known |
| `KMO-OPR` Operative Procedure | Kamar Operasi | Known |
| `LAB-RESULT` Lab Result Management | Laboratory | Known |
| `RAD-EXAM` Examination | Radiology | Known |
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

- Informasi **Sensus Pelayanan** (harian dan periodik) telah tersedia dari transaksi operasional untuk seluruh unit pelayanan (Rawat Jalan, Rawat Inap, Gawat Darurat, dan Penunjang Medis).
- **Sensus Harian Rawat Inap (SHRI)** mencatat pergerakan mutasi tempat tidur secara presisi pada setiap titik waktu cut-off harian:
  $$\text{Pasien Sisa Akhir} = \text{Pasien Awal} + \text{Masuk} + \text{Pindahan Masuk} - \text{Dipindahkan Keluar} - \text{Pulang Hidup} - \text{Meninggal}$$
  serta akumulasi Hari Perawatan (HP) dan Lama Dirawat (LD) per ruangan, kelas perawatan, dan total rumah sakit.
- Kumpulan **Indeks Rekam Medis** terstandar telah tersedia dan dapat disaring (*filtered*) berdasarkan kriteria operasional/klinis:
  - **Indeks Penyakit (Disease Index)**: Kumpulan episode berdasarkan kode ICD-10 (utama/sekunder), kelompok usia, jenis kelamin, dan hasil perawatan.
  - **Indeks Tindakan / Operasi (Procedure Index)**: Kumpulan episode berdasarkan kode ICD-9-CM, jenis spesialisasi bedah, dokter operator, dan dokter anestesi.
  - **Indeks Dokter / PPA (Physician Index)**: Kumpulan episode yang ditangani oleh dokter tertentu sebagai DPJP Utama atau pelaksana tindakan.
  - **Indeks Kematian (Death Index)**: Kumpulan kasus kematian pasien yang dirawat di rumah sakit, memuat diagnosis penyebab kematian, waktu kematian, ruangan terakhir, dan durasi perawatan (< 48 jam vs $\ge$ 48 jam).
  - **Indeks Kelahiran (Birth Index)**: Kumpulan kelahiran bayi (hidup/mati) di rumah sakit dengan berat badan lahir, cara persalinan, dan identitas ibu.
  - **Indeks Pasien Rujukan (Referral Index)**: Kumpulan pasien rujukan masuk (berdasarkan faskes pengirim) dan rujukan keluar (berdasarkan faskes tujuan dan alasan rujukan).
  - **Indeks Pasien Pulang Paksa / APS**: Kumpulan pasien yang menghentikan perawatan atas permintaan sendiri beserta unit perawatan dan alasan kepulangan.
  - **Indeks Wilayah & Penjamin**: Kumpulan pasien berdasarkan domisili geografis dan kelompok jaminan pembayaran.
- **Statistik Pelayanan dan Indikator Rumah Sakit** telah dihitung menggunakan formula baku perumahsakitan yang berlaku nasional:
  - Indikator efisiensi rawat inap: BOR (*Bed Occupancy Rate*), ALOS (*Average Length of Stay*), TOI (*Turn Over Interval*), BTO (*Bed Turn Over*), GDR (*Gross Death Rate*), dan NDR (*Net Death Rate*).
  - Tabulasi pola epidemiologis: 10 Besar Penyakit (*Top 10 Morbidity*) per instalasi, tren Penyakit Tidak Menular (PTM), statistik maternal-perinatal, dan deteksi dini surveilans epidemiologi/KLB.
- **Keterlacakan Granular (*Drill-Down Traceability*)**: Setiap angka agregat pada sensus dan statistik pelayanan dapat ditelusuri langsung ke daftar kasus/pasien individual (indeks) yang membentuk angka tersebut.
- **Transparansi Kesiapan Data Sumber (*Non-Blocking*)**: Episode pelayanan yang belum lengkap kodifikasinya (misal pasien sudah discharge namun koding ICD-10 belum divalidasi) tetap terhitung pada volume sensus, namun diidentifikasi secara transparan pada indeks klinis sebagai status *Pending Koding*.

### 5.2 Required Recorded Information

**Konteks dan Parameter Analisis:**
- Identitas rumah sakit dan unit kerja/bangsal/instalasi.
- Parameter rentang waktu: tanggal/jam cut-off sensus harian atau rentang periode analisis (bulanan, triwulanan, tahunan).
- Parameter kriteria pencarian/penyaringan (kode diagnosis, kode tindakan, dokter DPJP, kelompok usia, jenis jaminan, kelas rawat, wilayah).

**Informasi Sensus Pelayanan:**
- Rekapitulasi volume kunjungan: jumlah kunjungan baru, kunjungan lama, per poliklinik, per jenis penjamin, dan per wilayah domisili.
- Metrik SHRI per ruangan dan kelas rawat:
  - Jumlah Pasien Awal Periode.
  - Jumlah Pasien Masuk Baru.
  - Jumlah Pasien Pindahan Masuk (*Transfer In*).
  - Jumlah Pasien Dipindahkan Keluar (*Transfer Out*).
  - Jumlah Pasien Keluar Hidup (sembuh, membaik, rujukan, pulang paksa).
  - Jumlah Pasien Keluar Meninggal (< 48 jam dan $\ge$ 48 jam).
  - Jumlah Pasien Sisa Akhir Periode.
  - Jumlah Hari Perawatan (HP) dan Lama Dirawat (LD).

**Informasi Indeks Kasus Rekam Medis:**
- Identitas episode: Nomor Rekam Medis (No RM), Nama Pasien, Nomor Registrasi/Kunjungan, Tanggal Masuk, Tanggal Pulang/Keluar.
- Atribut klinis: Kode Diagnosis ICD-10 (Utama & Sekunder) beserta deskripsi, Kode Prosedur ICD-9-CM beserta deskripsi.
- Atribut pelayanan: Unit/Bangsal/Kamar, Kelas Rawat, Dokter DPJP Utama, Dokter Operator/Anestesi (pada tindakan bedah).
- Atribut khusus:
  - Pada Indeks Kematian: Tanggal/jam kematian, diagnosis penyebab kematian, kategori kematian (< 48 jam / $\ge$ 48 jam).
  - Pada Indeks Kelahiran: Tanggal/jam kelahiran, jenis kelamin bayi, berat badan lahir, kondisi lahir (hidup/mati), No RM ibu.
  - Pada Indeks Rujukan: Jenis rujukan (masuk/keluar), nama faskes asal/tujuan, alasan rujukan.
  - Pada Indeks Pulang Paksa: Alasan pulang atas permintaan sendiri.

**Informasi Statistik & Indikator Pelayanan:**
- Nilai indikator efisiensi rawat inap per ruangan/kelas dan total RS:
  $$\text{BOR (\%)} = \frac{\text{Jumlah Hari Perawatan}}{\text{Jumlah Tempat Tidur Tersedia} \times \text{Jumlah Hari Periode}} \times 100\%$$
  $$\text{ALOS (hari)} = \frac{\text{Jumlah Lama Dirawat Pasien Keluar}}{\text{Jumlah Pasien Keluar (Hidup + Meninggal)}}$$
  $$\text{TOI (hari)} = \frac{(\text{Jumlah Tempat Tidur Tersedia} \times \text{Jumlah Hari}) - \text{Jumlah Hari Perawatan}}{\text{Jumlah Pasien Keluar (Hidup + Meninggal)}}$$
  $$\text{BTO (kali)} = \frac{\text{Jumlah Pasien Keluar (Hidup + Meninggal)}}{\text{Jumlah Tempat Tidur Tersedia}}$$
  $$\text{GDR (\textperthousand)} = \frac{\text{Total Pasien Meninggal}}{\text{Total Pasien Keluar (Hidup + Meninggal)}} \times 1000\text{\textperthousand}$$
  $$\text{NDR (\textperthousand)} = \frac{\text{Pasien Meninggal } \ge 48\text{ jam}}{\text{Total Pasien Keluar (Hidup + Meninggal)}} \times 1000\text{\textperthousand}$$
- Peringkat 10 Besar Morbiditas (Top 10 Diseases) menurut kelompok umur dan jenis kelamin.
- Tabulasi kasus surveilans epidemiologi penyakit menular berpotensi KLB.

**Informasi Kesiapan Data Sumber:**
- Daftar episode yang belum memiliki pengkodean tervalidasi pada penarikan Indeks Penyakit / Prosedur.
- Daftar episode rawat inap dengan data mutasi bed yang belum ditutup administrasinya saat cut-off sensus.

### 5.3 Required Business Conditions

- **Derived Information & Single Source of Truth**: Seluruh data sensus, indeks, dan statistik wajib diturunkan secara langsung dari data transaksi operasional. Tidak ada fasilitas input manual atau modifikasi angka agregat secara lokal di modul Rekam Medis.
- **Koreksi di Modul Sumber**: Apabila terdapat ketidaksesuaian data pada hasil sensus atau indeks, koreksi data wajib dilakukan pada unit kerja pemilik transaksi operasional (misal pemutakhiran mutasi bed di Bangsal, penetapan kode di Casemix & Coding, atau pemutakhiran data sosial di Admisi).
- **Independensi Sensus dari Koding**: Sensus volume kunjungan dan dinamika tempat tidur rawat inap dapat dibentuk langsung dari data transaksi admission dan bangsal, tanpa harus menunggu selesainya pengkodean klinis (coding).
- **Keterikatan Indeks Klinis pada Hasil Koding Tervalidasi**: Indeks Penyakit dan Indeks Tindakan hanya menampilkan kasus yang telah memiliki penetapan kode ICD-10/ICD-9-CM yang tervalidasi dari kapabilitas `BRM-CODING`. Kasus yang belum terkoding ditampilkan dalam daftar kasus *Pending Koding*.
- **Kepatuhan Terhadap Formula Baku Nasional**: Rumus penghitungan indikator perumahsakitan (BOR, ALOS, TOI, BTO, GDR, NDR) wajib mematuhi pedoman teknis baku Kementerian Kesehatan RI.
- **Kaidah Hari Perawatan Tunggal**: Satu pasien rawat inap hanya menghasilkan tepat 1 Hari Perawatan (HP) untuk setiap 1 hari kalender perawatan. Perpindahan ruangan internal dalam satu hari yang sama tidak boleh menyebabkan penggandaan hari perawatan.
- **Keterlacakan Vertikal Penuh**: Setiap angka agregat pada rekapitulasi sensus dan tabel statistik wajib menyediakan mekanisme *drill-down* ke daftar kasus operasional pembentuknya.
- **Independensi dari Pelaporan RL**: Sensus dan Indeks dihasilkan secara mandiri dari data operasional dan tidak bergantung pada output Pelaporan RL (OC-04-04). Namun, data sensus dan indeks dapat digunakan sebagai sarana pembuktian/verifikasi terhadap angka-angka pada laporan RL.

### 5.4 Completion Proof

- Laporan sensus harian (termasuk SHRI) dan periodik telah tersedia dan menyajikan data volume pelayanan yang konsisten dengan transaksi operasional pada rentang waktu yang dipilih.
- Kumpulan indeks rekam medis (penyakit, operasi/tindakan, dokter, kematian, kelahiran, rujukan, pulang paksa, wilayah/penjamin) dapat disaring dan menampilkan daftar kasus pasien yang relevan beserta atribut klinis/administratifnya.
- Nilai indikator efisiensi pelayanan (BOR, ALOS, TOI, BTO, GDR, NDR) dan tabulasi 10 besar penyakit terhitung secara akurat sesuai rumus baku.
- Seluruh angka agregat dapat diverifikasi dengan menampilkan daftar episode pasien yang membentuknya.
- Informasi keterbatasan kelengkapan data sumber (seperti kasus belum terkoding) disajikan secara transparan.

---

## 6. Outcome Boundary

### Start

Dimulai ketika petugas Rekam Medis, komite medis, auditor, atau pimpinan rumah sakit menginisiasi permintaan informasi sensus pelayanan, penelusuran indeks kasus klinis, evaluasi indikator efisiensi pelayanan, atau penelusuran audit terhadap suatu periode/kriteria tertentu, dan sistem mulai menarik serta mengagregasikan data transaksi operasional yang relevan.

### End

Berakhir ketika informasi sensus pelayanan, indeks kasus rekam medis, dan statistik indikator rumah sakit untuk periode atau kriteria yang ditentukan telah tersedia dari data operasional — lengkap dengan kemampuan penelusuran *drill-down* ke daftar kasus pembentuknya serta status kelengkapan data sumber — dan siap untuk ditelaah, dianalisis, diverifikasi, dicetak, atau diekspor.

---

## 7. Business Constraints

- **Keaslian Fakta Operasional**: Sistem tidak menyediakan mekanisme manipulasi, pengeditan langsung angka agregat, atau pembuatan catatan rekaan. Seluruh angka bersumber murni dari data operasional.
- **Akses Read-Only terhadap Domain Operasional**: Outcome ini tidak memiliki kewenangan mengubah catatan klinis, status tempat tidur, data transaksi keuangan, atau status registrasi pada domain-domain sumber.
- **Kepatuhan Kaidah Standar Kementerian Kesehatan RI**: Seluruh rumus indikator rumah sakit, batasan pembagian umur, definisi operasional hari perawatan, dan metode perhitungan sensus mengacu pada standar baku Kementerian Kesehatan RI.
- **Konsistensi Jam Cut-Off Sensus Harian**: Penghitungan sensus harian rawat inap menggunakan jam cut-off baku yang telah ditetapkan oleh kebijakan rumah sakit (standar nasional: pukul 00:00 atau akhir shift operasional harian yang konsisten).
- **Prinsip Non-Blocking**: Ketiadaan pengkodean diagnosis atau kelengkapan data tertentu tidak boleh memblokir penyajian sensus pergerakan pasien dan volume aktivitas operasional. Data yang belum lengkap disajikan dengan penanda transparan.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Pasien rawat inap secara fisik telah meninggalkan bangsal tetapi proses administrasi kepulangan (*discharge*) belum dicatat di sistem (`RNA-DISCHARGE`)** | Pasien masih terhitung dalam posisi "Masih Dirawat / Sisa Pasien" pada cut-off sensus harian. Sistem menampilkan status operasional tersebut dan unit rawat inap terkait perlu menyelesaikan transaksi kepulangan administratif. |
| **Pasien telah dipulangkan secara administratif tetapi pengkodean diagnosis ICD-10 belum selesai divalidasi oleh coder (`BRM-CODING`)** | Pasien tetap terhitung pada volume sensus pasien keluar rawat inap dan hari perawatan, namun belum muncul pada Indeks Penyakit spesifik. Pada ringkasan indeks ditampilkan dalam kategori *Pending Koding* agar petugas casemix dapat melengkapi kodingnya. |
| **Pasien mengalami mutasi antar ruangan/bangsal lebih dari satu kali dalam satu hari kalender yang sama** | Sistem mengalokasikan hari perawatan (HP) sesuai kebijakan cut-off sensus tanpa melakukan duplikasi hari rawat; akumulasi hari perawatan tetap bernilai 1 HP untuk pasien tersebut pada hari bersangkutan. |
| **Pasien dinyatakan meninggal dunia dalam perawatan** | Kasus wajib terhitung secara tepat pada Sensus Rawat Inap (sebagai pasien keluar meninggal), Indeks Kematian, serta perhitungan GDR dan NDR berdasarkan klasifikasi waktu kematian (< 48 jam atau $\ge$ 48 jam). |
| **Kapasitas tempat tidur ruangan bernilai nol atau belum didefinisikan pada master ruangan (`ORG-BANGSAL`)** | Perhitungan BOR, TOI, dan BTO untuk ruangan tersebut tidak dapat dieksekusi (dihindari pembagian dengan nol) dan ditandai secara eksplisit agar pengelola fasilitas melengkapi data kapasitas tempat tidur. |
| **Kriteria penyaringan indeks tidak menemukan transaksi yang cocok pada periode yang dipilih** | Sistem menyajikan hasil pencarian kosong yang sah (0 kasus) disertai informasi bahwa tidak ditemukan transaksi operasional yang memenuhi kriteria filter tersebut. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sistem dapat menghasilkan informasi sensus harian dan periodik untuk Rawat Jalan, Rawat Inap, dan Gawat Darurat yang bersumber murni dari data operasional rumah sakit. | Completeness |
| **AC-02** | Sensus Harian Rawat Inap (SHRI) menyajikan pergerakan pasien harian per ruangan dan kelas rawat dengan keseimbangan matematis yang valid: Pasien Sisa = Pasien Awal + Masuk + Pindahan Masuk - Dipindahkan Keluar - Pulang Hidup - Meninggal. | Correctness |
| **AC-03** | Satu pasien rawat inap yang berpindah ruangan beberapa kali dalam satu hari kalender hanya dihitung menghasilkan tepat satu hari perawatan (tidak terjadi duplikasi HP). | Correctness |
| **AC-04** | Sistem menyediakan Indeks Rekam Medis terstandar (Indeks Penyakit, Indeks Operasi/Tindakan, Indeks Dokter, Indeks Kematian, Indeks Kelahiran, Indeks Rujukan, Indeks Pulang Paksa, dan Indeks Wilayah/Penjamin) yang dapat disaring berdasarkan kriteria yang relevan. | Completeness |
| **AC-05** | Indeks Penyakit dan Indeks Prosedur hanya memuat kasus yang telah memiliki kode ICD-10 dan ICD-9-CM yang tervalidasi dari kapabilitas `BRM-CODING`. | Constraint |
| **AC-06** | Kasus yang telah selesai secara operasional namun belum selesai dikoding ditampilkan dalam status *Pending Koding* tanpa memblokir pembentukan sensus volume pelayanan. | Exception |
| **AC-07** | Sistem menghitung indikator efisiensi pelayanan rumah sakit (BOR, ALOS, TOI, BTO, GDR, NDR) sesuai formula baku Kementerian Kesehatan RI berdasarkan data sensus dan kapasitas tempat tidur. | Correctness |
| **AC-08** | Sistem menyajikan statistik epidemiologi meliputi peringkat 10 Besar Morbiditas (*Top 10 Morbidity*) per instalasi dan kelompok demografi, tren Penyakit Tidak Menular, serta kewaspadaan dini surveilans KLB. | Completeness |
| **AC-09** | Setiap angka agregat pada sensus pelayanan dan statistik indikator dapat ditelusuri (*drill-down*) ke daftar kasus/pasien individual (indeks) yang membentuknya. | Correctness |
| **AC-10** | Sistem tidak menyediakan fasilitas input manual atau modifikasi lokal terhadap angka sensus/indeks/statistik; seluruh angka merupakan turunan murni dari transaksi operasional sumber. | Constraint |
| **AC-11** | Informasi sensus dan indeks dapat digunakan untuk memverifikasi dan mengaudit angka-angka pada Pelaporan RL (OC-04-04), tanpa menciptakan ketergantungan data langsung antara keduanya. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pencatatan Transaksi Pelayanan Operasional**: Pencatatan pendaftaran pasien, asuhan medis, tindakan keperawatan, transfer ruangan fisik di bangsal, administrasi kepulangan, peresepan obat, dan pemeriksaan laboratorium/radiologi → domain operasional masing-masing (`ADM`, `RNA`, `RJL`, `IGD`, `KMO`, `LAB`, `RAD`, `APT`).
- **Kodifikasi Klinis ICD-10 dan ICD-9-CM**: Penetapan dan validasi kode diagnosis dan prosedur medis pada episode pelayanan → **OC-04-03 Casemix dan Coding** (`BRM-CODING`).
- **Penyusunan Formulir Kepatuhan Regulasi Kemenkes (RL 1 s/d RL 5)**: Agregasi dan penyusunan format resmi pelaporan Sistem Informasi Rumah Sakit (SIRS) Kementerian Kesehatan RI → **OC-04-04 Pelaporan RL** (`BRM-RL`).
- **Pengelolaan Fisik Berkas Rekam Medis**: Pelacakan lokasi fisik map rekam medis, ekspedisi peminjaman berkas, dan penyusutan berkas inaktif → **OC-04-02 Manajemen Berkas** (`BRM-MUTASI`).
- **Pencarian Master Demografi Pasien Individual**: Pencarian data sosial perorangan pasien atau verifikasi identitas kependudukan (NIK) → **OC-04-01 Data Sosial Pasien** (`PAS-DATSOS`).
- **Penelusuran Riwayat Klinis Pasien Individual (*Patient Journey / Clinical Chart*)**: Akses kronologis rekam medis lengkap perorangan pasien selama masa perawatan → `ADM-TRACKER` dan Clinical Chart di domain pelayanan terkait (`mnuHistoriPasien`).
- **Monitoring Operasional Tempat Tidur Real-Time (*Live Bed Board*)**: Papan kontrol ketersediaan dan status kesiapan tempat tidur kamar bangsal saat ini untuk penempatan pasien baru → `RNA-BED` (`mnuInfoPasienAktif`).
- **Pengelolaan Status Keaktifan Nomor Rekam Medis**: Penonaktifan nomor rekam medis atau retensi status pasien non-aktif → `PAS-DATSOS` / `BRM-MUTASI` (`mnuPasienNonAktif`).
- **Administrasi Layanan Pelanggan / Pemasaran Non-Medis**: Pengelolaan data ulang tahun pasien untuk keperluan promosi atau ucapan humas rumah sakit (`mnuPasienUltah`) → Administrasi Humas / CRM Rumah Sakit.
- **Transmisi Elektronik ke Server Eksternal (Kemenkes / Dinkes)**: Mekanisme protokol komunikasi API pengiriman data surveilans atau statistik ke instansi luar rumah sakit.
- **Keputusan Desain Teknis**: Skema tabel basis data, optimasi indeks SQL, mekanisme penyimpanan sementara (*caching*), arsitektur *reporting engine*, dan desain tata letak antarmuka pengguna (*UI wireframe*).
