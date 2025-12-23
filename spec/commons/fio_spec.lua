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
      local content1 = fio.readfile("README.md") --[[@as string]]
      local t1 = "test1.txt"
      fio.writefile(t1, content1)
      local content2 = fio.readfile(t1) --[[@as string]]
      assert_eq(content1, content2)
    end)
  end)
  describe("[asyncwritefile]", function()
    it("write", function()
      local t = "test2.txt"
      local content = "hello world, goodbye world!"
      local done = false
      fio.asyncwritefile(t, content, function(bytes)
        assert_eq(bytes, #content)
      end)
      vim.wait(1000, function()
        return done
      end)
    end)
  end)
  describe("[asyncreadfile]", function()
    it("read1", function()
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
    it("read2", function()
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
    it("non exist", function()
      local t = "NON_EXIST_README.md"
      local failed = false
      fio.asyncreadfile(t, {
        on_complete = function(content)
          assert_true(false)
        end,
        on_error = function(msg, err)
          print(string.format("failed to open file(%s): %s", vim.inspect(msg), vim.inspect(err)))
          assert_true(true)
          failed = true
        end,
      })
      vim.wait(1000, function()
        return failed
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
end)
