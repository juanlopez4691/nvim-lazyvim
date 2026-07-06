local group = vim.api.nvim_create_augroup("code", { clear = true })

-- Add $ to iskeyword for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "php", "javascript", "typescript" },
  callback = function()
    vim.opt_local.iskeyword:append("$")
  end,
})
