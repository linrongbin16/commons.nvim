<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.spawn](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/spawn.lua)

Run child-process with both line-wise/until-complete callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).

!> The `blockwise` and `linewise` methods only works for multiple strings list command. For single string command, please refer to [commons.shell](commons_shell.md).

## Functions

### `blockwise`

Run command line in child-process and collect all the output. The difference with `vim.system` API is:

- It pass the `on_exit` method in `opts`.
- It is by default `text = true` in `opts`.

```lua
--- @alias commons.SpawnJob {obj:vim.SystemObj,opts:commons.SpawnBlockWiseOpts|commons.SpawnLineWiseOpts}
--- @alias commons.SpawnOnExit fun(completed:vim.SystemCompleted):nil
--- @alias commons.SpawnBlockWiseOpts {on_exit:commons.SpawnOnExit?,[string]:any}
--- @param cmd string[]
--- @param opts commons.SpawnBlockWiseOpts?
--- @return commons.SpawnJob
M.blockwise = function(cmd, opts)
```

#### Parameters

- `cmd`: Command line in string list, exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_exit`: Callback function that will be invoked when child process exit, with signature:

    ```lua
    function on_exit(completed:vim.SystemCompleted):any
    ```

    - Parameters:
      - `completed`: The `vim.SystemCompleted` object.

#### Returns

- Returns the `commons.SpawnJob` object.

#### Note

If you want to run this API in async mode, pass the `on_exit` function in `opts`, and DO NOT invoke the `wait` method. For example:

```lua
local spawn = require("commons.spawn")
local job = spawn.blockwise({"cat", "README.md"}, {
  on_exit = function(completed)
    print(string.format("exit code:%d", completed.code))
    print(string.format("signal:%d", completed.signal))
    print(string.format("process stdout:%d", vim.inspect(completed.stdout)))
    print(string.format("process stderr:%d", vim.inspect(completed.stderr)))
  end,
})

-- Ignore the returned `job`, don't wait for it, thus this job will run in async.
```

If you want to run this API in sync mode, don't the pass `on_exit` function in `opts`, and invoke the `wait` method on the returned job. For example:

```lua
local spawn = require("commons.spawn")
local job = spawn.blockwise({"cat", "README.md"})

-- Wait for the job done, this is sync.
local completed = spawn.wait(job)

print(string.format("exit code:%d", completed.code))
print(string.format("signal:%d", completed.signal))
print(string.format("process stdout:%d", vim.inspect(completed.stdout)))
print(string.format("process stderr:%d", vim.inspect(completed.stderr)))
```

### `linewise`

Run command line in child-process and process each line of output while running. The difference with `vim.system` API is:

- It process each line in the output of child-process while the process is running.
- It is by default `text = true` in `opts`.

```lua
--- @alias commons.SpawnLineWiseProcessor fun(line:string):any
--- @alias commons.SpawnLineWiseOpts {on_stdout:commons.SpawnLineWiseProcessor,on_stderr:commons.SpawnLineWiseProcessor?,on_exit:commons.SpawnOnExit?,[string]:any}
--- @param cmd string[]
--- @param opts commons.SpawnLineWiseOpts?
--- @return commons.SpawnJob
M.linewise = function(cmd, opts)
```

#### Parameters

- `cmd`: Command line in string list, exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_stdout`: Callback function that will be invoked on each line of child process output `stdout`, with signature:

    ```lua
    function on_stdout(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stdout`.

  - `on_stderr`: Callback function that will be invoked on each line of child process output `stderr`, with signature:

    ```lua
    function on_stderr(line:string):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stderr`.

  - `on_exit`: Callback function that will be invoked when child process exit, with signature:

    ```lua
    function on_exit(completed:vim.SystemCompleted):nil
    ```

    - Parameters:
      - `completed`: The `vim.SystemCompleted` object.

#### Returns

- Returns the `commons.SpawnJob` object.

#### Note

If you want to run this API in async mode, pass the `on_exit` function in `opts`, and DO NOT invoke the `wait` method. For example:

```lua
local spawn = require("commons.spawn")
local job = spawn.linewise({"cat", "README.md"}, {
  on_stdout = function(line)
    print(string.format("processed stdout:%d", vim.inspect(line)))
  end,
  on_stderr = function(line)
    print(string.format("processed stderr:%d", vim.inspect(line)))
  end,
  on_exit = function(completed)
    print(string.format("exit code:%d", completed.code))
    print(string.format("signal:%d", completed.signal))
  end,
})

-- Ignore the returned `job`, don't wait for it, thus this job will run in async.
```

If you want to run this API in sync mode, don't the pass `on_exit` function in `opts`, and invoke the `wait` method on the returned job. For example:

```lua
local spawn = require("commons.spawn")
local job = spawn.linewise({"cat", "README.md"}, {
  on_stdout = function(line)
    print(string.format("processed line:%d", vim.inspect(line)))
  end,
  on_stderr = function(line)
    print(string.format("processed stderr:%d", vim.inspect(line)))
  end,
})

-- Wait for the job done, this is sync.
local completed = spawn.wait(job)

print(string.format("exit code:%d", completed.code))
print(string.format("signal:%d", completed.signal))
```
