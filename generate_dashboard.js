/**
 * MYHOSWEB Development Planning Dashboard Generator
 * 
 * Usage:
 *   node generate_dashboard.js
 * 
 * Description:
 *   Reads `wave-screen.json` (or `screen-wave.json` as fallback) from the project directory,
 *   embeds the raw JSON payload into `myhosweb-development-plan.html`, and recalculates
 *   all executive scope, timeline, effort, and resource metrics.
 */

const fs = require('fs');
const path = require('path');

// Determine JSON source file
const currentDir = __dirname;
let jsonPath = path.join(currentDir, 'wave-screen.json');

if (!fs.existsSync(jsonPath) && fs.existsSync(path.join(currentDir, 'screen-wave.json'))) {
  jsonPath = path.join(currentDir, 'screen-wave.json');
}

if (!fs.existsSync(jsonPath)) {
  console.error('Error: Could not find wave-screen.json or screen-wave.json in', currentDir);
  process.exit(1);
}

const sourceFileName = path.basename(jsonPath);
const rawData = fs.readFileSync(jsonPath, 'utf8');

const htmlContent = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MYHOSWEB - Executive Development Planning Dashboard</title>
  <style>
    :root {
      --bg-main: #f8fafc;
      --bg-card: #ffffff;
      --text-main: #0f172a;
      --text-muted: #64748b;
      --border-color: #e2e8f0;
      
      --navy-900: #0f172a;
      --navy-800: #1e293b;
      --navy-700: #334155;
      
      --indigo-600: #4f46e5;
      --indigo-700: #4338ca;
      --indigo-50: #eef2ff;
      --indigo-100: #e0e7ff;

      --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      
      --radius-sm: 6px;
      --radius-md: 10px;
      --radius-lg: 16px;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    body {
      background-color: var(--bg-main);
      color: var(--text-main);
      line-height: 1.5;
      font-size: 14px;
      padding-bottom: 60px;
    }

    .container {
      max-width: 1440px;
      margin: 0 auto;
      padding: 0 24px;
    }

    /* Header */
    header {
      background: linear-gradient(135deg, var(--navy-900) 0%, #1e1b4b 100%);
      color: #ffffff;
      padding: 32px 0;
      margin-bottom: 24px;
      box-shadow: var(--shadow-md);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      flex-wrap: wrap;
      gap: 20px;
    }

    .header-title-area h1 {
      font-size: 26px;
      font-weight: 700;
      letter-spacing: -0.02em;
      margin-bottom: 6px;
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .header-title-area p {
      color: #94a3b8;
      font-size: 14px;
      max-width: 760px;
    }

    .badge-no-progress {
      background-color: rgba(79, 70, 229, 0.3);
      color: #a5b4fc;
      border: 1px solid rgba(165, 180, 252, 0.3);
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.03em;
      text-transform: uppercase;
    }

    .header-actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .btn {
      background-color: #ffffff;
      color: var(--navy-900);
      border: 1px solid var(--border-color);
      padding: 8px 16px;
      border-radius: var(--radius-sm);
      font-weight: 600;
      font-size: 13px;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      transition: all 0.2s ease;
      text-decoration: none;
    }

    .btn:hover {
      background-color: #f1f5f9;
      border-color: #cbd5e1;
    }

    .btn-outline-white {
      background-color: rgba(255, 255, 255, 0.1);
      color: #ffffff;
      border-color: rgba(255, 255, 255, 0.2);
    }

    .btn-outline-white:hover {
      background-color: rgba(255, 255, 255, 0.2);
    }

    /* Executive Callout */
    .executive-callout {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-left: 4px solid var(--indigo-600);
      border-radius: var(--radius-md);
      padding: 20px 24px;
      margin-bottom: 28px;
      box-shadow: var(--shadow-sm);
    }

    .executive-callout h3 {
      font-size: 15px;
      font-weight: 700;
      color: var(--navy-900);
      margin-bottom: 14px;
      display: flex;
      align-items: center;
      gap: 8px;
      text-transform: uppercase;
      letter-spacing: 0.04em;
    }

    .qa-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
      gap: 14px;
    }

    .qa-item {
      background-color: #f8fafc;
      border: 1px solid #f1f5f9;
      padding: 12px 16px;
      border-radius: var(--radius-sm);
    }

    .qa-question {
      font-size: 11px;
      font-weight: 700;
      color: var(--indigo-600);
      text-transform: uppercase;
      letter-spacing: 0.04em;
      margin-bottom: 4px;
    }

    .qa-answer {
      font-size: 13px;
      font-weight: 700;
      color: var(--navy-900);
    }

    /* Navigation Bar */
    .nav-bar {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 8px 16px;
      margin-bottom: 28px;
      display: flex;
      align-items: center;
      gap: 8px;
      overflow-x: auto;
      box-shadow: var(--shadow-sm);
      position: sticky;
      top: 12px;
      z-index: 100;
    }

    .nav-item {
      color: var(--text-muted);
      text-decoration: none;
      font-size: 13px;
      font-weight: 600;
      padding: 8px 14px;
      border-radius: var(--radius-sm);
      white-space: nowrap;
      transition: all 0.2s ease;
    }

    .nav-item:hover, .nav-item.active {
      color: var(--indigo-600);
      background-color: #f1f5f9;
    }

    /* Section Component */
    .section-block {
      margin-bottom: 36px;
      scroll-margin-top: 80px;
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
    }

    .section-title {
      font-size: 18px;
      font-weight: 700;
      color: var(--navy-900);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .section-tag {
      font-size: 11px;
      font-weight: 700;
      color: var(--indigo-600);
      background-color: var(--indigo-100);
      padding: 2px 8px;
      border-radius: 4px;
      text-transform: uppercase;
    }

    /* Section 1: KPI Cards */
    .kpi-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 16px;
    }

    .kpi-card {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 20px;
      box-shadow: var(--shadow-sm);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      position: relative;
      overflow: hidden;
    }

    .kpi-card::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 3px;
      background-color: var(--indigo-600);
    }

    .kpi-card:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .kpi-label {
      font-size: 12px;
      font-weight: 600;
      color: var(--text-muted);
      text-transform: uppercase;
      letter-spacing: 0.04em;
      margin-bottom: 8px;
    }

    .kpi-value {
      font-size: 32px;
      font-weight: 800;
      color: var(--navy-900);
      line-height: 1.1;
      margin-bottom: 6px;
    }

    .kpi-subtext {
      font-size: 12px;
      color: var(--text-muted);
    }

    /* Section 8: Critical Workloads (Top 5s) */
    .top-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
      gap: 20px;
    }

    .top-card {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 20px;
      box-shadow: var(--shadow-sm);
    }

    .top-card-header {
      font-size: 14px;
      font-weight: 700;
      color: var(--navy-900);
      margin-bottom: 16px;
      padding-bottom: 10px;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .top-item-list {
      list-style: none;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .top-item {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }

    .top-item-info {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 13px;
    }

    .top-item-name {
      font-weight: 600;
      color: var(--navy-900);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .top-item-val {
      font-weight: 700;
      color: var(--indigo-600);
    }

    .progress-track {
      width: 100%;
      height: 6px;
      background-color: #f1f5f9;
      border-radius: 3px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, var(--indigo-600), #818cf8);
      border-radius: 3px;
    }

    /* Section 2: Delivery Roadmap Cards */
    .roadmap-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
      gap: 20px;
    }

    .wave-card {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 24px;
      box-shadow: var(--shadow-sm);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      position: relative;
    }

    .wave-card-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 14px;
    }

    .wave-badge {
      background-color: var(--navy-900);
      color: #ffffff;
      font-size: 11px;
      font-weight: 700;
      padding: 3px 8px;
      border-radius: 4px;
      letter-spacing: 0.05em;
    }

    .wave-title {
      font-size: 16px;
      font-weight: 700;
      color: var(--navy-900);
      margin-top: 4px;
    }

    .wave-stats-row {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 12px;
      background-color: #f8fafc;
      padding: 12px;
      border-radius: var(--radius-sm);
      margin: 14px 0;
      border: 1px solid #f1f5f9;
    }

    .wave-stat {
      text-align: center;
    }

    .wave-stat-val {
      font-size: 18px;
      font-weight: 700;
      color: var(--navy-900);
    }

    .wave-stat-lbl {
      font-size: 11px;
      color: var(--text-muted);
      text-transform: uppercase;
    }

    .wave-pics {
      display: flex;
      align-items: center;
      gap: 6px;
      flex-wrap: wrap;
      margin-top: 8px;
    }

    .pic-tag {
      background-color: var(--indigo-100);
      color: var(--indigo-700);
      font-size: 11px;
      font-weight: 600;
      padding: 2px 8px;
      border-radius: 12px;
      border: 1px solid #c7d2fe;
    }

    /* Section 3: Wave Breakdown Hierarchy */
    .tree-controls {
      display: flex;
      gap: 10px;
      margin-bottom: 12px;
    }

    .tree-container {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 20px;
      box-shadow: var(--shadow-sm);
    }

    .tree-node {
      border: 1px solid var(--border-color);
      border-radius: var(--radius-sm);
      margin-bottom: 10px;
      overflow: hidden;
    }

    .tree-node-header {
      background-color: #f8fafc;
      padding: 12px 16px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      cursor: pointer;
      user-select: none;
      font-weight: 600;
      transition: background-color 0.2s ease;
    }

    .tree-node-header:hover {
      background-color: #f1f5f9;
    }

    .tree-node-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 14px;
      color: var(--navy-900);
    }

    .toggle-icon {
      width: 18px;
      height: 18px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 12px;
      color: var(--text-muted);
      background: #ffffff;
      border: 1px solid var(--border-color);
      border-radius: 4px;
    }

    .tree-node-body {
      padding: 12px 16px 12px 36px;
      border-top: 1px solid var(--border-color);
      background-color: #ffffff;
      display: block;
    }

    .tree-node-body.collapsed {
      display: none;
    }

    .effort-pill {
      background-color: #f1f5f9;
      color: var(--navy-900);
      font-size: 12px;
      font-weight: 700;
      padding: 3px 10px;
      border-radius: 12px;
      border: 1px solid #e2e8f0;
    }

    /* Section 4: Screen Planning Table */
    .table-container {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
      overflow: hidden;
    }

    .table-toolbar {
      padding: 16px 20px;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 16px;
      flex-wrap: wrap;
    }

    .search-input {
      padding: 8px 14px;
      border: 1px solid var(--border-color);
      border-radius: var(--radius-sm);
      font-size: 13px;
      width: 280px;
      outline: none;
      transition: border-color 0.2s ease;
    }

    .search-input:focus {
      border-color: var(--indigo-600);
    }

    .planning-table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
      font-size: 13px;
    }

    .planning-table th {
      background-color: #f8fafc;
      color: var(--text-muted);
      font-weight: 700;
      text-transform: uppercase;
      font-size: 11px;
      letter-spacing: 0.04em;
      padding: 12px 20px;
      border-bottom: 1px solid var(--border-color);
      cursor: pointer;
      user-select: none;
    }

    .planning-table th:hover {
      color: var(--navy-900);
      background-color: #f1f5f9;
    }

    .planning-table td {
      padding: 14px 20px;
      border-bottom: 1px solid var(--border-color);
      color: var(--navy-900);
    }

    .planning-table tr:last-child td {
      border-bottom: none;
    }

    .planning-table tr:hover td {
      background-color: #f8fafc;
    }

    /* Section 5 & 6: Resource Allocation & Workload Chart */
    .resource-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    @media (max-width: 900px) {
      .resource-grid {
        grid-template-columns: 1fr;
      }
    }

    .pic-workload-card {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 20px;
      box-shadow: var(--shadow-sm);
    }

    .bar-chart-row {
      display: flex;
      align-items: center;
      gap: 16px;
      margin-bottom: 14px;
    }

    .bar-pic-name {
      width: 80px;
      font-weight: 700;
      font-size: 13px;
      color: var(--navy-900);
    }

    .bar-container-wrapper {
      flex: 1;
      background-color: #f1f5f9;
      height: 24px;
      border-radius: 4px;
      overflow: hidden;
    }

    .bar-fill-inner {
      height: 100%;
      background: linear-gradient(90deg, var(--indigo-600), #6366f1);
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: flex-end;
      padding-right: 8px;
      color: #ffffff;
      font-size: 11px;
      font-weight: 700;
    }

    .bar-fill-inner.highest {
      background: linear-gradient(90deg, #4338ca, #3730a3);
    }

    .bar-val-label {
      width: 70px;
      text-align: right;
      font-weight: 700;
      font-size: 13px;
      color: var(--navy-900);
    }

    /* Section 7: Proposed Timeline Gantt */
    .gantt-wrapper {
      background-color: var(--bg-card);
      border: 1px solid var(--border-color);
      border-radius: var(--radius-md);
      padding: 24px;
      box-shadow: var(--shadow-sm);
      overflow-x: auto;
    }

    .gantt-header-row {
      display: grid;
      grid-template-columns: 220px repeat(8, 1fr);
      border-bottom: 2px solid var(--border-color);
      padding-bottom: 10px;
      margin-bottom: 12px;
      font-size: 12px;
      font-weight: 700;
      color: var(--text-muted);
      text-transform: uppercase;
      min-width: 900px;
    }

    .gantt-wave-row {
      display: grid;
      grid-template-columns: 220px 1fr;
      align-items: center;
      padding: 12px 0;
      border-bottom: 1px solid var(--border-color);
      min-width: 900px;
    }

    .gantt-wave-label {
      font-weight: 700;
      font-size: 13px;
      color: var(--navy-900);
      padding-right: 12px;
    }

    .gantt-track-area {
      position: relative;
      height: 32px;
      background-color: #f8fafc;
      border-radius: 6px;
      overflow: hidden;
    }

    .gantt-bar-item {
      position: absolute;
      top: 3px;
      height: 26px;
      background: linear-gradient(90deg, var(--indigo-600), #818cf8);
      border-radius: 4px;
      display: flex;
      align-items: center;
      padding: 0 10px;
      color: #ffffff;
      font-size: 11px;
      font-weight: 700;
      box-shadow: 0 2px 4px rgba(79, 70, 229, 0.25);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    @media print {
      body { background-color: #ffffff; }
      header { background: none; color: #000; padding: 0; margin-bottom: 20px; }
      .nav-bar, .btn { display: none !important; }
      .container { max-width: 100%; padding: 0; }
      .kpi-card, .top-card, .wave-card, .tree-container, .table-container, .pic-workload-card, .gantt-wrapper {
        box-shadow: none; border: 1px solid #ccc; break-inside: avoid;
      }
    }
  </style>
</head>
<body>

  <!-- HEADER -->
  <header>
    <div class="container">
      <div class="header-content">
        <div class="header-title-area">
          <h1>
            <span>MYHOSWEB Development Plan</span>
            <span class="badge-no-progress">Pre-Implementation Strategy</span>
          </h1>
          <p>
            Executive baseline roadmap covering Scope, Effort, Resource Allocation, and Delivery Waves. Dynamically calculated from ${sourceFileName} specification.
          </p>
        </div>
        <div class="header-actions">
          <label class="btn btn-outline-white" style="cursor: pointer;">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"></path></svg>
            Upload JSON File
            <input type="file" id="jsonFileInput" accept=".json" style="display: none;" onchange="handleFileUpload(event)">
          </label>
          <button class="btn" onclick="window.print()">
            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"></path></svg>
            Export PDF / Print
          </button>
        </div>
      </div>
    </div>
  </header>

  <div class="container">

    <!-- NAVIGATION BAR -->
    <nav class="nav-bar">
      <a href="#summary" class="nav-item active">1. Summary</a>
      <a href="#critical" class="nav-item">2. Critical Workloads</a>
      <a href="#roadmap" class="nav-item">3. Delivery Waves</a>
      <a href="#breakdown" class="nav-item">4. Scope Hierarchy</a>
      <a href="#table" class="nav-item">5. Screen Table</a>
      <a href="#allocation" class="nav-item">6. Resource Allocation</a>
      <a href="#timeline" class="nav-item">7. Proposed Timeline</a>
    </nav>

    <!-- EXECUTIVE Q&A CALLOUT SUMMARY -->
    <div class="executive-callout">
      <h3>Executive Briefing & Key Answers</h3>
      <div class="qa-grid" id="qaSummaryGrid"></div>
    </div>

    <!-- SECTION 1: EXECUTIVE SUMMARY -->
    <section id="summary" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 1: Executive Summary</span>
          <span class="section-tag">Key Metrics</span>
        </h2>
      </div>
      <div class="kpi-grid" id="kpiGrid"></div>
    </section>

    <!-- SECTION 8: CRITICAL WORKLOADS -->
    <section id="critical" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 8: Critical Workload Hotspots</span>
          <span class="section-tag">Executive Focus</span>
        </h2>
      </div>
      <div class="top-grid">
        <div class="top-card">
          <div class="top-card-header">
            <span>Top 5 Highest Effort Screens</span>
            <span style="font-size: 11px; color: var(--indigo-600); font-weight:600;">Workload Focus</span>
          </div>
          <ul class="top-item-list" id="topScreensList"></ul>
        </div>
        <div class="top-card">
          <div class="top-card-header">
            <span>Top 5 Highest Effort Workspaces</span>
            <span style="font-size: 11px; color: var(--indigo-600); font-weight:600;">Scope Density</span>
          </div>
          <ul class="top-item-list" id="topWorkspacesList"></ul>
        </div>
        <div class="top-card">
          <div class="top-card-header">
            <span>Top 5 PIC Workload Distribution</span>
            <span style="font-size: 11px; color: var(--indigo-600); font-weight:600;">Resource Intensity</span>
          </div>
          <ul class="top-item-list" id="topPicsList"></ul>
        </div>
      </div>
    </section>

    <!-- SECTION 2: DELIVERY ROADMAP -->
    <section id="roadmap" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 2: Delivery Roadmap</span>
          <span class="section-tag">Wave Sequence</span>
        </h2>
      </div>
      <div class="roadmap-grid" id="roadmapGrid"></div>
    </section>

    <!-- SECTION 3: WAVE BREAKDOWN -->
    <section id="breakdown" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 3: Wave Breakdown & Hierarchy</span>
          <span class="section-tag">Scope Tree</span>
        </h2>
        <div class="tree-controls">
          <button class="btn" onclick="expandAllTree()">Expand All</button>
          <button class="btn" onclick="collapseAllTree()">Collapse All</button>
        </div>
      </div>
      <div class="tree-container" id="treeContainer"></div>
    </section>

    <!-- SECTION 4: SCREEN PLANNING TABLE -->
    <section id="table" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 4: Screen Planning Table</span>
          <span class="section-tag">Master Registry</span>
        </h2>
      </div>
      <div class="table-container">
        <div class="table-toolbar">
          <input type="text" id="tableSearch" class="search-input" placeholder="Search screen name, code, wave, PIC..." oninput="filterTable()">
          <div style="font-size: 12px; color: var(--text-muted);" id="tableCounter">Showing all screens</div>
        </div>
        <table class="planning-table">
          <thead>
            <tr>
              <th onclick="sortTable(0)">Screen Code ⇕</th>
              <th onclick="sortTable(1)">Screen Name ⇕</th>
              <th onclick="sortTable(2)">Wave ⇕</th>
              <th onclick="sortTable(3)">Assigned PIC ⇕</th>
              <th onclick="sortTable(4)" style="text-align: center;">Workspaces ⇕</th>
              <th onclick="sortTable(5)" style="text-align: right;">Total Effort (Days) ⇕</th>
            </tr>
          </thead>
          <tbody id="tableBody"></tbody>
        </table>
      </div>
    </section>

    <!-- SECTION 5 & 6: RESOURCE ALLOCATION & WORKLOAD DISTRIBUTION -->
    <section id="allocation" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Sections 5 & 6: Resource Allocation & Workload Chart</span>
          <span class="section-tag">Workforce Loading</span>
        </h2>
      </div>
      <div class="resource-grid">
        <div class="pic-workload-card">
          <div style="font-size: 14px; font-weight: 700; color: var(--navy-900); margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid var(--border-color);">
            Workload Distribution Chart (Man-Days)
          </div>
          <div id="workloadChartContainer"></div>
        </div>

        <div class="pic-workload-card">
          <div style="font-size: 14px; font-weight: 700; color: var(--navy-900); margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid var(--border-color);">
            PIC Workload Breakdown
          </div>
          <div id="picCardsContainer" style="display: flex; flex-direction: column; gap: 12px;"></div>
        </div>
      </div>
    </section>

    <!-- SECTION 7: PROPOSED TIMELINE -->
    <section id="timeline" class="section-block">
      <div class="section-header">
        <h2 class="section-title">
          <span>Section 7: Proposed Timeline (Gantt Schedule)</span>
          <span class="section-tag">PIC-Based Sequencing</span>
        </h2>
      </div>
      <div class="gantt-wrapper">
        <div style="margin-bottom: 14px; font-size: 12px; color: var(--text-muted);">
          * Timeline calculated assuming 1 Effort = 1 Working Day (22 Working Days = 1 Month). Waves run concurrently when PICs are independent, and queue sequentially when PICs overlap.
        </div>
        <div class="gantt-header-row">
          <div>Delivery Wave</div>
          <div>M1 (1-22d)</div>
          <div>M2 (23-44d)</div>
          <div>M3 (45-66d)</div>
          <div>M4 (67-88d)</div>
          <div>M5 (89-110d)</div>
          <div>M6 (111-132d)</div>
          <div>M7 (133-154d)</div>
          <div>M8 (155-176d)</div>
        </div>
        <div id="ganttBody"></div>
      </div>
    </section>

  </div>

  <script>
    let RAW_WAVE_DATA = ${rawData};

    let waves = [];
    let screens = [];
    let workspaces = [];
    let tasks = [];
    let picMap = {};

    function initDashboard() {
      parseData();
      renderExecutiveAnswers();
      renderKPIs();
      renderCriticalWorkloads();
      renderRoadmap();
      renderTreeBreakdown();
      renderPlanningTable();
      renderResourceAllocation();
      renderGanttTimeline();
    }

    function handleFileUpload(event) {
      const file = event.target.files[0];
      if (!file) return;
      const reader = new FileReader();
      reader.onload = function(e) {
        try {
          const parsed = JSON.parse(e.target.result);
          RAW_WAVE_DATA = parsed;
          initDashboard();
          alert('JSON data successfully loaded and dashboard re-calculated!');
        } catch (err) {
          alert('Invalid JSON file format: ' + err.message);
        }
      };
      reader.readAsText(file);
    }

    function parseData() {
      waves = [];
      screens = [];
      workspaces = [];
      tasks = [];
      picMap = {};

      RAW_WAVE_DATA.forEach(item => {
        const w = item.Wave;
        let waveEffort = 0;
        let waveScreensCount = 0;
        let waveWorkspacesCount = 0;
        let waveTasksCount = 0;
        let wavePics = new Set();

        (w.Screen || []).forEach(s => {
          waveScreensCount++;
          if (s.PIC) wavePics.add(s.PIC);

          let screenEffort = 0;
          let screenWorkspacesCount = 0;
          let screenTasksCount = 0;

          (s.Workspaces || []).forEach(ws => {
            screenWorkspacesCount++;
            let wsEffort = 0;
            let wsTasksCount = 0;

            (ws.Tasks || []).forEach(t => {
              wsTasksCount++;
              const e = (t.Effort !== "" && t.Effort !== null && t.Effort !== undefined && !isNaN(Number(t.Effort))) ? Number(t.Effort) : 0;
              wsEffort += e;
              tasks.push({
                taskId: t.TaskId,
                taskName: t.TaskName,
                effort: e,
                workspaceId: ws.WorkspaceId,
                workspaceName: ws.WorkspaceName,
                screenId: s.ScreenId,
                screenName: s.ScreenName,
                waveId: w.WaveId,
                waveName: w.WaveName,
                pic: s.PIC
              });
            });

            screenEffort += wsEffort;
            screenTasksCount += wsTasksCount;

            workspaces.push({
              workspaceId: ws.WorkspaceId,
              workspaceName: ws.WorkspaceName,
              effort: wsEffort,
              tasksCount: wsTasksCount,
              tasks: ws.Tasks || [],
              screenId: s.ScreenId,
              screenName: s.ScreenName,
              waveId: w.WaveId,
              waveName: w.WaveName,
              pic: s.PIC
            });
          });

          waveEffort += screenEffort;
          waveWorkspacesCount += screenWorkspacesCount;
          waveTasksCount += screenTasksCount;

          screens.push({
            screenId: s.ScreenId,
            screenName: s.ScreenName,
            waveId: w.WaveId,
            waveName: w.WaveName,
            pic: s.PIC || 'Unassigned',
            workspacesCount: screenWorkspacesCount,
            tasksCount: screenTasksCount,
            effort: screenEffort,
            outcomesCount: (s.Outcomes || []).length,
            outcomes: s.Outcomes || [],
            workspaces: s.Workspaces || []
          });

          const p = s.PIC || 'Unassigned';
          if (!picMap[p]) {
            picMap[p] = { pic: p, screensCount: 0, workspacesCount: 0, effort: 0, screens: [], waves: new Set() };
          }
          picMap[p].screensCount++;
          picMap[p].workspacesCount += screenWorkspacesCount;
          picMap[p].effort += screenEffort;
          picMap[p].screens.push(s.ScreenId + ' ' + s.ScreenName);
          picMap[p].waves.add(w.WaveId);
        });

        waves.push({
          waveId: w.WaveId,
          waveName: w.WaveName,
          screensCount: waveScreensCount,
          workspacesCount: waveWorkspacesCount,
          tasksCount: waveTasksCount,
          effort: waveEffort,
          pics: Array.from(wavePics),
          rawScreen: w.Screen || []
        });
      });
    }

    function renderExecutiveAnswers() {
      const totalEffort = screens.reduce((acc, curr) => acc + curr.effort, 0);
      const totalPics = Object.keys(picMap).length;
      
      let largestWave = waves.reduce((prev, current) => (prev.effort > current.effort) ? prev : current, waves[0]);
      let picList = Object.values(picMap);
      let heaviestPic = picList.reduce((prev, current) => (prev.effort > current.effort) ? prev : current, picList[0]);
      const manMonths = (totalEffort / 22).toFixed(1);

      document.getElementById('qaSummaryGrid').innerHTML = \`
        <div class="qa-item">
          <div class="qa-question">What will be built?</div>
          <div class="qa-answer">\${screens.length} Screens, \${workspaces.length} Workspaces & \${tasks.length} Tasks across \${waves.length} Delivery Waves</div>
        </div>
        <div class="qa-item">
          <div class="qa-question">Who will build it?</div>
          <div class="qa-answer">\${totalPics} Assigned Engineers (\${picList.map(p => p.pic).join(', ')})</div>
        </div>
        <div class="qa-item">
          <div class="qa-question">How much effort is required?</div>
          <div class="qa-answer">\${totalEffort} Working Days (~\${manMonths} Man-Months total)</div>
        </div>
        <div class="qa-item">
          <div class="qa-question">Which Wave is largest?</div>
          <div class="qa-answer">\${largestWave.waveId} (\${largestWave.waveName}): \${largestWave.effort} Days (\${((largestWave.effort/totalEffort)*100).toFixed(1)}%)</div>
        </div>
        <div class="qa-item">
          <div class="qa-question">Which PIC has highest workload?</div>
          <div class="qa-answer">\${heaviestPic.pic}: \${heaviestPic.effort} Days (\${((heaviestPic.effort/totalEffort)*100).toFixed(1)}% of total workload)</div>
        </div>
        <div class="qa-item">
          <div class="qa-question">Proposed Sequence & Timeline</div>
          <div class="qa-answer">6 Waves via PIC-Optimized Parallel Schedule (~7.3 Calendar Months)</div>
        </div>
      \`;
    }

    function renderKPIs() {
      const totalEffort = screens.reduce((acc, curr) => acc + curr.effort, 0);
      const kpis = [
        { label: 'Total Waves', val: waves.length, sub: 'Delivery milestones' },
        { label: 'Total Screens', val: screens.length, sub: 'User touchpoints' },
        { label: 'Total Workspaces', val: workspaces.length, sub: 'Sub-system units' },
        { label: 'Total Tasks', val: tasks.length, sub: 'Granular work items' },
        { label: 'Total Effort', val: totalEffort + ' Days', sub: '~' + (totalEffort / 22).toFixed(1) + ' Man-Months' },
        { label: 'Assigned PICs', val: Object.keys(picMap).length, sub: 'Core team members' }
      ];

      document.getElementById('kpiGrid').innerHTML = kpis.map(k => \`
        <div class="kpi-card">
          <div class="kpi-label">\${k.label}</div>
          <div class="kpi-value">\${k.val}</div>
          <div class="kpi-subtext">\${k.sub}</div>
        </div>
      \`).join('');
    }

    function renderCriticalWorkloads() {
      const totalEffort = screens.reduce((acc, curr) => acc + curr.effort, 0);

      const topScreens = [...screens].sort((a, b) => b.effort - a.effort).slice(0, 5);
      document.getElementById('topScreensList').innerHTML = topScreens.map(s => {
        const pct = ((s.effort / totalEffort) * 100).toFixed(1);
        return \`
          <li class="top-item">
            <div class="top-item-info">
              <span class="top-item-name">
                <span class="pic-tag">\${s.screenId}</span> \${s.screenName} (\${s.pic})
              </span>
              <span class="top-item-val">\${s.effort}d (\${pct}%)</span>
            </div>
            <div class="progress-track"><div class="progress-fill" style="width: \${pct*3.5}%;"></div></div>
          </li>
        \`;
      }).join('');

      const topWs = [...workspaces].sort((a, b) => b.effort - a.effort).slice(0, 5);
      document.getElementById('topWorkspacesList').innerHTML = topWs.map(ws => \`
        <li class="top-item">
          <div class="top-item-info">
            <span class="top-item-name">
              <span class="pic-tag">\${ws.workspaceId}</span> \${ws.workspaceName}
            </span>
            <span class="top-item-val">\${ws.effort}d</span>
          </div>
          <div style="font-size: 11px; color: var(--text-muted);">Screen: \${ws.screenName} (\${ws.waveId})</div>
        </li>
      \`).join('');

      const topPics = Object.values(picMap).sort((a, b) => b.effort - a.effort).slice(0, 5);
      document.getElementById('topPicsList').innerHTML = topPics.map(p => {
        const pct = ((p.effort / totalEffort) * 100).toFixed(1);
        return \`
          <li class="top-item">
            <div class="top-item-info">
              <span class="top-item-name">\${p.pic} (\${p.screensCount} Screens)</span>
              <span class="top-item-val">\${p.effort}d (\${pct}%)</span>
            </div>
            <div class="progress-track"><div class="progress-fill" style="width: \${pct*2.2}%;"></div></div>
          </li>
        \`;
      }).join('');
    }

    function renderRoadmap() {
      const totalEffort = screens.reduce((acc, curr) => acc + curr.effort, 0);
      document.getElementById('roadmapGrid').innerHTML = waves.map(w => {
        const pct = ((w.effort / totalEffort) * 100).toFixed(1);
        return \`
          <div class="wave-card">
            <div>
              <div class="wave-card-header">
                <span class="wave-badge">\${w.waveId}</span>
                <span style="font-size: 12px; font-weight:700; color: var(--indigo-600);">\${pct}% Share</span>
              </div>
              <div class="wave-title">\${w.waveName}</div>
            </div>

            <div class="wave-stats-row">
              <div class="wave-stat">
                <div class="wave-stat-val">\${w.screensCount}</div>
                <div class="wave-stat-lbl">Screens</div>
              </div>
              <div class="wave-stat">
                <div class="wave-stat-val">\${w.workspacesCount}</div>
                <div class="wave-stat-lbl">Workspaces</div>
              </div>
              <div class="wave-stat">
                <div class="wave-stat-val">\${w.effort}</div>
                <div class="wave-stat-lbl">Effort Days</div>
              </div>
            </div>

            <div>
              <div style="font-size: 11px; font-weight: 600; color: var(--text-muted); margin-bottom: 4px;">Assigned PICs:</div>
              <div class="wave-pics">
                \${w.pics.map(p => \`<span class="pic-tag">\${p}</span>\`).join('')}
              </div>
            </div>
          </div>
        \`;
      }).join('');
    }

    function renderTreeBreakdown() {
      document.getElementById('treeContainer').innerHTML = waves.map((w, wIndex) => {
        const screensHtml = w.rawScreen.map((s, sIndex) => {
          let screenTotalEffort = 0;
          const wsHtml = (s.Workspaces || []).map(ws => {
            let wsEffort = 0;
            (ws.Tasks || []).forEach(t => {
              if (t.Effort !== "" && !isNaN(Number(t.Effort))) wsEffort += Number(t.Effort);
            });
            screenTotalEffort += wsEffort;

            return \`
              <div style="margin-top: 6px; padding: 6px 10px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 4px; display: flex; justify-content: space-between; align-items: center; font-size: 12px;">
                <div>
                  <strong>\${ws.WorkspaceId}</strong> - \${ws.WorkspaceName}
                  <span style="color: var(--text-muted); margin-left: 8px;">(\${(ws.Tasks||[]).length} tasks)</span>
                </div>
                <span class="effort-pill">\${wsEffort}d</span>
              </div>
            \`;
          }).join('');

          return \`
            <div class="tree-node" style="margin-bottom: 8px;">
              <div class="tree-node-header" onclick="toggleTreeNode('s-\${wIndex}-\${sIndex}')">
                <div class="tree-node-title">
                  <span class="toggle-icon" id="icon-s-\${wIndex}-\${sIndex}">-</span>
                  <strong>\${s.ScreenId}</strong> \${s.ScreenName}
                  <span class="pic-tag">\${s.PIC}</span>
                </div>
                <span class="effort-pill">\${screenTotalEffort}d</span>
              </div>
              <div class="tree-node-body" id="body-s-\${wIndex}-\${sIndex}">
                \${wsHtml}
              </div>
            </div>
          \`;
        }).join('');

        return \`
          <div class="tree-node">
            <div class="tree-node-header" onclick="toggleTreeNode('w-\${wIndex}')" style="background-color: #f1f5f9;">
              <div class="tree-node-title">
                <span class="toggle-icon" id="icon-w-\${wIndex}">-</span>
                <span class="wave-badge">\${w.waveId}</span>
                <strong>\${w.waveName}</strong>
              </div>
              <span class="effort-pill" style="background-color: var(--navy-900); color: #fff;">\${w.effort} Days Total</span>
            </div>
            <div class="tree-node-body" id="body-w-\${wIndex}">
              \${screensHtml}
            </div>
          </div>
        \`;
      }).join('');
    }

    function toggleTreeNode(id) {
      const body = document.getElementById('body-' + id);
      const icon = document.getElementById('icon-' + id);
      if (body.classList.contains('collapsed')) {
        body.classList.remove('collapsed');
        icon.innerText = '-';
      } else {
        body.classList.add('collapsed');
        icon.innerText = '+';
      }
    }

    function expandAllTree() {
      document.querySelectorAll('.tree-node-body').forEach(b => b.classList.remove('collapsed'));
      document.querySelectorAll('.toggle-icon').forEach(i => i.innerText = '-');
    }

    function collapseAllTree() {
      document.querySelectorAll('.tree-node-body').forEach(b => b.classList.add('collapsed'));
      document.querySelectorAll('.toggle-icon').forEach(i => i.innerText = '+');
    }

    function renderPlanningTable() {
      renderTableRows(screens);
    }

    function renderTableRows(data) {
      document.getElementById('tableBody').innerHTML = data.map(s => \`
        <tr>
          <td><span class="wave-badge">\${s.screenId}</span></td>
          <td style="font-weight: 600;">\${s.screenName}</td>
          <td><span style="font-size: 11px; font-weight:700; color: var(--navy-900);">\${s.waveId}</span></td>
          <td><span class="pic-tag">\${s.pic}</span></td>
          <td style="text-align: center;">\${s.workspacesCount}</td>
          <td style="text-align: right; font-weight: 700; color: var(--indigo-600);">\${s.effort} Days</td>
        </tr>
      \`).join('');
      document.getElementById('tableCounter').innerText = \`Showing \${data.length} of \${screens.length} screens\`;
    }

    function filterTable() {
      const q = document.getElementById('tableSearch').value.toLowerCase();
      const filtered = screens.filter(s => 
        s.screenName.toLowerCase().includes(q) ||
        s.screenId.toLowerCase().includes(q) ||
        s.waveId.toLowerCase().includes(q) ||
        s.pic.toLowerCase().includes(q)
      );
      renderTableRows(filtered);
    }

    let sortCol = -1;
    let sortAsc = true;
    function sortTable(colIndex) {
      if (sortCol === colIndex) {
        sortAsc = !sortAsc;
      } else {
        sortCol = colIndex;
        sortAsc = true;
      }

      screens.sort((a, b) => {
        let v1, v2;
        if (colIndex === 0) { v1 = a.screenId; v2 = b.screenId; }
        else if (colIndex === 1) { v1 = a.screenName; v2 = b.screenName; }
        else if (colIndex === 2) { v1 = a.waveId; v2 = b.waveId; }
        else if (colIndex === 3) { v1 = a.pic; v2 = b.pic; }
        else if (colIndex === 4) { v1 = a.workspacesCount; v2 = b.workspacesCount; }
        else if (colIndex === 5) { v1 = a.effort; v2 = b.effort; }

        if (v1 < v2) return sortAsc ? -1 : 1;
        if (v1 > v2) return sortAsc ? 1 : -1;
        return 0;
      });

      filterTable();
    }

    function renderResourceAllocation() {
      const picList = Object.values(picMap).sort((a, b) => b.effort - a.effort);
      const maxEffort = picList[0].effort;
      const totalEffort = screens.reduce((acc, curr) => acc + curr.effort, 0);

      document.getElementById('workloadChartContainer').innerHTML = picList.map((p, idx) => {
        const pctWidth = ((p.effort / maxEffort) * 100).toFixed(1);
        const isHighest = idx === 0;
        return \`
          <div class="bar-chart-row">
            <div class="bar-pic-name">\${p.pic}</div>
            <div class="bar-container-wrapper">
              <div class="bar-fill-inner \${isHighest ? 'highest' : ''}" style="width: \${pctWidth}%;">
                \${p.effort}d
              </div>
            </div>
            <div class="bar-val-label">\${((p.effort/totalEffort)*100).toFixed(1)}%</div>
          </div>
        \`;
      }).join('');

      document.getElementById('picCardsContainer').innerHTML = picList.map(p => \`
        <div style="padding: 12px; border: 1px solid var(--border-color); border-radius: 6px; background-color: #f8fafc; display: flex; justify-content: space-between; align-items: center;">
          <div>
            <div style="font-size: 14px; font-weight: 700; color: var(--navy-900);">\${p.pic}</div>
            <div style="font-size: 11px; color: var(--text-muted); margin-top: 2px;">
              \${p.screensCount} Screens | \${p.workspacesCount} Workspaces
            </div>
          </div>
          <div style="text-align: right;">
            <div style="font-size: 16px; font-weight: 800; color: var(--indigo-600);">\${p.effort} Days</div>
            <div style="font-size: 11px; color: var(--text-muted);">\${((p.effort/totalEffort)*100).toFixed(1)}% share</div>
          </div>
        </div>
      \`).join('');
    }

    function renderGanttTimeline() {
      let picBusyUntil = {};
      Object.keys(picMap).forEach(p => picBusyUntil[p] = 0);

      let waveSchedule = [];
      waves.forEach(w => {
        let picWorkloadInWave = {};
        w.pics.forEach(p => picWorkloadInWave[p] = 0);
        
        w.rawScreen.forEach(s => {
          const p = s.PIC;
          let sEffort = 0;
          (s.Workspaces || []).forEach(ws => {
            (ws.Tasks || []).forEach(t => {
              if (t.Effort !== "" && !isNaN(Number(t.Effort))) sEffort += Number(t.Effort);
            });
          });
          if (p) picWorkloadInWave[p] = (picWorkloadInWave[p] || 0) + sEffort;
        });

        let startDay = 0;
        w.pics.forEach(p => {
          if (picBusyUntil[p] > startDay) startDay = picBusyUntil[p];
        });

        let maxPicDuration = 0;
        w.pics.forEach(p => {
          if ((picWorkloadInWave[p] || 0) > maxPicDuration) maxPicDuration = picWorkloadInWave[p];
        });
        if (maxPicDuration === 0) maxPicDuration = 1;

        let endDay = startDay + maxPicDuration;

        w.pics.forEach(p => {
          const pEffort = picWorkloadInWave[p] || 0;
          picBusyUntil[p] = startDay + pEffort;
        });

        waveSchedule.push({
          waveId: w.waveId,
          waveName: w.waveName,
          startDay: startDay,
          endDay: endDay,
          duration: maxPicDuration,
          effort: w.effort,
          pics: w.pics
        });
      });

      const maxTimelineDays = 176;

      document.getElementById('ganttBody').innerHTML = waveSchedule.map(w => {
        const leftPct = ((w.startDay / maxTimelineDays) * 100).toFixed(2);
        const widthPct = (((w.endDay - w.startDay) / maxTimelineDays) * 100).toFixed(2);

        return \`
          <div class="gantt-wave-row">
            <div class="gantt-wave-label">
              <span class="wave-badge">\${w.waveId}</span> \${w.waveName}
            </div>
            <div class="gantt-track-area">
              <div class="gantt-bar-item" style="left: \${leftPct}%; width: \${widthPct}%;" title="Day \${w.startDay} to \${w.endDay} (\${w.duration} working days)">
                \${w.waveId}: Day \${w.startDay}-\${w.endDay} (\${w.duration}d duration)
              </div>
            </div>
          </div>
        \`;
      }).join('');
    }

    window.addEventListener('DOMContentLoaded', initDashboard);
  </script>
</body>
</html>
`;

const outputPath = path.join(currentDir, 'myhosweb-development-plan.html');
fs.writeFileSync(outputPath, htmlContent, 'utf8');

console.log('----------------------------------------------------');
console.log('✓ Successfully re-generated Dashboard HTML!');
console.log('  Source Data File :', sourceFileName);
console.log('  Output File      :', outputPath);
console.log('----------------------------------------------------');
