return {
  "mfussenegger/nvim-dap",
  opts = function(_, opts)
    local dap = require("dap")

    if not dap.configurations.php and vim.fn.filereadable(".vscode/launch.json") == 0 then
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (Docker/Sail)",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (local)",
          port = 9003,
        },
      }
    end

    return opts
  end,
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        handlers = {
          php = function() end,
        },
      },
    },
  },
}
