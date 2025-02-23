local keymap = vim.keymap
local wk = require("which-key")

-- Force code linting
wk.add({
  {
    mode = "n",
    "<leader>cL",
    function()
      require("lint").try_lint()
    end,
    desc = "Lint code",
  },
})

-- Remove default keymaps
keymap.del("n", "<leader>cs")
keymap.del("n", "<leader>cS")

-- Symbols outline for current buffer and workspace
local symbols_filter = {
  "Class",
  "Closure",
  "Constant",
  "Constructor",
  "Enum",
  "Field",
  "Function",
  "Interface",
  "Method",
  "Module",
  "Namespace",
  "Package",
  "Parameter",
  "Property",
  "Struct",
  "Trait",
  "Variable",
}

wk.add({
  {
    mode = "n",
    "<leader>cs",
    function()
      Snacks.picker("lsp_symbols", {
        layout = {
          preset = "right",
        },
        filter = {
          default = symbols_filter,
        },
      })
    end,
  },
  {
    mode = "n",
    "<leader>cS",
    function()
      Snacks.picker("lsp_workspace_symbols", {
        layout = {
          preset = "vertical",
          layout = {
            width = 0.9,
          },
        },
        filter = {
          default = symbols_filter,
        },
      })
    end,
  },
})
