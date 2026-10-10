# OUTCOME: Penerimaan Mutasi Stok (TerimaMutasi)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-INV-TERIMA-MUTASI   |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Pengiriman barang logistik dan perbekalan medis antar-lokasi persediaan di rumah sakit memerlukan titik verifikasi fisik akhir di lokasi penerima sebelum barang tersebut diakui secara sah menjadi saldo stok aktif yang siap digunakan (*usable on-hand stock*).

Dokumen Penerimaan Mutasi Stok (*TerimaMutasi*) berfungsi memformalkan fakta bisnis bahwa barang yang dikirimkan oleh unit asal (berstatus *In-Transit*) telah tiba secara fisik, dihitung jumlahnya, diperiksa integritas kemasannya, serta dicocokkan atribut penelusuran mutunya (seperti Nomor Batch/Lot dan Tanggal Kedaluwarsa untuk komoditas medis/farmasi) oleh petugas di unit tujuan.

Tanpa pencatatan penerimaan mutasi yang mandiri dan terverifikasi, barang dalam perjalanan tidak dapat dipertanggungjawabkan titik serah-terimanya, perselisihan atas barang hilang atau rusak selama proses distribusi fisik tidak dapat dilacak penanggung jawabnya, dan risiko pencatatan stok fiktif di unit pelayanan akan meningkat drastis.

---

## 2. Outcome Statement

Penerimaan fisik barang hasil mutasi di lokasi persediaan tujuan (mencakup verifikasi kuantitas, pencatatan kondisi fisik/selisih, serta konfirmasi batch dan tanggal kedaluwarsa) **telah disahkan, saldo stok fisik unit tujuan bertambah sebesar kuantitas yang diterima baik, status persediaan dalam perjalanan (In-Transit) resmi ditutup, dan status dokumen Mutasi asal diperbarui menjadi Diterima atau Diterima dengan Selisih**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| **Inventory** | Pemilik utama: mencatat transaksi penerimaan mutasi (`INV-MUTASI` Tahap 3), menambah saldo stok fisik unit tujuan dan menutup status *In-Transit* (`INV-STOK`), serta memvalidasi katalog master barang (`INV-MASTER`). |
| **Organisasi** | Menyediakan data struktur unit kerja penerima dan unit pengirim yang sah dan aktif (`ORG-LAYANAN`). |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `INV-MUTASI` Mutasi | Inventory | Known |
| `INV-STOK` Stok | Inventory | Known |
| `INV-MASTER` Item Master | Inventory | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> *Catatan: Dokumen ini membaca referensi langsung dari dokumen pengeluaran Outcome `Mutasi` (`OC-INV-MUTASI`) berstatus `In-Transit` untuk menarik rincian kuantitas kirim dan atribut batch pengiriman.*

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Penerimaan Mutasi Stok (*Stock Receipt / Acceptance*) telah tersimpan secara persisten dengan nomor transaksi unik.
- Dokumen merujuk secara sah ke tepat satu dokumen pengeluaran `Mutasi` (`OC-INV-MUTASI`) yang berstatus **Terkirim (In-Transit)**.
- Kuantitas yang diterima dicatat secara independen dan transparan:
  - `Qty Terima Baik`: Kuantitas fisik barang yang lolos verifikasi dan diterima dalam kondisi baik.
  - `Qty Selisih/Rusak/Hilang`: Kuantitas barang yang mengalami kerusakan fisik, pecah, atau hilang selama proses pengiriman.
- Saldo fisik persediaan di lokasi tujuan bertambah tepat sebesar `Qty Terima Baik`. Barang rusak/hilang tidak diakui ke dalam saldo stok berguna unit tujuan.
- Status persediaan *In-Transit* atas dokumen mutasi terkait resmi diselesaikan (*cleared*).
- Status dokumen `Mutasi` asal diperbarui secara otomatis menjadi **Diterima (Received)** jika seluruh kuantitas diterima baik, atau **Diterima dengan Selisih (Received with Discrepancy)** jika terdapat barang rusak/hilang.
- Status akhir dokumen penerimaan tercatat valid: **Diterima Penuh**, **Diterima Sebagian/Selisih**, atau **Ditolak (Rejected)**.

### 5.2 Required Recorded Information

- Nomor transaksi unik penerimaan mutasi (format penomoran standar penerimaan barang internal).
- Nomor referensi dokumen pengeluaran `Mutasi` asal (relasi 1-to-1 dengan dokumen `Mutasi`).
- Nomor referensi `ReqMutasi` awal (bila mutasi tersebut berasal dari siklus permintaan).
- Identitas lokasi persediaan asal/pengirim (ID & nama unit).
- Identitas lokasi persediaan tujuan/penerima (ID & nama unit).
- Tanggal dan waktu pengesahan penerimaan fisik.
- Identitas petugas penerima di unit tujuan (*receiver*).
- Rincian item barang yang diterima:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang (*Unit of Measure*).
  - Kuantitas yang dikirim unit asal (`Qty Kirim` — referensi asal).
  - Kuantitas yang diterima baik (`Qty Terima Baik` — bernilai \(\ge 0\)).
  - Kuantitas selisih/rusak/hilang (`Qty Selisih` — bernilai \(\ge 0\)).
  - Alasan / keterangan selisih (wajib diisi apabila `Qty Selisih \gt 0`, misal: botol pecah di perjalanan, ampul retak, kemasan basah/rusak).
  - Nomor Batch / Lot (sesuai verifikasi fisik terhadap dokumen kirim).
  - Tanggal Kedaluwarsa / *Expired Date* (sesuai verifikasi fisik terhadap dokumen kirim).
- Catatan / keterangan penerimaan (opsional).
- Status dokumen penerimaan mutasi.

### 5.3 Required Business Conditions

- Unit penerima yang melakukan pengesahan harus identik dengan unit tujuan yang tercantum pada dokumen `Mutasi` pengeluaran asal.
- Dokumen `Mutasi` asal yang dirujuk harus berstatus **Terkirim (In-Transit)**. Tidak diperkenankan memproses penerimaan atas mutasi yang masih berupa draf, telah dibatalkan, atau telah selesai diterima sebelumnya.
- Jumlah matematis baris rincian harus seimbang:
  $$\text{Qty Terima Baik} + \text{Qty Selisih} = \text{Qty Kirim}$$
- Nilai `Qty Terima Baik` tidak boleh melebihi nilai `Qty Kirim` (\(\text{Qty Terima Baik} \le \text{Qty Kirim}\)).
- Atribut Nomor Batch dan Tanggal Kedaluwarsa untuk komoditas farmasi/medis harus diverifikasi kesesuaian fisiknya terhadap data yang tertera pada pengeluaran gudang asal.
- Pengesahan penerimaan menambah saldo fisik lokasi tujuan dan mencatat kartu stok/buku pembantu di unit tujuan secara *real-time*.

### 5.4 Completion Proof

- Dokumen `TerimaMutasi` tersimpan secara persisten dengan nomor transaksi unik.
- Status dokumen bernilai **Diterima Penuh**, **Diterima dengan Selisih**, atau **Ditolak**.
- Saldo fisik persediaan pada lokasi tujuan bertambah tepat sebesar `Qty Terima Baik` dengan atribut batch dan tanggal kedaluwarsa yang sesuai.
- Antrean mutasi masuk (*incoming queue*) pada unit tujuan dibersihkan dan status dokumen `Mutasi` asal terkunci permanen.

---

## 6. Outcome Boundary

### Start

Dimulai ketika kiriman barang fisik tiba di unit tujuan dan petugas penerima membuka dokumen pengeluaran `Mutasi` berstatus *In-Transit* yang ada pada antrean penerimaan barang unit tersebut.

### End

Berakhir ketika pemeriksaan kuantitas dan kondisi fisik tuntas, dokumen `TerimaMutasi` resmi disahkan: saldo fisik unit tujuan bertambah sebesar `Qty Terima Baik`, status transit barang ditutup, dan dokumen `Mutasi` asal diperbarui statusnya menjadi *Diterima* atau *Diterima dengan Selisih*.

---

## 7. Business Constraints

1. **Mandatory Upstream Dispatch Link**: Setiap transaksi `TerimaMutasi` wajib memiliki relasi langsung dengan dokumen pengeluaran `Mutasi` (`OC-INV-MUTASI`) yang valid dan berstatus *In-Transit*.
2. **Independent Fact Recording**: Nilai kuantitas yang dikirim (`Qty Kirim`) pada dokumen pengeluaran tidak boleh diubah oleh unit penerima. Kuantitas riil fisik yang diterima (`Qty Terima Baik`) dan kuantitas rusak/kurang (`Qty Selisih`) dicatat secara independen di dokumen `TerimaMutasi` guna memelihara transparansi audit.
3. **No Usable Stock for Damaged Goods**: Barang yang tercatat rusak atau hilang di perjalanan (`Qty Selisih`) dilarang dimasukkan ke dalam saldo stok aktif/berguna unit tujuan.
4. **Immediate Destination Stock Increment**: Penambahan saldo fisik di unit tujuan dieksekusi secara instan saat dokumen `TerimaMutasi` disahkan, bukan ditunda hingga proses akhir hari atau opname periodik.
5. **Absolute Immutability**: Dokumen `TerimaMutasi` yang telah disahkan terkunci secara mutlak (*immutable*). Pembatalan atau penghapusan dokumen tidak diizinkan. Jika terjadi kelebihan penerimaan atau pengembalian stok di kemudian hari, penyelesaian wajib dilakukan melalui transaksi `Mutasi` baru (retur persediaan internal dari unit ke gudang).
6. **Total Rejection Support**: Unit penerima berhak melakukan Penolakan Mutasi (*Total Rejection*) apabila seluruh kiriman salah alamat atau rusak total, dengan menetapkan `Qty Terima Baik = 0`, mencantumkan berita acara/alasan penolakan, serta mengembalikan fisik barang ke unit pengirim tanpa menambah stok unit tujuan.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Dokumen `Mutasi` asal belum berstatus *In-Transit* (masih Draft atau sudah Dibatalkan) | Sistem menolak pembuatan dan pengesahan dokumen `TerimaMutasi`. |
| Terdapat barang yang pecah, bocor, atau rusak dalam perjalanan | Petugas mencatat jumlah barang rusak pada kolom `Qty Selisih` dan mengisi alasan selisih; sistem hanya menambah saldo unit tujuan sebesar `Qty Terima Baik` dan memperbarui status dokumen Mutasi menjadi *Diterima dengan Selisih*. |
| Kiriman salah alamat atau ditolak total oleh unit penerima | Petugas memilih aksi *Penolakan Mutasi (Reject)* dengan mencantumkan alasan; status dokumen menjadi `Ditolak`, saldo unit tujuan tidak bertambah, dan fisik barang dikembalikan ke unit asal untuk pemulihan saldo stok asal. |
| Nomor batch atau tanggal kedaluwarsa fisik berbeda dengan dokumen kirim | Petugas menahan pengesahan dan melakukan klarifikasi ke unit pengirim; jika tidak sesuai, kiriman baris tersebut dapat ditolak atau disesuaikan melalui berita acara sebelum disahkan. |
| Percobaan membatalkan dokumen `TerimaMutasi` yang telah disahkan | Sistem menolak pembatalan karena dokumen telah permanen dan mempengaruhi saldo stok; unit diarahkan untuk menerbitkan dokumen pengeluaran mutasi balik (retur). |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem berhasil memuat daftar mutasi masuk berstatus `In-Transit` untuk unit tujuan dan menerbitkan dokumen `TerimaMutasi` dengan nomor unik saat diproses. | Completeness |
| AC-02 | Pengesahan dokumen `TerimaMutasi` menambah saldo fisik stok di unit tujuan tepat sejumlah `Qty Terima Baik` lengkap dengan nomor batch dan tanggal kedaluwarsanya. | Correctness |
| AC-03 | Sistem mencatat `Qty Kirim`, `Qty Terima Baik`, `Qty Selisih`, dan alasan selisih secara independen pada dokumen `TerimaMutasi` tanpa mengubah nilai `Qty Kirim` di dokumen Mutasi asal. | Correctness |
| AC-04 | Pengesahan penerimaan dengan selisih memperbarui status dokumen `Mutasi` pengeluaran asal menjadi `Diterima dengan Selisih (Received with Discrepancy)`. | Completeness |
| AC-05 | Sistem menolak pengesahan jika jumlah `Qty Terima Baik` ditambah `Qty Selisih` tidak sama dengan `Qty Kirim`. | Constraint |
| AC-06 | Sistem mengizinkan penolakan mutasi total (*Rejection*), menghasilkan status `Ditolak`, tidak menambah stok unit tujuan, dan memungkinkan pengembalian fisik ke unit asal. | Exception |
| AC-07 | Sistem menolak pengeditan, penghapusan, atau pembatalan pada dokumen `TerimaMutasi` yang telah disahkan. | Constraint |

---

## 10. Out of Scope

- **Pencatatan Permintaan Mutasi**: Pengajuan kebutuhan logistik awal dari unit pemohon merupakan tanggung jawab Outcome `ReqMutasi` (`OC-INV-REQ-MUTASI`).
- **Pencatatan Pengeluaran dan Pengurangan Stok Asal**: Pengemasan dan pengeluaran fisik barang dari unit asal merupakan tanggung jawab Outcome `Mutasi` (`OC-INV-MUTASI`).
- **Penerimaan Barang Eksternal dari Pemasok**: Penerimaan kiriman barang dari rekanan/vendor luar rumah sakit merupakan tanggung jawab domain Purchasing via `TerimaBrg` (`PUR-DO`).
- **Pemusnahan Barang Rusak**: Penghapusan atau pemusnahan resmi atas barang yang rusak selama transit dari pencatatan rumah sakit merupakan tanggung jawab kapabilitas pemusnahan barang (`INV-MUSNAH`).
- **Pengembalian Barang Pasca-Penerimaan**: Pengembalian stok berlebih dari unit tujuan kembali ke gudang utama di kemudian hari dikelola sebagai transaksi pengeluaran mutasi internal baru (`OC-INV-MUTASI`).
