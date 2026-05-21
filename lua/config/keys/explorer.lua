local wk = require("which-key")

-- Explorer Snacks (root dir)
wk.add({
  {
    mode = "n",
    "\\\\",
    function()
      Snacks.explorer({ cwd = LazyVim.root() })
    end,
    desc = "Explorer Snacks (root dir)",
  },
})
