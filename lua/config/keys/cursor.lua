local keymap = vim.keymap

-- Fixes issues with Snacks smooth scroll and centering on screen
-- See https://github.com/folke/snacks.nvim/discussions/1030#discussioncomment-12109404
local smoothScroll = function(keys)
  vim.wo.scrolloff = 999
  vim.defer_fn(function()
    vim.wo.scrolloff = 8
  end, 500)
  return keys
end

vim.keymap.set("n", "<C-d>", function()
  return smoothScroll("<C-d>")
end, { expr = true, desc = "Scroll half page down" })

vim.keymap.set("n", "<C-u>", function()
  return smoothScroll("<C-u>")
end, { expr = true, desc = "Scroll half page down" })

keymap.set("n", "G", "GGzz", { desc = "Scroll to end" })
