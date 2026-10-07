# OUTCOME: Dispensing

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-04     |
| Version     | 1.3          |
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

Dispensing secara tegas **BUKAN**:
- **Penjualan / Sales Order / Billing:** Pengelolaan pesanan penjualan, pemisahan penjamin, dan penetapan tagihan adalah wewenang **OC-11-03 (Penjualan)**.
- **Telaah Resep:** Pengkajian klinis instruksi pengobatan adalah wewenang **OC-11-02 (Telaah Resep)**.
- **Serah Obat:** Pemanggilan antrian loket, verifikasi pasien di loket, edukasi obat (KIE), dan serah-terima fisik ke pasien adalah wewenang **OC-11-05 (Serah Obat)**.
- **Transaksi Finansial & Kasir:** Penerimaan pembayaran dan refund adalah wewenang domain **Kasir** dan **Tata Rekening**.
- **Pencatatan Buku Stok:** Implementasi kartu stok dan mutasi buku gudang adalah wewenang domain **Inventory**.

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
| **Admission (`ADM`)** | Menerima pembaruan progres penyiapan fisik untuk pelacakan perjalanan pelayanan pasien (`ADM-TRACKER`). |
| **Pasien (`PAS`)** | Menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) sebagai subjek pelayanan. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-DISPENSING` Dispensing | Apotek | Known |
| `APT-QUEUE` Antrian Apotek | Apotek | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `INV-MUSNAH` Musnah | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known |
| `ADM-TRACKER` Pasien Journey | Admission | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |

> **Batasan Kepemilikan Upstream:** Kapabilitas `APT-ORDER` (Sales Order) dimiliki sepenuhnya oleh **OC-11-03 Penjualan**. Dispensing murni mengonsumsi instruksi pemenuhan yang diterbitkan oleh Sales Order sebagai masukan kerja fisik, tanpa mengelola siklus hidup Sales Order.

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

#### A. Hakikat Dispensing Job
1. Satu *Dispensing Job* merepresentasikan **satu batch pekerjaan penyiapan fisik** sediaan obat di farmasi.
2. Relasi antara Sales Order dan Dispensing Job bersifat fleksibel: satu Sales Order dapat menghasilkan satu atau beberapa *Dispensing Job* sesuai kebutuhan karakteristik sediaan atau beban operasional penyiapan.

#### B. Keberhasilan Normal: Ready for Pickup
1. Dispensing dinyatakan berhasil secara normal ketika *Dispensing Job* mencapai status **Ready for Pickup**.
2. Syarat kumulatif *Ready for Pickup*:
   - Selesai disiapkan secara fisik sesuai instruksi;
   - Lolos verifikasi mutu internal oleh tenaga kefarmasian;
   - Berada dalam *physical custody* yang teridentifikasi secara akuntabel;
   - Siap masuk ke proses serah obat (**OC-11-05**).
3. **Invarian All-or-Nothing:** Dilarang ada status `Partially Ready for Pickup`. *Dispensing Job* hanya boleh *Ready for Pickup* jika 100% item di dalamnya telah selesai dan terverifikasi.
4. *Ready for Pickup* adalah batas serah tugas operasional (*handoff boundary*) menuju OC-11-05, bukan penyerahan obat ke pasien.

#### C. Siklus Hidup Penyiapan Fisik
Siklus hidup normal mengikuti tahapan:
```text
Eligible ──► Queued ──► Preparing ──► Ready for Pickup
```
- **Queued:** Pekerjaan resmi masuk ke antrian tanggung jawab farmasi. Waktu tunggu / SLA penyiapan secara bisnis mulai dihitung sejak status *Queued*.
- **Preparing:** Pekerjaan fisik aktif mulai dikerjakan oleh petugas farmasi. Mengikat akuntabilitas pekerjaan fisik yang sedang berlangsung (*work-in-progress*).
- **Ready for Pickup:** Penyiapan fisik selesai, terverifikasi, dan berada dalam *custody* siap serah.

#### D. Integritas Pekerjaan Fisik & Granularitas Pembatalan
1. **No Silent Mutation:** Setelah berstatus *Preparing*, isi instruksi fisik dilarang diubah diam-diam. Perubahan instruksi fisik membatalkan pekerjaan terdampak dan menghasilkan instruksi/job baru.
2. **Granularitas Proporsional (Job vs Item):**
   - **Tingkat Item:** Pembatalan pada sebagian item memisahkan item tersebut sebagai **Cancelled**; item valid lainnya tetap dilanjutkan proses penyiapannya hingga *Ready for Pickup*.
   - **Tingkat Job:** Pembatalan terhadap keseluruhan *Dispensing Job* (**Cancelled**) hanya terjadi jika seluruh item dibatalkan atau instruksi batch berubah fundamental.
3. Perubahan administratif non-fisik tidak membatalkan pekerjaan fisik yang sedang berjalan.

#### E. Pembedaan Konseptual: Cancelled vs Unfulfilled
- **Cancelled:** Kebutuhan/instruksi ditarik atau tidak lagi berlaku (tidak ada kewajiban pemenuhan lanjutan).
- **Unfulfilled:** Kebutuhan pasien tetap sah, namun farmasi gagal memenuhinya secara fisik (terminal exception di Dispensing; kebutuhan tetap sah untuk ditindaklanjuti pada konteks upstream).

#### F. Pemenuhan Parsial (*Partial Fulfillment*)
Satu *Dispensing Job* tidak boleh menjadi *Ready for Pickup* secara parsial. Jika sebagian item gagal dipenuhi:
- Item yang gagal dipisahkan sebagai **Unfulfilled**;
- Bagian item yang berhasil diselesaikan secara utuh hingga **Ready for Pickup**;
- Silsilah batch asal tetap terlacak secara akuntabel.

#### G. Masa Tunggu (*Collection Window*) & No-Show Physical Custody
1. **Policy-Driven:** Masa tunggu pengambilan dimulai sejak *Ready for Pickup*. Durasi *collection window* ditentukan oleh kebijakan operasional/konfigurasi, bukan angka yang di-*hardcode*.
2. **Collection Expired Non-Terminal:** Terlampauinya batas waktu pengambilan mengubah kondisi menjadi *Collection Expired*. Ini adalah kondisi temporal non-terminal; tanggung jawab *physical custody* farmasi belum berakhir.
3. **Siklus Jalur No-Show:**
   ```text
   Ready for Pickup ──► Collection Expired ──► No-Show Resolution ──► Resolved
   ```
4. **Valid Physical Disposition:** Farmasi menyelesaikan *physical custody* melalui tindakan disposisi fisik yang sah (seperti pengembalian ke persediaan aktif untuk sediaan yang layak, atau pemusnahan/pembuangan untuk sediaan yang tidak layak pakai ulang). Tidak ada asumsi otomatis bahwa seluruh obat No-Show dapat dikembalikan ke stok aktif.
5. **Resolved sebagai Terminal State:** *Dispensing Job* mencapai status **Resolved** hanya jika seluruh sediaan fisik telah berdisposisi sah dan *remaining custody* bernilai nol.

#### H. Decoupling Downstream
Status penyelesaian fisik (*Resolved* maupun *Unfulfilled*) pada Dispensing diterbitkan ke konteks terkait (Sales Order/Billing/Tracking) dan **tidak bergantung pada keberhasilan proses downstream** seperti refund uang kasir, penyesuaian tagihan, atau pembatalan klaim BPJS.

#### I. Pembedaan Status Terminal
Status akhir penyiapan fisik dibedakan secara tegas sesuai fakta bisnisnya:
- **`Ready for Pickup`:** Selesai fisik & lolos verifikasi internal (handoff ke OC-11-05).
- **`Unfulfilled`:** Terminal exception ketika farmasi gagal memenuhi kebutuhan fisik yang masih valid.
- **`Cancelled`:** Terminal exception ketika instruksi penyiapan ditarik/tidak lagi berlaku.
- **`Resolved`:** Terminal state jalur No-Show setelah *physical custody* selesai tuntas.

---

### 5.2 Required Recorded Information

1. **Header Dispensing Job:** Nomor referensi unik, referensi instruksi pemenuhan asal (Sales Order), identitas pasien, unit layanan farmasi, kategori sediaan fisik, dan status siklus hidup.
2. **Akuntabilitas Waktu & SLA:** Waktu antrian (*Queued* - awal SLA), waktu mulai penyiapan (*Preparing*), waktu siap serah (*Ready for Pickup*), dan waktu penyelesaian exception/No-Show (*Resolved* / *Cancelled* / *Unfulfilled*).
3. **Akuntabilitas Tenaga Kefarmasian:** Identitas penyiap fisik (*preparer*) dan verifikator internal (*verifier*).
4. **Rincian Sediaan & Kuantitas:** Identitas obat, kuantitas instruksi, kuantitas disiapkan, kuantitas unfulfilled/cancelled, informasi kelayakan batch fisik, dan aturan pakai etiket.
5. **Verifikasi Mutu Internal:** Konfirmasi lolos verifikasi kesesuaian obat sebelum siap serah.
6. **Pengawasan Fisik (*Physical Custody*):** Identifikasi pengawasan/penyimpanan fisik sementara sediaan obat siap serah.
7. **Rekam Jejak Pemisahan (*Lineage Record*):** Catatan pemisahan item *Unfulfilled* atau *Cancelled* dari batch utama.
8. **Catatan Disposisi Fisik No-Show:** Rincian disposisi fisik yang sah per item dan konfirmasi nol sisa sediaan fisik (*Zero Remaining Custody*).

---

### 5.3 Required Business Conditions

1. **Kondisi Queued:** Instruksi pemenuhan sah dari Sales Order telah diterima dan memiliki minimal satu item penyiapan fisik dengan kuantitas > 0.
2. **Kondisi Preparing:** Pekerjaan dialokasikan kepada petugas farmasi yang berwenang.
3. **Kondisi Ready for Pickup:** 100% item dalam job selesai disiapkan fisik, lolos verifikasi internal, dan berada dalam *physical custody* yang teridentifikasi.
4. **Kondisi Unfulfilled:** Terjadi kegagalan pemenuhan fisik atas kebutuhan yang masih valid; item/job ditutup secara fisik dan diteruskan upstream.
5. **Kondisi Cancelled:** Instruksi ditarik/dibatalkan; penutupan diterapkan secara proporsional (level item memisahkan item, level job jika seluruh batch batal).
6. **Kondisi Resolved:** Masa tunggu berakhir (*Collection Expired*), seluruh sediaan fisik memiliki disposisi fisik yang sah, dan *physical custody* bernilai nol.

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
5. **Administrative Change Decoupling Invariant:** Perubahan data administratif non-fisik tidak membatalkan pekerjaan penyiapan fisik yang sedang berjalan.
6. **Distinct Meaning of Cancelled vs Unfulfilled Invariant:** *Cancelled* menyatakan penarikan instruksi (tidak ada kewajiban pemenuhan); *Unfulfilled* menyatakan kegagalan penyediaan fisik atas kebutuhan yang masih sah.
7. **Unfulfilled as Terminal Physical State Invariant:** Kegagalan penyediaan fisik berstatus akhir *Unfulfilled* di Dispensing dan memicu tindak lanjut pada konteks upstream.
8. **Accountable Partial Fulfillment Invariant:** Kegagalan pada sebagian item dipisahkan sebagai *Unfulfilled*, sedangkan bagian yang berhasil dapat diselesaikan hingga *Ready for Pickup* dengan silsilah batch yang terlacak.
9. **Policy-Driven Collection Window Invariant:** Durasi masa tunggu pengambilan ditentukan oleh kebijakan operasional/konfigurasi, bukan nilai yang di-*hardcode*.
10. **Continuous Custody Accountability Invariant:** *Collection Expired* adalah kondisi temporal non-terminal. Tanggung jawab *physical custody* farmasi berlanjut hingga sediaan memiliki disposisi fisik yang sah.
11. **Valid Physical Disposition for Resolved Invariant:** Status *Resolved* mensyaratkan setiap item memiliki pencatatan disposisi fisik yang sah dan *remaining custody* bernilai nol.
12. **No Automatic Restocking Assumption Invariant:** Dilarang mengasumsikan seluruh sediaan No-Show dapat otomatis dikembalikan ke persediaan aktif; sediaan yang tidak layak pakai ulang wajib diproses melalui pemusnahan/pembuangan (*discard*).
13. **Ready for Pickup Handoff Boundary Invariant:** *Ready for Pickup* adalah akhir tanggung jawab penyiapan fisik Dispensing dan handoff menuju OC-11-05; tidak mencakup penyerahan obat ke pasien atau edukasi KIE.
14. **Downstream Decoupling Invariant:** Keberhasilan penyelesaian fisik Dispensing (*Resolved* / *Unfulfilled*) tidak bergantung pada proses refund kasir, penyesuaian tagihan, atau klaim jaminan downstream.
15. **SLA Origin Invariant:** Penghitungan waktu tunggu / SLA penyiapan obat secara bisnis dimulai tepat saat pekerjaan berstatus *Queued*.
16. **Distinct Terminal States Invariant:** Dilarang menggunakan status universal tunggal seperti `Completed` untuk menggabungkan status *Ready for Pickup*, *Unfulfilled*, *Cancelled*, dan *Resolved*.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| **Perubahan klinis yang membatalkan seluruh batch saat Preparing** | *Dispensing Job* dibatalkan secara akuntabel (**Cancelled**). Sediaan fisik dibersihkan. Instruksi baru menghasilkan job baru. |
| **Perubahan klinis yang hanya membatalkan item tertentu dalam job** | Item terdampak dipisahkan sebagai **Cancelled**. Item valid lainnya tetap dilanjutkan proses penyiapannya hingga **Ready for Pickup**. |
| **Keterbatasan fisik persediaan atau kendala teknis penyiapan** | Item terdampak dipisahkan sebagai **Unfulfilled**. Sisa item yang berhasil diselesaikan hingga **Ready for Pickup**. Fakta kegagalan fisik diteruskan upstream. |
| **Seluruh item dalam job gagal dipenuhi secara fisik** | Seluruh *Dispensing Job* berakhir sebagai **Unfulfilled**. Kebutuhan pasien tetap sah dan diteruskan upstream untuk tindak lanjut. |
| **Obat gagal verifikasi mutu internal** | Status *Ready for Pickup* ditolak hingga sediaan diperbaiki dan lolos verifikasi. Jika tidak dapat dipenuhi, ditangani via pemisahan *Unfulfilled*. |
| **Masa tunggu pengambilan berakhir (*Collection Expired / No-Show*)** | Pekerjaan bertransisi ke *Collection Expired* (non-terminal). Farmasi menginisiasi *No-Show Resolution* untuk menetapkan disposisi fisik yang sah hingga status **Resolved**. |
| **Sediaan No-Show tidak memenuhi syarat kelayakan pakai ulang** | Sediaan diproses melalui pemusnahan/pembuangan (**Discard / Musnah** via `INV-MUSNAH`), bukan dikembalikan ke stok aktif persediaan komersial. |
| **Pembatalan instruksi sebelum pekerjaan fisik dimulai (saat Queued)** | *Dispensing Job* langsung bertransisi ke status **Cancelled** dan antrian dibebaskan secara tertib. |
| **Perubahan administratif non-fisik saat pekerjaan berjalan** | Data administratif diperbarui tanpa membatalkan *Dispensing Job*. Penyiapan fisik tetap berjalan normal. |
| **Kendala proses refund/klaim downstream saat fisik selesai** | Status *Resolved* pada Dispensing tetap sah. Penanganan finansial/klaim diselesaikan mandiri oleh domain terkait tanpa menahan status fisik Dispensing. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | *Dispensing Job* hanya dapat dibentuk dari instruksi pemenuhan yang sah dan memiliki minimal satu item fisik dengan kuantitas > 0. | Completeness |
| **AC-02** | Waktu tunggu / SLA penyiapan obat secara bisnis mulai dihitung sejak pekerjaan memasuki status **Queued**. | Correctness |
| **AC-03** | Status **Ready for Pickup** hanya dapat dicapai jika 100% item dalam *Dispensing Job* selesai disiapkan fisik dan lolos verifikasi internal kefarmasian. | Constraint |
| **AC-04** | Sistem menolak penetapan status `Partially Ready for Pickup`; jika terdapat item yang belum siap, job tidak dapat berstatus *Ready for Pickup*. | Constraint |
| **AC-05** | Perubahan instruksi fisik pada tingkat batch membatalkan pekerjaan lama menjadi **Cancelled** dan membentuk job baru, tanpa mutasi diam-diam pada pekerjaan lama. | Correctness |
| **AC-06** | Pembatalan pada tingkat item memisahkan item terdampak sebagai **Cancelled** tanpa membatalkan keseluruhan *Dispensing Job*, dan item valid lainnya tetap dilanjutkan proses penyiapannya. | Constraint |
| **AC-07** | Kegagalan pemenuhan fisik dicatat sebagai terminal outcome **Unfulfilled** (bukan *Cancelled*), dan fakta diterbitkan untuk resolusi lanjutan di konteks upstream. | Correctness |
| **AC-08** | Item yang gagal dipenuhi (*Unfulfilled*) dapat dipisahkan secara akuntabel dari job, sehingga sisa item yang berhasil dapat mencapai **Ready for Pickup** dengan silsilah batch yang terlacak. | Completeness |
| **AC-09** | Masa tunggu pengambilan dimulai tepat saat job mencapai status **Ready for Pickup**, dengan durasi yang mengacu pada konfigurasi kebijakan operasional. | Correctness |
| **AC-10** | Berakhirnya masa tunggu pengambilan mengubah status menjadi **Collection Expired** sebagai kondisi temporal non-terminal, dan tanggung jawab *physical custody* tetap berada pada farmasi. | Constraint |
| **AC-11** | *Dispensing Job* pada jalur No-Show hanya dapat bertransisi ke status **Resolved** apabila seluruh sediaan fisik telah memiliki disposisi fisik yang sah dan *Zero Remaining Custody* terpenuhi. | Completeness |
| **AC-12** | Sediaan yang tidak memenuhi syarat kelayakan pakai ulang akibat No-Show diproses melalui disposisi pemusnahan/pembuangan (*Discard*), dan tidak dikembalikan ke stok aktif persediaan komersial. | Correctness |
| **AC-13** | Status **Ready for Pickup** berfungsi sebagai handoff boundary menuju OC-11-05 dan tidak mencakup penyerahan obat ke pasien atau edukasi KIE. | Constraint |
| **AC-14** | Keberhasilan penetapan status **Resolved** pada Dispensing tidak bergantung pada status penyelesaian refund, billing, atau klaim BPJS di sistem downstream. | Constraint |
| **AC-15** | Status akhir penyiapan fisik dibedakan secara tegas antara **Ready for Pickup**, **Unfulfilled**, **Cancelled**, dan **Resolved**, tanpa menggunakan status universal `Completed`. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Kepemilikan Sales Order, Pemesanan Komersial & Plafon Kuantitas Komitmen:** Pembentukan Sales Order, pemisahan jalur penjamin (*payer split*), dan penguncian plafon komitmen `AcceptedQty` → **OC-11-03 Penjualan** (`APT-ORDER`).
- **Penetapan Harga, Faktur, & Potret Finansial:** Penerbitan Invoice, penentuan harga satuan, tuslah, diskon, dan penetapan *Pricing Snapshot* → **OC-11-03 Penjualan** (`APT-BILL`) dan **Tata Rekening** (`TRK-TARIF`).
- **Penyerahan Obat ke Pasien & Edukasi Pasien:** Pemanggilan antrian serah obat di loket, verifikasi identitas penerima akhir, dan edukasi/konseling pemakaian obat (KIE) → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Pengkajian Klinis Resep:** Telaah administratif, farmasetis, dan klinis atas resep dokter → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Penerimaan Pembayaran Kasir & Penutupan Kas:** Eksekusi pembayaran kasir, penutupan shift kasir, dan pengembalian uang (*refund*) fisik kepada pasien → **OC-03-01 Kasir** (`TRK-PAYMENT`, `TRK-KASIR`) dan **OC-03-02 Closing Shift**.
- **Pencatatan Buku Kas & Penyesuaian Akuntansi Piutang:** Penyesuaian nota kredit, posting jurnal piutang, dan rekonsiliasi keuangan rumah sakit → Domain **Tata Rekening** (`TRK-BILLING`).
- **Pengurusan Klaim Jaminan & BPJS:** Verifikasi keabsahan kartu, penerbitan SEP, kaidah Fornas, dan verifikasi berkas klaim BPJS → **OC-01-04 VCLAIM BPJS** (`BPJ-VCLAIM`) dan domain jaminan eksternal.
- **Implementasi Kartu Stok & Buku Besar Pergudangan:** Mekanisme internal penulisan tabel mutasi stok, kartu stok inventori, dan algoritma alokasi gudang → Domain **Inventory** (`INV-STOK`, `INV-MUTASI`).
- **Penghitungan Stok Fisik Apotek:** Pelaksanaan stok opname berkala instalasi farmasi → **OC-11-06 Opname** (`INV-OPNAME`).
- **Rancangan Teknis dan Antarmuka Pengguna:** Skema tabel basis data, trigger SQL, model data internal, antarmuka grafis (UI wireframe / mockup), tata letak layar, endpoint API, dan format serialisasi event/message.
