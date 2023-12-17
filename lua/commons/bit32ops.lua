local M = {}

do 
local _bitop = require("commons._bitop")

for k, v in pairs(_bitop) do
  M[k] = v
end
end

return M
