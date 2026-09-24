# MYHOSWEB Progress Tracker Generator

Converts the authoritative Markdown tracker into machine-readable and
management-friendly generated views:

```text
project-management/phase-0-planning/MYHOSWEB-PROGRESS-TRACKER.md   (SOURCE OF TRUTH)
        |
        |  tracker_parser.py   (Markdown -> milestone/screen/feature tree)
        v
        |  json_builder.py     (tree -> normalized JSON + derived metrics)
        v
project-management/phase-0-planning/generated/progress-tracker.json
        |
        |  dashboard_builder.py + dashboard_template.html (JSON embedded in page)
        v
project-management/phase-0-planning/generated/progress-dashboard.html
```

The Markdown file **never** changes and **never** receives derived values.
`generated/` output is disposable and must never be edited by hand.

## Usage

From the repository root (Python 3.9+, standard library only):

```powershell
python project-management/phase-0-planning/tools/progress-tracker/generate.py
```

Optional arguments:

```powershell
python project-management/phase-0-planning/tools/progress-tracker/generate.py --input <path-to-tracker.md> --outdir <output-dir>
```

The generator prints a cross-check of the parsed feature count against the
tracker's own *Program Summary* total row, so parser/format drift is detected
immediately. If the `jsonschema` package is installed, the output is also
validated against `progress-tracker.schema.json`.

## Synchronization rule

Whenever `MYHOSWEB-PROGRESS-TRACKER.md` changes, re-run the command above and
commit the regenerated files. No manual editing of `generated/` is ever
required — the generator is fully deterministic apart from the
`metadata.generatedAt` timestamp.

`metadata.trackerRevision` and `metadata.lastUpdated` are taken from git
history of the tracker file when available (falling back to `1` / file
modification time while the file is untracked).

## Components

| File | Role |
| ---- | ---- |
| `tracker_parser.py` | Markdown parser (state machine over headings and pipe tables) |
| `json_builder.py` | Normalized JSON document + all derived metrics |
| `dashboard_builder.py` | Embeds the JSON document into the HTML template |
| `dashboard_template.html` | Standalone dashboard: pure HTML/CSS/vanilla JS, no external dependencies, responsive, print-friendly |
| `progress-tracker.schema.json` | JSON Schema (draft-07) for `progress-tracker.json` |
| `generate.py` | CLI entry point wiring the pipeline together |

## JSON structure

Hierarchy: `Project -> Milestone -> Screen -> Feature`.

* `metadata` — project, version, trackerRevision, lastUpdated, source.
* `milestones[]` — id, name, status, businessDescription, screens.
  * `screens[]` — id, name, features.
    * `features[]` — `featureId`, `featureName`, `complexity` (int or null for
      TBD), `status`, `statusBucket`, `plannedStart`, `plannedDuration`,
      `analysis` / `testing` / `pilotDeployment` (objects with `rows` +
      `summary`), `rollout` (array of rows) + `rolloutSummary`.
* `metrics` — derived program / milestone / screen metrics. These are
  generated views only and are never written back into the Markdown.

`TBD` values are preserved as the literal string `"TBD"`; `-` becomes `null`.

## Status buckets

Feature Overall Status values map to four reporting buckets used by all
dashboard rollups:

| Bucket | Statuses |
| ------ | -------- |
| completed | `COMPLETED`, `ROLLED_OUT` |
| inProgress | `PLANNING`, `ANALYSIS`, `IMPLEMENTATION`, `REVIEW`, `TESTING`, `PILOT_DEPLOYMENT`, phase `IN_PROGRESS` |
| blocked | `BLOCKED` |
| notStarted | `NOT_STARTED` / unknown |

## Dashboard sections

Executive Summary (totals, status split, completion percentages), Milestone
Progress (stacked bars), Screen Progress, Feature Detail (search, status-group
and milestone filters, sortable columns), Testing Status, Pilot Deployment
Status, Rollout Status. Open `project-management/phase-0-planning/generated/progress-dashboard.html` directly in
any browser; there is no backend or framework.

## Parsing contract

Parsing relies on the conventions documented in tracker section *2. Structure
and Conventions* and *5. Maintenance Rules* (rule 5): heading formats
`## Milestone Mxx — Title`, `### SC-xx Name` + `**PIC:** Name` screen ownership line,
`#### FT-xx-yy Name`, the fixed
phase table headers, and the exact status values. Keeping those stable keeps
the generator stable.
