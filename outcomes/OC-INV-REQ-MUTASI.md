# OUTCOME: Permintaan Mutasi Stok (ReqMutasi)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-REQ-MUTASI      |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Unit-unit operasional dan pelayanan di rumah sakit (seperti Poliklinik Rawat Jalan, Bangsal Rawat Inap, IGD, Kamar Operasi, Laboratorium, dan Radiologi) membutuhkan pasokan perbekalan persediaan fisik yang siap pakai di lokasi (*floor stock*) untuk menunjang kelancaran tindakan medis dan perawatan pasien.

Untuk memenuhi dan menjaga ketersediaan stok tersebut, unit pelayanan secara teratur maupun insidental mengajukan permohonan transfer persediaan dari gudang induk rumah sakit (seperti Gudang Farmasi Pusat atau Gudang Logistik Umum) atau dari depo lain. Dokumen Permintaan Mutasi Stok (*ReqMutasi*) berfungsi sebagai instrumen formal untuk mencatat niat, justifikasi, dan rincian kebutuhan barang yang diminta oleh unit pemohon kepada unit penyedia yang berwenang.

Tanpa pencatatan permintaan mutasi yang terstruktur dan disetujui oleh penanggung jawab unit, distribusi persediaan internal akan berlangsung tanpa kendali otorisasi, rawan permintaan berlebih (*overstock*) di unit pelayanan, serta menyulitkan gudang induk dalam merencanakan prioritas pengeluaran dan distribusi logistik harian.

---

## 2. Outcome Statement

Permintaan resmi pemindahan stok internal rumah sakit dari unit pemohon kepada satu unit penyedia tertentu (mencakup rincian item barang, satuan, dan kuantitas yang diminta) **telah diajukan, disetujui oleh Kepala Unit Pemohon, tercatat persisten tanpa memotong saldo fisik persediaan, dan siap diproses dalam antrean pemenuhan unit penyedia**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** | Pemilik utama: mencatat transaksi permintaan mutasi stok (`INV-MUTASI` Tahap 1), memvalidasi katalog master barang (`INV-MASTER`), serta menyediakan informasi saldo sisa di unit pemohon (`INV-STOK`). |
| **Organisasi** | Menyediakan data struktur unit kerja pemohon dan unit kerja penyedia yang sah dan aktif (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> *Catatan: Data saldo stok unit penyedia maupun pemohon dibaca sebagai referensi informatif saat pengajuan/persetujuan tanpa mengubah maupun mengunci (reserve) saldo fisik persediaan.*

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Permintaan Mutasi Stok (*Stock Transfer Request*) telah tercatat secara persisten dengan nomor identifikasi unik.
- Dokumen memuat fakta bisnis murni berupa **kebutuhan/permintaan barang (*demand*)**, dan secara tegas **tidak memotong maupun mengunci (*hard-reserve*) saldo fisik stok** di unit penyedia maupun unit pemohon.
- Dokumen ditujukan secara spesifik kepada tepat satu unit/gudang penyedia yang berwenang untuk komoditas barang yang diminta.
- Dokumen telah mendapatkan penelaahan dan persetujuan resmi dari Kepala Unit / Penanggung Jawab Ruangan pemohon.
- Dokumen siap diakses secara *real-time* oleh unit penyedia sebagai dasar penerbitan pengeluaran fisik barang pada Outcome `Mutasi` (`OC-INV-MUTASI`).
- Status siklus hidup dokumen terdefinisi secara jelas: **Draft**, **Disetujui (Approved)**, **Diproses Sebagian (Partially Fulfilled)**, **Selesai (Completed)**, **Ditutup Manual (Force Closed)**, atau **Dibatalkan (Cancelled)**.

### 5.2 Required Recorded Information

- Nomor referensi unik dokumen permintaan mutasi (format penomoran standar permintaan mutasi internal).
- Identitas unit pemohon (ID & nama unit layanan/ruangan, misal: IGD, Bangsal Teratai, Depo Farmasi Rawat Jalan).
- Identitas unit penyedia yang dituju (ID & nama gudang/depo, misal: Gudang Farmasi Pusat, Gudang Logistik Umum).
- Tanggal dan waktu pembuatan draf permintaan.
- Tanggal dan waktu pengesahan/persetujuan oleh Kepala Unit.
- Identitas staf pemohon (*requester*) dan identitas pejabat penyetuju (*approver* / Kepala Unit).
- Tingkat urgensi / prioritas permintaan:
  - **Rutin**: Pengisian berkala floor stock terjadwal.
  - **Cito / Mendesak**: Kebutuhan insidental segera untuk penanganan pasien/tindakan medis.
- Catatan / justifikasi kebutuhan operasional (opsional).
- Rincian item barang yang diminta:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang (*Unit of Measure*).
  - Kuantitas yang diminta (`Qty Permintaan`) — bernilai \(\gt 0\).
  - Kuantitas saldo berjalan di unit pemohon saat pengajuan (sebagai referensi verifikasi kewajaran).
  - Kuantitas yang telah dipenuhi / dikirim (`Qty Terpenuhi` — bertambah secara progresif oleh Outcome `Mutasi`).
  - Sisa kuantitas permintaan (*backorder*).
- Status dokumen permintaan mutasi.

### 5.3 Required Business Conditions

- Unit pemohon dan unit penyedia harus terdaftar aktif dalam struktur organisasi rumah sakit (`ORG-LAYANAN`) dan **tidak boleh identik** (Unit Pemohon \(\ne\) Unit Penyedia).
- Setiap dokumen `ReqMutasi` ditujukan kepada tepat satu unit penyedia; komoditas barang yang diminta harus selaras dengan lingkup wewenang persediaan unit penyedia tersebut (misal: obat/alkes ke Gudang Farmasi, perlengkapan umum/ATK ke Gudang Logistik Umum).
- Barang yang diminta harus berstatus aktif dalam katalog master barang (`INV-MASTER`).
- Nilai `Qty Permintaan` untuk setiap baris item harus berupa bilangan positif (\(\gt 0\)).
- Keberadaan dokumen `ReqMutasi` yang disetujui tidak boleh mempengaruhi nilai saldo fisik persediaan di kartu stok manapun sampai transaksi `Mutasi` disahkan.

### 5.4 Completion Proof

- Dokumen `ReqMutasi` tersimpan secara persisten dengan nomor unik.
- Status dokumen bernilai **Disetujui (Approved)**.
- Dokumen tampil dalam antrean daftar permintaan (*fulfillment queue*) pada unit/gudang penyedia terkait dan dapat ditarik untuk pemenuhan fisik melalui Outcome `Mutasi` (`OC-INV-MUTASI`).

---

## 6. Outcome Boundary

### Start

Dimulai ketika staf atau petugas di unit pemohon membuat draf usulan permintaan mutasi persediaan, menentukan unit penyedia yang dituju, memilih item barang yang dibutuhkan, serta menetapkan kuantitas permintaan.

### End

Berakhir ketika dokumen permintaan mutasi telah diperiksa dan secara resmi disetujui oleh Kepala Unit / Penanggung Jawab Ruangan pemohon (**Approved by Unit Head**), tersimpan secara persisten dengan nomor registrasi unik, serta telah tersedia dalam antrean pemenuhan unit penyedia.

> *Catatan: Pemrosesan fisik barang, pemotongan stok gudang, dan pengiriman barang ke unit pemohon merupakan tanggung jawab Outcome downstream `Mutasi` (`OC-INV-MUTASI`).*

---

## 7. Business Constraints

1. **Pure Demand Fact**: `ReqMutasi` semata-mata merepresentasikan catatan kebutuhan/permintaan operasional dan tidak mengikat alokasi stok fisik atau mengubah saldo persediaan di unit manapun.
2. **Single Supplying Unit per Document**: Satu dokumen `ReqMutasi` hanya boleh ditujukan ke satu unit penyedia tertentu guna menjamin kejelasan akuntabilitas antrean pemenuhan di tingkat gudang.
3. **Mandatory Unit Authorization**: Dokumen draf tidak akan muncul dalam antrean kerja unit penyedia sebelum diverifikasi dan disahkan oleh pejabat berwenang di unit pemohon (Kepala Unit/Ruangan).
4. **Progressive Multi-Dispatch Support**: Satu dokumen `ReqMutasi` dapat dipenuhi melalui satu atau beberapa transaksi pengeluaran `Mutasi` terpisah (pengiriman bertahap/parsial) hingga total kuantitas terpenuhi atau ditutup.
5. **Force Close Capability**: Jika sisa kuantitas yang belum terpenuhi tidak dapat disediakan oleh unit penyedia (misal: stok kosong/gangguan suplai distributor) atau unit pemohon sudah tidak memerlukan lagi, dokumen dapat ditutup secara manual (*Force Closed*) untuk membatalkan sisa antrean tanpa menggantung.
6. **Strict Full-Cancellation Rule**: Pembatalan penuh dokumen `ReqMutasi` hanya diperkenankan apabila belum ada satupun transaksi `Mutasi` yang diterbitkan terhadap dokumen tersebut.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Unit pemohon dan unit penyedia yang dipilih sama | Sistem menolak penyimpanan dokumen karena pemindahan stok harus melibatkan dua lokasi persediaan yang berbeda. |
| Item barang dalam katalog berstatus tidak aktif atau diblokir | Sistem menolak penambahan item tersebut ke dalam rincian permintaan mutasi. |
| Pembatalan diajukan saat sebagian barang telah dikirim via `Mutasi` | Sistem menolak pembatalan penuh; unit diarahkan untuk menggunakan mekanisme *Force Close* guna menutup sisa kuantitas yang belum terkirim. |
| Kuantitas permintaan bernilai 0 atau negatif | Sistem menolak penyimpanan baris rincian barang. |
| Unit penyedia tidak memiliki stok fisik saat hendak memproses | Dokumen `ReqMutasi` tetap sah dan berstatus *Approved*; unit penyedia dapat menunda pengeluaran, melakukan pemenuhan parsial, atau berkoordinasi untuk pengadaan eksternal baru via Purchasing. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Staf unit pemohon berhasil membuat draf permintaan mutasi dengan memilih unit penyedia, memasukkan item barang aktif, kuantitas permintaan, dan tingkat prioritas (Rutin/Cito). | Completeness |
| AC-02 | Kepala Unit Pemohon dapat menelaah, mengoreksi, dan menyetujui dokumen sehingga status berubah menjadi `Approved`. | Correctness |
| AC-03 | Dokumen berstatus `Approved` langsung muncul dalam antrean pemenuhan unit penyedia tanpa mengubah saldo fisik stok persediaan di kedua unit. | Completeness |
| AC-04 | Sistem menolak pembuatan dokumen jika unit pemohon identik dengan unit penyedia. | Constraint |
| AC-05 | Sistem mendukung pemenuhan progresif (parsial) oleh transaksi `Mutasi`, memperbarui akumulasi `Qty Terpenuhi` dan sisa *backorder*. | Correctness |
| AC-06 | Sistem mengizinkan penutupan paksa (*Force Close*) pada dokumen yang memiliki sisa kuantitas permintaan belum terpenuhi, menandai dokumen sebagai selesai tanpa menggantung di antrean. | Correctness |
| AC-07 | Sistem menolak pembatalan penuh (*Cancel*) pada dokumen `ReqMutasi` yang telah memiliki riwayat pengeluaran `Mutasi`. | Exception |

---

## 10. Out of Scope

- **Pengeluaran Fisik dan Pengurangan Stok Asal**: Pencatatan fisik barang yang dikeluarkan dari gudang penyedia merupakan tanggung jawab Outcome `Mutasi` (`OC-INV-MUTASI`).
- **Penerimaan Fisik Barang di Unit Pemohon**: Penerimaan barang, verifikasi kesesuaian fisik, dan penambahan saldo di unit pemohon merupakan tanggung jawab Outcome `TerimaMutasi` (`OC-INV-TERIMA-MUTASI`).
- **Kompilasi Pengadaan Eksternal ke Vendor**: Pengumpulan kebutuhan berkala rumah sakit untuk pembelian ke vendor pihak ketiga merupakan tanggung jawab `MaterialReq` (`OC-PUR-MATERIAL-REQ`) dan `PurchaseReq` (`OC-PUR-PURCHASE-REQ`) pada Domain Purchasing.
- **Konsumsi Pemakaian Barang**: Pencatatan konsumsi barang oleh pasien atau unit operasional merupakan tanggung jawab Outcome `PakaiBrg` (`INV-PAKAI`).
