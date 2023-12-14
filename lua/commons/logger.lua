local IS_WINDOWS = vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0

local M = {}

-- see: `lua print(vim.inspect(vim.log.levels))`
--- @enum commons.LogLevels
local LogLevels = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}

--- @type table
local LogLevelNames = {
  [0] = "TRACE",
  [1] = "DEBUG",
  [2] = "INFO",
  [3] = "WARN",
  [4] = "ERROR",
  [5] = "OFF",
}

M.LogLevels = LogLevels
M.LogLevelNames = LogLevelNames

local LogHighlights = {
  [1] = "Comment",
  [2] = "None",
  [3] = "WarningMsg",
  [4] = "ErrorMsg",
}

local Defaults = {
  name = nil,
  level = LogLevels.INFO,
  console_log = true,
  file_log = false,
  file_log_name = nil,
  file_log_dir = vim.fn.stdpath("data"),
}

local Configs = {}

--- @param opts table?
M.setup = function(opts)
  Configs = vim.tbl_deep_extend("force", vim.deepcopy(Defaults), opts or {})
  if type(Configs.level) == "string" then
    assert(
      string.upper(Configs.level) == "TRACE"
        or string.upper(Configs.level) == "DEBUG"
        or string.upper(Configs.level) == "INFO"
        or string.upper(Configs.level) == "WARN"
        or string.upper(Configs.level) == "ERROR"
        or string.upper(Configs.level) == "OFF"
    )
    Configs.level = LogLevels[Configs.level]
  end
  assert(
    type(Configs.level) == "number" and LogHighlights[Configs.level] ~= nil
  )
  if Configs.file_log then
    assert(type(Configs.file_log_name) == "string")
    local SEPARATOR = IS_WINDOWS and "\\" or "/"
    Configs._file_log_path = string.format(
      "%s%s%s",
      Configs.file_log_dir or "",
      SEPARATOR,
      Configs.file_log_name
    )
  end
end

M.echo = function(level, fmt, ...)
  local msg = string.format(fmt, ...)
  local msg_lines = vim.split(msg, "\n", { plain = true })

  local title = ""
  if type(Configs.name) and string.len(Configs.name) > 0 then
    title = Configs.name .. " "
  end

  local prefix = ""
  if level >= M.LogLevels.ERROR then
    prefix = "error! "
  elseif level == M.LogLevels.WARN then
    prefix = "warning! "
  end

  local chunks = {}
  for _, line in ipairs(msg_lines) do
    table.insert(chunks, {
      string.format("%s%s%s", title, prefix, line),
      LogHighlights[level],
    })
  end

  vim.schedule(function()
    vim.api.nvim_echo(chunks, false, {})
  end)
end

--- @param level integer
--- @param msg string
local function log(level, msg)
  local uv = require("commons.uv")

  if level < Configs.level then
    return
  end

  if Configs.console_log and level >= LogLevels.INFO then
    M.echo(level, msg)
  end

  if Configs.file_log then
    local fp = io.open(Configs._file_log_path, "a")
    if fp then
      local msg_lines = vim.split(msg, "\n", { plain = true })
      for _, line in ipairs(msg_lines) do
        local secs, ms = uv.gettimeofday()
        fp:write(
          string.format(
            "%s.%06d [%s]: %s\n",
            os.date("%Y-%m-%d %H:%M:%S", secs),
            ms,
            LogLevelNames[level],
            line
          )
        )
      end
      fp:close()
    end
  end
end

local function debug(fmt, ...)
  log(LogLevels.DEBUG, string.format(fmt, ...))
end

local function info(fmt, ...)
  log(LogLevels.INFO, string.format(fmt, ...))
end

local function warn(fmt, ...)
  log(LogLevels.WARN, string.format(fmt, ...))
end

local function err(fmt, ...)
  log(LogLevels.ERROR, string.format(fmt, ...))
end

local function throw(fmt, ...)
  log(LogLevels.ERROR, string.format(fmt, ...))
  error(string.format(fmt, ...))
end

local function ensure(cond, fmt, ...)
  if not cond then
    throw(fmt, ...)
  end
end

local M = {
  LogLevels = LogLevels,
  setup = setup,
  debug = debug,
  info = info,
  warn = warn,
  err = err,
  throw = throw,
  ensure = ensure,
}

return M
