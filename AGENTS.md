# AGENTS.md: Guidelines for Agentic Work in This LazyVim Configuration

## Purpose

Practical, repo-specific guidance for agents and human contributors working on
this [LazyVim](https://github.com/LazyVim/LazyVim) based Neovim configuration.
Covers reload, format/lint, validation, and local code
style and structure conventions.

## For AI Agents

This file is the comprehensive reference. Critical rules are also available as
invokable skills under `.agents/skills/`:
`/code`, `/format`, `/lint`, `/commit`.
Agents should prefer the specific skill when available; fall back to this file.

## Scope and Precedence

- Scope: Entire repository unless a deeper AGENTS.md overrides it.
- Precedence:
  1. Deeper AGENTS.md files
  2. This file
  3. Direct user instructions that express **intent or preference**
     (e.g., "use tabs instead of spaces")
- Note: routine commands ("commit this", "fix that") do NOT constitute intent
  overrides. Apply commit conventions, formatting, and code style automatically.
  Do not bundle unrelated changes because the user mentioned them together.
- Intent: Clarify how to work here without duplicating LazyVim docs.

## Build, Reload, and Health

- Build: No manual build; Neovim loads config automatically.
- Apply changes: `:source %` (current buffer) or restart Neovim.
- Health checks:
  - `:checkhealth` (LSP/formatters/linters diagnostics)
  - `:messages` after reload to catch warnings/errors
- Headless quick load (sanity): `nvim --headless +qa` (does not cover
  lazy-loaded paths).

## Commit Conventions

Follow [Conventional Commits](https://www.conventionalcommits.org/):
`type: subject`.

- Commit subjects should explain WHY the change is made — what problem it
  solves or what feature it adds. Do NOT explain WHAT or HOW; the code already
  does that.
- No scope or context suffix (e.g., no `(fixes #123)` or issue references)
  appended to the subject.
- No commit body unless absolutely necessary to explain the "why." Prefer a
  self-contained subject that makes the body redundant.
- One logical change per commit. Never mix unrelated topics. A commit subject
  that reads "do X and Y" must be split into (at least) two commits.
- Changes to `.md` files (README, AGENTS.md, skills) must use `docs:` type.

### Commit Command

Always use a plain string literal — no heredocs or subshell expansion:

```bash
git commit -m "type: subject"
```

Heredocs and `$(...)` in this environment cause delta/highlight to embed ANSI
codes into the stored commit message. No `Co-Authored-By` trailers.

### Examples

- ❌ `docs: fix markdownlint in README and AGENTS`
  → Two unrelated files; split into two commits.
- ✅ `docs: fix markdownlint errors in README`
  → Single topic, self-contained.
- ✅ `docs: fix markdownlint line-length`
  → Single topic, no body needed.
- ❌ `feat: add linter and update keymaps`
  → "and" signals two changes; must be split.

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

## Formatting

This repository contains **Lua, Markdown, JSON, and TOML** files.

- **Lua** via Stylua (see `stylua.toml`): 2-space indent, width 120.
  - Format all Lua: `stylua .`
- **Markdown, JSON, TOML**: handled by LSP and editor defaults. No manual CLI
  formatter steps required.
- In Neovim, format buffer:

  ```lua
  require("conform").format({ async = false, lsp_fallback = true })
  ```

- Inspect formatter setup: `:ConformInfo`.

### Formatting Rules (Project-wide)

- Indentation: 2 spaces; max width: 120. (Enforced by `stylua.toml`.)
- Keep tables and function signatures readable; break long lines.
- No trailing whitespace; ensure a final newline.

## Linting

- Uses `mfussenegger/nvim-lint` (see `lua/plugins/nvim-lint.lua`). Triggers on
  `BufWritePost`, `BufReadPost`, `InsertLeave`. Run on demand: `:Lint`.
- For this repository, linting/diagnostics are provided by LSP servers for Lua
  and JSON. Markdown navigation is handled by `marksman` (links, references),
  but no markdown linter is configured.

## Validation

- No formal automated tests in this repo. Validation is interactive:
  - `:source %` or restart; confirm no errors in `:messages` and
    `:checkhealth`.
  - Run a linter or formatter in check mode against a single file.

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
- Functions: verb_noun (for example, `file_exists`).
- Globals: only `vim`, `LazyVim`, `Snacks`, `Laravel` (see `.luarc.json`).

## Error Handling and Logging

- Wrap risky calls with `pcall` or guard checks (for example, binaries).
- Fail fast on hard misconfigurations; fallback gracefully for optional tools.
- Notify via `vim.notify` or `vim.notify_once` with levels from
  `vim.log.levels`.
- Use `vim.schedule` for notifications from callbacks or async contexts.
- Prefer Neovim diagnostics and `vim.notify` over printing to stdout/stderr.

## Plugin and Config Patterns

- Autocmds: `vim.api.nvim_create_autocmd` in `lua/config/autocmds.lua` or
  `lua/config/autocmds/`; keep idempotent and lightweight.
- Keymaps: `vim.keymap.set` in `lua/config/keymaps.lua` or `lua/config/keys/`.
- Options: configure in `lua/config/options.lua` and let LazyVim autoload.
- LSP servers (see `lua/plugins/nvim-lspconfig.lua`):
  - `lua_ls` (LuaJIT; globals include `vim`, `LazyVim`)
  - `jsonls` (JSON)
  - `marksman` (Markdown navigation)
- Treesitter and Mason: `lua/plugins/treesitter.lua`, `lua/plugins/mason.lua`.
- Conform (formatting): event `BufWritePre`; see `:ConformInfo` for resolution.
- nvim-lint (linting): see `lua/plugins/nvim-lint.lua`; use `:Lint`.

## Repo Notes and File Map

- Stylua: `stylua.toml` (2-space indent, width 120).
- Lua LS globals: `.luarc.json` (`vim`, `LazyVim`, `Snacks`, `Laravel`).
- Linting config: `lua/plugins/nvim-lint.lua`.
- Formatting config: `lua/plugins/conform.lua`.
- LSP setup: `lua/plugins/nvim-lspconfig.lua`.
- Helpers reference: `lua/helpers/` (filesystem, keymap, list, snacks, split).
- Project skills: `.agents/skills/code`, `.agents/skills/format`,
  `.agents/skills/lint`, `.agents/skills/commit`.

## Do and Do Not

- Do: run `stylua .` before submitting changes.
- Do: use Neovim APIs (`vim.*`) instead of shelling out when possible.
- Do not: manually require autoloaded config files.
- Do not: introduce new globals; keep modules explicit.

## Useful Commands (Cheat Sheet)

- Format Lua: `stylua .`
- In Neovim: `:source %`, `:checkhealth`, `:ConformInfo`, `:Lint`, `:messages`

## Resources

- [LazyVim docs](https://lazyvim.github.io/)
- [LazyVim configuration](https://lazyvim.github.io/configuration)
- [LazyVim repo](https://github.com/LazyVim/LazyVim)
- [Starter template](https://github.com/LazyVim/starter)

Maintain readability, minimal side effects, and clear notifications. Favor
extensibility and upstream-consistent patterns across all contributions.
