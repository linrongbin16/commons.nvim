<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD026 -->

# Welcome to commons.nvim's Documentation!

<p align="center"><i>
The commons lua library for Neovim plugin project.
</i></p>

- Commons Modules

  - [commons.buffers](/commons_buffers.md): The compatible Neovim APIs for nvim buffers.
  - [commons.fileios](/commons_fileios.md): File sync/async IO operations.
  - [commons.jsons](/commons_jsons.md): Encode/decode between lua table/list and json string.
  - [commons.logging](/commons_logging.md): Logging system with [python-logging](https://docs.python.org/3/library/logging.html) like features.
  - [commons.numbers](/commons_numbers.md): Numbers utilities, with type check.
  - [commons.paths](/commons_paths.md): File and directory path utilities.
  - [commons.ringbuf](/commons_ringbuf.md): Drop-in [vim.ringbuf](<https://neovim.io/doc/user/lua.html#vim.ringbuf()>) replacement data structure with iterator support.
  - [commons.spawn](/commons_spawn.md): Run child-process with friendly line-wise callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).
  - [commons.strings](/commons_strings.md): Strings utilities, with type check.
  - [commons.tables](/commons_tables.md): Lua table/list utilities, with type check.
  - [commons.termcolors](/commons_termcolors.md): Terminal ANSI/RGB color rendering utilities.
  - [commons.uv](/commons_uv.md): A wrapper on [vim.loop](https://github.com/neovim/neovim/blob/36552adb39edff2d909743f16c1f061bc74b5c4e/runtime/doc/deprecated.txt?plain=1#L166) (for Neovim &lt; 0.10) or [vim.uv](https://neovim.io/doc/user/lua.html#vim.uv) (for Neovim &ge; 0.10).
  - [commons.windows](/commons_windows.md): The compatible Neovim APIs for nvim windows.
