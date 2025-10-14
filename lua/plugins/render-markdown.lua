return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
    -- lazy = false,
    opts = {
      preview = {
        enable = true,
        enable_hybrid_mode = true,
        icon_provider = "mini",
        filetypes = { "Avante", "markdown", "md", "rmd", "quarto" },
        ignore_buftypes = {},
      },
    },
    config = function(_, opts)
      local markview = require("markview")
      local presets = require("markview.presets")

      markview.setup(vim.tbl_deep_extend("force", opts or {}, {
        markdown = {
          headings = presets.marker,
          tables = presets.simple,
          horizonal_rules = presets.thin,
        },
      }))
    end,
  },
}
