<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.strings](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/strings.lua)

Strings utilities, with type check.

## Functions

### `empty`

Whether string is empty.

```lua
function empty(s:string?):boolean
```

### `not_empty`

Whether string is not empty.

```lua
function not_empty(s:string?):boolean
```

### `blank`

Whether string is blank, e.g. empty after trimmed.

```lua
function blank(s:string?):boolean
```

### `not_blank`

Whether string is not blank, e.g. not empty after trimmed.

```lua
function not_blank(s:string?):boolean
```

### `find`

Search the first position of a target `t` in string `s`, start from position `start`.

```lua
function find(s:string, t:string, start:integer?):integer?
```

Parameters:

- `s`: The content string.
- `t`: The target string.
- `start`: The start position, by default is `1`.

Returns:

- If target `t` is been found, returns the first position index.
- If target `t` is not found, returns `nil`.

### `rfind`

Search (reversely) the last position of a target `t` in string `s`, start from position `rstart`.

```lua
function rfind(s:string, t:string, rstart:integer?):integer?
```

Parameters:

- `s`: The content string.
- `t`: The target string.
- `rstart`: The start position, by default is `#s`.

Returns:

- If target `t` is been found, returns the last position index.
- If target `t` is not found, returns `nil`.

### `ltrim`

Trim target `t` from left side of string `s`, by default trim all whitespaces.

```lua
function ltrim(s:string, t:string?):string
```

Parameters:

- `s`: The string that left side will been trimmed.
- `t`: Target characters, by default is all whitespaces.

?> Also see [vim.trim](<https://neovim.io/doc/user/lua.html#vim.trim()>).

### `rtrim`

Trim target `t` from right side of string `s`, by default trim all whitespaces.

```lua
function rtrim(s:string, t:string?):string
```

Parameters:

- `s`: The string that right side will been trimmed.
- `t`: Target characters, by default is all whitespaces.

?> Also see [vim.trim](<https://neovim.io/doc/user/lua.html#vim.trim()>).

### `split`

Just a wrapper for [vim.split](<https://neovim.io/doc/user/lua.html#vim.split()>), the only difference is:

- By default the `opts` is `{plain = true}`.

```lua
function split(s:string, sep:string, opts:{plain:boolean?, trimempty:boolean?}?):string
```

Parameters:

- `s`: Exactly the same passing to `vim.split`.
- `sep`: Exactly the same passing to `vim.split`.
- `opts`: Almost the same passing to `vim.split`, except:

  - `plain`: By default is `true`.

### `startswith`

Whether string `s` starts with prefix `t`.

```lua
function startswith(s:string, t:string, opts:{ignorecase:boolean?}?):boolean
```

Parameters:

- `s`: The content.
- `t`: The prefix.
- `opts`: Options.

  - `ignorecase`: Whether to ignore case when comparing strings, by default is `false`.

### `endswith`

Whether string `s` ends with suffix `t`.

```lua
function endswith(s:string, t:string, opts:{ignorecase:boolean?}?):boolean
```

Parameters:

- `s`: The content.
- `t`: The target.
- `opts`: Options.

  - `ignorecase`: Whether to ignore case when comparing strings, by default is `false`.

### `isspace`

Whether character `c` is whitespace.

!> Only allow single character as the parameter.

```lua
function isspace(c:string):boolean
```

?> Also see: C/C++ Reference [isspace](https://en.cppreference.com/w/cpp/string/byte/isspace).

### `isalnum`

Whether character `c` is alphanumeric (0-9 A-Z a-z).

!> Only allow single character as the parameter.

```lua
function isalnum(c:string):boolean
```

?> Also see: C/C++ Reference [isalnum](https://en.cppreference.com/w/cpp/string/byte/isalnum).

### `isdigit`

Whether character `c` is digit (0-9).

!> Only allow single character as the parameter.

```lua
function isdigit(c:string):boolean
```

?> Also see: C/C++ Reference [isdigit](https://en.cppreference.com/w/cpp/string/byte/isdigit).

### `isxdigit`

Whether character `c` is hex digit (0-9 a-f A-F).

!> Only allow single character as the parameter.

```lua
function isxdigit(c:string):boolean
```

?> Also see: C/C++ Reference [isxdigit](https://en.cppreference.com/w/cpp/string/byte/isxdigit).

### `isalpha`

Whether character `c` is alphabetic character (a-z A-Z).

!> Only allow single character as the parameter.

```lua
function isalpha(c:string):boolean
```

?> Also see: C/C++ Reference [isalpha](https://en.cppreference.com/w/cpp/string/byte/isalpha).

### `islower`

Whether character `c` is lower case alphabetic character (a-z).

!> Only allow single character as the parameter.

```lua
function islower(c:string):boolean
```

?> Also see: C/C++ Reference [islower](https://en.cppreference.com/w/cpp/string/byte/islower).

### `isupper`

Whether character `c` is upper case alphabetic character (A-Z).

!> Only allow single character as the parameter.

```lua
function isupper(c:string):boolean
```

?> Also see: C/C++ Reference [isupper](https://en.cppreference.com/w/cpp/string/byte/isupper).
