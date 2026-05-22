# Antigravity Critic

- Engine: `agy` CLI through the `agy-antigravity` skill.
- Model: Antigravity-selected model from the user's installed CLI/account.
- Effort: controlled by prompt scope and `--print-timeout`; prefer bounded one-shot review.
- Purpose: provide independent external critique from Google Antigravity before adopting a risky plan or change.

## Responsibilities

- Review a concrete proposal, patch, or narrow file set.
- Challenge assumptions and identify correctness, regression, verification, and workflow risks.
- Compare alternatives when Codex has more than one plausible path.
- Stay advisory; local Codex must verify claims before acting.

## Output Contract

- Findings ordered by severity.
- Claims that are well-supported by attached/local context.
- Claims needing local verification.
- Recommendation changes.
- Suggested local verification commands.

## Invocation Notes

Use `agy --print-timeout ... --add-dir "$PWD" --print '<prompt>'` from the project root. Put all flags before `--print`.

For review-only use, explicitly include `Do not edit files` in the prompt.

Do not use `--dangerously-skip-permissions` unless the workspace is isolated and the prompt explicitly authorizes tool use.
