local M = {}

local _bitop = require("commons._bitop")

for k, v in pairs(_bitop) do
  M[k] = v
end

return M
