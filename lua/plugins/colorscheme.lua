return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = vim.g.colorscheme,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      highlight_overrides = {
        all = function(colors)
          local u = require("catppuccin.utils.colors")

          return {
            CursorLine = { bg = u.lighten(colors.mantle, 0.40, colors.base) },
            WinSeparator = { fg = "#809dc2" },
            CopilotSuggestion = { fg = "#809dc2" },
            SnacksIndentScope = { fg = "#5e5e87" },
            Normal = { bg = colors.crust },
            NormalNC = { bg = colors.mantle },
            WinBar = { fg = colors.text, bg = "NONE" },
            WinBarNC = { fg = colors.text, bg = colors.base },
            WinBarContent = { fg = colors.text, bg = "#405e86" },
            WinBarContentNC = { fg = "#809dc2", bg = colors.base },
            AvanteSidebarWinSeparator = { fg = "#809dc2" },
            DiffAdd = { bg = "#006400" },
            DiffChange = { bg = "#184e77" },
            DiffDelete = { bg = "#a4161a" },
            DiffText = { bg = "#003566" },
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
