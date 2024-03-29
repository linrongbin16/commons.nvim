local cwd = vim.fn.getcwd()

describe("commons.json", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local json = require("commons.json")
  describe("[encode/decode]", function()
    it("encode1", function()
      local a = json.encode({ "a", "b", 1 })
      local b = json.decode(a)
      local c = json.decode('["a", "b", 1]')
      print(string.format("encode1: %s\n", vim.inspect(a)))
      print(string.format("encode2: %s\n", vim.inspect(b)))
      print(string.format("encode3: %s\n", vim.inspect(c)))
      assert_true(vim.deep_equal(b, c))
      assert_eq(json.encode(nil), nil)
    end)
    it("encode2", function()
      local a = json.encode({ a = "a", b = { 1, 2, "3" }, c = "c" })
      local b = json.decode(a)
      local c = json.decode('{"a":"a", "b":[1,2,"3"], "c":"c"}')
      print(string.format("encode1: %s\n", vim.inspect(a)))
      print(string.format("encode2: %s\n", vim.inspect(b)))
      print(string.format("encode3: %s\n", vim.inspect(c)))
      assert_true(vim.deep_equal(b, c))
    end)
    it("decode1", function()
      local a = { "a", "b", { a = "1", b = 2 } }
      local b = json.decode('["a", "b", {"a":"1","b":2}]')
      print(string.format("decode1:%s\n", vim.inspect(a)))
      print(string.format("decode2:%s\n", vim.inspect(b)))
      assert_true(vim.deep_equal(a, b))
      assert_eq(json.decode(nil), nil)
      assert_eq(json.decode(nil), nil)
    end)
    it("decode2", function()
      local a = { a = "a", b = "b", c = { d = 2, e = "5" } }
      local b = json.decode('{"a":"a", "b":"b", "c":{"d":2,"e":"5"}}')
      print(string.format("decode1:%s\n", vim.inspect(a)))
      print(string.format("decode2:%s\n", vim.inspect(b)))
      assert_true(vim.deep_equal(a, b))
    end)
  end)
end)
