local M = {}

-- see: `lua print(vim.inspect(vim.log.levels))`
--- @enum commons.LogLevels
M.LogLevels = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}

--- @enum commons.LogLevelNames
M.LogLevelNames = {
  [0] = "TRACE",
  [1] = "DEBUG",
  [2] = "INFO",
  [3] = "WARN",
  [4] = "ERROR",
  [5] = "OFF",
}

return M
