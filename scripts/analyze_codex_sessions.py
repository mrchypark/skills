#!/usr/bin/env python3
"""Compatibility wrapper for the bundled Codex session-log analyzer."""

from __future__ import annotations

import runpy
from pathlib import Path


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    target = root / "skills/process/codex-principal-team/scripts/analyze_codex_sessions.py"
    runpy.run_path(str(target), run_name="__main__")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
