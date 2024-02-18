local M = {}

-- int32 max/min
M.INT32_MAX = 2147483647
M.INT32_MIN = -2147483648

M._RELATIVE_PRECISION = 1e-09
M._ABSOLUTE_PRECISION = 0.0

-- https://github.com/scikit-hep/scikit-hep/blob/e0c433e53677ebf1ac690d7962e0eca6ce57ed63/skhep/math/isclose.py
--
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.eq = function(a, b, rel_tol, abs_tol, method)
  if type(a) ~= "number" or type(b) ~= "number" then
    return false
  end
  if a == b then
    return true
  end

  rel_tol = rel_tol or M._RELATIVE_PRECISION
  abs_tol = abs_tol or M._ABSOLUTE_PRECISION
  method = method or "weak"

  local diff = math.abs(a - b)
  if method == "asymmetric" then
    return (diff <= math.abs(rel_tol * b)) or (diff <= abs_tol)
  elseif method == "strong" then
    return ((diff <= math.abs(rel_tol * b)) and (diff <= math.abs(rel_tol * a)))
      or (diff <= abs_tol)
  elseif method == "weak" then
    return (diff <= math.abs(rel_tol * b)) or (diff <= math.abs(rel_tol * a)) or (diff <= abs_tol)
  elseif method == "average" then
    return (diff <= math.abs(rel_tol * (a + b) / 2)) or (diff <= abs_tol)
  else
    assert(false)
    ---@diagnostic disable-next-line: missing-return
  end
end

--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.ne = function(a, b, rel_tol, abs_tol, method)
  return not M.eq(a, b, rel_tol, abs_tol, method)
end

--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.gt = function(a, b, rel_tol, abs_tol, method)
  if type(a) ~= "number" or type(b) ~= "number" then
    return false
  end
  return M.ne(a, b, rel_tol, abs_tol, method) and a > b
end

--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.ge = function(a, b, rel_tol, abs_tol, method)
  return M.gt(a, b, rel_tol, abs_tol, method) or M.eq(a, b, rel_tol, abs_tol, method)
end

--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.lt = function(a, b, rel_tol, abs_tol, method)
  if type(a) ~= "number" or type(b) ~= "number" then
    return false
  end
  return M.ne(a, b, rel_tol, abs_tol, method) and a < b
end

--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @param method "asymmetric"|"strong"|"weak"|"average"|nil
--- @return boolean
M.le = function(a, b, rel_tol, abs_tol, method)
  return M.lt(a, b, rel_tol, abs_tol, method) or M.eq(a, b, rel_tol, abs_tol, method)
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
  assert(rand_result ~= nil, rand_err)

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
