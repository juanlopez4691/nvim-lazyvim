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
  extensions = {
    project = {
      theme = "dropdown",
    },
  },
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope").extensions.project.project({
          display_type = "full",
          theme = "dropdown",
        })
      end,
      desc = "Find project",
    },
  },
  dependencies = {
    {
      "nvim-telescope/telescope-project.nvim",
      config = function()
        LazyVim.on_load("telescope", function()
          require("telescope").load_extension("project")
        end)
      end,
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
