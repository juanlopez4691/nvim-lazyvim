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

-- Remove some default keymaps
pcall(keymap.del, "n", "<leader>dB")
pcall(keymap.del, "n", "<leader>db")
pcall(keymap.del, "n", "<leader>dc")
pcall(keymap.del, "n", "<leader>dC")
pcall(keymap.del, "n", "<leader>dg")
pcall(keymap.del, "n", "<leader>di")
pcall(keymap.del, "n", "<leader>dj")
pcall(keymap.del, "n", "<leader>dk")
pcall(keymap.del, "n", "<leader>dl")
pcall(keymap.del, "n", "<leader>do")
pcall(keymap.del, "n", "<leader>dO")
pcall(keymap.del, "n", "<leader>dP")
pcall(keymap.del, "n", "<leader>dt")
pcall(keymap.del, "n", "<leader>de")

wk.add({
  mode = { "n" },
  {
    "<leader>db",
    safe_dap_call("toggle_breakpoint"),
    desc = "[F9] Toggle Breakpoint",
  },
  {
    "<F9>",
    safe_dap_call("toggle_breakpoint"),
  },
  {
    "<leader>dB",
    function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return vim.notify("nvim-dap is not installed", vim.log.levels.WARN)
      end
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "[S-F9] Breakpoint Condition",
  },
  {
    "<F21>",
    function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return vim.notify("nvim-dap is not installed", vim.log.levels.WARN)
      end
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
  },
  {
    "<leader>dc",
    safe_dap_call("continue"),
    desc = "[F5] Run/Continue",
  },
  {
    "<F5>",
    safe_dap_call("continue"),
  },
  {
    "<leader>dC",
    safe_dap_call("run_to_cursor"),
    desc = "[S-F5] Run to Cursor",
  },
  {
    "<F17>",
    safe_dap_call("run_to_cursor"),
  },
  {
    "<leader>di",
    safe_dap_call("step_into"),
    desc = "[F11] Step Into",
  },
  {
    "<F11>",
    safe_dap_call("step_into"),
  },
  {
    "<leader>do",
    safe_dap_call("step_out"),
    desc = "[S-F11] Step Out",
  },
  {
    "<F23>",
    safe_dap_call("step_out"),
  },
  {
    "<leader>dO",
    safe_dap_call("step_over"),
    desc = "[F10] Step Over",
  },
  {
    "<F10>",
    safe_dap_call("step_over"),
  },
  {
    "<leader>dj",
    safe_dap_call("down"),
    desc = "[F6] Down",
  },
  {
    "<F6>",
    safe_dap_call("down"),
  },
  {
    "<leader>dk",
    safe_dap_call("up"),
    desc = "[S-F6] Up",
  },
  {
    "<F18>",
    safe_dap_call("up"),
  },
  {
    "<leader>dl",
    safe_dap_call("run_last"),
    desc = "[C-F5] Run Last",
  },
  {
    "<F29>",
    safe_dap_call("run_last"),
  },
  {
    "<leader>dP",
    safe_dap_call("pause"),
    desc = "[F7] Pause",
  },
  {
    "<F7>",
    safe_dap_call("pause"),
  },
  {
    "<leader>dt",
    function()
      safe_dapui_call("close")()
      safe_dap_call("terminate")()
    end,
    desc = "[F8] Terminate",
  },
  {
    "<F8>",
    function()
      safe_dapui_call("close")()
      safe_dap_call("terminate")()
    end,
  },
  {
    "<leader>de",
    safe_dapui_call("eval"),
    desc = "[F12] Eval",
  },
  {
    "<F12>",
    safe_dapui_call("eval"),
  },
})
