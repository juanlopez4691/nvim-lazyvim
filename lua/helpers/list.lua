--[[
  Checks if a list contains a given value

  @param list (table) The list
  @param value (mixed) The value to find

  @return (bool) True if the list contains the value
]]
local function contains_value(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end

return {
  contains_value = contains_value,
}
