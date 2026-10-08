#Requires -Version 5.1
<#
.SYNOPSIS
    CAKRA - Import Workspaces and Tasks from workspace-task.json
.DESCRIPTION
    Imports workspace-task.json into CAKRA database tables:
    - Workspace -> workpackage.WorkPackages
    - Task -> request.Requests
    - Association -> workpackage.WorkPackageRequests
    
    The script generates/uses import-workspace-task.sql and executes it idempotently against the database.
.PARAMETER Server
    SQL Server hostname or instance name (default: JUDE7)
.PARAMETER Database
    Database name (default: CAKRA)
.PARAMETER SqlUser
    SQL Login user (default: cakraLogin)
.PARAMETER SqlPassword
    SQL Login password (default: cakra123!)
.PARAMETER JsonPath
    Path to workspace-task.json
#>
param(
    [string]$Server       = "JUDE7",
    [string]$Database     = "CAKRA",
    [string]$SqlUser      = "cakraLogin",
    [string]$SqlPassword  = "cakra123!",
    [string]$JsonPath     = "$PSScriptRoot\workspace-task.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot
$sqlScriptPath = Join-Path $scriptDir "import-workspace-task.sql"
$pyScriptPath = Join-Path $scriptDir "import_workspace_task.py"

# Step 1: Ensure SQL script is generated
if (-not (Test-Path $sqlScriptPath) -or (Test-Path $pyScriptPath)) {
    Write-Host "==> Generating SQL from $JsonPath..." -ForegroundColor Cyan
    & python "$pyScriptPath" --json "$JsonPath" --output-sql "$sqlScriptPath"
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to generate SQL script from $JsonPath"
    }
}

# Step 2: Execute SQL script via sqlcmd
Write-Host "==> Importing Work Packages and Requests into [$Database] on [$Server]..." -ForegroundColor Cyan
& sqlcmd -S $Server -d $Database -U $SqlUser -P $SqlPassword -i "$sqlScriptPath"
if ($LASTEXITCODE -ne 0) {
    throw "SQL execution failed with code $LASTEXITCODE"
}

Write-Host "==> Workspace and Task import complete!" -ForegroundColor Green
