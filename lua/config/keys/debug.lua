local keymap = vim.keymap
local wk = require("which-key")

local function safe_dap_call(fn_name)
  return function()
    local ok, dap = pcall(require, "dap")
    if not ok then
      return vim.notify("nvim-dap is not installed", vim.log.levels.WARN)
    end
    dap[fn_name]()
  end
end

local function safe_dapui_call(fn_name)
  return function()
    local ok, dapui = pcall(require, "dapui")
    if not ok then
      return vim.notify("nvim-dapui is not installed", vim.log.levels.WARN)
    end
    dapui[fn_name]()
  end
end

local function set_breakpoint_condition()
  local ok, dap = pcall(require, "dap")
  if not ok then
    return vim.notify("nvim-dap is not installed", vim.log.levels.WARN)
  end
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

local function terminate()
  safe_dapui_call("close")()
  safe_dap_call("terminate")()
end

-- Each action is bound twice: under <leader>d… (described) and on its function key.
local actions = {
  { key = "b", fkey = "F9", action = safe_dap_call("toggle_breakpoint"), desc = "[F9] Toggle Breakpoint" },
  { key = "B", fkey = "F21", action = set_breakpoint_condition, desc = "[S-F9] Breakpoint Condition" },
  { key = "c", fkey = "F5", action = safe_dap_call("continue"), desc = "[F5] Run/Continue" },
  { key = "C", fkey = "F17", action = safe_dap_call("run_to_cursor"), desc = "[S-F5] Run to Cursor" },
  { key = "i", fkey = "F11", action = safe_dap_call("step_into"), desc = "[F11] Step Into" },
  { key = "o", fkey = "F23", action = safe_dap_call("step_out"), desc = "[S-F11] Step Out" },
  { key = "O", fkey = "F10", action = safe_dap_call("step_over"), desc = "[F10] Step Over" },
  { key = "j", fkey = "F6", action = safe_dap_call("down"), desc = "[F6] Down" },
  { key = "k", fkey = "F18", action = safe_dap_call("up"), desc = "[S-F6] Up" },
  { key = "l", fkey = "F29", action = safe_dap_call("run_last"), desc = "[C-F5] Run Last" },
  { key = "P", fkey = "F7", action = safe_dap_call("pause"), desc = "[F7] Pause" },
  { key = "t", fkey = "F8", action = terminate, desc = "[F8] Terminate" },
  { key = "e", fkey = "F12", action = safe_dapui_call("eval"), desc = "[F12] Eval" },
}

-- Remove the default keymaps we redefine below
for _, a in ipairs(actions) do
  pcall(keymap.del, "n", "<leader>d" .. a.key)
end
pcall(keymap.del, "n", "<leader>dg")

local spec = { mode = { "n" } }
for _, a in ipairs(actions) do
  table.insert(spec, { "<leader>d" .. a.key, a.action, desc = a.desc })
  table.insert(spec, { "<" .. a.fkey .. ">", a.action })
end

wk.add(spec)
