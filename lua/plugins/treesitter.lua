return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- Core Neovim related
      "lua",
      "vim",
      "vimdoc",
      "query",
      -- Common languages
      "bash",
      "css",
      "html",
      "javascript",
      "json",
      "markdown",
      "markdown_inline",
      "php",
      "phpdoc",
      "typescript",
      "tsx",
      "yaml",
      -- Framework / extra
      "blade",
      "vue",
    },
  },
}
