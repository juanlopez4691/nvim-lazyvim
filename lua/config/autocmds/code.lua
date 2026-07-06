local group = vim.api.nvim_create_augroup("code", { clear = true })

-- Add $ to iskeyword for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "php", "javascript", "typescript" },
  callback = function()
    vim.opt_local.iskeyword:append("$")
  end,
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
