# Skills Monorepo Design

## Goal

Convert this repository into a personal skills monorepo where each skill lives in its own top-level directory. Seed the repository with the existing PocketBase Go skill under `pocketbase-go/`.

## Repository Shape

- Keep the repository root for shared documentation only.
- Store each skill in a flat top-level directory such as `pocketbase-go/`.
- Keep skill-local assets next to the skill in `resources/` and reference them with relative paths from `SKILL.md`.

## First Imported Skill

The first imported skill is the existing `pocketbase-go-skill` repository. Its current contents map directly into:

- `pocketbase-go/SKILL.md`
- `pocketbase-go/README.md`
- `pocketbase-go/resources/`

## Skill Authoring Adjustments

- Normalize `SKILL.md` frontmatter to the conventions used in this workspace.
- Remove repository-specific installation assumptions from the skill body where possible.
- Prefer instructions that refer to files relative to the skill directory, so the skill remains portable whether it is copied from this monorepo or installed elsewhere.

## Root Documentation

Add a root `README.md` that explains:

- this repository is the personal home for `mrchypark` skills
- each skill is contained in its own directory
- the current available skill list starts with `pocketbase-go`

## Rollout

1. Add design and implementation plan documents.
2. Import the upstream PocketBase Go skill into `pocketbase-go/`.
3. Update documentation for monorepo layout and portable installation guidance.
4. Review the resulting tree, commit, and push to `origin/main`.
