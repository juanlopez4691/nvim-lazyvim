return {
  "adalessa/laravel.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
  },
  ft = { "php", "blade" },
  event = { "BufEnter composer.json" },
  -- stylua: ignore
  keys = {
    { "<leader>l", "", desc = "+laravel" },
    { "<leader>ll", function() Laravel.pickers.laravel() end, desc = "Laravel Picker" },
    { "<leader>la", function() Laravel.pickers.artisan() end, desc = "Artisan Picker" },
    { "<leader>lr", function() Laravel.pickers.routes() end, desc = "Routes Picker" },
    { "<leader>lm", function() Laravel.pickers.make() end, desc = "Make Picker" },
    { "<leader>lc", function() Laravel.pickers.commands() end, desc = "Commands Picker" },
    { "<leader>lo", function() Laravel.pickers.resources() end, desc = "Resources Picker" },
    { "<leader>lt", function() Laravel.commands.run("actions") end, desc = "Actions Picker" },
    { "<leader>lu", function() Laravel.commands.run("hub") end, desc = "Hub" },
    { "<leader>lp", function() Laravel.commands.run("command_center") end, desc = "Command Center" },
    { "<c-g>", function() Laravel.commands.run("view:finder") end, desc = "Laravel: View Finder" },
    {
      "gf",
      function()
        local ok, res = pcall(function()
          if Laravel.app("gf").cursorOnResource() then
            return "<cmd>lua Laravel.commands.run('gf')<cr>"
          end
        end)
        if not ok or not res then
          return "gf"
        end
        return res
      end,
      expr = true,
      noremap = true,
    },
  },
  opts = {
    features = {
      pickers = {
        provider = "snacks",
      },
    },
  },
}
