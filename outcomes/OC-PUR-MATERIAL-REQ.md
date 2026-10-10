# OUTCOME: Material Request (MaterialReq)

| Field       | Value                  |
|-------------|------------------------|
| Code        | OC-PUR-MATERIAL-REQ    |
| Version     | 1.0                    |
| Status      | Draft                  |
| LastUpdated | 2026-10-10             |

---

## 1. Business Purpose

Unit operasional di rumah sakit (seperti IGD, masing-masing Poliklinik Rawat Jalan, masing-masing Bangsal Rawat Inap, Laboratorium, Radiologi, dll.) memerlukan ketersediaan logistik dan persediaan barang yang aman dan mencukupi agar pelayanan pasien dapat berjalan tanpa gangguan.

Untuk menjamin kelancaran operasional tersebut secara tertib dan efisien, sistem secara periodik men-generate kalkulasi perkiraan kebutuhan material untuk setiap unit. Perkiraan kebutuhan ini dikonfirmasikan dan disetujui oleh Kepala Unit, lalu diserahkan kepada Bagian Purchasing sebagai dasar kompilasi kebutuhan berkala seluruh rumah sakit.

Tanpa Material Request yang terstandarisasi dan disetujui unit, Bagian Purchasing tidak memiliki dasar operasional yang akurat untuk menyusun Purchase Request rumah sakit, sehingga berisiko menimbulkan kekosongan stok kritis di unit pelayanan atau sebaliknya terjadinya penumpukan barang yang tidak terkendali.

---

## 2. Outcome Statement

Permintaan material operasional periodik untuk unit kerja tertentu (mencakup estimasi kebutuhan, sisa stok, dan kuantitas yang diminta) **telah dihitung oleh sistem, disetujui oleh Kepala Unit, dan tersedia untuk dikumpulkan oleh Bagian Purchasing**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|---|---|
| Purchasing | Pemilik utama: mencatat dan mengelola Material Request sebagai fakta bisnis persisten kebutuhan pengadaan unit |
| Organisasi | Menyediakan data unit kerja/layanan operasional pemohon (`ORG-LAYANAN`) |

---

## 4. Participating Capabilities

| Capability | Domain | Status |
|---|---|---|
| `PUR-MATREQ` Material Request | Purchasing | Known |
| `ORG-LAYANAN` Unit Layanan | Organisasi | Known |

> *Catatan: Data saldo stok unit dan master katalog barang digunakan melalui lookup internal saat kalkulasi sistem, tanpa memindahkan otoritas kapabilitas.*

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Dokumen Material Request untuk unit operasional dan periode kebutuhan tertentu telah tercatat persisten dalam sistem.
- Sistem telah mengkalkulasi estimasi kebutuhan periodik (`Qty Perkiraan Kebutuhan`) dan membaca sisa stok fisik unit (`Qty Sisa`).
- Setiap item barang memiliki kuantitas permintaan yang definitif (`Request Qty`).
- Dokumen Material Request memuat persetujuan resmi dari pejabat unit yang berwenang (Kepala Unit/Ruangan).
- Status Material Request dapat dibedakan secara tegas: **Draf Sistem**, **Disetujui Unit (Approved by Unit)**, **Dikonsolidasikan (Consolidated into PR)**, atau **Dibatalkan**.

### 5.2 Required Recorded Information

- Nomor referensi unik Material Request (format penomoran standar MR per unit dan periode).
- Identitas unit pemohon (ID & nama unit layanan, e.g., Bangsal Mawar, IGD, Poli Penyakit Dalam).
- Periode kebutuhan (misal: Bulan & Tahun atau Siklus Mingguan tertentu).
- Tanggal & waktu pembuatan (kalkulasi sistem).
- Tanggal & waktu persetujuan unit.
- Identitas pejabat unit penyetuju (Kepala Unit / Kepala Ruangan).
- Daftar rincian barang yang diminta:
  - Kode dan nama barang (dari katalog master barang aktif).
  - Satuan barang.
  - Qty Perkiraan Kebutuhan (kalkulasi sistem berdasarkan perkiraan kebutuhan unit).
  - Qty Sisa (saldo stok berjalan di unit saat kalkulasi).
  - Request Qty (kuantitas yang direkomendasikan sistem / hasil penyesuaian oleh unit).
  - Catatan/justifikasi unit (opsional, jika ada penyesuaian khusus).
- Status Material Request.

### 5.3 Required Business Conditions

- Unit kerja pemohon harus terdaftar aktif dalam struktur organisasi rumah sakit (`ORG-LAYANAN`).
- Barang yang tercantum harus merupakan item aktif dalam katalog master barang rumah sakit.
- Satu dokumen Material Request dapat menggabungkan kelompok barang medis/farmasi dan umum/non-medis secara bebas; pemilahan kategori dilakukan kemudian oleh Bagian Purchasing.
- Nilai `Qty Sisa` tidak boleh negatif (\(\ge 0\)).
- Nilai `Request Qty` tidak boleh negatif (\(\ge 0\)). Item dengan `Request Qty = 0` tidak diikutkan dalam pengajuan pengadaan.
- Satu unit kerja hanya boleh memiliki **satu dokumen Material Request aktif** untuk periode kebutuhan yang sama.
- Persetujuan oleh Kepala Unit harus diselesaikan sebelum batas waktu (*cutoff date*) periode pengumpulan oleh Purchasing.

### 5.4 Completion Proof

- Dokumen Material Request tersimpan secara persisten dengan nomor referensi unik.
- Status dokumen bernilai **Disetujui Unit (Approved by Unit)**.
- Seluruh rincian item barang telah tervalidasi dengan nilai `Request Qty` final.
- Dokumen tersedia dalam antrean penarikan Bagian Purchasing untuk dikompilasi menjadi Purchase Request rumah sakit.

---

## 6. Outcome Boundary

### Start

Dimulai ketika sistem menjalankan kalkulasi rutin periodik untuk unit operasional terkait (atau saat proses periodik dipicu), menghasilkan draf usulan Material Request yang memuat perkiraan kebutuhan, sisa stok, dan kuantitas yang diminta.

### End

Berakhir ketika dokumen Material Request telah ditelaah, disesuaikan (bila diperlukan), dan secara resmi disetujui oleh Kepala Unit/Ruangan (**Approved by Head of Unit**), sehingga siap ditarik dan dikonsolidasikan oleh Bagian Purchasing ke dalam dokumen Purchase Request rumah sakit.

---

## 7. Business Constraints

1. **Periodic Routine Only**: Material Request secara eksklusif hanya melayani pengajuan logistik periodik/rutin terjadwal (mingguan/bulanan). Kebutuhan mendesak/darurat (cito/ad-hoc) menggunakan mekanisme operasional terpisah.
2. **Single Request per Unit per Period**: Setiap unit hanya diperbolehkan memiliki 1 dokumen Material Request untuk satu periode kebutuhan yang sama guna mencegah duplikasi pengadaan.
3. **No Mixed Tracing into Unit Level after Consolidation**: Pemotongan atau penyesuaian anggaran (*budget adjustment*) dilakukan pada level kompilasi rumah sakit (*Purchase Request*), dan tidak ditelusuri balik secara individual per unit pada dokumen Material Request.
4. **Immutability upon Consolidation**: Dokumen Material Request yang telah ditarik dan dikonsolidasikan ke dalam siklus Purchase Request oleh Purchasing terkunci dan tidak dapat diubah atau dibatalkan oleh unit pemohon.
5. **Role-Based Authorization**: Hanya personel dengan wewenang Kepala Unit/Ruangan yang dapat mengesahkan status *Approved*.

---

## 8. Business Exceptions

| Exception | Expected Behavior |
|---|---|
| Batas waktu (*cutoff date*) pengajuan telah terlewati | Dokumen draf unit tidak dapat lagi disetujui untuk siklus berjalan; unit harus menunggu siklus periodik berikutnya atau mengajukan perpanjangan wewenang khusus. |
| Duplikasi periode terdeteksi untuk unit yang sama | Sistem menolak pembuatan draf baru dan mengarahkan ke dokumen Material Request yang sudah ada untuk periode tersebut. |
| Seluruh item memiliki `Request Qty = 0` (sisa stok unit masih mencukupi kebutuhan) | Sistem menandai dokumen tidak memerlukan pengadaan eksternal dan tidak diteruskan ke antrean Purchasing. |
| Unit dinonaktifkan dalam Organisasi | Sistem menonaktifkan pembentukan Material Request otomatis untuk unit tersebut. |

---

## 9. Acceptance Criteria

| # | Criterion | Validates |
|---|---|---|
| AC-01 | Sistem secara periodik berhasil mengkalkulasi kebutuhan unit dan menerbitkan draf Material Request lengkap dengan atribut unit, periode, daftar item, Qty Perkiraan Kebutuhan, Qty Sisa, dan Request Qty usulan. | Completeness |
| AC-02 | Kepala Unit dapat menelaah, mengoreksi Request Qty (bila diperlukan), dan menyetujui dokumen sehingga status berubah menjadi *Approved by Head of Unit*. | Correctness |
| AC-03 | Dokumen Material Request berstatus *Approved* dapat dibaca dan dikumpulkan oleh Bagian Purchasing sebagai bahan kompilasi kebutuhan rumah sakit. | Completeness |
| AC-04 | Sistem menolak penerbitan atau persetujuan dokumen Material Request kedua untuk unit dan periode yang sama. | Constraint |
| AC-05 | Dokumen yang telah melewati *cutoff date* atau telah ditarik oleh Purchasing terkunci dari perubahan kuantitas oleh staf maupun Kepala Unit. | Constraint |
| AC-06 | Penggabungan item lintas komoditas (medis dan non-medis) dalam satu dokumen Material Request dapat diproses tanpa galat validasi kategori. | Correctness |

---

## 10. Out of Scope

- **Kompilasi Kebutuhan Rumah Sakit**: Penggabungan seluruh Material Request unit menjadi satu kebutuhan rumah sakit merupakan tanggung jawab `Purchase Request` (`PUR-PURREQ`).
- **Penyesuaian Anggaran Finansial**: Pemotongan kuantitas atau penyesuaian pagu anggaran pengadaan di tingkat rumah sakit merupakan tanggung jawab proses Purchase Request bersama Departemen Keuangan.
- **Pemesanan ke Supplier**: Pemilahan barang per rekanan/supplier dan penerbitan PO merupakan tanggung jawab `Purchase Order` (`PUR-PO`).
- **Penerimaan Fisik & Mutasi Gudang**: Pengiriman barang fisik dari gudang utama ke unit lokal merupakan tanggung jawab mutasi internal (`INV-MUTASI`).
- **Permintaan Darurat / Cito**: Pengadaan atau permintaan insidental di luar siklus rutin dikelola di luar cakupan Material Request periodik.
