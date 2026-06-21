local fs = require("helpers.filesystem")

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts = opts or {}
    opts.servers = opts.servers or {}

    -- Only point intelephense at php-stubs directories that actually exist.
    -- Composer may live under the legacy ~/.composer or the XDG ~/.config path.
    local stub_paths = {}
    for _, path in ipairs({
      "~/.composer/vendor/php-stubs/",
      "~/.config/composer/vendor/php-stubs/",
    }) do
      local expanded = vim.fn.expand(path)
      if fs.dir_exists(expanded) then
        table.insert(stub_paths, expanded)
      end
    end

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
              associations = { "*.php", "*.blade.php" },
              maxSize = 1000000,
            },
            environment = {
              includePaths = stub_paths,
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
