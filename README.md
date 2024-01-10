<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# commons.nvim

<p align="center">
<a href="https://github.com/neovim/neovim/releases/v0.6.0"><img alt="Neovim" src="https://img.shields.io/badge/Neovim-v0.6+-57A143?logo=neovim&logoColor=57A143" /></a>
<a href="https://luarocks.org/modules/linrongbin16/commons.nvim"><img alt="luarocks" src="https://custom-icon-badges.demolab.com/luarocks/v/linrongbin16/commons.nvim?label=LuaRocks&labelColor=2C2D72&logo=tag&logoColor=fff&color=blue" /></a>
<a href="https://github.com/linrongbin16/commons.nvim/actions/workflows/ci.yml"><img alt="ci.yml" src="https://img.shields.io/github/actions/workflow/status/linrongbin16/commons.nvim/ci.yml?label=GitHub%20CI&labelColor=181717&logo=github&logoColor=fff" /></a>
<a href="https://app.codecov.io/github/linrongbin16/commons.nvim"><img alt="codecov" src="https://img.shields.io/codecov/c/github/linrongbin16/commons.nvim?logo=codecov&logoColor=F01F7A&label=Codecov" /></a>
</p>

<p align="center"><i>
The commons lua library for Neovim plugin project.
</i></p>

This lua library includes multiple modules:

- Utilities for lua tables, strings, numbers and other data structures.
- File IO & path operations.
- Convert between lua tables and json strings.
- Run child-process and handle line-wise output from stdout/stderr.
- Async/await with lua coroutine.
- Logging system with python-logging like features.
- Terminal ANSI/RGB color renderings.
- Compatible APIs support Neovim versions from v0.6 to nightly.

Please check [documentation](https://linrongbin16.github.io/commons.nvim) for more details.

## Embedded Libraries

- [json.lua](https://github.com/actboy168/json.lua): A pure Lua JSON library.
- [\_system.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/_system.lua): Neovim [vim.system()](<https://neovim.io/doc/user/lua.html#vim.system()>) source file.
- [async.lua](https://github.com/lewis6991/async.nvim): Small aync library for Neovim plugins.
- [micro-async.lua](https://github.com/willothy/micro-async.nvim): Ultra-simple async library for Neovim, with cancellation support.
- [promise.lua](https://github.com/notomo/promise.nvim): Promise implementation for neovim lua.

## Contribute

Please open [issue](https://github.com/linrongbin16/commons.nvim/issues)/[PR](https://github.com/linrongbin16/commons.nvim/pulls) for anything about commons.nvim.

Likes commons.nvim? Consider

[![Github Sponsor](https://img.shields.io/badge/-Sponsor%20Me%20on%20Github-magenta?logo=github&logoColor=white)](https://github.com/sponsors/linrongbin16) [![Wechat Pay](https://img.shields.io/badge/-Tip%20Me%20on%20WeChat-brightgreen?logo=wechat&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor) [![Alipay](https://img.shields.io/badge/-Tip%20Me%20on%20Alipay-blue?logo=alipay&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor)
