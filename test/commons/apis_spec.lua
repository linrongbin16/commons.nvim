local cwd = vim.fn.getcwd()

describe("commons.apis", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local apis = require("commons.apis")

  describe("[get_buf_option/set_buf_option]", function()
    it("get filetype", function()
      local ft = apis.get_buf_option(0, "filetype")
      print(string.format("filetype get buf option:%s\n", vim.inspect(ft)))
      assert_eq(type(ft), "string")
    end)
    it("set filetype", function()
      apis.set_buf_option(0, "filetype", "lua")
      local ft = apis.get_buf_option(0, "filetype")
      print(string.format("filetype set buf option:%s\n", vim.inspect(ft)))
      assert_eq(ft, "lua")
    end)
  end)

  describe("[get_win_option/set_win_option]", function()
    it("get spell", function()
      apis.set_win_option(0, "spell", true)
      local s = apis.get_win_option(0, "spell")
      print(string.format("spell get win option:%s\n", vim.inspect(s)))
      assert_eq(type(s), "boolean")
      assert_true(s)
    end)
    it("set spell", function()
      apis.set_win_option(0, "spell", false)
      local s = apis.get_win_option(0, "spell")
      print(string.format("spell set win option:%s\n", vim.inspect(s)))
      assert_false(s)
    end)
  end)
end)
