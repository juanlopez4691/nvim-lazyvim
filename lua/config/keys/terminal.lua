local snacks_helper = require("helpers.snacks")
local keymap = vim.keymap
local wk = require("which-key")

-- Remove some original keymaps
pcall(keymap.del, "n", "<leader>fT")
pcall(keymap.del, "n", "<leader>ft")

wk.add({
  { mode = "n", "<leader>t", group = "Terminal" },
  {
    mode = "n",
    "<leader>tt",
    function()
      if Snacks then
        Snacks.terminal()
      end
    end,
    desc = "Terminal (cwd)",
  },
  {
    mode = "n",
    "<leader>tT",
    function()
      if Snacks and LazyVim then
        Snacks.terminal(nil, { cwd = LazyVim.root() })
      end
    end,
    desc = "Terminal (Root Dir)",
  },
  {
    mode = "n",
    "<leader>tv",
    function()
      snacks_helper.close_snacks_explorer()
      if Snacks then
        Snacks.terminal(nil, { win = { style = "vertical_terminal" } })
      end
    end,
    desc = "Terminal (vertical, cwd)",
  },
  {
    mode = "n",
    "<leader>tV",
    function()
      snacks_helper.close_snacks_explorer()
      if Snacks and LazyVim then
        Snacks.terminal(nil, { cwd = LazyVim.root(), win = { style = "vertical_terminal" } })
      end
    end,
    desc = "Terminal (vertical, root)",
  },
})
