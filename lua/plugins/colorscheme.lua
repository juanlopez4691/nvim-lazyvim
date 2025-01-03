return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    style = "night",
    dim_inactive = true,
    lualine_bold = true,
    on_highlights = function(hl, colors)
      hl.WinSeparator = { fg = "#4b6f9e", bg = colors.bg_dark }
      hl.CopilotSuggestion = { fg = "#4b6f9e", bg = colors.bg_dark }
    end,
  },
}
