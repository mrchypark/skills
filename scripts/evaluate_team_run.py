#!/usr/bin/env python3
"""Evaluate a Codex principal-team run log."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


def count_list(value: Any) -> int:
    if value is None:
        return 0
    if isinstance(value, list):
        return len(value)
    raise TypeError(f"expected list or null, got {type(value).__name__}")


def count_number(value: Any) -> int:
    if value is None:
        return 0
    if isinstance(value, bool):
        raise TypeError("expected int, integral float, or null, got bool")
    if isinstance(value, int):
        return value
    if isinstance(value, float) and value.is_integer():
        return int(value)
    raise TypeError(f"expected int, integral float, or null, got {type(value).__name__}")


def evaluate(log: dict[str, Any]) -> dict[str, Any]:
    large = count_number(log.get("large_model_actions"))
    small = count_number(log.get("small_model_actions"))
    oracle_calls = count_number(log.get("oracle_calls"))
    oracle_adopted = count_number(log.get("oracle_adopted"))
    skills_used = count_list(log.get("skills_used"))
    new_skills = count_list(log.get("new_skills"))
    scripts_used = count_list(log.get("scripts_used"))
    new_scripts = count_list(log.get("new_scripts"))
    manual = count_list(log.get("manual_activities"))
    failures = count_list(log.get("failures"))
    rework = count_list(log.get("rework_items"))
    follow_ups = count_list(log.get("follow_up_candidates"))

    model_actions = large + small
    large_share = (large / model_actions) if model_actions else 0.0
    small_share = (small / model_actions) if model_actions else 0.0
    oracle_adoption_rate = (oracle_adopted / oracle_calls) if oracle_calls else 0.0

    recommendations: list[str] = []
    if manual:
        recommendations.append("Review manual activities for skill or script conversion.")
    if large_share > 0.5 and model_actions >= 4:
        recommendations.append("Move bounded large-model work to small-model subagents.")
    if failures or rework:
        recommendations.append("Add verification checks for failure or rework patterns.")
    if oracle_calls and oracle_adoption_rate == 0:
        recommendations.append("Tighten the Oracle trigger to avoid low-value calls.")
    if follow_ups:
        recommendations.append("Prioritize follow-up candidates before the next similar run.")

    return {
        "task": log.get("task", "unknown"),
        "large_model_action_share": round(large_share, 3),
        "small_model_action_share": round(small_share, 3),
        "oracle_adoption_rate": round(oracle_adoption_rate, 3),
        "skill_reuse_count": skills_used,
        "new_skill_count": new_skills,
        "script_use_count": scripts_used,
        "new_script_count": new_scripts,
        "manual_activity_count": manual,
        "failure_count": failures,
        "rework_count": rework,
        "follow_up_candidate_count": follow_ups,
        "recommendations": recommendations,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("run_log", type=Path, help="Path to a principal-team run log JSON file")
    args = parser.parse_args()

    with args.run_log.open("r", encoding="utf-8") as handle:
        log = json.load(handle)

    result = evaluate(log)
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
