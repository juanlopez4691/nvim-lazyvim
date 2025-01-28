--[[
--- Configure PHP formatters dynamically based on project setup.
---
--- Prevents phpcbf from being used if the project is using pint.
---
--- @return table Linter names for PHP files
---]]
local function get_php_formatters()
  local fs = require("helpers.filesystem")
  local project_root = vim.fn.getcwd()

  if fs.file_exists(project_root .. "/pint.json") and fs.file_exists(project_root .. "/vendor/bin/pint") then
    return { "pint" }
  else
    return { "phpcbf" }
  end
end

return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = function(_, opts)
    -- Merge new options with existing ones
    return vim.tbl_deep_extend("force", opts or {}, {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        php = function()
          return vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, get_php_formatters())
        end,
        -- php = { "pint", "phpcbf", stop_after_first = true },
        python = { "isort", "black", stop_after_first = true },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },
          command = require("conform.util").find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
          }, "pint"),
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    })
  end,
}
