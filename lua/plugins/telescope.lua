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
  },
}
