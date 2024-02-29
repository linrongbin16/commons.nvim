<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.msgpack](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/msgpack)

Pack/unpack between lua table and msgpack bytes.

?> Just a wrapper on [fperrad/lua-MessagePack](https://fperrad.frama.io/lua-MessagePack).

## Functions

### `pack`

Pack(encode) lua table to msgpack bytes (`string`).

```lua
--- @param t table?
--- @return string?
M.pack = function(t)
```

### `unpack`

Unpack(decode) msgpack bytes (`string`) to lua table.

```lua
--- @param m string?
--- @return table?
M.unpack = function(m)
```
