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

Parameters:

- `s`: Command line argument string.

Returns:

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

### `linewise`
