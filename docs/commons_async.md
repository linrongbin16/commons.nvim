# [commons.async](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/async.lua)

Very simple and rough wrap to turn callback-style functions into async-style functions, with the help of lua's `coroutine`, thus getting out of the callback hell.

> It is quite simple and rough, but correctly works. Big and complete coroutine library requires a lot of maintain effort (and I am not a master of lua coroutine), simple and easy is good enough.

## Functions

### `wrap`

Wrap a callback-style function, into a async-style function without callbacks. Note: you can use the async-style function without callbacks (just like a sync function)!

!> The callback parameter must be the last parameter in the callback-style function!

```lua
--- @param func function
--- @param argc integer
--- @return function
M.wrap = function(func, argc)
```

#### Parameters

- `func`: The callback-style function with a callback parameter (as the last parameter).
- `argc`: Parameters number of the function `func`.

#### Returns

It returns the wrapped async-style function.

### `void`

Creates a async context thus can run async-style functions inside it. The async context itself can be called in normal sync context, i.e. the Neovim lua scripts.

```lua
--- @param func function
--- @return function
M.void = function(func)
```

#### Parameters

- `func`: Wrapped async-style function.

#### Returns

It returns the async context, which is also a lua function that can be called in normal sync context.

### `schedule`

Schedules Neovim event loop between libuv and `vim` APIs.

```lua
M.schedule = function()
```

### Examples

The `libuv` brings a bunch of callback-style functions to turn sync/blocking IO operations into async/non-blocking. It has great performance, while it also brings the callback hell. Consider we are calling the `uv.spawn` API to execute shell commands, for example, let's print some messages with `echo foo`, `echo bar`, `echo baz`, we will have to write code like this:

```lua
local function run_job(cmd, args, callback)
  local handle
  handle = vim.uv.spawn(cmd, { args  = args, },
    function(code)
      s.handle:close()
      callback(code)
    end
  )
end

run_job('echo', {'foo'},
  function(code1)
    if code1 ~= 0 then
      return
    end
    run_job('echo', {'bar'},
      function(code2)
        if code2 ~= 0 then
          return
        end
        run_job('echo', {'baz'})
      end
    )
  end
)
```

This easily leads code logic to callback hell.

The `wrap` API turns callback-style function into async-style function, so we could use them just like the `await` functions in javascripts:

```lua
local a = require('commons.async')

-- Note:
-- The 1st parameter `run_job` is the original callback-style function.
-- The 2nd parameter `3` is the number of the parameters of the function `run_job`.
local run_job_a = a.wrap(run_job, 3)
```

The wrapped async-style functions will have exactly the same parameters with the original callback-style function signatures, except the last parameter is been removed. You don't have to pass a callback function to it any longer, the result will be directly returned just like `await` functions in javascripts.

The wrapped async-style functions must be called inside the async context, via the `void` API:

```lua
-- Creates the async context, so `run_job_a` methods can be called inside it.
local run = a.void(function()
    local code1 = run_job_a('echo', {'foo'})
    if code1 ~= 0 then
        return
    end
    local code2 = run_job_a('echo', {'bar'})
    if code2 ~= 0 then
        return
    end
    run_job_a('echo', {'baz'})
end)

-- Runs the async context in the normal sync context.
run()
```

The `void` API creates a async context `run` (also a lua function), thus the async-style function `run_job_a` can be called inside it, the value passed to the original callback will be directly returned! And `run` can be directly called in the normal Neovim scripts, i.e. a sync context.

In a real-world Neovim plugin, the code logic of a async context can be quite complicated and developer usually will have to call Neovim APIs (i.e. the `vim.api`, `vim.fn`, `vim.cmd`, etc). There's a technical limitation that we cannot call these `vim` APIs inside a libuv event loop.

We will have to call the `schedule` API before any `vim` APIs:

```lua
local run = a.void(function()
    local code1 = run_job_a('echo', {'foo'})
    if code1 ~= 0 then
        return
    end

    -- Note: Must call `schedule` before any `vim` APIs.
    a.schedule()

    -- Then you can call `vim` APIs.
    local win_height = vim.api.nvim_win_get_height(0)

    local code2 = run_job_a('echo', {'bar'})
    if code2 ~= 0 then
        return
    end
    run_job_a('echo', {'baz'})
end)

run()
```
