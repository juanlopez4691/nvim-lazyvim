--[[
--- Configure PHP linters dynamically based on project setup.
---
--- Prevents phpcs and phpstan from being used if the project is using pint.
---
--- @return table Linter names for PHP files
---]]
local function get_php_linters()
  local fs = require("helpers.filesystem")
  local project_root = vim.fn.getcwd()
  local linters = { "phpcs", "phpstan" }

  if fs.file_exists(project_root .. "/pint.json") and fs.file_exists(project_root .. "/vendor/bin/pint") then
    linters = {}
  end

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
