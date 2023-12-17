local cwd = vim.fn.getcwd()

describe("commons.bit32ops", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local bit32ops = require("commons.bit32ops")

  describe("[get_buf_option/set_buf_option]", function()
    it("test", function() 
        assert_true(bit32ops.band ~= nil)  
          end)
  end)
end)
