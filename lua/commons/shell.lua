local M = {}

-- Escape the Windows/DOS command line (cmd.exe) strings for Windows OS.
--
-- References:
-- * https://www.robvanderwoude.com/escapechars.php
-- * https://ss64.com/nt/syntax-esc.html
-- * https://stackoverflow.com/questions/562038/escaping-double-quotes-in-batch-script
--
--- @param s string
--- @return string
M._escape_windows = function(s)
  local shellslash = vim.o.shellslash
  vim.o.shellslash = false
  local result = vim.fn.escape(s)
  vim.o.shellslash = shellslash
  return result
end

-- Escape shell strings for POSIX compatible OS.
--- @param s string
--- @return string
M._escape_posix = function(s)
  return vim.fn.escape(s)
end

--- @param s string
--- @return string
M.escape = function(s)
  if require("commons.platform").IS_WINDOWS then
    return M._escape_windows(s)
  else
    return M._escape_posix(s)
  end
end

--- @class commons.ShellContext
--- @field shell string?
--- @field shellslash string?
--- @field shellcmdflag string?
local ShellContext = {}

--- @return commons.ShellContext
function ShellContext:save()
  local is_win = require("commons.platform").IS_WINDOWS

  local o = is_win
      and {
        shell = vim.o.shell,
        shellslash = vim.o.shellslash,
        shellcmdflag = vim.o.shellcmdflag,
      }
    or {
      shell = vim.o.shell,
    }

  setmetatable(o, self)
  self.__index = self

  if is_win then
    vim.o.shell = "cmd.exe"
    vim.o.shellslash = false
    vim.o.shellcmdflag = "/s /c"
  else
    vim.o.shell = "sh"
  end

  return o
end

function ShellContext:restore()
  local is_win = require("commons.platform").IS_WINDOWS

  if is_win then
    vim.o.shell = self.shell
    vim.o.shellslash = self.shellslash
    vim.o.shellcmdflag = self.shellcmdflag
  else
    vim.o.shell = self.shell
  end
end

--- @alias commons.ShellJobOnExit fun(exitcode:integer?):nil
--- @alias commons.ShellJobBlockWiseOnStdout fun(lines:string[]?):any
--- @alias commons.ShellJobBlockWiseOnStderr fun(lines:string[]?):any
--- @alias commons.ShellJobBlockWiseOpts {on_stdout:commons.ShellJobBlockWiseOnStdout,on_stderr:commons.ShellJobBlockWiseOnStderr?,on_exit:commons.ShellJobOnExit?,[string]:any}
--- @param cmd string
--- @param opts commons.ShellJobBlockWiseOpts?
--- @return integer
M.blockwise = function(cmd, opts)
  opts = opts or {}

  if type(opts.on_stderr) ~= "function" then
    opts.on_stderr = function() end
  end
  if type(opts.on_exit) ~= "function" then
    opts.on_exit = function() end
  end

  assert(type(opts.on_stdout) == "function")
  assert(type(opts.on_stderr) == "function")
  assert(type(opts.on_exit) == "function")

  local saved_ctx = ShellContext:save()

  local function _handle_stdout(chanid, data, name)
    opts.on_stdout(data)
  end

  local function _handle_stderr(chanid, data, name)
    opts.on_stderr(data)
  end

  local function _handle_exit(jobid1, exitcode, event)
    opts.on_exit(exitcode)
  end

  local jobid = vim.fn.jobstart(cmd, {
    clear_env = opts.clear_env,
    cwd = opts.cwd,
    detach = opts.detach,
    env = opts.env,
    overlapped = opts.overlapped,
    rpc = opts.rpc,
    stdin = opts.stdin,
    term = opts.term,
    height = opts.height,
    width = opts.width,
    pty = opts.pty,
    on_stdout = _handle_stdout,
    on_stderr = _handle_stderr,
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = _handle_exit,
  })

  saved_ctx:restore()

  return jobid
end

--- @alias commons.ShellJobLineWiseOnStdout fun(line:string?):any
--- @alias commons.ShellJobLineWiseOnStderr fun(line:string?):any
--- @alias commons.ShellJobLineWiseOpts {on_stdout:commons.ShellJobLineWiseOnStdout,on_stderr:commons.ShellJobLineWiseOnStderr?,on_exit:commons.ShellJobOnExit?,[string]:any}
--- @param cmd string
--- @param opts commons.ShellJobLineWiseOpts?
--- @return integer
M.linewise = function(cmd, opts)
  opts = opts or {}

  if type(opts.on_stderr) ~= "function" then
    opts.on_stderr = function() end
  end
  if type(opts.on_exit) ~= "function" then
    opts.on_exit = function() end
  end

  assert(type(opts.on_stdout) == "function")
  assert(type(opts.on_stderr) == "function")
  assert(type(opts.on_exit) == "function")

  local saved_ctx = ShellContext:save()

  local stdout_buffer = { "" }

  local function _handle_stdout(chanid, data, name)
    local eof = type(data) == "table" and #data == 1 and string.len(data[1]) == 0
    local n = #stdout_buffer
    -- Concat the first line in `data` to the last line in `stdout_buffer`, since they could be partial.
    stdout_buffer[n] = stdout_buffer[n] .. data[1]
    local i = 1
    while i < n do
      local line = stdout_buffer[i]
      opts.on_stdout(line)
    end
    -- Removes all the lines before `n` in `stdout_buffer`, only keep the last line since it could be partial.
    stdout_buffer = { stdout_buffer[n] }
    i = 2
    n = #data
    -- Append all the lines after `1` in `data`, since the 1st line is already concat to `stdout_buffer`.
    while i <= n do
      table.insert(stdout_buffer, data[i])
    end
  end

  local stderr_buffer = { "" }

  local function _handle_stderr(chanid, data, name)
    local eof = type(data) == "table" and #data == 1 and string.len(data[1]) == 0
    local n = #stderr_buffer
    -- Concat the first line in `data` to the last line in `stderr_buffer`, since they could be partial.
    stderr_buffer[n] = stderr_buffer[n] .. data[1]
    local i = 1
    while i < n do
      local line = stderr_buffer[i]
      opts.on_stderr(line)
    end
    -- Removes all the lines before `n` in `stderr_buffer`, only keep the last line since it could be partial.
    stderr_buffer = { stderr_buffer[n] }
    i = 2
    n = #data
    -- Append all the lines after `1` in `data`, since the 1st line is already concat to `stderr_buffer`.
    while i <= n do
      table.insert(stderr_buffer, data[i])
    end
  end

  local function _handle_exit(jobid1, exitcode, event)
    opts.on_exit(exitcode)
  end

  local jobid = vim.fn.jobstart(cmd, {
    clear_env = opts.clear_env,
    cwd = opts.cwd,
    detach = opts.detach,
    env = opts.env,
    overlapped = opts.overlapped,
    rpc = opts.rpc,
    stdin = opts.stdin,
    term = opts.term,
    height = opts.height,
    width = opts.width,
    pty = opts.pty,
    on_stdout = _handle_stdout,
    on_stderr = _handle_stderr,
    on_exit = _handle_exit,
  })

  saved_ctx:restore()

  return jobid
end

--- @param jobid integer
--- @param timeout integer?
M.wait = function(jobid, timeout)
  vim.fn.jobwait(jobid, timeout)
end
