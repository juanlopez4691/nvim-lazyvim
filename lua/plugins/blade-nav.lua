return {
  {
    "RicardoRamirezR/blade-nav.nvim",
    ft = { "blade", "php" },
    opts = {
      close_tag_on_complete = true,
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      if not vim.tbl_contains(opts.sources.default, "blade-nav") then
        table.insert(opts.sources.default, "blade-nav")
      end
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers["blade-nav"] = {
        module = "blade-nav.blink",
        opts = {
          close_tag_on_complete = true,
        },
      }
    end,
  },
}
