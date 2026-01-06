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

-- Show current macro recording register (if any)
local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "recording @" .. reg
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
  init = function()
    -- Restore LazyVim default: hide statusline on starter page
    vim.g.lualine_laststatus = vim.o.laststatus

    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end

    -- Restore laststatus after lazy plugins initialized
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      once = true,
      callback = function()
        vim.o.laststatus = vim.g.lualine_laststatus
      end,
    })

    -- Refresh lualine when macro recording starts/stops
    local function refresh()
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.refresh({ place = { "statusline" } })
      end
    end

    vim.api.nvim_create_autocmd("RecordingEnter", { callback = refresh })
    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        vim.defer_fn(refresh, 50)
      end,
    })
  end,
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
        {
          macro_recording,
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
          separator = { left = "" },
          color = { fg = "#000000", bg = "#f5a524" },
        },
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
