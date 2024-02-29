local cwd = vim.fn.getcwd()

describe("commons.msgpack", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local msgpack = require("commons.msgpack")
  describe("[pack/unpack]", function()
    it("pack1", function()
      local a = msgpack.pack({ "a", "b", 1 })
      print(string.format("pack1 a: %s\n", vim.inspect(a)))
      local b = msgpack.unpack(a)
      print(string.format("pack1 b: %s\n", vim.inspect(b)))
      assert_eq(msgpack.pack(nil), nil)
    end)
    it("pack2", function()
      local input = { a = "a", b = { 1, 2, "3" }, c = "c" }
      local a = msgpack.pack(input)
      print(string.format("pack2 a:%s\n", vim.inspect(a)))
      local b = msgpack.unpack(a)
      print(string.format("pack2 b:%s\n", vim.inspect(b)))
      assert_true(vim.deep_equal(b, input))
    end)
    it("unpack1", function()
      local input = { "a", "b", { a = "1", b = 2 } }
      local a = msgpack.pack(input)
      print(string.format("unpack1 a:%s\n", vim.inspect(a)))
      local b = msgpack.unpack(a)
      print(string.format("unpack2 b:%s\n", vim.inspect(b)))
      assert_true(vim.deep_equal(input, b))
      assert_eq(msgpack.unpack(nil), nil)
      assert_eq(msgpack.unpack(nil), nil)
    end)
    it("unpack2", function()
      local input = { a = "a", b = "b", c = { d = 2, e = "5" } }
      local a = msgpack.pack(input)
      print(string.format("unpack2 a:%s\n", vim.inspect(a)))
      local b = msgpack.unpack(a)
      print(string.format("unpack2 b:%s\n", vim.inspect(b)))
      assert_true(vim.deep_equal(input, b))
    end)
  end)
end)
