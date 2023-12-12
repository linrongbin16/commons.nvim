local cwd = vim.fn.getcwd()

describe("commons.uv", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local uv = require("commons.uv")
  describe("[uv]", function()
    it("test", function()
      assert_eq(type(uv.gettimeofday), "function")
      assert_eq(type(uv.new_pipe), "function")
      assert_eq(type(uv.spawn), "function")
    end)
  end)
end)
