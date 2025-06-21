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

local toggleDocumentSymbols = function()
  vim.wo.winbar = ""
  Snacks.picker("lsp_symbols", {
    layout = {
      preset = "right",
    },
    filter = {
      default = symbols_filter,
    },
  })
end

local toggleWorkspaceSymbols = function()
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
end

-- Override original mapping for LSP symbols
keymap.set("n", "gO", function()
  toggleDocumentSymbols()
end, { desc = "Symbols in document" })

-- Override original mapping for go-to-file
keymap.set("n", "gf", function()
  if require("laravel").app("gf").cursor_on_resource() then
    return "<cmd>Laravel gf<CR>"
  else
    return "gf"
  end
end, { desc = "Go to file", noremap = false, expr = true })

wk.add({
  {
    mode = "n",
    "<leader>cs",
    function()
      toggleDocumentSymbols()
    end,
    desc = "Symbols in document",
  },
  {
    mode = "n",
    "<leader>cS",
    function()
      toggleWorkspaceSymbols()
    end,
    desc = "Symbols in workspace",
  },
})
