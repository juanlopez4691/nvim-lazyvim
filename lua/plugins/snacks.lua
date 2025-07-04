return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      -- formatters = {
      --   file = {
      --     filename_first = true,
      --   },
      -- },
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
    styles = {
      zen = {
        width = math.max(140, vim.api.nvim_win_get_width(0) * 0.7),
        backdrop = { transparent = true, blend = 25 },
      },
    },
    scroll = {
      animate = {
        easing = "inQuad",
      },
    },
    zen = {
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = true,
        diagnostics = true,
        inlay_hints = true,
      },
    },
    terminal = {
      win = {
        wo = {
          winbar = "",
        },
      },
    },
    lazygit = {
      win = {
        width = 0,
        heigth = 0,
      },
      config = {
        os = {
          edit = '[ -z ""$NVIM"" ] && (nvim -- {{filename}}) || (nvim --server ""$NVIM"" --remote-send ""q"" && nvim --server ""$NVIM"" --remote {{filename}})',
        },
      },
    },
    statuscolumn = {
      folds = {
        open = true,
        git_hl = true,
      },
    },
  },
}
