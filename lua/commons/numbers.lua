-- Numbers utilities

local M = {}

-- math
M.INT32_MAX = 2147483647
M.INT32_MIN = -2147483648

--- @param value number
--- @param left number?   by default INT32_MIN
--- @param right number?  by default INT32_MAX
--- @return number
M.bound = function(value, left, right)
  return math.min(math.max(left or M.INT32_MIN, value), right or M.INT32_MAX)
end

local IncrementalId = 0

--- @return integer
M.incremental_id_i32 = function()
  if IncrementalId >= M.INT32_MAX then
    IncrementalId = 1
  else
    IncrementalId = IncrementalId + 1
  end
  return IncrementalId
end

return M
