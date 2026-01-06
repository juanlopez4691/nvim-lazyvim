# AGENTS.md: Guidelines for Agentic Work in This LazyVim Configuration

## Purpose

Practical, repo-specific guidance for agents contributing to
this [LazyVim](https://github.com/LazyVim/LazyVim) based Neovim configuration.
Covers reload, format/lint, "single tests," and local code
style and structure conventions.

## Scope and Precedence

- Scope: Entire repository unless a deeper AGENTS.md overrides it.
- Precedence: Deeper files > this file; direct user/system instructions > all.
- Intent: Clarify how to work here without duplicating LazyVim docs.

## Build, Reload, and Health

- Build: No manual build; Neovim loads config automatically.
- Apply changes: `:source %` (current buffer) or restart Neovim.
- Health checks:
  - `:checkhealth` (LSP/formatters/linters diagnostics)
  - `:messages` after reload to catch warnings/errors
- Headless quick load (sanity): `nvim --headless +qa` (does not cover
  lazy-loaded paths).

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
- Manual CLI single-file checks:
  - PHPStan: `vendor/bin/phpstan analyse <file|dir>`
  - PHPCS: `vendor/bin/phpcs <file>` (or `phpcs`)
  - Pint: `vendor/bin/pint <file>`
  - JavaScript: `npx prettier --check <file>`
  - Python: `isort --check-only <file>`; `black --check <file>`
  - Blade: `npx blade-formatter --check <file>`

## Tests and Single-Test Guidance

- No formal automated tests in this repo. Validation is interactive:
  - `:source %` or restart; confirm no errors in `:messages` and
    `:checkhealth`.
  - Run a linter or formatter in check mode against a single file.
- For PHP projects using this config: prefer project-local binaries
  (`vendor/bin/...`) to match CI behavior.

## Code Structure and Imports

- Do not manually `require` LazyVim autoloaded files under `lua/config/`:
  - `config/options.lua`, `config/keymaps.lua`, `config/autocmds.lua`
  - Files under `config/keys/` and `config/autocmds/`
- Plugin specs live in `lua/plugins/*.lua` and return a spec table. Extend with
  `vim.tbl_deep_extend("force", ...)` rather than rewriting.
- Local helpers/utilities live in `lua/helpers/` and are imported via
  `require("helpers.<module>")`.
- Keep modules light on side effects; initialize in setup functions where
  possible, not at require time.

## Formatting Rules (Project-wide)

- Indentation: 2 spaces; max width: 120.
- Keep tables and function signatures readable; break long lines.
- No trailing whitespace; ensure a final newline.

## Types and Documentation

- Use EmmyLua annotations on public functions and module APIs:

  ```lua
  --- Brief description
  ---@param path string
  ---@return boolean
  local function file_exists(path) ... end
  ```

- Prefer module-level doc comments for helpers and plugin specs to explain
  intent, assumptions, and notable side effects.

## Naming Conventions

- Locals/fields: `snake_case`.
- Modules/plugins: follow upstream names (for example, `Snacks`) or
  `snake_case`.
- Files: lowercase with hyphens/underscores where appropriate.
- Functions: verb_noun (for example, `parse_diagnostics_from_phpcs`).
- Globals: only `vim`, `LazyVim`, `Snacks` (see `.luarc.json`).

## Error Handling and Logging

- Wrap risky calls with `pcall` or guard checks (for example, binaries).
- Fail fast on hard misconfigurations; fallback gracefully for optional tools.
- Notify via `vim.notify` or `vim.notify_once` with levels from `vim.log.levels`.
- Use `vim.schedule` for notifications from callbacks or async contexts.
- Prefer Neovim diagnostics and `vim.notify` over printing to stdout/stderr.

## Plugin and Config Patterns

- Autocmds: `vim.api.nvim_create_autocmd` in `lua/config/autocmds.lua` or
  `lua/config/autocmds/`; keep idempotent and lightweight.
- Keymaps: `vim.keymap.set` in `lua/config/keymaps.lua` or `lua/config/keys/`.
- Options: configure in `lua/config/options.lua` and let LazyVim autoload.
- LSP servers (see `lua/plugins/nvim-lspconfig.lua`):
  - `lua_ls` (LuaJIT; globals include `vim`, `LazyVim`)
  - `antlersls` (Antlers/HTML)
  - `intelephense` (PHP/Blade; stubs via `config/intelephense/stubs.lua`)
- Treesitter and Mason: `lua/plugins/treesitter.lua`, `lua/plugins/mason.lua`.
- Conform (formatting): event `BufWritePre`; see `:ConformInfo` for resolution.
- nvim-lint (linting): dynamic PHP rules above; use `:Lint`.

## Repo Notes and File Map

- Stylua: `stylua.toml` (2-space indent, width 120).
- Lua LS globals: `.luarc.json` (`vim`, `LazyVim`, `Snacks`).
- PHP linting logic: `lua/plugins/nvim-lint.lua`.
- Formatting adapters: `lua/plugins/conform.lua`.
- LSP setup: `lua/plugins/nvim-lspconfig.lua`.
- Helpers reference: `lua/helpers/filesystem.lua`.

## Cursor and Copilot Rules

- No Cursor rules found: `.cursor/rules/`, `.cursorrules` not present.
- No Copilot instructions found: `.github/copilot-instructions.md` not present.
- If added later, summarize constraints here and link to their locations.

## Do and Do Not (Quick Reference)

- Do: run `stylua .` before submitting changes.
- Do: prefer project-local binaries (`vendor/bin/...`) for PHP.
- Do: use Neovim APIs (`vim.*`) instead of shelling out when possible.
- Do not: manually require autoloaded config files.
- Do not: introduce new globals; keep modules explicit.

## Useful Commands (Cheat Sheet)

- Format Lua: `stylua .`
- PHP style (one file): `vendor/bin/pint <file>` or `vendor/bin/phpcbf <file>`
- PHP lint (one file): `vendor/bin/phpcs <file>` or `phpcs <file>`
- PHP static analysis: `vendor/bin/phpstan analyse <file|dir>`
- JavaScript check: `npx prettier --check <file>`
- Python check: `isort --check-only <file>`; `black --check <file>`
- Blade check: `npx blade-formatter --check <file>`
- In Neovim: `:source %`, `:checkhealth`, `:ConformInfo`, `:Lint`, `:messages`

## Resources

- [LazyVim docs](https://lazyvim.github.io/)
- [LazyVim configuration](https://lazyvim.github.io/configuration)
- [LazyVim repo](https://github.com/LazyVim/LazyVim)
- [Starter template](https://github.com/LazyVim/starter)

Maintain readability, minimal side effects, and clear notifications. Favor
extensibility and upstream-consistent patterns across all contributions.
