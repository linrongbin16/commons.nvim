local cwd = vim.fn.getcwd()

describe("commons.uri", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false
  local assert_truthy = assert.is.truthy
  local assert_falsy = assert.is.falsy

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

  local uri = require("commons.uri")

  describe("[encode/decode]", function()
    local DECODED = {
      "linrongbin16/gitlinker.nvim.git",
      "linrongbin16/commons.nvim/blob/6441d8cac5ba5b6183d8bb17c60360960e7b4d2a/spec/test cases/this is a path contains whitespaces.txt",
    }
    local ENCODED = {
      "linrongbin16/gitlinker.nvim.git",
      "linrongbin16/commons.nvim/blob/6441d8cac5ba5b6183d8bb17c60360960e7b4d2a/spec/test%20cases/this%20is%20a%20path%20contains%20whitespaces.txt",
    }

    it("encode", function()
      for i, input in ipairs(DECODED) do
        local actual = uri.encode(input)
        local expect = ENCODED[i]
        print(
          string.format(
            "uri.encode-%s, input:%s, expect:%s, actual:%s\n",
            vim.inspect(i),
            vim.inspect(input),
            vim.inspect(expect),
            vim.inspect(actual)
          )
        )
        assert_eq(expect, actual)
      end

      assert_eq(uri.encode(nil), nil)
    end)
    it("decode", function()
      for i, input in ipairs(ENCODED) do
        local actual = uri.decode(input)
        local expect = DECODED[i]
        print(
          string.format(
            "uri.decode-%s, input:%s, expect:%s, actual:%s\n",
            vim.inspect(i),
            vim.inspect(input),
            vim.inspect(expect),
            vim.inspect(actual)
          )
        )
        assert_eq(expect, actual)
      end

      assert_eq(uri.decode(nil), nil)
    end)
  end)
end)
