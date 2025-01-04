local keymap = vim.keymap

-- Redefine buffer explorer keymap
keymap.del("n", "<leader>be")
keymap.set("n", "<leader>be", ":Neotree buffers toggle=true<cr>", { desc = "Buffer Explorer", silent = true })
