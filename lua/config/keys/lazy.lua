local keymap = vim.keymap
local wk = require("which-key")

-- Unmap old Lazy keys (in case these are imported by LazyVim/themes/plugins)
keymap.del("n", "<leader>l")
keymap.del("n", "<leader>L")

-- Assign new Lazy keys to avoid conflicts with laravel.nvim plugin keymaps.
wk.add({
  {
    mode = "n",
    "<leader>z",
    function()
      require("lazy").home()
    end,
    desc = "Lazy",
  },
  {
    mode = "n",
    "<leader>Z",
    function()
      LazyVim.news.changelog()
    end,
    desc = "LazyVim Changelog",
  },
})
