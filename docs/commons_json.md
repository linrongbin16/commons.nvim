<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.json](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/json.lua)

Encode/decode between lua table and json string.

?> Just a wrapper on [actboy168/json.lua](https://github.com/actboy168/json.lua).

## Functions

### `encode`

Encode lua table to json string.

```lua
function encode(t:table?):string?
```

### `decode`

Decode json string to lua table.

```lua
function decode(j:string?):table?
```
