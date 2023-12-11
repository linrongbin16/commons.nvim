<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# commons.nvim

<p align="center">
<a href="https://github.com/neovim/neovim/releases/v0.5.0"><img alt="Neovim" src="https://img.shields.io/badge/Neovim-v0.5+-57A143?logo=neovim&logoColor=57A143" /></a>
<a href="https://luarocks.org/modules/linrongbin16/commons.nvim"><img alt="luarocks" src="https://custom-icon-badges.demolab.com/luarocks/v/linrongbin16/commons.nvim?label=LuaRocks&labelColor=063B70&logo=tag&logoColor=fff&color=008B8B" /></a>
<a href="https://github.com/linrongbin16/commons.nvim/actions/workflows/ci.yml"><img alt="ci.yml" src="https://img.shields.io/github/actions/workflow/status/linrongbin16/commons.nvim/ci.yml?label=GitHub%20CI&labelColor=181717&logo=github&logoColor=fff" /></a>
<a href="https://app.codecov.io/github/linrongbin16/commons.nvim"><img alt="codecov" src="https://img.shields.io/codecov/c/github/linrongbin16/commons.nvim?logo=codecov&logoColor=F01F7A&label=Codecov" /></a>
</p>

<p align="center"><i>
The commons lua library for Neovim plugin project.
</i></p>

## Table of Contents

- [Requirements](#requirements)
- [Install](#install)
  - [Plugin Manager](#plugin-manager)
  - [LuaRocks](#luarocks)
  - [GitHub Actions](#github-actions)
- [Modules](#modules)
- [Development](#development)
- [Contribute](#contribute)

## Requirements

- neovim &ge; 0.5.0.

## Install

There're 3 ways to install this library for Neovim plugin.

### Plugin Manager

<details><summary><b>With <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a></b></summary>

```lua
require("lazy").setup({
  { "linrongbin16/commons.nvim", opts = {} },
})
```

</details>

<details><summary><b>With <a href="https://github.com/lewis6991/pckr.nvim">pckr.nvim</a></b></summary>

```lua
require("pckr").add({
  {
    "linrongbin16/commons.nvim",
    config = function()
      require("commons").setup()
    end,
  },
})
```

</details>

### LuaRocks

<details><summary><b>With <a href="https://luarocks.org/">luarocks</a></b></summary>

```bash
luarocks install commons.nvim
```

</details>

### GitHub Actions

<details><summary><b>With <a href="https://docs.github.com/en/actions">GitHub Actions</a></b></summary>

Download and auto-commit (with [git-auto-commit-action@v4](https://github.com/stefanzweifel/git-auto-commit-action)) to `lua/your/plugin/commons` folder:

```yaml
jobs:
  install_commons_nvim:
    name: Install commons.nvim
    runs-on: ubuntu-latest
    steps:
      - name: Install commons.nvim
        if: ${{ github.ref != 'refs/heads/main' }}
        shell: bash
        run: |
          echo "pwd"
          echo $PWD
          git clone --depth=1 https://github.com/linrongbin16/commons.nvim.git ~/.commons.nvim
          cp -rf ~/.commons.nvim/lua/commons ./lua/your/plugin/commons
      - uses: stefanzweifel/git-auto-commit-action@v4
        if: ${{ github.ref != 'refs/heads/main' }}
        with:
          commit_message: "chore(pr): embed commons.nvim library"
```

And you need to export the **module prefix** (since the default lua module prefix is `commons`) in environment variable:

```lua
vim.env._COMMONS_NVIM_MODULE_PREFIX = 'your.plugin.'
```

Then in your plugin project, load the commons library with:

```lua
local strings = require('your.plugin.commons.strings')
```

</details>

## Modules

## Usage

## Development

Setup the plugin development with:

- [lua-language-server](https://github.com/LuaLS/lua-language-server): language server.
- [stylua](https://github.com/JohnnyMorganz/StyLua): code format.
- [luacheck](https://github.com/lunarmodules/luacheck): code static check.
- [luarocks](https://luarocks.org/): package management for vusted/busted/luacov.
- [vusted](https://github.com/notomo/vusted): unit test.

Then run unit tests with `vusted ./test`.

## Contribute

Please open [issue](https://github.com/linrongbin16/commons.nvim/issues)/[PR](https://github.com/linrongbin16/commons.nvim/pulls) for anything about commons.nvim.

Like commons.nvim? Consider

[![Github Sponsor](https://img.shields.io/badge/-Sponsor%20Me%20on%20Github-magenta?logo=github&logoColor=white)](https://github.com/sponsors/linrongbin16)
[![Wechat Pay](https://img.shields.io/badge/-Tip%20Me%20on%20WeChat-brightgreen?logo=wechat&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor)
[![Alipay](https://img.shields.io/badge/-Tip%20Me%20on%20Alipay-blue?logo=alipay&logoColor=white)](https://github.com/linrongbin16/lin.nvim/wiki/Sponsor)
