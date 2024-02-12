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

Drop-in replacement of [vim.tbl_get()](<https://neovim.io/doc/user/lua.html#vim.tbl_get()>).

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

### `is_list`

Whether the parameter is an instance of the `List` class.

```lua
--- @param o any
--- @return boolean
M.is_list = function(o)
```

Parameters:

- `o`: An object.

Returns:

- Returns `true` if `o` is an instance of the `List` class, returns `false` if not.

### `is_hashmap`

Whether the parameter is an instance of the `HashMap` class.

```lua
--- @param o any?
--- @return boolean
M.is_hashmap = function(o)
```

Parameters:

- `o`: An object.

Returns:

- Returns `true` if `o` is an instance of the `HashMap` class, returns `false` if not.

## Classes

### `List`

High-level list/array data structure.

?> The API design is heavily influenced by [Javascript Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) and [lodash](https://lodash.com/docs), but some APIs are different, because lua is not javascript anyway, and `List` is designed to be purely functional programming without side-effect.

#### Methods

##### `wrap`

Create a list by wrap a lua table list.

```lua
--- @param l any[]
--- @return commons.List
function List:wrap(l)
```

Parameters:

- `l`: The lua table used to create the list.

  !> The ownership of the memory/resource/data of the lua table will be moved to the created list. You should never use the parameter `l` any more. This is very likely to the C++ `move` API, or the Rust data ownership.

Returns:

- Returns the created list.

##### `of`

Create a list from 0 or more elements.

```lua
--- @param ... any
--- @return commons.List
function List:of(...)
```

Parameters:

- `...`: Variadic elements that used to create the list.

Returns:

- Returns the created list.

##### `data`

The internal lua table of the list.

```lua
--- @return any[]
function List:data()
```

Returns:

- Returns the internal lua table.

##### `length`

Get the length of the list.

```lua
--- @return integer
function List:length()
```

Returns:

- Returns the length of the list.

##### `empty`

Whether the list is empty or not.

```lua
--- @return boolean
function List:empty()
```

Returns:

- Returns `true` if the list is empty (e.g. the length &gt; 0), returns `false` if not (e.g. the length = 0).

##### `at`

Get the element at specific index.

```lua
--- @param index integer
--- @return any
function List:at(index)
```

Parameters:

- `index`: The index of the list, this parameter accepts negative integers.
  - When `index` &lt; 0, `-1` is the last element, `-length()` is the first element. Internal logic is close to `self._data[#self._data + index + 1]`.

Returns:

- Returns the element at `index`, or `nil` if not found.

##### `first`

Get the first element at head.

```lua
--- @return any
function List:first()
```

Returns:

- Returns the first element if exists, returns `nil` if empty.

##### `last`

Get the last element at head.

```lua
--- @return any
function List:last()
```

Returns:

- Returns the last element if exists, returns `nil` if empty.

##### `concat`

Concat two list (current list and another list) into a new list.

```lua
--- @param other commons.List
--- @return commons.List
function List:concat(other)
```

Parameters:

- `other`: Another list.

Returns:

- Returns a new list.

##### `join`

Join elements of current list into a string.

```lua
--- @param separator string?
--- @return string
function List:join(separator)
```

Parameters:

- `separator`: Separator string between two elements, by default is a whitespace `" "`.

Returns:

- Returns joined string.

##### `every`

Whether all elements are satisfied with an unary detect function.

?> This API usually can be named to `allOf`, `allMatch` in other programming languages.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:every(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns `true` if all elements are satisfied, `false` if not.

##### `some`

Whether any elements (at least 1) are satisfied with an unary detect function.

?> This API usually can be named to `anyOf`, `anyMatch` in other programming languages.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:some(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns `true` if any elements (at least 1) are satisfied, `false` otherwise.

##### `none`

Whether no element is satisfied (e.g. all elements are not satisfied) with an unary detect function.

?> This API usually can be named to `noneOf`, `noneMatch` in other programming languages.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return boolean
function List:none(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns `true` if no element is satisfied (e.g. all elements are not satisfied), `false` otherwise.

##### `filter`

Filter the list and create a new list.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return commons.List
function List:filter(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns a new list that all elements are satisfied, those unsatisfied elements are been filtered.

##### `find`

Find the first element that satisfied the unary detect function, e.g. search by index from 1 to `length()`.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return any?, integer
function List:find(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns the first element that satisfied the unary function `f` and its index, if found.
- Returns `nil` and `-1`, if not found.

##### `findLast`

Find the last element that satisfied the unary detect function, e.g. search by index from `length()` to 1.

```lua
--- @param f fun(value:any, index:integer):boolean
--- @return any?, integer
function List:findLast(f)
```

Parameters:

- `f`: Unary detect function, it use below signature:

  ```lua
  function f(value:any, index:integer):boolean
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

  Returns:

  - Returns `true` if satisfied, `false` if not.

Returns:

- Returns the last element that satisfied the unary function `f` and its index, if found.
- Returns `nil` and `-1`, if not found.

##### `indexOf`

Find the first index of the element that equals to the given value, e.g. search by index from 1 to `length()`.

```lua
--- @param value any
--- @param start integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return integer?
function List:indexOf(value, start, comparator)
```

Parameters:

- `value`: The value to be found.
- `start`: Start searching index, by default is `1`.
- `comparator`: Binary function to compare two elements, by default is `nil`. When `nil` use simply `=` to compare two elements. It use below signature:

  ```lua
  function comparator(a:any, b:any):boolean
  ```

  Parameters:

  - `a`: An element.
  - `b`: Another element.

  Returns:

  - Returns `true` if two elements are equal, `false` if not.

Returns:

- Returns the first index of the element that equals to `value`, if found.
- Returns `nil`, if not found.

##### `lastIndexOf`

Find the last index of the element that equals to the given value, e.g. search by index from `length()` to 1.

```lua
--- @param value any
--- @param rstart integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return integer?
function List:lastIndexOf(value, rstart, comparator)
```

Parameters:

- `value`: The value to be found.
- `rstart`: Start searching index, by default is the last element index, e.g. `length()`.
- `comparator`: Binary function to compare two elements, by default is `nil`. When `nil` use simply `=` to compare two elements. It use below signature:

  ```lua
  function comparator(a:any, b:any):boolean
  ```

  Parameters:

  - `a`: An element.
  - `b`: Another element.

  Returns:

  - Returns `true` if two elements are equal, `false` if not.

Returns:

- Returns the last index of the element that equals to `value`, if found.
- Returns `nil`, if not found.

##### `forEach`

Visit every element of the list, and invoke a lua function.

```lua
--- @param f fun(value:any, index:integer):nil
function List:forEach(f)
```

Parameters:

- `f`: The lua function to be invoke on every element, it use below signature:

  ```lua
  function f(value:any, index:integer):nil
  ```

  Parameters:

  - `value`: An element of current list.
  - `index`: The index of the element in current list.

##### `includes`

Whether the list includes the given value.

```lua
--- @param value any
--- @param start integer?
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return boolean
function List:includes(value, start, comparator)
```

Parameters:

- `value`: The value to be detect.
- `start`: Start searching index, by default is `1`.
- `comparator`: Binary function to compare two elements, by default is `nil`. When `nil` use simply `=` to compare two elements. It use below signature:

  ```lua
  function comparator(a:any, b:any):boolean
  ```

  Parameters:

  - `a`: An element.
  - `b`: Another element.

  Returns:

  - Returns `true` if two elements are equal, `false` if not.

Returns:

- Returns `true` if the `value` is been found, `false` if not.

##### `map`

Transform the list and create a new list.

```lua
--- @param f fun(value:any,index:integer):any
--- @return commons.List
function List:map(f)
```

Parameters:

- `f`: The transform function, it use below signature:

  ```lua
  function f(value:any, index:integer):any
  ```

  Parameters:

  - `value`: The element of current list.
  - `index`: The index of the element.

  Returns:

  - Returns transformed element.

Returns:

- Returns the new list.

##### `pop`

Remove the last element from the list from tail, just like `table.remove`.

```lua
--- @return any?, boolean
function List:pop()
```

Returns:

- Returns the last element and `true` if successfully removed.
- Returns `nil` and `false` if failed, e.g. the list is empty.

##### `push`

Insert 0 or more elements into the list in the tail, just like `table.insert`.

```lua
--- @param ... any
function List:push(...)
```

Parameters:

- `...`: The new elements to be insert.

##### `shift`

Remove the first element from the list in the head, just like `table.remove`.

```lua
--- @return any?, boolean
function List:shift()
```

Returns:

- Returns the first element and `true` if successfully removed.
- Returns `nil` and `false` if failed, e.g. the list is empty.

##### `unshift`

Insert 0 or more elements into the list in the head, just like `table.insert`.

```lua
--- @param ... any
function List:unshift(...)
```

Parameters:

- `...`: The new elements to be insert.

##### `reduce`

Aggregate the list from first element to last.

```lua
--- @param f fun(accumulator:any, value:any, index:integer):any
--- @param initialValue any?
--- @return any
function List:reduce(f, initialValue)
```

Parameters:

- `f`: The aggregate function, it use below signature:

  ```lua
  function f(accumulator:any, value:any, index:integer):any
  ```

  Parameters:

  - `accumulator`: The accumulated value returned from previous `f`.
  - `value`: The element of the list.
  - `index`: The index of the element.

- `initialValue`: The initial value, by default is `nil`. When `nil`, the first element will be used as the initial value, and reduce will start from the second element.

Returns:

- Returns the final accumulator value.

##### `reduceRight`

Aggregate the list exactly like `reduce`, except it's from last element to first.

```lua
--- @param f fun(accumulator:any,value:any,index:integer):any
--- @param initialValue any?
--- @return any
function List:reduceRight(f, initialValue)
```

##### `reverse`

Reverse the list.

!> This method will not modify the current list, but create a new list.

```lua
--- @return commons.List
function List:reverse()
```

Returns:

- Returns a new list that reverse all the elements.

##### `slice`

Get part of the list, just like `string.sub`.

!> This method will not modify the current list, but create a new list.

```lua
--- @param startIndex integer?
--- @param endIndex integer?
--- @return commons.List
function List:slice(startIndex, endIndex)
```

Parameters:

- `startIndex`: First element of the part, by default is `1`.
- `endIndex`: Last element of the part, inclusive, by default is `length()`.

Returns:

- Returns a new list that contains part of the current list.

##### `sort`

Sort the list, just like `table.sort`.

!> This method will not modify the current list, but create a new list.

```lua
--- @param comparator (fun(a:any,b:any):boolean)|nil
--- @return commons.List
function List:sort(comparator)
```

Parameters:

- `comparator`: Binary function to compare two elements, by default is `nil`. When `nil` use simply `=` to compare two elements. It use below signature:

  ```lua
  function comparator(a:any, b:any):boolean
  ```

  Parameters:

  - `a`: An element.
  - `b`: Another element.

  Returns:

  - Returns `true` if two elements are equal, `false` if not.

Returns:

- Returns a new list that been sorted.

### `HashMap`

High-level hash map data structure, provide a set of APIs highly close to [Javascript Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array).

?> The API design is heavily influenced by [Javascript Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) and [lodash](https://lodash.com/docs), but some APIs are different, because lua is not javascript anyway, and `HashMap` is designed to be purely functional programming without side-effect.

#### Methods

##### `wrap`

Create a list by wrap a lua table list.
