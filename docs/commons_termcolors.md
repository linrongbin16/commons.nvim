<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.termcolors](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/termcolors.lua)

Terminal ANSI/RGB color rendering utilities.

!> This module requires terminal support true color and Neovim enables `termguicolors` for the best display.

## Functions

### `render`

Render `text` content with ANSI color (<span style='background-color:yellow'>yellow</span>, <span style='background-color:red'>red</span>, <span style='background-color:blue'>blue</span>, etc) and RGB color (<span style='background-color:#808080'>#808080</span>, <span style='background-color:#FF00FF'>#FF00FF</span>, etc), or vim's syntax highlighting group.

```lua
function render(text:string, name:string, hl:string?):string
```

Parameters:

- `text`: The content to be rendered.
- `name`: The ANSI color name or RGB color code.
- `hl`: The vim syntax highlighting group name, by default is `nil`.
  ?> Vim syntax highlighting group has higher priority, only when it's been provided.

Returns:

- Returns the rendered text string with terminal escape. For example: `\27[38;2;216;166;87mCTRL-U\27[0m` (the text content is `CTRL-U`).

### `erase`

Erase ANSI/RGB colors from `text` content.

```lua
function erase(text:string):string
```

Parameters:

- `text`: The escaped text content that can be print on terminal with colors, for example: `\27[38;2;216;166;87mCTRL-U\27[0m` (the text content is `CTRL-U`).

Returns:

- Returns the raw text content, for example: `CTRL-U`.

?> There're a bunch of pre-defined CSS color functions:

### `black`

Almost same with [render](#render) function, except always use the <span style='background-color:black; color:white'>black</span> color.

```lua
function black(text:string, hl:string?):string
```

Parameters:

- `text`: The content to be rendered.
- `hl`: The vim syntax highlighting group name, by default is `nil`.
  ?> Vim syntax highlighting group has higher priority, only when it's been provided.

### `silver`

Same with the [black](#black) function, except use the <span style='background-color:silver'>silver</span> color.

### `white`

Same with the [black](#black) function, except use the <span style='color:white; background-color:black'>white</span> color.

### `violet`

Same with the [black](#black) function, except use the <span style='background-color:violet'>violet</span> color.

### `magenta`

Same with the [black](#black) function, except use the <span style='background-color:magenta'>magenta</span> color.

### `fuchsia`

Same with the [black](#black) function, except use the <span style='background-color:fuchsia'>fuchsia</span> color.

### `red`

Same with the [black](#black) function, except use the <span style='background-color:red'>red</span> color.

### `purple`

Same with the [black](#black) function, except use the <span style='background-color:purple'>purple</span> color.

### `indigo`

Same with the [black](#black) function, except use the <span style='background-color:indigo'>indigo</span> color.

### `yellow`

Same with the [black](#black) function, except use the <span style='background-color:yellow'>yellow</span> color.

### `gold`

Same with the [black](#black) function, except use the <span style='background-color:gold'>gold</span> color.

### `orange`

Same with the [black](#black) function, except use the <span style='background-color:orange'>orange</span> color.

### `chocolate`

Same with the [black](#black) function, except use the <span style='background-color:chocolate'>chocolate</span> color.

### `olive`

Same with the [black](#black) function, except use the <span style='background-color:olive'>olive</span> color.

### `green`

Same with the [black](#black) function, except use the <span style='background-color:green'>green</span> color.

### `lime`

Same with the [black](#black) function, except use the <span style='background-color:lime'>lime</span> color.

### `teal`

Same with the [black](#black) function, except use the <span style='background-color:teal'>teal</span> color.

### `cyan`

Same with the [black](#black) function, except use the <span style='background-color:cyan'>cyan</span> color.

### `aqua`

Same with the [black](#black) function, except use the <span style='background-color:aqua'>aqua</span> color.

### `blue`

Same with the [black](#black) function, except use the <span style='background-color:blue'>blue</span> color.

### `navy`

Same with the [black](#black) function, except use the <span style='background-color:navy'>navy</span> color.

### `slateblue`

Same with the [black](#black) function, except use the <span style='background-color:slateblue'>slateblue</span> color.

### `steelblue`

Same with the [black](#black) function, except use the <span style='background-color:steelblue'>steelblue</span> color.

?> There're some other APIs:

### `retrieve`

Retrieve ANSI/RGB color codes from vim's syntax highlighting group name.

```lua
function retrieve(attr:"fg"|"bg", hl:string):string
```

Parameters:

- `attr`: Retrieve the foreground (`fg`) color or background (`bg`) color from vim highlighting group.
- `hl`: Vim highlighting group name.

Returns:

- Returns ANSI color codes (`30`, `35`, etc) or RGB color codes (`#808080`, `#FF00FF`, etc).

### `escape`

Format (escape) ANSI/RGB color code to terminal escaped (printable) style.

```lua
function escape(attr:"fg"|"bg", code:string):string
```

Parameters:

- `attr`: Escape for foreground (`fg`) or background (`bg`).
- `code`: The ANSI color code (`30`, `35`, etc) or RGB color code (`#808080`, `#FF00FF`, etc).

Returns:

- Returns the terminal escaped format, for example: `38;2;216;166;87`.
