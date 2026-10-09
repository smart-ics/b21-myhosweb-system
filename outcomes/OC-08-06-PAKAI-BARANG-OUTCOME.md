# OUTCOME: Pakai Barang

| Field       | Value             |
|-------------|-------------------|
| Code        | OC-08-06          |
| Version     | 2.0               |
| Status      | Final Draft       |
| LastUpdated | 2026-10-09        |

---

## 1. Business Purpose

Unit laboratorium memerlukan bahan habis pakai dan reagen untuk pemeriksaan pasien maupun aktivitas operasional laboratorium lainnya. OC-08-06 bertanggung jawab atas **Pencatatan Pemakaian Barang (Pakai Barang)** pada lokasi laboratorium serta koreksi operasionalnya melalui **Edit** dan **Pembatalan (Cancel)**.

Outcome ini memastikan konsumsi barang tercatat secara tertib dan saldo stok berkurang atau disesuaikan secara seketika dan konsisten, tanpa pernah menghasilkan stok negatif dan tanpa menghapus riwayat transaksi.

---

## 2. Outcome Statement

Transaksi pemakaian barang pada lokasi laboratorium **telah berhasil disimpan, diedit, atau dibatalkan secara persisten**, dan **saldo stok barang pada lokasi laboratorium berkurang atau disesuaikan secara atomik**, dengan riwayat transaksi yang **tidak pernah dihapus**.

---

## 3. Participating Domains

| Domain | Role in this Outcome |
|--------|----------------------|
| Laboratory | Menyediakan konteks operasional laboratorium tempat pemakaian barang dilakukan oleh petugas laboratorium. |
| Inventory | Mengelola pemotongan, penyesuaian, pengembalian stok per lokasi, dan validasi stok non-negatif (`INV-PAKAI`, `INV-STOK`, `INV-MASTER`). |
| Organisasi | Memverifikasi identitas petugas dan kepemilikan permission `Pakai Barang` (`ORG-USER`). |

---

## 4. Outcome Specification

### 4.1 Business Rules

1. **Item & Lingkup Transaksi:**
   - Satu transaksi Pakai Barang mencatat tepat **satu jenis barang**.
   - Transaksi mencatat kuantitas pemakaian pada tingkat lokasi inventori laboratorium; **tidak mencatat nomor batch maupun tanggal kadaluarsa (Batch/Expiry)**.
   - Transaksi bersifat mandiri: **tidak wajib terkait dengan Order Laboratorium atau pemeriksaan pasien tertentu** (dapat digunakan untuk pemeriksaan klinis maupun kebutuhan operasional/QC/alat).
2. **Permission Model:**
   - Seluruh operasi (Create, Edit, dan Cancel) menggunakan permission yang sama: **Pakai Barang**. Tidak diperlukan permission khusus untuk edit atau cancel.
3. **No Delete Invariant:**
   - Transaksi yang sudah berhasil disimpan **tidak boleh dihapus** (tidak ada penghapusan fisik maupun logis); riwayat transaksi wajib dipertahankan.
4. **Non-Negative Stock & Atomisitas:**
   - Kuantitas pemakaian tidak boleh melebihi stok yang tersedia; sistem dilarang keras menghasilkan stok negatif.
   - Seluruh operasi (Create, Edit, Cancel) dan perubahan stoknya bersifat **atomik**: jika penyimpanan/operasi gagal, data transaksi dan saldo stok tidak berubah sama sekali (tidak ada perubahan parsial).

### 4.2 State & Stock Rules

| Operasi | Prasyarat Status | Aturan Stok & Transaksi |
|---------|------------------|-------------------------|
| **Create** | — | - Kuantitas pemakaian $\le$ stok tersedia.<br>- Save berhasil $\rightarrow$ status transaksi menjadi `Active`, dan stok berkurang sebesar kuantitas pemakaian.<br>- Save gagal / stok kurang $\rightarrow$ transaksi ditolak, stok tidak berubah. |
| **Edit** | `Active` | - Modifikasi langsung pada transaksi yang ada (**bukan membuat transaksi baru**).<br>- Menggunakan selisih stok (delta):<br>&nbsp;&nbsp;• Kuantitas naik $\rightarrow$ stok berkurang sebesar selisih tambahan (wajib $\le$ stok tersedia; ditolak jika stok kurang).<br>&nbsp;&nbsp;• Kuantitas turun $\rightarrow$ selisihnya dikembalikan ke stok.<br>- Keterangan alasan perubahan bersifat opsional.<br>- Edit pada transaksi `Cancelled` ditolak. |
| **Cancel** | `Active` | - Transaksi tidak dihapus; status berubah menjadi `Cancelled`.<br>- **Tidak bergantung pada kondisi ketersediaan stok saat ini** (operasi menambah/mengembalikan stok).<br>- **Wajib menyertakan alasan pembatalan (`CancelReason`)**; pembatalan tanpa alasan ditolak.<br>- Mengembalikan **kuantitas aktif terakhir (*latest active quantity*)** ke stok, bukan kuantitas awal saat Create.<br>&nbsp;&nbsp;*(Contoh: Create 10 $\rightarrow$ Edit 7 $\rightarrow$ Cancel $\rightarrow$ stok bertambah 7).*<br>- Cancel pada transaksi `Cancelled` ditolak dan stok tidak berubah. |

### 4.3 Required Recorded Information

- **Create (`Active`):** Barang, Kuantitas Pemakaian, Lokasi Pemakaian, Petugas Transaksi, Waktu Transaksi, Status (`Active`).
- **Edit:** Kuantitas Pemakaian baru (*latest active quantity*), Petugas & Waktu Edit, Alasan Perubahan *(opsional)*.
- **Cancel:** Status (`Cancelled`), Alasan Pembatalan (**`CancelReason` wajib**), Petugas & Waktu Cancel.

---

## 5. Completion Proof

- **Create:** Transaksi tersimpan dengan status `Active` dan stok berkurang sebesar kuantitas pemakaian.
- **Edit:** Transaksi terbarui dengan kuantitas aktif baru dan stok disesuaikan sebesar selisihnya (delta).
- **Cancel:** Transaksi berstatus `Cancelled` dengan `CancelReason` tercatat, dan stok bertambah sebesar kuantitas aktif terakhir.

---

## 6. Outcome Boundary

- **Start:** Petugas dengan permission `Pakai Barang` mencatat pemakaian baru, mengedit transaksi `Active`, atau membatalkan transaksi `Active`.
- **End:** Transaksi berhasil disimpan/diperbarui/dibatalkan secara persisten dan saldo stok pada lokasi laboratorium disesuaikan secara atomik.

---

## 7. Business Exceptions

| Exception | Expected Behavior |
|-----------|-------------------|
| Petugas tidak memiliki permission `Pakai Barang` | Operasi Create, Edit, atau Cancel ditolak. Data dan stok tidak berubah. |
| Barang atau lokasi tidak valid/aktif | Transaksi ditolak. Data dan stok tidak berubah. |
| Kuantitas pemakaian $\le 0$ atau tidak valid | Transaksi ditolak. Data dan stok tidak berubah. |
| Create: Stok tersedia $<$ kuantitas pemakaian | Transaksi ditolak (mencegah stok negatif). Stok tidak berubah. |
| Edit: Stok tersedia $<$ selisih kenaikan kuantitas | Edit ditolak (mencegah stok negatif). Data dan stok tidak berubah. |
| Edit pada transaksi berstatus `Cancelled` | Aksi ditolak. Transaksi `Cancelled` tidak dapat diedit. |
| Cancel tanpa menyertakan `CancelReason` | Pembatalan ditolak. Alasan pembatalan wajib diisi. |
| Cancel pada transaksi berstatus `Cancelled` | Aksi ditolak. Pembatalan hanya berlaku untuk transaksi `Active`. Stok tidak berubah. |
| Upaya menghapus (Delete) transaksi tersimpan | Aksi ditolak mutlak. Transaksi tidak boleh dihapus. |
| Kegagalan teknis penyimpanan Create/Edit/Cancel | Operasi dibatalkan penuh (rollback). Data dan stok tidak berubah parsial. |

---

## 8. Acceptance Criteria

| # | Criterion | Validates |
|---|-----------|-----------|
| AC-01 | Petugas dengan permission `Pakai Barang` dapat membuat transaksi pemakaian untuk satu jenis barang tanpa batch/expiry dan tanpa prerequisite Order Lab atau pasien. | Completeness |
| AC-02 | Create berhasil mencatat transaksi berstatus `Active` dan mengurangi stok seketika sesuai kuantitas pemakaian; ditolak jika stok tidak mencukupi (mencegah stok negatif). | Correctness & Constraint |
| AC-03 | Transaksi yang sudah tersimpan tidak dapat dihapus dari sistem dalam kondisi apa pun. | Constraint |
| AC-04 | Transaksi `Active` dapat diedit langsung (bukan transaksi baru) menggunakan permission `Pakai Barang`; kenaikan kuantitas memotong selisih stok (ditolak jika stok kurang), penurunan kuantitas mengembalikan selisih ke stok. | Correctness |
| AC-05 | Edit pada transaksi `Cancelled` ditolak oleh sistem. | Exception |
| AC-06 | Transaksi `Active` dapat dibatalkan tanpa bergantung kondisi stok saat ini, wajib menyertakan `CancelReason`, dan mengubah status menjadi `Cancelled` tanpa menghapus data. | Completeness & Correctness |
| AC-07 | Cancel pada transaksi yang pernah diedit mengembalikan kuantitas aktif terakhir (*latest active quantity*) ke stok (misal: Create 10 $\rightarrow$ Edit 7 $\rightarrow$ Cancel mengembalikan 7). | Correctness |
| AC-08 | Cancel pada transaksi yang sudah berstatus `Cancelled` atau Cancel tanpa `CancelReason` ditolak dan stok tidak berubah. | Exception |
| AC-09 | Seluruh operasi (Create, Edit, Cancel) dan penyesuaian stoknya bersifat atomik; kegagalan operasi tidak menyebabkan perubahan data atau stok secara parsial. | Constraint |
| AC-10 | Operasi Create, Edit, dan Cancel ditolak jika petugas tidak memiliki permission `Pakai Barang`. | Exception |

---

## 9. Out of Scope

- Order Laboratorium (`OC-08-02`), Sample Collection (`OC-08-04`), dan Result Management (`OC-08-05`).
- Pembebanan biaya pasien (`OC-08-03 Charge`).
- Pengadaan dan penerimaan barang gudang (`SC-12` / `SC-13`).
- Mutasi barang antar lokasi (`OC-08-07`) dan Stock Opname (`OC-08-08`).
- Formula reagen otomatis per pemeriksaan (auto-deduct per test).
- Tracking nomor batch dan tanggal kadaluarsa (Batch/Expiry).

---

## 10. Confirmed Decisions

1. **Independensi Klinis:** Tidak wajib terkait Order Lab atau pemeriksaan pasien.
2. **Satu Transaksi Satu Barang:** Mencatat satu jenis barang, tanpa tracking batch/expiry.
3. **Permission:** Create, Edit, dan Cancel menggunakan permission `Pakai Barang`.
4. **No Delete:** Transaksi tersimpan tidak boleh dihapus.
5. **Create:** Status menjadi `Active`, stok berkurang sebesar kuantitas pemakaian (wajib $\le$ stok tersedia).
6. **Edit:** Modifikasi transaksi `Active` in-place berbasis delta stok; ditolak jika stok kurang untuk selisih kenaikan; alasan edit opsional.
7. **Cancel:** Khusus transaksi `Active`, wajib `CancelReason`, status menjadi `Cancelled`, tidak bergantung stok saat ini, mengembalikan kuantitas aktif terakhir (*latest active quantity*).
8. **Atomisitas:** Eksekusi data transaksi dan stok selalu utuh; stok tidak pernah negatif.
9. **Scope Boundary:** Tidak mencakup Order Lab, Sample Collection, Result Management, Pengadaan, Mutasi Barang, maupun Opname.
