## Dari Feature-Centric UI ke Actor-Centric UI

Pada sistem sebelumnya, aplikasi dirancang menggunakan pendekatan **Feature-Centric UI**, di mana:
- Navigasi utama berupa menu-menu fitur
- User harus berpindah-pindah screen dan menu untuk menyelesaikan satu pekerjaan
- Satu alur kerja sering tersebar di banyak menu

Pendekatan ini menimbulkan beberapa masalah:
- Tidak selaras dengan cara kerja nyata di rumah sakit
- Membebani user secara kognitif
- Menyulitkan onboarding dan pelatihan

Pada desain baru ini, sistem menggunakan pendekatan **Actor-Centric UI**.

### Prinsip Actor-Centric UI
- UI dirancang berdasarkan **siapa actor-nya**, bukan fitur apa yang ada
- Satu actor bekerja dalam **satu screen utama** sesuai perannya
- Seluruh aktivitas harian actor tersedia dalam screen tersebut
- Tidak ada lagi navigasi menu fitur yang terpisah-pisah

Dengan pendekatan ini:
- User tidak perlu "mencari fitur"
- Sistem mengikuti alur kerja actor
- Produktivitas meningkat dan kesalahan operasional berkurang

### Implikasi ke Desain Sistem
Untuk mendukung Actor-Centric UI, diperlukan:
1. Daftar fitur yang tersedia di sistem
2. Daftar actor yang terlibat dalam operasional rumah sakit
3. Mapping yang jelas antara actor dan fitur

Mapping inilah yang menjadi dasar:
- Desain UI per actor
- Penentuan tanggung jawab
- Pembagian screen Staff dan Kepala

Dokumen ini menyajikan ketiga hal tersebut sebagai dasar desain UI dan pengembangan sistem.

---

## 1. Daftar Modul & Fitur

### A. Billing

#### 1. Admisi & Registrasi
- Booking Kunjungan
- Registrasi Pasien
- Data Sosial Pasien

#### 2. Penunjang Medis (Order & Hasil)
- Order Laboratorium
- Hasil Laboratorium
- Order Radiologi
- Expertise Radiologi
- Order Operasi
- Schedule Operasi

#### 3. Charge & Biaya
- Tindakan Medis
- Biaya Lain-lain
- Room Charge
- Transport / Ambulance
- Management Bed

#### 4. Payment & Klaim
- Kasir
- Deposit
- Registrasi Keluar (Discharge)
- Verifikasi Jaminan / e-Klaim

---

### B. Pharmacy

#### 1. Purchasing & Pengadaan
- Material Request
- Purchase Order
- Goods Receive
- Faktur Tagihan

#### 2. Penjualan & Produksi
- Penjualan Obat
- Produksi / Racikan
- Retur Penjualan

#### 3. Pengelolaan Stok (Floor Stock)
- Order Mutasi
- Mutasi Barang
- Pakai Barang
- Stok Opname
- Musnah Barang

---

## 2. Daftar Actor

### A. Administrasi & Keuangan
- Admisi
- Tata Rekening
- Kasir
- Coding Medical Record
- Pengadaan Barang

### B. Klinis
- Poli Rawat Jalan
- Bangsal Rawat Inap
- IGD
- Kamar Operasi

### C. Penunjang Medis
- Laboratorium
- Radiologi

### D. Farmasi
- Apotek
- Gudang Farmasi

---

## 3. Mapping Actor – Fitur

### 1. Admisi
- Booking
- Registrasi
- Data Sosial Pasien
- Management Bed (Pakai Bed)

---

### 2. Tata Rekening
- Biaya Lain-lain
- Registrasi Keluar
- Deposit

---

### 3. Kasir
- Transaksi Kasir

---

### 4. Coding Medical Record
- Verifikasi Jaminan (EKlaim)
- Data Sosial Pasien

---

### 5. Poli Rawat Jalan
- Order Lab
- Order Radiologi
- Order Operasi
- Tindakan
- Pakai Barang
- Order Mutasi
- Stok Opname

---

### 6. Bangsal Rawat Inap
- Manajemen Bed
- Order Lab
- Order Radiologi
- Order Operasi
- Tindakan
- Pakai Barang
- Order Mutasi
- Stok Opname

---

### 7. IGD
- Order Lab
- Order Radiologi
- Order Operasi
- Tindakan
- Pakai Barang
- Order Mutasi
- Stok Opname

---

### 8. Laboratorium
- Tindakan Lab
- Hasil Lab
- Pakai Barang 
- Order Mutasi
- Stok Opname

---

### 9. Radiologi
- Tindakan Radiologi
- Expertise Radiologi
- Pakai Barang (Film / Media)
- Order Mutasi
- Stok Opname

---

### 10. Kamar Operasi
- Schedule Operasi
- Tindakan Operasi
- Pakai Barang
- Order Mutasi
- Stok Opname

---

### 11. Apotek
- Penjualan Obat
- Produksi / Racikan
- Retur Penjualan
- Stok Opname

---

### 12. Gudang Farmasi
- Material Request
- Mutasi Barang
- Goods Receive
- Stok Opname
- Musnah Barang

---

### 13. Pengadaan Barang
- Purchase Order
- Faktur Tagihan

---

## 4. Prinsip Domain yang Digunakan

1. **Actor-centric UI**
   - Screen mengikuti aktivitas kerja actor

2. **Staff vs Kepala**
   - Staff: input & operasional
   - Kepala: approval & monitoring

