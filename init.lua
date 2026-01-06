-- Main entry point for Neovim configuration
-- This Neovim config is based on LazyVim (https://github.com/LazyVim/LazyVim)
-- LazyVim documentation: https://www.lazyvim.org/
-- Sets up package management and loads the main configuration

-- Enable the loader for improved performance
if vim.loader then
  vim.loader.enable()
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
