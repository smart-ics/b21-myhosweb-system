# OUTCOME: Rincian Tagihan Pasien

| Field       | Value        |
|-------------|--------------|
| Code        | OC-02-01     |
| Version     | 1.0          |
| Status      | Draft        |
| LastUpdated | 2026-10-01   |

---

## 1. Business Purpose

Rumah sakit harus mampu membentuk dan memelihara tagihan kumulatif atas seluruh pelayanan yang diterima pasien selama satu episode kunjungan — baik rawat jalan, IGD, maupun rawat inap — sebagai persisted business fact yang menjadi dasar penyelesaian kewajiban finansial pasien sebelum kepulangan.

Rincian tagihan memastikan bahwa setiap item biaya yang timbul dari tindakan klinis, pemakaian obat/alat, pelayanan penunjang, jasa akomodasi, dan biaya administrasi telah tercatat secara akurat, terkelompokkan sesuai kategori pelayanan, dan dapat diverifikasi oleh pasien maupun penjamin (jaminan umum, BPJS, atau asuransi swasta).

Tanpa tagihan yang terbentuk dan terkonsolidasi secara benar, proses pembayaran, klaim jaminan, dan penyelesaian administrasi kepulangan tidak dapat dilakukan.

---

## 2. Outcome Statement

Seluruh biaya pelayanan yang diterima pasien selama satu episode kunjungan **telah tercatat, terkonsolidasi, dan tersaji sebagai rincian tagihan yang dapat diverifikasi, siap menjadi dasar bagi proses pembayaran, alokasi jaminan, dan penyelesaian administratif kepulangan**.

---

## 3. Participating Domains

| Domain        | Role in this Outcome                                                                                                       |
|---------------|----------------------------------------------------------------------------------------------------------------------------|
| Tata Rekening | Pemilik utama: mengelola pembentukan, konsolidasi, dan pemeliharaan tagihan atas semua item biaya kunjungan pasien         |
| Admission     | Menyediakan konteks kunjungan (nomor registrasi, jenis kunjungan) sebagai identitas episode yang ditagihkan                |
| Pasien        | Menyediakan identitas pasien sebagai subjek tagihan                                                                        |
| Rawat Jalan   | Sumber charge: tindakan klinis dan konsultasi poliklinik yang diposting ke tagihan kunjungan rawat jalan                  |
| Rawat Inap    | Sumber charge: tindakan klinis, room charge, dan biaya akomodasi bangsal yang diposting ke tagihan kunjungan rawat inap   |
| Gawat Darurat | Sumber charge: tindakan klinis IGD yang diposting ke tagihan kunjungan IGD                                                 |
| Laboratory    | Sumber charge: order laboratorium dan biaya pemeriksaan lab yang diposting ke tagihan                                      |
| Radiology     | Sumber charge: order radiologi dan biaya pemeriksaan radiologi yang diposting ke tagihan                                   |
| Kamar Operasi | Sumber charge: biaya prosedur operasi yang diposting ke tagihan                                                            |
| Apotek        | Sumber charge: biaya obat dan alat yang didispensing dan diposting ke tagihan                                              |
| Inventory     | Sumber charge: biaya barang habis pakai yang digunakan selama pelayanan klinis dan diposting ke tagihan                   |
| Organisasi    | Menyediakan data tarif melalui master tarif yang menjadi dasar penetapan nilai setiap item biaya                           |

---

## 4. Participating Capabilities

| Capability                        | Domain        | Status |
|-----------------------------------|---------------|--------|
| `TRK-BILLING` Billing             | Tata Rekening | Known  |
| `TRK-TARIF` Tariff                | Tata Rekening | Known  |
| `TRK-JAMINAN` Jaminan            | Tata Rekening | Known  |
| `ADM-REG` Registration            | Admission     | Known  |
| `PAS-DATSOS` Data Sosial Pasien   | Pasien        | Known  |
| `RJL-TINDAKAN` Charge Tindakan Klinis | Rawat Jalan | Known  |
| `RNA-BED` Pakai Bed               | Rawat Inap    | Known  |
| `RNA-CHARGE` Room Charge          | Rawat Inap    | Known  |
| `IGD-TINDAKAN` IGD Procedure      | Gawat Darurat | Known  |
| `LAB-ORDER` Order Lab             | Laboratory    | Known  |
| `RAD-ORDER` Order Radiologi       | Radiology     | Known  |
| `KMO-OPR` Operative Procedure     | Kamar Operasi | Known  |
| `APT-BILL` Sales Bill             | Apotek        | Known  |
| `INV-PAKAI` Pakai Barang          | Inventory     | Known  |

> **Capability Status values:** Known · Existing but Undocumented · Capability Candidate

---

## 5. Outcome Specification

> What must be true for this Outcome to be considered established?

### 5.1 Required Business Facts

- Tagihan kunjungan atas nama pasien yang teridentifikasi dan nomor registrasi yang valid telah terbentuk dalam sistem.
- Setiap item biaya yang timbul dari pelayanan klinis dan penunjang selama kunjungan telah diposting ke tagihan tersebut.
- Item biaya tercatat dengan referensi ke sumber pelayanan yang menghasilkannya (tindakan, order lab, order radiologi, dispensing obat, room charge, dll.).
- Setiap item biaya dinilai berdasarkan tarif yang berlaku untuk jenis jaminan pasien pada kunjungan tersebut.
- Total tagihan (gross amount) telah terhitung dan dapat ditampilkan sebagai angka yang dapat diverifikasi.
- Tagihan dibedakan antara porsi yang ditanggung penjamin (jaminan) dan porsi yang menjadi kewajiban pasien (patient portion).
- Status tagihan mencerminkan keadaan aktual: **Aktif** (kunjungan masih berjalan) atau **Final** (kunjungan selesai, tagihan siap diselesaikan).

### 5.2 Required Recorded Information

**Identitas Tagihan:**
- Nomor tagihan yang unik.
- Nomor registrasi kunjungan yang menjadi konteks tagihan.
- Identitas pasien (Nomor Rekam Medis, nama pasien).
- Jenis kunjungan: Rawat Jalan, IGD, atau Rawat Inap.
- Jenis jaminan pembayaran yang berlaku (umum, BPJS, asuransi swasta, atau jaminan lain).
- Tanggal tagihan dibentuk.
- Status tagihan.

**Rincian Item Biaya:**
- Kode dan nama item pelayanan/barang.
- Kategori biaya (tindakan, obat, lab, radiologi, akomodasi, administrasi, dll.).
- Jumlah dan satuan.
- Tarif per unit berdasarkan jenis jaminan.
- Nilai total per item.
- Tanggal dan waktu pelayanan yang menghasilkan item biaya.
- Referensi unit/departemen pelayanan yang memposting item biaya.

**Ringkasan Tagihan:**
- Total nilai tagihan kotor (gross amount) per kategori biaya.
- Total nilai tagihan keseluruhan.
- Porsi yang ditanggung penjamin.
- Porsi kewajiban pasien (patient portion).
- Saldo tagihan yang belum terbayar.

### 5.3 Required Business Conditions

- Kunjungan yang menjadi konteks tagihan harus terdaftar dan aktif dalam sistem (berdasarkan nomor registrasi yang valid).
- Setiap item biaya harus memiliki referensi tarif yang berlaku; item tanpa tarif tidak dapat diposting.
- Nilai setiap item biaya harus dihitung berdasarkan tarif yang sesuai dengan jenis jaminan pasien — bukan tarif umum secara default jika jaminan pasien berbeda.
- Seluruh item biaya yang telah divalidasi dan dikonfirmasi oleh unit pelayanan asal harus terefleksi dalam tagihan sebelum tagihan dapat dijadikan **Final**.
- Tagihan tidak dapat dijadikan **Final** jika masih ada item biaya yang berstatus menunggu verifikasi dari unit pelayanan.
- Porsi jaminan dan porsi pasien harus terdefinisi secara eksplisit berdasarkan aturan manfaat jaminan yang berlaku.

### 5.4 Completion Proof

- Nomor tagihan yang unik telah diterbitkan dan terhubung ke nomor registrasi kunjungan.
- Seluruh item biaya dari semua unit pelayanan yang terlibat selama kunjungan telah terposting dan tercatat dalam tagihan.
- Total tagihan kotor, porsi jaminan, dan porsi pasien dapat ditampilkan dengan benar.
- Tagihan dapat ditemukan berdasarkan nomor tagihan, nomor registrasi, atau identitas pasien.
- Tagihan dapat dijadikan dasar untuk proses pembayaran (OC-02-02 Alokasi Pembayaran) dan penyelesaian kepulangan (OC-02-05 Reg-Out).

---

## 6. Outcome Boundary

### Start

Dimulai ketika kunjungan pasien telah terdaftar secara resmi (registrasi Admission selesai dengan nomor kunjungan aktif), sehingga tagihan kosong (header tagihan) dapat dibentuk dan siap menerima posting item biaya dari seluruh unit pelayanan.

Untuk rawat inap, tagihan dapat mulai menerima posting item biaya sejak pasien pertama kali ditempatkan di bed bangsal.

### End

Berakhir ketika seluruh item biaya atas episode kunjungan telah diposting, diverifikasi, dan status tagihan berubah menjadi **Final** — menandakan bahwa tagihan siap diselesaikan melalui pembayaran, alokasi jaminan, atau kombinasi keduanya.

Tagihan yang berstatus **Final** menjadi titik serah ke proses Alokasi Pembayaran (OC-02-02) dan Reg-Out (OC-02-05).

---

## 7. Business Constraints

> Rules that must always hold true for this Outcome.

- Setiap tagihan harus terhubung ke tepat satu nomor registrasi kunjungan yang aktif; tagihan tidak dapat dibentuk tanpa konteks kunjungan yang valid.
- Tarif yang diterapkan pada setiap item biaya harus sesuai dengan jenis jaminan yang terdaftar pada kunjungan — perubahan jaminan setelah posting item biaya memerlukan proses koreksi tagihan yang berlaku.
- Nomor tagihan bersifat unik dan tidak dapat digunakan ulang atau dipindahkan ke kunjungan lain.
- Item biaya yang sudah diposting hanya dapat dihapus atau dikoreksi melalui mekanisme koreksi tagihan yang terkontrol; penghapusan langsung tanpa jejak audit tidak diperbolehkan.
- Tagihan tidak dapat berstatus **Final** selama masih ada pelayanan aktif yang belum diselesaikan (misalnya: bed aktif di bangsal, order lab yang belum selesai, obat yang belum di-dispensing) — kecuali unit pelayanan terkait secara eksplisit telah menyatakan selesai.
- Satu kunjungan hanya boleh memiliki satu tagihan utama yang aktif pada satu waktu; penggabungan atau pemisahan tagihan memerlukan otorisasi.
- Untuk kunjungan BPJS, item biaya yang termasuk dalam manfaat BPJS harus dikelompokkan sesuai aturan tarif INA-CBGs; item di luar manfaat harus diidentifikasi sebagai biaya pasien.

---

## 8. Business Exceptions

> Conditions under which the Outcome cannot be established.

| Exception                                                                           | Expected Behavior                                                                                                                                                               |
|-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kunjungan tidak terdaftar atau nomor registrasi tidak valid                         | Header tagihan tidak dapat dibentuk. Pastikan kunjungan telah terdaftar melalui proses Registrasi (OC-01-02 atau OC-01-03) sebelum tagihan dapat dibuka.                        |
| Item biaya tidak memiliki referensi tarif yang berlaku untuk jaminan pasien         | Item tidak dapat diposting. Unit pelayanan harus memastikan item memiliki tarif yang valid, atau eskalasi ke administrator tarif untuk penetapan tarif darurat.                  |
| Terdapat item biaya dari unit pelayanan yang masih berstatus menunggu verifikasi    | Tagihan tidak dapat dijadikan Final. Unit pelayanan terkait harus menyelesaikan verifikasi sebelum tagihan dapat difinalisasi.                                                   |
| Perubahan jenis jaminan dilakukan setelah item biaya sudah diposting                | Tagihan memerlukan proses recalculation; semua item yang sudah diposting harus dihitung ulang berdasarkan tarif jaminan yang baru. Proses ini memerlukan otorisasi supervisor.  |
| Kunjungan sudah diselesaikan (Reg-Out) namun item biaya tambahan masih masuk        | Posting item tambahan setelah Reg-Out tidak diperbolehkan secara otomatis; memerlukan pembukaan kembali tagihan (reopening) dengan otorisasi, atau diproses sebagai koreksi.    |
| Item biaya diposting ke kunjungan yang salah                                        | Koreksi tagihan harus dilakukan oleh petugas yang berwenang dengan menghapus item dari kunjungan yang salah dan memposting ke kunjungan yang benar melalui mekanisme koreksi.   |

---

## 9. Acceptance Criteria

> Verifiable criteria confirming the Outcome exists as specified.

| #     | Criterion                                                                                                                                                                           | Validates    |
|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| AC-01 | Tagihan memiliki nomor tagihan unik yang terhubung ke nomor registrasi kunjungan yang benar.                                                                                        | Completeness |
| AC-02 | Tagihan mencatat identitas pasien, jenis kunjungan, dan jenis jaminan yang sesuai dengan data kunjungan.                                                                            | Correctness  |
| AC-03 | Setiap item biaya yang diposting memiliki referensi ke sumber pelayanan, kategori biaya, tarif per unit, dan nilai total yang terhitung dengan benar.                               | Correctness  |
| AC-04 | Tarif yang diterapkan pada setiap item biaya sesuai dengan jenis jaminan yang berlaku pada kunjungan — bukan tarif default yang tidak relevan.                                      | Correctness  |
| AC-05 | Total tagihan kotor (gross amount) sesuai dengan penjumlahan nilai seluruh item biaya yang terposting.                                                                              | Completeness |
| AC-06 | Porsi jaminan dan porsi kewajiban pasien terdefinisi secara eksplisit dan dapat ditampilkan secara terpisah.                                                                        | Completeness |
| AC-07 | Tagihan dapat ditemukan berdasarkan nomor tagihan, nomor registrasi kunjungan, atau identitas pasien.                                                                               | Correctness  |
| AC-08 | Tagihan tidak dapat dijadikan Final selama masih ada item biaya yang menunggu verifikasi dari unit pelayanan.                                                                       | Constraint   |
| AC-09 | Item biaya hanya dapat diposting jika memiliki referensi tarif yang valid untuk jaminan pasien; posting tanpa tarif menghasilkan penolakan.                                         | Constraint   |
| AC-10 | Tagihan yang berstatus Final dapat dijadikan dasar untuk proses Alokasi Pembayaran (OC-02-02) dan Reg-Out (OC-02-05).                                                               | Correctness  |
| AC-11 | Penghapusan atau koreksi item biaya yang sudah diposting hanya dapat dilakukan melalui mekanisme koreksi yang terkontrol; jejak audit perubahan tersimpan.                          | Constraint   |
| AC-12 | Posting item biaya ke kunjungan yang sudah Reg-Out ditolak secara otomatis tanpa otorisasi pembukaan kembali tagihan.                                                               | Exception    |

---

## 10. Out of Scope

> What this Outcome explicitly does NOT cover.

- Proses pembayaran oleh pasien dan penerimaan kas — **OC-02-02 Alokasi Pembayaran** dan **OC-03-02 Pembayaran**.
- Pengelolaan deposit pasien sebagai jaminan biaya rawat — **OC-02-03 Deposit**.
- Proses refund kelebihan pembayaran kepada pasien — **OC-02-04 Refund**.
- Penyelesaian administrasi kepulangan pasien (finalisasi tagihan dan Reg-Out) — **OC-02-05 Reg-Out**.
- Proses order oleh kasir sebelum pembayaran — **OC-03-01 Order Bayar**.
- Pengelolaan tarif dan struktur harga pelayanan — `TRK-TARIF` (domain Tata Rekening, bukan bagian dari Outcome ini).
- Pengelolaan master jaminan dan aturan manfaat penjamin — `TRK-JAMINAN`.
- Klaim ke BPJS melalui e-Klaim — **BPJS Domain** (`BPJ-EKLAIM`).
- Pencatatan tindakan klinis itu sendiri — domain klinis masing-masing (RJL, RNA, IGD, LAB, RAD, KMO).
- Pengelolaan stok dan pemakaian barang di unit pelayanan — **Inventory Domain** (`INV-PAKAI`).
- Pelaporan akuntansi dan keuangan atas pendapatan rumah sakit — domain Finance/Akuntansi (di luar scope MYHOSWEB saat ini).
