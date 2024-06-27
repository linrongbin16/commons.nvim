<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.uri](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/uri.lua)

A wrapper on [vim.uri_encode](<https://neovim.io/doc/user/lua.html#vim.uri_encode()>) and [vim.uri_decode](<https://neovim.io/doc/user/lua.html#vim.uri_decode()>).

## Functions

### `encode`

Encode plain string to URI encoded.

```lua
---@param value string?
---@param rfc "rfc2396"|"rfc2732"|"rfc3986"|nil
---@return string?
M.encode = function(value, rfc)
```

Parameters:

- `value`: Plain string.
- `rfc`: Encode RFC: 2396, 2732, 3986. By default it's 3986.

Returns:

- Returns encoded URI string if success.
- Returns `nil` if `value` is `nil`.

### `decode`

Decode URI encoded to plain string.

```lua
---@param value string?
---@return string?
M.decode = function(value)
```

Parameters:

- `value`: URI encoded string.

Returns:

- Returns plain string if success.
- Returns `nil` if `value` is `nil`.
