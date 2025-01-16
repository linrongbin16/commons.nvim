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

  describe("[wait linewise]", function()
    it("test1", function()
      local job = spawn.linewise({ "cat", "README.md" }, { on_stdout = dummy, on_stderr = dummy })
      local result = spawn.wait(job)
      print(string.format("wait-linewise-1, result:%s\n", vim.inspect(result)))
    end)
    it("test2", function()
      local lines = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function eachline(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, lines[i])
        i = i + 1
      end
      local job = spawn.linewise(
        { "cat", "README.md" },
        { on_stdout = eachline, on_stderr = dummy }
      )
      local result = spawn.wait(job)
      print(string.format("wait-linewise-2, result:%s\n", vim.inspect(result)))
    end)
    local case_i = 0
    while case_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + case_i)
      it(string.format("stdout on %s", lower_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function eachline(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local job = spawn.linewise(
          { "cat", "README.md" },
          { on_stdout = eachline, on_stderr = dummy }
        )
        local result = spawn.wait(job)
        print(
          string.format(
            "wait-linewise-lowercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
      end)
      -- upper case: A
      local upper_char = string.char(65 + case_i)
      it(string.format("stdout on %s", upper_char), function()
        local lines = fio.readlines("README.md") --[[@as table]]

        local i = 1
        local function eachline(line)
          -- print(string.format("[%d]%s\n", i, line))
          assert_eq(type(line), "string")
          assert_eq(line, lines[i])
          i = i + 1
        end
        local job = spawn.linewise(
          { "cat", "README.md" },
          { on_stdout = eachline, on_stderr = dummy }
        )
        local result = spawn.wait(job)
        print(
          string.format(
            "wait-linewise-uppercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
      end)
      case_i = case_i + 1
    end
    it("test3", function()
      local job = spawn.linewise({ "cat", "README.md" }, { on_stdout = dummy, on_stderr = dummy })
      local result = spawn.wait(job)
      print(string.format("wait-linewise-3, result:%s\n", vim.inspect(result)))
    end)
    it("test4", function()
      local job = spawn.linewise({ "cat", "non_exists.txt" }, {
        on_stdout = function(line)
          print(string.format("wait-linewise-4, stdout line:%s\n", vim.inspect(line)))
        end,
        on_stderr = function(line)
          print(string.format("wait-linewise-4, stderr line:%s\n", vim.inspect(line)))
        end,
      })
      local result = spawn.wait(job)
      print(string.format("wait-linewise-4, result:%s\n", vim.inspect(result)))
    end)
  end)
  describe("[no-wait linewise]", function()
    it("test1", function()
      local job = spawn.linewise(
        { "cat", "README.md" },
        { on_stdout = dummy, on_stderr = dummy, on_exit = dummy }
      )
      print(string.format("no-wait-linewise-1, job:%s\n", vim.inspect(job)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function eachline(line)
        -- print(string.format("[%d]%s", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = spawn.linewise({ "cat", "README.md" }, {
        on_stdout = eachline,
        on_stderr = dummy,
        on_exit = function(completed)
          print(string.format("no-wait-linewise-2, completed:%s\n", vim.inspect(completed)))
        end,
      })
      print(string.format("no-wait-linewise-2, job:%s\n", vim.inspect(job)))
    end)
    it("test3", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local i = 1
      local function eachline(line)
        -- print(string.format("[%d]%s\n", i, line))
        assert_eq(type(line), "string")
        assert_eq(line, expect[i])
        i = i + 1
      end
      local job = spawn.linewise({ "cat", "CHANGELOG.md" }, {
        on_stdout = eachline,
        on_stderr = dummy,
        on_exit = function(completed)
          print(string.format("no-wait-linewise-3, completed:%s\n", vim.inspect(completed)))
        end,
      })
      print(string.format("no-wait-linewise-3, job:%s\n", vim.inspect(job)))
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
      local job = spawn.linewise({ "cat", "CHANGELOG.md" }, {
        on_stdout = eachline,
        on_stderr = dummy,
        on_exit = function(completed)
          print(string.format("no-wait-linewise-4, completed:%s\n", vim.inspect(completed)))
        end,
      })
      local ok, err = pcall(spawn.wait, job)
      assert(not ok)
      print(string.format("no-wait-linewise-4, job:%s\n", vim.inspect(job)))
      print(string.format("no-wait-linewise-4, err:%s\n", vim.inspect(err)))
    end)
  end)

  describe("[wait blockwise]", function()
    it("test1", function()
      local job = spawn.blockwise({ "cat", "README.md" })
      local result = spawn.wait(job)
      print(string.format("wait-blockwise-1, result:%s\n", vim.inspect(result)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local job = spawn.blockwise({ "cat", "README.md" }, {})
      local result = spawn.wait(job)
      print(string.format("wait-blockwise-2, result:%s\n", vim.inspect(result)))

      local actual = str.split(result.stdout, "\n", { plain = true, trimempty = false })
      assert_eq(#expect, #actual)
      local n = #expect
      for i = 1, n do
        assert_eq(expect[i], actual[i])
      end
    end)
    local case_i = 0
    while case_i <= 25 do
      -- lower case: a
      local lower_char = string.char(97 + case_i)
      it(string.format("stdout on %s", lower_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local job = spawn.blockwise({ "cat", "README.md" })
        local result = spawn.wait(job)
        print(
          string.format(
            "wait-blockwise-lowercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
        local actual = str.split(result.stdout, "\n", { plain = true, trimempty = false })
        assert_eq(#expect, #actual)
        local n = #expect
        for i = 1, n do
          assert_eq(expect[i], actual[i])
        end
      end)
      -- upper case: A
      local upper_char = string.char(65 + case_i)
      it(string.format("stdout on %s", upper_char), function()
        local expect = fio.readlines("README.md") --[[@as table]]

        local job = spawn.blockwise({ "cat", "README.md" }, {})
        local result = spawn.wait(job)
        print(
          string.format(
            "wait-blockwise-uppercase-%d, result:%s\n",
            vim.inspect(case_i),
            vim.inspect(result)
          )
        )
        local actual = str.split(result.stdout, "\n", { plain = true, trimempty = false })
        assert_eq(#expect, #actual)
        local n = #expect
        for i = 1, n do
          assert_eq(expect[i], actual[i])
        end
      end)
      case_i = case_i + 1
    end
  end)
  describe("[no-wait blockwise]", function()
    it("test1", function()
      local job = spawn.blockwise({ "cat", "README.md" }, {
        on_exit = function(completed)
          print(string.format("no-wait-blockwise-1, completed:%s\n", vim.inspect(completed)))
        end,
      })
      print(string.format("no-wait-blockwise-1, job:%s\n", vim.inspect(job)))
    end)
    it("test2", function()
      local expect = fio.readlines("README.md") --[[@as table]]

      local job = spawn.blockwise({ "cat", "README.md" }, {
        on_exit = function(completed)
          print(string.format("no-wait-blockwise-2, completed:%s\n", vim.inspect(completed)))
          local actual = str.split(completed.stdout, "\n", { plain = true, trimempty = false })
          assert_eq(#expect, #actual)
          local n = #expect
          for i = 1, n do
            assert_eq(expect[i], actual[i])
          end
        end,
      })
      print(string.format("no-wait-blockwise-2, job:%s\n", vim.inspect(job)))
    end)
    it("test3", function()
      local job = spawn.blockwise({ "cat", "non-exists.txt" }, {
        on_exit = function(completed)
          print(string.format("no-wait-blockwise-3, completed:%s\n", vim.inspect(completed)))
          assert(completed.stdout == nil)
          assert(type(completed.stderr) == "string")
          assert(string.len(completed.stderr) > 0)
        end,
      })
      print(string.format("no-wait-blockwise-3, job:%s\n", vim.inspect(job)))
    end)
    it("test4", function()
      local job = spawn.blockwise({ "cat", "CHANGELOG.md" }, {
        on_exit = function(completed)
          print(string.format("no-wait-blockwise-4, completed:%s\n", vim.inspect(completed)))
        end,
      })
      local ok, err = pcall(spawn.wait, job)
      assert(not ok)
      assert(type(err) == "string")
      print(string.format("no-wait-blockwise-4, err:%s\n", vim.inspect(err)))
    end)
  end)
end)
