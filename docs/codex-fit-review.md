# Codex Fit Review

This note records the overlap, overdesign, and contradiction cleanup applied while adapting the reference material to a Codex-native toolkit.

## Inventory summary

- External references inventoried: 241 entries
- Skills: 95
- Agents: 146
- Sources:
  - `workflows`: 95 entries
  - `superpowers`: 15 entries
  - `awesome-claude-code-subagents`: 131 entries

## Consolidation decisions

- Installed process skills stay intentionally small: `mrchypark-brainstorm`, `mrchypark-debate`, `mrchypark-orchestrate`, `mrchypark-plan`, `mrchypark-delegate`, `mrchypark-review-request`, `mrchypark-verify`.
- Installed domain skills stay task-specific: `disk-clean-audit`, `oracle`, `pocketbase-go`.
- Installed agent roles stay narrow and purpose-built: `triager`, `builder`, `debater`, `moderator`, `researcher`, `reviewer`.
- Everything else remains reference-only until a repeated Codex-native need is proven.

## Overlap removed

- Design and planning flow had heavy duplication across `brainstorming`, `writing-plans`, `dev-design`, `dev-clarify`, and spec-review helpers. The installed toolkit now keeps only one lightweight clarification skill and one executable planning skill.
- Delegation patterns overlapped across `dispatching-parallel-agents`, `subagent-driven-development`, `dev-delegate`, and multiple orchestration agents. The installed toolkit keeps one delegation skill plus one coordinator role.
- Verification and review guidance overlapped across `verification-before-completion`, `requesting-code-review`, `dev-review`, `audit-verify`, and multiple reviewer agents. The installed toolkit now separates `mrchypark-verify` for evidence gathering from `mrchypark-review-request` for packaging and asking for scrutiny.
- `code-reviewer` appears in all three external sources. That duplication was treated as evidence that a single reviewer role is enough for the default install.

## Overdesign removed

- Mandatory spec writing and spec-review loops before any implementation were removed from the default process flow. Specs and plans are now optional durable artifacts for long or handoff-heavy work.
- The reference agent catalogs contain many specialist personas. Installing them all would create routing noise, maintenance overhead, and role ambiguity. The default toolkit now ships only three general roles.
- Provider-specific variants were removed entirely. The toolkit keeps only Codex-facing instructions and config surfaces.
- Model-pinned Oracle examples were removed so the skill does not ossify around one external model choice.

## Contradictions resolved

- The earlier `mrchypark-brainstorm` wording blocked implementation until a spec file and a review loop were completed. That contradicted Codex's default execution-oriented workflow, so it now asks only for the minimum clarification needed.
- The earlier all-read-only agent set pushed implementation back into the parent session. Adding `builder` resolves that gap and makes handoff-first execution real instead of rhetorical.
- `triager` and `researcher` were too close semantically. `triager` is now explicitly responsible for routing and ownership, while `researcher` is limited to evidence gathering and source-backed findings.
- `mrchypark-review-request` and `mrchypark-verify` previously blurred together. They now have separate contracts: verify first, then package the delta and open questions for review.
- Handoffs used to depend on ad-hoc prompt summaries. `.codex/context/ACTIVE_TASK.md` is now the shared context fragment for non-trivial delegated work.
- Structured disagreement is now explicit instead of leaking into ad-hoc review prompts. `mrchypark-debate` grounds a question first, runs perspective-specific debate passes, and asks `moderator` for synthesis.

## Patterns kept from the references

- Keep process and domain guidance separate.
- Delegate only independent work.
- Keep reviewer output findings-first.
- Treat external-model critique as advisory and verify it locally.

## Patterns explicitly rejected

- Installing a public mega-catalog of specialist agents by default.
- Carrying provider-specific prompt variants for the same skill.
- Turning every non-trivial task into a mandatory multi-document ceremony.
