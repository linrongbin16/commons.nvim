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

  local xml2lua = require("commons.xml2lua")
  local xmlhandler_tree = require("commons.xmlhandler.tree")

  describe("[xml2lua]", function()
    it("parse-1", function()
    end)
  end)
end)
