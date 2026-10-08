# OUTCOME: Serah Obat

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-05     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Serah Obat adalah outcome final pelayanan farmasi rawat jalan ketika sediaan obat yang telah selesai disiapkan melalui proses penyiapan (*Dispensing*), serta telah memenuhi seluruh gerbang keselamatan (*safety gates*) klinis dan administratif yang diwajibkan, benar-benar diserahkan secara fisik kepada pasien atau penerima yang berhak di loket penyerahan farmasi.

Tujuan bisnis Serah Obat adalah:
1. **Menegakkan Pemisahan Otoritas Profesional dan Eksekusi Operasional (*Authority Decoupling*):** Memisahkan secara tegas hak profesional klinis Apoteker (*professional authority*) dalam memvalidasi dan meloloskan gerbang keselamatan klinis (Final Dispense Review, Pelayanan Informasi Obat / PIO, serta persetujuan masa tunggu pengambilan / Collection Window Override) dari hak operasional pelaksanaan penyerahan (*operational authority*) di loket (pemanggilan pasien, penyerahan fisik obat, dan eksekusi pencatatan serah di sistem) yang dapat dilaksanakan oleh Apoteker maupun Staf Farmasi Terotorisasi (*Authorized Pharmacy Staff* / Tenaga Vokasi Farmasi).
2. **Menjamin Pemenuhan Seluruh Safety Gates Sebelum Penyerahan Fisik (*Mandatory Safety Gates Enforcement*):** Menjamin bahwa tidak ada obat yang dapat diserahkan kepada pasien sebelum seluruh prasyarat keselamatan terpenuhi secara lengkap (pemanggilan loket tercatat, telaah akhir fisik berstatus Pass oleh Apoteker, pemberian informasi obat dikonfirmasi oleh Apoteker, pelunasan pembayaran terverifikasi untuk pasien umum, serta otorisasi override sah apabila batas waktu pengambilan terlampaui).
3. **Menetapkan Fakta Bisnis Penyerahan Fisik yang Definitif dan Imutabel (*Definitive & Immutable Physical Handover*):** Menegaskan bahwa Serah Obat bukan sekadar perubahan status administratif antrean menjadi 'Done' atau sekadar pemanggilan pasien ke loket, melainkan pencatatan persisten atas peristiwa fisik penyerahan obat yang telah dieksekusi secara sah, serta mengikat status akhir pekerjaan penyiapan (*Dispensing Job*) menjadi **Completed** dengan semantik transaksi sekali selesai (*strict one-time business semantics*).
4. **Menjamin Keutuhan Penyerahan (*Full Handover Accountability*):** Menerapkan aturan penyerahan utuh (*1 Dispensing = 1 Full Handover*) tanpa adanya konsep penyerahan sebagian (*Partial Handover*) pada level Serah Obat, di mana pemenuhan sebagian (*partial fulfillment*) diselesaikan secara tuntas pada level pesanan (*Sales Order*) dan penyiapan (*Dispensing*) sebelum masuk ke proses serah obat.
5. **Mengisolasi Fakta Penyerahan dari Ketergantungan Sistem Hilir (*Downstream Decoupling*):** Memastikan keberhasilan penyerahan fisik obat sebagai fakta bisnis yang berdiri sendiri dan sah, yang memicu konsekuensi lanjutan (pemotongan persediaan fisik dan pembentukan faktur klaim BPJS) secara asinkron tanpa menjadikan kendala teknis sistem hilir sebagai pembatal fakta penyerahan obat.

Serah Obat secara tegas **BUKAN**:
- **Penyelesaian Antrean Administratif:** Status antrean atau pelacak perjalanan pasien (*Patient Journey Tracker*) yang berstatus 'Done' bukan bukti bahwa obat telah diserahkan.
- **Pemanggilan Pasien (*Pickup Call*):** Pemanggilan pasien ke loket penyerahan hanya membuktikan panggilan telah dilakukan, bukan bukti bahwa obat telah diterima oleh pasien.
- **Telaah Resep Dokter:** Pengkajian administratif, farmasetis, dan klinis atas resep dokter adalah wewenang penuh **OC-11-02 (Telaah Resep)**.
- **Komersial & Penjualan:** Penetapan komitmen kuantitas pesanan, pemisahan jalur penjamin, penetapan harga, dan penerbitan faktur tagihan adalah wewenang penuh **OC-11-03 (Penjualan)**.
- **Penyiapan & Pengawasan Fisik (*Dispensing*):** Pengambilan obat, peracikan, pengemasan, pelabelan etiket, dan penjagaan fisik sediaan (*physical custody*) adalah wewenang penuh **OC-11-04 (Dispensing)**.
- **Administrasi Klinis Pemberian Obat (*Medication Administration*):** Tindakan medis meminumkan atau menyuntikkan obat ke tubuh pasien adalah wewenang klinis ruang perawatan / rawat inap / EMR.
- **Prosedur Pengembalian Obat (*Return / Reversal*):** Penanganan obat yang dikembalikan setelah penyerahan selesai adalah wewenang proses retur tersendiri (**APT-RETUR**).

---

## 2. Outcome Statement

Sediaan obat yang telah selesai disiapkan dan berada dalam status siap serah (*Ready for Pickup*) **telah diverifikasi kelolosan seluruh safety gates klinis dan administratifnya oleh pihak yang berwenang, telah diserahkan secara fisik secara utuh (Full Handover) kepada pasien atau penerima yang berhak di loket farmasi, dan peristiwa penyerahan tersebut telah dicatat secara persisten dan imutabel sehingga status Dispensing bertransisi secara definitif menjadi Completed**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Serah Obat (`APT-SERAH`): mengelola siklus penyerahan obat, memverifikasi kelolosan gerbang keselamatan klinis (Final Dispense Review Pass, Patient Education acknowledgement, Collection Window status), mencatat eksekusi penyerahan fisik operasional, dan mentransisikan Dispensing Job dari `Ready for Pickup` menjadi status akhir `Completed`. |
| **Organisasi (`ORG`)** | Menyediakan konteks unit layanan farmasi (`ORG-LAYANAN`) dan otorisasi Petugas Pemberi Asuhan (`ORG-PPA`), yang membedakan otoritas profesional klinis Apoteker (untuk Final Review, KIE/PIO, dan Override) dari otoritas operasional loket penyerahan (Apoteker atau Authorized Pharmacy Staff / Tenaga Vokasi Farmasi). |
| **Tata Rekening (`TRK`)** | Kolaborator finansial: menyediakan status kepastian pelunasan pembayaran tagihan obat (*Payment Clearance* via `TRK-PAYMENT` / `TRK-BILLING`) untuk memvalidasi kelayakan penyerahan obat bagi pasien jalur umum / bayar mandiri (*General / Self-Pay*). |
| **Pasien (`PAS`)** | Subjek pelayanan: menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) sebagai penerima manfaat terapi obat. |
| **Inventory (`INV`)** | Kolaborator persediaan hilir: mengonsumsi fakta penyerahan obat yang berhasil untuk melaksanakan finalisasi pemotongan saldo persediaan fisik (`INV-STOK`) sebagai konsekuensi lanjutan asinkron (*downstream consequence*). |
| **BPJS (`BPJ`)** | Kolaborator jaminan hilir: mengonsumsi fakta penyerahan obat yang berhasil untuk pembentukan penagihan faktur klaim BPJS (`BPJ-VCLAIM`) sebagai konsekuensi lanjutan asinkron (*downstream consequence*). |
| **Admission (`ADM`)** | Kolaborator pelacakan perjalanan pasien: mengonsumsi peristiwa penyerahan obat untuk memutakhirkan milestone perjalanan pasien (*Patient Journey Tracker* via `ADM-TRACKER`) di instalasi farmasi. |

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

> **Batasan Kepemilikan Upstream & Downstream:**
> - Kapabilitas `APT-DISPENSING` menyediakan sediaan berstatus *Ready for Pickup* sebagai titik awal Serah Obat dan menerima pembaruan status akhir menjadi *Completed*.
> - Kapabilitas `INV-STOK` dan `BPJ-VCLAIM` murni berperan sebagai penerima notifikasi/event hilir pasca-serah (*downstream consequences*) tanpa memengaruhi keabsahan status penyerahan.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

#### A. Hakikat Serah Obat dan Pembedaan Fakta Bisnis
1. **Hakikat Serah Obat:** Serah Obat adalah peristiwa fisik perpindahan penguasaan sediaan obat dari instalasi farmasi kepada pasien atau penerima yang berhak di loket penyerahan setelah seluruh gerbang keselamatan (*safety gates*) terpenuhi.
2. **Bukan Sekadar Perubahan Status Administratif:** Keberhasilan Serah Obat dilarang disamakan dengan atau disimpulkan dari:
   - Status antrean loket farmasi berubah menjadi `Done`.
   - Pasien telah dipanggil ke loket penyerahan (*Pickup Call*).
   - Status pelacak perjalanan pasien (*Patient Journey Tracker*) berstatus selesai.
3. **Penyelesaian Fisik Riil:** Outcome Serah Obat baru dianggap tercapai apabila penyerahan fisik sediaan benar-benar telah dieksekusi dan dicatat secara persisten ke dalam sistem oleh aktor penyerah yang berwenang.

#### B. Pemisahan Otoritas Profesional dan Eksekusi Operasional
Sistem memisahkan secara tegas dua lapis kewenangan:
1. **Otoritas Profesional Klinis (*Professional Authority* — Apoteker):**
   - Apoteker memiliki hak dan kewenangan eksklusif atas gerbang keselamatan (*safety gates*) klinis.
   - Tindakan yang wajib dilakukan sendiri oleh Apoteker dan tidak dapat didelegasikan atau digantikan oleh staf apotek:
     - Melakukan pemeriksaan kesesuaian fisik akhir sediaan (*Final Dispense Review*) dengan hasil **Pass**.
     - Memberikan edukasi dan Pelayanan Informasi Obat (PIO/KIE) kepada pasien/penerima dan mengonfirmasi pencatatannya (*acknowledgement*).
     - Menyetujui dan mencatat pembukaan blokir pengambilan jika masa tunggu pengambilan terlampaui (*Collection Window Override*).
2. **Otoritas Eksekusi Operasional (*Operational Authority* — Staf Farmasi Terotorisasi atau Apoteker):**
   - Tindakan operasional penyerahan di loket farmasi mencakup:
     - Memanggil pasien ke loket penyerahan (*Pickup Call*).
     - Menyerahkan paket sediaan obat secara fisik kepada penerima di loket.
     - Mengeksekusi perintah pencatatan penyerahan (*Handover Command*) di dalam sistem.
   - Tindakan operasional ini dapat dilakukan oleh **Authorized Pharmacy Staff / Tenaga Vokasi Farmasi**, atau dapat dilakukan langsung oleh **Apoteker**.
   - Staf farmasi hanya diizinkan mengeksekusi penyerahan di sistem setelah seluruh gerbang keselamatan klinis yang menjadi wewenang Apoteker telah terpenuhi dan berstatus valid.

#### C. Gerbang Keselamatan Wajib (*Mandatory Safety Gates*)
Handover obat dilarang dieksekusi di sistem apabila salah satu dari lima prasyarat keselamatan berikut belum terpenuhi:
1. **Gate 1 — Pemanggilan Loket Tercatat (*Pickup Call Recorded*):** Terdapat rekam waktu pemanggilan pasien/penerima ke loket penyerahan.
2. **Gate 2 — Telaah Akhir Fisik Lolos (*Final Dispense Review Passed*):** Evaluasi kesesuaian fisik dan penandaan obat telah dilakukan oleh Apoteker dengan hasil definitif **Pass**.
3. **Gate 3 — Edukasi Pasien Terkonfirmasi (*Patient Education Acknowledged*):** Informasi cara pakai dan aturan obat telah disampaikan oleh Apoteker dan tercatat sebagai konfirmasi (*acknowledgement*).
4. **Gate 4 — Pelunasan Tagihan Terpenuhi (*Payment Clearance*):** Untuk pasien jalur umum / bayar mandiri (*General / Self-Pay*), kewajiban pembayaran tagihan obat telah dikonfirmasi lunas dari Kasir / Tata Rekening. Untuk pasien jalur penjamin (seperti BPJS), gerbang ini terpenuhi berdasarkan keabsahan penjaminan.
5. **Gate 5 — Validitas Masa Tunggu Pengambilan (*Collection Window Validity*):** Penyerahan dilakukan dalam rentang masa tunggu pengambilan obat yang sah. Jika masa tunggu telah terlampaui (*Collection Window Expired*), penyerahan normal diblokir dan hanya dapat dibuka apabila terdapat persetujuan *Collection Window Override* yang sah dari Apoteker/Supervisor yang berwenang.

#### D. Bukti Penyerahan (*Evidence of Handover*)
Sistem membedakan secara tegas antara bukti prasyarat dan bukti akhir penyerahan:
1. **Prerequisite Evidence (Bukti Kelaikan Penyerahan):**
   - Waktu pemanggilan ke loket (*Pickup Call timestamp*).
   - Hasil Final Review Pass beserta identitas dan nomor SIP Apoteker penanggung jawab.
   - Bukti konfirmasi Pelayanan Informasi Obat (PIO acknowledgement) beserta identitas Apoteker pemberi informasi.
   - Bukti verifikasi pelunasan (*Payment Clearance*) untuk pasien umum.
   - Catatan otorisasi *Collection Window Override* (mencakup identitas Apoteker/Supervisor, waktu persetujuan, dan alasan override) apabila masa tunggu terlampaui.
2. **Final Handover Evidence (Bukti Eksekusi Penyerahan Fisik):**
   - Waktu definitif pelaksanaan penyerahan fisik obat (*Handover execution timestamp*).
   - Identitas aktor penyerah obat (*Handover Actor*), yang dapat berupa Apoteker atau Authorized Pharmacy Staff / Tenaga Vokasi Farmasi.
3. **Hal yang Ditegaskan BUKAN Merupakan Bukti Penyerahan (*Non-Evidence*):**
   - Status antrean loket atau status pelacak perjalanan pasien berstatus `Done`.
   - Pasien telah dipanggil ke loket (*Pickup Call*).
   - Data kontak pengambil (`RecipientPhone`) atau hubungan pengambil dengan pasien (`RecipientRelationship`). Data ini bersifat informasi pendukung sukarela (*optional supporting information*), bukan mandatory gate.
   - Nomor KTP, surat kuasa fisik, tanda tangan digital (*digital signature*), atau verifikasi biometrik pengambil. Verifikasi kecocokan orang yang datang di loket merupakan tanggung jawab operasional petugas loket, bukan prasyarat wajib sistem (*mandatory system gate*).
   - Keberhasilan integrasi pemotongan persediaan fisik (*stock integration*).
   - Keberhasilan integrasi pembentukan faktur klaim BPJS (*BPJS invoice integration*).
   - Catatan naratif konseling mendalam (cukup pencatatan konfirmasi pemberian informasi / PIO acknowledgement).

#### E. Prinsip Penyerahan Utuh (*Full Handover — No Partial Handover*)
1. **Prinsip 1 Dispensing = 1 Full Handover:** OC-11-05 hanya mengenal penyerahan utuh atas sediaan yang disiapkan.
2. **Tidak Ada Partial Handover:** Sistem menolak status penyerahan sebagian (*Partially Handed Over*).
3. **Resolusi Parsial di Ranah Upstream:** Apabila terjadi pemenuhan sebagian (*partial fulfillment*) karena keterbatasan fisik atau keputusan klinis, pemisahan tersebut telah diselesaikan pada level Sales Order (**OC-11-03**) dan Dispensing (**OC-11-04**). Sediaan yang masuk ke OC-11-05 adalah sediaan utuh dari *Dispensing Job* yang memang siap diserahkan sepenuhnya.

#### F. Penyelesaian dan Status Akhir (*Completion & Strict One-Time Semantics*)
1. **Transisi ke Status Completed:** Eksekusi penyerahan fisik yang berhasil mentransisikan status *Dispensing Job* menjadi **Completed**.
2. **Status Terminal Definitif:** Status `Completed` merupakan kondisi terminal akhir.
3. **Invarian Eksekusi Sekali Sah (*Strict One-Time Business Semantics*):** Satu *Dispensing Job* hanya boleh menghasilkan tepat satu penyerahan sukses (`1 Dispensing = 1 Successful Handover`). Eksekusi berulang, klik ganda, pengiriman ulang (*retry*), maupun pengiriman data simultan (*concurrent request*) dilarang menghasilkan penyerahan kedua.

#### G. Imutabilitas Status Selesai (*Completed Cannot Be Undone*)
1. **Fakta Historis Permanen:** Peristiwa penyerahan fisik obat kepada pasien adalah fakta historis yang permanen dan imutabel.
2. **Dilarang Batalkan Biasa (*No Ordinary Cancel/Undo*):** Setelah Dispensing berstatus `Completed`, tidak ada mekanisme *Undo* atau pembatalan transaksi serah obat biasa.
3. **Pemisahan Jalur Koreksi Pasca-Serah:** Setiap koreksi atau penyesuaian yang timbul setelah obat berada di tangan pasien (misalnya pengembalian obat, alergi mendadak, atau kesalahan terapi lanjutan) wajib diselesaikan melalui mekanisme Pengembalian/Retur Obat (**APT-RETUR**) atau pembalikan transaksi resmi (*Reversal*), bukan dengan membatalkan pencatatan serah obat.

#### H. Kemandirian terhadap Konsekuensi Hilir (*Downstream Integration Decoupling*)
1. **Pemicu Konsekuensi Hilir:** Penyerahan obat yang sukses memicu konsekuensi operasional lanjutan:
   - Finalisasi pemotongan saldo stok fisik di modul persediaan (*Inventory Domain*).
   - Pembentukan faktur klaim tagihan BPJS untuk pasien jalur BPJS (*BPJS Domain*).
2. **Bukan Prasyarat Keberhasilan Serah:** Konsekuensi hilir tersebut bukan bukti penyerahan obat dan keberhasilannya tidak memengaruhi keabsahan Serah Obat.
3. **Tetap Berstatus Completed:** Jika terjadi kegagalan jaringan atau kendala teknis pada integrasi stok atau integrasi klaim BPJS, status penyerahan obat **TETAP Completed**.
4. **Integrasi Asinkron Berketahanan:** Proses integrasi hilir dieksekusi sebagai tugas asinkron dengan mekanisme percobaan ulang berketahanan (*resilient retry*) tanpa membatalkan fakta bisnis bahwa obat telah diserahkan.

#### I. Penanganan Kegagalan Telaah Akhir (*Review Failure*)
1. **Bukan Gagal Serah (*Not a Failed Handover*):** Jika Final Dispense Review oleh Apoteker menghasilkan status tidak lolos (*Fail*), hal tersebut bukan merupakan kegagalan serah obat (*Failed Handover*), karena penyerahan fisik belum terjadi.
2. **Tindakan Perbaikan:** Sediaan dilarang diserahkan ke loket, penyerahan tidak dapat berstatus `Completed`, dan sediaan obat dikembalikan ke unit kerja penyiapan farmasi untuk diperbaiki/diracik ulang (*rework*) sesuai alur Dispensing (**OC-11-04**).

#### J. Penanganan Masa Tunggu Kedaluwarsa (*Collection Window Expired / No-Show*)
1. **Konsep Masa Tunggu (*Collection Window*):** Masa tunggu adalah batas waktu pengambilan obat sejak sediaan berstatus *Ready for Pickup*, yang ditentukan oleh kebijakan operasional farmasi (kebijakan default saat ini adalah 7 hari kalender).
2. **Pemblokiran Penyerahan Normal:** Jika masa tunggu telah terlampaui:
   - Penyerahan normal otomatis diblokir oleh sistem.
   - Penyerahan hanya dapat dilakukan apabila terdapat otorisasi pembukaan blokir (*Collection Window Override*) oleh Apoteker atau Supervisor yang berwenang, lengkap dengan identitas aktor, waktu, dan alasan persetujuan.
3. **Penyelesaian No-Show:** Apabila pasien tidak hadir mengambil obat dan tidak ada persetujuan override hingga batas akhir kebijakan penyimpanan:
   - Proses penyerahan ditutup sebagai batas waktu terlampaui (*Pickup / Collection Expired*).
   - Kondisi ini bukan kegagalan serah obat (*Not a Failed Handover*), karena penyerahan memang belum pernah terjadi.
   - Penanganan fisik sediaan obat diselesaikan melalui prosedur pengembalian stok / pemusnahan sediaan di Dispensing (**OC-11-04**).
   - Istilah *Pickup Expired* mencerminkan terlampauinya batas waktu pengambilan oleh pasien, bukan kedaluwarsa masa simpan farmasi sediaan obat.

#### K. Dukungan Dua Model Operasional Pelayanan
Outcome Serah Obat secara utuh mendukung dua pola operasional di instalasi farmasi:
1. **Model Terpadu (*Integrated / Single Pharmacist Model*):**
   Apoteker tunggal menjalankan seluruh tahapan pelayanan:
   `Final Review (Pass) → Patient Education (PIO) → Penyerahan Fisik Obat → Eksekusi Handover di Sistem`.
2. **Model Kolaboratif (*Collaborative Model*):**
   Apoteker menjalankan pengawasan klinis:
   `Final Review (Pass) → Patient Education (PIO)`,
   kemudian Authorized Pharmacy Staff / Tenaga Vokasi Farmasi menjalankan tindakan operasional di loket:
   `Pickup Call → Penyerahan Fisik Obat → Eksekusi Handover di Sistem`.
3. **Hasil Bisnis Identik:** Kedua model operasional menghasilkan fakta bisnis dan status akhir yang persis sama, yaitu sediaan obat telah diserahkan dan *Dispensing Job* berstatus **Completed**.

---

### 5.2 Required Recorded Information

Pencatatan persisten Serah Obat wajib memuat informasi berikut:
1. **Identitas Unik Penyerahan:**
   - Nomor unik rekam penyerahan obat (*Handover Record ID*).
   - Referensi unik pekerjaan penyiapan (*Dispensing Job ID*) yang diserahkan.
   - Referensi pesanan penjualan (*Sales Order ID*) dan resep dokter asal.
2. **Identitas Pasien & Subjek Pelayanan:**
   - Nomor Rekam Medis (Nomor RM) dan nama lengkap pasien.
   - Konteks unit pelayanan farmasi / loket penyerahan tempat serah terima dilakukan (`ORG-LAYANAN`).
3. **Rincian Sediaan Obat:**
   - Daftar seluruh item sediaan obat beserta kuantitas fisik yang diserahkan (wajib mencakup 100% item pada Dispensing Job).
4. **Rekam Jejak Pemanggilan Loket (*Pickup Call Evidence*):**
   - Waktu pelaksanaan pemanggilan pasien ke loket (*Pickup Call Timestamp*).
   - Identitas petugas yang memanggil pasien.
5. **Rekam Jejak Gerbang Keselamatan Klinis (*Clinical Safety Gates Evidence*):**
   - Bukti kelolosan telaah akhir fisik (*Final Dispense Review Pass*), mencakup identitas dan SIP Apoteker penanggung jawab telaah serta waktu verifikasi.
   - Bukti konfirmasi Pelayanan Informasi Obat (*Patient Education / PIO Acknowledgement*), mencakup identitas Apoteker yang memberikan edukasi serta waktu pencatatan konfirmasi.
6. **Rekam Jejak Gerbang Finansial (*Financial Safety Gate Evidence*):**
   - Bukti konfirmasi pelunasan tagihan (*Payment Clearance Confirmation*) untuk pasien jalur umum/mandiri.
7. **Rekam Jejak Otorisasi Masa Tunggu (*Collection Window Override Evidence*, jika berlaku):**
   - Identitas Apoteker atau Supervisor yang menyetujui override.
   - Waktu persetujuan override.
   - Alasan bisnis/klinis persetujuan override.
8. **Rekam Jejak Eksekusi Penyerahan (*Handover Execution Evidence*):**
   - Waktu definitif pelaksanaan penyerahan fisik obat (*Handover Execution Timestamp*).
   - Identitas sah aktor pelaksana penyerahan (*Handover Actor*), baik Apoteker maupun Authorized Pharmacy Staff / Tenaga Vokasi Farmasi.
9. **Informasi Pendukung Penerima Fisik (*Optional Supporting Information*):**
   - Nama orang yang menerima obat di loket (jika diambil oleh keluarga/kuasa).
   - Hubungan penerima dengan pasien (`RecipientRelationship`).
   - Nomor kontak penerima (`RecipientPhone`).
   *(Catatan: Informasi pendukung ini bersifat opsional dan ketiadaannya tidak menggagalkan penyerahan obat).*

---

### 5.3 Required Business Conditions

Outcome Serah Obat hanya dapat terbentuk apabila seluruh kondisi bisnis berikut terpenuhi secara kumulatif:
1. **Kondisi Kesiapan Dispensing:** Sediaan obat dalam *Dispensing Job* berstatus **Ready for Pickup** dan berada dalam pengawasan fisik (*physical custody*) farmasi yang sah.
2. **Kondisi Pemanggilan Pasien:** Pemanggilan pasien/penerima ke loket penyerahan (*Pickup Call*) telah tercatat secara resmi dalam sistem.
3. **Kondisi Kelolosan Telaah Akhir:** Final Dispense Review telah diselesaikan oleh Apoteker yang sah dan menghasilkan status **Pass**.
4. **Kondisi Edukasi Pasien:** Informasi penggunaan obat (PIO) telah diberikan oleh Apoteker dan tercatat sebagai konfirmasi (*acknowledged*).
5. **Kondisi Pelunasan Tagihan:** Untuk pasien jalur bayar mandiri (*General / Self-Pay*), status *Payment Clearance* telah terkonfirmasi lunas oleh sistem Kasir / Tata Rekening. Untuk pasien jalur penjamin (BPJS), pertanggungan telah diverifikasi sah.
6. **Kondisi Masa Tunggu:** Penyerahan dilakukan sebelum masa tunggu pengambilan kedaluwarsa, ATAU telah tercatat persetujuan *Collection Window Override* yang sah dari Apoteker/Supervisor berwenang.
7. **Kondisi Otorisasi Pelaksana:** Aktor penyerah obat (*Handover Actor*) teridentifikasi secara sah sebagai Apoteker atau Authorized Pharmacy Staff / Tenaga Vokasi Farmasi yang memiliki penugasan aktif di unit farmasi bersangkutan.
8. **Kondisi Keutuhan Sediaan:** Penyerahan dilakukan secara penuh (100% item sediaan fisik yang siap serah).

---

### 5.4 Completion Proof

Outcome Serah Obat dinyatakan selesai secara akuntabel apabila:
1. Rekam penyerahan obat (*Handover Record*) telah terbentuk dan tersimpan secara persisten dengan identifier unik.
2. Status pekerjaan penyiapan (*Dispensing Job*) bertransisi secara definitif menjadi **Completed**.
3. Rekam audit memuat bukti lengkap kelolosan seluruh gerbang keselamatan (*Pickup Call*, *Final Dispense Review Pass*, *PIO Acknowledgement*, *Payment Clearance*, serta *Override* bila masa tunggu terlampaui).
4. Timestamp eksekusi penyerahan dan identitas aktor penyerah obat (*Handover Actor*) tercatat secara sah dan tidak dapat diubah (*immutable*).
5. Dispensing Job terkunci secara permanen sehingga upaya penyerahan kedua ditolak secara mutlak (*strictly idempotent*).
6. Peristiwa keberhasilan penyerahan diterbitkan secara asinkron ke modul Inventory dan BPJS tanpa menjadikan respons teknis modul hilir sebagai penentu kepastian status `Completed`.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika sediaan obat dalam pekerjaan penyiapan (*Dispensing Job*) telah berstatus **Ready for Pickup** (menerima handoff sediaan dari **OC-11-04 Dispensing**), dan proses verifikasi gerbang keselamatan (*safety gates*) serta pemanggilan pasien ke loket penyerahan farmasi diinisiasi.

### End
Outcome berakhir ketika penyerahan fisik obat kepada pasien atau penerima yang berhak telah dieksekusi secara sah di loket, seluruh gerbang keselamatan klinis dan administratif terverifikasi lengkap, rekam penyerahan tersimpan secara persisten, dan status pekerjaan penyiapan (*Dispensing Job*) bertransisi secara definitif menjadi **Completed**.

*Kondisi Terminasi Alternatif (Bukan Penyerahan Berhasil):*
Apabila pasien tidak hadir mengambil obat (*No-Show*) hingga masa tunggu pengambilan kedaluwarsa tanpa adanya persetujuan override yang sah, proses penyerahan ditutup dengan status batas waktu terlampaui (*Collection Window Expired*). Penanganan fisik sediaan obat dikembalikan ke tanggung jawab *physical custody* Dispensing (**OC-11-04**) untuk diproses disposisi fisik / retur stok.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Mandatory Full Handover Invariant:** Satu Dispensing Job hanya boleh diserahkan secara utuh (`1 Dispensing = 1 Full Handover`). Penyerahan sebagian (*partial handover*) dilarang keras pada level Serah Obat.
2. **Authority Decoupling Invariant:** Sistem wajib memisahkan hak profesional klinis Apoteker (*professional authority*) dari hak operasional pelaksanaan penyerahan (*operational authority*). Staf farmasi dilarang meloloskan safety gates klinis.
3. **Exclusive Pharmacist Safety Gate Invariant:** Final Dispense Review, Patient Education / PIO, dan Collection Window Override adalah wewenang eksklusif Apoteker dan dilarang didelegasikan kepada staf non-apoteker.
4. **Mandatory Safety Gates Precedence Invariant:** Handover dilarang dieksekusi jika salah satu dari safety gates (Pickup Call, Final Review Pass, PIO Acknowledgement, Payment Clearance untuk pasien umum, dan Override bila masa tunggu lewat) belum terpenuhi.
5. **Dual Eligible Handover Actor Invariant:** Aktor penyerah fisik (*Handover Actor*) diakui sah jika dilakukan oleh Apoteker ATAU Authorized Pharmacy Staff / Tenaga Vokasi Farmasi yang berwenang.
6. **Pickup Call Is Not Handover Evidence Invariant:** Pemanggilan pasien (*Pickup Call*) hanya membuktikan panggilan ke loket telah dilakukan, bukan bukti bahwa obat telah diserahkan atau diterima oleh pasien.
7. **Queue Done Is Not Handover Evidence Invariant:** Perubahan status antrean loket farmasi atau tracker perjalanan pasien menjadi `Done` bukan merupakan bukti sah penyerahan fisik obat.
8. **Non-Mandatory Identity Artifact Invariant:** Pengambilan nomor KTP, surat kuasa fisik, tanda tangan digital, maupun verifikasi biometrik penerima bukan merupakan prasyarat wajib sistem (*mandatory system gate*) untuk menyelesaikan Handover.
9. **Strict One-Time Business Semantics (Idempotency) Invariant:** Satu Dispensing Job hanya boleh memiliki tepat satu penyerahan sukses. Eksekusi ulang, klik ganda, retry, atau pengiriman simultan dilarang menghasilkan penyerahan kedua.
10. **Terminal State Immutability (No Ordinary Undo) Invariant:** Status **Completed** pada Dispensing Job bersifat permanen dan imutabel; dilarang dibatalkan melalui fitur pembatalan biasa (*Undo* / *Cancel*).
11. **Post-Handover Correction Separation Invariant:** Segala bentuk koreksi sediaan atau administrasi setelah status Completed wajib diselesaikan melalui proses Retur Obat (**APT-RETUR**) atau pembalikan transaksi resmi (*Reversal*), bukan membatalkan pencatatan penyerahan.
12. **Downstream Decoupling Invariant:** Kegagalan atau penundaan pada integrasi persediaan (*Inventory*) maupun integrasi tagihan (*BPJS*) dilarang membatalkan atau menunda status **Completed** penyerahan obat.
13. **Policy-Driven Collection Window Invariant:** Masa tunggu pengambilan obat ditentukan oleh konfigurasi kebijakan operasional farmasi (default 7 hari kalender), di mana pelampauan batas waktu memblokir penyerahan normal kecuali terdapat *Collection Window Override*.
14. **Documented Override Precedence Invariant:** Pembukaan blokir pengambilan obat yang kedaluwarsa waktu (*Collection Window Expired*) wajib memiliki pencatatan identitas Apoteker/Supervisor yang memberi otorisasi, waktu persetujuan, dan alasan override yang dapat dipertanggungjawabkan.
15. **Clinical Review Failure Abort Invariant:** Kegagalan pada Final Dispense Review menghentikan alur penyerahan dan mengembalikan sediaan ke alur penyiapan/perbaikan di Dispensing (**OC-11-04**), dan bukan merupakan status `Failed Handover`.
16. **No-Show Non-Handover Invariant:** Ketidakhadiran pasien mengambil obat hingga masa tunggu berakhir (*No-Show*) bukan merupakan kegagalan serah (*Failed Handover*), melainkan kondisi *Pickup Expired* yang diselesaikan melalui disposisi fisik sediaan di Dispensing.
17. **Patient Education Acknowledgement Sufficiency Invariant:** Syarat edukasi pasien dianggap terpenuhi melalui pencatatan konfirmasi (*acknowledgement*) bahwa informasi obat telah diberikan oleh Apoteker, tanpa mensyaratkan dokumentasi konseling naratif panjang.
18. **Operational Workflow Flexibility Invariant:** Serah Obat wajib mendukung Model Terpadu (Apoteker tunggal) dan Model Kolaboratif (Apoteker bersama Staf Farmasi) dengan hasil bisnis dan kontrak status akhir yang identik.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established or deviates from normal flow.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Kegagalan Telaah Akhir Fisik (*Final Dispense Review Fail*)** | Sediaan tidak memenuhi standar kelaikan fisik atau etiket oleh Apoteker → Penyerahan diblokir mutlak, obat dikembalikan ke proses perbaikan/rework di Dispensing (**OC-11-04**). Bukan merupakan *Failed Handover* karena penyerahan fisik belum terjadi. |
| **Edukasi Pasien Belum Diberikan (*PIO Unacknowledged*)** | Informasi obat belum disampaikan oleh Apoteker → Sistem memblokir eksekusi penyerahan di loket. Staf mengarahkan pasien untuk menerima penjelasan obat dari Apoteker terlebih dahulu. |
| **Tagihan Belum Lunas pada Pasien Umum (*Unpaid Bill*)** | Bukti *Payment Clearance* belum terbit dari Kasir / Tata Rekening → Eksekusi penyerahan diblokir. Petugas loket mengarahkan pasien/keluarga untuk menyelesaikan pembayaran di kasir terlebih dahulu. |
| **Masa Tunggu Pengambilan Kedaluwarsa (*Collection Window Expired*)** | Pasien hadir setelah batas waktu pengambilan terlampaui → Penyerahan normal diblokir. Eksekusi hanya dapat dibuka apabila Apoteker atau Supervisor yang berwenang memberikan persetujuan *Collection Window Override* beserta alasan resmi. |
| **Pasien Tidak Hadir Mengambil Obat (*No-Show / Uncollected*)** | Pasien tidak hadir mengambil obat hingga batas waktu terlampaui tanpa ada permohonan override → Penyerahan ditutup sebagai *Pickup Expired*. Sediaan obat diproses melalui disposisi fisik sediaan / retur stok di Dispensing (**OC-11-04**). |
| **Pasien Tidak Muncul Saat Dipanggil di Loket (*Pickup Call No-Show*)** | Pasien tidak merespons panggilan di loket → Obat tetap disimpan di loket penyerahan dalam *physical custody* farmasi. Penyerahan tidak dieksekusi. Masa tunggu pengambilan tetap berjalan normal. |
| **Percobaan Eksekusi Penyerahan Ganda (*Duplicate Handover Attempt*)** | Terjadi klik ganda, pengiriman paralel, atau percobaan eksekusi ulang pada Dispensing Job yang telah Completed → Sistem menolak eksekusi kedua dan mempertahankan catatan penyerahan asli yang telah ada tanpa perubahan (*Strict Business Idempotency*). |
| **Upaya Eksekusi Penyerahan oleh Staf Tanpa Kelolosan Safety Gate Klinis** | Staf mencoba mengeksekusi penyerahan sebelum Apoteker meloloskan Final Review atau PIO → Sistem menolak perintah penyerahan dan menampilkan status safety gate klinis yang belum dipenuhi oleh Apoteker. |
| **Kegagalan Integrasi Hilir Persediaan atau BPJS (*Downstream Integration Failure*)** | Layanan persediaan (Inventory) atau penagihan klaim BPJS mengalami gangguan teknis/jaringan saat penyerahan dieksekusi → Penyerahan **TETAP Completed**. Tugas integrasi hilir dicatat dalam antrean asinkron untuk dicoba ulang secara otomatis (*resilient retry*) tanpa membatalkan fakta penyerahan obat. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Penyerahan obat hanya dapat dieksekusi jika Dispensing Job berstatus **Ready for Pickup** dan seluruh safety gates wajib telah terpenuhi. | Completeness |
| **AC-02** | Sistem memblokir eksekusi penyerahan jika Final Dispense Review oleh Apoteker belum dilakukan atau berstatus selain **Pass**. | Constraint |
| **AC-03** | Sistem memblokir eksekusi penyerahan jika Patient Education / PIO oleh Apoteker belum tercatat sebagai *acknowledged*. | Constraint |
| **AC-04** | Sistem memblokir eksekusi penyerahan untuk pasien jalur umum (*GeneralPatientPay*) jika *Payment Clearance* belum berstatus lunas dari Kasir/Tata Rekening. | Constraint |
| **AC-05** | Penyerahan obat yang dieksekusi melewati batas *Collection Window* ditolak sistem, kecuali telah disertai *Collection Window Override* yang sah dari Apoteker/Supervisor. | Constraint |
| **AC-06** | Aktor penyerah obat (*Handover Actor*) dapat dicatat sebagai Apoteker maupun Authorized Pharmacy Staff yang sah. | Correctness |
| **AC-07** | Keberhasilan eksekusi penyerahan obat mencatat timestamp penyerahan definitif, identitas aktor penyerah, dan mentransisikan status Dispensing Job menjadi **Completed**. | Completeness |
| **AC-08** | Sistem menolak penyerahan sebagian (*Partial Handover*); 1 Dispensing Job hanya dapat diserahkan secara utuh (*Full Handover*). | Constraint |
| **AC-09** | Eksekusi berulang, klik ganda, atau pengiriman simultan atas Dispensing Job yang telah berstatus Completed tidak menghasilkan rekam penyerahan kedua (*Strict Business Idempotency*). | Constraint |
| **AC-10** | Dispensing Job yang telah berstatus **Completed** tidak dapat di-Undo atau di-Cancel melalui fitur pembatalan biasa. | Constraint |
| **AC-11** | Kegagalan koneksi atau pemrosesan pada integrasi persediaan (*Inventory*) maupun penagihan klaim (*BPJS*) pasca-handover tidak membatalkan atau mengubah status **Completed**. | Correctness |
| **AC-12** | Ketiadaan data KTP, surat kuasa fisik, tanda tangan digital, atau biometrik penerima tidak menghalangi keberhasilan penyelesaian penyerahan obat di sistem. | Constraint |
| **AC-13** | Pemanggilan antrean loket (*Pickup Call*) dicatat sebagai prasyarat pemanggilan dan tidak dianggap sebagai bukti penyelesaian serah obat. | Correctness |
| **AC-14** | Perubahan status antrean loket atau tracker perjalanan pasien menjadi `Done` tidak dapat dijadikan bukti pengganti penyerahan obat fisik. | Constraint |
| **AC-15** | Model Terpadu (Apoteker tunggal) dan Model Kolaboratif (Apoteker dan Staf) menghasilkan rekam penyerahan dan status akhir **Completed** yang identik. | Correctness |
| **AC-16** | Kegagalan pada Final Dispense Review mengembalikan sediaan ke penyiapan Dispensing dan tidak dicatat sebagai kegagalan serah obat (*Failed Handover*). | Exception |
| **AC-17** | Berakhirnya masa tunggu pengambilan tanpa kehadiran pasien (*No-Show*) ditutup sebagai *Pickup Expired* untuk disposisi fisik sediaan di Dispensing, bukan sebagai kegagalan serah obat. | Exception |

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
