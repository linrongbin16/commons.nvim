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

  local buffers = require("commons.buffers")

  describe("[get_buf_option/set_buf_option]", function()
    it("get filetype", function()
      local ft = buffers.get_buf_option(0, "filetype")
      print(string.format("filetype get buf option:%s\n", vim.inspect(ft)))
      assert_eq(type(ft), "string")
    end)
    it("set filetype", function()
      buffers.set_buf_option(0, "filetype", "lua")
      local ft = buffers.get_buf_option(0, "filetype")
      print(string.format("filetype set buf option:%s\n", vim.inspect(ft)))
      assert_eq(ft, "lua")
    end)
  end)
end)
