# OUTCOME: Antrian Apotek

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-03   |

---

## 1. Business Purpose

Pelayanan kefarmasian bagi pasien rawat jalan di rumah sakit memerlukan pengelolaan alur kedatangan dan giliran pelayanan yang teratur, adil, transparan, dan akuntabel.

Antrian Apotek memastikan bahwa setiap pasien atau perwakilan pasien yang memerlukan pelayanan di apotek rawat jalan memperoleh nomor antrian yang sah, tercatat dalam sistem, dan terhubung secara akurat dengan satu sumber pelayanan (baik resep elektronik dari poliklinik, resep kertas/manual yang dibawa pasien, maupun transaksi tanpa resep seperti Jual Bebas).

Dengan adanya Antrian Apotek yang tercatat sebagai fakta bisnis persisten (*persisted business fact*), apotek dapat mengendalikan arus pelayanan, memantau riwayat pemanggilan dan penyelesaian, menyediakan transparansi posisi antrian kepada pasien melalui papan informasi (*display*), serta memberikan fleksibilitas kepada petugas apotek untuk mengambil keputusan pemanggilan berdasarkan kondisi pelayanan riil di lapangan.

---

## 2. Outcome Statement

Entri antrian pelayanan apotek rawat jalan **telah tercatat dan diterbitkan dengan nomor antrian yang sah, terhubung tepat ke satu sumber pelayanan, serta perkembangannya terpantau secara transparan dan akuntabel dari penerbitan hingga pelayanan selesai atau dibatalkan**.

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
- Entri antrian apotek merepresentasikan **tepat satu sumber pelayanan** (hubungan 1:1) dan tidak menggabungkan dua sumber pelayanan berbeda.
- Kondisi hubungan (*mapping*) antara nomor antrian dan sumber pelayanan tercatat secara tegas:
  - **Belum Terpetakan (*Unmapped*)**: nomor antrian sudah terbit namun belum dikaitkan dengan sumber pelayanan spesifik.
  - **Terpetakan (*Mapped*)**: nomor antrian telah terhubung secara definitif dengan tepat satu sumber pelayanan (resep sistem, resep kerja/kertas, atau jual bebas).
- Status perkembangan pelayanan antrian tercatat sebagai fakta bisnis yang bertahap dan dapat dibedakan:
  - **Menunggu Pelayanan**: antrian aktif menunggu pemanggilan atau pemrosesan.
  - **Dipanggil / Sedang Dilayani**: antrian sedang dipanggil di loket tertentu atau sedang diproses oleh petugas apotek.
  - **Selesai**: seluruh proses pelayanan kefarmasian untuk nomor antrian tersebut telah tuntas.
  - **Dibatalkan**: antrian dihentikan sebelum selesai (misalnya pasien tidak hadir atau membatalkan pelayanan).
- Informasi nomor antrian, loket pelayanan, dan status pelayanan tersedia untuk disajikan pada sarana informasi pasien (*display* antrian).

### 5.2 Required Recorded Information

- Nomor antrian apotek (kode/nomor urut pelayanan yang unik pada hari tersebut).
- Unit apotek tujuan dan loket pelayanan yang menangani.
- Tanggal dan waktu penerbitan nomor antrian.
- Status pelayanan antrian saat ini (**Menunggu Pelayanan**, **Dipanggil / Sedang Dilayani**, **Selesai**, atau **Dibatalkan**).
- Status keterikatan sumber pelayanan (**Belum Terpetakan** atau **Terpetakan**).
- Jenis sumber pelayanan (Resep Masuk dari Sistem, Resep Kertas/Kerja, atau Jual Bebas / Non-resep).
- Referensi dokumen/transaksi sumber pelayanan (misalnya nomor resep atau nomor order penjualan jika sudah terpetakan).
- Identitas pasien (Nomor Rekam Medis dan/atau nama pasien) jika sudah diketahui atau terhubung dengan resep/identitas yang sah.
- Loket pemanggil / titik layanan tempat antrian dipanggil atau dilayani.
- Catatan riwayat waktu pelayanan (*lifecycle timestamps*): waktu penerbitan antrian, waktu pemanggilan, dan waktu penyelesaian/pembatalan.
- Identitas petugas yang memanggil, memetakan, atau menyelesaikan antrian.
- Catatan tindakan pemanggilan di luar urutan normal (jika petugas memilih nomor antrian di luar urutan nomor default).

### 5.3 Required Business Conditions

- Nomor antrian apotek dapat diterbitkan sebelum sumber pelayanan teridentifikasi/terhubung (misalnya saat pasien mengambil nomor di kiosk), atau diterbitkan bersamaan saat resep elektronik diterima oleh apotek.
- Suatu nomor antrian yang berstatus Belum Terpetakan (*Unmapped*) wajib diidentifikasi dan dimapping ke tepat satu sumber pelayanan sebelum pelayanan kefarmasian definitif dinyatakan selesai.
- Satu nomor antrian hanya boleh terikat pada satu sumber pelayanan. Tidak diperbolehkan menggabungkan dua resep berbeda atau resep dengan transaksi jual bebas ke dalam satu nomor antrian yang sama.
- Satu sumber pelayanan aktif hanya boleh memiliki satu entri antrian apotek aktif pada hari pelayanan yang sama.
- Urutan nomor antrian adalah urutan pelayanan normal/default, namun petugas apotek memiliki wewenang untuk memilih dan memanggil nomor antrian lain di luar urutan nomor berdasarkan kondisi pelayanan nyata di apotek.
- Sistem tidak melakukan penghitungan tingkat urgensi secara otomatis dan tidak menghitung estimasi waktu tunggu (*estimated waiting time*).
- Status perkembangan pelayanan harus mengikuti transisi yang sah dan tidak boleh melompati tahap validasi pemetaan sebelum penyelesaian.

### 5.4 Completion Proof

- Entri antrian apotek tercatat dalam sistem dan dapat ditemukan berdasarkan tanggal pelayanan, nomor antrian, loket, nomor rekam medis pasien, atau referensi sumber pelayanan.
- Nomor antrian apotek memiliki status akhir **Selesai** (pelayanan tuntas diserahkan) atau **Dibatalkan** (antrian ditutup tanpa penyerahan).
- Keterikatan antrian dengan sumber pelayanan tercatat dengan status **Terpetakan** (untuk antrian yang selesai).
- Riwayat perkembangan pelayanan (waktu terbit, waktu panggil/layani, loket penanganan, dan waktu penyelesaian) tercatat secara lengkap dan dapat diverifikasi.

---

## 6. Outcome Boundary

### Start

Dimulai ketika nomor antrian apotek diterbitkan dan entri antrian baru tercatat dalam sistem — baik melalui pengambilan mandiri oleh pasien/keluarga di kiosk antrian apotek, pencetakan/penerbitan oleh petugas apotek, maupun saat resep dari poliklinik masuk ke antrian apotek.

### End

Berakhir ketika entri antrian apotek mencapai kondisi terminal:
1. Status pelayanan berubah menjadi **Selesai** (pelayanan kefarmasian untuk nomor antrian tersebut telah tuntas dilakukan); ATAU
2. Status pelayanan berubah menjadi **Dibatalkan** (pasien tidak hadir setelah pemanggilan berulang atau pasien membatalkan proses pelayanan obat).

> **Catatan Batasan Waktu:** Outcome Antrian Apotek bersifat harian (*daily operational cycle*). Setiap nomor antrian hanya berlaku pada tanggal pelayanan yang bersangkutan dan tidak dibawa ke hari berikutnya.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- **Urutan Pelayanan Default:** Urutan nomor antrian merupakan urutan pelayanan standar/normal di apotek.
- **Diskresi Pemanggilan Petugas:** Petugas apotek memiliki kewenangan operasional untuk memanggil nomor antrian di luar urutan nomor normal apabila kondisi pelayanan di apotek mengharuskannya (misalnya kesiapan obat racikan vs non-racikan, kebutuhan telaah/klarifikasi dengan dokter, atau kehadiran fisik pasien di ruang tunggu).
- **Relasi Tunggal (1:1):** Satu nomor antrian hanya merepresentasikan tepat satu sumber pelayanan. Penggabungan beberapa sumber pelayanan ke dalam satu nomor antrian dilarang.
- **Fleksibilitas Penerbitan Awal:** Nomor antrian tidak selalu harus langsung memiliki sumber pelayanan pada saat diterbitkan; nomor antrian dapat diterbitkan dalam kondisi Belum Terpetakan (*Unmapped*) dan dimapping kemudian oleh petugas.
- **Prasyarat Penyelesaian Pelayanan:** Pelayanan suatu nomor antrian tidak dapat diselesaikan (**Selesai**) sebelum nomor antrian tersebut berhasil dimapping secara definitif ke satu sumber pelayanan yang sah.
- **Larangan Otomasi Urgensi:** Sistem dilarang menentukan atau menghitung tingkat urgensi secara otomatis; penentuan prioritas pelayanan di luar nomor urut adalah wewenang klinis/operasional petugas apotek.
- **Larangan Estimasi Waktu Tunggu:** Sistem dilarang menghitung atau menampilkan perkiraan waktu tunggu (*estimated waiting time*) kepada pasien. Display antrian hanya menyajikan informasi faktual berupa nomor antrian, loket, dan status pelayanan agar pasien dapat memantau posisinya secara mandiri.
- **Keunikan Nomor Antrian Harian:** Nomor antrian apotek harus unik untuk setiap unit apotek pada tanggal pelayanan yang sama.
- **Ketertutupan Status Akhir (*Immutability of Terminal State*):** Antrian yang sudah berstatus **Selesai** atau **Dibatalkan** bersifat permanen dan tidak dapat diaktifkan kembali. Pelayanan baru memerlukan penerbitan nomor antrian baru.

---

## 8. Business Exceptions

> Conditions under which the Outcome deviates from normal flow or cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| Sumber pelayanan tidak ditemukan saat proses pemetaan | Antrian tetap berstatus **Belum Terpetakan**. Petugas melakukan konfirmasi manual ke unit poliklinik atau mencari berkas resep kertas. Jika sumber pelayanan tetap tidak ditemukan atau tidak sah, antrian dapat ditandai **Dibatalkan**. |
| Sumber pelayanan yang dipilih sudah terikat pada nomor antrian aktif lain | Sistem menolak pemetaan ganda. Petugas diberitahu bahwa sumber pelayanan tersebut sudah memiliki nomor antrian aktif dan diarahkan untuk menggunakan antrian yang sudah ada atau membatalkan antrian duplikat. |
| Pasien tidak merespons saat nomor antrian dipanggil | Petugas dapat menandai antrian sebagai dilewati (*skip* / panggilan tertunda) dan melanjutkan pemanggilan ke nomor berikutnya. Pasien yang bersangkutan dapat dipanggil kembali sewaktu hadir tanpa kehilangan hak antriannya, atau dibatalkan jika melebihi batas waktu tunggu yang ditentukan apotek. |
| Pasien membatalkan transaksi atau meninggalkan apotek sebelum obat selesai diproses | Antrian diubah statusnya menjadi **Dibatalkan** dengan mencatat alasan pembatalan dari pasien atau petugas. |
| Resep dari sistem poliklinik dibatalkan oleh dokter setelah nomor antrian diterbitkan | Status antrian apotek terkait disesuaikan menjadi **Dibatalkan** dengan keterangan resep dibatalkan oleh peresep. |
| Terjadi gangguan sarana cetak atau kiosk mandiri saat pasien mengambil antrian | Petugas apotek dapat menerbitkan nomor antrian secara langsung dari loket sehingga antrian tetap tercatat dalam sistem secara sah. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Nomor antrian apotek yang diterbitkan tercatat dengan kode/nomor urut unik untuk unit apotek dan tanggal pelayanan yang bersangkutan. | Completeness |
| AC-02 | Setiap entri antrian apotek mencatat waktu penerbitan, unit apotek, loket, status pelayanan, dan status keterikatan sumber pelayanan. | Completeness |
| AC-03 | Nomor antrian apotek dapat diterbitkan dalam kondisi Belum Terpetakan (*Unmapped*) tanpa mengharuskan sumber pelayanan langsung tersedia saat nomor dibuat. | Correctness |
| AC-04 | Nomor antrian apotek dapat dihubungkan ke sumber pelayanan yang sah (resep masuk dari rawat jalan, resep kertas/manual, atau transaksi jual bebas) sehingga status keterikatannya berubah menjadi Terpetakan (*Mapped*). | Correctness |
| AC-05 | Sistem mencegah satu nomor antrian dihubungkan ke lebih dari satu sumber pelayanan (menegakkan aturan 1:1). | Constraint |
| AC-06 | Sistem menolak pemetaan jika sumber pelayanan yang dipilih sudah terhubung dengan nomor antrian apotek lain yang masih aktif pada hari yang sama. | Constraint |
| AC-07 | Petugas apotek dapat memilih dan memanggil nomor antrian di luar urutan nomor normal tanpa halangan dari sistem, dan tindakan tersebut tercatat dalam riwayat antrian. | Correctness |
| AC-08 | Sistem tidak menampilkan perhitungan atau estimasi waktu tunggu (*estimated waiting time*) pada informasi antrian. | Constraint |
| AC-09 | Informasi nomor antrian, loket, dan status perkembangan pelayanan dapat disajikan untuk display ruang tunggu pasien. | Completeness |
| AC-10 | Status pelayanan antrian dapat diperbarui secara berurutan (**Menunggu Pelayanan** → **Dipanggil / Sedang Dilayani** → **Selesai** atau **Dibatalkan**). | Correctness |
| AC-11 | Antrian yang belum terpetakan ke sumber pelayanan tidak dapat diubah statusnya menjadi **Selesai**. | Constraint |
| AC-12 | Antrian yang telah berstatus **Selesai** atau **Dibatalkan** tidak dapat diubah kembali statusnya menjadi aktif. | Constraint |
| AC-13 | Antrian yang pasiennya tidak merespons pemanggilan dapat dilewati (*skip*) untuk memanggil antrian berikutnya, dan tetap dapat dipanggil kembali oleh petugas sebelum ditutup. | Exception |
| AC-14 | Antrian yang dibatalkan mencatat status **Dibatalkan** beserta alasan pembatalan dan identitas petugas yang membatalkan. | Exception |

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
