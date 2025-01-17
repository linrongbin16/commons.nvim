local cwd = vim.fn.getcwd()
local IS_WINDOWS = vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0

if IS_WINDOWS then
  return
end

describe("commons.spawn", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local fio = require("commons.fio")
  local str = require("commons.str")
  local spawn = require("commons.spawn")

  local dummy = function() end

  describe("[waitable]", function()
    it("test1", function()
      local job = spawn.waitable({ "cat", "README.md" }, { on_stdout = dummy, on_stderr = dummy })
      local result = spawn.waitable(job)
      print(string.format("waitable-1, result:%s\n", vim.inspect(result)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function on_line(line)
        -- print(string.format("waitable-2 [%d]:%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end

      local job = spawn.waitable({ "cat", "README.md" }, { on_stdout = on_line, on_stderr = dummy })
      local result = spawn.waitable(job)
      print(string.format("waitable-2, result:%s\n", vim.inspect(result)))
    end)
    it("test3", function()
      local job = spawn.waitable({ "cat", "README.md" }, { on_stdout = dummy, on_stderr = dummy })
      -- print(string.format("waitable-3, job:%s\n", vim.inspect(job)))
    end)
    it("test4", function()
      local job = spawn.waitable({ "cat", "non_exists.txt" }, {
        on_stdout = function(line)
          print(string.format("waitable-4, stdout line:%s\n", vim.inspect(line)))
        end,
        on_stderr = function(line)
          print(string.format("waitable-4, stderr line:%s\n", vim.inspect(line)))
        end,
      })
      local result = spawn.waitable(job)
      print(string.format("waitable-4, result:%s\n", vim.inspect(result)))
    end)
    local case_i = 0
    while case_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + case_i)
      it(string.format("stdout on %s", lower_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("waitable-lowercase-%d [%d]:%s", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = spawn.waitable(
          { "cat", "README.md" },
          { on_stdout = on_line, on_stderr = dummy }
        )
        local result = spawn.waitable(job)
        print(
          string.format(
            "waitable-lowercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
      end)
      -- upper case: A
      local upper_char = string.char(65 + case_i)
      it(string.format("stdout on %s", upper_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("waitable-uppercase-%d [%d]:%s", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = spawn.waitable(
          { "cat", "README.md" },
          { on_stdout = on_line, on_stderr = dummy }
        )
        local result = spawn.waitable(job)
        print(
          string.format(
            "waitable-uppercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
      end)
      case_i = case_i + 1
    end
  end)
  describe("[detached]", function()
    it("test1", function()
      local job = spawn.detached(
        { "cat", "README.md" },
        { on_stdout = dummy, on_stderr = dummy },
        dummy
      )
      -- print(string.format("detached-1, job:%s\n", vim.inspect(job)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function on_line(line)
        -- print(string.format("detached-2 [%d]:%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = spawn.detached({ "cat", "README.md" }, {
        on_stdout = on_line,
        on_stderr = dummy,
      }, function(result)
        print(string.format("detached-2, result:%s\n", vim.inspect(result)))
      end)
      -- print(string.format("detached-2, job:%s\n", vim.inspect(job)))
    end)
    it("test3", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function on_line(line)
        -- print(string.format("detached-3 [%d]:%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = spawn.detached({ "cat", "CHANGELOG.md" }, {
        on_stdout = on_line,
        on_stderr = dummy,
      }, function(result)
        print(string.format("detached-3, result:%s\n", vim.inspect(result)))
      end)
      -- print(string.format("detached-3, job:%s\n", vim.inspect(job)))
    end)
    it("test4", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function eachline(line)
        -- print(string.format("[%d]%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = spawn.detached({ "cat", "CHANGELOG.md" }, {
        on_stdout = eachline,
        on_stderr = dummy,
      }, function(result)
        print(string.format("detached-4, result:%s\n", vim.inspect(result)))
      end)
      local ok, err = pcall(spawn.waitable, job)
      assert(not ok)
      -- print(string.format("detached-4, job:%s\n", vim.inspect(job)))
      print(string.format("detached-4, err:%s\n", vim.inspect(err)))
    end)
  end)
end)
