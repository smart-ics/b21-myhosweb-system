# generated/

This directory contains **generated views only**.

| File | Produced from |
| ---- | ------------- |
| `progress-tracker.json` | `project-management/phase-0-planning/MYHOSWEB-PROGRESS-TRACKER.md` |
| `progress-dashboard.html` | `progress-tracker.json` (same pipeline) |

Never edit these files by hand. Whenever the tracker changes, regenerate
from the repository root:

```powershell
python project-management/phase-0-planning/tools/progress-tracker/generate.py
```

The Markdown tracker remains the single source of truth. See
`project-management/phase-0-planning/tools/progress-tracker/README.md` for
the full generation flow.
