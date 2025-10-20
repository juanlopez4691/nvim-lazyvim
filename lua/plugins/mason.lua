return {
  "mason-org/mason.nvim",
  opts = function()
    return {
      ensure_installed = {
        "blade-formatter",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "intelephense",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "php-debug-adapter",
        "phpcbf",
        "phpcs",
        "phpstan",
        "pint",
        "prettierd",
        "tailwindcss-language-server",
        "taplo",
        "twigcs",
        "twig-cs-fixer",
        "vtsls",
      },
    }
  end,
}
