-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Remove original keymaps
keymap.del("n", "<C-Up>")
keymap.del("n", "<C-Down>")
keymap.del("n", "<C-Left>")
keymap.del("n", "<C-Right>")

-- Resize window splits
local split = require("helpers.split")

keymap.set("n", "<A-right>", function()
  split.resize("right")
end, { silent = true })

keymap.set("n", "<A-left>", function()
  split.resize("left")
end, { silent = true })

keymap.set("n", "<A-down>", function()
  split.resize("down")
end, { silent = true })

keymap.set("n", "<A-up>", function()
  split.resize("up")
end, { silent = true })

-- Buffers
keymap.del("n", "<leader>be")
keymap.set("n", "<leader>be", ":Neotree buffers toggle=true<cr>", { desc = "Buffer Explorer", silent = true })
