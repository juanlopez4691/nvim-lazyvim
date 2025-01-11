local M = {}

M.project = {
  hidden_files = true,
  order_by = "asc",
  search_by = "title",
  mappings = {
    n = {
      ["b"] = function()
        require("helpers.telescope").open_file_browser()
      end,
    },
    i = {
      ["<C-b>"] = function()
        require("helpers.telescope").open_file_browser()
      end,
    },
  },
}

M.file_browser = {
  hijack_netrw = true,
  git_status = true,
  grouped = true,
  sorting_strategy = "ascending",
  prompt_path = true,
  hidden = { file_browser = true, folder_browser = true },
}

M.live_grep_args = {
  auto_quoting = true, -- enable/disable auto-quoting
}

return M
