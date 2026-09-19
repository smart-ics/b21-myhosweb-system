# MyHopsital

## Hierarchy

1. Modul
2. Context
3. Domain

4. SubDomain / Aggregate
SubDomain = Model behubungan secara logical/struktural tapi detilnya bisa di-reference secara langsung oleh model external
Aggregate = Model berhubungan secara header-detil dan detil tidak bisa direference secara langsung oleh model external

5. Model - UseCase
Master yang terelasi secara SubDomain maupun Aggregate tidak menyimpan composit mandatory field, hanya composit key saja
Transaksional menyimpan composit key dan composit mandatory field

## Project

1. pasien-api
2. admisi-api
3. revenue-api
4. payment-api
5. stok-api
6. purchasing-api
7. penjualan-api

## Billing Modul

1. Pasien Context
    1. StatusSosialDomain
        1. SukuModel
            - SukuId
            - SukuName
            1. CreateSukuCommand (SukuId, SukuName)
            2. UpdateSukuCommand (SukuId, SukuName)
            3. DeleteCommand (SukuId)
            4. GetSukuQuery (SukuId)
            5. ListSukuQuery()

        2. AgamaModel
            - AgamaId
            - AgamaName
            1. CreateAgamaCommand (AgamaId, AgamaName)
            2. UpdateAgamaCommand (AgamaId, AgamaName)
            3. DeleteAgamaCommand (AgamaId)
            4. GetAgamaQuery (AgamaId)
            5. ListAgamaQuery

        3. PendidikanModel
            - PendidikanId
            - PendidikanName
            1. GetPendidikanQuery (PendidikanId)
            2. ListPendidikanQuery ()
            3. DownloadPendidikanCommand

        4. PekerjaanModel
            - PekerjaanId
            - PekerjaanName
            1. GetPekerjaanQuery (PekerjaanId)
            2. ListPekerjaanQUery ()
            3. DownloadPekerjaanCommand ()

        5. StatusNikahModel
            - StatusNikahId
            - StatusNikahName
            1. GetPendidikanQuery
            2. ListPendidikanQUery
            3. DownloadStatusNikahCommand

    2. DemografiDomain
        1. PropinsiModel
            - PropinsiId
            - PropinsiName
            1. GetPropinsiQuery(PropinsiId)
            2. ListPropinsiQuery ()

        2. KabupatenModel
            - KabupatenId
            - KabupatenName
            - PropinsiId
            - PropinsiName
            1. GetKabupatenQuery (KabupatenId)
            2. ListKabupatenQuery (PropinsiId)

        3. KecamatanModel
            - KecamatanId
            - KecamatanName
            - KabupatenId
            - KabupatanName
            - PropinsiId
            - PropinsiName
            1. GetKecamatanQuery (KecamatanId)
            2. ListKecamatanQuery (KabupatenId)

        4. KelurahanModel
            - KelurahanId
            - KelurahanName
            - KecamatanId
            - KecamatanName
            - KabupatenId
            - KabupatenName
            - PropinsiId
            - PropinsiName
            1. GetKelurahanQuery (KelurahanId)
            2. ListKelurahanQuery (KecamatanId)
            3. SearchKelurahan (KelurahanName)
            4. DownloadKelurahanCommand ()

        5. KotaModel
            - KotaId
            - KotaName
            - KabupatenId
            1. CreateKotaCommand (KotaId, KotaName, KabupatenId)
            2. UpdateKotaCommand (KotaId, KotaName, KabupatenId)
            3. DeleteKodeCommand (KotaId)
            4. GetKotaQuery (KotaId)
            5. ListKotaQuery ()

        6. NegaraModel
            - NegaraId
            - NegaraName
            - EnglishName
            - Alpha3Code
            - NumericCode
            1. GetNegaraQuery (NegaraId)
            2. SearchNegaraQuery (NegaraName)
            3. DownloadNegaraCommand ()

    3. PasienInfoDomain
        1. PasienModel
            - PasienId (PK)
            - PasienName
            - TglLahir
            - Gender
            - IbuKandung
            1. CreatePasienCommand (PasienName, TglLahir, Gender, IbuKandung)
            2. ChangePasienCommand (PasienName, TglLahir, Gender, IbuKandung)
            3. MergePasienCommand (MainPasienId, List[PasienId])
            4. DeactivatePasienCommand (PasienId)
            5. GetPasienQuery (PasienId)
            6. ListPasienQuery (TglLahir)

        2. PasienAddress
            - PasienId (UQ)
            - Alamat
            - Alamat2
            - Alamat3
            - KotaName
            - KelurahanId
            - KecamatanName
            - KabupatenName
            - PropinsiName
            - NegaraId
            - NegaraName
            - Nationality
            - PostalCode
            1. SetPasienAddressCommand (PasienId, Alamat, Alamat2, Alamat3, KotaName, KelurahanId, PostalCode)
            2. SetNegaraPasienCommand (PasienId, NegaraId)
            3. DeletePasienAddressCommand (PasienId)
            4. GetPasienAddressQuery (PasienId)

        3. PasienIdentityModel
            - PasienId (FK)
            - IdType
            - IdNumber
            1. AddPasienIdentityCommand (PasienId, IdType, IdNumber)
            2. RemovePasienIdentityCommand (PasienId, IdType)
            3. ListPasienIdentity (PasienId)

        4. PasienSosialModel
            - PasienId (UQ)
            - StatusNikahId
            - AgamaId
            - SukuId
            - PekerjaanId
            - PendidikanId
            1. SetPasienSosialCommand (PasienId, StatusNikahId, AgamaId, SukuId, PekerjaanId, PendidikanId)
            2. DeletePasienSosialCommand (PasienId)
            3. GetPasienSosialQUery (PasienId)

        5. PasienKeluargaModel
            - PasienId (UQ)
            - KeluargaName
            - Hubungan
            - Alamat
            - Kota
            - NoTelpon
            1. SetPasienKeluargaCommand (PasienId, KeluargaName, Hubungan, Alamat, Kota, NoTelpon)
            2. DeletePasienKeluargaCommand (PasienId)
            3. GetPasienKeluargaQuery (PasienId)

        6. PasienContactModel
            - PasienId (FK)
            - ContactType
            - ContactNo
            1. AddPasienContactCommand (PasienId, ContactType, ContactNo)
            2. RemovePasienContactCommand (PasienId, ContactType)
            3. ListPasienCOntactQuery (PasienId)

2. AdmisiContext
    1. StrukturalDomain
        1. LocationSubDomain
            1. GedungModel
                - GedungId (PK)
                - GedungName
                1. CreateGedungCommand (GedungId, GedungName)
                2. ChangeGedungCommand (GedungId, GedungName)
                3. DeleteGedung (GedungId)
                4. GetGedung (GedungId)
                5. ListGedung ()

            2. LantaiModel
                - LantaiId (PK)
                - LantaiName
                - GedungId
                - GedungName
                1. CreateLantaiCommand (LantaiId, LantaiName, GedungId)
                2. ChangeLantaiCommand (LantaiId, LantaiName, GedungId)
                3. DeleteLantai (LantaiId)
                4. GetLantai (LantaiId)
                5. ListLantai (GedungId)

            3. BagianModel
                - BagianId (PK)
                - BagianName
                - LantaiId
                - LantaiName
                - GedungName
                1. CreateBagianCommand (BagianId, BagianName, LantaiId)
                2. ChangeBagianCommand (BagianId, BagianName, LantaiId)
                3. DeleteBagianCommand (BagianId)
                4. GetBagianQuery (BagianId)
                5. ListBagianQuery (LantaiId)

            4. RuanganModel
                - RuanganId (PK)
                - RuanganName (MF)
                - BagianId (FK)
                - BagianName
                - LantaiName
                - GedungName
                1. CreateRuanganCommand (RuanganId, RuanganName, BagianId)
                2. ChangeRuanganCommand (RuanganId, RuanganName, BagianId)
                3. DeleteRuanganCommand (RuanganId)
                4. GetRuanganQuery (RuanganId)
                5. ListRuanganQuery (LantaiId)

        2. Organisation SubDomain
            1. InstalasiDkModel
                - InstalasiDkId
                - InstalasiDkName
                1. GetInstalasiDkQuery (InstalasiDkId)
                2. ListInstalasiDkQUery ()

            2. InstalasiModel
                - InstalasiId
                - InstalasiName
                - InstalasiDkId
                - InstalasiDkName
                1. CreateInstalasiCommand (InstalasiId, InstalasiName, InstalasiDkId)
                2. ChangeInstalasiCommand (InstalasiId, InstalasiName, InstalasiDkId)
                3. DeleteInstalasiCommand (InstalasiId)
                4. GetInstalasi (InstalasiId)
                5. ListInstalasi ()
                6. ListByInstalasiDk(InstalasiDkId)

            3. LayananDkModel
                - LayananDkId
                - LayananDkName
                1. GetLayananDkQuery (LayananDkId)
                2. ListLayananDk ()

            4. LayananTipeModel
                - LayananTipeId
                - LayananTipeName
                1. GetLayananTipe(LayananTipeId)
                2. ListLayananTipe()

            5. Layanan Model
                - LayananId
                - LayananName
                - InstalasiId
                - InstalasiName
                - LayananDkId
                - LayananDkName
                - LayananTipeId
                - LayananTipeName
                1. CreateLayananCommand (LayananId, LayananName, InstalasiId)
                2. ChangeLayanan (LayananId, LayananName, InstalasiId)
                3. SetLayananDkLayananCommand (LayananId, LayananDkId)
                4. SetLayananTipeLayananCommand (LayananId, LayananTipeId)
                5. DeleteLayananCommand (LayananId)
                6. GetLayananQuery (LayananId)
                7. ListLayananQuery ()

    2. MarketingDomain
        1. AsuransiSubDomain
            1. GrupJaminanModel
                - GrupJaminanId
                - GrupJaminanName
                - IsKaryawan
                - Keterangan
                1. CreateGrupJaminanCommand (GrupJaminanId, GrupJaminanName, IsKaryawan, Keterangan)
                2. ChangeGrupJaminanCommand (GrupJaminanId, GrupJaminanName, IsKaryawan, Keterangan)
                3. DeleteGrupJaminanCommand (GrupJaminanId)
                4. GetGrupJaminanQuery (GrupJaminanId)
                5. ListGrupJaminanQuery ()

            2. JaminanModel
                - JaminanId
                - JaminanName
                - Alamat
                - Alamat2
                - Kota
                - CaraBayarDkId
                - Benefit
                - ContactPerson
                - NoTelp
                - TglBerlaku
                - TglExpired
                1. CreateJaminanCommand (JaminanId, JaminanName, Alamat, Alamat2, Kota, CaraBayarDkId)
                2. ChangeJaminanCommand (JaminanId, JaminanName, Alamat, Alamat2, Kota, CaraBayarDkId)
                3. SetContactPersonJaminanCommand (JaminanId, ContactPerson, NoTelp)
                4. SetPeriodeKerjaSamaJaminanCommand (JaminanId, TglBerlaku, TglExpired)
                5. SetBenefitJaminanCommand (JaminanId, Benefit)
                6. DeleteJaminanCommand (JaminanId)
                7. GetJaminanQuery (JaminanId)
                8. ListJaminanQuery ()
                9. ListDeactiveJaminanQuery ()

            3. TipeJaminanModel
                - TipeJaminanId
                - TipeJaminanName
                - JaminanId
                - JaminanName
                - IsAktif
                1. CreateTipeJaminanCommand (TipeJaminanId, TipeJaminanName, JaminanId, IsAktif)
                2. ChangeTipeJaminanCommand (TipeJaminanId, TipeJaminanName, JaminanId, IsAktif)
                3. DeleteTipeJaminanCommand (TipeJaminanId)
                4. GetTipeJaminanQuery (TipeJaminanId)
                5. ListTipeJaminanQuery (JaminanId)

            4. PolisAggregate
                - PolisModel
                    - PolisId
                    - TipeJaminanId
                    - NoPolis
                    - AtasNama
                    - ExpiredDate
                    - KelasInap
                    - IsRajal
                - PolisCoverModel
                    - PolisId
                    - PasiendId
                    - StatusPeserta
                    - ExpiredDate
                1. CreatePolisCommand (PasienId, TipeJaminanId, NoPolis, AtasNama, KelasInap, IsRajal)
                2. UpdatePolisCommand (POlisId, TipeJaminanId, NoPolis, AtasNama, KelasIap, IsRajal)
                3. DeletePolisCommand (PolisId)
                4. AddPesertaCommand (PolisId, PasienId, StatusPeserta)
                5. RemovePesertaCommand (PolisId, PasienId)
                6. GetPolisQuery (PolisId)
                7. SearchPolisQuery (PasienId, TipeJaminanId)

        2. RujukanSubDomain
            1. CaraMasukModel
                - CaraMasukId
                - CaraMasukName
                1. SeedCaraMasukCommand()
                2. GetCaraMasukQuery (CaraMasukId)
                3. ListCaraMasukQuery ()

            2. TipeRujukanModel
                - TipeRujukanId
                - TipeRujukanName
                1. SeedTipeRujukanCommand ()
                2. GetTipeRujukanQuery (TipeRujukanId)
                3. ListTipeRujukanQuery ()

            3. RujukanModel
                - RujukanId
                - RujukanName
                - Alamat
                - Alamat2
                - Kota
                - NoTelp
                - TipeRujukanId
                - KelasRs
                - PegId
                - IsDokterLuar
                1. CreateRujukanCommand (RujukanId, RujukanName, TipeRujukanId, CaraMasukId)
                2. UpdateRujukanCommand (RujukanID, RujukanName, TipeRujukanID, CaramKasukId)
                3. SetDokterInternalRujukanCommand (RujukanId, PegId)
                4. DeleteRujukanCommand (RujukanId)
                5. GetRujukanCommand (RujukanId)
                6. ListRujukanQuery ()

    3. RegistrasiDomain
        1. JadwalPraktekSubDomain
            1. JadwalMingguanAggregate
                - JadwalMingguankModel
                    - JadwalMingguanId
                    - DokterId
                    - LayananId
                - JadwaMingguanWaktuModel
                    - JadwalMingguanId
                    - NoUrut
                    - Hari
                    - JamMulai
                    - JamSelesai
                    - MaxPasien
                    - RuangId
                    - PolaAntrian
                1. CreateJadwalMingguanCommand (DokterId, LayananId, Hari, JamMulai, JamSelesai)
                2. RemoveJadwalMingguanCommand (JadwalMingguanId, Hari, JamMulai)
                3. SetRuangPraktekCommand (JadwalMingguankId, NoUrut, RuangId)
                4. SetPolaAntrianCommand (JadwalMingguanId, NoUrut, PolaAntrian)
                5. GetJadwalMingguanQuery (JadwalMingguanId)
                6. ListJadwalMingguanQuery (DokterId)

            2. JadwalTglModel
                - JadwalTglId
                - DokterId
                - LayananID
                - Tgl
                - JamMulai
                - JamSelesai
                - MaxPasien
                - RuangId
                - PolaAntrian
                1. GenJadwalBulananCommand(JadwalMingguanId, Tgl)
                2. CreateJadwalBulananCommand (DokterId, LayananId, Tgl, JamMulai, JamSelesai, MaxPasien)
                3. SetRuangJadwalBulananCommand (JadwalTglId, RuangId)
                4. DeleteJadwalTglCommand (JadwalTglId)
                5. GetJadwalTglQuery (JadwalTglId)
                6. ListJadwalTglDokterQuery (DokterId, Tgl1, Tgl2)
                7. ListJadwalTglQUery (Tgl1, Tgl2)

            3. AntrianAggregate
                - AntrianHeaderModel
                    - AntrianId
                    - TglAntrian
                    - Tag1 (DokterId / LoketId)
                    - Tag2 (LayananId / JaminanId)
                    - Tag3 (JamMulai)
                    - PolaAntrian
                    - JumDetil
                - AntrianDetilModel
                    - AntrianId
                    - NoUrut
                    - PasienName
                    - PasienId
                    - BookingId
                    - RegId
                    - Flag
                1. AddAntrianCommand (Tgl, DokterId, LayananId)
                2. GetAntrianQuery (Tgl, DokterId, LayananId, NoUrut)
                3. ListAntrianDetilQuery (Tgl, DokterId, Layanan)
                4. ListAntrianQuery (Tgl)

        2. BookingSubDomain
            1. BookingAggregate
                - BookingModel
                    - BookingId
                    - TrsDate
                    - UserId
                    - UserName
                    - VoidDate
                    - VoidUserId
                    - VoidUserName
                    - AppointmentDate
                    - PasienId
                    - PasienName
                    - Alamat
                    - PhoneNo
                    - BirthDate
                    - Gender
                    - CaraBookingId
                    - RegId
                - BookingLayananModel
                    - BookingId
                    - LayananId
                    - DokterId
                    - JamMulai
                    - Hari
                    - NoAntrian
                - BookingBpjsModel
                    - BookingId
                    - NoPeserta
                    - NoRujukan
                1. BookingCommand(PasienId, AppointmentDate, LayananId, DokterId, JamMulai)
                2. BookingNewPasien(PasienName, Alamat, PhoneNo, Birthdate, Gender, AppointmentDate, LayananId, DokterId, JamMulai)
                3. CancelBookingCommand(BookingId, LayananId, DokterId)
                4. GetBookingQuery(BookingId)
                5. ListBookingQuery(AppointmentDate, LayananId, DokterId)

        3. RegSubDomain
            1. RegModel (Abstract)
                - RegId
                - TrsDate
                - UserId
                - UserName
                - VoidDate
                - VoidUserId
                - VoidUserName
                - RegDate
                - BookingId
                - PasienId
                - PasienName
                - CaraMasukId
                - KarcisId
                - KarcisName
                - NilaiKarcis
                - Jaminan : RegJaminanModel
                    - RegId
                    - TipeJaminanId
                    - PolisId
                    - NoPerserta
                    - NoSep
                - Rujukan : RegRujukanModel
                    - RegId
                    - RujukanId
                    - RujukanName
                    - RujukanDate
                    - DiagId
                    - DiagName
                    - UraianDokter
                1. GetRegQuery (PasienId)
                2. ListRegQuery (RegDate)
                3. VoidRegCommand (RegId)

            2. RegJalanAggregate
                - RegJalanModel : RegModel
                    - TarifId
                    - TarifName
                    - NilaiTindakan
                    - TindakanId
                    - List of RegJalanLayananModel
                - RegJalanLayananModel
                    - RegId
                    - LayananId
                    - LayananName
                    - DokterId
                    - DokterName
                    - NoAntrian
                1. CreateRegJalanCommand (PasienId, RegDate, CaraMasukId, KarcisId, Jaminan(TipeJaminanId), Rujukan(RujukanId) List[RegJalanLayananModel])
                2. ChangeJaminanRegCommad (RegId, JaminanId, PolisId, NoPeserta)
                3. ChangeRujukanRegCommad (RegId, CaraMasukId, RujukanId, RujukanDate, DiagId, DiagName, UraianDokter)
                4. CancelRujukanRegCommad (RegId)
                5. ListRegLayananQuery (RegDate, LayananId)

            3. RegJalanInapAggregate
                - RegInapUmumModel : RegModel
                    - BedId
                    - BedName
                    - KelasId
                    - KelasName
                    - LayananDkId
                    - LayananDkName
                    - TrsBedId
                - RegInapObstetriModel : RegInapModel
                - RegInapPerinatalModel : RegInapModel
                    - RegIbuId
                    - RegIbuName

                1. CreateRegInapCommand (PasienId, KelasId, BedId)
                2. ChangeToRegInapObstetriCommand (PasienId)
                3. ChangeToRegInapPerinatalCommand (PasienId, RegIdObstetri)

    4. BedManagementDomain
        1. BedStructureSubDomain
            1. BangsalModel
                - BangsalId
                - BangsalName
                - LayananId
                - LayananName
                1. CreateBangsalCommand (BangsalId, BangsalName, LayananId)
                2. UpdateBangsalCommand (BangsalId, BangsalName, LayananId)
                3. DeleteBangsalCommand (BangsalId)
                4. GetBangsalQuery (BangsalId)
                5. ListBangsalQuery ()

            2. KamarModel
                - KamarId
                - KamarName
                - BangsalId
                - KelasId
                - Description
                - IsAKtif
                - RuangId
                1. CreateKamarCommand (KamarId, KamarName, Description, BangsalId, KelasId)
                2. UpdateKamarCommand (KamarId, KamarName, Description, BangsalId, KelasId)
                3. DeactivateKamarCommand (KamarId)
                4. ActivateKamarCommand (KamarId)
                5. DeleteKamarCommand (KamarID)
                6. GetKamarQuery (KamarId)
                7. ListKamarQuery (BangsalId)
                8. MapRuangKamarCommand (KamarId, RuangId)

            3. BedModel
                - BedId
                - BedName
                - Description
                - KamarId
                1. CreateBedCommand (BedId, BedName, KamarId)
                2. UpdateBedCommand (BedId, BedName, KamarId)
                3. DeleteBedCommand (BedId)
                4. GetBedQUery (BedId)
                5. ListBedQuery (BangsalId)

        2. OccupancySubDomain
            1. BedUsageAggregate
                - BedUsageModel
                    - BedId
                    - LayananDkID
                    - Description
                    - StatusBed
                    - List[BedUsageRegModel]

                - BedUsageRegModel
                    - BedId
                    - RegID
                    - PakaiBedId
                    - LayananDkID
                    - IsShadow

                - PakaiBedModel
                    - PakaiBedId

                    - TrsDate
                    - UserId
                    - UserName
                    - VoidDate
                    - VoidUserId
                    - VoidUserName

                    - PakaiBedDate
                    - RegId
                    - BedId
                    - LayananId
                    - LayananDkId
                    - TipeKamarId
                    - KelasTindakanId

                1. PakaiBedCommand (BedId, RegId)
                2. KeluarBedCommand (PakaiBedId)
                3. CancelKeluarBedCommand (PakaiBedId)
                4. LoadShadowPakaiBedCommand (PakaiBedId)
                5. UnloadShadowPakaiBedCommand (PakaiBedId)
                6. CleanUpBedCommand (BedId, PetugasCleanUp)
                7. DeactivateBedCommand (BedId, Description)
                8. ActivateBedCommand (BedId)

3. BillContext
    0. TarifStructureDomain
        1. KomponenAggregate
            - KomponenModel
                - KomponenId
                - KomponenName
                - GrupKomponenId
                - GrupKomponenName
                - 
            - KomponenMedisModel
        2. GrupKomponenModel
        3. 
        2. TipeTarifModel
        3. KelasModel
        4. TrsBillAggregate
    1. TindakanDomain
        1. TarifAggregate
        2. TindakanSubDomain
    2. TransportDomain
        1. AmbulanceModel
        2. 
        1. TarifTranspo
    3. RoomCharge
    4. BiayaLain

4. Payment
    1. Deposit
        - Deposit Umum
        - Voucher
    2. Trs Kasir
    3. Regout

## Pharmacy

1. Inventory
    1 Barang
        1. 
    2 Stok
        1. Mutasi
        2. Adjustment
        3 Produksi

2. Purchasing
    - Analisa
    - Purchase Order
    - Penerimaan Brg
    - Faktur
    - Retur Beli
3. Penjualan
    - Resep
    - DU Bill
    - Retur Jual

## Medrec

1. Assesment
2. Chart
3. Resume Medis
4. Askep

## Accounting

1. GL
2. Hutang
3. Piutang

## Hrd

1. Kepegawaian
2. Attendance
3. Payroll
4. Tax

## Asset
