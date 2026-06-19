---
name: commit
description: >
  LazyVim configuration commit conventions. Use when committing changes in
  this LazyVim-based Neovim config. Covers Conventional Commits style specific
  to this repository. For full details see AGENTS.md in the repository root.
---

# LazyVim Commit Conventions

## Scope

This skill covers **commits and branching only** — commit message style and
branch workflow. It does NOT cover code patterns (see `/code`),
formatting (see `/format`), or linting (see `/lint`).

Follow [Conventional Commits](https://www.conventionalcommits.org/):
`type: subject`. This skill mirrors the key rules from AGENTS.md for quick
reference — see AGENTS.md for full context and examples.

Key rules:

- Explain WHY, not WHAT or HOW.
- No scope or context suffix.
- No body unless necessary.
- One logical change per commit. Never bundle unrelated changes.
- `docs:` type for `.md` file changes.
- No `Co-Authored-By` trailers.

## Commit Command

Always use a plain string literal:

```bash
git commit -m "type: subject"
```

Never use heredocs or `$(...)` subshell expansion for the message — in this
environment delta/highlight processes subshell output and embeds ANSI escape
codes into the stored commit message.

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

See AGENTS.md for commit message examples.
