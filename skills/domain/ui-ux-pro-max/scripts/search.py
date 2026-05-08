#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "data" / "design-rules.json"


def load_data() -> dict:
    return json.loads(DATA_PATH.read_text(encoding="utf-8"))


def score(item: dict, terms: list[str]) -> int:
    haystack = " ".join(
        str(value).lower()
        for key, value in item.items()
        if key in {"domain", "stack", "title", "tags", "summary"}
    )
    return sum(1 for term in terms if term in haystack)


def matching(items: list[dict], query: str, limit: int) -> list[dict]:
    terms = [term.lower() for term in query.split() if term.strip()]
    ranked = sorted(items, key=lambda item: score(item, terms), reverse=True)
    if terms:
        ranked = [item for item in ranked if score(item, terms) > 0] or ranked
    return ranked[:limit]


def render_items(items: list[dict], fmt: str) -> str:
    if fmt == "json":
        return json.dumps(items, ensure_ascii=False, indent=2)
    lines: list[str] = []
    for item in items:
        label = item.get("domain") or item.get("stack")
        lines.append(f"## {item['title'] if 'title' in item else label}")
        lines.append(f"- scope: {label}")
        if item.get("tags"):
            lines.append(f"- tags: {', '.join(item['tags'])}")
        lines.append(f"- guidance: {item['summary']}")
        lines.append("")
    return "\n".join(lines).rstrip()


def design_system(data: dict, query: str, project: str | None, fmt: str) -> str:
    items = matching(data["domains"], query, 6)
    payload = {
        "project": project or "Project",
        "query": query,
        "recommendations": items,
        "stacks": matching(data["stacks"], query, 3),
    }
    if fmt == "json":
        return json.dumps(payload, ensure_ascii=False, indent=2)

    lines = [f"# {payload['project']} Design System", ""]
    lines.append(f"- query: {query}")
    lines.append("- principle: choose the smallest coherent UI system that matches the product workflow.")
    lines.append("")
    lines.append("## Recommendations")
    for item in items:
        lines.append(f"- **{item['title']}** ({item['domain']}): {item['summary']}")
    lines.append("")
    lines.append("## Stack Notes")
    for item in payload["stacks"]:
        lines.append(f"- **{item['stack']}**: {item['summary']}")
    return "\n".join(lines)


def persist(markdown: str, page: str | None) -> None:
    root = Path("design-system")
    root.mkdir(exist_ok=True)
    (root / "MASTER.md").write_text(markdown + "\n", encoding="utf-8")
    if page:
        pages = root / "pages"
        pages.mkdir(exist_ok=True)
        (pages / f"{page}.md").write_text(
            f"# {page} Overrides\n\nUse `../MASTER.md` unless this file states a narrower page-specific rule.\n",
            encoding="utf-8",
        )


def main() -> int:
    parser = argparse.ArgumentParser(description="Search compact UI/UX design guidance.")
    parser.add_argument("query", nargs="*", help="Search terms")
    parser.add_argument("--domain", choices=["product", "style", "color", "landing", "typography", "chart", "ux", "react", "web"])
    parser.add_argument("--stack", choices=["web", "react", "next", "react-native", "swiftui"])
    parser.add_argument("--design-system", action="store_true")
    parser.add_argument("--persist", action="store_true")
    parser.add_argument("--page")
    parser.add_argument("-p", "--project")
    parser.add_argument("-n", "--limit", type=int, default=5)
    parser.add_argument("-f", "--format", choices=["markdown", "json"], default="markdown")
    args = parser.parse_args()

    data = load_data()
    query = " ".join(args.query).strip() or "ui ux"

    if args.design_system:
        output = design_system(data, query, args.project, args.format)
        if args.persist:
            persist(output if args.format == "markdown" else design_system(data, query, args.project, "markdown"), args.page)
        print(output)
        return 0

    if args.stack:
        items = [item for item in data["stacks"] if item["stack"] == args.stack]
    else:
        items = data["domains"]
        if args.domain:
            items = [item for item in items if item["domain"] == args.domain]
        items = matching(items, query, args.limit)

    print(render_items(items, args.format))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
