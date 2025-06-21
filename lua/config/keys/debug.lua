local keymap = vim.keymap
local wk = require("which-key")

-- Remove some default keymaps
keymap.del("n", "<leader>dB")
keymap.del("n", "<leader>db")
keymap.del("n", "<leader>dc")
keymap.del("n", "<leader>dC")
keymap.del("n", "<leader>dg")
keymap.del("n", "<leader>di")
keymap.del("n", "<leader>dj")
keymap.del("n", "<leader>dk")
keymap.del("n", "<leader>dl")
keymap.del("n", "<leader>do")
keymap.del("n", "<leader>dO")
keymap.del("n", "<leader>dP")
keymap.del("n", "<leader>dt")
keymap.del("n", "<leader>de")

wk.add({
  mode = { "n" },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "[F9] Toggle Breakpoint",
  },
  {
    "<F9>",
    function()
      require("dap").toggle_breakpoint()
    end,
  },
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "[S-F9] Breakpoint Condition",
  },
  {
    "<F21>",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
  },
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "[F5] Run/Continue",
  },
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
  },
  {
    "<leader>dC",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "[S-F5] Run to Cursor",
  },
  {
    "<F17>",
    function()
      require("dap").run_to_cursor()
    end,
  },
  {
    "<leader>di",
    function()
      require("dap").step_into()
    end,
    desc = "[F11] Step Into",
  },
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
  },
  {
    "<leader>do",
    function()
      require("dap").step_out()
    end,
    desc = "[S-F11] Step Out",
  },
  {
    "<F23>",
    function()
      require("dap").step_out()
    end,
  },
  {
    "<leader>dO",
    function()
      require("dap").step_over()
    end,
    desc = "[F10] Step Over",
  },
  {
    "<F10>",
    function()
      require("dap").step_over()
    end,
  },
  {
    "<leader>dj",
    function()
      require("dap").down()
    end,
    desc = "[F6] Down",
  },
  {
    "<F6>",
    function()
      require("dap").down()
    end,
  },
  {
    "<leader>dk",
    function()
      require("dap").up()
    end,
    desc = "[S-F6] Up",
  },
  {
    "<F18>",
    function()
      require("dap").up()
    end,
  },
  {
    "<leader>dl",
    function()
      require("dap").run_last()
    end,
    desc = "[C-F5] Run Last",
  },
  {
    "<F29>",
    function()
      require("dap").run_last()
    end,
  },
  {
    "<leader>dP",
    function()
      require("dap").pause()
    end,
    desc = "[F7] Pause",
  },
  {
    "<F7>",
    function()
      require("dap").pause()
    end,
  },
  {
    "<leader>dt",
    function()
      require("dapui").close()
      require("dap").terminate()
    end,
    desc = "[F8] Terminate",
  },
  {
    "<F8>",
    function()
      require("dapui").close()
      require("dap").terminate()
    end,
  },
  {
    "<leader>de",
    function()
      require("dapui").eval()
    end,
    desc = "[F12] Eval",
  },
  {
    "<F12>",
    function()
      require("dapui").eval()
    end,
  },
})
