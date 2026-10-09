# OUTCOME: PreOperativeClearance (Persiapan & Verifikasi Kesiapan Pra-Bedah)

| Field       | Value                    |
|-------------|--------------------------|
| Code        | OC-KMO-PREOP-CLEARANCE   |
| Version     | 1.0                      |
| Status      | Draft                    |
| LastUpdated | 2026-10-10               |

---

## 1. Business Purpose

Rumah sakit harus mampu mencatat, memvalidasi, memverifikasi, dan memelihara status kesiapan serta kelayakan pra-bedah pasien (*Pre-Operative Readiness & Clearance*) secara resmi sebagai fakta bisnis persisten (*persisted business fact*).

Pencatatan *PreOperativeClearance* memastikan bahwa seluruh prasyarat keselamatan operasional pra-bedah—meliputi verifikasi identitas dan lokasi pembedahan (*patient & surgical site verification*), konfirmasi persetujuan tindakan medis (*informed consent*), kelayakan anestesi (*pre-anesthesia clearance*), persiapan fisik pasien, serta ketersediaan darah dan alat/implan khusus—telah terverifikasi secara akuntabel sebelum pasien dipindahkan atau dimasukkan ke dalam ruang operasi untuk pelaksanaan prosedur bedah (*KMO-OPR*).

Fakta Kesiapan Pra-Bedah ini merupakan fondasi operasional yang esensial untuk:
1. **Keselamatan Pasien (Patient Safety Gate)**: Menjadi gerbang verifikasi mutlak (*hard gate*) guna mencegah salah pasien, salah lokasi bedah, atau salah prosedur operasi.
2. **Kepatuhan Regulasi & Aspek Legal**: Memastikan persetujuan tindakan medis (*informed consent*) dan asesmen pra-anestesi telah terdokumentasi dan terverifikasi secara sah.
3. **Kesiapan Logistik & Medis**: Memastikan ketersediaan kantong darah, alat khusus (misal: C-Arm, instrumen khusus), serta reservasi ruang perawatan intensif pasca-bedah (ICU/HCU) bila dipersyaratkan.
4. **Otorisasi Pelaksanaan Bedah**: Menyediakan dasar otorisasi resmi bagi tim kamar bedah untuk memulai tindakan operasi (*KMO-OPR*).
5. **Penanganan Kasus Darurat (Emergency Cito Override)**: Menyediakan alur bypassing resmi yang teraudit untuk operasi darurat (*Cito*) di mana kelayakan pra-bedah di-override oleh dokter operator utama demi menyelamatkan nyawa pasien.

---

## 2. Outcome Statement

Status kesiapan dan verifikasi kelayakan pra-bedah pasien atas jadwal operasi yang sah telah terkonfirmasi dan tercatat secara resmi sebagai fakta bisnis persisten (`Pre-Operative Readiness / Clearance exists`) dengan status `CLEARED` atau `EMERGENCY_OVERRIDDEN`, yang menjadi prasyarat otorisasi sebelum pelaksanaan tindakan operasi (`KMO-OPR`) dapat dimulai.

---

## 3. Participating Domains

Berdasarkan arsitektur fungsional sistem MyHosWeb, Outcome ini memiliki **tepat satu Primary Domain** dengan Contributing Domains pendukung:

| Domain | Peran dalam Outcome ini |
|--------|-------------------------|
| **Kamar Operasi** (`KMO`) | **Primary Domain (Pemilik Utama):** Bertanggung jawab atas pengelolaan kesiapan pra-bedah (`KMO-PREOP`), pelaksanaan checklist verifikasi keselamatan, otorisasi gerbang operasi, serta mengonsumsi data dari `KMO-ORDER` dan `KMO-JADWAL`. |
| **Pasien** (`PAS`) | **Contributing Domain:** Menyediakan data identitas demografi resmi dan nomor rekam medis pasien yang sah melalui `PAS-DATSOS`. |
| **Admission** (`ADM`) | **Contributing Domain:** Menyediakan konteks administratif episode registrasi kunjungan aktif pasien (`RegId` aktif melalui `ADM-REG`) serta menerima pembaruan tahapan perjalanan pasien melalui `ADM-TRACKER`. |
| **Organisasi** (`ORG`) | **Contributing Domain:** Menyediakan master data kamar bedah fisik melalui `ORG-LAYANAN` serta kredensial PPA (Dokter Operator, Dokter Anestesi, Perawat Penata) melalui `ORG-PPA`. |

> **Catatan Batasan Domain:**
> Sesuai keputusan arsitektur, peninjauan hasil pemeriksaan diagnostik (laboratorium, radiologi) dan form klinis asesmen dilakukan secara klinis oleh PPA (offline/EMR review) tanpa pembentukan dependensi otomatis langsung pada outcome diagnostik.

---

## 4. Participating Capabilities

Seluruh kapabilitas divalidasi terhadap [`domain/DOMAIN-CATALOG.md`](file:///d:/Project.Aktif/b21-myhosweb-system/domain/DOMAIN-CATALOG.md) dan [`outcomes/outcome-capability-domain-v2.md`](file:///d:/Project.Aktif/b21-myhosweb-system/outcomes/outcome-capability-domain-v2.md):

| Capability | Domain | Status | Peran & Kontribusi |
|------------|--------|--------|---------------------|
| `KMO-PREOP` Persiapan Operasi | Kamar Operasi | Known | **Primary Capability:** Mengelola verifikasi kesiapan pra-bedah pasien, merekam item checklist keselamatan, menetapkan keputusan clearance, dan menangani emergency override. |
| `KMO-JADWAL` Jadwal Operasi | Kamar Operasi | Known | Menyediakan referensi jadwal operasi aktif (`JadwalOk`) yang menjadi basis verifikasi pra-bedah. |
| `KMO-ORDER` Order Operasi | Kamar Operasi | Known | Menyediakan rujukan permintaan operasi resmi (`OrderOk`) untuk pembaruan status siklus hidup kunjungan pra-bedah. |
| `PAS-DATSOS` Data Sosial Pasien | Pasien | Known | Menyediakan identitas pasien (Nomor RM, nama, jenis kelamin, tanggal lahir) yang diverifikasi. |
| `ADM-REG` Registration | Admission | Known | Memastikan episode kunjungan pasien berstatus aktif selama proses verifikasi kesiapan pra-bedah. |
| `ADM-TRACKER` Pasien Tracker | Admission | Known | Menerima peristiwa pembaruan status kelayakan pra-bedah untuk visibilitas alur perjalanan pasien (*Patient Journey*). |
| `ORG-PPA` Petugas Pemberi Asuhan | Organisasi | Known | Menyediakan data kredensial dokter operator, dokter anestesi, dan perawat penanggung jawab verifikasi. |

---

## 5. Outcome Specification

### 5.1 Required Business Facts

Pre-Operative Clearance (*PreOperativeClearance*) dianggap terwujud (*established*) jika fakta bisnis berikut terbukti ada:

1. **Eksistensi Catatan Clearance Unik**:
   - Terbentuk satu catatan verifikasi kesiapan pra-bedah unik dengan identifier resmi (*ClearanceId*) yang tersimpan secara persisten.
2. **Keterikatan Mutlak pada Jadwal & Order Aktif**:
   - Clearance terikat secara valid pada tepat 1 (satu) entitas `JadwalOk` aktif (`JadwalOkId` berstatus `ACTIVE`) dan `OrderOk` terkait (`OrderOkId`).
3. **Verifikasi Checklist Kesiapan Operasional Pra-Bedah**:
   - Verifikasi Identitas Pasien & Prosedur: Konfirmasi kesesuaian identitas pasien, rencana prosedur pembedahan, dan penandaan lokasi bedah (*site marking*).
   - Verifikasi Persetujuan Tindakan Medis (*Informed Consent*): Konfirmasi keberadaan dokumen persetujuan tindakan medis pra-bedah yang sah.
   - Verifikasi Kelayakan Anestesi (*Pre-Anesthesia Clearance*): Konfirmasi status rekomendasi dari dokter spesialis anestesi.
   - Verifikasi Persiapan Fisik Pasien: Konfirmasi puasa, persiapan kulit/pencukuran, pembersihan perhiasan/prostesa, dan pemberian obat pra-bedah bila dipersyaratkan.
   - Verifikasi Ketersediaan Logistik & Darah: Konfirmasi kesiapan kantong darah (bila ada order darah) dan instrumen/implan khusus.
4. **Keputusan Status Clearance Definitif**:
   - Catatan memiliki status siklus hidup yang eksplisit:
     - `PENDING_CLEARANCE`: Verifikasi checklist sedang berjalan.
     - `CLEARED`: Seluruh elemen checklist pra-bedah terverifikasi memenuhi syarat.
     - `CANCELLED_NOT_CLEARED`: Pasien dinyatakan tidak layak/tidak siap atau pembedahan dibatalkan.
     - `EMERGENCY_OVERRIDDEN`: Elemen checklist pra-bedah di-override secara eksplisit untuk kasus darurat *Cito*.
5. **Akuntabilitas Verifikator & Otorisasi**:
   - Teridentifikasi PPA penanggung jawab verifikasi (Perawat Kamar Bedah / Perawat Anestesi) serta dokter penanggung jawab (Operator Utama / Dokter Anestesi).
6. **Pencatatan Alasan & Otorisasi Emergency Override (khusus Cito)**:
   - Jika status `EMERGENCY_OVERRIDDEN`, wajib terdeteksi alasan medis darurat, stempel waktu, serta identitas Dokter Operator/Anestesi yang memicu override.

---

### 5.2 Required Recorded Information

Setiap entitas `PreOperativeClearance` wajib mencatat informasi bisnis berikut:

#### A. Identifikasi Clearance & Referensi Konteks:
- **`ClearanceId`**: Nomor unik identitas catatan pre-operative clearance.
- **`JadwalOkId`**: Nomor unik jadwal operasi (`JadwalOk`) yang diverifikasi.
- **`OrderOkId`**: Nomor unik permintaan kamar operasi (`OrderOk`) terkait.
- **`RegId`**: Nomor unik registrasi kunjungan aktif pasien (`ADM-REG`).
- **Identitas Pasien**: Nomor Rekam Medis (Nomor RM), nama lengkap, jenis kelamin, dan tanggal lahir.
- **Rencana Prosedur Bedah & Lokasi**: Prosedur bedah yang dijadwalkan dan penandaan lokasi tubuh (*site marking side/laterality*).

#### B. Hasil Verifikasi Checklist Kesiapan Pra-Bedah:
- **Status Verifikasi Pasien & Prosedur**: `VERIFIED` / `FAILED`
- **Status Informed Consent Bedah & Anestesi**: `VERIFIED` / `FAILED` / `PENDING`
- **Status Pre-Anesthesia Clearance**: `CLEARED` / `NOT_CLEARED` / `PENDING`
- **Status Persiapan Fisik Pasien**: Konfirmasi jam mulai puasa, persiapan area operasi, dan pemberian premedikasi.
- **Status Ketersediaan Darah & Implan**: Konfirmasi kesiapan darah (jumlah kantong & jenis) serta alkes/implan khusus.

#### C. Keputusan Final & Akuntabilitas PPA:
- **Status Clearance**: `PENDING_CLEARANCE` | `CLEARED` | `CANCELLED_NOT_CLEARED` | `EMERGENCY_OVERRIDDEN`.
- **Petugas Verifikator**: Identitas Perawat/PPA yang melakukan verifikasi checklist (`ORG-PPA`).
- **Dokter Penanggung Jawab**: Identitas Dokter Operator Utama dan/atau Dokter Anestesi (`ORG-PPA`).
- **Stempel Waktu Completion**: Tanggal dan jam keputusan clearance ditetapkan.

#### D. Detail Emergency Override (Wajib terisi jika `EMERGENCY_OVERRIDDEN`):
- **Dokter Otorisasi Override**: Identitas Dokter Operator / Anestesi yang menyetujui override darurat.
- **Alasan Medis Darurat Cito**: Deskripsi rasional medis pemicu override (misal: pendarahan masif darurat, ancaman jiwa langsung).
- **Stempel Waktu Override**: Jam dan tanggal eksekusi override darurat.

#### E. Detail Pembatalan / Un-cleared (Wajib terisi jika `CANCELLED_NOT_CLEARED`):
- **Alasan Tidak Layak / Batal**: Kategori alasan (misal: kondisi umum pasien memburuk/hemodinamik tidak stabil, penolakan tindakan oleh keluarga, puasa belum cukup, kelainan hasil pemeriksaan mendadak).
- **Petugas Pencatat Batal**: Identitas PPA yang mencatat status tidak layak.

---

### 5.3 Required Business Conditions

1. **Keabsahan Jadwal & Order OK**:
   - PreOperativeClearance mutlak mensyaratkan entitas `JadwalOk` berstatus `ACTIVE` dan `OrderOk` berstatus `Scheduled`.
2. **Kardinalitas 1-to-1 per Jadwal Operasi**:
   - Satu entitas `JadwalOk` hanya dapat memiliki maksimal 1 (satu) entitas `PreOperativeClearance` yang berstatus aktif (`CLEARED`, `PENDING_CLEARANCE`, atau `EMERGENCY_OVERRIDDEN`).
3. **Pemberlakuan Hard Gate Sebelum Operasi (Invarian Utama)**:
   - Pelaksanaan tindakan operasi di `KMO-OPR` menuntut keberadaan `PreOperativeClearance` berstatus `CLEARED` atau `EMERGENCY_OVERRIDDEN`. Prosedur operasi tidak dapat dimulai tanpa terenuhinya gate ini.
4. **Kebijakan Emergency Override untuk Kasus Cito**:
   - Pada kondisi gawat darurat (*Cito*), Dokter Operator Utama atau Dokter Anestesi berwenang memutus verifikasi pra-bedah dengan menetapkan status `EMERGENCY_OVERRIDDEN`, disertai kewajiban merekam alasan medis darurat.
5. **Sinkronisasi Siklus Hidup OrderOK**:
   - Penetapan status `CLEARED` atau `EMERGENCY_OVERRIDDEN` secara otomatis mengodekan status siklus hidup `OrderOk` menjadi **`Siap Operasi (Ready for Surgery)`**.
   - Penetapan status `CANCELLED_NOT_CLEARED` mengembalikan status `OrderOk` menjadi **`Diajukan (Requested)`** atau **`Ditinjau Ulang`**, serta menandai `JadwalOk` untuk evaluasi/pembatalan.
6. **Imutabilitas Pasca-Operasi Berjalan**:
   - Catatan `PreOperativeClearance` berstatus `CLEARED` atau `EMERGENCY_OVERRIDDEN` tidak dapat diubah atau dibatalkan apabila tindakan operasi di `KMO-OPR` telah dimulai (*In Progress*).

---

### 5.4 Completion Proof

Outcome ini dinyatakan lengkap dan terbukti terbentuk apabila:
1. Catatan clearance tersimpan secara persisten dengan nomor unik `ClearanceId` dan status `CLEARED` atau `EMERGENCY_OVERRIDDEN`.
2. Status `OrderOk` terkait tersinkronisasi menjadi `Siap Operasi (Ready for Surgery)`.
3. Peristiwa kesiapan pra-bedah tercatat pada riwayat perjalanan pasien di `ADM-TRACKER`.
4. Otorisasi kesiapan pra-bedah secara sah dapat dikonsumsi oleh kapabilitas pelaksanaan operasi (`KMO-OPR`) untuk memulai prosedur pembedahan.

---

## 6. Outcome Boundary

### 6.1 Start Boundary (Titik Awal)

- **Dimulai saat:** Pasien tiba di area penerimaan kamar bedah (*holding area*) atau bangsal pra-bedah, dan perawat/PPA membuka jadwal operasi aktif (`JadwalOk` berstatus `ACTIVE`) untuk memulai verifikasi kelayakan pra-bedah.

### 6.2 End Boundary (Titik Akhir)

- **Berakhir saat:** Seluruh elemen checklist keselamatan pra-bedah terverifikasi dan disimpan secara persisten dengan status `CLEARED` (atau `EMERGENCY_OVERRIDDEN` untuk kasus Cito), serta status `OrderOk` tersinkronisasi menjadi `Ready for Surgery`.

---

## 7. Business Constraints

1. **Invarian Gerbang Otentikasi Keselamatan Bedah**:
   - Pelaksanaan pembedahan di `KMO-OPR` tidak diperkenankan berjalan tanpa keberadaan entitas `PreOperativeClearance` aktif yang berstatus `CLEARED` atau `EMERGENCY_OVERRIDDEN`.
2. **Akuntabilitas Otorisasi Override**:
   - Emergency override tidak dapat dilakukan oleh staf administratif; override mutlak membutuhkan otorisasi kredensial PPA (Dokter Operator atau Dokter Anestesi).
3. **Pemisahan Semantik Form Klinis vs Operational Clearance**:
   - Outcome ini mengelola fakta bisnis kesiapan operasional pra-bedah, bukan menyimpan dokumen rekam medis klinis mendalam (seperti lembar anamnesis atau grafik pemantauan anestesi yang dimiliki domain EMR).
4. **Audit Trail Non-Destructive**:
   - Seluruh perubahan verifikasi dan pencatatan override tersimpan secara permanen tanpa penghapusan fisik (*no hard delete*).

---

## 8. Business Exceptions

| Pengecualian | Kondisi Pemicu | Perilaku yang Diharapkan (Expected Behavior) |
|---|---|---|
| **EX-01: JadwalOK Tidak Aktif atau Tidak Ditemukan** | Pengguna berupaya melakukan clearance tanpa referensi `JadwalOkId` yang sah, atau status jadwal `CANCELED`. | Sistem menolak pembuatan clearance dan memberikan notifikasi bahwa verifikasi pra-bedah hanya dapat dilakukan pada jadwal operasi aktif. |
| **EX-02: Checklist Tidak Lengkap Tanpa Emergency Override** | Pengguna mencoba menyelesaikannya sebagai `CLEARED` padahal ada poin kritis (seperti Informed Consent) yang berstatus `FAILED` / `PENDING`. | Sistem menolak penetapan status `CLEARED` dan mewajibkan penyelesaian checklist atau penggunaan jalur `EMERGENCY_OVERRIDDEN` oleh DPJP. |
| **EX-03: Otorisasi Override Oleh PPA Tidak Berwenang** | Pengguna non-DPJP / non-dokter mencoba memicu status `EMERGENCY_OVERRIDDEN`. | Sistem memblokir eksekusi dan mewajibkan otentikasi kredensial dokter operator/anestesi yang berwenang. |
| **EX-04: Pasien Tidak Layak / Kondisi Memburuk (Un-cleared)** | PPA menentukan pasien tidak layak operasi akibat hemodinamik tidak stabil atau kendala medis mendadak. | Sistem mengubah status clearance menjadi `CANCELLED_NOT_CLEARED`, merekam alasan tidak layak, memperbarui status `JadwalOk` & `OrderOk` untuk tinjauan klinis ulang. |
| **EX-05: Modifikasi Clearance Saat Operasi Telah Berjalan** | Pengguna mencoba mengubah data clearance setelah prosedur pembedahan di `KMO-OPR` dimulai. | Sistem menolak secara mutlak (Hard Block) perubahan clearance karena operasi telah dalam pelaksanaan. |

---

## 9. Acceptance Criteria

| # | Kriteria Verifikasi | Memvalidasi |
|---|---------------------|-------------|
| **AC-01** | Sistem berhasil mencatat entitas PreOperativeClearance baru dengan `ClearanceId` unik, terikat pada `JadwalOkId` aktif, dan menyimpan hasil verifikasi checklist keselamatan pra-bedah. | Completeness & Linking |
| **AC-02** | Penetapan status `CLEARED` berhasil jika seluruh poin verifikasi checklist terpenuhi dan di otorisasi oleh PPA penanggung jawab. | Correctness (Standard Clearance) |
| **AC-03** | Penetapan status `EMERGENCY_OVERRIDDEN` berhasil untuk kasus Cito apabila diotorisasi oleh Dokter Operator/Anestesi disertai pengisian alasan medis darurat. | Emergency Policy (Cito Override) |
| **AC-04** | Keberhasilan penetapan `CLEARED` atau `EMERGENCY_OVERRIDDEN` secara otomatis memperbarui status `OrderOk` menjadi `Siap Operasi (Ready for Surgery)` dan merekam event pada `ADM-TRACKER`. | Lifecycle Synchronization |
| **AC-05** | Modul pelaksanaan operasi (`KMO-OPR`) menolak pemulaian tindakan pembedahan jika entitas PreOperativeClearance belum berstatus `CLEARED` atau `EMERGENCY_OVERRIDDEN`. | Downstream Invariant Gate |
| **AC-06** | Penetapan status `CANCELLED_NOT_CLEARED` berhasil merekam alasan ketidaklayakan pasien dan mengembalikan `OrderOk` untuk evaluasi klinis ulang. | Exception & Rollback Handling |
| **AC-07** | Pembatalan pada entitas `JadwalOk` secara otomatis menonaktifkan proses clearance terkait yang belum selesai. | Two-Way Synchronization |
| **AC-08** | Seluruh perubahan status dan pencatatan emergency override terekam secara permanen dalam jejak audit system (*audit trail*). | Auditability |

---

## 10. Out of Scope

> Aspek-aspek berikut secara eksplisit berada di luar lingkup tanggung jawab Outcome `PreOperativeClearance`:

- **Formulir & Catatan Rekam Medis Klinis Detail:** Pengisian detail anamnesis pra-bedah, pencatatan fisik lengkap, dan lembar asesmen pra-anestesi mendalam (merupakan wewenang EMR).
- **Penjadwalan & Alokasi Ruang Bedah:** Penetapan slot waktu, alokasi fisik kamar bedah, dan penugasan tim (merupakan wewenang `KMO-JADWAL` / Outcome *JadwalOk*).
- **Pelaksanaan Prosedur Bedah Intra-Operatif:** Pencatatan waktu insisi, laporan pembedahan, dan pemantauan intra-anestesi (merupakan wewenang `KMO-OPR`).
- **Pemulihan Pasca-Bedah (PACU / Recovery):** Observasi pasca-operasi dan kelayakan transfer ke bangsal/ICU (merupakan wewenang `KMO-RECOVERY`).
- **Pembebanan Biaya & Billing:** Penagihan biaya persiapan pra-bedah atau alkes (merupakan wewenang `TRK-BILLING`).
