<!-- markdownlint-disable -->

# Welcome to commons.nvim's Documentation!

<p align="left"><i>
The commons lua library for Neovim plugin project.
</i></p>

## Get Started

- [Install](install.md)
- [Usage](usage.md)

## Modules

- [commons.async](/commons_async.md): Very simple and rough wrap to turn callback-style functions into async-style functions, with the help of lua's `coroutine`, thus getting out of the callback hell.
- commons.color
  - [commons.color.hl](/commons_color_hl.md): RGB color & nvim syntax highlight utilities.
  - [commons.color.hsl](/commons_color_hsl.md): Embedded [sputnik's colors](http://sputnik.freewisdom.org/lib/colors/) library.
  - [commons.color.term](/commons_color_term.md): Terminal ANSI/RGB color rendering utilities.
- [commons.fio](/commons_fio.md): File sync/async IO operations.
- [commons.logging](/commons_logging.md): Logging system with [python-logging](https://docs.python.org/3/library/logging.html) like features.
- [commons.num](/commons_num.md): Numbers utilities, with type check and approximate float compare.
- [commons.path](/commons_path.md): File and directory path utilities.
- [commons.platform](/commons_platform.md): OS and platform utilities.
- [commons.spawn](/commons_spawn.md): Run child-process with friendly line-wise callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).
- [commons.str](/commons_str.md): Strings utilities, with type check.
- [commons.tbl](/commons_tbl.md): Lua table/list utilities, with type check.
- [commons.uv](/commons_uv.md): A wrapper on [vim.loop](https://github.com/neovim/neovim/blob/36552adb39edff2d909743f16c1f061bc74b5c4e/runtime/doc/deprecated.txt?plain=1#L166) (for Neovim &lt; 0.10) or [vim.uv](https://neovim.io/doc/user/lua.html#vim.uv) (for Neovim &ge; 0.10).
- [commons.version](/commons_version.md): Compatible APIs to detect Neovim version, a wrapper on [vim.version](https://neovim.io/doc/user/lua.html#vim.version).

## Contribute

- [Contribute](contribute.md)
- [Development](development.md)
- [Sponsor](sponsor.md)
