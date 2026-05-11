# Codex Fit Review

This note records the overlap, overdesign, and contradiction cleanup applied while adapting the reference material to a Codex-native toolkit.

## Inventory summary

- External references inventoried: generated from the active reference sources
- Skills: generated from the active reference sources
- Agents: generated from the active reference sources
- Sources:
  - `workflows`: 95 entries
  - `awesome-claude-code-subagents`: 131 entries

## Consolidation decisions

- Installed process skills stay intentionally small and avoid project-prefix process variants.
- Installed domain skills stay task-specific and repo-portable: `disk-clean-audit`, `pocketbase-go`, and other machine-neutral domain skills.
- Installed agent roles stay narrow and purpose-built: `triager`, `builder`, `debater`, `moderator`, `researcher`, `reviewer`.
- Everything else remains reference-only until a repeated Codex-native need is proven.

## Overlap removed

- Design and planning flow had heavy duplication across `brainstorming`, `writing-plans`, `dev-design`, `dev-clarify`, and spec-review helpers. The installed toolkit now keeps only one lightweight clarification skill and one executable planning skill.
- Delegation patterns overlapped across `dispatching-parallel-agents`, `subagent-driven-development`, `dev-delegate`, and multiple orchestration agents. The installed toolkit keeps one delegation skill plus one coordinator role.
- Verification and review guidance overlapped across multiple reference skills and reviewer agents. The installed toolkit keeps review packaging under the remaining review skills and requires fresh verification evidence.
- `code-reviewer` appears in all three external sources. That duplication was treated as evidence that a single reviewer role is enough for the default install.

## Overdesign removed

- Mandatory spec writing and spec-review loops before any implementation were removed from the default process flow. Specs and plans are now optional durable artifacts for long or handoff-heavy work.
- The reference agent catalogs contain many specialist personas. Installing them all would create routing noise, maintenance overhead, and role ambiguity. The default toolkit now ships only three general roles.
- Provider-specific variants were removed entirely. The toolkit keeps only Codex-facing instructions and config surfaces.
- Oracle stays repo-managed only with an explicit `oracle >= 0.11.1` binary requirement, because its browser-tab, harvest/live-tail, Deep Research, Project Sources, and multi-turn browser workflows depend on the newer CLI surface.

## Contradictions resolved

- The earlier prefixed brainstorming wording blocked implementation until a spec file and a review loop were completed. That contradicted Codex's default execution-oriented workflow, so the prefixed process layer was removed.
- The earlier all-read-only agent set pushed implementation back into the parent session. Adding `builder` resolves that gap and makes handoff-first execution real instead of rhetorical.
- `triager` and `researcher` were too close semantically. `triager` is now explicitly responsible for routing and ownership, while `researcher` is limited to evidence gathering and source-backed findings.
- Review-request and verification guidance previously blurred together. They now remain separated through fresh verification evidence and the review skills that are still installed.
- Handoffs used to depend on ad-hoc prompt summaries. `.codex/context/ACTIVE_TASK.md` is now the shared context fragment for non-trivial delegated work.
- Structured disagreement is now explicit instead of leaking into ad-hoc review prompts. Debate-style work should use the bundled debate/moderator agent roles rather than a prefixed process skill.

## Patterns kept from the references

- Keep process and domain guidance separate.
- Delegate only independent work.
- Keep reviewer output findings-first.
- Treat external-model critique as advisory and verify it locally.

## Patterns explicitly rejected

- Installing a public mega-catalog of specialist agents by default.
- Carrying provider-specific prompt variants for the same skill.
- Turning every non-trivial task into a mandatory multi-document ceremony.
