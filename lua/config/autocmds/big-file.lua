local group = vim.api.nvim_create_augroup("BigFileDisable", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  pattern = "*",
  callback = function(args)
    local filepath = args.match or vim.api.nvim_buf_get_name(0)
    local max_filesize = 10 * 1024 * 1024 -- 1 MiB
    local ok, stats = pcall(vim.uv.fs_stat, filepath)

    if ok and stats and stats.size > max_filesize then
      vim.cmd("syntax off")
      pcall(function()
        vim.treesitter.stop(vim.api.nvim_get_current_buf())
      end)
      vim.cmd("silent! LspStop")
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
    end
  end,
})
