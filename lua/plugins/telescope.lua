return {
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-project.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        config = function()
          LazyVim.on_load("telescope", function()
            require("telescope").load_extension("file_browser")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-project.nvim",
        lazy = true,
        config = function()
          LazyVim.on_load("telescope", function()
            require("telescope").load_extension("project")
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
        project = {
          hidden_files = true,
          order_by = "asc",
          search_by = "title",
          mappings = {
            n = {
              ["b"] = function()
                require("telescope_helpers").open_file_browser()
              end,
            },
            i = {
              ["<C-b>"] = function()
                require("telescope_helpers").open_file_browser()
              end,
            },
          },
        },
        file_browser = function()
          return require("telescope_helpers").file_browser_settings()
        end,
      },
    },
  },
}
