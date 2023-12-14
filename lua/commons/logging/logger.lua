local LogLevels = require("commons.logging.level").LogLevels
local LogLevelNames = require("commons.logging.level").LogLevelNames

local M = {}

--- @class commons.Logger
--- @field name string
--- @field level commons.LogLevels
--- @field handlers commons.logging.Handler[]
local Logger = {}

--- @param name string
--- @param level commons.LogLevels
function Logger:new(name, level)
  assert(type(name) == "string")
  assert(type(level) == "number" and LogLevelNames[level] ~= nil)

  local o = {
    name = name,
    level = level,
    handlers = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

--- @param handler commons.logging.Handler
function Logger:add_handler(handler)
  assert(type(handler) == "table")
  table.insert(self.handlers, handler)
end

--- @param lvl integer
--- @param fmt string
--- @param ... any
function Logger:_log(lvl, fmt, ...)
  assert(type(lvl) == "number")

  if lvl < self.level then
    return
  end

  local msg = string.format(fmt, ...)
  local msg_lines = vim.split(msg, "\n", { plain = true })

  for _, handler in ipairs(self.handlers) do
    for _, line in ipairs(msg_lines) do
      handler:write(line)
    end
  end
end

--- @param fmt string
--- @param ... any
function Logger:debug(fmt, ...)
  self:_log(LogLevels.DEBUG, fmt, ...)
end

--- @param fmt string
--- @param ... any
function Logger:info(fmt, ...)
  self:_log(LogLevels.INFO, fmt, ...)
end

--- @param fmt string
--- @param ... any
function Logger:warn(fmt, ...)
  self:_log(LogLevels.WARN, fmt, ...)
end

--- @param fmt string
--- @param ... any
function Logger:err(fmt, ...)
  self:_log(LogLevels.ERROR, fmt, ...)
end

--- @param fmt string
--- @param ... any
function Logger:throw(fmt, ...)
  self:_log(LogLevels.ERROR, fmt, ...)
  error(string.format(fmt, ...))
end

--- @param cond any
--- @param fmt string
--- @param ... any
function Logger:ensure(cond, fmt, ...)
  if not cond then
    self:err(fmt, ...)
  end
  assert(cond, string.format(fmt, ...))
end

M.Logger = Logger

return M
