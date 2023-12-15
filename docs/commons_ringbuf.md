<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.ringbuf](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/ringbuf.lua)

Drop-in [vim.ringbuf](<https://neovim.io/doc/user/lua.html#vim.ringbuf()>) replacement data structure with iterator support.

## Classes

### `RingBuffer`

The ring buffer class.

```lua
--- @class commons.RingBuffer
```

#### Functions

##### `new`

Create new ring buffer object.

```lua
function RingBuffer:new(maxsize:integer):commons.RingBuffer
```

Parameters:

- `maxsize`: Max internal list size.

Returns:

- Returns the ring buffer object.

##### `push`

Push new `item` into ring buffer.

```lua
function RingBuffer:push(item:any):integer
```

Parameters:

- `item`: The item.

Returns:

- Returns the index of new added item.

##### `pop`

Pop out the latest added item from ring buffer.

```lua
function RingBuffer:pop():any
```

Returns:

- If ring buffer is not empty, returns the latest added item.
- If ring buffer is empty, returns `nil`.

##### `peek`

Get (peek) the latest added item in ring buffer, without modify the ring buffer.

```lua
function RingBuffer:peek():any
```

Returns:

- If ring buffer is not empty, returns the latest added item.
- If ring buffer is empty, returns `nil`.

##### `clear`

Clear the ring buffer.

```lua
function RingBuffer:clear():nil
```

##### `iterator`

Returns the iterator that allow foreach all the items from oldest to latest.

```lua
function RingBuffer:iterator():commons._RingBufferIterator
```

?> Also see: [\_RingBufferIterator](#_RingBufferIterator).

##### `riterator`

Returns the reverse iterator that allow foreach all the items from latest to oldest.

```lua
function RingBuffer:riterator():commons._RingBufferRIterator
```

?> Also see: [\_RingBufferRIterator](#_RingBufferRIterator).

### `_RingBufferIterator`

The iterator class that allow foreach all items from oldest to latest.

```lua
--- @class commons._RingBufferIterator
```

#### Functions

##### `has_next`

Whether has next item in ring buffer.

```lua
function _RingBufferIterator:has_next():boolean
```

##### `next`

Get the next item in ring buffer.

```lua
function _RingBufferIterator:next():any
```

Returns:

- If has next item, returns the next item.
- If has no more items, returns `nil`.

Example:

```lua
local rb = require("commons.ringbuf").RingBuffer:new()
local iter = rb:iterator()
while iter:has_next() do
  local item = iter:next()
end
```

### `_RingBufferRIterator`

The reverse iterator class that allow foreach all items from latest to oldest.

```lua
--- @class commons._RingBufferRIterator
```

#### Functions

##### `has_next`

Whether has next item in ring buffer.

```lua
function _RingBufferRIterator:has_next():boolean
```

##### `next`

Get the next item in ring buffer.

```lua
function _RingBufferRIterator:next():any
```

Returns:

- If has next item, returns the next item.
- If has no more items, returns `nil`.

Example:

```lua
local rb = require("commons.ringbuf").RingBuffer:new()
local iter = rb:riterator()
while iter:has_next() do
  local item = iter:next()
end
```
