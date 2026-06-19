---
name: lazyvim-linter
description: >
  LazyVim configuration linting conventions. Use when linting files in this
  LazyVim-based Neovim config repository. Covers LSP diagnostics. For full
  details see AGENTS.md in the repository root.
---

# LazyVim Linting Conventions (This Repo)

## Scope

This skill covers **linting/diagnostics only** — checking for errors via LSP.
It does NOT cover formatting (see `lazyvim-formatter`) or code changes (see
`lazyvim-coder`). Do NOT run `stylua` unless explicitly asked.

## LSP Diagnostics

For this repo, linting/diagnostics are provided by LSP servers:

- **Lua**: `lua_ls`
- **JSON**: `jsonls`

Markdown navigation is handled by `marksman` (links, references), but no
markdown linter is configured.

Run `:checkhealth` to verify LSP status. Check `:messages` after reloading
for diagnostic errors.

## nvim-lint

No linters beyond LSP are configured for this repo's file types — `:Lint` is a
no-op here.
