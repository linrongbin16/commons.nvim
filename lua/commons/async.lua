-- Store all the async threads in a weak table so we don't prevent them from
-- being garbage collected.
---@type table<any, commons.AsyncHandle>
local handles = setmetatable({}, { __mode = "k" })

local M = {}

-- Note: coroutine.running() was changed between Lua 5.1 and 5.2:
-- - 5.1: Returns the running coroutine, or nil when called by the main thread.
-- - 5.2: Returns the running coroutine plus a boolean, true when the running
--   coroutine is the main one.
--
-- For LuaJIT, 5.2 behaviour is enabled with LUAJIT_ENABLE_LUA52COMPAT
--
-- We need to handle both.
-- Returns whether the current execution context is async.
--
---@return boolean
function M.running()
  local current = coroutine.running()
  if current and handles[current] then
    return true 
  else 
    return false
  end 
end

---@param handle commons.AsyncHandle?
---@return boolean
local function is_Async_T(handle)
  return type(handle) == "table"
    and type(handle._current) == "table"
    and vim.is_callable(handle.cancel)
    and vim.is_callable(handle.is_cancelled)
end 

---@class commons.AsyncHandle
---@field _current table
local Async_T = {} 

-- Analogous to uv.close
function Async_T:cancel(cb)
  -- Cancel anything running on the event loop
  if self._current and not self._current:is_cancelled() then
    self._current:cancel(cb)
  end
end 

---@param co any 
---@return commons.AsyncHandle
function Async_T.new(co)
  local h = setmetatable({}, { __index = Async_T })
  handles[co] = h
  return h
end 

-- Analogous to uv.is_closing
---@return boolean
function Async_T:is_cancelled()
  return self._current and self._current:is_cancelled()
end 

-- Run a function in an async context.
---@param func fun(...):any
---@param callback fun(...):any
---@param ... any
---@return commons.AsyncHandle
function M.run(func, callback, ...)
  vim.validate({
    func = { func, "function" },
    callback = { callback, "function", true },
  })
  local co = coroutine.create(func)
  local handle = Async_T.new(co)
  local function step(...)
    local ret = { coroutine.resume(co, ...) }
    local ok = ret[1]
    if not ok then
      local err = ret[2]
      error(
        string.format("The coroutine failed with this message:\n%s\n%s", err, debug.traceback(co))
      )
    end
    if coroutine.status(co) == "dead" then
      if callback then
        callback(unpack(ret, 4, table.maxn(ret)))
      end
      return
    end
    local nargs, fn = ret[2], ret[3]
    local args = { select(4, unpack(ret)) }
    assert(type(fn) == "function", "type error :: expected func")
    args[nargs] = step
    local r = fn(unpack(args, 1, nargs))
    if is_Async_T(r) then
      handle._current = r
    end
  end
  step(...)
  return handle
end 

---@param argc integer 
---@param func fun(...):any 
---@param ... any
local function wait(argc, func, ...)
  vim.validate({
    argc = { argc, "number" },
    func = { func, "function" },
  })
  -- Always run the wrapped functions in xpcall and re-raise the error in the
  -- coroutine. This makes pcall work as normal.
  local function pfunc(...)
    local args = { ... }
    local cb = args[argc]
    args[argc] = function(...)
      cb(true, ...)
    end
    xpcall(func, function(err)
      cb(false, err, debug.traceback())
    end, unpack(args, 1, argc))
  end
  local ret = { coroutine.yield(argc, pfunc, ...) }
  local ok = ret[1]
  if not ok then
    local _, err, traceback = unpack(ret)
    error(string.format("Wrapped function failed: %s\n%s", err, traceback))
  end
  return unpack(ret, 2, table.maxn(ret))
end 

-- Wait on a callback style function
--
--- @param argc integer? The number of arguments of func.
--- @param func fun(...):any func callback style function to execute
--- @param ... any Arguments for func
function M.wait(...)
  if type(select(1, ...)) == "number" then
    return wait(...)
  end
  -- Assume argc is equal to the number of passed arguments.
  return wait(select("#", ...) - 1, ...)
end 

-- Use this to create a function which executes in an async context but
-- called from a non-async context. Inherently this cannot return anything
-- since it is non-blocking 
--
--- @param func fun(...):any
--- @param argc integer The number of arguments of func. Defaults to 0
--- @param strict boolean Error when called in non-async context
--- @return fun(...):commons.AsyncHandle
function M.create(func, argc, strict)
  vim.validate({
    func = { func, "function" },
    argc = { argc, "number", true },
  })
  argc = argc or 0
  return function(...)
    if M.running() then
      if strict then
        error("This function must run in a non-async context")
      end
      return func(...)
    end
    local callback = select(argc + 1, ...)
    return M.run(func, callback, unpack({ ... }, 1, argc))
  end
end 

-- Create a function which executes in an async context but
-- called from a non-async context.
--
--- @param func fun(...):any
--- @param strict boolean Error when called in non-async context
function M.void(func, strict)
  vim.validate({ func = { func, "function" } })
  return function(...)
    if M.running() then
      if strict then
        error("This function must run in a non-async context")
      end
      return func(...)
    end
    return M.run(func, nil, ...)
  end
end 

-- Creates an async function with a callback style function.
--
--- @param func fun(...):any A callback style function to be converted. The last argument must be the callback.
--- @param argc integer The number of arguments of func. Must be included.
--- @param strict boolean Error when called in non-async context
--- @return fun(...):any Returns an async function
function M.wrap(func, argc, strict)
  vim.validate({
    argc = { argc, "number" },
  })
  return function(...)
    if not M.running() then
      if strict then
        error("This function must run in an async context")
      end
      return func(...)
    end
    return M.wait(argc, func, ...)
  end
end 

-- Run a collection of async functions (`thunks`) concurrently and return when
-- all have finished.
--
--- @param thunks any[]
--- @param n integer Max number of thunks to run concurrently
--- @param interrupt_check fun():any Function to abort thunks between calls
function M.join(thunks, n, interrupt_check)
  local function run(finish)
    if #thunks == 0 then
      return finish()
    end
    local remaining = { select(n + 1, unpack(thunks)) }
    local to_go = #thunks
    local ret = {}
    local function cb(...)
      ret[#ret + 1] = { ... }
      to_go = to_go - 1
      if to_go == 0 then
        finish(ret)
      elseif not interrupt_check or not interrupt_check() then
        if #remaining > 0 then
          local next_task = table.remove(remaining)
          next_task(cb)
        end
      end
    end
    for i = 1, math.min(n, #thunks) do
      thunks[i](cb)
    end
  end
  if not M.running() then
    return run
  end
  return M.wait(1, false, run)
end 

--- Partially applying arguments to an async function 
--
--- @param fn fun(...):any
--- @param ... any arguments to apply to `fn`
function M.curry(fn, ...)
  local args = { ... }
  local nargs = select("#", ...)
  return function(...)
    local other = { ... }
    for i = 1, select("#", ...) do
      args[nargs + i] = other[i]
    end
    fn(unpack(args))
  end
end 

-- An async function that when called will yield to the Neovim scheduler to be
-- able to call the neovim API.
--
--- @type fun():nil
M.scheduler = M.wrap(vim.schedule, 1, false) 

return M
