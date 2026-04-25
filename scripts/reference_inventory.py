#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
import json
import pathlib
import re
import shutil
import subprocess
import tempfile
from dataclasses import dataclass


@dataclass(frozen=True)
class Source:
    id: str
    url: str


SOURCES = [
    Source("workflows", "https://github.com/edwinhu/workflows.git"),
    Source(
        "awesome-claude-code-subagents",
        "https://github.com/VoltAgent/awesome-claude-code-subagents.git",
    ),
]

PROCESS_HINTS = (
    "brainstorm",
    "plan",
    "review",
    "verify",
    "verification",
    "delegate",
    "debug",
    "test",
    "execute",
    "finish",
    "worktree",
    "request",
    "receive",
    "parallel",
    "subagent",
    "using-",
)


def run(*args: str, cwd: pathlib.Path | None = None) -> str:
    completed = subprocess.run(
        args,
        cwd=cwd,
        check=True,
        text=True,
        capture_output=True,
    )
    return completed.stdout.strip()


def parse_frontmatter_name(path: pathlib.Path) -> str | None:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return None
    match = re.search(r"^name:\s*(.+?)\s*$", text, re.MULTILINE)
    if not match:
        return None
    return match.group(1).strip().strip('"')


def normalize_agent_name(path: pathlib.Path) -> str:
    return path.stem


def bucket_for(name: str, kind: str) -> str:
    lowered = name.lower()
    if kind == "agent":
        return "agent-role"
    if any(hint in lowered for hint in PROCESS_HINTS):
        return "process-skill"
    return "domain-skill"


def inventory_skills(repo_root: pathlib.Path, source_id: str) -> list[dict]:
    entries = []
    for skill_path in sorted(repo_root.glob("**/SKILL.md")):
        if ".git/" in skill_path.as_posix():
            continue
        name = parse_frontmatter_name(skill_path) or skill_path.parent.name
        entries.append(
            {
                "source": source_id,
                "kind": "skill",
                "name": name,
                "path": skill_path.relative_to(repo_root).as_posix(),
                "suggested_bucket": bucket_for(name, "skill"),
            }
        )
    return entries


def inventory_agents(repo_root: pathlib.Path, source_id: str) -> list[dict]:
    entries = []
    if source_id == "awesome-claude-code-subagents":
        patterns = [repo_root.glob("categories/*/*.md")]
    else:
        patterns = [repo_root.glob("agents/*.md")]
    for pattern in patterns:
        for agent_path in sorted(pattern):
            if agent_path.name.lower() == "readme.md":
                continue
            name = normalize_agent_name(agent_path)
            entries.append(
                {
                    "source": source_id,
                    "kind": "agent",
                    "name": name,
                    "path": agent_path.relative_to(repo_root).as_posix(),
                    "suggested_bucket": bucket_for(name, "agent"),
                }
            )
    return entries


def clone_source(source: Source, workspace: pathlib.Path) -> pathlib.Path:
    repo_dir = workspace / source.id
    run("git", "clone", "--depth", "1", source.url, str(repo_dir))
    return repo_dir


def build_inventory() -> dict:
    generated_at = dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat()
    with tempfile.TemporaryDirectory() as tmpdir:
        temp_root = pathlib.Path(tmpdir)
        source_records = []
        entries = []
        for source in SOURCES:
            repo_dir = clone_source(source, temp_root)
            commit = run("git", "rev-parse", "HEAD", cwd=repo_dir)
            repo_entries = inventory_skills(repo_dir, source.id) + inventory_agents(
                repo_dir, source.id
            )
            source_records.append(
                {
                    "id": source.id,
                    "url": source.url,
                    "commit": commit,
                    "entry_count": len(repo_entries),
                }
            )
            entries.extend(repo_entries)

    summary = {
        "total_entries": len(entries),
        "skills": sum(1 for entry in entries if entry["kind"] == "skill"),
        "agents": sum(1 for entry in entries if entry["kind"] == "agent"),
        "process_skills": sum(
            1 for entry in entries if entry["suggested_bucket"] == "process-skill"
        ),
        "domain_skills": sum(
            1 for entry in entries if entry["suggested_bucket"] == "domain-skill"
        ),
        "agent_roles": sum(
            1 for entry in entries if entry["suggested_bucket"] == "agent-role"
        ),
    }
    return {
        "generated_at": generated_at,
        "sources": source_records,
        "summary": summary,
        "entries": entries,
    }


def render_markdown(data: dict) -> str:
    lines = [
        "# Reference Consolidation",
        "",
        f"Generated at: `{data['generated_at']}`",
        "",
        "## Process",
        "",
        "1. Run `python3 scripts/reference_inventory.py --json-out catalog/reference-inventory.json --markdown-out docs/reference-consolidation.md`.",
        "2. Review the raw inventory grouped by source before making taxonomy decisions.",
        "3. Keep every external item in one of four buckets: `process-skill`, `domain-skill`, `agent-role`, or `reference-only`.",
        "4. Merge duplicates by behavior, not by name. Preserve only the strongest instruction set for each adopted capability.",
        "5. Record explicit reject reasons for entries that remain reference-only so the toolkit does not silently drift back toward provider-specific sprawl.",
        "",
        "## Unified taxonomy",
        "",
        "- `process-skill`: reusable workflow skills for planning, verification, review, debugging, and delegation",
        "- `domain-skill`: topic-specific skills that remain useful after provider-specific wording is removed",
        "- `agent-role`: multi-agent roles or specialist personas that Codex can run via `config_file`-backed agent configs",
        "- `reference-only`: useful inspiration that should not be installed directly into this toolkit",
        "",
        "## Source summary",
        "",
        "| Source | Commit | Entries |",
        "| --- | --- | ---: |",
    ]
    for source in data["sources"]:
        lines.append(
            f"| {source['id']} | `{source['commit'][:12]}` | {source['entry_count']} |"
        )
    lines.extend(
        [
            "",
            "## Inventory",
            "",
            "| Source | Kind | Name | Suggested bucket | Path |",
            "| --- | --- | --- | --- | --- |",
        ]
    )
    for entry in sorted(
        data["entries"],
        key=lambda item: (item["source"], item["kind"], item["name"].lower()),
    ):
        lines.append(
            f"| {entry['source']} | {entry['kind']} | `{entry['name']}` | {entry['suggested_bucket']} | `{entry['path']}` |"
        )
    lines.extend(
        [
            "",
            "## Codex constraints",
            "",
            "- Codex reads repo and user skills from `.agents/skills` locations and follows symlinked skill folders.",
            "- Project-level agent roles should be declared in `.codex/config.toml` using `[agents.<name>]` plus `config_file` references.",
            "- Multi-agent setups should keep agent roles small and specialized, with read-only roles for research and review when possible.",
        ]
    )
    return "\n".join(lines) + "\n"


def write_file(path: pathlib.Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--json-out", required=True)
    parser.add_argument("--markdown-out", required=True)
    args = parser.parse_args()

    data = build_inventory()
    json_out = pathlib.Path(args.json_out)
    markdown_out = pathlib.Path(args.markdown_out)

    write_file(json_out, json.dumps(data, indent=2, ensure_ascii=True) + "\n")
    write_file(markdown_out, render_markdown(data))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
