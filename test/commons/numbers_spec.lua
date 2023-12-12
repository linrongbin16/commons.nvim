local cwd = vim.fn.getcwd()

describe("commons.numbers", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local numbers = require("commons.numbers")

  describe("[test]", function()
    it("INT32_MIN/INT32_MAX", function()
      assert_eq(numbers.INT32_MAX, 2 ^ 31 - 1)
      assert_eq(numbers.INT32_MIN, -(2 ^ 31))
    end)
    it("eq/ne", function()
      assert_true(numbers.eq(1, 1))
      assert_false(numbers.eq(nil, 1))
      assert_false(numbers.eq("a", 1))
      assert_false(numbers.ne(1, 1))
      assert_true(numbers.ne(nil, 1))
      assert_true(numbers.ne("a", 1))
    end)
    it("lt/le", function()
      assert_true(numbers.lt(1, 2))
      assert_false(numbers.lt(nil, 1))
      assert_false(numbers.lt("a", 1))
      assert_true(numbers.le(1, 1))
      assert_false(numbers.le(nil, 1))
      assert_false(numbers.le("a", 1))
    end)
    it("gt/ge", function()
      assert_true(numbers.gt(2, 1))
      assert_false(numbers.gt(1, nil))
      assert_false(numbers.gt("a", 1))
      assert_true(numbers.ge(1, 1))
      assert_false(numbers.ge(1, nil))
      assert_false(numbers.ge("a", 1))
    end)
    it("bound", function()
      assert_eq(numbers.bound(5, 1, 3), 3)
      assert_eq(numbers.bound(2, 1, 13), 2)
      assert_eq(numbers.bound(77), 77)
      assert_eq(numbers.bound(77, nil, 29), 29)
    end)
    it("bound left", function()
      assert_eq(numbers.bound(1, 1, 2), 1)
      assert_eq(numbers.bound(1, 2, 3), 2)
      assert_eq(numbers.bound(1, 3, 4), 3)
      assert_eq(numbers.bound(2, 3, 4), 3)
      assert_eq(numbers.bound(3, 3, 4), 3)
      assert_eq(numbers.bound(4, 3, 4), 4)
      assert_eq(numbers.bound(-10, nil), -10)
    end)
    it("bound right", function()
      assert_eq(numbers.bound(1, 1, 5), 1)
      assert_eq(numbers.bound(3, 2, 6), 3)
      assert_eq(numbers.bound(5, 3, 7), 5)
      assert_eq(numbers.bound(9, 3, 8), 8)
      assert_eq(numbers.bound(10, 3, 9), 9)
      assert_eq(numbers.bound(15, 3, 10), 10)
      assert_eq(numbers.bound(15, 3), 15)
    end)
    it("auto_incremental_id", function()
      local id1 = numbers.auto_incremental_id()
      assert_true(id1 >= 1)
      local id2 = numbers.auto_incremental_id()
      assert_eq(id2, id1 + 1)
      local id3 = numbers.auto_incremental_id()
      assert_eq(id3, id2 + 1)
      assert_true(
        numbers.auto_incremental_id() == numbers.auto_incremental_id() - 1
      )
    end)
  end)
end)
