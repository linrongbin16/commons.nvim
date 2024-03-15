<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.uri](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/uri.lua)

[RFC 2396](https://www.ietf.org/rfc/rfc2396.txt) compatible URI encode/decode.

## Functions

### `encode`

Encode string into URI encoded format.

```lua
--- @param value string?
--- @return string?
M.encode = function(value)
```

Parameters:

- `value`: Lua string.

Returns:

- Returns encoded URI if success.
- Returns `nil` if `value` is not a `string` type.

### `decode`

Decode URI into plain string.

```lua
--- @param value string?
--- @return string?
M.decode = function(value)
```

Parameters:

- `value`: URI encoded string.

Returns:

- Returns decoded plain string if success.
- Returns `nil` if `value` is not a `string` type.
