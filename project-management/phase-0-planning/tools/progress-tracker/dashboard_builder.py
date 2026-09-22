"""HTML dashboard generator.

Injects the normalized tracker JSON into a standalone HTML template.
The template uses pure HTML/CSS/vanilla JavaScript with no external
dependencies and renders all views client-side from the embedded data.
"""

import pathlib

TEMPLATE_PATH = pathlib.Path(__file__).with_name("dashboard_template.html")


def build_dashboard(tracker_json):
    """Return the dashboard HTML string for the given tracker document."""
    template = TEMPLATE_PATH.read_text(encoding="utf-8")
    payload = _json_for_script(tracker_json)
    return template.replace("__DATA_JSON__", payload)


def _json_for_script(obj):
    import json

    text = json.dumps(obj, ensure_ascii=False, separators=(",", ":"))
    # Prevent an embedded "</script>" sequence from breaking the document.
    return text.replace("</", "<\\/")
