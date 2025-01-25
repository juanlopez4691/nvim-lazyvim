--[[
--- Configure PHP linters dynamically based on project setup.
---
--- Checks for Pint and sets appropriate linters. Defines a custom
--- Pint linter with JSON parsing for nvim-lint.
---
--- @return table Linter names for PHP files
---]]
local function get_php_linters()
  local fs = require("helpers.filesystem")
  local project_root = vim.fn.getcwd()
  local lint = require("lint")
  local linters = { "phpcs", "phpstan" }

  if fs.file_exists(project_root .. "/pint.json") and fs.file_exists(project_root .. "/vendor/bin/pint") then
    linters = { "pint" }
  end

  -- Define custom Pint linter
  lint.linters.pint = {
    cmd = "vendor/bin/pint",
    args = { "--test", "--format", "json" },
    stdin = true,
    stream = "stdout",
    ignore_exitcode = true,
    parser = function(output)
      local diagnostics = {}
      local json = vim.json.decode(output)

      if json and json.files then
        for _, file in pairs(json.files) do
          for _, message in ipairs(file.messages) do
            table.insert(diagnostics, {
              lnum = message.line - 1,
              col = message.column - 1,
              message = message.message,
              severity = vim.diagnostic.severity.WARN,
            })
          end
        end
      end
      return diagnostics
    end,
  }

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
