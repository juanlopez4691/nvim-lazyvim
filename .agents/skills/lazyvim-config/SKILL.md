---
name: lazyvim-config
description: >
  LazyVim Neovim configuration conventions. Use when editing Lua files,
  plugin specs, keymaps, or options in this LazyVim-based Neovim config.
  Enforces commit rules, Lua/Stylua formatting, and unbreakable constraints.
  For full details, manual CLI commands, and extended explanations, see
  AGENTS.md in the repository root.
---

## Triggers

Load this skill when:
- Creating or editing files under `lua/`
- Modifying `stylua.toml`, `.luarc.json`, or plugin specs
- The user says "commit", "format", "lint", or "reload" in the context of
  this Neovim config

## Commit Rules

- One logical change per commit. Never mix unrelated topics.
- Conventional Commits: `type: subject`. No scopes. No issue references.
- No commit body unless the "why" is non-obvious.
- A subject reading "do X and Y" → split into (at least) two commits.

### Examples

- ❌ `docs: fix markdownlint in README and AGENTS`
  → Two unrelated files; split.
- ❌ `feat: add linter and update keymaps`
  → "and" signals two changes; split.
- ✅ `docs: fix markdownlint errors in README`
  → Single topic.
- ✅ `docs: fix markdownlint line-length`
  → Single topic, no body needed.

## Formatting

- Run `stylua .` before any Lua change.
- Lua: 2-space indent, max width 120.
- Prefer project-local binaries (`vendor/bin/...`) for PHP.

## Linting

- Uses `mfussenegger/nvim-lint` (see `lua/plugins/nvim-lint.lua`).
- PHP: dynamic selection per project (see AGENTS.md for full rules).

## Unbreakable Constraints

- Do NOT manually `require` autoloaded config files (`config/options.lua`,
  `config/keymaps.lua`, `config/autocmds.lua`, or files under `config/keys/`
  and `config/autocmds/`).
- Do NOT introduce new globals.
- Do not bundle unrelated changes into a single commit just because the user
  mentioned them together.

## Code Structure

- Plugin specs live in `lua/plugins/*.lua` and return a spec table. Extend with
  `vim.tbl_deep_extend("force", ...)` rather than rewriting.
- Local helpers live in `lua/helpers/` and are imported via
  `require("helpers.<module>")`.
- Keep modules light on side effects; initialize in setup functions where
  possible, not at require time.

## Quick Workflows

### Reload config
- `:source %` (current buffer) or restart Neovim.
- Headless sanity: `nvim --headless +qa`
- After reload, check `:messages` and `:checkhealth`

### Add a plugin
1. Create `lua/plugins/<name>.lua` returning a Lazy plugin spec table.
2. Use `vim.tbl_deep_extend("force", ...)` to extend existing specs.
3. Run `stylua .` before committing.

### Format buffer
```lua
require("conform").format({ async = false, lsp_fallback = true })
```

### Run linter
```
:Lint
```

## Naming Conventions

- Locals/fields: `snake_case`.
- Functions: `verb_noun`.
- Globals: only `vim`, `LazyVim`, `Snacks` (see `.luarc.json`).
- Files: lowercase with hyphens/underscores where appropriate.
