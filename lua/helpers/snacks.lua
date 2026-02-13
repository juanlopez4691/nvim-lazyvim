--[[
 -- Closes the Snacks explorer picker if it is currently open.
 --]]
local function close_snacks_explorer()
  local pickers = Snacks.picker.get({ source = "explorer" })

  if not pickers or #pickers == 0 then
    return
  end

  local explorer = pickers and pickers[1]

  if explorer and explorer.close then
    explorer:close()
  end
end

return {
  close_snacks_explorer = close_snacks_explorer,
}
