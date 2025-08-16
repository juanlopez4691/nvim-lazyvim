return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "folke/snacks.nvim", -- for input provider snacks
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
    "zbirenbaum/copilot.lua",
  },
  opts = {
    input = {
      provider = "snacks", -- "native" | "dressing" | "snacks"
      provider_opts = {
        -- Snacks input configuration
        title = "Avante Input",
        icon = " ",
        placeholder = "Enter your API key...",
      },
    },
    provider = "gemini",
    providers = {
      copilot = {}, -- leverages copilot.lua session internally
      gemini = {
        -- @see https://ai.google.dev/gemini-api/docs/models/gemini
        model = "gemini-2.5-pro",
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },
      mistral = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        model = "mistral-large-latest",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
      },
      openai = {
        __inherited_from = "openai",
        api_key_name = "OPENAI_API_KEY",
        model = "gpt-4o",
      },
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
