<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.buffers](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua)

The compatible Neovim APIs for nvim buffers.

## Functions

### `get_buf_option`

Get buffer option.

https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/buffers.lua#L3-L6


<iframe height="600" width="100%" scrolling="no" title="Zdog trefoil" src="https://codepen.io/desandro/embed/XWNWPve?height=600&theme-id=light&default-tab=js,result" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href='https://codepen.io/desandro/pen/XWNWPve'>Zdog trefoil</a> by Dave DeSandro
  (<a href='https://codepen.io/desandro'>@desandro</a>) on <a href='https://codepen.io'>CodePen</a>.
</iframe>


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
