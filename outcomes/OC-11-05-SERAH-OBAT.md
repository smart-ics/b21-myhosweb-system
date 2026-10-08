# OUTCOME: Serah Obat

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-05     |
| Version     | 1.2          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Serah Obat adalah outcome final pelayanan farmasi rawat jalan ketika sediaan obat yang telah selesai disiapkan melalui proses penyiapan (*Dispensing*), serta telah memenuhi seluruh gerbang keselamatan (*safety gates*) klinis dan administratif yang diwajibkan, benar-benar diserahkan secara fisik kepada pasien atau penerima yang berhak di loket penyerahan farmasi.

Tujuan bisnis Serah Obat adalah:
1. **Menegakkan Pemisahan Otoritas Profesional dan Eksekusi Operasional:** Memisahkan hak profesional klinis Apoteker dalam memvalidasi gerbang keselamatan klinis (Final Dispense Review, Pelayanan Informasi Obat / PIO, serta persetujuan Collection Window Override) dari hak operasional pelaksanaan penyerahan di loket (pemanggilan pasien, penyerahan fisik obat, dan pencatatan serah di sistem) yang dapat dilaksanakan oleh Apoteker maupun Staf Farmasi Terotorisasi / Tenaga Vokasi Farmasi.
2. **Menjamin Pemenuhan Seluruh Safety Gates Sebelum Penyerahan Fisik:** Menjamin obat tidak dapat diserahkan sebelum seluruh prasyarat keselamatan terpenuhi lengkap (pemanggilan loket tercatat, telaah akhir fisik lolos oleh Apoteker, pemberian informasi obat dikonfirmasi oleh Apoteker, pelunasan pembayaran terverifikasi untuk pasien umum, serta persetujuan perpanjangan sah apabila batas waktu pengambilan terlampaui).
3. **Menetapkan Fakta Bisnis Penyerahan Fisik yang Definitif dan Permanen:** Menegaskan bahwa Serah Obat bukan sekadar perubahan status administratif antrean atau pemanggilan loket, melainkan pencatatan persisten atas peristiwa fisik penyerahan obat yang telah dieksekusi secara sah, serta mengikat status akhir pekerjaan penyiapan (*Dispensing Job*) menjadi **Completed** dengan prinsip penyerahan sekali selesai.
4. **Menjamin Keutuhan Penyerahan (*Full Handover*):** Menerapkan aturan penyerahan utuh (*1 Dispensing = 1 Full Handover*) tanpa penyerahan sebagian (*Partial Handover*) pada level Serah Obat. Pemenuhan sebagian diselesaikan tuntas pada level pesanan (*Sales Order*) dan penyiapan (*Dispensing*).
5. **Kemandirian Fakta Penyerahan dari Proses Lanjutan:** Memastikan keberhasilan penyerahan fisik obat sebagai fakta bisnis mandiri yang sah, yang memicu pembaruan persediaan dan proses penjaminan/klaim tanpa menjadikan ketergantungan teknis proses lanjutan sebagai penentu keabsahan penyerahan obat.

Serah Obat secara tegas **BUKAN**:
- **Penyelesaian Antrean Administratif:** Status antrean atau pelacak alur pelayanan pasien yang berstatus selesai bukan bukti bahwa obat telah diserahkan.
- **Pemanggilan Pasien (*Pickup Call*):** Pemanggilan pasien ke loket penyerahan hanya membuktikan panggilan telah dilakukan, bukan bukti bahwa obat telah diterima oleh pasien.
- **Telaah Resep Dokter:** Pengkajian administratif, farmasetis, dan klinis atas resep dokter adalah wewenang penuh **OC-11-02 (Telaah Resep)**.
- **Komersial & Penjualan:** Penetapan komitmen kuantitas pesanan, pemisahan jalur penjamin, penetapan harga, dan penerbitan faktur tagihan adalah wewenang penuh **OC-11-03 (Penjualan)**.
- **Penyiapan & Pengawasan Fisik (*Dispensing*):** Pengambilan obat, peracikan, pengemasan, pelabelan etiket, dan penjagaan fisik sediaan (*physical custody*) adalah wewenang penuh **OC-11-04 (Dispensing)**.
- **Administrasi Klinis Pemberian Obat (*Medication Administration*):** Tindakan medis meminumkan atau menyuntikkan obat ke tubuh pasien adalah wewenang klinis ruang perawatan / rawat inap / EMR.
- **Prosedur Pengembalian Obat (*Return / Reversal*):** Penanganan obat yang dikembalikan setelah penyerahan selesai adalah wewenang proses retur tersendiri (**APT-RETUR**).

---

## 2. Outcome Statement

Sediaan obat yang telah selesai disiapkan dan berada dalam status siap serah (*Ready for Pickup*) **telah diverifikasi kelolosan seluruh safety gates klinis dan administratifnya oleh pihak yang berwenang, telah diserahkan secara fisik secara utuh (Full Handover) kepada pasien atau penerima yang berhak di loket farmasi, dan peristiwa penyerahan tersebut telah dicatat secara sah dan permanen sehingga status Dispensing bertransisi secara definitif menjadi Completed**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Serah Obat (`APT-SERAH`): mengelola siklus penyerahan obat, memverifikasi kelolosan safety gates klinis, mencatat eksekusi penyerahan fisik operasional, dan mentransisikan pekerjaan penyiapan (*Dispensing Job*) dari `Ready for Pickup` menjadi status akhir `Completed`. |
| **Organisasi (`ORG`)** | Menyediakan konteks unit layanan farmasi (`ORG-LAYANAN`) dan otorisasi peran petugas (`ORG-PPA`), yang membedakan otoritas profesional klinis Apoteker (untuk Final Review, KIE/PIO, dan Override) dari otoritas operasional loket penyerahan (Apoteker atau Staf Farmasi Terotorisasi). |
| **Tata Rekening (`TRK`)** | Kolaborator finansial: menyediakan kepastian pelunasan pembayaran tagihan obat (*Payment Clearance* via `TRK-PAYMENT` / `TRK-BILLING`) untuk memvalidasi kelayakan penyerahan obat bagi pasien jalur umum / bayar mandiri (*General / Self-Pay*). |
| **Pasien (`PAS`)** | Subjek pelayanan: menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) sebagai penerima manfaat terapi obat. |
| **Inventory (`INV`)** | Kolaborator persediaan: menerima konfirmasi penyerahan obat untuk pembaruan persediaan fisik (`INV-STOK`) tanpa memengaruhi keabsahan status penyerahan obat. |
| **BPJS (`BPJ`)** | Kolaborator jaminan: menerima konfirmasi penyerahan obat untuk proses penagihan klaim penjamin (`BPJ-VCLAIM`) tanpa memengaruhi keabsahan status penyerahan obat. |
| **Admission (`ADM`)** | Kolaborator perjalanan pasien: menerima pembaruan peristiwa penyerahan obat untuk pelacakan alur pelayanan pasien (`ADM-TRACKER`) di instalasi farmasi. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-SERAH` Serah Obat | Apotek | Known |
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `TRK-PAYMENT` Payment | Tata Rekening | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `INV-STOK` Stok | Inventory | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |

> **Batasan Kepemilikan:**
> - Kapabilitas `APT-DISPENSING` menyediakan sediaan berstatus *Ready for Pickup* sebagai titik awal Serah Obat dan menerima pembaruan status akhir menjadi *Completed*.
> - Kapabilitas `INV-STOK` dan `BPJ-VCLAIM` murni berperan menerima peristiwa pasca-serah tanpa menentukan keabsahan status penyerahan obat.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

#### A. Hakikat Serah Obat
1. **Perpindahan Fisik Sediaan:** Serah Obat adalah peristiwa fisik berpindahnya penguasaan sediaan obat dari instalasi farmasi kepada pasien atau penerima yang berhak di loket apotek setelah seluruh safety gates terpenuhi.
2. **Pembedaan dari Status Administratif:** Keberhasilan penyerahan obat tidak dapat disimpulkan dari status antrean yang selesai (*Done*), pelacakan alur pelayanan pasien, atau pemanggilan pasien ke loket (*Pickup Call*). Outcome baru tercapai saat penyerahan fisik dieksekusi dan dicatat secara sah.

#### B. Pemisahan Otoritas Profesional dan Operasional
1. **Otoritas Profesional Klinis (Apoteker):**
   - Apoteker memiliki wewenang eksklusif atas gerbang keselamatan (*safety gates*) klinis.
   - Tindakan yang wajib dilakukan sendiri oleh Apoteker dan tidak dapat didelegasikan kepada staf:
     - Melakukan pemeriksaan fisik akhir sediaan (*Final Dispense Review*) dengan hasil **Pass**.
     - Memberikan Pelayanan Informasi Obat (PIO/KIE) kepada pasien/penerima dan mengonfirmasi pencatatannya.
     - Menyetujui pembukaan blokir pengambilan jika masa tunggu pengambilan terlampaui (*Collection Window Override*).
2. **Otoritas Eksekusi Operasional (Staf Farmasi Terotorisasi atau Apoteker):**
   - Tindakan operasional di loket penyerahan meliputi memanggil pasien ke loket (*Pickup Call*), menyerahkan paket obat fisik, dan mencatat eksekusi penyerahan di sistem.
   - Tindakan operasional ini dapat dilakukan oleh **Staf Farmasi Terotorisasi / Tenaga Vokasi Farmasi**, atau dilakukan langsung oleh **Apoteker**.
   - Staf farmasi hanya dapat mengeksekusi penyerahan di sistem setelah seluruh gerbang keselamatan klinis yang menjadi wewenang Apoteker telah terpenuhi lengkap.

#### C. Gerbang Keselamatan Wajib (*Mandatory Safety Gates*)
Penyerahan obat dilarang dieksekusi apabila salah satu dari prasyarat keselamatan berikut belum terpenuhi:
1. **Pemanggilan Loket Tercatat (*Pickup Call*):** Telah tercatat riwayat pemanggilan pasien/penerima ke loket penyerahan.
2. **Telaah Akhir Fisik Lolos (*Final Dispense Review Pass*):** Pemeriksaan akhir kesesuaian obat oleh Apoteker telah berstatus **Pass**.
3. **Edukasi Pasien Terkonfirmasi (*Patient Education Acknowledged*):** Informasi aturan pakai obat telah disampaikan oleh Apoteker dan tercatat konfirmasinya.
4. **Pelunasan Tagihan Terpenuhi (*Payment Clearance*):** Untuk pasien umum / mandiri, tagihan obat telah dikonfirmasi lunas oleh Kasir / Tata Rekening. Untuk pasien penjamin (seperti BPJS), syarat ini terpenuhi berdasarkan keabsahan penjaminan.
5. **Validitas Masa Tunggu Pengambilan (*Collection Window Validity*):** Penyerahan dilakukan dalam rentang masa tunggu pengambilan obat yang sah. Jika masa tunggu telah terlampaui, penyerahan normal diblokir dan hanya dapat dibuka melalui persetujuan *Collection Window Override* oleh Apoteker/Supervisor yang berwenang.

#### D. Bukti Penyerahan (*Evidence of Handover*)
1. **Bukti Prasyarat Kelaikan Serah:** Waktu pemanggilan loket, kelolosan Final Review beserta identitas Apoteker, konfirmasi PIO beserta identitas Apoteker, bukti pelunasan tagihan untuk pasien umum, dan catatan otorisasi override (aktor, waktu, alasan) bila masa tunggu terlampaui.
2. **Bukti Final Penyerahan Fisik:** Waktu pelaksanaan penyerahan fisik obat dan identitas aktor penyerah (*Handover Actor*), baik Apoteker maupun Staf Farmasi Terotorisasi.
3. **Bukan Bukti Penyerahan (*Non-Evidence*):** Status antrean selesai, pemanggilan loket, data kontak pengambil atau hubungan dengan pasien (informasi pendukung opsional), nomor KTP, surat kuasa, tanda tangan digital, verifikasi biometrik pengambil (verifikasi fisik di loket adalah tanggung jawab operasional petugas loket), catatan konseling panjang, serta respon pembaruan sistem persediaan dan klaim penjamin.

#### E. Prinsip Penyerahan Utuh (*Full Handover*)
1. **1 Dispensing = 1 Full Handover:** Sediaan obat dalam pekerjaan penyiapan diserahkan secara utuh.
2. **Tidak Ada Partial Handover:** Penyerahan sebagian tidak didukung pada Serah Obat. Penyesuaian kuantitas atau pemenuhan sebagian diselesaikan upstream pada Sales Order (**OC-11-03**) dan Dispensing (**OC-11-04**).

#### F. Penyelesaian dan Status Akhir
1. **Transisi ke Completed:** Eksekusi penyerahan fisik yang sah mentransisikan status pekerjaan Dispensing menjadi **Completed**.
2. **Status Terminal Definitif:** Status `Completed` merupakan kondisi terminal akhir.
3. **Penyerahan Sekali Selesai:** Satu pekerjaan Dispensing hanya menghasilkan satu kali penyerahan obat yang sah. Tindakan berulang atau pengiriman ulang tidak menghasilkan penyerahan kedua.

#### G. Imutabilitas Status Selesai
1. **Fakta Historis Permanen:** Peristiwa penyerahan fisik obat bersifat permanen dan tidak dapat dibatalkan melalui pembatalan biasa (*Undo / Cancel*).
2. **Pemisahan Jalur Koreksi:** Penyesuaian atau pengembalian obat pasca-serah diselesaikan melalui proses Retur Obat (**APT-RETUR**) atau pembalikan transaksi tersendiri, bukan dengan membatalkan fakta penyerahan.

#### H. Kemandirian terhadap Proses Lanjutan
1. **Pemicu Proses Lanjutan:** Keberhasilan penyerahan obat memicu pembaruan saldo persediaan fisik dan penagihan klaim penjamin.
2. **Bukan Prasyarat Status:** Keberhasilan penyerahan obat tidak bergantung pada respon sistem lanjutan. Jika terjadi gangguan pada proses pembaruan stok atau klaim, status penyerahan obat **tetap Completed** dan proses lanjutan diselesaikan secara mandiri.

#### I. Penanganan Kegagalan Telaah Akhir (*Review Failure*)
Jika Final Dispense Review oleh Apoteker menghasilkan status tidak lolos (*Fail*), hal tersebut bukan kegagalan serah obat (*Failed Handover*) karena penyerahan belum terjadi. Sediaan dilarang diserahkan dan dikembalikan ke penyiapan farmasi untuk diperbaiki/diracik ulang (*rework*) di Dispensing (**OC-11-04**).

#### J. Penanganan Batas Waktu Pengambilan Terlampaui (*Collection Window Expired / No-Show*)
1. **Kebijakan Batas Waktu (*Collection Window*):** Batas waktu pengambilan obat dihitung sejak sediaan berstatus siap serah (*Ready for Pickup*) berdasarkan kebijakan operasional apotek (kebijakan standar saat ini adalah 7 hari).
2. **Pemblokiran dan Override:** Melewati batas waktu memblokir penyerahan normal. Penyerahan hanya dapat diproses bila terdapat persetujuan *Collection Window Override* dari Apoteker/Supervisor berwenang beserta alasan.
3. **Penyelesaian No-Show:** Jika pasien tidak hadir mengambil obat dan tidak ada persetujuan override, proses ditutup sebagai batas waktu terlampaui (*Pickup Expired*). Kondisi ini bukan kegagalan serah obat (*Not a Failed Handover*). Fisik sediaan obat diselesaikan melalui disposisi fisik/retur sediaan di Dispensing (**OC-11-04**).

#### K. Dukungan Dua Pola Operasional Pelayanan
1. **Model Terpadu (Apoteker Tunggal):** Apoteker menjalankan seluruh tahapan: `Final Review (Pass) → Edukasi PIO → Penyerahan Fisik → Pencatatan Penyerahan di Sistem`.
2. **Model Kolaboratif (Apoteker & Staf):** Apoteker menjalankan aspek klinis (`Final Review (Pass) → Edukasi PIO`), kemudian Staf Farmasi Terotorisasi menjalankan tindakan loket (`Pemanggilan Pasien → Penyerahan Fisik → Pencatatan Penyerahan di Sistem`).
3. Kedua pola menghasilkan fakta bisnis dan status akhir yang identik: obat diserahkan dan Dispensing berstatus **Completed**.

---

### 5.2 Required Recorded Information

Pencatatan persisten Serah Obat mencakup informasi bisnis berikut:
1. **Identitas & Referensi Pelayanan:** Nomor referensi penyerahan obat, referensi pekerjaan penyiapan (*Dispensing*), serta referensi pesanan (*Sales Order*) dan resep dokter asal.
2. **Subjek Pelayanan:** Identitas pasien (Nomor Rekam Medis dan nama lengkap) serta unit layanan loket farmasi penyerahan (`ORG-LAYANAN`).
3. **Rincian Sediaan:** Daftar seluruh sediaan obat dan kuantitas fisik yang diserahkan (selaras 100% dengan sediaan siap serah pada pekerjaan Dispensing).
4. **Bukti Pemanggilan Loket:** Waktu pemanggilan pasien ke loket dan identitas petugas yang memanggil.
5. **Bukti Kelolosan Gerbang Klinis:**
   - Bukti kelolosan telaah akhir fisik (*Final Dispense Review Pass*), identitas dan SIP Apoteker penanggung jawab, serta waktu verifikasi.
   - Bukti konfirmasi Pelayanan Informasi Obat (PIO), identitas Apoteker pemberi edukasi, serta waktu konfirmasi.
6. **Bukti Gerbang Finansial:** Bukti konfirmasi pelunasan tagihan (*Payment Clearance*) untuk pasien jalur umum/mandiri.
7. **Bukti Otorisasi Batas Waktu (bila berlaku):** Identitas Apoteker/Supervisor yang menyetujui override, waktu persetujuan, dan alasan pembukaan blokir pengambilan.
8. **Bukti Eksekusi Penyerahan Fisik:** Waktu pelaksanaan penyerahan fisik dan identitas aktor penyerah obat (*Handover Actor*), baik Apoteker maupun Staf Farmasi Terotorisasi.
9. **Informasi Pendukung Pengambil di Loket (Opsional):** Nama pengambil (bila diwakilkan keluarga/wali), hubungan dengan pasien, dan nomor kontak pengambil.

---

### 5.3 Required Business Conditions

Outcome Serah Obat hanya terbentuk apabila seluruh kondisi bisnis berikut terpenuhi:
1. **Kesiapan Sediaan:** Sediaan obat dalam pekerjaan Dispensing berstatus **Ready for Pickup** dan berada dalam pengawasan fisik farmasi.
2. **Pemanggilan Loket:** Pemanggilan pasien/penerima ke loket penyerahan telah tercatat.
3. **Kelolosan Klinis:** Final Dispense Review berstatus **Pass** oleh Apoteker yang berwenang.
4. **Edukasi Pasien:** Pelayanan Informasi Obat (PIO) telah diberikan oleh Apoteker dan tercatat konfirmasinya.
5. **Pelunasan Tagihan:** Kewajiban pembayaran telah terkonfirmasi lunas bagi pasien umum / mandiri, atau pertanggungan terverifikasi sah bagi pasien penjamin (BPJS).
6. **Validitas Batas Waktu:** Penyerahan dilakukan sebelum batas waktu pengambilan berakhir, atau telah disetujui melalui *Collection Window Override* sah oleh Apoteker/Supervisor.
7. **Kelayakan Aktor Penyerah:** Aktor pelaksana penyerahan teridentifikasi sah sebagai Apoteker atau Staf Farmasi Terotorisasi di unit farmasi bersangkutan.
8. **Keutuhan Penyerahan:** Penyerahan dilakukan secara penuh atas seluruh sediaan yang siap serah.

---

### 5.4 Completion Proof

Outcome Serah Obat dinyatakan selesai secara akuntabel apabila:
1. Rekam penyerahan obat tersimpan secara persisten dengan nomor referensi yang sah.
2. Status pekerjaan penyiapan (*Dispensing*) bertransisi menjadi **Completed**.
3. Tercatat bukti lengkap kelolosan seluruh gerbang keselamatan (*Pickup Call*, *Final Review Pass*, konfirmasi PIO, *Payment Clearance*, serta persetujuan *Override* bila masa tunggu lewat).
4. Waktu penyerahan fisik dan identitas aktor penyerah (*Handover Actor*) tercatat secara sah dan permanen.
5. Pekerjaan Dispensing terkunci dari eksekusi penyerahan ulang.
6. Peristiwa penyerahan obat diterbitkan untuk pembaruan persediaan dan penagihan klaim penjamin secara mandiri.

---

## 6. Outcome Boundary

### Start
Dimulai ketika sediaan obat dalam pekerjaan penyiapan telah berstatus **Ready for Pickup** (menerima serah terima sediaan dari **OC-11-04 Dispensing**), serta proses verifikasi gerbang keselamatan dan pemanggilan pasien ke loket penyerahan farmasi diinisiasi.

### End
Berakhir ketika penyerahan fisik obat kepada pasien atau penerima yang berhak telah dilaksanakan di loket, seluruh gerbang keselamatan terverifikasi lengkap, rekam penyerahan tersimpan persisten, dan status pekerjaan penyiapan (*Dispensing*) bertransisi menjadi **Completed**.

*Kondisi Terminasi Alternatif (Bukan Penyerahan Berhasil):*
Apabila pasien tidak hadir mengambil obat (*No-Show*) hingga batas waktu pengambilan berakhir tanpa persetujuan override yang sah, proses penyerahan ditutup sebagai batas waktu terlampaui (*Collection Window Expired*). Fisik sediaan obat diselesaikan melalui disposisi fisik/retur sediaan di Dispensing (**OC-11-04**).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Full Handover (Tanpa Parsial):** Satu pekerjaan Dispensing hanya diserahkan secara utuh (*1 Dispensing = 1 Full Handover*). Penyerahan sebagian dilarang pada level Serah Obat.
2. **Pemisahan Otoritas:** Wewenang profesional klinis untuk memvalidasi dan meloloskan safety gates (Final Review, PIO, Override) adalah hak eksklusif Apoteker dan dilarang dialihkan ke staf non-apoteker.
3. **Precedence Gerbang Keselamatan:** Penyerahan obat dilarang dieksekusi sebelum seluruh safety gates wajib (Pickup Call, Final Review Pass, konfirmasi PIO, Payment Clearance untuk pasien umum, dan Override bila batas waktu lewat) terpenuhi.
4. **Kelayakan Aktor Penyerah:** Tindakan operasional penyerahan fisik di loket diakui sah jika dilakukan oleh Apoteker ATAU Staf Farmasi Terotorisasi / Tenaga Vokasi Farmasi yang berwenang.
5. **Bukan Bukti Serah Obat:** Pemanggilan loket (*Pickup Call*) dan status antrean selesai bukan bukti bahwa obat telah diterima oleh pasien.
6. **Non-Mandatory Identity Artifact:** Identitas pendukung (nomor KTP, surat kuasa fisik, tanda tangan digital, biometrik, telepon) bukan prasyarat wajib sistem untuk menyelesaikan penyerahan obat.
7. **Penyerahan Sekali Selesai:** Satu pekerjaan Dispensing hanya menghasilkan satu penyerahan sah. Eksekusi ulang atau tindakan ganda tidak menghasilkan penyerahan kedua.
8. **Imutabilitas Status Selesai:** Status **Completed** bersifat permanen dan tidak dapat dibatalkan melalui pembatalan biasa (*Undo / Cancel*). Koreksi pasca-serah diselesaikan melalui alur Retur Obat (**APT-RETUR**) atau pembalikan transaksi terpisah.
9. **Kemandirian dari Proses Lanjutan:** Keberhasilan penyerahan obat tidak bergantung pada respon pembaruan persediaan fisik maupun penagihan klaim penjamin.
10. **Batas Waktu Pengambilan (Collection Window):** Penyerahan obat yang melewati batas waktu pengambilan diblokir, kecuali terdapat persetujuan resmi *Collection Window Override* dari Apoteker/Supervisor yang memuat aktor, waktu, dan alasan.
11. **Kegagalan Telaah Akhir Bukan Gagal Serah:** Kegagalan Final Dispense Review menghentikan alur penyerahan dan mengembalikan sediaan ke alur penyiapan Dispensing untuk perbaikan/rework, bukan dianggap kegagalan serah obat (*Failed Handover*).
12. **Ketidakhadiran Pasien Bukan Gagal Serah:** Ketidakhadiran pasien mengambil obat hingga batas waktu berakhir (*No-Show*) ditutup sebagai batas waktu terlampaui (*Pickup Expired*) untuk penyelesaian disposisi fisik di Dispensing, bukan kegagalan serah obat.
13. **Fleksibilitas Alur Operasional:** Serah Obat mendukung Model Terpadu (Apoteker tunggal) dan Model Kolaboratif (Apoteker bersama Staf) dengan kontrak hasil bisnis dan status akhir yang identik.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Kegagalan Telaah Akhir Fisik (*Final Dispense Review Fail*)** | Sediaan tidak memenuhi standar kelaikan fisik atau etiket oleh Apoteker → Penyerahan diblokir, sediaan obat dikembalikan ke penyiapan farmasi untuk diperbaiki/diracik ulang di Dispensing (**OC-11-04**). Bukan kegagalan serah obat. |
| **Edukasi Pasien Belum Diberikan (*PIO Unacknowledged*)** | Informasi obat belum disampaikan oleh Apoteker → Penyerahan di loket diblokir. Pasien diarahkan menerima penjelasan obat dari Apoteker terlebih dahulu. |
| **Tagihan Belum Lunas pada Pasien Umum (*Unpaid Bill*)** | Konfirmasi pelunasan belum terbit dari Kasir / Tata Rekening → Penyerahan diblokir. Pasien diarahkan menyelesaikan pembayaran di kasir terlebih dahulu. |
| **Batas Waktu Pengambilan Terlampaui (*Collection Window Expired*)** | Pasien hadir setelah batas waktu pengambilan lewat → Penyerahan normal diblokir. Penyerahan hanya dapat dibuka jika Apoteker atau Supervisor berwenang menyetujui *Collection Window Override* beserta alasan resmi. |
| **Pasien Tidak Hadir Mengambil Obat (*No-Show / Uncollected*)** | Pasien tidak hadir mengambil obat hingga batas waktu terlampaui tanpa permohonan override → Penyerahan ditutup sebagai *Pickup Expired*. Sediaan obat diproses melalui disposisi fisik sediaan / retur persediaan di Dispensing (**OC-11-04**). |
| **Pasien Tidak Muncul Saat Dipanggil di Loket (*Pickup Call No-Show*)** | Pasien tidak merespons panggilan di loket → Obat tetap disimpan di loket dalam pengawasan farmasi. Penyerahan tidak dieksekusi dan masa tunggu pengambilan tetap berjalan. |
| **Percobaan Eksekusi Penyerahan Berulang (*Duplicate Handover Attempt*)** | Terjadi tindakan eksekusi berulang atau ganda pada pekerjaan Dispensing yang telah Completed → Sistem menolak eksekusi kedua dan mempertahankan catatan penyerahan sah yang telah ada tanpa perubahan. |
| **Eksekusi Penyerahan oleh Staf Tanpa Kelolosan Safety Gate Klinis** | Staf mencoba mengeksekusi penyerahan sebelum Apoteker meloloskan Final Review atau PIO → Sistem menolak penyerahan dan menampilkan informasi gerbang klinis yang belum dipenuhi oleh Apoteker. |
| **Gangguan pada Proses Lanjutan Persediaan atau Klaim Penjamin** | Pembaruan persediaan atau penagihan klaim mengalami gangguan teknis saat penyerahan dilakukan → Status penyerahan obat **tetap Completed**. Proses pembaruan lanjutan dilanjutkan secara mandiri tanpa membatalkan penyerahan obat. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Rekam penyerahan obat terbentuk lengkap dengan bukti pemanggilan loket, kelolosan telaah akhir fisik, konfirmasi PIO, dan status lunas untuk pasien umum. | Completeness |
| **AC-02** | Verifikasi bahwa sistem menolak eksekusi penyerahan jika Final Dispense Review oleh Apoteker belum dilakukan atau berstatus selain Pass. | Constraint |
| **AC-03** | Verifikasi bahwa sistem menolak eksekusi penyerahan jika konfirmasi Pelayanan Informasi Obat (PIO) oleh Apoteker belum tercatat. | Constraint |
| **AC-04** | Verifikasi bahwa sistem menolak eksekusi penyerahan untuk pasien jalur umum jika konfirmasi pelunasan tagihan belum terbit. | Constraint |
| **AC-05** | Verifikasi bahwa penyerahan obat yang melewati batas waktu pengambilan ditolak, kecuali disertai persetujuan override sah yang memuat identitas Apoteker/Supervisor, waktu, dan alasan. | Constraint |
| **AC-06** | Verifikasi bahwa penyerahan fisik obat di loket dapat dicatat dan diakui sah baik oleh Apoteker maupun Staf Farmasi Terotorisasi. | Correctness |
| **AC-07** | Keberhasilan penyerahan fisik obat mencatat waktu penyerahan definitif, identitas aktor penyerah, dan mentransisikan status Dispensing menjadi Completed. | Completeness |
| **AC-08** | Verifikasi bahwa sistem menolak penyerahan sebagian (*Partial Handover*) dan memastikan 100% sediaan siap serah pada pekerjaan Dispensing diserahkan secara utuh. | Constraint |
| **AC-09** | Verifikasi bahwa tindakan penyerahan berulang atau ganda atas pekerjaan Dispensing yang telah Completed ditolak dan tidak menghasilkan catatan penyerahan kedua. | Constraint |
| **AC-10** | Verifikasi bahwa pekerjaan Dispensing yang telah berstatus Completed terkunci dari pembatalan biasa (*Undo / Cancel*), dan koreksi hanya dapat dilakukan via alur retur/pembalikan terpisah. | Constraint |
| **AC-11** | Verifikasi bahwa status Completed penyerahan obat tetap sah dan tidak dibatalkan saat terjadi kendala pada pembaruan persediaan atau penagihan klaim lanjutan. | Correctness |
| **AC-12** | Verifikasi bahwa penyerahan obat dapat diselesaikan tanpa mewajibkan verifikasi KTP, surat kuasa, tanda tangan digital, atau biometrik penerima. | Correctness |
| **AC-13** | Verifikasi bahwa pemanggilan pasien (*Pickup Call*) atau status antrean selesai tidak memicu penyelesaian penyerahan obat tanpa eksekusi fisik riil. | Correctness |
| **AC-14** | Verifikasi bahwa alur pelayanan Model Terpadu (Apoteker tunggal) dan Model Kolaboratif (Apoteker bersama Staf) menghasilkan bukti penyerahan dan status akhir Completed yang setara. | Correctness |
| **AC-15** | Verifikasi bahwa sediaan yang gagal pada telaah akhir fisik dialihkan kembali ke penyiapan Dispensing untuk perbaikan dan tidak dicatat sebagai kegagalan serah obat (*Failed Handover*). | Exception |
| **AC-16** | Verifikasi bahwa sediaan yang tidak diambil pasien hingga batas waktu berakhir ditutup sebagai Pickup Expired untuk retur fisik di Dispensing, bukan kegagalan serah obat. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Pengkajian Klinis & Telaah Resep Dokter (OC-11-02):** Evaluasi administratif, farmasetis, dosis, kontraindikasi, interaksi obat, dan persetujuan substitusi resep → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Penjualan & Komersial (OC-11-03):** Pengelolaan pesanan penjualan, pemisahan jalur penjamin, plafon komitmen kuantitas `AcceptedQty`, penetapan harga, dan penerbitan faktur tagihan → **OC-11-03 Penjualan** (`APT-ORDER`, `APT-BILL`).
- **Penyiapan & Peracikan Fisik Obat (OC-11-04):** Pengambilan barang dari rak, peracikan, pengemasan, pembuatan etiket, alokasi stok, dan pengawasan fisik sediaan (*physical custody*) hingga siap serah → **OC-11-04 Dispensing** (`APT-DISPENSING`).
- **Pengelolaan Antrean Apotek (OC-11-01):** Penerbitan nomor antrean loket apotek, pemanggilan display suara antrian, dan pengelolaan alur antrean fisik loket → **OC-11-01 Antrian Apotek** (`APT-QUEUE`).
- **Penerimaan Uang Kasir & Transaksi Pembayaran:** Eksekusi pembayaran tunai/non-tunai di loket kasir, pembulatan uang, penerbitan kuitansi kasir, dan penutupan shift kasir → **OC-03-01 Kasir** (`TRK-KASIR`, `TRK-PAYMENT`).
- **Pengembalian Obat & Koreksi Pasca-Handover:** Penerimaan retur obat dari pasien, pengembalian sediaan ke persediaan, dan penerbitan nota kredit keuangan → **Apotek Domain** (`APT-RETUR`) dan **Tata Rekening** (`TRK-BILLING`).
- **Akuntansi Persediaan Pergudangan:** Penjurnalan kartu stok fisik gudang, mutasi buku, dan pelaksanaan stok opname berkala → **Inventory Domain** (`INV-STOK`, `INV-MUTASI`, `INV-OPNAME`).
- **Pengurusan Klaim Jaminan BPJS:** Pengesahan SEP, kaidah restriksi jaminan/Fornas, dan pengajuan berkas klaim e-Klaim ke BPJS Kesehatan → **BPJS Domain** (`BPJ-VCLAIM`, `BPJ-EKLAIM`).
- **Pemberian Obat Klinis (*Medication Administration*):** Tindakan medis pemberian sediaan obat kepada pasien di bangsal rawat inap atau ruang tindakan → **Domain Rawat Jalan / Rawat Inap / EMR**.
- **Desain Teknis & Implementasi:** Skema basis data, model entitas kode program, API endpoint, tata letak antarmuka pengguna (UI), dan prosedur teknis SOP internal rumah sakit.
