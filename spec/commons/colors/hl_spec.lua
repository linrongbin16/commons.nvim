local cwd = vim.fn.getcwd()

describe("commons.colors.hl", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
    vim.api.nvim_command("colorscheme darkblue")
  end)

  local apis = require("commons.apis")
  local versions = require("commons.versions")

  describe("[get_color_with_fallback]", function()
    it("test", function()
      local hl_with_fallback = { "NotExistHl", "@comment", "Comment" }
      local actual1 = apis.get_hl_with_fallback(unpack(hl_with_fallback))
      local actual2 = apis.get_hl("Comment")
      assert_true(vim.deep_equal(actual1, actual2))
    end)
  end)
end)
