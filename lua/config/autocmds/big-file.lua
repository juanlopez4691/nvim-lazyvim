local group = vim.api.nvim_create_augroup("BigFileDisable", { clear = true })

local MAX_FILESIZE = 1.5 * 1024 * 1024 -- 1.5 MB
local MAX_LINES = 5000

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  pattern = "*",
  callback = function(args)
    local lines = vim.fn.line("$")
    local filesize = vim.fn.getfsize(args.file)
    local is_big_file = filesize >= MAX_FILESIZE or lines >= MAX_LINES

    if is_big_file then
      vim.cmd("syntax off")

      pcall(function()
        vim.treesitter.stop(args.buf)
      end)

      -- Stop LSP clients attached to this buffer only
      local clients = vim.lsp.get_clients({ bufnr = args.buf })
      for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
      end

      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.cursorline = false
    end
  end,
})
