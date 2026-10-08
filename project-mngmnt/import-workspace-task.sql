-- =============================================================================
-- CAKRA Database Import: Workspace -> WorkPackage, Task -> Request
-- Generated from workspace-task.json
-- =============================================================================
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

-- 1. Resolve Product (MyHospital Web 'MHW')
DECLARE @ProductId UNIQUEIDENTIFIER;
SELECT TOP 1 @ProductId = Id FROM product.Products WHERE Code = 'MHW';
IF @ProductId IS NULL
    SELECT TOP 1 @ProductId = Id FROM product.Products ORDER BY CreatedAt ASC;

-- 2. Resolve Default Admin Person
DECLARE @AdminPersonId UNIQUEIDENTIFIER;
SELECT TOP 1 @AdminPersonId = Id FROM organization.Persons WHERE Email = 'admin@cakra.id';
IF @AdminPersonId IS NULL
    SELECT TOP 1 @AdminPersonId = Id FROM organization.Persons ORDER BY CreatedAt ASC;

IF @AdminPersonId IS NULL
BEGIN
    RAISERROR('No organization persons found in organization.Persons. Please run seed-persons.sql first.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END

-- 3. Helper Table for PIC Resolution (Strict 1:1 Primary Key)
DECLARE @PicMapping TABLE (PicName NVARCHAR(50) PRIMARY KEY, PersonId UNIQUEIDENTIFIER);
INSERT INTO @PicMapping (PicName, PersonId)
SELECT 'Arif', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'arif.hidayat@cakra.id' OR (FirstName = 'Arif' AND LastName = 'Hidayat'))
UNION ALL SELECT 'Fikri', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'fikri.haikal@cakra.id' OR FirstName = 'Fikri')
UNION ALL SELECT 'Erkoc', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'erkoc@email.com' OR Email = 'ernawan.sukoco@cakra.id' OR FirstName = 'Ernawan')
UNION ALL SELECT 'Rizal', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'rizal.aditya.pratama@cakra.id' OR FirstName LIKE 'Rizal%')
UNION ALL SELECT 'Sulis', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'sulistiyarno@cakra.id' OR LastName = 'Sulistiyarno')
UNION ALL SELECT 'We', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'wahyu.widanarto@cakra.id' OR (FirstName = 'Wahyu' AND LastName = 'Widanarto'))
UNION ALL SELECT 'Arie', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'arie.haryanto@cakra.id' OR FirstName = 'Arie')
UNION ALL SELECT 'Roso', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'roso.wahono@cakra.id' OR FirstName = 'Roso')
UNION ALL SELECT 'Jude', @AdminPersonId
UNION ALL SELECT 'All PICs', @AdminPersonId;

DECLARE @ImportTime DATETIME2 = SYSUTCDATETIME();
DECLARE @WorkPackagesCount INT = 0;
DECLARE @RequestsCount INT = 0;
DECLARE @LinksCount INT = 0;

-- Temporary table for staged WorkPackages
DECLARE @StagedWorkPackages TABLE (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Objective NVARCHAR(MAX) NOT NULL,
    Pic NVARCHAR(50) NOT NULL,
    WaveId NVARCHAR(50),
    ScreenCode NVARCHAR(50),
    TotalEffort INT
);

-- Temporary table for staged Requests
DECLARE @StagedRequests TABLE (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    WorkPackageId UNIQUEIDENTIFIER NOT NULL,
    TaskId NVARCHAR(50) NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Effort INT,
    Pic NVARCHAR(50) NOT NULL
);

-- Populating Staged WorkPackages and Requests...
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('385C15BB-781D-5C01-9992-6F03179806E6', '[SC-00-01] Workspace System Architecture & Discovery', 'Wave: WAVE-00 - PREPARATION & OUTCOME DISCOVERY | Screen: SC-00 - Preparation & Outcome Discovery | PIC: All PICs | Total Effort: 5 day(s)', 'All PICs', 'WAVE-00', 'SC-00', 5);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('1641F838-2984-54ED-ADC4-38EA40064E8F', '[SC-01-01] Workspace Booking', 'Wave: WAVE-01 - MASTER & PATIENT ADMISSION | Screen: SC-01 - Admisi | PIC: Arif | Total Effort: 17 day(s)', 'Arif', 'WAVE-01', 'SC-01', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', '[SC-01-02] Workspace Registrasi Rawat Jalan dan IGD', 'Wave: WAVE-01 - MASTER & PATIENT ADMISSION | Screen: SC-01 - Admisi | PIC: Arif | Total Effort: 17 day(s)', 'Arif', 'WAVE-01', 'SC-01', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('FB13D76C-061A-588F-A268-CDB8E4A85BF8', '[SC-01-03] Workspace Registrasi Ranap', 'Wave: WAVE-01 - MASTER & PATIENT ADMISSION | Screen: SC-01 - Admisi | PIC: Arif | Total Effort: 17 day(s)', 'Arif', 'WAVE-01', 'SC-01', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('E971BF4E-EDB4-53BF-9251-0E7B9C143638', '[SC-05-01] Workspace Tindakan', 'Wave: WAVE-02 - OUTPATIENT REVENUE CYCLE | Screen: SC-05 - Poli Rawat Jalan | PIC: Fikri | Total Effort: 17 day(s)', 'Fikri', 'WAVE-02', 'SC-05', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('DD534A0C-7656-5D06-8BA2-10885E026EAA', '[SC-05-02] Workspace Local Inventory', 'Wave: WAVE-02 - OUTPATIENT REVENUE CYCLE | Screen: SC-05 - Poli Rawat Jalan | PIC: Fikri | Total Effort: 17 day(s)', 'Fikri', 'WAVE-02', 'SC-05', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('AF44B29F-F43A-5295-BDAD-BB4CA1C63442', '[SC-02-01] Workspace Reg Out', 'Wave: WAVE-02 - OUTPATIENT REVENUE CYCLE | Screen: SC-02 - Tata Rekening | PIC: Erkoc | Total Effort: 17 day(s)', 'Erkoc', 'WAVE-02', 'SC-02', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('69468E99-5822-5B87-B779-8AF27552E44C', '[SC-03-01] Workspace Kasir-Deposit-Voucher', 'Wave: WAVE-02 - OUTPATIENT REVENUE CYCLE | Screen: SC-03 - Kasir | PIC: Erkoc | Total Effort: 17 day(s)', 'Erkoc', 'WAVE-02', 'SC-03', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', '[SC-03-02] Workspace Closing Shift', 'Wave: WAVE-02 - OUTPATIENT REVENUE CYCLE | Screen: SC-03 - Kasir | PIC: Erkoc | Total Effort: 17 day(s)', 'Erkoc', 'WAVE-02', 'SC-03', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('8678E39D-76C5-5AD0-9D7F-971051EF152C', '[SC-04-01] Workspace Berkas RM', 'Wave: WAVE-03 - MEDICAL RECORD FOUNDATION | Screen: SC-04 - Rekam Medis | PIC: Rizal | Total Effort: 17 day(s)', 'Rizal', 'WAVE-03', 'SC-04', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('A9E110EF-9992-57AC-98AB-81F4BFB2CA50', '[SC-04-02] Workspace Casemix dan Coding', 'Wave: WAVE-03 - MEDICAL RECORD FOUNDATION | Screen: SC-04 - Rekam Medis | PIC: Rizal | Total Effort: 17 day(s)', 'Rizal', 'WAVE-03', 'SC-04', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('02715241-EF03-50D0-AEF4-09A03E05654E', '[SC-04-03] Workspace Pelaporan RL', 'Wave: WAVE-03 - MEDICAL RECORD FOUNDATION | Screen: SC-04 - Rekam Medis | PIC: Rizal | Total Effort: 17 day(s)', 'Rizal', 'WAVE-03', 'SC-04', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', '[SC-07-01] Workspace IGD Triage', 'Wave: WAVE-04 - ACUTE CARE OPERATIONS | Screen: SC-07 - IGD | PIC: Arif | Total Effort: 17 day(s)', 'Arif', 'WAVE-04', 'SC-07', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('EAED14E4-E25B-5057-8C7C-DD192B8F284E', '[SC-05-02] Workspace Local Inventory (IGD)', 'Wave: WAVE-04 - ACUTE CARE OPERATIONS | Screen: SC-07 - IGD | PIC: Arif | Total Effort: 17 day(s)', 'Arif', 'WAVE-04', 'SC-07', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('6E2F68E3-57D8-5178-84D9-BF8CE3666804', '[SC-06-01] Workspace Bed Management', 'Wave: WAVE-04 - ACUTE CARE OPERATIONS | Screen: SC-06 - Bangsal Rawat Inap | PIC: Sulis | Total Effort: 17 day(s)', 'Sulis', 'WAVE-04', 'SC-06', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('4E03A819-62E8-55C0-9FA9-A69A275EC3F9', '[SC-05-02] Workspace Local Inventory (Bangsal Rawat Inap)', 'Wave: WAVE-04 - ACUTE CARE OPERATIONS | Screen: SC-06 - Bangsal Rawat Inap | PIC: Sulis | Total Effort: 17 day(s)', 'Sulis', 'WAVE-04', 'SC-06', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('F593D204-F4FF-57E2-AA7F-602C4596BCB9', '[SC-08-01] Workspace Order Laboratorium', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-08 - Laboratorium | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-08', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('4145DA70-292E-548F-A5AE-21BBABFFC10E', '[SC-08-02] Workspace Result Management', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-08 - Laboratorium | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-08', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('8125248C-0E2C-5C1A-9199-3550C463D34F', '[SC-08-03] Workspace Local Inventory', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-08 - Laboratorium | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-08', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('E44A5DCA-82A2-56C7-8F26-DB31D633D730', '[SC-09-01] Workspace Order Radiologi', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-09 - Radiologi | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-09', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('496DD045-1057-57E3-B687-6EB43CFEC417', '[SC-09-02] Workspace Expertise', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-09 - Radiologi | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-09', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('DF8481A9-60A8-5EA9-92A1-45B414E69C68', '[SC-09-03] Workspace Local Inventory', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-09 - Radiologi | PIC: We | Total Effort: 17 day(s)', 'We', 'WAVE-05', 'SC-09', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('19F556EC-DE39-550C-8229-6306128FDF7E', '[SC-10-01] Workspace Scheduling', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-10 - Kamar Operasi | PIC: Arie | Total Effort: 17 day(s)', 'Arie', 'WAVE-05', 'SC-10', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('9F172DA2-1CDE-5106-A2C2-68B286D6FED5', '[SC-10-02] Workspace Operative Management', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-10 - Kamar Operasi | PIC: Arie | Total Effort: 17 day(s)', 'Arie', 'WAVE-05', 'SC-10', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('9B6C2B81-4716-5B52-B6F0-E830763A222A', '[SC-10-03] Workspace Local Inventory', 'Wave: WAVE-05 - DIAGNOSTIC & PROCEDURE SERVICES | Screen: SC-10 - Kamar Operasi | PIC: Arie | Total Effort: 17 day(s)', 'Arie', 'WAVE-05', 'SC-10', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('34A73E68-5A21-503B-BC70-46F393A560BE', '[SC-11-01] Workspace Antrian Apotek', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-11 - Apotek | PIC: Jude | Total Effort: 17 day(s)', 'Jude', 'WAVE-06', 'SC-11', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('37C40862-94E1-5A99-8969-F26C22A8309E', '[SC-11-02] Workspace Telaah Resep', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-11 - Apotek | PIC: Jude | Total Effort: 17 day(s)', 'Jude', 'WAVE-06', 'SC-11', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('BAB235F5-A86B-5139-B700-72CD7A0AB0C5', '[SC-11-03] Workspace Dispensing', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-11 - Apotek | PIC: Jude | Total Effort: 17 day(s)', 'Jude', 'WAVE-06', 'SC-11', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('0DD2D03E-FC0A-54D9-AE15-089050F72512', '[SC-11-04] Workspace Serah Obat', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-11 - Apotek | PIC: Jude | Total Effort: 17 day(s)', 'Jude', 'WAVE-06', 'SC-11', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('2933F709-3C41-5610-8387-6AD544956BF1', '[SC-11-05] Workspace Local Inventory', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-11 - Apotek | PIC: Jude | Total Effort: 17 day(s)', 'Jude', 'WAVE-06', 'SC-11', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('FE7070EC-820A-574F-A0E0-62A1DF16C0DC', '[SC-12-01] Workspace Terima Barang (DO), Retur Beli', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-12 - Gudang | PIC: Roso | Total Effort: 17 day(s)', 'Roso', 'WAVE-06', 'SC-12', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('B3C2E294-7360-5429-9A9A-19504CC0B2D1', '[SC-12-02] Workspace Local Inventory', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-12 - Gudang | PIC: Roso | Total Effort: 17 day(s)', 'Roso', 'WAVE-06', 'SC-12', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('4B9E5537-153C-594C-949B-55F24892B004', '[SC-12-03] Workspace Retur Beli', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-12 - Gudang | PIC: Roso | Total Effort: 17 day(s)', 'Roso', 'WAVE-06', 'SC-12', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('AFCA7F86-15C7-53F1-A95A-281B716BD863', '[SC-13-01] Workspace Purchase Order', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-13 - Purchasing | PIC: Fikri | Total Effort: 17 day(s)', 'Fikri', 'WAVE-06', 'SC-13', 17);
INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ('8985CCB3-8DC3-579E-A4D4-118EA2151C8F', '[SC-13-02] Workspace Faktur Tagihan', 'Wave: WAVE-06 - SUPPLY CHAIN & PHARMACY | Screen: SC-13 - Purchasing | PIC: Fikri | Total Effort: 17 day(s)', 'Fikri', 'WAVE-06', 'SC-13', 17);

INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7089EBDA-6482-597B-B386-4F22EA388EA1', '385C15BB-781D-5C01-9992-6F03179806E6', 'SC-00-01-01', '[SC-00-01-01] Outcome Discovery & Domain Alignment', 'Task: Outcome Discovery & Domain Alignment
Task ID: SC-00-01-01
Estimated Effort: 3 day(s)
Workspace: [SC-00-01] Workspace System Architecture & Discovery
Screen: [SC-00] Preparation & Outcome Discovery
Wave: [WAVE-00] PREPARATION & OUTCOME DISCOVERY
PIC: All PICs', 3, 'All PICs');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F2C74442-B155-5C72-B886-42F82D30F80D', '385C15BB-781D-5C01-9992-6F03179806E6', 'SC-00-01-02', '[SC-00-01-02] Environment & Baseline Setup', 'Task: Environment & Baseline Setup
Task ID: SC-00-01-02
Estimated Effort: 2 day(s)
Workspace: [SC-00-01] Workspace System Architecture & Discovery
Screen: [SC-00] Preparation & Outcome Discovery
Wave: [WAVE-00] PREPARATION & OUTCOME DISCOVERY
PIC: All PICs', 2, 'All PICs');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('22C560F1-6DEE-58C3-9903-FC17E972A80C', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-01', '[SC-01-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-01-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 5, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B9721F9C-B084-51A3-A341-1FB92AB0E9D7', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-02', '[SC-01-01-02] UI Design', 'Task: UI Design
Task ID: SC-01-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D27D34E8-B334-5570-B929-98EA28D418DF', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-03', '[SC-01-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-01-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D1B0B15A-452A-5827-A035-F1D151EF459D', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-04', '[SC-01-01-04] Architecture', 'Task: Architecture
Task ID: SC-01-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F037FFD2-935C-5BA2-ABE3-4FD05BB56642', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-05', '[SC-01-01-05] Development', 'Task: Development
Task ID: SC-01-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('00BC1DD6-593A-59E3-AFFE-7BE3AD99E36E', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-06', '[SC-01-01-06] Testing', 'Task: Testing
Task ID: SC-01-01-06
Estimated Effort: 3 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7CA33C74-6A21-5AEB-A0E2-CC345542EDD0', '1641F838-2984-54ED-ADC4-38EA40064E8F', 'SC-01-01-07', '[SC-01-01-07] Deployment', 'Task: Deployment
Task ID: SC-01-01-07
Estimated Effort: 1 day(s)
Workspace: [SC-01-01] Workspace Booking
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C317B837-6290-5A76-962F-A3C14BF639B5', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-01', '[SC-01-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-01-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 5, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('22EDD9EB-D420-5F3F-94CA-4AFBEED874C3', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-02', '[SC-01-02-02] UI Design', 'Task: UI Design
Task ID: SC-01-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('87ECA2DF-1ED9-5CF8-B377-33DFE44473BA', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-03', '[SC-01-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-01-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('15F1F460-9436-5548-9EFA-5B135A0D0AC1', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-04', '[SC-01-02-04] Architecture', 'Task: Architecture
Task ID: SC-01-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9F695905-3180-57AA-A1D1-1DF4BD28EA70', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-05', '[SC-01-02-05] Development', 'Task: Development
Task ID: SC-01-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('0A22D387-9132-544D-860A-8A6FE7F7618C', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-06', '[SC-01-02-06] Testing', 'Task: Testing
Task ID: SC-01-02-06
Estimated Effort: 3 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7927BA0C-7D97-5DDE-8797-6344053C1043', '7E2FF278-DEB2-51E9-A6CB-815EE2B7ADFA', 'SC-01-02-07', '[SC-01-02-07] Deployment', 'Task: Deployment
Task ID: SC-01-02-07
Estimated Effort: 1 day(s)
Workspace: [SC-01-02] Workspace Registrasi Rawat Jalan dan IGD
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C1753A76-F435-571A-AC08-4F5A8936E979', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-01', '[SC-01-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-01-03-01
Estimated Effort: 5 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 5, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('41939402-B4C2-5542-95FF-7F21788945D8', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-02', '[SC-01-03-02] UI Design', 'Task: UI Design
Task ID: SC-01-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('246256EA-408D-50BA-8EDA-8929ABAB46AA', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-03', '[SC-01-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-01-03-03
Estimated Effort: 1 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('61CCE9E1-93A2-51EE-B0E9-79450B1D4F04', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-04', '[SC-01-03-04] Architecture', 'Task: Architecture
Task ID: SC-01-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('3ACE601A-7D9F-5E5E-8EE6-E904D6889CE4', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-05', '[SC-01-03-05] Development', 'Task: Development
Task ID: SC-01-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B8FC8B8F-927D-5F63-9310-B74B7C938A08', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-06', '[SC-01-03-06] Testing', 'Task: Testing
Task ID: SC-01-03-06
Estimated Effort: 3 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('08AE7644-EB74-52C3-B26C-ED158F7EF73B', 'FB13D76C-061A-588F-A268-CDB8E4A85BF8', 'SC-01-03-07', '[SC-01-03-07] Deployment', 'Task: Deployment
Task ID: SC-01-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-01-03] Workspace Registrasi Ranap
Screen: [SC-01] Admisi
Wave: [WAVE-01] MASTER & PATIENT ADMISSION
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('790A26DC-EADE-5429-868D-C074FF280E95', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-01', '[SC-05-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-05-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 5, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BF9AC3E7-4B56-5546-B70F-10CCBC6CE477', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-02', '[SC-05-01-02] UI Design', 'Task: UI Design
Task ID: SC-05-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 3, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('360C1C81-56EF-57A9-A70B-FF8C08659651', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-03', '[SC-05-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-05-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('040BE254-D014-565F-A8C0-E927FFD301ED', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-04', '[SC-05-01-04] Architecture', 'Task: Architecture
Task ID: SC-05-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('84FB3CD5-5B45-50BB-8E58-BF0A278B7A34', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-05', '[SC-05-01-05] Development', 'Task: Development
Task ID: SC-05-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('73C10630-5CE2-5285-8116-A0E24856C72E', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-06', '[SC-05-01-06] Testing', 'Task: Testing
Task ID: SC-05-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 4, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F638F74C-F5EA-5A27-A671-69BBFA7E043C', 'E971BF4E-EDB4-53BF-9251-0E7B9C143638', 'SC-05-01-07', '[SC-05-01-07] Deployment', 'Task: Deployment
Task ID: SC-05-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-05-01] Workspace Tindakan
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C2828FE5-6599-54F9-9C1A-3F2EF8CF022C', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-01', '[SC-05-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-05-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 5, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E2831B31-670E-5DA1-91DC-25361EAA5526', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-02', '[SC-05-02-02] UI Design', 'Task: UI Design
Task ID: SC-05-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 3, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('593203AC-41DB-5BA5-B51A-4FBC63DB5F64', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-03', '[SC-05-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-05-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7170301E-FD60-534B-BA64-6C4EB791C72D', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-04', '[SC-05-02-04] Architecture', 'Task: Architecture
Task ID: SC-05-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('71004A3A-B343-58C3-AE7F-FDF7865045E2', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-05', '[SC-05-02-05] Development', 'Task: Development
Task ID: SC-05-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('2C2178EB-3E9F-54AA-A833-A42DE731A154', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-06', '[SC-05-02-06] Testing', 'Task: Testing
Task ID: SC-05-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 4, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E7D96BC5-6693-5E01-9E16-0051B650E992', 'DD534A0C-7656-5D06-8BA2-10885E026EAA', 'SC-05-02-07', '[SC-05-02-07] Deployment', 'Task: Deployment
Task ID: SC-05-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-05] Poli Rawat Jalan
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E9AFB137-C274-5E59-B478-BF375F566B23', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-01', '[SC-02-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-02-01-01
Estimated Effort: 4 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 4, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B6B3C417-6723-5E27-A77E-AA36971A4597', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-02', '[SC-02-01-02] UI Design', 'Task: UI Design
Task ID: SC-02-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 3, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8E798055-3C47-56E8-812C-F390BC51E8FE', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-03', '[SC-02-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-02-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('11300834-FC79-5FB7-9739-CD9FF9674771', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-04', '[SC-02-01-04] Architecture', 'Task: Architecture
Task ID: SC-02-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('ED1D425C-BDD0-5606-A071-04C177E459C8', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-05', '[SC-02-01-05] Development', 'Task: Development
Task ID: SC-02-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('83034F4A-8EE7-5C01-88A8-326D9EE2ADED', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-06', '[SC-02-01-06] Testing', 'Task: Testing
Task ID: SC-02-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 4, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('87C564E1-A25B-5D1A-8183-5F0C25080438', 'AF44B29F-F43A-5295-BDAD-BB4CA1C63442', 'SC-02-01-07', '[SC-02-01-07] Deployment', 'Task: Deployment
Task ID: SC-02-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-02-01] Workspace Reg Out
Screen: [SC-02] Tata Rekening
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9B7A28AE-5A3B-5BAE-98C2-1E125EEDC1FB', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-01', '[SC-03-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-03-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 5, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('DC8F9C35-D491-5D51-9939-CBD98BF745A3', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-02', '[SC-03-01-02] UI Design', 'Task: UI Design
Task ID: SC-03-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 3, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C33AAA2A-0305-5EE6-804E-E242F5243835', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-03', '[SC-03-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-03-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('737EF0E2-95B9-5916-BDBD-251A0A1501D4', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-04', '[SC-03-01-04] Architecture', 'Task: Architecture
Task ID: SC-03-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B077FA25-12A9-5FED-BA3C-278A41B60D4E', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-05', '[SC-03-01-05] Development', 'Task: Development
Task ID: SC-03-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1C459AE3-A64C-5244-B7AF-23D4427DA298', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-06', '[SC-03-01-06] Testing', 'Task: Testing
Task ID: SC-03-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 4, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('4D201F27-D53B-54D3-9BE6-03DEDEA28DD2', '69468E99-5822-5B87-B779-8AF27552E44C', 'SC-03-01-07', '[SC-03-01-07] Deployment', 'Task: Deployment
Task ID: SC-03-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-03-01] Workspace Kasir-Deposit-Voucher
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B13352AC-7119-5430-A640-CFCEF5AEF40D', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-01', '[SC-03-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-03-02-01
Estimated Effort: 2 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('AF4E7101-7107-5D9E-ACD0-03C5AB9E4BDD', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-02', '[SC-03-02-02] UI Design', 'Task: UI Design
Task ID: SC-03-02-02
Estimated Effort: 2 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('87FC2171-746E-5205-ACF4-D38C0987A0F3', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-03', '[SC-03-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-03-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('77F07A76-1F44-56DE-9A2B-6B701550DB4E', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-04', '[SC-03-02-04] Architecture', 'Task: Architecture
Task ID: SC-03-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C543F100-5196-5D0F-9A79-7DB88AB5719C', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-05', '[SC-03-02-05] Development', 'Task: Development
Task ID: SC-03-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C12BCB22-6673-508F-9AA1-3DD2669C54D6', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-06', '[SC-03-02-06] Testing', 'Task: Testing
Task ID: SC-03-02-06
Estimated Effort: 2 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 2, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('31F02059-C9F1-52C4-89F9-958AF8EAD48D', '78C439D4-CF32-5A33-9E64-C1BB6BB83E5A', 'SC-03-02-07', '[SC-03-02-07] Deployment', 'Task: Deployment
Task ID: SC-03-02-07
Estimated Effort: 1 day(s)
Workspace: [SC-03-02] Workspace Closing Shift
Screen: [SC-03] Kasir
Wave: [WAVE-02] OUTPATIENT REVENUE CYCLE
PIC: Erkoc', 1, 'Erkoc');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5BBF6F40-1321-571E-95F3-C282E2C6F70D', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-01', '[SC-04-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-04-01-01
Estimated Effort: 3 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 3, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('AFDC7E2C-BD00-50A3-93E8-8D498EE17916', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-02', '[SC-04-01-02] UI Design', 'Task: UI Design
Task ID: SC-04-01-02
Estimated Effort: 2 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C1F92F3B-14B5-575F-B78C-2F38C5EA48C0', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-03', '[SC-04-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-04-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FC7E74D0-9DD0-5AC1-B959-0B8DC1B30AE1', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-04', '[SC-04-01-04] Architecture', 'Task: Architecture
Task ID: SC-04-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F69384BA-42B7-5964-917A-F12068018ECD', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-05', '[SC-04-01-05] Development', 'Task: Development
Task ID: SC-04-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D13CB8F3-9138-51B7-B39C-DFF82EEE4DC9', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-06', '[SC-04-01-06] Testing', 'Task: Testing
Task ID: SC-04-01-06
Estimated Effort: 3 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 3, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A1621D51-4B3E-5110-86E4-80C9419BA196', '8678E39D-76C5-5AD0-9D7F-971051EF152C', 'SC-04-01-07', '[SC-04-01-07] Deployment', 'Task: Deployment
Task ID: SC-04-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-04-01] Workspace Berkas RM
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E70EE977-CC72-5C43-9E97-40C5473F19C6', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-01', '[SC-04-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-04-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 5, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F624D910-4F27-574E-8908-8CA3209A8041', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-02', '[SC-04-02-02] UI Design', 'Task: UI Design
Task ID: SC-04-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 3, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D5BEF998-93FC-50F6-86E3-EAB07ACD9BA4', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-03', '[SC-04-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-04-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7C29115B-02BB-5DD7-B2BD-12D8D3F68F36', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-04', '[SC-04-02-04] Architecture', 'Task: Architecture
Task ID: SC-04-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1F64B55E-7033-5944-8849-5D699C3D9220', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-05', '[SC-04-02-05] Development', 'Task: Development
Task ID: SC-04-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('45D443A7-084F-5D68-A6FF-2632B98925F9', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-06', '[SC-04-02-06] Testing', 'Task: Testing
Task ID: SC-04-02-06
Estimated Effort: 3 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 3, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('98FAE877-099C-56B2-94DB-F43E147AB4A5', 'A9E110EF-9992-57AC-98AB-81F4BFB2CA50', 'SC-04-02-07', '[SC-04-02-07] Deployment', 'Task: Deployment
Task ID: SC-04-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-04-02] Workspace Casemix dan Coding
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B03BD81A-EBED-5F9C-8B42-8BCD542C68D0', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-01', '[SC-04-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-04-03-01
Estimated Effort: 4 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 4, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FABFC697-8D75-57DB-A111-6F7841338517', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-02', '[SC-04-03-02] UI Design', 'Task: UI Design
Task ID: SC-04-03-02
Estimated Effort: 2 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D07B27F6-6B96-524B-90FA-05C3E1CEB0F4', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-03', '[SC-04-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-04-03-03
Estimated Effort: 1 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F4E57046-79EE-50DD-8325-CC4F3D574C43', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-04', '[SC-04-03-04] Architecture', 'Task: Architecture
Task ID: SC-04-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('185C93EE-A93E-5B79-9EF1-E6927C7066B4', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-05', '[SC-04-03-05] Development', 'Task: Development
Task ID: SC-04-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 1, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1263E694-FE17-5D32-AE25-FC6FE4E47F99', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-06', '[SC-04-03-06] Testing', 'Task: Testing
Task ID: SC-04-03-06
Estimated Effort: 2 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6113CFD7-5CCB-5571-8409-3F50B6F2DE91', '02715241-EF03-50D0-AEF4-09A03E05654E', 'SC-04-03-07', '[SC-04-03-07] Deployment', 'Task: Deployment
Task ID: SC-04-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-04-03] Workspace Pelaporan RL
Screen: [SC-04] Rekam Medis
Wave: [WAVE-03] MEDICAL RECORD FOUNDATION
PIC: Rizal', 2, 'Rizal');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('0B93F606-98EB-5DE5-9FEA-672F860457D3', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-01', '[SC-07-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-07-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 5, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BDCA8647-BA1D-5822-BBCB-56B220338656', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-02', '[SC-07-01-02] UI Design', 'Task: UI Design
Task ID: SC-07-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 3, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5C02C64E-C840-5D76-AF19-39F811D1754B', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-03', '[SC-07-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-07-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('60D9ADD5-58CD-5DFF-987F-DDE7E87234EA', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-04', '[SC-07-01-04] Architecture', 'Task: Architecture
Task ID: SC-07-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B2EFFCA5-1AAC-51BD-A650-677F83B5D4BE', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-05', '[SC-07-01-05] Development', 'Task: Development
Task ID: SC-07-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A2BF8A19-561A-5F51-9A1F-AC10101D1174', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-06', '[SC-07-01-06] Testing', 'Task: Testing
Task ID: SC-07-01-06
Estimated Effort: 2 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8D8E3CE8-DBCD-578A-A008-3DF863910190', '0DF8EE00-DF59-5780-9DCA-A17EC5F334A8', 'SC-07-01-07', '[SC-07-01-07] Deployment', 'Task: Deployment
Task ID: SC-07-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-07-01] Workspace IGD Triage
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('2122C764-657E-5FE0-83DC-F45AF165F576', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-01', '[SC-05-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-05-02-01
Estimated Effort: 4 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 4, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1972F813-34FB-5266-9251-14782D53108B', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-02', '[SC-05-02-02] UI Design', 'Task: UI Design
Task ID: SC-05-02-02
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('37027716-4583-5C99-A1BD-D90BB69D5F48', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-03', '[SC-05-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-05-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('273DA9B4-DC67-56B9-A491-8261A6DB725D', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-04', '[SC-05-02-04] Architecture', 'Task: Architecture
Task ID: SC-05-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('36582917-AE9D-5669-BFC2-FBA44BDC388C', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-05', '[SC-05-02-05] Development', 'Task: Development
Task ID: SC-05-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 1, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F9C21166-E453-5B09-A6EA-9F13BBB7D720', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-06', '[SC-05-02-06] Testing', 'Task: Testing
Task ID: SC-05-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 4, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('937A88FB-A670-5F3F-8DE8-C912DBC83D09', 'EAED14E4-E25B-5057-8C7C-DD192B8F284E', 'SC-05-02-07', '[SC-05-02-07] Deployment', 'Task: Deployment
Task ID: SC-05-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-07] IGD
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Arif', 2, 'Arif');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8FCA8544-2612-5E05-A82C-3A822B706EC8', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-01', '[SC-06-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-06-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 5, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('11A23DE5-BC1A-5D2B-AEFD-1705FA9ADFEB', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-02', '[SC-06-01-02] UI Design', 'Task: UI Design
Task ID: SC-06-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 3, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E7A12AAF-CE2F-549F-9442-FD94D9A6A858', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-03', '[SC-06-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-06-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 1, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F997DF9C-97D7-5699-BA2C-9EF137C7324C', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-04', '[SC-06-01-04] Architecture', 'Task: Architecture
Task ID: SC-06-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 2, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CFAFB118-F0AB-56F2-8A16-8DAE350FAA5F', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-05', '[SC-06-01-05] Development', 'Task: Development
Task ID: SC-06-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 1, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A91093E7-CAEB-5C2A-8C4D-DDB80E6949D2', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-06', '[SC-06-01-06] Testing', 'Task: Testing
Task ID: SC-06-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 4, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1C1B7AD0-256B-5CC1-920C-F5FA33A0EFF8', '6E2F68E3-57D8-5178-84D9-BF8CE3666804', 'SC-06-01-07', '[SC-06-01-07] Deployment', 'Task: Deployment
Task ID: SC-06-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-06-01] Workspace Bed Management
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 2, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('34549949-4BD8-5E83-84E8-2AA5FBA7CEF2', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-01', '[SC-05-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-05-02-01
Estimated Effort: 3 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 3, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E89015CD-7ED1-59F3-8808-8615EBD3DB9C', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-02', '[SC-05-02-02] UI Design', 'Task: UI Design
Task ID: SC-05-02-02
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 2, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CBFC74D7-3400-599D-9AED-A7D01D633F7F', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-03', '[SC-05-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-05-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 1, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('17AC8035-EF2E-54DF-999B-789BF81FF63A', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-04', '[SC-05-02-04] Architecture', 'Task: Architecture
Task ID: SC-05-02-04
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 1, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('919B6D9C-976C-55C0-A38A-90298AC62F2E', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-05', '[SC-05-02-05] Development', 'Task: Development
Task ID: SC-05-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 1, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9442915A-7F14-5C90-B116-DB4411D84CC4', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-06', '[SC-05-02-06] Testing', 'Task: Testing
Task ID: SC-05-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 4, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('3D2BEF08-DA3C-570D-9887-D34A5A0A3653', '4E03A819-62E8-55C0-9FA9-A69A275EC3F9', 'SC-05-02-07', '[SC-05-02-07] Deployment', 'Task: Deployment
Task ID: SC-05-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-05-02] Workspace Local Inventory
Screen: [SC-06] Bangsal Rawat Inap
Wave: [WAVE-04] ACUTE CARE OPERATIONS
PIC: Sulis', 2, 'Sulis');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8BB52122-1F03-5B40-8E7B-5E2A3D1C899E', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-01', '[SC-08-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-08-01-01
Estimated Effort: 4 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 4, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('73E469C0-2DA3-5E9F-B679-AA5F2BA98482', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-02', '[SC-08-01-02] UI Design', 'Task: UI Design
Task ID: SC-08-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('47D91086-DCB3-58F6-BFA7-A4C65D150D84', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-03', '[SC-08-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-08-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F6233E07-4F83-585A-98E3-EDB60083C536', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-04', '[SC-08-01-04] Architecture', 'Task: Architecture
Task ID: SC-08-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('415EF0A3-4AD3-584C-8DA9-4F037446241B', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-05', '[SC-08-01-05] Development', 'Task: Development
Task ID: SC-08-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BF29CC80-849F-5AA4-BF16-1DA02E33179C', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-06', '[SC-08-01-06] Testing', 'Task: Testing
Task ID: SC-08-01-06
Estimated Effort: 3 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D6EEBC57-EEE3-59FD-9CE1-2C872600B5D7', 'F593D204-F4FF-57E2-AA7F-602C4596BCB9', 'SC-08-01-07', '[SC-08-01-07] Deployment', 'Task: Deployment
Task ID: SC-08-01-07
Estimated Effort: 1 day(s)
Workspace: [SC-08-01] Workspace Order Laboratorium
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6444E7B0-916D-5693-9260-2932D2F6A370', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-01', '[SC-08-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-08-02-01
Estimated Effort: 3 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6BD50359-8BD5-59BE-AA47-11E1D0A5FF9D', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-02', '[SC-08-02-02] UI Design', 'Task: UI Design
Task ID: SC-08-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('68B069F6-D58B-5677-B46E-0E28C6352D50', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-03', '[SC-08-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-08-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6F651351-4A20-5A39-9A38-E84CA631759A', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-04', '[SC-08-02-04] Architecture', 'Task: Architecture
Task ID: SC-08-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('83EF15B9-AE71-5966-A9A5-CD9C6E0C4D6C', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-05', '[SC-08-02-05] Development', 'Task: Development
Task ID: SC-08-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6C3F7618-A1CC-5A42-B305-228BFDCE829B', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-06', '[SC-08-02-06] Testing', 'Task: Testing
Task ID: SC-08-02-06
Estimated Effort: 3 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E3E4C07F-72B7-5A94-9DE1-4D79331538C5', '4145DA70-292E-548F-A5AE-21BBABFFC10E', 'SC-08-02-07', '[SC-08-02-07] Deployment', 'Task: Deployment
Task ID: SC-08-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-08-02] Workspace Result Management
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('128F9019-0C18-5F18-B00D-8696B859D3C6', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-01', '[SC-08-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-08-03-01
Estimated Effort: 3 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C3B53FC1-AAB9-5D0D-AA44-9B6A8E9376EF', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-02', '[SC-08-03-02] UI Design', 'Task: UI Design
Task ID: SC-08-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FACDB45C-DB63-5517-8E48-331F5C2C924D', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-03', '[SC-08-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-08-03-03
Estimated Effort: 2 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1E36DCE4-A047-5C11-A719-A66291DBB127', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-04', '[SC-08-03-04] Architecture', 'Task: Architecture
Task ID: SC-08-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CB03710F-02D1-55DE-A101-BA8F28D27DF2', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-05', '[SC-08-03-05] Development', 'Task: Development
Task ID: SC-08-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5727598E-5A78-538C-B412-F4764E849275', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-06', '[SC-08-03-06] Testing', 'Task: Testing
Task ID: SC-08-03-06
Estimated Effort: 3 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('697A90B7-5E03-54F0-9DAB-101BB9D00E12', '8125248C-0E2C-5C1A-9199-3550C463D34F', 'SC-08-03-07', '[SC-08-03-07] Deployment', 'Task: Deployment
Task ID: SC-08-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-08-03] Workspace Local Inventory
Screen: [SC-08] Laboratorium
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('0BEF423A-2126-5AA2-8628-1BA67F9252F1', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-01', '[SC-09-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-09-01-01
Estimated Effort: 3 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7C705209-B81F-5221-9D3B-399017338A9C', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-02', '[SC-09-01-02] UI Design', 'Task: UI Design
Task ID: SC-09-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('ADE13E16-0034-559D-88C1-B9110F4B2D5D', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-03', '[SC-09-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-09-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A1CE417F-C917-55F2-A976-4158D18503FF', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-04', '[SC-09-01-04] Architecture', 'Task: Architecture
Task ID: SC-09-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('B1CEB330-B206-5E8A-8F7C-F134119303BD', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-05', '[SC-09-01-05] Development', 'Task: Development
Task ID: SC-09-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FD9B757A-F871-5B6B-8027-9644C8A050EA', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-06', '[SC-09-01-06] Testing', 'Task: Testing
Task ID: SC-09-01-06
Estimated Effort: 3 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1A1ECD83-E2B3-5070-BDF9-5ACDF847633C', 'E44A5DCA-82A2-56C7-8F26-DB31D633D730', 'SC-09-01-07', '[SC-09-01-07] Deployment', 'Task: Deployment
Task ID: SC-09-01-07
Estimated Effort: 1 day(s)
Workspace: [SC-09-01] Workspace Order Radiologi
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D33015C7-F57E-5EC7-8796-914C098F9779', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-01', '[SC-09-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-09-02-01
Estimated Effort: 3 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('37CF131F-FF08-5F1D-B148-3A377495F9E8', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-02', '[SC-09-02-02] UI Design', 'Task: UI Design
Task ID: SC-09-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('756FC0CF-53B6-5945-8ADB-D673E0AF90B9', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-03', '[SC-09-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-09-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C6A0E782-9AC2-56F2-B420-17C4D740D3BB', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-04', '[SC-09-02-04] Architecture', 'Task: Architecture
Task ID: SC-09-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('53585B76-72B6-5357-AD74-EB58B676B168', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-05', '[SC-09-02-05] Development', 'Task: Development
Task ID: SC-09-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F90B553D-9888-5177-8725-02685E196A6D', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-06', '[SC-09-02-06] Testing', 'Task: Testing
Task ID: SC-09-02-06
Estimated Effort: 3 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5DABBBFE-6632-50C8-B45C-2078F0AD694B', '496DD045-1057-57E3-B687-6EB43CFEC417', 'SC-09-02-07', '[SC-09-02-07] Deployment', 'Task: Deployment
Task ID: SC-09-02-07
Estimated Effort: 1 day(s)
Workspace: [SC-09-02] Workspace Expertise
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D3461B3A-E222-5545-A4D1-8EB24DB8D2AA', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-01', '[SC-09-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-09-03-01
Estimated Effort: 3 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F2450ECF-2E24-5F35-87C2-849AC92C4E4C', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-02', '[SC-09-03-02] UI Design', 'Task: UI Design
Task ID: SC-09-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E22D6BD0-BBCD-5258-AF20-CB58933BBFFA', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-03', '[SC-09-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-09-03-03
Estimated Effort: 2 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D005F23D-1048-5DC5-826D-2EA0B475315F', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-04', '[SC-09-03-04] Architecture', 'Task: Architecture
Task ID: SC-09-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('83B663F0-9DAB-5736-BDE2-E1864C1DBB59', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-05', '[SC-09-03-05] Development', 'Task: Development
Task ID: SC-09-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 1, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('05EA3C68-F7C0-52EB-AF7F-5541AD22DF1B', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-06', '[SC-09-03-06] Testing', 'Task: Testing
Task ID: SC-09-03-06
Estimated Effort: 3 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 3, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6C2A23E6-63BD-59A8-B146-86D08C0B3A1B', 'DF8481A9-60A8-5EA9-92A1-45B414E69C68', 'SC-09-03-07', '[SC-09-03-07] Deployment', 'Task: Deployment
Task ID: SC-09-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-09-03] Workspace Local Inventory
Screen: [SC-09] Radiologi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: We', 2, 'We');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9416728A-91D2-5983-9CF4-EA41B3BB9B9D', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-01', '[SC-10-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-10-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 5, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CDFFBF57-B77E-5A3E-B2DB-1A4AAADCCAB9', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-02', '[SC-10-01-02] UI Design', 'Task: UI Design
Task ID: SC-10-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 3, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C4BAE978-8CDA-5260-8847-DF69C32A164A', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-03', '[SC-10-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-10-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 1, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('DA2E4CD9-BE0E-508F-93D3-7D165E8F8D12', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-04', '[SC-10-01-04] Architecture', 'Task: Architecture
Task ID: SC-10-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('0B2EDA68-E7EB-5858-80DD-398D25BC74A1', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-05', '[SC-10-01-05] Development', 'Task: Development
Task ID: SC-10-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 1, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BB3D9F1A-6343-56B6-84FE-789BB4D2ED77', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-06', '[SC-10-01-06] Testing', 'Task: Testing
Task ID: SC-10-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 4, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('40B0D322-4364-5A84-8EF1-56216B511591', '19F556EC-DE39-550C-8229-6306128FDF7E', 'SC-10-01-07', '[SC-10-01-07] Deployment', 'Task: Deployment
Task ID: SC-10-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-10-01] Workspace Scheduling
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6430BD51-6430-5787-8AA3-F3816644BA66', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-01', '[SC-10-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-10-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 5, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5B9364F6-5995-5DB5-B7AC-789DE0B6168B', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-02', '[SC-10-02-02] UI Design', 'Task: UI Design
Task ID: SC-10-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 3, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C0DCF7F6-86EF-5BF1-B1EF-2B64A1E509CE', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-03', '[SC-10-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-10-02-03
Estimated Effort: N/A
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 0, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FBAD73FB-14F7-5074-A8B7-E25968873834', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-04', '[SC-10-02-04] Architecture', 'Task: Architecture
Task ID: SC-10-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('89734BF0-037F-56C9-8854-22C55BD1E358', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-05', '[SC-10-02-05] Development', 'Task: Development
Task ID: SC-10-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 1, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('137F2723-AA35-5208-8023-C91C9E733F34', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-06', '[SC-10-02-06] Testing', 'Task: Testing
Task ID: SC-10-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 4, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CF19EAE1-7401-544D-88A3-F1B8C77178D8', '9F172DA2-1CDE-5106-A2C2-68B286D6FED5', 'SC-10-02-07', '[SC-10-02-07] Deployment', 'Task: Deployment
Task ID: SC-10-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-10-02] Workspace Operative Management
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('208A7D33-95D8-5205-8174-EB27595A1DD0', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-01', '[SC-10-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-10-03-01
Estimated Effort: 5 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 5, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9F3AC3C8-7B43-5752-A364-5799B7CC2ABF', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-02', '[SC-10-03-02] UI Design', 'Task: UI Design
Task ID: SC-10-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 3, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E9D8BE0C-C119-510B-9A3D-43EB7E527107', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-03', '[SC-10-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-10-03-03
Estimated Effort: 1 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 1, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C1E65EEB-AEC5-57D0-99FE-FB4B9ADE5540', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-04', '[SC-10-03-04] Architecture', 'Task: Architecture
Task ID: SC-10-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F8EE6477-5F81-5008-806E-774E052B5FAE', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-05', '[SC-10-03-05] Development', 'Task: Development
Task ID: SC-10-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 1, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D5DC9E84-D813-5C15-B45C-94D011C7C7AB', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-06', '[SC-10-03-06] Testing', 'Task: Testing
Task ID: SC-10-03-06
Estimated Effort: 4 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 4, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1C2A7D06-5C92-5FCD-9379-DE6C0F1A0D11', '9B6C2B81-4716-5B52-B6F0-E830763A222A', 'SC-10-03-07', '[SC-10-03-07] Deployment', 'Task: Deployment
Task ID: SC-10-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-10-03] Workspace Local Inventory
Screen: [SC-10] Kamar Operasi
Wave: [WAVE-05] DIAGNOSTIC & PROCEDURE SERVICES
PIC: Arie', 2, 'Arie');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('CD1E834F-A467-58D9-A6BD-A885BD7D1310', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-01', '[SC-11-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-11-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 5, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('96671F69-FF48-5D54-803F-6F3FB28D7F1F', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-02', '[SC-11-01-02] UI Design', 'Task: UI Design
Task ID: SC-11-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('4BC71D26-DEFD-5ED1-993D-9A454AF36B86', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-03', '[SC-11-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-11-01-03
Estimated Effort: N/A
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 0, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('42BEA471-175E-5840-BC62-2050735E1D2C', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-04', '[SC-11-01-04] Architecture', 'Task: Architecture
Task ID: SC-11-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('AB05D125-9571-55F7-A36C-99332D1CBF5F', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-05', '[SC-11-01-05] Development', 'Task: Development
Task ID: SC-11-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9F7E988E-A395-58B2-83A2-BC40867FAA6F', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-06', '[SC-11-01-06] Testing', 'Task: Testing
Task ID: SC-11-01-06
Estimated Effort: 3 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A847FF56-B2F7-5C08-AB73-FC05E1786470', '34A73E68-5A21-503B-BC70-46F393A560BE', 'SC-11-01-07', '[SC-11-01-07] Deployment', 'Task: Deployment
Task ID: SC-11-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-11-01] Workspace Antrian Apotek
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5A4E83C6-479D-58F6-92A7-BC7513FC84C3', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-01', '[SC-11-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-11-02-01
Estimated Effort: 4 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 4, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8EE15F0C-E36B-54DA-8493-7DAD5D283CD7', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-02', '[SC-11-02-02] UI Design', 'Task: UI Design
Task ID: SC-11-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BDA353A3-E55D-5D6E-BD4C-09F4B198721C', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-03', '[SC-11-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-11-02-03
Estimated Effort: 1 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('3296659F-9151-5BC9-B583-854D420EF1AB', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-04', '[SC-11-02-04] Architecture', 'Task: Architecture
Task ID: SC-11-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('0E9A5AA0-824E-5551-9071-D8DBD1E9C0AE', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-05', '[SC-11-02-05] Development', 'Task: Development
Task ID: SC-11-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FB43FB44-6561-5E04-A617-21FC2C347458', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-06', '[SC-11-02-06] Testing', 'Task: Testing
Task ID: SC-11-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 4, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('76D9D652-0ECE-5AE6-81AA-D294DEA0250B', '37C40862-94E1-5A99-8969-F26C22A8309E', 'SC-11-02-07', '[SC-11-02-07] Deployment', 'Task: Deployment
Task ID: SC-11-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-11-02] Workspace Telaah Resep
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7A7D7BC8-21E0-5E42-A1E5-28589EA0B215', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-01', '[SC-11-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-11-03-01
Estimated Effort: 5 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 5, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9C54C99F-89EC-5084-A812-D208675EF124', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-02', '[SC-11-03-02] UI Design', 'Task: UI Design
Task ID: SC-11-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('58F0E1FE-F48E-5514-824A-C8ECAF1659A5', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-03', '[SC-11-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-11-03-03
Estimated Effort: N/A
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 0, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C86195BA-D199-54A4-9A79-4A45C114201C', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-04', '[SC-11-03-04] Architecture', 'Task: Architecture
Task ID: SC-11-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('E586C930-8922-5C02-8B2E-B55926CEEBFF', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-05', '[SC-11-03-05] Development', 'Task: Development
Task ID: SC-11-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A965F711-45C5-5AE4-BAE5-A1FA7C49652A', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-06', '[SC-11-03-06] Testing', 'Task: Testing
Task ID: SC-11-03-06
Estimated Effort: 4 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 4, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('41FDC01B-E9AE-5559-903F-E9DFD5F94540', 'BAB235F5-A86B-5139-B700-72CD7A0AB0C5', 'SC-11-03-07', '[SC-11-03-07] Deployment', 'Task: Deployment
Task ID: SC-11-03-07
Estimated Effort: 2 day(s)
Workspace: [SC-11-03] Workspace Dispensing
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('28F43B47-7190-5C15-9D47-B313BD9FCA09', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-01', '[SC-11-04-01] Core Feature', 'Task: Core Feature
Task ID: SC-11-04-01
Estimated Effort: 3 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('A2508891-A470-5781-9E44-5F1CD0437CC7', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-02', '[SC-11-04-02] UI Design', 'Task: UI Design
Task ID: SC-11-04-02
Estimated Effort: 2 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7A1774A9-A97F-5AD5-85B5-377471746F45', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-03', '[SC-11-04-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-11-04-03
Estimated Effort: 1 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('AE3106ED-C488-526F-8CC2-8341D22B7C88', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-04', '[SC-11-04-04] Architecture', 'Task: Architecture
Task ID: SC-11-04-04
Estimated Effort: 2 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BE26B656-7AAB-5595-B722-57A5FAE47CD5', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-05', '[SC-11-04-05] Development', 'Task: Development
Task ID: SC-11-04-05
Estimated Effort: 1 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('65332EFB-2084-5DE0-AA7F-D7E5F08A47E5', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-06', '[SC-11-04-06] Testing', 'Task: Testing
Task ID: SC-11-04-06
Estimated Effort: 2 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('3CCADB80-1475-5E2E-BA66-EDFFE821153D', '0DD2D03E-FC0A-54D9-AE15-089050F72512', 'SC-11-04-07', '[SC-11-04-07] Deployment', 'Task: Deployment
Task ID: SC-11-04-07
Estimated Effort: 2 day(s)
Workspace: [SC-11-04] Workspace Serah Obat
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('45B19529-095E-5F25-A06A-A3E51C3BDCAA', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-01', '[SC-11-05-01] Core Feature', 'Task: Core Feature
Task ID: SC-11-05-01
Estimated Effort: 3 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D223B7B9-0C32-57C8-8B3D-305A43F68C74', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-02', '[SC-11-05-02] UI Design', 'Task: UI Design
Task ID: SC-11-05-02
Estimated Effort: 3 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 3, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C0D045CC-5BDA-5B12-AA7D-9455F1E0F570', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-03', '[SC-11-05-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-11-05-03
Estimated Effort: 1 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('EA655F60-CC9D-5063-8CDD-0EE5F3FE3262', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-04', '[SC-11-05-04] Architecture', 'Task: Architecture
Task ID: SC-11-05-04
Estimated Effort: 2 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('8984C447-3120-5970-9DFE-28554919686B', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-05', '[SC-11-05-05] Development', 'Task: Development
Task ID: SC-11-05-05
Estimated Effort: 1 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 1, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('97ACE9D0-B866-508B-98D4-AB9F31FCF5E5', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-06', '[SC-11-05-06] Testing', 'Task: Testing
Task ID: SC-11-05-06
Estimated Effort: 4 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 4, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7DA618B4-712F-524E-9DE7-D1D99FD0D70D', '2933F709-3C41-5610-8387-6AD544956BF1', 'SC-11-05-07', '[SC-11-05-07] Deployment', 'Task: Deployment
Task ID: SC-11-05-07
Estimated Effort: 2 day(s)
Workspace: [SC-11-05] Workspace Local Inventory
Screen: [SC-11] Apotek
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Jude', 2, 'Jude');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('EEBAD1A7-B6EB-5E43-B103-6C272F09B5AD', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-01', '[SC-12-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-12-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 5, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('58EF9310-66D4-51E9-AFC9-471A90B75342', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-02', '[SC-12-01-02] UI Design', 'Task: UI Design
Task ID: SC-12-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 3, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('DA415FDB-C9DA-5903-A634-E6DAD8630B4C', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-03', '[SC-12-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-12-01-03
Estimated Effort: N/A
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 0, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('BD150D83-910E-5E70-80BA-3E8A2FEDE3AC', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-04', '[SC-12-01-04] Architecture', 'Task: Architecture
Task ID: SC-12-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FE1C5CD3-94BA-5302-B2D1-9989CCDD0084', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-05', '[SC-12-01-05] Development', 'Task: Development
Task ID: SC-12-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 1, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('4EBB9420-03FF-5E60-8488-711C5AC5F294', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-06', '[SC-12-01-06] Testing', 'Task: Testing
Task ID: SC-12-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 4, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6263E04F-F78A-545B-8D4D-74C2703908DD', 'FE7070EC-820A-574F-A0E0-62A1DF16C0DC', 'SC-12-01-07', '[SC-12-01-07] Deployment', 'Task: Deployment
Task ID: SC-12-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-12-01] Workspace Terima Barang (DO), Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('97D4C46A-E6A5-58E7-B436-F76A3AD39360', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-01', '[SC-12-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-12-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 5, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FEE088C8-D42C-5BD0-99C8-7300C9FF015E', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-02', '[SC-12-02-02] UI Design', 'Task: UI Design
Task ID: SC-12-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 3, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('76626AF8-AD3D-5ADB-94A9-82828D22B59B', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-03', '[SC-12-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-12-02-03
Estimated Effort: N/A
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 0, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D0BD51B4-25F1-52D5-8D05-382D49D6014E', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-04', '[SC-12-02-04] Architecture', 'Task: Architecture
Task ID: SC-12-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('65AAC157-5170-512B-9AEC-8E2311A73C99', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-05', '[SC-12-02-05] Development', 'Task: Development
Task ID: SC-12-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 1, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('47AC1550-81B7-5F66-B6C9-160937209AE0', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-06', '[SC-12-02-06] Testing', 'Task: Testing
Task ID: SC-12-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 4, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('4D6ED70A-3D73-5873-B350-A47F91516FC1', 'B3C2E294-7360-5429-9A9A-19504CC0B2D1', 'SC-12-02-07', '[SC-12-02-07] Deployment', 'Task: Deployment
Task ID: SC-12-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-12-02] Workspace Local Inventory
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('1209262D-D24E-5ED5-BFC4-BEA34C7654D2', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-01', '[SC-12-03-01] Core Feature', 'Task: Core Feature
Task ID: SC-12-03-01
Estimated Effort: 5 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 5, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('41356600-2BB8-5020-A55C-FE9D3936F26B', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-02', '[SC-12-03-02] UI Design', 'Task: UI Design
Task ID: SC-12-03-02
Estimated Effort: 3 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 3, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('5C80B9F3-2A2E-53F5-9E57-073466502FB7', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-03', '[SC-12-03-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-12-03-03
Estimated Effort: N/A
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 0, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('962377D0-A887-5269-9259-6C44E32DF63B', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-04', '[SC-12-03-04] Architecture', 'Task: Architecture
Task ID: SC-12-03-04
Estimated Effort: 2 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D15601A3-C91D-541D-A64A-CDDA5A082E14', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-05', '[SC-12-03-05] Development', 'Task: Development
Task ID: SC-12-03-05
Estimated Effort: 1 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 1, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F4D5D4F3-7B99-55DB-B228-2DE4896D4F75', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-03-06', '[SC-12-03-06] Testing', 'Task: Testing
Task ID: SC-12-03-06
Estimated Effort: 4 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 4, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('346FE542-DDAE-5E36-89D3-9A55DA54BEA8', '4B9E5537-153C-594C-949B-55F24892B004', 'SC-12-06-07', '[SC-12-06-07] Deployment', 'Task: Deployment
Task ID: SC-12-06-07
Estimated Effort: 2 day(s)
Workspace: [SC-12-03] Workspace Retur Beli
Screen: [SC-12] Gudang
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Roso', 2, 'Roso');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('7BD807F7-04BC-56B4-B546-07A1418C5C99', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-01', '[SC-13-01-01] Core Feature', 'Task: Core Feature
Task ID: SC-13-01-01
Estimated Effort: 5 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 5, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('FBC1DE58-C6BF-5281-BB9A-44E76896738B', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-02', '[SC-13-01-02] UI Design', 'Task: UI Design
Task ID: SC-13-01-02
Estimated Effort: 3 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 3, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6F8A8F2A-4A76-5635-AB33-3A873BDCCEAD', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-03', '[SC-13-01-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-13-01-03
Estimated Effort: 1 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('D9A2A403-AA53-5E58-A021-7630C30813F5', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-04', '[SC-13-01-04] Architecture', 'Task: Architecture
Task ID: SC-13-01-04
Estimated Effort: 2 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('F8D1A3E1-D466-513C-BDB8-CB7664B406B6', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-05', '[SC-13-01-05] Development', 'Task: Development
Task ID: SC-13-01-05
Estimated Effort: 1 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('AB6EF5A9-3E4E-5A80-A161-E520B9C9C7C0', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-06', '[SC-13-01-06] Testing', 'Task: Testing
Task ID: SC-13-01-06
Estimated Effort: 4 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 4, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('EC45866E-E7DB-5F07-8FE3-5D6AC8D17387', 'AFCA7F86-15C7-53F1-A95A-281B716BD863', 'SC-13-01-07', '[SC-13-01-07] Deployment', 'Task: Deployment
Task ID: SC-13-01-07
Estimated Effort: 2 day(s)
Workspace: [SC-13-01] Workspace Purchase Order
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('C4389CFC-BD83-5900-93F1-21AB525428A2', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-01', '[SC-13-02-01] Core Feature', 'Task: Core Feature
Task ID: SC-13-02-01
Estimated Effort: 5 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 5, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('39FC0117-3067-549A-9FC1-E45B77207178', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-02', '[SC-13-02-02] UI Design', 'Task: UI Design
Task ID: SC-13-02-02
Estimated Effort: 3 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 3, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('9A8C2C83-A2C7-5267-BFA1-1A462AD8290F', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-03', '[SC-13-02-03] BFF Feature', 'Task: BFF Feature
Task ID: SC-13-02-03
Estimated Effort: N/A
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 0, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('36D57115-A62C-5F2D-A6B2-A55CD5745487', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-04', '[SC-13-02-04] Architecture', 'Task: Architecture
Task ID: SC-13-02-04
Estimated Effort: 2 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 2, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('927C3A4C-E97E-50CA-89AC-BFB73A68F0A4', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-05', '[SC-13-02-05] Development', 'Task: Development
Task ID: SC-13-02-05
Estimated Effort: 1 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 1, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('6CF6A9BA-EA7C-55E6-B45E-191C1CB9D093', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-06', '[SC-13-02-06] Testing', 'Task: Testing
Task ID: SC-13-02-06
Estimated Effort: 4 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 4, 'Fikri');
INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ('41D31A5D-F8CE-53BF-8572-525538284BDB', '8985CCB3-8DC3-579E-A4D4-118EA2151C8F', 'SC-13-02-07', '[SC-13-02-07] Deployment', 'Task: Deployment
Task ID: SC-13-02-07
Estimated Effort: 2 day(s)
Workspace: [SC-13-02] Workspace Faktur Tagihan
Screen: [SC-13] Purchasing
Wave: [WAVE-06] SUPPLY CHAIN & PHARMACY
PIC: Fikri', 2, 'Fikri');

-- 4. Upsert Work Packages into workpackage.WorkPackages
MERGE INTO [workpackage].[WorkPackages] AS TARGET
USING (
    SELECT 
        s.Id,
        s.Name,
        s.Objective,
        'ACTIVE' AS [Status],
        ISNULL(m.PersonId, @AdminPersonId) AS OwnerPersonId,
        @ProductId AS ProductId,
        @ImportTime AS CreatedAt
    FROM @StagedWorkPackages s
    LEFT JOIN @PicMapping m ON s.Pic = m.PicName
) AS SOURCE (Id, Name, Objective, [Status], OwnerPersonId, ProductId, CreatedAt)
ON (TARGET.Id = SOURCE.Id)
WHEN MATCHED THEN
    UPDATE SET 
        TARGET.Name = SOURCE.Name,
        TARGET.Objective = SOURCE.Objective,
        TARGET.OwnerPersonId = SOURCE.OwnerPersonId,
        TARGET.ProductId = SOURCE.ProductId,
        TARGET.UpdatedAt = @ImportTime
WHEN NOT MATCHED THEN
    INSERT (Id, Name, Objective, [Status], OwnerPersonId, ProductId, CreatedAt)
    VALUES (SOURCE.Id, SOURCE.Name, SOURCE.Objective, SOURCE.Status, SOURCE.OwnerPersonId, SOURCE.ProductId, SOURCE.CreatedAt);

SET @WorkPackagesCount = @@ROWCOUNT;

-- 5. Upsert Requests into request.Requests
MERGE INTO [request].[Requests] AS TARGET
USING (
    SELECT 
        r.Id,
        r.Title,
        r.Description,
        'FEATURE' AS RequestType,
        'ACCEPTED' AS [Status],
        'NORMAL' AS Priority,
        ISNULL(m.PersonId, @AdminPersonId) AS OwnerPersonId,
        @ProductId AS ProductId,
        r.WorkPackageId,
        CONCAT('Estimated Effort: ', r.Effort, ' day(s)') AS EvaluationNotes,
        @ImportTime AS CreatedAt
    FROM @StagedRequests r
    LEFT JOIN @PicMapping m ON r.Pic = m.PicName
) AS SOURCE (Id, Title, Description, RequestType, [Status], Priority, OwnerPersonId, ProductId, WorkPackageId, EvaluationNotes, CreatedAt)
ON (TARGET.Id = SOURCE.Id)
WHEN MATCHED THEN
    UPDATE SET 
        TARGET.Title = SOURCE.Title,
        TARGET.Description = SOURCE.Description,
        TARGET.OwnerPersonId = SOURCE.OwnerPersonId,
        TARGET.ProductId = SOURCE.ProductId,
        TARGET.WorkPackageId = SOURCE.WorkPackageId,
        TARGET.EvaluationNotes = SOURCE.EvaluationNotes,
        TARGET.UpdatedAt = @ImportTime
WHEN NOT MATCHED THEN
    INSERT (Id, Title, Description, RequestType, [Status], Priority, OwnerPersonId, ProductId, WorkPackageId, EvaluationNotes, CreatedAt)
    VALUES (SOURCE.Id, SOURCE.Title, SOURCE.Description, SOURCE.RequestType, SOURCE.Status, SOURCE.Priority, SOURCE.OwnerPersonId, SOURCE.ProductId, SOURCE.WorkPackageId, SOURCE.EvaluationNotes, SOURCE.CreatedAt);

SET @RequestsCount = @@ROWCOUNT;

-- 6. Upsert Links into workpackage.WorkPackageRequests
MERGE INTO [workpackage].[WorkPackageRequests] AS TARGET
USING (
    SELECT 
        r.WorkPackageId,
        r.Id AS RequestId,
        @ImportTime AS AddedAt,
        @ImportTime AS CreatedAt
    FROM @StagedRequests r
) AS SOURCE (WorkPackageId, RequestId, AddedAt, CreatedAt)
ON (TARGET.WorkPackageId = SOURCE.WorkPackageId AND TARGET.RequestId = SOURCE.RequestId)
WHEN MATCHED AND TARGET.RemovedAt IS NOT NULL THEN
    UPDATE SET TARGET.RemovedAt = NULL, TARGET.UpdatedAt = @ImportTime
WHEN NOT MATCHED THEN
    INSERT (Id, WorkPackageId, RequestId, AddedAt, CreatedAt)
    VALUES (NEWID(), SOURCE.WorkPackageId, SOURCE.RequestId, SOURCE.AddedAt, SOURCE.CreatedAt);

SET @LinksCount = @@ROWCOUNT;

COMMIT TRANSACTION;

PRINT '==================================================';
PRINT 'Import Summary:';
PRINT CONCAT('- Work Packages processed: ', @WorkPackagesCount);
PRINT CONCAT('- Requests processed:      ', @RequestsCount);
PRINT CONCAT('- Links processed:         ', @LinksCount);
PRINT '==================================================';