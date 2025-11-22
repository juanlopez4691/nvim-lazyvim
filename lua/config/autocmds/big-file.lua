local group = vim.api.nvim_create_augroup("BigFileDisable", { clear = true })

local MAX_FILESIZE = 1.5 * 1024 * 1024 -- 1.5 MB
local MAX_LINES = 5000

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  pattern = "*",
  callback = function(args)
    local lines = vim.fn.line("$")
    local filesize = vim.fn.getfsize(args.file)
    local is_big_file = filesize >= MAX_FILESIZE or lines >= MAX_LINES

    if is_big_file then
      vim.cmd("syntax off")

      pcall(function()
        vim.treesitter.stop(vim.api.nvim_get_current_buf())
      end)

      vim.cmd("silent! LspStop")
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt.cursorline = false
    end
  end,
})
