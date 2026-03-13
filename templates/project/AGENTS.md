# Project Template Instructions

## Purpose
This folder is copied into new projects by `install/project-bootstrap.sh`. It carries the Codex config and a starter `.agents/skills` README so you can extend the toolkit per project.

## After bootstrapping
1. Inspect `.codex/config.toml` and adjust paths or metadata as needed for the project.
2. Add project-specific skills under `.agents/skills/`, using `README.md` as a guide.
3. Start with the bundled `triager`, `builder`, `debater`, `moderator`, `researcher`, and `reviewer` roles. Use `trend_researcher` and `keyword_curator` when the project needs business ideation support from recent market signals.
4. Use `.codex/context/ACTIVE_TASK.md` as the default handoff artifact whenever the work is too large for a single local turn.
5. For structured decisions, keep the debate transcript in `.codex/context/DEBATE_LOG.md` and move only the synthesized decision back into `ACTIVE_TASK.md`.
6. Commit the copied files so each project documents its Codex entry point.
