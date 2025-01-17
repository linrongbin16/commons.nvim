<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.spawn](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/spawn.lua)

Run child-process with line-wise callback functions to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).

!> These methods only works for multiple strings list command. For single string command, please refer to [commons.shell](commons_shell.md).

## Functions

### `detached`

Run command line in child-process and process each line of output while running. The difference with `vim.system` API is:

- It process each line in the output of child-process while the process is running.
- It use `on_exit` callback function for process exit in no-wait mode, and doesn't allow wait for its exit.
- It is by default `text = true` in `opts`.

```lua
--- @alias commons.SpawnOnLine fun(line:string):any
--- @alias commons.SpawnOnExit fun(result:{exitcode:integer?,signal:integer?}?):nil
--- @alias commons.SpawnOpts {on_stdout:commons.SpawnOnLine,on_stderr:commons.SpawnOnLine?,[string]:any}
--- @alias commons.SpawnJob {obj:vim.SystemObj,opts:commons.SpawnOpts,on_exit:commons.SpawnOnExit?}

--- @param cmd string[]
--- @param opts commons.SpawnOpts?
--- @param on_exit commons.SpawnOnExit
--- @return commons.SpawnJob
M.detached = function(cmd, opts, on_exit)
```

#### Parameters

- `cmd`: Command line in multiple strings list, exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_stdout`: Callback function that will be invoked on each line of child process `stdout`, with signature:

    ```lua
    function on_stdout(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stdout`.

  - `on_stderr`: Callback function that will be invoked on each line of child process `stderr`, with signature:

    ```lua
    function on_stderr(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stderr`.

- `on_exit`: Callback function that will be invoked when child process exit, with signature:

  ```lua
  function on_exit(result:{exitcode:integer?,signal:integer?}?):nil
  ```

  - Parameters:
    - `result`: The exit information.

#### Returns

- Returns the `commons.SpawnJob` object.

### `waitable`

Run command line in child-process and process each line of output while running. The difference with `vim.system` API is:

- It process each line in the output of child-process while the process is running.
- It use `wait` API for process exit in sync mode, and doesn't allow `on_exit` callback function.
- It is by default `text = true` in `opts`.

> It is the **sync** version of the `detached` API, uses the `wait` API to wait for spawn job exit in sync mode.

```lua
--- @param cmd string[]
--- @param opts commons.SpawnOpts?
--- @return commons.SpawnJob
M.waitable = function(cmd, opts)
```

#### Parameters

- `cmd`: Command line in strings list, exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_stdout`: Callback function that will be invoked on each line of child process `stdout`, with signature:

    ```lua
    function on_stdout(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stdout`.

  - `on_stderr`: Callback function that will be invoked on each line of child process `stderr`, with signature:

    ```lua
    function on_stderr(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stderr`.

#### Returns

- Returns the `commons.SpawnJob` object.

### `wait`

Wait for the spawn job complete, only works for the job created by `waitable` API. This is just a wrapper for [vim.SystemObj:wait](<https://neovim.io/doc/user/lua.html#vim.system()>).

```lua
--- @param job commons.SpawnJob
--- @param timeout integer?
--- @return {exitcode:integer?,signal:integer?}
M.wait = function(job, timeout)
```

#### Parameters

- `job`: The returned spawn job from `waitable` API.
- `timeout`: Optional timeout in milliseconds. By default it is `nil`, i.e. wait forever.

#### Returns

- Returns the exit information.

## Notes

### No-Wait Mode

If you want to run a child process in no-wait mode, use the `detached` API and pass the `on_exit` function in the 3rd parameter, **DO NOT** invoke the `wait` API. For example:

```lua
local spawn = require("commons.spawn")

local job = spawn.detached({"cat", "README.md"}, {
  on_stdout = function(line)
    print(string.format("processed stdout:%d", vim.inspect(line)))
  end,
  on_stderr = function(line)
    print(string.format("processed stderr:%d", vim.inspect(line)))
  end,
}, function(result)
  print(string.format("exit code:%d", result.exitcode))
  print(string.format("signal:%d", result.signal))
end)

-- NOTE: Ignore the returned `job`, don't wait for it.
```

### Waitable Mode

If you want to run a child process in waitable mode, use the `waitable` API and don't the pass `on_exit` function, then call the `wait` API on the returned job. For example:

```lua
local spawn = require("commons.spawn")

local job = spawn.waitable({"cat", "README.md"}, {
  on_stdout = function(line)
    print(string.format("processed line:%d", vim.inspect(line)))
  end,
  on_stderr = function(line)
    print(string.format("processed stderr:%d", vim.inspect(line)))
  end,
})

-- Wait for the job done, this API runs in **sync** mode.
local result = spawn.wait(job)

print(string.format("exit code:%d", result.exitcode))
print(string.format("signal:%d", result.signal))
```
