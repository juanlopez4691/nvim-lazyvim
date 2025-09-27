local copilot_ok, copilot_suggestion = pcall(require, "copilot.suggestion")

local transform_items = function(items, icon, name)
  for _, item in ipairs(items) do
    item.kind_icon = icon
    item.kind_name = name
  end
  return items
end

return {
  "saghen/blink.cmp",
  dependencies = {
    { "xzbdmw/colorful-menu.nvim" },
    {
      "Kaiser-Yang/blink-cmp-avante",
    },
  },
  opts = {
    sources = {
      default = { "avante", "laravel", "lsp", "buffer", "snippets", "path" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {},
        },
        laravel = {
          name = "laravel",
          module = "laravel.blink_source",
          score_offset = 1000, -- High priority for Laravel completions
          transform_items = function(_, items)
            return transform_items(items, "", "Laravel")
          end,
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<CR>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.accept()
            return true
          end

          if copilot_ok and copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
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

          if copilot_ok and copilot_suggestion.is_visible() then
            copilot_suggestion.next()
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

          if copilot_ok and copilot_suggestion.is_visible() then
            copilot_suggestion.prev()
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

          if copilot_ok and copilot_suggestion.is_visible() then
            copilot_suggestion.dismiss()
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
