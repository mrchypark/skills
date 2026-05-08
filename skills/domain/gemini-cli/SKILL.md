---
name: gemini-cli
description: Use before invoking Gemini CLI for reviews, model checks, cross-validation, or JSON output. Covers safe non-interactive Gemini CLI usage, approval mode, model selection, stdin handling, and output parsing.
---

# Gemini CLI

Use this skill when Gemini CLI is part of a review, model check, cross-validation pass, or structured-output workflow.

## Default Review Command

Use non-interactive mode and keep Gemini read-only unless the user explicitly asks for an editing run.

```bash
gemini --approval-mode plan -m gemini-3.1-pro-preview -p "<review prompt>" < input.txt
```

For JSON output:

```bash
gemini --approval-mode plan -m gemini-3.1-pro-preview -o json -p "<prompt>" < input.txt
```

## Operating Rules

- Prefer `-p/--prompt` for non-interactive runs.
- Prefer `--approval-mode plan` for review-only or cross-validation work.
- Keep stdout and stderr separate when parsing JSON; do not use `2>&1`.
- Put large prompts or file bundles in an input file and redirect with `< input.txt`.
- Ask for structured output only when the downstream step will parse it.
- Treat Gemini output as advisory. Verify claims against local files and tests before adopting them.

## When Not To Use

- Do not use Gemini CLI for routine local edits that can be verified directly.
- Do not use Gemini as a substitute for thread-aware GitHub review state.
- Do not pass secrets, private credentials, or broad unrelated file dumps.

## Related Review Flow

- Use `remote-review` first when the source is PR review threads or `/gemini review` comments.
- Use `review-workflow` to evaluate Gemini findings as neutral local claims before implementing anything.
