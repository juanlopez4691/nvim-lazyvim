---
name: lazyvim-commiter
description: >
  LazyVim configuration commit conventions. Use when committing changes in
  this LazyVim-based Neovim config. Covers Conventional Commits style specific
  to this repository. For full details see AGENTS.md in the repository root.
---

# LazyVim Commit Conventions

## Scope

This skill covers **commits and branching only** — commit message style and
branch workflow. It does NOT cover code patterns (see `lazyvim-coder`),
formatting (see `lazyvim-formatter`), or linting (see `lazyvim-linter`).

Follow [Conventional Commits](https://www.conventionalcommits.org/):
`type: subject`.

- No scope or context suffix (e.g., no `(fixes #123)` or issue references)
  appended to the subject.
- No commit body unless absolutely necessary to explain the "why." Prefer a
  self-contained subject that makes the body redundant.
- One logical change per commit. Never mix unrelated topics. A commit subject
  that reads "do X and Y" must be split into (at least) two commits.
- Changes to `.md` files (README, AGENTS.md, skills) must use `docs:` type.

## Branching

For non-trivial or risky changes, create a dedicated branch:

```bash
git checkout -b <type>/<brief-description>
```

Examples: `feat/remove-avante`, `fix/keymap-typo`, `docs/update-readme`.

Keep branches focused on a single logical change. Merge via PR or fast-forward
after review and validation.

## Git History

Maintain a **linear history**. Avoid merge commits.

- Rebase feature branches onto `main` before merging:

  ```bash
  git checkout feat/my-branch
  git rebase main
  git checkout main
  git merge --ff-only feat/my-branch
  ```

- Never use `git merge --no-ff`.
- Never merge `main` into a feature branch; always rebase.

## Examples

- ❌ `docs: fix markdownlint in README and AGENTS`
  → Two unrelated files; split into two commits.
- ✅ `docs: fix markdownlint errors in README`
  → Single topic, self-contained.
- ✅ `docs: fix markdownlint line-length`
  → Single topic, no body needed.
- ❌ `feat: add linter and update keymaps`
  → "and" signals two changes; must be split.
