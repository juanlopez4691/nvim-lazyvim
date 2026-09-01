local keymap = vim.keymap
local split = require("helpers.split")

-- Remove original keymaps
pcall(keymap.del, "n", "<C-h>")
pcall(keymap.del, "n", "<C-l>")
pcall(keymap.del, "n", "<C-j>")
pcall(keymap.del, "n", "<C-k>")

-- Navigate splits
keymap.set("n", "<C-h>", split.jump_split_with_wrap("h", "l"), { desc = "Jump to split left" })
keymap.set("n", "<C-l>", split.jump_split_with_wrap("l", "h"), { desc = "Jump to split right" })
keymap.set("n", "<C-j>", split.jump_split_with_wrap("j", "k"), { desc = "Jump to split down" })
keymap.set("n", "<C-k>", split.jump_split_with_wrap("k", "j"), { desc = "Jump to split up" })

-- Remove original keymaps
pcall(keymap.del, "n", "<C-Up>")
pcall(keymap.del, "n", "<C-Down>")
pcall(keymap.del, "n", "<C-Left>")
pcall(keymap.del, "n", "<C-Right>")

-- Resize window splits
local skip_filetypes = {
  "lazy",
  "neo-tree",
  "noice",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_picker_list",
  "snacks_picker_preview",
  "TelescopePrompt",
}

for direction, keys in pairs({
  right = { "<A-right>", "<C-A-l>" },
  left = { "<A-left>", "<C-A-h>" },
  down = { "<A-down>", "<C-A-j>" },
  up = { "<A-up>", "<C-A-k>" },
}) do
  for _, key in ipairs(keys) do
    keymap.set("n", key, function()
      if vim.tbl_contains(skip_filetypes, vim.bo.filetype) then
        return
      end
      split.resize(direction)
    end, { silent = true })
  end
end
