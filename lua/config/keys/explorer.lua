local wk = require("which-key")

-- Force code linting
wk.add({
  {
    mode = "n",
    "\\",
    function()
      Snacks.explorer({ cwd = LazyVim.root() })
    end,
    desc = "Explorer Snacks (root dir)",
  },
})
