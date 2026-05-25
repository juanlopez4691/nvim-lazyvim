-- Map various template/markup extensions and patterns to known filetypes
-- to silence LSP "unknown filetype" warnings for supported language servers.

vim.filetype.add({
  extension = {
    blade = "blade",
    twig = "twig",
    mdx = "markdown.mdx",
    postcss = "postcss",
    antlers = "antlers",
  },
  pattern = {
    [".*%.blade%.php"] = "blade",
    [".*%.twig"] = "twig",
    [".*%.antlers%.html"] = "antlers",
    [".*%.antlers%.php"] = "antlers",
    ["docker%-compose%.ya?ml"] = "yaml",
  },
})

pcall(function()
  vim.treesitter.language.register("html", "blade")
end)

pcall(function()
  vim.treesitter.language.register("html", "antlers")
end)

-- Correct buffers that incorrectly land on html for antlers files.
-- vim.filetype.add already handles BufRead/BufNewFile, so we only need
-- to catch late FileType assignments here.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function(event)
    local name = vim.api.nvim_buf_get_name(event.buf)
    if name:match("%.antlers%.html$") or name:match("%.antlers%.php$") or name:match("%.antlers$") then
      vim.bo[event.buf].filetype = "antlers"
    end
  end,
})
