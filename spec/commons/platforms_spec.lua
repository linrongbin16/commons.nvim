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
  describe("[IS_XXX]", function()
    it("test", function()
      if not platforms.IS_WINDOWS then
        assert_true(platforms.IS_LINUX or platforms.IS_MAC)
      end
    end)
  end)
end)
