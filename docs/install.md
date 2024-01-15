<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# Install

!> Embedding source code is the recommend way to install this library, both [LuaRocks](https://luarocks.org/) and Neovim plugin managers cannot guarantee they handle the version confliction issue correctly, which brings potential exceptions in runtime. See below.

## The Version Confliction Issue

For example now we have two plugins `A` and `B`, they both depend on the `commons` library, but on different versions, say `v2.1.0` and `v3.4.3`.

The major version means there're some break changes, say `commons.paths.parent` API behavior is different on `v2.x` and `v3.x`. And it just happened both `A` and `B` are using this API.

We expect `A` use `commons-v2.1.0` and `B` use `commons-v3.4.3`, but when `A` and `B` use LuaRocks or Neovim plugin managers to depend `commons` library, the package manager cannot guarantee such behavior, e.g. the `commons` library version is uncertain, thus bring potential exceptions in runtime.

## Embed Source Code

### Manual

1. Copy/paste the `lua/commons` directory into one of your plugin folders.
2. Replace all prefix `"commons.` to `"your.plugin.commons.`.

### [GitHub Actions](https://docs.github.com/en/actions)

Embed to `lua/your/plugin/commons` folder when submit PRs:

```yaml
name: Install commons.nvim
on:
  pull_request:
    branches:
      - main
jobs:
  install_commons_nvim:
    name: Install commons.nvim
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install commons.nvim
        if: ${{ github.ref != 'refs/heads/main' }}
        shell: bash
        run: |
          git clone --depth=1 https://github.com/linrongbin16/commons.nvim.git ~/.commons.nvim
          rm -rf ./lua/your/plugins/commons
          mkdir -p ./lua/your/plugin
          cp -rf ~/.commons.nvim/lua/commons ./lua/your/plugin/
          cp ~/.commons.nvim/version.txt ./lua/your/plugin/commons/version.txt
          find ./lua/your/plugin/commons -type f -name '*.lua' -exec sed -i 's/"commons./"your.plugin.commons./g' {} \;
      - uses: stefanzweifel/git-auto-commit-action@v4
        if: ${{ github.ref != 'refs/heads/main' }}
        with:
          commit_message: "chore(pr): auto-commit commons.nvim"
```

To specify tag/version, please use (for example `v1.4.3`):

```sh
git clone --depth=1 --branch v1.4.3 https://github.com/linrongbin16/commons.nvim.git ~/.commons.nvim
```

Here're real-world examples:

- gentags.nvim's [ci.yml](https://github.com/linrongbin16/gentags.nvim/blob/5f5bd825951fb8bc8c5dea7919c46a86063c6e5e/.github/workflows/ci.yml?plain=1#L47-L51) and its [action runs](https://github.com/linrongbin16/gentags.nvim/actions/runs/7176179406/job/19540665077).

## LuaRocks

```bash
luarocks install commons.nvim

# (optional) specify the version
luarocks install commons.nvim 1.4.1
```

## Plugin Manager

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
  "linrongbin16/commons.nvim",
})
```

### [pckr.nvim](https://github.com/lewis6991/pckr.nvim)

```lua
require("pckr").add({
  "linrongbin16/commons.nvim",
})
```
