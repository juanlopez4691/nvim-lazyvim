---
name: lazyvim-linter
description: >
  LazyVim configuration linting conventions. Use when linting files in this
  LazyVim-based Neovim config repository. Covers LSP diagnostics. For full
  details see AGENTS.md in the repository root.
---

# LazyVim Linting Conventions (This Repo)

## LSP Diagnostics

For this repo, linting/diagnostics are provided by LSP servers:

- **Lua**: `lua_ls`
- **JSON**: `jsonls`

Markdown navigation is handled by `marksman` (links, references), but no
markdown linter is configured.

Run `:checkhealth` to verify LSP status. Check `:messages` after reloading
for diagnostic errors.

## nvim-lint

`:Lint` is available but has no effect on the file types in this repo.
