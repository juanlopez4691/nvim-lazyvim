return {
  "saghen/blink.cmp",
  dependencies = {
    { "xzbdmw/colorful-menu.nvim" },
  },
  opts = {
    sources = {
      default = { "lsp", "buffer", "snippets", "path" },
    },
    keymap = {
      preset = "enter",
      ["<CR>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.accept()
            return true
          end

          return false
        end,
        "fallback",
      },
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.select_next()
            return true
          end

          return false
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.select_prev()
            return true
          end

          return false
        end,
        "fallback",
      },
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
