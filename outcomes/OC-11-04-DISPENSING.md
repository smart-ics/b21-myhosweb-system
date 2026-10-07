# OUTCOME: Dispensing

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-04     |
| Version     | 1.4          |
| Status      | Approved     |
| LastUpdated | 2026-10-07   |

---

## 1. Business Purpose

Dispensing adalah outcome bisnis yang menetapkan akuntabilitas penyiapan fisik sediaan obat oleh instalasi farmasi / Apotek, pengawasan fisik sediaan (*physical custody*), serta verifikasi internal mutu dan ketepatan obat sebelum masuk ke proses penyerahan pasien.

Tujuan bisnis Dispensing adalah:
1. **Menjamin Akuntabilitas Penyiapan Fisik (*Physical Preparation Accountability*):** Merepresentasikan pekerjaan penyiapan fisik sediaan obat dalam unit kerja penyiapan (*Dispensing Job*) yang terlacak sejak diterima hingga tuntas.
2. **Menjamin Mutu melalui Verifikasi Internal (*Internal Quality Verification*):** Memastikan seluruh sediaan yang disiapkan lolos verifikasi kesesuaian internal oleh tenaga kefarmasian sebelum dinyatakan siap serah.
3. **Mengelola Pengawasan Fisik (*Physical Custody Management*):** Memastikan sediaan obat yang telah disiapkan berada dalam pengawasan fisik (*physical custody*) farmasi yang akuntabel selama masa tunggu pengambilan (*collection window*).
4. **Menyelesaikan Pengecualian Fisik & No-Show (*Physical Resolution*):** Menyelesaikan konsekuensi fisik secara akuntabel apabila sediaan gagal dipenuhi (*Unfulfilled*), dibatalkan (*Cancelled*), atau tidak diambil oleh pasien hingga batas waktu berakhir (*Resolved* via *valid physical disposition*).
5. **Menjaga Batasan Operasional (*Boundary Decoupling*):** Mengonsumsi instruksi pemenuhan dari **OC-11-03 (Penjualan)** tanpa mengelola aspek komersial/finansial, dan menyerahkan sediaan yang siap serah (*Ready for Pickup*) kepada **OC-11-05 (Serah Obat)** tanpa mengambil alih edukasi atau penyerahan fisik ke pasien.

---

## 2. Outcome Statement

Pekerjaan penyiapan fisik obat (*Dispensing Job*) yang bersumber dari instruksi pemenuhan yang sah **telah selesai disiapkan secara fisik dan diverifikasi internal oleh farmasi serta berada dalam physical custody yang akuntabel dan siap diserahkan (Ready for Pickup), atau telah diselesaikan secara akuntabel sebagai hasil pengecualian fisik definitif (Unfulfilled, Cancelled, atau Resolved akibat No-Show)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Dispensing (`APT-DISPENSING`): mengelola siklus penyiapan fisik, verifikasi internal, *physical custody*, penetapan *Ready for Pickup*, serta penyelesaian pengecualian fisik (*Unfulfilled*, *Cancelled*, *Resolved*). Mengonsumsi instruksi pemenuhan dari Sales Order milik OC-11-03 Penjualan. |
| **Inventory (`INV`)** | Kolaborator persediaan: menyediakan master identitas obat (`INV-MASTER`), mengonfirmasi alokasi fisik barang (`INV-STOK`), serta mencatat pemusnahan sediaan yang tidak layak pakai ulang (`INV-MUSNAH`). |
| **Organisasi (`ORG`)** | Menyediakan konteks unit layanan farmasi (`ORG-LAYANAN`) dan tenaga kefarmasian yang berwenang sebagai penyiap dan verifikator internal (`ORG-PPA`). |
| **Pasien (`PAS`)** | Menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) sebagai subjek pelayanan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `INV-STOK` Stok | Inventory | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Batasan Kepemilikan Upstream:** Kapabilitas `APT-ORDER` (Sales Order) dimiliki sepenuhnya oleh **OC-11-03 Penjualan**. Dispensing murni mengonsumsi instruksi pemenuhan yang diterbitkan oleh Sales Order sebagai masukan kerja fisik, tanpa mengelola siklus hidup Sales Order.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

1. **Hakikat Dispensing Job:** Satu *Dispensing Job* merepresentasikan satu batch pekerjaan penyiapan fisik sediaan obat. Satu Sales Order dapat menghasilkan satu atau beberapa *Dispensing Job* sesuai kebutuhan karakteristik sediaan atau beban operasional penyiapan.
2. **Keberhasilan Normal (Ready for Pickup):** Tercapai ketika sediaan selesai disiapkan secara fisik, lolos verifikasi mutu internal, berada dalam *physical custody* yang teridentifikasi, dan siap masuk ke proses serah obat (**OC-11-05**). *Ready for Pickup* adalah handoff boundary ke OC-11-05, bukan serah obat ke pasien.
3. **Invarian All-or-Nothing:** Tidak ada status `Partially Ready for Pickup`. *Dispensing Job* hanya boleh *Ready for Pickup* jika 100% item di dalamnya selesai dan terverifikasi internal.
4. **Siklus Hidup Penyiapan Fisik:** Mengikuti alur `Eligible` → `Queued` → `Preparing` → `Ready for Pickup`. Waktu tunggu / SLA penyiapan secara bisnis mulai dihitung sejak status *Queued*. Status *Preparing* mengikat akuntabilitas pekerjaan fisik aktif yang sedang berjalan.
5. **Integritas Pekerjaan & Granularitas Pembatalan:** Setelah *Preparing*, instruksi fisik dilarang diubah diam-diam (*no silent mutation*). Pembatalan berlaku proporsional: pembatalan pada sebagian item memisahkan item tersebut sebagai **Cancelled**, sedangkan sisa item valid tetap dilanjutkan hingga *Ready for Pickup*. Pembatalan seluruh job (**Cancelled**) hanya terjadi jika seluruh item ditarik atau instruksi batch berubah fundamental. Perubahan administratif non-fisik tidak membatalkan pekerjaan fisik.
6. **Pembedaan Cancelled vs Unfulfilled:**
   - **Cancelled:** Kebutuhan/instruksi ditarik atau tidak lagi berlaku (tidak ada kewajiban pemenuhan lanjutan).
   - **Unfulfilled:** Kebutuhan pasien tetap sah, namun farmasi gagal memenuhinya secara fisik (terminal exception di Dispensing; kebutuhan tetap sah untuk ditindaklanjuti pada konteks upstream).
7. **Pemenuhan Parsial (*Partial Fulfillment*):** Jika sebagian item gagal dipenuhi, item yang gagal dipisahkan sebagai **Unfulfilled**, sedangkan bagian item yang berhasil diselesaikan secara utuh hingga **Ready for Pickup** dengan silsilah batch yang terlacak.
8. **Masa Tunggu (*Collection Window*) & No-Show Physical Custody:** Masa tunggu dimulai sejak *Ready for Pickup* dengan durasi berbasis kebijakan operasional/konfigurasi (bukan hard-coded). Berakhirnya waktu tunggu mengubah status menjadi **Collection Expired** (kondisi temporal non-terminal; *physical custody* belum berakhir). Farmasi wajib menuntaskan custody melalui tindakan disposisi fisik yang sah (*valid physical disposition*) hingga mencapai status **Resolved** (seluruh sediaan berdisposisi sah dan *remaining custody* bernilai nol).
9. **Decoupling Downstream:** Status penyelesaian fisik (*Resolved* maupun *Unfulfilled*) diterbitkan ke konteks terkait dan tidak bergantung pada keberhasilan proses downstream (refund kasir, penyesuaian tagihan, atau klaim jaminan).
10. **Pembedaan Status Terminal:** Status akhir dibedakan secara tegas sesuai fakta bisnisnya: **Ready for Pickup**, **Unfulfilled**, **Cancelled**, dan **Resolved**. Dilarang menggunakan status universal tunggal seperti `Completed`.

---

### 5.2 Required Recorded Information

- Referensi identitas unik pekerjaan penyiapan dan referensi instruksi pemenuhan yang sah (Sales Order);
- Identitas pasien dan tenaga kefarmasian yang bertanggung jawab (penyiap fisik dan verifikator internal);
- Rincian sediaan, kuantitas instruksi, kuantitas disiapkan, serta kuantitas pengecualian (unfulfilled / cancelled jika ada);
- Bukti konfirmasi kelolosan verifikasi mutu internal dan status *physical custody* sediaan siap serah;
- Rekam waktu tahapan penyiapan fisik (waktu antrian/SLA, mulai penyiapan, siap serah, atau waktu penyelesaian pengecualian);
- Catatan tindakan disposisi fisik yang sah pada kondisi No-Show beserta konfirmasi nol sisa sediaan (*Zero Remaining Custody*).

---

### 5.3 Required Business Conditions

- **Kondisi Queued:** Instruksi pemenuhan sah dari Sales Order diterima dan memiliki minimal satu item fisik dengan kuantitas > 0.
- **Kondisi Preparing:** Pekerjaan fisik mulai dikerjakan oleh tenaga kefarmasian yang berwenang.
- **Kondisi Ready for Pickup:** 100% item dalam job selesai disiapkan fisik, lolos verifikasi internal, dan berada dalam *physical custody* yang teridentifikasi.
- **Kondisi Unfulfilled:** Terjadi kegagalan pemenuhan fisik atas kebutuhan yang masih valid; sediaan ditutup secara fisik dan diteruskan upstream.
- **Kondisi Cancelled:** Instruksi ditarik/dibatalkan; penutupan diterapkan secara proporsional sesuai tingkat unit pekerjaan fisik yang terdampak.
- **Kondisi Resolved:** Masa tunggu berakhir (*Collection Expired*), seluruh sediaan fisik memiliki disposisi fisik yang sah, dan *physical custody* bernilai nol.

---

### 5.4 Completion Proof

Outcome Dispensing dinyatakan selesai secara akuntabel apabila:
1. **Penyelesaian Normal:** Job berstatus **Ready for Pickup**, 100% item lolos verifikasi internal, dan berada dalam *physical custody* siap serah menuju OC-11-05.
2. **Penyelesaian Ketidakterpenuhan:** Job/item berstatus **Unfulfilled**, alasan kegagalan fisik tercatat, dan fakta diterbitkan ke Sales Order untuk resolusi lanjutan.
3. **Penyelesaian Pembatalan:** Job/item berstatus **Cancelled**, alasan pembatalan tercatat, sediaan fisik tertangani, dan item valid lainnya tetap terlindungi.
4. **Penyelesaian No-Show:** Job berstatus **Resolved**, seluruh sediaan memiliki pencatatan disposisi fisik yang sah, dan *Zero Remaining Custody* terkonfirmasi.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika instruksi pemenuhan yang sah dari Sales Order diterima dan masuk antrian operasional penyiapan farmasi (**Queued**), yang secara bersamaan menandai awal penghitungan waktu tunggu / SLA penyiapan obat.

### End
Outcome berakhir pada salah satu kondisi batas:
1. **Jalur Normal:** Seluruh sediaan obat selesai disiapkan fisik, terverifikasi internal, dan mencapai status **Ready for Pickup** (handoff boundary ke OC-11-05).
2. **Jalur Ketidakterpenuhan Fisik:** Seluruh sediaan (atau item terdampak) dipastikan gagal dipenuhi secara fisik dan berstatus **Unfulfilled**.
3. **Jalur Pembatalan:** Instruksi penyiapan ditarik dan berstatus **Cancelled** secara proporsional.
4. **Jalur No-Show:** Seluruh sediaan obat yang tidak diambil diselesaikan melalui disposisi fisik yang sah dan berstatus **Resolved**.

*Batasan Luar (Out of Scope):* Tidak mencakup pemanggilan loket dan penyerahan fisik ke pasien (OC-11-05), edukasi obat KIE (OC-11-05), transaksi kasir/refund (Kasir/Tata Rekening), maupun klaim jaminan/BPJS.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **Physical Batch Invariant:** Satu *Dispensing Job* merepresentasikan satu batch pekerjaan penyiapan fisik sediaan.
2. **All-or-Nothing Ready for Pickup Invariant:** Tidak ada kondisi `Partially Ready for Pickup`. *Dispensing Job* HANYA BOLEH mencapai *Ready for Pickup* jika 100% item di dalamnya selesai dan terverifikasi internal.
3. **No Silent Mutation Invariant:** Setelah berstatus *Preparing*, instruksi fisik dilarang diubah diam-diam. Perubahan instruksi fisik membatalkan pekerjaan terdampak dan menghasilkan instruksi/job baru.
4. **Proportional Cancellation Invariant:** Status pembatalan mengikuti unit pekerjaan fisik terdampak. Pembatalan level item dilarang membatalkan keseluruhan job jika masih terdapat item valid lain yang dapat dilayani.
5. **Distinct Meaning of Cancelled vs Unfulfilled Invariant:** *Cancelled* menyatakan penarikan instruksi (tidak ada kewajiban pemenuhan); *Unfulfilled* menyatakan kegagalan penyediaan fisik atas kebutuhan yang masih sah.
6. **Unfulfilled as Terminal Physical State Invariant:** Kegagalan penyediaan fisik berstatus akhir *Unfulfilled* di Dispensing dan memicu tindak lanjut pada konteks upstream.
7. **Policy-Driven Collection Window Invariant:** Durasi masa tunggu pengambilan ditentukan oleh kebijakan operasional/konfigurasi, bukan nilai yang di-*hardcode*.
8. **Continuous Custody Accountability Invariant:** *Collection Expired* adalah kondisi temporal non-terminal. Tanggung jawab *physical custody* farmasi berlanjut hingga seluruh sediaan memiliki disposisi fisik yang sah.
9. **Valid Physical Disposition for Resolved Invariant:** Status *Resolved* mensyaratkan setiap item memiliki pencatatan disposisi fisik yang sah dan *remaining custody* bernilai nol.
10. **No Automatic Restocking Assumption Invariant:** Dilarang mengasumsikan seluruh sediaan No-Show dapat otomatis dikembalikan ke persediaan aktif; sediaan yang tidak layak pakai ulang wajib diproses melalui pemusnahan/pembuangan (*discard*).
11. **Ready for Pickup Handoff Boundary Invariant:** *Ready for Pickup* adalah akhir tanggung jawab penyiapan fisik Dispensing dan handoff menuju OC-11-05; tidak mencakup penyerahan obat ke pasien atau edukasi KIE.
12. **Downstream Decoupling Invariant:** Keberhasilan penyelesaian fisik Dispensing (*Resolved* / *Unfulfilled*) tidak bergantung pada proses refund kasir, penyesuaian tagihan, atau klaim jaminan downstream.
13. **SLA Origin Invariant:** Penghitungan waktu tunggu / SLA penyiapan obat secara bisnis dimulai tepat saat pekerjaan berstatus *Queued*.
14. **Distinct Terminal States Invariant:** Dilarang menggunakan status universal tunggal seperti `Completed` untuk menggabungkan status *Ready for Pickup*, *Unfulfilled*, *Cancelled*, dan *Resolved*.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Pembatalan Instruksi Pemenuhan** | Instruksi ditarik (secara parsial pada tingkat item atau menyeluruh pada tingkat batch) → sediaan terdampak berstatus **Cancelled** secara akuntabel, dan sediaan fisik dibersihkan/dikelola. Item valid lainnya tetap dilanjutkan proses penyiapannya. |
| **Kegagalan Penyediaan Fisik** | Keterbatasan persediaan fisik atau kendala penyiapan atas kebutuhan yang masih valid → sediaan terdampak dipisahkan sebagai **Unfulfilled** dan diteruskan ke konteks upstream untuk resolusi lanjutan. Bagian sediaan yang berhasil disiapkan tetap dapat mencapai **Ready for Pickup**. |
| **Kegagalan Verifikasi Mutu Internal** | Sediaan tidak memenuhi standar mutu/ketepatan internal farmasi → status *Ready for Pickup* ditahan hingga sediaan diperbaiki dan lolos verifikasi, atau dialihkan ke status *Unfulfilled* jika tidak dapat diperbaiki. |
| **Masa Tunggu Pengambilan Kedaluwarsa (No-Show)** | Pasien tidak hadir mengambil obat hingga batas waktu berakhir → pekerjaan bertransisi ke **Collection Expired** (non-terminal). Farmasi wajib menuntaskan *physical custody* melalui tindakan disposisi fisik yang sah hingga seluruh sediaan tuntas dan job berstatus **Resolved**. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | *Dispensing Job* hanya dapat dibentuk dari instruksi pemenuhan yang sah dan memiliki minimal satu item fisik dengan kuantitas > 0. | Completeness |
| **AC-02** | Waktu tunggu / SLA penyiapan obat secara bisnis mulai dihitung sejak pekerjaan memasuki status **Queued**. | Correctness |
| **AC-03** | Status **Ready for Pickup** hanya dapat dicapai jika 100% item dalam *Dispensing Job* selesai disiapkan fisik dan lolos verifikasi internal kefarmasian. | Constraint |
| **AC-04** | Sistem menolak penetapan status `Partially Ready for Pickup`; jika terdapat item yang belum siap, job tidak dapat berstatus *Ready for Pickup*. | Constraint |
| **AC-05** | Perubahan instruksi fisik membatalkan pekerjaan terdampak menjadi **Cancelled** dan membentuk job baru, tanpa mutasi diam-diam pada pekerjaan lama. | Correctness |
| **AC-06** | Pembatalan tingkat item memisahkan item terdampak sebagai **Cancelled** tanpa membatalkan keseluruhan job, dan item valid lainnya tetap dapat mencapai **Ready for Pickup**. | Constraint |
| **AC-07** | Kegagalan pemenuhan fisik dicatat sebagai terminal outcome **Unfulfilled** (bukan *Cancelled*), dan fakta diterbitkan untuk resolusi lanjutan di konteks upstream. | Correctness |
| **AC-08** | Masa tunggu pengambilan dimulai tepat saat job mencapai status **Ready for Pickup**, dengan durasi mengacu pada konfigurasi kebijakan operasional. | Correctness |
| **AC-09** | Berakhirnya masa tunggu pengambilan mengubah status menjadi **Collection Expired** (non-terminal), dan tanggung jawab *physical custody* tetap berada pada farmasi. | Constraint |
| **AC-10** | *Dispensing Job* pada jalur No-Show hanya dapat bertransisi ke status **Resolved** apabila seluruh sediaan fisik telah memiliki disposisi fisik yang sah dan *Zero Remaining Custody* terpenuhi. | Completeness |
| **AC-11** | Status **Ready for Pickup** berfungsi sebagai handoff boundary menuju OC-11-05 dan tidak mencakup penyerahan obat ke pasien atau edukasi KIE. | Constraint |
| **AC-12** | Keberhasilan penetapan status **Resolved** pada Dispensing tidak bergantung pada status penyelesaian refund, billing, atau klaim BPJS di sistem downstream. | Constraint |
| **AC-13** | Status akhir penyiapan fisik dibedakan secara tegas antara **Ready for Pickup**, **Unfulfilled**, **Cancelled**, dan **Resolved**, tanpa menggunakan status universal `Completed`. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Penjualan & Komersial (OC-11-03):** Pengelolaan pesanan penjualan, pemisahan penjamin, penetapan harga, faktur tagihan, dan plafon komitmen `AcceptedQty`.
- **Serah Obat ke Pasien (OC-11-05):** Pemanggilan loket antrian, verifikasi identitas penerima akhir di loket, edukasi obat (KIE), dan serah-terima fisik sediaan ke pasien.
- **Pengkajian Klinis Resep (OC-11-02):** Telaah administratif, farmasetis, dan klinis atas resep dokter.
- **Transaksi Finansial & Kasir:** Penerimaan pembayaran kasir, penutupan shift kasir, pencatatan piutang, dan pengembalian uang (*refund*) fisik.
- **Klaim Asuransi / BPJS:** Verifikasi kepesertaan, penerbitan SEP, kaidah restriksi jaminan, dan pengajuan berkas klaim.
- **Akuntansi Persediaan Pergudangan:** Penjurnalan kartu stok, mutasi buku pergudangan, dan pelaksanaan stok opname berkala.
- **Desain Teknis & Implementasi:** Skema basis data, model entitas kode program, API endpoint, tata letak antarmuka pengguna (UI), dan prosedur teknis SOP.
