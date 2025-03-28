return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      lazy = true,
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "gemini",
    gemini = {
      -- @see https://ai.google.dev/gemini-api/docs/models/gemini
      model = "gemini-2.0-flash-thinking-exp-01-21",
      -- model = "gemini-1.5-pro-exp-0827",
      -- model = "gemini-1.5-flash",
      temperature = 0,
      max_tokens = 8192,
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
    file_selector = {
      provider = "snacks",
      -- Options override for custom providers
      provider_opts = {},
    },
    web_search_engine = {
      provider = "brave", -- tavily, serpapi, searchapi, google or kagi
    },
  },
}
