return {
  "williamboman/mason.nvim",
  opts = function()
    return {
      ensure_installed = {
        "phpcs",
        "phpcbf",
        "phpstan",
        "prettierd",
      },
    }
  end,
}
