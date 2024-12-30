return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    style = "night",
    on_highlights = function(hl)
      hl.WinSeparator = { fg = "#4b6f9e" }
    end,
  },
}
