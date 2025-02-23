local wk = require("which-key")

wk.add({
  {
    mode = "n",
    "<leader>p",
    function()
      Snacks.picker({
        layout = {
          preset = "select",
          preview = false,
        },
      })
    end,
    desc = "Pickers (Snacks)",
  },
})
