<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.apis](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/apis.lua)

Compatible builtin APIs across multiple Neovim versions, a wrapper on [vim.api](https://neovim.io/doc/user/api.html).

## Functions

### `get_buf_option`

Get buffer option.

```lua
function get_buf_option(bufnr:integer, name:string):any
```

Parameters:

- `bufnr`: The buffer number.
- `name`: The option number.

Returns:

- Returns option value.

### `set_buf_option`

Set buffer option value.

```lua
function set_buf_option(bufnr:integer, name:string, value:any):any
```

Parameters:

- `bufnr`: The buffer number.
- `name`: The option number.
- `value`: The option value.

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

### `get_hl`

Get both ANSI(cterm)/RGB(gui) color codes from syntax highlighting group.

```lua
--- @param hl string
--- @return {fg:integer?,bg:integer?,ctermfg:integer?,ctermbg:integer?}
M.get_hl = function(hl)
```

Parameters:

- `hl`: Highlighting group name.

Returns:

- Returns lua table with below fields:
  - `fg`: RGB(gui) foreground color code.
  - `bg`: RGB(gui) background color code.
  - `ctermfg`: ANSI(cterm) terminal foreground color code.
  - `ctermbg`: ANSI(cterm) terminal background color code.

?> Use `string.format("#%06x", fg)` to convert RGB color code into CSS color format such as `"#581720"`.
