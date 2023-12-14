<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.logger](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/logger.lua)

Logger with variadic parameters support.

!> **Note:** This module requires initialize via `setup` before invoke other APIs, except the [echo](#echo) API.

## Constants

### `LogLevels`

Log levels.

```lua
--- @enum commons.LogLevels
local LogLevels = {
  TRACE = 0,
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  OFF = 5,
}
```

### `LogLevelNames`

Log level names.

```lua
local LogLevelNames = {
  [0] = "TRACE",
  [1] = "DEBUG",
  [2] = "INFO",
  [3] = "WARN",
  [4] = "ERROR",
  [5] = "OFF",
}
```

## Functions

### `setup`

Initialize logger module.

```lua
--- @alias commons.LoggerConfigs {name:string,level:commons.LogLevels?,console_log:boolean?,file_log:boolean?,file_log_name:string?,file_log_dir:string?}

function setup(opts:commons.LoggerConfigs):nil
```

Parameters:

- `opts`: Config options.

  - `name`: Logger name, **mandatory** field.
  - `level`: Log level, by default is `LogLevels.INFO`.
  - `console_log`: Whether enable console (message) log, by default is `true`.

    !> **Note:** The debug messages (logging level &le; `LogLevels.DEBUG`) will be filtered, e.g. not print to the nvim's command line.

  - `file_log`: Whether enable file log, by default is `false`.
  - `file_log_name`: File log name, working with `file_log`, **mandatory** when setting `file_log = true`.
  - `file_log_dir`: File log directory, working with `file_log`, **mandatory** when setting `file_log = true`. By default is `vim.fn.stdpath("data")`.

Examples:

```lua
local logger = require("commons.logger")
local LogLevels = require("commons.logger").LogLevels

logger.setup({
  name = "[gitlinker]",
  level = LogLevels.DEBUG,
  file_log = true,
  file_log_name = "gitlinker.log",
})

logger.debug("This is the first debugging message on %s", vim.inspect(logger.debug))
```

### `echo`

Echo message to nvim's command line, formatting variadic parameters with `string.format`.

?> **Note:** This API doesn't require logger module initialization.

```lua
function echo(level:commons.LogLevels, fmt:string, ...:any):nil
```

Parameters:

- `level`: Log level.
- `fmt`: Message formatter.
- `...`: Variadic parameters, working with `fmt`.

### `debug`

Write logging message in debug (`LogLevels.DEBUG`) level.

```lua
function debug(fmt:string, ...:any):nil
```

### `info`

Write logging message in info (`LogLevels.INFO`) level.

```lua
function info(fmt:string, ...:any):nil
```

### `warn`

Write logging message in warning (`LogLevels.WARN`) level.

```lua
function warn(fmt:string, ...:any):nil
```

### `err`

Write logging message in error (`LogLevels.ERROR`) level.

```lua
function err(fmt:string, ...:any):nil
```

### `throw`

Write error logs and throw the error.

```lua
function throw(fmt:string, ...:any):nil
```

### `ensure`

Write error logs and throw the error only when condition not met.

Work in the same way with lua [assert](https://www.lua.org/pil/8.3.html), with logging support.

```lua
function ensure(cond:boolean, fmt:string, ...:any):nil
```

Parameters

- `cond`: The condition, error message will only be logged and thrown when `cond` is `false`.
- `fmt`: Message formatter.
- `...`: Variadic parameters, working with `fmt`.
