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
          return {
            WinSeparator = { fg = "#4b6f9e" },
            CopilotSuggestion = { fg = "#4b6f9e" },
            SnacksIndentScope = { fg = "#5e5e87" },
            Normal = { bg = colors.mantle },
            NormalNC = { bg = colors.base },
            WinBar = { fg = colors.text, bg = "NONE" },
            WinBarNC = { fg = colors.text, bg = colors.base },
            WinBarContent = { fg = colors.text, bg = "#405e86" },
            WinBarContentNC = { fg = colors.surface2, bg = colors.base },
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
