local M = {}

--- @param s any
--- @return boolean
M.empty = function(s)
  return type(s) ~= "string" or string.len(s) == 0
end

--- @param s any
--- @return boolean
M.not_empty = function(s)
  return type(s) == "string" and string.len(s) > 0
end

--- @param s any
--- @return boolean
M.blank = function(s)
  return type(s) ~= "string" or string.len(vim.trim(s)) == 0
end

--- @param s any
--- @return boolean
M.not_blank = function(s)
  return type(s) == "string" and string.len(vim.trim(s)) > 0
end

--- @param s string
--- @param t string
--- @param start integer?  by default start=1
--- @return integer?
M.find = function(s, t, start)
  assert(type(s) == "string")
  assert(type(t) == "string")

  start = start or 1
  for i = start, #s do
    local match = true
    for j = 1, #t do
      if i + j - 1 > #s then
        match = false
        break
      end
      local a = string.byte(s, i + j - 1)
      local b = string.byte(t, j)
      if a ~= b then
        match = false
        break
      end
    end
    if match then
      return i
    end
  end
  return nil
end

--- @param s string
--- @param t string
--- @param rstart integer?  by default rstart=#s
--- @return integer?
M.rfind = function(s, t, rstart)
  assert(type(s) == "string")
  assert(type(t) == "string")

  rstart = rstart or #s
  for i = rstart, 1, -1 do
    local match = true
    for j = 1, #t do
      if i + j - 1 > #s then
        match = false
        break
      end
      local a = string.byte(s, i + j - 1)
      local b = string.byte(t, j)
      if a ~= b then
        match = false
        break
      end
    end
    if match then
      return i
    end
  end
  return nil
end

--- @param s string
--- @param t string?  by default t is whitespace
--- @return string
M.ltrim = function(s, t)
  assert(type(s) == "string")
  assert(type(t) == "string" or t == nil)

  local function has(idx)
    if not t then
      return M.isspace(s:sub(idx, idx))
    end

    local c = string.byte(s, idx)
    local found = false
    for j = 1, #t do
      if string.byte(t, j) == c then
        found = true
        break
      end
    end
    return found
  end

  local i = 1
  while i <= #s do
    if not has(i) then
      break
    end
    i = i + 1
  end
  return s:sub(i, #s)
end

--- @param s string
--- @param t string?  by default t is whitespace
--- @return string
M.rtrim = function(s, t)
  assert(type(s) == "string")
  assert(type(t) == "string" or t == nil)

  local function has(idx)
    if not t then
      return M.isspace(s:sub(idx, idx))
    end

    local c = string.byte(s, idx)
    local found = false
    for j = 1, #t do
      if string.byte(t, j) == c then
        found = true
        break
      end
    end
    return found
  end

  local i = #s
  while i >= 1 do
    if not has(i) then
      break
    end
    i = i - 1
  end
  return s:sub(1, i)
end

--- @param s string
--- @param sep string
--- @param opts {plain:boolean?,trimempty:boolean?}?  by default opts={plain=true,trimempty=false}
--- @return string[]
M.split = function(s, sep, opts)
  assert(type(s) == "string")
  assert(type(sep) == "string")
  opts = opts or {
    plain = true,
    trimempty = true,
  }
  opts.plain = type(opts.plain) == "boolean" and opts.plain or true
  opts.trimempty = type(opts.trimempty) == "boolean" and opts.trimempty or false
  return vim.split(s, sep, opts)
end

--- @param s string
--- @param t string
--- @return boolean
M.startswith = function(s, t)
  assert(type(s) == "string")
  assert(type(t) == "string")
  return string.len(s) >= string.len(t) and s:sub(1, #t) == t
end

--- @param s string
--- @param t string
--- @return boolean
M.endswith = function(s, t)
  assert(type(s) == "string")
  assert(type(t) == "string")
  return string.len(s) >= string.len(t) and s:sub(#s - #t + 1) == t
end

--- @param s string
--- @return boolean
M.isspace = function(s)
  assert(string.len(s) == 1)
  return s:match("%s") ~= nil
end

--- @param s string
--- @return boolean
M.isalnum = function(s)
  assert(string.len(s) == 1)
  return s:match("%w") ~= nil
end

--- @param s string
--- @return boolean
M.isdigit = function(s)
  assert(string.len(s) == 1)
  return s:match("%d") ~= nil
end

--- @param s string
--- @return boolean
M.ishex = function(s)
  assert(string.len(s) == 1)
  return s:match("%x") ~= nil
end

--- @param s string
--- @return boolean
M.isalpha = function(s)
  assert(string.len(s) == 1)
  return s:match("%a") ~= nil
end

--- @param s string
--- @return boolean
M.islower = function(s)
  assert(string.len(s) == 1)
  return s:match("%l") ~= nil
end

--- @param s string
--- @return boolean
M.isupper = function(s)
  assert(string.len(s) == 1)
  return s:match("%u") ~= nil
end

return M
