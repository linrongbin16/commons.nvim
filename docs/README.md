<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# Welcome to commons.nvim's Documentation!

> The commons lua library for Neovim plugin project.

## Install

## Modules

### [commons.buffers](/lua/commons/buffers.lua)

Compatible Neovim APIs relate to nvim buffers.

- `get_buf_option`: Get buffer option.
- `set_buf_option`: Set buffer option.

### [commons.fileios](/lua/commons/fileios.lua)

Sync/async file IO operations.

For read operations:

- `FileLineReader` (`@class`): Line-wise file reader: read by chunks, iterate by lines.

  - `open`: Create a file reader, returns the file reader object.
  - `has_next`: Whether has more lines to read.
  - `next`: Get next line.
  - `close`: Close the file reader.

- `readfile`: Read all the content from a file, returns file content.
- `readlines`: Read file content by lines, returns file content in lines.

  > **Note**
  >
  > Newline break `\n` is auto removed from each line.

- `asyncreadfile`: Async read all the content from a file, invoke callback function on read complete.

For write operations:

- `writefile`: Write content into file.
- `writelines`: Write content into file by lines.

  > **Note**
  >
  > Newline break `\n` is auto appended for each line.

- `asyncwritefile`: Async write all the content into a file, invoke callback function on write complete.

### [commons.jsons](/lua/commons/jsons.lua)

Encode/decode between lua table/list and json string.

> **Note**
>
> Use [actboy168/json.lua](https://github.com/actboy168/json.lua) for Neovim &lt; 0.10, [vim.json](https://github.com/neovim/neovim/blob/a9fbba81d5d4562a2d2b2cbb41d73f1de83d3102/runtime/doc/lua.txt?plain=1#L772) for Neovim &ge; 0.10.

- `encode`: encode lua table to json object/list string.
- `decode`: decode json object/list string to lua table.

### [commons.numbers](/lua/commons/numbers.lua)

Numbers and integers utilities.

- `INT32_MAX`/`INT32_MIN`: 32 bit integer max/min value.

- `eq`/`ne`: Whether equals to or not.
- `lt`/`le`: Whether is less than (`lt`) or not, less equal to (`le`) or not.
- `gt`/`ge`: Whether is greater than (`gt`) or not, greater equal to (`ge`) or not.
- `bound`: Bound `value` by upper bound `right` and lower bound `left`.
  > **Note**
  >
  > - When `value < left` returns `left`.
  > - When `value > right` returns `right`.
- `auto_incremental_id`: Get auto-incremental integer, start from `1`.

### [commons.paths](/lua/commons/paths.lua)

File/directory path utilities.

- `SEPARATOR:string`: `/` for UNIX/Linux, `\\` for Windows.
- `normalize(p:string, opts:{backslash:boolean?, expand:boolean?}?):string`: normalize path, e.g. replace Windows path separator `\\\\` to `\\`. The `backslash = true` could replace `\\` to `/`, the `expand = true` could expand the home `~` to full path, by default `opts` is `{backslash = false, expand = false}`.
- `join(...):string`: join multiple components into path, for example `join('my', 'folder')` returns `my/folder` on UNIX/Linux, returns `my\\folder` on Windows.
- `reduce2home(p:string?):string`: Reduce path `p` to start with home `~`, By default `p` is current working directory.
- `reduce(p:string?):string`: Reduce path `p` to start with home `~` or current working directory `.`, By default `p` is current working directory.
- `shorten(p:string?):string`: Shorten path `p` to the `~/p/l/commons.nvim` style, start with home `~` or current working directory `.`, By default `p` is current working directory.
- `pipename():string`: Make named pipe path, for UNIX/Linux it's a tmp file, for Windows it looks like `\\.\pipe\nvim-pipe-12873-182710`.

### [commons.ringbuf](/lua/commons/ringbuf.lua)

Drop-in replacement **Ring Buffer** data structure with iterator support.

- `commons.RingBuffer`:

  - `new(maxsize:integer):commons.RingBuffer`: Create new ring buffer data structure with fixed list size.
  - `push(item:any):integer`: Push new `item` into ring buffer. Returns new added item index.
  - `pop():any`: Pop out latest added `item` from ring buffer. Returns the latest added item.
  - `peek():any`: Get latest added `item` without remove it from ring buffer. Returns the latest added item.
  - `clear():any`: Clear whole ring buffer. Returns the previous items count.
  - `iterator():commons._RingBufferIterator`: Returns iterator (from oldest to latest).
  - `riterator():commons._RingBufferRIterator`: Returns reverse iterator (from latest to oldest).

- `commons._RingBufferIterator`:

  - `has_next():boolean`: Whether has next item in ring buffer.
  - `next():any`: Returns next item in ring buffer, returns `nil` if there's no more items. For example:

  ```lua
  local ringbuf = require("commons.ringbuf").RingBuffer:new()
  local iter = ringbuf:iterator()
  while iter:has_next() do
    local item = iter:next()
    -- consume item
  end
  ```

- `commons._RingBufferRIterator`:

  - `has_next():boolean`: Whether has next item in ring buffer.
  - `next():any`: Returns next item in ring buffer, returns `nil` if there's no more items. For example:

  ```lua
  local ringbuf = require("commons.ringbuf").RingBuffer:new()
  local riter = ringbuf:riterator()
  while iter:has_next() do
    local item = iter:next()
    -- consume item
  end
  ```

### [commons.spawn](/lua/commons/spawn.lua)

Sync/async run child-process via `uv.spawn` API, and handle stdout/stderr IO by line-based callbacks.

- `run(cmd:string[], opts:{stdout:fun(line:string):nil, stderr:fun(line:string):nil, [string]:any}, on_exit:fun(completed:vim.SystemCompleted):nil|nil):vim.SystemObject`: run command line, this is just a wrapper for [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>). The only difference is `opts` provide more friendly line-based `stdout` and `stderr` callbacks, and by default `{text = true}`.
  - `stdout`/`stderr`: both use the function signature `fun(line:string):any`, been invoked when receiving a line from stdout/stderr.

### [commons.strings](/lua/commons/strings.lua)

String utilities.

- `empty(s:string?):boolean`/`not_empty(s:string?):boolean`: Whether string `s` is empty or not.
- `blank(s:string?):boolean`/`not_blank(s:string?):boolean`: Whether (trimed) string `s` is blank or not.
- `find(s:string, t:string, start:integer?):boolean`: Search the first index position of target `t` in string `s`, start from optional `start`, by default `start` is `1`. Returns `nil` if not found, lua string index if been found.
- `rfind(s:string, t:string, rstart:integer?):boolean`: Reverse search the last index position of target `t` in string `s`, start from optional `rstart`, by default `rstart` is `#s` (length of `s`). Returns `nil` if not found, lua string index if been found.
- `ltrim(s:string, t:string?):string`: Trim optional target `t` from left side of string `s`, by default all whitespaces are been trimed if `t` is not provided. To trim both sides please use [vim.trim](<https://neovim.io/doc/user/lua.html#vim.trim()>).
- `rtrim(s:string, t:string?):string`: Trim optional target `t` from right side of string `s`, by default all whitespaces are been trimed if `t` is not provided. To trim both sides please use [vim.trim](<https://neovim.io/doc/user/lua.html#vim.trim()>).
- `split(s:string, sep:string, opts:{plain:boolean?,trimempty:boolean?}?):string`: Split string `s` by `sep`, by default the `opts` is `{plain = true, trimempty = false}`. This is just a wrapper for [vim.split(s, sep, {plain=true})](<https://neovim.io/doc/user/lua.html#vim.split()>).
- `startswith(s:string, t:string, opts:{ignorecase:boolean?}?):boolean`: Whether string `s` starts with target `t`. Set `ignorecase = true` to compare string ignore lower/upper case, by default `ignorecase = false`.
- `endswith(s:string, t:string, opts:{ignorecase:boolean?}?):boolean`: Whether string `s` ends with target `t`. Set `ignorecase = true` to compare string ignore lower/upper case, by default `ignorecase = false`.
- `isspace(c:string):boolean`: Whether character `c` is whitespace, string length of `c` must be `1`. Also see C++ Reference [isspace](https://en.cppreference.com/w/cpp/string/byte/isspace).
- `isalnum(c:string):boolean`: Whether character `c` is alphanumeric (0-9 A-Z a-z), string length of `c` must be `1`. Also see C++ Reference [isalnum](https://en.cppreference.com/w/cpp/string/byte/isalnum).
- `isdigit(c:string):boolean`: Whether character `c` is digit (0-9), string length of `c` must be `1`. Also see C++ Reference [isdigit](https://en.cppreference.com/w/cpp/string/byte/isdigit).
- `isxdigit(c:string):boolean`: Whether character `c` is hex digit (0-9 a-f A-F), string length of `c` must be `1`. Also see C++ Reference [isxdigit](https://en.cppreference.com/w/cpp/string/byte/isxdigit).
- `isalpha(c:string):boolean`: Whether character `c` is alphabetic character (a-z A-Z), string length of `c` must be `1`. Also see C++ Reference [isalpha](https://en.cppreference.com/w/cpp/string/byte/isalpha).
- `islower(c:string):boolean`: Whether character `c` is lower case alphabetic character (a-z), string length of `c` must be `1`. Also see C++ Reference [islower](https://en.cppreference.com/w/cpp/string/byte/islower).
- `isupper(c:string):boolean`: Whether character `c` is upper case alphabetic character (A-Z), string length of `c` must be `1`. Also see C++ Reference [isupper](https://en.cppreference.com/w/cpp/string/byte/isupper).

### [commons.tables](/lua/commons/tables.lua)

Lua table/list utilities.

For lua table:

- `tbl_empty(t:any):boolean`/`tbl_not_empty(t:any):boolean`: Whether table `t` is empty or not.
- `tbl_get(t:any, ...:any):any`: Retrieve element from lua table/list, this is just a wrapper of [vim.tbl_get](<https://neovim.io/doc/user/lua.html#vim.tbl_get()>).

For lua list:

- `list_empty(l:any):boolean`/`list_not_empty(l:any):boolean`: Whether list `l` is empty or not.
- `list_index(l:any, idx:integer):integer`: Get list index with negatives support, for `idx > 0` returns the same value, for `idx < 0` returns `#l + idx + 1`, e.g. `-1` returns `#l` (the last element index), `-#l` returns `1` (the first element index).

### [commons.termcolors](/lua/commons/termcolors.lua)

Terminal ANSI color rendering utilities.

> [!NOTE]
>
> This module requires true color terminal support and Neovim enables `termguicolors` to present the best display.

- `render(text:string, name:string, hl:string?):string`: Render `text` content with ANSI color (yellow, red, blue, etc) and RGB color (#808080, #FF00FF, etc), or vim's syntax highlighting group. Vim's syntax highlighting group has higher priority, but only working when it's been provided. Returns the rendered text content in terminal colors. For example: `\27[38;2;216;166;87mCTRL-U\27[0m` (rendered text `CTRL-U`).

There're a bunch of pre-defined CSS colors:

- `black(text:string, hl:string?):string`: Render `text` content with black color, or with vim's syntax highlighting group `hl` if been provided.
- `silver(text:string, hl:string?):string`: same.
- `white(text:string, hl:string?):string`: same.
- `violet(text:string, hl:string?):string`: same.
- `magenta(text:string, hl:string?):string` (`fuchsia`): same.
- `red(text:string, hl:string?):string`: same.
- `purple(text:string, hl:string?):string`: same.
- `indigo(text:string, hl:string?):string`: same.
- `yellow(text:string, hl:string?):string`: same.
- `gold(text:string, hl:string?):string`: same.
- `orange(text:string, hl:string?):string`: same.
- `chocolate(text:string, hl:string?):string`: same.
- `olive(text:string, hl:string?):string`: same.
- `green(text:string, hl:string?):string`: same.
- `lime(text:string, hl:string?):string`: same.
- `teal(text:string, hl:string?):string`: same.
- `cyan(text:string, hl:string?):string` (`aqua`): same.
- `blue(text:string, hl:string?):string`: same.
- `navy(text:string, hl:string?):string`: same.
- `slateblue(text:string, hl:string?):string`: same.
- `steelblue(text:string, hl:string?):string`: same.

And some other APIs:

- `retrieve(attr:"fg"|"bg", hl:string):string`: Retrieve ANSI/RGB color codes from vim's syntax highlighting group name. Returns ANSI color codes (30, 35, etc) or RGB color codes (#808080, #FF00FF, etc).
- `escape(attr:"fg"|"bg", code:string):string`: Format/escape ANSI/RGB color code to terminal escaped (printable) style. Returns the rendered text content in terminal colors. For example: `38;2;216;166;87`.
- `erase(text:string):string`: Erase ANSI/RGB colors from `text` content. Returns the raw text content.

### [commons.uv](/lua/commons/uv.lua)

Lua uv.

Use [vim.loop](https://github.com/neovim/neovim/blob/a9fbba81d5d4562a2d2b2cbb41d73f1de83d3102/runtime/doc/deprecated.txt?plain=1#L166) for Neovim &lt; 0.10, [vim.uv](https://github.com/neovim/neovim/blob/a9fbba81d5d4562a2d2b2cbb41d73f1de83d3102/runtime/doc/news.txt?plain=1#L345) for Neovim &ge; 0.10.

### [commons.windows](/lua/commons/windows.lua)

Compatible Neovim window relate APIs.

- `get_win_option(winnr:integer, name:string):any`: get `winnr` window option.
- `set_win_option(winnr:integer, name:string, value:any):any`: set `winnr` window option value.

## Development

Setup the plugin development with:

- [lua-language-server](https://github.com/LuaLS/lua-language-server): language server.
- [stylua](https://github.com/JohnnyMorganz/StyLua): code format.
- [luacheck](https://github.com/lunarmodules/luacheck): code static check.
- [luarocks](https://luarocks.org/): package management for vusted/busted/luacov.
- [vusted](https://github.com/notomo/vusted): unit test.

Then run unit tests with `vusted ./test`.

## Contribute

Please open [issue](https://github.com/linrongbin16/commons.nvim/issues)/[PR](https://github.com/linrongbin16/commons.nvim/pulls) for anything about commons.nvim.

Like commons.nvim? Consider

[![Github Sponsor](https://img.shields.io/badge/-Sponsor%20Me%20on%20Github-magenta?logo=github&logoColor=white)](https://github.com/sponsors/linrongbin16)
[![Wechat Pay](https://img.shields.io/badge/-Tip%20Me%20on%20WeChat-brightgreen?logo=wechat&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor)
[![Alipay](https://img.shields.io/badge/-Tip%20Me%20on%20Alipay-blue?logo=alipay&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor)
