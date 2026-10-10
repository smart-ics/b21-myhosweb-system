# OUTCOME: OrderDispensing

| Field       | Value        |
|-------------|--------------|
| Code        | OC-APT-ORDER-DISPENSING |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Rumah sakit harus mampu mengelola, mencatat, dan mengendalikan pemenuhan fisik obat pasien secara akuntabel sebagai *persisted business fact*. Keberadaan outcome **OrderDispensing** memastikan bahwa setiap permintaan obat yang telah disetujui dalam pesanan penjualan farmasi (*Sales Order*) diubah menjadi instruksi penyiapan fisik (*Dispensing Order*), dialokasikan stok obatnya, diproses peracikannya, diverifikasi kesesuaian akhirnya oleh Apoteker (*Final Dispense Review*), diberikan edukasi informasi obat kepada pasien (*Patient Education*), serta diserahkan secara sah kepada pasien atau penerima yang berhak (*Medication Handover*).

Pencatatan dispensing yang persisten dan terpisah dari siklus penagihan (*Sales Bill*) menjamin terpenuhinya prinsip **7 Benar** dalam pemberian obat (Benar Pasien, Benar Obat, Benar Dosis, Benar Rute, Benar Waktu, Benar Informasi, dan Benar Dokumentasi). Selain itu, outcome ini mengoordinasikan pergerakan fisik stok dengan Domain Inventory secara tertib: mencadangkan obat dari Depo Farmasi ke Unit Penyiapan Sementara (*Dispensing Temporary Unit* via Mutasi Stok) saat peracikan dimulai, serta memotong saldo inventori fisik secara permanen (*Remove Stock*) pada saat obat diserahkan kepada pasien.

---

## 2. Outcome Statement

Instruksi alokasi fisik penyiapan obat (`Dispensing`) **telah terbentuk dari pesanan penjualan yang sah (`SalesOrder`), diproses penyiapan dan peracikannya, diverifikasi kelayakan akhirnya melalui telaah dispensing Apoteker, serta dicatat penyerahannya kepada penerima yang sah beserta mutasi pemotongan stok inventori terkait**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Apotek** (Primary Owner) | Mengelola instruksi alokasi dispensing (`APT-DISPENSING`), mengoordinasikan tahapan penyiapan obat (*Preparing*, *Prepared*), mengeksekusi telaah akhir dispensing (*Final Dispense Review Record*), mencatat konfirmasi edukasi obat, menyelesaikan serah obat fisik (`APT-SERAH`), dan menangani kasus obat tidak diambil (*No-Show Resolution*). |
| **Inventory** | Bertindak sebagai otoritas saldo fisik obat (`INV-STOK`), menerima instruksi mutasi cadangan obat ke unit penyiapan sementara (`INV-MUTASI`), dan mencatat pengeluaran/pemotongan fisik stok saat obat diserahkan (`INV-PAKAI`). |
| **Organisasi** | Menyediakan profil Apoteker dan Tenaga Teknis Kefarmasian / Asisten Apoteker (`ORG-PPA`) yang bertugas menyiapkan, meracik, menelaah akhir, dan menyerahkan obat. |
| **Pasien** | Menyediakan identitas pasien dan penerima obat yang sah (`PAS-DATSOS`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `APT-ORDER` Sales Order | Apotek | Known |
| `APT-SERAH` Serah Obat | Apotek | Known |
| `INV-PAKAI` Pakai Barang | Inventory | Known |
| `INV-MUTASI` Mutasi | Inventory | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen instruksi alokasi dispensing (`Dispensing`) telah terbentuk dengan item-itemnya (*Dispensing Items*) mengacu langsung pada baris pesanan penjualan yang sah (*Sales Order Items*).
- Otorisasi penyiapan obat (*Dispense Authorized*) telah dievaluasi dan terpenuhi:
  - **Pasien Umum**: Bukti pelunasan tagihan (*Payment Clearance*) telah terkonfirmasi.
  - **Pasien BPJS**: Bukti keabsahan penjaminan (*Coverage Clearance*) dan Surat Eligibilitas Peserta (SEP) yang valid telah terkonfirmasi.
- Pencadangan fisik stok obat ke unit penyiapan sementara (*Dispensing Temporary Unit*) telah dieksekusi melalui transaksi Mutasi Stok ke Domain Inventory (`INV-MUTASI`) saat penyiapan dimulai (*Dispensing Started*).
- Penyiapan, pengambilan barang (*picking*), peracikan (*compounding*), pengemasan, dan pelabelan etiket obat telah selesai dilaksanakan dan berstatus siap periksa (`Prepared`).
- Apoteker telah melaksanakan telaah akhir dispensing (*Final Dispense Review*) di hadapan pasien/keluarga dan mencatat hasil evaluasi yang lulus (*Passed*).
- Konfirmasi pemberian edukasi informasi obat (*Patient Education Acknowledgement*) telah dicatat oleh Apoteker.
- Penyerahan fisik obat (*Medication Handover*) telah selesai dilaksanakan kepada penerima yang sah, memicu pemotongan saldo fisik obat dari unit penyiapan sementara di Domain Inventory (*Remove Stock* / `INV-PAKAI`).

### 5.2 Required Recorded Information

- Nomor unik dokumen Dispensing (`DispensingId`) dan tautan ke nomor Sales Order rujukan (`SalesOrderId`).
- Unit/depo farmasi penyiap obat dan lokasi penyiapan sementara (*Dispensing Temporary Unit*).
- Rincian item dispensing (*Dispensing Items*):
  - Referensi baris *Sales Order Item*.
  - Kode dan nama obat/BMHP.
  - Kuantitas yang disiapkan.
  - Nomor batch/lot dan tanggal kedaluwarsa (*Expiry Date / ED*).
  - Teks etiket aturan pakai: dosis, frekuensi, rute pemberian, waktu konsumsi (sebelum/sesudah makan), dan peringatan khusus (contoh: "kocok dahulu", "habiskan").
- Status siklus hidup dispensing: `Established`, `Awaiting Clearance`, `Released`, `Preparing`, `Prepared`, `Reviewed`, `Completed`, `Cancelled`, `Expired`, atau `Unfulfilled`.
- Rekaman riwayat telaah akhir dispensing (*Final Dispense Review Records*):
  - Timestamp pemeriksaan telaah akhir.
  - Identitas Apoteker penelaah akhir (`PPA Id`).
  - Hasil evaluasi: Lulus (*Passed*) atau Gagal (*Failed*).
  - Catatan dan alasan kegagalan jika tidak lulus (contoh: etiket tidak lengkap, jumlah tablet kurang, etiket tertukar).
- Rekaman bukti edukasi informasi obat (*Patient Education Acknowledgement*):
  - Timestamp edukasi dan identitas Apoteker yang memberikan konseling/informasi obat.
  - Catatan konseling khusus (opsional).
- Rekaman bukti serah obat (*Medication Handover Record*):
  - Waktu penyerahan obat fisik (`HandedOverAt`).
  - Identitas petugas farmasi yang menyerahkan obat.
  - Nama penerima obat, hubungan penerima dengan pasien (pasien sendiri / keluarga / perawat bangsal), dan nomor telepon kontak (opsional sebagai referensi).
- Referensi ID transaksi pemotongan stok pada Domain Inventory.

### 5.3 Required Business Conditions

- **Kemandirian dari Tagihan Komersial**: Siklus penyiapan fisik dispensing (*Dispensing*) berjalan independen dari siklus penerbitan tagihan (*Sales Bill / Invoice*). Satu pesanan penjualan farmasi (`SalesOrder`) dapat dipenuhi melalui satu atau beberapa pesanan dispensing (*multiple Dispensings per Sales Order*) untuk mendukung pemenuhan bertahap (*partial fulfillment*) atau dosis harian (*Unit Dose Dispensing / UDD*).
- **Prasyarat Otorisasi Peracikan**: Petugas farmasi dilarang memulai peracikan fisik obat sebelum status otorisasi penyiapan (*Dispense Authorized*) terpenuhi.
- **Gerbang Telaah Akhir & Edukasi**: Obat yang telah disiapkan (`Prepared`) **dilarang keras diserahkan kepada pasien tanpa melewati Final Dispense Review yang berstatus lulus (*Passed*) dan pencatatan konfirmasi edukasi obat**. Apabila telaah akhir gagal (*Failed*), dokumen dispensing dikembalikan ke status `Preparing` untuk dikoreksi secara fisik, dan riwayat kegagalan dicatat secara permanen (*append-only*).
- **Kebijakan Batas Waktu Pengambilan (Collection Window & No-Show)**:
  - Obat rawat jalan yang telah disiapkan (`Prepared`) memiliki jendela waktu pengambilan (*Collection Window*, standar default 7 hari kalender).
  - Jika jendela waktu terlampaui tanpa serah obat, status tampilan beralih ke kedaluwarsa penjemputan (*Pickup Expired*). Penyerahan obat setelah kedaluwarsa penjemputan memerlukan persetujuan khusus Apoteker (*Collection Window Override*).
  - Kasus obat yang tidak diambil secara permanen diselesaikan melalui resolusi *No-Show*, yang mengubah status dispensing menjadi `Expired`, mengembalikan stok fisik dari *Dispensing Temporary Unit* kembali ke Depo Farmasi via Mutasi Stok (`INV-MUTASI`), dan memicu penyelesaian administratif akun pesanan.
- **Batasan Stok & Inventori (`ADR-APT-002`)**:
  - Apotek tidak memelihara saldo buku inventori lokal; saldo stok fisik sepenuhnya diatur oleh Domain Inventory.
  - Pencadangan obat saat penyiapan diwujudkan sebagai Mutasi Stok ke *Dispensing Temporary Unit*.
  - Serah obat yang sukses memicu *Remove Stock* dari *Dispensing Temporary Unit*. Status `Prepared` adalah status internal dispensing farmasi, bukan status inventori.
- **Bukan Tindakan Pemberian Obat Klinis**: Penyerahan obat kepada pasien atau keluarga (*Medication Handover*) bukan merupakan tindakan pemberian obat ke dalam tubuh pasien (*Medication Administration*). Pemberian obat klinis di ruang perawatan rawat inap tetap menjadi otoritas rekam medis keperawatan/EMR.

### 5.4 Completion Proof

- Dokumen Dispensing mencapai status akhir `Completed`.
- Rekaman *Final Dispense Review Record* berstatus *Passed* dan *Patient Education Acknowledgement* tersimpan permanen.
- Bukti serah obat fisik (*Medication Handover Record*) tercatat lengkap dengan identitas penerima dan waktu serah.
- Transaksi pemotongan kuantitas stok fisik tercatat pada kartu mutasi Domain Inventory (`INV-PAKAI`).

---

## 6. Outcome Boundary

### Start

Dimulai ketika item-item pesanan penjualan farmasi (`SalesOrder`) dialokasikan ke dalam dokumen instruksi penyiapan fisik `Dispensing` dan status otorisasi penyiapan obat (*Dispense Authorized*) terpenuhi untuk diproses.

### End

Berakhir ketika:
1. Obat selesai disiapkan, lolos telaah akhir, diberikan edukasi, diserahkan kepada pasien/penerima sah, dan pemotongan stok inventori disahkan (`Completed`); **atau**
2. Penyiapan obat dibatalkan secara sah sebelum serah obat (`Cancelled`), dan obat yang sempat disiapkan dikembalikan ke stok inventori; **atau**
3. Batas waktu pengambilan obat terlampaui dan petugas farmasi mengeksekusi resolusi *No-Show*, mengubah status menjadi kedaluwarsa (`Expired`), serta mengembalikan obat ke rak stok aktif Depo Farmasi.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Total kuantitas obat pada seluruh pesanan dispensing yang merujuk pada satu baris `SalesOrder` tidak boleh melebihi kuantitas yang disetujui pada baris `SalesOrder` tersebut.
- Penyerahan obat fisik wajib menyertakan etiket aturan pakai resmi yang memuat nama pasien, nama obat, dosis, aturan pakai, tanggal penyiapan, dan tanggal kedaluwarsa obat.
- Verifikasi identitas penerima obat saat penyerahan di loket merupakan tanggung jawab operasional profesional Apoteker penyerah obat; sistem tidak memberlakukan validasi biometrik yang menghambat pelayanan darurat.
- Farmasi rawat jalan rumah sakit tidak mendukung sistem inden/tunggakan barang (*Backorder*). Kekurangan stok fisik harus diselesaikan melalui pesanan parsial dan penerbitan Salinan Resep (*Copy Resep*) untuk ditebus di apotek jejaring/luar.
- Catatan riwayat telaah akhir dispensing (*Final Dispense Review Record*) bersifat *append-only* (setiap percobaan telaah akhir yang gagal dan berhasil dicatat urutannya tanpa menghapus rekaman sebelumnya).

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|---|---|
| Terjadi kekosongan stok fisik obat saat proses peracikan dimulai (*Stock Shortage*) | Staf farmasi mencatat *Medication Shortage*. Kuantitas dispensing disesuaikan dengan stok riil yang ada. Sisa kuantitas yang tidak terpenuhi dialihkan ke status *Unfulfilled* dan diterbitkan Salinan Resep (*Copy Resep*). Konsekuensi tagihan disesuaikan ke Tata Rekening. |
| Telaah akhir dispensing gagal (*Final Dispense Review Failed*) | Apoteker mencatat alasan kegagalan pada review record. Dispensing dikembalikan ke status `Preparing`. Staf farmasi melakukan perbaikan fisik sediaan (misal: penyesuaian etiket atau penggantian tablet yang rusak) hingga siap diperiksa ulang. |
| Pasien rawat jalan tidak kunjung mengambil obat hingga melewati batas waktu (*Collection Window Expired*) | Status tampilan menjadi *Pickup Expired*. Staf farmasi menghubungi pasien. Jika pasien tetap tidak hadir, dieksekusi prosedur *No-Show Resolution*: stok fisik dikembalikan ke Depo Farmasi via Mutasi Stok, dispensing ditandai *Expired*, dan konsekuensi komersial diselesaikan ke Tata Rekening. |
| Pasien datang mengambil obat saat status telah *Pickup Expired* namun obat fisik belum dibongkar | Apoteker yang berwenang memeriksa kelayakan fisik dan stabilitas obat, mencatat persetujuan penyerahan lewat batas (*Collection Window Override*) dengan alasan yang sah, lalu memproses serah obat secara normal. |
| Pasien membatalkan pengambilan obat racikan yang telah selesai dibuat | Obat racikan yang tidak dapat dikembalikan ke stok aktif diproses pemusnahan sediaannya sesuai SOP farmasi, dispensing ditandai *Cancelled*, dan konsekuensi kerugian biaya dibukukan secara akuntabel. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Dokumen Dispensing berhasil dibentuk dengan nomor unik dan setiap itemnya menunjuk ke baris `SalesOrder` yang sah. | Completeness |
| AC-02 | Penyiapan fisik obat hanya dapat dimulai setelah evaluasi otorisasi penyiapan obat (*Dispense Authorized*) terpenuhi. | Constraint |
| AC-03 | Saat penyiapan dimulai (*Dispensing Started*), sistem secara otomatis mencatat transaksi pencadangan stok ke *Dispensing Temporary Unit* di Domain Inventory (`INV-MUTASI`). | Correctness |
| AC-04 | Setiap item dispensing mencatat nomor batch/lot, tanggal kedaluwarsa, dan aturan etiket pakai yang lengkap. | Correctness |
| AC-05 | Sistem mewajibkan pencatatan *Final Dispense Review Record* yang berstatus lulus (*Passed*) oleh Apoteker sebelum serah obat dapat disahkan. | Constraint |
| AC-06 | Jika telaah akhir gagal (*Failed*), sistem mengembalikan dispensing ke status `Preparing` dan melarang proses serah obat. | Exception |
| AC-07 | Konfirmasi edukasi informasi obat (*Patient Education Acknowledgement*) tercatat dengan timestamp dan identitas Apoteker sebelum serah obat. | Completeness |
| AC-08 | Saat serah obat disahkan (*Medication Handover*), sistem mencatat identitas penerima dan memicu transaksi pemotongan fisik stok (*Remove Stock* / `INV-PAKAI`) di Inventory. | Correctness |
| AC-09 | Satu `SalesOrder` dapat dipenuhi melalui beberapa dokumen `Dispensing` (pemenuhan parsial atau UDD) tanpa melanggar batas kuantitas pesanan. | Completeness |
| AC-10 | Eksekusi resolusi *No-Show* berhasil mengubah status dispensing menjadi *Expired* dan mengembalikan stok fisik ke Depo Farmasi melalui Mutasi Stok. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Tindakan pemberian obat klinis ke tubuh pasien oleh perawat di ruang rawat inap (*Medication Administration*) → **EMR / Keperawatan Rawat Inap Domain**.
- Penerbitan tagihan komersial dan penagihan biaya obat → **`OC-APT-PENJUALAN` (Penjualan)**.
- Penerimaan pembayaran kasir atas obat → **`OC-TRK-KASIR` (Kasir)**.
- Penelaahan resep dokter pada tahap awal → **`OC-APT-TELAAH-RESEP` (TelaahResep)**.
- Pengelolaan nomor antrean loket farmasi → **`OC-APT-ANTRIAN-APOTEK` (AntrianApotek)**.
- Pengadaan logistik obat dan penerimaan faktur supplier → **Purchasing Domain (`PUR`)**.
- Perhitungan stok opname berkala gudang farmasi → **Inventory Domain (`INV-OPNAME`)**.
