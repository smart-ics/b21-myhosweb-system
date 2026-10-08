#!/usr/bin/env python3
"""
Import script for workspace-task.json into Cakra Work Package and Request database tables.

Mappings:
- Workspace -> workpackage.WorkPackages
- Task -> request.Requests
- Link -> workpackage.WorkPackageRequests
"""

import json
import os
import sys
import uuid
import argparse

# Deterministic namespace for generating repeatable UUIDs from workspace and task IDs
NAMESPACE_CAKRA = uuid.UUID('6ba7b810-9dad-11d1-80b4-00c04fd430c8')

def get_deterministic_guid(key: str) -> str:
    """Generate a consistent GUID based on input key string."""
    return str(uuid.uuid5(NAMESPACE_CAKRA, key)).upper()

def sanitize_sql_string(val: str) -> str:
    if val is None:
        return "NULL"
    return "'" + str(val).replace("'", "''") + "'"

def parse_int_safe(val, default=0) -> int:
    if val is None or val == "":
        return default
    try:
        return int(val)
    except (ValueError, TypeError):
        return default

def generate_sql(data_list, output_sql_path: str):
    """Generate idempotent T-SQL script for importing workspaces and tasks."""
    
    lines = []
    lines.append("-- =============================================================================")
    lines.append("-- CAKRA Database Import: Workspace -> WorkPackage, Task -> Request")
    lines.append("-- Generated from workspace-task.json")
    lines.append("-- =============================================================================")
    lines.append("SET ANSI_NULLS ON;")
    lines.append("SET QUOTED_IDENTIFIER ON;")
    lines.append("SET NOCOUNT ON;")
    lines.append("")
    lines.append("BEGIN TRANSACTION;")
    lines.append("")
    lines.append("-- 1. Resolve Product (MyHospital Web 'MHW')")
    lines.append("DECLARE @ProductId UNIQUEIDENTIFIER;")
    lines.append("SELECT TOP 1 @ProductId = Id FROM product.Products WHERE Code = 'MHW';")
    lines.append("IF @ProductId IS NULL")
    lines.append("    SELECT TOP 1 @ProductId = Id FROM product.Products ORDER BY CreatedAt ASC;")
    lines.append("")
    lines.append("-- 2. Resolve Default Admin Person")
    lines.append("DECLARE @AdminPersonId UNIQUEIDENTIFIER;")
    lines.append("SELECT TOP 1 @AdminPersonId = Id FROM organization.Persons WHERE Email = 'admin@cakra.id';")
    lines.append("IF @AdminPersonId IS NULL")
    lines.append("    SELECT TOP 1 @AdminPersonId = Id FROM organization.Persons ORDER BY CreatedAt ASC;")
    lines.append("")
    lines.append("IF @AdminPersonId IS NULL")
    lines.append("BEGIN")
    lines.append("    RAISERROR('No organization persons found in organization.Persons. Please run seed-persons.sql first.', 16, 1);")
    lines.append("    ROLLBACK TRANSACTION;")
    lines.append("    RETURN;")
    lines.append("END")
    lines.append("")
    lines.append("-- 3. Helper Table for PIC Resolution (Strict 1:1 Primary Key)")
    lines.append("DECLARE @PicMapping TABLE (PicName NVARCHAR(50) PRIMARY KEY, PersonId UNIQUEIDENTIFIER);")
    lines.append("INSERT INTO @PicMapping (PicName, PersonId)")
    lines.append("SELECT 'Arif', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'arif.hidayat@cakra.id' OR (FirstName = 'Arif' AND LastName = 'Hidayat'))")
    lines.append("UNION ALL SELECT 'Fikri', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'fikri.haikal@cakra.id' OR FirstName = 'Fikri')")
    lines.append("UNION ALL SELECT 'Erkoc', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'erkoc@email.com' OR Email = 'ernawan.sukoco@cakra.id' OR FirstName = 'Ernawan')")
    lines.append("UNION ALL SELECT 'Rizal', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'rizal.aditya.pratama@cakra.id' OR FirstName LIKE 'Rizal%')")
    lines.append("UNION ALL SELECT 'Sulis', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'sulistiyarno@cakra.id' OR LastName = 'Sulistiyarno')")
    lines.append("UNION ALL SELECT 'We', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'wahyu.widanarto@cakra.id' OR (FirstName = 'Wahyu' AND LastName = 'Widanarto'))")
    lines.append("UNION ALL SELECT 'Arie', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'arie.haryanto@cakra.id' OR FirstName = 'Arie')")
    lines.append("UNION ALL SELECT 'Roso', (SELECT TOP 1 Id FROM organization.Persons WHERE Email = 'roso.wahono@cakra.id' OR FirstName = 'Roso')")
    lines.append("UNION ALL SELECT 'Jude', @AdminPersonId")
    lines.append("UNION ALL SELECT 'All PICs', @AdminPersonId;")
    lines.append("")
    lines.append("DECLARE @ImportTime DATETIME2 = SYSUTCDATETIME();")
    lines.append("DECLARE @WorkPackagesCount INT = 0;")
    lines.append("DECLARE @RequestsCount INT = 0;")
    lines.append("DECLARE @LinksCount INT = 0;")
    lines.append("")

    # Stage 1: Temporary tables for bulk processing
    lines.append("-- Temporary table for staged WorkPackages")
    lines.append("DECLARE @StagedWorkPackages TABLE (")
    lines.append("    Id UNIQUEIDENTIFIER PRIMARY KEY,")
    lines.append("    Name NVARCHAR(255) NOT NULL,")
    lines.append("    Objective NVARCHAR(MAX) NOT NULL,")
    lines.append("    Pic NVARCHAR(50) NOT NULL,")
    lines.append("    WaveId NVARCHAR(50),")
    lines.append("    ScreenCode NVARCHAR(50),")
    lines.append("    TotalEffort INT")
    lines.append(");")
    lines.append("")
    lines.append("-- Temporary table for staged Requests")
    lines.append("DECLARE @StagedRequests TABLE (")
    lines.append("    Id UNIQUEIDENTIFIER PRIMARY KEY,")
    lines.append("    WorkPackageId UNIQUEIDENTIFIER NOT NULL,")
    lines.append("    TaskId NVARCHAR(50) NOT NULL,")
    lines.append("    Title NVARCHAR(255) NOT NULL,")
    lines.append("    Description NVARCHAR(MAX) NOT NULL,")
    lines.append("    Effort INT,")
    lines.append("    Pic NVARCHAR(50) NOT NULL")
    lines.append(");")
    lines.append("")

    # Populate staged data
    lines.append("-- Populating Staged WorkPackages and Requests...")
    
    wp_insert_statements = []
    req_insert_statements = []

    for wave in data_list:
        wave_id = wave.get("waveId", "")
        wave_name = wave.get("waveName", "")
        for ws in wave.get("workspaces", []):
            ws_id = ws.get("workspaceId", "")
            ws_name = ws.get("workspaceName", "")
            screen_id = ws.get("screenId", "")
            screen_code = ws.get("screenCode", "")
            screen_name = ws.get("screenName", "")
            pic = ws.get("pic", "All PICs")
            total_effort = parse_int_safe(ws.get("totalEffort", 0))

            # Unique deterministic key for workspace: wave + screen + workspaceId
            wp_key = f"{wave_id}:{screen_code}:{ws_id}"
            wp_guid = get_deterministic_guid(wp_key)
            
            wp_display_name = f"[{ws_id}] {ws_name}"
            if screen_code and screen_code not in ws_id:
                wp_display_name += f" ({screen_name})"
                
            wp_objective = f"Wave: {wave_id} - {wave_name} | Screen: {screen_code} - {screen_name} | PIC: {pic} | Total Effort: {total_effort} day(s)"

            wp_insert_statements.append(
                f"INSERT INTO @StagedWorkPackages (Id, Name, Objective, Pic, WaveId, ScreenCode, TotalEffort) VALUES ("
                f"'{wp_guid}', {sanitize_sql_string(wp_display_name)}, {sanitize_sql_string(wp_objective)}, {sanitize_sql_string(pic)}, {sanitize_sql_string(wave_id)}, {sanitize_sql_string(screen_code)}, {total_effort});"
            )

            for task in ws.get("tasks", []):
                t_id = task.get("taskId", "")
                t_name = task.get("taskName", "")
                effort = parse_int_safe(task.get("effort", 0))

                # Unique deterministic key for task: wave + screen + workspaceId + taskId
                task_key = f"{wave_id}:{screen_code}:{ws_id}:{t_id}"
                task_guid = get_deterministic_guid(task_key)

                req_title = f"[{t_id}] {t_name}"
                effort_text = f"{effort} day(s)" if effort > 0 else "N/A"
                req_desc = (
                    f"Task: {t_name}\n"
                    f"Task ID: {t_id}\n"
                    f"Estimated Effort: {effort_text}\n"
                    f"Workspace: [{ws_id}] {ws_name}\n"
                    f"Screen: [{screen_code}] {screen_name}\n"
                    f"Wave: [{wave_id}] {wave_name}\n"
                    f"PIC: {pic}"
                )

                req_insert_statements.append(
                    f"INSERT INTO @StagedRequests (Id, WorkPackageId, TaskId, Title, Description, Effort, Pic) VALUES ("
                    f"'{task_guid}', '{wp_guid}', {sanitize_sql_string(t_id)}, {sanitize_sql_string(req_title)}, {sanitize_sql_string(req_desc)}, {effort}, {sanitize_sql_string(pic)});"
                )

    lines.extend(wp_insert_statements)
    lines.append("")
    lines.extend(req_insert_statements)
    lines.append("")

    # Upsert into workpackage.WorkPackages
    lines.append("-- 4. Upsert Work Packages into workpackage.WorkPackages")
    lines.append("MERGE INTO [workpackage].[WorkPackages] AS TARGET")
    lines.append("USING (")
    lines.append("    SELECT ")
    lines.append("        s.Id,")
    lines.append("        s.Name,")
    lines.append("        s.Objective,")
    lines.append("        'ACTIVE' AS [Status],")
    lines.append("        ISNULL(m.PersonId, @AdminPersonId) AS OwnerPersonId,")
    lines.append("        @ProductId AS ProductId,")
    lines.append("        @ImportTime AS CreatedAt")
    lines.append("    FROM @StagedWorkPackages s")
    lines.append("    LEFT JOIN @PicMapping m ON s.Pic = m.PicName")
    lines.append(") AS SOURCE (Id, Name, Objective, [Status], OwnerPersonId, ProductId, CreatedAt)")
    lines.append("ON (TARGET.Id = SOURCE.Id)")
    lines.append("WHEN MATCHED THEN")
    lines.append("    UPDATE SET ")
    lines.append("        TARGET.Name = SOURCE.Name,")
    lines.append("        TARGET.Objective = SOURCE.Objective,")
    lines.append("        TARGET.OwnerPersonId = SOURCE.OwnerPersonId,")
    lines.append("        TARGET.ProductId = SOURCE.ProductId,")
    lines.append("        TARGET.UpdatedAt = @ImportTime")
    lines.append("WHEN NOT MATCHED THEN")
    lines.append("    INSERT (Id, Name, Objective, [Status], OwnerPersonId, ProductId, CreatedAt)")
    lines.append("    VALUES (SOURCE.Id, SOURCE.Name, SOURCE.Objective, SOURCE.Status, SOURCE.OwnerPersonId, SOURCE.ProductId, SOURCE.CreatedAt);")
    lines.append("")
    lines.append("SET @WorkPackagesCount = @@ROWCOUNT;")
    lines.append("")

    # Upsert into request.Requests
    lines.append("-- 5. Upsert Requests into request.Requests")
    lines.append("MERGE INTO [request].[Requests] AS TARGET")
    lines.append("USING (")
    lines.append("    SELECT ")
    lines.append("        r.Id,")
    lines.append("        r.Title,")
    lines.append("        r.Description,")
    lines.append("        'FEATURE' AS RequestType,")
    lines.append("        'ACCEPTED' AS [Status],")
    lines.append("        'NORMAL' AS Priority,")
    lines.append("        ISNULL(m.PersonId, @AdminPersonId) AS OwnerPersonId,")
    lines.append("        @ProductId AS ProductId,")
    lines.append("        r.WorkPackageId,")
    lines.append("        CONCAT('Estimated Effort: ', r.Effort, ' day(s)') AS EvaluationNotes,")
    lines.append("        @ImportTime AS CreatedAt")
    lines.append("    FROM @StagedRequests r")
    lines.append("    LEFT JOIN @PicMapping m ON r.Pic = m.PicName")
    lines.append(") AS SOURCE (Id, Title, Description, RequestType, [Status], Priority, OwnerPersonId, ProductId, WorkPackageId, EvaluationNotes, CreatedAt)")
    lines.append("ON (TARGET.Id = SOURCE.Id)")
    lines.append("WHEN MATCHED THEN")
    lines.append("    UPDATE SET ")
    lines.append("        TARGET.Title = SOURCE.Title,")
    lines.append("        TARGET.Description = SOURCE.Description,")
    lines.append("        TARGET.OwnerPersonId = SOURCE.OwnerPersonId,")
    lines.append("        TARGET.ProductId = SOURCE.ProductId,")
    lines.append("        TARGET.WorkPackageId = SOURCE.WorkPackageId,")
    lines.append("        TARGET.EvaluationNotes = SOURCE.EvaluationNotes,")
    lines.append("        TARGET.UpdatedAt = @ImportTime")
    lines.append("WHEN NOT MATCHED THEN")
    lines.append("    INSERT (Id, Title, Description, RequestType, [Status], Priority, OwnerPersonId, ProductId, WorkPackageId, EvaluationNotes, CreatedAt)")
    lines.append("    VALUES (SOURCE.Id, SOURCE.Title, SOURCE.Description, SOURCE.RequestType, SOURCE.Status, SOURCE.Priority, SOURCE.OwnerPersonId, SOURCE.ProductId, SOURCE.WorkPackageId, SOURCE.EvaluationNotes, SOURCE.CreatedAt);")
    lines.append("")
    lines.append("SET @RequestsCount = @@ROWCOUNT;")
    lines.append("")

    # Upsert into workpackage.WorkPackageRequests
    lines.append("-- 6. Upsert Links into workpackage.WorkPackageRequests")
    lines.append("MERGE INTO [workpackage].[WorkPackageRequests] AS TARGET")
    lines.append("USING (")
    lines.append("    SELECT ")
    lines.append("        r.WorkPackageId,")
    lines.append("        r.Id AS RequestId,")
    lines.append("        @ImportTime AS AddedAt,")
    lines.append("        @ImportTime AS CreatedAt")
    lines.append("    FROM @StagedRequests r")
    lines.append(") AS SOURCE (WorkPackageId, RequestId, AddedAt, CreatedAt)")
    lines.append("ON (TARGET.WorkPackageId = SOURCE.WorkPackageId AND TARGET.RequestId = SOURCE.RequestId)")
    lines.append("WHEN MATCHED AND TARGET.RemovedAt IS NOT NULL THEN")
    lines.append("    UPDATE SET TARGET.RemovedAt = NULL, TARGET.UpdatedAt = @ImportTime")
    lines.append("WHEN NOT MATCHED THEN")
    lines.append("    INSERT (Id, WorkPackageId, RequestId, AddedAt, CreatedAt)")
    lines.append("    VALUES (NEWID(), SOURCE.WorkPackageId, SOURCE.RequestId, SOURCE.AddedAt, SOURCE.CreatedAt);")
    lines.append("")
    lines.append("SET @LinksCount = @@ROWCOUNT;")
    lines.append("")
    lines.append("COMMIT TRANSACTION;")
    lines.append("")
    lines.append("PRINT '==================================================';")
    lines.append("PRINT 'Import Summary:';")
    lines.append("PRINT CONCAT('- Work Packages processed: ', @WorkPackagesCount);")
    lines.append("PRINT CONCAT('- Requests processed:      ', @RequestsCount);")
    lines.append("PRINT CONCAT('- Links processed:         ', @LinksCount);")
    lines.append("PRINT '==================================================';")

    sql_content = "\n".join(lines)
    with open(output_sql_path, "w", encoding="utf-8") as f:
        f.write(sql_content)
    
    print(f"Generated SQL script: {output_sql_path}")
    print(f"Total Work Packages: {len(wp_insert_statements)}, Total Requests: {len(req_insert_statements)}")

def main():
    parser = argparse.ArgumentParser(description="Import workspace-task.json to Cakra WorkPackage and Request tables.")
    parser.add_argument("--json", default="workspace-task.json", help="Path to workspace-task.json")
    parser.add_argument("--output-sql", default="import-workspace-task.sql", help="Path for output SQL script")
    parser.add_argument("--execute", action="store_true", help="Execute generated SQL via sqlcmd")
    parser.add_argument("--server", default="JUDE7", help="SQL Server host / instance")
    parser.add_argument("--database", default="CAKRA", help="Database name")
    parser.add_argument("--user", default="cakraLogin", help="SQL User")
    parser.add_argument("--password", default="cakra123!", help="SQL Password")

    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    json_path = os.path.join(script_dir, args.json) if not os.path.isabs(args.json) else args.json
    output_sql_path = os.path.join(script_dir, args.output_sql) if not os.path.isabs(args.output_sql) else args.output_sql

    if not os.path.exists(json_path):
        print(f"Error: JSON file not found: {json_path}", file=sys.stderr)
        sys.exit(1)

    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    generate_sql(data, output_sql_path)

    if args.execute:
        print(f"Executing {output_sql_path} on {args.server}/{args.database}...")
        cmd = f'sqlcmd -S "{args.server}" -d "{args.database}" -U "{args.user}" -P "{args.password}" -i "{output_sql_path}"'
        res = os.system(cmd)
        if res != 0:
            print(f"Execution failed with code {res}", file=sys.stderr)
            sys.exit(res)
        print("Execution completed successfully.")

if __name__ == "__main__":
    main()
