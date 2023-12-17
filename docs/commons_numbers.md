<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.numbers](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/numbers.lua)

Numbers utilities, with type check.

## Constants

### `INT32_MAX`

32-Bit integer max value.

```lua
--- @type integer
```

### `INT32_MIN`

32-Bit integer min value.

```lua
--- @type integer
```

## Functions

### `eq`

Whether `a` is equals to `b`, with type check.

```lua
function eq(a:number?, b:number?):boolean
```

### `ne`

Whether `a` is not equals to `b`, with type check.

```lua
function ne(a:number?, b:number?):boolean
```

### `lt`

Whether `a` is less than (&lt;) `b`, with type check.

```lua
function lt(a:number?, b:number?):boolean
```

### `le`

Whether `a` is less than or equals to (&le;) `b`, with type check.

```lua
function le(a:number?, b:number?):boolean
```

### `gt`

Whether `a` is greater than (&gt;) `b`, with type check.

```lua
function gt(a:number?, b:number?):boolean
```

### `ge`

Whether `a` is greater than or equals to (&ge;) `b`, with type check.

```lua
function ge(a:number?, b:number?):boolean
```

### `mod`

Get the remainder of division, e.g. the `%` calculate operator.

```lua
function mod(a:integer, b:integer):integer
```

Parameters:

- `a`: Divisor.
- `b`: Dividend.

Returns:

- Remainder.

?> Also see: [math.fmod](http://lua-users.org/wiki/MathLibraryTutorial).

### `max`

Get the maximal element by unary-function mapped value.

```lua
function max(f:fun(v:any):number, a:any, ...:any):any,integer
```

Parameters:

- `f`: Unary function that map a paramter to number value.
- `a`: First parameter.
- `...`: Other variadic parameters.

Returns:

- Returns the maximal parameter and its position.

### `min`

Get the minimal element by unary-function mapped value.

```lua
function min(f:fun(v:any):number, a:any, ...:any):any,integer
```

Parameters:

- `f`: Unary function that map a paramter to number value.
- `a`: First parameter.
- `...`: Other variadic parameters.

Returns:

- Returns the minimal parameter and its position.

### `bound`

Bound `value` by upper bound `right` and lower bound `left`.

```lua
function bound(value:number, left:number, right:number):number
```

Parameters:

- `value`: Input number.
- `left`: Lower bound.
- `right`: Upper bound.

Returns:

- If `left` &le; `value` &le; `right`, returns `value` without changes.
- If `value` &lt; `left`, returns `left`.
- If `value` &gt; `right`, returns `right`.

### `auto_incremental_id`

Get auto-incremental ID, start from `1`.

```lua
function auto_incremental_id():integer
```
