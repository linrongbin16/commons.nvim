local cwd = vim.fn.getcwd()

describe("commons.buf_option", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local win_options = require("commons.win_options")

  describe("[get_win_option/set_win_option]", function()
    it("get spell", function()
      win_options.set_win_option(0, "spell", true)
      local s = win_options.get_win_option(0, "spell")
      print(string.format("spell get win option:%s\n", vim.inspect(s)))
      assert_eq(type(s), "boolean")
      assert_true(s)
    end)
    it("set spell", function()
      win_options.set_win_option(0, "spell", false)
      local s = win_options.get_win_option(0, "spell")
      print(string.format("spell set win option:%s\n", vim.inspect(s)))
      assert_false(s)
    end)
  end)
end)
