--[[
  helpers/filesystem.lua

  Utility functions for filesystem operations in Neovim configs.

  Features:
    - Cross-platform directory scanning using plenary.nvim
    - Error aggregation and summary reporting
    - Deduplication of required modules
    - Support for both absolute and relative paths
    - Input sanitization for security
    - Expanded documentation and usage examples
]]

local scan
local plenary_ok, plenary_scan = pcall(require, "plenary.scandir")

-- Ensure plenary.nvim is available for robust directory scanning or fall back to shell scanning
if plenary_ok then
  scan = plenary_scan
else
  vim.notify(
    "plenary.nvim not found! Falling back to shell-based scan. Some features may be less portable.",
    vim.log.levels.WARN
  )
end

-- Sanitize input to avoid shell injection and invalid paths
local function sanitize_path(path)
  -- Only allow valid Lua module path characters
  return path:gsub("[^%w%._/-]", "")
end

-- Loads all Lua modules in a directory (absolute or relative to lua/)
-- Usage:
--   require_dir("config/keys") -- relative to lua/
--   require_dir("/absolute/path/to/lua/config/keys") -- absolute path
local function require_dir(directory)
  local safe_dir = sanitize_path(directory)
  local target_dir = safe_dir

  if not safe_dir:match("^/") then
    target_dir = vim.fn.stdpath("config") .. "/lua/" .. safe_dir
  end

  local files = {}

  if scan and scan.scan_dir then
    files = scan.scan_dir(target_dir, { depth = 1, add_dirs = false, search_pattern = "%.lua$" })
  else
    -- Fallback: shell-based scan (Unix only)
    local pfile = io.popen('find "' .. target_dir .. '" -type f -name "*.lua"')

    if pfile then
      for file in pfile:lines() do
        table.insert(files, file)
      end
      pfile:close()
    else
      vim.notify("Failed to scan directory: " .. target_dir, vim.log.levels.ERROR)
      return
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
