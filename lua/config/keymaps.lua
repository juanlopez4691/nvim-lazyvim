-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove original keymaps
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- Resize window splits
local split = require("helpers.split")

vim.keymap.set("n", "<A-right>", function()
  split.resize("right")
end, { silent = true })

vim.keymap.set("n", "<A-left>", function()
  split.resize("left")
end, { silent = true })

vim.keymap.set("n", "<A-down>", function()
  split.resize("down")
end, { silent = true })

vim.keymap.set("n", "<A-up>", function()
  split.resize("up")
end, { silent = true })
