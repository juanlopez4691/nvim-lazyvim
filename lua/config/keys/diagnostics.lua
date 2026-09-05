-- Toggles for tiny-inline-diagnostic, which replaces native virtual text.

local tiny = "tiny-inline-diagnostic"

Snacks.toggle({
  name = "Inline Diagnostics",
  get = function()
    return require(tiny .. ".state").user_toggle_state
  end,
  set = function(enabled)
    require(tiny)[enabled and "enable" or "disable"]()
    -- Keep native virtual text off, even while inline diagnostics are hidden.
    vim.diagnostic.config({ virtual_text = false })
  end,
}):map("<leader>uv")

Snacks.toggle({
  name = "Inline Diagnostics (Cursor Only)",
  get = function()
    return require(tiny).config.options.show_diags_only_under_cursor
  end,
  set = function()
    require(tiny).toggle_cursor_only()
  end,
}):map("<leader>uV")
