--- Nearest WordPress root for a buffer, or nil if none.
---@param bufnr integer
---@return string?
local function wp_root(bufnr)
  local hits = vim.fs.find({ "wp-config.php", "wp-content", "wp-includes" }, {
    upward = true,
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })
  return hits[1] and vim.fs.dirname(hits[1]) or nil
end

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
      ---@cast expanded string

      if vim.fn.isdirectory(expanded) == 1 then
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
      },
      twiggy_language_server = {
        filetypes = { "twig" },
      },
      vtsls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
      antlersls = {
        filetypes = { "antlers", "html" },
        root_dir = function(bufnr, on_dir)
          on_dir(vim.fs.root(bufnr, { "composer.json", ".git" }) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
        end,
      },
      intelephense = {
        filetypes = { "php" },
        -- WordPress only; phpantom below covers everything else.
        root_dir = function(bufnr, on_dir)
          local wp = wp_root(bufnr)
          if wp then
            on_dir(vim.fs.root(bufnr, { "composer.json", ".git" }) or wp)
          end
        end,
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
      phpantom_lsp = {
        -- Laravel/general PHP; WordPress goes to intelephense above.
        root_dir = function(bufnr, on_dir)
          if not wp_root(bufnr) then
            on_dir(nil) -- nil defers to the root_markers lspconfig ships
          end
        end,
      },
      marksman = {
        filetypes = { "markdown" },
      },
    }, opts.servers)

    return opts
  end,
}
