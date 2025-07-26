return {
  "zbirenbaum/copilot.lua",
  opts = {
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
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
      lua = true,
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
