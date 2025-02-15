# [commons.num](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/num.lua)

Numbers utilities, with type check and approximate float compare.

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

Whether `a` is equals to `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.eq = function(a, b, rel_tol, abs_tol)
```

Parameters:

- `a`: First number.
- `b`: Second number.
- `rel_tol`: Relative tolerance, by default is `1e-09`.
- `abs_tol`: Absolute tolerance, by default is `0.0`.

Returns:

- Returns `true` if `a` equals to `b` when both are integers.
- Returns `true` if `a` equals to `b` when either of them are floats, using approximate float compare method `math.abs(a - b) <= math.max(rel_tol * math.max(math.abs(a), math.abs(b)), abs_tol)` (which comes from python3's [math.isclose()](https://docs.python.org/3/library/math.html#math.isclose)).
- Returns `false` otherwise.

### `ne`

Whether `a` is not equals to `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.ne = function(a, b, rel_tol, abs_tol)
```

### `lt`

Whether `a` is less than (&lt;) `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.lt = function(a, b, rel_tol, abs_tol)
```

### `le`

Whether `a` is less than or equals to (&le;) `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.le = function(a, b, rel_tol, abs_tol)
```

### `gt`

Whether `a` is greater than (&gt;) `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.gt = function(a, b, rel_tol, abs_tol)
```

### `ge`

Whether `a` is greater than or equals to (&ge;) `b`.

```lua
--- @param a number?
--- @param b number?
--- @param rel_tol number?
--- @param abs_tol number?
--- @return boolean
M.ge = function(a, b, rel_tol, abs_tol)
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

- `f`: Unary function that map a parameter to number value.
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

- `f`: Unary function that map a parameter to number value.
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

### `random`

Drop-in 32-bit random replacement of `math.random` API implemented via [uv.random](https://github.com/luvit/luv/blob/master/docs.md#uvrandomlen-flags-callback).

```lua
function random(m:integer?, n:integer?):number
```

Parameters:

- `m`: Random integer bound.
- `n`: Random integer bound2.

Returns:

- When both `m` and `n` are `nil`, returns random floats in range `[0,1)`.
- When `m` is provided and `n` is `nil`, returns random integer in range `[1,m]`.
- When both `m` and `n` are provided, returns random integer in range `[m,n]`.

### `shuffle`

Shuffle list.

?> The shuffle function will not change the input list `l`.

```lua
function shuffle(l:any[]):any[]
```

Parameters:

- `l`: Lua list to shuffle.

Returns:

- Returns the shuffled list.
