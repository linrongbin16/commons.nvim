<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.buffers](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua)

The compatible Neovim APIs for nvim buffers.

## Functions

### `get_buf_option`

Get buffer option with buffer number (`bufnr`) and option name (`name`).

```lua
function get_buf_option(bufnr:integer, name:string):any
```

### `set_buf_option`

Set buffer option (to `value`) with buffer name (`bufnr`) and option name (`name`).

```lua
function set_buf_option(bufnr:integer, name:string, value:any):any
```
