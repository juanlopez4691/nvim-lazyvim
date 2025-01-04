local keymap = vim.keymap

-- Buffer navigation keymaps conflict with jump to screen top and bottom
keymap.del("n", "<S-h>")
keymap.del("n", "<S-l>")

-- Redefine buffer explorer keymap
keymap.del("n", "<leader>be")
keymap.set("n", "<leader>be", ":Neotree buffers toggle=true<cr>", { desc = "Buffer Explorer", silent = true })
