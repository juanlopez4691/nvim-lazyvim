return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      keymap = {
        accept = "<CR>",
        next = "<Tab>",
        prev = "<S-Tab>",
      },
    },
    filetypes = {
      blade = true,
      css = true,
      go = true,
      html = true,
      javascript = true,
      javascriptreact = true,
      json = true,
      less = true,
      php = true,
      python = true,
      scss = true,
      sql = true,
      twig = true,
      typescript = true,
      typescriptreact = true,
      vue = true,
      ["*"] = false,
    },
  },
}
