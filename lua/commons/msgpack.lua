local M = {}

--- @param t table?
--- @return integer[]|nil
M.encode = function(t)
  if t == nil then
    return nil
  end
  return require("commons._MessagePack").encode(t)
end

--- @param d integer[]|nil
--- @return table?
M.decode = function(d)
  if d == nil then
    return nil
  end
  return require("commons._MessagePack").decode(d)
end

return M
