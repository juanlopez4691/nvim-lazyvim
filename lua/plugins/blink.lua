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
        selection = { preselect = true, auto_insert = true },
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
