<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.windows](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/windows.lua)

The compatible Neovim APIs for nvim windows.

## Functions

### `get_win_option`

Get window option.

```lua
function get_win_option(winnr:integer, name:string):any
```

Parameters:

- `winnr`: The window number.
- `name`: The option number.

Returns:

- Returns the option value.

### `set_win_option`

Set window option.

```lua
function set_win_option(winnr:integer, name:string, value:any):any
```

Parameters:

- `winnr`: The window number.
- `name`: The option number.
- `value`: The option value.
