local wk = require("which-key")

wk.add({
  { mode = "n", "<leader>D", group = "inline diagnostics", icon = { icon = "󰴅", color = "purple" } },
  { mode = "n", "<leader>De", "<cmd>TinyInlineDiag enable<cr>", desc = "Enable diagnostics" },
  { mode = "n", "<leader>Dd", "<cmd>TinyInlineDiag disable<cr>", desc = "Disable diagnostics" },
  { mode = "n", "<leader>Dt", "<cmd>TinyInlineDiag toggle<cr>", desc = "Toggle diagnostics" },
  { mode = "n", "<leader>Dc", "<cmd>TinyInlineDiag toggle_cursor_only<cr>", desc = "Toggle cursor-only diagnostics" },
  { mode = "n", "<leader>Dr", "<cmd>TinyInlineDiag reset<cr>", desc = "Reset diagnostic options" },
})
