<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.buffers](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua)

The compatible Neovim APIs for nvim buffers.

## Functions

### `get_buf_option`

Get buffer option.

https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua#L3-L6

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
