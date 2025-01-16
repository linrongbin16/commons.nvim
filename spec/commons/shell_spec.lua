local cwd = vim.fn.getcwd()

describe("commons.shell", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local shell = require("commons.shell")
  local fio = require("commons.fio")

  local dummy = function() end

  describe("[wait linewise]", function()
    it("test1", function()
      local job = shell.linewise("cat README.md", { on_stdout = dummy, on_stderr = dummy })
      shell.wait({ job })
      -- print(string.format("shell wait-1:%s\n", vim.inspect(sp)))
    end)
    it("test2", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local job = shell.linewise("echo README.md", { on_stdout = process_line, on_stderr = dummy })
      shell.wait({ job })
      -- print(string.format("shell wait-2:%s\n", vim.inspect(sp)))
    end)
    local delimiter_i = 0
    while delimiter_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + delimiter_i)
      it(string.format("stdout on %s", lower_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local job = shell.linewise("cat README.md", { on_stdout = process_line, on_stderr = dummy })
        shell.wait({ job })
        -- print(
        --   string.format(
        --     "shell wait-delimiter-%d:%s\n",
        --     vim.inspect(delimiter_i),
        --     vim.inspect(sp)
        --   )
        -- )
      end)
      -- upper case: A
      local upper_char = string.char(65 + delimiter_i)
      it(string.format("stdout on %s", upper_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local job = shell.linewise("cat README.md", { on_stdout = process_line, on_stderr = dummy })
        shell.wait({ job })
        -- print(
        --   string.format(
        --     "shell wait-uppercase-%d:%s\n",
        --     vim.inspect(delimiter_i),
        --     vim.inspect(sp)
        --   )
        -- )
      end)
      delimiter_i = delimiter_i + math.random(1, 5)
    end
    it("stderr", function()
      local job = shell.linewise("cat README.md", { on_stdout = dummy, on_stderr = dummy })
      shell.wait({ job })
      -- print(string.format("shell wait-3:%s\n", vim.inspect(sp)))
    end)
    it("stderr2", function()
      local i = 1
      local function process_line(line)
        -- print(string.format("process[%d]:%s\n", i, line))
      end
      local job =
        shell.linewise("cat non_exists.txt", { on_stdout = process_line, on_stderr = process_line })
      shell.wait({ job })
      -- print(string.format("shell wait-4:%s\n", vim.inspect(sp)))
    end)
  end)
  describe("[no-wait linewise]", function()
    it("open", function()
      shell.linewise(
        "cat README.md",
        { on_stdout = dummy, on_stderr = dummy, on_exit = function(completed) end }
      )
      -- print(string.format("shell nonblocking-1:%s\n", vim.inspect(sp)))
    end)
    it("consume line", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      shell.linewise(
        "cat README.md",
        { on_stdout = process_line, on_stderr = dummy, on_exit = function(completed) end }
      )
      -- print(string.format("shell nonblocking-2:%s\n", vim.inspect(sp)))
    end)
    it("stdout on newline", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      shell.linewise(
        "cat README.md",
        { on_stdout = process_line, on_stderr = dummy, on_exit = function(completed) end }
      )
      -- print(string.format("shell nonblocking-3:%s\n", vim.inspect(sp)))
    end)
  end)

  describe("[wait blockwise]", function()
    it("test1", function()
      local job = shell.blockwise("cat README.md", { on_stdout = dummy })
      shell.wait({ job })
    end)
    it("test2", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local job = shell.blockwise("cat README.md", { on_stdout = dummy })
      shell.wait({ job })
    end)
    local delimiter_i = 0
    while delimiter_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + delimiter_i)
      it(string.format("stdout on %s", lower_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local stdout_data = nil
        local job = shell.blockwise("cat README.md", {
          on_stdout = function(stdout_data1)
            stdout_data = stdout_data1
          end,
        })
        shell.wait({ job })
        print(
          string.format(
            "shell wait-delimiter-%d:%s\n",
            vim.inspect(delimiter_i),
            vim.inspect(stdout_data)
          )
        )
      end)
      -- upper case: A
      local upper_char = string.char(65 + delimiter_i)
      it(string.format("stdout on %s", upper_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local stdout_data = nil
        local sp = shell.blockwise("cat README.md", {
          on_stdout = function(stdout_data1)
            stdout_data = stdout_data1
          end,
        })
        print(
          string.format(
            "shell wait-uppercase-%d:%s\n",
            vim.inspect(delimiter_i),
            vim.inspect(stdout_data)
          )
        )
      end)
      delimiter_i = delimiter_i + math.random(1, 5)
    end
  end)
  describe("[no-wait blockwise]", function()
    it("open", function()
      local sp = shell.blockwise("cat README.md", { on_stdout = dummy, on_exit = dummy })
    end)
    it("consume line", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local sp = shell.blockwise("cat README.md", { on_stdout = dummy, on_exit = dummy })
      -- print(string.format("shell nonblocking-2:%s\n", vim.inspect(sp)))
    end)
    it("stdout on newline", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local sp = shell.blockwise("cat README.md", { on_stdout = dummy, on_exit = dummy })
      -- print(string.format("shell nonblocking-3:%s\n", vim.inspect(sp)))
    end)
  end)
end)
