# OUTCOME: Penjualan

| Field       | Value        |
|-------------|--------------|
| Code        | OC-APT-PENJUALAN |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-10   |

---

## 1. Business Purpose

Setiap penyediaan obat, bahan medis habis pakai (BMHP), dan jasa kefarmasian kepada pasien rumah sakit harus dipertanggungjawabkan secara komersial dan finansial sebagai *persisted business fact*. Keberadaan outcome **Penjualan** memastikan bahwa setiap permintaan obat yang telah disetujui (baik bersumber dari telaah resep dokter maupun penjualan obat bebas/OTC) dibukukan ke dalam pesanan penjualan farmasi (*Sales Order*), dihitung nilai kewajiban keuangannya berdasarkan harga katalog dan aturan tarif yang berlaku, diklasifikasikan penjaminannya, serta diterbitkan dokumen tagihan penjualannya (*Sales Bill / Invoice*).

Dokumen tagihan penjualan farmasi bertindak sebagai sumber pembebanan biaya (*Charge Source*) resmi ke dalam rekening tagihan pasien di domain Tata Rekening (`TRK-BILLING`). Dengan memisahkan siklus penagihan komersial (*Sales Bill*) dari siklus penyiapan fisik barang (*Dispensing*), rumah sakit mampu mengakomodasi penagihan terpisah, pemenuhan parsial (*partial fulfillment*), verifikasi penjaminan berlapis (Umum, BPJS Kesehatan, Asuransi Swasta), serta perlakuan akuntansi yang tertib atas retur dan pembatalan tanpa mengacaukan integritas fisik pergerakan obat.

---

## 2. Outcome Statement

Transaksi penjualan obat dan BMHP farmasi **telah terbentuk secara akuntabel dari pesanan penjualan yang disetujui (`SalesOrder`), mencatat rincian tagihan beserta komponen biaya terkait (`Invoice`), dan terhubung sebagai sumber pembebanan finansial di Tata Rekening**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Apotek** (Primary Owner) | Mengelola penetapan pesanan penjualan farmasi (`APT-ORDER`), pembentukan tagihan komersial penjualan (`APT-BILL`), pencatatan snapshot harga, klasifikasi penjamin, pemisahan pesanan campuran (*mixed-payer split*), serta penyesuaian penjualan farmasi. |
| **Tata Rekening** | Menyediakan master tarif dan aturan harga jual obat (`TRK-TARIF`), menerima pembebanan tagihan farmasi ke akun pasien (`TRK-BILLING`), mengelola pelunasan pembayaran kasir (`TRK-KASIR` / `TRK-PAYMENT`), serta menentukan izin mutabilitas tagihan (*Invoice Mutability Permission*) dan penerbitan Nota Kredit/Refund (`ADR-APT-003`). |
| **Pasien** | Menyediakan data identitas pasien dan nomor rekam medis (`PAS-DATSOS`) sebagai subjek tagihan. |
| **BPJS** | Menyediakan bukti keabsahan penjaminan BPJS berupa Surat Eligibilitas Peserta (`BPJ-VCLAIM`) dan aturan restriksi Fornas untuk penetapan tagihan klaim. |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `APT-BILL` Sales Bill | Apotek | Known |
| `APT-ORDER` Sales Order | Apotek | Known |
| `TRK-BILLING` Billing | Tata Rekening | Known |
| `TRK-TARIF` Tariff | Tata Rekening | Known |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known |
| `BPJ-VCLAIM` VClaim | BPJS | Known |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Pesanan penjualan farmasi (`SalesOrder`) telah terbentuk dan disahkan dari item-item resep yang disetujui pada telaah resep (`OC-APT-TELAAH-RESEP`) atau dari permintaan obat bebas yang diterima (`JualBebas`).
- Dokumen tagihan komersial penjualan farmasi (`Invoice` / *Sales Bill*) telah diterbitkan dan mengaitkan item-itemnya (*Invoice Items*) langsung ke item pesanan penjualan (*Sales Order Items*).
- Setiap baris tagihan farmasi mencatat kuantitas yang ditagih, harga satuan dari snapshot tarif yang mengikat, diskon (jika ada), serta biaya jasa item seperti kemasan atau biaya racik (*item-level charges*).
- Penyesuaian nilai komersial tingkat transaksi (seperti pembulatan nilai rupiah) telah dicatat pada header tagihan (*header-level attribute*).
- Pembebanan biaya farmasi telah terkirim dan tercatat sebagai *Financial Charge* yang sah di akun billing pasien pada domain Tata Rekening (`TRK-BILLING`).
- Klasifikasi penjamin (Pasien Umum/Self-pay, BPJS Kesehatan, atau Asuransi Kerjasama) telah ditentukan dan terverifikasi kelayakannya.

### 5.2 Required Recorded Information

- Nomor unik dokumen Invoice Penjualan (`InvoiceId`) dan nomor unik Sales Order (`SalesOrderId`).
- Nomor rekam medis pasien (`PasienId`) dan nama pasien.
- Nomor registrasi kunjungan aktif (`RegistrasiId`) untuk pasien terdaftar, atau penanda transaksi umum untuk non-kunjungan.
- Klasifikasi penjaminan (*Payer Category*): Pasien Umum / BPJS Kesehatan / Asuransi Perusahaan.
- Rincian item tagihan (*Invoice Items*):
  - Referensi *Sales Order Item*.
  - Kode dan deskripsi obat atau BMHP (merujuk katalog resmi).
  - Kuantitas yang ditagih.
  - Snapshot harga satuan (*Pricing Snapshot*) pada saat invoice dibuat.
  - Nilai kotor (*Gross Amount*), potongan harga (*Discount*), dan nilai bersih (*Net Amount*).
  - Biaya jasa peracikan / tuslah / embalase (*Item-level Charges*).
- Atribut komersial header tagihan: subtotal, total biaya racik, nilai pembulatan (*Rounding*), dan total akhir tagihan (*Grand Total*).
- Status siklus hidup tagihan: `Established`, `Issued`, `Financially Cleared`, `Adjusted or Credited`, `Resolved`, atau `Cancelled`.
- Timestamp penerbitan invoice dan identitas staf farmasi yang menerbitkan.
- Tautan referensi transaksi billing ke Tata Rekening (`TRK-BILLING`).

### 5.3 Required Business Conditions

- **Penurunan Wajib dari Sales Order**: Setiap baris tagihan obat atau BMHP wajib berasal dari item pesanan penjualan farmasi (`SalesOrder`). Staf farmasi dilarang memasukkan baris tagihan obat bebas (*free-form lines*) tanpa dokumen `SalesOrder` yang mendasarinya.
- **Waktu Penerbitan Berdasarkan Penjamin**:
  - **Pasien Umum (Self-pay)**: Tagihan diterbitkan setelah staf mengomunikasikan rincian biaya dan memperoleh konfirmasi pembelian (*Purchase Confirmation*) verbal dari pasien/keluarga, sebelum peracikan/penyiapan obat dilakukan.
  - **Pasien BPJS Kesehatan**: Tagihan BPJS diterbitkan bersamaan dengan penyerahan obat fisik yang sukses (*Medication Handover*), di mana kewajiban bayar pasien adalah nol dan tagihan dibebankan ke penjamin BPJS.
- **Pemisahan Tagihan Campuran (Mixed-Payer Split)**: Untuk resep pasien BPJS yang mengandung obat yang tidak dijamin oleh Fornas (*Not Covered*), item tidak dijamin tersebut tidak boleh dimasukkan ke dalam klaim BPJS, melainkan dibentuk menjadi `SalesOrder` dan `Invoice` mandiri berkategori Pasien Umum atas persetujuan pasien.
- **Tata Kelola Mutabilitas Tagihan (`ADR-APT-003`)**:
  - Tagihan farmasi yang berstatus `Issued` atau `Financially Cleared` **tidak otomatis beku (*not immutable*)**.
  - Koreksi tagihan farmasi dilakukan dengan merevisi dokumen invoice yang sama selama izin mutabilitas dari Tata Rekening masih terbuka.
  - Apabila Tata Rekening telah mengunci periode tagihan (misal: billing telah *Finalize*, *Close*, atau *Lunas*), Apotek **tidak boleh menerbitkan Nota Kredit (*Credit Note*) lokal sendiri**. Mekanisme koreksi diserahkan sepenuhnya ke Tata Rekening untuk menerbitkan Nota Kredit resmi, Refund, atau Financial Adjustment.
- **Independensi dari Fisik Obat**: Keberadaan tagihan yang berstatus lunas (*Financially Cleared*) tidak menjadi jaminan mutlak bahwa penyerahan fisik obat pasti berhasil (misal: terjadi kerusakan sediaan mendadak atau pasien tidak mengambil obat / *No-Show*).

### 5.4 Completion Proof

- Dokumen Invoice Penjualan tersimpan permanen dengan nomor invoice unik.
- Data pembebanan biaya farmasi muncul dan terakumulasi dalam rekapitulasi rekening tagihan pasien di domain Tata Rekening (`TRK-BILLING`).
- Item tagihan mencatat status penagihan yang telah terhubung ke pemenuhan fisik di `SalesOrder`.

---

## 6. Outcome Boundary

### Start

Dimulai ketika pesanan penjualan farmasi (`SalesOrder`) telah disahkan dari hasil telaah resep atau persetujuan penjualan obat bebas, dan staf farmasi memulai pembentukan transaksi komersial penjualan dengan menghitung nilai tagihan sesuai tarif yang berlaku.

### End

Berakhir ketika:
1. Invoice penjualan diterbitkan (*Issued*), dibebankan ke Tata Rekening, dan mencapai penyelesaian finansial (*Financially Cleared* / *Resolved*) melalui pelunasan kasir atau penjaminan BPJS; **atau**
2. Tagihan dibatalkan secara sah (*Cancelled*) sebelum peracikan dimulai karena pasien membatalkan pembelian obat; **atau**
3. Tagihan disesuaikan melalui koreksi resmi (*Adjusted or Credited*) sesuai otorisasi Tata Rekening.

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Nilai harga satuan pada invoice mengikat sejak saat invoice diterbitkan (*immutable pricing snapshot*), tidak berubah meskipun terdapat perubahan master tarif di kemudian hari.
- Bahan Medis Habis Pakai (BMHP) harus diperlakukan sebagai item katalog standar, bukan komponen biaya bebas tanpa identitas barang.
- Biaya kemasan dan peracikan dicatat sebagai biaya melekat pada item obat (*item-level charges*), sedangkan pembulatan dicatat pada atribut header invoice.
- Kuantitas yang ditagihkan pada invoice tidak boleh melebihi kuantitas yang disetujui pada `SalesOrder`.
- Pembatalan transaksi penjualan yang telah dibayar kasir wajib melibatkan Domain Tata Rekening untuk pengembalian dana (*Refund*) yang sah.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception | Expected Behavior |
|---|---|
| Pasien Umum menolak konfirmasi harga sebelum invoice terbit | Dokumen invoice tidak diterbitkan. Sisa item pada pesanan farmasi dibatalkan atau disesuaikan. Salinan resep (*Copy Resep*) diterbitkan untuk item yang tidak dibeli. |
| Kepesertaan BPJS tidak valid atau Surat Eligibilitas Peserta (SEP) ditolak | Item resep tidak dapat ditagihkan sebagai klaim BPJS. Staf farmasi mengonfirmasi kepada pasien untuk dialihkan ke jalur pembayaran Pasien Umum atau menyelesaikan permasalahan kepesertaan di loket admisi. |
| Koreksi tagihan diperlukan namun Tata Rekening telah mengunci invoice | Apotek tidak dapat merevisi invoice secara langsung. Apotek mengajukan permohonan koreksi finansial ke Tata Rekening agar diterbitkan Nota Kredit atau penyesuaian billing resmi. |
| Terjadi ketidaksesuaian stok fisik setelah pasien umum melunasi pembayaran | Apotek mencatat hasil ketidaksesuaian (*Unfulfilled Outcome*), menerbitkan Copy Resep untuk sisa kuantitas, dan mengirimkan permintaan koreksi nilai tagihan/refund ke Tata Rekening sesuai `ADR-APT-003`. |
| Pasien tidak mengambil obat setelah pembayaran lunas (*General Patient No-Show*) | Invoice tidak dihapus. Obat dikembalikan ke stok inventori melalui resolusi No-Show farmasi, dan tindak lanjut finansial (pengembalian dana atau penyimpanan deposit pasien) diproses di Tata Rekening. |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Dokumen Invoice Penjualan berhasil diterbitkan dengan nomor unik dan terhubung ke dokumen `SalesOrder` yang sah. | Completeness |
| AC-02 | Setiap baris tagihan obat atau BMHP berasal dari baris pesanan `SalesOrder` dan mencatat kuantitas serta harga satuan yang valid. | Correctness |
| AC-03 | Biaya peracikan dan kemasan tercatat sebagai *item-level charge* dan pembulatan tercatat pada header invoice. | Correctness |
| AC-04 | Pembebanan biaya farmasi berhasil terkirim dan tercatat pada rekening tagihan pasien di domain Tata Rekening (`TRK-BILLING`). | Completeness |
| AC-05 | Untuk Pasien Umum, invoice diterbitkan sebelum peracikan obat dimulai berdasarkan konfirmasi pembelian pasien. | Correctness |
| AC-06 | Untuk Pasien BPJS, invoice diterbitkan pada saat penyerahan obat berhasil dilakukan dengan nilai tagihan pasien nihil. | Correctness |
| AC-07 | Resep campuran (Fornas dan Non-Fornas) secara otomatis terpisah menjadi pesanan BPJS dan pesanan Pasien Umum yang independen. | Constraint |
| AC-08 | Revisi invoice dilakukan pada dokumen yang sama selama izin mutabilitas Tata Rekening masih terbuka (`ADR-APT-003`). | Constraint |
| AC-09 | Sistem melarang pembuatan entri Nota Kredit (*Credit Note*) lokal di dalam tabel Apotek saat invoice terkunci oleh Tata Rekening. | Constraint |
| AC-10 | Rincian nilai tagihan farmasi tetap konsisten dan tidak terpengaruh oleh perubahan master tarif obat di masa mendatang. | Correctness |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Penerimaan uang tunai, gesek kartu debit/kredit, dan penerbitan kuitansi kasir → **`OC-TRK-KASIR` (Kasir)** dan **`OC-TRK-ALOKASI-PEMBAYARAN` (AlokasiPembayaran)**.
- Penutupan kas harian kasir → **`OC-TRK-CLOSING-SHIFT` (ClosingShift)**.
- Pengajuan dan rekonsiliasi klaim INA-CBGs BPJS ke verifikator BPJS → **`OC-BPJ-EKLAIM` (Eklaim)**.
- Penyiapan fisik, peracikan obat, dan serah obat fisik ke pasien → **`OC-APT-ORDER-DISPENSING` (OrderDispensing)**.
- Penelaahan klinis resep oleh Apoteker → **`OC-APT-TELAAH-RESEP` (TelaahResep)**.
- Pengelolaan master tarif rumah sakit → **Tata Rekening Domain (`TRK-TARIF`)**.
