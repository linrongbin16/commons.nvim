<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.buffers](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua)

The compatible Neovim APIs for nvim buffers.

## Functions

### `get_buf_option`

Get buffer option.

https://github.com/linrongbin16/commons.nvim/blob/487e197fe8ce9db28aec656df43df1c712710fac/lua/commons/buffers.lua#L3-L6

Parameters:

- `bufnr`: The buffer number.
- `name`: The option number.

Returns:

- Returns option value.

### `set_buf_option`

Set buffer option value.

https://github.com/linrongbin16/commons.nvim/blob/487e197fe8ce9db28aec656df43df1c712710fac/lua/commons/buffers.lua#L14-L17

Parameters:

- `bufnr`: The buffer number.
- `name`: The option number.
- `value`: The option value.
