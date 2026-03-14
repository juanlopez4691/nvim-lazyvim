return {
  {
    "lionyxml/gitlineage.nvim",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("gitlineage").setup({})
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>gv",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Toggle Diffview window",
      },
    },
    opts = {},
  },
}
