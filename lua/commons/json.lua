local M = {}

local NVIM_090 = require("commons.version").ge("0.9")

--- @param t table?
--- @return string?
M.encode = function(t)
  if t == nil then
    return nil
  end
  return NVIM_090 and vim.json.encode(t) or require("commons._json").encode(t)
end

--- @param j string?
--- @return table?
M.decode = function(j)
  if j == nil then
    return nil
  end
  return NVIM_090 and vim.json.decode(j) or require("commons._json").decode(j)
end

return M
