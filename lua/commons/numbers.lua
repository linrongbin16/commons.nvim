local M = {}

-- int32 max/min
M.INT32_MAX = 2147483647
M.INT32_MIN = -2147483648

--- @param a number?
--- @param b number?
--- @return boolean
M.eq = function(a, b)
  return type(a) == "number" and type(b) == "number" and a == b
end

--- @param a number?
--- @param b number?
--- @return boolean
M.ne = function(a, b)
  return not M.eq(a, b)
end

--- @param a number?
--- @param b number?
--- @return boolean
M.gt = function(a, b)
  return type(a) == "number" and type(b) == "number" and a > b
end

--- @param a number?
--- @param b number?
--- @return boolean
M.ge = function(a, b)
  return M.gt(a, b) or M.eq(a, b)
end

--- @param a number?
--- @param b number?
--- @return boolean
M.lt = function(a, b)
  return type(a) == "number" and type(b) == "number" and a < b
end

--- @param a number?
--- @param b number?
--- @return boolean
M.le = function(a, b)
  return M.lt(a, b) or M.eq(a, b)
end

--- @param value number
--- @param left number?   lower bound, by default INT32_MIN
--- @param right number?  upper bound, by default INT32_MAX
--- @return number
M.bound = function(value, left, right)
  assert(type(value) == "number")
  assert(type(left) == "number" or left == nil)
  assert(type(right) == "number" or right == nil)
  return math.min(math.max(left or M.INT32_MIN, value), right or M.INT32_MAX)
end

local IncrementalId = 0

--- @return integer
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

--- @param f fun(v:any):number
--- @param a any
--- @param ... any
--- @return integer, integer
M.max = function(f, a, ...)
  assert(
    type(f) == "function",
    string.format("first param 'f' must be unary-function returns number value:%s", vim.inspect(f))
  )
  local maximal_item = a
  local maximal_value = f(a)
  local maximal_index = 1
  for i, o in ipairs({ ... }) do
    if f(o) > maximal_value then
      maximal_item = o
      maximal_index = i
    end
  end
  return maximal_item, maximal_index
end

--- @param f fun(v:any):number
--- @param a any
--- @param ... any
--- @return integer, integer
M.min = function(f, a, ...)
  assert(
    type(f) == "function",
    string.format("first param 'f' must be unary-function returns number value:%s", vim.inspect(f))
  )
  local minimal_item = a
  local minimal_value = f(a)
  local minimal_index = 1
  for i, o in ipairs({ ... }) do
    if f(o) < minimal_value then
      minimal_item = o
      minimal_index = i
    end
  end
  return minimal_item, minimal_index
end

--- @param m integer?
--- @param n integer?
--- @return number
M.random = function(m, n)
  local rand_result, rand_err = require("commons.uv").random(4)
  if rand_result == nil then
    if m == nil and n == nil then
      return math.random()
    elseif m ~= nil and n == nil then
      return math.random(m)
    else
      return math.random(m --[[@as integer]], n --[[@as integer]])
    end
  end
  local bytes = {
    string.byte(rand_result --[[@as string]], 1, -1),
  }
  local total = 0
  for _, b in ipairs(bytes) do
    total = M.mod(total * 256 + b, M.INT32_MAX)
  end
  if m == nil and n == nil then
    return total / M.INT32_MAX
  elseif m ~= nil and n == nil then
    assert(type(m) == "number")
    assert(m >= 1)
    return M.mod(total, m) + 1
  else
    assert(type(m) == "number")
    assert(type(n) == "number")
    assert(n >= m)
    return M.mod(total, n - m + 1) + m
  end
end

--- @param l any[]|string
--- @return any[]|string
M.shuffle = function(l)
  assert(type(l) == "table")
  local n = #l

  local new_l = {}
  for i = 1, n do
    table.insert(new_l, l[i])
  end

  for i = n, 1, -1 do
    local j = M.random(n)
    local tmp = new_l[j]
    new_l[j] = new_l[i]
    new_l[i] = tmp
  end
  return new_l
end

return M
