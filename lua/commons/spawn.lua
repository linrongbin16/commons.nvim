local M = {}

--- @alias commons.SpawnJob {obj:vim.SystemObj,opts:commons.SpawnBlockWiseOpts|commons.SpawnLineWiseOpts}
--- @alias commons.SpawnOnExit fun(completed:vim.SystemCompleted):nil
--- @alias commons.SpawnBlockWiseOpts {on_exit:commons.SpawnOnExit?,[string]:any}
--- @param cmd string[]
--- @param opts commons.SpawnBlockWiseOpts?
--- @return commons.SpawnJob
M.blockwise = function(cmd, opts)
  opts = opts or {}

  assert(opts.on_stdout == nil, "Block-wise spawn job doesn't allow 'on_stdout' hook function")
  assert(opts.on_stderr == nil, "Block-wise spawn job doesn't allow 'on_stderr' hook function")
  assert(type(opts.on_exit) == "function" or opts.on_exit == nil)

  local obj = vim.system(cmd, {
    cwd = opts.cwd,
    env = opts.env,
    clear_env = opts.clear_env,
    stdin = opts.stdin,
    text = true,
    timeout = opts.timeout,
    detach = opts.detach,
  }, opts.on_exit)

  return { obj = obj, opts = opts }
end

--- @alias commons.SpawnLineWiseProcessor fun(line:string):any
--- @alias commons.SpawnLineWiseOpts {on_stdout:commons.SpawnLineWiseProcessor,on_stderr:commons.SpawnLineWiseProcessor?,on_exit:commons.SpawnOnExit?,[string]:any}
--- @param cmd string[]
--- @param opts commons.SpawnLineWiseOpts?
--- @return commons.SpawnJob
M.linewise = function(cmd, opts)
  opts = opts or {}

  if type(opts.on_stderr) ~= "function" then
    opts.on_stderr = function() end
  end

  assert(
    type(opts.on_stdout) == "function",
    "Line-wise spawn job must have 'on_stdout' hook function"
  )
  assert(
    type(opts.on_stderr) == "function",
    "Line-wise spawn job must have 'on_stderr' hook function"
  )
  assert(type(opts.on_exit) == "function" or opts.on_exit == nil)

  --- @param buffer string
  --- @param fn_line_processor commons.SpawnLineWiseProcessor
  --- @return integer
  local function _process(buffer, fn_line_processor)
    local str = require("commons.str")

    local i = 1
    while i <= #buffer do
      local newline_pos = str.find(buffer, "\n", i)
      if not newline_pos then
        break
      end
      local line = buffer:sub(i, newline_pos - 1)
      fn_line_processor(line)
      i = newline_pos + 1
    end
    return i
  end

  local stdout_buffer = nil

  --- @param err string?
  --- @param data string?
  local function _handle_stdout(err, data)
    if err then
      error(
        string.format(
          "failed to read stdout on cmd:%s, error:%s",
          vim.inspect(cmd),
          vim.inspect(err)
        )
      )
      return
    end

    if data then
      -- append data to buffer
      stdout_buffer = stdout_buffer and (stdout_buffer .. data) or data
      -- search buffer and process each line
      local i = _process(stdout_buffer, opts.on_stdout)
      -- truncate the processed lines if still exists any
      stdout_buffer = i <= #stdout_buffer and stdout_buffer:sub(i, #stdout_buffer) or nil
    elseif stdout_buffer then
      -- foreach the data_buffer and find every line
      local i = _process(stdout_buffer, opts.on_stdout)
      if i <= #stdout_buffer then
        local line = stdout_buffer:sub(i, #stdout_buffer)
        opts.on_stdout(line)
        stdout_buffer = nil
      end
    end
  end

  local stderr_buffer = nil

  --- @param err string?
  --- @param data string?
  local function _handle_stderr(err, data)
    if err then
      error(
        string.format(
          "failed to read stderr on cmd:%s, error:%s",
          vim.inspect(cmd),
          vim.inspect(err)
        )
      )
      return
    end

    if data then
      stderr_buffer = stderr_buffer and (stderr_buffer .. data) or data
      local i = _process(stderr_buffer, opts.on_stderr)
      stderr_buffer = i <= #stderr_buffer and stderr_buffer:sub(i, #stderr_buffer) or nil
    elseif stderr_buffer then
      local i = _process(stderr_buffer, opts.on_stderr)
      if i <= #stderr_buffer then
        local line = stderr_buffer:sub(i, #stderr_buffer)
        opts.on_stderr(line)
        stderr_buffer = nil
      end
    end
  end

  local obj = vim.system(cmd, {
    cwd = opts.cwd,
    env = opts.env,
    clear_env = opts.clear_env,
    ---@diagnostic disable-next-line: assign-type-mismatch
    stdin = opts.stdin,
    stdout = _handle_stdout,
    stderr = _handle_stderr,
    text = true,
    timeout = opts.timeout,
    detach = opts.detach,
  }, opts.on_exit)

  return { obj = obj, opts = opts }
end

--- @param job commons.SpawnJob
--- @param timeout integer?
--- @return vim.SystemCompleted
M.wait = function(job, timeout)
  assert(type(job) == "table", "Job must be a 'commons.SpawnJob' object")
  assert(job.obj ~= nil, "Job must be a 'commons.SpawnJob' object")
  assert(type(job.opts) == "table", "Job must be a 'commons.SpawnJob' object")
  assert(
    job.opts.on_exit == nil,
    "Async job cannot 'wait' for complete, it already use 'on_exit' hook function"
  )
  assert(type(timeout) == "number" or timeout == nil, "Timeout must be either integer or nil")

  return job.obj:wait(timeout)
end

return M
