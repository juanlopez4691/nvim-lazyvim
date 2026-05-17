return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts = opts or {}
    opts.servers = opts.servers or {}

    local tailwind_filetypes = {
      "php",
      "html",
      "css",
      "postcss",
      "blade",
      "twig",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    }

    opts.servers = vim.tbl_deep_extend("force", {
      tailwindcss = {
        filetypes = tailwind_filetypes,
        init_options = {
          userLanguages = {
            php = "html",
            blade = "html",
            twig = "html",
            postcss = "css",
          },
        },
        on_new_config = function(new_config)
          new_config.filetypes = tailwind_filetypes
        end,
      },
      twiggy_language_server = {
        filetypes = { "twig" },
        on_new_config = function(new_config)
          new_config.filetypes = { "twig" }
        end,
      },
      vtsls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        on_new_config = function(new_config)
          new_config.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
        end,
      },
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
      laravel_ls = {
        filetypes = { "php" },
        single_file_support = false,
        root_dir = require("lspconfig.util").root_pattern("composer.json", ".git"),
      },
      antlersls = {
        filetypes = { "antlers", "html" },
        single_file_support = true,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("composer.json", ".git")(fname) or util.path.dirname(fname)
        end,
      },
      intelephense = {
        filetypes = { "php" },
        settings = {
          intelephense = {
            files = {
              exclude = { "**/node_modules/**", "**/.git/**", "**/.svn/**", "**/.hg/**" },
              associations = { "*.php", "*.blade.php", "*.twig" },
              maxSize = 1000000,
            },
            environment = {
              includePaths = { vim.fn.expand("~/.composer/vendor/php-stubs/") },
            },
            stubs = require("config.intelephense.stubs"),
          },
        },
      },
      marksman = {
        filetypes = { "markdown" },
      },
    }, opts.servers)

    return opts
  end,
}
