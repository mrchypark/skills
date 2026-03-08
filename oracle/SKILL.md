---
name: oracle
description: Use when you need a second-model opinion via the @steipete/oracle CLI for high-risk debugging, non-trivial refactors, architecture or API tradeoff reviews, or decisions that are expensive to reverse. Do not use for routine edits, small bug fixes, or tasks that can be validated quickly in the local codebase.
---

# Oracle (CLI) — best use

Oracle bundles your prompt + selected files into one “one-shot” request so another model can answer with real repo context (API or browser automation). Treat outputs as advisory: verify against the codebase + tests.

## Decision support rule

Use Oracle as an optional second opinion for meaningful technical or product decisions when:

- the decision has lasting architecture or API impact
- there are multiple viable options with non-obvious tradeoffs
- the change is expensive to reverse
- local tests and code reading alone are unlikely to surface the main risks

Do not treat Oracle as a mandatory approval gate. Use it to challenge assumptions and expose blind spots, then verify the conclusions against the codebase, tests, and project constraints.

When you do use it for a decision review, at minimum:

- summarize the decision and constraints
- present the leading option and at least one alternative
- ask Oracle to critique the plan, identify risks, and challenge weak assumptions

## Main use case (browser, GPT-5.4 Pro)

Default workflow here: `--engine browser` with GPT-5.4 Pro in ChatGPT. This is the “human in the loop” path: it can take ~10 minutes to ~1 hour; expect a stored session you can reattach to.

Recommended defaults:

- Engine: browser (`--engine browser`)
- Model: GPT-5.4 Pro (`--model gpt-5.4-pro` or the current ChatGPT picker label if it differs)
- Attachments: directories/globs + excludes; avoid secrets.

## Golden path (fast + reliable)

1. Pick a tight file set (fewest files that still contain the truth).
2. Preview what you are about to send (`--dry-run` + `--files-report` when needed).
3. Run in browser mode for the usual GPT-5.4 Pro ChatGPT workflow; use API only when you explicitly want it.
4. If the run detaches or times out: reattach to the stored session instead of re-running.

## Avoid common misuse

Do not use Oracle for:

- routine code edits or small, local bug fixes
- questions that can be answered by running the tests or reading 1-2 files
- broad "review the whole repo" requests
- attaching generated artifacts, lockfiles, snapshots, logs, or vendored code unless they are directly relevant

Before any paid or long-running run:

1. narrow the file set
2. run `--dry-run`
3. inspect the file list and token-heavy files
4. confirm the question is specific enough to answer in one shot

## Commands (preferred)

- Show help (once/session):
  - `npx -y @steipete/oracle --help`

- Preview (no tokens):
  - `npx -y @steipete/oracle --dry-run summary -p "<task>" --file "src/**" --file "!**/*.test.*"`
  - `npx -y @steipete/oracle --dry-run full -p "<task>" --file "src/**"`

- Token/cost sanity:
  - `npx -y @steipete/oracle --dry-run summary --files-report -p "<task>" --file "src/**"`

- Browser run (main path; long-running is normal):
  - `npx -y @steipete/oracle --engine browser --model gpt-5.4-pro -p "<task>" --file "src/**"`

- Manual paste fallback (assemble bundle, copy to clipboard):
  - `npx -y @steipete/oracle --render --copy -p "<task>" --file "src/**"`
  - Use this only when browser automation is unavailable or unreliable, and after confirming the rendered bundle is scoped correctly.

## Attaching files (`--file`)

`--file` accepts files, directories, and globs. You can pass it multiple times; entries can be comma-separated.

- Include:
  - `--file "src/**"` (directory glob)
  - `--file src/index.ts` (literal file)
  - `--file docs --file README.md` (literal directory + file)

- Exclude (prefix with `!`):
  - `--file "src/**" --file "!src/**/*.test.ts" --file "!**/*.snap"`

- Defaults (important behavior from the implementation):
  - Default-ignored dirs: `node_modules`, `dist`, `coverage`, `.git`, `.turbo`, `.next`, `build`, `tmp` (skipped unless you explicitly pass them as literal dirs/files).
  - Honors `.gitignore` when expanding globs.
  - Does not follow symlinks (glob expansion uses `followSymbolicLinks: false`).
  - Dotfiles are filtered unless you explicitly opt in with a pattern that includes a dot-segment (for example `--file ".github/**"`).
  - Default cap: files larger than 1 MB are rejected unless you raise `ORACLE_MAX_FILE_SIZE_BYTES` or `maxFileSizeBytes` in `~/.oracle/config.json`.
- Attachment discipline:
  - Never assume `.gitignore` alone is a sufficient privacy or relevance filter.
  - Always inspect the dry-run output before sending.
  - Exclude low-signal files first: snapshots, coverage, build output, logs, generated files, and vendor copies unless they are central to the question.
  - If hidden config is important, include it explicitly and verify it was picked up.

## Budget + observability

- Treat ~196k tokens as a soft operating target, not a goal.
- Use `--files-report` (and/or `--dry-run json`) to spot the token hogs before spending.
- If the dry-run already looks large or the file report shows multiple token-heavy files, stop and reduce scope before running.
- Browser runs also have real cost: time, session management, and repeated manual attention. Prefer one well-scoped run over multiple broad retries.
- If you need hidden or advanced knobs: `npx -y @steipete/oracle --help --verbose`.

## Engines (API vs browser)

- Auto-pick: uses `api` when `OPENAI_API_KEY` is set, otherwise `browser`.
- In this repo, prefer setting `--engine browser` explicitly for the usual ChatGPT workflow. Do not rely on auto-pick if cost, provider, or session behavior matters.
- Browser engine supports GPT + Gemini only; use `--engine api` for Claude/Grok/Codex or multi-model runs.
- API runs require explicit user consent before starting because they incur usage costs.
- Browser attachments:
  - `--browser-attachments auto|never|always` (auto pastes inline up to ~60k chars then uploads).
- Remote browser host (signed-in machine runs automation):
  - Host: `oracle serve --host 0.0.0.0 --port 9473 --token <secret>`
  - Client: `oracle --engine browser --remote-host <host:port> --remote-token <secret> -p "<task>" --file "src/**"`

## Sessions + slugs (don't lose work)

- Stored under `~/.oracle/sessions` (override with `ORACLE_HOME_DIR`).
- Runs may detach or take a long time (browser + GPT-5.4 Pro often does). If the CLI times out: do not re-run; reattach.
  - List: `oracle status --hours 72`
  - Attach: `oracle session <id> --render`
- Use `--slug "<3-5 words>"` to keep session IDs readable.
- Duplicate prompt guard exists; use `--force` only when you truly want a fresh run.

## Prompt template (high signal)

Oracle starts with zero project knowledge. Assume the model cannot infer your stack, build tooling, conventions, or “obvious” paths. Include:

- Project briefing (stack + build/test commands + platform constraints).
- “Where things live” (key directories, entrypoints, config files, dependency boundaries).
- Exact question + what you tried + the error text (verbatim).
- Constraints (“don't change X”, “must keep public API”, “perf budget”, etc).
- Desired output (“return patch plan + tests”, “list risky assumptions”, “give 3 options with tradeoffs”).

### “Exhaustive prompt” pattern (for later restoration)

When you know this will be a long investigation, write a prompt that can stand alone later:

- Top: 6-30 sentence project briefing + current goal.
- Middle: concrete repro steps + exact errors + what you already tried.
- Bottom: attach all context files needed so a fresh model can fully understand (entrypoints, configs, key modules, docs).

If you need to reproduce the same context later, re-run with the same prompt + `--file ...` set (Oracle runs are one-shot; the model does not remember prior runs).

## Safety

- Do not attach secrets by default (`.env`, key files, auth tokens). Redact aggressively; share only what is required.
- Prefer “just enough context”: fewer files + better prompt beats whole-repo dumps.
