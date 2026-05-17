return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "powerline",
      options = {
        show_all_diags_on_cursorline = true,
        use_icons_from_diagnostic = true,
        add_messages = {
          messages = true,
          show_multiple_glyphs = false,
        },
        multilines = {
          enabled = true,
          trim_whitespace = true,
          always_show = true,
        },
      },
    })

    vim.diagnostic.config({ virtual_text = false })
  end,
}
