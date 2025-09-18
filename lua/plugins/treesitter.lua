return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "blade",
      "css",
      "http",
      "markdown",
      "php",
      "php_only",
      "phpdoc",
      "vue",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end

    require("nvim-treesitter").setup(opts)

    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
        [".*%.blade"] = "blade",
      },
    })
  end,
}
