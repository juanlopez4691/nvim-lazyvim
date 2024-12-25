return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      php = { "pint", "phpcbf", stop_after_first = true },
      python = { "isort", "black", stop_after_first = true },
    },
  },
}
