# Changelog

## [10.2.2](https://github.com/linrongbin16/commons.nvim/compare/v10.2.1...v10.2.2) (2024-03-01)


### Bug Fixes

* **paths:** fix 'normalize' path on Windows ([#216](https://github.com/linrongbin16/commons.nvim/issues/216)) ([610eb58](https://github.com/linrongbin16/commons.nvim/commit/610eb581a13677d41044f308b6736e688f7bed71))


### Miscellaneous

* **paths:** fix windows 'normalize' test ([#216](https://github.com/linrongbin16/commons.nvim/issues/216)) ([610eb58](https://github.com/linrongbin16/commons.nvim/commit/610eb581a13677d41044f308b6736e688f7bed71))

## [10.2.1](https://github.com/linrongbin16/commons.nvim/compare/v10.2.0...v10.2.1) (2024-03-01)


### Continuously Integration

* **lint:** suppress luals warnings/errors ([#213](https://github.com/linrongbin16/commons.nvim/issues/213)) ([b8a7cd9](https://github.com/linrongbin16/commons.nvim/commit/b8a7cd98265af6bc76cf12fac0cc3da3af7de781))
* **release:** add 'ci' release type ([#214](https://github.com/linrongbin16/commons.nvim/issues/214)) ([fadccd1](https://github.com/linrongbin16/commons.nvim/commit/fadccd1df9a5f977adf5b6909fbcd41aed589a89))

## [10.2.0](https://github.com/linrongbin16/commons.nvim/compare/v10.1.0...v10.2.0) (2024-02-29)


### Features

* **msgpack:** add 'msgpack' ([#210](https://github.com/linrongbin16/commons.nvim/issues/210)) ([e9dc2dc](https://github.com/linrongbin16/commons.nvim/commit/e9dc2dcd9dca3aacc7278c246fa04155282dc99e))

## [10.1.0](https://github.com/linrongbin16/commons.nvim/compare/v10.0.0...v10.1.0) (2024-02-18)


### Features

* **numbers:** approximate float number compare ([#207](https://github.com/linrongbin16/commons.nvim/issues/207)) ([0d0b4f9](https://github.com/linrongbin16/commons.nvim/commit/0d0b4f9aac54a4c21e3072071691849a2d9b0598))

## [10.0.0](https://github.com/linrongbin16/commons.nvim/compare/v9.1.0...v10.0.0) (2024-02-13)


### ⚠ BREAKING CHANGES

* **tables:** rename 'List:wrap' to 'List:move'! ([#204](https://github.com/linrongbin16/commons.nvim/issues/204))
* **fileios:** return `nil` if failed to read lines for `readlines`! ([#204](https://github.com/linrongbin16/commons.nvim/issues/204))

### Features

* **fileios:** add 'CachedFileReader' ([#206](https://github.com/linrongbin16/commons.nvim/issues/206)) ([1965799](https://github.com/linrongbin16/commons.nvim/commit/19657995da7d8e7600e5c564088277c33f4d588c))
* **tables:** add 'HashMap' ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))


### Bug Fixes

* **fileios:** return `nil` if failed to read lines for `readlines`! ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))


### Performance

* **numbers:** remove 'random' fallback ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))


### Miscellaneous

* **fileios:** improve test cases ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))
* **jsons:** improve test cases ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))
* **numbers:** improve test cases ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))
* **tables:** rename 'List:wrap' to 'List:move'! ([#204](https://github.com/linrongbin16/commons.nvim/issues/204)) ([90a8837](https://github.com/linrongbin16/commons.nvim/commit/90a88371b8e43287d4f2efe6c8380c657ebbab73))

## [9.1.0](https://github.com/linrongbin16/commons.nvim/compare/v9.0.1...v9.1.0) (2024-02-12)


### Features

* **tables:** add 'List' ([#202](https://github.com/linrongbin16/commons.nvim/issues/202)) ([25d03c3](https://github.com/linrongbin16/commons.nvim/commit/25d03c38562085a17e2b127fe8ead050543ea993))

## [9.0.1](https://github.com/linrongbin16/commons.nvim/compare/v9.0.0...v9.0.1) (2024-02-05)


### Bug Fixes

* **tables:** use 'type' in 'tbl_get' ([#199](https://github.com/linrongbin16/commons.nvim/issues/199)) ([805dce9](https://github.com/linrongbin16/commons.nvim/commit/805dce9702f546276ac62637b3ded1154156f1c2))

## [9.0.0](https://github.com/linrongbin16/commons.nvim/compare/v8.4.0...v9.0.0) (2024-02-05)


### ⚠ BREAKING CHANGES

* **colors.term:** rename 'termcolors' to 'colors.term'! ([#195](https://github.com/linrongbin16/commons.nvim/issues/195))

### Features

* **colors.hl:** add 'colors.hl' module ([#195](https://github.com/linrongbin16/commons.nvim/issues/195)) ([19994dc](https://github.com/linrongbin16/commons.nvim/commit/19994dccb13e0f5429b8789d53fa535c87e1f795))
* **colors.term:** rename 'termcolors' to 'colors.term'! ([#195](https://github.com/linrongbin16/commons.nvim/issues/195)) ([19994dc](https://github.com/linrongbin16/commons.nvim/commit/19994dccb13e0f5429b8789d53fa535c87e1f795))


### Bug Fixes

* **apis:** fix 'get_hl' for lower versions ([#195](https://github.com/linrongbin16/commons.nvim/issues/195)) ([19994dc](https://github.com/linrongbin16/commons.nvim/commit/19994dccb13e0f5429b8789d53fa535c87e1f795))

## [8.4.0](https://github.com/linrongbin16/commons.nvim/compare/v8.3.0...v8.4.0) (2024-02-04)


### Features

* **apis:** add 'get_hl_with_fallback' api ([#192](https://github.com/linrongbin16/commons.nvim/issues/192)) ([126d92a](https://github.com/linrongbin16/commons.nvim/commit/126d92a6d07f672059e83df31abb1e36f92002e1))


### Bug Fixes

* **apis:** fix 'get_hl_with_fallback' for lower-versions ([#193](https://github.com/linrongbin16/commons.nvim/issues/193)) ([f1d65ec](https://github.com/linrongbin16/commons.nvim/commit/f1d65ec7325e3bcac204086bdd6b03b654b1f6b0))

## [8.3.0](https://github.com/linrongbin16/commons.nvim/compare/v8.2.0...v8.3.0) (2024-02-01)


### Features

* **platforms:** add 'platforms' module ([#190](https://github.com/linrongbin16/commons.nvim/issues/190)) ([4c6b9d4](https://github.com/linrongbin16/commons.nvim/commit/4c6b9d4b67eb3dafaced41601b12635065456e1e))

## [8.2.0](https://github.com/linrongbin16/commons.nvim/compare/v8.1.0...v8.2.0) (2024-01-29)


### Features

* **strings:** add 'replace' api ([#188](https://github.com/linrongbin16/commons.nvim/issues/188)) ([f234654](https://github.com/linrongbin16/commons.nvim/commit/f234654f96ccd933cda01bade1add182c0a6206e))

## [8.1.0](https://github.com/linrongbin16/commons.nvim/compare/v8.0.0...v8.1.0) (2024-01-25)


### Features

* **fileios:** add 'asyncreadlines' api ([#186](https://github.com/linrongbin16/commons.nvim/issues/186)) ([2bffe4f](https://github.com/linrongbin16/commons.nvim/commit/2bffe4fe8b5be402b3a5c6acd85e8ab951ac3286))

## [8.0.0](https://github.com/linrongbin16/commons.nvim/compare/v7.0.2...v8.0.0) (2024-01-22)


### ⚠ BREAKING CHANGES

* **termcolors:** remove 'retrieve' api ([#184](https://github.com/linrongbin16/commons.nvim/issues/184))

### Deprecated

* **termcolors:** remove 'retrieve' api ([#184](https://github.com/linrongbin16/commons.nvim/issues/184)) ([2982d51](https://github.com/linrongbin16/commons.nvim/commit/2982d514a03cb1f5b6663955d9f6c31bfb0c47d6))

## [7.0.2](https://github.com/linrongbin16/commons.nvim/compare/v7.0.1...v7.0.2) (2024-01-22)


### Bug Fixes

* **apis:** fix return value compatible in 'get_hl' for lower version ([#182](https://github.com/linrongbin16/commons.nvim/issues/182)) ([3fc1abf](https://github.com/linrongbin16/commons.nvim/commit/3fc1abf059b77a89abdd9d795af49507b58c7616))

## [7.0.1](https://github.com/linrongbin16/commons.nvim/compare/v7.0.0...v7.0.1) (2024-01-20)


### Bug Fixes

* **apis:** keep compatible returned value for 'get_hl' in lower versions ([#180](https://github.com/linrongbin16/commons.nvim/issues/180)) ([bb746a3](https://github.com/linrongbin16/commons.nvim/commit/bb746a3353743238821a9f0d14b097ef4c6f974e))

## [7.0.0](https://github.com/linrongbin16/commons.nvim/compare/v6.2.0...v7.0.0) (2024-01-18)


### ⚠ BREAKING CHANGES

* **termcolors:** returns all 4 color codes in 'retrieve' api ([#178](https://github.com/linrongbin16/commons.nvim/issues/178))

### Features

* **apis:** add 'get_hl' api ([#178](https://github.com/linrongbin16/commons.nvim/issues/178)) ([898a2fb](https://github.com/linrongbin16/commons.nvim/commit/898a2fb66e18539bb855676a9da3d0f7338aaef9))


### Performance

* **termcolors:** returns all 4 color codes in 'retrieve' api ([#178](https://github.com/linrongbin16/commons.nvim/issues/178)) ([898a2fb](https://github.com/linrongbin16/commons.nvim/commit/898a2fb66e18539bb855676a9da3d0f7338aaef9))

## [6.2.0](https://github.com/linrongbin16/commons.nvim/compare/v6.1.1...v6.2.0) (2024-01-18)


### Features

* **versions:** add 'versions' module ([#176](https://github.com/linrongbin16/commons.nvim/issues/176)) ([e7b3293](https://github.com/linrongbin16/commons.nvim/commit/e7b3293a58f7de1151e5d475e52244f3e84d4bd4))

## [6.1.1](https://github.com/linrongbin16/commons.nvim/compare/v6.1.0...v6.1.1) (2024-01-15)


### Miscellaneous

* **test:** rename 'test' to 'spec' ([#174](https://github.com/linrongbin16/commons.nvim/issues/174)) ([4aefbcb](https://github.com/linrongbin16/commons.nvim/commit/4aefbcb8023d12f7a6a10d4b342d3f1a3f8d5756))

## [6.1.0](https://github.com/linrongbin16/commons.nvim/compare/v6.0.0...v6.1.0) (2024-01-14)


### Features

* **micro-async:** add 'micro-async' back ([#172](https://github.com/linrongbin16/commons.nvim/issues/172)) ([a3d4fad](https://github.com/linrongbin16/commons.nvim/commit/a3d4fad3457f5113b516ea91dd03ff1d7558a82a))

## [6.0.0](https://github.com/linrongbin16/commons.nvim/compare/v5.1.0...v6.0.0) (2024-01-14)


### ⚠ BREAKING CHANGES

* **micro-async:** remove 'micro-async' module ([#170](https://github.com/linrongbin16/commons.nvim/issues/170))

### Performance

* **apis:** use 'vim.version' for 0.9+ ([#170](https://github.com/linrongbin16/commons.nvim/issues/170)) ([bda1658](https://github.com/linrongbin16/commons.nvim/commit/bda16583c2cefdd1a6b53bcb5922c684e7c89ddb))
* **micro-async:** remove 'micro-async' module ([#170](https://github.com/linrongbin16/commons.nvim/issues/170)) ([bda1658](https://github.com/linrongbin16/commons.nvim/commit/bda16583c2cefdd1a6b53bcb5922c684e7c89ddb))

## [5.1.0](https://github.com/linrongbin16/commons.nvim/compare/v5.0.0...v5.1.0) (2024-01-10)


### Features

* **micro-async:** add 'micro-async' module ([#168](https://github.com/linrongbin16/commons.nvim/issues/168)) ([a7621a6](https://github.com/linrongbin16/commons.nvim/commit/a7621a66a546a5c4167dd4745e451e58d92eb71e))

## [5.0.0](https://github.com/linrongbin16/commons.nvim/compare/v4.0.0...v5.0.0) (2024-01-04)


### ⚠ BREAKING CHANGES

* **buffers:** remove deprecated 'buffers' module! ([#164](https://github.com/linrongbin16/commons.nvim/issues/164))
* **windows:** remove deprecated 'windows' module! ([#164](https://github.com/linrongbin16/commons.nvim/issues/164))

### Features

* **promise:** add 'notomo/promise.nvim' as 'promise' module ([#164](https://github.com/linrongbin16/commons.nvim/issues/164)) ([753423b](https://github.com/linrongbin16/commons.nvim/commit/753423be244310b34a9d70e5930b32ac9ffa7164))


### Break Changes

* **buffers:** remove deprecated 'buffers' module! ([#164](https://github.com/linrongbin16/commons.nvim/issues/164)) ([753423b](https://github.com/linrongbin16/commons.nvim/commit/753423be244310b34a9d70e5930b32ac9ffa7164))
* **windows:** remove deprecated 'windows' module! ([#164](https://github.com/linrongbin16/commons.nvim/issues/164)) ([753423b](https://github.com/linrongbin16/commons.nvim/commit/753423be244310b34a9d70e5930b32ac9ffa7164))

## [4.0.0](https://github.com/linrongbin16/commons.nvim/compare/v3.7.3...v4.0.0) (2024-01-04)


### ⚠ BREAKING CHANGES

* **async:** use 'lewis6991/async.nvim' as 'async' module! ([#162](https://github.com/linrongbin16/commons.nvim/issues/162))

### Features

* **async:** use 'lewis6991/async.nvim' as 'async' module! ([#162](https://github.com/linrongbin16/commons.nvim/issues/162)) ([429e19d](https://github.com/linrongbin16/commons.nvim/commit/429e19d5ee90f8fd46e736a7dded1f3bcb455153))

## [3.7.3](https://github.com/linrongbin16/commons.nvim/compare/v3.7.2...v3.7.3) (2024-01-03)


### Performance

* **uv:** drop off 'vim.fn.has' ([#159](https://github.com/linrongbin16/commons.nvim/issues/159)) ([946956a](https://github.com/linrongbin16/commons.nvim/commit/946956a6706d6017c3ac56fca6843a04a9148587))

## [3.7.2](https://github.com/linrongbin16/commons.nvim/compare/v3.7.1...v3.7.2) (2024-01-03)


### Miscellaneous

* **ci:** add ci for windows unit test ([#148](https://github.com/linrongbin16/commons.nvim/issues/148)) ([641f328](https://github.com/linrongbin16/commons.nvim/commit/641f3285c59c4a797bab759ba480d0e8e610b727))

## [3.7.1](https://github.com/linrongbin16/commons.nvim/compare/v3.7.0...v3.7.1) (2024-01-03)


### Performance

* **spawn:** avoid 'vim.fn.has' in 'run' API ([#155](https://github.com/linrongbin16/commons.nvim/issues/155)) ([ddb65d4](https://github.com/linrongbin16/commons.nvim/commit/ddb65d4f507f1c42daf71d658e60a1d6f73c31d5))

## [3.7.0](https://github.com/linrongbin16/commons.nvim/compare/v3.6.2...v3.7.0) (2024-01-03)


### Features

* **async:** embed 'ms-jpq/lua-async-await' as 'async' module ([#153](https://github.com/linrongbin16/commons.nvim/issues/153)) ([ee61ef7](https://github.com/linrongbin16/commons.nvim/commit/ee61ef7204aa619a71a9ad20c3b04d79a739f980))

## [3.6.2](https://github.com/linrongbin16/commons.nvim/compare/v3.6.1...v3.6.2) (2024-01-02)


### Miscellaneous

* **strings:** add cases for 'ltrim'/'rtrim' ([#151](https://github.com/linrongbin16/commons.nvim/issues/151)) ([8a3f5c3](https://github.com/linrongbin16/commons.nvim/commit/8a3f5c3737eef9a830b7e4c15f5ac8e364f267ff))

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
