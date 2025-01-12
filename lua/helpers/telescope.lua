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

return {
  get_dropdown_custom = get_dropdown_custom,
}
