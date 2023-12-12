local cwd = vim.fn.getcwd()

describe("lib.nvim", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local ringbuf = require("commons.ringbuf")

  describe("[RingBuffer]", function()
    it("new", function()
      local rb = ringbuf.RingBuffer:new(10)
      assert_eq(type(rb), "table")
      assert_eq(#rb.queue, 0)
    end)
    it("push", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      local expect = 1
      local it = rb:iterator()
      while true do
        local actual = it:next()
        if not actual then
          break
        end
        assert_eq(actual, expect)
        expect = expect + 1
      end
    end)
    it("pop", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      for i = 1, 10 do
        local actual = rb:pop()
        assert_eq(actual, i)
      end
      assert_eq(rb:pop(), nil)
    end)
    it("peak", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      for i = 1, 10 do
        local actual1 = rb:peek()
        local actual2 = rb:pop()
        assert_eq(actual1, actual2)
        assert_eq(actual1, i)
      end
      assert_eq(rb:peek(), nil)
      assert_eq(rb:pop(), nil)
    end)
    it("clear", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      rb:clear()
      assert_eq(rb:pop(), nil)
    end)
    it("iterate", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      local expect = 1
      local it = rb:iterator()
      while true do
        local actual = it:next()
        if actual then
          assert_eq(actual, expect)
        else
          break
        end
        expect = expect + 1
      end
      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 15 do
        rb:push(i)
      end
      expect = 1
      it = rb:iterator()
      while true do
        local actual = it:next()
        if actual then
          if expect <= 5 then
            assert_eq(actual, expect + 10)
          else
            assert_eq(actual, expect)
          end
        else
          break
        end
        expect = expect + 1
      end
      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 20 do
        rb:push(i)
      end
      expect = 1
      it = rb:iterator()
      while true do
        local actual = it:next()
        if actual then
          assert_eq(actual, expect + 10)
        else
          break
        end
        expect = expect + 1
      end
      assert_eq(expect, 10)
    end)
    it("get latest", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 50 do
        rb:push(i)
        assert_eq(rb:get(), i)
      end
      local p = rb:begin()
      print(string.format("|utils_spec| begin, p:%s\n", vim.inspect(p)))
      while p do
        local actual = rb:get(p)
        print(
          string.format(
            "|utils_spec| get, p:%s, actual:%s\n",
            vim.inspect(p),
            vim.inspect(actual)
          )
        )
        assert_eq(actual, p + 40)
        p = rb:next(p)
        print(string.format("|utils_spec| next, p:%s\n", vim.inspect(p)))
      end
      p = rb:rbegin()
      print(
        string.format(
          "|utils_spec| rbegin, p:%s, rb:%s\n",
          vim.inspect(p),
          vim.inspect(rb)
        )
      )
      while p do
        local actual = rb:get(p)
        print(
          string.format(
            "|utils_spec| rget, p:%s, actual:%s, rb:%s\n",
            vim.inspect(p),
            vim.inspect(actual),
            vim.inspect(rb)
          )
        )
        assert_eq(actual, p + 40)
        p = rb:rnext(p)
        print(
          string.format(
            "|utils_spec| rnext, p:%s, rb:%s\n",
            vim.inspect(p),
            vim.inspect(rb)
          )
        )
      end
    end)
  end)
end)
