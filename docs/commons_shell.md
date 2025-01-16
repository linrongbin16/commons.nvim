# [commons.shell](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/shell.lua)

Run shell command and handles argument string escaping.

!> The `escape` methods only works for single-line argument escaping. It is not for 1) Complicated shell scripts. 2) Multi-line shell commands. 3) Windows PowerShell.

!> The `blockwise` and `linewise` methods only works for single string command. For strings list command, please refer to [commons.spawn](commons_spawn.md).

## Functions

### `escape`

Escape command line argument string, works for both `sh` (for POSIX compatible OS) and `cmd.exe` (for Windows/DOS).

- It pass the `on_exit` method in `opts`.
- It is by default `text = true` in `opts`.

```lua
--- @alias commons.SpawnOnExit fun(completed:vim.SystemCompleted):nil
--- @alias commons.SpawnBlockWiseOpts {on_exit:commons.SpawnOnExit?,[string]:any}
--- @param cmd string[]
--- @param opts commons.SpawnBlockWiseOpts?
--- @return vim.SystemObj
M.blockwise = function(cmd, opts)
```

Parameters:

- `cmd`: Command line in string list, exactly the same passing to `vim.system`.
- `opts`: Almost the same passing to `vim.system`, except:

  - `on_exit`: Callback function that will be invoked when child process exit, with signature:

    ```lua
    function on_exit(completed:vim.SystemCompleted):any
    ```

    - Parameters:
      - `completed`: The `vim.SystemCompleted` object.

Returns:

- Returns the `vim.SystemObj` object.
