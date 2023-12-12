-- Sync/async child-process and stdout/stderr line-based outputs processing

local M = {}

--- @alias commons.SpawnLineProcessor fun(line:string):any
--- @alias commons.SpawnOnStdout commons.SpawnLineProcessor
--- @alias commons.SpawnOnStderr commons.SpawnLineProcessor
--- @alias commons.SpawnOnExit fun(exitcode:integer,signal:integer):any
--- @param cmd string[]
--- @param opts {on_stdout:commons.SpawnOnStdout, on_stderr:commons.SpawnOnStderr, on_exit:commons.SpawnOnExit, cwd:string?, env:table?, clear_env:boolean?, stdin:boolean|function|nil, stdout:boolean|function|nil, stderr:boolean|function|nil, text:boolean?, timeout:integer?, detach:boolean?}?
--         by default {text = true}
M.run = function(cmd, opts)
  opts = opts or {}
  opts.text = type(opts.text) == "boolean" and opts.text or true

  local stdout_buffer = nil

  --- @param err string?
  --- @param data string?
  local function _handle_stdout(err, data) end

  local stderr_buffer = nil

  --- @param err string?
  --- @param data string?
  local function _handle_stderr(err, data) end

  local _system = require("commons._system").run

  if vim.fn.has("nvim-0.10") > 0 and type(vim.system) == "function" then
    _system = vim.system
  end

  if type(opts.on_exit) == "function" then
    return _system(cmd, {
      cwd = opts.cwd,
      env = opts.env,
      clear_env = opts.clear_env,
      ---@diagnostic disable-next-line: assign-type-mismatch
      stdin = opts.stdin,
      stdout = _handle_stdout,
      stderr = _handle_stderr,
      text = opts.text,
      timeout = opts.timeout,
      detach = opts.detach,
    }, function(exitcode, signal)
      opts.on_exit(exitcode, signal)
    end)
  else
    return _system(cmd, {
      cwd = opts.cwd,
      env = opts.env,
      clear_env = opts.clear_env,
      ---@diagnostic disable-next-line: assign-type-mismatch
      stdin = opts.stdin,
      stdout = _handle_stdout,
      stderr = _handle_stderr,
      text = opts.text,
      timeout = opts.timeout,
      detach = opts.detach,
    })
  end
end

return M
