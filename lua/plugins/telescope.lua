return {
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-project.nvim" },
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
    dependencies = {
      {
        "nvim-telescope/telescope-project.nvim",
        lazy = true,
        config = function()
          LazyVim.on_load("telescope", function()
            require("telescope").load_extension("project")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        lazy = true,
        version = "^1.0.0",
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
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
      {
        "<leader>fx",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File browser",
      },
    },
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
            ["<C-space>"] = require("telescope.actions").to_fuzzy_refine,
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
