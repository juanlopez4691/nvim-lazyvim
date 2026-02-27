--[[
  Custom Scooter keybindings and integration.
  
  scooter is an interactive find-and-replace terminal UI app
  that can be used to quickly search and replace text across files.
  This code integrates scooter with Neovim using the snacks plugin
  to manage the terminal window, and which-key for keybindings.
  See https://github.com/thomasschafer/scooter
]]

local wk = require("which-key")
local snacks = require("snacks")
local scooter_term = nil

--[[
  Open scooter terminal window
--]]
local function open_scooter()
  if scooter_term and scooter_term:buf_valid() then
    local channel = vim.fn.getbufvar(scooter_term.buf, "terminal_job_id")
    if channel and vim.fn.jobwait({ channel }, 0)[1] == -1 then
      scooter_term:toggle()
      return
    end
  end
  scooter_term = snacks.terminal.open("scooter", { win = { position = "float" } })
end

--[[
  Open scooter with search text

  @param search-text The text to search for in scooter. Newlines will be replaced with spaces.
-- ]]
local function open_scooter_with_text(search_text)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:close()
  end
  local escaped = vim.fn.shellescape(search_text:gsub("\r?\n", " "))
  scooter_term =
    snacks.terminal.open("scooter --fixed-strings --search-text " .. escaped, { win = { position = "float" } })
end

--[[
  Edit line from scooter in Neovim

  @param file_path The path of the file to edit
  @param line The line number to jump to in the file
]]
_G.EditLineFromScooter = function(file_path, line)
  if scooter_term and scooter_term:buf_valid() then
    scooter_term:hide()
  end
  if vim.fn.expand("%:p") ~= vim.fn.fnamemodify(file_path, ":p") then
    vim.cmd.edit(vim.fn.fnameescape(file_path))
  end
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

-- Keybindings for scooter
wk.add({
  {
    mode = "n",
    "<leader>sr",
    group = "Search and replace",
    open_scooter,
    desc = "Open scooter",
  },
  {
    mode = "v",
    "<leader>ar",
    function()
      local selection = vim.fn.getreg('"')
      vim.cmd('normal! "ay')
      open_scooter_with_text(vim.fn.getreg("a"))
      vim.fn.setreg('"', selection)
    end,
    group = "s",
    desc = "Search selected text in scooter",
  },
})
