return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      highlight_overrides = {
        all = function()
          return {
            WinSeparator = { fg = "#4b6f9e" },
            CopilotSuggestion = { fg = "#4b6f9e" },
            SnacksIndentScope = { fg = "#5e5e87" },
          }
        end,
      },
    },
  },
  {
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
  },
}
