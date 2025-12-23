local cwd = vim.fn.getcwd()

describe("commons.tbl", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local str = require("commons.str")
  local tbl = require("commons.tbl")
  local List = tbl.List
  local HashMap = tbl.HashMap

  describe("strings", function()
    it("tbl_empty/tbl_not_empty", function()
      assert_true(tbl.tbl_empty(nil))
      assert_true(tbl.tbl_empty({}))
      assert_false(tbl.tbl_not_empty(nil))
      assert_false(tbl.tbl_not_empty({}))
      assert_false(tbl.tbl_empty({ 1, 2, 3 }))
      assert_false(tbl.tbl_empty({ a = 1 }))
      assert_true(tbl.tbl_not_empty({ 1, 2, 3 }))
      assert_true(tbl.tbl_not_empty({ a = 1 }))
    end)
    it("list", function()
      assert_true(tbl.list_empty(nil))
      assert_true(tbl.list_empty({}))
      assert_false(tbl.list_empty({ 1, 2, 3 }))
      assert_true(tbl.list_empty({ a = 1 }))
    end)
  end)
end)
