local M = {}

-- int32 max/min
M.INT32_MAX = 2147483647
M.INT32_MIN = -2147483648

--- @param a number
--- @param b number
--- @return boolean   returns `true` if equals, `false` if not.
M.eq = function(a, b)
  return type(a) == "number" and type(b) == "number" and a == b
end

--- @param a number
--- @param b number
--- @return boolean   returns `true` if not equals, `false` if equals.
M.ne = function(a, b)
  return not M.eq(a, b)
end

--- @param a number
--- @param b number
--- @return boolean   returns `true` if a is greater than b, `false` if not.
M.gt = function(a, b)
  return type(a) == "number" and type(b) == "number" and a > b
end

--- @param a number
--- @param b number
--- @return boolean   returns `true` if a is greater equals to b, `false` if not.
M.ge = function(a, b)
  return M.gt(a, b) or M.eq(a, b)
end

--- @param a number
--- @param b number
--- @return boolean   returns `true` if a is less than b, `false` if not.
M.lt = function(a, b)
  return type(a) == "number" and type(b) == "number" and a < b
end

--- @param a number
--- @param b number
--- @return boolean   returns `true` if a is less equals to b, `false` if not.
M.le = function(a, b)
  return M.lt(a, b) or M.eq(a, b)
end

--- @param value number
--- @param left number?   lower bound, by default INT32_MIN
--- @param right number?  upper bound, by default INT32_MAX
--- @return number
M.bound = function(value, left, right)
  return math.min(math.max(left or M.INT32_MIN, value), right or M.INT32_MAX)
end

local IncrementalId = 0

--- @return integer     returns auto-incremental integer, start from 1.
M.auto_incremental_id = function()
  if IncrementalId >= M.INT32_MAX then
    IncrementalId = 1
  else
    IncrementalId = IncrementalId + 1
  end
  return IncrementalId
end

--- @param a integer
--- @param b integer
--- @return integer
M.mod = function(a, b)
  return math.floor(math.fmod(a, b))
end

--- @param a any
--- @param ... any
--- @return integer, integer
M.max = function(a, ...)
  local others = { ... }
  assert(
    #others >= 1 and type(others[#others]) == "function",
    string.format(
      "last param 'f' must be unary-function returns a number ('function:(v:any):number'): %s",
      vim.inspect(others)
    )
  )
  local mapper = others[#others]
  local maximal_item = a
  local maximal_value = mapper(a)
  local maximal_index = 1
  for i, o in ipairs(others) do
    if i < #others then
      if mapper(o) > maximal_value then
        maximal_item = o
        maximal_index = i
      end
    end
  end
  return maximal_item, maximal_index
end

--- @param a any
--- @param ... any
--- @return integer, integer
M.min = function(a, ...)
  local others = { ... }
  assert(
    #others >= 1 and type(others[#others]) == "function",
    string.format(
      "last param 'f' must be unary-function returns a number ('function:(v:any):number'): %s",
      vim.inspect(others)
    )
  )
  local mapper = others[#others]
  local minimal_item = a
  local minimal_value = mapper(a)
  local minimal_index = 1
  for i, o in ipairs(others) do
    if i < #others then
      if mapper(o) < minimal_value then
        minimal_item = o
        minimal_index = i
      end
    end
  end
  return minimal_item, minimal_index
end

return M
