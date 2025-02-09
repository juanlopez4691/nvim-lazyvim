local keymap = vim.keymap

-- Buffer navigation keymaps conflict with jump to screen top and bottom
keymap.del("n", "<S-h>")
keymap.del("n", "<S-l>")
