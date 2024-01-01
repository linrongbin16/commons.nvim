local IS_WINDOWS = vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0

local M = {}

M.SEPARATOR = IS_WINDOWS and "\\" or "/"

M._normalize_slash = function(p, opts)
  assert(type(p) == "string")
  opts = opts or { double_backslash = false }
  opts.double_backslash = type(opts.double_backslash) == "boolean"
      and opts.double_backslash
    or false
  -- '\\\\' => '\\'
  local function _double_backslash(s)
    if string.match(s, [[\\]]) then
      s = string.gsub(s, [[\\]], [[\]])
    end
    return s
  end

  -- '\\' => '/'
  local function _single_backslash(s)
    if string.match(s, [[\]]) then
      s = string.gsub(s, [[\]], [[/]])
    end
    return s
  end
  local result = vim.trim(p)

  if opts.double_backslash then
    result = _double_backslash(result)
  end
  result = _single_backslash(result)
  return result
end

M.expand = function(p)
  assert(type(p) == "string")
  if string.len(p) >= 1 and string.sub(p, 1, 1) == "~" then
    return require("commons.uv").cwd() .. string.sub(p, 2)
  else
    return p
  end
end

--- @param p string
--- @param opts {double_backslash:boolean?,expand:boolean?,resolve:boolean?}?
--- @return string
M.normalize = function(p, opts)
  assert(type(p) == "string")
  opts = opts or { double_backslash = false, expand = false, resolve = false }
  opts.double_backslash = type(opts.double_backslash) == "boolean"
      and opts.double_backslash
    or false
  opts.expand = type(opts.expand) == "boolean" and opts.expand or false
  opts.resolve = type(opts.resolve) == "boolean" and opts.resolve or false

  local result = M._normalize_slash(p, opts)
  if opts.expand then
    result = M.expand(result)
  end

  if opts.resolve then
    result = require("commoms.uv").fs_realpath(result)
  end

  return result
end

--- @param ... any
--- @return string
M.join = function(...)
  return table.concat({ ... }, M.SEPARATOR)
end

--- @param p string?
--- @return string
M.reduce2home = function(p)
  return vim.fn.fnamemodify(p or vim.fn.getcwd(), ":~") --[[@as string]]
end

--- @param p string?
--- @return string
M.reduce = function(p)
  return vim.fn.fnamemodify(p or vim.fn.getcwd(), ":~:.") --[[@as string]]
end

--- @param p string?
--- @return string
M.shorten = function(p)
  return vim.fn.pathshorten(M.reduce(p)) --[[@as string]]
end

--- @return string
M.pipename = function()
  if IS_WINDOWS then
    local function uuid()
      local secs, ms = vim.loop.gettimeofday()
      return table.concat({
        string.format("%x", vim.loop.os_getpid()),
        string.format("%x", secs),
        string.format("%x", ms),
      }, "-")
    end
    return string.format([[\\.\pipe\nvim-pipe-%s]], uuid())
  else
    return vim.fn.tempname() --[[@as string]]
  end
end

--- @param p string?
--- @return string?
M.parent = function(p)
  p = p or vim.fn.getcwd()

  local strings = require("commons.strings")
  if strings.endswith(p, "/") or strings.endswith(p, "\\") then
    p = string.sub(p, 1, #p - 1)
  end

  local result = vim.fn.fnamemodify(p, ":h")
  return string.len(result) < string.len(p) and result or nil
end

return M
