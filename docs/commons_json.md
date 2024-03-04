<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.json](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/json.lua)

Encode/decode between lua table and json string.

?> Just a wrapper on [actboy168/json.lua](https://github.com/actboy168/json.lua).

## Functions

### `encode`

Encode lua table to json string.

```lua
--- @param t table?
--- @return string?
M.encode = function(t)
```

Parameters:

- `t`: Lua table.

Returns:

- Returns encoded json string if lua table exists.
- Returns `nil` if `t` is `nil`.

### `decode`

Decode json string to lua table.

```lua
--- @param j string?
--- @return table?
M.decode = function(j)
```

Parameters:

- `j`: JSON string.

Returns:

- Returns decoded lua table if json string exists.
- Returns `nil` if `j` is `nil`.
