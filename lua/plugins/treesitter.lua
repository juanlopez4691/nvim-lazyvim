return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  event = { "LazyFile", "VeryLazy" },
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "blade",
      "css",
      "http",
      "markdown",
      "php",
      "php_only",
      "phpdoc",
      "vue",
    })
    return opts
  end,
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end

    require("nvim-treesitter.configs").setup(opts)

    -- Defer Blade parser configuration
    vim.defer_fn(function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      if not parser_config.blade then
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade",
        }

        vim.filetype.add({
          pattern = {
            [".*%.blade%.php"] = "blade",
          },
        })
      end
    end, 100)
  end,
}
