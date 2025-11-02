return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = { "i", "<c-k>", false },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "LazyVim" },
            },
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              },
            },
          },
        },
      },
      antlersls = {
        filetypes = { "antlers", "html" },
        files = {
          associations = { "*.antlers", "*.antlers.html" },
        },
      },
      intelephense = {
        filetypes = { "php", "blade", "php_only" },
        files = {
          associations = { "*.php", "*.blade.php" },
          maxSize = 1000000,
        },
        environment = {
          includePaths = vim.fn.expand("~/.composer/vendor/php-stubs/"),
        },
        stubs = require("config.intelephense.stubs"),
      },
    },
  },
}
