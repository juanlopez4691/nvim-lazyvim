return {
  "adalessa/laravel.nvim",
  dependencies = {
    { "tpope/vim-dotenv", lazy = true },
    { "nvim-telescope/telescope.nvim", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "kevinhwang91/promise-async", lazy = true },
  },
  cmd = { "Laravel" },
  event = { "BufRead", "BufNewFile" },
  ft = { "php" },
  config = true,
  opts = {
    lsp_server = vim.g.lazyvim_php_lsp,
    features = {
      route_info = {
        enable = true,
        view = "top",
      },
      model_info = {
        enable = true,
      },
      override = {
        enable = true,
      },
      pickers = {
        enable = true,
        provider = "telescope",
      },
    },
  },
}
