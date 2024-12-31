return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "\\",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      -- "document_symbols",
    },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = "󰉓 Files" },
        { source = "buffers", display_name = " Buffers" },
        -- { source = "document_symbols", display_name = " Symbols" },
        { source = "git_status", display_name = "󰊢 Git" },
        -- Add custom sources here
      },
    },
    filesystem = {
      window = {
        position = "left",
        mappings = {
          ["\\"] = "close_window",
        },
      },
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- Add any files or directories you want to hide
          ".git",
          "node_modules",
        },
      },
    },
    window = {
      mappings = {
        ["P"] = "noop",
        ["<Tab>"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
    },
  },
}
