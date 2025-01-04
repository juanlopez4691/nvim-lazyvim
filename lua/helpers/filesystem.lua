--[[
-- Scans a given directory and requires all Lua files within it.
--
-- The directory path is assumed to be relative to the "lua/" directory.
--
-- @param directory The directory to scan and require Lua files from.
--]]
local function require_dir(directory)
  local target_dir = vim.fn.stdpath("config") .. "/lua/" .. directory

  local function scan_dir(dir)
    local pfile = io.popen('find "' .. dir .. '" -type f -name "*.lua"')
    if not pfile then
      vim.notify("Failed to scan directory: " .. dir, vim.log.levels.ERROR)
      return
    end

    for file in pfile:lines() do
      local module_name = file:match("^.+/lua/(.+).lua$"):gsub("/", ".")
      local success, err = pcall(require, module_name)
      if not success then
        vim.notify("Failed to require module: " .. module_name .. "\nError: " .. err, vim.log.levels.WARN)
      end
    end

    pfile:close()
  end

  scan_dir(target_dir)
end

return {
  require_dir = require_dir,
}
