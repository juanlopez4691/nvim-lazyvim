return {
  "snacks.nvim",
  opts = {
    dashboard = {
      width = 40,
      sections = function()
        local header = [[
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]
        local function greeting()
          local hour = tonumber(vim.fn.strftime("%H"))
          -- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
          local part_id = math.floor((hour + 6) / 8) + 1
          local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
          local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
          return ("Good %s, %s"):format(day_part, username)
        end

        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#0dd95b" })

        return {
          { padding = 0, align = "center", text = { header, hl = "SnacksDashboardHeader" } },
          { padding = 2, align = "center", text = { greeting(), hl = "SnacksDashboardHeader" } },
          {
            title = "Builtin Actions",
            indent = 2,
            padding = 1,
            {
              icon = " ",
              key = "p",
              desc = "Find Project",
              action = function()
                local project_base_path = vim.fn.expand("~/Projects")
                Snacks.picker.projects({
                  dev = {
                    project_base_path,
                    project_base_path .. "/Sites/personal/",
                    project_base_path .. "/Sites/somoscuatro/",
                  },
                })
              end,
            },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files (cwd)",
              action = function()
                Snacks.picker.recent({ filter = { cwd = true } })
              end,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          {
            title = "Sessions",
            indent = 2,
            padding = 1,
            {
              icon = "󱐋 ",
              key = "S",
              desc = "List Sessions",
              action = function()
                require("persistence").select()
              end,
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          },
          {
            title = "Maintenance Actions",
            indent = 2,
            padding = 2,
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "z", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󱁤 ", key = "m", desc = "Mason", action = ":Mason" },
          },
          { section = "startup" },
        }
      end,
    },
  },
}
