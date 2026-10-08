# Executive Summary: MyHosWeb System Implementation (Rev 6)
**Document Type:** Board of Directors Briefing  
**System:** MyHosWeb Integrated Hospital Information System (SIMRS)  
**MS Project File:** `workspace-task-rev-6-ms-project.mpp`  
**Operational Capacity Model:** **4 Hours / Day** (24 Hours/Week, Monday – Saturday)  
**Date of Report:** October 7, 2026  

---

## 1. Executive Snapshot & Strategic Overview

The **MyHosWeb System** is the digital enterprise backbone for modern hospital operations, unifying front office patient access, outpatient & inpatient care, emergency response, surgical suites, diagnostic laboratories & imaging (PACS), clinical pharmacy, supply chain logistics, hospital billing, and procurement.

Revision 6 (`workspace-task-rev-6-ms-project.mpp`) establishes a **strengthened quality assurance and staging deployment baseline**. Based on executive review, the engineering capacity is formally modeled at **4 hours/day per engineer (24 hours/week)** across **9 dedicated parallel workstreams**.

| Key Metric | Value (4h/Day Model) | Strategic Executive Context |
| :--- | :---: | :--- |
| **Daily Capacity Model** | **4 Hours / Day** | Part-time / focused allocation (24 hrs/wk, Mon–Sat) per engineer |
| **Net Engineering Effort** | **5,744 Person-Hours** | **1,436 Man-Days (@ 4h/day)** across 303 unique work packages |
| **Gross Work (MS Project Rollup)** | **11,480 Person-Hours** | Standard rollup across 34 summary milestones & 303 work packages |
| **Operational Workspaces** | **34 Workspaces** | Covering 13 hospital clinical, diagnostic, and administrative departments |
| **Engineering Capacity** | **9 Domain Engineers** | 100% single-stream dedicated assignment with leveled workload |
| **Project Kickoff** | **October 12, 2026** | Initial booking sprint active since Sept 20; full 9 streams kick off Oct 12 |
| **Final Delivery Due Date** | **February 09, 2027** | Final milestone (Radiology Local Inventory) reaches full staging readiness |

```mermaid
timeline
    title MyHosWeb Phased Delivery & Board Governance Milestones (Rev 6)
    section Wave 1 (Nov 2026) : Foundation & Front-End Access
        Week 4 (Nov 03 - 07) : Admisi Ranap : Tata Rekening : RM Berkas : OK Scheduling : Poli Tindakan
        Week 5 (Nov 09 - 16) : Gudang DO : Apotek Antrian : Lab Order : Bangsal Bed Mgmt
        Week 6 (Nov 24 - 26) : Kasir Payment : Apotek Telaah Resep
    section Wave 2 (Dec 2026) : Clinical Workflows & Revenue Close
        Week 7 (Dec 01 - 08) : Poli Inv : RM Casemix : Lab Results : OK Management : IGD Triage : Inpatient Cutover (Sulis finishes)
        Week 8 (Dec 11 - 18) : Kasir Closing Shift : Apotek Dispensing
        Week 9 (Dec 25 - 29) : RM Kemenkes RL (Rizal) : OK Inv (Arie) : Gudang Retur (Roso) : IGD Inv (Arif) : Radiologi Order
    section Wave 3 (Jan - Feb 2027) : Diagnostics, Supply Chain & Final Cutover
        Week 10 (Jan 02) : Lab Local Inventory (Erkoc finishes)
        Week 11 (Jan 07 - 18) : Apotek Serah Obat : Purchasing PO : Radiologi PACS Expertise
        Week 12 (Jan 28 - 30) : Apotek Local Inv (Jude) : Purchasing Faktur AP (Fikri)
        Week 14 (Feb 09) : Radiologi Local Inv (We finishes - Complete Hospital Cutover)
```

---

## 2. Complete Workspace Due Date Schedule (All 34 Workspaces)

The table below lists all **34 operational workspaces**, ordered chronologically by **Due Date**, showing the assigned Person-in-Charge (PIC), technical effort, and man-days under the **4 hours/day model**:

| No | Module Code | Operational Workspace Name | Lead (PIC) | Effort (Hours) | Effort (Man-Days @ 4h/d) | Start Date | **Due Date (Completion)** |
| :-: | :---: | :--- | :---: | :---: | :---: | :---: | :---: |
| 1 | **SC-01-02** | Admisi Workspace Reg Rajal-IGD | Arif | 152 hrs | 38.0 days | 2026-09-20 | **2026-10-10** |
| 2 | **SC-01-01** | Admisi Workspace Booking | Arif | 144 hrs | 36.0 days | 2026-09-22 | **2026-10-12** |
| 3 | **SC-01-03** | Admisi Workspace Reg Ranap | Arif | 160 hrs | 40.0 days | 2026-10-12 | **2026-11-03** |
| 4 | **SC-02-01** | Tata Rekening Workspace Reg Out | Erkoc | 168 hrs | 42.0 days | 2026-10-12 | **2026-11-04** |
| 5 | **SC-04-01** | Rekam Medis Workspace Berkas RM | Rizal | 176 hrs | 44.0 days | 2026-10-12 | **2026-11-05** |
| 6 | **SC-10-01** | Kamar Operasi Workspace Scheduling | Arie | 184 hrs | 46.0 days | 2026-10-12 | **2026-11-06** |
| 7 | **SC-05-01** | Poli Rawat Jalan Workspace Tindakan | Fikri | 192 hrs | 48.0 days | 2026-10-12 | **2026-11-07** |
| 8 | **SC-12-01** | Gudang Workspace Terima Barang (DO) | Roso | 200 hrs | 50.0 days | 2026-10-12 | **2026-11-09** |
| 9 | **SC-11-01** | Apotek Workspace Antrian Apotek | Jude | 208 hrs | 52.0 days | 2026-10-12 | **2026-11-10** |
| 10 | **SC-08-01** | Laboratorium Workspace Order Laboratorium | We | 216 hrs | 54.0 days | 2026-10-12 | **2026-11-11** |
| 11 | **SC-06-01** | Bangsal Rawat Inap Workspace Bed Management | Sulis | 248 hrs | 62.0 days | 2026-10-12 | **2026-11-16** |
| 12 | **SC-03-01** | Kasir Workspace Kasir | Erkoc | 136 hrs | 34.0 days | 2026-11-05 | **2026-11-24** |
| 13 | **SC-11-02** | Apotek Workspace Telaah Resep | Jude | 112 hrs | 28.0 days | 2026-11-11 | **2026-11-26** |
| 14 | **SC-05-02** | Poli Rawat Jalan Workspace Local Inventory | Fikri | 160 hrs | 40.0 days | 2026-11-09 | **2026-12-01** |
| 15 | **SC-04-02** | Rekam Medis Workspace Casemix dan Coding | Rizal | 176 hrs | 44.0 days | 2026-11-06 | **2026-12-01** |
| 16 | **SC-08-02** | Laboratorium Workspace Result Management | We | 136 hrs | 34.0 days | 2026-11-12 | **2026-12-01** |
| 17 | **SC-10-02** | Kamar Operasi Workspace Operative Management | Arie | 192 hrs | 48.0 days | 2026-11-07 | **2026-12-04** |
| 18 | **SC-12-02** | Gudang Workspace Local Inventory | Roso | 184 hrs | 46.0 days | 2026-11-10 | **2026-12-05** |
| 19 | **SC-07-01** | IGD Workspace IGD Triage | Arif | 232 hrs | 58.0 days | 2026-11-04 | **2026-12-07** |
| 20 | **SC-05-02** | Bangsal Rawat Inap Workspace Local Inventory | Sulis | 152 hrs | 38.0 days | 2026-11-17 | **2026-12-08** |
| 21 | **SC-03-02** | Kasir Workspace Closing Shift | Erkoc | 120 hrs | 30.0 days | 2026-11-25 | **2026-12-11** |
| 22 | **SC-11-03** | Apotek Workspace Dispensing | Jude | 152 hrs | 38.0 days | 2026-11-27 | **2026-12-18** |
| 23 | **SC-04-03** | Rekam Medis Workspace Pelaporan RL | Rizal | 168 hrs | 42.0 days | 2026-12-02 | **2026-12-25** |
| 24 | **SC-10-03** | Kamar Operasi Workspace Local Inventory | Arie | 152 hrs | 38.0 days | 2026-12-05 | **2026-12-26** |
| 25 | **SC-12-03** | Gudang Workspace Retur Beli | Roso | 144 hrs | 36.0 days | 2026-12-07 | **2026-12-26** |
| 26 | **SC-05-02** | IGD Workspace Local Inventory | Arif | 152 hrs | 38.0 days | 2026-12-08 | **2026-12-29** |
| 27 | **SC-09-01** | Radiologi Workspace Order Radiologi | We | 200 hrs | 50.0 days | 2026-12-02 | **2026-12-30** |
| 28 | **SC-08-03** | Laboratorium Workspace Local Inventory | Erkoc | 152 hrs | 38.0 days | 2026-12-12 | **2027-01-02** |
| 29 | **SC-11-04** | Apotek Workspace Serah Obat | Jude | 136 hrs | 34.0 days | 2026-12-19 | **2027-01-07** |
| 30 | **SC-13-01** | Purchasing Workspace Purchase Order | Fikri | 256 hrs | 64.0 days | 2026-12-02 | **2027-01-07** |
| 31 | **SC-09-02** | Radiologi Workspace Expertise | We | 128 hrs | 32.0 days | 2026-12-31 | **2027-01-18** |
| 32 | **SC-11-05** | Apotek Workspace Local Inventory | Jude | 144 hrs | 36.0 days | 2027-01-08 | **2027-01-28** |
| 33 | **SC-13-02** | Purchasing Workspace Faktur Tagihan | Fikri | 160 hrs | 40.0 days | 2027-01-08 | **2027-01-30** |
| 34 | **SC-09-03** | Radiologi Workspace Local Inventory | We | 152 hrs | 38.0 days | 2027-01-19 | **2027-02-09** |
| **TOTAL** | | **All 34 Workspaces** | **9 Leads** | **5,744 hrs** | **1,436.0 days** | **2026-09-20** | **2027-02-09** |

---

## 3. Human Capital Allocation & Capacity Ranking (4 Hours/Day Model)

Under the **4 hours/day model**, 1 man-day equals 4 productive engineering hours (24 hours/week). The distribution remains balanced across the 9 domain leads:

| Rank | Resource Name | Assigned Hospital Workspaces | Leaf Tasks | Total Hours | **Man-Days (@ 4h/d)** | % Share | Projected Stream Finish |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **1** | **Arif** | Front Office (Admisi & IGD) | 52 | **840.0 hrs** | **210.0 days** | 14.62% | Dec 29, 2026 |
| **2** | **We** | Diagnostics (Lab & Radiologi) | 43 | **832.0 hrs** | **208.0 days** | 14.48% | **Feb 09, 2027** *(Critical Path)* |
| **3** | **Fikri** | Outpatient & Purchasing | 36 | **768.0 hrs** | **192.0 days** | 13.37% | Jan 30, 2027 |
| **4** | **Jude** | Pharmacy & E-Prescription | 44 | **752.0 hrs** | **188.0 days** | 13.09% | Jan 28, 2027 |
| **5** | **Erkoc** | Cashier, Revenue & Lab Inv | 31 | **576.0 hrs** | **144.0 days** | 10.03% | Jan 02, 2027 |
| **6** | **Arie** | Operating Theaters (OK) | 27 | **528.0 hrs** | **132.0 days** | 9.19% | Dec 26, 2026 |
| **7** | **Roso** | Warehouse & Logistics | 26 | **528.0 hrs** | **132.0 days** | 9.19% | Dec 26, 2026 |
| **8** | **Rizal** | Medical Records & Compliance | 23 | **520.0 hrs** | **130.0 days** | 9.05% | Dec 25, 2026 |
| **9** | **Sulis** | Inpatient & Bed Management | 21 | **400.0 hrs** | **100.0 days** | 6.96% | Dec 08, 2026 |
| **TOTAL** | | **Full Engineering Team** | **303** | **5,744.0 hrs** | **1,436.0 days** | **100.00%** | **Feb 09, 2027** |

---

## 4. Strategic Delivery Waves & Governance Gates

The Board of Directors can evaluate progress against **3 Definitive Governance Gates**:

### Gate 1: Front Office, Outpatient & Inpatient Foundation (December 08, 2026)
* **Scope**: Admisi Booking & Registrasi, Rawat Jalan Clinic Consultation, Inpatient Bed Management, and Cashier Payment Point.
* **Success Criteria**: End-to-end digital patient encounter from self-service booking to bed assignment and preliminary billing without paper records.
* **Resource Status**: `Sulis` completes all deliverables; `Arif`, `Erkoc`, and `Fikri` reach over 70% milestone readiness.

### Gate 2: Perioperative, Supply Chain & Compliance (December 29, 2026)
* **Scope**: Emergency Triage (IGD), Operating Rooms (OK), Central Warehouse Logistics, and Medical Records (Kemenkes RL & Casemix).
* **Success Criteria**: Automated stock deductions on surgical consumption; zero discrepancies on test export of BPJS/Kemenkes ICD-10 data.
* **Resource Status**: `Rizal`, `Arie`, `Roso`, and `Arif` complete all stream commitments.

### Gate 3: Diagnostics, AP Billing & Full Production Cutover (February 09, 2027)
* **Scope**: Laboratory LIS interfaces, Radiologi PACS imaging & digital reports, Pharmacy dispensing, and Purchasing invoices.
* **Success Criteria**: Imaging results broadcast to EMR in <30 seconds; 100% test pass rate across all 34 workspaces; final production cutover sign-off.
* **Resource Status**: Final delivery of Radiologi Local Inventory by `We` marks full system operational readiness.

---

## 5. Board Action & Next Steps

1. **Adopt 4h/Day Resource Model**: Formally record total engineering capacity as **1,436 Man-Days** based on the 4 hours/day (24 hours/week) model.
2. **Monitor Workspace Due Dates**: Use the 34-workspace due date master table for weekly project PMO tracking and steering committee reviews.
3. **Approve Engineer Redeployment**: Authorize program management to redeploy engineers completing in December (`Sulis`, `Rizal`, `Arie`, `Roso`) toward PACS acceleration, user simulation, and hospital staff training.
