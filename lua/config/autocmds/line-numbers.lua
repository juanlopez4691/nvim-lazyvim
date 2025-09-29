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

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    if list.contains_value(skip_filetypes, vim.bo.filetype) then
      return
    end
    -- Disable relative numbers in Insert mode
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if list.contains_value(skip_filetypes, vim.bo.filetype) then
      return
    end
    -- Re-enable relative numbers when leaving Insert mode
    vim.wo.relativenumber = true
  end,
})

-- Automatically switch to absolute line numbers for inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if list.contains_value(skip_filetypes, vim.bo.filetype) then
      return
    end
    -- Keep absolute numbers for inactive windows
    vim.wo.number = true
    -- Disable relative numbers in inactive windows
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if list.contains_value(skip_filetypes, vim.bo.filetype) then
      return
    end
    -- Enable relative numbers when entering a window
    vim.wo.relativenumber = true
    -- Keep absolute numbers enabled
    vim.wo.number = true
  end,
})

-- Hide line numbers in Telescope pickers prompt
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Set cursor line only in active window.
local setCursorLine = function(enable)
  if not list.contains_value(skip_filetypes, vim.bo.filetype) then
    vim.opt.cursorline = enable
  end
end

vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function()
    setCursorLine(false)
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    setCursorLine(true)
  end,
})
