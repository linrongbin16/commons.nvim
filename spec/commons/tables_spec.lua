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
    it("wrap/of/data", function()
      local l1 = { 1, 2, 3 }
      local actual1 = tables.List:wrap(l1)
      local actual2 = tables.List:of(1, 2, 3)
      assert_true(vim.deep_equal(l1, actual1._data))
      assert_true(vim.deep_equal(l1, actual2:data()))
      local l2 = { "a", "b", "c" }
      local actual3 = tables.List:wrap(l2)
      local actual4 = tables.List:of("a", "b", "c")
      assert_true(vim.deep_equal(l2, actual3._data))
      assert_true(vim.deep_equal(l2, actual4:data()))
    end)
    it("length/empty/at", function()
      local l1 = tables.List:of()
      assert_true(l1:empty())
      for i = 1, 10 do
        l1:push(i)
        assert_eq(l1:length(), i)
        assert_eq(l1:at(i), i)
        assert_false(l1:empty())
      end
      for i = -10, -1, -1 do
        assert_eq(l1:at(i), -i)
      end
    end)
    it("concat/join", function()
      local l1 = tables.List:of()
      assert_true(l1:empty())
      local l2 = l1:concat(tables.List:of(1, 2, 3))
      assert_eq(l2:length(), 3)
      assert_eq(l2:join(), "1 2 3")
      assert_eq(l2:join(","), "1,2,3")
      local l3 = l2:concat(tables.List:of("a", "b", "c"))
      assert_eq(l3:length(), 6)
      assert_eq(l3:join(), "1 2 3 a b c")
      assert_eq(l3:join(","), "1,2,3,a,b,c")
    end)
    it("every/some/none", function()
      local l1 = tables.List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      assert_true(l1:every(function(v)
        return v > 0
      end))
      assert_true(l1:every(function(v)
        return v <= 10
      end))
      assert_true(l1:every(function(v, i)
        return v == i
      end))
      assert_true(l1:some(function(v, i)
        return v == 1
      end))
      assert_true(l1:some(function(v, i)
        return v == 10
      end))
      assert_true(l1:some(function(v, i)
        return v == i
      end))
    end)
    it("filter", function()
      local l1 = tables.List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      assert_true(vim.deep_equal(
        l1:filter(function(v)
          return v > 5
        end):data(),
        { 6, 7, 8, 9, 10 }
      ))
      assert_true(vim.deep_equal(
        l1:filter(function(v)
          return v <= 5
        end):data(),
        { 1, 2, 3, 4, 5 }
      ))
      assert_true(vim.deep_equal(
        l1:filter(function(v, i)
          return i % 2 == 0
        end):data(),
        { 2, 4, 6, 8, 10 }
      ))
      assert_true(vim.deep_equal(
        l1:filter(function(v, i)
          return i % 2 == 0 and v > 5
        end):data(),
        { 6, 8, 10 }
      ))
    end)
    it("find", function()
      local l1 = tables.List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual11, actual12 = l1:find(function(v, i)
        return v > 5 and i > 6
      end)
      assert_eq(actual11, 7)
      assert_eq(actual12, 7)
      local actual21, actual22 = l1:find(function(v, i)
        return v < 1 and i > 6
      end)
      assert_eq(actual21, nil)
      assert_eq(actual22, -1)
    end)
    it("findLast", function()
      local l1 = tables.List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual11, actual12 = l1:findLast(function(v, i)
        return v > 5 and i > 6
      end)
      assert_eq(actual11, 10)
      assert_eq(actual12, 10)
      local actual21, actual22 = l1:findLast(function(v, i)
        return v < 1 and i > 6
      end)
      assert_eq(actual21, nil)
      assert_eq(actual22, -1)
    end)
    it("indexOf", function()
      local l1 = tables.List:of(1, 1, 1, 1, 1, 6, 6, 6, 6, 6)
      local actual1 = l1:indexOf(6, 8)
      assert_eq(actual1, 8)
      local actual2 = l1:indexOf(6)
      assert_eq(actual2, 6)
    end)
    it("lastIndexOf", function()
      local l1 = tables.List:of(1, 1, 1, 1, 1, 6, 6, 6, 6, 6)
      local actual1 = l1:lastIndexOf(6, 3)
      assert_eq(actual1, -1)
      local actual2 = l1:lastIndexOf(6)
      assert_eq(actual2, 10)
    end)
  end)
end)
