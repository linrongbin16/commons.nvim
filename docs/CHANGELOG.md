# Changelog

## [3.6.1](https://github.com/linrongbin16/commons.nvim/compare/v3.6.0...v3.6.1) (2024-01-02)


### Bug Fixes

* **paths:** remove 'print' debug ([#149](https://github.com/linrongbin16/commons.nvim/issues/149)) ([ed879d4](https://github.com/linrongbin16/commons.nvim/commit/ed879d41e29a3af38bb62178169b8cb1f3cc882f))

## [3.6.0](https://github.com/linrongbin16/commons.nvim/compare/v3.5.3...v3.6.0) (2024-01-02)


### Features

* **paths:** add 'exists'/'isfile'/'isdir'/'islink' APIs  ([#146](https://github.com/linrongbin16/commons.nvim/issues/146)) ([53b87be](https://github.com/linrongbin16/commons.nvim/commit/53b87be5b70e930f90925466f8da43ff45b296c7))
* **paths:** add 'expand'/'resolve' APIs  ([#146](https://github.com/linrongbin16/commons.nvim/issues/146)) ([53b87be](https://github.com/linrongbin16/commons.nvim/commit/53b87be5b70e930f90925466f8da43ff45b296c7))
* **paths:** add 'resolve' opts in 'normalize'  ([#146](https://github.com/linrongbin16/commons.nvim/issues/146)) ([53b87be](https://github.com/linrongbin16/commons.nvim/commit/53b87be5b70e930f90925466f8da43ff45b296c7))
* **paths:** add more APIs and refactor 'normalize' ([#146](https://github.com/linrongbin16/commons.nvim/issues/146)) ([53b87be](https://github.com/linrongbin16/commons.nvim/commit/53b87be5b70e930f90925466f8da43ff45b296c7))

## [3.5.3](https://github.com/linrongbin16/commons.nvim/compare/v3.5.2...v3.5.3) (2024-01-01)


### Performance

* **paths:** add 'resolve' opts for 'normalize' ([#144](https://github.com/linrongbin16/commons.nvim/issues/144)) ([f47fba0](https://github.com/linrongbin16/commons.nvim/commit/f47fba089a3e2133ffc7761825c42df1a5f49aa3))

## [3.5.2](https://github.com/linrongbin16/commons.nvim/compare/v3.5.1...v3.5.2) (2024-01-01)


### Performance

* **tables:** always use self-implementation for 'tbl_get' API ([#142](https://github.com/linrongbin16/commons.nvim/issues/142)) ([4cfed5c](https://github.com/linrongbin16/commons.nvim/commit/4cfed5c68eed0d1dfdb823b612a9211127b2d72f))

## [3.5.1](https://github.com/linrongbin16/commons.nvim/compare/v3.5.0...v3.5.1) (2024-01-01)


### Performance

* **jsons:** always use external library ([#140](https://github.com/linrongbin16/commons.nvim/issues/140)) ([a145f19](https://github.com/linrongbin16/commons.nvim/commit/a145f1953cbf05738e46b172c87b953083aa3695))

## [3.5.0](https://github.com/linrongbin16/commons.nvim/compare/v3.4.3...v3.5.0) (2023-12-28)


### Features

* **tables:** add 'tbl_contains' and 'list_contains' API ([#133](https://github.com/linrongbin16/commons.nvim/issues/133)) ([f019c8f](https://github.com/linrongbin16/commons.nvim/commit/f019c8fdfe6e2b5fa18c6247864a3af588ccd4d1))

## [3.4.3](https://github.com/linrongbin16/commons.nvim/compare/v3.4.2...v3.4.3) (2023-12-27)


### Performance

* **paths:** improve returned value from 'parent' API ([#131](https://github.com/linrongbin16/commons.nvim/issues/131)) ([5ea6ae2](https://github.com/linrongbin16/commons.nvim/commit/5ea6ae29c930d35541072427c410e2cf41bef6a8))

## [3.4.2](https://github.com/linrongbin16/commons.nvim/compare/v3.4.1...v3.4.2) (2023-12-26)


### Performance

* **spawn:** add returned types ([#129](https://github.com/linrongbin16/commons.nvim/issues/129)) ([9fca684](https://github.com/linrongbin16/commons.nvim/commit/9fca684f4240301968c59f78abcc52058fe59ce4))

## [3.4.1](https://github.com/linrongbin16/commons.nvim/compare/v3.4.0...v3.4.1) (2023-12-26)


### Performance

* **numbers:** fallback to 'math.random' if uv.random not succeed ([#124](https://github.com/linrongbin16/commons.nvim/issues/124)) ([942a7ea](https://github.com/linrongbin16/commons.nvim/commit/942a7ea6fe5d75605f6d72e6b58ce9906ba0972a))

## [3.4.0](https://github.com/linrongbin16/commons.nvim/compare/v3.3.0...v3.4.0) (2023-12-26)


### Features

* **numbers:** add 'random' API ([#121](https://github.com/linrongbin16/commons.nvim/issues/121)) ([ee437e2](https://github.com/linrongbin16/commons.nvim/commit/ee437e2c92e2b179c5cf40c2ffb7b798523bd302))

## [3.3.0](https://github.com/linrongbin16/commons.nvim/compare/v3.2.1...v3.3.0) (2023-12-26)


### Features

* **numbers:** add 'shuffle' API ([#119](https://github.com/linrongbin16/commons.nvim/issues/119)) ([69cd5da](https://github.com/linrongbin16/commons.nvim/commit/69cd5dae28be4e428a1bfe35cc7e7df14a91c10f))
* **strings:** add 'setchar'/'tochars' API ([#119](https://github.com/linrongbin16/commons.nvim/issues/119)) ([69cd5da](https://github.com/linrongbin16/commons.nvim/commit/69cd5dae28be4e428a1bfe35cc7e7df14a91c10f))

## [3.2.1](https://github.com/linrongbin16/commons.nvim/compare/v3.2.0...v3.2.1) (2023-12-25)


### Bug Fixes

* **tables:** fix 'tbl_get' NPE ([#115](https://github.com/linrongbin16/commons.nvim/issues/115)) ([4250b33](https://github.com/linrongbin16/commons.nvim/commit/4250b33edb5d25c483ba4eaa582aa0d0c2c6fc16))

## [3.2.0](https://github.com/linrongbin16/commons.nvim/compare/v3.1.4...v3.2.0) (2023-12-25)


### Features

* **strings:** add 'trim', use lua pattern for '(l/r)trim' ([#113](https://github.com/linrongbin16/commons.nvim/issues/113)) ([a7c6161](https://github.com/linrongbin16/commons.nvim/commit/a7c6161fa7a9510c644b3696cd65779751efc343))


### Performance

* **strings:** use lua pattern for 'ltrim'/'rtrim' ([#113](https://github.com/linrongbin16/commons.nvim/issues/113)) ([a7c6161](https://github.com/linrongbin16/commons.nvim/commit/a7c6161fa7a9510c644b3696cd65779751efc343))

## [3.1.4](https://github.com/linrongbin16/commons.nvim/compare/v3.1.3...v3.1.4) (2023-12-20)


### Bug Fixes

* **paths:** fix 'pipename' require ([#111](https://github.com/linrongbin16/commons.nvim/issues/111)) ([67fc158](https://github.com/linrongbin16/commons.nvim/commit/67fc1583397ba7d8baca501b9e61545dd822c524))

## [3.1.3](https://github.com/linrongbin16/commons.nvim/compare/v3.1.2...v3.1.3) (2023-12-20)


### Performance

* **numbers:** loose types ([#109](https://github.com/linrongbin16/commons.nvim/issues/109)) ([0f3806f](https://github.com/linrongbin16/commons.nvim/commit/0f3806f815e177b5ac261da5f4256039bbdf7eaa))

## [3.1.2](https://github.com/linrongbin16/commons.nvim/compare/v3.1.1...v3.1.2) (2023-12-20)


### Bug Fixes

* **termcolors:** fix '\27[m' character in 'erase' ([#107](https://github.com/linrongbin16/commons.nvim/issues/107)) ([125ccb6](https://github.com/linrongbin16/commons.nvim/commit/125ccb61590a07f1462c59c90895b0cc976c7569))

## [3.1.1](https://github.com/linrongbin16/commons.nvim/compare/v3.1.0...v3.1.1) (2023-12-20)


### Miscellaneous

* **termcolors:** add test cases for 'render' ([ad3fb65](https://github.com/linrongbin16/commons.nvim/commit/ad3fb6564d1d5b06415050de97b9bbf10224ecb3))


### Deprecated

* **termcolors:** make 'escape' internal ([#103](https://github.com/linrongbin16/commons.nvim/issues/103)) ([ad3fb65](https://github.com/linrongbin16/commons.nvim/commit/ad3fb6564d1d5b06415050de97b9bbf10224ecb3))

## [3.1.0](https://github.com/linrongbin16/commons.nvim/compare/v3.0.1...v3.1.0) (2023-12-19)


### Features

* **logging:** add low-level API 'log' with 'level' option ([#100](https://github.com/linrongbin16/commons.nvim/issues/100)) ([1942a55](https://github.com/linrongbin16/commons.nvim/commit/1942a55b9b885f5dddf8c026debc73a4afad8e50))

## [3.0.1](https://github.com/linrongbin16/commons.nvim/compare/v3.0.0...v3.0.1) (2023-12-18)


### Miscellaneous

* **logging:** add test cases for 'Logger' ([#98](https://github.com/linrongbin16/commons.nvim/issues/98)) ([38eb222](https://github.com/linrongbin16/commons.nvim/commit/38eb2222a3327d2ecffda1c3a2c5ef633959d141))

## [3.0.0](https://github.com/linrongbin16/commons.nvim/compare/v2.4.2...v3.0.0) (2023-12-18)


### ⚠ BREAKING CHANGES

* **spawn:** rename 'stdout'/'stderr' to 'on_stdout'/'on_stderr' ([#96](https://github.com/linrongbin16/commons.nvim/issues/96))

### Performance

* **spawn:** rename 'stdout'/'stderr' to 'on_stdout'/'on_stderr' ([#96](https://github.com/linrongbin16/commons.nvim/issues/96)) ([a20b9e7](https://github.com/linrongbin16/commons.nvim/commit/a20b9e7c664fe54de4ed07e5e62334a8994475b8))

## [2.4.2](https://github.com/linrongbin16/commons.nvim/compare/v2.4.1...v2.4.2) (2023-12-18)


### Performance

* **termcolors:** export constants 'COLOR_NAMES' for pre-defined colors ([#94](https://github.com/linrongbin16/commons.nvim/issues/94)) ([9b255cc](https://github.com/linrongbin16/commons.nvim/commit/9b255cc69f31c04b372a210a74b6f829e0979ca6))

## [2.4.1](https://github.com/linrongbin16/commons.nvim/compare/v2.4.0...v2.4.1) (2023-12-17)


### Performance

* **logging:** add 'file_log_mode' option to logging 'setup' ([#92](https://github.com/linrongbin16/commons.nvim/issues/92)) ([c0883e0](https://github.com/linrongbin16/commons.nvim/commit/c0883e0dc093b04e4f465800ade2fe9faff394ee))

## [2.4.0](https://github.com/linrongbin16/commons.nvim/compare/v2.3.1...v2.4.0) (2023-12-17)


### Features

* **numbers:** add functional 'max' and 'min' ([#90](https://github.com/linrongbin16/commons.nvim/issues/90)) ([7b1512a](https://github.com/linrongbin16/commons.nvim/commit/7b1512a91eca5053f729ec5f35726a9944e90535))

## [2.3.1](https://github.com/linrongbin16/commons.nvim/compare/v2.3.0...v2.3.1) (2023-12-17)


### Bug Fixes

* **modules:** revert 'bit32ops' [#84](https://github.com/linrongbin16/commons.nvim/issues/84) ([#87](https://github.com/linrongbin16/commons.nvim/issues/87)) ([1a14d31](https://github.com/linrongbin16/commons.nvim/commit/1a14d313e9f0506da3ac33fcc91b7aa464db7480))

## [2.3.0](https://github.com/linrongbin16/commons.nvim/compare/v2.2.0...v2.3.0) (2023-12-17)


### Features

* **module:** add 'bit32ops' ([#84](https://github.com/linrongbin16/commons.nvim/issues/84)) ([d6fced0](https://github.com/linrongbin16/commons.nvim/commit/d6fced057063785da8a89e5709c366afde4d1780))

## [2.2.0](https://github.com/linrongbin16/commons.nvim/compare/v2.1.0...v2.2.0) (2023-12-16)


### Features

* **numbers:** add 'mod' ([#80](https://github.com/linrongbin16/commons.nvim/issues/80)) ([b486672](https://github.com/linrongbin16/commons.nvim/commit/b486672bea84affe9938d4d3faf3dae761ba5204))


### Performance

* **modules:** merge 'buffers' and 'windows' into 'apis' ([b486672](https://github.com/linrongbin16/commons.nvim/commit/b486672bea84affe9938d4d3faf3dae761ba5204))


### Upgrade

* **buffers:** deprecate 'buffers' module ([b486672](https://github.com/linrongbin16/commons.nvim/commit/b486672bea84affe9938d4d3faf3dae761ba5204))
* **windows:** deprecate 'windows' module ([b486672](https://github.com/linrongbin16/commons.nvim/commit/b486672bea84affe9938d4d3faf3dae761ba5204))

## [2.1.0](https://github.com/linrongbin16/commons.nvim/compare/v2.0.1...v2.1.0) (2023-12-15)


### Features

* **paths:** add 'parent' ([#67](https://github.com/linrongbin16/commons.nvim/issues/67)) ([94d900c](https://github.com/linrongbin16/commons.nvim/commit/94d900c11bb78770d68deb6f6c60d8c9fccf60a2))

## [2.0.1](https://github.com/linrongbin16/commons.nvim/compare/v2.0.0...v2.0.1) (2023-12-15)


### Performance Improvements

* **logging:** support file, function and line number format attributes ([#64](https://github.com/linrongbin16/commons.nvim/issues/64)) ([dde8665](https://github.com/linrongbin16/commons.nvim/commit/dde866568379691c4d3524c1c93c2bf979d4b212))

## [2.0.0](https://github.com/linrongbin16/commons.nvim/compare/v1.6.0...v2.0.0) (2023-12-15)


### ⚠ BREAKING CHANGES

* **paths:** normalize by default replace '\\' to '/' ([#51](https://github.com/linrongbin16/commons.nvim/issues/51))
* **logging:** add logging documents ([#57](https://github.com/linrongbin16/commons.nvim/issues/57))
* **logger:** remove legacy 'logger' module ([#57](https://github.com/linrongbin16/commons.nvim/issues/57))
* **logging:** update logging documents ([#59](https://github.com/linrongbin16/commons.nvim/issues/59))
* **logger:** fix potential confliction on global singleton logger instance
* **logging:** new logging system ([#57](https://github.com/linrongbin16/commons.nvim/issues/57))

### Features

* **logging:** new logging system ([#57](https://github.com/linrongbin16/commons.nvim/issues/57)) ([b417cbb](https://github.com/linrongbin16/commons.nvim/commit/b417cbb615c3286df32f0d28a6f3ba081b2e5533))


### Bug Fixes

* **logger:** fix potential confliction on global singleton logger instance ([b417cbb](https://github.com/linrongbin16/commons.nvim/commit/b417cbb615c3286df32f0d28a6f3ba081b2e5533))
* **paths:** normalize by default replace '\\' to '/' ([#51](https://github.com/linrongbin16/commons.nvim/issues/51)) ([d7e21ed](https://github.com/linrongbin16/commons.nvim/commit/d7e21edb868b30567d62144f87f5144353a8bccf))


### Documentation

* **logger:** remove legacy 'logger' module ([#57](https://github.com/linrongbin16/commons.nvim/issues/57)) ([d7e21ed](https://github.com/linrongbin16/commons.nvim/commit/d7e21edb868b30567d62144f87f5144353a8bccf))
* **logging:** add logging documents ([#57](https://github.com/linrongbin16/commons.nvim/issues/57)) ([d7e21ed](https://github.com/linrongbin16/commons.nvim/commit/d7e21edb868b30567d62144f87f5144353a8bccf))
* **logging:** update logging documents ([#59](https://github.com/linrongbin16/commons.nvim/issues/59)) ([d7e21ed](https://github.com/linrongbin16/commons.nvim/commit/d7e21edb868b30567d62144f87f5144353a8bccf))

## [1.6.0](https://github.com/linrongbin16/commons.nvim/compare/v1.5.2...v1.6.0) (2023-12-14)


### Features

* **logger:** add 'logger' module ([#52](https://github.com/linrongbin16/commons.nvim/issues/52)) ([c63d2c3](https://github.com/linrongbin16/commons.nvim/commit/c63d2c364025b9b2b72aec0bd1c673964523c388))

## [1.5.2](https://github.com/linrongbin16/commons.nvim/compare/v1.5.1...v1.5.2) (2023-12-14)


### Bug Fixes

* **types:** fix typecheck in 'jsons' ([#49](https://github.com/linrongbin16/commons.nvim/issues/49)) ([e0b418b](https://github.com/linrongbin16/commons.nvim/commit/e0b418bbf4a578438a4bd4d7d9972b0f7c616fb5))
* **types:** fix typecheck in 'spawn' ([#49](https://github.com/linrongbin16/commons.nvim/issues/49)) ([e0b418b](https://github.com/linrongbin16/commons.nvim/commit/e0b418bbf4a578438a4bd4d7d9972b0f7c616fb5))

## [1.5.1](https://github.com/linrongbin16/commons.nvim/compare/v1.5.0...v1.5.1) (2023-12-14)


### Performance Improvements

* **docs:** use github pages for documentation ([#44](https://github.com/linrongbin16/commons.nvim/issues/44)) ([0d940fc](https://github.com/linrongbin16/commons.nvim/commit/0d940fc3bcb0e3cd052f94576acc5a94513aa03b))

## [1.5.0](https://github.com/linrongbin16/commons.nvim/compare/v1.4.3...v1.5.0) (2023-12-13)


### Features

* **lib:** add 'tables' ([#31](https://github.com/linrongbin16/commons.nvim/issues/31)) ([efb7fda](https://github.com/linrongbin16/commons.nvim/commit/efb7fdaed21665e42bb524d51f6277c9949400ba))


### Performance Improvements

* **test:** add v0.7.0 Neovim version for unit test matrix ([efb7fda](https://github.com/linrongbin16/commons.nvim/commit/efb7fdaed21665e42bb524d51f6277c9949400ba))

## [1.4.3](https://github.com/linrongbin16/commons.nvim/compare/v1.4.2...v1.4.3) (2023-12-12)


### Bug Fixes

* **annotations:** fix typecheck for _system.lua ([#28](https://github.com/linrongbin16/commons.nvim/issues/28)) ([3aeff32](https://github.com/linrongbin16/commons.nvim/commit/3aeff32b89428a8cef0b0a772de3c9a09a681bc4))

## [1.4.2](https://github.com/linrongbin16/commons.nvim/compare/v1.4.1...v1.4.2) (2023-12-12)


### Bug Fixes

* **lib:** compatible API signature in spawn ([#25](https://github.com/linrongbin16/commons.nvim/issues/25)) ([4e59da0](https://github.com/linrongbin16/commons.nvim/commit/4e59da088ccc2a2be043e503ae6dd58800b022c3))

## [1.4.1](https://github.com/linrongbin16/commons.nvim/compare/v1.4.0...v1.4.1) (2023-12-12)


### Performance Improvements

* **lib:** add ignorecase opts to 'startswith'/'endswith' in strings ([#23](https://github.com/linrongbin16/commons.nvim/issues/23)) ([de9af2e](https://github.com/linrongbin16/commons.nvim/commit/de9af2e07646554bcb49f9f2d868e789a6ce0070))

## [1.4.0](https://github.com/linrongbin16/commons.nvim/compare/v1.3.0...v1.4.0) (2023-12-12)


### Features

* **lib:** add 'paths' ([#21](https://github.com/linrongbin16/commons.nvim/issues/21)) ([b1c0a46](https://github.com/linrongbin16/commons.nvim/commit/b1c0a46dc9787f61c6700a26c535ef74e4a9f7e2))
* **lib:** add 'spawn' ([#21](https://github.com/linrongbin16/commons.nvim/issues/21)) ([b1c0a46](https://github.com/linrongbin16/commons.nvim/commit/b1c0a46dc9787f61c6700a26c535ef74e4a9f7e2))

## [1.3.0](https://github.com/linrongbin16/commons.nvim/compare/v1.2.1...v1.3.0) (2023-12-12)


### Features

* **lib:** add 'buf_options' ([#18](https://github.com/linrongbin16/commons.nvim/issues/18)) ([2124d6e](https://github.com/linrongbin16/commons.nvim/commit/2124d6e659cce4171d8d994cf047c26164e86627))
* **lib:** add 'ringbuf' ([#18](https://github.com/linrongbin16/commons.nvim/issues/18)) ([2124d6e](https://github.com/linrongbin16/commons.nvim/commit/2124d6e659cce4171d8d994cf047c26164e86627))
* **lib:** add 'win_options' ([#18](https://github.com/linrongbin16/commons.nvim/issues/18)) ([2124d6e](https://github.com/linrongbin16/commons.nvim/commit/2124d6e659cce4171d8d994cf047c26164e86627))


### Bug Fixes

* **lib:** rename 'buf_options' to 'buffers' ([#20](https://github.com/linrongbin16/commons.nvim/issues/20)) ([11d0d4d](https://github.com/linrongbin16/commons.nvim/commit/11d0d4d1b525457f761aef775ef1249d4e4b6186))
* **lib:** rename 'win_options' to 'windows' ([#20](https://github.com/linrongbin16/commons.nvim/issues/20)) ([11d0d4d](https://github.com/linrongbin16/commons.nvim/commit/11d0d4d1b525457f761aef775ef1249d4e4b6186))

## [1.2.1](https://github.com/linrongbin16/commons.nvim/compare/v1.2.0...v1.2.1) (2023-12-12)


### Performance Improvements

* **test:** improve assert utils for unit test ([#16](https://github.com/linrongbin16/commons.nvim/issues/16)) ([766e4c6](https://github.com/linrongbin16/commons.nvim/commit/766e4c62431527dfc2b297c85add20e952a58e16))
* **test:** improve test cases for 'strings' lib ([#16](https://github.com/linrongbin16/commons.nvim/issues/16)) ([766e4c6](https://github.com/linrongbin16/commons.nvim/commit/766e4c62431527dfc2b297c85add20e952a58e16))

## [1.2.0](https://github.com/linrongbin16/commons.nvim/compare/v1.1.0...v1.2.0) (2023-12-12)


### Features

* **lib:** add `commons.numbers` ([#14](https://github.com/linrongbin16/commons.nvim/issues/14)) ([fbee2ac](https://github.com/linrongbin16/commons.nvim/commit/fbee2ac45adab72b3cbc1ffaec0b28e6d3ce5dc7))
* **lib:** add `commons.uv` ([#11](https://github.com/linrongbin16/commons.nvim/issues/11)) ([fbee2ac](https://github.com/linrongbin16/commons.nvim/commit/fbee2ac45adab72b3cbc1ffaec0b28e6d3ce5dc7))

## [1.1.0](https://github.com/linrongbin16/commons.nvim/compare/v1.0.1...v1.1.0) (2023-12-12)


### Features

* **lib:** add `fileios` ([#11](https://github.com/linrongbin16/commons.nvim/issues/11)) ([45f049f](https://github.com/linrongbin16/commons.nvim/commit/45f049f347c3f9a2cb7824db1bc096f61c4a0078))

## [1.0.1](https://github.com/linrongbin16/commons.nvim/compare/v1.0.0...v1.0.1) (2023-12-12)


### Bug Fixes

* **docs:** fix embed install github actions ([#9](https://github.com/linrongbin16/commons.nvim/issues/9)) ([e69551a](https://github.com/linrongbin16/commons.nvim/commit/e69551a9b11b81c0d0365a5d48022faed11261a2))
* **lib:** fix json require path ([e69551a](https://github.com/linrongbin16/commons.nvim/commit/e69551a9b11b81c0d0365a5d48022faed11261a2))


### Performance Improvements

* **embed:** remove environment variable ([#7](https://github.com/linrongbin16/commons.nvim/issues/7)) ([1e42aa3](https://github.com/linrongbin16/commons.nvim/commit/1e42aa3d74f898f258e30a3a50a4b6f35d4fc416))

## 1.0.0 (2023-12-12)


### Features

* **libs:** add `jsons` ([#1](https://github.com/linrongbin16/commons.nvim/issues/1)) ([bb3ee6c](https://github.com/linrongbin16/commons.nvim/commit/bb3ee6cdca47511e53a4a8a9421f172d3ae47f91))
* **libs:** add `strings` ([#1](https://github.com/linrongbin16/commons.nvim/issues/1)) ([bb3ee6c](https://github.com/linrongbin16/commons.nvim/commit/bb3ee6cdca47511e53a4a8a9421f172d3ae47f91))
* **libs:** add `termcolors` ([#1](https://github.com/linrongbin16/commons.nvim/issues/1)) ([bb3ee6c](https://github.com/linrongbin16/commons.nvim/commit/bb3ee6cdca47511e53a4a8a9421f172d3ae47f91))


### Bug Fixes

* **lib:** rename 'ishex' to 'isxdigit' in strings lib ([b296dc8](https://github.com/linrongbin16/commons.nvim/commit/b296dc8bba3432ae60ec06ba684529bb56a8673c))
