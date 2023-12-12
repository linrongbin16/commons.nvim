local cwd = vim.fn.getcwd()

describe("commons.spawn", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local strings = require("commons.strings")
  local fileios = require("commons.fileios")
  local spawn = require("commons.spawn")

  local dummy = function() end

  describe("[blocking]", function()
    it("test1", function()
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = dummy, stderr = dummy }
      )
      sp:wait()
      -- print(string.format("spawn wait-1:%s\n", vim.inspect(sp)))
    end)
    it("test2", function()
      local lines = fileios.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = process_line, stderr = dummy }
      )
      sp:wait()
      -- print(string.format("spawn wait-2:%s\n", vim.inspect(sp)))
    end)
    local delimiter_i = 0
    while delimiter_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + delimiter_i)
      it(string.format("stdout on %s", lower_char), function()
        local lines = fileios.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local sp = spawn.run(
          { "cat", "README.md" },
          { stdout = process_line, stderr = dummy }
        )
        sp:wait()
        -- print(
        --   string.format(
        --     "spawn wait-delimiter-%d:%s\n",
        --     vim.inspect(delimiter_i),
        --     vim.inspect(sp)
        --   )
        -- )
      end)
      -- upper case: A
      local upper_char = string.char(65 + delimiter_i)
      it(string.format("stdout on %s", upper_char), function()
        local lines = fileios.readlines("README.md") --[[@as table]]

        local i = 1
        local function process_line(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local sp = spawn.run(
          { "cat", "README.md" },
          { stdout = process_line, stderr = dummy }
        )
        sp:wait()
        -- print(
        --   string.format(
        --     "spawn wait-uppercase-%d:%s\n",
        --     vim.inspect(delimiter_i),
        --     vim.inspect(sp)
        --   )
        -- )
      end)
      delimiter_i = delimiter_i + math.random(1, 5)
    end
    it("stderr", function()
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = dummy, stderr = dummy }
      )
      sp:wait()
      -- print(string.format("spawn wait-3:%s\n", vim.inspect(sp)))
    end)
    it("stderr2", function()
      local i = 1
      local function process_line(line)
        -- print(string.format("process[%d]:%s\n", i, line))
      end
      local sp = spawn.run(
        { "cat", "non_exists.txt" },
        { stdout = process_line, stderr = process_line, blocking = true }
      )
      sp:wait()
      -- print(string.format("spawn wait-4:%s\n", vim.inspect(sp)))
    end)
  end)
  describe("[nonblocking]", function()
    it("open", function()
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = dummy, stderr = dummy },
        function(exitcode, signal) end
      )
      sp:kill(9)
      -- print(string.format("spawn nonblocking-1:%s\n", vim.inspect(sp)))
    end)
    it("consume line", function()
      local lines = fileios.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = process_line, stderr = dummy },
        function(exitcode, signal) end
      )
      -- print(string.format("spawn nonblocking-2:%s\n", vim.inspect(sp)))
    end)
    it("stdout on newline", function()
      local lines = fileios.readlines("README.md") --[[@as table]]

      local i = 1
      local function process_line(line)
        -- print(string.format("[%d]%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local sp = spawn.run(
        { "cat", "README.md" },
        { stdout = process_line, stderr = dummy },
        function(exitcode, signal) end
      )
      -- print(string.format("spawn nonblocking-3:%s\n", vim.inspect(sp)))
    end)
  end)
end)
