return {
  "nvim-telescope/telescope-file-browser.nvim",
  config = function()
    LazyVim.on_load("telescope", function()
      require("telescope").load_extension("file_browser")
    end)
  end,
}
