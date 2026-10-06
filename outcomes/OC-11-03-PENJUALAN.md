# OUTCOME: Penjualan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-11-03     |
| Version     | 1.1          |
| Status      | Draft        |
| LastUpdated | 2026-10-06   |

---

## 1. Business Purpose

Penjualan adalah outcome bisnis ketika permintaan obat yang telah disetujui secara sah (*accepted medication demand*) ditransformasikan menjadi komitmen operasional dan komersial (*commercial/operational commitment*) yang akuntabel oleh instalasi farmasi / Apotek, diikuti dengan pembentukan komitmen finansial melalui penerbitan faktur tagihan (*Invoice*) berdasarkan potret harga yang sah (*Pricing Snapshot*), hingga akhirnya mencapai disposisi komersial akhir (*final commercial disposition*).

Tujuan bisnis Penjualan adalah:
1. **Menetapkan Akuntabilitas Komitmen Pelayanan:** Mengunci batas kuantitas (*commitment ceiling*) dan identitas obat yang disanggupi oleh Apotek berdasarkan ketersediaan stok riil (*Available Stock*) serta keputusan telaah/penerimaan profesional, sehingga seluruh proses hilir memiliki plafon yang pasti.
2. **Mengisolasi Jalur Penjamin (*Payer Path*):** Memisahkan pertanggungjawaban komersial ke dalam Sales Order yang homogen per jalur penjamin (misalnya memisahkan porsi jaminan BPJS dari porsi bayar mandiri/umum), guna mencegah percampuran hak tagih, klaim, maupun beban biaya pasien.
3. **Memisahkan Komitmen Operasional dari Komitmen Finansial:** Menjamin kepastian kuantitas pelayanan pada saat Sales Order terbentuk tanpa mengunci harga secara prematur, serta menetapkan kepastian finansial secara definitif hanya pada saat Invoice diterbitkan.
4. **Memastikan Penutupan Transaksi yang Tertib dan Terlacak (*Closed & Reconciled Commercial Lifecycle*):** Mengawal seluruh kuantitas komitmen hingga berstatus akhir tuntas (*UnresolvedAcceptedQty = 0*) dan memastikan tidak ada konsekuensi finansial yang mengambang, dengan ketertelusuran penuh dari permintaan asal hingga penyelesaian akhir.

Penjualan secara tegas **BUKAN**:
- **Telaah Resep:** Pengkajian klinis dan penetapan kelaikan farmasi adalah wewenang penuh **OC-11-02 (Telaah Resep)**.
- **Dispensing:** Penyiapan fisik, peracikan, alokasi stok fisik, dan pengemasan obat adalah wewenang penuh **OC-11-04 (Dispensing)**.
- **Serah Obat:** Penyerahan fisik obat kepada pasien dan edukasi obat adalah wewenang penuh **OC-11-05 (Serah Obat)**.
- **Stok Opname:** Penyesuaian dan penghitungan fisik persediaan farmasi adalah wewenang penuh **OC-11-06 (Opname)**.
- **Mutasi Stok:** Perpindahan fisik barang antar unit farmasi adalah wewenang penuh **OC-11-07 (Mutasi)**.
- **Transaksi Pembayaran / Kasir / Refund:** Penerimaan uang fisik, penutupan kasir, pengembalian dana (*refund*), maupun penerbitan nota kredit (*credit note*) adalah wewenang penuh domain **Tata Rekening** dan **Kasir**.
- **Detail Teknis:** Outcome ini tidak mencakup rancangan database, antarmuka layar pengguna (UI), alur layar (*screen layout*), endpoint API, maupun prosedur operasional standar (SOP).

---

## 2. Outcome Statement

Permintaan obat yang telah disetujui (*Accepted Medication Demand*) **telah ditransformasikan menjadi komitmen operasional dan komersial Apotek yang akuntabel (Sales Order) dengan pemisahan jalur penjamin (PayerPath) yang homogen dan batas kuantitas (AcceptedQty) yang terkunci, komitmen finansialnya telah ditetapkan melalui Invoice berdasarkan Pricing Snapshot yang sah, serta seluruh kuantitas komitmen beserta konsekuensi finansial terkait telah mencapai disposisi komersial akhir (final commercial disposition) yang definitif (Resolved atau Cancelled)**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| **Apotek (`APT`)** | Pemilik utama outcome Penjualan: mengelola transformasi accepted demand menjadi Sales Order, menetapkan kuantitas komitmen (`AcceptedQty`), mengeksekusi pembagian Sales Order berdasarkan jalur penjamin (*payer split*), memelihara ketertelusuran ke telaah/permintaan asal, menerbitkan Invoice sebagai komitmen finansial (`APT-BILL`), serta mengawal siklus hidup hingga disposisi komersial akhir. |
| **Tata Rekening (`TRK`)** | Kolaborator finansial: menyediakan aturan dan struktur tarif (`TRK-TARIF`), aturan penjaminan (`TRK-JAMINAN`), mengonsumsi komitmen finansial Invoice ke dalam konsolidasi tagihan pasien (`TRK-BILLING`), serta mengonfirmasi penyelesaian resmi atas konsekuensi finansial (pelunasan, posting tagihan, atau koreksi nota resmi). |
| **Kasir (`KSR`)** | Kolaborator transaksi kas: melaksanakan penerimaan pembayaran kas/non-kas atas invoice umum dan memproses penyelesaian restitusi/pembatalan resmi kas apabila terjadi pembatalan transaksi dengan invoice aktif. |
| **Inventory (`INV`)** | Kolaborator persediaan: menyediakan master identitas obat (`INV-MASTER`) dan data stok yang tersedia (*Available Stock* via `INV-STOK`) yang digunakan sebagai gerbang penentuan kuantitas komitmen (*Available Stock Gate*). |
| **Pasien (`PAS`)** | Subjek pelayanan: menyediakan identitas tunggal pasien yang sah (`PAS-DATSOS`) sebagai subjek komitmen operasional dan pihak yang bertransaksi. |
| **Admission (`ADM`)** | Penyedia konteks registrasi: menyediakan konteks episode kunjungan aktif pasien (`ADM-REG`) untuk pelayanan obat yang terhubung dengan episode rawat jalan, gawat darurat, atau rawat inap. |
| **BPJS (`BPJ`)** | Penyedia konteks jaminan: menyediakan verifikasi kepesertaan dan parameter eligibilitas klaim BPJS (`BPJ-VCLAIM`) sebagai dasar evaluasi penjaminan bagi Sales Order jalur BPJS. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|------------|--------|--------|
| `APT-ORDER` Sales Order | Apotek | Known |
| `APT-BILL` Sales Bill | Apotek | Known |
| `APT-TELAAH` Telaah Resep | Apotek | Known |
| `APT-RESEP` Resep | Apotek | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `TRK-JAMINAN` Jaminan | Tata Rekening | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `ADM-REG` Registration | Admission | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

#### A. Pemisahan Konsep Domain Objects
Penjualan memisahkan dan membedakan secara tegas domain objects berikut:
1. **Resep / Demand:** Menjawab *"Apa yang diminta?"* Permintaan awal terapi medis dari dokter atau permintaan pembelian dari pembeli/pasien.
2. **Telaah Resep:** Menjawab *"Apakah item tersebut secara farmasi/klinis dapat diterima?"* Evaluasi profesional Apoteker yang menetapkan kelaikan klinis item.
3. **Accepted Medication Item:** Menjawab *"Apa yang secara profesional diterima untuk diproses?"* Himpunan item yang telah dinyatakan layak secara klinis (pada resep) atau disetujui Apotek (pada OTC).
4. **Sales Order:** Menjawab *"Berapa quantity yang resmi dikomitmenkan Apotek untuk diproses, melalui payer path apa, dan berdasarkan acceptance/coverage basis apa?"* Dokumen komitmen operasional/komersial akuntabel Apotek.
5. **Invoice:** Menjawab *"Berapa financial commitment transaksi yang terbentuk, berdasarkan pricing snapshot saat Invoice Established?"* Dokumen penguncian komitmen finansial tagihan.
6. **Dispensing:** Menjawab *"Berapa yang secara fisik dipenuhi/diserahkan?"* Pelaksanaan pemenuhan fisik obat di ruang peracikan/penyiapan.
7. **Payment:** Menjawab *"Berapa uang yang telah diselesaikan/diterima kasir?"* Penyelesaian transaksi moneter di kasir.

#### B. Alur Model Bisnis Utama
Transformasi bisnis berjalan melalui tahapan tegas:
```text
Demand (Resep / Jual Bebas)
  ↓
Professional Acceptance / Telaah Resep
  ↓
Accepted Medication Item
  ↓
Payer Split (Evaluasi Penjamin & Pemisahan Jalur)
  ↓
Sales Order (Operational/Commercial Commitment)
  ↓
Invoice (Financial Commitment via Pricing Snapshot)
  ↓
Dispensing (Physical Fulfillment)
  ↓
Handover (Penyerahan Obat)
```

#### C. Gerbang Sumber Permintaan (*Demand Gateway*)
1. **Permintaan Berbasis Resep (*Prescription Demand*):**
   - Wajib menyelesaikan Telaah Resep (**OC-11-02**).
   - Item dengan keputusan telaah `AcceptedAsPrescribed` (Disetujui Sesuai Resep) dan `AcceptedSubstitute` (Disetujui dengan Penggantian) menjadi *Accepted Medication Item* yang dapat diproses ke Sales Order.
   - Item dengan keputusan telaah `Rejected` (Ditolak) dilarang menghasilkan Sales Order item.
   - Resep yang masih berstatus `Under Review` / `Sedang Ditelaah` dilarang membentuk Sales Order.
2. **Permintaan Jual Bebas (*Over-the-Counter / OTC Demand*):**
   - Tidak memerlukan telaah klinis resep formal.
   - Wajib disetujui dan diterima secara resmi oleh Apotek sebagai permintaan penjualan yang sah.
   - Permintaan OTC yang ditolak Apotek tidak menghasilkan Sales Order.

#### D. Pembentukan Sales Order (*Sales Order Establishment*)
Sales Order Establishment adalah transisi resmi ketika *accepted demand* berubah menjadi komitmen operasional dan komersial yang dapat dipertanggungjawabkan oleh Apotek.
1. **Karakteristik Komitmen:**
   - **Dijamin & Dikunci oleh Sales Order:**
     - Identitas item yang disetujui (*accepted item identity*, termasuk obat pengganti jika hasil substitusi).
     - Kuantitas komitmen yang disetujui (`AcceptedQty`).
     - Jalur penjamin tunggal (`PayerPath`).
     - Basis kelaikan klinis/pertanggungan (*clinical/coverage basis*).
     - Keterlacakan ke permintaan dan telaah asal (*source traceability*).
   - **TIDAK Dijamin atau Dikunci oleh Sales Order:**
     - Harga satuan (*UnitPrice*).
     - Diskon (*Discount*).
     - Pajak (*Tax*).
     - Biaya tambahan/tuslah/embalase (*Charges*).
     - Total nilai uang (*Total Monetary Amount*).
2. **Empat Gerbang Bisnis Pembentukan Sales Order (*Business Gates*):**
   - **Gerbang 1: Available Stock Gate (*Batas Ketersediaan Stok*):**
     - Kuantitas stok yang tersedia (*Available Stock*) menentukan besaran `AcceptedQty`.
     - *Available Stock* TIDAK mewajibkan stok harus mencukupi seluruh kuantitas yang diminta (`RequestedQty`) agar Sales Order boleh terbentuk.
     - Jika `Available Stock < RequestedQty`, Sales Order tetap dapat terbentuk sebesar kuantitas yang tersedia (`AcceptedQty = Available Stock`), dan sisanya menjadi permintaan yang tidak dapat dilayani (*ExcludedQty*).
   - **Gerbang 2: Payer Path Homogeneity Gate (*Homogenitas Jalur Penjamin*):**
     - Satu Sales Order hanya boleh memiliki tepat satu `PayerPath`.
   - **Gerbang 3: Non-Empty Commitment Gate (*Komitmen Tidak Boleh Kosong*):**
     - Sales Order wajib memiliki minimal satu baris item dengan `AcceptedQty > 0`.
   - **Gerbang 4: Unique Commitment / Idempotency Gate (*Invarian Keunikan Komitmen*):**
     - Permintaan yang telah disetujui dilarang menghasilkan lebih dari satu komitmen akuntabel (tidak boleh terjadi komitmen ganda / duplikasi Sales Order).
     - Pemrosesan ulang (*reprocessing event/request*) atas permintaan yang sama harus menghasilkan komitmen yang sama persis tanpa menduplikasi Sales Order. Idempotensi ini adalah invarian bisnis mutlak.

#### E. Pemisahan Jalur Penjamin (*Payer Split*)
1. **Invarian Utama:** `One Sales Order = exactly one PayerPath`.
2. **Waktu Pelaksanaan:** Payer split dieksekusi setelah *accepted items* tersedia dan sebelum Sales Order berstatus *Established*.
3. **Mekanisme Split:**
   - Apabila satu resep menghasilkan item-item dengan jalur penjamin berbeda (misalnya sebagian dijamin BPJS dan sebagian tidak dijamin sehingga menjadi tanggungan pasien/umum), terbentuk Sales Order terpisah yang masing-masing homogen:
     - `SO-A`: `PayerPath = BPJS`, berisi seluruh covered items.
     - `SO-B`: `PayerPath = GeneralPatientPay`, berisi seluruh non-covered items.
   - Dilarang membuat *hybrid Sales Order* yang mencampur lebih dari satu `PayerPath` dalam satu Sales Order.
4. **Kelengkapan Bisnis Hasil Split (*Business-Complete Split*):**
   - Hasil payer split harus business-complete: seluruh Sales Order yang diperlukan dari satu permintaan yang displit harus terbentuk sebagai satu hasil bisnis yang lengkap. Tidak boleh menghasilkan partial split yang meninggalkan sebagian accepted item tanpa Sales Order.
5. **Batasan Kepemilikan (*Scope Boundary*):**
   - Penjualan bukan pemilik evaluasi eligibilitas BPJS, aturan Fornas, maupun lifecycle SEP. Penjualan hanya mengonsumsi hasil evaluasi coverage/penjamin sebagai fakta masukan.
6. **Imutabilitas Jalur Penjamin:**
   - Properti `PayerPath` bersifat *immutable* (tidak dapat diubah) setelah Sales Order berstatus *Established*.
   - Dilarang mengubah jalur penjamin pada Sales Order yang telah terbentuk (misal mengubah `BPJS` menjadi `General`, atau `General` menjadi `BPJS`).
   - Jika pasien menolak Sales Order jalur bayar mandiri (`GeneralPatientPay`):
     - `PayerPath` tidak boleh diubah.
     - Sales Order jalur umum tersebut diproses menuju disposisi akhir sesuai siklus hidupnya (misalnya *Resolved* dengan alasan *PatientDeclined*).
     - Sales Order jalur BPJS tetap berdiri sendiri dan tidak terpengaruh oleh penolakan tersebut.

#### F. Model Kuantitas dan Plafon Komitmen (*Quantity Model*)
1. **Definisi Istilah Kuantitas:**
   - `PrescribedQty`: Kuantitas asli yang tertera pada instruksi resep dokter (untuk OTC: kuantitas yang diminta / `RequestedQty`).
   - `AcceptedQty`: Kuantitas yang resmi dikomitmenkan Apotek ke dalam Sales Order, setelah melalui seluruh gerbang bisnis pra-SO (termasuk gerbang stok dan gerbang kelaikan telaah).
   - `ExcludedQty`: Seluruh kuantitas dari permintaan asal yang tidak masuk ke dalam Sales Order untuk alasan apapun sebelum Sales Order terbentuk — termasuk (namun tidak terbatas pada) keterbatasan *Available Stock*, keputusan telaah yang membatasi kuantitas yang dapat dilayani, atau alasan bisnis pra-SO lainnya. `ExcludedQty` adalah selisih antara kuantitas permintaan asal dan `AcceptedQty`, bukan semata-mata bagian yang tidak ada stoknya.
   - `DispensedQty`: Kuantitas fisik obat yang benar-benar disiapkan dan dipenuhi (ditentukan oleh proses Dispensing, bukan oleh Sales Order).
   - `UnfulfilledQty`: Bagian dari `AcceptedQty` yang pada akhirnya tidak dipenuhi setelah Sales Order berstatus *Established* (misalnya: pasien menolak, batas waktu pengambilan terlampaui, atau kekurangan stok pada saat dispensing).
   - `UnresolvedAcceptedQty`: Bagian dari `AcceptedQty` yang masih berjalan dan belum memiliki disposisi akhir yang definitif.
2. **Relasi Kuantitas:**

   Pada tahap pra-SO (sebelum Sales Order terbentuk):
   ```text
   PrescribedQty (/ RequestedQty)
     = AcceptedQty + ExcludedQty
   ```
   Pada tahap pasca-SO (setelah Sales Order berstatus Established hingga Resolved):
   ```text
   AcceptedQty
     = DispensedQty + UnfulfilledQty + UnresolvedAcceptedQty
   ```
   Pada disposisi komersial akhir:
   ```text
   UnresolvedAcceptedQty = 0
   AcceptedQty = DispensedQty + UnfulfilledQty
   ```
   > **Catatan:** `ExcludedQty` dan `UnfulfilledQty` adalah dua fakta bisnis yang berbeda dan tidak boleh dicampur. `ExcludedQty` terjadi sebelum Sales Order terbentuk; `UnfulfilledQty` terjadi terhadap kuantitas yang sudah masuk ke dalam Sales Order.

3. **Plafon Komitmen (*Commitment Ceiling*):**
   - Setelah Sales Order berstatus *Established*, `AcceptedQty` menjadi plafon komitmen tertinggi.
   - Kuantitas downstream (baik kuantitas dispensing maupun kuantitas faktur) dilarang melebihi `AcceptedQty`:
     - `DispensedQty <= AcceptedQty`
     - `InvoiceQty <= AcceptedQty`
   - `AcceptedQty` dilarang ditulis ulang atau ditimpa (*overwritten*) menjadi `DispensedQty`.
4. **Aturan Pelayanan Rawat Jalan (*Outpatient Rule*):**
   - Pelayanan farmasi rawat jalan **tidak mengenal mekanisme backorder**.
   - Kuantitas yang tidak dapat dipenuhi pada saat pembentukan Sales Order — termasuk karena keterbatasan *Available Stock* — menjadi bagian dari `ExcludedQty` dan tidak masuk ke dalam Sales Order.
   - Jika diperlukan, sisa permintaan tersebut dapat diterbitkan salinan resep (*copy prescription*) sesuai aturan bisnis farmasi.
   - `ExcludedQty` pra-SO dilarang dicatat atau dikategorikan sebagai `UnfulfilledQty`. `UnfulfilledQty` hanya berlaku terhadap kuantitas yang sudah resmi masuk ke dalam Sales Order.

#### G. Penetapan Harga dan Komitmen Finansial (*Pricing & Financial Commitment*)
1. **Pemisahan Sales Order dan Harga:**
   - **Sales Order hanya mengunci kuantitas, identitas item, jalur penjamin, dan basis telaah.**
   - **Harga menjadi komitmen finansial resmi HANYA ketika Invoice berstatus Established.**
   - Perhitungan harga sebelum Invoice terbentuk hanyalah estimasi/evaluasi harga (*pricing evaluation/estimate*) yang tidak mengikat.
2. **Alur Penetapan Komitmen Finansial:**
   - **Jalur Pasien Umum / Mandiri (*General / Self-Pay*):**
     ```text
     Pricing Evaluation → Konfirmasi Pasien → Invoice Established → Pricing Snapshot Mengikat
     ```
   - **Jalur Jaminan BPJS (*BPJS Coverage*):**
     ```text
     Sales Order Established → Basis Klaim / Penyerahan Terpenuhi → Invoice Established → Pricing Snapshot Mengikat
     ```
3. **Konsep Potret Harga (*Pricing Snapshot*):**
   - Saat Invoice ditetapkan (*Invoice Established*), *Pricing Snapshot* tercatat sebagai fakta finansial permanen yang merepresentasikan kondisi harga dan tagihan saat itu:
     - Kuantitas tertagih (*Invoiced Quantity*).
     - Harga satuan (*Unit Price*).
     - Potongan harga / diskon (*Discount*).
     - Biaya pelayanan / tuslah / embalase (*Charges*).
     - Pajak (*Tax*).
     - Pembulatan (*Rounding*).
     - Nilai moneter total (*Total Amount*).
     - Informasi penjamin (*Payer Information*).
   - **Imutabilitas Potret Finansial:** Perubahan harga pada master tarif (*Tariff Master*) setelah Invoice Established dilarang mengubah nilai pada Pricing Snapshot yang telah tercatat.
4. **Integritas Koreksi Finansial:**
   - Dilarang melakukan mutasi diam-diam (*silent mutation*) terhadap komitmen finansial historis.
   - Setiap perubahan atau pembatalan nilai tagihan wajib melalui koreksi finansial resmi (*official financial correction*) yang diakui oleh pihak Tata Rekening/Kasir (seperti nota koreksi, pembatalan/void kasir, atau penyesuaian billing resmi).
5. **Invarian Kuantitas Penagihan:**
   - Kuantitas pada satu faktur tidak boleh melebihi kuantitas komitmen: `InvoiceQty <= SalesOrder.AcceptedQty`.
   - Secara kumulatif untuk Sales Order dengan beberapa faktur: `Σ InvoiceQty per SalesOrderItem <= AcceptedQty`.
   - Partial invoicing diperbolehkan pada konteks proses yang relevan (seperti rawat inap), namun tidak boleh dijadikan sarana backorder pada rawat jalan.

#### H. Ketertelusuran Sumber (*Source Traceability*)
Setiap baris item Sales Order (`SalesOrderItem`) wajib memiliki rantai keterlacakan utuh dan persisten:
```text
Original Demand Item (Resep / OTC)
        ↓
Telaah Decision (Persetujuan Apoteker / Penerimaan Apotek)
        ↓
Accepted Medication Item
        ↓
SalesOrderItem
```
- Rekonsiliasi antara permintaan yang diterima (*accepted demand*) dan Sales Order wajib 100% konsisten:
  - Tidak ada accepted item yang hilang.
  - Tidak ada accepted item yang terduplikasi.
  - Tidak ada item yang ditolak atau dieksklusi yang menyusup ke dalam Sales Order.
  - Seluruh accepted items terpetakan secara lengkap ke Sales Order yang sesuai dengan jalur penjaminnya.

#### I. Siklus Hidup Sales Order (*Sales Order Lifecycle*)
Siklus hidup Sales Order header HANYA terdiri dari empat status kanonikal:
1. **Established:** Sales Order telah resmi terbentuk sebagai komitmen operasional/komersial akuntabel Apotek.
2. **Active:** Telah terdapat konsekuensi operasional/komersial turunan (*downstream consequence*) yang nyata dari komitmen tersebut.
   - Contoh pemicu transisi ke *Active*:
     - *Invoice Established* telah terjadi, atau
     - Pemrosesan fisik / reservasi stok dispensing mulai dilakukan.
   - *Catatan:* Evaluasi penjamin/coverage yang terjadi sebelum pembentukan Sales Order dilarang dijadikan pemicu transisi ke status *Active*.
3. **Resolved:** Seluruh komitmen komersial telah mencapai disposisi akhir yang definitif.
4. **Cancelled:** Siklus komitmen dihentikan/dibatalkan secara sah melalui pembatalan (*authorized abort*), bukan melalui penyelesaian komersial normal.

*Catatan:* Status `Draft`, `PartiallyFulfilled`, atau `Fulfilled` **dilarang** dijadikan sebagai canonical header state.

Diagram transisi kanonikal:
```text
      Established
          │
          │ First downstream consequence (e.g. Invoice Established / Physical Processing)
          ▼
        Active
          │
          ├── Final commercial disposition → Resolved
          │
          └── Authorized abort             → Cancelled
```

#### J. Disposisi Komersial Akhir (*Commercial Final Disposition*)
Sales Order mencapai kondisi akhir komersial yang sah (**Resolved**) HANYA JIKA memenuhi dua syarat kumulatif:
1. **Disposisi Kuantitas Selesai:** Seluruh kuantitas komitmen (`AcceptedQty`) telah memiliki status akhir pasti:
   - Menjadi `DispensedQty` (berhasil dipenuhi/diserahkan), ATAU
   - Menjadi `UnfulfilledQty` (tidak dipenuhi dengan alasan bisnis yang sah),
   sehingga:
   ```text
   UnresolvedAcceptedQty = 0
   ```
   DAN
2. **Disposisi Finansial Selesai:** Seluruh konsekuensi finansial dari Invoice yang terkait telah memiliki status penyelesaian resmi dari pihak yang berwenang (misal: telah lunas di kasir, telah berhasil masuk ke penagihan klaim/billing resmi rumah sakit, atau telah diselesaikan melalui nota pembatalan/void resmi).

*Prinsip Penting:*
- **Resolved ≠ Fully Fulfilled:** Sales Order dapat berstatus *Resolved* meskipun kuantitas yang dipenuhi kurang dari komitmen atau bahkan nol, asalkan seluruh sisa kuantitas berstatus definitif sebagai *UnfulfilledQty* dan konsekuensi finansialnya selesai.
- **Resolved ≠ Paid:** Status *Resolved* mencerminkan selesainya komitmen komersial Apotek, bukan pencatatan uang tunai kasir.

#### K. Pembedaan Pembatalan vs Resolusi (*Cancellation vs Resolution*)
- **`Resolved`:** Digunakan ketika alur komitmen selesai hingga akhir, baik terpenuhi seluruhnya, terpenuhi sebagian, maupun tidak terpenuhi sama sekali karena alasan bisnis yang sah pasca komitmen.
  - Alasan akhir (*Final Reason*) pada status *Resolved* mencakup antara lain:
    - `FullFulfillment`: seluruh kuantitas berhasil diserahkan (`DispensedQty = AcceptedQty`).
    - `PartialNonFulfillment`: sebagian kuantitas diserahkan, sisanya tidak dipenuhi.
    - `PatientDeclined`: pasien menolak mengambil sisa atau seluruh obat komitmen.
    - `CollectionWindowExpired`: pasien tidak hadir mengambil obat hingga batas waktu penyimpanan kadaluwarsa (*no-show*).
- **`Cancelled`:** Digunakan HANYA jika siklus hidup komitmen dibatalkan/di-abort secara sah sebelum alur proses berjalan tuntas.
- **Keterikatan Finansial pada Status Terminal:** Jika Invoice telah terbentuk, Sales Order dilarang bertransisi ke status terminal (`Resolved` maupun `Cancelled`) selama konsekuensi finansial dari invoice tersebut masih mengambang. Konsekuensi finansial harus diselesaikan terlebih dahulu oleh Tata Rekening / Kasir.

---

### 5.2 Required Recorded Information

1. **Informasi Header Sales Order:**
   - Nomor identitas unik Sales Order.
   - Waktu pembentukan Sales Order.
   - Unit farmasi / apotek yang menerbitkan komitmen.
   - Status siklus hidup saat ini (**Established**, **Active**, **Resolved**, **Cancelled**).
   - Alasan perubahan status siklus hidup.
   - Jalur penjamin tunggal (`PayerPath`).
   - Keterikatan dengan grup pemisahan jalur penjamin, jika berasal dari demand yang displit.
2. **Informasi Subjek Pasien dan Kunjungan:**
   - Identitas pasien.
   - Konteks episode kunjungan aktif pasien (jika terikat episode pelayanan RS).
3. **Informasi Rincian Komitmen Item (`SalesOrderItem`):**
   - Referensi item permintaan asal (resep dokter / permintaan OTC) yang dapat ditelusuri ke baris permintaan dan keputusan telaah yang mendasarinya.
   - Identitas obat yang disetujui, termasuk obat pengganti dan obat asli bila hasil substitusi.
   - Instruksi pemakaian obat yang disetujui.
   - Kuantitas asal permintaan (`PrescribedQty` / `RequestedQty`).
   - Kuantitas yang dikomitmenkan (`AcceptedQty`).
   - Kuantitas yang dieksklusi sebelum komitmen terbentuk (`ExcludedQty`) beserta alasan pengecualian.
   - Kuantitas yang berhasil diserahkan (`DispensedQty`).
   - Kuantitas komitmen yang tidak terpenuhi (`UnfulfilledQty`) beserta alasan tidak terpenuhi.
   - Kuantitas yang belum terselesaikan (`UnresolvedAcceptedQty`).
4. **Informasi Komitmen Finansial (`Invoice`):**
   - Referensi unik Invoice yang dapat ditelusuri ke Sales Order yang mendasarinya.
   - Waktu penetapan komitmen finansial (Invoice Established).
   - Kuantitas yang ditagihkan per baris item (`InvoiceQty`).
   - **Pricing Snapshot** permanen yang merekam: harga satuan, diskon, biaya pelayanan, pajak, pembulatan, total nilai kewajiban finansial, dan informasi penjamin — seluruhnya merepresentasikan kondisi saat Invoice Established.
5. **Informasi Disposisi Komersial Akhir:**
   - Waktu dan kategori hasil akhir komersial (*Final Disposition Category*).
   - Konfirmasi bahwa konsekuensi finansial dari Invoice terkait telah memiliki disposisi resmi dari pihak yang berwenang.

---

### 5.3 Required Business Conditions

1. **Syarat Pembentukan Sales Order:**
   - Resep asal telah menyelesaikan Telaah Resep (**OC-11-02**) tanpa menyisakan item berstatus pending/menunggu klarifikasi.
   - Item resep yang masuk wajib berstatus telaah `AcceptedAsPrescribed` atau `AcceptedSubstitute`.
   - Permintaan OTC telah disetujui resmi oleh petugas Apotek.
   - Kuantitas `AcceptedQty` tidak boleh melebihi kuantitas stok yang tersedia (`AcceptedQty <= Available Stock`).
   - Sales Order wajib memiliki minimal 1 item dengan `AcceptedQty > 0`.
   - Demand yang sama tidak boleh menghasilkan lebih dari satu accountable Sales Order commitment (invarian idempotensi).
2. **Syarat Homogenitas dan Integritas Payer Split:**
   - Setiap Sales Order hanya memuat item-item yang memiliki `PayerPath` identik.
   - Payer split wajib menghasilkan hasil yang business-complete: seluruh Sales Order yang diperlukan dari satu permintaan yang displit harus terbentuk sebagai satu hasil bisnis yang lengkap.
   - Setelah status *Established*, properti `PayerPath` tidak dapat diubah ke jalur penjamin lain.
3. **Syarat Penguncian Finansial:**
   - Harga satuan, diskon, biaya embalase/tuslah, dan total tagihan baru menjadi komitmen mengikat saat Invoice berstatus *Established*.
   - Kuantitas pada faktur tidak boleh melebihi kuantitas komitmen (`InvoiceQty <= AcceptedQty`).
   - Nilai pada *Pricing Snapshot* kebal terhadap perubahan tarif master yang terjadi di kemudian hari.
4. **Syarat Transisi Siklus Hidup:**
   - Transisi dari *Established* ke *Active* hanya terjadi bila telah terdapat konsekuensi turunan nyata (penerbitan Invoice atau dimulainya pemrosesan fisik).
   - Sales Order dilarang mencapai status terminal (*Resolved* atau *Cancelled*) selama nilai `UnresolvedAcceptedQty > 0`.
   - Sales Order yang memiliki Invoice dilarang mencapai status terminal selama konsekuensi finansial invoice belum memiliki disposisi resmi dari pihak Tata Rekening/Kasir.
5. **Syarat Pelayanan Rawat Jalan:**
   - Tidak ada backorder. Sisa kuantitas demand yang tidak dapat dilayani menjadi `ExcludedQty` dan dapat difasilitasi melalui penerbitan salinan resep resmi.

---

### 5.4 Completion Proof

Outcome Penjualan dinyatakan selesai apabila dapat diverifikasi bahwa:
1. Sales Order berada pada status terminal yang sah: **Resolved** atau **Cancelled**.
2. `UnresolvedAcceptedQty = 0` untuk setiap baris item pada Sales Order.
3. Setiap kuantitas pada `AcceptedQty` telah berstatus definitif sebagai `DispensedQty` atau `UnfulfilledQty` (`AcceptedQty = DispensedQty + UnfulfilledQty`).
4. Seluruh Invoice yang terhubung dengan Sales Order telah memiliki disposisi finansial definitif yang dikonfirmasi oleh pihak yang berwenang (Tata Rekening / Kasir).
5. Keterlacakan dari permintaan asal, keputusan telaah, Sales Order, hingga Invoice dan penutupan komersial dapat diverifikasi secara utuh.

---

## 6. Outcome Boundary

### Start
Outcome dimulai ketika permintaan obat yang telah disetujui (*accepted medication demand*) — baik yang bersumber dari resep dokter yang telah menyelesaikan Telaah Resep (**OC-11-02**) maupun permintaan Jual Bebas / OTC yang telah disetujui Apotek — telah tersedia dan memenuhi seluruh gerbang bisnis (*Available Stock Gate*, *Payer Path Homogeneity Gate*, *Non-Empty Commitment Gate*, dan *Idempotency Gate*) untuk dibentuk menjadi Sales Order Apotek.

### End
Outcome berakhir ketika seluruh kuantitas komitmen (`AcceptedQty`) pada Sales Order telah memiliki disposisi komersial akhir yang definitif (`UnresolvedAcceptedQty = 0`) dan seluruh konsekuensi finansial dari Invoice terkait telah memiliki disposisi resmi dari pihak yang berwenang (Tata Rekening / Kasir), sehingga Sales Order berhasil mencapai status terminal yang sah (**Resolved** atau **Cancelled**) sesuai aturan siklus hidup komersial.

*Catatan Batasan:* Outcome End **tidak mencakup** penyerahan fisik obat kepada pasien (milik OC-11-05), pemotongan fisik buku inventori (milik Inventory Domain), maupun penutupan seluruh transaksi administrasi rumah sakit di kasir besar.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

1. **One Sales Order = Exactly One PayerPath:** Satu Sales Order dilarang memuat lebih dari satu jalur penjamin. Percampuran item beda penjamin dalam satu Sales Order adalah pelanggaran bisnis mutlak.
2. **Non-Empty Commitment Invariant:** Sales Order dilarang kosong; wajib memiliki minimal satu baris item dengan `AcceptedQty > 0`.
3. **Commitment Ceiling Invariant:** `AcceptedQty` menjadi plafon komitmen tertinggi setelah Sales Order berstatus *Established*. Seluruh kuantitas downstream (dispensing maupun penagihan) dilarang melebihi `AcceptedQty`.
4. **Invoice Quantity Boundary Invariant:** Kuantitas penagihan pada faktur tidak boleh melebihi kuantitas komitmen: `InvoiceQty <= SalesOrder.AcceptedQty`, dan secara kumulatif `Σ InvoiceQty per SalesOrderItem <= AcceptedQty`.
5. **Business Idempotency Invariant:** Permintaan yang telah diterima yang sama dilarang menghasilkan komitmen ganda. Pemrosesan berulang atas permintaan yang sama tidak boleh menerbitkan Sales Order duplikat.
6. **Full Traceability Invariant:** Setiap `SalesOrderItem` wajib dapat ditelusuri ke satu item permintaan asal dan keputusan telaah/penerimaan profesional yang menghasilkannya.
7. **Payer Split Reconciliation Invariant:** Pembagian Sales Order berdasarkan jalur penjamin dilarang menghilangkan, menggandakan, atau menyusupkan item yang ditolak. Seluruh accepted items wajib terwakili secara lengkap dan konsisten pada Sales Order hasil split.
8. **Immutability of AcceptedQty Invariant:** Nilai `AcceptedQty` dilarang diubah, ditulis ulang, atau ditimpa menjadi `DispensedQty`. Keduanya adalah fakta bisnis yang berbeda.
9. **Zero Unresolved Quantity Invariant:** Disposisi komersial akhir mensyaratkan `UnresolvedAcceptedQty = 0`. Sales Order dilarang mencapai status terminal jika masih terdapat kuantitas komitmen yang belum jelas disposisinya.
10. **Financial Resolution Prerequisite Invariant:** Sales Order dilarang mencapai status terminal (*Resolved* atau *Cancelled*) selama masih terdapat konsekuensi finansial dari Invoice terkait yang belum berdisposisi resmi dari Tata Rekening/Kasir.
11. **Resolved ≠ Fully Fulfilled Invariant:** Status *Resolved* mencerminkan selesainya siklus komersial secara tertib, bukan kewajiban terpenuhinya 100% kuantitas obat. Sales Order dapat berstatus *Resolved* meskipun sebagian atau seluruh obat tidak terpenuhi (`DispensedQty < AcceptedQty`).
12. **Resolved ≠ Paid Invariant:** Status *Resolved* pada Sales Order adalah fakta penutupan komersial Apotek, bukan sinonim tanda lunas kasir (*Paid*).
13. **Invoice ≠ Payment Invariant:** Invoice adalah penetapan komitmen finansial tagihan, bukan bukti pembayaran atau penerimaan kas.
14. **Sales Order ≠ Dispensing Invariant:** Sales Order adalah penetapan komitmen komersial dan operasional Apotek, bukan pelaksanaan pemenuhan fisik obat.
15. **Pricing Snapshot at Invoice Established Invariant:** Sales Order tidak mengunci harga. Penetapan komitmen finansial resmi terjadi saat *Invoice Established*. Nilai pada *Pricing Snapshot* kebal terhadap perubahan master tarif di masa mendatang.
16. **Available Stock Gate Invariant:** Kuantitas stok yang tersedia (*Available Stock*) menjadi penentu batas atas `AcceptedQty`. Kurangnya stok dari kuantitas yang diminta menghasilkan `ExcludedQty` pra-SO, bukan kegagalan pembuatan order.
17. **No Outpatient Backorder Invariant:** Pada pelayanan rawat jalan, kuantitas yang tidak dapat dipenuhi karena keterbatasan stok dikeluarkan dari pesanan penjualan (`ExcludedQty`) dan tidak diizinkan dicatat sebagai backorder maupun `UnfulfilledQty`.
18. **Immutability of PayerPath Invariant:** Properti `PayerPath` pada Sales Order bersifat permanen dan dilarang dimutasi ke jalur penjamin lain setelah Sales Order Established.
19. **Payer Split Independence Invariant:** Penolakan pasien terhadap Sales Order jalur bayar mandiri hasil split tidak membatalkan atau mengubah status Sales Order jalur BPJS dari resep yang sama.
20. **No Silent Financial Mutation Invariant:** Koreksi finansial terhadap tagihan historis dilarang dilakukan secara diam-diam. Setiap perubahan nilai tagihan wajib melalui mekanisme koreksi resmi yang terdokumentasi.

---

## 8. Business Exceptions

> Conditions under which the Outcome deviates from normal flow or cannot be established.

| Exception | Expected Behavior |
|-----------|-------------------|
| **Stok yang tersedia kurang dari kuantitas yang diminta (*Available Stock < RequestedQty*)** | Sales Order tetap dapat terbentuk dengan `AcceptedQty` sebesar stok yang tersedia. Selisih kuantitas menjadi `ExcludedQty` pra-SO. Pada pasien rawat jalan, sisa kuantitas tersebut tidak menjadi backorder dan dapat difasilitasi melalui penerbitan salinan resep sesuai aturan bisnis. |
| **Permintaan resep masih berstatus Belum Final / Sedang Ditelaah (*Under Review*)** | Sales Order tidak dapat terbentuk. Pembentukan Sales Order harus menunggu hingga seluruh item pada resep memiliki keputusan telaah final dari Apoteker (**OC-11-02**). |
| **Item resep berstatus Ditolak (*Rejected*) pada Telaah Resep** | Item yang ditolak dieksklusi secara mutlak dan dilarang dimasukkan ke dalam Sales Order. Jika seluruh item pada resep ditolak, tidak ada Sales Order yang terbentuk (*Non-Empty Commitment Gate*). |
| **Accepted demand memiliki lebih dari satu jalur penjamin (*Multi-Payer Split*)** | Payer split dieksekusi sebelum penetapan Sales Order: terbentuk Sales Order terpisah yang masing-masing homogen (`One Sales Order = One PayerPath`). Hasil split harus business-complete: tidak boleh ada accepted item yang tidak tercakup oleh Sales Order manapun. |
| **Pasien menolak Sales Order jalur bayar mandiri (*GeneralPatientPay*) hasil split** | `AcceptedQty` tetap tidak berubah. Sales Order jalur umum diproses menuju disposisi akhir yang sesuai (misalnya **Resolved** dengan alasan `PatientDeclined`, setelah konsekuensi finansial apapun terselesaikan). Sales Order jalur BPJS tetap aktif dan tidak terpengaruh. |
| **Pasien membatalkan/menolak sebagian obat setelah Sales Order Established (*Patient Declined Partial Fulfillment*)** | Nilai `AcceptedQty` tetap dipertahankan utuh. Kuantitas yang diambil dicatat sebagai `DispensedQty`, dan kuantitas yang ditolak dicatat sebagai `UnfulfilledQty` dengan alasan `PatientDeclined`. Sales Order dapat mencapai **Resolved** setelah seluruh konsekuensi finansial terkait memiliki disposisi resmi dari Tata Rekening/Kasir. |
| **Pasien tidak hadir mengambil obat hingga batas waktu terlampaui (*Collection Window Expired / No-Show*)** | Seluruh kuantitas komitmen berstatus `DispensedQty = 0` dan `UnfulfilledQty = AcceptedQty` dengan alasan `CollectionWindowExpired`. Sales Order dapat mencapai **Resolved** setelah seluruh konsekuensi finansial terkait memiliki disposisi resmi dari Tata Rekening/Kasir. |
| **Demand yang sama diproses ulang (*Duplicate Reprocessing Request*)** | Demand yang sama tidak boleh menghasilkan lebih dari satu accountable Sales Order commitment. Reprocessing atas demand yang sama mempertahankan commitment yang telah ada tanpa membentuk komitmen baru. |
| **Terjadi perubahan master tarif setelah Invoice Established** | Perubahan tarif master tidak berlaku terhadap Invoice yang sudah terbentuk. Pricing Snapshot pada Invoice tersebut tetap merepresentasikan komitmen finansial saat Invoice Established. |
| **Permintaan pembatalan total atas Sales Order dengan Invoice yang sudah aktif** | Sales Order tidak dapat mencapai status terminal **Cancelled** sebelum konsekuensi finansial dari Invoice terkait memiliki disposisi resmi dari Tata Rekening/Kasir. Setelah disposisi finansial resmi diterima, Sales Order dapat mencapai status **Cancelled**. |
| **Kuantitas fisik yang berhasil disiapkan kurang dari komitmen (*Dispensing Shortage*)** | Bagian yang berhasil disiapkan dicatat sebagai `DispensedQty`, dan selisihnya dicatat sebagai `UnfulfilledQty`. Nilai `AcceptedQty` tidak boleh diubah. Sales Order dapat mencapai disposisi akhir setelah penyesuaian finansial atas kuantitas riil diselesaikan secara resmi. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|-----------|-----------|
| **AC-01** | Sales Order hanya dapat terbentuk dari permintaan yang telah disetujui secara sah (*accepted medication demand*), baik resep yang telah tuntas ditelaah maupun OTC yang disetujui Apotek. | Completeness |
| **AC-02** | Permintaan resep yang masih berstatus *Under Review* / *Sedang Ditelaah* tidak dapat diproses dan tidak menghasilkan Sales Order. | Constraint |
| **AC-03** | Item resep yang berstatus *Rejected* (Ditolak) pada Telaah Resep tidak dapat dimasukkan ke dalam baris item Sales Order. | Constraint |
| **AC-04** | Kuantitas stok yang tersedia (*Available Stock*) menjadi batas penentu `AcceptedQty`, di mana keterbatasan stok menghasilkan `AcceptedQty < RequestedQty` dan selisihnya dicatat sebagai `ExcludedQty` tanpa menggagalkan pembentukan order. | Correctness |
| **AC-05** | Pada pelayanan rawat jalan, `ExcludedQty` pra-SO tidak dicatat sebagai backorder maupun `UnfulfilledQty`, dan dapat difasilitasi melalui penerbitan salinan resep. | Constraint |
| **AC-06** | Permintaan yang memiliki campuran jalur penjamin menghasilkan Sales Order terpisah yang masing-masing homogen (`One Sales Order = One PayerPath`) dan terbentuk secara business-complete: tidak ada accepted item yang tidak tercakup oleh Sales Order manapun. | Completeness |
| **AC-07** | Setiap Sales Order memiliki tepat satu `PayerPath` yang bersifat *immutable* dan tidak dapat diubah ke jalur penjamin lain setelah berstatus *Established*. | Constraint |
| **AC-08** | Pemrosesan ulang (*reprocessing*) atas permintaan yang sama tidak menghasilkan duplikasi Sales Order, melainkan merujuk pada komitmen akuntabel yang telah ada (*Business Idempotency*). | Constraint |
| **AC-09** | Setiap `SalesOrderItem` dapat ditelusuri dan direkonsiliasi secara penuh ke baris permintaan asal dan keputusan telaah/penerimaan profesional yang mendasarinya. | Completeness |
| **AC-10** | Nilai `AcceptedQty` tidak berubah atau ditimpa menjadi `DispensedQty` selama maupun setelah pelaksanaan pemenuhan fisik obat. | Constraint |
| **AC-11** | Kuantitas penagihan pada Invoice (`InvoiceQty`) tidak melebihi `AcceptedQty`, baik per baris item maupun secara kumulatif untuk seluruh faktur terkait. | Constraint |
| **AC-12** | Nilai harga, diskon, tuslah, dan total pada *Pricing Snapshot* merepresentasikan komitmen finansial saat *Invoice Established* dan tidak terpengaruh oleh perubahan harga master setelahnya. | Correctness |
| **AC-13** | Sales Order dapat mencapai status terminal **Resolved** meskipun `DispensedQty < AcceptedQty` (termasuk kondisi `DispensedQty = 0` akibat *no-show* atau penolakan pasien), selama `UnresolvedAcceptedQty = 0` dan seluruh konsekuensi finansial telah tuntas secara resmi. | Correctness |
| **AC-14** | Sales Order tidak dapat bertransisi ke status terminal (**Resolved** maupun **Cancelled**) selama masih terdapat `UnresolvedAcceptedQty > 0` atau konsekuensi finansial Invoice yang belum berdisposisi resmi. | Constraint |
| **AC-15** | Status **Resolved** pada Sales Order tidak digunakan atau disamakan maknanya dengan status **Paid** (Lunas) maupun **Fully Fulfilled** (Terpenuhi Penuh). | Correctness |
| **AC-16** | Pembatalan Sales Order yang telah memiliki Invoice aktif hanya dapat mencapai status terminal **Cancelled** setelah Invoice terkait memperoleh penyelesaian/pembatalan resmi dari Tata Rekening/Kasir. | Exception |
| **AC-17** | Penolakan pasien atas Sales Order jalur bayar mandiri hasil *payer split* tidak membatalkan atau mengubah status Sales Order jalur BPJS dari resep yang sama. | Exception |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- **Telaah Klinis & Pengkajian Farmasi Resep Dokter:** Pemeriksaan dosis, kontraindikasi klinis, interaksi obat, dan persetujuan substitusi obat → **OC-11-02 Telaah Resep** (`APT-TELAAH`).
- **Penyiapan & Peracikan Fisik Obat:** Pengambilan fisik obat dari rak, peracikan puyer/kapsul/salep, pembuatan etiket obat, dan pengemasan sediaan farmasi → **OC-11-04 Dispensing** (`APT-DISPENSING`).
- **Penyerahan Obat & Edukasi Pasien:** Pemanggilan antrian penyerahan, verifikasi identitas penerima obat, dan pemberian Komunikasi, Informasi, dan Edukasi (KIE) obat → **OC-11-05 Serah Obat** (`APT-SERAH`).
- **Pencatatan Kartu Stok & Mutasi Fisik:** Pengurangan saldo buku stok fisik farmasi, mutasi antar depo, dan penyesuaian kartu stok persediaan → **Inventory Domain** (`INV-STOK`, `INV-MUTASI`, OC-11-07).
- **Penghitungan Stok Fisik Apotek:** Pelaksanaan stok opname dan rekonsiliasi selisih fisik persediaan → **OC-11-06 Opname** (`INV-OPNAME`).
- **Penerimaan Pembayaran Kasir:** Eksekusi fisik penerimaan uang tunai, gesek kartu debit/kredit, QRIS, dan pencetakan kuitansi pembayaran kasir → **OC-03-01 Kasir** (`KSR-TERIMA-KAS`, `TRK-PAYMENT`).
- **Pengembalian Dana Kas / Refund / Credit Note:** Tata cara pengeluaran fisik kas untuk refund kelebihan bayar atau penerbitan nota kredit keuangan rumah sakit → **OC-03-01 Kasir** (`KSR-KELUAR-KAS`) dan **Tata Rekening** (`TRK-BILLING`).
- **Penutupan Shift Kasir:** Rekonsiliasi fisik uang kas dan penutupan buku shift loket kasir → **OC-03-02 Closing Shift** (`KSR-SHIFT`).
- **Pengelolaan Regulasi Jaminan Eksternal:** Penetapan keabsahan kepesertaan BPJS, pengesahan SEP, kaidah restriksi Fornas, dan pengajuan berkas klaim rumah sakit → **OC-01-04 VCLAIM BPJS** (`BPJ-VCLAIM`), **Casemix/Coding** (`BRM-CODING`), dan domain penjaminan eksternal.
- **Rancangan Teknis dan Antarmuka Sistem:** Definisi skema tabel basis data, struktur kolom, indeks, perancangan antarmuka visual (UI wireframe / mockup), tata letak layar, kontrak teknis endpoint API, maupun prosedur operasional standar (SOP) internal staf.
