local wk = require("which-key")

-- Force code linting
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
