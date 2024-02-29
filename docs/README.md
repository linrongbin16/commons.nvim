<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD026 -->

# Welcome to commons.nvim's Documentation!

<p align="left"><i>
The commons lua library for Neovim plugin project.
</i></p>
</br>

- [commons.apis](/commons_apis.md): Compatible builtin APIs across multiple Neovim versions, a wrapper on [vim.api](https://neovim.io/doc/user/api.html).
- [commons.async](/commons_async.md): Embedded [lewis6991/async.nvim](https://github.com/lewis6991/async.nvim) library.
- commons.colors
  - [commons.colors.hl](/commons_colors_hl.md): RGB color & nvim syntax highlight utilities.
  - [commons.colors.hsl](/commons_colors_hsl.md): Embedded [sputnik's colors](http://sputnik.freewisdom.org/lib/colors/) library.
  - [commons.colors.term](/commons_colors_term.md): Terminal ANSI/RGB color rendering utilities.
- [commons.fileios](/commons_fileios.md): File sync/async IO operations.
- [commons.jsons](/commons_jsons.md): Encode/decode between lua table/list and json string.
- [commons.logging](/commons_logging.md): Logging system with [python-logging](https://docs.python.org/3/library/logging.html) like features.
- [commons.micro-async](/commons_micro_async.md): Embedded [willothy/micro-async.nvim](https://github.com/willothy/micro-async.nvim) library.
- [commons.msgpack](/commons_msgpack.md): Encode/decode between lua table/list and msgpack bytes.
- [commons.numbers](/commons_numbers.md): Numbers utilities, with type check and approximate float compare.
- [commons.paths](/commons_paths.md): File and directory path utilities.
- [commons.platforms](/commons_platforms.md): OS and platforms utilities.
- [commons.promise](/commons_promise.md): Embedded [notomo/promise.nvim](https://github.com/notomo/promise.nvim) library.
- [commons.ringbuf](/commons_ringbuf.md): Drop-in [vim.ringbuf](<https://neovim.io/doc/user/lua.html#vim.ringbuf()>) replacement data structure with iterator support.
- [commons.spawn](/commons_spawn.md): Run child-process with friendly line-wise callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).
- [commons.strings](/commons_strings.md): Strings utilities, with type check.
- [commons.tables](/commons_tables.md): Lua table/list utilities, with type check.
- [commons.uv](/commons_uv.md): A wrapper on [vim.loop](https://github.com/neovim/neovim/blob/36552adb39edff2d909743f16c1f061bc74b5c4e/runtime/doc/deprecated.txt?plain=1#L166) (for Neovim &lt; 0.10) or [vim.uv](https://neovim.io/doc/user/lua.html#vim.uv) (for Neovim &ge; 0.10).
