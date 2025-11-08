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
      "markdown_inline", -- inline code blocks in md
      "php",
      "phpdoc", -- phpdoc comments
      "typescript",
      "tsx", -- TSX / React
      "yaml",
      -- Framework / extra
      "blade", -- Laravel Blade templates
      "vue", -- Vue single-file components
    },
  },
}
