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

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
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
