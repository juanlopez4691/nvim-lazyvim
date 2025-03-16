-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use default clipboard for yank/paste
vim.opt.clipboard = ""

-- intelephense as PHP LSP
vim.g.lazyvim_php_lsp = "intelephense"

if vim.fn.executable("pyenv") == 1 then
  local pyenv_python = vim.fn.trim(vim.fn.system("pyenv which python"))
  if vim.v.shell_error == 0 and vim.fn.filereadable(pyenv_python) == 1 then
    vim.g.python3_host_prog = pyenv_python
  else
    vim.g.python3_host_prog = "/opt/homebrew/opt/python@3.13/bin/python3"
  end
else
  vim.g.python3_host_prog = "/opt/homebrew/opt/python@3.13/bin/python3"
end

-- Disable PERL provider
vim.g.loaded_perl_provider = 0

-- Set the backup directory, create it if it doesn't exist
local backup_dir = vim.fn.expand("~/.nvim/backupdir")

if vim.fn.isdirectory(backup_dir) == 0 then
  vim.fn.mkdir(backup_dir, "p")
end

vim.opt.backupdir = backup_dir
vim.opt.backup = true

vim.g.root_spec = {
  "lsp",
  { ".git", "composer.json" },
  { ".git", "package.json" },
  { ".git", "lua" },
  ".git",
  "cwd",
}

-- Enable AI virtual text
vim.g.ai_cmp = false

vim.g.colorscheme = "catppuccin"
