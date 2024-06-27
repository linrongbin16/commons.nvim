<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.version](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/version.lua)

Compatible APIs to detect Neovim version, a wrapper on [vim.version](https://neovim.io/doc/user/lua.html#vim.version).

## Functions

### `to_string`

Convert version number from lua table to string, e.g. `{0, 9, 1}` to `"0.9.1"`.

```lua
--- @param l integer[]
--- @return string
M.to_string = function(l)
```

Parameters:

- `l`: Lua table.

Returns:

- Returns version number in string.

### `to_list`

Convert version number from string to lua table, e.g. `"0.9.1"` to `{0, 9, 1}`.

```lua
--- @param s string
--- @return integer[]
M.to_list = function(s)
```

Parameters:

- `s`: Version number in string.

Returns:

- Returns version number in lua table.

### `lt`

Whether current Neovim version is less than the specified version.

```lua
--- @param ver string|integer[]
--- @return boolean
M.lt = function(ver)
```

Parameters:

- `ver`: Specified version to compare with current Neovim, accepts version number in both lua table format or string format.

Returns:

- Returns `true` if current Neovim version &lt; `ver`, returns `false` otherwise.

### `ge`

Whether current Neovim version is greater than or equals to the specified version.

```lua
--- @param ver string|integer[]
--- @return boolean
M.ge = function(ver)
```

Parameters:

- `ver`: Specified version to compare with current Neovim, accepts version number in both lua table format or string format.

Returns:

- Returns `true` if current Neovim version &ge; `ver`, returns `false` otherwise.
