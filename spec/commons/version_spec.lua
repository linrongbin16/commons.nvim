local cwd = vim.fn.getcwd()

describe("commons.version", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local version = require("commons.version")
  describe("[version]", function()
    it("lt", function()
      for i = 1, 11 do
        assert_eq(version.lt({ 0, 9 }), not version.HAS_VIM_VERSION_LT)
        assert_eq(version.ge({ 0, 9 }), version.HAS_VIM_VERSION_GT)
      end
    end)
    it("to_list", function()
      assert_true(vim.deep_equal(version.to_list("0.6"), { 0, 6 }))
      assert_true(vim.deep_equal(version.to_list("0.7.1"), { 0, 7, 1 }))
    end)
    it("to_string", function()
      assert_true(vim.deep_equal(version.to_string({ 0, 6 }), "0.6"))
      assert_true(vim.deep_equal(version.to_string({ 0, 8, 2 }), "0.8.2"))
    end)
  end)
end)
