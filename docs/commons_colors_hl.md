<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.colors.term](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/colors/term.lua)

RGB color utilities about nvim syntax highlights.

!> This module requires terminal support RGB colors and Neovim enables `termguicolors`.

## Functions

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
  - The name of the `highlight` been found.

- Returns 3 values if failed to get the color:
  - The `fallback_color`.
  - `-1`.
  - `nil`.
