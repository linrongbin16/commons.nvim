local cwd = vim.fn.getcwd()

describe("commons.fileios", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local strings = require("commons.strings")
  local fileios = require("commons.fileios")

  describe("[readfile/readlines]", function()
    it("readfile and FileLineReader", function()
      local content = fileios.readfile("README.md")
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
      assert_eq(strings.rtrim(buffer --[[@as string]]), content)
    end)
    it("readfile and readlines", function()
      local content = fileios.readfile("README.md")
      local lines = fileios.readlines("README.md")
      local buffer = nil
      for _, line in
        ipairs(lines --[[@as table]])
      do
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
      assert_eq(strings.rtrim(buffer --[[@as string]]), content)
    end)
  end)
  describe("[writefile/writelines]", function()
    it("writefile and writelines", function()
      local content = fileios.readfile("README.md") --[[@as string]]
      local lines = fileios.readlines("README.md") --[[@as table]]

      local t1 = "writefile-test1-README.md"
      local t2 = "writefile-test2-README.md"
      fileios.writefile(t1, content)
      fileios.writelines(t2, lines)

      content = fileios.readfile(t1) --[[@as string]]
      lines = fileios.readlines(t2) --[[@as table]]

      local buffer = nil
      for _, line in
        ipairs(lines --[[@as table]])
      do
        assert_eq(type(line), "string")
        assert_true(string.len(line) >= 0)
        buffer = buffer and (buffer .. line .. "\n") or (line .. "\n")
      end
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
      fileios.asyncwritefile(t, content, function(bytes)
        assert_eq(bytes, #content)
        vim.schedule(function()
          local j = vim.fn.jobstart(
            { "rm", t },
            { on_stdout = function() end, on_stderr = function() end }
          )
          vim.fn.jobwait({ j })
        end)
      end)
    end)
  end)
  describe("[asyncreadfile]", function()
    it("read", function()
      local t = "README.md"
      fileios.asyncreadfile(t, function(content)
        assert_true(string.len(content) > 0)
      end)
    end)
  end)
end)
