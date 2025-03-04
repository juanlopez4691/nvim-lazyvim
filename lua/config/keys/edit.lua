local keymap = vim.keymap
local wk = require("which-key")

-- Move cursor while in insert mode (naughty boy!)
-- Should not start a new undo sequence
keymap.set("i", "<A-h>", "<C-G>U<Left>")
keymap.set("i", "<A-l>", "<C-G>U<Right>")

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
