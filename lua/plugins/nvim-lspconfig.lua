return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts = opts or {}
    opts.setup = opts.setup or {}
    opts.servers = opts.servers or {}

    -- Ensure filetypes are registered before configuring servers that rely on them
    require("config.filetypes")

    -- Force TailwindCSS to only the filetypes Neovim actually reports (Blade/Twig/PostCSS are mapped)
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

    opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, {
      filetypes = tailwind_filetypes,
      init_options = {
        userLanguages = {
          php = "html",
          blade = "html",
          twig = "html",
          postcss = "css",
        },
      },
    })

    opts.setup.tailwindcss = function(_, cfg)
      cfg.filetypes = tailwind_filetypes
      cfg.on_new_config = function(new_config)
        new_config.filetypes = tailwind_filetypes
      end
      cfg.init_options = vim.tbl_deep_extend("force", cfg.init_options or {}, {
        userLanguages = {
          php = "html",
          blade = "html",
          twig = "html",
          postcss = "css",
        },
      })
      require("lspconfig").tailwindcss.setup(cfg)
      return true
    end

    opts.servers.twiggy_language_server = {
      filetypes = { "twig" },
    }

    opts.setup.twiggy_language_server = function(_, cfg)
      cfg.filetypes = { "twig" }
      cfg.on_new_config = function(new_config)
        new_config.filetypes = { "twig" }
      end
      require("lspconfig").twiggy_language_server.setup(cfg)
      return true
    end

    -- Keep existing server configs
    opts.servers = vim.tbl_deep_extend("force", {
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
        files = {
          exclude = { "node_modules", "vendor" },
          associations = { "*.php", "*.blade.php", "*.twig" },
          maxSize = 1000000,
        },
        environment = {
          includePaths = vim.fn.expand("~/.composer/vendor/php-stubs/"),
        },
        stubs = require("config.intelephense.stubs"),
      },
      docker_compose_language_service = {
        filetypes = { "yaml" },
      },
      marksman = {
        filetypes = { "markdown" },
      },
      twiggy_language_server = false,
      vtsls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
    }, opts.servers)

    opts.setup.vtsls = function(_, cfg)
      local vts_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      cfg.filetypes = vts_filetypes
      cfg.on_new_config = function(new_config)
        new_config.filetypes = vts_filetypes
      end
      require("lspconfig").vtsls.setup(cfg)
      return true
    end

    opts.setup.antlersls = function(_, cfg)
      cfg.filetypes = { "antlers", "html" }
      require("lspconfig").antlersls.setup(cfg)
      return true
    end

    opts.setup.laravel_ls = function(_, cfg)
      local util = require("lspconfig.util")
      cfg.root_dir = cfg.root_dir or util.root_pattern("composer.json", "artisan", ".git")
      cfg.single_file_support = false
      require("lspconfig").laravel_ls.setup(cfg)
      return true
    end

    return opts
  end,
}
