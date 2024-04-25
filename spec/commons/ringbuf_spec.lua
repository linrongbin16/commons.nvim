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
      while it:has_next() do
        local actual = it:next()
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
        assert_eq(actual, 10 - i + 1)
      end
      assert_eq(rb:pop(), nil)

      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 17 do
        rb:push(i)
      end
      for i = 1, 10 do
        local actual = rb:pop()
        -- print(
        --   string.format(
        --     "|ringbuf| pop-2 i:%s, actual:%s, rb:%s\n",
        --     vim.inspect(i),
        --     vim.inspect(actual),
        --     vim.inspect(rb)
        --   )
        -- )
        assert_eq(actual, 17 - i + 1)
      end
      assert_eq(rb:pop(), nil)
    end)
    it("peek", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
      end
      for i = 1, 10 do
        local actual1 = rb:peek()
        local actual2 = rb:pop()
        -- print(
        --   string.format(
        --     "|ringbuf| peek i:%s, actual1:%s, actual2:%s, rb:%s\n",
        --     vim.inspect(i),
        --     vim.inspect(actual1),
        --     vim.inspect(actual2),
        --     vim.inspect(rb)
        --   )
        -- )
        assert_eq(actual1, actual2)
        assert_eq(actual1, 10 - i + 1)
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
      -- print(string.format("|ringbuf| iterator-1, it:%s\n", vim.inspect(it)))
      while it:has_next() do
        local actual = it:next()
        -- print(
        --   string.format(
        --     "|ringbuf| iterate:next-1, it:%s, actual:%s\n",
        --     vim.inspect(it),
        --     vim.inspect(actual)
        --   )
        -- )
        assert_eq(actual, expect)
        expect = expect + 1
      end
      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 15 do
        rb:push(i)
      end
      expect = 6
      it = rb:iterator()
      -- print(string.format("|ringbuf| iterator-2, it:%s\n", vim.inspect(it)))
      while it:has_next() do
        local actual = it:next()
        -- print(
        --   string.format(
        --     "|ringbuf| iterate:next-2, it:%s, expect:%s, actual:%s\n",
        --     vim.inspect(it),
        --     vim.inspect(expect),
        --     vim.inspect(actual)
        --   )
        -- )
        if expect <= 5 then
          assert_eq(actual, expect + 10)
        else
          assert_eq(actual, expect)
        end
        expect = expect + 1
      end
      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 20 do
        rb:push(i)
      end
      expect = 1
      it = rb:iterator()
      while it:has_next() do
        local actual = it:next()
        assert_eq(actual, expect + 10)
        expect = expect + 1
      end
      assert_eq(expect, 10)
    end)
    it("riterate", function()
      local rb = ringbuf.RingBuffer:new(10)
      for i = 1, 10 do
        rb:push(i)
        assert_eq(rb:peek(), i)
      end
      local expect = 10
      local it = rb:riterator()
      -- print(string.format("|ringbuf| riterator-1, it:%s\n", vim.inspect(it)))
      while it:has_next() do
        local actual = it:next()
        -- print(
        --   string.format(
        --     "|ringbuf| riterator:next-1, it:%s, actual:%s\n",
        --     vim.inspect(it),
        --     vim.inspect(actual)
        --   )
        -- )
        assert_eq(actual, expect)
        expect = expect - 1
      end

      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 17 do
        rb:push(i)
        assert_eq(rb:peek(), i)
      end
      expect = 17
      it = rb:riterator()
      -- print(string.format("|ringbuf| riterator-2, it:%s\n", vim.inspect(it)))
      while it:has_next() do
        local actual = it:next()
        -- print(
        --   string.format(
        --     "|ringbuf| riterator:next-2, it:%s, actual:%s\n",
        --     vim.inspect(it),
        --     vim.inspect(actual)
        --   )
        -- )
        assert_eq(actual, expect)
        expect = expect - 1
      end

      rb = ringbuf.RingBuffer:new(10)
      for i = 1, 30 do
        rb:push(i)
        assert_eq(rb:peek(), i)
      end
      expect = 30
      it = rb:riterator()
      -- print(string.format("|ringbuf| riterator-3, it:%s\n", vim.inspect(it)))
      while it:has_next() do
        local actual = it:next()
        -- print(
        --   string.format(
        --     "|ringbuf| riterator:next-3, it:%s, actual:%s\n",
        --     vim.inspect(it),
        --     vim.inspect(actual)
        --   )
        -- )
        assert_eq(actual, expect)
        expect = expect - 1
      end
    end)
  end)
end)
