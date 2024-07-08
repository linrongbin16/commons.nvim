# [commons.color.hl](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/color/hl.lua)

RGB color & nvim syntax highlight utilities.

!> This module requires terminal support RGB colors and Neovim enables `termguicolors`.

## Functions

### `get_hl`

Get real highlighting value without `link`, a wrapper on [nvim_get_hl()](<https://neovim.io/doc/user/api.html#nvim_get_hl()>) with global namespace and `link=false`.

```lua
--- @param hl string
--- @return {fg:integer?,bg:integer?,[string]:any,ctermfg:integer?,ctermbg:integer?,cterm:{fg:integer?,bg:integer?,[string]:any}?}
M.get_hl = function(hl)
```

Parameters:

- `hl`: Highlighting group name.

Returns:

- Returns lua table with RGB(gui)/ANSI(cterm) highlight args (see [nvim_set_hl()](<https://neovim.io/doc/user/api.html#nvim_set_hl()>)) if `hl` exists:

  - `fg`, `bg`, `sp`, `bold`, `italic`, `underline`, etc.
  - `ctermfg`: ANSI(cterm) foreground color code.
  - `ctermbg`: ANSI(cterm) background color code.
  - `cterm`: Other ANSI(cterm) highlight args such as `sp`, `bold`, `italic`, `underline`, etc.

- Returns `vim.empty_dict()` if `hl` not found.

?> Use `string.format("#%06x", fg)` to convert integer RGB color code into CSS color format such as `"#581720"`.

### `get_hl_with_fallback`

A wrapper on [`get_hl`](#get_hl), it accepts multiple highlight groups, returns the first existing one.

```lua
--- @param ... string?
--- @return {fg:integer?,bg:integer?,[string]:any,ctermfg:integer?,ctermbg:integer?,cterm:{fg:integer?,bg:integer?,[string]:any}?}, integer, string?
M.get_hl_with_fallback = function(...)
```

Parameters:

- `...`: Multiple highlight groups.

Returns:

- Returns 3 values for the first found highlight:

  1. The highlight value (lua table) of the hl.
  2. The index (in the parameter list) of the hl.
  3. The name of the hl.

- Returns 3 values if all highlight groups not found:
  1. `vim.empty_dict()`.
  2. `-1`.
  3. `nil`.

### `get_color`

Get RGB color code from nvim syntax highlight.

```lua
--- @param highlight string
--- @param attr "fg"|"bg"|string
--- @return string?
M.get_color = function(highlight, attr)
```

Parameters:

- `highlight`: Syntax highlight name.
- `attr`: Specify which field (usually `fg`, `bg`) to retrieve the RGB color from.

Returns:

- Returns RGB color code (in 6-bit hex format with `#` prefix, such as `#837104`, `#ab82c9`) if successful get the color.
- Returns `nil` if failed to found the `highlight` with specified `attr`.

### `get_color_with_fallback`

Get (the first if multiple highlights are provided) RGB color code, accepts multiple syntax highlights, with a fallback RGB color code.

```lua
--- @param highlights string|string[]
--- @param attr "fg"|"bg"|string
--- @param fallback_color string?
--- @return string?, integer, string?
M.get_color_with_fallback = function(highlights, attr, fallback_color)
```

Parameters:

- `highlights`: One or more syntax highlight names.
- `attr`: Specify which field (usually `fg`, `bg`) to retrieve the RGB color from.
- `fallback_color`: Fallback RGB color code, by default is `nil`.

Returns:

- Returns 3 values if successful get the color:

  - The RGB color code in 6-bit hex format with `#` prefix, such as `#837104`, `#ab82c9`.
  - The index in the `highlights` parameters list, indicate which highlight is been found if `highlights` contains multiple highlight names.
  - The name of the highlight been found.

- Returns 3 values if failed to get the color:
  - The `fallback_color`.
  - `-1`.
  - `nil`.
