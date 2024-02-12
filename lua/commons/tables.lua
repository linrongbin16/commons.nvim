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

--- @param t any?
--- @param ... any
--- @return any
M.tbl_get = function(t, ...)
  local e = t --[[@as table]]
  for _, k in ipairs({ ... }) do
    if type(e) == "table" and e[k] ~= nil then
      e = e[k]
    else
      return nil
    end
  end
  return e
end

--- @param t any[]
--- @param v any
--- @param compare (fun(a:any, b:any):boolean)|nil
--- @return boolean
M.tbl_contains = function(t, v, compare)
  assert(type(t) == "table")
  for k, item in pairs(t) do
    if type(compare) == "function" then
      if compare(item, v) then
        return true
      end
    else
      if item == v then
        return true
      end
    end
  end
  return false
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

--- @param i integer
--- @param n integer
--- @return integer
M.list_index = function(i, n)
  assert(n >= 0)
  return i > 0 and i or (n + i + 1)
end

--- @param l any[]
--- @param v any
--- @param compare (fun(a:any, b:any):boolean)|nil
--- @return boolean
M.list_contains = function(l, v, compare)
  assert(type(l) == "table")
  for _, item in ipairs(l) do
    if type(compare) == "function" then
      if compare(item, v) then
        return true
      end
    else
      if item == v then
        return true
      end
    end
  end
  return false
end

--- @class commons.List
--- @field _data any[]
local List = {}

--- @param l any[]
--- @return commons.List
function List:wrap(l)
  assert(type(l) == "table")

  local o = { _data = l }
  setmetatable(o, self)
  self.__index = self
  return o
end

--- @param ... any
--- @return commons.List
function List:of(...)
  return List:wrap({ ... })
end

--- @return any[]
function List:data()
  return self._data
end

--- @return integer
function List:length()
  return #self._data
end

--- @return boolean
function List:empty()
  return #self._data == 0
end

--- @param index integer
--- @return any
function List:at(index)
  local normalized_index = M.list_index(index, self:length())
  return self._data[normalized_index]
end

--- @return any
function List:first()
  return self:at(1)
end

--- @return any
function List:last()
  return self:at(self:length())
end

--- @param other commons.List
--- @return commons.List
function List:concat(other)
  assert(M.is_list(other))
  local l = {}
  for i, v in ipairs(self._data) do
    table.insert(l, v)
  end
  for i, v in ipairs(other._data) do
    table.insert(l, v)
  end
  return List:wrap(l)
end

--- @param separator string?
--- @return string
function List:join(separator)
  separator = separator or " "
  return table.concat(self._data, separator)
end

--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:every(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if not f(v, i) then
      return false
    end
  end
  return true
end

--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:some(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if f(v, i) then
      return true
    end
  end
  return false
end

--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:none(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if f(v, i) then
      return false
    end
  end
  return true
end

--- @param f fun(value:any, index:integer):boolean
--- @return commons.List
function List:filter(f)
  assert(type(f) == "function")
  local l = {}
  for i, v in ipairs(self._data) do
    if f(v, i) then
      table.insert(l, v)
    end
  end
  return List:wrap(l)
end

--- @param f fun(value:any, index:integer):boolean
--- @return any?, integer
function List:find(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if f(v, i) then
      return v, i
    end
  end
  return nil, -1
end

--- @param f fun(value:any, index:integer):boolean
--- @return any?, integer
function List:findLast(f)
  assert(type(f) == "function")
  local n = self:length()

  for i = n, 1, -1 do
    local v = self._data[i]
    if f(v, i) then
      return v, i
    end
  end
  return nil, -1
end

--- @param value any
--- @param start integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return integer?
function List:indexOf(value, start, comparator)
  assert(type(comparator) == "function" or comparator == nil)
  start = start or 1
  local n = self:length()

  for i = start, n do
    local v = self._data[i]
    if type(comparator) == "function" then
      if comparator(v, value) then
        return i
      end
    else
      if v == value then
        return i
      end
    end
  end

  return -1
end

--- @param value any
--- @param rstart integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return integer?
function List:lastIndexOf(value, rstart, comparator)
  assert(type(comparator) == "function" or comparator == nil)
  local n = self:length()
  rstart = rstart or n

  for i = rstart, 1, -1 do
    local v = self._data[i]
    if type(comparator) == "function" then
      if comparator(v, value) then
        return i
      end
    else
      if v == value then
        return i
      end
    end
  end

  return -1
end

--- @param f fun(value:any, index:integer):nil
function List:forEach(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    f(v, i)
  end
end

--- @param value any
--- @param start integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return boolean
function List:includes(value, start, comparator)
  return self:indexOf(value, start, comparator) >= 1
end

--- @param f fun(value:any,index:integer):any
--- @return commons.List
function List:map(f)
  assert(type(f) == "function")
  local l = {}
  for i, v in ipairs(self._data) do
    table.insert(l, f(v, i))
  end
  return List:wrap(l)
end

--- @return any?, boolean
function List:pop()
  if self:empty() then
    return nil, false
  end
  return table.remove(self._data, self:length()), true
end

--- @param ... any
function List:push(...)
  for i, v in ipairs({ ... }) do
    table.insert(self._data, v)
  end
end

--- @return any?, boolean
function List:shift()
  if self:empty() then
    return nil, false
  end
  return table.remove(self._data, 1), true
end

--- @param ... any
function List:unshift(...)
  for i, v in ipairs({ ... }) do
    table.insert(self._data, 1, v)
  end
end

--- @param f fun(accumulator:any,value:any,index:integer):any
--- @param initialValue any?
--- @return any
function List:reduce(f, initialValue)
  assert(type(f) == "function")

  if self:empty() then
    return initialValue
  end

  local startIndex = initialValue and 1 or 2
  local accumulator = initialValue or self._data[1]
  local n = self:length()
  local i = startIndex
  while i <= n do
    accumulator = f(accumulator, self._data[i], i)
    i = i + 1
  end
  return accumulator
end

--- @param f fun(accumulator:any,value:any,index:integer):any
--- @param initialValue any?
--- @return any
function List:reduceRight(f, initialValue)
  assert(type(f) == "function")

  if self:empty() then
    return initialValue
  end

  local n = self:length()
  local startIndex = initialValue and n or self:length() - 1
  local accumulator = initialValue or self._data[n]

  local i = startIndex
  while i >= 1 do
    accumulator = f(accumulator, self._data[i], i)
    i = i - 1
  end
  return accumulator
end

--- @return commons.List
function List:reverse()
  if self:empty() then
    return List:wrap({})
  end

  local l = {}
  local i = self:length()
  while i >= 1 do
    table.insert(l, self._data[i])
    i = i - 1
  end
  return List:wrap(l)
end

--- @param start_index integer?
--- @param end_index integer?
--- @return commons.List
function List:slice(start_index, end_index)
  assert(type(start_index) == "number" or start_index == nil)
  assert(type(end_index) == "number" or end_index == nil)

  local n = self:length()
  start_index = start_index or 1
  end_index = end_index or n

  local l = {}
  for i = start_index, end_index do
    if i >= 1 and i <= n then
      table.insert(l, self._data[i])
    end
  end
  return List:wrap(l)
end

--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return commons.List
function List:sort(comparator)
  local l = {}
  for i, v in ipairs(self._data) do
    table.insert(l, v)
  end
  table.sort(l, comparator)
  return List:wrap(l)
end

M.List = List

--- @param o any
--- @return boolean
M.is_list = function(o)
  return type(o) == "table" and o.__index == List and getmetatable(o) == List
end

-- --- @class commons.HashMap
-- local HashMap = {}
--
-- --- @param t table
-- function HashMap:new(t)
--   assert(type(t) == "table")
--
--   local o = { _data = t }
--   setmetatable(o, self)
--   self.__index = self
--   return o
-- end
--
-- M.HashMap = HashMap
--
-- M.is_hashmap = function(o)
--   return type(o) == "table" and o.__index == HashMap and getmetatable(o) == HashMap
-- end

return M
