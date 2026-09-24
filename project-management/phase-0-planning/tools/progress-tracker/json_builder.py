"""JSON builder: turns the parsed tracker tree into the normalized
progress-tracker.json document, including all derived metrics.

Derived metrics are computed here and are generated views only; they are
never written back to the Markdown source of truth.
"""

FEATURE_STATUSES = {
    "NOT_STARTED", "PLANNING", "ANALYSIS", "IMPLEMENTATION", "REVIEW",
    "TESTING", "PILOT_DEPLOYMENT", "ROLLED_OUT", "COMPLETED", "BLOCKED",
}
PHASE_STATUSES = {"NOT_STARTED", "IN_PROGRESS", "COMPLETED", "BLOCKED"}

_COMPLETED = {"COMPLETED", "ROLLED_OUT"}
_BLOCKED = {"BLOCKED"}
_NOT_STARTED = {None, "", "NOT_STARTED"}


def feature_bucket(status):
    """Map a feature Overall Status to one of four reporting buckets."""
    if status in _COMPLETED:
        return "completed"
    if status in _BLOCKED:
        return "blocked"
    if status in _NOT_STARTED:
        return "notStarted"
    return "inProgress"


def _empty_counts():
    return {"completed": 0, "inProgress": 0, "blocked": 0, "notStarted": 0}


def _pct(part, total):
    return round(part * 100.0 / total, 1) if total else 0.0


def _status_counts(items, key="status"):
    counts = {}
    for item in items:
        status = item.get(key) or "NOT_STARTED"
        counts[status] = counts.get(status, 0) + 1
    return counts


def _phase_stats(rows):
    buckets = _empty_counts()
    for row in rows:
        buckets[feature_bucket(row.get("status"))] += 1
    total = len(rows)
    return {
        "rowCount": total,
        "completed": buckets["completed"],
        "inProgress": buckets["inProgress"],
        "blocked": buckets["blocked"],
        "notStarted": buckets["notStarted"],
        "statusCounts": _status_counts(rows),
        "completionPct": _pct(buckets["completed"], total),
    }


def _iter_features(milestones):
    for milestone in milestones:
        for screen in milestone["screens"]:
            for feature in screen["features"]:
                yield milestone, screen, feature


def build_json(parsed_milestones, metadata):
    """Return the final normalized document as a plain dict."""
    milestones_out = []
    metric_milestones = []
    metric_screens = []

    screen_occurrences = 0
    distinct_screens = set()
    feature_totals = _empty_counts()
    total_features = 0

    phase_rows = {
        "analysis": [],
        "testing": [],
        "pilotDeployment": [],
        "rollout": [],
    }
    all_feature_statuses = []

    for milestone in parsed_milestones:
        screens_out = []
        milestone_features = _empty_counts()
        milestone_total = 0

        for screen in milestone["screens"]:
            screen_occurrences += 1
            distinct_screens.add(screen["id"])
            screen_features = _empty_counts()
            screen_total = 0

            features_out = []
            for feature in screen["features"]:
                bucket = feature_bucket(feature["status"])
                milestone_features[bucket] += 1
                feature_totals[bucket] += 1
                screen_features[bucket] += 1
                milestone_total += 1
                screen_total += 1
                total_features += 1
                all_feature_statuses.append({"status": feature["status"]})

                for phase in ("analysis", "testing", "pilotDeployment"):
                    phase_rows[phase].extend(feature[phase]["rows"])
                phase_rows["rollout"].extend(feature["rollout"])

                feature_out = {
                    "featureId": feature["featureId"],
                    "featureName": feature["featureName"],
                    "complexity": feature["complexity"],
                    "status": feature["status"],
                    "statusBucket": bucket,
                    "screenPic": screen.get("pic"),
                    "plannedStart": feature["plannedStart"],
                    "plannedDuration": feature["plannedDuration"],
                    "analysis": {
                        "rows": feature["analysis"]["rows"],
                        "summary": _phase_stats(feature["analysis"]["rows"]),
                    },
                    "testing": {
                        "rows": feature["testing"]["rows"],
                        "summary": _phase_stats(feature["testing"]["rows"]),
                    },
                    "pilotDeployment": {
                        "rows": feature["pilotDeployment"]["rows"],
                        "summary": _phase_stats(
                            feature["pilotDeployment"]["rows"]
                        ),
                    },
                    "rollout": feature["rollout"],
                    "rolloutSummary": _phase_stats(feature["rollout"]),
                }
                if feature.get("extra"):
                    feature_out["additionalFields"] = feature["extra"]
                features_out.append(feature_out)

            screens_out.append({
                "id": screen["id"],
                "name": screen["name"],
                "pic": screen.get("pic"),
                "features": features_out,
            })
            metric_screens.append({
                "milestoneId": milestone["id"],
                "milestoneName": milestone["name"],
                "screenId": screen["id"],
                "screenName": screen["name"],
                "pic": screen.get("pic"),
                "featureCount": screen_total,
                **screen_features,
                "completionPct": _pct(screen_features["completed"], screen_total),
            })

        milestones_out.append({
            "id": milestone["id"],
            "name": milestone["name"],
            "status": milestone["status"],
            "businessDescription": milestone["businessDescription"],
            "screens": screens_out,
        })
        metric_milestones.append({
            "id": milestone["id"],
            "name": milestone["name"],
            "status": milestone["status"],
            "businessDescription": milestone["businessDescription"],
            "screenCount": len(milestone["screens"]),
            "featureCount": milestone_total,
            **milestone_features,
            "completionPct": _pct(milestone_features["completed"], milestone_total),
        })

    program = {
        "totalMilestones": len(milestones_out),
        "totalScreens": screen_occurrences,
        "totalDistinctScreens": len(distinct_screens),
        "totalFeatures": total_features,
        "features": {
            **feature_totals,
            "completionPct": _pct(feature_totals["completed"], total_features),
        },
        "statusCounts": _status_counts(all_feature_statuses),
        "phases": {
            phase: _phase_stats(rows) for phase, rows in phase_rows.items()
        },
    }

    return {
        "metadata": metadata,
        "milestones": milestones_out,
        "metrics": {
            "program": program,
            "milestones": metric_milestones,
            "screens": metric_screens,
        },
    }


__all__ = [
    "build_json",
    "feature_bucket",
    "FEATURE_STATUSES",
    "PHASE_STATUSES",
]
