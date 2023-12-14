<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.fileios](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/fileios.lua)

File sync/async IO operations.

## Classes

### `FileLineReader`

Line-wise file reader, read by chunks, iterate by lines.

```lua
--- @class commons.FileLineReader
```

#### `open`

Create a file reader.

```lua
function FileLineReader:open(filename:string, batchsize:integer?):commons.FileLineReader?
```

Parameters:

- `filename`: File name.
- `batchsize`: Internal chunk size on each read operation, by default 4096.

Returns:

- If success, returns file reader object.
- If failed to open file, returns `nil`.

#### `has_next`

Whether has more lines to read.

```lua
function FileLineReader:has_next():boolean
```

#### `next`

Get next line.

```lua
function FileLineReader:next():string?
```

Returns:

- If has next line, returns next line.
- If no more lines, returns `nil`.

#### `close`

Close the file reader.

```lua
function FileLineReader:close():nil
```

## Functions

?> Read operations

### `readfile`

Read all the content from a file.

```lua
function(filename:string, opts:{trim:boolean?}?):string?
```

Parameters:

- `filename`: File name.
- `opts`: Options.
  - `trim`: Whether to trim whitespaces around file content, by default `false`.

Returns:

- If success, returns file content.
- If failed to open, returns `nil`.

### `readlines`

Read all the file content into lines (strings list).

```lua
function(filename:string):string[]|nil
```

Returns:

- If success, returns file content as strings list.

  ?> **Note:** The newline break `\n` is removed from each line.

- If failed to open, returns `nil`.

### `asyncreadfile`

Async read all the content from a file, invoke callback function on read complete.

```lua
function(filename:string, on_complete:fun(data:string?):any, opts:{trim:boolean?}?):nil
```

Parameters:

- `filename`: File name.
- `on_complete`: Callback function that will be invoked on read complete, with signature:

  ```lua
  function(data:string?):any
  ```

  - Parameters:
    - `data`: read file content

- `opts`: Options.
  - `trim`: Whether to trim whitespaces around file content, by default `false`.

?> Write operations

### `writefile`

Write content into file.

```lua
function(filename:string, content:string):0|1
```

Returns:

- If success, returns `0`.
- If failed to write, returns `-1`.

### `writelines`

Write content into file by lines.

```lua
function(filename:string, lines:string):0|1
```

Parameters:

- `filename`: File name.
- `lines`: content as lines (strings list).

  ?> **Note:** The newline break `\n` is appended for each line.

Returns:

- If success, returns `0`.
- If failed to write, returns `-1`.

### `asyncwritefile`

Async write all the content into a file, invoke callback function on write complete.

```lua
function(filename:string, content:string, on_complete:fun(bytes:integer?):any):nil
```

Parameters:

- `filename`: File name.
- `content`: File content.
- `on_complete`: Callback function that will be invoked on write complete, with signature:

  ```lua
  function(bytes:integer?):any
  ```

  - Parameters:
    - `bytes`: written bytes.
