---
name: agy-antigravity
description: Use when running the Google Antigravity `agy` CLI as an external agent for bounded reviews, second opinions, repo analysis, or delegated CLI-based investigation from Codex.
---

# Agy Antigravity

## Overview

Use the installed `agy` CLI as an external advisory agent. In this environment, `agy` is Google Antigravity CLI `1.0.1` (for example, at `~/.local/bin/agy`).

`agy` output is advisory. Verify any claim against local files, tests, command output, and project constraints before changing direction or reporting completion.

## Use Agy When

- you need an independent Antigravity/Gemini/Claude-flavored second opinion
- a bounded repo review would benefit from external agent context
- you want to compare Codex's plan with another CLI agent before an expensive-to-reverse change
- the task can be expressed as a clear one-shot prompt with a concrete output contract

## Do Not Use Agy When

- the answer is available from a few local file reads or a focused test
- the task involves secrets, credentials, or private data that should not leave the local trust boundary
- local verification has not been planned
- a broad, unbounded whole-repo review would create more noise than evidence

## Preflight

Run these before relying on `agy` in a session:

```bash
command -v agy
agy --version
agy --help
```

Known verified version:

```text
1.0.1
```

Important flag ordering: put modifiers such as `--print-timeout`, `--sandbox`, and `--add-dir` before `--print`. If `--print` appears before `--print-timeout`, Antigravity may treat the later flag text as part of the prompt.

## One-Shot Review

Use print mode for bounded external-agent calls:

```bash
agy --print-timeout 10m --print '<prompt>'
```

When the prompt needs project files, run from the project root and add the workspace explicitly:

```bash
agy --print-timeout 10m --add-dir "$PWD" --print '<prompt>'
```

For review-only calls, make the prompt explicitly read-only:

```bash
agy --print-timeout 10m --add-dir "$PWD" --print '
Review this repository change as an external agent.
Do not edit files.
Focus on correctness, regressions, missing tests, and unsafe assumptions.
Return findings first with file paths and line references when possible.
'
```

## Interactive Use

Use interactive mode only when a human or the current Codex session needs to continue the conversation:

```bash
agy --prompt-interactive '<initial prompt>'
agy --continue
agy --conversation '<conversation-id>'
```

Prefer one-shot `--print` for automated review or orchestration because it is easier to capture, summarize, and verify.

## Workspace And Permissions

- `--add-dir` adds extra directories to the Antigravity workspace and is repeatable.
- `--sandbox` runs with terminal restrictions enabled.
- `--dangerously-skip-permissions` auto-approves tool permission requests. Use it only in an isolated, trusted workspace where the prompt and file set are tightly scoped.
- `--log-file` can redirect CLI logs when debugging CLI behavior.

## Plugin Commands

`agy` can manage Antigravity plugins:

```bash
agy plugin list
agy plugin import gemini
agy plugin import claude
agy plugin install '<target>'
agy plugin uninstall '<name>'
agy plugin enable '<name>'
agy plugin disable '<name>'
agy plugin validate '<path>'
```

The installed `1.0.1` CLI reports imported Gemini plugins through `agy plugin list`.

## Prompt Contract

Every `agy` request should include:

- goal and decision being reviewed
- exact file or directory scope
- whether edits are allowed
- constraints from `AGENTS.md`, user instructions, and local policy
- expected output shape
- local verification that Codex will run after receiving the answer

For expensive-to-reverse decisions, ask Agy to critique assumptions and compare alternatives rather than asking for a generic approval.

## Failure Handling

- If `agy --version` or `agy --help` fails, report the missing CLI prerequisite.
- If print mode times out, increase `--print-timeout` only after narrowing the prompt and file scope.
- If output looks like it answered a flag instead of the task, rerun with all flags before `--print`.
- If authentication hangs, use interactive `agy` directly to complete Antigravity onboarding, then retry the one-shot call.
- If `agy` suggests changes, inspect and verify locally before adopting them.

## Verified Smoke Test

This command shape was verified locally:

```bash
agy --print-timeout 45s --print 'Reply with exactly: AGY_OK'
```

Expected output:

```text
AGY_OK
```
