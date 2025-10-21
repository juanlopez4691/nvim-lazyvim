-- Display attached LSP clients in the status line
local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return "No LSPs"
  end
  return table.concat(
    vim.tbl_map(function(client)
      local icons = {
        lua_ls = "",
        pyright = "",
        tsserver = "",
        gopls = "",
        rust_analyzer = "",
        clangd = "",
        intelephense = "",
        jsonls = "",
        tailwindcss = "󱏿",
        dockerls = "",
        taplo = "",
        marksman = "",
        vtsls = "",
        cssls = "",
        html = "",
      }
      local icon = icons[client.name] or ""
      return string.format("%s %s", icon, client.name)
    end, clients),
    ", "
  )
end

local filename = {
  "filename",
  path = 4,
  newfile_status = true,
  symbols = {
    modified = "",
    readonly = "",
    unnamed = "",
    newfile = "",
  },
}

local disabled_filetypes = {
  "dap-repl",
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      disabled_filetypes = {
        winbar = disabled_filetypes,
        inactive_winbar = disabled_filetypes,
      },
    },
    sections = {
      lualine_c = {
        LazyVim.lualine.root_dir(),
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      },
      lualine_x = {
        { lsp_clients, color = { fg = "#7aa2f7" } }, -- Subtle bluish color
      },
    },
    winbar = {
      lualine_a = {
        filename,
      },
      lualine_z = {
        { "diagnostics", separator = { left = "" }, color = { bg = "NONE" } },
      },
    },
    inactive_winbar = {
      lualine_a = {
        filename,
      },
      lualine_z = {
        { "diagnostics", separator = { left = "" }, colored = false, color = { bg = "NONE" } },
      },
    },
  },
}
