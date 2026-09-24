"""Markdown parser for MYHOSWEB-PROGRESS-TRACKER.md.

Converts the authoritative tracker Markdown into an intermediate Python
structure (milestones -> screens -> features) using only the Python
standard library. The Markdown file remains the single source of truth;
this module never writes to it.
"""

import re

MILESTONE_RE = re.compile(r"^## Milestone\s+(M\d+)\s*[—–-]\s*(.+?)\s*$")
SCREEN_RE = re.compile(r"^###\s+(SC-\d+)\s+(.+?)\s*$")
FEATURE_RE = re.compile(r"^####\s+(FT-\d+-\d+)\s+(.+?)\s*$")
BOLD_ONLY_RE = re.compile(r"^\*\*([^*]+)\*\*$")
BUSINESS_DESC_RE = re.compile(r"^\*\*Business description:\*\*\s*(.+?)\s*$")
MILESTONE_STATUS_RE = re.compile(r"^\*\*Milestone Status:\*\*\s*(\S+)")
SCREEN_PIC_RE = re.compile(r"^\*\*PIC:\*\*\s*(.+?)\s*$")
TABLE_SEP_CELL_RE = re.compile(r"^:?-{3,}:?$")

PHASE_BY_HEADING = {
    "Analysis": "analysis",
    "Testing": "testing",
    "Pilot Deployment": "pilotDeployment",
    "Rollout": "rollout",
}

FIELD_MAP = {
    "Overall Status": "status",
    "Planned Start Date": "plannedStart",
    "Planned Duration": "plannedDuration",
}


def camel(header):
    words = [w for w in re.split(r"[^A-Za-z0-9]+", header.strip()) if w]
    if not words:
        return header.strip()
    parts = [words[0].lower()]
    for w in words[1:]:
        if w == "ID":
            parts.append("Id")
        elif w.isupper():
            parts.append(w.lower())
        else:
            parts.append(w[:1].upper() + w[1:].lower())
    return "".join(parts)


def split_row(line):
    line = line.strip()
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    return [cell.strip() for cell in line.split("|")]


def is_separator(cells):
    return bool(cells) and all(TABLE_SEP_CELL_RE.match(c) for c in cells)


def clean(value):
    """Normalize a Markdown table cell value."""
    if value is None:
        return None
    value = value.strip()
    if value in ("", "-"):
        return None
    return value


def parse_complexity(value):
    value = clean(value)
    if value is None or value == "TBD":
        return None
    try:
        return int(value)
    except ValueError:
        return None


class TrackerParser:
    """State-machine parser over the tracker Markdown."""

    def __init__(self):
        self.milestones = []
        self._milestone = None
        self._screen = None
        self._feature = None
        self._phase = None

    # -- context handling -------------------------------------------------

    def _enter_milestone(self, mid, name):
        self._milestone = {
            "id": mid,
            "name": name,
            "status": None,
            "businessDescription": None,
            "screens": [],
        }
        self.milestones.append(self._milestone)
        self._screen = None
        self._feature = None
        self._phase = None

    def _enter_screen(self, sid, name):
        if self._milestone is None:
            return
        self._screen = {"id": sid, "name": name, "pic": None, "features": []}
        self._milestone["screens"].append(self._screen)
        self._feature = None
        self._phase = None

    def _upsert_feature_from_summary(self, row):
        if self._screen is None:
            return
        fid = clean(row.get("featureId"))
        if not fid:
            return
        feature = {
            "featureId": fid,
            "featureName": clean(row.get("featureName")),
            "complexity": parse_complexity(row.get("complexity")),
            "status": clean(row.get("overallStatus")),
            "plannedStart": clean(row.get("plannedStart")),
            "plannedDuration": clean(row.get("duration")),
            "analysis": {"rows": []},
            "testing": {"rows": []},
            "pilotDeployment": {"rows": []},
            "rollout": [],
            "extra": {},
        }
        self._screen["features"].append(feature)

    def _enter_feature(self, fid, name):
        self._phase = None
        existing = None
        if self._screen is not None:
            for feature in self._screen["features"]:
                if feature["featureId"] == fid:
                    existing = feature
                    break
        if existing is None:
            if self._screen is None:
                return
            existing = {
                "featureId": fid,
                "featureName": name,
                "complexity": None,
                "status": None,
                "plannedStart": None,
                "plannedDuration": None,
                "analysis": {"rows": []},
                "testing": {"rows": []},
                "pilotDeployment": {"rows": []},
                "rollout": [],
                "extra": {},
            }
            self._screen["features"].append(existing)
        if name:
            existing["featureName"] = name
        self._feature = existing

    # -- table handling ----------------------------------------------------

    def _handle_table(self, header_cells, data_rows):
        kind = header_cells[0]
        keys = [camel(c) for c in header_cells]
        rows = [dict(zip(keys, [clean(c) for c in row])) for row in data_rows]

        if kind == "Feature ID" and self._screen is not None and self._feature is None:
            for row in rows:
                self._upsert_feature_from_summary(row)
            return

        if self._feature is None:
            return

        if kind == "Field":
            for row in rows:
                label = row.get("field")
                value = row.get("value")
                canonical = FIELD_MAP.get(label)
                if canonical:
                    self._feature[canonical] = value
                elif label:
                    self._feature["extra"][_squash(label)] = value
            return

        phase = self._phase
        if phase is None:
            return
        if phase == "rollout":
            self._feature["rollout"].extend(rows)
        else:
            self._feature[phase]["rows"].extend(rows)

    # -- main loop ----------------------------------------------------------

    def feed(self, text):
        lines = text.splitlines()
        i = 0
        n = len(lines)
        while i < n:
            line = lines[i]
            stripped = line.strip()

            if stripped.startswith("|"):
                block = []
                while i < n and lines[i].strip().startswith("|"):
                    block.append(lines[i])
                    i += 1
                self._consume_table_block(block)
                continue

            m = MILESTONE_RE.match(stripped)
            if m:
                self._enter_milestone(m.group(1), m.group(2))
                i += 1
                continue
            if stripped.startswith("## "):
                # Non-milestone level-2 heading closes milestone context.
                self._milestone = None
                self._screen = None
                self._feature = None
                self._phase = None
                i += 1
                continue

            m = SCREEN_RE.match(stripped)
            if m:
                self._enter_screen(m.group(1), m.group(2))
                i += 1
                continue

            m = FEATURE_RE.match(stripped)
            if m:
                self._enter_feature(m.group(1), m.group(2))
                i += 1
                continue

            m = BUSINESS_DESC_RE.match(stripped)
            if m and self._milestone is not None:
                self._milestone["businessDescription"] = m.group(1)
                i += 1
                continue

            m = MILESTONE_STATUS_RE.match(stripped)
            if m and self._milestone is not None:
                self._milestone["status"] = m.group(1)
                i += 1
                continue

            m = SCREEN_PIC_RE.match(stripped)
            if m and self._screen is not None and self._feature is None:
                self._screen["pic"] = clean(m.group(1))
                i += 1
                continue

            m = BOLD_ONLY_RE.match(stripped)
            if m:
                title = m.group(1).strip()
                self._phase = PHASE_BY_HEADING.get(title)
                i += 1
                continue

            i += 1

    def _consume_table_block(self, block):
        rows_cells = [split_row(line) for line in block]
        rows_cells = [r for r in rows_cells if not is_separator(r)]
        if not rows_cells:
            return
        header = rows_cells[0]
        data = rows_cells[1:]
        self._handle_table(header, data)


def _squash(text):
    return re.sub(r"[^a-z0-9]", "", text.lower())


def parse(text):
    """Parse tracker Markdown and return the milestone tree."""
    parser = TrackerParser()
    parser.feed(text)
    return parser.milestones
