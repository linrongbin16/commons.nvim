<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.paths](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/paths.lua)

File and directory path utilities.

## Constants

### `SEPARATOR`

The file system path separator.

- For UNIX/Linux, it's `/`.
- For Windows, it's `\\`.

```lua
--- @type string
```

## Functions

### `exists`

Whether file path `p` exists, based on current working directory if file path is relative.

```lua
--- @param p string
--- @return boolean
M.exists = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `true` if file path exists, `false` if not.

### `isfile`

Whether file path `p` exists and is file.

```lua
--- @param p string
--- @return boolean
M.isfile = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `true` if file path exists and is file, `false` if not.

### `isdir`

Whether file path `p` exists and is directory, based on current working directory if file path is relative.

```lua
--- @param p string
--- @return boolean
M.isdir = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `true` if file path exists and is directory, `false` if not.

### `islink`

Whether file path `p` exists and is symlink, based on current working directory if file path is relative.

```lua
--- @param p string
--- @return boolean
M.islink = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `true` if file path exists and is symlink, `false` if not.

### `expand`

Expand user home `~` to full file path.

```lua
--- @param p string
--- @return string
M.expand = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `p` without change if there's no user home `~`, returns full path if there is.

### `resolve`

Resolve symlink path to linked full file path.

```lua
--- @param p string
--- @return string
M.resolve = function(p)
```

Parameters:

- `p`: File path.

Returns:

- Returns `p` without change if it's not symlink, returns the linked full path if it is.

### `normalize`

Normalize path with below steps:

- Trim all whitespaces.
- replace Windows path separator `\\` to UNIX/Linux separator `/`.

```lua
--- @param p string
--- @param opts {double_backslash:boolean?,expand:boolean?,resolve:boolean?}?
--- @return string
M.normalize = function(p, opts)
```

Parameters:

- `p`: Input path.
- `opts`: Options, by default `{double_backslash = false, expand = false}`.

  - `double_backslash`: Also replace double backslashes `\\\\` to single backslash `\\` as well, by default is `false`.
  - `expand`: Also expand user home `~` to full path as well, by default is `false`.
  - `resolve`: Also resolve symlink to linked full file path as well, by default is `false`.

Returns:

- Normalized path.

### `join`

Join multiple path components with separator. For example `join('github', 'linrongbin16', 'commons.nvim')`:

- For UNIX/Linux, returns `github/linrongbin16/commons.nvim`.
- For Windows, returns `github\\linrongbin16\\commons.nvim`.

```lua
--- @param ... any
--- @return string
M.join = function(...)
```

### `reduce2home`

Reduce path starts from user home `~`.

```lua
--- @param p string?
--- @return string
M.reduce2home = function(p)
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

### `reduce`

Reduce path starts from user home `~`, or starts from current working directory `.`.

```lua
--- @param p string?
--- @return string
M.reduce = function(p)
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

Returns:

- For path outside of current working directory, returns path string starts from user home `~`.
- For path inside of current working directory, returns path string starts from current working directory `.`.

### `shorten`

Shorten path to the `~/g/l/commons.nvim` style, e.g. reduce all parent components to single character length.

```lua
--- @param p string?
--- @return string
M.shorten = function(p)
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

### `pipename`

Make named pipe path, for UNIX/Linux it's tmp file path, for Windows it looks like `\\.\pipe\nvim-pipe-12873-182710`.

```lua
--- @return string
M.pipename = function()
```

### `parent`

Get parent path.

```lua
--- @param p string?
--- @return string?
M.parent = function(p)
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

Returns:

- Returns the parent path if `p` is a valid file path.
- Returns `nil` if `p` is already root path, e.g. the `/`.
