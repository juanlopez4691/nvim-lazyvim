--[[
  helpers/filesystem.lua

  Utility functions for filesystem operations in Neovim configs.

  Features:
    - Directory scanning using vim.fs.dir
    - Error aggregation and summary reporting
    - Deduplication of required modules
    - Relative path support
]]

-- Loads all Lua modules in a directory (relative to lua/)
-- Usage:
--   require_dir("config/keys") -- relative to lua/
local function require_dir(directory)
  local target_dir = vim.fn.stdpath("config") .. "/lua/" .. directory

  if vim.fn.isdirectory(target_dir) == 0 then
    vim.notify("Directory not found: " .. target_dir, vim.log.levels.WARN)
    return
  end

  local files = {}
  for name in vim.fs.dir(target_dir) do
    if name:match("%.lua$") then
      table.insert(files, target_dir .. "/" .. name)
    end
  end

  local required = {}
  local errors = {}

  for _, file in ipairs(files) do
    local module_name = file:match("^.+/lua/(.+)%.lua$"):gsub("/", ".")

    if not required[module_name] then
      local success, err = pcall(require, module_name)

      if not success then
        table.insert(errors, { module = module_name, error = err })
      end
      required[module_name] = true
    end
  end

  if #errors > 0 then
    local msg = "Failed to require modules:\n"

    for _, e in ipairs(errors) do
      msg = msg .. e.module .. ": " .. e.error .. "\n"
    end
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

--[[
-- Function to check if a file exists
--
-- @param file The file to check
--
-- @return boolean
--]]
local function file_exists(file)
  return vim.fn.filereadable(file) == 1
end

return {
  require_dir = require_dir,
  file_exists = file_exists,
}
