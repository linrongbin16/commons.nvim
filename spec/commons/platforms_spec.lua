local cwd = vim.fn.getcwd()

describe("commons.platforms", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local platforms = require("commons.platforms")
  describe("[OS_NAME]", function()
    it("test", function()
      assert_true(string.len(platforms.OS_NAME) > 0)
    end)
  end)
  describe("[IS_XXX]", function()
    it("test", function()
      if vim.fn.has("win32") > 0 or vim.fn.has("win64") > 0 then
        assert_true(platforms.IS_WINDOWS)
      else
        assert_true(platforms.IS_LINUX or platforms.IS_MAC)
      end
    end)
  end)
end)
