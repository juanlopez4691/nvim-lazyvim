return {
  "nvim-telescope/telescope.nvim",
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
  },
  keys = {
    {
      "<leader>fp",
      function()
        local telescope = require("telescope")
        local telescope_custom = require("helpers.telescope")

        local custom_theme = telescope_custom.get_dropdown_custom(0.5, 0.5)
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
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      config = function()
        LazyVim.on_load("telescope", function()
          require("telescope").load_extension("file_browser")
        end)
      end,
    },
  },
}
