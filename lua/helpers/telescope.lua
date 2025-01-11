--[[
  Creates a custom dropdown theme for Telescope with specified dimensions.

  @param width (number|nil) Width of dropdown as fraction of screen width. Defaults to 0.95.
  @param height (number|nil) Height of dropdown as fraction of screen height. Defaults to 0.95.

  @return table Custom theme configuration for Telescope's get_dropdown function.
]]
local get_dropdown_custom = function(width, height)
  return require("telescope.themes").get_dropdown({
    layout_config = {
      width = width or 0.95,
      height = height or 0.95,
    },
  })
end

--[[
  Opens a file browser in Telescope for the selected entry.

  @param prompt_bufnr (number) The prompt buffer number.
]]
local function open_file_browser(prompt_bufnr)
  local selection = require("telescope.actions.state").get_selected_entry()
  local file_browser_settings = require("plugins.telescope.extensions").file_browser

  require("telescope.actions").close(prompt_bufnr)
  require("telescope").extensions.file_browser.file_browser(
    vim.tbl_extend("force", file_browser_settings, { path = selection.value, cwd = selection.value })
  )
end

return {
  get_dropdown_custom = get_dropdown_custom,
  open_file_browser = open_file_browser,
}
