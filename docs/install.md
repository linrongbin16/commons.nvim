<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# Install

## Plugin Manager

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
  {
    "linrongbin16/commons.nvim",

    -- (optional) specify the version/tag
    tag = 'v1.4.3',
    version = 'v1.4.*',
  },
})
```

### [pckr.nvim](https://github.com/lewis6991/pckr.nvim)

```lua
require("pckr").add({
  {
    "linrongbin16/commons.nvim",

    -- (optional) specify the tag
    tag = 'v1.*',
  },
})
```

## LuaRocks

```bash
luarocks install commons.nvim

# (optional) specify the version
luarocks install commons.nvim 1.4.1
```

## Embed Source Code

### Manual

1. Copy/paste all `lua/commons/*.lua` into one of your plugin folders.
2. Replace all prefix `require("commons` to `require("your.plugin.commons`.

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
          mkdir -p ./lua/your/plugin/commons
          cp -rf ~/.commons.nvim/lua/commons/*.lua ./lua/your/plugin/commons
          cd ./lua/your/plugin/commons
          find . -type f -name '*.lua' -exec sed -i 's/require("commons/require("your.plugin.commons/g' {} \;
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
