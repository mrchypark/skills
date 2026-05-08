#!/usr/bin/env python3
"""Analyze Codex archived session logs for principal-team operating metrics."""

from __future__ import annotations

import argparse
import json
import re
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

SUBAGENT_REQUEST_RE = re.compile(r"서브\s*에이전트|subagent|spawn_agent", re.IGNORECASE)
VERIFY_RE = re.compile(
    r"\b(pytest|cargo test|go test|npm test|pnpm test|bun test|yarn test|"
    r"swift test|xcodebuild|ruff|mypy|tsc|eslint|validate-repo|smoke-install|"
    r"verify-install|diff --check|evaluate_team_run|vitest|playwright test)\b"
)


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    with path.open("r", encoding="utf-8") as handle:
        for line in handle:
            try:
                value = json.loads(line)
            except json.JSONDecodeError:
                continue
            if isinstance(value, dict):
                records.append(value)
    return records


def payload(record: dict[str, Any]) -> dict[str, Any]:
    value = record.get("payload")
    return value if isinstance(value, dict) else {}


def function_args(record: dict[str, Any]) -> dict[str, Any]:
    args = payload(record).get("arguments")
    if not isinstance(args, str):
        return {}
    try:
        value = json.loads(args)
    except json.JSONDecodeError:
        return {}
    return value if isinstance(value, dict) else {}


def message_text(record: dict[str, Any]) -> str:
    content = payload(record).get("content")
    if isinstance(content, list):
        return " ".join(
            item.get("text", "") for item in content if isinstance(item, dict)
        )
    if isinstance(content, str):
        return content
    return ""


def is_injected_skill_text(text: str) -> bool:
    return (
        "<skill>" in text
        or "<skills_instructions>" in text
        or text.startswith("# AGENTS.md instructions")
    )


def command_from_event(record: dict[str, Any]) -> str:
    command = payload(record).get("command", "")
    if isinstance(command, list):
        return " ".join(str(part) for part in command)
    return command if isinstance(command, str) else str(command)


def analyze_file(path: Path) -> dict[str, Any]:
    records = read_jsonl(path)
    session_id = None
    parent_id = None
    role = "parent"
    calls: dict[str, str] = {}
    metrics: dict[str, Any] = {
        "path": str(path),
        "role": role,
        "session_id": session_id,
        "parent_id": parent_id,
        "spawn_agent_count": 0,
        "explicit_model_count": 0,
        "explicit_effort_count": 0,
        "apply_patch_count": 0,
        "exec_command_count": 0,
        "verification_command_count": 0,
        "evaluate_team_run_failures": 0,
        "user_requested_delegation": False,
    }

    for record in records:
        if record.get("type") != "session_meta":
            continue
        meta = payload(record)
        session_id = meta.get("id")
        role = meta.get("agent_role") or "parent"
        source = meta.get("source")
        if isinstance(source, dict):
            subagent = source.get("subagent")
            if isinstance(subagent, dict):
                thread_spawn = subagent.get("thread_spawn")
                if isinstance(thread_spawn, dict):
                    parent_id = thread_spawn.get("parent_thread_id")
        metrics.update({"role": role, "session_id": session_id, "parent_id": parent_id})
        break

    for record in records:
        record_type = record.get("type")
        data = payload(record)
        if record_type == "response_item" and data.get("type") == "function_call":
            call_id = data.get("call_id")
            name = data.get("name")
            if isinstance(call_id, str) and isinstance(name, str):
                calls[call_id] = name
            if name == "spawn_agent":
                metrics["spawn_agent_count"] += 1
                args = function_args(record)
                if args.get("model"):
                    metrics["explicit_model_count"] += 1
                if args.get("reasoning_effort"):
                    metrics["explicit_effort_count"] += 1
            elif name == "exec_command":
                metrics["exec_command_count"] += 1
                cmd = function_args(record).get("cmd", "")
                if VERIFY_RE.search(cmd if isinstance(cmd, str) else str(cmd)):
                    metrics["verification_command_count"] += 1
        elif record_type == "response_item" and data.get("type") == "custom_tool_call":
            if data.get("name") == "apply_patch":
                metrics["apply_patch_count"] += 1
        elif record_type == "response_item" and data.get("type") == "message":
            text = message_text(record)
            if (
                data.get("role") == "user"
                and not is_injected_skill_text(text)
                and SUBAGENT_REQUEST_RE.search(text)
            ):
                metrics["user_requested_delegation"] = True
        elif record_type == "event_msg" and data.get("type") == "user_message":
            text = data.get("message") or data.get("text") or ""
            if isinstance(text, str) and SUBAGENT_REQUEST_RE.search(text):
                metrics["user_requested_delegation"] = True
        elif record_type == "event_msg" and data.get("type") == "exec_command_end":
            command = command_from_event(record)
            if "evaluate_team_run.py" in command and data.get("exit_code") not in (0, None):
                metrics["evaluate_team_run_failures"] += 1

    return metrics


def aggregate(files: list[Path]) -> dict[str, Any]:
    sessions = [analyze_file(path) for path in files]
    by_role: dict[str, Counter[str]] = defaultdict(Counter)
    parent_ids_with_user_delegation = {
        session["session_id"]
        for session in sessions
        if session["role"] == "parent" and session["user_requested_delegation"]
    }

    for session in sessions:
        role = session["role"]
        for key in (
            "spawn_agent_count",
            "explicit_model_count",
            "explicit_effort_count",
            "apply_patch_count",
            "exec_command_count",
            "verification_command_count",
            "evaluate_team_run_failures",
        ):
            by_role[role][key] += int(session[key])
        by_role[role]["session_count"] += 1
        if role == "parent" and session["user_requested_delegation"]:
            by_role[role]["user_requested_delegation_sessions"] += 1

    parent_patches = by_role["parent"]["apply_patch_count"]
    worker_patches = by_role["worker"]["apply_patch_count"]
    patch_total = parent_patches + worker_patches
    spawn_total = sum(counter["spawn_agent_count"] for counter in by_role.values())
    explicit_model_total = sum(counter["explicit_model_count"] for counter in by_role.values())
    explicit_effort_total = sum(counter["explicit_effort_count"] for counter in by_role.values())
    subagent_sessions = sum(
        1 for session in sessions if session["role"] != "parent"
    )
    subagent_sessions_from_user_requested_parent = sum(
        1
        for session in sessions
        if session["role"] != "parent"
        and session["parent_id"] in parent_ids_with_user_delegation
    )

    return {
        "file_count": len(files),
        "session_count": len(sessions),
        "parent_session_count": by_role["parent"]["session_count"],
        "subagent_session_count": subagent_sessions,
        "subagent_sessions_from_user_requested_parent": subagent_sessions_from_user_requested_parent,
        "spawn_agent_count": spawn_total,
        "explicit_model_rate": round(explicit_model_total / spawn_total, 3)
        if spawn_total
        else 0.0,
        "explicit_effort_rate": round(explicit_effort_total / spawn_total, 3)
        if spawn_total
        else 0.0,
        "parent_patch_count": parent_patches,
        "worker_patch_count": worker_patches,
        "parent_patch_share": round(parent_patches / patch_total, 3)
        if patch_total
        else 0.0,
        "verification_command_count": sum(
            counter["verification_command_count"] for counter in by_role.values()
        ),
        "evaluate_team_run_failure_count": sum(
            counter["evaluate_team_run_failures"] for counter in by_role.values()
        ),
        "by_role": {role: dict(counter) for role, counter in sorted(by_role.items())},
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("logs", nargs="+", type=Path, help="Archived session JSONL files")
    args = parser.parse_args()

    files = [path for path in args.logs if path.exists()]
    result = aggregate(files)
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
