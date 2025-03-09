return {
  "folke/snacks.nvim",
  opts = {
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
