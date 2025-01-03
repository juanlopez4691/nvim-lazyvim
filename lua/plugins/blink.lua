return {
  "saghen/blink.cmp",
  opts = {
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
        selection = "preselect",
      },
      menu = {
        min_width = 25,
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description" },
            { "kind" },
            { "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  or ("BlinkCmpKind" .. ctx.kind)
              end,
            },
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
            },
            label_description = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return "    " .. ctx.label_description
              end,
              highlight = "BlinkCmpLabelDescription",
            },
            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                return ctx.kind
              end,
              highlight = function(ctx)
                return require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  or ("BlinkCmpKind" .. ctx.kind)
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
