local M = {}

--[[
  Opens a file browser in Telescope for the selected entry.

  @param prompt_bufnr (number) The prompt buffer number.
  @param settings (table) The settings for the file browser.
]]
local function open_file_browser(prompt_bufnr, settings)
  local selection = require("telescope.actions.state").get_selected_entry()
  local file_browser_settings = require("plugins.telescope.extensions").file_browser

  require("telescope.actions").close(prompt_bufnr)
  require("telescope").extensions.file_browser.file_browser(
    vim.tbl_extend("force", file_browser_settings, { path = selection.value, cwd = selection.value })
  )
end

M.file_browser = {
  hijack_netrw = true,
  git_status = true,
  grouped = true,
  sorting_strategy = "ascending",
  prompt_path = true,
  hidden = { file_browser = true, folder_browser = true },
}

M.project = {
  hidden_files = true,
  order_by = "asc",
  search_by = "title",
  mappings = {
    n = {
      ["b"] = function(bufnr)
        open_file_browser(bufnr, M.file_browser)
      end,
    },
    i = {
      ["<C-b>"] = function(bufnr)
        open_file_browser(bufnr, M.file_browser)
      end,
    },
  },
}

M.live_grep_args = {
  auto_quoting = true, -- enable/disable auto-quoting
}

return M
