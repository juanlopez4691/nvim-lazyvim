--[[
--- Configure PHP linters dynamically based on project setup.
---
--- @return table Linter names for PHP files
---]]
local function get_php_linters()
  local fs = require("helpers.filesystem")
  local project_root = vim.fn.getcwd()
  local linters = {}

  if fs.file_exists(project_root .. "/vendor/bin/phpcs") then
    table.insert(linters, "phpcs")
  end

  if fs.file_exists(project_root .. "/vendor/bin/phpstan") then
    table.insert(linters, "phpstan")
  end
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
