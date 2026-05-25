---
name: lazyvim-config
description: >
  LazyVim Neovim configuration conventions. Use when editing Lua files,
  plugin specs, keymaps, or options in this LazyVim-based Neovim config.
  Enforces commit rules, Lua/Stylua formatting, and unbreakable constraints.
---

## Commit Conventions

- Follow [Conventional Commits](https://www.conventionalcommits.org/):
  `type: subject`.
- No scope or context suffix (e.g., no `(fixes #123)` or issue references)
  appended to the subject.
- No commit body unless absolutely necessary to explain the "why."
- One logical change per commit. Never mix unrelated topics. A commit subject
  that reads "do X and Y" must be split into (at least) two commits.

### Examples

- ❌ `docs: fix markdownlint in README and AGENTS`
  → Two unrelated files; split into two commits.
- ✅ `docs: fix markdownlint errors in README`
  → Single topic, self-contained.
- ✅ `docs: fix markdownlint line-length`
  → Single topic, no body needed.
- ❌ `feat: add linter and update keymaps`
  → "and" signals two changes; must be split.

## Formatting

- Lua via Stylua (see `stylua.toml`): 2-space indent, width 120.
  - Format all Lua: `stylua .`
- Other languages via Conform (`stevearc/conform.nvim`):
  - PHP: `pint`, `phpcbf`, `php-cs-fixer` (stop after first available)
  - JavaScript: `prettierd`, `prettier`
  - Python: `isort`, `black`
  - Blade: `blade-formatter`
- In Neovim, format buffer:

  ```lua
  require("conform").format({ async = false, lsp_fallback = true })
  ```

- Inspect formatter setup: `:ConformInfo`.

## Linting

- Uses `mfussenegger/nvim-lint` (see `lua/plugins/nvim-lint.lua`). Triggers on
  `BufWritePost`, `BufReadPost`, `InsertLeave`. Run on demand: `:Lint`.
- PHP dynamic selection (per project):
  - If `phpstan.neon` (or `.dist` variants) exists -> enable `phpstan`.
  - If `vendor/bin/pint` exists -> skip `phpcs`.
  - Else -> enable `phpcs`.
- PHPCS resolution: prefers `./vendor/bin/phpcs`, falls back to `phpcs` in PATH.

## Unbreakable Constraints

- Do NOT manually `require` autoloaded config files (`config/options.lua`,
  `config/keymaps.lua`, `config/autocmds.lua`, or files under `config/keys/`
  and `config/autocmds/`).
- Do NOT introduce new globals.
- Do not: bundle unrelated changes into a single commit just because the user
  mentioned them together.

## Code Structure

- Do not manually `require` LazyVim autoloaded files under `lua/config/`:
  - `config/options.lua`, `config/keymaps.lua`, `config/autocmds.lua`
  - Files under `config/keys/` and `config/autocmds/`
- Plugin specs live in `lua/plugins/*.lua` and return a spec table. Extend with
  `vim.tbl_deep_extend("force", ...)` rather than rewriting.
- Local helpers/utilities live in `lua/helpers/` and are imported via
  `require("helpers.<module>")`.
- Keep modules light on side effects; initialize in setup functions where
  possible, not at require time.

## Project File Map

- `stylua.toml` — 2-space indent, width 120
- `.luarc.json` — Lua LS globals (`vim`, `LazyVim`, `Snacks`, `Laravel`)
- `lua/plugins/nvim-lint.lua` — PHP linting logic
- `lua/plugins/conform.lua` — Formatting adapters
- `lua/plugins/nvim-lspconfig.lua` — LSP setup
- `lua/helpers/filesystem.lua` — Shared utilities

## Common Workflows

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
- Modules/plugins: follow upstream names (for example, `Snacks`) or
  `snake_case`.
- Files: lowercase with hyphens/underscores where appropriate.
- Functions: verb_noun (for example, `parse_diagnostics_from_phpcs`).
- Globals: only `vim`, `LazyVim`, `Snacks` (see `.luarc.json`).

## Error Handling

- Wrap risky calls with `pcall` or guard checks (for example, binaries).
- Fail fast on hard misconfigurations; fallback gracefully for optional tools.
- Notify via `vim.notify` or `vim.notify_once` with levels from
  `vim.log.levels`.
- Use `vim.schedule` for notifications from callbacks or async contexts.
