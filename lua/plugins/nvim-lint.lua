--[[
--- Configure PHP linters dynamically based on project setup.
---
--- @return table Linter names for PHP files
---]]
local function get_php_linters()
  local fs = require("helpers.filesystem")
  local work_dir = vim.fn.expand("$PWD")
  local vendor_dir = work_dir .. "/vendor"
  local linters = {}

  -- Add phpstan if config file exists
  if
    fs.file_exists(work_dir .. "/phpstan.neon")
    or fs.file_exists(work_dir .. "/phpstan.neon.dist")
    or fs.file_exists(work_dir .. "/phpstan.dist.neon")
  then
    table.insert(linters, "phpstan")
  end

  -- Skip phpcs if pint formatter is installed
  if fs.file_exists(vendor_dir .. "/bin/pint") then
    return linters
  end

  -- Add phpcs
  table.insert(linters, "phpcs")

  return linters
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  opts = function(_, opts)
    opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, {
      php = get_php_linters(),
    })
    return opts
  end,
}
