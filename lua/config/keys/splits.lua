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
local list = require("helpers.list")
local skip_filetypes = {
  "neo-tree",
  "snacks_dashboard",
  "noice",
  "TelescopePrompt",
  "lazy",
}

keymap.set("n", "<A-right>", function()
  if list.contains_value(skip_filetypes, vim.bo.filetype) then
    return
  end
  split.resize("right")
end, { silent = true })

keymap.set("n", "<A-left>", function()
  if list.contains_value(skip_filetypes, vim.bo.filetype) then
    return
  end
  split.resize("left")
end, { silent = true })

keymap.set("n", "<A-down>", function()
  if list.contains_value(skip_filetypes, vim.bo.filetype) then
    return
  end
  split.resize("down")
end, { silent = true })

keymap.set("n", "<A-up>", function()
  if list.contains_value(skip_filetypes, vim.bo.filetype) then
    return
  end
  split.resize("up")
end, { silent = true })
