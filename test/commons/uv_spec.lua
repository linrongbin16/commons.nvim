local cwd = vim.fn.getcwd()

describe("commons.uv", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local uv = require("commons.uv")
  describe("[uv]", function()
    it("test", function()
      assert_true(uv.gettimeofday ~= nil)
      assert_true(uv.new_pipe ~= nil)
    end)
  end)
end)
