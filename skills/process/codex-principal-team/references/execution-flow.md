# Execution Flow

## 1. Intake

- Restate the user goal and success criteria.
- Classify risk: routine, important, or expensive-to-reverse.
- Decide which roles are needed now and which can wait.
- Fetch `origin/main` before repo work, without changing the working tree.

## 2. Exploration

- Inspect AGENTS, README, existing skills, scripts, docs, git status, and Yeoul when prior decisions may matter.
- Use `rg` and targeted reads before asking questions.
- Capture facts, sources, open questions, and repeated signals.

## 3. Generalization

Classify repeated activity into one of four buckets:

- Skill: repeated workflow with judgment.
- Small-model subagent: bounded repeated judgment task.
- Code/script: deterministic repeated work.
- Keep manual: rare, ambiguous, or not yet stable.

## 4. Decision Review

- Task Spec Architect writes the smallest implementation-safe spec.
- Use Oracle Critic through the `oracle` skill for architecture, API, migration, security, data-loss, or hard-to-reverse choices.
- Treat Oracle output as advisory; verify claims locally before adopting them.

## 5. Implementation

- Assign narrow file ownership.
- Prefer new focused artifacts over broad refactors.
- Use `apply_patch` for manual edits.
- Keep skill bodies lean and move details to references or scripts.
- Route skill and script edits through `builder` when delegating.

## 6. Verification

- Run the lowest-cost command that proves the changed behavior.
- For skills, validate frontmatter, trigger clarity, referenced files, and bundled scripts.
- For scripts, run at least one sample fixture.
- For docs-only work, check links, file paths, and consistency with README.

## 7. Optimization Loop

Record:

- Activities handled by large models.
- Activities handled by small models.
- Activities handled by skills.
- Activities handled by deterministic code.
- Activities still manual.

For each manual or large-model activity, decide whether the next version should become a skill, small-model subagent, script, or remain manual.

Use `cost_analyst` for this pass when the task was substantial.
