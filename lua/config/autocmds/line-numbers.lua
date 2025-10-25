-- Autocommands to toggle line numbers based on mode
local list = require("helpers.list")

-- Filetypes to skip for relative number toggling
local skip_filetypes = {
  "Avante",
  "AvantePromptInput",
  "codecompanion",
  "DressingInput",
  "grug-far",
  "lazy",
  "neo-tree",
  "noice",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_picker_list",
  "snacks_picker_preview",
  "snacks_terminal",
  "TelescopePrompt",
  "trouble",
}

-- Check if current filetype should be skipped
local function should_skip_filetype()
  return list.contains_value(skip_filetypes, vim.bo.filetype)
end

-- Set line numbers based on mode
local function set_line_numbers(enable_line_numbers, enable_relative_line_numbers)
  if not should_skip_filetype() then
    vim.wo.number = enable_line_numbers
    vim.wo.relativenumber = enable_relative_line_numbers
  end
end

-- Switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    set_line_numbers(true, false)
  end,
})

-- Switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    set_line_numbers(true, true)
  end,
})

-- Switch to absolute line numbers for inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if not list.contains_value(skip_filetypes, vim.bo.filetype) then
      -- Keep absolute numbers for inactive windows
      set_line_numbers(true, false)
    end
  end,
})

-- Switch to relative line numbers for active windows
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if not list.contains_value(skip_filetypes, vim.bo.filetype) then
      -- Enable relative numbers when entering a window
      set_line_numbers(true, true)
      -- Keep absolute numbers enabled
      vim.wo.number = true
    end
  end,
})

-- Hide line numbers in Telescope pickers prompt
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    set_line_numbers(false, false)
  end,
})

-- Set cursor line only in active window.
local setCursorLine = function(enable)
  if not list.contains_value(skip_filetypes, vim.bo.filetype) then
    vim.opt.cursorline = enable
  end
end

-- Unset cursor line when leaving a window
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function()
    setCursorLine(false)
  end,
})

-- Set cursor line when entering a window
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    setCursorLine(true)
  end,
})
