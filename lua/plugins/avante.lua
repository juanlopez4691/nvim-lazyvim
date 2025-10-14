--- Providers Configuration
---@return table
local function configure_providers()
  return {
    copilot = {
      -- GitHub Copilot uses its own models optimized for code completion.
      -- No model selection or extra parameters are needed.
    },
    gemini = {
      -- @see https://ai.google.dev/gemini-api/docs/models/gemini
      model = "gemini-2.5-pro",
      extra_request_body = {
        temperature = 0.7, -- Adjusted for creativity in web development tasks
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
  }
end

--- Behaviour Configuration
---@return table
local function configure_behaviour()
  return {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = true,
  }
end

--- Dependencies Configuration
---@return table
local function configure_dependencies()
  return {
    -- Core dependencies
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",

    -- Input provider snacks
    "folke/snacks.nvim",

    -- Provider-specific dependencies
    "zbirenbaum/copilot.lua",

    -- Markdown rendering support
    {
      "OXY2DEV/markview.nvim",
      lazy = true,
    },

    -- Blink completion support
    {
      "saghen/blink.cmp",
      dependencies = {
        "Kaiser-Yang/blink-cmp-avante",
      },
      opts = {
        sources = {
          default = { "avante" },
          providers = {
            avante = {
              module = "blink-cmp-avante",
              name = "Avante",
              opts = {},
            },
          },
        },
      },
    },
  }
end

return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!

  ---@module 'avante'
  ---@type avante.Config
  opts = {
    instructions_file = "avante.md",
    provider = "copilot",
    providers = configure_providers(),
    behaviour = configure_behaviour(),
    selector = {
      provider = "snacks",
      provider_opts = {}, -- Options override for custom providers
    },
    web_search_engine = {
      provider = "brave",
    },
  },

  dependencies = configure_dependencies(),
}
