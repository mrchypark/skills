# Skills Monorepo Implementation Plan

> **For agents:** Execute this plan task-by-task and verify each step before moving on.

**Goal:** Turn this repository into a personal skills monorepo and import the PocketBase Go skill into `pocketbase-go/`.

**Architecture:** Keep the repository root as shared documentation and place each reusable skill in its own top-level folder. Preserve the upstream skill contents, but normalize `SKILL.md` metadata and references so the skill works cleanly from a subdirectory layout.

**Tech Stack:** Git, Markdown, shell utilities

---

### Task 1: Add repository planning docs

**Files:**
- Create: `docs/plans/2026-03-09-skills-monorepo-design.md`
- Create: `docs/plans/2026-03-09-skills-monorepo.md`

**Step 1: Write the design and implementation docs**

Create the two planning documents with the approved repository structure and rollout steps.

**Step 2: Verify the docs exist**

Run: `find docs/plans -maxdepth 1 -type f | sort`
Expected: both `2026-03-09-skills-monorepo-design.md` and `2026-03-09-skills-monorepo.md` are listed

**Step 3: Commit the planning docs**

Run:

```bash
git add docs/plans
git commit -m "docs: add skills monorepo plan"
```

Expected: a commit is created with the planning documents

### Task 2: Import PocketBase Go skill into monorepo

**Files:**
- Create: `pocketbase-go/SKILL.md`
- Create: `pocketbase-go/README.md`
- Create: `pocketbase-go/resources/Makefile`
- Create: `pocketbase-go/resources/pb_migrate_ops.py`
- Create: `pocketbase-go/resources/Dockerfile`

**Step 1: Copy upstream skill contents**

Copy the upstream repository files into the new `pocketbase-go/` directory.

**Step 2: Normalize the imported skill**

Adjust `pocketbase-go/SKILL.md` frontmatter and wording so it matches this repository's conventions and does not depend on a hardcoded root path.

**Step 3: Verify imported files**

Run: `find pocketbase-go -maxdepth 2 -type f | sort`
Expected: `SKILL.md`, `README.md`, and the three resource files are present

### Task 3: Add root repository documentation

**Files:**
- Create: `README.md`

**Step 1: Write root documentation**

Document the monorepo purpose, layout, and currently included skills.

**Step 2: Verify readability**

Run: `sed -n '1,200p' README.md`
Expected: clear repository overview with `pocketbase-go/` called out as the first skill

### Task 4: Validate, commit, and push

**Files:**
- Modify: `README.md`
- Modify: `pocketbase-go/SKILL.md`
- Modify: `pocketbase-go/README.md`

**Step 1: Inspect git state**

Run: `git status --short`
Expected: only intended new files are listed

**Step 2: Commit imported skill and docs**

Run:

```bash
git add README.md pocketbase-go
git commit -m "feat: add pocketbase go skill"
```

Expected: a commit is created with the monorepo structure and imported skill

**Step 3: Push to origin**

Run: `git push -u origin main`
Expected: `main` is updated on `mrchypark/skills`
