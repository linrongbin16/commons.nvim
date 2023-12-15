<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 -->

# [commons.logger](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/logger.lua)

Logging system with [python-logging](https://docs.python.org/3/howto/logging.html) like features.

!> **Note:** This module requires initialize before writing logs.

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

-- First get logger by name, then write logs
logging.get("your_logging"):debug("This is the first debugging message")
logging.get("your_logging"):info(
  "This is the first info with global logger: %s",
  vim.inspect(logging.get("your_logging"))
)
```

The `setup` function will create a logger instance named `your_logging` and register into the logging system.

!> **Note:** Each time you write a logging message, you need to get the logger by logger name `your_logging`.

### Root Logger

The logger named `root` by default is the global singleton logger instance.

Once you initialize the logging system with the name `root`, you can easily use the global logging APIs without get the logger:

```lua
local logging = require("commons.logging")
logging.setup({
  name = "root", -- here we create the `root` logger instance
  console_log = true,
  file_log = true,
  file_log_name = "root.log",
})

-- Directly use logging APIs, without get logger by name
logging.debug("This is the first debugging message")
logging.info(
  "This is the first info with global logger: %s",
  vim.inspect(logging.get())
)
```

The global logging APIs are equivalent to:

```lua
local root_logger = logging.get("root")
root_logger:debug(...)
root_logger:info(...)
```

!> **Note:** This would bring potential conflictions between multiple Neovim plugins if they all use the same root logger in same lua package namespace. See [Isolated Logger Instance](#isolated-logger-instance).

### Isolated Logger Instance

When installing the commons library with Neovim plugin manager or LuaRocks (see [Install](/install.md)), the commons library use the lua package namespace `commons` (e.g. the `require("commons")`), this would bring potential risks that multiple Neovim plugins share the same logging system, and further have conflictions on the global root logger instance if they all use the global logging APIs, in the same Neovim editor instance.

To avoid such issue, Neovim plugin will have to create isolated logger instance for itself:

```lua
local paths = require("commons.paths")
local logging = require("commons.logging")

-- Create logging handlers: ConsoleHandler (nvim's command line) and FileHandler.
local console_handler = logging.ConsoleHandler:new()
local file_handler = logging.FileHandler:new(
  string.format(
    "%s%s%s",
    vim.fn.stdpath("data"),
    paths.SEPARATOR,
    "your_plugin.log"
  )
)

-- Create logger instance.
local logger = logging.Logger:new("your_plugin", logging.LogLevels.DEBUG)
logger:add_handler(console_handler)
logger:add_handler(file_handler)

-- Add instance into logging system.
logging.add(logger)

-- Invoke logging API on specified logger instance.
local logger2 = logging.get("your_plugin")
logger2:debug("This is the first debugging message for your plugin")
logger2:warn(
  "This is the first warning message for your plugin with your logger: %s",
  vim.inspect(logger2)
)
```

!> **Note:** The logger name for your plugin must be unique, and must not be `root`!

### Customization

The logging system support python-logging like features, that allow you customize the logger with:

- `Logger`: Top-level API class, you can bind multiple handlers on a single logger.
- `Handler`: Different logging devices, each handler will have its own logging formatter.

  - `ConsoleHandler`: Write logs as nvim's messages.

    !> **Note:** The console handler will only print logs with logging level &ge; `INFO`, to avoid the interference of too noisy debugging messages to user.

  - `FileHandler`: Write logs to file.

- `Formatter`: Logging formatter that actually responsible for final logging record rendering.

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

    !> **Note:** The console handler will only print logs with `level >= LogLevels.INFO`, to avoid the interference of too noisy debugging messages to user.

  - `file_log`: Whether enable file log, by default is `false`.
  - `file_log_name`: File log name, working with `file_log`, **mandatory** when setting `file_log = true`.
  - `file_log_dir`: File log directory, working with `file_log`, **mandatory** when setting `file_log = true`. By default is `vim.fn.stdpath("data")`.

### `debug`/`info`/`warn`/`err`

Write logging message with below levels:

- `LogLevels.DEBUG`
- `LogLevels.INFO`
- `LogLevels.WARN`
- `LogLevels.ERROR`

```lua
function debug(fmt:string, ...:any):nil
function info(fmt:string, ...:any):nil
function warn(fmt:string, ...:any):nil
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

### `add`

Add the logger into logging system.

```lua
function add(logger:commons.logging.Logger):nil
```

Parameters:

- `logger`: The logger instance.

## Classes

### `Logger`

The logger class.
