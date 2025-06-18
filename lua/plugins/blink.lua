return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "saghen/blink.compat",
      lazy = true,
      opts = {},
    },
    { "xzbdmw/colorful-menu.nvim" },
  },
  opts = {
    sources = {
      default = { "lsp", "laravel", "buffer", "snippets", "path" },
      providers = {
        laravel = {
          name = "laravel",
          module = "blink.compat.source",
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<esc>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.cancel()
            return true
          end
          return false
        end,
        "fallback",
      },
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      menu = {
        min_width = 25,
        border = "rounded",
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            source_name = {
              text = function(ctx)
                return "[" .. ctx.source_name .. "]"
              end,
            },
          },
        },
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
  },
}
