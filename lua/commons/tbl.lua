local M = {}

--- @param t any?
--- @return boolean
M.tbl_empty = function(t)
  return type(t) ~= "table" or vim.tbl_isempty(t)
end

--- @param t any?
--- @return boolean
M.tbl_not_empty = function(t)
  return type(t) == "table" and not vim.tbl_isempty(t)
end

--- @param l any?
--- @return boolean
M.list_empty = function(l)
  return type(l) ~= "table" or #l == 0
end

--- @param l any?
--- @return boolean
M.list_not_empty = function(l)
  return type(l) == "table" and #l > 0
end

return M
