<!-- markdownlint-disable MD001 MD013 MD034 MD033 MD051 MD024 -->

# [commons.logger](https://github.com/linrongbin16/commons.nvim/blob/main/lua/commons/logger.lua)

Logging system with [python-logging](https://docs.python.org/3/library/logging.html) like features.

!> This module requires initialize before writing logs.

## Introduction

### Setup

You can easily initialize the logging system via the `setup` function, for example:

```lua
local logging = require("commons.logging")
logging.setup({
  name = "your_logging",
  console_log = false,  -- by default is `true`
  file_log = true,      -- by default is `false`
  file_log_name = "your_logging.log",   -- by default is `nil`
  file_log_mode = "w",  -- by default is `"a"`.
})

-- First get logger by name, then write logs
logging.get("your_logging"):debug("This is the first debugging message")
logging.get("your_logging"):info(
  "This is the first info with global logger: %s",
  vim.inspect(logging.get("your_logging"))
)
```

The `setup` function will create a logger instance named `your_logging` and register into the logging system.

!> Get logger by name `your_logging` before write a logging message.

### Root Logger

The logger named `root` by default is the global singleton logger instance.

Once you initialize the logging system with the name `root`, you can easily use the global logging APIs without get the logger:

```lua
local logging = require("commons.logging")
logging.setup({
  name = "root", -- here we create the `root` logger instance
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

!> This would bring potential conflictions between multiple Neovim plugins if they all use the same root logger in same lua package namespace. See [Isolated Logger Instance](#isolated-logger-instance).

### Isolated Logger Instance

When installing the commons library with Neovim plugin manager or LuaRocks (see [Install](/install.md)), the commons library use the lua package namespace `commons` (e.g. the `require("commons")`), this would bring potential risks that multiple Neovim plugins share the same logging system, and further have conflictions on the global root logger instance if they all use the global logging APIs, in the same Neovim editor instance.

?> Also see: [Usage](/usage.md).

To avoid such issue, Neovim plugin will have to create isolated logger instance for itself, e.g. use a specified logger just like [Setup](#setup).

!> The logger name must be unique, and must not be `root`!

### Customization

The logging system is heavily influenced by [python-logging](https://docs.python.org/3/library/logging.html), it's built by below 3 main classes:

#### Logger

The top-level API class, provide `debug`/`info`/`warn`/`err` logging APIs for users.

The logger will collect all information (not only the logging message body) required for final rendering, pass them to its logging handlers.

Each logger has at least one logging handler, or multiple logging handlers.

#### Handler

Logging handler is responsible for actually write logs into a device, e.g. the nvim messages (`echomsg` or `vim.notify`), or a file on local disk.

Now we have below logging handlers:

- `ConsoleHandler`: Write logs to nvim's messages.

  !> Console handler will only print when logging level &ge; `INFO`, to avoid the interference of too noisy debugging messages to user.

- `FileHandler`: Write logs to file.

To control the final logging records rendering, each handler has its own logging formatter.

#### Formatter

The final logging records can look like:

```txt
2023-12-14 18:50:17.508383 [DEBUG]: This is the first debugging message.
2023-12-14 18:50:17.571393 [INFO]: This is the first info message.
```

Which is actually different from what user input in the logging APIs. That is what logging formatter does: formatting logs into final records with configurations.

#### Example

Here's an example of customizing logging formatters:

```lua
local paths = require("commons.paths")
local logging = require("commons.logging")

-- Step-1: Create a simple console handler that print to nvim's messages.

local console_formatter = logging.Formatter:new("[%(name)s] %(message)s")
local console_handler = logging.ConsoleHandler:new(console_formatter)

-- Step-2: Create a complicated file handler that write logs to a file.
local file_formatter = logging.Formatter:new(
  "%(asctime)s,%(msecs)d [%(name)] |%(levelname)s| - %(message)s.",
  {
    datefmt = "%Y-%m-%dT%H:%M:%S",
    msecsfmt = "%06d",
  }
)

-- For UNIX/Linux, it's '~/.local/share/nvim/your_plugin.log'.
-- For Windows, it's '~\AppData\Local\nvim-data\your_plugin.log'.
local file_path = string.format(
  "%s%s%s",
  vim.fn.stdpath("data"),
  paths.SEPARATOR,
  "your_plugin.log"
)

local file_handler = logging.FileHandler:new(file_path, "a", file_formatter)

-- Create logger in debug level.
local logger = logging.Logger:new("your_plugin", logging.LogLevels.DEBUG)
logger:add_handler(console_handler)
logger:add_handler(file_handler)

-- Register into logging system.
logging.add(logger)

-- In other places, write some logs.
local logger2 = logging.get("your_plugin") --[[@as commons.logging.Logger]]
logger2:debug("This is the first debugging message for your plugin")
logger2:warn(
  "Warning! This is the first warning message for your plugin with your logger: %s",
  vim.inspect(logger2)
)
```

This example will finally write 2 types of logs:

- Console message looks like:

  ```txt
  [your_plugin] This is the first debugging message for your plugin
  [your_plugin] Warning! This is the first warning message for your plugin with your logger: {
    name = "your_plugin",
    level = 1,
    handlers = { ... },
  }
  ```

- File logs looks like:

  ```txt
  2023-12-14 18:50:17,508383 [your_plugin] |DEBUG| - This is the first debugging message for your plugin.
  2023-12-14 18:50:17,513379 [your_plugin] |WARN| - Warning! This is the first warning message for your plugin with your logger: {.
  2023-12-14 18:50:17,513380 [your_plugin] |WARN| -   name = "your_plugin",.
  2023-12-14 18:50:17,513382 [your_plugin] |WARN| -   level = 1,.
  2023-12-14 18:50:17,513382 [your_plugin] |WARN| -   handlers = { ... },
  2023-12-14 18:50:17,513382 [your_plugin] |WARN| - }.
  ```

## Enums

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
--- @alias commons.LoggingConfigs {name:string,level:(commons.LogLevels|string)?,console_log:boolean?,file_log:boolean?,file_log_name:string?,file_log_dir:string?,file_log_mode:"a"|"w"|nil}

function setup(opts:commons.LoggingConfigs):nil
```

Parameters:

- `opts`: Config options.

  - `name`: Logger name, **mandatory** field.
  - `level`: Log level, by default is `LogLevels.INFO`.
  - `console_log`: Whether enable console (message) log, by default is `true`.

    !> Console handler will only print when `level >= LogLevels.INFO`, to avoid the interference of too noisy debugging messages to user.

  - `file_log`: Whether enable file log, by default is `false`.
  - `file_log_name`: File log name, working with `file_log`, **mandatory** when setting `file_log = true`.
  - `file_log_dir`: File log directory, working with `file_log`, **mandatory** when setting `file_log = true`. By default is `vim.fn.stdpath("data")`.
  - `file_log_mode`: File log open mode, working with `file_log`, **mandatory** when setting `file_log = true`. By default is `"a"`.
    - `a`: Append mode.
    - `w`: Write mode.

### `debug`/`info`/`warn`/`err`

Write logs with below levels:

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

- Returns whether logging system has the logger.

### `get`

Get logger instance.

```lua
function get(name:string):commons.logging.Logger?
```

Parameters:

- `name`: Logger name.

Returns:

- If logger exist, returns the logger.
- If logger not found, returns `nil`.

### `add`

Register logger into logging system.

```lua
function add(logger:commons.logging.Logger):nil
```

Parameters:

- `logger`: The logger.

## Classes

### `Logger`

The logger class.

```lua
--- @class commons.logging.Logger
```

#### Functions

##### `new`

Create new logger.

```lua
function Logger:new(name:string, level:commons.logging.LogLevels):commons.logging.Logger
```

Parameters:

- `name`: Logger name.
- `level`: Logging level.

Returns:

- Returns logger instance.

##### `add_handler`

Add logging handler.

```lua
function Logger:add_handler(handler: commons.logging.Handler):nil
```

Parameters:

- `handler`: Logging handler, see [Handler](#handler).

##### `debug`/`info`/`warn`/`err`

Same with global logging APIs, see above [debug/info/warn/err](#debuginfowarnerr).

##### `throw`

Same with global logging APIs, see above [throw](#throw).

##### `ensure`

Same with global logging APIs, see above [ensure](#ensure).

### `ConsoleHandler`

The logging handler that write nvim's messages.

```lua
--- @class commons.logging.ConsoleHandler
```

#### Functions

##### `new`

Create new console handler.

```lua
function ConsoleHandler:new(formatter: commons.logging.Formatter?):commons.logging.ConsoleHandler
```

Parameters:

- `formatter`: The logging formatter, by default is `[%(name)s] %(message)s`. For example: `[gitlinker] https://github.com/linrongbin16/commons.nvim/blob/c651def812/docs/README.md#L364 (lines can be wrong)`.

  ?> Also see: [Formatter](#formatter) and [Formatting Attributes](#attributes).

### `FileHandler`

The logging handler that write logs to file.

```lua
--- @class commons.logging.FileHandler
```

#### Functions

##### `new`

Create new file handler.

```lua
function FileHandler:new(filepath:string, filemode:"a"|"w"|nil, formatter:commons.logging.Formatter):commons.logging.FileHandler
```

Parameters:

- `filepath`: The full file name that logs will be written to.
- `filemode`: File mode.
  - `a`: Append mode, logs will be append at the end of logging file.
  - `w`: Write mode, exist file content will be removed before writing.
- `formatter`: The logging formatter, by default is `%(asctime)s,%(msecs)d [%(levelname)s] %(message)s`

  ?> Also see: [Formatter](#formatter) and [Formatting Attributes](#attributes).

### `Formatter`

The logging formatter that actually render the final logging records.

```lua
--- @class commons.logging.Formatter
```

#### Functions

##### `new`

Create new logging formatter.

```lua
function Formatter:new(fmt:string, opts:{datefmt:string?, msecsfmt:string?}?):commons.logging.Formatter
```

Parameters:

- `fmt`: The formatting template string, see [Formatting Attributes](#attributes).
- `opts`: Formatting options.

  - `datefmt`: The formatting placeholder for date and time (`%(asctime)s`), evaluated by [os.date()](https://www.lua.org/pil/22.1.html).

    - By default is `%Y-%m-%d %H:%M:%S`, for example: `2023-12-14 18:50:17`.

    ?> Also see: [Formatting Attributes](#attributes).

  - `msecsfmt`: The formatting placeholder for milliseconds (`%(msecs)d`), evaluated by [string.format](https://www.lua.org/pil/20.html).

    - By default is `%06d`, for example: `00713`.

    ?> Also see: [Formatting Attributes](#attributes).

Returns:

- Returns logging formatter.

#### Attributes

The logging formatter is (as well) heavily influenced by [python-logging's LogRecord attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes). For now supported attributes are:

- `%(levelno)s`: Numeric logging level (0-5), see [LogLevels](#loglevels).
- `%(levelname)s`: Text logging level (TRACE, DEBUG, etc), see [LogLevelNames](#loglevelnames).
- `%(message)s`: Logging message from user input.
- `%(asctime)s`: Date time, useful when you need extra debugging messages (especially in file handler).

  - By default it's formatted by [os.date()](https://www.lua.org/pil/22.1.html) with `%Y-%m-%d %H:%M:%S`, you can configure it with the `datefmt` options when creating a formatter.

    ?> Also see: [Formatter:new](#formatter).

  - For example:

    ```txt
    2023-12-14 18:50:17.508383 [DEBUG]: This is the first debugging message.
    2023-12-14 18:50:17.571393 [INFO]: This is the first info message.
    ```

- `%(msecs)d`: Milliseconds portion of the logging time, useful when you need the exact timestamp (especially in file handler).

  ?> **Tip:** Create formatter with setting `fmt` to `"%(asctime)s,%(msecs)d"` (with comma `,`) will give you: `2023-12-14 18:50:17,571393`.

  ?> **Why?** The reason of splitting `%(msecs)d` from `%(asctime)s` is mostly because the `os.date()` API doesn't support milliseconds portion rendering together with date and time.

- `%(name)s`: Logger name.
- `%(filename)s`: Source file.
- `%(lineno)d`: Line no.
- `%(funcName)s`: Function name.
- `%(process)d`: Process ID.
