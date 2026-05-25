local keymap = vim.keymap

-- Buffer navigation keymaps conflict with jump to screen top and bottom
pcall(keymap.del, "n", "<S-h>")
pcall(keymap.del, "n", "<S-l>")
