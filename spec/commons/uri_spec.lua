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

  local PATH = {
    "https://github.com/linrongbin16/gitlinker.nvim",
    "~/github/linrongbin16/commons.nvim/spec/test cases/this is a path contains whitespaces.txt",
  }
  local URI = {
    "https%3A%2F%2Fgithub.com%2Flinrongbin16%2Fgitlinker.nvim",
    "~%2Fgithub%2Flinrongbin16%2Fcommons.nvim%2Fspec%2Ftest+cases%2Fthis+is+a+path+contains+whitespaces.txt",
  }

  describe("[uri]", function()
    it("encode", function()
      for i, p in ipairs(PATH) do
        local actual = uri.encode(p)
        local expect = URI[i]
        print(
          string.format(
            "uri.encode-%s, actual:%s, expect:%s\n",
            vim.inspect(i),
            vim.inspect(actual),
            vim.inspect(expect)
          )
        )
        assert_eq(actual, expect)
      end
    end)
    it("decode", function()
      for i, u in ipairs(URI) do
        local actual = uri.decode(u)
        local expect = PATH[i]
        print(
          string.format(
            "uri.decode-%s, actual:%s, expect:%s\n",
            vim.inspect(i),
            vim.inspect(actual),
            vim.inspect(expect)
          )
        )
        assert_eq(actual, expect)
      end
    end)
  end)
end)
