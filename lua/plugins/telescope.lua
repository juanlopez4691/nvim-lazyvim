return {
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-project.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          LazyVim.on_load("telescope", function()
            require("telescope").load_extension("file_browser")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-project.nvim",
        config = function()
          LazyVim.on_load("telescope", function()
            require("telescope").load_extension("project")
          end)
        end,
      },
    },
    opts = {
      defaults = {
        layout_config = {
          height = 0.95,
          width = 0.95,
        },
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
          },
          n = {
            ["j"] = require("telescope.actions").move_selection_next,
            ["k"] = require("telescope.actions").move_selection_previous,
            -- Add more custom normal mode mappings here
          },
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
      },
      extensions = {
        project = {
          hidden_files = true,
          order_by = "asc",
          search_by = "title",
          mappings = {
            ["b"] = function()
              local ok, telescope = pcall(require, "telescope")
              if not ok then
                return
              end
              telescope.extensions.file_browser.file_browser({
                grouped = true,
              })
            end,
          },
        },
        file_browser = {
          hijack_netrw = true,
          git_status = true,
          grouped = true,
          prompt_path = true,
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    },
  },
}
