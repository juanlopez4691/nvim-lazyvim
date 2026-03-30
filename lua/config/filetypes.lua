-- Map various template/markup extensions and patterns to known filetypes
-- to silence LSP “unknown filetype” warnings for supported language servers.

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

vim.treesitter.language.register("html", "blade")
vim.treesitter.language.register("html", "twig")
vim.treesitter.language.register("twig", "twig")
pcall(function()
  vim.treesitter.language.register("html", "antlers")
end)

-- Force antlers filetype for common Statamic template patterns even if filetype detection
-- runs late; also correct buffers that still land on html.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
  pattern = { "*.antlers.html", "*.antlers.php", "html" },
  callback = function(event)
    local name = vim.api.nvim_buf_get_name(event.buf)
    if name:match("%.antlers%.html$") or name:match("%.antlers%.php$") or name:match("%.antlers$") then
      vim.bo[event.buf].filetype = "antlers"
    end
  end,
})
