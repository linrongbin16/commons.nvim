local M = {}

local NVIM_010 = require("commons.version").ge("0.10")

---@param value string?
---@param rfc "rfc2396"|"rfc2732"|"rfc3986"|nil
---@return string?
M.encode = function(value, rfc)
  if type(value) ~= "string" then
    return nil
  end
  return NVIM_010 and vim.uri_encode(value, rfc) or require("commons._uri").uri_encode(value, rfc)
end

---@param value string?
---@return string?
M.decode = function(value)
  if type(value) ~= "string" then
    return nil
  end
  return NVIM_010 and vim.uri_decode(value) or require("commons._uri").uri_decode(value)
end

return M
