#!/usr/bin/env python3
"""MYHOSWEB Progress Tracker generator.

Converts the authoritative Markdown tracker into:

    project-management/phase-0-planning/generated/progress-tracker.json
    project-management/phase-0-planning/generated/progress-dashboard.html

Usage (from the repository root):

    python project-management/phase-0-planning/tools/progress-tracker/generate.py
    python project-management/phase-0-planning/tools/progress-tracker/generate.py --input <tracker.md> --outdir <dir>

The Markdown file remains the single source of truth. Generated files are
derived views and must never be edited by hand.
"""

import argparse
import datetime as dt
import json
import pathlib
import re
import subprocess
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))

import tracker_parser  # noqa: E402
import json_builder  # noqa: E402
import dashboard_builder  # noqa: E402

BASE_DIR = pathlib.Path(__file__).resolve().parents[2]  # project-management/phase-0-planning


def _find_repo_root(start):
    for candidate in (start, *start.parents):
        if (candidate / ".git").exists():
            return candidate
    return start


REPO_ROOT = _find_repo_root(BASE_DIR)
DEFAULT_INPUT = BASE_DIR / "MYHOSWEB-PROGRESS-TRACKER.md"
DEFAULT_OUTDIR = BASE_DIR / "generated"
SCHEMA_PATH = pathlib.Path(__file__).with_name("progress-tracker.schema.json")

TOTAL_ROW_RE = re.compile(
    r"^\|\s*\*\*Total\*\*\s*\|\s*—\s*\|\s*—\s*\|\s*\*\*(\d+)\*\*\s*\|"
)


def _git(args):
    try:
        out = subprocess.run(
            ["git", *args], cwd=str(REPO_ROOT),
            capture_output=True, text=True, timeout=15,
        )
        if out.returncode == 0:
            return out.stdout.strip()
    except Exception:
        pass
    return None


def _as_repo_relative(path):
    try:
        return path.relative_to(REPO_ROOT).as_posix()
    except ValueError:
        return str(path.resolve())


def resolve_metadata(source_path):
    """Project / version / revision / last-updated for the JSON metadata block."""
    git_path = _as_repo_relative(source_path)
    revision = _git(["rev-list", "--count", "HEAD", "--", git_path])
    if not revision or revision == "0":
        revision = "1"
    last_updated = _git(["log", "-1", "--format=%cd", "--date=short", "--", git_path])
    if not last_updated:
        mtime = dt.datetime.fromtimestamp(source_path.stat().st_mtime)
        last_updated = mtime.strftime("%Y-%m-%d")
    return {
        "project": "MYHOSWEB",
        "artifact": "Program Progress Tracker",
        "version": "1.0",
        "trackerRevision": int(revision),
        "lastUpdated": last_updated,
        "generatedAt": dt.datetime.now().strftime("%Y-%m-%d %H:%M"),
        "source": git_path,
        "generator": _as_repo_relative(pathlib.Path(__file__)),
    }


def crosscheck_total(markdown_text, feature_count):
    """Compare parsed feature count against the tracker's own Program Summary."""
    for line in markdown_text.splitlines():
        m = TOTAL_ROW_RE.match(line.strip())
        if m:
            declared = int(m.group(1))
            if declared != feature_count:
                return ("WARNING: tracker Program Summary declares %d features, "
                        "parser extracted %d — check heading/table conventions."
                        % (declared, feature_count))
            return "OK: parsed %d features, matches tracker Program Summary." % feature_count
    return "NOTE: no Program Summary total row found; cross-check skipped."


def validate_against_schema(document):
    """Validate the JSON document if the jsonschema package is available."""
    try:
        import jsonschema
    except ImportError:
        return "jsonschema package not installed — schema validation skipped."
    schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    jsonschema.validate(instance=document, schema=schema)
    return "OK: JSON validates against %s." % SCHEMA_PATH.name


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--input", type=pathlib.Path, default=DEFAULT_INPUT,
                    help="Path to MYHOSWEB-PROGRESS-TRACKER.md")
    ap.add_argument("--outdir", type=pathlib.Path, default=DEFAULT_OUTDIR,
                    help="Output directory for generated files")
    args = ap.parse_args(argv)

    source = args.input.resolve()
    if not source.is_file():
        ap.error("tracker not found: %s" % source)

    text = source.read_text(encoding="utf-8")
    parsed = tracker_parser.parse(text)
    if not parsed:
        ap.error("no milestones parsed from %s" % source)

    metadata = resolve_metadata(source)
    document = json_builder.build_json(parsed, metadata)

    outdir = args.outdir.resolve()
    outdir.mkdir(parents=True, exist_ok=True)

    json_path = outdir / "progress-tracker.json"
    with open(json_path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(json.dumps(document, ensure_ascii=False, indent=2) + "\n")

    html_path = outdir / "progress-dashboard.html"
    with open(html_path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(dashboard_builder.build_dashboard(document))

    print(crosscheck_total(text, document["metrics"]["program"]["totalFeatures"]))
    print(validate_against_schema(document))
    print("Milestones: %d | Screens (occurrences): %d | Distinct screens: %d | Features: %d"
          % (document["metrics"]["program"]["totalMilestones"],
             document["metrics"]["program"]["totalScreens"],
             document["metrics"]["program"]["totalDistinctScreens"],
             document["metrics"]["program"]["totalFeatures"]))
    print("Wrote %s" % _as_repo_relative(json_path))
    print("Wrote %s" % _as_repo_relative(html_path))
    return 0


if __name__ == "__main__":
    sys.exit(main())
