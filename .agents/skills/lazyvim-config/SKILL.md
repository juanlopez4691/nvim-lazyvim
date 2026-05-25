---
name: lazyvim-config
description: >
  LazyVim Neovim configuration conventions. Use when editing Lua files,
  plugin specs, keymaps, or options in this LazyVim-based Neovim config.
  For full details see AGENTS.md in the repository root.
---

# LazyVim Config Conventions

## Hard Constraints (NEVER violate)

- Don't `require` autoloaded config files: `config/options.lua`,
  `config/keymaps.lua`, `config/autocmds.lua`, or anything under
  `config/keys/`, `config/autocmds/`.
- Don't create new globals. Existing: `vim`, `LazyVim`, `Snacks`, `Laravel`
  (see `.luarc.json`).
- Don't bundle unrelated changes in a single commit.

## Before Committing Lua

Run `stylua .`. Lua uses 2-space indent, column width 120 (see `stylua.toml`).

## Commits

`type: subject`. No scopes. No body unless "why" isn't obvious. One logical
change per commit. Split anything that reads "X and Y". See AGENTS.md.

## Code Patterns

- Plugin specs: `lua/plugins/<name>.lua`, extend with
  `vim.tbl_deep_extend("force", ...)`.
- Helpers: `lua/helpers/`, require as `require("helpers.<module>")`.
- Init in setup functions, not at require time.

## Verify

```text
:source %      # Reload current file
:messages      # Check for errors
:checkhealth   # LSP/linter diagnostics
```

Format: `:ConformInfo` or:

```lua
require("conform").format({ async = false, lsp_fallback = true })
```

Lint: `:Lint`

## Naming

Locals/fields: `snake_case`. Functions: `verb_noun`. Files: lowercase, hyphens.
