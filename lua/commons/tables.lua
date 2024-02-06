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
  assert(n > 0)
  assert((i >= 1 and i <= n) or (i <= -1 and i >= -n))
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
function List:wrap(l)
  assert(type(l) == "table")

  local o = { _data = l }
  setmetatable(o, self)
  self.__index = self
  return o
end

--- @param ... any
function List:of(...)
  return List:wrap({ ... })
end

function List:data()
  return self._data
end

function List:at(index)
  return self._data[index]
end

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

function List:allOf(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if not f(v, i) then
      return false
    end
  end
  return true
end

function List:anyOf(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if f(v, i) then
      return true
    end
  end
  return false
end

function List:noneOf(f)
  assert(type(f) == "function")
  for i, v in ipairs(self._data) do
    if f(v, i) then
      return false
    end
  end
  return true
end

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

M.List = List

M.is_list = function(o)
  return type(o) == "table" and o.__index == List and getmetatable(o) == List
end

--- @class commons.HashMap
local HashMap = {}

--- @param t table
function HashMap:new(t)
  assert(type(t) == "table")

  local o = { _data = t }
  setmetatable(o, self)
  self.__index = self
  return o
end

M.HashMap = HashMap

M.is_hashmap = function(o)
  return type(o) == "table" and o.__index == HashMap and getmetatable(o) == HashMap
end

return M
