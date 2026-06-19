-- Toggles line numbers and cursorline based on mode and window focus.
-- Uses heuristics (buftype, floating windows, existing settings) instead of
-- a hardcoded filetype list to stay zero-maintenance across new plugins.

-- Non-normal buftypes that indicate a plugin UI / popup (never needs numbers).
local ui_buftypes = {
  help = true,
  nofile = true,
  prompt = true,
  quickfix = true,
  terminal = true,
}

-- Fallback filetype list for edge cases where a plugin uses buftype="" (normal)
-- in a non-floating window but still should not show line numbers or cursorline.
-- Only add a filetype here if the heuristics fail to catch it in practice.
local skip_filetypes = {}

--- Returns false for windows that should not be touched by our toggles.
---@param respect_number? boolean  If true, skip when vim.wo.number is already false.
local function should_manage_window(respect_number)
  -- Heuristic 1: plugin UI buffers (sidebar, picker, terminal, help, etc.)
  if ui_buftypes[vim.bo.buftype] ~= nil then
    return false
  end

  -- Heuristic 2: floating / popup windows
  local ok, win_conf = pcall(vim.api.nvim_win_get_config, 0)
  if ok and win_conf.relative ~= "" then
    return false
  end

  -- Heuristic 3: respect existing user or plugin opt-out for line numbers.
  -- Not applied to cursorline because we toggle it ourselves in WinLeave,
  -- which would make the check self-defeating.
  if respect_number and not vim.wo.number then
    return false
  end

  -- Fallback: filetypes that escape heuristics 1-3
  if skip_filetypes[vim.bo.filetype] then
    return false
  end

  return true
end

local function set_line_numbers(enable_line_numbers, enable_relative_line_numbers)
  if not should_manage_window(true) then
    return
  end
  vim.wo.number = enable_line_numbers
  vim.wo.relativenumber = enable_relative_line_numbers
end

local function set_cursor_line(enable)
  if not should_manage_window(false) then
    return
  end
  vim.wo.cursorline = enable
end

local group = vim.api.nvim_create_augroup("LineNumbers", { clear = true })

-- InsertEnter → absolute line numbers
vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  pattern = "*",
  desc = "Absolute line numbers in insert mode",
  callback = function()
    set_line_numbers(true, false)
  end,
})

-- InsertLeave → relative line numbers
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  pattern = "*",
  desc = "Relative line numbers in normal mode",
  callback = function()
    set_line_numbers(true, true)
  end,
})

-- Inactive windows → absolute line numbers
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = group,
  pattern = "*",
  desc = "Absolute line numbers for inactive windows",
  callback = function()
    set_line_numbers(true, false)
  end,
})

-- Active windows → relative (or absolute in insert mode)
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = group,
  pattern = "*",
  desc = "Relative line numbers for active windows",
  callback = function()
    local is_insert = vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
    set_line_numbers(true, not is_insert)
  end,
})

-- Cursorline off when leaving a window
vim.api.nvim_create_autocmd("WinLeave", {
  group = group,
  pattern = "*",
  desc = "Hide cursorline in inactive windows",
  callback = function()
    set_cursor_line(false)
  end,
})

-- Cursorline on when entering a window
vim.api.nvim_create_autocmd("WinEnter", {
  group = group,
  pattern = "*",
  desc = "Show cursorline in active windows",
  callback = function()
    set_cursor_line(true)
  end,
})
