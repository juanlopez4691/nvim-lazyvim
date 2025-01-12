return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    cmd = "Telescope file_browser",
    keys = {
      { "<leader>fx", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
    },
  },
  {
    "nvim-telescope/telescope-project.nvim",
    lazy = true,
    cmd = "Telescope project",
    keys = {
      {
        "<leader>fp",
        function()
          local telescope = require("telescope")
          local telescope_custom = require("helpers.telescope")
          local custom_theme = telescope_custom.get_dropdown_custom(0.7, 0.5)

          telescope.extensions.project.project(vim.tbl_deep_extend("force", custom_theme, {
            display_type = "full",
          }))
        end,
        desc = "Find project",
      },
    },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    cmd = "Telescope live_grep_args",
    keys = {
      { "<leader>/", "<cmd>Telescope live_grep_args<cr>", desc = "Grep (Root Dir)" },
      { "<leader>sg", "<cmd>Telescope live_grep_args<cr>", desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep_args", { root = false }), desc = "Grep (cwd)" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = {
      defaults = {
        layout_config = {
          width = 0.95,
          height = 0.95,
        },
        mappings = {
          i = {
            ["<C-j>"] = function(bufnr)
              require("telescope.actions").move_selection_next(bufnr)
            end,
            ["<C-k>"] = function(bufnr)
              require("telescope.actions").move_selection_previous(bufnr)
            end,
            ["<C-h>"] = function(bufnr)
              require("telescope.actions").preview_scrolling_left(bufnr)
            end,
            ["<C-l>"] = function(bufnr)
              require("telescope.actions").preview_scrolling_right(bufnr)
            end,
            ["<C-p>"] = function(bufnr)
              require("telescope-live-grep-args.actions").quote_prompt()(bufnr)
            end,
            ["<C-g>"] = function(bufnr)
              require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " })(bufnr)
            end,
            ["<C-f>"] = function(bufnr)
              require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t " })(bufnr)
            end,
            ["<C-space>"] = function(bufnr)
              require("telescope.actions").to_fuzzy_refine(bufnr)
            end,
          },
          n = {
            ["j"] = function(bufnr)
              require("telescope.actions").move_selection_next(bufnr)
            end,
            ["k"] = function(bufnr)
              require("telescope.actions").move_selection_previous(bufnr)
            end,
          },
        },
      },
      extensions = {
        project = require("plugins.telescope.extensions").project,
        file_browser = require("plugins.telescope.extensions").file_browser,
        live_grep_args = require("plugins.telescope.extensions").live_grep_args,
      },
    },
  },
}
