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
  local str = require("commons.str")

  local dummy = function() end

  describe("[escape]", function()
    it("test1", function()
      local actual = shell.escape("Hello World")
      assert(str.find(actual, "Hello World") > 0)
    end)
    it("test2", function()
      local actual = shell.escape("'Hello World'")
      assert(str.find(actual, "Hello World") > 0)
    end)
  end)

  describe("[waitable]", function()
    it("test1", function()
      local job = shell.waitable("cat README.md", { on_stdout = dummy, on_stderr = dummy })
      -- shell.wait(job)
      -- print(string.format("waitable-1:%s\n", vim.inspect(sp)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function on_line(line)
        -- print(string.format("waitable-1 [%d]:%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = shell.waitable("echo README.md", { on_stdout = on_line, on_stderr = dummy })
      -- shell.wait(job)
      -- print(string.format("waitable-2:%s\n", vim.inspect(sp)))
    end)
    it("test3", function()
      local job = shell.waitable("cat README.md", { on_stdout = dummy, on_stderr = dummy })
      -- shell.wait(job)
      -- print(string.format("shell waitable-3:%s\n", vim.inspect(sp)))
    end)
    it("test4", function()
      local job = shell.waitable("cat non_exists.txt", {
        on_stdout = function(line)
          print(string.format("waitable-4, stdout line:%s", vim.inspect(line)))
        end,
        on_stderr = function(line)
          print(string.format("waitable-4, stderr line:%s", vim.inspect(line)))
        end,
      })
      -- shell.wait(job)
      -- print(string.format("shell waitable-4:%s\n", vim.inspect(sp)))
    end)
    local case_i = 0
    while case_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + case_i)
      it(string.format("stdout on %s", lower_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("waitable-lowercase-%d [%d]:%s\n", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = shell.waitable("cat README.md", { on_stdout = on_line, on_stderr = dummy })
        -- shell.wait(job)
        -- print(
        --   string.format(
        --     "waitable-lowercase-%d, job:%s\n",
        --     vim.inspect(case_i),
        --     vim.inspect(job)
        --   )
        -- )
      end)
      -- upper case: A
      local upper_char = string.char(65 + case_i)
      it(string.format("stdout on %s", upper_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("waitable-uppercase-%d [%d]:%s\n", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = shell.waitable("cat README.md", { on_stdout = on_line, on_stderr = dummy })
        -- shell.wait(job)
        -- print(
        --   string.format(
        --     "shell waitable-uppercase-%d:%s\n",
        --     vim.inspect(delimiter_i),
        --     vim.inspect(sp)
        --   )
        -- )
      end)
      case_i = case_i + 1
    end
  end)
  describe("[detached]", function()
    it("test1", function()
      local job = shell.detached(
        "cat README.md",
        { on_stdout = dummy, on_stderr = dummy },
        function(result)
          print(string.format("detached-1, result:%s\n", vim.inspect(result)))
        end
      )
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
      local job = shell.detached(
        "cat README.md",
        { on_stdout = on_line, on_stderr = dummy },
        function(result)
          print(string.format("detached-2, result:%s\n", vim.inspect(result)))
        end
      )
    end)
    it("test3", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function on_line(line)
        -- print(string.format("detached-3 [%d]:%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = shell.detached(
        "cat README.md",
        { on_stdout = on_line, on_stderr = dummy },
        function(result)
          print(string.format("detached-3, result:%s\n", vim.inspect(result)))
        end
      )
    end)
    it("test4", function()
      local job = shell.detached("cat non_exists.txt", {
        on_stdout = function(line)
          print(string.format("detached-4, stdout line:%s\n", vim.inspect(line)))
        end,
        on_stderr = function(line)
          print(string.format("detached-4, stderr line:%s\n", vim.inspect(line)))
        end,
      }, function(result)
        print(string.format("detached-4, result:%s\n", vim.inspect(result)))
      end)
    end)
    it("test5", function()
      local job = shell.detached("cat CHANGELOG.md", {
        on_stdout = function(line)
          print(string.format("detached-5, stdout line:%s\n", vim.inspect(line)))
        end,
        on_stderr = function(line)
          print(string.format("detached-5, stderr line:%s\n", vim.inspect(line)))
        end,
      }, function(result)
        print(string.format("detached-5, result:%s\n", vim.inspect(result)))
      end)
      local ok, err = pcall(shell.wait, job)
      assert(not ok)
      print(string.format("detached-5 wait err:%s\n", vim.inspect(err)))
    end)
    local case_i = 0
    while case_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + case_i)
      it(string.format("stdout on %s", lower_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("detached-lowercase-%d [%d]:%s\n", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = shell.detached(
          "cat README.md",
          { on_stdout = on_line, on_stderr = dummy },
          function(result)
            print(
              string.format(
                "detached-lowercase-%d, result:%s\n",
                vim.inspect(case_i),
                vim.inspect(result)
              )
            )
          end
        )
      end)
      -- upper case: A
      local upper_char = string.char(65 + case_i)
      it(string.format("stdout on %s", upper_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function on_line(line)
          -- print(string.format("detached-uppercase-%d [%d]:%s\n", case_i, i, line))
          assert_eq(type(line), "string")
          assert_eq(line, expect[i])
          i = i + 1
        end
        local job = shell.detached(
          "cat README.md",
          { on_stdout = on_line, on_stderr = dummy },
          function(result)
            print(
              string.format(
                "shell detached-uppercase-%d, result:%s\n",
                vim.inspect(case_i),
                vim.inspect(result)
              )
            )
          end
        )
      end)
      case_i = case_i + 1
    end
  end)
end)
