<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.tables](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/tables.lua)

Lua table/list utilities, with type check.

## Functions

### `tbl_empty`

Whether lua table `t` is empty, with type check.

```lua
function tbl_empty(t:table?):boolean
```

### `tbl_not_empty`

Whether lua table `t` is not empty, with type check.

```lua
function tbl_not_empty(t:table?):boolean
```

### `tbl_get`

Drop-in replacement of [vim.tbl_get](<https://neovim.io/doc/user/lua.html#vim.tbl_get()>).

```lua
function tbl_get(t:table?, ...:any):any
```

Parameters:

- `t`: The lua table/list.
- `...`: Variadic indexing fields.

Returns:

- Returns element if get success.
- Returns `nil` if get failed.

### `tbl_contains`

Whether lua table `t` contains a value `v`, with optional `compare` function.

```lua
function tbl_contains(t:table?, v:any, compare:(fun(a:any,b:any):boolean)|nil):boolean
```

Parameters:

- `t`: Lua table.
- `v`: Target value.
- `compare`: Optional compare function that accept two parameters and returns whether they're equal. By default is `=`.

Returns:

- Returns `true` if table `t` contains value `v`.
- Returns `false` if table `t` doesn't contain value `v`.

### `list_empty`

Whether lua list `l` is empty, with type check.

```lua
function list_empty(l:table?):boolean
```

### `list_not_empty`

Whether lua list `l` is not empty, with type check.

```lua
function list_not_empty(l:table?):boolean
```

### `list_index`

Get list index with negative support.

```lua
function list_index(l:table, idx:integer):integer
```

Parameters:

- `l`: The lua list.
- `idx`: The index integer.

Returns:

- If `idx > 0`, returns `idx` itself.
- If `idx < 0`, returns `#l + idx + 1`, for example:
  - If `idx = -1`, returns `#l`, e.g. the last element position.
  - If `idx = -#l`, returns `1`, e.g. the first element position.

### `list_contains`

Whether lua list `l` contains a value `v`, with optional `compare` function.

```lua
function list_contains(t:table?, v:any, compare:(fun(a:any,b:any):boolean)|nil):boolean
```

Parameters:

- `l`: Lua list.
- `v`: Target value.
- `compare`: Optional compare function that accept two parameters and returns whether they're equal. By default is `=`.

Returns:

- Returns `true` if list `l` contains value `v`.
- Returns `false` if list `l` doesn't contain value `v`.
