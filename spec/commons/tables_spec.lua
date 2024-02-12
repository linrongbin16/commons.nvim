local cwd = vim.fn.getcwd()

describe("commons.tables", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local tables = require("commons.tables")
  local List = tables.List
  local HashMap = tables.HashMap

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
    it("is_list", function()
      local l1 = { 1, 2, 3 }
      local l2 = List:wrap(l1)
      assert_false(tables.is_list(l1))
      assert_true(tables.is_list(l2))
    end)
    it("wrap/of/data", function()
      local l1 = { 1, 2, 3 }
      local actual1 = List:wrap(l1)
      local actual2 = List:of(1, 2, 3)
      assert_true(vim.deep_equal(l1, actual1._data))
      assert_true(vim.deep_equal(l1, actual2:data()))
      local l2 = { "a", "b", "c" }
      local actual3 = List:wrap(l2)
      local actual4 = List:of("a", "b", "c")
      assert_true(vim.deep_equal(l2, actual3._data))
      assert_true(vim.deep_equal(l2, actual4:data()))
    end)
    it("length/empty/at/first/last", function()
      local l1 = List:of()
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
      assert_eq(l1:first(), 1)
      assert_eq(l1:last(), 10)
      local l2 = List:of()
      assert_eq(l2:first(), nil)
      assert_eq(l2:last(), nil)
    end)
    it("concat/join", function()
      local l1 = List:of()
      assert_true(l1:empty())
      local l2 = l1:concat(List:of(1, 2, 3))
      assert_eq(l2:length(), 3)
      assert_eq(l2:join(), "1 2 3")
      assert_eq(l2:join(","), "1,2,3")
      local l3 = l2:concat(List:of("a", "b", "c"))
      assert_eq(l3:length(), 6)
      assert_eq(l3:join(), "1 2 3 a b c")
      assert_eq(l3:join(","), "1,2,3,a,b,c")
    end)
    it("every/some/none", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
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
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
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
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
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
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
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
      local l1 = List:of(1, 1, 1, 1, 1, 6, 6, 6, 6, 6)
      local actual1 = l1:indexOf(6, 8)
      assert_eq(actual1, 8)
      local actual2 = l1:indexOf(6)
      assert_eq(actual2, 6)
      local l2 = List:of({ 1, 2 }, { "a", "b" }, { List, HashMap })
      local actual3 = l2:indexOf({ 1, 2 }, 1, vim.deep_equal)
      local actual4 = l2:indexOf({ "a", "b" }, 3, vim.deep_equal)
      assert_eq(actual3, 1)
      assert_eq(actual4, -1)
    end)
    it("lastIndexOf", function()
      local l1 = List:of(1, 1, 1, 1, 1, 6, 6, 6, 6, 6)
      local actual1 = l1:lastIndexOf(6, 3)
      assert_eq(actual1, -1)
      local actual2 = l1:lastIndexOf(6)
      assert_eq(actual2, 10)
      local l2 = List:of({ 1, 2 }, { "a", "b" }, { List, HashMap })
      local actual3 = l2:indexOf({ List, HashMap }, 1, vim.deep_equal)
      local actual4 = l2:indexOf({ "a", "b" }, 1, vim.deep_equal)
      assert_eq(actual3, 3)
      assert_eq(actual4, 2)
    end)
    it("forEach", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual1 = 0
      l1:forEach(function(v)
        actual1 = actual1 + v
      end)
      assert_eq(actual1, 55)
      local actual2 = 0
      l1:forEach(function(v, i)
        actual2 = actual2 + v + i
      end)
      assert_eq(actual2, 110)
    end)
    it("includes", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual1 = l1:includes(1)
      local actual2 = l1:includes(10)
      local actual3 = l1:includes(-1)
      local actual4 = l1:includes(11)
      assert_true(actual1)
      assert_true(actual2)
      assert_false(actual3)
      assert_false(actual4)
      local l2 = List:of({ 1, 2 }, { "a", "b" }, { List, HashMap })
      local actual5 = l2:includes({ 1, 2 }, 1, vim.deep_equal)
      local actual6 = l2:includes({ "a", "b" })
      local actual7 = l2:includes({ "a", "b" }, 3, vim.deep_equal)
      assert_true(actual5)
      assert_false(actual6)
      assert_false(actual7)
    end)
    it("map", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual1 = l1:map(function(v)
        return v * 2
      end)
        :map(function(v)
          return v + 1
        end)
        :reduce(function(accumulator, v)
          return accumulator + v
        end, 0)
      assert_eq(actual1, 120)
      local actual2 = l1:map(function(v, i)
        return tostring(i)
      end)
        :map(function(v, i)
          return string.len(v)
        end)
        :reduce(function(accumulator, v, i)
          return accumulator + v + i
        end, 0)
      assert_eq(actual2, 66)
    end)
    it("reduce", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local actual1 = l1:reduce(function(accumulator, v)
        return accumulator + v
      end)
      assert_eq(actual1, 55)
      local actual2 = l1:reduce(function(accumulator, v, i)
        return accumulator + i + v
      end)
      assert_eq(actual2, 109)
    end)
    it("reduceRight", function()
      local l1 = List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      local count = 0
      local actual1 = l1:reduceRight(function(accumulator, v, i)
        count = count + 1
        return count <= 5 and accumulator + v or accumulator
      end)
      assert_eq(actual1, 45)
      count = 0
      local actual2 = l1:reduceRight(function(accumulator, v, i)
        count = count + 1
        return count <= 5 and accumulator + i or accumulator
      end, 0)
      assert_eq(actual2, 40)
    end)
    it("reverse", function()
      assert_true(
        vim.deep_equal(
          { 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 },
          List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10):reverse():data()
        )
      )
      assert_true(
        vim.deep_equal(
          { "a", "b", "c", "d", "e" },
          List:of("e", "d", "c", "b", "a"):reverse():data()
        )
      )
    end)
    it("slice", function()
      assert_true(
        vim.deep_equal(
          { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
          List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10):slice():data()
        )
      )
      assert_true(
        vim.deep_equal(
          { 5, 6, 7, 8, 9, 10 },
          List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10):slice(5):data()
        )
      )
      assert_true(
        vim.deep_equal({ "a", "b", "c" }, List:of("a", "b", "c", "d", "e"):slice(1, 3):data())
      )
      assert_true(vim.deep_equal({}, List:of("e", "d", "c", "b", "a"):slice(9):data()))
      assert_true(
        vim.deep_equal({ "c", "b", "a" }, List:of("e", "d", "c", "b", "a"):slice(3, 10):data())
      )
    end)
    it("sort", function()
      assert_true(
        vim.deep_equal(
          { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
          List:of(1, 3, 5, 7, 9, 2, 4, 6, 8, 10):sort():data()
        )
      )
      assert_true(
        vim.deep_equal(
          { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
          List:of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10):sort():data()
        )
      )
      assert_true(vim.deep_equal(
        { "e", "d", "c", "b", "a" },
        List:of("a", "b", "c", "d", "e")
          :sort(function(a, b)
            return b < a
          end)
          :data()
      ))
    end)
  end)
  describe("[HashMap]", function()
    it("wrap/of/data", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local t2 = { d = 4, e = 5, f = 6 }
      assert_true(vim.deep_equal(HashMap:wrap(t1), HashMap:of({ "a", 1 }, { "b", 2 }, { "c", 3 })))
      assert_true(
        vim.deep_equal(
          HashMap:wrap(t2):data(),
          HashMap:of({ "d", 4 }, { "e", 5 }, { "f", 6 }):data()
        )
      )
    end)
    it("size/empty/set/unset/get", function()
      assert_true(HashMap:of():empty())
      assert_eq(HashMap:of():size(), 0)
      local t1 = { a = 1, b = 2, c = 3 }
      local t2 = { d = 4, e = 5, f = 6 }
      local hm1 = HashMap:wrap(t1)
      local hm2 = HashMap:wrap(t2)
      assert_eq(hm1:size(), 3)
      assert_eq(hm2:size(), 3)
      hm1:set("d", 4)
      hm2:set("x", 100)
      hm2:set("y", 100)
      hm2:set("z", 100)
      assert_eq(hm1:size(), 4)
      assert_eq(hm2:size(), 6)
      hm1:unset("z")
      assert_eq(hm1:size(), 4)
      hm2:unset("z")
      assert_eq(hm2:size(), 5)
      hm2:set("asdf", { qwer = { zxcv = "jkhl" } })
      assert_eq(hm2:size(), 6)
      assert_eq(hm2:get("d"), 4)
      assert_eq(hm2:get("e"), 5)
      assert_eq(hm2:get("z"), nil)
      assert_eq(hm2:get("x"), 100)
      assert_eq(hm2:get("asdf", "qwer", "zxcv"), "jkhl")
    end)
    it("hasKey/hasValue", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local t2 = { d = 4, e = 5, f = 6 }
      local hm1 = HashMap:wrap(t1)
      local hm2 = HashMap:wrap(t2)
      for k, v in pairs(t1) do
        assert_true(hm1:hasKey(k))
        assert_true(hm1:hasValue(v))
      end
      for k, v in pairs(t2) do
        assert_true(hm2:hasKey(k))
        assert_true(hm2:hasValue(v))
      end
    end)
    it("merge", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local t2 = { c = -1, d = 4, e = 5, f = 6 }
      local actual = HashMap:wrap(t1):merge(HashMap:wrap(t2))
      assert_eq(actual:get("a"), 1)
      assert_eq(actual:get("b"), 2)
      assert_eq(actual:get("c"), -1)
      assert_eq(actual:get("d"), 4)
      assert_eq(actual:get("e"), 5)
      assert_eq(actual:get("f"), 6)
      assert_eq(actual:get("g"), nil)
    end)
    it("every", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local m1 = HashMap:wrap(t1)
      assert_true(m1:every(function(k, v)
        return v > 0
      end))
      assert_false(m1:every(function(k, v)
        return k < "c"
      end))
    end)
    it("some", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local m1 = HashMap:wrap(t1)
      assert_true(m1:some(function(k, v)
        return v > 2
      end))
      assert_false(m1:some(function(k, v)
        return k < "a"
      end))
    end)
    it("none", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local m1 = HashMap:wrap(t1)
      assert_true(m1:none(function(k, v)
        return v > 5
      end))
      assert_false(m1:none(function(k, v)
        return k > "a"
      end))
    end)
    it("filter", function()
      local t1 = { a = 1, b = 2, c = 3 }
      local m1 = HashMap:wrap(t1)
      local m2 = m1:filter(function(k, v)
        return v > 2
      end)
      local m3 = m1:filter(function(k, v)
        return k > "a"
      end)
      assert_true(vim.deep_equal({ c = 3 }, m2:data()))
      assert_true(vim.deep_equal({ b = 2, c = 3 }, m3:data()))
    end)
  end)
end)
