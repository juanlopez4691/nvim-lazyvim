return {
  "olimorris/codecompanion.nvim",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    display = {
      chat = {
        window = {
          opts = {
            number = false,
            relativenumber = false,
          },
        },
      },
      action_palette = {
        width = 95,
        height = 20,
        prompt = "Prompt ",
        provider = "snacks",
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
    },
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      },
    },
  },
}
