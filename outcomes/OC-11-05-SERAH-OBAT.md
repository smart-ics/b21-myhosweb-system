# OUTCOME: Serah Obat

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-05     |
| Version     | 2.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-08   |

---

## 1. Business Purpose

Serah Obat adalah outcome final pelayanan farmasi rawat jalan ketika sediaan obat yang telah selesai disiapkan melalui proses penyiapan (*Dispensing*), serta telah memenuhi seluruh gerbang keselamatan (*safety gates*) yang diwajibkan, benar-benar diserahkan secara fisik kepada pasien atau penerima yang berhak di loket farmasi.

Outcome ini menetapkan fakta penyerahan fisik obat secara utuh dan mengikat status akhir pekerjaan penyiapan menjadi **Completed**. Serah Obat bukan sekadar pemanggilan pasien ke loket atau penyelesaian antrean administratif.

---

## 2. Outcome Statement

Sediaan obat yang telah siap serah dan memenuhi seluruh safety gate **telah diserahkan secara fisik dan utuh (Full Handover) kepada pasien atau penerima yang berhak di loket farmasi, dan peristiwa penyerahan tersebut telah dicatat secara sah sehingga status pekerjaan Dispensing menjadi Completed**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Serah Obat: memverifikasi pemenuhan safety gates, mencatat penyerahan fisik obat, dan mentransisikan status penyiapan (*Dispensing*) menjadi `Completed`. |
| **Organisasi (`ORG`)** | Menyediakan konteks unit layanan farmasi dan peran petugas: membedakan wewenang profesional Apoteker dari wewenang operasional penyerahan di loket. |
| **Tata Rekening (`TRK`)** | Menyediakan kepastian pelunasan pembayaran obat untuk pasien umum / bayar mandiri. |
| **Pasien (`PAS`)** | Menyediakan identitas pasien penerima obat. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-SERAH` Serah Obat | Apotek | Known |
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

1. **Penyerahan Fisik Riil:** Obat benar-benar diserahkan secara fisik kepada pasien atau penerima yang berhak di loket apotek. Pemanggilan loket atau status antrean selesai bukan bukti penyerahan obat.
2. **Pemisahan Otoritas:**
   - **Apoteker:** Berwenang mutlak atas safety gates klinis (Final Dispense Review Pass, pemberian informasi obat / PIO, dan persetujuan override batas waktu pengambilan). Wewenang ini tidak dapat didelegasikan ke staf.
   - **Apoteker atau Staf Farmasi Terotorisasi:** Berwenang melaksanakan tindakan operasional penyerahan fisik di loket dan mencatat penyerahan di sistem setelah seluruh safety gates terpenuhi.
3. **Safety Gates Wajib:** Penyerahan tidak boleh dilakukan sebelum seluruh syarat berikut terpenuhi:
   - Pemanggilan loket telah tercatat;
   - Final Dispense Review oleh Apoteker berstatus Pass;
   - Edukasi / Pelayanan Informasi Obat (PIO) oleh Apoteker telah diberikan;
   - Pembayaran tagihan obat telah lunas untuk pasien umum;
   - Batas waktu pengambilan obat masih berlaku (atau disetujui override resmi jika kedaluwarsa).
4. **Full Handover (1 Dispensing = 1 Full Handover):** Sediaan obat diserahkan secara utuh. Penyerahan sebagian (*partial handover*) tidak didukung pada Serah Obat; pemenuhan sebagian diselesaikan di tahap pesanan atau penyiapan sebelumnya.
5. **Penyelesaian Sekali Sah & Imutabel:** Penyerahan yang berhasil mengikat pekerjaan Dispensing menjadi **Completed**. Status ini bersifat permanen dan tidak dapat dibatalkan (*tidak ada Undo/Cancel biasa*). Koreksi pasca-serah diselesaikan melalui alur Retur Obat.
6. **Kemandirian dari Proses Lanjutan:** Keberhasilan penyerahan obat tidak bergantung pada keberhasilan proses hilir (pembaruan stok atau penagihan klaim penjamin). Gangguan pada proses lanjutan tidak membatalkan status Completed.

---

### 5.2 Required Recorded Information

Pencatatan penyerahan obat mencakup:
- Referensi penyerahan, referensi pekerjaan penyiapan (*Dispensing*), dan identitas pasien;
- Rincian sediaan obat yang diserahkan;
- Bukti pemenuhan seluruh safety gates (pemanggilan loket, kelolosan telaah akhir, edukasi PIO, pelunasan tagihan pasien umum, dan override batas waktu jika ada);
- Waktu penyerahan fisik dan identitas petugas pelaksana penyerahan (Apoteker atau Staf Farmasi Terotorisasi).

---

### 5.3 Required Business Conditions

- Sediaan obat dalam Dispensing berstatus siap serah (*Ready for Pickup*);
- Seluruh safety gates wajib telah terpenuhi dan valid;
- Pelaksana penyerahan fisik di loket adalah pihak yang berwenang.

---

### 5.4 Completion Proof

- Penyerahan fisik obat tercatat secara sah dan permanen;
- Status pekerjaan penyiapan (*Dispensing*) bertransisi menjadi **Completed**;
- Pekerjaan Dispensing terkunci dari penyerahan ulang.

---

## 6. Outcome Boundary

### Start
Dimulai saat sediaan obat telah siap serah (*Ready for Pickup* dari Dispensing) dan proses verifikasi safety gates serta pemanggilan loket dimulai.

### End
Berakhir saat sediaan fisik obat telah diserahkan di loket, seluruh safety gates terverifikasi, dan status Dispensing tercatat sebagai **Completed**.

*Pengecualian Batas Waktu (No-Show):*
Jika pasien tidak hadir hingga batas waktu pengambilan berakhir tanpa persetujuan override, proses ditutup sebagai batas waktu terlampaui (*Pickup Expired*). Fisik sediaan obat diselesaikan melalui retur stok di Dispensing, bukan sebagai kegagalan serah obat.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **1 Dispensing = 1 Full Handover:** Penyerahan hanya dilakukan secara utuh. Penyerahan sebagian tidak diizinkan.
2. **Pemisahan Otoritas:** Safety gates klinis (Final Review, PIO, Override batas waktu) wajib divalidasi oleh Apoteker. Eksekusi penyerahan fisik di loket dapat dilakukan oleh Apoteker atau Staf Farmasi Terotorisasi.
3. **Prasyarat Safety Gates:** Penyerahan dilarang dieksekusi sebelum seluruh safety gates wajib terpenuhi lengkap.
4. **Penyerahan Sekali Selesai:** Satu pekerjaan Dispensing hanya dapat menghasilkan satu kali penyerahan obat yang sah.
5. **Imutabilitas Completed:** Status Completed bersifat permanen dan tidak dapat dibatalkan (tidak ada Undo/Cancel biasa). Koreksi setelah penyerahan dilakukan melalui alur Retur Obat.
6. **Kemandirian Proses Lanjutan:** Gangguan teknis pada pembaruan persediaan atau penagihan klaim lanjutan tidak membatalkan atau menunda status Completed.
7. **Batas Waktu Pengambilan:** Penyerahan diblokir jika melewati batas waktu pengambilan, kecuali terdapat persetujuan override resmi oleh Apoteker/Supervisor.
8. **Pemanggilan Bukan Bukti Serah:** Pemanggilan loket dan status antrean selesai bukan bukti penyerahan obat fisik.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Telaah Akhir Fisik Gagal** | Sediaan tidak memenuhi syarat oleh Apoteker → Penyerahan diblokir, sediaan dikembalikan ke penyiapan Dispensing untuk perbaikan/rework. Bukan kegagalan serah obat. |
| **PIO / Pembayaran Belum Terpenuhi** | Edukasi obat atau pelunasan kasir belum selesai → Penyerahan di loket ditahan hingga prasyarat diselesaikan. |
| **Batas Waktu Pengambilan Terlampaui** | Pasien hadir melewati batas waktu pengambilan → Penyerahan diblokir kecuali disetujui override resmi oleh Apoteker/Supervisor. |
| **Pasien Tidak Hadir Mengambil Obat (*No-Show*)** | Pasien tidak hadir hingga batas waktu berakhir → Ditutup sebagai *Pickup Expired*. Sediaan obat diproses melalui retur stok fisik di Dispensing, bukan kegagalan serah obat. |
| **Gangguan Proses Lanjutan** | Pembaruan persediaan atau penagihan klaim mengalami gangguan → Status penyerahan obat **tetap Completed**. Proses lanjutan diselesaikan secara mandiri. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Penyerahan obat hanya dapat diselesaikan jika sediaan siap serah dan seluruh safety gates wajib telah terpenuhi. | Completeness |
| **AC-02** | Sistem menolak penyerahan jika Final Dispense Review atau edukasi PIO belum diselesaikan oleh Apoteker. | Constraint |
| **AC-03** | Sistem menolak penyerahan untuk pasien umum jika kewajiban pembayaran belum lunas. | Constraint |
| **AC-04** | Penyerahan obat melewati batas waktu pengambilan ditolak, kecuali disertai persetujuan override resmi dari Apoteker/Supervisor. | Constraint |
| **AC-05** | Penyerahan fisik obat di loket dapat dicatat dan diakui sah baik oleh Apoteker maupun Staf Farmasi Terotorisasi. | Correctness |
| **AC-06** | Keberhasilan penyerahan fisik obat mencatat status Dispensing menjadi Completed secara permanen dan tidak dapat dibatalkan. | Completeness |
| **AC-07** | Pekerjaan Dispensing hanya dapat diserahkan secara penuh (1 Full Handover) dan tidak dapat diserahkan sebagian. | Constraint |
| **AC-08** | Gangguan pada proses persediaan fisik atau penagihan klaim lanjutan tidak membatalkan atau menunda status Completed. | Correctness |
| **AC-09** | Sediaan yang gagal telaah akhir atau tidak diambil pasien hingga batas waktu berakhir dialihkan ke alur Dispensing, bukan dicatat sebagai kegagalan serah obat. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Pengkajian klinis resep dokter → **OC-11-02 Telaah Resep**
- Komersial dan pemenuhan pesanan penjualan → **OC-11-03 Penjualan**
- Penyiapan fisik dan peracikan sediaan obat → **OC-11-04 Dispensing**
- Pengelolaan antrean loket farmasi → **OC-11-01 Antrian Apotek**
- Penerimaan uang pembayaran kasir → **Kasir / Tata Rekening**
- Pengembalian obat pasca-serah → **Retur Obat (APT-RETUR)**
- Proses teknis integrasi pembaruan stok dan penagihan klaim lanjutan
- Desain teknis basis data, model entitas kode, kontrak API, tata letak antarmuka pengguna (UI), dan SOP internal.
