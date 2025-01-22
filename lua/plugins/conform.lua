return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      php = { "pint", "phpcbf", stop_after_first = true },
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
  },
}
