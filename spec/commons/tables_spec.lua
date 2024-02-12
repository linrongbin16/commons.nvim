local cwd = vim.fn.getcwd()

describe("commons.tables", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local tables = require("commons.tables")

  describe("strings", function()
    it("tbl_empty/tbl_not_empty", function()
      assert_true(tables.tbl_empty(nil))
      assert_true(tables.tbl_empty({}))
      assert_false(tables.tbl_not_empty(nil))
      assert_false(tables.tbl_not_empty({}))
      assert_false(tables.tbl_empty({ 1, 2, 3 }))
      assert_false(tables.tbl_empty({ a = 1 }))
      assert_true(tables.tbl_not_empty({ 1, 2, 3 }))
      assert_true(tables.tbl_not_empty({ a = 1 }))
    end)
    it("tbl_get", function()
      assert_true(tables.tbl_get({ a = { b = true } }, "a", "b"))
      assert_eq(tables.tbl_get({ a = { b = true } }, "a", "b", "c"), nil)
      assert_eq(tables.tbl_get({ a = { b = true } }, "a", "c"), nil)
      assert_eq(tables.tbl_get({ a = { b = true } }, "c"), nil)
      assert_eq(tables.tbl_get({ c = { d = 1 } }, "c", "d"), 1)
      assert_eq(tables.tbl_get({ c = { d = 1, e = "e" } }, "c", "e"), "e")
      assert_eq(tables.tbl_get({ c = { 1, 2, 3 } }, "c", 2), 2)
      assert_eq(tables.tbl_get({ c = { 1, 2, 3 } }, "c", 4), nil)
      assert_eq(tables.tbl_get(nil, "c"), nil)
      assert_eq(tables.tbl_get({}, "c"), nil)
    end)
    it("tbl_contains", function()
      assert_true(tables.tbl_contains({ a = 1, b = 2, c = 3, d = 4 }, 1))
      assert_true(
        tables.tbl_contains({ a = 1, b = { 1, 2 }, c = 3, d = 4 }, { 1, 2 }, vim.deep_equal)
      )
      assert_false(tables.tbl_contains({ a = 1, b = 2, c = 3, d = 4 }, "a"))
      assert_false(tables.tbl_contains({ a = 1, b = { 1, 2 }, c = 3, d = 4 }, { 1, 2 }))
    end)
    it("list", function()
      assert_true(tables.list_empty(nil))
      assert_true(tables.list_empty({}))
      assert_false(tables.list_empty({ 1, 2, 3 }))
      assert_true(tables.list_empty({ a = 1 }))
    end)
    it("list index", function()
      assert_eq(tables.list_index(-1, 10), 10)
      assert_eq(tables.list_index(-2, 10), 9)
      for i = 1, 10 do
        assert_eq(tables.list_index(i, 10), i)
        assert_eq(tables.list_index(-i, 10), 10 - i + 1)
      end
      for i = 1, 10 do
        assert_eq(tables.list_index(i, 10), i)
      end
      for i = -1, -10, -1 do
        assert_eq(tables.list_index(i, 10), 10 + i + 1)
      end
      assert_eq(tables.list_index(-1, 10), 10)
      assert_eq(tables.list_index(-10, 10), 1)
      assert_eq(tables.list_index(-3, 10), 8)
      assert_eq(tables.list_index(-5, 10), 6)
    end)
    it("list_contains", function()
      assert_true(tables.list_contains({ 1, 2, 3, 4 }, 1))
      assert_true(tables.list_contains({ 1, { 1, 2 }, 3, 4 }, { 1, 2 }, vim.deep_equal))
      assert_false(tables.list_contains({ 1, 2, 3, 4 }, "a"))
      assert_false(tables.list_contains({ 1, { 1, 2 }, 3, 4 }, { 1, 2 }))
    end)
  end)

  describe("[List]", function()
    it("wrap", function()
      local l1 = { 1, 2, 3 }
      local actual1 = tables.List:wrap(l1)
      assert_true(vim.deep_equal(l1, actual1._data))
      local l2 = { "a", "b", "c" }
      local actual2 = tables.List:wrap(l2)
      assert_true(vim.deep_equal(l2, actual2._data))
    end)
  end)
end)
