<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.logger](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/logger.lua)

Logging system with [python-logging](https://docs.python.org/3/howto/logging.html) like features.

!> **Note:** This module requires initialize before write logging messages.

## Introduction

### Setup

You can easily initialize the logging system via the `setup` function, for example:

```lua
local logging = require("commons.logging")
logging.setup({
  name = "your_logging",
  console_log = true,
  file_log = true,
  file_log_name = "your_logging.log",
})
logging.get("your_logging"):debug("This is the first debugging message")
logging.get("your_logging"):info(
  "This is the first info with global logger: %s",
  vim.inspect(logging.get("your_logging"))
)
```

The `setup` function will create a logger instance named `your_logging` and add it into the logging system.

Each time you write a logging message, you need to get the logger via `logging.get` API with the logger name `your_logging`.

### Root Logger

The logger named `root` by default is the global singleton logger instance.

Once you initialize the logging system with the name `root`, you can easily writing messages without the `get` API:

```lua
local logging = require("commons.logging")
logging.setup({
  name = "root", -- here we create the `root` logger instance
  console_log = true,
  file_log = true,
  file_log_name = "root.log",
})
logging.debug("This is the first debugging message")
logging.info(
  "This is the first info with global logger: %s",
  vim.inspect(logging.get())
)
```

The `logging.debug`, `logging.info` and other logging APIs are equivalent to:

```lua
local root_logger = logging.get("root")
root_logger:debug(...)
root_logger:info(...)
...
```

### Plugin (Isolated) Mode

When developing a Neovim plugin, you will need to use a isolated memory space to separate the unique logger to avoid potentially confliction from other logger instancse in the same Neovim editor instance.

To create a unique/separated logger, please use:

```lua
local paths = require("commons.paths")
local logging = require("commons.logging")

-- create two handlers
local console_handler = logging.ConsoleHandler:new()
local file_handler = logging.FileHandler:new(
  string.format(
    "%s%s%s",
    vim.fn.stdpath("data"),
    paths.SEPARATOR,
    "your_plugin.log"
  )
)

-- create logger
local logger = logging.Logger:new("your_plugin", logging.LogLevels.DEBUG)
logger:add_handler(console_handler)
logger:add_handler(file_handler)

-- add logger into logging system
logging.add(logger)

-- invoke logging API in another place
local logger2 = logging.get("your_plugin")
logger2:debug("This is the first debugging message for your plugin")
logger2:warn(
  "This is the first warning message for your plugin with your logger: %s",
  vim.inspect(logger2)
)
```

!> **Note:** The logger name for your plugin must be unique, and must not be `root`!

### Customization

The logging system support partial python-logging features, which allow you customize the logger:

- `Logger`: Top-level API class for user to write logging messages.
- `Handler`: Different type of logging devices.
  - `ConsoleHandler`: Write logging messages to Neovim's command line.
  - `FileHandler`: Write logging messages to file.
- `Formatter`: Customize final logging message formats.

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
--- @enum commons.LogLevelNames
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

Initialize global singleton logger instance.

```lua
--- @alias commons.LoggingConfigs {name:string,level:(commons.LogLevels|string)?,console_log:boolean?,file_log:boolean?,file_log_name:string?,file_log_dir:string?}

function setup(opts:commons.LoggingConfigs):nil
```

Parameters:

- `opts`: Config options.

  - `name`: Logger name, **mandatory** field.
  - `level`: Log level, by default is `LogLevels.INFO`.
  - `console_log`: Whether enable console (message) log, by default is `true`.

    !> **Note:** The debug messages (logging level &lt; `LogLevels.INFO`) will be filtered, e.g. not print to the nvim's command line.

  - `file_log`: Whether enable file log, by default is `false`.
  - `file_log_name`: File log name, working with `file_log`, **mandatory** when setting `file_log = true`.
  - `file_log_dir`: File log directory, working with `file_log`, **mandatory** when setting `file_log = true`. By default is `vim.fn.stdpath("data")`.

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

### `has`

Whether has logger instance.

```lua
function has(name:string):boolean
```

Parameters:

- `name`: Logger name.

Returns:

- Returns whether logging system has the logger instance.

### `get`

Get logger instance.

```lua
function get(name:string):commons.logging.Logger?
```

Parameters:

- `name`: Logger name.

Returns:

- If the logger exist, returns the logger instance.
- If the logger not found, returns `nil`.
