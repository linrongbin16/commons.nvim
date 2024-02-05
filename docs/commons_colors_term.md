<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.colors.term](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/colors/term.lua)

Terminal ANSI/RGB color rendering utilities.

!> This module requires terminal support RGB colors and Neovim enables `termguicolors`.

## Constants

### `COLOR_NAMES`

The strings list contains below values, it also match the pre-defined CSS color APIs:

?> Also see [Pre-defined Color APIs](#pre-defined-color-apis).

- `"black"`: <span style='background-color:black; color:white'>Black</span>.
- `"grey"`: <span style='background-color:grey; color:white'>Grey</span>.
- `"silver"`: <span style='background-color:silver; color:white'>Silver</span>.
- `"white"`: <span style='background-color:black; color:white'>The<span style='background-color:white; color:black'> White </span>color</span>.
- `"violet"`: <span style='background-color:violet; color:white'>Violet</span>.
- `"magenta"`: <span style='background-color:magenta; color:white'>Magenta</span>.
- `"fuchsia"`: <span style='background-color:fuchsia; color:white'>Fuchsia</span>.
- `"red"`: <span style='background-color:red; color:white'>Red</span>.
- `"purple"`: <span style='background-color:purple; color:white'>Purple</span>.
- `"indigo"`: <span style='background-color:indigo; color:white'>Indigo</span>.
- `"yellow"`: <span style='background-color:yellow'>Yellow</span>.
- `"gold"`: <span style='background-color:gold'>Gold</span>.
- `"orange"`: <span style='background-color:orange'>Orange</span>.
- `"chocolate"`: <span style='background-color:chocolate; color:white'>Chocolate</span>.
- `"olive"`: <span style='background-color:olive; color:white'>Olive</span>.
- `"green"`: <span style='background-color:green; color:white'>Green</span>.
- `"lime"`: <span style='background-color:lime'>Lime</span>.
- `"teal"`: <span style='background-color:teal; color:white'>Teal</span>.
- `"cyan"`: <span style='background-color:cyan'>Cyan</span>.
- `"aqua"`: <span style='background-color:aqua'>Aqua</span>.
- `"blue"`: <span style='background-color:blue; color:white'>Blue</span>.
- `"navy"`: <span style='background-color:navy; color:white'>Navy</span>.
- `"slateblue"`: <span style='background-color:slateblue; color:white'>Slateblue</span>.
- `"steelblue"`: <span style='background-color:steelblue; color:white'>Steelblue</span>.

## Functions

### `render`

Render `text` content with ANSI color (<span style='background-color:yellow'>yellow</span>, <span style='background-color:red'>red</span>, <span style='background-color:blue'>blue</span>, etc) and RGB color (<span style='background-color:#808080'>#808080</span>, <span style='background-color:#FF00FF'>#FF00FF</span>, etc), or vim's syntax highlighting group.

```lua
function render(text:string, name:string, hl:string?):string
```

Parameters:

- `text`: The content to be rendered.
- `name`: The ANSI color name or RGB color code.
- `hl`: The vim syntax highlighting group name, by default is `nil`. It has higher priority when provided.

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

### Pre-defined Color APIs

?> There're a bunch of pre-defined CSS color functions:

`black`: Almost same with [render](#render) function, except always use the `"black"` color.

```lua
function black(text:string, hl:string?):string
```

Parameters:

- `text`: The content to be rendered.
- `hl`: The vim syntax highlighting group name, by default is `nil`.

  - Vim syntax highlighting group has higher priority, only when it's been provided.

Here're other colors:

- `function silver(text:string, hl:string?):string`
- `function white(text:string, hl:string?):string`
- `function violet(text:string, hl:string?):string`
- `function magenta(text:string, hl:string?):string`
- `function fuchsia(text:string, hl:string?):string`
- `function red(text:string, hl:string?):string`
- `function purple(text:string, hl:string?):string`
- `function indigo(text:string, hl:string?):string`
- `function yellow(text:string, hl:string?):string`
- `function gold(text:string, hl:string?):string`
- `function orange(text:string, hl:string?):string`
- `function chocolate(text:string, hl:string?):string`
- `function olive(text:string, hl:string?):string`
- `function green(text:string, hl:string?):string`
- `function lime(text:string, hl:string?):string`
- `function teal(text:string, hl:string?):string`
- `function cyan(text:string, hl:string?):string`
- `function aqua(text:string, hl:string?):string`
- `function blue(text:string, hl:string?):string`
- `function navy(text:string, hl:string?):string`
- `function slateblue(text:string, hl:string?):string`
- `function steelblue(text:string, hl:string?):string`

?> Also see: [COLOR_NAMES](#color_names).
