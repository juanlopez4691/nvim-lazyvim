return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        php = { "pint", "phpcbf", "php-cs-fixer", stop_after_first = true },
        python = { "isort", "black", stop_after_first = true },
        blade = { "blade-formatter" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },
          command = require("conform.util").find_executable({
            "vendor/bin/pint", -- Project-local first
            vim.fn.stdpath("data") .. "/mason/bin/pint", -- Mason second
          }, "pint"), -- Fallback to PATH
          args = { "$FILENAME" },
          stdin = false,
          -- Only use pint if pint.json exists or vendor/bin/pint exists
          condition = function(_, ctx)
            local root = vim.fs.root(ctx.buf, { "pint.json", "vendor" }) or ctx.dirname
            return vim.fn.filereadable(root .. "/pint.json") == 1
              or vim.fn.filereadable(root .. "/vendor/bin/pint") == 1
          end,
        },
        phpcbf = {
          -- Only use phpcbf if vendor/bin/phpcbf exists
          condition = function(_, ctx)
            local root = vim.fs.root(ctx.buf, { "vendor" }) or ctx.dirname
            return vim.fn.filereadable(root .. "/vendor/bin/phpcbf") == 1
          end,
        },
      },
    })
  end,
}
