local cwd = vim.fn.getcwd()

describe("commons.numbers", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

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
    it("mod", function()
      assert_eq(numbers.mod(2, 7), 2)
      assert_eq(numbers.mod(10, 7), 3)
      assert_eq(numbers.mod(10, 1), 0)
      assert_eq(numbers.mod(7, 6), 1)
    end)
    it("max", function()
      assert_eq(numbers.max(string.len, "a", "bc", "def"), "def")
      local ok, err = pcall(numbers.max, "a", "bc", "def")
      assert_false(ok)
    end)
    it("min", function()
      assert_eq(numbers.min(string.len, "a", "bc", "def"), "a")
      local ok, err = pcall(numbers.min, "a", "bc", "def")
      assert_false(ok)
    end)
    it("random", function()
      for i = 1, 50 do
        local actual1 = numbers.random()
        print(
          string.format(
            "random-1(%s):%s\n",
            vim.inspect(type(actual1)),
            vim.inspect(actual1)
          )
        )
        assert_true(actual1 >= 0 and actual1 < 1)
      end
      for i = 1, 50 do
        local actual2 = numbers.random(10)
        print(
          string.format(
            "random-2(%s):%s\n",
            vim.inspect(type(actual2)),
            vim.inspect(actual2)
          )
        )
        assert_true(actual2 >= 1 and actual2 <= 10)
      end
      for i = 1, 50 do
        local actual3 = numbers.random(10, 100)
        print(
          string.format(
            "random-3(%s):%s\n",
            vim.inspect(type(actual3)),
            vim.inspect(actual3)
          )
        )
        assert_true(actual3 >= 10 and actual3 <= 100)
      end
    end)
    it("shuffle", function()
      local input = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 }
      local last_actual = vim.deepcopy(input)
      for i = 1, 50 do
        local actual = numbers.shuffle(input)
        assert_false(vim.deep_equal(input, actual))
        assert_false(vim.deep_equal(last_actual, actual))
        last_actual = vim.deepcopy(actual)
      end
    end)
  end)
end)
