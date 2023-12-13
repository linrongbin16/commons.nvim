local M = {}

--- @param t table?   lua table.
--- @return string?   returns json string.
M.encode = (vim.fn.has("nvim-0.9") and vim.json ~= nil) and vim.json.encode
  or require("commons.actboy168_json").encode

--- @param j string?  json string.
--- @return table?    returns lua table.
M.decode = (vim.fn.has("nvim-0.9") and vim.json ~= nil) and vim.json.decode
  or require("commons.actboy168_json").decode

return M
