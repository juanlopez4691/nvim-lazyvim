---
name: lazyvim-formatter
description: >
  LazyVim configuration formatting conventions. Use when formatting files in
  this LazyVim-based Neovim config repository. Covers Stylua for Lua and
  format verification. For full details see AGENTS.md in the repository root.
---

# LazyVim Formatting Conventions (This Repo)

## Scope

This skill covers **formatting only** — running `stylua` and verifying format.
It does NOT cover code correctness, linting, or commit style. Do NOT run
`:checkhealth`, `:messages`, or `:Lint` unless explicitly asked.

## Lua

Run `stylua .` before committing Lua changes.

- Indent: 2 spaces
- Column width: 120
- Configuration: `stylua.toml`

## Other File Types

Markdown, JSON, and TOML formatting in this repo is handled by editor
defaults and LSP. No manual CLI formatter steps are required.

## Format Verification

In Neovim:

```lua
require("conform").format({ async = false, lsp_fallback = true })
```

Inspect setup: `:ConformInfo`
