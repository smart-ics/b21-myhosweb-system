# OUTCOME: Antrian Apotek

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-01     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Pelayanan kefarmasian bagi pasien rawat jalan di rumah sakit memerlukan pengelolaan giliran pelayanan yang teratur, adil, dan transparan.

Antrian Apotek memastikan bahwa setiap pasien yang memerlukan pelayanan di apotek rawat jalan memperoleh nomor antrian yang sah dan tercatat sebagai fakta bisnis persisten, sehingga urutan pelayanan dapat dikelola secara konsisten, posisi antrian dapat diketahui oleh pasien, dan setiap nomor antrian terhubung secara akurat dengan tepat satu sumber pelayanan.

---

## 2. Outcome Statement

Entri antrian pelayanan apotek rawat jalan **telah tercatat dan diterbitkan dengan nomor antrian yang sah, perkembangannya terpantau secara transparan dan akuntabel dari penerbitan hingga pelayanan selesai atau dibatalkan, dan pada saat sumber pelayanan telah diidentifikasi, antrian tersebut terhubung tepat ke satu sumber pelayanan**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Apotek (`APT`) | Pemilik utama: mencatat dan mengelola entri antrian apotek, memelihara status perkembangan pelayanan, dan memetakan antrian ke sumber pelayanan kefarmasian. |
| Admission (`ADM`) | Menyediakan konteks pelacakan alur pelayanan pasien (*Patient Journey*) dari poliklinik rawat jalan menuju instalasi farmasi. |
| Pasien (`PAS`) | Menyediakan identitas pasien yang menjadi subjek penerima pelayanan obat. |
| Organisasi (`ORG`) | Menyediakan data unit layanan farmasi/apotek dan loket pelayanan tempat antrian dikelola. |
| Rawat Jalan (`RJL`) | Menyediakan konteks pelayanan asal bagi resep obat yang diterbitkan dari poliklinik. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-QUEUE` Antrian Apotek | Apotek | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Nomor antrian apotek yang sah dan unik untuk hari pelayanan telah diterbitkan dan tercatat dalam sistem.
- Setiap nomor antrian mencatat apakah sumber pelayanan telah diidentifikasi atau belum:
  - Jika sumber pelayanan **belum diidentifikasi**, antrian tetap valid dan dapat diproses lebih lanjut oleh petugas.
  - Jika sumber pelayanan **sudah diidentifikasi**, antrian tersebut terhubung ke **tepat satu** sumber pelayanan (resep masuk dari sistem, resep kertas/kerja, atau jual bebas). Satu nomor antrian tidak dapat dihubungkan ke lebih dari satu sumber pelayanan.
- Status perkembangan pelayanan antrian tercatat sebagai fakta bisnis yang bertahap dan dapat dibedakan:
  - **Menunggu Pelayanan**: antrian aktif menunggu pemanggilan atau pemrosesan.
  - **Dipanggil / Sedang Dilayani**: antrian sedang dalam proses pelayanan oleh petugas apotek.
  - **Selesai**: seluruh proses pelayanan kefarmasian untuk nomor antrian tersebut telah tuntas.
  - **Dibatalkan**: antrian dihentikan sebelum selesai.
- Informasi nomor antrian, loket pelayanan, dan status pelayanan tercatat dan dapat disajikan kepada pasien.

### 5.2 Required Recorded Information

- Nomor antrian apotek (kode/nomor urut pelayanan yang unik pada hari tersebut).
- Unit apotek tujuan dan loket pelayanan yang menangani.
- Tanggal dan waktu penerbitan nomor antrian.
- Status pelayanan antrian saat ini (**Menunggu Pelayanan**, **Dipanggil / Sedang Dilayani**, **Selesai**, atau **Dibatalkan**).
- Kondisi keterikatan sumber pelayanan: apakah sumber pelayanan sudah diidentifikasi atau belum.
- Jenis sumber pelayanan (resep masuk dari sistem, resep kertas/kerja, atau jual bebas / non-resep) — jika sudah teridentifikasi.
- Referensi ke sumber pelayanan (misalnya nomor resep) — jika sudah terpetakan.
- Identitas pasien (Nomor Rekam Medis dan/atau nama pasien) jika sudah diketahui.
- Loket / titik pelayanan tempat antrian dipanggil atau dilayani.
- Riwayat waktu pelayanan: waktu penerbitan antrian, waktu pemanggilan, dan waktu penyelesaian atau pembatalan.
- Identitas petugas yang memanggil, memetakan, atau menyelesaikan antrian.
- Catatan bahwa pemanggilan dilakukan di luar urutan nomor normal — jika kondisi tersebut terjadi.

### 5.3 Required Business Conditions

- Nomor antrian apotek dapat diterbitkan sebelum sumber pelayanan teridentifikasi, maupun bersamaan saat sumber pelayanan sudah diketahui.
- Pada saat sumber pelayanan telah diidentifikasi, satu nomor antrian hanya dapat dihubungkan ke tepat satu sumber pelayanan. Tidak diperbolehkan menggabungkan dua resep berbeda, atau resep dengan transaksi jual bebas, ke dalam satu nomor antrian yang sama.
- Urutan nomor antrian adalah urutan pelayanan normal/default, namun petugas apotek memiliki wewenang untuk memilih dan memanggil nomor antrian lain di luar urutan berdasarkan kondisi pelayanan nyata di apotek.
- Sistem tidak melakukan penghitungan tingkat urgensi secara otomatis dan tidak menghitung estimasi waktu tunggu (*estimated waiting time*).
- Pelayanan suatu nomor antrian tidak dapat dinyatakan selesai (**Selesai**) sebelum sumber pelayanannya berhasil diidentifikasi.

### 5.4 Completion Proof

- Entri antrian apotek tercatat dalam sistem dan dapat ditemukan berdasarkan tanggal pelayanan, nomor antrian, loket, nomor rekam medis pasien, atau referensi sumber pelayanan.
- Nomor antrian apotek memiliki status akhir **Selesai** (pelayanan tuntas diserahkan) atau **Dibatalkan** (antrian ditutup tanpa penyerahan).
- Keterikatan antrian dengan sumber pelayanan tercatat dengan status **Terpetakan** (untuk antrian yang selesai).
- Riwayat perkembangan pelayanan (waktu terbit, waktu panggil/layani, loket penanganan, dan waktu penyelesaian) tercatat secara lengkap dan dapat diverifikasi.

---

## 6. Outcome Boundary

### Start

Dimulai ketika nomor antrian apotek diterbitkan dan entri antrian baru tercatat dalam sistem.

### End

Berakhir ketika entri antrian apotek mencapai kondisi terminal:
1. Status pelayanan berubah menjadi **Selesai** — pelayanan kefarmasian untuk nomor antrian tersebut telah tuntas dilakukan; ATAU
2. Status pelayanan berubah menjadi **Dibatalkan** — antrian ditutup sebelum pelayanan selesai.

> **Catatan:** Outcome Antrian Apotek bersifat harian. Setiap nomor antrian hanya berlaku pada tanggal pelayanan yang bersangkutan dan tidak dibawa ke hari berikutnya.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Urutan Pelayanan Default:** Urutan nomor antrian merupakan urutan pelayanan standar/normal di apotek.
- **Diskresi Pemanggilan Petugas:** Petugas apotek memiliki kewenangan untuk memanggil nomor antrian di luar urutan normal apabila kondisi pelayanan di apotek mengharuskannya.
- **Relasi Tunggal (1:1) Pasca Identifikasi:** Setelah sumber pelayanan diidentifikasi, satu nomor antrian hanya dapat terhubung ke tepat satu sumber pelayanan. Penggabungan beberapa sumber pelayanan ke dalam satu nomor antrian dilarang.
- **Fleksibilitas Penerbitan Awal:** Nomor antrian dapat diterbitkan sebelum sumber pelayanannya diketahui, dan dapat dimapping kemudian oleh petugas.
- **Prasyarat Penyelesaian Pelayanan:** Pelayanan suatu nomor antrian tidak dapat dinyatakan **Selesai** sebelum sumber pelayanannya berhasil diidentifikasi.
- **Larangan Otomasi Urgensi:** Sistem dilarang menentukan atau menghitung tingkat urgensi secara otomatis; penentuan prioritas pelayanan di luar nomor urut adalah wewenang petugas apotek.
- **Larangan Estimasi Waktu Tunggu:** Sistem dilarang menghitung atau menampilkan perkiraan waktu tunggu kepada pasien. Informasi antrian yang disajikan kepada pasien hanya berupa nomor antrian, loket, dan status pelayanan.
- **Keunikan Nomor Antrian Harian:** Nomor antrian apotek harus unik dalam konteks pelayanan apotek dan tanggal pelayanan yang sama.

---

## 8. Business Exceptions

> Conditions under which the Outcome deviates from normal flow or cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Sumber pelayanan tidak dapat diidentifikasi saat proses pemetaan | Antrian tetap aktif tanpa sumber pelayanan terhubung. Petugas melakukan konfirmasi manual ke unit terkait. Jika sumber pelayanan tidak dapat ditemukan atau tidak sah, antrian dapat ditutup dengan status **Dibatalkan**. |
| Sumber pelayanan yang dipilih sudah terikat pada nomor antrian aktif lain | Pemetaan ditolak. Petugas diberitahu bahwa sumber pelayanan tersebut sudah memiliki nomor antrian aktif dan diarahkan untuk menggunakan atau membatalkan antrian yang sudah ada. |
| Pasien tidak merespons saat nomor antrian dipanggil | Petugas dapat melewati (*skip*) antrian tersebut dan melanjutkan pemanggilan ke nomor berikutnya. Nomor yang dilewati tetap tercatat sebagai antrian aktif dan dapat dipanggil kembali. |
| Pasien membatalkan atau meninggalkan apotek sebelum pelayanan selesai | Antrian diubah statusnya menjadi **Dibatalkan** dengan mencatat alasan pembatalan. |
| Resep dari poliklinik dibatalkan oleh dokter setelah nomor antrian diterbitkan | Antrian terkait tidak memiliki sumber pelayanan yang sah; antrian disesuaikan menjadi **Dibatalkan**. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Nomor antrian apotek yang diterbitkan tercatat dengan nomor urut unik untuk unit apotek dan tanggal pelayanan yang bersangkutan. | Completeness |
| AC-02 | Setiap entri antrian apotek mencatat waktu penerbitan, unit apotek, status pelayanan, dan kondisi keterikatan sumber pelayanan. | Completeness |
| AC-03 | Nomor antrian apotek dapat diterbitkan sebelum sumber pelayanan diidentifikasi — entri antrian tercatat sah dengan kondisi sumber belum diketahui. | Correctness |
| AC-04 | Setelah sumber pelayanan diidentifikasi, entri antrian mencatat keterikatan ke tepat satu sumber pelayanan (resep masuk dari rawat jalan, resep kertas/kerja, atau jual bebas). | Correctness |
| AC-05 | Tidak terdapat entri antrian yang memiliki keterikatan ke lebih dari satu sumber pelayanan. | Constraint |
| AC-06 | Entri antrian yang memiliki sumber pelayanan terpetakan tidak dapat dinyatakan **Selesai** tanpa sumber pelayanan tersebut tercatat. | Constraint |
| AC-07 | Entri antrian yang dilayani di luar urutan nomor normal memiliki catatan bahwa pelayanan dilakukan di luar urutan. | Correctness |
| AC-08 | Entri antrian tidak memuat informasi estimasi waktu tunggu atau perkiraan jadwal selesai. | Constraint |
| AC-09 | Informasi nomor antrian, loket, dan status pelayanan tercatat dalam sistem dan dapat diambil untuk disajikan kepada pasien. | Completeness |
| AC-10 | Entri antrian yang berstatus **Selesai** memiliki sumber pelayanan terpetakan, loket pelayanan, dan waktu penyelesaian yang tercatat. | Completeness |
| AC-11 | Entri antrian yang berstatus **Dibatalkan** memiliki catatan alasan pembatalan dan identitas petugas yang membatalkan. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Telaah Resep Klinis & Administratif:** Kajian kesesuaian dosis, interaksi obat, dan persyaratan farmasi → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Transaksi Penjualan & Pembayaran:** Perhitungan harga obat, pembuatan *sales order/bill*, dan transaksi kasir → **OC-11-03 Penjualan** (`APT-ORDER`, `APT-BILL`, `TRK-BILLING`).
- **Penyiapan & Peracikan Fisik Obat:** Proses dispensing fisik, pengambilan obat dari rak, peracikan puyer/kapsul, dan pemberian etiket → **OC-11-04 Dispensing** (`APT-DISPENSING`).
- **Penyerahan & Konseling Obat:** Penyerahan fisik obat kepada pasien, verifikasi identitas penerima obat, serta pemberian edukasi/KIE → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Pencatatan Stok & Mutasi Obat:** Pengurangan stok apotek dan penyesuaian kartu stok → **Inventory Domain** (`INV-STOK`, `INV-MUTASI`).
- **Antrian Unit Lain:** Antrian pendaftaran admisi dan antrian pelayanan poli rawat jalan → **OC-01-07 Antrian** (`ADM-ANTRIAN`, `RJL-ANTRIAN`).
- **Penghitungan Urgensi Otomatis:** Sistem klasifikasi prioritas otomatis berbasis kecerdasan buatan atau algoritma triase farmasi otomatis.
- **Estimasi Waktu Tunggu:** Algoritma prediksi durasi tunggu atau waktu estimasi obat selesai.
- **Perangkat Keras & Desain Fisik:** Pengadaan mesin kiosk fisik, instalasi kabel pengeras suara, rancangan teknis monitor display, atau hardware audio pemanggil.
