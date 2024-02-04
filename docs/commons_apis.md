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

!> This API behaves like `nvim_get_hl(0, {name=xxx, link=false})`, e.g. the legacy `nvim_get_hl_by_name`.

```lua
--- @param hl string
--- @return {fg:integer?,bg:integer?,[string]:any,ctermfg:integer?,ctermbg:integer?,cterm:{fg:integer?,bg:integer?,[string]:any}}
M.get_hl = function(hl)
```

Parameters:

- `hl`: Highlighting group name.

Returns:

- Returns lua table with all RGB(gui) highlight args (see [nvim_set_hl()](<https://neovim.io/doc/user/api.html#nvim_set_hl()>) 3rd parameters `{*val}`):

  - `fg`, `bg`, `sp`, `bold`, `italic`, `underline`, etc.
  - `ctermfg`: ANSI(cterm) foreground color code.
  - `ctermbg`: ANSI(cterm) background color code.
  - `cterm`: Other ANSI(cterm) highlight args such as `sp`, `bold`, `italic`, `underline`, etc.

?> The `ctermfg`, `ctermbg` and `cterm` are equal to the result of `nvim_get_hl_by_name(xxx, false)`: `{foreground=ctermfg, background=ctermbg, ...=unpack(cterm)}`

?> Use `string.format("#%06x", fg)` to convert integer RGB color code into CSS color format such as `"#581720"`.
