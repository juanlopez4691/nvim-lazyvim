return {
  "adibhanna/laravel.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  ft = { "php", "blade" },
  event = { "VeryLazy" },
  config = function()
    local laravel = require("laravel")
    local artisan = require("laravel.artisan")

    laravel.setup({
      notifications = false,
      debug = false,
    })

    vim.api.nvim_create_user_command("Artisan", function(opts)
      artisan.run_command(opts.args)
    end, {
      nargs = "*",
      complete = function()
        return artisan.get_completions()
      end,
      desc = "Run Laravel Artisan commands",
    })
  end,
}
