# Changelog

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
