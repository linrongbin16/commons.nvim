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

### `normalize`

Normalize path with below steps:

- Trim all whitespaces.
- replace Windows path separator `\\` to UNIX/Linux separator `/`.

```lua
function normalize(p:string, opts:{double_backslash:boolean?, expand:boolean?}?):string
```

Parameters:

- `p`: Input path.
- `opts`: Options, by default `{double_backslash = false, expand = false}`.

  - `double_backslash`: Whether replace double backslashes `\\\\` to single backslash `\\` as well.
  - `expand`: Whether expand user home `~` to full path as well.

Returns:

- Normalized path.

### `join`

Join multiple path components with separator. For example `join('github', 'linrongbin16', 'commons.nvim')`:

- For UNIX/Linux, returns `github/linrongbin16/commons.nvim`.
- For Windows, returns `github\\linrongbin16\\commons.nvim`.

```lua
function join(...:any):string
```

### `reduce2home`

Reduce path starts from user home `~`.

```lua
function reduce2home(p:string?):string
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

### `reduce`

Reduce path starts from user home `~`, or starts from current working directory `.`.

```lua
function reduce(p:string?):string
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

Returns:

- For path outside of current working directory, returns path string starts from user home `~`.
- For path inside of current working directory, returns path string starts from current working directory `.`.

### `shorten`

Shorten path to the `~/g/l/commons.nvim` style, e.g. reduce all parent components to single character length.

```lua
function shorten(p:string?):string
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

### `pipename`

Make named pipe path, for UNIX/Linux it's tmp file path, for Windows it looks like `\\.\pipe\nvim-pipe-12873-182710`.

```lua
function pipename():string
```

### `parent`

Get parent path.

```lua
function parent(p:string?):string
```

Parameters:

- `p`: Input path, by default is current working directory `.`.

Returns:

- Returns the parent path if `p` is a valid file path.
- Returns `nil` if `p` is already root path, e.g. the `/`.
