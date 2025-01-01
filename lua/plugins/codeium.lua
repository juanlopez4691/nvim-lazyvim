return {
  "Exafunction/codeium.nvim",
  opts = {
    virtual_text = {
      key_bindings = {
        -- Accept the current completion.
        accept = "<Tab>",
        -- Accept the next word.
        accept_word = "<M-w>",
        -- Accept the next line.
        accept_line = "<M-l>",
        -- Clear the virtual text.
        clear = "<M-x>",
        -- Cycle to the next completion.
        next = "<M-]>",
        -- Cycle to the previous completion.
        prev = "<M-[>",
      },
    },
  },
}
