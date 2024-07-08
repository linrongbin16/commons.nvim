# commons.nvim

<p>
<a href="https://github.com/neovim/neovim/releases/v0.9.0"><img alt="require" src="https://img.shields.io/badge/require-0.9%2B-blue" /></a>
<a href="https://luarocks.org/modules/linrongbin16/commons.nvim"><img alt="luarocks" src="https://img.shields.io/luarocks/v/linrongbin16/commons.nvim" /></a>
<a href="https://github.com/linrongbin16/commons.nvim/actions/workflows/ci.yml"><img alt="ci.yml" src="https://img.shields.io/github/actions/workflow/status/linrongbin16/commons.nvim/ci.yml?label=ci" /></a>
<a href="https://app.codecov.io/github/linrongbin16/commons.nvim"><img alt="codecov" src="https://img.shields.io/codecov/c/github/linrongbin16/commons.nvim/main?label=codecov" /></a>
</p>

<p align="center"><i>
The commons lua library for Neovim plugin project.
</i></p>

This lua library includes multiple modules:

- Utilities for lua tables, strings, numbers and other data structures.
- File IO & path operations.
- URL encode/decode.
- Spawn child-process & coroutine.
- Logging system with python-logging like features.
- Colors & syntax highlight utilities, HSL calculation & terminal rendering.
- Compatible APIs support Neovim versions from last legacy to nightly.

> [!NOTE]
>
> This library keeps up with the latest Neovim stable version, support until the last legacy version, earlier versions are dropped for maintenance reason, i.e. (at the time of writing, 2024-05-27), stable is 0.10, last legacy is 0.9, nightly is 0.11, thus this plugin supports 0.9+.

Please check [documentation](https://linrongbin16.github.io/commons.nvim) for more details.

## Embedded Libraries

- [\_system.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/_system.lua): Neovim [vim.system()](<https://neovim.io/doc/user/lua.html#vim.system()>) source file.
- [uri.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/uri.lua): Neovim [vim.uri_encode()](<https://neovim.io/doc/user/lua.html#vim.uri_encode()>) source file.
- [async.lua](https://github.com/lewis6991/async.nvim): Small aync library for Neovim plugins.
- [colors.lua](http://sputnik.freewisdom.org/lib/colors/): HSL Color Theory Computation in Lua.

## Contribute

Please open [issue](https://github.com/linrongbin16/commons.nvim/issues)/[PR](https://github.com/linrongbin16/commons.nvim/pulls) for anything about commons.nvim.

Likes commons.nvim? Consider

[![Github Sponsor](https://img.shields.io/badge/-Sponsor%20Me%20on%20Github-magenta?logo=github&logoColor=white)](https://github.com/sponsors/linrongbin16) [![Wechat Pay](https://img.shields.io/badge/-Tip%20Me%20on%20WeChat-brightgreen?logo=wechat&logoColor=white)](https://linrongbin16.github.io/commons.nvim/#/sponsor?id=wechat-pay) [![Alipay](https://img.shields.io/badge/-Tip%20Me%20on%20Alipay-blue?logo=alipay&logoColor=white)](https://linrongbin16.github.io/commons.nvim/#/sponsor?id=alipay)
