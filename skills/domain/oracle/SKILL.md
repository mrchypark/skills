---
name: oracle
description: Use when an important technical or product decision needs an external critique through the Oracle CLI before you finalize the direction.
---

# Oracle

## Overview

Use the installed `oracle` CLI as a second-opinion path for decisions that are expensive to reverse. In this environment, use browser mode with the dedicated Oracle Chrome profile on port `55268` and Node 24 first in `PATH`; this is the verified stable path. Oracle output is advisory. Verify it against the codebase, local tests, and project constraints before adopting it.

## Use Oracle When

- architecture or API choices have lasting impact
- there are multiple viable approaches with unclear tradeoffs
- a migration or refactor is expensive to undo
- local reading and tests are unlikely to surface the main risks
- you want a second model to challenge assumptions before locking direction

## Do Not Use Oracle When

- the task is a routine edit or a small local bug
- the answer is available from a few files or local verification
- you are tempted to send a broad whole-repo review

## Workflow

1. Narrow the file set to the smallest useful scope.
2. Ensure every Oracle request has both a concrete prompt and at least one scoped `--file` attachment. Oracle cannot see the project without files.
3. Run `--dry-run summary --files-report` first and inspect the attached files.
4. State the current proposal, constraints, and at least one alternative.
5. Ask Oracle to critique assumptions, identify risks, and call out missing considerations.
6. Select the mode and effort explicitly before running.
7. Run browser mode with `--browser-port 55268`.
8. Reattach to detached browser sessions instead of re-running them.
9. Summarize the critique in your own words and decide what to verify locally before changing direction.

Prefix Oracle commands with the verified Node runtime unless the default `node` already reports Node 24:

```bash
PATH="/opt/homebrew/opt/node@24/bin:$PATH" oracle ...
```

## Mode Selection

- New browser consult: use this for the first Oracle review of a question. Start with dry-run, then run browser mode on port `55268`.
- Browser follow-up in the same conversation: use repeated `--browser-follow-up "<prompt>"` when the follow-up prompts are already known before the run.
- Existing ChatGPT tab continuation: run `oracle status --browser-tabs`, choose the current tab, target id, URL, or title substring, then pass `--browser-tab <ref>`.
- Detached or timed-out session recovery: run `oracle status --hours 72`, then `oracle session <id> --render`; use `oracle session <id> --harvest` or `--live` when the session is browser-bound and still producing output.
- API follow-up: only after explicit API-cost approval, continue a stored Responses run with `--followup <sessionId|responseId>` and use `--followup-model <model>` when the session has multiple model outputs.

## Effort Selection

- Honor the user's requested model or effort when provided. Pass it with `--model "<label>"`, using Oracle-supported model ids or ChatGPT labels such as `"5.5 Pro"` or `"5.2 Thinking"`.
- If the user asks to keep the active ChatGPT model, use `--browser-model-strategy current`; if they want Oracle to choose the requested model, use the default `select` strategy.
- If the user does not specify effort, default to `gpt-5.5-pro` in browser mode for high-impact decisions.
- Do not silently force `gpt-5.5-pro` when the user explicitly requested another supported effort/model.

## Failure Avoidance

- Do not start a real Oracle run until the dry-run succeeds with the intended prompt and file list.
- Do not treat dry-run as proof that browser execution works. After upgrading Oracle or changing the skill, run a real browser smoke test with `gpt-5.5-pro` and `--wait`.
- If `oracle --version` does not report the expected installed CLI or `--browser-port 55268` is unavailable, stop and report the missing prerequisite instead of retrying with a random port.
- If the real run fails with Node networking errors such as `setTypeOfService EINVAL`, ensure Node 24 is installed and rerun with `PATH="/opt/homebrew/opt/node@24/bin:$PATH"`.
- If browser login/profile state blocks the run, report the exact blocker and use only an approved fallback such as `--browser-attach-running`, `--remote-chrome`, or API mode.
- If a run is already active or a matching session exists, reattach or reuse the tab instead of starting a duplicate. Use `--force` only when intentionally starting a separate run.
- For long browser runs, keep `--heartbeat` enabled and prefer reattach/harvest/live-tail after timeouts over rerunning the prompt.

## Verified Commands

Dry run:

```bash
oracle --engine browser --browser-port 55268 \
  --dry-run summary --files-report \
  -p "<prompt>" \
  --file "path/**" --file "!**/*.test.*"
```

Run with Pro:

```bash
PATH="/opt/homebrew/opt/node@24/bin:$PATH" oracle \
  --engine browser --browser-port 55268 \
  --model "gpt-5.5-pro" \
  --slug "<3-5-words>" \
  -p "<prompt>" \
  --file "path/**" --file "!**/*.test.*"
```

Real execution smoke test after CLI or skill changes:

```bash
PATH="/opt/homebrew/opt/node@24/bin:$PATH" oracle \
  --engine browser --browser-port 55268 \
  --model "gpt-5.5-pro" \
  --browser-model-strategy select \
  --browser-archive never \
  --wait --write-output /tmp/oracle-real-smoke.txt \
  --slug "<real-smoke-slug>" \
  -p "<short verification prompt that requires reading the attached file>" \
  --file "path/**"
```

Real browser follow-up smoke test:

```bash
PATH="/opt/homebrew/opt/node@24/bin:$PATH" oracle \
  --engine browser --browser-port 55268 \
  --model "gpt-5.5-pro" \
  --browser-model-strategy select \
  --browser-archive never \
  --wait --write-output /tmp/oracle-followup-smoke.txt \
  --slug "<followup-smoke-slug>" \
  -p "<initial prompt>" \
  --browser-follow-up "<follow-up prompt that depends on the first turn>" \
  --file "path/**"
```

Reattach:

```bash
oracle status --hours 72
oracle session <id> --render
oracle session <id> --harvest
oracle session <id> --live
```

Inspect or reuse live ChatGPT tabs:

```bash
oracle status --browser-tabs
oracle --engine browser --browser-port 55268 --browser-tab current \
  -p "<follow-up prompt>" \
  --file "path/**"
```

Multi-turn browser consult:

```bash
oracle --engine browser --browser-port 55268 \
  -p "<initial prompt>" \
  --browser-follow-up "<second turn>" \
  --browser-follow-up "<third turn>" \
  --file "path/**"
```

API follow-up after explicit cost approval:

```bash
oracle --engine api \
  --followup "<sessionId-or-responseId>" \
  --followup-model "<model-if-needed>" \
  -p "<follow-up prompt>" \
  --file "path/**"
```

Deep Research browser run:

```bash
oracle --engine browser --browser-port 55268 \
  --browser-research deep \
  -p "<research prompt>" \
  --file "path/**"
```

Project Sources:

```bash
oracle project-sources list
oracle project-sources add --file "path/**"
```

## Current Environment

- `oracle` is installed at `/opt/homebrew/bin/oracle`.
- Installed version: `0.11.1`.
- Use Node `24.15.0` from `/opt/homebrew/opt/node@24/bin/node` for real browser runs. The default `/opt/homebrew/bin/node` may point to Node 25 and fail browser execution with `setTypeOfService EINVAL`.
- The default model is `gpt-5.5-pro` in browser mode unless the user requests another supported effort/model.
- The dedicated Oracle Chrome profile is `/Users/cypark/.oracle/browser-profile`.
- The current reliable DevTools port is `55268`; omitting it can fail with `ECONNREFUSED` against a random local port.
- Do not use API mode unless the user explicitly approves possible usage costs.

## Version 0.11 Features

- ChatGPT Project Sources management is available through `oracle project-sources list|add`; use it when Developer Mode workflows need explicit shared project context.
- Browser consults can use repeated `--browser-follow-up` turns in one ChatGPT conversation. Only send caller-provided follow-up prompts.
- `oracle status --browser-tabs`, browser harvest/live-tail commands, and `--browser-tab <ref>` can inspect or reuse existing ChatGPT tabs.
- `--browser-research deep` supports ChatGPT Deep Research with progress monitoring and reattach recovery.
- Browser sessions save durable local artifacts such as transcripts, Deep Research reports, and downloadable ChatGPT image files.
- `--browser-archive` can archive successful one-shot browser conversations after artifacts are saved; temporary chats are not archived.
- `--browser-attach-running` can attach to an already-running signed-in local Chrome via remote debugging.
- Shared manual-login profiles coordinate concurrent browser runs with tab leases and `--browser-max-concurrent-tabs`.
- Browser runs emit heartbeat status while waiting for ChatGPT responses.
- Version `0.11.1` fixes renamed GPT-5.5 Pro/Thinking model-label detection, requested thinking-time handling, temporary-chat Pro selection, and MCP `consult` argument validation.

## Guardrails

- Remove low-signal files before sending generated output, logs, or secrets.
- Treat dry-run output as mandatory.
- If a browser run detaches or times out, reattach with `oracle status`/`oracle session`; do not re-run the same prompt.
- Do not use Oracle as a substitute for local verification.
- Do not use Oracle for routine edits, style bikeshedding, or a generic stamp of approval.
