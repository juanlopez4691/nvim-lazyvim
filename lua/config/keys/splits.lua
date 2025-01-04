local keymap = vim.keymap
local split = require("helpers.split")

-- Remove original keymaps
keymap.del("n", "<C-h>")
keymap.del("n", "<C-l>")
keymap.del("n", "<C-j>")
keymap.del("n", "<C-k>")

-- Navigate splits
keymap.set("n", "<C-h>", split.jump_split_with_wrap("h", "l"), { desc = "Jump to split left" })
keymap.set("n", "<C-l>", split.jump_split_with_wrap("l", "h"), { desc = "Jump to split left" })
keymap.set("n", "<C-j>", split.jump_split_with_wrap("j", "k"), { desc = "Jump to split left" })
keymap.set("n", "<C-k>", split.jump_split_with_wrap("k", "j"), { desc = "Jump to split left" })

-- Remove original keymaps
keymap.del("n", "<C-Up>")
keymap.del("n", "<C-Down>")
keymap.del("n", "<C-Left>")
keymap.del("n", "<C-Right>")

-- Resize window splits
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
