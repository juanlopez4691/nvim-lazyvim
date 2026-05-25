# 💤 LazyVim

A Neovim configuration based on
[LazyVim](https://github.com/LazyVim/LazyVim), tailored for PHP, Laravel,
and web development.

In Catalonia, we have a proverb: "Qui no té feina, el gat pentina",
which translates to "Those who have no work, brush the cat". This
means that when someone is idle or has nothing to do, they may engage
in trivial or unnecessary tasks, similar to the idea of "idle hands
are the devil's workshop."

I guess sometimes Neovim is like my cat to brush.

Refer to the [LazyVim documentation](https://lazyvim.github.io/installation)
to learn how to start brushing your own feline.

## Prerequisites

- **Neovim** >= 0.12
- **Nerd Font** (e.g.
  [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads))
- **External tools**: `git`, `fzf`, `ripgrep`, `fd`, `lazygit`, `stylua`

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/joanlopez/nvim-lazyvim.git ~/.config/nvim

# Launch Neovim — LazyVim will install plugins automatically
nvim
```

## Language Support

| Language | LSP | Formatter | Linter |
| ---------- | ----- | ----------- | -------- |
| PHP | Intelephense | Pint, PHPCBF | PHPStan, PHPCS |
| Blade | blade-nav | blade-formatter | — |
| Twig | Twiggy LSP | — | — |
| JavaScript/TypeScript | vtsls | Prettierd | ESLint |
| Lua | LuaLS | Stylua | — |
| Tailwind CSS | Tailwind LSP | — | — |
| Docker | Docker LSP | — | — |
| JSON | JSON LSP | — | — |
| Markdown | Marksman | — | markdownlint |
| TOML | Taplo | — | — |

## Keymap Namespaces

| Prefix | Purpose |
| -------- | --------- |
| `<leader>a` | AI assistants |
| `<leader>c` | Code (lint, symbols) |
| `<leader>d` | Debug (DAP) |
| `<leader>f` | Find / Pickers |
| `<leader>g` | Git |
| `<leader>l` | Laravel |
| `<leader>o` | OpenCode (AI chat) |
| `<leader>r` | Replace |
| `<leader>s` | Search & replace (scooter) |
| `<leader>t` | Terminal |
| `<leader>y` | Yank / Paste |
| `<leader>z` | Lazy (plugin manager) |

## Project Structure

```text
lua/
├── config/
│   ├── autocmds/      # Autocommands by category
│   ├── intelephense/  # PHP LSP stubs
│   ├── keys/          # Keymaps by category
│   ├── autocmds.lua   # Autocommand entry point
│   ├── filetypes.lua  # Filetype detection
│   ├── keymaps.lua    # Keymap entry point
│   ├── lazy.lua       # LazyVim bootstrap
│   └── options.lua    # Vim options
├── helpers/           # Shared utilities
└── plugins/           # Plugin specs
```

## Contributing

See [AGENTS.md](AGENTS.md) for detailed conventions, formatting rules, and
agent-specific guidelines. Project-local skills are available under
`.agents/skills/`.

## Useful Commands

| Command | Description |
| --------- | ------------- |
| `:checkhealth` | Run Neovim health checks |
| `:ConformInfo` | Inspect formatter resolution |
| `:Lint` | Run linter on current buffer |
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/tool installer |
| `:source %` | Reload current config file |
