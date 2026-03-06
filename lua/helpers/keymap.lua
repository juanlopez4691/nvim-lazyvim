--[[
  Helper functions for keymaps.
]]

--[[
  Set a keymap.

  This is a proxy function for vim.keymap.set to avoid conflicts
  when this module is required in other modules that also use vim.keymap.set.

  @param mode The mode to set the keymap for (e.g. "n", "i", "v", etc.)
  @param key The key to set
  @param action The action to set the key to
  @param opts (optional) A table of options to pass to vim.keymap.set
]]
local function set(mode, key, action, opts)
  vim.keymap.set(mode, key, action, opts)
end

--[[
  Delete a keymap.

  This is a proxy function for vim.keymap.set to avoid conflicts
  when this module is required in other modules that also use vim.keymap.det.

  @param mode The mode to delete the keymap from (e.g. "n", "i", "v", etc.)
  @param key The key to delete
]]
local function del(mode, key)
  vim.keymap.del(mode, key)
end

--[[
  Set multiple keys to the same action.

  @param mode The mode to set the keymaps for (e.g. "n", "i", "v", etc.)
  @param keys A list of keys to set
  @param action The action to set the keys to
  @param opts (optional) A table of options to pass to vim.keymap.set
]]
local function set_multi_keys(mode, keys, action, opts)
  for _, key in ipairs(keys) do
    vim.keymap.set(mode, key, action, opts)
  end
end

return {
  set = set,
  del = del,
  set_multi_keys = set_multi_keys,
}
