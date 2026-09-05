local wk = require("which-key")

--- Run a TinyInlineDiag subcommand, keeping native virtual text off.
---@param sub string
---@return fun()
local function tiny_inline_diag(sub)
  return function()
    vim.cmd("TinyInlineDiag " .. sub)
    vim.diagnostic.config({ virtual_text = false })
  end
end

wk.add({
  { mode = "n", "<leader>D", group = "inline diagnostics", icon = { icon = "󰴅", color = "purple" } },
  { mode = "n", "<leader>De", tiny_inline_diag("enable"), desc = "Enable diagnostics" },
  { mode = "n", "<leader>Dd", tiny_inline_diag("disable"), desc = "Disable diagnostics" },
  { mode = "n", "<leader>Dt", tiny_inline_diag("toggle"), desc = "Toggle diagnostics" },
  { mode = "n", "<leader>Dc", tiny_inline_diag("toggle_cursor_only"), desc = "Toggle cursor-only diagnostics" },
  { mode = "n", "<leader>Dr", tiny_inline_diag("reset"), desc = "Reset diagnostic options" },
})
