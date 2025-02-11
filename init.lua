-- Enable the loader for improved performance
if vim.loader then
  vim.loader.enable()
end

vim.cmd("syntax off")
vim.defer_fn(function()
  vim.cmd("syntax on")
end, 50)

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
