# [commons.shell](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/shell.lua)

Run shell command and handles argument string escaping.

!> The `escape` API only works for single-line argument escaping. It is not for 1) Complicated shell scripts. 2) Multi-line shell commands. 3) Windows PowerShell.

!> The `detached` and `waitable` APIs only works for single string command. For multiple strings list command, please refer to [commons.spawn](commons_spawn.md).

## Functions

### `escape`

Escape command line argument string, works for both `sh` (for POSIX compatible OS) and `cmd.exe` (for Windows/DOS).

```lua
--- @param s string
--- @return string
M.escape = function(s)
```

#### Parameters

- `s`: Command line argument string.

#### Returns

- Returns the escaped argument string.

### `detached`

Run command line in child-process and process each line of output while running. This is just a wrapper on [jobstart](<https://neovim.io/doc/user/builtin.html#jobstart()>) API. The difference is:

- It handles the `vim.o.shell` options for Windows platform, thus process the escaped command line string.
- It process each line in the output of child-process while the process is running.

```lua
--- @alias commons.ShellJobOnExit fun(exitcode:integer?):nil
--- @alias commons.ShellJobOnLine fun(line:string?):any
--- @alias commons.ShellJobOpts {on_stdout:commons.ShellJobOnLine,on_stderr:commons.ShellJobOnLine?,[string]:any}
--- @alias commons.ShellJob {jobid:integer,opts:commons.ShellJobOpts,on_exit:commons.ShellJobOnExit?}

--- @param cmd string
--- @param opts commons.ShellJobOpts?
--- @param on_exit commons.ShellJobOnExit
--- @return commons.ShellJob
M.detached = function(cmd, opts, on_exit)
```

#### Parameters

- `cmd`: Command line in single string, exactly the same passing to `jobstart`.
- `opts`: Almost the same passing to `jobstart`, except:

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
  function on_exit(exitcode:integer?):nil
  ```

  - Parameters:
    - `exitcode`: The exit code.

#### Returns

- Returns the `commons.ShellJob` object.

### `waitable`

Run command line in child-process and process each line of output while running. This is just a wrapper on [jobstart](<https://neovim.io/doc/user/builtin.html#jobstart()>) API. The difference is:

- It handles the `vim.o.shell` options for Windows platform, thus process the escaped command line string.
- It process each line in the output of child-process while the process is running.
- It use `wait` API for process exit in sync mode, and doesn't allow `on_exit` callback function.

> It is the **sync** version of the `detached` API, uses the `wait` API to wait for spawn job exit in sync mode.

```lua
--- @param cmd string
--- @param opts commons.ShellJobOpts?
--- @return commons.ShellJob
M.waitable = function(cmd, opts)
```

#### Parameters

- `cmd`: Command line in strings list, exactly the same passing to `jobstart`.
- `opts`: Almost the same passing to `jobstart`, except:

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

!> This API is failed in unit testing! Use it at your own risk!

Wait for the spawn job complete, only works for the job created by `waitable` API. This is just a wrapper on [jobwait](<https://neovim.io/doc/user/builtin.html#jobwait()>) API.

```lua
--- @param job commons.ShellJob
--- @param timeout integer?
M.wait = function(job, timeout)
```

#### Parameters

- `job`: The `commons.ShellJob` object returned from `waitable` API.
- `timeout`: Wait timeout in milliseconds. By default it is `nil`, i.e. wait forever.

## Notes

### No-Wait Mode

If you want to run a child process in no-wait mode, use the `detached` API and pass the `on_exit` function in the 3rd parameter, **DO NOT** invoke the `wait` API. For example:

```lua
local shell = require("commons.shell")

local job = shell.detached("cat README.md", {
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
local shell = require("commons.shell")

local job = shell.waitable("cat README.md", {
  on_stdout = function(line)
    print(string.format("processed line:%d", vim.inspect(line)))
  end,
  on_stderr = function(line)
    print(string.format("processed stderr:%d", vim.inspect(line)))
  end,
})

-- Wait for the job done, this API runs in **sync** mode.
shell.wait(job)

-- NOTE: For `waitable` shell job, there's no wait to query its exit code. This is a trade-off between API design and system limitation.
```
