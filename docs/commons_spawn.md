<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.spawn](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/spawn.lua)

Sync/async run child-process via `uv.spawn` API, and handle stdout/stderr IO by line-based callbacks.

## Functions

### `run`

Run command line in child-process, this is just a wrapper for [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).

The only differences are:

- It provides more friendly line-based `stdout` and `stderr` callbacks in `opts`.
- By default `text = true` in `opts`.

```lua
--- @alias commons.SpawnLineProcessor fun(line:string):nil
--- @alias commons.SpawnOpts {stdout:commons.SpawnLineProcessor, stderr:commons.SpawnLineProcessor, [string]:any}
--- @alias commons.SpawnOnExit fun(completed:vim.SystemCompleted):nil

function run(cmd:string[], opts:commons.SpawnOpts, on_exit:commons.SpawnOnExit?):vim.SystemObject
```

Parameters:

- `cmd`: Exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `stdout`: Use line-wise callback that will be invoked when receiving a line from stdout.
  - `stderr`: Use line-wise callback that will be invoked when receiving a line from stderr, they are using the same function signature:

    ```lua
    function fn_line_processor(line:string):nil
    ```

  - `text`: By default is `true`.
