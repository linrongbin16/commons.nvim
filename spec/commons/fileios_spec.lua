local cwd = vim.fn.getcwd()

describe("commons.fileios", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local strings = require("commons.strings")
  local fileios = require("commons.fileios")

  describe("[FileLineReader]", function()
    it("failed to open", function()
      local ok, reader = pcall(fileios.FileLineReader.open, fileios.FileLineReader, "asdf.md")
      assert_false(ok)
    end)
  end)
  describe("[readfile/readlines]", function()
    it("failed to open", function()
      local ok1, reader1 = pcall(fileios.readfile, "asdf.md")
      assert_eq(reader1, nil)
      assert_true(ok1)
      local ok2, reader2 = pcall(fileios.readlines, "asdf.md")
      assert_eq(reader2, nil)
      assert_true(ok2)
    end)
    it("readfile and FileLineReader", function()
      local content = fileios.readfile("README.md", { trim = true })
      local reader = fileios.FileLineReader:open("README.md") --[[@as commons.FileLineReader]]
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
      assert_eq(strings.rtrim(buffer --[[@as string]]), content)
    end)
    it("readfile and readlines", function()
      local content = fileios.readfile("README.md", { trim = true })
      local lines = fileios.readlines("README.md")
      local buffer = nil
      for _, line in
        ipairs(lines --[[@as table]])
      do
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
      content = content:gsub("\r\n", "\n")
      assert_eq(strings.rtrim(buffer --[[@as string]]), content)
    end)
  end)
  describe("[writefile/writelines]", function()
    it("failed to open", function()
      local ok1, reader1 = pcall(fileios.writefile, "a\\  '' :?!#+_-sdf.md")
      assert_false(ok1)
      local ok2, reader2 = pcall(fileios.writelines, "a\\  '' :?!#+_-sdf.md")
      assert_false(ok2)
    end)
    it("writefile and writelines", function()
      local content = fileios.readfile("README.md") --[[@as string]]
      local lines = fileios.readlines("README.md") --[[@as table]]

      local t1 = "writefile-test1-README.md"
      local t2 = "writefile-test2-README.md"
      fileios.writefile(t1, content)
      fileios.writelines(t2, lines)

      content = fileios.readfile(t1, { trim = true }) --[[@as string]]
      lines = fileios.readlines(t2) --[[@as table]]

      local buffer = nil
      for _, line in
        ipairs(lines --[[@as table]])
      do
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
      content = content:gsub("\r\n", "\n")
      assert_eq(strings.rtrim(buffer --[[@as string]]), content)
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
      fileios.asyncwritefile(t, content, function(bytes)
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
    it("test", function()
      local t = "README.md"
      local done = false
      fileios.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
        done = true
      end)
      vim.wait(1000, function()
        return done
      end)
    end)
  end)
  describe("[asyncreadlines]", function()
    it("test", function()
      local t = "README.md"
      local done = false
      local actual = {}
      fileios.asyncreadlines(t, {
        on_line = function(line)
          assert_eq(type(line), "string")
          assert_true(string.len(line) >= 0)
          table.insert(actual, line)
        end,
        on_complete = function(bytes)
          assert_true(bytes > 0)
          local expect = fileios.readlines(t)
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
    it("failed", function()
      local t = "asyncreadlines_not_exists.txt"
      local done = false
      local failed = false
      fileios.asyncreadlines(t, {
        on_line = function(line) end,
        on_complete = function(bytes)
          done = true
        end,
        on_error = function(read_err)
          failed = true
        end,
      })
      vim.wait(1000, function()
        return failed and done
      end)
    end)
  end)
end)
