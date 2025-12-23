<!-- markdownlint-disable -->

# Welcome to commons.nvim's Documentation!

<p align="left"><i>
The commons lua library for Neovim plugin project.
</i></p>

## Get Started

- [Install](install.md)
- [Usage](usage.md)

## Modules

- [commons.fio](/commons_fio.md): File sync/async IO operations.
- [commons.log](/commons_logging.md): Logging system for both messages (stdout/stderr) and files.
- [commons.num](/commons_num.md): Numbers utilities, with type check and approximate float compare.
- [commons.path](/commons_path.md): File and directory path utilities.
- [commons.platform](/commons_platform.md): OS and platform utilities.
- [commons.spawn](/commons_spawn.md): Run child-process with friendly line-wise callbacks to handle stdout/stderr output, a wrapper on [vim.system](<https://neovim.io/doc/user/lua.html#vim.system()>).
- [commons.str](/commons_str.md): Strings utilities, with type check.
- [commons.tbl](/commons_tbl.md): Lua table/list utilities, with type check.
- [commons.uv](/commons_uv.md): A wrapper on [vim.loop](https://github.com/neovim/neovim/blob/36552adb39edff2d909743f16c1f061bc74b5c4e/runtime/doc/deprecated.txt?plain=1#L166) (for Neovim &lt; 0.10) or [vim.uv](https://neovim.io/doc/user/lua.html#vim.uv) (for Neovim &ge; 0.10).
- [commons.version](/commons_version.md): Compatible APIs to detect Neovim version, a wrapper on [vim.version](https://neovim.io/doc/user/lua.html#vim.version).

## Contribute

- [Development](development.md)
