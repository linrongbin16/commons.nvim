<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.jsons](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/jsons.lua)

Encode/decode between lua table/list and json string.

?> **Note:** Use [actboy168/json.lua](https://github.com/actboy168/json.lua) for Neovim &lt; 0.10, [vim.json](https://github.com/neovim/neovim/blob/a9fbba81d5d4562a2d2b2cbb41d73f1de83d3102/runtime/doc/lua.txt?plain=1#L772) for Neovim &ge; 0.10.

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
