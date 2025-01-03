-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Buffers
keymap.del("n", "<leader>be")
keymap.set("n", "<leader>be", ":Neotree buffers toggle=true<cr>", { desc = "Buffer Explorer", silent = true })

local wk = require("which-key")
wk.add({
  -- Replace selected text
  { mode = "x", "<leader>r", [["_c]], desc = "Replace selection", icon = { icon = "" } },

  -- Replace ocurrences of selected text
  {
    mode = "v",
    "<leader>R",
    function()
      -- Yank the selected text into the 'v' register
      vim.cmd('normal! "vy')

      -- Get the contents of the 'v' register
      local selected_text = vim.fn.getreg("v")

      -- Check if selected text is empty
      if selected_text == "" then
        print("No text selected")
        return
      end

      -- Escape special characters for Vim's search
      local escaped_text = vim.fn.escape(selected_text, "/\\")

      -- Replace newlines with a special placeholder for substitution
      escaped_text = escaped_text:gsub("\n", "\\n")

      -- Prompt for replacement text
      local replacement_text = vim.fn.input("Replace with: ")

      -- Set up the search command
      local cmd = string.format("%%s/%s/%s/gc", escaped_text, vim.fn.escape(replacement_text, "/\\"))

      -- Provide information about confirmation options
      print("Options: [y]es, [n]o, [a]ll, [q]uit, [l]ast")

      -- Execute the command safely
      local success, err = pcall(function()
        vim.cmd(cmd)
      end)

      if not success then
        print("Error executing substitution: " .. err)
      end
    end,
    desc = "Replace occurrences of selection",
    icon = { icon = "", color = "yellow" },
  },
})

-- Terminal
-- Remove some original keymaps
keymap.del("n", "<leader>fT")
keymap.del("n", "<leader>ft")

wk.add({
  { mode = "n", "<leader>t", group = "Terminal" },
  {
    mode = "n",
    "<leader>tt",
    function()
      Snacks.terminal()
    end,
    desc = "Terminal (cwd)",
  },
  {
    mode = "n",
    "<leader>tT",
    function()
      Snacks.terminal(nil, { cwd = LazyVim.root() })
    end,
    desc = "Terminal (Root Dir)",
  },
})

-- Code linting
wk.add({
  {
    mode = "n",
    "<leader>cL",
    function()
      require("lint").try_lint()
    end,
    desc = "Lint code",
  },
})

-- AI keymaps
wk.add({
  { mode = "n", "<leader>a", group = "ai" },
})
