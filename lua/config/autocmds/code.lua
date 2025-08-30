-- Add $ to iskeyword for some filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "javascript", "typescript" },
  callback = function()
    vim.opt_local.iskeyword:append("$")
  end,
})
