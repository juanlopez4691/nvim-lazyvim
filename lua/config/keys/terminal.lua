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
})
