# [commons.shell](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/shell.lua)

Run shell command and handles argument string escaping.

!> The `escape` methods only works for single-line argument escaping. It is not for 1) Complicated shell scripts. 2) Multi-line shell commands. 3) Windows PowerShell.

!> The `blockwise` and `linewise` methods only works for single string command. For strings list command, please refer to [commons.spawn](commons_spawn.md).

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

### `blockwise`

Run command line in child-process and collect all the output. This is just a wrapper on [jobstart](<https://neovim.io/doc/user/builtin.html#jobstart()>) API. The difference is:

- It handles the `vim.o.shell` options for Windows platform.

```lua
--- @alias commons.ShellJobOnExit fun(exitcode:integer?):nil
--- @alias commons.ShellJobBlockWiseOnStdout fun(lines:string[]?):any
--- @alias commons.ShellJobBlockWiseOnStderr fun(lines:string[]?):any
--- @alias commons.ShellJobBlockWiseOpts {on_stdout:commons.ShellJobBlockWiseOnStdout,on_stderr:commons.ShellJobBlockWiseOnStderr?,on_exit:commons.ShellJobOnExit?,[string]:any}
--- @param cmd string
--- @param opts commons.ShellJobBlockWiseOpts?
--- @return integer
M.blockwise = function(cmd, opts)
```

#### Parameters

- `cmd`: Single-line command line string.
- `opts`: Almost the same with `jobstart` options, except:

  - `on_stdout`: Callback function that will be invoked with all the lines from `stdout` when child process complete, with function signature:

    ```lua
    function on_stdout(lines:string[]):any
    ```

    - Parameters:
      - `lines`: All the lines from the process output `stdout`.

  - `on_stderr`: Callback function that will be invoked with all the lines from `stderr` when child process complete, with function signature:

    ```lua
    function on_stderr(lines:string[]?):any
    ```

    - Parameters:
      - `lines`: All the lines from the process `stderr`.

  - `on_exit`: Callback function that will be invoked when child process exit, with function signature:

    ```lua
    function on_exit(exitcode:integer?):nil
    ```

    - Parameters:
      - `exitcode`: The exit code.

#### Returns

- Returns the job ID.

### `linewise`

Run command line in child-process and process each line of output while running. This is just a wrapper on [jobstart](<https://neovim.io/doc/user/builtin.html#jobstart()>) API. The difference is:

- It handles the `vim.o.shell` options for Windows platform.
- It process each line in the output of child-process while the process is running.

```lua
--- @alias commons.ShellJobLineWiseOnStdout fun(line:string?):any
--- @alias commons.ShellJobLineWiseOnStderr fun(line:string?):any
--- @alias commons.ShellJobLineWiseOpts {on_stdout:commons.ShellJobLineWiseOnStdout,on_stderr:commons.ShellJobLineWiseOnStderr?,on_exit:commons.ShellJobOnExit?,[string]:any}
--- @param cmd string
--- @param opts commons.ShellJobLineWiseOpts?
--- @return integer
M.linewise = function(cmd, opts)
```

#### Parameters

- `cmd`: Single-line command line string.
- `opts`: Almost the same with `jobstart` options, except:

  - `on_stdout`: Callback function that will be invoked on each line of the `stdout` while child process is running, with function signature:

    ```lua
    function on_stderr(line:string?):any
    ```

    - Parameters:
      - `line`: Each line of the process output `stdout`.

  - `on_stderr`: Callback function that will be invoked on each line of the `stderr` while child process is running, with function signature:

    ```lua
    function on_stderr(line:string?):any
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

- Returns the job ID.

### `wait`

This method is to wait for the job(s) done, by the job ID(s). This is just a wrapper on [jobwait](<https://neovim.io/doc/user/builtin.html#jobwait()>) API.

```lua
--- @param jobid integer[]
--- @param timeout integer?
M.wait = function(jobid, timeout)
```

#### Parameters

- `jobid`: Job IDs list.
- `timeout`: Wait timeout in milliseconds. By default it is `nil`, i.e. wait forever.
