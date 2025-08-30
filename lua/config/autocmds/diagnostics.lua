-- Toggle diagnostics when entering/leaving insert mode
local groupDiagnostics = vim.api.nvim_create_augroup("diagnostics", {})

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.diagnostic.enable(false)
  end,
  group = groupDiagnostics,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.diagnostic.enable(true)
  end,
  group = groupDiagnostics,
})
