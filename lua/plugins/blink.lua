local copilot_suggestion

--[[
  Gets copilot suggestions.

  Prevents loading the copilot.suggestion module until
  it's needed, and caches the result.
]]
local function get_copilot_suggestion()
  if copilot_suggestion == false then
    return nil
  end

  if not copilot_suggestion then
    local ok, suggestion = pcall(require, "copilot.suggestion")
    if not ok then
      copilot_suggestion = false
      return nil
    end
    copilot_suggestion = suggestion
  end

  return copilot_suggestion
end

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

          local suggestion = get_copilot_suggestion()
          if suggestion and suggestion.is_visible() then
            suggestion.accept()
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

          local suggestion = get_copilot_suggestion()
          if suggestion and suggestion.is_visible() then
            suggestion.next()
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

          local suggestion = get_copilot_suggestion()
          if suggestion and suggestion.is_visible() then
            suggestion.prev()
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

          local suggestion = get_copilot_suggestion()
          if suggestion and suggestion.is_visible() then
            suggestion.dismiss()
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
