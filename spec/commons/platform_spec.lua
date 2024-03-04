local cwd = vim.fn.getcwd()

describe("commons.platform", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local platform = require("commons.platform")
  describe("[OS_NAME]", function()
    it("test", function()
      assert_true(string.len(platform.OS_NAME) > 0)
    end)
  end)
  describe("[IS_XXX]", function()
    it("test", function()
      if vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0 then
        assert_true(platform.IS_WINDOWS)
      else
        assert_true(platform.IS_LINUX or platform.IS_MAC)
      end
    end)
  end)
end)
