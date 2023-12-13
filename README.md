<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# commons.nvim

<p align="center">
<a href="https://github.com/neovim/neovim/releases/v0.6.0"><img alt="Neovim" src="https://img.shields.io/badge/Neovim-v0.6+-57A143?logo=neovim&logoColor=57A143" /></a>
<a href="https://luarocks.org/modules/linrongbin16/commons.nvim"><img alt="luarocks" src="https://custom-icon-badges.demolab.com/luarocks/v/linrongbin16/commons.nvim?label=LuaRocks&labelColor=063B70&logo=tag&logoColor=fff&color=008B8B" /></a>
<a href="https://github.com/linrongbin16/commons.nvim/actions/workflows/ci.yml"><img alt="ci.yml" src="https://img.shields.io/github/actions/workflow/status/linrongbin16/commons.nvim/ci.yml?label=GitHub%20CI&labelColor=181717&logo=github&logoColor=fff" /></a>
<a href="https://app.codecov.io/github/linrongbin16/commons.nvim"><img alt="codecov" src="https://img.shields.io/codecov/c/github/linrongbin16/commons.nvim?logo=codecov&logoColor=F01F7A&label=Codecov" /></a>
</p>

<p align="center"><i>
The commons lua library for Neovim plugin project.
</i></p>

## Table of Contents

- [Requirements](#requirements)
- [Install](#install)
  - [Plugin Manager](#plugin-manager)
  - [LuaRocks](#luarocks)
  - [Embed Source Code](#embed-source-code)
- [Usage](#usage)
- [Modules](#modules)
  - [commons.buffers](#commonsbuffers)
  - [commons.fileios](#commonsfileios)
  - [commons.jsons](#commonsjsons)
  - [commons.numbers](#commonsnumbers)
  - [commons.paths](#commonspaths)
  - [commons.ringbuf](#commonsringbuf)
  - [commons.spawn](#commonsspawn)
  - [commons.strings](#commonsstrings)
  - [commons.tables](#commonstables)
  - [commons.termcolors](#commonstermcolors)
  - [commons.uv](#commonsuv)
  - [commons.windows](#commonswindows)
- [Development](#development)
- [Contribute](#contribute)

## Requirements

- neovim &ge; 0.6.0.

## Install

### Plugin Manager

<details><summary><b>With <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a></b></summary>

```lua
require("lazy").setup({
  "linrongbin16/commons.nvim",
})
```

</details>

<details><summary><b>With <a href="https://github.com/lewis6991/pckr.nvim">pckr.nvim</a></b></summary>

```lua
require("pckr").add({
  "linrongbin16/commons.nvim",
})
```

</details>

### LuaRocks

<details><summary><b>With <a href="https://luarocks.org/">luarocks</a></b></summary>

```bash
luarocks install commons.nvim
```

</details>

### Embed Source Code

<details><summary><b>With <a href="https://docs.github.com/en/actions">GitHub Actions</a></b></summary>

Download and auto-commit (with [git-auto-commit-action@v4](https://github.com/stefanzweifel/git-auto-commit-action)) to `lua/your/plugin/commons` folder when submit PRs:

```yaml
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  install_commons_nvim:
    name: Install commons.nvim
    runs-on: ubuntu-latest
    steps:
      - name: Install commons.nvim
        if: ${{ github.ref != 'refs/heads/main' }}
        shell: bash
        run: |
          echo "pwd"
          echo $PWD
          echo "home"
          echo $HOME
          git clone --depth=1 https://github.com/linrongbin16/commons.nvim.git ~/.commons.nvim
          mkdir -p ./lua/gentags/commons
          cp -rf ~/.commons.nvim/lua/commons/*.lua ./lua/your/plugin/commons
          cd ./lua/your/plugin/commons
          find . -type f -name '*.lua' -exec sed -i 's/require("commons/require("your.plugin.commons/g' {} \;
          cd $HOME
      - uses: stefanzweifel/git-auto-commit-action@v4
        if: ${{ github.ref != 'refs/heads/main' }}
        with:
          commit_message: "chore(pr): auto-commit commons.nvim"
```

Here're some real-world examples:

- [gentags.nvim's ci.yml](https://github.com/linrongbin16/gentags.nvim/blob/5f5bd825951fb8bc8c5dea7919c46a86063c6e5e/.github/workflows/ci.yml?plain=1#L47-L51) and its [action runs](https://github.com/linrongbin16/gentags.nvim/actions/runs/7176179406/job/19540665077).

</details>

## Usage

When installed with plugin manager or luarocks, please use:

```lua
local strings = require("commons.strings")
```

When installed with embed source code, please use:

```lua
local strings = require("your.plugin.commons.strings")
```

## Modules

### [commons.buffers](/lua/commons/buffers.lua)

Compatible Neovim buffer relate APIs.

- `get_buf_option(bufnr:integer, name:string):any`: get `bufnr` buffer option.
- `set_buf_option(bufnr:integer, name:string, value:any):any`: set `bufnr` buffer option value.

### [commons.fileios](/lua/commons/fileios.lua)

File (sync/async) IO operations.

Read operations:

- `readfile(filename:string, opts:{trim:boolean?}?):string`: Read the file content, by default `opts` is `{trim = false}`, e.g. not trim whitespaces around text content. Returns the file content.
- `readlines(filename:string):string[]|nil`: Read the file content line by line. Returns the file content by strings list.
- `asyncreadfile(filename:string, on_complete:fun(data:string?):nil, opts:{trim:boolean?}?):nil`: Async read the file content, invoke callback `on_complete` when read is done, by default `opts` is `{trim = false}`, e.g. not trim whitespaces around text content. Throw an error if failed.

Write operations:

- `writefile(filename:string, content:string):integer`: Write text `context` to file, returns `-1` if failed, otherwise `0`.
- `writelines(filename:string, lines:string[]):integer`: Write `lines` content to file, returns `-1` if failed, otherwise `0`.
- `asyncwritefile(filename:string, content:string, on_complete:fun(bytes:integer?):nil):nil`: Async write text `content` to the file, invoke callback `on_complete` when write is done. Throw an error if failed.

### [commons.jsons](/lua/commons/jsons.lua)

Use [actboy168/json.lua](https://github.com/actboy168/json.lua) for Neovim &lt; 0.10, [vim.json](https://github.com/neovim/neovim/blob/a9fbba81d5d4562a2d2b2cbb41d73f1de83d3102/runtime/doc/lua.txt?plain=1#L772) for Neovim &ge; 0.10.

- `encode(t:table):string`: encode lua table to json object/list string.
- `decode(j:string):table`: decode json object/list string to lua table.

### [commons.numbers](/lua/commons/numbers.lua)

Numbers utilities.

- `INT32_MIN`/`INT32_MAX`: 32 bit integer max/min value.
- `eq(a:number?, b:number?):boolean`/`ne(a:number?, b:number?):boolean`: Whether `a` and `b` are equal or not.
- `lt(a:number?, b:number?):boolean`/`le(a:number?, b:number?):boolean`: Whether `a` is less than (or less equal to) `b` or not.
- `gt(a:number?, b:number?):boolean`/`ge(a:number?, b:number?):boolean`: Whether `a` is greater than (or greater equal to) `b` or not.
- `bound(value:number?, left:number?, right:numbers?):number`: Returns the bounded `value` by the max value `right` and min value `left`, e.g. when `value < left` returns `left`, when `value > right` returns `right`.
- `auto_incremental_id():integer`: Returns auto-incremental ID, start from `1`.

### [commons.paths](/lua/commons/paths.lua)

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

Sync/async run child-process via `uv.spawn` API, and handle stdout/stderr IO by lines.

- `run(cmd:string[], opts:{stdout:fun(line:string):nil, stderr:fun(line:string):nil, [string]:any}, on_exit:fun(completed:vim.SystemCompleted):nil|nil):vim.SystemObject`: run command line, this is just a wrapper for [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>). The only difference is `opts` provide more friendly line-based `stdout` and `stderr` callbacks.
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

Table/list data structure for lua.

For tables:

- `tbl_empty(t:any):boolean`/`tbl_not_empty(t:any):boolean`: Whether table `t` is empty or not.
- `tbl_get(t:any, ...:any):any`: Retrieve element from lua table/list, this is just a wrapper of [vim.tbl_get](<https://neovim.io/doc/user/lua.html#vim.tbl_get()>).

For list:

- `list_empty(l:any):boolean`/`list_not_empty(l:any):boolean`: Whether list `l` is empty or not.
- `list_index(l:any, idx:integer):integer`: Get list index with negatives support, for `idx > 0` returns the same value, for `idx < 0` returns `#l + idx + 1`, e.g. `-1` returns `#l` (the last element index), `-#l` returns `1` (the first element index).

### [commons.termcolors](/lua/commons/termcolors.lua)

Terminal ANSI colors rendering utilities.

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
