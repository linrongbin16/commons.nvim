# [commons.async](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/async.lua)

Very simple and rough wrap to turn async functions (with callbacks) into coroutine-version functions, thus getting out of the hell of callbacks.

> It is quite simple and rough, but correctly works. Big and complete coroutine library requires a lot of maintain effort (and I am not a master of lua coroutine), simple and easy is good enough.

## Functions

### `wrap`

Wrap a async function (with a callback in the last parameter), into a coroutine-version function without callbacks. Note: you can use the coroutine-version function without callbacks (just like a sync function)!

!> The callback parameter must be the last parameter in the async function!

```lua
--- @param func function
--- @param argc integer
--- @return function
M.wrap = function(func, argc)
```

#### Parameters

- `func`: Async function with a callback parameter (as the last parameter).
- `argc`: Parameters number of the async function `func`.

#### Returns

It returns the wrapped coroutine-version function.

### `void`

Creates a async context thus can run coroutine-version functions inside it. The async context itself can be invoked in normal sync context, i.e. the Neovim lua scripts.

```lua
--- @param func function
--- @return function
M.void = function(func)
```

#### Parameters

- `func`: Wrapped coroutine-version function.

#### Returns

It returns the async context, which is also a lua function that can be invoked in normal sync context.

### `schedule`

Schedules Neovim event loop between libuv and `vim` APIs.

```lua
M.schedule = function()
```

### Examples

If without the `async` module, when we call the `uv.spawn` API to run some command lines in async way, for example let's echo some messages (`foo`, `bar`, `baz`), we will have to write code like this:

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

This easily leads code logics into the hell of callbacks.

The `wrap` API turns async function (with callbacks) into coroutine-version function, so we could use them just like sync functions:

```lua
local a = require('commons.async')

-- Note:
-- The 1st parameter `run_job` is the original async function.
-- The 2nd parameter `3` is the number of the parameters of `run_job` function.
local run_job_a = a.wrap(run_job, 3)
```

The wrapped coroutine-version functions must be invoked inside the async context, here comes the `void` API:

```lua
-- Creates the async context, so `run_job_a` methods can be invoked inside it.
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

The `void` API creates a async context `run`, thus coroutine-version functions such as `run_job_a` can be invoked inside it just like normal sync functions! And `run` can be directly invoked in normal sync context.

In a real-world Neovim plugin project, the logic inside a async context can be quite completed and developer usually will have to invoke `vim` APIs. There's a technical limitation that we cannot invoke `vim` APIs inside a libuv event loop. Here comes the `schedule` API:

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
