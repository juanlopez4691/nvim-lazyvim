local keymap = vim.keymap

-- Fixes issues with Snacks smooth scroll and centering on screen
-- See https://github.com/folke/snacks.nvim/discussions/1030#discussioncomment-12109404
local smoothScroll_timer = nil
local smoothScroll = function(keys)
  ---@diagnostic disable-next-line: unnecessary-if
  if smoothScroll_timer then
    smoothScroll_timer:close()
  end
  vim.wo.scrolloff = 999
  smoothScroll_timer = vim.defer_fn(function()
    vim.wo.scrolloff = 8
    smoothScroll_timer = nil
  end, 500)
  return keys
end

vim.keymap.set("n", "<C-d>", function()
  return smoothScroll("<C-d>")
end, { expr = true, desc = "Scroll half page down" })

vim.keymap.set("n", "<C-u>", function()
  return smoothScroll("<C-u>")
end, { expr = true, desc = "Scroll half page up" })

keymap.set("n", "G", "Gzz", { desc = "Scroll to end" })

keymap.set("n", "n", "nzz", { desc = "Next occurrence" })
keymap.set("n", "N", "Nzz", { desc = "Previous occurrence" })
