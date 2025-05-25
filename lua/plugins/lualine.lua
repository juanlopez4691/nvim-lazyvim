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
