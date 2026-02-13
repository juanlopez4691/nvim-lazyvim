local snacks_helper = require("helpers.snacks")
local keymap = vim.keymap
local wk = require("which-key")

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
  {
    mode = "n",
    "<leader>tv",
    function()
      snacks_helper.close_snacks_explorer()
      Snacks.terminal(nil, { win = { style = "vertical_terminal" } })
    end,
    desc = "Terminal (vertical, cwd)",
  },
  {
    mode = "n",
    "<leader>tV",
    function()
      snacks_helper.close_snacks_explorer()
      Snacks.terminal(nil, { cwd = LazyVim.root(), win = { style = "vertical_terminal" } })
    end,
    desc = "Terminal (vertical, root)",
  },
})
