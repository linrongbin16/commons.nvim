# [commons.fio](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/fio.lua)

File sync/async IO operations.

## Classes

### `FileLineReader`

Line-wise file reader, read by chunks, iterate by lines.

```lua
--- @class commons.FileLineReader
```

#### Methods

##### `open`

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

##### `has_next`

Whether has more lines to read.

```lua
function FileLineReader:has_next():boolean
```

##### `next`

Get next line.

```lua
function FileLineReader:next():string?
```

Returns:

- If has next line, returns next line.
- If no more lines, returns `nil`.

##### `close`

Close the file reader.

```lua
function FileLineReader:close():nil
```

### `CachedFileReader`

Cached file reader, always returns cached content until reset.

```lua
--- @class commons.CachedFileReader
```

#### Methods

##### `open`

Create a cached file reader with a file name.

```lua
--- @param filename string
--- @return commons.CachedFileReader
function CachedFileReader:open(filename)
```

Parameters:

- `filename`: File name to read.

Returns:

- Returns the cached file reader.

##### `read`

Read the file, use cached content if available.

```lua
--- @param opts {trim:boolean?}?
--- @return string?
function CachedFileReader:read(opts)
```

Parameters:

- `opts`: Options.
  - `trim`: Whether to trim whitespaces around file content, by default is `false`.

Returns:

- Returns file content if read success, returns `nil` if failed to read file.

##### `reset`

Reset the internal cache.

```lua
--- @return string?
function CachedFileReader:reset()
```

Returns:

- Returns the old cache.

## Functions

### `readfile`

Read file.

```lua
function readfile(filename:string, opts:{trim:boolean?}?):string?
```

Parameters:

- `filename`: File name.
- `opts`: Options.
  - `trim`: Whether to trim whitespaces around file content, by default is `false`.

Returns:

- If success, returns file content.
- If failed to open, returns `nil`.

### `asyncreadfile`

Async read file, invoke callback function on read complete.

```lua
--- @alias commons.AsyncReadFileOnComplete fun(data:string?):any
--- @alias commons.AsyncReadFileOnError fun(step:string?,err:string?):any
--- @param filename string
--- @param opts {on_complete:commons.AsyncReadFileOnComplete,on_error:commons.AsyncReadFileOnError?,trim:boolean?}
M.asyncreadfile = function(filename, opts)
```

Parameters:

- `filename`: File name.
- `opts`: Options.

  - `on_complete`: Callback function that will be invoked after read complete, with signature:

    ```lua
    function on_complete(data:string?):any
    ```

    - Parameters:
      - `data`: File content.

  - `on_error`: Callback function that will be invoked after an error on read file, by default it throws via `error` API. The signature is:

    ```lua
    function on_error(step:string?,err:string?):nil
    ```

    - Parameters:
      - `step`: Which step that the error throws.
      - `err`: Error message.

  - `trim`: Whether to trim whitespaces around file content, by default is `false`.

### `readlines`

Read file by lines (strings list).

```lua
function readlines(filename:string):string[]|nil
```

Returns:

- If success, returns file content as strings list.

  ?> Newline break `\n` is removed from each line.

- If failed to open, returns `nil`.

### `asyncreadlines`

Async read file by lines, invoke callback functions on each line and after complete.

```lua
--- @alias commons.AsyncReadLinesOnLine fun(line:string):any
--- @alias commons.AsyncReadLinesOnComplete fun(bytes:integer):any
--- @alias commons.AsyncReadLinesOnError fun(step:string?,err:string?):any
--- @param filename string
--- @param opts {on_line:commons.AsyncReadLinesOnLine,on_complete:commons.AsyncReadLinesOnComplete,on_error:commons.AsyncReadLinesOnError?,batchsize:integer?}
M.asyncreadlines = function(filename, opts)
```

Parameters:

- `filename`: File name.
- `opts`: Options.

  - `on_line`: Callback function that will be invoked on each line, with signature:

    ```lua
    function on_line(line:string):any
    ```

    - Parameters:

      - `line`: Each line of the file content.

  - `on_complete`: Callback function that will be invoked on read complete, with signature:

    ```lua
    function on_complete(bytes:integer):any
    ```

    - Parameters:
      - `bytes`: File content bytes.

  - `on_error`: Callback function that will be invoked on error, with signature:

    ```lua
    function on_error(step:string?,err:string?):any
    ```

    - Parameters:
      - `step`: Which step that the error throws.
      - `err`: Error message.

  - `batchsize`: Internal chunk size on each disk read operation, by default is `4096`.

### `writefile`

Write content into file.

```lua
function writefile(filename:string, content:string):0|1
```

Returns:

- If success, returns `0`.
- If failed to write, returns `-1`.

### `writelines`

Write content into file by lines.

```lua
function writelines(filename:string, lines:string):0|1
```

Parameters:

- `filename`: File name.
- `lines`: content as lines (strings list).

  ?> Newline break `\n` is appended for each line.

Returns:

- If success, returns `0`.
- If failed to write, returns `-1`.

### `asyncwritefile`

Async write all the content into a file, invoke callback function on write complete.

```lua
function asyncwritefile(filename:string, content:string, on_complete:fun(bytes:integer?):any):nil
```

Parameters:

- `filename`: File name.
- `content`: File content.
- `on_complete`: Callback function that will be invoked on write complete, with signature:

  ```lua
  function on_complete(bytes:integer?):any
  ```

  - Parameters:
    - `bytes`: written bytes.
