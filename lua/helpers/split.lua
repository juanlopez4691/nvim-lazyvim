--[[
  Checks if the given split is the bottommost of the given window

  @param win_id (integer) The window ID
]]
local function is_bottommost(win_id)
  local win_bottom = vim.api.nvim_win_get_position(win_id)[1] + vim.api.nvim_win_get_height(win_id)
  local screen_bottom = vim.o.lines - vim.o.cmdheight - 1
  return win_bottom >= screen_bottom
end

--[[
  Checks if the given split is the rightmost of the given window

  @param win_id (integer) The window ID
]]
local function is_rightmost(win_id)
  local win = win_id or vim.api.nvim_get_current_win()
  local win_pos = vim.api.nvim_win_get_position(win)
  local win_width = vim.api.nvim_win_get_width(win)
  local screen_width = vim.o.columns

  -- Check if the right edge of the window is at the screen's right edge
  return (win_pos[2] + win_width) >= screen_width
end

--[[
  Resizes the current split window in the specified direction.
 
  @param direction (string) The direction to resize: "right", "left", "up", or "down"
 
  This function determines if the current window is the rightmost or bottommost split,
  then constructs and executes a resize command based on the given direction.
  The resize amount is fixed at 2 units.
]]
local function resize(direction)
  local current_win = vim.api.nvim_get_current_win()
  local rightmost = is_rightmost(current_win)
  local bottommost = is_bottommost(current_win)

  local resize_amount = 2
  local resize_command = ""

  if direction == "right" or direction == "left" then
    resize_command = "vertical resize "
    if (direction == "right" and not rightmost) or (direction == "left" and rightmost) then
      resize_command = resize_command .. "+"
    else
      resize_command = resize_command .. "-"
    end
  else -- "up" or "down"
    resize_command = "resize "
    if (direction == "down" and not bottommost) or (direction == "up" and bottommost) then
      resize_command = resize_command .. "+"
    else
      resize_command = resize_command .. "-"
    end
  end

  vim.cmd(resize_command .. resize_amount)
end

return {
  is_rightmost = is_rightmost,
  is_bottommost = is_bottommost,
  resize = resize,
}
