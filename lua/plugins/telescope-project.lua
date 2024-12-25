return {
  "nvim-telescope/telescope-project.nvim",
  config = function()
    LazyVim.on_load("telescope", function()
      require("telescope").load_extension("project")
    end)
  end,
}
