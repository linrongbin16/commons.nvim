local cwd = vim.fn.getcwd()

describe("commons.fileio", function()
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
  local fileio = require("commons.fileio")
  local platform = require("commons.platform")

  describe("[FileLineReader]", function()
    it("failed to open", function()
      local ok, reader = pcall(fileio.FileLineReader.open, fileio.FileLineReader, "asdf.md")
      assert_false(ok)
    end)
    it("should equal with readfile", function()
      local function compare_with_readfile(filename)
        local expect_content = fileio.readfile(filename, { trim = true })
        assert_true(str.not_empty(expect_content))
        local expect_lines = str.split(expect_content, "\n", { plain = true, trimempty = false })

        local reader = fileio.FileLineReader:open(filename)
        local actual_lines = {}
        while reader:has_next() do
          table.insert(actual_lines, reader:next())
        end
        reader:close()

        assert_eq(type(expect_lines), type(actual_lines))
        assert_eq(type(actual_lines), "table")
        assert_true(tbl.list_not_empty(expect_lines))
        assert_true(tbl.list_not_empty(actual_lines))
        assert_eq(#expect_lines, #actual_lines)
        for i, expect in ipairs(expect_lines) do
          local actual = actual_lines[i]
          assert_eq(actual, expect)
        end
      end

      compare_with_readfile("README.md")
      compare_with_readfile("LICENSE")
      compare_with_readfile("version.txt")
      compare_with_readfile(".github/workflows/ci.yml")
    end)
  end)
  describe("[readfile/readlines]", function()
    it("failed to open", function()
      local ok1, reader1 = pcall(fileio.readfile, "asdf.md")
      assert_eq(reader1, nil)
      assert_true(ok1)
      local ok2, reader2 = pcall(fileio.readlines, "asdf.md")
      assert_eq(reader2, nil)
      assert_true(ok2)
    end)
    it("readfile and FileLineReader", function()
      local content = fileio.readfile("README.md", { trim = true })
      local reader = fileio.FileLineReader:open("README.md") --[[@as commons.FileLineReader]]
      local buffer = nil
      assert_eq(type(reader), "table")
      while reader:has_next() do
        local line = reader:next() --[[@as string]]
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
      reader:close()
      content = content:gsub("\r\n", "\n")
      assert_eq(str.rtrim(buffer --[[@as string]]), content)
    end)
    it("readfile and readlines", function()
      local content = fileio.readfile("README.md", { trim = true })
      local lines = fileio.readlines("README.md")
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
    end)
  end)
  describe("[writefile/writelines]", function()
    if not platform.IS_WINDOWS then
      it("failed to open", function()
        local ok1, reader1 = pcall(fileio.writefile, "a\\  '' :?!#+_-sdf.md")
        assert_false(ok1)
        local ok2, reader2 = pcall(fileio.writelines, "a\\  '' :?!#+_-sdf.md")
        assert_false(ok2)
      end)
    end

    it("writefile and writelines", function()
      local content = fileio.readfile("README.md") --[[@as string]]
      local lines = fileio.readlines("README.md") --[[@as table]]

      local t1 = "writefile-test1-README.md"
      local t2 = "writefile-test2-README.md"
      fileio.writefile(t1, content)
      fileio.writelines(t2, lines)

      content = fileio.readfile(t1, { trim = true }) --[[@as string]]
      lines = fileio.readlines(t2) --[[@as table]]

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
      fileio.asyncwritefile(t, content, function(bytes)
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
      fileio.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
        done = true
      end)
      vim.wait(1000, function()
        return done
      end)
    end)
    it("read with on_error", function()
      local t = "README.md"
      local done = false
      fileio.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
        done = true
      end, {
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
      fileio.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
        done = true
      end, {
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
      fileio.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
        done = true
      end, {
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
      fileio.asyncreadlines(t, {
        on_line = function(line)
          assert_eq(type(line), "string")
          assert_true(string.len(line) >= 0)
          table.insert(actual, line)
        end,
        on_complete = function(bytes)
          assert_true(bytes > 0)
          local expect = fileio.readlines(t)
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
      fileio.asyncreadlines(t, {
        on_line = function(line)
          assert_eq(type(line), "string")
          assert_true(string.len(line) >= 0)
          table.insert(actual, line)
        end,
        on_complete = function(bytes)
          assert_true(bytes > 0)
          local expect = fileio.readlines(t)
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
      fileio.asyncreadlines(t, {
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
      local reader = fileio.CachedFileReader:open("README.md")
      assert_true(reader.cache == nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      reader:reset()
      assert_true(reader.cache == nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
      assert_eq(fileio.readfile("README.md"), reader:read())
      assert_true(reader.cache ~= nil)
    end)
    it("failed to read", function()
      local reader = fileio.CachedFileReader:open("asdf.md")
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
