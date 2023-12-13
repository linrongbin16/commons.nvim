<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.buffers](/lua/commons/buffers.lua ":ignore")

The compatible Neovim APIs for nvim buffers.

## Functions

### `get_buf_option`

Get buffer option with buffer number (`bufnr`) and option name (`name`).

```lua
function(bufnr:integer, name:string):any
```

### `set_buf_option`

Set buffer option.

```lua
(bufnr:integer, name:string, value:any):any
```
