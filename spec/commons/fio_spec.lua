local cwd = vim.fn.getcwd()

describe("commons.fio", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local str = require("commons.str")
  local tbl = require("commons.tbl")
  local fio = require("commons.fio")
  local platform = require("commons.platform")

  describe("[readfile]", function()
    it("not exist", function()
      local ok1, reader1 = pcall(fio.readfile, "asdf.md")
      assert_eq(reader1, nil)
      assert_true(ok1)
    end)
    it("readfile", function()
      local content = fio.readfile("README.md") --[[@as string]]
      assert_true(type(content) == "string")
      assert_true(string.len(content) >= 0)
    end)
  end)
  describe("[writefile]", function()
    if not platform.IS_WINDOWS then
      it("invalid filename", function()
        local ok1, reader1 = pcall(fio.writefile, "a\\  '' :?!#+_-sdf.md")
        assert_false(ok1)
      end)
    end

    it("writefile", function()
      local content = fio.readfile("README.md") --[[@as string]]
      local lines = fio.readlines("README.md") --[[@as table]]

      local t1 = "writefile-test1-README.md"
      local t2 = "writefile-test2-README.md"
      fio.writefile(t1, content)
      fio.writelines(t2, lines)

      content = fio.readfile(t1, { trim = true }) --[[@as string]]
      lines = fio.readlines(t2) --[[@as table]]

      local buffer = nil
      for _, line in
        ipairs(lines --[[@as table]])
      do
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
      content = content:gsub("\r\n", "\n")
      assert_eq(str.rtrim(buffer --[[@as string]]), content)
      local j1 = vim.fn.jobstart(
        { "rm", t1 },
        { on_stdout = function() end, on_stderr = function() end }
      )
      local j2 = vim.fn.jobstart(
        { "rm", t2 },
        { on_stdout = function() end, on_stderr = function() end }
      )
      vim.fn.jobwait({ j1, j2 })
    end)
  end)
  describe("[asyncwritefile]", function()
    it("write", function()
      local t = "asyncwritefile-test.txt"
      local content = "hello world, goodbye world!"
      local done = false
      fio.asyncwritefile(t, content, function(bytes)
        assert_eq(bytes, #content)
        vim.schedule(function()
          local j = vim.fn.jobstart(
            { "rm", t },
            { on_stdout = function() end, on_stderr = function() end }
          )
          vim.fn.jobwait({ j })
          done = true
        end)
      end)
      vim.wait(1000, function()
        return done
      end)
    end)
  end)
  describe("[asyncreadfile]", function()
    it("read without on_error", function()
      local t = "README.md"
      local done = false
      fio.asyncreadfile(t, {
        on_complete = function(content)
          assert_true(string.len(content) > 0)
          done = true
        end,
      })
      vim.wait(1000, function()
        return done
      end)
    end)
    it("read with on_error", function()
      local t = "README.md"
      local done = false
      fio.asyncreadfile(t, {
        on_complete = function(content)
          assert_true(string.len(content) > 0)
          done = true
        end,
        on_error = function(msg, err)
          assert_true(false)
        end,
      })
      vim.wait(1000, function()
        return done
      end)
    end)
    it("read non-exist file", function()
      local t = "THE_NON_EXIST_README.md"
      local done = false
      local failed = false
      fio.asyncreadfile(t, {
        on_complete = function(content)
          assert_true(string.len(content) > 0)
          done = true
        end,
        on_error = function(msg, err)
          print(string.format("failed to open file(%s): %s", vim.inspect(msg), vim.inspect(err)))
          assert_true(true)
          failed = true
        end,
      })
      vim.wait(1000, function()
        return done or failed
      end)
    end)
    it("read directory", function()
      local t = "lua"
      local done = false
      local failed = false
      fio.asyncreadfile(t, {
        on_complete = function(content)
          assert_true(string.len(content) > 0)
          done = true
        end,
        on_error = function(msg, err)
          print(string.format("failed to open file(%s): %s", vim.inspect(msg), vim.inspect(err)))
          assert_true(true)
          failed = true
        end,
      })
      vim.wait(1000, function()
        return done or failed
      end)
    end)
  end)
  describe("[asyncreadlines]", function()
    it("read without on_error", function()
      local t = "README.md"
      local done = false
      local actual = {}
      fio.asyncreadlines(t, {
        on_line = function(line)
          assert_eq(type(line), "string")
          assert_true(string.len(line) >= 0)
          table.insert(actual, line)
        end,
        on_complete = function(bytes)
          assert_true(bytes > 0)
          local expect = fio.readlines(t)
          assert_eq(#actual, #expect)
          for i = 1, #actual do
            local la = actual[i]
            local le = expect[i]
            assert_eq(la, le)
            print(string.format("asyncreadlines-%s: %s\n", vim.inspect(i), vim.inspect(la)))
          end
          done = true
        end,
      })
      vim.wait(1000, function()
        return done
      end)
    end)
    it("read with on_error", function()
      local t = "README.md"
      local done = false
      local actual = {}
      fio.asyncreadlines(t, {
        on_line = function(line)
          assert_eq(type(line), "string")
          assert_true(string.len(line) >= 0)
          table.insert(actual, line)
        end,
        on_complete = function(bytes)
          assert_true(bytes > 0)
          local expect = fio.readlines(t)
          assert_eq(#actual, #expect)
          for i = 1, #actual do
            local la = actual[i]
            local le = expect[i]
            assert_eq(la, le)
            print(string.format("asyncreadlines-%s: %s\n", vim.inspect(i), vim.inspect(la)))
          end
          done = true
        end,
        on_error = function(msg, err)
          assert_true(false)
        end,
      })
      vim.wait(1000, function()
        return done
      end)
    end)
    it("failed", function()
      local t = "asyncreadlines_not_exists.txt"
      local done = false
      local failed = false
      fio.asyncreadlines(t, {
        on_line = function(line) end,
        on_complete = function(bytes)
          done = true
        end,
        on_error = function(read_err)
          failed = true
        end,
      })
      vim.wait(1000, function()
        return failed or done
      end)
    end)
  end)
  describe("[CachedFileReader]", function()
    it("test", function()
      local reader = fio.CachedFileReader:open("README.md")
      assert_true(reader.cache == nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      reader:reset()
      assert_true(reader.cache == nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
    end)
    it("failed to read", function()
      local reader = fio.CachedFileReader:open("asdf.md")
      assert_true(reader.cache == nil)
      assert_eq(reader:read(), nil)
      assert_true(reader.cache == nil)
      assert_eq(reader:read(), nil)
      assert_true(reader.cache == nil)
      assert_eq(reader:read(), nil)
      assert_true(reader.cache == nil)
      reader:reset()
      assert_eq(reader:read(), nil)
      assert_true(reader.cache == nil)
      assert_eq(reader:read(), nil)
      assert_true(reader.cache == nil)
    end)
  end)
end)
