return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  event = { "VeryLazy" },
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
