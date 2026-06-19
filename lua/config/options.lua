-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use default clipboard for yank/paste
vim.opt.clipboard = ""

-- Set the backup directory, create it if it doesn't exist
local backup_dir = vim.fn.expand("~/.nvim/backupdir")
---@cast backup_dir string

if vim.fn.isdirectory(backup_dir) == 0 then
  local ok = vim.fn.mkdir(backup_dir, "p")
  if ok == -1 then
    vim.notify("Failed to create backup directory: " .. backup_dir, vim.log.levels.WARN)
  end
end

vim.opt.backupdir = backup_dir
vim.opt.backup = true

vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  extends = "…",
}

vim.g.root_spec = {
  "lsp", -- use LSP workspace folders first
  { "composer.json", ".git" }, -- PHP projects
  { "package.json", ".git" }, -- JS/TS projects
  ".git", -- fallback to git root
  "cwd", -- finally current working dir
}

-- intelephense as PHP LSP
vim.g.lazyvim_php_lsp = "intelephense"

-- Enable LSP code lens
vim.lsp.codelens.enable(true)

-- Disable PERL provider
vim.g.loaded_perl_provider = 0

-- Enable AI virtual text
vim.g.ai_cmp = false

-- Disable native diagnostic virtual text in favor of tiny-inline-diagnostic
vim.diagnostic.config({ virtual_text = false })

vim.g.colorscheme = "catppuccin-mocha"
