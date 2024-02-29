local M = {}

--- @param t table?
--- @return any
M.encode = function(t)
  if t == nil then
    return nil
  end
  return require("commons._MessagePack").encode(t)
end

--- @param d any
--- @return table?
M.decode = function(d)
  if d == nil then
    return nil
  end
  return require("commons._MessagePack").decode(d)
end

return M
