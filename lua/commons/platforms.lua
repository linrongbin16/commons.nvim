local M = {}

M.IS_WINDOWS = vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0
M.IS_MAC = vim.fn.has("mac") > 0
M.IS_BSD = vim.fn.has("bsd") > 0
M.IS_LINUX = (vim.fn.has("linux") > 0 or vim.fn.has("unix") > 0)
  and not M.IS_WINDOWS
  and not M.IS_MAC
  and not M.IS_BSD

return M
