# OUTCOME: Master Tarif Layanan dan Fasilitas Rumah Sakit

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-TRK-TARIF      |
| Version     | 1.0               |
| Status      | Canonical Approved|
| LastUpdated | 2026-10-10        |

---

## 1. Business Purpose

Rumah sakit memerlukan kepastian bisnis bahwa seluruh layanan medis, prosedur tindakan, fasilitas kamar/akomodasi, pemeriksaan laboratorium, pemeriksaan radiologi, tindakan bedah, dan layanan ambulans memiliki penetapan harga resmi yang sah, terukur, dan transparan. Master tarif menetapkan nilai nominal rupiah dan struktur pembebanan biaya berdasarkan kombinasi kelas perawatan dan kelompok penjamin/cara bayar.

Fakta bisnis tarif yang tersimpan dan aktif (*Hospital Service & Facility Tariff exists*) bertindak sebagai referensi tunggal (*single source of truth*) yang mengikat seluruh proses pembebanan tagihan di titik layanan (*point-of-care billing*). Tarif tidak hanya menetapkan total biaya tagihan pasien, melainkan juga mendekomposisi nilai tersebut ke dalam komponen-komponen biaya riil, seperti jasa pelayanan tenaga medis (dokter spesialis, dokter umum, perawat/paramedis), biaya sarana/fasilitas rumah sakit, akomodasi, serta pemetaan pos rekening akuntansi pendapatan dan diskon (*Chart of Accounts* / COA).

Dengan tersedianya master tarif yang sah dan teraktivasi, rumah sakit menjamin:
1. Konsistensi nilai pembebanan tagihan pasien di seluruh unit pelayanan (`TRK-BILLING`, `RNA-ROOM-CHARGE`, dan `Tindakan`).
2. Transparansi dan akurasi pembagian jasa medis bagi tenaga profesional pemberi asuhan (PPA).
3. Integritas pelaporan keuangan dan akuntansi pendapatan rumah sakit.
4. Tata kelola perubahan harga yang akuntabel melalui instrumen kebijakan (*Tariff Policy / SK Direksi*) tanpa merusak riwayat transaksi finansial masa lalu (*non-retroactive immutability*).

---

## 2. Outcome Statement

Master tarif layanan dan fasilitas rumah sakit **telah ditetapkan, diuraikan ke dalam komponen biaya dan jasa medis secara seimbang, diverifikasi kelayakan aturannya, dan diaktivasi secara sah berdasarkan kebijakan resmi rumah sakit, sehingga menjadi acuan tunggal pembebanan tagihan operasional pasien masa kini dan masa depan tanpa mengubah riwayat transaksi tagihan masa lalu.**

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Tata Rekening** (`TRK`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pendefinisian struktur tarif, pemeliharaan varian harga komposit (`TRK-TARIF`), pengaitan terhadap kelompok penjamin/tipe tarif (`TRK-JAMINAN`), dekomposisi komponen biaya, serta penataan akun akuntansi pendapatan/diskon (COA). |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan konteks struktural rumah sakit yang mencakup katalog unit layanan (`ORG-LAYANAN`), master kelas perawatan dan konfigurasi ruang/bed (`ORG-BANGSAL`), serta master kualifikasi satuan tugas tenaga medis/PPA (`ORG-PPA`) untuk validasi pembagian jasa medis. |
| **Admission** (`ADM`) | **Contributing Domain:** Mengonsumsi referensi tarif saat pendaftaran kunjungan (karcis pendaftaran, biaya administrasi) dan menetapkan hak kelas penjamin pasien (`ADM-REG`). |
| **Unit Pelayanan & Penunjang** (`RJL`, `RNA`, `IGD`, `LAB`, `RAD`, `KMO`, `APT`) | **Downstream Consumers:** Mengonsumsi snapshot nilai tarif aktif saat tindakan klinis, sewa kamar, order penunjang, atau layanan farmasi dibebankan ke dalam tagihan pasien. |

---

## 4. Participating Capabilities

| Capability | Domain | Status | Peran dalam Outcome |
|------------|--------|--------|---------------------|
| `TRK-TARIF` Tariff | Tata Rekening | Known | **Primary Capability:** Memelihara master katalog tarif, varian harga komposit, dekomposisi komponen biaya, serta mempublikasikan tarif aktif operasional. |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known | Menyediakan dimensi Tipe Tarif yang terpetakan ke kelompok penjamin/cara bayar (Umum, BPJS, Asuransi Swasta, Perusahaan). |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known | Mengaitkan item layanan dengan instalasi/poliklinik/unit kerja yang berwenang melaksanakannya. |
| `ORG-BANGSAL` Kamar & Bed | Organisasi | Known | Menyediakan master referensi Kelas Perawatan sebagai dimensi varian tarif akomodasi dan tindakan rawat inap. |
| `ORG-PPA` Tenaga Medis / PPA | Organisasi | Known | Menyediakan referensi profesi dan Satuan Tugas (SatTugas) PPA untuk memvalidasi kelayakan penerima komponen jasa medis. |

---

## 5. Outcome Specification

> *Kondisi faktual yang harus terpenuhi agar Outcome dinyatakan terwujud secara sah.*

### 5.1 Required Business Facts

1. **Katalog Identitas Layanan (Catalog Identity):**
   - Setiap item layanan, tindakan medis, pemeriksaan diagnostik, atau fasilitas memiliki identitas katalog tunggal yang stabil (`TarifId` / Kode Tarif).
   - Katalog identitas bersifat murni nomenklatur layanan dan klasifikasi administratif; tidak menyimpan nilai nominal moneter tetap pada level katalog.
   - Katalog mendukung klasifikasi administratif (Kelompok Tarif, Jenis Tarif, Rekap Pelaporan).

2. **Varian Penetapan Harga Tiga Dimensi (Three-Dimensional Pricing Variant):**
   - Nilai nominal tarif ditentukan secara spesifik oleh kunci komposit tiga dimensi:
     $$\mathbf{Varian\ Tarif} = \mathbf{Layanan\ (Tarif)} \times \mathbf{Kelas\ Perawatan\ (Kelas)} \times \mathbf{Tipe\ Tarif\ (Penjamin)}$$
   - Kombinasi unik dari ketiga dimensi tersebut menghasilkan tepat satu nilai nominal harga total yang aktif dan berlaku.

3. **Dekomposisi Komponen Biaya (Komponen Breakdown):**
   - Setiap varian tarif wajib terurai ke dalam satu atau lebih rincian komponen biaya (`KomponenTarif`), mencakup:
     - **Komponen Jasa Medis:** Jasa dokter spesialis/operator, dokter umum, dokter anestesi, perawat/paramedis.
     - **Komponen Sarana & Fasilitas:** Sewa kamar/akomodasi, sewa alat medis, pemakaian instalasi, utilitas.
     - **Komponen Bahan & Operasional:** Bahan medis habis pakai (BMHP), administrasi penunjang.
     - **Komponen Penyesuaian:** Potongan harga/diskon resmi rumah sakit.

4. **Keseimbangan Finansial Komponen (Balance Invariant):**
   - Jumlah akumulatif seluruh nilai nominal komponen biaya wajib tepat sama secara matematis dengan nilai total nominal varian tarif:
     $$\text{Nilai Total Varian} = \sum_{i=1}^{n} \text{Nilai Komponen}_i \quad (\text{toleransi selisih } = 0)$$

5. **Validasi Kelayakan Penerima Jasa Medis (PPA Eligibility Gating):**
   - Komponen biaya yang bertipe jasa medis mengikat aturan Satuan Tugas (`SatTugas`).
   - Komponen jasa medis hanya dapat dibagikan atau dibebankan kepada praktisi medis (PPA) yang memiliki kualifikasi/kewenangan klinis yang beririsan dengan Satuan Tugas komponen tersebut.

6. **Pemetaan Akuntansi Finansial (COA Mapping):**
   - Setiap komponen biaya terhubung ke akun akuntansi yang valid:
     - Rekening Pendapatan (`RekPdpt` / Revenue Account).
     - Rekening Potongan/Diskon (`RekDiskon` / Discount Account).

7. **Tata Kelola Kebijakan & Jejak Audit (Policy Governance & Audit Trail):**
   - Setiap pembentukan atau perubahan nilai tarif dikelompokkan ke dalam sebuah kontainer kebijakan resmi (*Tariff Policy / SK Direksi*).
   - Kebijakan tarif memiliki siklus status: `Draft` $\rightarrow$ `Reviewed` $\rightarrow$ `Published`.
   - Aktivasi kebijakan (*Publish*) dicatat secara permanen dalam log audit (*Publish Log*) yang mencatat: nomor kebijakan, nama operator/petugas aktivasi, stempel waktu aktivasi (*timestamp*), dan jumlah varian yang terpengaruh.

8. **Kekebalan Transaksi Historis (Non-Retroactive Immutability):**
   - Aktivasi tarif baru hanya berlaku bagi transaksi pelayanan yang dicatat setelah waktu aktivasi.
   - Transaksi tagihan dan tindakan medis yang telah tercatat sebelumnya pada [`OC-TRK-BILLING`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-BILLING.md) bersifat kebal (*immutable*) dan tidak mengalami penyesuaian nilai otomatis.

---

### 5.2 Required Recorded Information

#### A. Identitas Master Katalog Layanan:
- **Kode Layanan (`TarifId`)**: Identifikasi unik alfanumerik stabil.
- **Nama Layanan (`TarifName`)**: Deskripsi resmi tindakan/layanan/fasilitas.
- **Kelompok Tarif (`GroupTarif`)**: Pengelompokan administratif (misal: Tindakan Dokter, Penunjang Medis, Akomodasi).
- **Jenis Tarif (`JenisTarif`)**: Klasifikasi operasional (Rawat Jalan, Rawat Inap, Bedah Sentral, Lab, Radiologi).
- **Status Keaktifan Katalog**: Status aktif/non-aktif layanan.

#### B. Spesifikasi Varian Tarif Operasional:
- **ID Varian Tarif (`NilaiTarifId`)**: Identitas unik proyeksi varian operasional.
- **Kunci Komposit Varian**:
  - Referensi Layanan (`TarifId`).
  - Referensi Kelas Perawatan (`KelasId` — VVIP, VIP, Kelas 1, Kelas 2, Kelas 3, Non-Kelas).
  - Referensi Tipe Tarif (`TipeTarifId` — Tarif Umum/Bayar Sendiri, BPJS Kesehatan, Asuransi Kerjasama, Perusahaan).
- **Nilai Total Tarif (`NilaiHeader`)**: Besaran rupiah total yang dibebankan kepada pasien/penjamin.
- **Status Operasional Varian**: Status keberlakuan varian (Aktif / Non-Aktif).

#### C. Rincian Dekomposisi Komponen Biaya:
- **Nomor Urut Komponen (`NoUrut`)**: Urutan tampilan dan kalkulasi komponen biaya.
- **Identitas Komponen (`KomponenId` / `KomponenName`)**: Nama komponen (misal: Jasa Medis Operator, Jasa Rumah Sakit, BMHP).
- **Nilai Nominal Komponen (`NilaiKomponen`)**: Porsi rupiah dari total tarif untuk komponen ini.
- **Kelompok Komponen (`GroupKomponen`)**: Kategori biaya (Jasa Medis, Jasa Sarana, Jasa Perawat, dsb.).
- **Aturan Kelayakan PPA (`ListSatTugas`)**: Kumpulan kode satuan tugas/profesi medis yang berhak menerima jasa ini.
- **Akun Akuntansi Pendapatan (`RekPdpt`)**: Kode akun Chart of Accounts (COA) untuk penjurnalan kredit pendapatan.
- **Akun Akuntansi Diskon (`RekDiskon`)**: Kode akun COA untuk penjurnalan debet potongan/diskon.

#### D. Dokumen Kebijakan & Riwayat Aktivasi (Policy & Publish Audit):
- **Nomor Dokumen Kebijakan (`PolicyId` / Nomor SK)**: Dasar hukum penyesuaian tarif rumah sakit.
- **Judul / Uraian Kebijakan**: Penjelasan konteks perubahan tarif (misal: "Penyesuaian Tarif Pelayanan Bedah Tahun 2026").
- **Status Kebijakan**: Status administratif (`Draft`, `Reviewed`, `Published`, `Archived`).
- **Tanggal Efektif Kebijakan**: Tanggal administratif berlakunya SK (sebagai metadata informasi).
- **Petugas Penyusun (`CreatedBy`)**: Identitas staf keuangan/tarif penyusun draf.
- **Petugas Penelaah (`ReviewedBy`)**: Identitas verifikator/supervisor yang menyetujui draf.
- **Petugas Pengaktivasi (`PublishedBy`)**: Identitas pejabat/operator yang mengeksekusi aktivasi tarif ke sistem live.
- **Stempel Waktu Aktivasi (`PublishedAt`)**: Waktu presisi saat nilai tarif mulai mengikat transaksi operasional.
- **Catatan Aktivasi (`PublishNote`)**: Keterangan operasional pada saat penerbitan tarif.

---

### 5.3 Required Business Conditions

1. **Integritas Referensi Master:**
   - Varian tarif hanya dapat dibentuk apabila referensi katalog layanan (`Tarif`), kelas rawat (`Kelas`), dan tipe tarif (`TipeTarif`) berstatus aktif dan sah di sistem master.
2. **Keunikan Varian Aktif:**
   - Tidak boleh terdapat lebih dari satu entitas varian aktif untuk kombinasi `(Tarif, Kelas, TipeTarif)` yang identik pada waktu yang sama.
3. **Kewajiban Komponen Minimal:**
   - Setiap varian tarif wajib memiliki sekurang-kurangnya 1 (satu) baris komponen biaya aktif.
4. **Validasi Persamaan Keseimbangan:**
   - Sistem wajib menolak aktivasi kebijakan tarif jika ditemukan satu saja varian di mana total nilai komponen tidak sama dengan nilai total varian ($\sum \text{Komponen} \neq \text{Nilai Header}$).
5. **Otorisasi Aktivasi Bertingkat:**
   - Kebijakan tarif berstatus `Draft` tidak dapat langsung diaktivasi menjadi tarif operasional sebelum melewati tahap verifikasi review (`Reviewed`) atau otorisasi eksplisit yang berwenang.
6. **Perlindungan Snapshot Tagihan Terbuka:**
   - Tagihan pasien pada episode berjalan yang telah membukukan transaksi tindakan medis mempertahankan snapshot tarif pada tanggal pencatatan transaksi; pembaruan master tarif di tengah episode rawat inap tidak otomatis merubah rincian transaksi masa lalu.

---

### 5.4 Completion Proof

Outcome dinyatakan terwujud secara sah apabila:
1. Proyeksi varian tarif operasional untuk kombinasi `(Tarif, Kelas, TipeTarif)` tersimpan persisten dan dapat dibaca secara deterministik dengan latensi rendah oleh modul Billing, Registrasi, dan Tindakan.
2. Setiap panggilan lookup tarif mengembalikan nilai nominal total beserta rincian dekomposisi komponen biaya dan akun COA secara lengkap dan seimbang.
3. Rekaman jejak audit aktivasi (*Publish Log*) tersimpan permanen dengan relasi valid ke dokumen kebijakan penetapannya.
4. Uji pembebanan tindakan medis (`Tindakan`) membuktikan bahwa tarif dapat ditarik secara presisi tanpa intervensi penginputan harga manual oleh klinisi.

---

## 6. Outcome Boundary

### Start
Dimulai ketika manajemen keuangan rumah sakit menginisiasi perumusan tarif baru atau penyesuaian tarif berjalan dengan membentuk draf kebijakan tarif (*Tariff Policy Draft*), mendefinisikan varian kombinasi layanan, kelas, dan penjamin, serta menyusun rincian komponen biaya.

### End
Berakhir ketika kebijakan tarif dinyatakan lolos verifikasi keseimbangan komponen, diaktivasi secara sah (*published*) ke dalam repositori operasional aktif, dan siap dikonsumsi sebagai acuan pembebanan transaksi oleh seluruh unit rumah sakit.

---

## 7. Business Constraints

- **Single Source of Truth:** Seluruh unit pelayanan klinis dan administrasi dilarang menentukan harga layanan secara manual atau mandiri di luar master tarif resmi Tata Rekening (`TRK-TARIF`).
- **Zero Discrepancy Balance:** Selisih antara nilai total varian dan penjumlahan rincian komponen biaya harus nol rupiah tanpa toleransi pembulatan yang tidak teralokasi.
- **Explicit Manual Publish:** Aktivasi tarif operasional wajib dilakukan melalui tindakan otorisasi eksplisit (*manual publish*); tanggal efektif kebijakan kalender berfungsi sebagai informasi legal dan tidak mengaktifkan tarif secara otomatis tanpa eksekusi resmi.
- **PPA Assignment Guard:** Tindakan medis tidak dapat mencatatkan pembagian jasa medis kepada tenaga kesehatan apabila kualifikasi profesi pelaksana tidak memenuhi daftar `SatTugas` yang ditentukan pada komponen tarif.
- **Non-Retroactivity Rule:** Publikasi tarif baru tidak boleh mengakibatkan rekalkulasi atau mutasi retrospektif pada billing episode yang sudah tercatat atau ditutup.

---

## 8. Business Exceptions

| Kode | Kondisi Pengecualian | Perilaku Bisnis yang Diharapkan |
|------|----------------------|---------------------------------|
| **EX-TRF-01** | **Varian Tarif Tidak Ditemukan**<br>(Kombinasi layanan, kelas, dan tipe tarif belum terdaftar atau belum dipublikasikan). | Sistem pembebanan menolak pencatatan transaksi; menampilkan peringatan konfigurasi master tarif kepada petugas admisi/billing, dan mencatat insiden ketidaktersediaan tarif untuk eskalasi ke Tim Tata Rekening. |
| **EX-TRF-02** | **Ketidakseimbangan Komponen (Unbalanced Variant)**<br>(Jumlah komponen tidak sama dengan nilai total header saat validasi aktivasi). | Proses aktivasi (*publish*) diblokir sepenuhnya; sistem menyajikan laporan selisih nilai komponen per varian dan menolak perubahan status kebijakan hingga rincian komponen diperbaiki. |
| **EX-TRF-03** | **Duplikasi Varian dalam Kebijakan**<br>(Terdapat dua baris varian dengan kombinasi `Tarif + Kelas + TipeTarif` yang sama dalam satu draft). | Sistem menolak penambahan varian duplikat; operator diarahkan untuk memperbarui varian yang telah ada (*update variant*). |
| **EX-TRF-04** | **Ineligible PPA Assignment**<br>(Tenaga medis yang dicatat pada tindakan tidak memiliki kualifikasi yang cocok dengan komponen jasa medis). | Sistem pencatatan tindakan menolak pengikatan PPA pada baris komponen jasa tersebut, atau memberikan peringatan diskrepansi kualifikasi klinis sesuai kebijakan tata kelola PPA rumah sakit. |
| **EX-TRF-05** | **Percobaan Edit pada Kebijakan Terpublikasi**<br>(Operator mencoba mengubah rincian varian pada kebijakan yang sudah berstatus `Published`). | Sistem menolak mutasi langsung; operator diwajibkan membuat draf kebijakan baru (*Copy Policy* atau *New Draft*) untuk menerbitkan perubahan tarif berikutnya. |
| **EX-TRF-06** | **Akun COA Tidak Terdaftar / Tidak Aktif**<br>(Komponen tarif memetakan kode rekening pendapatan/diskon yang tidak aktif di master akuntansi). | Validasi penelaahan kebijakan menolak draf; mewajibkan pemetaan pos rekening yang aktif dan valid sebelum kebijakan dapat diajukan ke tahap review. |

---

## 9. Acceptance Criteria

| ID | Kriteria Penerimaan | Kategori Validasi |
|----|---------------------|-------------------|
| **AC-TRF-01** | Sistem berhasil memvalidasi dan menyimpan identitas katalog layanan (`TarifId`) tanpa nilai moneter langsung. | *Completeness* |
| **AC-TRF-02** | Sistem dapat mengonfigurasi varian tarif berbasis kombinasi unik 3 dimensi: `(Tarif, Kelas, TipeTarif)`. | *Correctness* |
| **AC-TRF-03** | Setiap varian tarif memiliki dekomposisi komponen biaya dengan persamaan $\text{Nilai Header} = \sum \text{Nilai Komponen}$ yang terverifikasi presisi. | *Financial Invariant* |
| **AC-TRF-04** | Komponen jasa medis membatasi eligibilitas pembagian jasa hanya kepada tenaga medis dengan kualifikasi `SatTugas` yang bersesuaian. | *Business Rule (PPA Gating)* |
| **AC-TRF-05** | Seluruh komponen biaya terpetakan ke pos rekening pendapatan (`RekPdpt`) dan diskon (`RekDiskon`) yang valid. | *Accounting Integrity* |
| **AC-TRF-06** | Proses aktivasi kebijakan tarif (*publish*) mencatat identitas operator, stempel waktu, nomor kebijakan, dan memperbarui proyeksi operasional secara deterministik. | *Auditability* |
| **AC-TRF-07** | Publikasi tarif baru terbukti tidak mengubah nilai nominal transaksi billing dan tindakan medis yang telah tercatat sebelumnya pada episode yang ada. | *Non-Retroactivity* |
| **AC-TRF-08** | Seluruh modul downstream (`TRK-BILLING`, `RNA-ROOM-CHARGE`, `Tindakan`) berhasil membaca tarif aktif sesuai kombinasi konteks pasien secara deterministik. | *Integration Completeness* |

---

## 10. Out of Scope

Outcome ini secara tegas **TIDAK mencakup**:
1. **Siklus Hidup Tagihan Episode Pasien:** Pembentukan akun piutang pasien, verifikasi rincian tagihan, dan finalisasi billing episode (merupakan wewenang eksklusif [`OC-TRK-BILLING`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-BILLING.md)).
2. **Kalkulasi Durasi & Okupansi Kamar:** Perhitungan lama hari rawat inap dan penanganan titip/naik kelas secara operasional (merupakan wewenang eksklusif [`OC-RNA-ROOM-CHARGE`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-ROOM-CHARGE.md) dan [`OC-RNA-PAKAI-BED`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-RNA-PAKAI-BED.md)).
3. **Penerimaan Pembayaran Kasir:** Eksekusi pelunasan, penerimaan fisik kas/non-kas, dan pencetakan kuitansi pembayaran (merupakan wewenang eksklusif [`OC-TRK-KASIR`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-KASIR.md) dan [`OC-TRK-ALOKASI-PEMBAYARAN`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/OC-TRK-ALOKASI-PEMBAYARAN.md)).
4. **Distribusi Remunerasi Payroll Nyata:** Proses pencairan insentif/payroll periodik kepada rekening dokter (merupakan wewenang modul Keuangan/SDM Payroll).
5. **Klaim Asuransi & Tarif INA-CBGs:** Perhitungan paket tarif klaim BPJS berbasis koding diagnosis ICD-10/9 (merupakan wewenang eksklusif domain [`BPJ-EKLAIM`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/15-BPJS-DOMAIN.md)).

---
*Dokumen ini merupakan definisi formal kanonikal Outcome Tarif Layanan dan Fasilitas Rumah Sakit Sistem Informasi Rumah Sakit MyHosWeb.*
