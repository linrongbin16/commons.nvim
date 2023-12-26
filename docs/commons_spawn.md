<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.spawn](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/spawn.lua)

Run child-process with friendly line-wise callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).

## Functions

### `run`

Run command line in child-process, this is just a wrapper for [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>). The only differences are:

- It provides more friendly line-based `on_stdout` and `on_stderr` callbacks in `opts`.
- By default `text = true` in `opts`.

```lua
--- @alias commons.SpawnLineProcessor fun(line:string):nil
--- @alias commons.SpawnOpts {on_stdout:commons.SpawnLineProcessor, on_stderr:commons.SpawnLineProcessor, [string]:any}
--- @alias commons.SpawnOnExit fun(completed:vim.SystemCompleted):nil

function run(cmd:string[], opts:commons.SpawnOpts, on_exit:commons.SpawnOnExit?):vim.SystemObj
```

Parameters:

- `cmd`: Exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_stdout`: Use line-wise callback that will be invoked when receiving a line from stdout.
  - `on_stderr`: Use line-wise callback that will be invoked when receiving a line from stderr, they are using the same function signature:

    ```lua
    function fn_line_processor(line:string):nil
    ```

  - `text`: By default is `true`.

- `on_exit`: Exactly the same passing to `vim.system`.

Returns:

- Returns the `vim.SystemObj` object.

Sync/blocking and async/non-blocking:

- To run child process in sync/blocking way, set `on_exit` to `nil`, and invoke `wait()` on the returned object to wait for spawn exit.
- To run child process in async/non-blocking way, set `on_exit` to lua function and don't invoke `wait()` on the returned object to don't wait.
