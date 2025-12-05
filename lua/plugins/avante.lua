return {
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "ravitemer/mcphub.nvim",
        build = "npm install -g mcp-hub@latest",
        config = function()
          require("mcphub").setup({
            -- Automatically approve safe tool calls
            auto_approve = function(params)
              if params.tool_name == "read_file" or params.tool_name == "list_files" then
                return true
              end
              -- Show confirmation for all other tools
              return false
            end,
          })
        end,
      },
    },
    opts = {
      web_search_engine = "Brave",
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },

      -- Ensure no tool conflicts by disabling redundant Avante tools
      disabled_tools = {
        "list_files",
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",
      },

      -- Dynamically configure the system prompt to include active MCP servers
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
  },
}
