return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  event = "LazyFile",
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" -- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
    },
  },
  config = function()
    ---@diagnostic disable: undefined-field
    local opencode_cmd = "opencode --port"
    ---@diagnostic disable-next-line: undefined-doc-name, type-not-found
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = "right",
        enter = false,
        on_win = function(win)
          -- Set up keymaps and cleanup for an arbitrary terminal
          require("opencode.terminal").setup(win.win)
        end,
      },
    }

    ---@diagnostic disable-next-line: undefined-doc-name, type-not-found
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    -- Required for `opts.events.reload`
    vim.o.autoread = true

    local wk = require("which-key")
    wk.add({
      { "<leader>o", group = "opencode", desc = "OpenCode", icon = "󰚩 " },

      {
        "<leader>oB",
        function()
          require("opencode").ask("@buffers: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (buffers)…",
      },
      {
        "<leader>ob",
        function()
          require("opencode").ask("@buffer: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (buffer)…",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode…",
      },
      {
        "<leader>od",
        function()
          require("opencode").ask("@diff ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (diff)…",
      },
      {
        "<leader>om",
        function()
          require("opencode").ask("@marks ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (marks)…",
      },
      {
        "<leader>ov",
        function()
          require("opencode").ask("@visible ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask about visible text",
      },
      {
        "<leader>ox",
        function()
          require("opencode").ask("@quickfix ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (quickfix)…",
      },
      {
        "<leader>oi",
        function()
          require("opencode").ask("", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (empty)",
      },
      {
        "<leader>oI",
        function()
          require("opencode").ask("@this: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Ask Opencode (context)…",
      },
      {
        "<leader>of",
        function()
          require("opencode").ask("@this fix: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Fix with Opencode",
      },
      {
        "<leader>oe",
        function()
          require("opencode").ask("@this explain: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Explain with Opencode",
      },
      {
        "<leader>or",
        function()
          require("opencode").ask("@this review: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Review with Opencode",
      },
      {
        "<leader>oo",
        function()
          require("opencode").ask("@this optimize: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Optimize with Opencode",
      },
      {
        "<leader>os",
        function()
          require("opencode").ask("@this test: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Test with Opencode",
      },
      {
        "<leader>oD",
        function()
          require("opencode").ask("@this diagnose: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Diagnose with Opencode",
      },

      {
        "<leader>og",
        function()
          return require("opencode").operator("@this ")
        end,
        expr = true,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Add range to Opencode",
      },
      {
        "<leader>ol",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        mode = "n",
        icon = "󰚩  ",
        desc = "Add line to Opencode",
      },
      {
        "go",
        function()
          return require("opencode").operator("@this ")
        end,
        expr = true,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Add range to Opencode (operator)",
      },
      {
        "goo",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        mode = { "n" },
        desc = "Add line to Opencode (operator)",
      },

      {
        "<leader>oc",
        function()
          require("opencode").command("session.close")
        end,
        mode = { "n" },
        icon = "󰚩  ",
        desc = "Close session",
      },
      {
        "<leader>on",
        function()
          require("opencode").command("session.new")
        end,
        mode = { "n" },
        icon = "󰚩  ",
        desc = "New session",
      },

      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        mode = { "n", "t" },
        icon = "󰚩  ",
        desc = "Toggle Opencode",
      },
      {
        "<leader>oq",
        function()
          require("opencode").stop()
        end,
        mode = { "n", "t" },
        icon = "󰚩  ",
        desc = "Stop/Close OpenCode",
      },
      -- Action/Selection
      {
        "<leader>oX",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        icon = "󰚩  ",
        desc = "Execute Opencode action…",
      },

      {
        "<leader>ou",
        function()
          require("opencode").command("session.half.page.up")
        end,
        mode = "n",
        icon = "󰚩  ",
        desc = "Scroll Opencode up",
      },
      {
        "<leader>oj",
        function()
          require("opencode").command("session.half.page.down")
        end,
        mode = "n",
        icon = "󰚩  ",
        desc = "Scroll Opencode down",
      },
    })
    ---@diagnostic enable: undefined-field
  end,
}
