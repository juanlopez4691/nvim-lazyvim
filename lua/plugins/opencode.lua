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
      },
    }

    ---@diagnostic disable-next-line: undefined-doc-name, type-not-found
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    -- Required for `opts.events.reload`
    vim.o.autoread = true

    local wk = require("which-key")
    local icon = "󰚩  "

    -- Prompts sent with `ask`; all share the same mode, icon and options.
    local prompts = {
      { "oB", "@buffers: ", "Ask Opencode (buffers)…" },
      { "ob", "@buffer: ", "Ask Opencode (buffer)…" },
      { "od", "@diff ", "Ask Opencode (diff)…" },
      { "om", "@marks ", "Ask Opencode (marks)…" },
      { "ov", "@visible ", "Ask about visible text" },
      { "ox", "@quickfix ", "Ask Opencode (quickfix)…" },
      { "oi", "", "Ask Opencode (empty)" },
      { "oI", "@this: ", "Ask Opencode (context)…" },
      { "of", "@this fix: ", "Fix with Opencode" },
      { "oe", "@this explain: ", "Explain with Opencode" },
      { "or", "@this review: ", "Review with Opencode" },
      { "oo", "@this optimize: ", "Optimize with Opencode" },
      { "os", "@this test: ", "Test with Opencode" },
      { "oD", "@this diagnose: ", "Diagnose with Opencode" },
    }

    -- Session commands driven by `command`.
    local commands = {
      { "oc", "session.close", "Close session", { "n" } },
      { "on", "session.new", "New session", { "n" } },
      { "ou", "session.half.page.up", "Scroll Opencode up", "n" },
      { "oj", "session.half.page.down", "Scroll Opencode down", "n" },
    }

    local spec = {
      { "<leader>o", group = "opencode", desc = "OpenCode", icon = "󰚩 " },

      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        mode = { "n", "x" },
        icon = icon,
        desc = "Ask Opencode…",
      },

      {
        "<leader>og",
        function()
          return require("opencode").operator("@this ")
        end,
        expr = true,
        mode = { "n", "x" },
        icon = icon,
        desc = "Add range to Opencode",
      },
      {
        "<leader>ol",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        mode = "n",
        icon = icon,
        desc = "Add line to Opencode",
      },
      {
        "go",
        function()
          return require("opencode").operator("@this ")
        end,
        expr = true,
        mode = { "n", "x" },
        icon = icon,
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
        "<leader>ot",
        function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
        mode = { "n", "t" },
        icon = icon,
        desc = "Toggle Opencode",
      },
      {
        "<leader>oq",
        function()
          local win = require("snacks.terminal").get(opencode_cmd, { create = false })
          if win then
            win:close()
          end
        end,
        mode = { "n", "t" },
        icon = icon,
        desc = "Stop/Close OpenCode",
      },
      -- Action/Selection
      {
        "<leader>oX",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        icon = icon,
        desc = "Execute Opencode action…",
      },
    }

    for _, prompt in ipairs(prompts) do
      local text = prompt[2]
      table.insert(spec, {
        "<leader>" .. prompt[1],
        function()
          require("opencode").ask(text, { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        icon = icon,
        desc = prompt[3],
      })
    end

    for _, command in ipairs(commands) do
      local name = command[2]
      table.insert(spec, {
        "<leader>" .. command[1],
        function()
          require("opencode").command(name)
        end,
        mode = command[4],
        icon = icon,
        desc = command[3],
      })
    end

    wk.add(spec)
    ---@diagnostic enable: undefined-field
  end,
}
